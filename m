Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB49D6B6B4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 12:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C46892AA;
	Thu, 31 Oct 2024 13:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b3bKAFJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CD188B55; Thu, 31 Oct 2024 13:42:40 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7819F8929D
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 13:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7CF5CA44249
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF076C4FF11
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730378189;
 bh=pN4THYBz7uQ0QtFOh+VfhQ7YxybXfqz01rlAMR8YBDc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b3bKAFJkKSgaCgXGRa/vKBjG3camJRhnvPF9y57mm5gm6RsMpdia94BoLgmZDl3gl
 0GaMZW3x1ar8ceN0n4CWFmfBuewEVG6SPiwKq4tFLTnfroo3R2MByppASG8lP5GcdS
 y+soWwSnNixgik6goEgcacCqqY5XBrFAropCw3KctX4fFd5MN/LT8GXjZeGVNHEcyG
 sq1lNAvCkQUuKTB0KsKJ+uXZScjhVDnFI0KE3ooAMS5+T9JRu54ZQ1F9SV3DY3MB8w
 70N6qXnlZ0eeEdVyglHLZLew9VsTgNE/Uln6npYzdvtRsZ0zV8VGGHDsgCSReQnZ7l
 jZqP+woWUml4Q==
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-539e63c8678so1007263e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 05:36:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvdgqsIcB3ZYynE20yy/jKrigZSWItPUeA2PbFFgoXKeyiTudGy526UjHWMW0IAyXTxYZU6lc=@lists.denx.de
X-Gm-Message-State: AOJu0YzylllCEu/8ylkugyfBiq4kujfb1T/NwHtwp2ltkSQ6q7nFTZOd
 en+ZEEwFTOe4S/lJ8vNo+l9gWai3DMo1laWolGcxjqBQ8e89PdyG9/YZRHQHxMgeTQaISrPHYrT
 Z5L5+TQDaJOIzN4bhG2/10cIHwQ==
X-Google-Smtp-Source: AGHT+IGbQ2QlHmIxAipRELROCkoUWNGVlKx35u7hznfndRbc071Xg+IQrc4GAadbju0m88E+b4HFw1okR1LMSOUdBvQ=
X-Received: by 2002:a05:6512:318c:b0:539:918c:5124 with SMTP id
 2adb3069b0e04-53b348df188mr9574653e87.31.1730378188102; Thu, 31 Oct 2024
 05:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <Zxzh0ODFyZnav5JE@74d70d9af7e3>
 <fc3dcef2676252484cfa427ad0197cd9aa697420.camel@xry111.site>
 <ZyGHKJZe4q3ZP5oc@zatzit>
In-Reply-To: <ZyGHKJZe4q3ZP5oc@zatzit>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 Oct 2024 07:36:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDYwX7jAShFboGv6Bw8zd_UeW+ArVwtv+U8oVJgCkRKg@mail.gmail.com>
Message-ID: <CAL_JsqJDYwX7jAShFboGv6Bw8zd_UeW+ArVwtv+U8oVJgCkRKg@mail.gmail.com>
Subject: Re: [PATCH] libfdt: Fix build with swig 4.3.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Xi Ruoyao <xry111@xry111.site>, Rudi Heitbaum <rudi@heitbaum.com>,
 u-boot@lists.denx.de, devicetree-compiler@vger.kernel.org
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

On Tue, Oct 29, 2024 at 8:10=E2=80=AFPM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Tue, Oct 29, 2024 at 08:52:52PM +0800, Xi Ruoyao wrote:
> > On Sat, 2024-10-26 at 12:34 +0000, Rudi Heitbaum wrote:
> > > Call SWIG_AppendOutput instead of SWIG_Python_AppendOutput so that
> > > is_void is handled within swig.
> > >
> > > Link: https://github.com/swig/swig/commit/cd39cf132c96a0887be07c826b8=
0804d7677a701
> > >
> > > Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> >
> > Dtc is a separate project at
> > https://git.kernel.org/pub/scm/utils/dtc/dtc.git, so the patch should b=
e
> > rebased against it and sent to devicetree-compiler@vger.kernel.org.
>
> Looks like someone independently fixed it upstream:
>     https://github.com/dgibson/dtc/pull/154
>
> I'm doing final tests now and expect to merge shortly.

Would be good to tag a release too, so that distros have something to
pick up when they update swig.

Rob
