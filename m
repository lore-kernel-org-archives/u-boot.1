Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDF2C27C55
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD0D88307;
	Wed,  5 Jun 2024 05:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UjCLIHHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C75881D6; Wed,  5 Jun 2024 05:26:41 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4107988260
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7eb0b9fa610so177899639f.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717557997; x=1718162797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1H/pWJFkMuDuA9paJQKhfUlwQ682N0myl4Ho4pDDd6g=;
 b=UjCLIHHsS+ZPYVeVX757+S7q9avP6eq8E+lGP9ZpN+x7o851ZGpKVXR80L5LJI2ePR
 SyZcgi9u4qoFpek9fMcWDQitY/vINiFD/nbuqsEUTMcKf2+fH2luDyDDOl367P5Use9v
 n/0/qNEC5qWixbbRBo+4BDdUBwJbSkY4v2yhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717557997; x=1718162797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1H/pWJFkMuDuA9paJQKhfUlwQ682N0myl4Ho4pDDd6g=;
 b=FCWgha5TnZS6xsWw/fyXolnrFw3tbat85N9LrWkNnbzOqrxJsteeITA3WTmE/wKqzb
 pHQTE3+xud7eRg0D4zn90cV5X3sdErt+mEEkVm6WhFZVh2Ji37IxLRjwk8wn4bbODPv7
 z4IK1F7lVKmnbLi8x/EpAv8WmUWThNoFPeUmTRo7jPG9Mo3PQaVGoWTHn7U5puhHMOen
 oobdtmRU1qMtGE4gP7xwDkMvDrC6yT9GYgo7yWDQF2NVmPTkYEAKK4MjwclQVTKNhc7+
 Ydgpg+PyRaCDND1tmsUbnOGcOCfJeTunagy2M6QC2KrmWlyCUmUokVxvU5T96NhCTx/z
 p3Fw==
X-Gm-Message-State: AOJu0Yyo5NZFkf5ICxJutxv711v1SddB2bDgkhg+exm8RFWZJXfzkyAB
 dZQQ5Ze+Z1Ue6gcmTollrPAsb8UZqtWnlQaaMZzlm0j1V1IOp4uxT6qGEfIOqV7KEvJbtY2IWuG
 zbA==
X-Google-Smtp-Source: AGHT+IFjReuQU5bpELB5EcAHRYXSiSG1GexFG4Per1sMASkkpkl1jTZ2VXhG4BfSBnRTZhibi35C/g==
X-Received: by 2002:a05:6e02:1a0b:b0:374:a40f:e22c with SMTP id
 e9e14a558f8ab-374b1f029c6mr12642885ab.18.1717557997636; 
 Tue, 04 Jun 2024 20:26:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 2/9] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
Date: Tue,  4 Jun 2024 21:25:14 -0600
Message-Id: <20240605032521.1142768-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

It does not make sense to enable all SHA algorithms unless they are
needed. It bloats the code and in this case, causes chromebook_link to
fail to build.

Add a condition to TPM to correct this. Note that the original commit
combines refactoring and new features, which makes it hard to see what
is going on.

Fixes: 97707f12fda tpm: Support boot measurements

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..70b32362ada 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,10 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
+	select SHA1 if EFI_TCG2_PROTOCOL
+	select SHA256 if EFI_TCG2_PROTOCOL
+	select SHA384 if EFI_TCG2_PROTOCOL
+	select SHA512 if EFI_TCG2_PROTOCOL
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

