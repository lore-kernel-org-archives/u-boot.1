Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31867CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892D087D8E;
	Wed, 10 Apr 2024 19:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MsJzrXtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D5888149; Wed, 10 Apr 2024 19:27:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12EF87B71
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712770038; x=1713374838; i=xypron.glpk@gmx.de;
 bh=RG1vq/9D0F1K9Zv7FI28LYvtnM6DtCXuTmQQfGZip2E=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=MsJzrXtqJD2uxHZbkHE1Rcr5xbpsJgAc3SeGHUmT+5BXvDMTNWqLne2Q3AABIOTP
 ke/cShR5yRTkinQMpmDaRf81u6aWINkW2mpDHhJHywYsiXHFYjCrfSdljxu0+7GoV
 LyyP65hITe9C9uchOUch/Qr6KVel305gw1zsuwKrHWxFsMQ6K2WQIbKEE4qk1Ok8/
 1ChEnlm3OAGC3KR5EUEULdf6E9hgeBjhFAhVh6XwcvvbKFhnrpiGrKaHpPeyyxIx+
 RK0bU1MOlOH9VSWDTAxUrEWGDTcpB3qtJ/nPBzcoythyhTZBLGmpWbaJeErlJnUHX
 XUcQNH4VClQ2wgVGsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1swUoR2cUT-012IlU; Wed, 10
 Apr 2024 19:27:18 +0200
Date: Wed, 10 Apr 2024 19:27:17 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
User-Agent: K-9 Mail for Android
In-Reply-To: <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
Message-ID: <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:psZBGLp1/T5hTtJ4yuSs533IxSN3ccXhm89f/AtWa2GxZVRSxGF
 ijZs9ruNzctvgV+GOtxQIEz2cTbUd502yx6ExK2BLxtceEq2KOKSsnB2rJvu9abSjFxV8E0
 FRqPHVkuQ0pKXqD5cHERz6hsUw0Ckd608kTW6vkMh+SrqY2K3BjYRKom5kw2huAfYYJnHr5
 R2yj21+GGubGos5OAIqjA==
UI-OutboundReport: notjunk:1;M01:P0:EquyjtwI/mU=;xHPikNAmb0EeZq96iVemOS90MUE
 vZx3q55YPNL/YlzFJBTmf7cSIWq/Y6uVztcS6zB8q0UWs0GuNU1MJoRPS7a17uCBFHIwbfLob
 cWtZimZ8EzGGC4niM9Er0oU66TbTrQFGJVSzMgeJwX3eMVs/++rSaYdUvebKjJv9GG5Gvvbij
 NAsGaSbcfqvDT9oNTVpRrT2zDllmYECu96nrUkYO+EzwWOuTnpCelY3D2CrmHBNiCk3wX3P9p
 IFAwWg9HbMiQYAG3lyLkgMomcb5vSqxz8nykR2+ZZrxChI+HjaCfltCCP80efcMqfquq59Jno
 gpFnXlZB4vQiBXGKkZXhaTrFCAD7QslRqEp3BySSPDLk7zc9cw3oI+tA6PBYpqt3+3iMoXPsd
 pZc07vh3mWrZLQTB+TvB32PbK1vw/XwSDgK0v1ZrFpKv5UH88yyfpevkzkII/v20UlpNSPIO0
 0QbKAK9944xNaz/WMHLzIqD88CSfpELXKDgUUO4Hy6cQu72pyzdJeHjEuU4WvsLpMtbyxOhOj
 EflYDXER2d3lFxrlBcnfuksUwgqHg42q7cqdJWV7uaSXbkix7ykWx9SphXonUY4YQ0orwx4Yk
 b79PvFv2eA6V0pWh0YBMg9tOB5gmSZuj1KS4aPCxEKcxf2BVpogWE8ESaqPBGfIo6Gk/RpSdL
 a2mbKNHdbX8GUkkpvHa/7Np2U2O12un3j4Q7PU60wWmGPPqM95sINB7c48qGW87i84H31kbNh
 HiH0lgU9LUIG/QMzKlTfX/Flf1+o2k3JxSN/reiR0xS3A13SJuTJWV6gzlp/GT2lU383/L4IE
 bjFY0Z95eICX2HktWGhPYtXHndAtMvWJWSj+zoZNYCyTo=
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



