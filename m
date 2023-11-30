Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF8C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 13:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007F6875FE;
	Thu, 30 Nov 2023 14:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qfUwJUqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DB487650; Thu, 30 Nov 2023 14:39:06 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F09875C3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUDd2tc058278
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:39:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701351542;
 bh=fDWELlKN7E7r0WUzmGxPRuiTMFjKIFTsG/tKTkWMRQ4=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=qfUwJUqqgkG8Bed1Cxu3eUDPpcSLsvgYgjIch20grWcoFtz5p/haGX631SramQeoF
 wtNITO/nrh2twUE8EqqiE0hHqjMGZek7rMlSzEVXl0l+4P7upuE3wjcQnbXmIpG+zw
 Rw5pUwpdlVoakPHO+Kl1KhuXKHpRb0K7NS+EZOo0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUDd20P082652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:39:02 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 07:39:01 -0600
Received: from DFLE104.ent.ti.com ([fe80::44c:e883:6f6f:384d]) by
 DFLE104.ent.ti.com ([fe80::44c:e883:6f6f:384d%17]) with mapi id
 15.01.2507.023; Thu, 30 Nov 2023 07:39:01 -0600
From: "Mahaveer, Vishal" <vishalm@ti.com>
To: "Menon, Nishanth" <nm@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Raghavendra, Vignesh"
 <vigneshr@ti.com>, "Brattlof, Bryan" <bb@ti.com>, "Bajjuri, Praneeth"
 <praneeth@ti.com>
Subject: RE: [PATCH 0/4] board: ti: Update to latest board configuration
Thread-Topic: [PATCH 0/4] board: ti: Update to latest board configuration
Thread-Index: AQHaIjK4yFNkZ0gh4EOuFWGsDspKqLCQoJGAgADDgfA=
Date: Thu, 30 Nov 2023 13:39:01 +0000
Message-ID: <b8970b574874418a8ac179533548bafb@ti.com>
References: <20231128194024.20809-1-vishalm@ti.com>
 <20231128211645.cfgktxv2yxsoibjg@hurricane>
In-Reply-To: <20231128211645.cfgktxv2yxsoibjg@hurricane>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.247.81.53]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

> On 13:40-20231128, Vishal Mahaveer wrote:
> > This patch series brings in the latest board configurations for
> > am62 and am62a device.
> >
> > Patch "board: ti: am62x/am62ax: Update virtual interrupt allocations
> > in board config" is needed for booting with the latest TIFS and DM
> > firmware [1].
> >
> > [1]
> > https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/log/?h=3Dt=
i
> > -linux-firmware
> > SHA: e891ddc65c55bfa7111e4f45834b7c26444dff72
> >
> >
> > U-boot boot log -
> > https://gist.github.com/vishalmti/6b38fb80d557478131d5aaed5aeb3596
> >
> >
> > Vishal Mahaveer (4):
> >   board: ti: am62x/am62ax: Formatting updates to board config files
> >   board: ti: am62ax: Add C7x resource allocation entries to board confi=
g
> >   board: ti: am62x/am62ax: Update MCU GPIO interrupt allocation in boar=
d
> >     config
> >   board: ti: am62x/am62ax: Update virtual interrupt allocations in boar=
d
> >     config
> >
> >  board/ti/am62ax/rm-cfg.yaml | 522
> > +++++++++++++++---------------------
> >  board/ti/am62x/rm-cfg.yaml  | 481 +++++++++++++--------------------
> >  2 files changed, 396 insertions(+), 607 deletions(-)
>=20
>=20
> Sorry, but this is completely confusing. There is no documentation to
> indicate there is backward compatibility break in firmware. do all users
> need to upgrade firmware along with board config updates?? what is the
> minimum firmware version that is supported? is there an ABI version check
> that should be enforced?
>=20
> Is there absolutely no way for people to use the new firmware and keep
> their old u-boot? Rather disappointing to see backward compatible breakag=
e
> occurring this stage of the device. This is not appreciated.
>=20
> Please see if you can fix your firmware to maintain compatibility (as has
> been the case for year+ now)

Understood the concern. Sorry about that.

Will send a V2 with the virtual interrupt patch dropped.
The firmware will be updated to have the change reverted that causes backwa=
rd compatibility issue.

>=20
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34
> DDB5 849D 1736 249D
