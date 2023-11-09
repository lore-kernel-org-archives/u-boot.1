Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4020C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2A9870E1;
	Thu,  9 Nov 2023 01:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GamOQN1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053D487040; Thu,  9 Nov 2023 01:00:42 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD1687030
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6c48fad2f6dso49074b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699488036; x=1700092836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Rbk4h9u3NDdHFnf669fQ6/xvgtPSqRYMUsjRcUlzF8=;
 b=GamOQN1O9XSzRBS99ThFQeRbH+mlz8OEkMv/4KOAztpfEuzlHSokLgiqKDI/rF5Pga
 3F9j/byBpn3rTptsEIT4Z1YGyFP6XCw+mF8D7DBJBbgafcn8ndsTuvzNvl7tYwLAE2PZ
 G3OOSB5qvYsMOgL6XjGPpWBZsI+Bewi8HkFdN+m9QF+ERg9teX2+AD9YZa1Uv1kpT8su
 pky0IDf0iYSfWFt7yQG8kkcivyFxl0tGXjsqR9WZlhWmIpgUbx4GblIvVk9KgS92UfLz
 H3TrexOeH16SCHq6DXr31Gz2urV8wrHa7zXMmVCpHMR6k9IAg2T2DsCnR6HKeLjWJpR0
 O4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699488036; x=1700092836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Rbk4h9u3NDdHFnf669fQ6/xvgtPSqRYMUsjRcUlzF8=;
 b=opa1/Z7gVgWCHDf1V9UKxl12knrB7I+mWqn562gk+Prb9/EDHYFLIoIaihcubxYHLQ
 HL/S5aIMkdQas3gRr7ODqiwveGLXpMIR+HBLw+mr6JVVXtV41ibXb0ph+rMeMSq+Pofq
 4/g/30JQHBQ8n9fqNWkgY/E2Lvv5B/jA5XQLLjDvKk0SFyt6cdSSojid7E51bBYD3KO3
 yupEw7kGJNEO4TYA/hPYMLh425OZye14c3faVUBht59uStlKEruR7Lcp5pxc9GOQiADj
 japHUZsNvZc1JU1SAD24gQMvvP5621Mo2/0zbb7zyC9hPtkEK1GktckdbAQ/pjuhFGT6
 Y9xQ==
X-Gm-Message-State: AOJu0Yz1zS+47Ap2rS1HStwIqpDHcZ23ZgdQjexZVsS1Oz3nkxarYcGv
 K3fKJknmDNa0vZ4HnTjW3B4MCE+tdeCzKjThjU4=
X-Google-Smtp-Source: AGHT+IGSspqp5QokNakBlwmlTYEm6+6yGmGMbBRjji62sFG54/DlEtXABXPP9TEcpNC/rvR8gSMfqPydG3fhOwwl9ig=
X-Received: by 2002:a05:6a20:4290:b0:15d:6fd3:8e74 with SMTP id
 o16-20020a056a20429000b0015d6fd38e74mr3942305pzj.3.1699488036024; Wed, 08 Nov
 2023 16:00:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Nov 2023 21:00:23 -0300
Message-ID: <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>, Duncan Hare <DuncanCHare@yahoo.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

[Adding Tom and Marek]

On Wed, Nov 8, 2023 at 7:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Greetings,
>
> I've recently given wget/tcp a try and find the results inconsistent.
>
> Transferring the same file 15 times in a row will eventually give me
> an incomplete transfer with packet/byte count wrong but showing
> 'Transfer Successful'.
>
> Here is current master on an imx8mp-venice-gw74xx board using IMX8MP
> EQOS enet dev:
>

> u-boot=3D> time wget $loadaddr
> /tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
> $filesize
> HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | |
> Packets received 64368, Transfer Successful
> Bytes transferred =3D 93198937 (58e1a59 hex)
>
> time: 3.103 seconds
> md5 for 48200000 ... 4dae1a58 =3D=3D> 69bedfe899148c43c09a98ac950dd0ed

....
> u-boot=3D> time wget $loadaddr
> /tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
> $filesize
> HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | | | | | | | | | | | | | | | | | | | |
>  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> | | | | | |
> Packets received 64368, Transfer Successful
> Bytes transferred =3D 26984682 (19bc0ea hex)
>
> time: 3.011 seconds
> md5 for 48200000 ... 49bbc0e9 =3D=3D> c9978ff116605a7729a1cb14ef51fc20
>
> Anyone else seeing this?

Yes, I am seeing the same behavior on an imx8mn board using the FEC driver.

I am transferring a 412MB file. Doing the wget transfers several times
in a row, I also see the incorrect number of bytes transferred:

u-boot=3D> wget test
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | |
Packets received 298387, Transfer Successful
Bytes transferred =3D 432013312 (19c00000 hex)

u-boot=3D> wget test
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | |
Packets received 298375, Transfer Successful
Bytes transferred =3D 58355848 (37a7088 hex)
