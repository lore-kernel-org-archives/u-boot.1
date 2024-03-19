Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C389C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF45988080;
	Tue, 19 Mar 2024 19:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SColivSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E084C87F77; Tue, 19 Mar 2024 19:20:12 +0100 (CET)
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com
 [IPv6:2a00:1450:4864:20::249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F7887FEE
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3Wdf5ZQYKBiYDCTPCUIQQING.EQOW-DQQVNKUVU.FGPZ.FG@flex--barnas.bounces.google.com
Received: by mail-lj1-x249.google.com with SMTP id
 38308e7fff4ca-2d496045d19so30176191fa.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710872410; x=1711477210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ui6TEkit2d93/EKni3jZ2rBsl1MmK00uecahQlwswtk=;
 b=SColivSJz4CX9SfsjsGs3ejgMiern0gnnRxbEBNp14qfFMplGNhgE8O2/SLJBVPGni
 VkQ9h0JXWJc4OcZvgGwYXAsCc5veWIFBoWjD47tjaTZ0xG2rd5y0CwQqdXBQo0jJfXZJ
 qmtg6yOEFO+eY36jTNnEekLTJlufrBXfo7+BOzQbEKnNjkWp6lTEN9VQfxcNxnWmRFFB
 VOWRH/EUJXteJoWmotfhH83GPTWBx+M9W+gPr/4GcfL02Aj4KICrLBoPetGm73Gb68t3
 EShqlr/G7wPCQcRANycmuEf3bWFmnczk5ijKSJIgsEVaeHnbB+0BEjVLbb1BZYdY+H9V
 UltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872410; x=1711477210;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ui6TEkit2d93/EKni3jZ2rBsl1MmK00uecahQlwswtk=;
 b=RD6Fb5yFCeFDYAef4KEvTVOZ2TD6qDbjkp21YoNeGGqmmi5M6KOp2HdNAp5Qqzd5ou
 6YNlA0cpHHk/oVNSRau+yWtivFWz31iMg3LxGVJzwlo6S6vdgmm6OaUSPVuVOXAgqQmM
 fyRN36hbRa8Jfr/jfgKSGfMJWx6ePEhXPJN1FavM0k/OpsPEH7JW/2vcIgkxAxI8AXZe
 YXCTDYCq0L4BuYCsrl6D5H94A7ieCGXcz7bllNfgi+pjRmNnoIHrnt3+KBz3aqgUUTd/
 VN7dq0MVpBfwyuPQmwpkUPCvJuYvJSBI8eortezZxm6RfBYMk84ghcdzqLT0NFc3owE3
 AtjA==
X-Gm-Message-State: AOJu0YzQjLSw3OBAS329q5CQt+uQp3417Q8puaSU/fwFDCE1dGX/eDv5
 9gxhacOzjGkc1TB01H2gV7Pm8sZQv0dWxedKajnzJAF7L4uOZCRzyMAvDHWXi1Pia9kX/serBU3
 xWdubNCvuLiVKyyxcdhQ9WwbHm64DsThqd/b4o6oMhR7uQp7/s9H5lTb6hTvICHMNdAotVVYhZM
 2EyygIRdWQLjEypj//UG7LTytWxEvQfA==
X-Google-Smtp-Source: AGHT+IHhsN3pa6l29in7dLpgR3LUJPHkIYoprq9mc5EFDYvvMKdTEQcqizU+vMC+xcU91kNeiBpYOpy/w4k=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a2e:91d4:0:b0:2d4:584f:c64b with SMTP id
 u20-20020a2e91d4000000b002d4584fc64bmr22112ljg.7.1710872409911; Tue, 19 Mar
 2024 11:20:09 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:18:14 +0000
In-Reply-To: <20240319181949.3083508-1-barnas@google.com>
Mime-Version: 1.0
References: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
 <20240319181949.3083508-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319181949.3083508-3-barnas@google.com>
Subject: [PATCH v3 2/2] chameleonv3: set in defconfig for FPGA to reprogram
 every reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 19:20:50 +0100
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

Set CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM as enabled in
chameleon v3 board's defconfig.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

Changes in v3:
- Update defconfig to use renamed Kconfig

 configs/socfpga_chameleonv3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_chameleonv3_defconfig b/configs/socfpga_chamel=
eonv3_defconfig
index 6ea61ca6ea..7506aa8d32 100644
--- a/configs/socfpga_chameleonv3_defconfig
+++ b/configs/socfpga_chameleonv3_defconfig
@@ -7,6 +7,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_arria10_chameleonv3_4=
80_2"
 CONFIG_SPL_TEXT_BASE=3D0xFFE00000
 CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_SOCFPGA_CHAMELEONV3=3Dy
+CONFIG_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM=3Dy
 CONFIG_SPL_FS_FAT=3Dy
 CONFIG_FIT=3Dy
 CONFIG_SPL_FIT=3Dy
--=20
2.44.0.291.gc1ea87d7ee-goog

