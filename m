Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8909CC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECE180EC0;
	Tue, 25 Feb 2025 00:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V9qRYF4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC2680F3F; Tue, 25 Feb 2025 00:35:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F72D80977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740440115; x=1741044915; i=xypron.glpk@gmx.de;
 bh=qNjySIP0j+q6rh1EggkhH4QVNpFeAE5Q8O2iDLzEkWU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=V9qRYF4ChuvZt4hD8RRfS1oEfRNfFmuE7JGuo+pwpEVyMkBe0DfRadM1sGobaODD
 7SFPrS9YPHRqV0oag5xC09Jb3ObdXjHPYargKgGjAWEcsWGQoGq9uTN1PTVfJB8fY
 aVSeXawoFLtSAHjVeT7N13mrzgxS2BwzN6CjjHnECKMfVWh70AF4xQg8Q/Zw3kgMb
 FOh9UVGIQ203MR75Y+M4bTlNNfd96RyhQH9pVtFATnW8oIzjuQZCjypHpiF/r9WIn
 uqMcNutHyrT/aHBzsl/Y02ZkQzsvIeKGzKnC2KpK/eCX/MHV8uCBK9ZNDktdIfv6u
 UqihvET1xgQAjkXRTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1tLjIT3jol-00xCyn; Tue, 25
 Feb 2025 00:35:15 +0100
Date: Tue, 25 Feb 2025 00:35:10 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 36/44] boot: Consider non-bootable partitions
User-Agent: Thunderbird for Android
In-Reply-To: <20250224230640.2665206-37-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
 <20250224230640.2665206-37-sjg@chromium.org>
Message-ID: <B106845F-028F-4787-A719-07411C85B1CD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTBtm5ZRbQEZqGaS3doekMUgrvuotqE5LylKPTuJdA9GBgmzsb/
 9zGaoCkVoGl35btn82ywJ5GNuTaf50lMWinSpIQHwvPNxTwJp0731YzA6DrT3l8miZWJtlB
 HeSuStWunFKlegI6eZkkYGrlqUDkbnnZLABfhnzkmzBjoa7uXQptj9PhJTQV0U5VPoha0at
 zMuS2FMg+JyMWYAXl9TWA==
