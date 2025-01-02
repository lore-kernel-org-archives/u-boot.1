Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77837E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 13:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A977980196;
	Fri,  3 Jan 2025 14:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KasIvxEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641E38031D; Fri,  3 Jan 2025 00:45:48 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A901F80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 00:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so1930864566b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735861545; x=1736466345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=87+XIqk6YhI13m9mD6tL0S1ZDLdgyDoQFETmSfqfNLE=;
 b=KasIvxEQpJoRZ9sQkZDEWIPfdG+ieaPsXjdYyHkxhWfE4cKD7DAg2UTYA83uvsZZKB
 8F6XFYZjitlo9yalUvZa28p1zZCwIG+Eh3cRL8h8VSjUx2Kadfh8VwxwystLsgAdGChG
 TheBt5VVPuo84TUyQUBxrJnDabazFi32COZLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735861545; x=1736466345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87+XIqk6YhI13m9mD6tL0S1ZDLdgyDoQFETmSfqfNLE=;
 b=OO6vjlDoYfMGi7fPQhPsyZG3I3YWYoFkbVj0aTDY0yjDScH2zeuf0q1jcaNiOnludS
 /+hyxhE3tFE1DYZFZL3E2c0HjowavcYIIyEqM1u7Z9flaTdTZL98VbVboZ8o6+PhOhct
 /l1D3yqU/YFCdTYYTq+7BuJPwwwInxNOWEwDkamT+QVDBisB5gXoQvYlgRnpYW3uoK+i
 9Cbbxv1xlEER1XaBgaXIeCWSiJJueZSdyT5fLPAYZWpY7blWvfusw4BNmKNJ220kCqGG
 e5u8du0vpirCjAutvT5xUE9NKozJBVx2/CgX79MRcffUA+1Xy/ciKtb33CHgKDk7VQsg
 tbsw==
X-Gm-Message-State: AOJu0YzYvaXZmw5dtqNJfBzXaUJujVTOTOMC5azsnSNdTn7+hrLsFTRh
 4cOfwaWrrTsHsOrvE8xdQFSDOLABNOlgo9W+S6NpydAuMHqtsmQeW+198pDEh5PEmB3FCihku2Y
 /IhmqEiftBQ0SQM9cww+MlNdASR+GHd381PZX
X-Gm-Gg: ASbGnctHFoqDmp8nxKInhhg+qYDumA+BNFTrNKylgfTdglBio0jj47qiKQD+D69C3wh
 z7Sdcwo1knVJH5hImxQF+N8O9KV4Y+qirHbeBL5Ah
X-Google-Smtp-Source: AGHT+IFvYOybAX+xZWh1FsY73BWB2GWTKfY1BukGi85iM4qYGwo1QW4I0yK4g5u6c3T5RLNyUlum9ryQmrAVg4TfQOo=
X-Received: by 2002:a17:906:7943:b0:aa6:2cc5:56b7 with SMTP id
 a640c23a62f3a-aac2cf50655mr4578626866b.33.1735861545114; Thu, 02 Jan 2025
 15:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250102144451.GL3476@bill-the-cat>
In-Reply-To: <20250102144451.GL3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 12:45:36 +1300
Message-ID: <CAFLszTiSeBykLOSPGEFG6MV74KmC_e1F0PTkAfkR1DKxYstmeg@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 03 Jan 2025 14:24:13 +0100
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

On Fri, 3 Jan 2025 at 03:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 02, 2025 at 11:08:46AM +1300, Simon Glass wrote:
>
> > The current UPL spec[1] has been tidied up and improved over the last
> > year, since U-Boot's original UPL support was written.
> >
> > This series addresses various issues, with a goal of having U-Boot boot
> > EDK2.
> >
> > There is still more work to do, but this series gets to the point (on
> > QEMU) where the ACPI tables are required. Further work will be needed to
> > relocate the tables out of the QEMU firmware-filesystem.
> >
> > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
>
> Since this is on top of your fork, and not mainline, and you aren't even
> noting that in your cover letter it's probably not worth the time of
> everyone you sent this to, to look at.

It applies to -next except for the QEMU script which you rejected. I
can't do anything about that. So I think you may have the
wrong end of the stick here.

The only thing I can think of is that the UPL series depends on
Raymond's bloblist patch [1]. But I was assuming that would be applied
at some point and I didn't want to resend someone else's patch. I
don't have it in the sjg tree either yet, as I was hoping he would
write a test. In fact I would very-much like people to write tests
(and docs if needed) without needing to be asked.

Regards,
Simon

[1] https://lore.kernel.org/u-boot/CAFLszTjSGqmk8yYYbXFEaFZWFhF8uhj_rNxZz7ship1-Fb8p3Q@mail.gmail.com/
