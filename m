Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A25606A331
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iyvWI+US;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NvgPg+A+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF9F740743;
	Thu,  5 Nov 2026 11:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATlg64T7Em_i; Thu,  5 Nov 2026 11:40:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DABE4084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793878841;
	b=bm22zuQ04g/IwAr4mfGGr9UlKLVq/y7yCVliCbxd4AVs5/xaqfQPCKjXVIxM4xmx2XMF
	 n9QqEj4j8zfohR2W+w0Qkkf2AHhBzZw/fDap5FZJ9zAR2+9fBflUKDkh1Ro25cSrbQGVh
	 r1VALzDMsN1HbkCy1m7o0v2PTwLidRH6i9ghpl1p1db9VnDzhHprV1NEmpeqtad3CWZcc
	 ukTi9FpwgC/Ld9gWFjduwbHKeJWNuaTCOEEnTznAz+Z7iZhg32Y4tYHGAD+ueAc0/GOaU
	 XLTl1X4Vdnn9W4dVpazTPRF4DPGX2yy8WOSB8knrFVZj8XfLl58+FJPK1wOWFHKcs1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793878841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sAeK9BGzL8NjFo59CG3xeibU1FbrSyfbrFTmd0T9/6U=;
	b=Gbrs0DCNXdOhdPfXzNLI/RwDIUTKovhf9xDMUX+2ZgHrxGMOugDWkbAVUr2yh/3oLVDb
	 mFOMA/k5bGox5Lt+TdH8r/kscTjm69g7DXxTNY56nVt/z/twMYx5xl+1eDFixyOWuVgIm
	 eGsvozm6fjSMLEOXDwL7NFZah6uMFEWs3jFYfoVAhebKaaIdRVFytE7gIjldMRzyYsz92
	 WqO9c4EL1WHf7MS4XKTmp2bi2NBxmzZaACLytfFNCacYzMhXO4prQaRy7kvzJ4BFSZFJB
	 ESOgH57AQtl7RUmkRpX/Quhb8O91E1L9P0pcOg1BbWtO04pP170O1OYMglVbFSSbflw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793878841;
	bh=sAeK9BGzL8NjFo59CG3xeibU1FbrSyfbrFTmd0T9/6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iyvWI+USX5EjaM9jRq8OFFAfLifoAZ2ff31lP9ZDK2mjIXVYfl3OjhDFdunLdnV7/
	 QeKq0bfhEfwO9QgS6QG7UdqL9LqwSslYLBOp/XgJppKy+8vzqpIuMS701L9TSUm6aR
	 urZ3ZwhaOUiVFU9491kIo9DxQhgkNxVRnPRzx/bLz9jfm1nxz2jwsvkz3eXXhnA1my
	 rwLtyA/IKhLOS+rEzEuemErmIE0yET9S2pKLOjBmu2KfvP0TUkyPZWV427WaRa8Hnx
	 C0TNXiQhCrCL8wm4sHdiVbxfB18AJNe/y8KoOgweUQ1/8CczWi4PeHUwdISLo0nIJl
	 EmJih/3MiULPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DABE4084B;
	Thu,  5 Nov 2026 11:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F532AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51C3B81135
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EiW38TsS4Kjm for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 11:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3549180F75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NvgPg+A+
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3549180F75
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:40:36 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677bc4704cbso2123869d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 03:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793878836; x=1794483636;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sAeK9BGzL8NjFo59CG3xeibU1FbrSyfbrFTmd0T9/6U=;
 b=NvgPg+A+LGdfKs3A1M9Li1+uzTvJtHmp0jcFQ/GwO9DtDWP6yXMuWOZ748/eAiSuV4
 vkoTDI+r43Jpgq6NgGAtEO2zsmgnQOpmgr8f+yzLZedpgesSBV2WxgkDgfpsht676cjQ
 Z3p8svSaGkUkIpX+LYGIXkMbTCaMBtDoi9GdBxpH6zUm8EvaSg9omn+4ws8RPN5dw4KN
 GIotfr/ZilTYE+kt2BXe3GWU9kULhQzmjDIIiICjZZ8+4EEo32GiYkMbmK8NJhqZM8bA
 4304i1fO+Hb9yeAy+zA23osn3cq7sAV6M8A5DAIDYoJQ5pyB83EIR4DWQvMRD2usEwui
 Me4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793878836; x=1794483636;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sAeK9BGzL8NjFo59CG3xeibU1FbrSyfbrFTmd0T9/6U=;
 b=VgwTlaBl1VaCjiymTOkxQfTU5cnPqFqzubgQcHuWbWAFEaIooF3Iz/5mh3pwvIp5iD
 N3GnSt5iuH3phHVH/hFz7DgsUG9UryEK9yI1yvpzudqAM3FUx0mdne+VawfAVjIFCgaz
 dWsULlq6JwVKAVnBSFoPdufoUpYw4pABkt1qMKUXMGr1PeYHvl0JxvCQKZTipUufAsk2
 jFuvaR/lwc5KlbX9Kj0174Yc9uM4H5Vsp72rFZxHt1tNghbO50IwTEs5141PyfMPL42/
 O07Ga/1Qz6aL8GhKbPQdClsPehI9fwH/JIYbrzburJ0XeVC/0YLnFzXCpaC8i4kwlZbN
 BBZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe8j2NEeK3+UfnHuWUac2bQb+KFeo7SfjoNYv700elkFQ1j0SKrykWpEwGeRG/BDUpXEzGRV0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/MR/N3gpVZKnuAGw49w77eiQjRDUS8YjNyyhECUWZlIp9V4lvV
 eNoMWvIYGcOaKoF9XuU2suAbHdmef1dn/BUra7sXddhbtfhiJjM1iVaAyIiiF3Kx/+BQp8VWW3n
 nnSQDRP3oDSnLYrKr3X/TKMPNpzmTF+ZqC+M++HXuGA==
