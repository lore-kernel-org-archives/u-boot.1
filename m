Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432AC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152388863F;
	Wed, 29 May 2024 16:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IvhNLjfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFDD88629; Wed, 29 May 2024 16:49:05 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E4A88602
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5785d466c82so2594620a12.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994143; x=1717598943; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FMAW1dpN0sJGqp4IpwIC0EpaM2WaZQwQFd9eCKE47xE=;
 b=IvhNLjfgkOGvGgPAtXz9dMwGWDLansM4tlkA0xlYn9vGrwO85lAcUuq4cMkmn+4wi5
 G1Wq4mChLldFsCZFoBOrHyUsDP+t3FcVzys/abgRezBY9rM1ZybqpkVPyTWJpsdQ4oG1
 rNuvDS8jQgdXz0/HJJHN6i32l925UQJxuyeY6B1PLiwdcZjtWCak3NNrWtDTe+t0Xvkb
 exewB7chU3TjcWfhICLlBWsIB5Td+yx2GbJYc78vnq5WzpxXviPz8rAbVXGbaffqAX25
 io6NIgtmmMrBp3NIQjAPblWLiNP5HlGlu0RSp3hfqoVWFGclzaLfdrwYRVCuynkfaBmN
 F0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994143; x=1717598943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMAW1dpN0sJGqp4IpwIC0EpaM2WaZQwQFd9eCKE47xE=;
 b=m/wMajtAZa96GU+IDqVG/IT4CXym91Hb2gpakUmS1HYDqtGWP7RNNyHrPTQT72XYxE
 QmjvP338xW7eSQRNccrGDTEmULO5FLhdAiQMTr9gCZ3knD/ctfNpuj81jVi0k0aydk8R
 qSwc9yCWT6Es1g35ZtnqRRIPvVLZPDPskBR108+lIKs/h1b6oG6srQ/j5hpuC9RQB8cI
 +8Drdu6pHH9WUbv1+CEwGVsCc/pXWbUyySlrPKD8IsuqSAZE5TpCgEfZw+CUeNEFVfxE
 8ohHjkYP/xUvOUKkJTrcfjB/ekoRmBu42FmZDVsVnPnFSFXpEgvX7x7eZWiMkZHD4IUX
 PHZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWp8J8OnPmbEZfVYWCSxeEBsVtXTsN/e/mNHtfUP48NP3mshAhOfepOrN8ciLRe3Pvx/sOSrpLwTSLhtfhc4iW/UJG8Q==
X-Gm-Message-State: AOJu0YyQ/52OvDDXQ7CxQPFGFIT/bA9U900vTRCWZboxykN+KxF9EN83
 HlU9Aef1lcEIX1oHwL4OuO+RY189XicP8QEmRwzg/5F83PEnkqgWzujWbnd0vLQ=
X-Google-Smtp-Source: AGHT+IHwfFYrs88c8LcEWqNRvAarPlBrgQiH7m2fusOKe9T+cMItZUuGPS/FwQsmrmgsDaNa65y/dQ==
X-Received: by 2002:a50:a45d:0:b0:578:63e0:e4f1 with SMTP id
 4fb4d7f45d1cf-57863e0e555mr9562088a12.17.1716994143135; 
 Wed, 29 May 2024 07:49:03 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:52 +0200
Subject: [PATCH v2 3/7] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-3-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EdslQZF10Tz/XBvoasteUepMjZO5dSDrB6Bbsr2kI1w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BatxyLQukAj5Dqnl+xStlnQCKCwrB0fbuyB
 w4B56lgPPGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWgAKCRAFgzErGV9k
 ticCD/9x/f5jkH7UFVfM6eqOBTbKYRSQTYKqhMfagwIB0HhU114r4p7qJdIxiC7r3VpS83Pf9pC
 hEILG0mjxNJx0+/7LmZA6nCVLJnP/X2LjrpbZxgnG7oroXkmxiZ3Tkj0HvpxCCvm19bh24t/GNJ
 UgMINpDhnZu5HOoyiYQ34xVLKOL6rtqlESLst2PRX5q3jJ0gX4o0vH59zNWdehb1bYdbIoR7v7A
 gXM55veKJ3BAwUnesc+OxzVh7YrCWh4Xtbl7DjVLgucUjwczIWYjzj5lhbkKpS5T993RsOyg8H0
 4ixX26gY0KJei6PppJGtKfZgTrDgEqdA132/TsO/OSz3Fjjsj0iL7za/rY8lhHiXRiRzMAReNmD
 Go5eEvdvHlgEXnncuEsaVEKOdgjFLLn6Uhn6brsZTMTGwX3wVNKt0TwvpPzfu7bMg+lgXRjPep9
 wReK9OPJTlr8Ok/hX0O/LTQ6BlvaASSgo9OjM210MQ8qrd3n8SB3GkbsG5k314MQ5Qm/bJsY5NG
 mN5XS4g0bvyQ2BcfCbbw2ihTWgO1Ihss0L1TalxqoJB+dcStmHxloP3fE0ff63cCm945572mYet
 +q1qg7lNOLoZzREet2/hZJmiTQPYXegZa3aotTYZULq2r3aouz7CazxJzawMwml4lp1aic/u7gT
 bXOO51Qlzq/D9ow==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Document how platforms can generate GUIDs at runtime rather than
maintaining a list of UUIDs per-board.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/develop/uefi/uefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01b..0b60702c052a 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,39 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+The image_type_id contains a GUID value which is specific to the image
+and board being updated, that is to say it should uniquely identify the
+board model (and revision if relevant) and image pair. Traditionally,
+these GUIDs are generated manually and hardcoded on a per-board basis,
+however this scheme makes it difficult to scale up to support many
+boards.
+
+To address this, v5 GUIDs can be used to generate board-specific GUIDs
+at runtime, based on a set of persistent identifiable information:
+
+.. code-block:: c
+
+	/**
+	* efi_capsule_update_info_gen_ids - generate GUIDs for the images
+	*
+	* Generate the image_type_id for each image in the update_info.images array
+	* using the model and compatible strings from the device tree and a salt
+	* UUID defined at build time.
+	*
+	* Returns:		status code
+	*/
+	static efi_status_t efi_capsule_update_info_gen_ids(void);
+
+These strings are combined with the fw_image name to generate GUIDs for
+each image. Support for dynamic UUIDs can be enabled by turning on
+CONFIG_EFI_CAPSULE_DYNAMIC_UUIDS, generating a new namespace UUID and
+setting CONFIG_EFI_CAPSULE_NAMESPACE_UUID to it.
+
+The genguid tool can be used to determine the GUIDs for a particular board
+and image. It can be found in the tools directory.
+
 The firmware images structure defines the GUID values, image index
 values and the name of the images that are to be updated through
 the capsule update feature. These values are to be defined as part of
 an array. These GUID values would be used by the Firmware Management

-- 
2.45.0

