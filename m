Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38D2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 21:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCFE86784;
	Wed, 29 Nov 2023 22:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="JHEDynO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7150D86E6B; Wed, 29 Nov 2023 22:12:45 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030B286579
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 22:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SgX8n6Lklzp3j;
 Wed, 29 Nov 2023 22:12:41 +0100 (CET)
Date: Wed, 29 Nov 2023 21:12:41 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Dragan Simic <dsimic@manjaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 Hugo Villeneuve <hugo@hugovil.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Message-ID: <A2FScA.MW9nwmW6LUOs.KplLbQiNaxiTRzhfA2eM@freemail.hu>
In-Reply-To: <46e75feb54d11721d09209ac00036dc3@manjaro.org>
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
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1701292362; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=6476; bh=tw+B44HKh6U2+BWjgtaTDAVfLyK3vEMz0Gqci1vWXCE=;
 b=JHEDynO+SmoPCKH5tPke4MYcuN5aXpsC40nmXYOT0v+6pFpj9tE2kdmG1dOXA6U/
 lDZhp26+0dyJvuIIiNoHRfwj57VaMd+BDvf2GmPJI1J5DtgZT/iCiSaXLx2uxTF5xfE
 CCUz+Hi5EGkgo+bsjYrDrSI93C8rf0tuQB6zSDEo3NsV+/SUW4Lugp7Cj7FRS54WSDe
 g1cmJDzSnx/xbLaiqWUPVaVG40jjWD0LZd4NGbjyk0GXgt8bsPQ/mcJr23E9hO+tea9
 RiL2RmNf7M40KVHc9N90lDRSuuLJT9lJkzaX2NeE47j8iW8QoWlOlJhd/Fiy4a1G7vP
 v3yQ9b0ZeA==
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

https://lists.yoctoproject.org/g/main=C2=A0-------- Eredeti lev=C3=A9l ----=
----Felad=C3=B3: Dragan Simic <dsimic@manjaro.org>D=C3=A1tum: 2023 november=
 29 05:47:55T=C3=A1rgy: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card b=
oot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@fr=
eemail.hu>On 2023-11-29 00:35, Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin wrote: =
> Sorry i can not fix it, this is an average e-mail service provider > that=
 provides the expected tech level in 2023.Please upgrade your > u-boot list=
 website engine to able to support e-mail > formats/technologies from 2020s=
 ages. I suggest to use similar what > Yocto project has:=C2=A0https://list=
s.yoctoproject.org/g/main--------  Well, it makes me wonder what are those =
modern email technologies?  Is it HTML?  Also, I'm getting "group does not =
exist" on the link above.  > Eredeti lev=C3=A9l --------Felad=C3=B3: Hugo V=
illeneuve <hugo@hugovil.com>D=C3=A1tum: > 2023 november 29 00:17:51T=C3=A1r=
gy: Re: [PATCH 1/1] pico-imx7d: add > baseboard SD card boot detectC=C3=ADm=
zett: Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin > <egyszeregy@freemail.hu>On Mon=
, 27 Nov 2023 23:26:08 +0000 (GMT) Sz=C5=91ke > K=C3=A1lm=C3=A1n Benjamin <=
egyszeregy@freemail.hu> wrote:  > It was absolutely > conform, i supressed =
the potentional warning. Once again i say, i will > not remove it, if you d=
o not liket it you can remoce as a maintainer. > My patch is ready and fina=
l. Let's do something to improve i.MX family > as a maintainer. I am realy =
sad to see in last 2-3 years there was no > any significats new features fo=
r boards since their initial > commits.-------- Eredeti lev=C3=A9l --------=
Felad=C3=B3: Fabio Estevam > <festevam@gmail.com>D=C3=A1tum: 2023 november =
27 21:39:19T=C3=A1rgy: Re: [PATCH > 1/1] pico-imx7d: add baseboard SD card =
boot detectC=C3=ADmzett: Sz=C5=91ke > K=C3=A1lm=C3=A1n Benjamin <egyszeregy=
@freemail.hu>On Mon, Nov 27, 2023 at > 4:55=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=
=C3=A1n Benjamin <egyszeregy@freemail.hu> wrote: > > > Unused function para=
meters should be removed > > https://rules.sonarsource.com/c/tag/based-on-m=
isra/RSPEC-1172/  From > this same URL:  "Exceptions There are some cases w=
hen you want to have > an unused parameter (usually because the function ha=
s to conform to a > fixed prototype"  which is the case here with your patc=
h, where you > need to conform to: int board_mmc_get_env_dev(int devno)  Hi=
, please > fix your mailer to wrap lines properly.  Hugo Villeneuve.=20
