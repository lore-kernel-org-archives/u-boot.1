Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8A9C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BC3885BF;
	Fri, 21 Jun 2024 01:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nuiHZAOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6E58855E; Fri, 21 Jun 2024 01:06:49 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5C687D1A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so56530339f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924806; x=1719529606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfcLD1zI16U3eN8QPXtyDsRvUuj2hvtPCbl0nEveeBM=;
 b=nuiHZAOPd/HqqbHLg6AvK2zdj8MUcfb4Extid09fn2arBzjtvDa12lZ9nVtMNLBI7r
 cdmG1NWVOL9A5/gn+U4sL+GwgIHpVfhgOHR1RzArEj9xx7gW08MlRxfUytNLg/MgKPz1
 6IORriXQqWFDg39k2Ohdv1lB/cqBAEh9dDTCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924806; x=1719529606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfcLD1zI16U3eN8QPXtyDsRvUuj2hvtPCbl0nEveeBM=;
 b=cCCDCNv4l/JUktayfpD5YssG8l89jwA8H4ExDFmR5p/xJH1+G+kvcvNjKuIvGoOval
 5ER0i5KGjv+IqST8wc5Tj0QFuSaR+NFrFUg86vzPAG0GfOYQvhaQGUkFJoiPslSx2i0u
 fAEdiV0IStAed+AXbXKmymRBbsZCUGrZJSTCHfelDAw0ce2Jp+c09C+lWZG0zkyfUZPN
 BkBW9b/1mZ3sKdYGrCVizfnalWh3YKx1Nf44477P+OgGFyUSiHlsQNfISYuYOqDmlZJN
 19xCVdpAF9wOu9+7reNieSAXBBXd+0FJFDaylzPtkuropULlEs8KV8RWzSSb9fMA48RG
 seOQ==
X-Gm-Message-State: AOJu0Yy0bmBsuiNiRhIExnp9ShiycwHG1CVRA+qEtesA13/xAoGlkb5f
 IsvHTOxgM651LZHu60vQC2K39nkUeIvpevy8jp5mxg5GF3s6jA36j9++JcPXHRogX+4V6Q8Y045
 ndA==
X-Google-Smtp-Source: AGHT+IG2taZTGw8gvm0zJNCEZUutOC8O2aXxLKthfXPEUfg278UYTmZLKkmp1La7ItFGGlwbDGHmBA==
X-Received: by 2002:a05:6602:15d1:b0:7e1:a7e8:eecb with SMTP id
 ca18e2360f4ac-7f13edde67cmr748517939f.6.1718924805853; 
 Thu, 20 Jun 2024 16:06:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Date: Thu, 20 Jun 2024 17:06:17 -0600
Message-Id: <20240620230625.1797397-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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
fail to build. That board does use the TPM, but not with measured boot,
nor EFI.

Since EFI_TCG2_PROTOCOL already selects these options, we just need to
add them to MEASURED_BOOT as well.

Note that the original commit combines refactoring and new features,
which makes it hard to see what is going on.

Fixes: 97707f12fda tpm: Support boot measurements
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too

 boot/Kconfig | 4 ++++
 lib/Kconfig  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..b061891e109 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..568892fce44 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,6 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

