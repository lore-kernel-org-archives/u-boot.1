Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9167FC07E97
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 23:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80740875EB;
	Tue, 28 Nov 2023 00:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="0t/lhwQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78204875BF; Tue, 28 Nov 2023 00:26:15 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730CE8757D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 00:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SfMCh17bTzjSJ;
 Tue, 28 Nov 2023 00:26:08 +0100 (CET)
Date: Mon, 27 Nov 2023 23:26:08 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
Message-ID: <A2E88A.1BiPC1JJI4ID.2cqy6ZTmX2YXIGOSvxV@freemail.hu>
In-Reply-To: <CAOMZO5AK3cxy_mOD_J9UPPCzFVfzoVw=OmACeh2+27k+4CkCnQ@mail.gmail.com>
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
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1701127569; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=3321; bh=/bh0lX6j8CXLw1CiOmlmhMlIIA6bkUjIb5BYf/HA5ts=;
 b=0t/lhwQYJhs0PcTJP71eTpURuEbmL9F6TKQARTK/Q7PN1k0gfNH/7Ck5e5F9nH4y
 Zk+6wLi+8gWF91d2AkxTXRRx7yg3D6JacS5P1yXH+L/HCcTDTI4yEDSX4uCz42AKoDh
 j0qxftP7B5Im341Ve01ZLuy9PS+RfeUOnfK8/wxz5oZvAConfStPWt7w2FI/Mb9Re1l
 RDoEQEmuTPxH88pCsV55oTkEtbrcENSQ820sE3URbJpTw5ntRJg4LK+bricOthCGCOt
 LHeNJ3Crfi6s+POrfMBn4hDc2BIr94QcYYozPnGK/fCIp39Cnhv7E/olxjpACN1FwEI
 zA6NglZ3VA==
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

It was absolutely conform, i supressed the potentional warning. Once again =
i say, i will not remove it, if you do not liket it you can remoce as a mai=
ntainer. My patch is ready and final. Let's do something to improve i.MX fa=
mily as a maintainer. I am realy sad to see in last 2-3 years there was no =
any significats new features for boards since their initial commits.-------=
- Eredeti lev=C3=A9l --------Felad=C3=B3: Fabio Estevam <festevam@gmail.com=
>D=C3=A1tum: 2023 november 27 21:39:19T=C3=A1rgy: Re: [PATCH 1/1] pico-imx7=
d: add baseboard SD card boot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1lm=C3=
=A1n Benjamin <egyszeregy@freemail.hu>On Mon, Nov 27, 2023 at 4:55=E2=80=AF=
PM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu> wrote: > >=
 Unused function parameters should be removed > https://rules.sonarsource.c=
om/c/tag/based-on-misra/RSPEC-1172/  From this same URL:  "Exceptions There=
 are some cases when you want to have an unused parameter (usually because =
the function has to conform to a fixed prototype"  which is the case here w=
ith your patch, where you need to conform to: int board_mmc_get_env_dev(int=
 devno)=20
