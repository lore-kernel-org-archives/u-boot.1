Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCEDCD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C7286CA1;
	Thu, 21 Sep 2023 03:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z0kaTx0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034CD803AE; Thu, 21 Sep 2023 03:02:53 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5752F86CB1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5033918c09eso740824e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258167; x=1695862967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yn9/V+VW2Zb/mJc7piYKOsUx/td3zjAnnP3RiPtT50I=;
 b=Z0kaTx0ylukFOG5kSPWL64ANLQlXhy8WHo1V1az94lQO3wDcSvEchIK7AXcM/XevQw
 Z2YkxKtVRb2bpqvPDskSpliQuVQrgX5a2j70pDqBkT/Y0ttRip0+Uj+NB6/y4NiK5g3y
 66r5giGo9F2QirBa/dJfr8e0j4/UyTyVkwtVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258167; x=1695862967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yn9/V+VW2Zb/mJc7piYKOsUx/td3zjAnnP3RiPtT50I=;
 b=glhWPdYU6eSVjwlnnOC7VFaac0j4QthBWGh127EvjXTBRGoWy1+4Ccxq1WG1GK+1Hf
 DOmwPSw5O5hf1sJKAFF+Tmg8ssExP8uQ4sfCuRVjnk/0w4BtYrU1fKvQnDfxK34cvOhx
 28G1KbAjyN1fYeaXs9EzNxpr/ZMYOgD8pWTCNv3encubzo967Rm/XwUW/VEEfHFzkcoP
 osIqwv3nkcHqnzLU6/mkMbOWDfcEgUVwj62JY1J3ChzBrj1J8KjA89DXCIFz+ov9Y6tU
 jxcx58rWiJ+6LaHFhdP2iwc+p2j0kIZvgkmnBFcy5t+WQiuDPA1HswIrCBfGRjz7Izna
 /uSg==
X-Gm-Message-State: AOJu0Yz1Vm6+Qdo8xqSyZ/CTchN0fATa3OHrbLC0RyXZ9/Y9+w2k18jl
 eWA89rUHAmHQZq3DF3cqCaq8fevnr/Hx8wNp/K5hdg==
X-Google-Smtp-Source: AGHT+IHOw046irpScqalELHoYJF83ykYK/Imby3L3dlRtcSJ/HFauAZhPgZ39QmBJCzti414YTc6XiMuzFnDj/IxBi4=
X-Received: by 2002:a19:ca1b:0:b0:500:bffa:5b85 with SMTP id
 a27-20020a19ca1b000000b00500bffa5b85mr3233420lfg.32.1695258167400; Wed, 20
 Sep 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230916082301.583248-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230916082301.583248-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:20 -0600
Message-ID: <CAPnjgZ0Xi+K5juLhzQUFE6AG54Zu1JD=AA=3ACwMvA9Sb09kAg@mail.gmail.com>
Subject: Re: [PATCH 1/4] spl: atf: Improve comments and code readability
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
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

On Sat, 16 Sept 2023 at 02:23, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Rename bl31_entry static function to avoid name clash with its first
> argument. Fix spaces misuse. Describe code accurately: load address
> is used if getting entry point address fails, and not if addresses
> differ. Remove not up-to-date comment about BL3-2 usage.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  common/spl/spl_atf.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
