Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2977AF41815
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A3483F82;
	Mon,  9 Mar 2026 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+kIjHjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2DD83F14; Mon,  9 Mar 2026 17:57:30 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CC983F6E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso680656a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773075445; x=1773680245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31WyJ98ubss3gpJzwsB5XZ61PkmyqngTmE+TmU1El/4=;
 b=U+kIjHjGMbQ7awmGvZZG2OrNIrYFg0K/Vqp/5HCNXlSypXRtsD16BYOoWZ6WkDcrdL
 mnVMGFqqKrWyHWiCkjHe1a+OA5e1n0ExxT45lun2bpEN3anrObOLSPkFDz7s0aX6WRr7
 6vQGzbheepTZESQ8ig08sIRR+E+2zG9qID3Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075445; x=1773680245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31WyJ98ubss3gpJzwsB5XZ61PkmyqngTmE+TmU1El/4=;
 b=WshTEPdT05E6QP0X7s5Ugv86H0A4VNbGRn+aAoXCEp5ezAvtX47FEe0LtNyD0YInUp
 +6KGFIxA8D7wo62f0dZP2my91EZxadbXXKe7lDcdRmDbzigdSFFdBdGd4aqt2/l48fkS
 qAvaEpFFmEAdFWUKnTyOFCInEFzvJy5AhMBey+E81qHNqvveRUrLMqvohqUxbLACEUH+
 ASWU6XnS1nrxG+wXX+kEd/6XXdj5mEGhrTKxFZRIVDw8uljMl54b056Y00bC320IDOeT
 +c4U/MxSRLBkwWmSdkZu10IzuRzSiwdA94eVr6VAnUhzb1KwSv8XGNC0EmN8U5agIFkn
 6Tog==
X-Gm-Message-State: AOJu0YzkuOmbFcCUPvHRD6OTfZjegqO5A/ePPqHi8ZPYqK0d69ojyNJo
 OVIEMvhAY3EyoClzzIimCaM3ghyVKBH+4tjeN7xuH93Fa+ZKYt3VejqFlISs/zLoJdwSQ06SpCY
 i9PTlxTc=
X-Gm-Gg: ATEYQzywNqUl1Fl9rhwscHVxx9MyJ7RXgVaR5Nxx7rMK5+Xv4poubmeU7ESC/NPynP6
 uW2TCxoMNCH3XhdBUpMTMJRr6trLLF75gY5zeGtlYRvWm41HjCMHMFqaU7L4UQCQAI6bIgeMzhv
 V4jPi+3qIsA11CT1To8LJjHVlDL2qF74TqsOBNv+3rU0EKOGR7prqdBj+/Rqfkp1BMOwRQokL7H
 K9YxbOqsIAMuywBbPY1MLVvCrfrEVs2cAPai/XFWemm+k1L7vX2dJ8hMYQToYHfWsRuX4iVbAnO
 kucSMh3w6UBAw8+iAc4k+9k/zBZFq5pFrqQ/yOGpMcC1F5nkqLV0lyzO2R9avffJ2IXqlu5xNmf
 Li1Kw6cUX7Kej7cfSUXqEzjd94ZlYCyxMnaSas1mSNIXx2RjJ5oBhs24kgSuijUJHU41YvVW7ST
 Xuz65w0mp48vjg1sJzxk29d3spyGQ51NHw5ebEeohhWyE5spIeqhYzsFSvraf+HpUI6FjBKec+S
 uWJ0NiAAzoWzUk6wiYK33U9nKUekEdJkR3km/Wauj1A
X-Received: by 2002:a05:6830:3487:b0:7d7:54d5:c6f8 with SMTP id
 46e09a7af769-7d754d5cd31mr1217699a34.17.1773075445343; 
 Mon, 09 Mar 2026 09:57:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74885b5a4sm2690201a34.23.2026.03.09.09.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:57:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Ludwig <ludwig.nussel@siemens.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Simon Glass <simon.glass@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20260306012019.800588-1-sjg@chromium.org>
References: <20260306012019.800588-1-sjg@chromium.org>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build
 signed node list
Message-Id: <177307544425.3622694.13421951746750904564.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 10:57:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 05 Mar 2026 18:20:09 -0700, Simon Glass wrote:

> The hashed-nodes property in a FIT signature node lists which FDT paths
> are included in the signature hash. It is intended as a hint so should
> not be used for verification.
> 
> Add a function to build the node list from scratch by iterating the
> configuration's image references. Skip properties known not to be image
> references. For each image, collect the path plus all hash and cipher
> subnodes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: Add fit_config_get_hash_list() to build signed node list
      commit: 2092322b31cc8b1f8c9e2e238d1043ae0637b241
-- 
Tom


