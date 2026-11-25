Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CA606A330
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EJ9a4G5u;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p0Jq8zzi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F2CD8021E;
	Wed, 25 Nov 2026 10:28:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4UeIZKdN46t; Wed, 25 Nov 2026 10:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71EAF80C9C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795602488;
	b=LIEAwv/qzHpGuEovREJeaQ0+5GywU8Rw9wU4N6spw4r6iCWWNmUyFGlI0uQx3o+UOhMX
	 VbWSE3C80LtWhym1AKEj+QSF9xfk4MmUX2gayYfm8XWUGUjiEUzYP4H/lDmnQIs099gEe
	 Q/Rs90K0VUL0zl0TL/hbCMFxSMSJb/rq7x2FPUT4/Q8q+yab9Bnjz95HzTz5wsZ75Lopc
	 bI2foyKna0KyQUl7LhfDFph4S7enGjV41ARLlKLMrtJ9e3aBQEpAlN5ZkJ4C0WjLog2W1
	 Vumv7fJLUw9hKs4aYLBgLEOpeUE3cnnwK1nxtdoBkAPa/Xl+j17HZAcsqGMQoGj0S4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795602488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RoXgsqb5VRdKmFvIJ1qPsI8xgjgeLJzM1GVyf8XbpjQ=;
	b=Pr1HkuNk6zeo9cb+/FwUG1E4SfvU4fnEZnJF6J7aZm/fiOTs4lK2c3bqzy2iQ0Kcqihl
	 ZRoWUpc30hicLMnR5HrLpMkl/C6hFQfOO5voM9NmQp+794gkmp0xzk4MpoSKL/qfsV4mZ
	 a44y3lScDHexBuchFZ+7aps4oNit1OJxaMYO1iT34+/zIrc8V0xLPBTwh3nISV/uyVpsF
	 lc8RP44+dfMJE9j0L4dvhBvLZZOoONUa9UsbB2bxC0gM8fwQkdGiU9ii3H8BqQQjS0cmP
	 NzKkS+gyLb6k2U7uXPz3qhZiyc2CMsvt+QnZ202G0ypJGyw0xpq0xFgMoMs30wxnj7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795602488;
	bh=RoXgsqb5VRdKmFvIJ1qPsI8xgjgeLJzM1GVyf8XbpjQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EJ9a4G5ugDX+MJspBKGX9MtobsnuMW2+oGq1AH2qIS8BcXfW+0twdPNF1ZK7biKJT
	 0F2CuV7rw8h/9tiYRIIxZ5RbdqtYTooRSwPTVtC7YWuCnDfPXU0UPoueuvhxjuDM1n
	 e9pzal2UymVogZ8ls40jXE1GtaEZpruHfVSplbpGFm0ywiDc6BC/KTd3EFsV2O50uU
	 /onsBWCinkDLwDO8nvQfLRIThGux1V+9P/sVkbPNLFotbjSzyLoGN9epKCJEmFRpwI
	 hR4QGx+SWHarfSM9bB2UMc/MJVrMcQRaqqbUoQZV1rqgY0/DsCz6p2KeAREczE/p5c
	 +bmgEohMMhp+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EAF80C9C;
	Wed, 25 Nov 2026 10:28:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA39325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABCB86070F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IxFRzXomUsQC for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABC9A606D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=p0Jq8zzi
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABC9A606D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:28:04 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so49012935e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795602483; x=1796207283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RoXgsqb5VRdKmFvIJ1qPsI8xgjgeLJzM1GVyf8XbpjQ=;
 b=p0Jq8zzi+iHGl1StCkahH1EE4KR/eYrspzr6tULr2caC2dTRoagKxG7pfxrv8uu8cu
 eaR0XB1eYQ691liiEnjapNcQ0ACVEG/uG4lwg3w6QzXERuH7JVvDDiHeuOameVD4Z6+O
 z7Pplyv3U564KkGCDNUl/JeYSay7RoDOHJpDQGf0mED6IOKXIKegzLVfOh6g3KPkyE4J
 QKSrwEVsU0W0TZVe8l6Hx0T+de50rtxNwKv32lNZR4DEnkm5ozzJWZCYY6bbcYd5g/yi
 rdrX8OhKaWYy/9ghWKBx/fxPOLuNYtlNbXvDxSPJ9YQGJMGM6D2hFJIb0lwsKL/tVIva
 7LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795602483; x=1796207283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RoXgsqb5VRdKmFvIJ1qPsI8xgjgeLJzM1GVyf8XbpjQ=;
 b=yTRw9kJn/ug08C8yAO8x4E/fTruq3HOLKVZiiPcCvf89BKhKzKSln7fFo0b2UF9xWu
 qlLJu3cLZDoo+DBYJ1iHE7efdCdLPAx4z5f42USs32RhROwpNFfgjTblorgoHn5KYUQo
 ybpdxF5QPKK5MJ+4PuCGlQruwEPKAV966LGDIUvvRhucYYK8sidblsKEN2/3A74KcVQV
 QMz/0RcgJjLEPIIAKWWsLQLpu+KQCO7MXsrPMDl+IJR3ElAB/nbhR1U7b0yJ43Fcayqv
 HDv8/V8/n+P2obs3/mhMCofnpFLVCkAtB1OFICjuGFXiJFt3v0lhckcd2sEdTG1mecLF
 mOIA==
