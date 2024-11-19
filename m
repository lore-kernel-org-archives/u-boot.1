Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72621D6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 22:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D4E88DB2;
	Tue, 19 Nov 2024 23:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H9e5You7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5F788ED9; Tue, 19 Nov 2024 23:48:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A76A88D7E
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732056501; x=1732661301; i=xypron.glpk@gmx.de;
 bh=33RIPDFTuLbOFhw38k5ibeu6U1RK41Kxkmx5pqji6QM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H9e5You7zw2M4WJ5Ypv9D3l/mWBWkyxTQ/pXcZ3v7D/wEbnz1o+gecuABqZluEmP
 PRzSewGc6a7JPpBb3FI0bOm1qg2hnYKAWKkQzoO2+cs0xrDKfNG+ZOnUBgP7B7sJa
 T9WJlcwHglGpTHrDkgkO1RKJn/xTNPn2wyTXXx6AxE+g8O6BYrZguK/xekD5mIroW
 SYI5Ak5ZVnTbytIRXU76FS0VxZ15AKAfCVNPBzfYnuDnKJ7nFWEqIk1YJzXTCss7l
 0LiodjIGJay152QH58+hyW9mH08WH55Pq/IG9iLy/nHZ2yW/yf3Bbge07pCPo+r19
 23OGv4zN3WDEeSJZ8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1tUvJN3YO1-00Rrh5; Tue, 19
 Nov 2024 23:48:21 +0100
Date: Tue, 19 Nov 2024 23:48:17 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 alpernebiyasak@gmail.com, ada@thorsis.com
CC: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: Re: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
User-Agent: Thunderbird for Android
In-Reply-To: <20241119222837.27550-3-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
Message-ID: <2BD68232-B09D-4F0C-9969-B90230A6FB90@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ma0go0Lw9CXc0ZPgRFCA/Dp8DyB+dNOwJSbujh0y8/MbHq0/d0i
 1u16bU1NavKKjo4QDRqQgMt5vc1DW3aW7lJGptyVxrNYYBD271L5YnGRrWNLVQpteByyIR2
 i/dRrl3SYdU7Fb5Q6eFHSK8VfiotJ+5yYnyMTj3uuk8GbXfnY5xpjEClqfOzjl1/Is9aD2a
 XeSJqdb/z9HQohRtrTekQ==
UI-OutboundReport: notjunk:1;M01:P0:leZGsqiO4g0=;KVrZS2nqrwHrn76N7hkRaAafEGS
 HawcYv2PE7RzT5kwrgx9cRT/FtIC2RICmCJFXkUBNjWrOa7nsQSwkrrSFIsTWx8f+dUU+7ELN
 4SXIsyZ86lH54HTYw1VOG8kzDVW6nUeDaUtQXMPe593wLrvTgiDmj2pwTnGTrL8k8/7aNYzCn
 P5nUaya8ws8CQW/prq9UvjK++byBAoMKPt8jRYPer6Q4fPutC0E5ktaB9icSsOeaPAgZ+aP+v
 fk9tHCeozaOOpJZAtnkX42CSUepZM+TLzCVxGelHxxvwcgMIVjMIbB/bh3/bzc6qmh1FNK6ir
 FvCGWRfn6zCiEYHaXDMSY2Xhik3HEfPbzjT34EpIK5sGXWwwJqZ2gtc37EE1ERn4+5snGlHC3
 GoEInRNx++DDtPRGeUnVWBv2ooX8DmYHbyCbOgqeNMHciKxbckgoYS0mEcr1XB84vYikY++1U
 JrUrmRytHaQnwWCYr2Ox0pv96vXDijV4AZrGGCXi3jgrja/KWFPlTLcyU/rI97PrpfvS9jB9q
 DC8a5mkuuzKdfEA6JKd6Fu7EnFHqkdpEB1Fe15OzH75HJBzZ86SIzU5+ESuYb9skuiqCW2FOV
 Oa4YeYK33LpbodZK0xOmw+hLE4E9abKmAVFxCMeFzdwyCd+5zmNoq05hXlx2j/WNmKemgSH7i
 GMgmBoFOqAnv7fqDVdNnHK5FXDSTHp+U4e3FJo5aljJ+uot7weq79a294ThI6HOFBReW3d+FB
 Xlhy1h83lgqFjlglR+RyAnHja/t0CplWDPueuio6vJrxlKeQR5WXZaHuEP8n+5HLGeLiCbin0
 laNyuTyy274eYUWsy4ACTWAVyOExP03txvyvZ1KxTZdoc8SaSVcJYPq4++4Qf1Rd6ttMra3j/
 gIxywx+9QHyj1mcdUDIvOBQ2MIhOFAmQa/Wu8b27bnoin5sidTYzhVmnE
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

