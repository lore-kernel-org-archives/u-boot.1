Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49567C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC04487E95;
	Mon, 26 Feb 2024 11:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=ml.lawnick@gmx.de header.b="uJiShV5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4452C87E52; Mon, 26 Feb 2024 11:40:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC6B87EB0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ml.lawnick@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708944053; x=1709548853; i=ml.lawnick@gmx.de;
 bh=Gishh8dy8stmPNo5z2qcKFr13iXdWW04uUpNVDZI5l8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=uJiShV5CbzMYRXBBdaDX+XUSob4C2AYiAH0Xp21idkcv2umvcXBwvMmam5GLlAGG
 OCP2g0se8WBNJJdB8c6wppfJ3+GM11VIV6NE8Jix13G2EMThf+sdO+Ps09wSPIM8D
 czGic0FgcbJcto/8kUFqgPn5YB60cIzig37BHIdjnK27bTlR1am4zHyHAY6RkTWZl
 DxT2oOFYNbEe0RkX1yCc+RamWcK8g1reSuwJWHXlhBsEVD8CZ+gb2A01ZxuxzjOSh
 1YZ1zoDjsii+55SvtgeGVxGkzdo0rEqM1WuvwCWrV0jgyE9Oa3h7iMJxmQRS7kE3v
 09YGow1li+pEAq5DDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.9.6] ([131.228.32.166]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1r30sF3Mkh-00daiv for
 <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:40:52 +0100
Message-ID: <264cd9a2-b651-4c68-8b9c-c2ab8c25081f@gmx.de>
Date: Mon, 26 Feb 2024 11:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need help: alternative module inclusion - duplicate symbols
Content-Language: en-GB
To: u-boot@lists.denx.de
References: <cea4d88b-3341-4703-82fb-0a594f4ddcd0@gmx.de>
From: Michael Lawnick <ml.lawnick@gmx.de>
In-Reply-To: <cea4d88b-3341-4703-82fb-0a594f4ddcd0@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lJ8gtwnCeAFkAeT+CyCxXXkeD2/wVpbKwPC4m0gqvPtmD+2uNJn
 gjvacgu6r9fnf6WdVDQkZZarCd5yxN6eTSiYegQp0t1lmt91p9bG0IxsXRnk1ys6auZizxj
 hDwWH/A6tFOP//lyEdD3UMfexJ4KLMrziALz+XzqbsTj2nusXHG4rHy0I5smptpn99q2OZT
 6XO3WcPMfz6FHbmjFshVg==
UI-OutboundReport: notjunk:1;M01:P0:8J74+Y1T+UY=;5iNpKHuBPhJLmQnAJEgzKa1JoFd
 NiA+cRpSkFWh/V2SZKdOvJIYqvjRMlXL8N8vMx4pYbLhmpxoxuL6ROWgfdl/+oEO9gZw4AySN
 y5/SSDUPUYH/IpX0jktJ1EIQSTIbzDweWqEX9dT8vmHG2TIne10W8P7AMgtw7JUi1i2wC8FDb
 0reumKYr78H5EjDvbiP6BK95aYyii57Z+zr/bGoMmzV4lIcPZf0SH0LJzio4y2slo3ySw/G/R
 Vc27ATsI4fl1Afls0HxIwIu1sMjC5PwTBvvU7Jl+QqHoYizZZwl2DvlxUUIWTuacHsN4yQKBA
 hjD1DVYDU2K7ZSoRoBssvI8T0beTUAD1s7H53McG3pMQKa7ZBIJqtsn1GRueP8KEOCYvq4YWd
 5uw0Yw33cWVtKDbcS4YtTAsf/+0tRt231gfpHXB1OfYEU29WNGO2lSdvCfRzrp/ZThx4ja2hP
 ycy8dYHBsT2Yv51Dknit8dPTgW6gXJUyHEqZFYGcug1THnJYh1BNBsGGHulqXuBYFjAzcJhGG
 nsqdMbdZv/FwEHTtK3pUiXwnhALOkdpii94kyyzsC55hPPkxZxQEZ+jGEnQq+EaiZjTZJGfs2
 dSArVoQLHrsH35908c1NGYqpW9WnnKLbcJF2MxbMV0KEOokem8k9rjFKGxCFLsCyJooiYBl/9
 nAEwUdo6Nvj05gh0L/klPSg9J6TQ8QeZTVd1GlUnnf5zTJrJXR6qgCRjyRiL6NkOd5MjwfVUJ
 wxqAejym6+S0/CcW/7ATrIFpV813+jAt4hBDovgVgnAhwIVA3W3b0V8im7FXaiRwZNRw2oomv
 B6nu58DI6RaJ8Mtbru7lsB9mA/qHxgv9eDFtdMHUjb2PM=
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

Sorry forget about this, wrong mailing list !

Am 26.02.2024 um 11:36 schrieb Michael Lawnick:
> Hi group,
>
> hope you can help me:
> I have modules pci_fpga.c and pci_fpga_emul.c with same functions in
> them but different implementation, one for the real device, the other
> one is an emulation.
>
> What I now want is being able to include one of both versions through
> build command. I started with this:
>
> Makefile.core.def:
> ...
> module =3D {
>   name =3D pci_fpga;
>   common =3D startlib/board/pci_fpga.c;
>   enable =3D efi;
> };
>
> module =3D {
>   name =3D pci_fpga_emul;
>   common =3D startlib/board/pci_fpga_emul.c;
>   enable =3D efi;
> };
> ...
>
> and then give pci_fpga or pci_fpga_emu on the build but then I get
> duplicate symbols error.
>
> For using different packages than common like this
> module =3D {
>   name =3D pci_fpga;
>   pci_fpga =3D startlib/board/pci_fpga.c;
>   enable =3D pci_fpga;
> };
> I could not find means to get pci_fpga included.
>
> Same problem if trying to approach it via different enable flag: How to?
>
> Can anybody help? In docs I couldn't find usable hints.
>
> --
> KR
> Michael
