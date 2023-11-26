Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93918C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 23:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F4286DDC;
	Mon, 27 Nov 2023 00:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="maYQi26E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0A886DDC; Mon, 27 Nov 2023 00:17:09 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA0986C67
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 00:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4Sdl3f06J4zfpQ;
 Mon, 27 Nov 2023 00:17:02 +0100 (CET)
Date: Sun, 26 Nov 2023 23:17:01 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
Message-ID: <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
In-Reply-To: <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
MIME-Version: 1.0
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1701040622; 
 s=20181004; d=freemail.hu;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 l=2566; bh=kpWUg0iDb2YEdq28oQYkjVYWPRZkKCtHhtwP3X23zxE=;
 b=maYQi26EWK03n/MQup/u007pLy9g7Syqbd150KJDRKt4ujbb2AsIUZ01oiFa6pKb
 uAXyapWxB4eUKWXM1WtbKLF4JAcdw+J5i29TLfaYvIhqxacV7MulLH3XOnYa9tku1xC
 HBmw6Qwh5ptVDteqtBFP5EQ92BH0Kd1SPTj1tfxfkpwvFyxh6AhmhP4kykG0LFIV+fu
 6jKgOvMIylXoVPRfk/LFcnDYVtGHBGaV0zftuIKkgIL3rq4rWdbjc+fmzCUpZlOV697
 4AyTCTaYnvu+HDWlu/8o7J8VayIugzITR/8TXid6XF8GrYcrdUmlTnaU1lw0q9JB+ez
 83E2Wu0hkA==
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

It can happen when will -Wall be enabled as in others SW projects. My patch=
es are final, ready and works. I will not remove this "supression", it must=
 be a part of it if the target is to provide code in good quality. If you h=
ave any further whishes you can edit my patch and you can be a co-author.--=
------ Eredeti lev=C3=A9l --------Felad=C3=B3: Fabio Estevam <festevam@gmai=
l.com>D=C3=A1tum: 2023 november 20 01:18:24T=C3=A1rgy: Re: [PATCH 1/1] pico=
-imx7d: add baseboard SD card boot detectC=C3=ADmzett: Sz=C5=91ke K=C3=A1lm=
=C3=A1n Benjamin <egyszeregy@freemail.hu>On Sun, Nov 19, 2023 at 8:47=E2=80=
=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin <egyszeregy@freemail.hu> wrote: =
> > It will warn, if warning levels is set correctly. I will do not remove =
it.  How can it happen if U-Boot uses warning-1 :=3D -Wextra -Wunused -Wno-=
unused-parameter ?=20