Am 10=2E April 2024 19:06:57 MESZ schrieb Caleb Connolly <caleb=2Econnolly=
@linaro=2Eorg>:
>Introduce support for a uclass to provide a fallback/stub driver which
>can be used when no device is found for a given node=2E This might be
>useful for handling non-essential clock controllers like the RPMh on
>Qualcomm platforms, or during early bringup to get UART output before a
>real clock driver has been created=2E
>
>Signed-off-by: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>---
> drivers/core/Kconfig  | 10 ++++++++++
> drivers/core/uclass=2Ec | 24 +++++++++++++++++++++++-
> include/dm/uclass=2Eh   |  3 +++
> 3 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>index 1081d61fcf01=2E=2E09075b9b7a15 100644
>--- a/drivers/core/Kconfig
>+++ b/drivers/core/Kconfig
>@@ -466,5 +466,15 @@ config BOUNCE_BUFFER
>=20
> 	  A second possible use of bounce buffers is their ability to
> 	  provide aligned buffers for DMA operations=2E
>=20
>+menuconfig FALLBACK_DRIVERS

Wouldn't it be preferable to mark individual drivers as fallback drivers i=
n their declaration?

This would allow alternative fallback drivers and would not require any de=
finitions at uclass level=2E

Just by building a fallback driver you would enable the fallback behavior =
for its uclass=2E

Best regards

Heinrich

>+	bool "Enable per-uclass fallback drivers"
>+	depends on DM
>+	help
>+	  If a driver requests a resource (like a clock) from a node which
>+	  isn't bound to a driver, the driver model will look for a fallback
>+	  driver to "stub" the resource=2E These stubs usually do nothing and
>+	  are therefore only suitable in instances where the resource is not
>+	  required=2E
>+
> endmenu
>diff --git a/drivers/core/uclass=2Ec b/drivers/core/uclass=2Ec
>index e46d5717aa62=2E=2E91d3a48d77b8 100644
>--- a/drivers/core/uclass=2Ec
>+++ b/drivers/core/uclass=2Ec
>@@ -378,8 +378,26 @@ int uclass_find_device_by_of_offset(enum uclass_id i=
d, int node,
>=20
> 	return -ENODEV;
> }
>=20
>+static int uclass_bind_fallback(struct uclass *uc, ofnode node, struct u=
device **devp)
>+{
>+	struct driver *drv;
>+
>+	log(LOGC_DM, LOGL_ERR, "   - binding fallback '%s' driver '%s'\n",
>+	    uc->uc_drv->name, uc->uc_drv->fallback_drv_name);
>+
>+	drv =3D lists_driver_lookup_name(uc->uc_drv->fallback_drv_name);
>+	if (!drv) {
>+		log(LOGC_DM, LOGL_DEBUG, "   - Can't find stub driver '%s' for uclass =
'%s'\n",
>+		    uc->uc_drv->fallback_drv_name, uc->uc_drv->name);
>+		return -ENOENT;
>+	}
>+
>+	return device_bind_with_driver_data(gd->dm_root, drv,
>+					  ofnode_get_name(node), 0, node, devp);
>+}
>+
> int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
> 				 struct udevice **devp)
> {
> 	struct uclass *uc;
>@@ -401,9 +419,13 @@ int uclass_find_device_by_ofnode(enum uclass_id id, =
ofnode node,
> 			*devp =3D dev;
> 			goto done;
> 		}
> 	}
>-	ret =3D -ENODEV;
>+
>+	if (CONFIG_IS_ENABLED(FALLBACK_DRIVERS) && uc->uc_drv->fallback_drv_nam=
e)
>+		ret =3D uclass_bind_fallback(uc, node, devp);
>+	else
>+		ret =3D -ENODEV;
>=20
> done:
> 	log(LOGC_DM, LOGL_DEBUG, "   - result for %s: %s (ret=3D%d)\n",
> 	    ofnode_get_name(node), *devp ? (*devp)->name : "(none)", ret);
>diff --git a/include/dm/uclass=2Eh b/include/dm/uclass=2Eh
>index 456eef7f2f31=2E=2Eb99e36485bc5 100644
>--- a/include/dm/uclass=2Eh
>+++ b/include/dm/uclass=2Eh
>@@ -67,8 +67,10 @@ struct udevice;
>  * @child_pre_probe: Called before a child in this uclass is probed
>  * @child_post_probe: Called after a child in this uclass is probed
>  * @init: Called to set up the uclass
>  * @destroy: Called to destroy the uclass
>+ * @stub_drv_name: Name of a stub driver to use for devices that are not
>+ * supported by any other driver=2E
>  * @priv_auto: If non-zero this is the size of the private data
>  * to be allocated in the uclass's ->priv pointer=2E If zero, then the u=
class
>  * driver is responsible for allocating any data required=2E
>  * @per_device_auto: Each device can hold private data owned
>@@ -98,8 +100,9 @@ struct uclass_driver {
> 	int (*child_pre_probe)(struct udevice *dev);
> 	int (*child_post_probe)(struct udevice *dev);
> 	int (*init)(struct uclass *class);
> 	int (*destroy)(struct uclass *class);
>+	const char *fallback_drv_name;
> 	int priv_auto;
> 	int per_device_auto;
> 	int per_device_plat_auto;
> 	int per_child_auto;
>
