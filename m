Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D69CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD57847C8;
	Thu, 25 Jun 2026 17:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="PfWdVCzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCC384949; Thu, 25 Jun 2026 17:55:18 +0200 (CEST)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595A984704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-30c8f2d93baso93647eec.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782402915; cv=none;
 d=google.com; s=arc-20260327;
 b=HxZu2uaYFpXQh3AKaisbwesdzLH6fxjBETE4oFmePJZ54ROsGQ77GIhWSZqHUJcN3H
 AFsuRnwtEm7YdbY8Acmpl0sBjR5S6WKJ9tNtIz4GdFE/XbU3e8SoPdqQQzQgNM7qSoIe
 I1asw6bvTTP4Swox/n4hCkFGy9dHRVlsqSOk7AO69ugRtSAXZ9X1KnskXZBlbBt8KZia
 spytKKfTGya7/byF97vnrytUjVdZV4Td1wRWOvqwL8dlmZklg5XQvIvrxUDSEZCwEvdX
 NXPsb4d7LibpTj9iXUjwTudgWycPLhTZ8mZkAnxW50zoAWTCM0nr9B9l1r7bYNsodFgN
 gI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QqxvCpGhKx8RwMNnUsN/1Mnx3KXDTwPkFwT3Uj6O95I=;
 fh=8OafM7syIYD4I3cfYAEnZ4Jif8pOP9EXMhdaii9d4Ro=;
 b=MqiaXYPyMEtiyr14dCMPxQ1d0GSibewD78iFJt45sc3d8Tv2CfAuHv2V73cLlURTRa
 eA6sdZlPsoAshsfxj4JOUPC4cO7CuzrLXhZgBa40OfdFZTZAZJ925xAosuwuPKDk7v/6
 Q4eK/NH9BYUFXrbskCRd5wep0IdGrv8RC2xcIyovL3Dlymnr8SjNrCRBcKFckTWhFIxW
 gNNVeBa9sPBbDJYOFTza5QaFf7dbqlD36UBus7U9pb3W+YPRwEmkoSlSeCxNOv+hFryT
 0Cuj1eIhwiJYRjK1d3riceMP14pHfqc7UGhlX3l8Ez00ZGE1A2mgk3+vDaQNg4HVA8/S
 pMpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782402915; x=1783007715; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqxvCpGhKx8RwMNnUsN/1Mnx3KXDTwPkFwT3Uj6O95I=;
 b=PfWdVCzgdbJ9+lT48L2DE21QF+0jiWle1UaOVsWjWbRw9lnN3JSJyEZZxEt261dqXa
 oZURp7Hs+pgsQ2gFjCLq+4qIy97o8tBJN7j2l21KsmpFDuQkWFn/HdwbclYduYhkY9aP
 fTG1a/lOJS56QQqf84f6OoHnwnm3SbhHj3/418I38aI9M938ygBA0te7Ied4qhywooJx
 6yBRtxtg+S0vgIzmhhtdyFefncKNeIdWnHYK/cgnVPFDWK+Hq17IlTOZdwCvMGZh7E59
 nne0eLbVMafSZa9cfrZ5BCWuYleAIZSurxbs28ygRd2psXy26BK+ccC8rCpMNwdyphy/
 Mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402915; x=1783007715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqxvCpGhKx8RwMNnUsN/1Mnx3KXDTwPkFwT3Uj6O95I=;
 b=nxNeRJmvR1Ea3S1W2nRhGuYE0PeCcVonNIE4D1/T6pcesdBJhQk1+3CCUxlqCL92wS
 RNhpVMqExS0EhmcXHbj27Am5sAuoaHuZjW2NjXiJ5rIGSYnloxyLVNWlGcS3PYjnxCq0
 xWP2wAHfeObgRbh609y+vFZQAX0Vbfksw5EQXy/q0G1YgF9mNeWh1pVlRpRSXYPrdG8w
 1L3QcJZkpg+gvU5wDInO0xbFiSVtTzmxCb6XuMxdAVMTEnRnplQAbQwCaapHhK+fclsI
 bx/2QV055W+NIEMbGYDpYj29iO0r7a+68Wj9VWO32/VJT5wkQqZBvCxiR0hhqBpm1NTI
 /kww==
