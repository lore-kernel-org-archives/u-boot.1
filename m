Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFA9C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 11:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5241879D3;
	Tue, 16 Jan 2024 12:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="wuMYxypi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99610879D8; Tue, 16 Jan 2024 12:21:23 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3736C879D1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 12:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705404080;
 bh=cgjMfWM/exvi7X5UE30iF9qp4JQjy8Lhtct/mysQw0k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=wuMYxypi0ytWrvspUzcLKkbbpI4OH/tmpiB9fENyG1dnGE83CEPEfcdYc6uR6mfP5
 9v5KvKjVJZrXys+mMdaOvx9hoar8F7idiKNqAZfLkAQEGrYLX82D6bsy9q14SGhrmx
 AZBY0ZT6+Bb335I2WB0Y014M1qh3MiPe/Ruvv+CknLcMsxt/NxrtJ3UnNWxWvR5YJE
 CdADlReHVw+8XEM2chkQm0Hk6vlDBxiSK1pLIxGA+dWBgcBrR6wNWfdm3EG3VdmGLh
 VfSKBaaozr8bdkf1nEGZqRvjwNxlAwtWHipy5yKJkf+P/O+GDVwNx40jII5cKoFljs
 J/tmUpy/m+wFQ==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7625537802F2;
 Tue, 16 Jan 2024 11:21:20 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 0478E9FCE6CD; Tue, 16 Jan 2024 12:21:19 +0100 (CET)
Message-ID: <ef70a0234a54aac0a34fd0e55df5b62a660f3ffe.camel@collabora.com>
Subject: Re: [PATCH v4 4/7] arm: dts: k3-am625-sk: Enable usb port in u-boot
From: Sjoerd Simons <sjoerd@collabora.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>,  Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,  Siddharth Vadapalli
 <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Julien Panis <jpanis@baylibre.com>
Date: Tue, 16 Jan 2024 12:21:19 +0100
In-Reply-To: <87bk9l4jf5.fsf@baylibre.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-5-sjoerd@collabora.com>
 <87bk9l4jf5.fsf@baylibre.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Tue, 2024-01-16 at 12:17 +0100, Mattijs Korpershoek wrote:
> Hi Sjoerd
>=20
> Thank you for the patch.
>=20
> On ven., janv. 12, 2024 at 09:52, Sjoerd Simons
> <sjoerd@collabora.com> wrote:
>=20
> > Enable usb0 in all boot phases for use with DFU
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> >=20
> > ---
> >=20
> > Changes in v4:
> > - Don't force usb0 into peripheral mode
>=20
> I know that dr_mode =3D "peripheral" has been removed as requested by
> Roger here:
>=20
> https://lore.kernel.org/all/054aa15f-05b9-4645-ab00-fac1be46dad7@kernel.o=
rg/
>=20
> However, the reason for this was the following series:
> https://lore.kernel.org/all/20230706-handle-otg-as-periph-v3-0-27e24fa173=
45@baylibre.com/
>=20
> I've spoken to Julien (off-list) about the above series and he
> confirmed
> that there are no plans to keep working this.
>=20
> Therefore, I'd prefer to re-instate dr_mode =3D "peripheral" here to
> make
> this series simpler and focus on enabling DFU.
>=20
> Would that be possible ?

If others agree sure; I really don't care either way (I wouldn't use
the port as host in any case), I only addressed it because i got a
complaint about it :)

Roger?

>=20
> >=20
> > Changes in v3:
> > - Enable usb nodes in all boot phases
> >=20
> > Changes in v2:
> > - Only enable usb port 0 DFU in SPL
> >=20
> > =C2=A0arch/arm/dts/k3-am625-sk-u-boot.dtsi | 8 ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > index fa778b0ff4c..67c9fa2bbc3 100644
> > --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > @@ -46,3 +46,11 @@
> > =C2=A0&cpsw_port2 {
> > =C2=A0	status =3D "disabled";
> > =C2=A0};
> > +
> > +&usbss0 {
> > +	bootph-all;
> > +};
> > +
> > +&usb0 {
> > +	bootph-all;
> > +};
> > --=20
> > 2.43.0

--=20
Sjoerd Simons
Collabora Ltd.
