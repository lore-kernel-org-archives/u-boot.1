Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6258FC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 12:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65008714A;
	Mon, 27 Nov 2023 13:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m0PEB2me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7464E87264; Mon, 27 Nov 2023 13:49:37 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BABC870B8
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 13:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2839b418f7fso3015372a91.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701089373; x=1701694173; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xj8KHhOsozF0eFU3EtrTMJ7yPKvFHMgGBgWpmaah6HQ=;
 b=m0PEB2me4uHvv+2g3T+6BRKHxhJAAJKmqip6jlOWfSnWu/s6CwZPFmpkmNS38xrY3z
 gbC0G+y6FsrLjRbLmM9WIz8gAhnUn+3snHl0Q2SyYhdZxCbZDT15okzyVgYHkIRm8YP7
 m4y2zhiyc/R4RIMrfsdlaR9FIBwo7Fnuorrfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701089373; x=1701694173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xj8KHhOsozF0eFU3EtrTMJ7yPKvFHMgGBgWpmaah6HQ=;
 b=fYOrnzSAicEms/trz+gBEegSA2lkXoOHDMymibF5kkjo1naoiPpMEp66i6yLrUPSz+
 5pn5M3tuA4MSwKb6Gls+mO8E7H6Vah2Jnx8qSNX0wP2cM35J3MsEqOWrCMN2LY9xm/Ur
 7TdtncHM1LuMrlGaEcM7ZPuYlVCqHLe/FwLxJrPK5PVOTdaG+cxafxUUba/wHq7SJ61R
 F2hlcznqB5qU1Kqbeh7MCs20b4jUsA6RoQHXhcRgGLxEncRiQCpGrGmWE4DNZGmvwqdD
 RT1H+iMDnbp/pW4EYFCR4lxorJ+kZnO43pnDRY3rsl+L8KKUNTrXn+cmPICYSjhTYGyG
 an3Q==
X-Gm-Message-State: AOJu0YzsvT9EADSQK0EXzYAyWpHijxYf9UhkKGErgK8M4brm9+6nvn6t
 7kc3pD3um3t+8FWLEAtNud0X28wPCka4V/aIXh4arQ==
X-Google-Smtp-Source: AGHT+IFs7c8l0w3SlwVPLWZSMOkDdxT6gKiMneKYWnva9uERpUp4lCuO4KqqnWVEli8Nj3R2SmIb2T52W0Y+b9kwWLc=
X-Received: by 2002:a17:90b:4d8b:b0:274:6839:6a8c with SMTP id
 oj11-20020a17090b4d8b00b0027468396a8cmr9549702pjb.6.1701089373523; Mon, 27
 Nov 2023 04:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20231117154757.777827-1-trini@konsulko.com>
 <20231125223809.GW2513409@bill-the-cat>
 <PAXPR10MB50858692C89D451A7A18F7E4D2BDA@PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB50858692C89D451A7A18F7E4D2BDA@PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM>
From: Tom Rini <trini@konsulko.com>
Date: Mon, 27 Nov 2023 07:49:07 -0500
Message-ID: <CAEGM6axzOkySNu7uSmsWthiTQhTb_vMOY_Mjj_iFKKgg_Y=Vqg@mail.gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
To: "Winker Matthias (HC-CW/ENG-PJM)" <Matthias.Winker@de.bosch.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Philip Oberfichtner <pro@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
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

On Mon, Nov 27, 2023 at 5:45=E2=80=AFAM Winker Matthias (HC-CW/ENG-PJM)
<Matthias.Winker@de.bosch.com> wrote:
>
> Hello Tom,
>
> Just to be sure. In the past we had NET enabled such that the fused MAC i=
s taken over, although we don=E2=80=99t use NET CMD.
> With your changes, does I.mx6 evaluate the MAC fuses and forward it to Li=
nux?
>
> Our board: Bosch ACC.

I honestly don't know as I don't see how it's doing that today in
current master (which does not have this change) so you might
need to start by confirming behavior in the current tree and working
from there, thanks.

--=20
Tom
