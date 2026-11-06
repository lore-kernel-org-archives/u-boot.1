Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82070606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h4OKCBZb;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UdHbnpcr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58F82608B2;
	Fri,  6 Nov 2026 18:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsLgLZUmMSv9; Fri,  6 Nov 2026 18:41:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6640160771
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793990519;
	b=gpnfzywYaM6RvO/HIc3GrBmXagecHpK2ZjIC0+eRW98cIiMcjWgjwGjMce9IlJ3hqUZ9
	 +Wovp2z1inMvHEeKtQ0t6jIdwU3SVMs5y1Bc+KoaADdQ+BZkkXWNi0F5Ga4OzjX65Qok2
	 3kQy9f83W/ORCCC9DU+A46jbilcYG8mf0rawJOQDY/WMnflyQiYRCE82+Wk5IEfLKRs9Y
	 a3VF2WMd7WLU/4mbyji3vNmPiGrhj6fhSn11YAuNTZZ/ohH2Ba19mSjg9bb36ZMf89/8S
	 3+zCB+kdTBq4FQy/KWq4cHVTpZz1feBAuT+uQ5jyy0SJjK5PyVwCXuIqUNbCTZLaQQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1kXU2MeioznKMVdFjuSdb8IpApZY2xhf+chwJu2o7lA=;
	b=Z71And4r//9NeJbvqjXa3UqcXon337IoFhgJwLf8tjCURoQ/WHfkqiS9DQsBsEJgUHo6
	 tAE5ZEV5qT1jdNIUZxUs/6I7Qb5rGHnROZKrTa7+fgjxAZXhjs7gz8mlVoXNUVnAk/u1v
	 rGW1vwpYUhWQrkJjYosMh3UQLOUZY1CTGqKciF2SgZgaCpvrPwPUViPOL3TepaP4o/IqO
	 BwAJxrZwJRcSYCXP6EoewA1EwiUkB5l4A7XxKQFsSPYFGMOLIkITUj2D/izGJ78eGiaIo
	 GyTkhMAT56jj4w6DXWCdcmO3hYwcjyVwCNW5P8u+EWo0xCgZc44HxZY7FmQwzZZjbcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UdHbnpcr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793990519;
	bh=1kXU2MeioznKMVdFjuSdb8IpApZY2xhf+chwJu2o7lA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h4OKCBZbui2G2ytf5Hm5zFW1DgnEUU/E44HbPmazYIbwVQZ7UEiLyDBR2UWSUl3zK
	 /Rd7XrDsuu1huhad8fjvD2jJkaVXrwbiqQvCsWLEHKSWYFup1XAtc0UZsllhUW1b9u
	 HIBrL4Io6IDxROIBiFRtj4ENwB1yaclSoqt7Eu/Ilr/pWBFRWVYP3aNNOBXv5XOfK4
	 TIxOMFRAWoZryzXw2ZICFwhm1oC9OLPM5APQ2tg5giEIk01d8b+osqiE5gPRJleHnG
	 AsL9dN0NphU6633d6YYk4SjzSILxvXQo6Oudo8NHn4L2y41tlBhg0A1TmSaI+/4B0Z
	 M/WRfFaV66VGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6640160771;
	Fri,  6 Nov 2026 18:41:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08BF732A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE2E860771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJlCKHRRqElA for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 297E260744
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UdHbnpcr
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 297E260744
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:55 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1006908f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793990513; x=1794595313;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1kXU2MeioznKMVdFjuSdb8IpApZY2xhf+chwJu2o7lA=;
 b=UdHbnpcr988uhb9x4vlW5dl0jdU34e0porxOZ97vzxFNuh1DMjrTyQy+Mqe13MvtvY
 fF81ctI/Hfed1PApCMRbKOWkdrTQJkGThCrE18GnOFa0ksRvj2hZo/jyNY3uO7ic3O13
 XwZ2VCDSJ8S3Kb9P2CtGJlDBfdG4IHaQY36jjp5nb+tXPihxih5YNxOX1qLB21PYYukL
 xnjqrsW/Gtdcoa+xEUldPDFRBi6awZ2FsIjiRwh7wYE4oU6Ul94zTLgsM1ggR5i+mQng
 yWWEUmmvI51TyzuBWBBBp4vxNRN/N7pMXPWdTXp+Mhzj3Sk+3b48GnocwS/2vW5PnKHl
 +JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793990513; x=1794595313;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1kXU2MeioznKMVdFjuSdb8IpApZY2xhf+chwJu2o7lA=;
 b=qOk1rMyUCvsoeOqgYdhfBQS8Gf2u8axjwNAvfKPJ3NGp5+MvK9lyopCYeipEYuxuyN
 F6q7DI9nfSQa9y6SUPXAc9B/VY2+g53YYvJY2RmxBbcugxqAXPDZzne/zev1CJOvaJiA
 eIqnycQ6LY1WrmChLMMFihH/5Z9fljDB148qe0MehKzeb1Bzy/tMLP228JGyXcWDj8Sd
 9xS2KYqR0BLPpqfnfBVCsPPfez+FPTMfmyQKLhanbAr1TDFXUg7OqEmp/TqebzLXsESe
 rK5yhXV7v4wHZzNPhltuoF5yv1vjrPyvECxA32oFeJUHbtCc5qZZeRBN4gAzFGUMfKtI
 OJeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEvjWn1xDCQRFk2TvnB8jzJbNQeozBUzdnIzKUdo8pnhE1LilEpV5WI8y6v5izjbp6azm6vcnc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kcnFz7rRvCx8lGdgInbSjBr9/5y5rFTeabh34KONm9H1JS1tz
 CBlZz/qKUa/QqebZz7/wawMC50mp7OVUE2NvE7uQDPTsiRioO7n1NLMhXAhf2y4ODS4=