Am 19=2E November 2024 23:28:36 MEZ schrieb Lothar Rubusch <l=2Erubusch@gma=
il=2Ecom>:
>Fix some typos and duplicate words in gdb=2Erst=2E
>
>Signed-off-by: Lothar Rubusch <l=2Erubusch@gmail=2Ecom>
>---
> doc/develop/gdb=2Erst | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/doc/develop/gdb=2Erst b/doc/develop/gdb=2Erst
>index 4e359c7f22=2E=2Edc38435227 100644
>--- a/doc/develop/gdb=2Erst
>+++ b/doc/develop/gdb=2Erst
>@@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a running =
U-Boot with GDB=2E
> A common way is to connect a debug adapter to the JTAG connector of your
> board, run a GDB server, connect GDB to the GDB server, and use GDB as u=
sual=2E
>=20
>-Similarly QEMU can provide a GDB server=2E
>+Similarly, QEMU can provide a GDB server=2E
>=20
> Preparing build
> ---------------
>=20
>-Building U-Boot with with reduced optimization (-Og) and without link ti=
me
>+Building U-Boot with reduced optimization (-Og) and without link time
> optimization is recommended for easier debugging::
>=20
>     CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
>@@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual=2E
> Using OpenOCD as GDB server
> ---------------------------
>=20
>-`OpenOCD <https://openocd=2Eorg/>`_ is an open source tool supporting ha=
rdware
>-debug probes, and providing a GDB server=2E It is readily available in m=
ajor Linux
>+`OpenOCD <https://openocd=2Eorg/>`_ is an open-source tool supporting ha=
rdware
>+debug probes and provide a GDB server=2E It is readily available in majo=
r Linux

Thanks for the patch=2E

'tool' is singular=2E You cannot use 'provide' here=2E

> distributions or you can build it from source=2E
>=20
> Here is example of starting OpenOCD on Debian using a J-Link adapter and=
 a
>@@ -124,7 +124,7 @@ with the command *bdinfo*:
>     Early malloc usage: cd8 / 2000
>=20
> Look out for the line starting with *relocaddr* which has the address
>-you need, ``0x27f7a000`` in this case=2E
>+You need, ``0x27f7a000`` in this case=2E

You is only capitalized at the start of sentences=2E

>=20
> On most architectures (not sandbox, x86, Xtensa) the global data pointer=
 is
> stored in a fixed register:
>@@ -144,7 +144,7 @@ riscv        gp
> sh           r13
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
>=20
>-On these architecture the relocation address cat be determined by
>+On this architecture the relocation address can be determined by

On these architectures =2E=2E=2E

The rest seems correct=2E

Best regards

Heinrich


> dereferencing the global data pointer stored in register, *r9* in the ex=
ample:
>=20
> =2E=2E code-block:: console
>@@ -153,7 +153,7 @@ dereferencing the global data pointer stored in regis=
ter, *r9* in the example:
>      $1 =3D 0x27f7a000
>=20
> In the GDB shell discard the previously loaded symbol file and add it on=
ce
>-again with the relocation address like this:
>+again, with the relocation address like this:
>=20
> =2E=2E code-block:: console
>=20

