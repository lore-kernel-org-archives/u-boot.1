Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E7C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 22:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA6087D42;
	Fri,  8 Mar 2024 23:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MPo/AQjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A0987D47; Fri,  8 Mar 2024 23:00:14 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6154487CDA
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 23:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dccb1421bdeso2511621276.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709935210; x=1710540010; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixN/z9qTz+hFjEUmUm2TiH1zB4/0FiX5+EEDu2etwM8=;
 b=MPo/AQjKRRjY+MltkCz5OuU+p9puE/Jce9ajhBYMpemPEJXL+WzpjA0oBarhSX0rEV
 zTdAZ2ItBzKVEQoXSfLqjdC+L+aLA97Sd8+zXtr72h2LECfMaMgPeuulKydp3yFnei8I
 PTtWsFQEA5c89nKDAeXtfFI4A5iCFUeEY8Y49MxTYDedMZkbXOwmZkQ6f6e2VK9A8mXD
 bKujghI9rSXrlv7/Of1CJqkYwJfQnJ5Vi0c5o1O+RposYmyXn9nfgt8nc0KRjG08DAPZ
 qNj0U4rcQhtmJB9B7hbBpad9dO/BV0gc5B3j3fKGlB//Movy5phkfr8sn4+uIHSO7Y2E
 kRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709935210; x=1710540010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixN/z9qTz+hFjEUmUm2TiH1zB4/0FiX5+EEDu2etwM8=;
 b=YsZXFMAp4khgGYeC28S7TNtDu6tkQlWk6tQwfgdPDEgWy0PhkqFij8HARZXihLscGs
 HFMenSLT/9OG70ZL68LqZd1IHuE9sjzTeOvNwn5k9KCpyl0QaLcekxb/2U6AIxn1w3Nk
 HnhQCu8FRY1CBogv/ineewiWFXUnza9sx8TmxIvpxDDHwlnIh+TiqsM5nnFg/ndOIWIr
 YUmLebEZOytwLxGPNU7AA8/d+GsXh5UiXbYRbkdAn0vv2/m1Kq1lFLdGDqL9GE57DPBU
 GW7PJC4h1rlwJ33Np3qC29K9qoUtn06xF/LRku6ndiDHJnE3dAKhBFfmsa9Feo9Ro9Kp
 N1Rw==
X-Gm-Message-State: AOJu0YySmunf2lO1bu5btbHBoZ/6lyuzCuqOvJ+bmC+4efE2tZ5XdJeU
 dCTkiRO+6AXQBba10MHhv2EYd2jNLhZeSYsm/XUeIRNSKBrejzwj47TKwqrFnIy+2xUoULyAVLC
 iZhoSrnhlyMG+EGeLgmmt+JvKafTxIL8AyfPuqw==
X-Google-Smtp-Source: AGHT+IGNOpBmQ695DGyrakDEFGIDRIq3/rLXYoRmZDaF2i1hogg0iRumKW9KjiutMO7sVVFyewgI5H+SKd/tKL68Ln0=
X-Received: by 2002:a25:684f:0:b0:dcc:e9d:4a22 with SMTP id
 d76-20020a25684f000000b00dcc0e9d4a22mr243033ybc.12.1709935209960; Fri, 08 Mar
 2024 14:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
 <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
In-Reply-To: <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 15:59:58 -0600
Message-ID: <CAPLW+4nQBssOtR_wqU25XW-6ZDEm7Yu_7q9ODjWhkWoE9FoV9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup
To: "McAllister, Colin" <Colin.McAllister@garmin.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "JPEWhacker@gmail.com" <JPEWhacker@gmail.com>, 
 "sjg@chromium.org" <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Fri, Mar 8, 2024 at 1:24=E2=80=AFPM McAllister, Colin
<Colin.McAllister@garmin.com> wrote:
>
> > Ah, ok, I see you replied to my comment here.
>
> Yes, sorry. Outlook is terrible to send inline responses too. I figured
> just adding responses in the patch contents would be better. Next time I'=
ll submit
> my patch with a different email :)
>
> > So when that config option is not defined at all, the build still
> > works, right?
>
> Yes, the default value for CONFIG_ANDROID_AB_BACKUP_OFFSET is 0x0, which
> would evaluate to a false bool value in the if conditions. I did do some
> testing with the config value not defined for my board and confirmed
> back-up data is not used.
>

Looks good to me, thanks.

> In your other emails you include your reviewed-by tag. For clarity, Am I
> supposed to append my patches and upload a new version? This is my
> first time contributing to u-boot, so I'm still learning the workflow. I
> didn't see anything glancing through the "Sending patches" page in the
> U-Boot documentation.
>

Welcome to the community! And thanks for your patches :) U-Boot
workflow is quite similar to Linux kernel one. It's useful to collect
all tags when sending out your next version. When the maintainer takes
your patch, they usually also apply all R-b tags for the final patch
version, so you only have to worry about that when sending out a new
version. I know that U-Boot contributors are often using `patman' tool
[1] for submitting patches (and corresponding updated versions), and
I'm pretty sure it collects all pending tags automatically for you.
FWIW, I'm not experienced with `patman', as I'm trying to use somehow
unified submitting process for both U-Boot and Linux kernel, and I
know that using `patman' is sometimes discouraged in Linux kernel
community.

[1] https://docs.u-boot.org/en/latest/develop/patman.html

[snip]
