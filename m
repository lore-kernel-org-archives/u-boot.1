Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369B6C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 17:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572F280E9A;
	Sat,  7 Jun 2025 19:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="VzQ7dil2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4BA826AA; Sat,  7 Jun 2025 19:56:37 +0200 (CEST)
Received: from sonic309-20.consmr.mail.sg3.yahoo.com
 (sonic309-20.consmr.mail.sg3.yahoo.com [106.10.244.83])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B0B807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 19:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749318991; bh=PSLnrNpD/VDsM27he1vy5D9Sars+b3eYTIF6j7+rL7c=;
 h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=VzQ7dil2xd5HjSS1S27M228AfZAIAIlmgKBabQa4vMgocKh8Hnve2dFf9ig0u71J68WKD16w13y7LTJbZoK6Zn8VmSmpCiLrV5W/YszoR7D4ezgk0jb9O07mfG/ezB1yscxH70e/trwnZsDsdgfO7M4LNTwEAE7DN74iR0rr92VSFKU7aqAQ8IwMbvqab4zoSucEXxQiXWYz7zd4GGt1TV+kFpdi6oHh3gc21y0ivtF556PhG8rr+KclVChn8ugYF0u+nBlP+CnY7SZ8cbRyx+GvhOiYq7oTCPs10kwMW7wqa60BCzurYNyApTwz13BVUXkl8+OQlbTHO2YWwR7Dgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749318991; bh=3GvA+tLIRjhHYJxa9uoOx5VC3B9Bgad2ZSBLEa3aBh8=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=amCLXMUst2u9Z6qTWzYTLxPfbycOE2oqGc+lP8oLh2fUNoUe8IoJNMQ081BUb7klkLm9ooU49Ic1WX2Tuw64eeQnlLCsHcVnS8Cr40ge/+d4pKcioYWkLuKL9vl1h5fNJJ2L5ZGlpZEGOYu6EmMrxP/8jjaF9ldabT9LKVuq1XPhZUUDwegrINeghU9JXQOH8qrN7k493RBAA6geiGj1ohawzBbIITlZpr0fbW2kcQ1txFgty9Ycb8zA7XTf3s7UAfVGCcUzCJ8psFrabanBV7edqAv108fEyPON9b7Ogl24WsNVCiYH5Jjkvnji4P0f7SzXz2oq6hDjCYJx1v09zg==
