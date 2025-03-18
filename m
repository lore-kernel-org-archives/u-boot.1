Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96A7C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFF6810F4;
	Tue, 18 Mar 2025 16:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="X6w2RFZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50161817D8; Tue, 18 Mar 2025 16:47:14 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5E881026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1742312830; x=1742572030;
 bh=bz0AiDymFC2u7C3E2VXESlQ7BB5qL5cjh34SpDb39hc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=X6w2RFZgUy1cCX8t+bABKSFkATr66jcF21eRqLqRP+7nmqizeSeYEeLC/L2G8LIGm
 Hx2nuY7EUZjuuQYpLjH/J9VycDof6avSQUrIPUaUP/q/b4uHd0Xz6WGv0fto9BqRaH
 Y2A03RdNmnUHyaVHsnZyMh6lHvCVh3ZkBk/X0lnwEle2nOqW5ak0S4H5kg+CeASwwS
 jTvyAmFXg8IIFH/T87G4aDcLzFUyW+Op+P+pg1Kizzx83JeFhrAGYZz0JTNA8exX2i
 2MKMyVhVxzpzkNtxe/ArXUnqIAxnabejLZ5pz8pUbPyxW/MnWjINS9hz8C8n/hs5DW
 qHy5DNN5UoiZQ==
Date: Tue, 18 Mar 2025 15:47:03 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 0/6] MSM8916: Bring secondary cores online with spin-table
Message-ID: <cjIBWjUlyvVV-6dcf1IoKZJSlpbIEpPZre6dag1li-Fw0FG2mnfm6OTmKkDn636cT1ZgGByWrDS1TUSUpFuY9oYzkyurDwLD3SHBCxhjofY=@samcday.com>
In-Reply-To: <0ea959fb-eaf5-4d90-a4b8-1298ac4d09d7@linaro.org>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
 <20250317134558.GM2640854@bill-the-cat>
 <0ea959fb-eaf5-4d90-a4b8-1298ac4d09d7@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 0063ddc0dce1422baf10fb070248937b92227fd7
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

Hi Caleb, Tom,

On Monday, 17 March 2025 at 14:50, Caleb Connolly <caleb.connolly@linaro.or=
g> wrote:

> On 3/17/25 13:45, Tom Rini wrote:
>=20
> > On Mon, Mar 17, 2025 at 01:13:22PM +0000, Caleb Connolly wrote:
> >=20
> > > Hi Sam,
> > >=20
> > > Can you re-send this without all the prerequisite-patch-id tags? b4 i=
s
> > > desperately trying to apply ~140 patches from some old next branch to=
 my
> > > tree and tbh im not sure how to make it stop.
> >=20
> > You can use --merge-base HEAD to override that I think. If not I think
> > it's worth asking tools@kernel.org because that sounds like a bug to me=
.
>=20
>=20
> I think Sam had a bunch of big series pulled in for some reason, the bug
> is listing them all as prerequisite patches imo
>


Ah, heh. No idea how I managed to confuse b4 like this. I wonder if it's
because this series had a prereq on a series that itself had a prereq?

Anyway, since Caleb had some additional feedback on the SCM bits in patch
#3, I'll send a v2 soon that fixes this strange issue.

-Sam

>=20
> --
> Caleb (they/them)
