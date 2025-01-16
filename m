Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D15EC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC4D806DD;
	Thu, 16 Jan 2025 02:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lj6dw14v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AB780214; Thu, 16 Jan 2025 02:28:14 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB4F8069D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce7f6fdd2aso2867725ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990889; x=1737595689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwMFZadoF80yz6TnGKvIty20OheMbz1YXLSJhyOIxq0=;
 b=Lj6dw14vz6mUJ/+Fi+MsCV0PBkYBIk72aH8Ip8n0cO9itSmyET4jQy6IFZ5vlKwJLU
 OuRx43kO2xJMqq4r0fBEBStDBRfVSeq+32SWNvrxKkzAipvqkNIAjcivaqzX8WHF44HL
 lnw5XqgRCpVtgxnZeqWzdL8xpjOznhViswUTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990889; x=1737595689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwMFZadoF80yz6TnGKvIty20OheMbz1YXLSJhyOIxq0=;
 b=Ki5Fz4OfH4pceh9T1+k6osZZJbN9yOJ12kQZTDjWLuERPe7ce62QxRoHqNZMmQm3ic
 wuIs6cQZ3Gd7HdGFUOuFc/tWBMRxYBe/xdBTbY2nXgluCoVgCWo0dZ7DZ26litGrtDQC
 FlHtLb0TYP6zIh8JRBouBQtkZOmUCiWyLAKiUpd1JffDA0uMPXLNiGghnwww1HfGiqlG
 oEhw8BoxvK8QKi2IfxujM+EFlkh4oYrGfwe3ZPJRTdSv94iJB09VK9Ypk4GkU0GfPlLy
 CjEo8OArBCiRj5w9x0ezokMooLsIIPx1AZzArAUwkJz3bIRJ5vFahodDBvaHkpgYLynH
 8rRw==
X-Gm-Message-State: AOJu0YwI9+fialX6bhyRdIOZsyo/uqsvCVpUdSWxHgNBprfkIEKi8pFd
 jn90X5JVLE/0vnbrfhDrmICjMidNoSfInN2QkhaEZnrYFLSrENc21kWtkTVkM2D4qq/Ubx3lT9w
 =
X-Gm-Gg: ASbGncth6lZ4RYuF1RUenBhOKPPvBza+yeX55KJV+Jc4w3xkyU1vFE5Lfwlg95lFuaW
 mTIYhGOjSR+eMetSGEq82CM4rc1vVIGfRUTQ2KI5Z0yL2IFl+OaduRpEb+EyfhCJaALyhpLRaZc
 hGCx/qqcU+AgudP9XMaoqRLcuzigy5Ng2oYZ0xSr28NvbP+J6BFMZxySN+9gzYcKY6fnrQYxWYn
 8Wo5QfRM7qxHo4jlw+B4AaF0v6UyXx/x+UlWGYAAsiLdf5y+sXrykTpW2+iKNDVFFkrk4d7D+VH
 jcMIkaJasknX95186w==
X-Google-Smtp-Source: AGHT+IEPMmbd4Oerh3EkUCDFX+Cyw1Yd/5mSdglmQ7ESMUj6pfCw2Yg81ctQffpRLovE5SdMttaYZg==
X-Received: by 2002:a05:6e02:3891:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3ce3a9669c8mr324886755ab.21.1736990889646; 
 Wed, 15 Jan 2025 17:28:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/22] vbe: Tidy up error checking with blk_read()
Date: Wed, 15 Jan 2025 18:27:13 -0700
Message-Id: <20250116012723.2820301-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

This function can read fewer blocks than requested, so update the checks
to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index ecf4ad916e0..0f5e0e4ca98 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -126,6 +126,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	ret = blk_read(blk, blknum, 1, sbuf);
 	if (ret < 0)
 		return log_msg_ret("rd", ret);
+	else if (ret != 1)
+		return log_msg_ret("rd2", -EIO);
 
 	ret = fdt_check_header(sbuf);
 	if (ret < 0)
@@ -214,6 +216,8 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 			  blknum, full_size, num_blks, base, base_buf, ret);
 		if (ret < 0)
 			return log_msg_ret("rd", ret);
+		if (ret != num_blks)
+			return log_msg_ret("rd", -EIO);
 	}
 	if (load_addrp)
 		*load_addrp = load_addr;
-- 
2.34.1

