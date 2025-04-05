Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F4C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC7A82ACF;
	Sun,  6 Apr 2025 00:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iYQ77Rin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D44082B00; Sun,  6 Apr 2025 00:30:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DEC82ABA
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743892218; x=1744497018; i=xypron.glpk@gmx.de;
 bh=U02nV18et+YBvzBOrYlnYn8x2Pjsnrj9lEcfiukQWqQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iYQ77RinAhIA8+M03PclijQdkR8L6pkbuHqvw1PIhtuFk08D7xw5tsKxLt0+e96x
 l1JZObDu6Njljrp1Rzvi/VyyMgNZ655CRuAfcWAZFiuYxqtt+ZzjOJrrX2Z5/YoOT
 8gJLcOWnknCdL38GNzeLfhYGQGqeaMatB18xCtJUmK4umgL2AQkGVnYDZ1LCQVsol
 /ZhSklHhzCKIX+fFXDNN1Oin0hZNnkq7+Pzc9hfSl77J5P6PZzbv0w+jJ+FBGBssF
 z9eCZHRaDZ99IRlqwsMkxGbtG/aJQdulfP+NqRUp3AfT03WGoCJIOSaTXM6l1QBMf
 7Ihrpt5/vLafaE7KGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.243]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1t3xSb01zX-010eCC; Sun, 06
 Apr 2025 00:30:18 +0200
Date: Sun, 06 Apr 2025 00:30:15 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 =?ISO-8859-1?Q?Christian_Kohlsch=FCtter?= <christian@kohlschutter.com>,
 Janne Grunau <j@jannau.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_efi=5Floader=3A_Move_devi?=
 =?US-ASCII?Q?ce-removal_later_in_exit-boot-services?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250405221308.498047-3-sjg@chromium.org>
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-3-sjg@chromium.org>
Message-ID: <6E95E440-67E4-4054-9662-871671684B7E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9aHNhfnXXka6lMN780/tq9dLu1nb7LchWaD1te0ftCoJwT+sJJp
 AB1fHynHCnLei24IK42Rvz5oOwEjT5juHwl55GGd/euVNGqP/0iDPIAhvsV3A9PNkX4niJV
 1SZuSEJBNjyixbdToauLLG3iOUfCO4clafAqCrELuQowjo7RyeGuz90lePQAcvCl/fsKQk/
 PIEt+JXeLvbvQHSSx6Fqw==
