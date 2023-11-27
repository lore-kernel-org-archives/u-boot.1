Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91AEC07D5B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95735877E9;
	Mon, 27 Nov 2023 20:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="mPNDdyni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7F387812; Mon, 27 Nov 2023 20:55:12 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F726877CE
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SfGXB23FlzjwK;
 Mon, 27 Nov 2023 20:55:06 +0100 (CET)
Date: Mon, 27 Nov 2023 19:55:06 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
Message-ID: <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
In-Reply-To: <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
 <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1701114907; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=4516; bh=pfifgY1NRzbQuweG2xnWQpCKjjjF/DaW/G40E3XJ+6Q=;
 b=mPNDdynizpQFqxDzWKJCcPI5Muw0thnBqZcltGZAL6Rj1Xw8GHp2SifW0wuoDiMQ
 YPJRppvx7VFOUPRna+C1K/BzCjPFAt75SmSAu2KQlV+JhtAET/bG+RDnzWJ1+dOM4mU
 QVFLp0gLyZ2oxqVNCNxTlsNbJd7abAchbSSDw9wKopZ5qiHaDmxrRp8Knngo32bBdd7
 EvoRs9YMdby39/vAkANKri9bL7NLU6I3vx0RSuNCyfEOtPSZnW/sq9di1XOpyp6UJGm
 zb/OQ69csiErzjqdB0UpiQkPaY9brLl7L8+kgcy38WQdfxjFIRPuljKi9d1cdk24o3E
 7XihH/SU+w==
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

Unused function parameters should be removedhttps://rules.sonarsource.com/c=
/tag/based-on-misra/RSPEC-1172/Quaility means the full SW has no any functi=
ons with unused paramteres. Unfortunatelly it seems u-boot and kernel sourc=
e code are not best, it is time to improve it. You can see, i did it, so if=
 you do not like it and you would like to keep the bad and historical solut=
ion you can change it in my patch yourself as a maintaner. I am not plannin=
g to submit any new patch version and my patch is done in my point of view.=
-------- Eredeti lev=C3=A9l --------Felad=C3=B3: Fabio Estevam <festevam@gm=
ail.com>D=C3=A1tum: 2023 november 27 01:44:16T=C3=A1rgy: Re: [PATCH 1/1] pi=
co-imx7d: add baseboard SD card boot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1=
lm=C3=A1n Benjamin <egyszeregy@freemail.hu>Hi Benjamin,  On Sun, Nov 26, 20=
23 at 8:17=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@free=
mail.hu> wrote: > > It can happen when will -Wall be enabled as in others S=
W projects. My patches are final, ready and works. I will not remove this "=
supression", it must be a part of it if the target is to provide code in go=
od quality. If you have any further whishes you can edit my patch and you c=
an be a co-author.  Sorry, but this makes no sense.  You are going in the o=
pposite direction of good code quality.  Both U-Boot and kernel pass -Wno-u=
nused-parameter.  It is common to write codes for stub functions like this:=
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/inc=
lude/linux/regulator/of_regulator.h?h=3Dv6.6.2#n29  No (void)parameter is p=
assed as you did in your patch. Like I said, it is unnecessary.=20
