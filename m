Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38512C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D73A839A7;
	Wed, 28 May 2025 14:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZfcqCY4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48BB83956; Wed, 28 May 2025 14:40:51 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA038394E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-604b9c53f6fso6053920a12.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748436049; x=1749040849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MnsiBb+uPB/z2PPaBIm/YZcH3FDW6TID3e4f4+t6484=;
 b=ZfcqCY4Fml6+KsGxNAReEFpQk2KM5V/+pqfEz4/yfzGlJfB1b6mew1mbfzyZeU6soE
 D8G4GoD1fxFjJM8iQ9wY0VO9UIcSqLaaWYBZHmTlEn1rSefPI95MyAC25R5g+hHrc7ZD
 D0oFN0m1yORqj5ylhty7SgX+dmNiAOTlcM/7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748436049; x=1749040849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnsiBb+uPB/z2PPaBIm/YZcH3FDW6TID3e4f4+t6484=;
 b=e16ptZCqVjq7HB4l2ZlD3TSq4ky9PmTqpnoIBF9phg5gK+ZzhCV1zdIkgsCAn4Dddg
 UD9NkZTelRkkrpHuHrhsXGx4Bba4Y1uhu95tjBFl+qPW7Sv7N2B5f+55Mqcj79j0tMvf
 GzA6d+/4uDcG4Zv+B61Zhl1+1nmfgsRR9PRmD9cbUaCZajezV4btH1lTe48NAvDsHgqo
 2y4j+NzEVWxD0rmWjyDDKjrdMpsradC84bIF7DNPX2ZyigRiChtkEFSTw6ZeFn3y4uy8
 I+Jd9NngG9H12xN0Q3Hc5Ebbd6ykTMxsSm9m9VBMICpAlIdkndFFtrq2dzCOd/zAgh3Q
 W65A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX02dRB1nc2uGZ4NFaqhz/dS64mnb2GxfQW9neHdSKyMNx8/4C034JlDTXqJjfIlmrQtLaQjmg=@lists.denx.de
X-Gm-Message-State: AOJu0YxX4r92ldD6Bp19q3T6Flu6PjPx0W7mR+q9OPX1fh2gfh4zFNic
 /ay3soAcg67eFvL56jL1h5SOljHMuq3hglGY5MXcrSlCRGDK8fThLJDPkv9Co6/RbFYOUkWqola
 +bn7F+7yG9l2mAFj4aCkkEb8EnuOWDFCC1y0VABJd
X-Gm-Gg: ASbGnct583SvZj41JhbD+V0SJ2Kp5dIyU2dSz7NQ0frgXIq60mK4/RygTu+12DPmYzb
 DKEIsNduphig/zubB3vFpaHmraTGWx3OycjuPBFPZw+NZk/NfFxQKvrHTeLAzwNYSOzdm5LhVkX
 ECMIN9RVMhmP4+vL+AmjvadhLEkuy6GuRulIIsdZQCsA==
X-Google-Smtp-Source: AGHT+IGfUfTSm4Sd3vaVsmyHlxv/cTvOoVQFQ7KxiMkJZtmsFmy6s5a65scRQHc1/rHVf37Gf8lypIYjp+p4IpIBP0w=
X-Received: by 2002:a05:6402:909:b0:600:5a9e:2b52 with SMTP id
 4fb4d7f45d1cf-602da1f0d2amr12375242a12.8.1748436048812; Wed, 28 May 2025
 05:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523140613.GQ100073@bill-the-cat>
 <b8c81f80-a32b-4935-b2f6-edb361822b6f@linaro.org>
In-Reply-To: <b8c81f80-a32b-4935-b2f6-edb361822b6f@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 13:40:36 +0100
X-Gm-Features: AX0GCFuWNG_ymL9OhpcotVHvLoshCxbC0hgWLFefzTdUnl18SnNFzJ0eKxmqYsU
Message-ID: <CAFLszThaeVF_6ewTqupDH-CvpZAvXr=6XxkUzv2UbaX9+z6Hvg@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 May 2025 14:46:33 +0200
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

Hi Casey,

On Wed, 28 May 2025 at 12:03, Casey Connolly <casey.connolly@linaro.org> wrote:
>
>
>
> On 5/23/25 16:06, Tom Rini wrote:
> > On Fri, May 23, 2025 at 02:06:35PM +0100, Simon Glass wrote:
> >
> >> Some functions provided in lib/efi_loader are actually useful for the
> >> app as well. This series refactors the Kconfig and directories a little
> >> so that code is easier to share.
> >>
> >> As a starting point, it moves some filename and device-path functions to
> >> the new directory.
> >>
> >> The next step would be to move device-path code over, but this will need
> >> some discussion.
> > [snip]
> >> base-commit: 3599a58a5114224a01557d18371036a5823233cc
> >> branch: app
> >
> > Please base this on mainline, next branch before asking for review.
>
> Seconding this, for the second (third?) time: please don't send me
> patches that don't apply to mainline U-Boot. This especially sucks since
> I want to see EFISTUB upstream>

OK, I have adjusted my system so you won't see future patches. I must
have missed your previous two requests, sorry.

Regards,
Simon
