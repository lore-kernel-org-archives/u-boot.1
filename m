Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3F8CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 00:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C90083631;
	Thu, 25 Sep 2025 02:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g3MPvZAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62058365C; Thu, 25 Sep 2025 02:35:09 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A221D835CB
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 02:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b30ead58e0cso69197766b.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758760506; x=1759365306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zi69wogX+gt625jx+aJgyTF6tFUahwLZopfg7JBKM/g=;
 b=g3MPvZAyr//h57P+Rx2ya2QkE+W1TZtPSDrTaUbaN710kYgRbbGJ4fb6oVI727FuYM
 ay5UndB19E6j16JVRoeZYjkHb5XVpopVGeZwDP/0qKT+KALFd7BSBhRH6U9okQcwUJcr
 AG2btGu09NtnVKkFB2AY8cS2r0ye56x5YXNjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758760506; x=1759365306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zi69wogX+gt625jx+aJgyTF6tFUahwLZopfg7JBKM/g=;
 b=c5STKWEfUHW06+j1won28XeBqtgLG0McSqpJdiXstRV8Q0rGZEeclGbh1/OOLdQZFq
 /wuWH221iG0+YIjc/1dTqZhLrcrpDJx2GIsxMCOHYk5iCHojz/IZX02UHPjdKj4Tm2BV
 qiC4DJm6N8F8kou/5FvOi9c5Q6aIBPr99nAiqx1toOUGBwnGbyAQsOE2mGmu+80a7bCX
 R4Fp7L22zuNHm2EpzpR4xZT+epyhstARAG7BN5zzZi+MKyNS5I/alVDDSR/J52YiI3xw
 PxGlB6udpY7Wxq9Ahk87rfXHZFG/uvO3dzfLpNqzoLlcHdoRiauGT/MUMbeCAsPfkttz
 sVlQ==
X-Gm-Message-State: AOJu0YxHABW3pv0EeRsnPHfuRDk94g57adEqogDlRvDG/T9f41AGYYYQ
 Xz1PDg+fZGdUQkzj58eiNuGtm/y1cKDgMETI3w2nkn7VpS1ihFCkH7AIxHSctSkxLjWT+RaMMX7
 tfSxk0O+empykRWqHke+Jt8M6vmjHXZd7pikvkW57
X-Gm-Gg: ASbGnct0oIJZ01FXTTPLOcEd6eNKXIn7beVKAHbK1+MT7tq/1fwpAMwtFf0soCxw8tn
 xtgc6GIl2xMw3hNVC8GMRJBX+8UO3mFLrb1/gfjRK5YZWme+i2hEM0XZuk3YKeI5YuNssOuXq7P
 0mvFvkJgOFfd0Omb7qYAiHy8S7dE1T3x2kpMUOrLBJMKrJLd2g52JEL9SaiIWVbU0VPEEoJItHt
 m0J4PvB
X-Google-Smtp-Source: AGHT+IG71ILIkN2OVNH1nyMJEgrrBBJp6wBEsMIitoRMr5flTmZDKxjLUPM6mlIU44zpM2uAcRxGbNgOBhHXSse+Gzg=
X-Received: by 2002:a17:907:3f0f:b0:b2f:d237:80d7 with SMTP id
 a640c23a62f3a-b34ba93ca96mr157069266b.37.1758760506010; Wed, 24 Sep 2025
 17:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
 <20250924163413.GJ197373@bill-the-cat>
In-Reply-To: <20250924163413.GJ197373@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Sep 2025 18:34:53 -0600
X-Gm-Features: AS18NWD_vlS6aVuDt3B_4n7MjzGDM55B6o_QuhZEDLARAX72jmN7yn-lTcnYlyc
Message-ID: <CAFLszTh7so42FH2pms7dqzXFSz0vbOcab-GRmFCOaqLe2DL6fw@mail.gmail.com>
Subject: Re: Bootstd for sunxi
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Wed, 24 Sept 2025 at 10:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 24, 2025 at 10:28:45AM -0600, Simon Glass wrote:
>
> > Hi,
> >
> > After the discussion on the call this week and Andre's suggestion of
> > putting FEL as the first global boothmeth, I took a look this morning.
> >
> > I created a new v7 series without the 'efi_loader: bootstd: Drop
> > bootmgr for sunxi' patch.
> >
> > It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
> > enough. The FEL boothmeth is first, which is good. But Heinrich did a
> > series to reorder bootmgr which hasn't landed and specifically I had
> > concerns about this patch[1].
> >
> > Given that Heinrich can't make the calls, I'll talk it through with
> > him separately and reply on this thread. For now I don't see much
> > benefit in sending the new v7 series, but I can if desired.
>
> The biggest blocking part of the sunxi series became that it showcased
> the more generic problem with integration of EFI and standard boot [2]
> so yes, getting that resolved first is the next big blocker for trying
> to migrate more platforms. It was unclear to me then, and still unclear
> to me now what the value is in exposing more platforms to what I believe
> ends up being a less than optimal experience is compared with what they
> experience today.

I'm not sure about the less-than-optimal, but I suspect this is the
bootmgr kicking in and checking the network. Heinrich has something
for that and I'll talk to him in a day or two.

>
> But since no one can actually test things out and see what is or is not
> different with the switch, yes, you should post v7.

OK, done! Something wrong with CI, but not sure what.

Regards,
Simon

>
> [2]: https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/#3418689
>
> --
> Tom
