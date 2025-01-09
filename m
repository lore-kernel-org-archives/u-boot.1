Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1D5E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 14:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F60805E9;
	Thu,  9 Jan 2025 15:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+8Vwdbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954598005B; Thu,  9 Jan 2025 13:37:31 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2048060C
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaec111762bso183099766b.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426247; x=1737031047; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3UTtvqNViXi2S9HsBZONx8b/E23cV3JmwrIscwtK76I=;
 b=K+8VwdbuqJA6a1xs8i3ZlPZlvONdLAecZHrG750smD7V3M95lVSPWRAuHn6sJsCx/S
 51rU0l55N9NyYlN49Kk/zylaEcUTQL15FOLxNmMJcBW2t2kdfFx2TBVPzjsF+3A/kZFe
 fs5TCUfar9x/WOwdTy8NdWVAKsqmU6RGxIwlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426247; x=1737031047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3UTtvqNViXi2S9HsBZONx8b/E23cV3JmwrIscwtK76I=;
 b=nNkx1F52kGD73gWo4nNCFSwvPxobYDEQKj9ARRWmSmglTQ06gBeaZnDRZqzHaeY+2J
 UgWXrP5t8nAiFpWA86ZZQ10k5IbFpxcK//Z/xLpMrrNy/CaQSGqDHJaJL6JbfUUwmck5
 2oreb352JmMh2hOEVcku0hBljKcTEA70a2mtTOPWOVuF/4/IJOLpzuo2HqrALrJFCBUB
 Q2X9ohctZLijf70INF8c7FiD5ySc3ejRoYk4w2UU2QUGDSik5gxYdRideVPDCoQB3XY0
 mAessQ9mAkF06oHeUtjv+KyGtlSq6vutxkICMBwgdVSxrahu6xlJF6lTW0DZlotQGVbl
 LsQA==
X-Gm-Message-State: AOJu0Ywfxf473KWk0MJbv34wmZT0S8v2nlEMgfPrRub1tzThG+0oiDCp
 PuDZv7Zg6/SAIa+DF1wepX/RAEZWoEkdbm7G99kaQgp4Ao8Q2P0DvXfN1K+Ttrt6lkRvZS4Eqd4
 xoeumYzwCYsVrCV5WguUf6FfqD+WpsImBA8KE
X-Gm-Gg: ASbGnct4HfWWOLqPGkFGOsFFh8QQDRGbihei7wp2hhZs5nOBKpH367QqrL213CEcBp6
 rVHvM9XCNITpqmQQxNQHQ7nlMrZj0AwmTrerfMOM=
X-Google-Smtp-Source: AGHT+IH5TZFW5j5CERaYEhdWXmopkINQy1w5vWginLFWbunvLRZ4rRZEraZZnFz+XAIhqDK9DSTRENmRL4ipHQLhOzU=
X-Received: by 2002:a17:907:2cc5:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab2abdbfa0bmr588221666b.50.1736426246837; Thu, 09 Jan 2025
 04:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250108183724.GP3476@bill-the-cat>
In-Reply-To: <20250108183724.GP3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:37:15 -0700
X-Gm-Features: AbW1kvYZhNp8Ls3c-C0cN-cskQH_0XCA9Jva0AvhI3Z1XZEW8gCaxHO79WsODUY
Message-ID: <CAFLszTgfhDOZhDFNatDC-2NMdK4jsuJWJ7nh0rPMJcE99EKwgQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] upl: Prerequite patches for updated spec
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Levi Yun <yeoreum.yun@arm.com>, 
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 09 Jan 2025 15:10:50 +0100
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

On Wed, 8 Jan 2025 at 11:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 06, 2025 at 07:31:56AM -0700, Simon Glass wrote:
>
> > The current UPL spec[1] has been tidied up and improved over the last
> > year, since U-Boot's original UPL support was written.
> >
> > This series includes some prerequisite patches needed for the real UPL
> > patches. It is split from [2]
> >
> > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> > [2] https://patchwork.ozlabs.org/project/uboot/list/?series=438574&state=*
> >
> > Changes in v2:
> > - Fix 'Emable' typo
> > - Enable the command in cmd/Kconfig instead
> > - Fix unbalanced {}
> > - Add new patch to move x86 tables to use SZ macros
> > - Use 4K instead of 4KB
> > - Add new patch to enable bloblist on x86
> > - Split this into its own function
> > - Split prerequisite patches into their own series
> >
> > Raymond Mao (1):
> >   bloblist: add api to get blob with size
> >
> > Simon Glass (32):
> >   bloblist: Drop BSD license
> >   bloblist: Make BLOBLIST_ALLOC the default
> >   abuf: Provide a way to get the buffer address
> >   abuf: Allow use in host tools
> >   abuf: Provide a constant buffer
> >   cpu: Provide a way to get the physical-address size
> >   serial: Support info() method in ns16550 xPL with UPL
> >   mkimage: Update map_to_sysmem() to match its prototype
> >   x86: Enable meminfo command
> >   x86: Show the timestamp counter with bdinfo
> >   ofnode: Use 4K for a default tree-size
> >   ofnode: Indicate when out of space in a few places
> >   ofnode: Update of_add_subnode() to indicate name is alloced
> >   boot: Rename fit_image_get_data()
> >   boot: Rename fit_image_get_data_and_size()
> >   boot: Update fit_image_get_emb_data to use abuf
> >   boot: Use fit_image_get_data() to get data
> >   boot: Update fit_image_get_data() to use abuf
> >   test: Fix inpected typo in upl test
> >   emulation: fdt: Relax condition for OF_HAS_PRIOR_STAGE
> >   emulation: Use bloblist to hold tables
> >   x86: Create more space for SPL with qemu-x86_64
> >   pci: video: Set up the pixel-format field
> >   x86: Show an error if video fails
> >   x86: Support jumping to a UPL image
> >   x86: Enable UPL handoff for SPL
> >   x86: Move tables to use SZ macros
> >   x86: Align the SMBIOS table to a 4K boundary
> >   x86: emulation: Enable bloblist
> >   dm: core: Clarify behaviour of ofnode_name_eq()
> >   dm: core: Provide ofnode_name_eq_unit() to accept a unit address
> >   dm: core: Provide ofnode_find_subnode_unit()
>
> Setting aside the bloblist parts of this. The x86 parts (and pci: video)
> are likely fine. I've commented about abuf now. I'm not keen, but I'm
> not nak'ing all of the rename stuff. All of the dm stuff is still you,
> and it doesn't look like there's anything behavior changing there, so
> that's fine. The rest of the QEMU related stuff needs a think.

OK, will wait to hear.

Regards,
Simon
