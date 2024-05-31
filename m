Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3ECC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FCE887B2;
	Fri, 31 May 2024 16:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlvS2r9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5213887B2; Fri, 31 May 2024 16:20:08 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2918872E
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c034676e02so1553736a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165205; x=1717770005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6O6iIR/dXqcs3gw1zCTsugJoRIdsjmblsaBLOu1MJo=;
 b=UlvS2r9aGAyS/CSmOL7fC2EBe/8CJ7op0+DuC5cjz6xTWSI7T8MdNpB8apDbD6phkS
 bd7vcpiaKm2umIrKgFP77MiIufMFkbtaRs6pP3tZmrbupXZ660wwKTKRpaTq7r6F6Yjw
 4/tMXU7aSMqWjGlS7JFXG4PKVXh8q6xP0Ysru01wCdzMQHuFaOdCj3Fj167rbbqxj2bW
 U5hSsBAZIQlq5sk88Egz4NlbNgFpSwQ491VRgq2vapyUcbw+v92YjVY9E2tWsCEHrM57
 vU7czvdG1RE4itxfCp5XlxOwjTqUxG14WXcEGGlTw9hWV29RA5SgAfN9i2s2JlVw1vyd
 sbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165205; x=1717770005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6O6iIR/dXqcs3gw1zCTsugJoRIdsjmblsaBLOu1MJo=;
 b=l2gyPEpee87i06LAJ5smY7fw8CPuwiarNOJUTHiRRNcDTFAtcH3gMHtrd0i+CTf+6k
 5BqcBzfX+x6wdbFF4xzk7SvgXQRpQwxLy2EXis/dhPxNz4kpvsL4BSVClZfYRpcyGrN7
 KRoXYKYyZ99oDSm/WB/fqGFDZhO4gHu8IR5TQ7NXEIv9Tt+OPJy+FZY6Jhvlo0x2szEA
 gg9fOvIsIKRJBldyLTa6wzq4fIH+hm0O3GtwmPmTFw8d68sdt7mjUeRCURvusQBIy1Eo
 MXLJc+tmk7wbUSBcsQcwpV4+XTxraS8TLJwE6h5WrVMJ9cbgwFoxKaCUF6NBQfK1mZwy
 XHkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQoqQWP8Zga28y55CNEytz0/UYb7Jwv4hRoJCf5JoSA8eTn+gMY3OB49EDVTJHv6VeuPCYvIsSj/ifUlPmJI1lI45MXw==
X-Gm-Message-State: AOJu0YzLpd0BrN8BHmNpx2aPKAGFM6CsaVxOA/Le9mUhbHBb+IAGZtxI
 PgKpdawK4h4xfZYdwrg3Jn/7kI4DogycNlOYZm9J56qshX2sREed
X-Google-Smtp-Source: AGHT+IFshzGHEdT0AjHE18Jxst0D9JdP01YwSqKWIlKnSTVBmW7TRqILbda0nK4CxxFU+g3+5JEsJA==
X-Received: by 2002:a17:90b:a4d:b0:2c1:a77c:6673 with SMTP id
 98e67ed59e1d1-2c1dc5c0e68mr2002280a91.38.1717165205191; 
 Fri, 31 May 2024 07:20:05 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:20:04 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 22/23] sysreset: rockchip: use fst reset for ARM64 SOC
Date: Fri, 31 May 2024 19:48:36 +0530
Message-ID: <20240531141837.13189-23-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Kever Yang <kever.yang@rock-chips.com>

Rockchip ARM64 SOC will change cpu entry, only fst reset can reset it.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/sysreset/sysreset_rockchip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index f353f9b4c7..17aa191349 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -22,7 +22,12 @@ int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
 
 	switch (type) {
 	case SYSRESET_WARM:
+#ifdef CONFIG_ARM64
+		/* Rockchip 64bit SOC need fst reset for cpu reset entry */
+		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
+#else
 		writel(0xeca8, cru_base + offset->glb_srst_snd_value);
+#endif
 		break;
 	case SYSRESET_COLD:
 		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
-- 
2.44.0