UI-OutboundReport: notjunk:1;M01:P0:hHFucrrNSVw=;QlA1kjbGlmpxmesvT6dsKnpAeJB
 abyF2lEzN038E+V1avS44ucLA0LjRsImHAre+3Fv8lgJMlKaDKaJduFS6pEYR7nozRC1kzNBh
 418v5E2JF6FBNQxatb4hYf2ymb4Yw6u+7/mqsWnHI5aiCaaJvGSAreW5U1ToIWY7+gmsYSkvC
 b7qxsgzK0QJPbR0qrvZND8X15CP65KjEdaw5O4EXAvdkbwvmHkF/cbmO3kw8IxjH3Oy9htpL1
 XePr/sMv2uBwQX9zij9AMnh1YHlsebPdi1OMuT9p+LAeusGBnC7RUwRLkdi7JQt4SWc0Iv0Es
 plWNqhuvvrnboskQ49F7X7xxNWju1xYA6YvSL+3HA1wAQ2GdoVCOMrF/FGqPYvYs6Rw81YGlo
 B3t7LZ/hNgvbBSYPkZnoZNKvc01yceXe6dkexeOKH8f5elCX9SW1/i8EG6SVjVc8LbFNUeqd7
 rw7eMwlMb56IkaB2ttwqFaI8S28+wmnNewkYUZY7HKxs/22RHhosDD1JBiZ0uhgfhFOhl++lu
 CeLPzO+/EHPk2qGYy+gWRgeJSnMnCTY0/UxSvj4qnp+YngZLRG98asnPdH3lp+dxZeoC17QWX
 xhHtEAAEQdisquuHoHrkUBWv/Q4I2rT8JOkfFdWjI6YUeLwg9KgF03ny15vdQukELTKgs+VSe
 ND7wdsc2ovEwZlIof+emjffGWIBxRhMlEJCyExcWJqZVGdHxydi7OD91a8IXNCFX3YDnU/L2g
 8s9uXvi7dwL8Nr1raF/QFyffrYhGcqRHnxR3u8Q9/KW84UnayhB1Dyl757H/80sZi4GmQVASk
 qmt0eAEdv6c4zS1JKQ5X3FdDpKj9dok7ars2U61TaiNOJ2c9Hxz4oCayH0pJTTpkM1H7s7dNy
 gCibTAK/8qAdGl4wbxgOPGzJwYuJz5YpVqZqerORYyegKo7zMxdJcbVsMMoCW35zmV+f1mTm3
 5ejvv1uH+P6xhewyu7M9JhiY6KYg8MiZHZgeFNCzqoSmmaG00pMsKuBJ9B8rpJvInO8ZSy61f
 MSn1Kvm/tkhAJH4Xt4STk+qdV2XWlLoFk0k46LhAL1FYKzG3pGkL8b8cU4y/xjewEzvsKSIne
 iwmmHmwJZB/GUklqtUiZqm7u1uFS8mSpEVmWYrRiEafTqPXqGHnEvXHGxFq4uA976lHb0uVSv
 xj5GWy7oGOX4VO8ygzDyuvwr9txeeauaD0h+1ISyHXaLtpbaSS+nb67fP36LZa/qGdJwxYo59
 8qJMvRv39psFcr6Kr/nRSV7BW/xtfDD6wKioCRBw/e3L+mosZNlJZ/zA+wKQQ+zPThi9Rwjxe
 9ODrEO3w1xhS/tZG4DnyBS5x27x9Bq1/7KUtYuzrVnFK3Kwq19WOZDN8j15ys/p1hcL7Vwdr3
 ciR7p4b318hEwFjq9xDjQlVXSMyBVLlvaWMKsrgDrolL4VHT5OreqQyeRS
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

Am 25=2E Februar 2025 00:06:25 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>The 'bootable' flag in the DOS partition is deprecated so we should not
>rely on it by default=2E The logic which skips non-bootable partitions ca=
n
>miss extlinux=2Econf files on the root disk=2E

It is unclear why you assume that this flag is deprecated=2E A link to the=
 specification change in the commit message would be helpful=2E

Best regards

Heinrich


