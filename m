Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F05C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 15:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3083D82075;
	Thu,  3 Apr 2025 17:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HMP4MfyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E7E8210D; Thu,  3 Apr 2025 17:09:20 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F5182054
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 17:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso10726241fa.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743692957; x=1744297757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vFcdWrjI06EEC6EWtN0L1kVOQgQ0UyRKBEbPFMOi2I=;
 b=HMP4MfyRmLXIJD64XbmHnC4nZE5u6RZtTo89fmR6wYzlBYuaqG31C1ZIowjEpxn3Fi
 oF1ENmYWiM7HDkHNMtwhG38ST3rfneekzIlfKanJOdRoNpEHDL/b7DmdXdRIKfdTOs3S
 ibnD4r/HNjupiilZwmpojVWbEh6C/j+L9zHLsvMi/elr+8JPvbNScLC+d1WvIp9CUtTX
 uIc2eZhjHXbVOnQ3FjMqBD8Or/5uoDpn34FdKGVKzE5FJCbjgv9nOhmylA/F6ZrrE9sT
 RScHf4N/HLeroQEmW3ffrNP9q9XpvckADpHzu7wTrs47oy405y10zBDmfe6PeZy1Ny9R
 y1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743692957; x=1744297757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vFcdWrjI06EEC6EWtN0L1kVOQgQ0UyRKBEbPFMOi2I=;
 b=Ttp/rzuw1zxudYZn8pEFDrIOpoIfg9tJKtCRX2kNA/wCEFy3bOtiY6nK9t9T9GeQq5
 A4/OY17R3B2Kbf791GzlEYBlqJSsy6xQ7O2YwSX+ohpKExpcGb32khzP55WNMRRZRK1m
 EB2J7D8BopK8aKZ05+ald3oeVBonpMij+4ENLUegcdnVB4NoXfBtKWlnUzDEEFIBea+R
 kWATeSnKNGIk8eFfrPf4Q/wj0wT8pmcV10ljR9qCaKjJdGSJ5jcrv0RI2PUs8s5mNVCz
 1w74n/gU4ZfGBE4T5Yy2GUKHVnr8jGm1ORxs6GwpmDtgy+IjvYrzi4GmtF32qRrnfGrH
 arEA==
X-Gm-Message-State: AOJu0Yw6ssTZDAWRCbPdKsjaIt91FSU85tbPFLoCugis04IxVgqnP05T
 RheuRaq/wlY+EeK/JphCLS5EwJ8Qm/F8amUpoEYF0F1JqEIcWm8YPXzFWvtoZIvQwY4ACcVL3Ci
 1UZoGw1eMJ/9WW03AkUrAA0nK8k79ng==
X-Gm-Gg: ASbGncuVKPQFpTqUPE1cdx1TuW0wpRlQON+N9kTCoqytGbAyGA5wghpoXzgJGitCOJq
 x4wbwPZTpRk7o8WqJKC5N/lr8rujSgREAkKqMdu6VMM/NIuYxGwlDAtG+OgjUCrMqAX3J9iaM9F
 bDw8+heQFcc2ItTY/2o3CaagqADkP51B5fSpnogwFL95KJPrEPkvARwJ9M8A==
X-Google-Smtp-Source: AGHT+IHp/CNFt8eMtJeR5vT+6wHMO+7Mh+SsM59GI7j6q3l5mhskizvbOglbV2//KqsrsNW2sBbtvqb7RyCswjMKCtc=
X-Received: by 2002:a05:651c:19a8:b0:309:22dc:6917 with SMTP id
 38308e7fff4ca-30f006a57bcmr12747681fa.19.1743692957358; Thu, 03 Apr 2025
 08:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CYsDA3fqdt9UZVFmcTttB4q-_=X5vqQocDpn2-ORSikQ@mail.gmail.com>
 <fc8a2397-9571-4830-bf61-1f57e5349229@linaro.org>
In-Reply-To: <fc8a2397-9571-4830-bf61-1f57e5349229@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Apr 2025 12:09:05 -0300
X-Gm-Features: AQ5f1Jp1H48Xb_HhqbxUdmZ7flQ5H5jSo_lyoeeJUVIA2e0b0FP5gnSOiNDkY1g
Message-ID: <CAOMZO5Dh5=r0t6tp4sg50oPogWkmuUYbVYvDDzOQBGtzJMSY0w@mail.gmail.com>
Subject: Re: sama5d27: Replacing at91bootstrap with U-Boot SPL
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alexander Dahl <ada@thorsis.com>,
 admin@hifiphile.com, artur@conclusive.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Eugen,

On Thu, Apr 3, 2025 at 11:29=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:

> First thing that comes to my mind is that there are no timer devices
> available. IIRC when you build u-boot, you get a separate DT for the
> SPL, in which only some of the devices are present. My feeling is that
> the timer is not there. Can you check ?
> Devices that are in different boot stages have a property in DT bootph-*

Thanks for your help.

I managed to fix it and will submit a patch.
