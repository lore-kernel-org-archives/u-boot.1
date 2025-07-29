Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F1C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 23:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFCF582B07;
	Wed, 30 Jul 2025 01:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gYzHtFjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D749682B20; Wed, 30 Jul 2025 01:37:15 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D627381FEE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 01:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5550dca1241so5554381e87.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753832233; x=1754437033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3OgxQWBJTjsbDXC1pHKEle+GDC/vomPAoNBttYIztc=;
 b=gYzHtFjAH2K8zC1uwztoLbXFK+KOc3eLPnzOKUcQc2iqZdnJgT0F4WwGan+Lo2COVr
 yO9T7GdvArtQOdjEXPCEZp7/aCZeCp7U3PdUTr3YwUNl4FjjjOXNcF1U9qoJbeTq9+1/
 5P3Wd9sN3Dvd5qIHXxCP0WEfmYb1PWVXdvNpevl6FNSHEe0wmnNu7j33euYfsgQCas1h
 HCuN5U/nL8HOFLroIaxvFd6HSl9vxM7i1Ne2EVf/AHAQwVX/7AQoddjpJFTc37KUXGNB
 w04kkOFaYIst1/fwble3ZtYAQQw95FWFa4RZN8DqI+kVdw1Rq/URq3NTnvYoerXp7WAO
 8hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753832233; x=1754437033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3OgxQWBJTjsbDXC1pHKEle+GDC/vomPAoNBttYIztc=;
 b=EX3DNKOFSS2+BLPESxJzhz044uCuM1ybQaUVhemnKIML5LiDex1eziegaczmBG4qQX
 hG/wXXu51JNBnAgKgFYa0vXpA/dprxSUBs5k9cGvZ5xnw/GpaRoMJ+1uQh7vgbxTz4fu
 mB/oV4t7CzsXUiy0cgO91W22qVrvCRqUT2EGYjCTu2XjZRRt4GrULGDcsZoPgQGvyKcV
 /hVcSMWouvU2VVkoWzbvz/iVzE5MtA7KOmN6sgz/V1wO9BiwCRlTuhHAtjxew5r1Co1Q
 +dwN75ypt+EJMSyXRM7q68YV0JJZBW+CcQesIeoiB/7ab5HZnoAFI907tOJDNpcDzo9e
 qmeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpPtFv10uG3ydn0ArxjvQU6X0p0SO/goZoP0MhA5djiEaZqXO87uKbMGv2cscy0W0jbEa7r9A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8yGFxPkvduZwy66mxIAFIbuhjXvsUV6aRVUl7l3VD6xhEvylk
 N5eBhYD7XVPxHvIyIOCy1C2IAzLJ8kfrlLu8GTA0bQjF/ILVDi/lS6Bdc/TSCttAF8/MRc9yjEW
 bVeLWYwOnVyZAkye/yhUrvsvf5AYNCnYosA==
X-Gm-Gg: ASbGncuN63H9FlnjP2LonsXcqm4MsghFWunwRzdry8JRS8xrlEzKDnsegMBQrZIxMYh
 /9Uc9umswLCYVYtl65pP5fxGIGhYQZ5+7LInrYvL+Z7J07ii1+Ny5+2W4cu1MX89dWStkCRPYM7
 0leywmNo49HvMElz46vvzim4GNaD6ZZNJVK1TSxIy/ctMTKvbaPdOTnDlPF4NvbnE58MAB43Gst
 LPSOQ72Fvoka+9RPt2VF9F7gA3nOm8WC1bCx6c=
X-Google-Smtp-Source: AGHT+IGPI+Mdj6Ez+4phbrz7rT/p7GG77EbWFF4+l/syqqu5kfvvIxyQNbr8VcW0V0fSgPgvm2SDNuzOfvd/tn/2/ME=
X-Received: by 2002:a05:6512:3c9c:b0:553:2e27:6769 with SMTP id
 2adb3069b0e04-55b7bff26ebmr351957e87.7.1753832232827; Tue, 29 Jul 2025
 16:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Jul 2025 20:37:01 -0300
X-Gm-Features: Ac12FXz7l_37mdO7fcrj2XQHQsRNf5SxOxVx78-i5JeTKs7yoqz1IJxl2TA8UyE
Message-ID: <CAOMZO5BN_kxD=t0n3h=g3XhL1dLMmhgLHf0TtBtaX8ad3M878w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
To: Tim Harvey <tharvey@gateworks.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Tue, Jul 29, 2025 at 1:02=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> This is unacceptable. Had I known this series was doing this I would
> have NAK'd it. There was no mention in the commit log that this would
> drop support for A0. There are many vendors like myself who have A0

Same here: I didn't notice that this series would remove A0 support.

> silicon evk's that will likely never get upgraded and should not
> become bricks.
>
> We need to at least know how to get back to working boot firmware for
> A0. I would be fine if there was just a Kconfig to select A0.

Yes, I would appreciate it if someone could send patches to restore
it.MX95 A0 support.