X-YMail-OSG: F8JUIEwVM1kV2IyDKofgn1ELmkDWPdkGXb.9PXx21lklSGw5CRamGOQNPC2wAvV
 1zO.ceIq.koDZmiu_F04r_qtsVOUamUfvU3HmXOnS6Kp1WYdvtrMdHZAol3lY_JwHjcto9OAa_gn
 Jy9n_imx6uxv0HRTj9LH0cMjc8NugQGq2S6NSCAXqEendNdxyasa93OZZ3hBjVqwvHrGRZKf8sQr
 DwwKweEJI9ivcnoJXT_ZrBh1LHVTEEdXrQgVXU6ATDr1yXlrpxiK_dLz6RMpYVJIIzN1eEX6IIll
 ZQKbmRSxbhhhuob8bmTDTA8yMILo8wHGCkPsFqIu63NaRLvq38wvlkdhZyxFjihFjtef3NLf3bzf
 NCDSIMlToez.n_jdQTE_3WEoABExspXdkICQvKmomD3b3TEwnkAn0NJo1PegG6iBQgNG2tzVcO72
 7bsNrcCY.HlnXzV3TWVYuusKldue2nN66LptPcUf9rEwcNPTMIPrJ2e63S0Umtj1CebQ626C_Apx
 HyHBGm.eIi_75swUkB8RpOF3U1zc4KSx6NZIpIDPxwfsbxwL7C8cEYZXfLxfgXPvXzugcxvp5KCe
 5Szuv8a.jBbYMnvRZuhSgKnWu.nMhW_c6L9Tj1Pw0Hc55qPm4zVxGI6DjZOzyG_7Tq.ZHrzrtnRh
 HqoC1D6hIG5XN45CzmOAsuUJf6P02V444Vor4jhf.Jaurkv22ZYW5sfPs2A1Wd.ERIaF7MDPGa_y
 rYcNbNYJiIxC5eBySh9CEqdIBWQZHPOKLpnPd9XieOZgDzwtujfJT2D.nSuGzBV015K0G23RYn_M
 C1XvlTQSzN4RvaYqX5C0CAaIancctp34Xe87DCJEW13xNtQ9qkCNAXWESFjFF7FEG_9wiyxVXSXQ
 FgBzuY5zoV19rmn8zGuf.m2DJ0mIcos2WPQ6H_FUedGC.hMZfL5QYE.IBgjONOVSlWEBblpSnvPb
 5iKFa0uEauIz3jmuAft8x5FRKLLjlbwALTEzK6uE_U5EcwKAHERzSxXP1CbWSGCJvR9Xcecnd5A5
 5znZGFqMGwv43B8bXYUnQjnjHU7uFuGzpH6mY6UZcXHjtGQAmoyzQOlzajxFokoDJmwsjCBOhVxW
 aOvm4rlfeAKvtTiezaPJdLIb3uMtpwu97ka4lPjiCkOxI2Fqs5AssU94ElQeh9LWujkwyls_lMcx
 84WoNGGvMFyLMa3Si94eaB4v0oQ3Y2oJrkGCM23IJsmjAiQT9W1ZH7z5ZTuBJtPaVV6YC6zwPGIR
 1DgbZtYm8A4_T6Y2p2WSNfIUxl92zNi41_qp4Asd06rDw23MNuC0ZI9D_scAd3moP1yNJmJSmdte
 BmEbYE4sjrXJmR2hmlHX8KlGEi3hE1NVSPMbVnOY_ogyJRmM3BtEv9epWdRx5L2YqV3ZvOPX5.FF
 EkAAdgGpCL_pOGx.o6Bz_ERy3V4W6KWlaFuYrlLsppL6cNDjz7V2l0gks74wiL4997oy5WkpzKog
 PT5h9hPw4vH.7lhpmgSUfKQlOhxZmT7DStnkkieWFC4yTWJ4frWAATGgbaoTQ9hLglAw.4vFk4.b
 ENwOq_KnZj5D2DXmMumq8BXaaSmyOpvRIniZYHUOjdT0Q3Fgpd_TkmOpGdaaodngy6HJQRUWYZN4
 WRm3aIo0J9SWC3WWk_487ec.vcBNrITDKmOTwLebTRHpnf0._8P9luCDHkBewQbqEXV38EEFacnv
 dtoeJ4DBL6W_.kCgcwbFiGqpkdN6akv_5knO8i5SYmFqCNyArF5QQmak9fFG.e0JdqUJo8XPMyKm
 BasF5SDsRXWEszCsdd_ug.U0jvtDMvkX2cp0uEk9UmGYXgspWERlqL6CpUadKe_guIPCRabEsbIE
 0EUdBF_MFmjfJd89waVXUBTErU2OsySKWVI39O6dj.dhlYBeVmUpw4Rx_zsDwIXIyfD70kVAPSKQ
 kAN_R9VE9detQ0.9ePtwvcqOR_lY1limaFOMZ16IEdSRfbmbJr8r8MwsUTBBT.mBDIRSutEB5PcS
 zgTf4O4_yv4hbIF.CtpHW.3ghATPLBDzQqRCNYPdsZfj8pHCEUPFMz_ugdygJ9GmOpDDIRzHf2jV
 47cmFW4HBYJkWQPtrI.uqbDRwJga6OSXj.LvP6_qU2UlsLt0iZghJrLHJ_ZcUrBijXOL1n1Nz2Qp
 gXyZJwIv2Cvh.MBNPqE6mjcMvgeSx4HVpHo4z78rHmh56m1jk6fpx5abR6EkGh4lLbtIuLciQcnT
 i0HGg1AvZQKqnmvKAhCnhy2D2uYPVqkf5BW8OzYnH96UM85l837yzIkS1lt8fH7KaPAUDQ3eZjzN
 3ZiAEO5buA.vT4.EbRXV93WLYz33gX8Cu
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: 3adae904-7ecd-4386-8eaa-8de957c0a0cc
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.sg3.yahoo.com with HTTP; Sat, 7 Jun 2025 17:56:31 +0000
Date: Sat, 7 Jun 2025 17:56:26 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Jonas Kvinge <jonaski@opensuse.org>
Message-ID: <1801521580.655864.1749318986908@mail.yahoo.com>
In-Reply-To: <da35020455a4a086617a0588ba913b5ad3d2dcd9.camel@opensuse.org>
References: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
 <851157797.299472.1749160367219@mail.yahoo.com>
 <da35020455a4a086617a0588ba913b5ad3d2dcd9.camel@opensuse.org>
Subject: Re: Raspberry Pi Compute Module 5 support
MIME-Version: 1.0
X-Mailer: WebService/1.1.23956 YMailNoble
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

 Master is ok. But it won=E2=80=99t work as is. You need to have rpi5 confi=
guration and the dts files. I did it a year back. But since =C2=A0did not h=
ave bcm7712 dts files, I took the dtb file from the raspberry pi images ( i=
t has a pre built dtb file, and extracted dts)
dtc -I dtb -O dts -o <output.dts> -i< input.dtb>

    On Saturday, June 7, 2025 at 03:26:31 AM PDT, Jonas Kvinge <jonaski@ope=
nsuse.org> wrote: =20
=20
 Which branch? The master branch is 1 year old.
On Thu, 2025-06-05 at 21:52 +0000, Jojan wrote:
You need to take raspberry=C2=A0 ( custodian version)

Making sure you're not a bot!

|=20
|=20
|  |=20
Making sure you're not a bot!


 |

 |

 |

=C2=A0But it is still missing the device tree fro bcm7712 ( RPI 5 is bcm771=
2)But you can Dow load the dtb file from the pre built dtb file from raspbe=
rry pi images
and=C2=A0 use those=C2=A0 device tree sources ( using a dtc )


    On Thursday, June 5, 2025 at 02:13:24 PM PDT, Jonas Kvinge <jonaski@ope=
nsuse.org> wrote: =20
=20
 Hi,
I'm trying to boot openSUSE Linux on an CM5 using a sourcekit io board
(https://sourcekit.cc/#/).
u-boot seem to be stuck with the logo on the upper right corner, no
text.
I re-built u-boot using the latest source from git from the next branch
and also set CONFIG_LOG in make menuconfig, but still no text.

Is the CM5 supported by u-boot?

Jonas
 =20

 =20
