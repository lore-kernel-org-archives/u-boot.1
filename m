Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B2FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2D787206;
	Tue, 14 Nov 2023 13:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNEEOKDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCC987215; Tue, 14 Nov 2023 13:11:07 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BA886758
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1f0f94a08a0so3491024fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699963864; x=1700568664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bZYc/hUx3kQB62GTpMhjEFyJnf9SnwwAA0pTqbu5GD0=;
 b=TNEEOKDWCLnb9u4BLq+QBbkZbJgVRqcBW2c2oTRQD30JPkfVMPTqZn9egIblSootig
 z+QARpriGQEcV0pjqD4fqDGjyqVLCRokZjON6TEtPR7YBprjwGoxufgA74si+U5RrMbX
 ZBQkL7RX2wnurl3FTbUKVm/Vi97NOyLzRlmv1hgC93KA/xQozw5Z7tEBKlhAjwcFZ7B6
 POR1MKKbrvlE03L9azMXJtZ+8M8SrCSICBML2lUC1AZS21unhK5ycUNCaqjkmDhTuGwh
 eEwUuqxTPs0vHZWRtxwHQFlA5BKKG3kxeD2z57CnjffHStmE7UDM8YLFsJe4CZUFdbO8
 hzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699963864; x=1700568664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZYc/hUx3kQB62GTpMhjEFyJnf9SnwwAA0pTqbu5GD0=;
 b=A1YCv4lCjeYBZn+Ur+D/Qe9yaUAhMBPKRKdFq86+J00NUlk814XweZwdqoCS6dS0NP
 1INJ25nhwHT6SbyvcJvWlI6Y5oHckvIBPY0yU1ikF8QF9Bcl9DF1ZvrygaVEji24+wzQ
 uUC2rdnvRoxcKm3uwb76V5sQykEHIo4slofB9FlupvellvD/HuTIxpcjpgFab5CwRJAk
 tSHSEI19mw1JvydjGB542sy+ukO3Xdljva5o0N1CznDUl7PnSSroY7gIj9FbMALPNEaZ
 R+PMU3ddK1WjYSVAKsprbrQ8lD+CROVWVeZwVrU6NjFA5gTvrIQeI1KCR7/y7IHuwABH
 TYJg==
X-Gm-Message-State: AOJu0YwwT4pYyqcBgh8bAM1nnGK5gr2IN3CDb+l7vho+ZNeUeziKKP+/
 IxmFvFxryt337hqFl9+n0IaiyH0Oo/diMFWJP5E=
X-Google-Smtp-Source: AGHT+IF0VVLVt7IglUTVjeQ2rIq4Fr2sPNGXTIai794D7lktAhMfmCTicr1mLvH2If8PzqWFElg6Tx84iqA51xTLzUQ=
X-Received: by 2002:a05:6871:750e:b0:1f0:b5f:8898 with SMTP id
 ny14-20020a056871750e00b001f00b5f8898mr12725992oac.55.1699963863787; Tue, 14
 Nov 2023 04:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20231023082117.39290-1-christian.gmeiner@gmail.com>
 <464e8700-c75e-4456-bb33-71873673b83a@denx.de>
In-Reply-To: <464e8700-c75e-4456-bb33-71873673b83a@denx.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 14 Nov 2023 13:10:52 +0100
Message-ID: <CAH9NwWeSGa23qa6HLVBG_jaTPLjmxKVAZH188vhF8WAo0E_FdA@mail.gmail.com>
Subject: Re: [PATCH] led: Do not overwrite label
To: Marek Vasut <marex@denx.de>
Cc: open list <u-boot@lists.denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

ping

Am Mo., 23. Okt. 2023 um 10:26 Uhr schrieb Marek Vasut <marex@denx.de>:
>
> On 10/23/23 10:21, Christian Gmeiner wrote:
> > label might have been set by a non device-tree based U-Boot driver already.
> >
> > In my concrete case there is a PCI driver that uses device_bind_driver(..)
> > for different class types. The UCLASS_LED specific driver sets label
> > in its bind function.
> >
> > Without this change the LEDs exposed by the PCI device are not available.
> >
> > Fixes: 83c63f0d11 ("led: Move OF "label" property parsing to core")
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >   drivers/led/led-uclass.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> > index 68ca3c2970..aebdfdeb95 100644
> > --- a/drivers/led/led-uclass.c
> > +++ b/drivers/led/led-uclass.c
> > @@ -71,9 +71,10 @@ static int led_post_bind(struct udevice *dev)
> >       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> >       const char *default_state;
> >
> > -     uc_plat->label = dev_read_string(dev, "label");
> >       if (!uc_plat->label)
> > -             uc_plat->label = ofnode_get_name(dev_ofnode(dev));
> > +             uc_plat->label = dev_read_string(dev, "label");
> > +             if (!uc_plat->label)
> > +                     uc_plat->label = ofnode_get_name(dev_ofnode(dev));
> >
> >       uc_plat->default_state = LEDST_COUNT;
>
> +CC Rasmus, you really do want to review this one.
>
> There is existing and more extensive series from Rasmus addressing the
> same issue.



-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
