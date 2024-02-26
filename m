Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C2EC54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A927D87DAF;
	Mon, 26 Feb 2024 11:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=ml.lawnick@gmx.de header.b="silWj/qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D7487CDB; Mon, 26 Feb 2024 11:36:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC5D87EB4
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ml.lawnick@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708943796; x=1709548596; i=ml.lawnick@gmx.de;
 bh=78woSTqt2A0HeC8NFaPI6mC04bprO0D6fuS7H3cSP8A=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=silWj/qGum21EChoavZI94c91ysCvGgQS626kUanS+7h9KvfoYQ7kY2QZRh3QKsM
 PCacRXcitjkkgzYtpzs91J0dCwJ1JNo8S+RBgZuwMQ2VAomQU/6ZmyeeRw3KurX0a
 68rlgaZ69djqdS3kTvb8tIIL9JEb1YtYVteZctmZj96y/sU1ZTJFlxiF1lfkhKohD
 cV2LV27P/CIRqoTf5usTEZO2GxjJDFmrtGXOgbCjyCxODDGg5sTD0ituazqFsWK76
 CIOcXsNXeWFmOupKgwEWgMClxq32PO6/kK2LVx44hTECPD7xANCNowNE45hJ0hCoa
 ONK+pyq5YFPk1PLRng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.9.6] ([131.228.32.166]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1rZ4hL46Cq-005Z0V for
 <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:36:36 +0100
Message-ID: <cea4d88b-3341-4703-82fb-0a594f4ddcd0@gmx.de>
Date: Mon, 26 Feb 2024 11:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: u-boot@lists.denx.de
From: Michael Lawnick <ml.lawnick@gmx.de>
Subject: Need help: alternative module inclusion - duplicate symbols
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fTNKj2IDq4fgKNfj03i5zGNtzNsbxe1/DZbP2FUBHACNa4g06a
 dBdejc+93LUbJsu3F84Q4mBRRYg25FrwY9OA6//m3Up47zp4oOonFCqkcus+ng+8HR15ilc
 lyMoSTV79UjAzyoEk8nzAUmk5mdm4FbEdEVwFHxqmKkwPWPzo55uTjgNDKL9Ww4luyVkOFR
 vdDc+vEt3lEvzTh8Jv15A==
UI-OutboundReport: notjunk:1;M01:P0:KIiOiZ2R07s=;ip8fQY7b9epWyOytMi6rs/SVISk
 Xa2ttPk2V0IRx0ShfYNZTBIJ/JtXjDEigKCSCWH5OYxABbcVy/8NHeMw98VdgFi8i2jdrQO5I
 I+uwv/rxH6AlMFT7OZbTrxqgRQ7d59gdFVHDEhQKdvZvJAPefJE8vdA904kY1NIDIN/RvFFix
 rmyq8ufbDkD3gwh8CaupIklRSEFTvWOIDrrZYaIV/WNblXUT6ydQnPzimM7zCwMpAylDIF7Ku
 RcqYVVioJyAo/9QMBe2M3FQblwbchTT8kvrSBzuFfMhBT9SDmt8/tZzXvryca0ISRRL0Gob9L
 aYOGQ3yXTVh/ottK46Cb/yifxRBcaQ/Zqh6K0eMnmO5stQ2wKuxWoyyWcSb0tGDMNGWbC9zeF
 sNwMGBT265fFVEFlvxA/fIg/KdnHRBrvHNaO1JlzZ6r2BDOifCU0js1RT8KznrxgeN5F+w5Ox
 +GU3o63s417rBN/fLtd+xH4agx47gMKUnNfKqPdcXyvpwjZ7P7F5IbmOANae7fXZ5lHdDFSIz
 GGzI1OM+EJE23LTbO3fc1YedPYe8RUROD+F7t3VAPTCt2x+B2gGjxGGUhcP3EGMjS80nz0aEB
 JS9DZUwkusaaOO2RMpxrSDG6wzH7lptf7Gv4oD2asBdvF70Fv8HTTaLUlo3Lj+KvjFQoONv9Q
 wdp0J+2U66YQUHYpP7Cw2B68CIG4wRZQU7iuVJ68SrvG1duA+RiFIRrj5F3WadGVRdwRGEokG
 4+FJGtCznmeIXYqHEzJEUEQrdOkLxV0zbl+W+sJ50aYdKNiXx1PRn/DOIyaDZaLTrRhY1aSwe
 Rqw2CVaSvjB5+mpN8SRAOEemTFGAjUZbhLyLyrZG9HDos=
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

Hi group,

hope you can help me:
I have modules pci_fpga.c and pci_fpga_emul.c with same functions in
them but different implementation, one for the real device, the other
one is an emulation.

What I now want is being able to include one of both versions through
build command. I started with this:

Makefile.core.def:
...
module =3D {
  name =3D pci_fpga;
  common =3D startlib/board/pci_fpga.c;
  enable =3D efi;
};

module =3D {
  name =3D pci_fpga_emul;
  common =3D startlib/board/pci_fpga_emul.c;
  enable =3D efi;
};
...

and then give pci_fpga or pci_fpga_emu on the build but then I get
duplicate symbols error.

For using different packages than common like this
module =3D {
  name =3D pci_fpga;
  pci_fpga =3D startlib/board/pci_fpga.c;
  enable =3D pci_fpga;
};
I could not find means to get pci_fpga included.

Same problem if trying to approach it via different enable flag: How to?

Can anybody help? In docs I couldn't find usable hints.

=2D-
KR
Michael