X-Gm-Gg: AYBFou1GFrdTHuKDepoZDO4L7J/9dk9lafs8OhL1UuMn3EynHo+814P9HdRYD6e+CZP
 7sYNQ4Y7MEHzIiFLtbJ2YtQBSQB02HAA9dErDmCcrvv+KloM9icgYAsEM+pR/+sA0gURsOWkM/y
 dNGM575oD8mJb3IMC4njOrRV4X/XnUv2iQMHYm5XmMTQmIsjipid6eJ6k1uT5j86/gbhID5MFvA
 L/oytmFHwFbjA+Bh4lHt4UcXzVSu32SggPHzwxYncSW1kTen1OEKEFjMGAYh59A7UWAgVsHAHB9
 XVz31I14BrlblaYToUQT6qdZ2LdQbWqvnREeF6JPbPkJH3IzN2rdSWZ+TwvSfi6dqV2qg9LLC03
 OJ9KChWgJKLSvkth6JChberHYv55ZvbEhYl1yNzunVy4W6U97WKIywxdikq6crDSalPRMAw==
X-Received: by 2002:a05:690e:168a:b0:675:4396:af23 with SMTP id
 956f58d0204a3-67badb6a949mr9425080d50.70.1793878835859; Thu, 05 Nov 2026
 03:40:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
 <20261103-imx-usb-boot-fastboot-v1-1-f3a918d55a20@baylibre.com>
 <20261104085049.GA810881@francesco-nb>
In-Reply-To: <20261104085049.GA810881@francesco-nb>
From: Daniel Drake <ddrake@baylibre.com>
Date: Thu, 5 Nov 2026 11:40:00 +0000
X-Gm-Features: AclHuK9BpiwnjV8ipESxlj_kf4FA64uvAHJK-mqvQ9C8K7oWridtCIttpLx3suI
Message-ID: <CAPGwodr9Nsy_C7oZJ+up2yktsgJbrKjXzgw94QPmOpYWKAoRbA@mail.gmail.com>
Subject: Re: [PATCH 1/4] imx: enter fastboot on USB serial download boot
To: Francesco Dolcini <francesco@dolcini.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@nabladev.com>,
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 08:51, Francesco Dolcini <francesco@dolcini.it> wrote:
> > The documented and expected behaviour is that a separate host computer
> > then uploads a U-Boot binary which then boots into fastboot mode,
> > allowing for storage devices to be flashed, usually by the 'uuu' tool.
>
> Why is this i.MX specific? We (Toradex) have exactly the same on other
> boards that does not use any NXP SoC.

[...]

> How can I opt out from it?
>
> Did you consider having a new boot command variable.
>
> if (bootcmd_usb_recovery && booting_from_usb_recover())
>         env_set(bootcmd, bootcmd_usb_recovery)
>
>
> The issue I see with this simple proposal is the USB instance number,
> but maybe this can be solved?

Good points. And thinking more, I'm wondering if it doesn't make sense
for it to be done in a generic way.

Having this enabled across all i.MX platforms is probably not correct,
some would want to opt out (or simply never have been opted in).
And while there is some similarity amongst i.MX platforms, there are
other non-i.MX boards that want this behaviour.
And as we look at making it more generic, then we quickly end up
considering: what if it's not the first USB instance.. what if it's
not usb at all.. what if it's not fastboot but some other recovery
mechanism.. what if the condition is not boot media but a GPIO or
something..

And all that leads back towards: these are board-level / product-level
details. And ultimately it's just a one line boot command we want to
drop in place.

So I'm wondering if we should just leave this as a board-level thing
as it is now, and have each board continue to do:

  if (device was booted in recovery mode)
     adjust the bootcmd appropriately;

and I'll just fix up the obvious inconsistency with the way bootcmd
gets set for the FRDM-IMX93 in front of me.

Thoughts?

Thanks
Daniel
