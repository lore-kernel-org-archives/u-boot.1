Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54496C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416D78398C;
	Mon, 12 Jan 2026 14:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="ggxg5mnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4412B83CF5; Mon, 12 Jan 2026 10:10:07 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93B283B7E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so58156385e9.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768209001; x=1768813801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAOj/7u3ifJApIlQHCsaxDoYbvLX+mCcoc38ywxKfmw=;
 b=ggxg5mnwbFLrbPOUJgar/3nL481BbcFL8Fekf08jUNhwrBgR2OOz+O33feOPXL+rby
 jpmDeE6s3r316/3iw8Kldz8vE4OVtpLH2onb6LZaEBvsSojYqEZ9v0Y6RBCDF0gPK3+v
 jTQqqGjCTVNRzEj3Kb27atcpm14LQrOJWQ0Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209001; x=1768813801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sAOj/7u3ifJApIlQHCsaxDoYbvLX+mCcoc38ywxKfmw=;
 b=DtInwpfXEEzF++aO84FPyEZS1439xoYFxauG7E5OvnqVXcTaHuI1agf9THStOu5JcG
 LSUFIAa+xAicDFPyrFupMhTCmWXDGA7k91tXzPOGJOWxtuS4cJQMCduMienmbKBlsbxd
 Gy5gMv1F5sDYdkBvSIBKSA6364sDy4HpCRjLjNyq30X5tKaEg/NGAqfOUgImdyBf362S
 dQ2OQpElVoDL2BtGvucHFrbICLBV7+TUDioeXxiFzJWou+/ZRmZHhkp9z0FZpqesfESi
 zw+lMljKEJ7Ov7fwxmQvd3SsxFwj+LLDJfDrogxzz20i0k+i0k/dL/CZcu7kAtBOZL+4
 1lzg==
X-Gm-Message-State: AOJu0Yw/KMn2ld7F1Wel8gjA5jS55Mrn3qezc2awoDaE4/t4Xj3DaJNo
 OaEI4dfwBiV+XzOJxE38NDh+6mEo/hbZ3sRTWk8+Rae+L/oXa5ftsCzGPFgPNQybNPrcAqed2r/
 aN/5JwbSaBQ==
X-Gm-Gg: AY/fxX5xgFF43H3DXtKooionr6yoCnjLWApoDoxleVmOrvMEg0b98A8wOxpzWSpGqA9
 VzBrAPt5j+kgPthOK6kPDB37742Kgf1X1pLrLknSHk+1190VQdIvdsa4XBxggydLDtPG353LGbE
 udBhJ79+MpzsbWcNVQdOF/eNflFwlyi5sq6g89GTGQdCc3KxU686Z7mAKbJ9gDQxXFgRHhBr3si
 vUNgo3+pFt8UsyGcOlhCxm1EyozZ352MjIWjm093rXEE2je1lWuCh1k8IP62z8jh0K7g/vP82Qf
 O0pTu+HciJN4Qib3OvvrRgkVY8OIAiipClFFMUQ4pKntVSoLTjT8QTYyChNFBJs648RitROFyc+
 9XtEHu8lqmVX0L/4Zg4hJetTrdgDUkZyc48ukSYzAtxaMVNVsbfPUsvVSdIMWLGj3xlKSLbtqtV
 J6bQ2cjzzayfSIViPF7BpbcLMpA1PO4/t9ccM2Tl2ziWvLhLoNvi/Ju7bUuw==
X-Google-Smtp-Source: AGHT+IH5fQzQcK68m/wBBZ6VJLfanRmWT1AsfN0c/7DXxn9GfVxACAQX1q9rZ7SvfDM8H4aSdSirUw==
X-Received: by 2002:a05:600c:a47:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-47d8e56624emr143772525e9.1.1768209000849; 
 Mon, 12 Jan 2026 01:10:00 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm346390335e9.7.2026.01.12.01.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:10:00 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>, Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 1/3] cmd: mtd: add logs when bad blocks are encountered
Date: Mon, 12 Jan 2026 10:09:27 +0100
Message-ID: <57e9a612b9ff9e61975ae29a249c488f11ccae73.1768208815.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768208815.git.peter.suti@streamunlimited.com>
References: <cover.1768208815.git.peter.suti@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 cmd/mtd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f25144098b..32733e8f11f 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -559,8 +559,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Search for the first good block after the given offset */
 	off = start_off;
-	while (mtd_block_isbad(mtd, off))
+	while (mtd_block_isbad(mtd, off)) {
+		printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
 		off += mtd->erasesize;
+	}
 
 	led_activity_blink();
 
@@ -572,6 +574,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		/* Skip the block if it is bad */
 		if (mtd_is_aligned_with_block_size(mtd, off) &&
 		    mtd_block_isbad(mtd, off)) {
+			printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
 			off += mtd->erasesize;
 			continue;
 		}
-- 
2.43.0

