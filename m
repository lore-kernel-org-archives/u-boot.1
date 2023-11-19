Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18893C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 23:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141CB8752B;
	Mon, 20 Nov 2023 00:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="A+2pA8E3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06A986F0D; Mon, 20 Nov 2023 00:47:13 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F29887507
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 00:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SYS3b1kGPzQ3D;
 Mon, 20 Nov 2023 00:47:07 +0100 (CET)
Date: Sun, 19 Nov 2023 23:47:06 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
Message-ID: <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
In-Reply-To: <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1700437628; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=3340; bh=yiENkgVsOY6h0zF2FyKQYdsk7gs5uUMLscqhCpQj3ts=;
 b=A+2pA8E3LuuGQ/SPA18LczBeO/Hj/wCmh36LK+SEPy3HDaUMR+h7Bj7o8sXbKL91
 bbRIXKNp4eIcsfu1mKWTMVkEtYfGyOjyR+wX6hoqw/JHf9XN/10md7vzcmIHk6kV7UA
 4TfhCq6yU9n18D2eyeMXzPSMMBX/yIX76xEYhI3QBWfRv3FZjHOejOZuefu6mX/2cPi
 y2dzxVy4uHFh+KuZUYM44Bodg/gz+5uFxahIoF5lDkEIfOTPDJ51flKh/HeFLS/4YE0
 NI1FZWYjy0rIgiS95K4Kg2LthhT55pVguECW9OpuDa1mo+uN0EQS/jd6E0PXJ23QSf1
 Rrabsn4jOA==
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

It will warn, if warning levels is set correctly. I will do not remove it.h=
ttps://stackoverflow.com/questions/3599160/how-can-i-suppress-unused-parame=
ter-warnings-in-cbtwSorry for "top-post" i am using an e-mail servicer whic=
h is not prepared to following the 1990s styles which is need for Linux and=
 U-boot developing processes still in 2023. Probably, It would be time to i=
mprove the communication platform as well, and it would be better to use Gi=
tLab or GitHub PRs.-------- Eredeti lev=C3=A9l --------Felad=C3=B3: Fabio E=
stevam <festevam@gmail.com>D=C3=A1tum: 2023 november 19 22:28:31T=C3=A1rgy:=
 Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detectC=C3=ADmzett:=
 Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu>Hi Benjamin, =
 [Please do not top-post]  On Sun, Nov 19, 2023 at 6:08=E2=80=AFPM Sz=C5=91=
ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu> wrote:  > (void)(devn=
o); is need because devno arguments is an unused variable, need to use this=
 solution to suppress any potential warnings.  No, devno is a function para=
meter. There is no warning if '(void)(devno)' is removed.=20