X-Forwarded-Encrypted: i=1;
 AL+hErEmUmF5DL4g7UWXyfynTR2v+/McS68zMJTgRDnbLYX4Qlf2I4Nz4kRHKIJj8UzFbfcFjkWnYBc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Hic51v7+onjR324bQsK909z1L6YTp7Gyx7bQ5pU/8L5oWCmvh
 LPd6spek6r+lVOFI+bCWFn74NsVdHI757MVKr3PgUon4iA0H0FT3RZxx
X-Gm-Gg: AZFdTZcC7wxQ8yRbj6h/syLLJxeVp6sOneAxXm0vAjIEWlUkUTjGyKpvXo48X8T/u3z
 4T3kgq9bYWwvFyrMMCMx7jS8qQEz7/8HgumEm/QTlip3rpq73XYeYYr+DEsuWqzn7GWf4+ZYRUL
 2QHtbIs7d7w7itFONH+xHnOvDI6Rzc8vuH8t2+54v7nj20VbmvYjGkbk9Wp4Ww2m6bz0PFOFZbg
 WPX84lhw4XT2w8sPY5hCj9uDHoYYgeQPzN2LLF9DxUqS0nw0keT0bot2APJWsEXxMmW3Wl2f4AB
 +ClaIyfE9TQXfehZvSmnvm6llyx1CbEdvzbBQr8v4QNSrUzuiyeF9vhDUPlCw+r3qco7hUJDxwQ
 8PAl9kz2b1Wb+fQHv3w8HFrq9jxqt/hWLrOK3f8Rho1Yft6yZYAyHB+sKrJXjP8Ye43a4fiqhdw
 madWu3UBZK8LvkhUP/EKeFsmtcNi+2J7lTJ72jY/VipzsJ5yKJ08gUqG1ZQkofnMApCndwxyvcx
 X9nQkvNbg2YIWpXDIv2jvdZ27wB6UMMS8SDatIy4Mx5Ww+WGJlHgMLYcyjKGwVtinUkJ+dZcoZy
 4NxjEYdh6qa8rnkhdbY+fJbzWnZ+kE/51xMkgWkLCMPBqTpXbxzjYTG4
X-Received: by 2002:a05:600c:6290:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4bb8882a21amr339230795e9.27.1795602482888; 
 Wed, 25 Nov 2026 02:28:02 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm576711625e9.14.2026.11.25.02.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:28:02 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH] colibri_vf: move scriptaddr and pxefile_addr_r out of the
 U-Boot region
Date: Wed, 25 Nov 2026 11:28:01 +0100
Message-ID: <20261125102801.1021544-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

On a Colibri VF50, which has 128 MiB of DDR at 0x80000000, distro boot
cannot load a boot script:

  TFTP error: trying to overwrite reserved memory...
  ** Reading file would overwrite reserved memory **

and with CMD_PXE enabled, "pxe get" fails the same way.

scriptaddr (0x87000000) and pxefile_addr_r (0x87100000) lie in the
region that LMB reserves for U-Boot. Since commit 6534d26ee9a5 ("lmb:
do away with arch_lmb_reserve()") this region starts CONFIG_STACK_SIZE
(16 MiB) below the U-Boot stack. On the VF50 the stack starts at
0x87d3be70, so everything from 0x86d3be70 up is reserved. The VF61 has
256 MiB and is not affected.

Move scriptaddr to 0x86000000 and pxefile_addr_r to 0x86100000, below
the reserved region on both modules and above ramdisk_addr_r.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Tested on a Colibri VF50 and a Colibri VF61 on the Iris carrier, U-Boot
loaded through the serial downloader, default environment: bootcmd_dhcp
and bootcmd_mmc0 run boot.scr from 0x86000000 and boot Linux; with
CMD_PXE enabled, "pxe get" loads the configuration to 0x86100000 and
"pxe boot" boots Linux. Without this patch the VF50 fails all three
with the errors above.

 include/configs/colibri_vf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/colibri_vf.h b/include/configs/colibri_vf.h
index 060e0ac3fe2..c1dc61e63c7 100644
--- a/include/configs/colibri_vf.h
+++ b/include/configs/colibri_vf.h
@@ -18,9 +18,9 @@
 	"bootm_size=0x10000000\0" \
 	"fdt_addr_r=0x82000000\0" \
 	"kernel_addr_r=0x81000000\0" \
-	"pxefile_addr_r=0x87100000\0" \
+	"pxefile_addr_r=0x86100000\0" \
 	"ramdisk_addr_r=0x82100000\0" \
-	"scriptaddr=0x87000000\0"
+	"scriptaddr=0x86000000\0"
 
 #define UBOOT_UPDATE \
 	"update_uboot=nand erase.part u-boot && " \
-- 
2.56.0

