Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C34C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 20:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DCD87971;
	Sat, 17 Feb 2024 21:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="L2sQ+DCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2244B87E75; Sat, 17 Feb 2024 20:25:37 +0100 (CET)
Received: from sonic308-20.consmr.mail.sg3.yahoo.com
 (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F207B87DFA
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 20:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708197920; bh=EIqs9T579BSp/SRFzeUXo5wGKwmvWzgp80KcXKrp11I=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=L2sQ+DCNsmFaG7PF7koG/VDTENpnXuJzk9iDV9MvV8JWBWG48tvpR7i/59PMcKHXrhW8fIEFNi7XZod9d6xNBqFfBa7xIGC5nWA49VWo8SqOd0T2o4vZs9xZLXkyeJt7sqc4bwsCe3Dl7GD6bSGUG/CJltPC1vhkVPXc6zpbawnWGov96yQ19kaB0PxUF32XtUDWPfVCs+ArAo0OfGIy3KAZHD+Nw8ipSWvphpYylewqB05hvBHPW1lqhb/D7yU7BpguZ1VjotfgNX98vsP3nyZEhXjDjC3NScjZJUIJznZpxAoxTtgkdw4QLnZLOXfo87PPioyI6M0QB3T5MLmvUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708197920; bh=P5QaXiNncY5KIUseWP0I90Dk8mrK4fU1BwjHJb4pxoO=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=Fs8KQZZ/EPKl4MaQGjC+Jyl6dCx/W9ok3n9VYBtAte1v/yKx+RTRzipKil6vMBUMaPTGlbC4cOvLIEOlcCSiq+6YAYyFYkfhBXVZ6KzICR+EAfXxbcIeoMcn1OjIxbyuCbBTsbuSHyC/W0e6B7YGw9deJDaMboNIHxHF6BtMynP7JNCzMcBuGhdjT6eVZf7iXTpR9TtSilBcLdD4UlUO75YElnKYUaeo6GSeNdawd3wHe1nta4txG5145DFg1HrqPwIOUkG0PpmA5nVfVgm1yX+iw4yrTYYWMbcGb0zwVMbhY+9GoGF0YguNxdvrLr8iASc4qBYmh+QemF5U3pwtyw==
X-YMail-OSG: vBvXtY8VM1nGin1nRUyh2lxxCw6MXEFMgBiu8noMUu0yIi0kveL2I4yfkpJWln1
 9phu99LoKI7HViAL7T6lnvgNFIpsof0aFs8mDnBS42Z0Pyxsl51Jfqkai_84PjyM2RpY.AVMmfub
 E2nrz0B_1C.00TtF.EURQUQ3qJRmfzd3icDVLMe7ldrBuC8kdJ7nzw4ElvMLe0MrvEBmRqjLa_xT
 kBaXzBXhvj44q4eu67dyNKLRSR1HO3jCtINjBLsn2vBzL2oijeFtaBbizO2pvu1KGYCXBSImD8jD
 sYZYZlWr57duS.tBjeH9F1_DZrQReNcEiL71xABrHMkldjoRLUjZOCe.ZTEE045UtkJAzsi2volv
 n337kg3X3DvbW8tsnRtMu8j2rLnxZzELoaHQ9hg3jp2lwgGQEtNWYe7h6Rn76TZxTnMGi3pH5ux3
 3e50IpGfVlAaWNqEu61n4.6AMRY5QQXyUFl2fXr5_mW36WEYXeks2_rKhy_EKMzbdPmO91p3l4KM
 9F7Kl49.JxzvdtJdGGe9vu4xDzRBXCpRkgQiNve8JTEkLaHZbgHv4TuNFg7Y2xKxYdnylOZKzzTz
 C9kr6YrwMbl3T33GWPGav5HSLEIBU2DTCk2qp1GMLbbAHW9Tyd6.oV6MNjw7vgyB1Mh5hQGjJeSJ
 VPCpPmBAriQyrMlyvESYElU0y3Fawa6Bjgz7klccUp68.0mLfYyh5QC5PJ1xzrKmBB_Wnw_.lFOK
 JIPAsOHYtmMgA4RRZXlBRQmqcaFI7FAjZ813_Bb30mZA93K5xeQiXVvFlHxXpL4ysnO05bYfZhd1
 BsgIbXUBZ.AQByw3VMsXDZGc6H.Ch_.dJ0rl2uJ3Iyy4ZBkiAxHoqGU4.slgH91VgBt_hCZVnZT.
 xI1kPA.aY5AGy5I2WRE4VkS0oB3yk8XROh85ScSaWTWHO_N3NlFdUpLMD48apO8zxvUgtiLkN7eT
 2BpfqQfabdrfeNyt00Wc6YKKRiVpnWTEXfLAX8Zqp6ao6Jr2yROUA2ZeGgIbcZVhmgmFQ57PzkiR
 mdk.R_GtaXKe.8kYDA8qSqH.SaMDjV8lrKO0U3lckepMY_c6wbqmjWk5PD8qM0Gx4K1CYoA_vCxC
 UWrbbqOqdZU2O4527_btS8NWbgVgh72pr_iVUtp0NLcuGRFghKL.zgNYEm1kAFPp4RKq5Irwa2ez
 7faI3_bMzhkA07JP_HiwgOXrm9rnd1hOQBhloPX2vpVDp8EUvxTEXjtJXCC2VRCsBHspg7RgYXmY
 jNkDZA.OJO4sVB3WeilTetaLznF0IjuWHQ6ZVdfBEM9zz_sjRzKdsJtzHouKAk_OPXVaOXGWNzRz
 fkrEmsOcPr_dCntcWL3jbPKSLU8tGF6M3P0ErpBgAP0iNgbr.Upxhra70b6FRa.XQAQRRuNFBNk4
 yHjzfzn76zeKT8P0_XouO0t7pdtlhSuFx4c7up73OULfdEX_Y7OLFFRUwXKBwshaZT7TQLE1JvoQ
 ImLm2BZaRKrS0MgVffZozpSm.9cn6emfqkWNPSobrtU5T.P73K8mtP8lV_Gk9RojcNYI6UTWPlR9
 _eq2MYFm.ujM5EvHkuxH4IMnQJXk6R3rMu.LBFxb_S.gXP2oiT.GJcoMFRyXCTqtxHv0656lS50Q
 JuJ9zEc_6jnt4jx6qGfi93VsLGp2h6FGdr4vBUs3QnqyDS.E1ncQGIoneSlw4Egc3LEsddpcXPzr
 yZVs5Ci8A_7C4RKTxhOSQeyJJK6zAFqoGtCg0MjnCy7SAnuKnpbg0otpL47IvjuKuvn9ov3JnX2F
 WRF7ueXSI9O6R.jApQoR3XZJSuKi10SmrZU9BtWfUVOf0nmNArijccYGYaCaK_9mDHI0Qjwpyv3f
 WlP8gZdRRAectXqmN1BDM8614MwnSRuxlH6n7TvHFAs8mjzAP4fEreUBfU83.z1jP8TD.TOMzvSb
 ici7ObuJ13ocWt6kopJ9_1EOYdNxYuggthT8cnzFlqwFcutqJNrIB.IvrIX4R9SEv.4kQuJSM3Ij
 U2yD9if23GLdNLx9VNPC2A0wZpcuOOEYCn8n_XAKs74MLc2t_ZZUwp0T.K9bnVkcwUqFJJlcu62Y
 h.4K24qx3tGOEwSKN50gxPJcZDntIMtghSIVZlrjowAo8wniMoO8CVn4PnmAYUFBokm5BiuW.d3w
 rark34nwVwv31VaCBntmxx6VOjCClLJ4gGS16l4N0KAUPa5CJ.xmZFPL4sqHzvB.wQsAMXaqQY76
 uxyK8F60FG_rWeTqHo4iUr9nQN4E0whO9YxQXi6lKBuyXMKnB4d8itJk7W3PxOXjgitXPjC7HU7w
 JKIhtWZET8gO8CACwLsUdNTzgSmTb
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: 83c14b9e-56b6-44be-ab2b-07c7270d7b13
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 Feb 2024 19:25:20 +0000
Date: Sat, 17 Feb 2024 19:25:19 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: John <therealgraysky@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <927582348.2068714.1708197919275@mail.yahoo.com>
In-Reply-To: <DGgjhERuQGB1Y5hPRvHb9voUNFMnLh01k7vLy61hTmLJ95fcKvnDP_AmTzTBA0jBbmDNXRza4jl_KWr2UrSja5RLGnFveMiWGXM3Mpk8v-E=@proton.me>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
 <1031326949.2069496.1708196119886@mail.yahoo.com>
 <DGgjhERuQGB1Y5hPRvHb9voUNFMnLh01k7vLy61hTmLJ95fcKvnDP_AmTzTBA0jBbmDNXRza4jl_KWr2UrSja5RLGnFveMiWGXM3Mpk8v-E=@proton.me>
Subject: Re: Booting RPi5B with latest git
MIME-Version: 1.0
X-Mailer: WebService/1.1.22077 YMailNorrin
X-Mailman-Approved-At: Sat, 17 Feb 2024 21:17:46 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 yes , I created new config=C2=A0 by renaming ' rpi_arm64_config'=C2=A0 to =
rpi5_arm64_config.and edited the device tree to bcm2712-rpi-5-b.dtb. Then g=
et get the dts files=C2=A0 from=20
linux/arch/arm/boot/dts/bcm2712-rpi-5-b.dts at rpi-6.1.y
)
It gets booted but still need more controllers( ethernet)

    On Saturday, February 17, 2024 at 11:17:12 AM PST, John <therealgraysky=
