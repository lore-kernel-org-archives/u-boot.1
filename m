Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8AFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 05:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DACC84099;
	Thu, 30 Apr 2026 07:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Y+SP1K80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFBD584198; Thu, 30 Apr 2026 07:22:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3BD180433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777526526; x=1778131326; i=xypron.glpk@gmx.de;
 bh=esW2PQWUSc3PgSH9cVzL95dw72qdELNqa95xnaynDdQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Y+SP1K80zvEHVizK8PZSUpy3RGJflycXEhpuAr8AnFXN7XsfgR9NXojjYlsNbMz8
 dni4eZWG8k0MixyPiLxKpk89XVDWZbhmwWaZdVWPuZSrdM+vloZrkKQ6QKXONNRpi
 qXpgR2J1C2c3C08KI6qYra/KLVXw3mF6F7PpSVJmEs0YI+PzQS9Zo3cEAvE32pQoz
 JxL/NQQcS9FRJwrr8fOsxCoJVURXo+qSC9etRrtCeAzMGSLBToaP/oiDgJ2r07eMh
 gOLipwvdYitUFtvCIsaYkMPTloEh4oPeQyfn5kgyFMtHXMfvEp3K6dwnDz4dnMrqp
 x0RqKaGTnHgAiKNQVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1wDNtc0kM6-00BViG; Thu, 30
 Apr 2026 07:22:06 +0200
Date: Thu, 30 Apr 2026 07:21:58 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Yao Zi <me@ziyao.cc>, Conor Dooley <conor@kernel.org>,
 Raymond Mao <raymondmaoca@gmail.com>
CC: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_04/16=5D_dts=3A_k1=3A_import_p?=
 =?US-ASCII?Q?inctrl_dts_file_from_upstream_folder?=
User-Agent: Thunderbird for Android
In-Reply-To: <afKvzj0yoJ85-5VI@pie>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
 <20260429-glare-anybody-16c98d01184e@spud> <afKvzj0yoJ85-5VI@pie>
Message-ID: <6562F314-D379-42C4-8371-0184E48B8592@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sRFRDHTShzx5uszj40dyAolFGk4yzZasvf/AOjRx4+cJHcJpHgO
 eDn45ocX2EfbtoG4MR7hA+Vgua3CFkwV5snaO+ZRueiQbD/XWWbTSYH6qflIg0fBRt0pTPw
 eOaf35lkfb4dp2p1s/JYSKWh9OGn1cNSmavbsWkPox8fgPBCakiT9B765QLfqO8OxIJDYPP
 6yU0GNgWIhKDYPAN6EJAA==
UI-OutboundReport: notjunk:1;M01:P0:AX0Y0Rh/QlQ=;mnxWwtT6pqBCuHGj/E1ensP+toS
 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
 UgyJjA==
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

Am 30=2E April 2026 03:26:38 MESZ schrieb Yao Zi <me@ziyao=2Ecc>:
>On Wed, Apr 29, 2026 at 08:48:39PM +0100, Conor Dooley wrote:
>> On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
>> > From: Raymond Mao <raymond=2Emao@riscstar=2Ecom>
>> >=20
>> > Import k1-pinctrl=2Edtsi from upstream folder=2E
>>=20
>> Why doesn't the platform just use the upstream dts directly?
>
>AFAIK, U-Boot's reset driver for SpacemiT K1 predates land of the
>kernel side driver, and follows a complete different (and to me,
>broken since it combines completely unrelated MMIO regions) ABI=2E

Shouldn't we first correct the reset drivers and switch to the upstream ke=
rnel device-tree before adding anything new? - This would reduce future rew=
ork=2E

Best regards

Heinrich




>
>U-Boot's version,
>
>	reset: reset-controller@d4050000 {
>		compatible =3D "spacemit,k1-reset";
>		reg =3D <0x0 0xd4050000 0x0 0x209c>,
>		      <0x0 0xd4282800 0x0 0x400>,
>		      <0x0 0xd4015000 0x0 0x1000>,
>		      <0x0 0xd4090000 0x0 0x1000>,
>		      <0x0 0xd4282c00 0x0 0x400>,
>		      <0x0 0xd8440000 0x0 0x98>,
>		      <0x0 0xc0000000 0x0 0x4280>,
>		      <0x0 0xf0610000 0x0 0x20>;
>		      reg-names =3D "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddr=
c", "apbc2";
>		      #reset-cells =3D <1>;
>		      status =3D "disabled";
>	};
>
>Kernel's version,
>
>	syscon_apmu: system-controller@d4282800 {
>		compatible =3D "spacemit,k1-syscon-apmu";
>		reg =3D <0x0 0xd4282800 0x0 0x400>;
>		clocks =3D <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
>			 <&vctcxo_24m>;
>		clock-names =3D "osc", "vctcxo_1m", "vctcxo_3m",
>			 "vctcxo_24m";
>		#clock-cells =3D <1>;
>		#power-domain-cells =3D <1>;
>		#reset-cells =3D <1>;
>	};
>
>	(and many other independent system-controller nodes, each for a
>	 distinct MMIO region)
>
>I suspect we have to deal with the difference before switching to
>upstream devicetree, since I2C controllers introduced in this series
>do depend on resets=2E
>
>Regards,
>Yao Zi

