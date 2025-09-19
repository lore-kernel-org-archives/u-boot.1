Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B5CCAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686A783327;
	Fri, 19 Sep 2025 02:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eUz+zkNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AAC832AD; Fri, 19 Sep 2025 02:12:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BF5832DA
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74d3389cd7eso514983a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758240748; x=1758845548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVWLGN4ss3+eE+XqfEygJ210oMtwxgm7ebJ+pyMfAtY=;
 b=eUz+zkNVQP5Mn2g+KStgLDiXhg70vnmrAm+PHtdvkBeIKwBD+LCuG+ZGU4icZwVpY4
 BETo/jP7qq8F8PxaZspbAaegsgaa/MdWlZmZLCdEe+Oh/ZBvxKQXwiqlPbfcGcKoc6oe
 V+mCVjpBQoMcECG44X35mSgkQeGAxs1+OOBoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758240748; x=1758845548;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVWLGN4ss3+eE+XqfEygJ210oMtwxgm7ebJ+pyMfAtY=;
 b=VJn3ve3KWDDdw6y6Gm9HtDoRFuodfEgo7B7KA15XCAy5scIjhci/jeP7J1k9Lf7och
 HfrzbcDBDXH18PpggTjRDggeTBqMNUfOYzWEBW7zWirxBovmmkM3GR6KPkblTVbUhpYx
 kpNcMB+Iv6+6UXCPZqEpHeiXW1jz1m2ipJPSRbu00hMWn6CY5QzfdpUff6ayl1N2++k1
 893sMRtJ2F/4rFfU1T1ZGxCqOZ3uFquo4eiiPjQOPHM3QSDTROyzTakC1YEl0Wclxf8G
 VScaHzSN74xiUC6hILtu43OpcsXxGvHlqslsp/AAhW7S18Y6bM09fhetH9n3UqSv5Lvh
 vHNg==
X-Gm-Message-State: AOJu0YzMdmVP+9xLQE103gNz/NluF5a19h9hStvPGyna4P2ylg/t4TUz
 urLYAHgs+H76EUH2PwokyDmN9wb3RWE+phuV0gWnY9ekKiu4ji/aJpOuLbF4avj/KEg=
X-Gm-Gg: ASbGncv7iG3FDpwQamnLmPzt7kWq2r0ebiU6f1u4shUi9KOZzhYbjroUTx1aQjUYTf6
 shyZQSGHALsbQZt7Goe/KjKBUg+Bcj0NRU+4+8EtsIZLq0+Z8z3BLUhvotVLUo5dpjBTP7UnHsO
 a57crctaWDNSyiwlWnhO3g9dVjmk9L5vA9TBrpCANFTnLnVXRW+aEmrGdjZ46zGYl3L/jd01rdg
 aD5hR+HoOVD/4wQQGvxWWKTgPZnaop1ZXpaQX7r33SsF0A43BSEbq8B9F0V1gZ+ydrRPfw60tMo
 qX0EindlQHMcD5GyA8zyFuRIzJV7Tk5daRQFA9f4jSKw5Lm9kO8sLmr+/OG6sy8D81922TWor+j
 64PXOuV7b6WJGxgfLVyzaSQIyQlKvvObZBRMStST3qtHuUFLN3MxYyU7HH7UQlbJ/Mi/DpJYyiB
 DEjvP+4YXN
X-Google-Smtp-Source: AGHT+IG2yN3I2e69S2ia3fBw1/nP5+3ygkEhH9duVqhE56OBiMVetcvGa8cp3swRWqGT4o+RAgHyIw==
X-Received: by 2002:a05:6830:63ca:b0:741:bf2f:ee87 with SMTP id
 46e09a7af769-76f5f990256mr1066905a34.0.1758240747834; 
 Thu, 18 Sep 2025 17:12:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691b0244d7sm1694728a34.15.2025.09.18.17.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 17:12:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250908134833.38297-1-marek.vasut+renesas@mailbox.org>
References: <20250908134833.38297-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot: Increase kernel size limit to 128 MiB on
 ARM64/PPC/RV
Message-Id: <175824074681.975344.11287721738562196556.b4-ty@konsulko.com>
Date: Thu, 18 Sep 2025 18:12:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 08 Sep 2025 15:48:16 +0200, Marek Vasut wrote:

> The ARM64 kernel Image size with LOCKDEP enabled is now around 80 MiB, which
> makes it unbootable due to "Image too large: increase CONFIG_SYS_BOOTM_LEN".
> Increase the image size limit to 128 MiB to future proof the limit.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: Increase kernel size limit to 128 MiB on ARM64/PPC/RV
      commit: e18a0dec6e383bf903b7b577201fece58122dae8
-- 
Tom