X-Gm-Gg: AYBFou3lih+KZI8pfQsy65/s9BhsqM+1UJTyCHmf5lYCG0Z3wq7YXlH7NFoURXX0x5H
 AjKL5gJSCGZpkrqUUV5FfOZszFfgMO/CPy23M0T2hLvMj4ULymbleFe9r7HqsPNAgpeA/LLV/U3
 3L8LT9/srQ0G5KcILVjl1MoE8jBwHhBCJ/lIwFcHYgjYWKOkCsqidO17awDCGja3sIM7kgY4Mcq
 D7Fpxa0w7QvhC/3QIS/WwADLzsA0Mxn1bkRYBGTTRi/8zg03lYxjx9Ihh5I+OmzVHwS29enmuPY
 siy6bsLy54YvXDszu/3Nl35Qq88Ip9x63ksQTV+xqL0+zfeLjfRyqein6Bzqpll3DGlSO6bNX9J
 1qsK9ume8/vNUI5pN6SBJhnaLm4+oSGHCwOKbEGZ73eAEMWabQzdBtlt/jnYP7Uylok1XTbHgaC
 Rq6KwDt+XRkc+nha/WZ74XNIaMBKhwwWIgdflrHH2jciFVTm6b4CjmTYFgIyLJHBuMnwCW9l85Q
 ZkQaSJok12EPDuvCLKhfHeVA6sKwNCvQixBS2g6tSZLjCYt+5uXAjsMgr/igdk5vmO0eKmRLAhV
 PX4xqHt0DlRSMA15mkiReEGdC1fc/atid2+55g==
X-Received: by 2002:a05:6000:430b:b0:491:4b13:f8bd with SMTP id
 ffacd0b85a97d-49275373a0emr8167896f8f.19.1793990513451; 
 Fri, 06 Nov 2026 10:41:53 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d72335eesm4886939f8f.24.2026.11.06.10.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:41:53 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Fri, 06 Nov 2026 18:41:45 +0000
Subject: [PATCH] imx93_frdm: prefer fastboot over regular boot in recovery mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-imx93-frdm-usb-boot-fastboot-v1-1-c0bdfbff3c63@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQrDIAwA0F8JOTegDmT6K6UHq3HLobWYdhRK/
 32w3d7pXajchRUjXNj5IyptxQh2AMzvtL6YpGAEdMZ5a40nWc7woNrLQofONLe2U026/+GDcTm
 kkusTB8Ctc5Xz14/TfX8BRByh5G4AAAA=
X-Change-ID: 20261106-imx93-frdm-usb-boot-fastboot-f6902c9adcf8
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Daniel Drake <ddrake@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, francesco.dolcini@toradex.com
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FRDM i.MX 93 board can be booted in a USB-serial download
mode where the bootrom pauses and expects the host to upload
a U-Boot binary which will boot directly into fastboot mode.
The host is then expected to use 'uuu' to flash storage devices.

The current implementation of this will only enter fastboot mode
after the regular boot command completes, which means that U-Boot will
prefer to boot existing OSes even when the USB-serial download mode has
been explicitly set.

Fix the USB-based fastboot launching to prepend bootcmd instead,
following the example of phyCORE-i.MX91/93. And if bootcmd has been
customised then this behaviour will be skipped.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
This replaces the series "imx: consistently enter fastboot on USB serial
download boot", because I concluded that the generic approach doesn't
really make sense:
https://lore.kernel.org/r/20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com
---
 board/nxp/imx93_frdm/imx93_frdm.c   | 7 +++++--
 board/nxp/imx93_frdm/imx93_frdm.env | 4 ----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
index e187de74a72..b6e4e97c988 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -106,8 +106,11 @@ int board_late_init(void)
 	}
 
 	if (get_boot_device() == USB_BOOT) {
-		printf("USB boot detected. Will enter fasboot mode\n");
-		env_set_ulong("dofastboot", 1);
+		const char *bootcmd = env_get("bootcmd");
+
+		printf("USB boot detected. Will enter fastboot mode\n");
+		if (bootcmd && !strcmp(bootcmd, CONFIG_BOOTCOMMAND))
+			env_set("bootcmd", "fastboot 0; " CONFIG_BOOTCOMMAND);
 	}
 
 	clear_pd_alert();
diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 96096bc51a0..b68ab18258e 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -26,12 +26,8 @@ fastboot_partition_alias_all=0:0
 fastboot_partition_alias_bootloader=0.1
 emmc_dev=0
 sd_dev=1
-dofastboot=0
 
 bsp_bootcmd=
-	if test ${dofastboot} = 1; then
-		fastboot 0;
-	fi;
 	echo Running BSP bootcmd ...;
 	mmc dev ${mmcdev};
 	run mmcargs;

---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261106-imx93-frdm-usb-boot-fastboot-f6902c9adcf8

Best regards,
-- 
Daniel Drake <ddrake@baylibre.com>

