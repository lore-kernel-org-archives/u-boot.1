Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82369C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 16:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52CA870F2;
	Tue, 21 Nov 2023 17:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XT1ZcPIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40FF870F2; Tue, 21 Nov 2023 17:20:59 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFF2875A8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 17:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a02ba1f500fso92589366b.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700583656; x=1701188456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RXR43D1DTu8SL6nKwCTpW7/tnVidYqO1kN7a18JyImc=;
 b=XT1ZcPIEIbRpGHsYev4Gg0GvOsRzT8nX0aKitfzZR8/neJf8pymoErvN2PX5KQPzVL
 WTb6oHGtd0YG0VCkIafVf7iF4rq9jqqfvoGeshaJ4No3HLYIDfjI/bUq8Hlbtus0bPl3
 r07HQANY1rp/ULOc9BsFxoKS1N73RYYYX20UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700583656; x=1701188456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXR43D1DTu8SL6nKwCTpW7/tnVidYqO1kN7a18JyImc=;
 b=JMgMjgB0HsG6Hfs0IaSta1YWtXWSGLy5vnTiMqWzm4/IOsQ/c/GPOL1pnqpSrps6SS
 +t2lvzqczN5JlrTLcPlmyHToOExFUJZWtsi62ZZWw7MB5OxsDo6kuKx4S3n9vI2/Z4jQ
 gEjDLQhNmbLTZnBNsD0Xk1rCymx2HKbJdQSyGBbRgBa1984m2jLK31nb5ht67ZqP0nlE
 QJRs8cl0jQO1AWQv9uZdBmnfcpvLElVnivv/9CfZ12a4h4dKwYm809smHJFMjndKhpnJ
 lnkfjskzg+lMr8FOI0/hX4o0rU1fJdbKXND4XndX4ApG9W+u3SxD0gqF2dpDCTBk3HR5
 4TPA==
X-Gm-Message-State: AOJu0Yyj/h6AKGapmHycCoqngLvuo2tdvFyouQyigfsycxnHnSQ19YgK
 eDIJ2PQICKwxzdGtzOkhBvTpqpFkhbQO8E1toJmtyYJK5G9XjIiTdMA=
X-Google-Smtp-Source: AGHT+IFMAVu0d0iOZk1htbdQcXGZ3tVlrS6Wofvvbf9oklFU6Me2UJltsEKssfnbncBWUYQchZm3Wt3nP9ywhleto74=
X-Received: by 2002:a17:906:1c51:b0:a00:772c:c879 with SMTP id
 l17-20020a1709061c5100b00a00772cc879mr3268807ejg.38.1700583655414; Tue, 21
 Nov 2023 08:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20231121020932.733405-1-sjg@chromium.org>
 <20231121020932.733405-2-sjg@chromium.org>
 <20231121130630.GM2513409@bill-the-cat>
In-Reply-To: <20231121130630.GM2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 09:20:39 -0700
Message-ID: <CAPnjgZ02NZp6fcx+o=HJ0maGxSJQTkSzAoEtSCdgP4oqHdy3KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Harald Seiler <hws@denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>, 
 Troy Kisky <troykiskyboundary@gmail.com>
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

On Tue, 21 Nov 2023 at 06:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 20, 2023 at 07:09:25PM -0700, Simon Glass wrote:
>
> > The cyclic subsystem is currently enabled either in all build phases
> > or none. For tools this should not be enabled, but since lib/shc256.c
> > and other files include watchdog.h in the host build, we must make
> > sure that it is not enabled there.
> >
> > Add an SPL symbol so that there is more control of this.
> >
> > Add an include into cyclic.h so that tools can include this file.
> >
> > Also add the kconfig.h header so that CONFIG_IS_ENABLED() works. We
> > could avoid this for now by moving the location of the watchdog.h
> > inclusion to outside the USE_HOSTCC area. But at some point the #ifdefs
> > from these files will likely be removed, so there is no benefit in
> > going that way.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > --- a/include/cyclic.h
> > +++ b/include/cyclic.h
> > @@ -11,6 +11,7 @@
> >  #ifndef __cyclic_h
> >  #define __cyclic_h
> >
> > +#include <linux/kconfig.h>
> >  #include <linux/list.h>
> >  #include <asm/types.h>
>
> As I said, we just need to fix lib/sha*.c so NAK. The only thing that
> stopped me from posting that patch last night was that I went and
> removed <common.h> from everything in lib/ as a follow-up and that's
> taken a few more iterations.
>

Yes I had the same thought the first time and mentioned it
specifically in this version.

If you are a doing a clean-up, perhaps you could drop the #idefs in
the sha files?

Regards,
Simon
