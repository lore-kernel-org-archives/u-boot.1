Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321AC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D93288100;
	Thu, 25 Jul 2024 22:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ESRelqYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518D688365; Thu, 25 Jul 2024 22:57:45 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA5588100
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-66493332ebfso12138777b3.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721941062; x=1722545862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGSMOlFcy/LdOvabyGOMHd51d9DFa3QkZXcqUI+9p1w=;
 b=ESRelqYYWgxA5NEBnJRIw4cLsB/JWSTMD+WICsA421aJWQ1DuM/SzC6ocU8y3DYl4v
 HGZ82ylPvrD8gjffgP9CUcVLKTgrXF197El1aEdCmFUS8E3H+SXup8OFGi8MeKKBNYga
 TM+oehBpIHrMPVuOMAMdz2gJ0N2N0xKqIHYcbl7vYRbqcEpjsfb6UECjtDzXLm1vM0l1
 XLon6CnRPCKlxNW2F0ZdsOcr9OQTiJ9Y7wKPRvV4H/JgZ2eWWUk04mzihF6FAd12CcI4
 Y1fSMivco8YCTv3PzhwO0QSAFDGTXeG1C3sDmdB2pwZHkPDpzHqzJnhJH0BRNnc8k+3y
 gOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721941062; x=1722545862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGSMOlFcy/LdOvabyGOMHd51d9DFa3QkZXcqUI+9p1w=;
 b=Qs/zDaBoptbupjJDnbA+AFZUqf6SF0eDEQwlxKQxYaseeL9pdilR7I5/MEvTId4oSF
 8cVm/LAofUsFm1qkP6AbUdHdiKEMJnCqxeXmGRrbzrBWNfWfXdMUWeFWEZGaEQKvte8Y
 wBZp7cred4mRHcIcFqqimr5HdJaWlGXWPz2NsCXsnGTxgVeEqUDNm2XEi+0kfSvH80xm
 7VfU5OjUGnrGrFkGzCFkdxjxeSc0WELtaQi9AV6mJeInh6xEUbuebyohjnCRR5tOx+fK
 dSLA4meMlxIWEl3RZAcgLHcI3Q5cERs7tL4wgWOqH2uDmSVYopTNRTdGho1ZCv2H+0p4
 xMIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWlwLgWyqtygjcJymhFB83+DtauEZ4dyQ1DyWLGrIzaAXV9fFOTyYBiCIKWYd5jNwHbWiIp7mpF5yP1PXk51Ywe5rNwQ==
X-Gm-Message-State: AOJu0YzGxtGsS50Ayr9UwpGksFvHxM0KsEsliW7Xsb7k/p4iSOqzoQDP
 zO22fzWkh1as69sX7R9xM0dN01Z+dRFpsLYRqWM0jlsRmOpFqlEAyqHU8yYRAbQzSpVRMuQ9BAN
 8rAj7SDwfYvIGGqcSK37e3nCA2mZugHn0lF09Pw==
X-Google-Smtp-Source: AGHT+IGtMbfTwUUyvvdcsDV4Jfr9bikZ4XgvhStyYJ2985cdzg4LlPlI5WEVfjoBvCt4Uro7aqn0j0UMenSazFCZcwI=
X-Received: by 2002:a0d:f281:0:b0:615:bb7:d59c with SMTP id
 00721157ae682-675b4e4a332mr32822857b3.22.1721941061898; Thu, 25 Jul 2024
 13:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
 <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
 <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
 <CAOf5uwm+LvC38EUough8RcPzyah01xuibP5rxnTYSam9dfNJUA@mail.gmail.com>
In-Reply-To: <CAOf5uwm+LvC38EUough8RcPzyah01xuibP5rxnTYSam9dfNJUA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jul 2024 15:57:31 -0500
Message-ID: <CAPLW+4kzPmy4zgjiuay=T2y2ciRRf1ejUNM=tGjj4JCA8AdVLA@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
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

[snip]

>>
>> If anything, that shows there is a rising need in this propagation
>> feature. I'd like to encourage the maintainers to take a look at both
>> implementations, and maybe at least comment on why there is hesitance
>> to accept this patch. It's been almost 5 months that I'm trying to
>> push that through, and my MMC work (DDR mode on E850-96 board to be
>> precise) still very much depends on this.
>
> My series is still not ready and I have no problem to go with your while for now
>

Hi Sean,

Can you please apply this patch, if it's ok with you?

Thanks!

[snip]
