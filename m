Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F8BC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 10:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFDB832C8;
	Mon, 11 Aug 2025 12:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p1JJXoLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02DA832DD; Mon, 11 Aug 2025 12:28:41 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89A3832BF
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7EF503F28B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754908115;
 bh=M8SAjQ8o98Auyjrtln8TE0vVYddXxJ47hgnzEjNBGcg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=p1JJXoLcSFVuiPflwJgZVptBJciV8pl428Ph9h/TSIUoWNNVZjnH1FLHXopkD0qx1
 p9kfOzMRTWzdCojSRtZ3rYCdexBdZPtX6OVAb8s5ahiNBvqAfWRDZRMEpJ5NmR+zXR
 yi9B/GAqov4L+NDoQHcmX78tbsujjydGdAlqFXmAU1akFcOqSSwo93MP/jAfx3XkBf
 MRrRzGOQlbTuCiWO0YJq4Ca+eSrAcsonzfkRYo5uLC+z7FxBXYXxF4yZ/GKT/kCGmD
 mqwORt6cb47HpEkbb/Pt4szKoUA7++CkEBDnASpEqJqr/plXUn5qUxP7CbgQX+/8T8
 F3X+7YfO2zdtA==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3215b3229c7so4429232a91.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 03:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908114; x=1755512914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8SAjQ8o98Auyjrtln8TE0vVYddXxJ47hgnzEjNBGcg=;
 b=CzmTqgpgBSeagAS8VmsxMiMvQ0XAzdR9fLCcLa1lE3KuH5GLfBQT4UHRTwiy1RgHnA
 PP4dyedzOpXOXbsXYL492qusNFMMcf9C5Z9VBvPIg4xI6QIjP5z3Ro/Td7Dbdd00iSD+
 pSNA3ko8p1XMaLlGLFCIamHtf0uUC5ONMUQcS7TSpVSs4FRhRYEtX5e8L9BdPbLzB0FQ
 KQGEs1MmiJ4t3q73s9GVhQuHk4tGckXVmIdJh4cfj7L5JT4r1jO3+cZxSa+JkZqAsHW+
 XQk1bj/ik3wKd8sdR8P5G0JW8yWqm85iY0Cy6/9GzbCV+XMMi5Yhj/JUNYgC/tdPaiBX
 d8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgYkckB0m4kWLCn/imzcyiI6xdjFUYwf4BPZf3EIC2fdcIwNBsyGYFct37JtRoKfK45szBHS4=@lists.denx.de
X-Gm-Message-State: AOJu0YzHGbwVYc+AZ6uJPqPkXwBcl4Ljb+bpYuBNVq20sRJ2Y00B34r7
 zqiXxgLEQ+XNzc5eOAZZj63EkzMQb/ldQ7PVu32CbMlPT0GwOVaZNKz99MfS126DO19ZWB0z2vd
 KWwP0RcoWAyhHyfHybwZmmTFmjCTH4HzOQJUcV6sgcxMkY2JRE9oYV4TEbhtq9BEqz7yLHLzqvn
 01MVV3NwAuOehBIcVsRwqvqrW4WHYWY3bhrPdGgk99tg4DIw==
X-Gm-Gg: ASbGncvib3IgSWiJN8/szPzJhB/FL1LljRxVKp/IVXXsuJ0hwVpNgYny9J7aCHThI1I
 nWL+mjspLsLohrDVyKODD/k/F/vqAB/BMerMqn8R5W3U6h6BljSUn7E/O+l6j9lj1NbR7Fe61cg
 ISqBlyZbw+rqZ5+mwwzw==
X-Received: by 2002:a17:903:1746:b0:23f:adc0:8cc2 with SMTP id
 d9443c01a7336-242c2206c3fmr146962115ad.27.1754908113973; 
 Mon, 11 Aug 2025 03:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtYZtVxgj2g7UuJl4NvbJbss9nx0NX0sDW2XoI6SGTl5LtaxfkyQIVFCbTaQhoqhI7+fCK6HJ2tLy1VYDiKbg=
X-Received: by 2002:a17:903:1746:b0:23f:adc0:8cc2 with SMTP id
 d9443c01a7336-242c2206c3fmr146961795ad.27.1754908113534; Mon, 11 Aug 2025
 03:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-4-pro@denx.de>
 <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org> <aJmwfBL48AzuFra8@antares>
In-Reply-To: <aJmwfBL48AzuFra8@antares>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 11 Aug 2025 12:28:21 +0200
X-Gm-Features: Ac12FXzWuhD-57RIcKE2UHGGlRtg1elBfGaRPqzJbNKxrjWZFT5PuYep4qtCTNE
Message-ID: <CAM=mAOmnegd4HTCt5-daVsjNnb04AEx0+VEbowNU5LkB+CY4AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Image size checks: Simplify help text
To: Philip Oberfichtner <pro@denx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Philip Oberfichtner <pro@denx.de> schrieb am Mo., 11. Aug. 2025, 10:57:

> On Thu, Aug 07, 2025 at 03:41:57PM +0200, Marek Vasut wrote:
> > On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > > For coherency, use the same help text for all related size checks
> > > options. Furthermore, simplify the depends-on logic.
>

If you want to make two unrelated changes, please, create two separate
patches.

Best regards

Heinrich


> >
> > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > ---
> > >
> > > Notes:
> > >      Changes in v2: new
> > >
> > >   Kconfig | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Kconfig b/Kconfig
> > > index ec20603883b..490a706101a 100644
> > > --- a/Kconfig
> > > +++ b/Kconfig
> > > @@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
> > >     default 1048576 if RCAR_64
> > >     default 0
> > >     help
> > > -     Maximum size of the U-Boot image. When defined, the build system
> > > -     checks that the actual size does not exceed it.  This does not
> > > -     include SPL nor TPL, on platforms that use that functionality,
> they
> > > -     have separate options to restrict size.
> > > +     Specifies the maximum length of the U-Boot image.
> > > +     If this value is zero, it is ignored.
> >
> > This makes the description less accurate, sorry, NAK.
>
> What about using just the first half:
>
>         Maximum size of the U-Boot image. When defined, the build system
>         checks that the actual size does not exceed it.
>         [plus/minus treatment of the value zero]
>
> And dropping the remainder "This does not include ..."?
>
> I think the hint on the separate options would be unnecessary, if they
> are placed placed just below.
>
> Best regards,
> Philip
>
>
>
>
> --
> =====================================================================
> DENX Software Engineering GmbH,
> Managing Director: Johanna Denk, Tabea Lutz
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> =====================================================================
>
