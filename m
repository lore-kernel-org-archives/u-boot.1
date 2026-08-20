Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B5AC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA06E80ACC;
	Thu, 20 Aug 2026 07:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EiYlP-jluFP6; Thu, 20 Aug 2026 07:27:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210822;
	bh=Ao9PCyD1AxppQGPdSr1oWTAfgXFTcs/mcqU3Ul45TQU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rGITllzuxYaNHRYEO7kLewI2Z84LRan9Iu8V7IRYKn/NLOqo99omhIxJX8CClPRaX
	 Jc15sAnQUG4LYflTYzZ7V41Hk6R2oVz9OwrCo0/y/2Qdn86JfGsNW8rIDkoy6HQ3VD
	 rllqyH/8E2MIDj/1YFTvnDdykmc/C6YKZrSlOpkUxR/CcuZgzkwyLaszO/saf70se7
	 K5auNMWwC9ywzf20Rd18Rv+zcByrdnHXvZkCo5p9Q35N+4ho0pxeVbLd7drQqi9ip5
	 f+PV8E000pTryDquqGXZgI9Nl4sL1YrQ2twY8j6gQqWWwC84CCS+2lcY+tD4AH6E4/
	 wkZkViMZi95Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FDFB80C0D;
	Thu, 20 Aug 2026 07:27:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3173429D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 232B64025F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OxvQh_C6eyG for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:26:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Wnz1CvyW
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B958440253
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:26:58 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB4A93FC9A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787210815;
 bh=Ao9PCyD1AxppQGPdSr1oWTAfgXFTcs/mcqU3Ul45TQU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Wnz1CvyWheMU9wDa0MmJFXu/m7PyqqGOV5dF5HyO8fXBFR03rzTAo6KGSmLlf2HA1
 oCzHBCESnMNl57IggRzNHMOCPPec0tnd0N8mQbSrbCBdihIqsL9sMP8NyTdc+s9EN0
 hibiDrrbAyK9FsqEbcDFd4FW167qda+sD1FfC3ywSf17W7epkNbNGX3U9wuxay8WNl
 cXvip6YG7N4SPvBiYLPTVn7Y7K0UPd/+LvuYI9Z64/IcM9LQ//Lj/Vxl3iYj0My4nt
 wA9L9awXC4plJ3IP0q4f5OxxWAbi9HKgOVxlDGAEsHYPZR3SmJv7WnU1yzRSKm9VFE
 +YJzUGHebXnkE+UDZMcrJ/edV72UzLJaX8RJRHJvaVZvZcxwxMSiKKS+hV60snX7qn
 Xep1E/hrHc3l8MnbIVDSGJ1h+fxkWMmve0SBqw1uyHToWU+d/DqsfwBym7SZhPmdx3
 9ND2RQrRRU7/C8FVTSNacnMRUxYKR22ZgXJuyTMx03ZtiDSwFxMvh708F9i/acQHco
 nmmSyscDAb1Ss+Rofylw/0sqc2qMJS1qOwZ7zhN0nj6sDEprApw/sSYv11rpHC5hJl
 gsmXoKU9IoyxuPziQEQhUDg4cNlPjL1qzDsfAY2OERPzYk0a+F47SaKSwRYo5Eziqz
 C1wfUUoo/TahuWsu7pFfa5Ec=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4996832e7b4so4650075e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210815; x=1787815615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ao9PCyD1AxppQGPdSr1oWTAfgXFTcs/mcqU3Ul45TQU=;
 b=Kyh31p0yZZZgV2a78sq23W0ZjZG42wknfA2A0ZmnVo+r32JRCGU8gObJ2Nh/95dNS2
 SluPPv+gCnQCJtHdzdkze+alQMsB1/AIYxZhnHE85Uhr72/j8CqnR/3pSUeLXc3Z2/XW
 qOYTi22YzOEhsAiJThaX8pr2n5ECizTCAYK5dG4SuvaNmePLXurnrh8NUlptFN7kFyvo
 TbKQDpPOmsGMfICi3ENbDlT9r8pcsnliJhjOBNYQHyeYiWBKTd++W/ijgBM1AWc8ILbM
 53U7X2U0V/n85jPiYhI5OhENKsd9V5cb+gNR6wbTSrmXSs74Z8ITTOtPBFeTOjse/9b1
 ZbDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbpoVZeeA+WAmaZO6kVAgrsNLTXXKzQaLl1zB5+vaxbDdJuKvBavpueyivQBvLJQQ43ocQRPk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyC6hw7QNcECJDpC9ayj74MS9yGg8FkFx7D+tlC/g0qlj5sVb5A
 PN5Ax4lMCtuybprK42WzaQ6sFoD93LEPjFCXBIYUYECduMmDnZ+yegLM8+1ULKayDIVcRABD0VC
 koqMNoRhdmBBcfEoaPJMveocdGCzwlNrJtgLZdi7Wh5W7hMIVXdDtloVmAuuQiB0R/lWxjL+UgE
 2mmSVzfhA93Q==
X-Gm-Gg: AR+sD13B/YqJIRWjQAoKLPoq5u7aFVYalrzLEXfd1LLtEBFgmHFwARayIWJM/3a7xg7
 hgtlT4n+aHSZr7K2Kv0+zjdHH1NmxWj3f3mtt9DcXy2wc9btTpjl0gLqcPeEid1Amvky2wDiOLR
 4l2cI7l1e23jSDbBj9n5tghpMytyK6dnlBF9O+1k040vIxGDzCQ1+XRWEDlyTU5nWBelT/W4czz
 WwTnbALkHIpUdlX4lGKP7Wo3ijsniYnpA32cHufMq/J3osnIrEg8Q4IKb8IzaBDJpfOxV12O6gI
 CLuIDsKc95klETVtr6D1nySI5hvzhSBoAS4IwMIJX9ZHYEFeLDCkBz6A6B2SoBHMsSRSq3xLU+E
 wImmJS0SlC6QfTKfQGBvAvGQ3tHGDq5H66qYeUVOBGdaMajLoj7urjhc=
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr69636035e9.7.1787210815455; 
 Thu, 20 Aug 2026 00:26:55 -0700 (PDT)
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr69635525e9.7.1787210815096; 
 Thu, 20 Aug 2026 00:26:55 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:cba:879e:28f0:3c57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2ae6c3fsm17014665e9.1.2026.08.20.00.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:26:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: build mkeficapsule for
 CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y
Date: Thu, 20 Aug 2026 09:26:45 +0200
Message-ID: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Currently we build mkeficapsule by default even if we don't have EFI
capsule support enabled. This adds a host GnuTLS build dependency.

Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y.

tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=y.
Hence distro packages like Debian's u-boot-tools will still contain
mkeficapsule.

Reported-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index ef33295b8ec..e151b30217e 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -108,7 +108,7 @@ config TOOLS_SHA512
 
 config TOOLS_MKEFICAPSULE
 	bool "Build efimkcapsule command"
-	default y if EFI_LOADER
+	default y if EFI_HAVE_CAPSULE_SUPPORT
 	help
 	  This command allows users to create a UEFI capsule file and,
 	  optionally sign that file. If you want to enable UEFI capsule
-- 
2.53.0

