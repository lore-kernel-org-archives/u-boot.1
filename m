Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D9BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 05:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6598777D;
	Fri, 10 Nov 2023 06:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kg40F3c1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE2E8776A; Fri, 10 Nov 2023 06:38:57 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3741877BF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 06:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9e4675c7a5fso267573066b.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 21:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699594734; x=1700199534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TIUeTfHZJpdQGhXbzIaTd9LQJxWd7PXBR9BPs/mFQk8=;
 b=kg40F3c1VJ2Dw2zASOoL+nK30hLE3tYnm+kpCaxDQN9bDjCpTlAC0jh4YqHpxfozMv
 znMcZ0A3U2D+rzx6b6JtP6J+O44w5iY6CmrKMhUhRZFwA9sxq3DFT/1YKu6nLr1L001v
 wrWJ46bo4KurIDUbBbdA5zaUGiYUUsP4bGaL/hJ93wbR494VbWuTAhim6AczSUUgJJl8
 N0UMvERSEqbXmps1Ic7TiqsTDjgUrqPyk+sFnRRfJnwhP2zWrUDWbNaxBdl6htRouziQ
 dQ4JkqKcQjCWzBKYr04gdzcQGpVq33TnPuuMELGzRREAcu4TqCn2RAcdSfnqiIM5WWMf
 D5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699594734; x=1700199534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIUeTfHZJpdQGhXbzIaTd9LQJxWd7PXBR9BPs/mFQk8=;
 b=BuhGcgT+7cyLKlqlowNR4NwKVE+G9G6ItyglsvPf7RebZURPTRMgU7zBvdToDEdeVG
 1QljPYFid4/uouOgrUt8fNGzVAZFizmddtE3EBcwp0IUOYvYgpAlor0IIOFYCK1pCwbN
 zvgLTvtHL4ut6lqHrnjKXBfK5kjqbEpfgCKJzapNPuIaQvtGeDPsDo28g14f7p+COZZI
 3z1ul+chwXYQYfsO3qHcusrg24aW2iuwdt7ocNvM0FZtOoYfa+amSw1HdGgGg3NZXUUy
 BEDRdhtRy6ojvE0v+3RNKHFVN90mZfFJf7vd726MmeFkor7Yg1gFZ3bO79Lze6MNgEAR
 FuEA==
X-Gm-Message-State: AOJu0YzWDkGCcRcFm28I289/WalFpi+lXv34RbCam0F1ONm3AL1ymjYO
 JfPP26oDxH+4oAYYtaggXvXOUWPMZnGaDGq07T4=
X-Google-Smtp-Source: AGHT+IFDP/7qSoPH7vrisElty2YunisV4TP3MW6Mpm535hIXZqHT1gFRveVGcVXCeSue47f6qP3Dg3ghOp2CME1cD0o=
X-Received: by 2002:a17:906:eec1:b0:9e0:9d26:420a with SMTP id
 wu1-20020a170906eec100b009e09d26420amr5988743ejb.65.1699594734079; Thu, 09
 Nov 2023 21:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027094947.bhtwngq26e3loya5@google.com>
 <20231027172237.GB496310@bill-the-cat>
 <20231109213348.GP6601@bill-the-cat>
In-Reply-To: <20231109213348.GP6601@bill-the-cat>
From: Chris Packham <judge.packham@gmail.com>
Date: Fri, 10 Nov 2023 18:38:40 +1300
Message-ID: <CAFOYHZAbkKLuC9KiH0KNz7hj31QsYohmJRCgu-Pk_yr4yXtEDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Revert HAFDBS changes
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 u-boot <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Will Deacon <willdeacon@google.com>, 
 Ye Li <ye.li@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>, Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 10 Nov 2023, 10:33 am Tom Rini, <trini@konsulko.com> wrote:

> On Fri, Oct 27, 2023 at 01:22:37PM -0400, Tom Rini wrote:
> > On Fri, Oct 27, 2023 at 10:49:47AM +0100, Pierre-Cl=C3=A9ment Tosi wrot=
e:
> > > Hi Chris,
> > >
> > > On Fri, Oct 27, 2023 at 01:23:51PM +1300, Chris Packham wrote:
> > > > As discussed this series reverts the HAFDBS changes that caused an
> issue
> > > > on AC5/AC5X. I think there are some improvements that can be made t=
o
> the
> > > > initial memory map for the AC5/AC5X but so far nothing I've found
> makes
> > > > it compatible with the HAFDBS changes.
> > >
> > > Would you mind briefly explaining what those issues are and/or point
> me to the
> > > discussion where it was decided to revert these patches?
> > >
> > > The feature is quite useful for users of CONFIG_CMO_BY_VA_ONLY, to
> speed up the
> > > boot sequence: instead of reverting these patches altogether, would a
> reasonable
> > > alternative be to put them behind a build option?
> > >
> > > Also, could you confirm that the "initial memory map" you are
> referring to above
> > > only describes actual memory as, IIRC, some boards were using mapping=
s
> **much**
> > > larger than their DRAM address space?
> >
> > The most details are in this thread:
> >
> https://lore.kernel.org/u-boot/CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=3DJ0oH=
yvN75bTaCUw@mail.gmail.com/
> > with some follow-up in:
> >
> https://lore.kernel.org/u-boot/CAFOYHZB7jJWwD24oWzx6u55w2whHYjK56f=3DQyN0=
LWU4Z8dSP+Q@mail.gmail.com/
>
> Checking to see if you have any feedback for these platforms? I would
> like to have them working again one way or another in v2024.01, thanks.
>

Either this series or
https://lore.kernel.org/u-boot/20231018205358.1557234-1-judge.packham@gmail=
.com/
will get the AC5X boards back working. I'm out of other ideas but happy to
test patches.

>