X-Gm-Message-State: AOJu0Ywhq6MhPkfEefMoJr7wNsQ+RuWF9/clMgXBDKe7vpk3oApC1WSF
 P5rz3OOHX2uiujyqcdi0+9V3GO62sSoG73P2Fgm6eKMFBMHXgdinBv09gP1UKsF2mQ8KXS6JW4c
 xOvfaLAT+km3xpj44zq/HBCxUM5LCe5oy7B+fzoDXuQ==
X-Gm-Gg: AfdE7ckgTuuDoZwWiY+9hfHVuwMGozznlQ1k2JgaAd4nuD6WGb8u7fZp3a0vp2blqeB
 2ikN7EaUrpTJwIhIttPkRRDDSG6TmM1pTJKVMlEwLyqDpk1hN4Yp+Rz8wYnPyTW2S+EMxFke7bx
 NGj4I2PybwoVZTGP2FJB2vWttDaOzyMy+obYgSCH0TueXRQrqrEOJyBS56N9GsYm+WugFA/aT5U
 KALGN8fLZSA+ff4ypGVBgpPCT+ezx7sMUI1msQKnuMIRqmM02R5NoQSBlyKJJSRNETJy/NoYNQi
 20P2EVUpD/JvAPr0qyP2NkziU+H4Rg==
X-Received: by 2002:a05:7301:5f06:b0:30c:554f:cc2 with SMTP id
 5a478bee46e88-30c84e1fe4bmr3691511eec.12.1782402914682; Thu, 25 Jun 2026
 08:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
 <CAFLszThDsSJSUbKsG1KfNFZzWwzeWUY=XPc47C9CpBZUwEqXww@mail.gmail.com>
In-Reply-To: <CAFLszThDsSJSUbKsG1KfNFZzWwzeWUY=XPc47C9CpBZUwEqXww@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 25 Jun 2026 19:55:02 +0400
X-Gm-Features: AVVi8CfGL7oreYUm8vLlILgu2Wg6dKCXTLRidY7MmDPaRswJS6M0Bv-sg26RdoE
Message-ID: <CAKTNdwHB2GqQb8-rN_WRjrzqsx7gSccdW6eYMTfDk4jKodXYaA@mail.gmail.com>
Subject: Re: [PATCH 3/7] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Alexey,
>
> On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> > pxe_utils: extract per-entry key parsing into parse_label_keys()
> >
> > Split the body of parse_label() into a standalone parse_label_keys()
> > helper that walks key/value lines and populates a pre-existing
> > struct pxe_label. parse_label() becomes a thin wrapper that creates
> > the label, reads its name, attaches it to the menu, and delegates.
> >
> > This is a pure refactor: the new helper contains the original loop
> > verbatim, with the local variable declarations moved to its scope.
> > No call sites or behaviour change.
> >
> > A subsequent change will export this helper so callers parsing
> > formats that lack a 'label' header (notably Boot Loader Specification
> > type #2 entries) can populate a label directly from a file body
> > without duplicating the parser.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > boot/pxe_utils.c | 58 ++++++++++++++++++++++++++++++++++++-------------=
-------
> >  1 file changed, 37 insertions(+), 21 deletions(-)
>
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > A subsequent change will export this helper so callers parsing
> > formats that lack a 'label' header (notably Boot Loader Specification
> > type #2 entries) can populate a label directly from a file body
> > without duplicating the parser.
>
> This should be type #1, not type #2. The cover letter and patch 7 both
> make clear that BLS type #2 are EFI binaries (out of scope), and the
> new bootmeth parses BLS type #1 .conf entry files.

Yes, it's a typo. There's another one like this in another patch -
will fix in v2.

> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > @@ -1288,34 +1288,20 @@ static int parse_label_kernel(char **c, struct =
pxe_label *label)
> > +static int parse_label_keys(char **c, struct pxe_menu *cfg,
> > +                         struct pxe_label *label)
>
> Please can you add a kernel-doc style comment, since patch 4 promotes
> this to a public symbol. The file uses /** ... */ for the exported
> helpers added in patch 2.

Sure. The kernel-doc comment was added in the following commit
(straight to the header), but adding it here already won't hurt (apart
from a slightly larger diff).

Thanks for your review!

Best regards,
Alexey
