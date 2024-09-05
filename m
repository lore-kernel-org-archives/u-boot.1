Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7BFCD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 06:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBC088B88;
	Thu,  5 Sep 2024 08:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k5CLH2cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7FA88B94; Thu,  5 Sep 2024 08:56:23 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C808876E
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 08:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42c5347b2f7so2797525e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725519380; x=1726124180;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kXrhSahasjgXf1/IcFt0BMJJdb42/4+E13ttetaGLQ=;
 b=k5CLH2cu/hNIPpOjSGgyhPIfpBNEUmrHe1GRS0aa4yNASjBasaIyqcARkA70YQDI+G
 s5HTKI7Worz+qUrFck43x1JGf7z5ZOWRZsjGqU38dHBLjdXUJ6VPkmSEVoKWx4MmaaTQ
 Y7sSH908U06zLLjSpDO+eORupHs1IqRipfytBiAbCZffNYkVX//wa9XRy2UmmzLwqw/S
 S8p320cXw5g/tDS/582359GmcpXBDfcxuk2pVyEKdhUcxhOPNPv8gYoN2+EDM/fDlFHO
 KWL4f/8Q8thDI1lAOUFxUcYnTrepAkBA8OgBdjBHW12CeJD1ZDDhhi1KF9oF2OQgmDyh
 /rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725519380; x=1726124180;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kXrhSahasjgXf1/IcFt0BMJJdb42/4+E13ttetaGLQ=;
 b=P5nY2MRRnPztLZrj4UtGUHUXnfPCao2jzWNjxon0qMdd5JSLTeS4/YSmlbIhVMep1p
 vmZ+6TUWApw/QSNRvGbPAki7woCb/C/Of3f8oVCaBhf3KNlHB1iqhmSSyG/Wi86VHe2o
 ni708Q3qKlE89HzBCC7VuNXBSN+9u9PnJdPu1BApuaLAEBMeVfljQggO/IGRbqRVnQIs
 YWaQI0VphcJPXfxS2MgU+Ahcv7V9qu9TWL5AdulwaxOnJJagxYJUU93AA5pT2szB6kcN
 FL9Yw9KeaqDG01CpFWsTgJ18ujt1KQwRJd06TUqjfNB7S9SGJgPbtlXL1+jBeUmQtvKB
 jpKQ==
X-Gm-Message-State: AOJu0YxWXO1oHfZAThMvUVIgXZFP1SXrzVGTIDAphBoRpgbBS7XvMUew
 HlqmXZ4RHFOFJZeGu2jj/k0Z/jPofotOGOW9+QDmmsWmmx6fH/D/QHlOb5kpHKs=
X-Google-Smtp-Source: AGHT+IHQbYHrICiYjav3aR/+a1OnCFam83LPg6BbuhzHoIHJS/fLQtoq2DTnCJhMu0FvtX7lidOgRQ==
X-Received: by 2002:adf:e444:0:b0:374:c1de:7e64 with SMTP id
 ffacd0b85a97d-374c1de81d6mr9232326f8f.42.1725519379728; 
 Wed, 04 Sep 2024 23:56:19 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bfbfc7b7sm13604205f8f.88.2024.09.04.23.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 23:56:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Joshua Watt <jpewhacker@gmail.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240828143924.3987331-1-JPEWhacker@gmail.com>
References: <20240807141434.733085-1-JPEWhacker@gmail.com>
 <20240828143924.3987331-1-JPEWhacker@gmail.com>
Subject: Re: [PATCH v2] android_ab: Fixes: Fix backup offset calculation
Message-Id: <172551937869.44670.14546795488796150123.b4-ty@baylibre.com>
Date: Thu, 05 Sep 2024 08:56:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Wed, 28 Aug 2024 08:37:57 -0600, Joshua Watt wrote:
> The backup offset is in bytes, but was incorrectly be interpreted as
> blocks, leading to it being written to the wrong location. Fix the
> calculation, clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and must
> be a multiple of the block size, and add a runtime check to validate the
> offset.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] android_ab: Fixes: Fix backup offset calculation
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/cc2f60c13f6aaf1bd277cf10c8b375c2e4a695b7

--
Mattijs
