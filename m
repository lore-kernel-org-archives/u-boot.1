Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4BEC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BB087D88;
	Wed, 31 Jan 2024 15:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTz7sqQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7A687D88; Wed, 31 Jan 2024 15:14:56 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D1787D67
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29080973530so4194319a91.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706710492; x=1707315292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CuP93CYwzP9yQnUWNs+A0plEMcmZDayNh7fHrs8JGi4=;
 b=OTz7sqQujjKlTSUNFhLzdJ+A3i/iCuyTHqGvOPqKN2g2GKtA44h4Snt+5l5aS2q4VX
 FLsPiRckTZuxRElEb9q6W6Es1ALu2u/aC7HTLzQz1pspg7BLhiJmKO770sd7+Sf//XwV
 zTkcTFEv8dEyM/R389d0pz+xKY0ltGrYInwATmZvxRkzOgX4/OawqxYqa7qMXFvAfb0/
 vtitkUyoJ+LAPpPoe8wFkqpN66NnjUyw1McUZJW0zwJAOrONUsNNX+aJ3UnT0Y0sh2wR
 zdmWzsPdNfYPMnM3qzs63/Cl0hMJvsR6f+r+Kl7O2LHU+l90zNpcfB3D5aHIwH+P5b5y
 bipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710492; x=1707315292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuP93CYwzP9yQnUWNs+A0plEMcmZDayNh7fHrs8JGi4=;
 b=kalvjHk/GuMH7evLS4SIoDJkLrdDncNysrqHumvJ3gAz4euGdhk6FMGwFx2irThk79
 yABogxRACzQwmh6Y76bpHSbeH7CvYmiMiYGH/5E9U7ywskccm/ZkCZzCkYkgUfAxI0Jw
 NyI0lOqBd9dS4mDfYNvwqNdhnb/TDC1Ux+ZRNaFGjGOsxzareuif0c9BcmJkJiiIr0l8
 rqWQUGapoyzWOYaY3K4aUrwaiQkeX5g/cvmwbNxc4W9twC/c3yMEE/TWsc+WQq4zMnH2
 MLpikgrdIJiwrN0PTHmkLCr8RIuWiUV2yG+Tdlh7t/60lykhB3vcZmbzQnaESb/L1cKF
 WoGg==
X-Gm-Message-State: AOJu0YzxODjoCTp0WOltb/nHGE+No8DeOO/hXerxmiZJHeVexusl9iKa
 oLVfiHhAr+68olXczxoYqdsLEXUKhPLa+td2PU67cwYjKnXErPSw
X-Google-Smtp-Source: AGHT+IFzLMFtnBYfrWKJtGdC47j9Z4x4nioRrRxl2Xa0mZ+4e2jNNTrjgw55lToA+Qluefwk623aHw==
X-Received: by 2002:a17:90a:cb8d:b0:295:c0dd:cb2e with SMTP id
 a13-20020a17090acb8d00b00295c0ddcb2emr1927242pju.25.1706710491722; 
 Wed, 31 Jan 2024 06:14:51 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX49srJKIiac4NH9Gd4pvohOBrQwH49WYbHH7HKz5oI413AP3Nq/TQNZuxIbe+kXr0KBCS2wxiHryqB2IT/H4/5Pf0/L4AaZ93GnF3WeyJoOVD3yq+XhD5KR/CVcxQqhT9HUXNndjzlK7gkQudTurB5amPc3gwMNx7xZm7c1ZDygMRz+qDRUSCTy3lu+EPdERMG8zoR5XwV94/7oP+Chi63GslaY5X/E7iZ1fwgv1PZQmKowAELUoMXZDmxcnjPRVkY/zQNWamOHhi47wuJLTA6KZJEVVLjEdswweRZ3lylwtsOSlRomRswO2ud5wUZyEbBPUCbcI8CaNd0YS9rJ0+kCgF+ZO3S3ripPb294rTRHuPbr/gmSxwcbQ==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 mm3-20020a17090b358300b00295bafadb4fsm1534954pjb.57.2024.01.31.06.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:51 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v3 3/3] cmd: rng: Add rng list command
Date: Wed, 31 Jan 2024 14:14:26 +0000
Message-Id: <20240131141426.34926-4-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131141426.34926-1-o451686892@gmail.com>
References: <20240131141426.34926-1-o451686892@gmail.com>
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

The 'rng list' command probes all RNG devices and list those devices
that are successfully probed. Also update the help info.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 cmd/rng.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 52f722c7af..b073a6c849 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct udevice *dev;
 	int ret = CMD_RET_SUCCESS;
 
+	if (argc == 2 && !strcmp(argv[1], "list")) {
+		int idx = 0;
+
+		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
+			idx++;
+			printf("RNG #%d - %s\n", dev->seq_, dev->name);
+		}
+
+		if (!idx) {
+			log_err("No RNG device\n");
+			return CMD_RET_FAILURE;
+		}
+
+		return CMD_RET_SUCCESS;
+	}
+
 	switch (argc) {
 	case 1:
 		devnum = 0;
@@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-U_BOOT_LONGHELP(rng,
-	"[dev [n]]\n"
-	"  - print n random bytes(max 64) read from dev\n");
-
 U_BOOT_CMD(
 	rng, 3, 0, do_rng,
 	"print bytes from the hardware random number generator",
-	rng_help_text
+	"list         - list all the probed rng devices\n"
+	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
 );
-- 
2.39.2

