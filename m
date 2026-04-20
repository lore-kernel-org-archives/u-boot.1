Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0083F557F5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 09:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1939A83B99;
	Mon, 20 Apr 2026 11:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="px1ivRKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497C184258; Mon, 20 Apr 2026 11:33:06 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D35839D5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 11:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1776677582; x=1776936782;
 bh=P944EK7Jgf6xkGoIkyoBqUgModDxrRn5Fpu2fSI0nt8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=px1ivRKrfZcsP9+1SNvGyYrbsSrGp50HsUd1KcbGOm/3TBrGkQsTZl90OmGTlbl+6
 ExiYxBGRlUWAg3v4mS0qwBHn67ac1g2N3T4lsPLoel+bszSRvvdBze3sin1qccs/OK
 8RO8NLm+gqJzRHD9GT9lj9RRm9H1qZCKBoFVQcFHU0rRLCc4CXUgGN8V3rhLsrtMJe
 Yf3hDshoMpKHKX5NgrJ6ZH+YiFvmhKDGF4kTscoi4f18W87UbZb9Y5hqGt+2JXM7a9
 sj1QIMlVe68LCsUPEWOmZ8DYDUJeZILKGL5eimR6ycOl3YnkGYId+NhoYA6KN3LpqB
 0fZ6UwLIv0cmg==
Date: Mon, 20 Apr 2026 09:33:00 +0000
To: Simon Glass <sjg@chromium.org>
From: Philip Molloy <philip@philipmolloy.com>
Cc: jcethrid@gmail.com, u-boot@lists.denx.de, malysagreg@gmail.com,
 trini@konsulko.com, linux@analog.com,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: Re: [RESEND v4 04/14] mach-sc5xx: Switch from tftp to wget
Message-ID: <ZvRFPTw_Edctn_6wqjb-fOsMId7IXsw7-610jpX4IF7sW-c5ZPQYP3rODdLWluzL5jgvp2Hc8HVt7R8njIiIluAhznZqOrVi6isOVMHT1-E=@philipmolloy.com>
In-Reply-To: <CAFLszTg-xE4RcK7j8e9m4ViQCoEfSJrh2SMia+A3W_8Kkoqv+g@mail.gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
 <63a35f9608c046f37f610fb0679c7217c93016f3.1776344788.git.jcethrid@gmail.com>
 <CAFLszTg-xE4RcK7j8e9m4ViQCoEfSJrh2SMia+A3W_8Kkoqv+g@mail.gmail.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: a43f14e0f0c97f865ff2d1bd640d7defe6d3ab4c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thanks so much for this and the other reviews on the series. We really appr=
eciate it!

On Monday, April 20th, 2026 at 4:51 AM, Simon Glass <sjg@chromium.org> wrot=
e:
> Hi Caleb,
>=20
> On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> > mach-sc5xx: Switch from tftp to wget
> >
> > Switch the nfsboot and other relevant commands to use
> > wget instead of tftp. This also includes the addition of
> > the httpdstp variable for selecting the wget port.
> >
> > Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
> >
> > include/env/adi/adi_boot.env | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> > diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.en=
v
> > @@ -15,6 +15,7 @@
> > +httpdstp=3D8000
>=20
> The default HTTP port is 80. The commit message does not explain why
> 8000 is chosen. Please can you add a comment explaining the rationale,
> or use port 80 if there is no specific need for a non-standard port?

Explaining it in the commit message sounds good. It allows us to run an unp=
rivileged web server.[1] 8000 is the default for `python3 -m http.server`.

[1]: https://analogdevicesinc.github.io/documentation/products/adsp/setup.h=
tml#boot-linux
