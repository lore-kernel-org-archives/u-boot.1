Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F10CC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 20:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E87F87E86;
	Sat, 17 Feb 2024 21:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="SqxgSwqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D51F87E0F; Sat, 17 Feb 2024 19:55:30 +0100 (CET)
Received: from sonic302-21.consmr.mail.sg3.yahoo.com
 (sonic302-21.consmr.mail.sg3.yahoo.com [106.10.242.141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3971887DCD
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708196122; bh=/qTDE+nuN55kHLLhzoowqo0E37E1pXNosfu8L2f8DIw=;
 h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=SqxgSwqDl+TezBorezp6S7VDPd2ce1BbYMllTQNa8z2QQw7hz6sdkh5b2wQQx0yBFDWqgb/c6ouXR1vI+kbB6RAGTqAT5asIndQfeLJpn9O1a0oMYrnacig3hWihCivPZwxG84f2wDVncmCCRCPKbB3k/eabZm9+zd3ImgYrgazu1CgcfOzW+zKJ1dqCRYnG9ZYBtTIIxEE0E+D2qPvOtdL4vUD3MHIAoBAQQWDiJHSGYkGZST56uAlwYt6wCNO4CkoV1P/mg+PrTYK1Z1dOIBY+MRbqUEWGlU1BRU7eH0WhmmduymJa6CYrOJEo/sYSFLIOBM9AweKiNdtEAs6/pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1708196122; bh=tQhUebxGlRi2+7/IvGCAqUnQ9+512T7QpedFn3zg04J=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=dc1vzLinJofyt68E3dYalUJW6M9vVGwT7WOqbc1T3MzP5rlMTSsqgqEZS6yFQylm0s48d4vtmIMAueJ/6aRyTF7GfTJDK5pItx3rwGgQQu5ZyY1pBXg0xt1MLy/ks0JGjg7KHzdlxySu/pjDx+UfurZ5BegGu7FkeWXYwlvF+0C1X5i00/ND8NsZYjZfBeEO1tKCvUjIUB5EEMSJfRO+y+eIoRz7ANZBJex7+k5Vwp2AjHiw0V+CX0JfjVilIFPY5MfaIHJrv9OEkSeZ3/XD1118JWhAmvBouYPjLQl4PwHytbKTXPlNhCRkaZ+ISsI3E+QFxn1y/CeGpTK7EhIcKQ==
X-YMail-OSG: ecQyfUkVM1kadJCebi9V9aXClvayswLMroFJp00R_VPBGEw557oZQ_rmtj_FaPD
 GySreZGs5AhIA4Oqx9yH75QGpeS5XadXXobE4D926MMV745_az3d3N0SBK4vgDRZzflICYx7NSh6
 OflDS_Me1u1oiIOZWyB1KUlTClwYUUdoID.HaE9zOn9zlrd7hDjrhGK6zhNRMKcq_0pUYr9flv.S
 aSB8foVjyuSuEX7GP41h_vqDfRsyML2IDDbYfKcZrwQgyFeXjIzb5Gcwr4K.rY0.mJL2CdjY7oav
 9N5bVgAkypJRcZGvfbZCUAovB_29WcpapJc4nu84B4zj5D2i7adkPlhXcygDXHaPsleolX3j.GkD
 mls4_q6Xe0c9G2mfFFznpfvrwTJs9CcVxvA0.w2flqhAzDPVZQiSHbZTyH5nOi3qFSxrmsTY6Q_2
 .RwjOOD6fqjkDlfOsJdXQ._TZoSJRj7iL288pl51y8cmw4pbvHZPoRXWRB_PDeKgAc8OWSRzo8F2
 qokqSgOcxm75uX8KCDWrF5yyi9khfnonRbnhn8srskXCO.mcAdTtOkKjl9VTOf1TK7gxIZWhT46f
 t1E6.KFlRbMidta.TjvXcHnvHYYzNn9mXN.RviKZdmSxia27_c08vtfRVFA3LB_PhRfIvFhic7vI
 wcJAW.5BJcPyttjVZZrJwVnVspfB_ylk3gJbCT9c3WjvGablQFRnwFtQucBhUjvkBHZ4WhtmgS_Z
 QNShoRE9fPi2.pEtU8gkrjmNP5Xdk8SZ0s8ZSATV9F42qbxeIhUWeB05rBV.BL1Yn2UYTNeQCQCk
 _89VshfyUhHIKr1ngJsMyXBaJsqR97LL0lHZZ02HmhZ5M9rgRZjFN0ZvDstEsWsw9ZGaGd1nLt_p
 xb24QldXfjBU2PUaYN1aBdSE18CWPyjEU9xhl4TziYeT1aqjrnm5QvVzCPP7ejweain7gpaKayOd
 XIx6ywbnf.KfAWiLfQm3EOY3tAiKcNQtMIoPW1Bt1bVVOIJaHzWMeCcYJszrqPLbSzETClCqHyeN
 idWIEsPUGZ.TtPldMfEaV09FfNYv__8Kccj9jXXV2pHhd15Ui1tAQa2wx8mSyVZB7L7LBV_rEHDe
 3mOYyJGvhhQHFsoPg6yiNbmkVmbNv7QH.NG8QABhSbcs4y6_J9XRF0cOMFJ18adCMIBj9XiZWOn0
 5yO1A7L3auI6ZhCd0uZBkZrIa0BlUK_7KxxWGWFNSeBQu0Vu6uvFD8RvootJL7C86JNINkjufyj8
 cwjM_AfBROLFVF4wahTQgWQvWcxzYsnz6SffyvvOiYgpqANv6s0R4rat0VaNILmAqhl.wfaZbA06
 L8glc8EGVMjUo68rru7pM8HvmFyo6iMOJVIDbKiMg86DEZsYwG1DeKjkchngQN6clrznafGgC9Id
 jAk3.QYN9ezVPY_1kguGUQJcbQC6VUU3GYZqqrvJmL_kKfZVvkWFBzxiP2EKEUlRn5WhLMrMs1VG
 XObYPbB7uXp3yK4V79ozw39SnSuFWjYv1u5E1QAnvyP5EfAKUywHaoL6fkgPoir8yGGzpEYY9uF7
 _E2GNNIDY.IQqe1QWgymlJvhntECW0gCwFl5KibuSD382PhubOAc0D2yO4xxLzwm.9tCs4Vwb5yd
 QNej3CjB2Ip6q0QtLMzgbT6Ru_AIwMPRHp4wIAtUNjB4Sb8onwUCrL1qfMvk694WecoQEdVSKYDl
 2eNmJvdYuNv_jooW27r8cvi7uvfUDGz3GNcCSnmPof.0ay.G0e_3jeCVhoTaKYdhVfPCy5MXbyAv
 lKZ48R4yJbWRqqhU34p2jUhz6zq.YzjGkyMMDuz3n3qS5Y_e7TC5X4I_pOcSQh5HD9Uq5rPU.Z4L
 7M59ktq1wMY7KjlEivXCaTkkk76EZe7SZ0pGeRLnGBXQ3uDnETdPm8VqSJQynVSPsWCgDNWjjGEa
 axSybqHZPyXrIzefM2xY6eUUoXZDhPxVgiGYX5XHh6ZSfzeaSgtbtktKAQOXpA1jn61QiiaJ2th9
 NeFRt_dNyuAFUDWuzly2_GXICPQ4xv.0Z8kl80Dl16_z6z80OG.4tb1eFScu_wxZuBbj9Mg5KjmZ
 o.1e49loTzLdKPLB3QQ4wGTvPCGPngWAiGcEHqW3mHMOrymepVIkn34p4fAqDfsJKV7lWy5ov8Sf
 96mTocnMmpW1z.3WHjQ1KrsqlwTdF1.dQzoQPp1cCgyM8WNSCWOHebLtF_1sxPfhgRwuk6aVjMG2
 IPp6jJdGyZC2JTy8uN0WdHaKAyVP6e0ZRcuZBnhDgW0aUtgjP6Qneh_fS_tZcFth15MZhhpjuuiA
 ePWR4UBXtR8PFKUWu5ICW9KCumNmGc4ysrQHgI6VwvVYHz6zPEmKL4gx55xNEKSxEr7THPLlzD9J
 T_tjg2xtNcyCWQt5IyrdWaLQQ3Jkc8rptd2GFGJHZrCYqTd9.b1.3qIuLC8zR50ocQscWgYsTEER
 nanQKJCqwjie8rdc1uH1aYCHYiyodDG.mLv2UAEoWQck3QycDqvE95n5q9P6USqMbOeb8EjsxJYf
 YApNfMTzcHkEH1T6O4Ogfb06T17LPRBwy_3kMNBF9U3dwtZjl3Htbz5Ffz_Nostjcimt_RwsGh1z
 rurodQbE-
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: 5d1cfeee-d07b-41cf-afe7-868ff349e080
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 Feb 2024 18:55:22 +0000
Date: Sat, 17 Feb 2024 18:55:19 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 John <therealgraysky@proton.me>
Message-ID: <1031326949.2069496.1708196119886@mail.yahoo.com>
In-Reply-To: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
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

 For RPi 5B you need bcm2712 device tree . RPi4 uses 2711.So the e rpi_arm6=
4_confi does not work for RPi5
Also make sure that you have the changes=C2=A0 discussed here.[GIT PULL] rp=
i: updates for v2024.04 (mail-archive.com)

Iwas able to get the git (https://source.denx.de/u-boot/custodians/u-boot-r=
aspberrypi.git=C2=A0tags/rpi-next-2024.04)
and modify the config to get 2712 dts file, and able to get u-boot.

|=20
|=20
|=20
|  |  |

 |

 |
|=20
|  |=20
[GIT PULL] rpi: updates for v2024.04


 |

 |

 |






   On Saturday, February 17, 2024 at 08:36:22 AM PST, John <therealgraysky@=
proton.me> wrote: =20
=20
 I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot th=
e vanilla kernel package (linux-aarch64) with the latest uboot-raspberrypi =
(2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my RP=
i5B, it does not boot. I only see the "U-Boot" submarine logo in the upper =
right of the screen/no debug output. Any thoughts are appreciated.

I built u-boot like this:

unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS

make rpi_arm64_config
echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
make EXTRAVERSION=3D-2024.04rc2
 =20