>
>Put this logic behind a flag and update the documentation=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v3:
>- Add new patch to consider non-bootable partitions
>
> boot/bootdev-uclass=2Ec            | 4 +++-
> doc/develop/bootstd/overview=2Erst | 5 +++--
> include/bootflow=2Eh               | 2 ++
> test/boot/bootdev=2Ec              | 1 +
> test/boot/bootflow=2Ec             | 5 +++--
> 5 files changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/boot/bootdev-uclass=2Ec b/boot/bootdev-uclass=2Ec
>index c39147940b6=2E=2E9e4c3db2dc1 100644
>--- a/boot/bootdev-uclass=2Ec
>+++ b/boot/bootdev-uclass=2Ec
>@@ -168,8 +168,10 @@ int bootdev_find_in_blk(struct udevice *dev, struct =
udevice *blk,
> 		 */
>=20
> 	/* if there are bootable partitions, scan only those */
>-	} else if (iter->first_bootable >=3D 0 &&
>+	} else if ((iter->flags & BOOTFLOWIF_ONLY_BOOTABLE) &&
>+		   iter->first_bootable >=3D 0 &&
> 		   (iter->first_bootable ? !info=2Ebootable : iter->part !=3D 1)) {
>+		log_debug("Skipping non-bootable partition %d\n", iter->part);
> 		return log_msg_ret("boot", -EINVAL);
> 	} else {
> 		ret =3D fs_set_blk_dev_with_part(desc, bflow->part);
>diff --git a/doc/develop/bootstd/overview=2Erst b/doc/develop/bootstd/ove=
rview=2Erst
>index c46bd7a5a90=2E=2E7bca043791b 100644
>--- a/doc/develop/bootstd/overview=2Erst
>+++ b/doc/develop/bootstd/overview=2Erst
>@@ -235,8 +235,9 @@ means that `default_get_bootflow()` is used=2E This s=
imply obtains the
> block device and calls a bootdev helper function to do the rest=2E The
> implementation of `bootdev_find_in_blk()` checks the partition table, an=
d
> attempts to read a file from a filesystem on the partition number given =
by the
>-`@iter->part` parameter=2E If there are any bootable partitions in the t=
able,
>-then only bootable partitions are considered=2E
>+`@iter->part` parameter=2E If there are any bootable partitions in the t=
able and
>+the BOOTFLOWIF_ONLY_BOOTABLE flag is set in `@iter->flags`, then only bo=
otable
>+partitions are considered=2E
>=20
> Each bootdev has a priority, which indicates the order in which it is us=
ed,
> if `boot_targets` is not used=2E Faster bootdevs are used first, since t=
hey are
>diff --git a/include/bootflow=2Eh b/include/bootflow=2Eh
>index d9045bc3dae=2E=2E2caeb80b878 100644
>--- a/include/bootflow=2Eh
>+++ b/include/bootflow=2Eh
>@@ -161,6 +161,7 @@ struct bootflow_img {
>  * before using it
>  * @BOOTFLOWIF_ALL: Return bootflows with errors as well
>  * @BOOTFLOWIF_HUNT: Hunt for new bootdevs using the bootdrv hunters
>+ * @BOOTFLOWIF_ONLY_BOOTABLE: Only consider partitions marked 'bootable'
>  *
>  * Internal flags:
>  * @BOOTFLOWIF_SINGLE_DEV: (internal) Just scan one bootdev
>@@ -177,6 +178,7 @@ enum bootflow_iter_flags_t {
> 	BOOTFLOWIF_SHOW			=3D 1 << 1,
> 	BOOTFLOWIF_ALL			=3D 1 << 2,
> 	BOOTFLOWIF_HUNT			=3D 1 << 3,
>+	BOOTFLOWIF_ONLY_BOOTABLE	=3D BIT(4),
>=20
> 	/*
> 	 * flags used internally by standard boot - do not set these when
>diff --git a/test/boot/bootdev=2Ec b/test/boot/bootdev=2Ec
>index 5f07430714e=2E=2Ed5499918249 100644
>--- a/test/boot/bootdev=2Ec
>+++ b/test/boot/bootdev=2Ec
>@@ -509,6 +509,7 @@ static int bootdev_test_bootable(struct unit_test_sta=
te *uts)
> 	iter=2Epart =3D 0;
> 	ut_assertok(uclass_get_device_by_name(UCLASS_BLK, "mmc1=2Eblk", &blk));
> 	iter=2Edev =3D blk;
>+	iter=2Eflags =3D BOOTFLOWIF_ONLY_BOOTABLE;
> 	ut_assertok(device_find_next_child(&iter=2Edev));
> 	uclass_first_device(UCLASS_BOOTMETH, &bflow=2Emethod);
>=20
>diff --git a/test/boot/bootflow=2Ec b/test/boot/bootflow=2Ec
>index 49ef4d0c3ab=2E=2E1447af2eb14 100644
>--- a/test/boot/bootflow=2Ec
>+++ b/test/boot/bootflow=2Ec
>@@ -301,8 +301,9 @@ static int bootflow_iter(struct unit_test_state *uts)
>=20
> 	/* The first device is mmc2=2Ebootdev which has no media */
> 	ut_asserteq(-EPROTONOSUPPORT,
>-		    bootflow_scan_first(NULL, NULL, &iter,
>-					BOOTFLOWIF_ALL | BOOTFLOWIF_SKIP_GLOBAL, &bflow));
>+		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
>+					BOOTFLOWIF_SKIP_GLOBAL |
>+					BOOTFLOWIF_ONLY_BOOTABLE, &bflow));
> 	ut_asserteq(2, iter=2Enum_methods);
> 	ut_asserteq(0, iter=2Ecur_method);
> 	ut_asserteq(0, iter=2Epart);