UI-OutboundReport: notjunk:1;M01:P0:7p+usDfKCUc=;ipT7S0dPncZUE6SWLTO0RGHTutY
 4Bbx2ok9al+7FwdRS+mGx6F5mm8kioYoYKV/qT9WI0Qq98Fz7K0eShxfRCgFzS9nEanTcl8fc
 kDAzNWhTMT+o1A0gQshs/A/47VOOWiZ0i4APNDvN79+I/uvpNYZrZQGlUVXmR9sPyhQwhjjwH
 ciGzLJmrGrtujiFdenUZ2cTMIxRK46KgmOhIdBbPxKzUv8vgLXMjTIYNx+8NNj8zlJWwW4laa
 28OaMXWRa5eVsTbhv91Gc9AuTu3u0ciItW5kJpETzU5Wk6yI2RMu+mqVVpRCTmvxXdIH3MQ81
 NdNSpa8V2UjMVeB2JDwvRv9xN5ck13uuvvnwEUAyUJfJq4f+9PHHwObBmYCLOQ0KNSHdhZePH
 JwfNCbsLrWFTPEChIPLPUhDFEb06oTvUadnKAQtAhUXUccLWj++tTZzxLlslP37kZ87gGonTe
 o6SNklCXe4VG5ccctNSpV+jjRXKa3db6FA3Dhk2vXt5XpZjUd8FLAA6ZqQ5ZN7wvc1bquHJph
 pqaIUyJOktq05vCFe098gZdipmFMPx6VFIoN8ne+xIiBM7A950fXUskinmBQO00pv3D77ZX7k
 h99iRJ213xzsenL8QRoUCGIta6rM8cYhBi9g/Blbf7uuoDwcf5vVpNZVu4UHnfLFNTDGIENRb
 ZmZfSp8zpQ8DFOAonydHuRQdKomaDapA0AHYleQOxtWFJEKk6K8DojAAExt4s/NAsi6Wks7SB
 UXZKm3xZyymhFKUVbJSCq49ZsJc7MGiDpuAMxShWGMMgxwf62LAnLoxbYYHLPAH1ed7QMQoUZ
 jPyE6vf5UALOtCMQIPIRCQ7lywLk80NvSZhCH2CmrSml1tL6eOZGs6WikzLqN9vAY2/T/iYAL
 N9Dj0qFPiKFheVePyXOA9nV34M8oucQeK36Pe42HXC1AG6PXVRkgKPuFehxHtmGXK6Pg9kJDb
 5ISoBFK6zJaxBzYwLipc/pvi9ddn9Ri1BCM76tcEc7F/dvMaZInpOPyRtPzuNn6P7IfGO7W3b
 B6qUpic2rgbX6Gv6kx+OwiVxyZDqDFcaVZ085n84yBT3EOoF2zK/tZL7I0FdWaYmCTUWa4SBn
 79GSNUNcqScWiIG0P1jxU2e5NQED0Lg/zMEFnZEsMGAW+U7+3/S1h+fzo/HF8ukTMYinM9n9O
 YXNF76o3Iv9ov1KzdCGiFNEPwRFUiVpihGphyHX1Lp6ZFHwnm9xiSdd2HGg60f0VjfUreU1n/
 bJoEn3psN+xrpSvopauza9Hr2xv1+5QZYdjcylzbqdNtlV9yMDc5KO6uYUZQznAkUUCpCBwyG
 khBVleqOvK1w3WHoIIzJPvbyoRFA8dV+x1Iwc1kWTkbhtKJs1Dbz7qymNOD56bUObb0ryZl5H
 scOnqdpVyMI/G/IlB/mA65PDxU+0h8FugtHh7v1Y/lIGRntkw/+71Gf+uS+8+rVtDO1+5/zIE
 uJ37EXiDrN9hlxFZYkNteHgIzulM4ornCjRx+iSiIMo13N1Jj
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

Am 6=2E April 2025 00:12:47 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>This removal should be the last thing done, so that U-Boot does no more
>memory allocations afterwards=2E Move it and add a comment=2E
>
>Note that the TCG2 log is updated after this call, but I cannot see any
>allocations there=2E
>
>Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter=2Ecom>

This commit message fails to describe which problem has been observed and =
you try to solve=2E

A link to the original communication would be helpful=2E

Furthermore, please, rebase it on my patch adding eth_halt()=2E
<https://lore=2Ekernel=2Eorg/u-boot/CAFLszTgp38yBXnSigfT-mEFU=3DrqyAKjp0WB=
QGgHP_N3vRxCq=3DQ@mail=2Egmail=2Ecom/T/#m1e55cc094f575797da3b4aed6b369544f8=
d6f8f4>

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> lib/efi_loader/efi_boottime=2Ec | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
>
>diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_boottim=
e=2Ec
>index ffe43accd1e=2E=2Ee525662f82f 100644
>--- a/lib/efi_loader/efi_boottime=2Ec
>+++ b/lib/efi_loader/efi_boottime=2Ec
>@@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(=
efi_handle_t image_handle,
> 			list_del(&evt->link);
> 	}
>=20
>-	if (!efi_st_keep_devices) {
>-		bootm_disable_interrupts();
>-		if (IS_ENABLED(CONFIG_USB_DEVICE))
>-			udc_disconnect();
>-		board_quiesce_devices();
>-		dm_remove_devices_active();
>-	}
>-
> 	/* Patch out unsupported runtime function */
> 	efi_runtime_detach();
>=20
>@@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services(=
efi_handle_t image_handle,
> 	/* Give the payload some time to boot */
> 	efi_set_watchdog(0);
> 	schedule();
>+
>+	/*
>+	 * this should be the last thing done, to avoid memory allocations
>+	 * between removing devices and the OS taking over
>+	 */
>+	if (!efi_st_keep_devices) {
>+		bootm_disable_interrupts();
>+		if (IS_ENABLED(CONFIG_USB_DEVICE))
>+			udc_disconnect();
>+		board_quiesce_devices();
>+		dm_remove_devices_active();
>+	}
>+
> out:
> 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> 		if (ret !=3D EFI_SUCCESS)

