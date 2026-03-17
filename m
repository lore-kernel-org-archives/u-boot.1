Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD422F3381E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 09:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D09F841B8;
	Tue, 17 Mar 2026 10:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TT0vfFQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39B3841B9; Tue, 17 Mar 2026 10:12:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82BC8419C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 10:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773738723; x=1774343523; i=xypron.glpk@gmx.de;
 bh=/8NCiqwdn4aPrS/7liu6RAE+CaP694YydYWuErT2788=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TT0vfFQ43o+w6Bp/KKjOgO2R3AHp0Bf64SQdaBBdJTU7Wr/doGMslxtx+zoM4DJM
 u6P4Y2WgOKqJYwNHeuu+fjiRIL/SuBuZosB7/u1qCDKNMua5lVDr/PmxseVt47zXz
 SDKpbeQ7Xu9E4gVqEKfNiULt+91YC9i0GYsWqL0bhf+JsBChuXk81hCBgfcYEHXSG
 XLv1xQe6GI5qfpu2esOj3O697ChDWYL/8BifNAIgFPki1hF/BTRv8M0QjWFBCHPuW
 J3K/X+62B++eKzNABStMJ/rd42zlQN+tLQGTz5+DB+UuhNpbm7MSKj9q+U4hP2f9U
 +kK0L2BDr4tEG59bJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1vVdrn2uwS-00t2kG; Tue, 17
 Mar 2026 10:12:03 +0100
Date: Tue, 17 Mar 2026 10:12:02 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Michal Simek <michal.simek@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v11] efi_vars: Implement SPI Flash store
User-Agent: Thunderbird for Android
In-Reply-To: <8b100da2-0e81-4340-9e5f-cb534449416a@amd.com>
References: <8ee5fc7a49816d9e26f38999990aa1e4e354801f.1773416725.git.michal.simek@amd.com>
 <9334dd3b-3bf9-43f3-b711-235246f3c901@gmx.de>
 <8b100da2-0e81-4340-9e5f-cb534449416a@amd.com>
Message-ID: <64CD4FB5-7EB5-41AF-93EE-12C8275874AD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gMRUBEWV1DjnjeDPOdCNnhqL/TI6c5J86WkWr3vKUWVwGo3zFN/
 mViqsv1ObJQWvRQKPmUG1MaoeUyNYxDcfGaYZX+HsiHrWomzO6Lr9jejnt6e+rbEzVPnh9q
 PQleuJX65p2Ln4cGYztLW7NkGHVUqzzD2ZHGS/1CVgdM2eKDN06HUWvZZ6tFBFajvangxMm
 HzT2hTfWfpRxATWgqkcAQ==
UI-OutboundReport: notjunk:1;M01:P0:twkV/pdh7OQ=;35uIPDK7A5BWDF8P0QVyUmaIRhR
 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
 t+FCqhDGzLbnScr0Sn8rPqTfwAt9pu1iQ==
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

Am 16=2E M=C3=A4rz 2026 12:54:56 MEZ schrieb Michal Simek <michal=2Esimek@a=
md=2Ecom>:
>
>
>On 3/14/26 10:19, Heinrich Schuchardt wrote:
>> On 3/13/26 16:45, Michal Simek wrote:
>>> From: Shantur Rathore <i@shantur=2Ecom>
>>>=20
>>> Currently U-Boot uses ESP as storage for EFI variables=2E
>>> Devices with SPI Flash are used for storing environment with this
>>> commit we allow EFI variables to be stored on SPI Flash=2E
>>>=20
>>> Signed-off-by: Shantur Rathore <i@shantur=2Ecom>
>>> Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>
>>> Tested-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg> # on AML-S90=
5D3-CC
>>> Acked-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>>=20
>> Tested on StarFive VisionFive 2=2E
>>=20
>> Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>=20
>>=20
>> The next logical step will be to define a value like RTStorageVolatile =
and allow to select CONFIG_EFI_RT_VOLATILE_STORE=2E
>>=20
>> One way to define the location would be a SPI flash partition defined i=
n the device-tree=2E An EFI variable could provide the compatible property =
of the partition that efivar should write to=2E
>>=20
>>  =C2=A0=C2=A0=C2=A0 partitions {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "fixed-parti=
tions";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@c0000 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "uboot-efivar";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0xc0000 0x20000>;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>  =C2=A0=C2=A0=C2=A0 };
>>=20
>> cf=2E Linux
>> Documentation/devicetree/bindings/mtd/partitions/partition=2Eyaml
>
>Can you clarify your request?
>I mean, yes partition can be defined but that's more or less for OS/efiva=
r=2E
>U-Boot is using Kconfig parameters to save it to exact location=2E
>Or are you suggesting that u-boot itself should be also decoding location=
s from mtd partition (as second configuration method)?

Using the same way to identify the EFI variables storage area could be hel=
pful but is not a must=2E

The major usages for writing variables from Linux I have seen are:

* updating boot variables
* updating the security database, e=2Eg=2E dbx
* indicating a capsule update

Updating boot variables will require either a driver in the Linux kernel o=
r support in the efivar package or a runtime driver for writing to the SPI =
flash=2E

For updating the EFI security database a secure world driver for the SPI f=
lash would be preferable but that is beyond the scope of the current develo=
pment=2E

Best regards

Heinrich

