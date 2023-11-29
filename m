Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E6BC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 22:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4871286EA3;
	Wed, 29 Nov 2023 23:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="toeHx3aZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1469E86E88; Wed, 29 Nov 2023 23:13:44 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DED886EA3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 23:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SgYW73qlNznWh;
 Wed, 29 Nov 2023 23:13:39 +0100 (CET)
Date: Wed, 29 Nov 2023 22:13:39 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Dragan Simic <dsimic@manjaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 Hugo Villeneuve <hugo@hugovil.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Message-ID: <A2FS4g.GFF4EBsw8Al.pbUwSFwrL4BSLzAdMWk@freemail.hu>
In-Reply-To: <722ca2b11c9ed6939fc0ee309cea01f4@manjaro.org>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
 <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
 <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
 <CAOMZO5AK3cxy_mOD_J9UPPCzFVfzoVw=OmACeh2+27k+4CkCnQ@mail.gmail.com>
 <A2E88A.1BiPC1JJI4ID.2cqy6ZTmX2YXIGOSvxV@freemail.hu>
 <20231128181740.7fea242b489d9efa261904d4@hugovil.com>
 <A2FIQQ.2wIe6QeN9LRi.hPrNsyrmbwYjoHVf1fCB@freemail.hu>
 <46e75feb54d11721d09209ac00036dc3@manjaro.org>
 <A2FScA.MW9nwmW6LUOs.KplLbQiNaxiTRzhfA2eM@freemail.hu>
 <722ca2b11c9ed6939fc0ee309cea01f4@manjaro.org>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1701296020; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=10020; bh=/FOMANtMu95nFSSqEglmNlhPbltTqujP0YlN4Loexz0=;
 b=toeHx3aZLsfLGqnwoo5DrgzKP9smx9+ocT8FoVufSyhtaulheNaclZ1c4tl7mo7c
 6KkeesIOkUN3spAUrfGxbn2E6iSUZw7Xiv41WJ9zkRRz64ApoWLesisnttn60kFkzEJ
 4B1J007EhVZ55AfhHbl+az+QBRBPBal91pjQ6gsj8eCwprjj1wFDEiod+iRka5aUTv+
 J+4hd6PkiZaPucOtpBeC/gBHRwWGAY+c5RvdnnX+2Kfk7cH5EPG95AiYt8WreHZjVPj
 Jp/NnGt3qI3kWztlgesZwuLunzWVe51xjdX4L0bPt8dHaKszGo/Ju0rKnC95C54DJNT
 fuXkI8cWOA==
Content-Type: text/plain; charset=UTF-8
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

https://wiki.yoctoproject.org/wiki/GroupsMigrationIt seems to me, you shoul=
d take little more time to understand the benefits. In Yocto wiki site ther=
e is an overview about why was they migrate mailing list to Groups.io some =
years ago from legacy and outdated Mailman.-------- Eredeti lev=C3=A9l ----=
----Felad=C3=B3: Dragan Simic <dsimic@manjaro.org>D=C3=A1tum: 2023 november=
 29 22:34:25T=C3=A1rgy: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card b=
oot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@fr=
eemail.hu>On 2023-11-29 22:12, Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin wrote: =
> https://lists.yoctoproject.org/g/main  Ah, I already used the same mailin=
g list system.  I saw no benefits, though.   >> -------- Eredeti lev=C3=A9l=
 -------- >> >> Felad=C3=B3: Dragan Simic <dsimic@manjaro.org> >> >> D=C3=
=A1tum: 2023 november 29 05:47:55 >> >> T=C3=A1rgy: Re: [PATCH 1/1] pico-im=
x7d: add baseboard SD card boot >> detect >> >> C=C3=ADmzett: Sz=C5=91ke K=
=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu> >> >> On 2023-11-29 00:35=
, Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin wrote: >> >>> Sorry i can not fix it=
, this is an average e-mail service provider >> >> >>> that provides the ex=
pected tech level in 2023.Please upgrade your >> >>> u-boot list website en=
gine to able to support e-mail >> >>> formats/technologies from 2020s ages.=
 I suggest to use similar >> what >> >>> Yocto project has: https://lists.y=
octoproject.org/g/main-------- >> >> Well, it makes me wonder what are thos=
e modern email technologies? >> Is >> >> it HTML? Also, I'm getting "group =
does not exist" on the link above. >> >> >>> Eredeti lev=C3=A9l --------Fel=
ad=C3=B3: Hugo Villeneuve >> <hugo@hugovil.com>D=C3=A1tum: >> >>> 2023 nove=
mber 29 00:17:51T=C3=A1rgy: Re: [PATCH 1/1] pico-imx7d: add >> >>> baseboar=
d SD card boot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin >> =
>>> <egyszeregy@freemail.hu>On Mon, 27 Nov 2023 23:26:08 +0000 (GMT) >> Sz=
=C5=91ke >> >>> K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu> wrote: >=
 It was >> absolutely >> >>> conform, i supressed the potentional warning. =
Once again i say, i >> will >> >>> not remove it, if you do not liket it yo=
u can remoce as a >> maintainer. >> >>> My patch is ready and final. Let's =
do something to improve i.MX >> family >> >>> as a maintainer. I am realy s=
ad to see in last 2-3 years there was >> no >> >>> any significats new feat=
ures for boards since their initial >> >>> commits.-------- Eredeti lev=C3=
=A9l --------Felad=C3=B3: Fabio Estevam >> >>> <festevam@gmail.com>D=C3=A1t=
um: 2023 november 27 21:39:19T=C3=A1rgy: Re: >> [PATCH >> >>> 1/1] pico-imx=
7d: add baseboard SD card boot detectC=C3=ADmzett: Sz=C5=91ke >> >> >>> K=
=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu>On Mon, Nov 27, 2023 at >>=
 >>> 4:55=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freem=
ail.hu> wrote: >>>> >> >>> Unused function parameters should be removed > >=
> >>> https://rules.sonarsource.com/c/tag/based-on-misra/RSPEC-1172/ >> Fro=
m >> >>> this same URL: "Exceptions There are some cases when you want to >=
> have >> >>> an unused parameter (usually because the function has to conf=
orm >> to a >> >>> fixed prototype" which is the case here with your patch,=
 where you >> >> >>> need to conform to: int board_mmc_get_env_dev(int devn=
o) Hi, >> please >> >>> fix your mailer to wrap lines properly. Hugo Villen=
euve.=20
