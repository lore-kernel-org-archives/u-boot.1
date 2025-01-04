Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6BE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 20:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D9D8043F;
	Sat,  4 Jan 2025 21:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uv7h5oPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0020A80584; Sat,  4 Jan 2025 20:32:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8931B8043F
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aabfb33aff8so2342693466b.0
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019145; x=1736623945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a8iOiAAxZzkS6uympeHkoUatgECT2x1JPTLjbcU7xjs=;
 b=Uv7h5oPxft5yIIf6fWLqXTdKiEtFCWilXjVTVykFT8LvOo+FMstasO8iWuDlHFieyy
 +v6lO/UDcDb+aAc9kzdci/1tv4vy2QtNX71OhshHRZSY/Uv6S/3YzCcbh4vW2DwX/JM6
 xXD8KGRoZH19TVrG29R0W+XsaBtOGY6CARPJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019145; x=1736623945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8iOiAAxZzkS6uympeHkoUatgECT2x1JPTLjbcU7xjs=;
 b=lJW7K8OB1CVhUV8yC86qzKumosIdxnUHC+OToz6nRVZpBgY2fFwLfc5Fjmv7Jb82IF
 Ds/LY2BENkwEaEXlIhS8NxmrqGLN9RHM6X4N0cyjLBe0DNvYyHjzbdebdF5q5rxToiP9
 8XnoQdrlQhl9z5Oy30e61ZTnUrqw3FyymtYia8JtmrGU+u4ZuhL518cs1qvUt0yMZKj7
 eaC/2xJyNbq+isJrgfneqT4W1y13DQydk4mRY3LSwBt9qItKxBb6C+2LKoVRDpjPN8TS
 1e+hH8dMiN4xG6vWxNyB5TX15cd6dwovzBqUkYlWdNVwiSrWXdXrW9tLSCCYUF0tQygY
 OUoQ==
X-Gm-Message-State: AOJu0Ywv1vxw78QTa534u6+35lQP7B+ZBJw2Aw5G9RdrdDhdCm3Jo0x1
 6Brj0XLfAje0zti2+3xDVW7JS8KIq+t21AE11sJ5+FpUwW18pHGcRthYvJyJQkcveRpU6Maqmvy
 R7/C4EeYRoUpOKCLM7ufHrDCwLgMBs51BP1RLhOM1BayrtrQ=
X-Gm-Gg: ASbGncvoJE+seyQoH74YPjXBbMCIX+J5KwYDYxhQtjyP/HwMPhWRsHqwknQanGNRqzY
 j3dpdI/QqaVxknM7hNcCvA5HngfYIBzw8xq4OMrJ8
X-Google-Smtp-Source: AGHT+IGgIJG6Iz0Fwc31xjkQpI5KfPXXhLOg1Z4zJQUx9ySh7DJaN6EtCBtXJ8Alrr/L11maDVlPkJl26BhpWCOCg7c=
X-Received: by 2002:a17:907:3da4:b0:aa6:89b9:e9bd with SMTP id
 a640c23a62f3a-aac346970e7mr4351741766b.24.1736019144916; Sat, 04 Jan 2025
 11:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250102144451.GL3476@bill-the-cat>
 <CAFLszTiSeBykLOSPGEFG6MV74KmC_e1F0PTkAfkR1DKxYstmeg@mail.gmail.com>
 <20250103142651.GU3476@bill-the-cat>
In-Reply-To: <20250103142651.GU3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:32:17 +1300
Message-ID: <CAFLszThoCAfm1TizsQFCcpoJEu7Gqxt5E9MfQm7EXDDbZ1VW3A@mail.gmail.com>
Subject: Re: [PATCH 00/67] upl: Align with the updated spec
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, 
 Dmitry Gerasimov <di.gerasimov@gmail.com>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Janne Grunau <j@jannau.net>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 04 Jan 2025 21:04:51 +0100
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

On Sat, 4 Jan 2025 at 03:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 03, 2025 at 12:45:36PM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 3 Jan 2025 at 03:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 02, 2025 at 11:08:46AM +1300, Simon Glass wrote:
> > >
> > > > The current UPL spec[1] has been tidied up and improved over the last
> > > > year, since U-Boot's original UPL support was written.
> > > >
> > > > This series addresses various issues, with a goal of having U-Boot boot
> > > > EDK2.
> > > >
> > > > There is still more work to do, but this series gets to the point (on
> > > > QEMU) where the ACPI tables are required. Further work will be needed to
> > > > relocate the tables out of the QEMU firmware-filesystem.
> > > >
> > > > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> > >
> > > Since this is on top of your fork, and not mainline, and you aren't even
> > > noting that in your cover letter it's probably not worth the time of
> > > everyone you sent this to, to look at.
> >
> > It applies to -next except for the QEMU script which you rejected. I
> > can't do anything about that. So I think you may have the
> > wrong end of the stick here.
> >
> > The only thing I can think of is that the UPL series depends on
> > Raymond's bloblist patch [1]. But I was assuming that would be applied
> > at some point and I didn't want to resend someone else's patch. I
> > don't have it in the sjg tree either yet, as I was hoping he would
> > write a test. In fact I would very-much like people to write tests
> > (and docs if needed) without needing to be asked.
> >
> > Regards,
> > Simon
> >
> > [1] https://lore.kernel.org/u-boot/CAFLszTjSGqmk8yYYbXFEaFZWFhF8uhj_rNxZz7ship1-Fb8p3Q@mail.gmail.com/
>
> A 60 part series that includes changes to something that was rejected,
> and depends on a series from someone else that was changes requested,
> and is again, 60+ patches, is not at all helpful. Please stop doing
> this.

As I see it, my only alternatives were to:

a) resend Raymond's patch unchanged (with a note that it is merely for
convenience), or
b) not send it, knowing that his patch will likely be applied before this series

I chose b. The single, dependent patch is really not an issue, IMO.

I often send large series, e.g. [2]. Sometimes, as with UPL, there is
just an enormous amount of work to get through. I really don't like
combining patches just to reduce the patch count. But I can split of
the pre-req patches (about 30) so I'll do that for v2. Honestly, I was
just desperate to get some of the work sent out so it didn't die on
the vine.

BTW, please reconsider your objections to the qemu script. I think it
might make sense to convert it to Python at some point, but the
complexity of building images and running QEMU for different use cases
is such that a script makes a lot of sense.

Regards,
Simon

[2] https://patchwork.ozlabs.org/project/uboot/list/?series=364775&state=*
