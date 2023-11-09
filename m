Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F6C4167B
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 11:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97687138;
	Thu,  9 Nov 2023 12:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="f49hv1pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8621E87147; Thu,  9 Nov 2023 12:43:09 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85D687128
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 12:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5be6d6c04bfso8823107b3.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1699530185; x=1700134985;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i6PIy+b5/1OmAUb/g+SD/Sc0y+Y5XpH/2K+dK8XiiY=;
 b=f49hv1pzhP1OGxPSXWjoWAbMbSaZM+LOHnu1GYfTwJNnXn4JMVhPPak+lT8/hp9oif
 KcadmT2tn6UUraQ4mdo6/1OoPazcoJQQOpgXmQsFuPFTK1QQLRXpWIgAWIUiJTvRaPPa
 XjHYcnee0I35DPdCuilzSCFhGDkilQ03udgmjcX7N/ecVWIxHi/z6fEIY3V5jsH+jq9v
 vwE3nsQoopSuxXpH5cSXWNgnMedxS4M7br8HAEPJ27/QNQq4yHZSFO/Xtet/xvf3IFzH
 AqsZvMSDZ4huwNooyBxS+mxX8fTVA0VirTO+0h3uH/jn3JSGLdYCl6hS3fzzIMSoW0Jh
 6rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699530185; x=1700134985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5i6PIy+b5/1OmAUb/g+SD/Sc0y+Y5XpH/2K+dK8XiiY=;
 b=m33egEMDX/cF9aZGg2e9wrhCyxuzWHkhD/TnB+q7n3JByZsV0Gh6pn8MYxb2BFz0RD
 UWI8CDBhY8MWhVTpEgUMR7uZwxICknFGrFFCjENCn8H9F+vH39vCH1M9RplD4SRpeAKD
 3HXcG45gVYXLYa5nnZacrrz/aWA6V1MGqF4gzjBmUNqnfVfOEe4bMP87B+9d96ATv0fS
 prMlt8L7/fKUU3oGZMIOKW4ebIk8Gfh2rY/46mvsUqfGaNHaMatqVmTwjP/KgIg9HIzu
 W3al08ZwVW2N/zoqAbbDF6uMid9a3E6DrTDhX3fmielyt9a7gIneWRBOSGE1YgrYt/oR
 PntQ==
X-Gm-Message-State: AOJu0YwfYT30PRQP1ZLRG933VWVFcBsjCYxyJdeo3K0gJ/wihFyPvxtc
 /xApHve9d5YEH6kbORsUpp6kqFNs+d9MMEpjxec08A==
X-Google-Smtp-Source: AGHT+IH/XFIv5sfTLZRsYUZyP+7Tj6quD9bRYp4ej+SUY3C+RT+YDLKdhu98BME0RgYSdzqTD681DGlfWRSG/bU2Ar8=
X-Received: by 2002:a0d:fb07:0:b0:5a2:15bc:b32c with SMTP id
 l7-20020a0dfb07000000b005a215bcb32cmr4368057ywf.42.1699530185198; Thu, 09 Nov
 2023 03:43:05 -0800 (PST)
MIME-Version: 1.0
References: <214217fdd0d69a107482c5c6f6dce96894aa5dc1.1698757115.git.love.kumar@amd.com>
 <20231108144153.GA1069311@bill-the-cat>
In-Reply-To: <20231108144153.GA1069311@bill-the-cat>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 9 Nov 2023 12:42:53 +0100
Message-ID: <CAHTX3dLohvCoy=2M5fyv6MAeqMpuO6rVSMsMwPBtPHX_xhrKsg@mail.gmail.com>
Subject: Re: [UBOOT PATCH v2] test/py: net: Add dhcp abort test
To: Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, michal.simek@amd.com,
 git@xilinx.com, rfried.dev@gmail.com, v.v.mitrofanov@yadro.com, 
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
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

st 8. 11. 2023 v 15:42 odes=C3=ADlatel Tom Rini <trini@konsulko.com> napsal=
:
>
> On Tue, Oct 31, 2023 at 06:29:20PM +0530, Love Kumar wrote:
>
> > Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> > prompt and validate the abort status.
> >
> > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > ---
> > Changes in v2:
> > - Mark CMD_MII command dependency
>
> This doesn't work for me on a raspberry pi 3 in 32bit mode (and I
> suspect fails on the rest of the Pi families and builds as well):
> test/py/tests/test_net.py ..F
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _____________________________________ test_net_dhcp_abort _______________=
______________________
> test/py/tests/test_net.py:139: in test_net_dhcp_abort
>     eth_num =3D re.search(r"Current device: '(.+?)'", output).groups()[0]
> E   AttributeError: 'NoneType' object has no attribute 'groups'
> ------------------------------------ Captured stdout call ---------------=
----------------------
> U-Boot> setenv autoload no
> U-Boot> U-Boot> mii device
> MII devices:

You have mii command enabled but you don't have any device there.
I expect you have any ethernet phy on RPI3.
Love should check that the actual phy device at the passed address
exists to be able to abort it.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