@proton.me> wrote: =20
=20
=20
On Saturday, February 17th, 2024 at 1:55 PM, Jojan <jjvazha@yahoo.com> wrot=
e:

> For RPi 5B you need bcm2712 device tree . RPi4 uses 2711.
> So the e rpi_arm64_confi does not work for RPi5
>=20

Which config target did you build or did you modify rpi_arm64_config?=C2=A0=
 If so, can you share the diff?=C2=A0 You mentioned modifying "the config" =
in your message below.

> Also make sure that you have the changes=C2=A0 discussed here.[GIT PULL] =
rpi: updates for v2024.04 (mail-archive.com)

I built from the master branch of the github mirror.=C2=A0 That should have=
 these changes incorporate, no?=C2=A0 https://github.com/u-boot/u-boot/comm=
its/master/

> Iwas able to get the git (https://source.denx.de/u-boot/custodians/u-boot=
-raspberrypi.git=C2=A0tags/rpi-next-2024.04)
>=20
> and modify the config to get 2712 dts file, and able to get u-boot.
> [GIT PULL] rpi: updates for v2024.04
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Saturday, February 17, 2024 at 08:36:22 AM PST, John <therealgraysky@p=
roton.me> wrote:
>=20
>=20
> I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot t=
he vanilla kernel package (linux-aarch64) with the latest uboot-raspberrypi=
 (2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my R=
Pi5B, it does not boot. I only see the "U-Boot" submarine logo in the upper=
 right of the screen/no debug output. Any thoughts are appreciated.
>=20
> I built u-boot like this:
>=20
> unset CFLAGS
> unset CXXFLAGS
> unset CPPFLAGS
>=20
> make rpi_arm64_config
> echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
> make EXTRAVERSION=3D-2024.04rc2
 =20
