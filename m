Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC65C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 20:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC1387EA8;
	Sat, 17 Feb 2024 21:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="YdqpIgZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F8387E7F; Sat, 17 Feb 2024 20:29:28 +0100 (CET)
Received: from sonic313-20.consmr.mail.sg3.yahoo.com
 (sonic313-20.consmr.mail.sg3.yahoo.com [106.10.240.79])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4534687DFA
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 20:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708198160; bh=rSpeFTceZN16Vpg8d7ZtjL7P6O4WdUdcsduXgLOwQV0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=YdqpIgZq1N+aqdRU0WqiI9/HHwgeJRNxTEny125JplBVmaJCSa1HuiiF7vamwgB3jirTHIl9ZxGJJEkLyGandxTFSxz5c4pACSEZ2NYzSf/xNut+BZMD0GcL94aCq/Z/sYWKI/pfuvpn1qh//P3Ucgxic6EjENFg3pmDTRQeZyODlxW6dHnZXFLJp0E/gC6rsyDszMAqKUhq7lm7snyq7jGDrvfICTtWZjPe1hiwS2W5amdiAFB2GBqus3kNOtv3ktW1OZ6+71lRqteKptFwpcEDQbuLmH0a0WSDBCrPPfP80ZmRauXxOHWD1bl2obl5eNOl4fHtjmMwEqaY2huTnA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708198160; bh=IV3X3JzLkSi37iCDDm4yBYig2T7IDgwJizYdFtX7MPX=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=IDi0scsDkwXwF/F7gtJ+GZG3ssPcx6Ehej2fh1L7eqNSjuIoBvyjYvOdyWIgVPMmwoNAWZ6FkQm+nr2W/w6Qy5XM+Jd784vu12tG5wokkiSzsyk0Desh8Efu1f2HmB2SecqvTiA5aoppMo06257T4R3bTiVHB+kF4FN/xEtysi+IXbnTvmbhwWVAaRTFLAhLTClprcnlH+9JbxCJjZgpT8/bIobWCGN89iVEyL2KBlyAA+/hSK589NSo9c3f//nMaFRi63VkUGb1/H7ZwT2gZ7es+PMoIYPqo4UcUcie/qYhd8liUKHglzSSJpI/biXvcfdORcgWV736VD0K2BTCEA==
X-YMail-OSG: xHoGGMkVM1mz8stnaaUNVDIPyCNwHuvOduYRXWYcoYcxdIBkL.2Ut8AbBTH1O0J
 CI31isFwhxu5iofp_EP7qmDAJNvKav2N1bAYoFvje6.Zg2WTo636gAd2FoLc.lDSKOj5hB0sQ39s
 VRXa1TM8Da.WXhLng8CEUCFhm8c99zntGZseUvvdDeeCPZt1PXiF4kGYse_OnMYd0ZSeWTJvmjWE
 b6b2pD.wkuGL.kXcICZbNQ7xhTfwA4hF__HgY7YuOJUnXnNcQ1rkcevPo1CphfKnW2z4_fylsqvd
 d7zOT.IM2QQM42_EWJzt.cvR8ivTRueIDh2jJ9u43NbJFDiiI3hyPfcZzrVq6K1Bruwz5M0J5DIR
 7NtlT6fTSuYmcS5gWClPkm6Em8TZx.kKj71X9lQkPxkCewb7VjGsi6OK_L4SMx8kY4cc_kQs6lao
 sSda7jtHyRzpjFjrYojYhzq1OJA2a9laptjOD5DqROnpBT6FqaQ44Cdq9ucr3HAsqmPThYpiAHqB
 4oeWEb9FbBRrUAFZ5mOqYQ.Eyx4dKTz2yvk4rfmMeJcAjPosR1.FZP8vv7vqnQumKIgG8e8ln2Rs
 GQqkXmiJC5Vpjde3uqokkEL7.VG5PRncnXvJhE84b3NrYWRPDHOy0.V0cUKgUu3PFmyU5M3PZ_zk
 F0EdTfa1pbeUFus8Lz9iIlok5XVA782Q6cBGaAtb7.vgNSzGqv8Drs5jAb6SMaugeKBcgVojcgcp
 F_y9Q46wjaxfV72dSoLV80DnbeIFVHj1CFI7jzkMHUt46RO008NS2zZPU._HFMof0rtYFXWN0BAZ
 Q7O02tgXLXN3KnAoiOMIySFyxsenfrbgXiRwpwXw4V66kMev97HtzaVq74crqV_Jg63YR8p.cm6_
 5lY6gxtVTlysV7p20M17kfoTYRsC4pvrVNMoORrXqIKoUmvFAZHjDPlrSn4wUfrXvbNvttE.1YgS
 ui_LMdTLwrP0yZ_RMJdKKHSOSl97W_yPjyidIxPVpp0qD9fi53xKyyZGQGicXXSC4sqnis1W7qpy
 32bR_Dx0NMs73uOGoGb2V2qt3IXk5rq_ebsXTBPH_8NxjjT4o.qcisrnpEmlxY18Y9ZFImEG4b8i
 c7eprzv26rF30YSyqFmXKxo3IBN7IOnWTowO.Ab_xg5Dl367t5Ks_BRIQ2m7h3tqLbfLiHkw0mDR
 rUPIbyyJsIuxpqRqcE.NSIn71v7wfu5psBvxuMTJ0tv5qDmNkXgBqJCaW8mI7oIWAWxlO.zEV0XA
 1mxtWt78u1VI31HAX.cfMRIqrFbXRkC9v2icEFmA6DeDyX5O79nc.VMHiBOcA1XcotUN_zPLwAJt
 ZDcKbuYPuQTXpk2QbEqyLv9.RypctcL90gg87fc5zTG62rh84Xvec75pKMmCdTapxF8VlaFc22nj
 dIH.idrNM.MEAozs5eaYCWmwo.S.K_xFZq9SCgpInnf5d0ZNanE4F4AeXoiZ5RTrsGVZA_v3VYZo
 twmUULHmtPHqx4j2j.un8MiPkRmvFeDuDDl0ZSJn_s7fX3p4rfdVjhndA5FBzhu9ixKOxc38TsnQ
 uresZ1KfvNmHSF8bX2D0qRN5LtrXAXk47FMozSIp33zVRrdg52kagxQQ3ByNMEqJxQM7eORlm6Nr
 Xo987gj3MnVUDHSecBk7qnrSYwJUy814bMsv2VeCISkPWaG9mDHEHs3cwMdAqCjRWZqXVpnZO0Wr
 egqS_PR0YMptZqi4GqHh9uKfiQ72agsKbg2leM1qvzp286e8RGCn9CQpKpVtaCqTIVlHSl.2b92c
 pfDMsGtifdYSBRBC3kvuLm8f3DDIDX8_1WghqTtdX4.U1eZn_nFlfVoagW8faEQr6h2ATcHFlekJ
 zhFf.SQkyvC45UJki5SP7Yvg.JoXLtqC67vshmmlZ9ujh38J3_imiPPq0kli5mztPUdtyt1KqkWl
 721nstNRtpxSG.ikaYRTpHurWG25Jp2kyszczF6f5PwwsuxjXeUYGBDgM9JGiAGLhEjUWIkgWMq3
 yCzteROtqCmriQWah3.RAEaGgtXuP6ihkQ5AXxsfxfUbIoeoaebCT3LBfhrKumCu0WsElL52uVrS
 CHyZhxawu_0s5hTIW1FOi3nBDypGvvfvgflTQ2HEOuxPvmT8T9Zq6.b7yGSBEWsb9CrQKD6ZlJ0g
 dhDyJbHjZiL5dJSDYG9FLpLVRlw4i.3Io5b7jFPLyLzHWPLIGKdjWVXcXvEZkxeX6HNAy4_MNy4p
 _oshZH2h0eGpvTtbX5fdddG12kRe8CUlopd9axNvreKUz4oHRkGj340nXTYH7uTgWNY6c8Q--
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: ae9fb012-cae6-46a3-b539-df54c5f67870
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 Feb 2024 19:29:20 +0000
Date: Sat, 17 Feb 2024 19:29:15 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: John <therealgraysky@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <1128990886.2066109.1708198155684@mail.yahoo.com>
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

 You might get these build errorsError:arch/arm/dts/bcm283x-u-boot.dtsi:42.=
1-14 Label or path uart0_gpio14 not found
Error: arch/arm/dts/bcm283x-u-boot.dtsi:46.1-14 Label or path uart1_gpio14 =
notfound

I just Just commented=C2=A0 out that.

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
