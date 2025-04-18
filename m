Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A97C369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 18:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA4282AAE;
	Fri, 18 Apr 2025 20:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="lLpN8uWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F199A82AC8; Fri, 18 Apr 2025 20:24:52 +0200 (CEST)
Received: from sonic302-21.consmr.mail.ir2.yahoo.com
 (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9186082AAE
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 20:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tholag43-online@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745000689; bh=M48dP1GMfzZrnqoIBwteCHgTuxgI0v1X+YgsNFTIPJQ=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=lLpN8uWwBJFiVy43Lyt/EVyezvQ3gFdf85gTN3USsB0gkJvGjBZAAbHzcLFgBarzl8kyqfqmHsC3z0HUBPp1by7x6ee92tF3/W5DJOkMEll0Lk4K5M0YEswHZq3NYFwmdAy5YajeJ+n+9qves+TD4w22TtFsm03gai9s0NwInBLeQ5hjzmjH10xWxaElL1DZDrYiVm3dsr8YpmpAMvXBekXbPNwCayk2pUjB6G1x0+UZM/Cejy/XCEIBtph9LAYB0yo/1fxp5nHty3g9Jgr9ZiTgU90sYkD7+GKC6yLITTxNPA6nRhtdhf+ENX8gCGQdDKukxrLmr0aRAD2SDUwMbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745000689; bh=kMdfRAkdSqOUgdu1c+CsRg7N83kc8ij6GWdLinMFFk0=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=idBoZz5hQYYp1eojq1xeqgE98gJo3s+Wxvli7QujtgppP6txJUqiRnZXMLRsznLsNOgz+U1nZRTBjnX1M0rUXSqXOlzClqDu3ckFDBXRXx563byUGC/kPAgur8xwEcqDA6IYMoLYH+MqZWKyRDVYOMEYPvINPD/0fjiiBdmoMDskahRHlStNDkFIUVZHVggM2RDp3Yn8F4ggg2qem5Z/RnIz9pIlICPJ2zgte2oFHNt5KxwNVkKrffT/XBgGX5+urGdmL1cLuTK0HO7BWoxJUySkUW9ututdgeoQc6uhYfxt5zcEsnqpvvKfiO39TBmQzVHV1Lcl7l3FoeWcK7NwGw==
X-YMail-OSG: JL4XLzUVM1melplPKcqXZ5rIfGBmS8H_qHJfFepGwsiDSxi5I2u_jPPDF49aNyj
 73T1ODyhSW.wjc9udm9nt7xOTF6vNptY9pGqmDTFahLH84vBlF8rKezFHFAuy_N.mC1p7cvrccox
 ZRtZo0ZRZpIblrkUGl1L9xzFgDTX3RAIEPfVCNjv70q07giQWMjE4EPmj.guQwLcWrNmrIgLk0ID
 zroSIPP2OW9PYHKqSAWGlrAmvVTGI_zaEha07F11xu6zjlbCukiRodrODACq..69ABjdyiuIcm70
 vGrMpbTsbCFkrtlzbr50FH0k_BBBN.fhzIInP0WWq1zRlMgcxaPVLvpFfC0VLqlLVAUumxyCc4YR
 hS_oYPKacpr__n78fbPwFt2b.YAHx5KvM8HHda7cbfKXD5P4W076mQAwrQV0pQ5m9chcJvqtvuzR
 atPmJKac3o_GZ.Ce7281VFiUTip0i1xui.J5jdPxxLG8frcseBTFrEYxDugDWUSMeUgzMg0QkmPD
 d10Qw9n6haYHsWbSCZcUVb4umnydo2ZJ2HmNmnF..BcycJvOTO3.Rg7cuCsej63uEEDvOp0vF8nI
 .GogTN7nJrp0kGE4L._7lvV3Hgpe0EyBNBBlUaPWIcSg.kpCU78G_S_SLT4ep4LBrOFMbqaRZ1JI
 Mlw2oLLzk_DHEGrJspYW_2lH13FuDdH.9fpylL_Ly0HAWz8iMoCpagibvc280ut00jYKqS2dP3GR
 2oPC4PBn12A_0rKv1X2KSMjp_ZjP38KT0DJ3pQRGtDZaMrj9zqKhZLqLd0KGVOQB_gI8sCda2sG4
 2gazlrGCZNZuoJEj41NlgJbn3KVZCTGKVIKJEAL87QzYJoiPtuwEIQKSQR7fW0vJvwj.eWJVjMGo
 x3FpZAS4shJQW81YF5ZP08BIjLsuWowgVo06V9YQ0c_e_kywSOgvHWIyYzSq36.scVtlnWJbmCd3
 Sy7H_zyq4CGc0mhAB36pGS4ktKEJXGUy1uGyEkd.zij1PHJUJC0vVFcrDSNLAQsa5mW1xEXv7biZ
 knlgc6mm4EEGJy2SA4eMHA3VPQghlHbGEwPQvk0_H7Uo9puK1C7Q7LS.uYjqvNFib8C2_rNxxc0B
 5knr54j9KqmJKGUWAfmRFvVj0YOm4hgX.t4V63JKFSTXoOu7vP54e8mZB3es9xTCoMNmKi_IKagA
 _FiedLyTiEDgx6J26ZLWrcXFEyLfPa2S.k3n38Bxc72_.QJVnKYgAcH_YWoa8wOJQl2Bxtqz5Ynq
 Xgj4qi0eWV0a0ASjavAVtRRF3YNgW50ttrp8aoX0s4x1Nz4SSIuY7dJH_BvA3aNy2qsV0kyMmTNl
 MQeqcC2mVPjP.AS1AVp7.EaVnRbxsU82QMIhhbhNSghcunxHiPDjTplm5CR8LwElYJyyP.JFZL9E
 dJz2FGwv1cXWDa6QInG4HIiq906VFmpBmliLoeliOUTdq_n4bwOnnW0dW53zgNBrKgA9zKSZn5W3
 K2_y2aQcq1_Y90E_11BwMRGbm0EJEWV9nDAolROsHoEBrF1SuO5B1JDvx9Zi1zVE_l5j3dkqVSoz
 FGI_uRdlZJ5u_eIGOPy1SGk4HT6qX_RLXfLC9jKU33Zr4FPXRxChEXZ62lz98wRH2G9VmPdQCfOs
 jW1RquKKs0yZDuVaZSAGRsfdJmmluXDG.PLoOBtcfzed3E4pI7WKt0IncCDaYDjLBcucDUCgpvio
 JxboM9z8elBCG1rtEuPMth.GqKKZRf5aT6TU7L0Nive14MFPYPL0mdzWHn6NBWWJqQwFHkLM28od
 WjWI_tZdM9Ng2kNe1u9LLOPpAR2ApsDnbm8jT8YxEpsnqRAoVMR51BVxoKq_sLmmZLwCjS.MLx6_
 8VqGEr3H.xIDaLkDnTCtQNBcL0Tckkh8r404k6J_Kto2dDBckis45Fgw0UeotI1JVJeO5d2baldY
 uuRVV86FDFnyLsyyVCcrg3ssJOUt_TLgreWCnyLfob6dgwaTz_4ult_1TsdDS3DWn6Y68j330U5N
 4BKTZJqjRGndUjiUJ9e3KrEt6E4rKzD9THqgjp.P29GuNjATraq43FgJ8FtxDBV2tn8EoQJKy0fh
 QIHUuSzLG8iqtlyl.ooClTxz8JeS2bjP8tl.U.87vJ8Prx2.apimoURraE3YnP7VMMpSIqGeBc7I
 TI.sVo8yETQsX.C9tAy0ZUSX9X.c7Eu_Kvib3zy8tl5tW3x0LCbaVJlEV1..7Up94apes2KAjTp2
 IfWT3jKQ7gazB6m9JDBZYE9lCUnld7cAuZ9DoGhp_cGVOg_1zz61NHw--
X-Sonic-MF: <tholag43-online@yahoo.com>
X-Sonic-ID: 6be6f67e-6fb0-4c7a-84a1-5ad93205848b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ir2.yahoo.com with HTTP; Fri, 18 Apr 2025 18:24:49 +0000
Date: Fri, 18 Apr 2025 18:24:46 +0000 (UTC)
From: Tholag <tholag43-online@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <421019670.5226453.1745000686387@mail.yahoo.com>
Subject: CM5 with random delays on boot
MIME-Version: 1.0
References: <421019670.5226453.1745000686387.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23665 YMailNorrin
X-Mailman-Approved-At: Fri, 18 Apr 2025 20:28:57 +0200
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

Hello everyone!
A random delay in bootup bugs me or my RPI CM5 for a few weeks.
My best guess for now is that U-Boot triggers some process in rp1, the shdc=
-controller or the mmc.But I don=E2=80=99t know how to diagnose any further=
, so I send the details I can provide below.
Maybe someone can help?
Thanks!
Tholag


System:
Raspberry CM5 with 2GB RAM/16GB mmc, custom developer board, yocto/poky sty=
head and u-boot 2025.04


Symptom:
Using U-Boot, at about 2 out of three boot ups the kernel is in an exact 13=
0 seconds wait state for root:
Waiting for root device /dev/mmcblk0p2...

It does not happen without U-Boot or with Raspbian, so I think a defect of =
the mmc is unlikely.
The delay occurs completely random, neither uptime, soft-reboot, cold boot,=
 sync before reboot, filesystem activity before reboot make any difference.=
 But it is always exact 130 seconds long (see below why...).


Diagnosis:

There are 13 mmc timeouts (10 seconds each?) on delayed boot-ups and none o=
f them on regular boot-ups:
cat /sys/kernel/debug/mmc0/err_stats# Request Timedout:  13
Adding the `initcall_debug` kernel parameter, a late rp1 firmware probe als=
o came to my attention:
[ =C2=A0 =C2=A02.736439] Waiting for root device /dev/mmcblk0p2...[ =C2=A0 =
12.764515] probe of rp1_firmware returned 19 after 9 usecs[ =C2=A0133.94956=
8] mmc0: Command Queue Engine enabled, 16 tags[ =C2=A0133.954800] mmc0: new=
 HS400 Enhanced strobe MMC card at address 000
I found this in the rpi-kernel repo on GitHub, maybe it is related or helps=
 otherwise:
https://github.com/raspberrypi/linux/issues/6642


Example bootlog:=C2=A0https://pastebin.com/LUYS3Dex



Unsuccessful approaches so far:
- Updating CM5 firmware (up to the current release of march-27th 2025 from =
https://github.com/raspberrypi/rpi-eeprom)- Mounting root via UUID instead =
of device- disabling the command queue engine in kernel with assorted sdhci=
.debug_quirks- rootwait, rootdelay and some other kernel parameters=C2=A0- =
=E2=80=9Esync=E2=80=9C before reboot- No difference whatsoever if warm rebo=
ot, cold start, different ways of (clean) shutdown- Filesystems are good- U=
pdating to u-boot 2025.04 from 2024.07
