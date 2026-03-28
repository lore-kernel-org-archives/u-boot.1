Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2A310F3DED
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DA283CD3;
	Sat, 28 Mar 2026 18:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BDZXiXlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8785183DA7; Sat, 28 Mar 2026 18:36:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692CA83642
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774719379; x=1775324179; i=xypron.glpk@gmx.de;
 bh=r/K9U3f8i6uMS7fO/kTHKSveVPexrdPt7k9FahIKdVk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BDZXiXlU6m/MQI9x2rDnwmAp566YG0sJ6Kf9aseIXrXpCesWH1JIuCAODhSNq0wh
 Zik5LP/nGb5qTqTPCgvxppxgy4x1Uvq5HBJBXUXPGSHSIPNm+o3Ngbww6QWKl/j2f
 zoBUGYgxtoS8wUhXCouGMTlRmtofzIuwpeFEnd/dNQleAfnXars9mS796PYnrhnTc
 LiuXTIN0DbFyoW9Jo2hQROwJ8OsXGkx4sy8yITA8WucVo0yx5mh1Dr0zXyBru+GE8
 60W4YOoLLHN3xV4QUCh4QnLZpX1W2I6ypQCfw51Eqe3HdRZTx+dW8uTgC+SM/LR9u
 4+jkvXVpcmlUAQmAHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1vzV803sF4-00Ytka; Sat, 28
 Mar 2026 18:36:19 +0100
Date: Sat, 28 Mar 2026 18:36:15 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
CC: linux-amarula@amarulasolutions.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/4=5D_lib=3A_uuid=3A_add_partit?=
 =?US-ASCII?Q?ion_type_GUID_for_extended_bootloader?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260328171624.2377527-2-dario.binacchi@amarulasolutions.com>
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
 <20260328171624.2377527-2-dario.binacchi@amarulasolutions.com>
Message-ID: <5C2766D4-8A00-4136-B25B-8474E8E8B5AD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sCmsP8QbzV1oZYwi3Rj7Jx/Fwca0wm64BR+5h75+rHQVags+Srg
 F9ZPhdCz+Mt/+eednQYWPwSbyXBD2pzalKjap2u3yqAkHhtcXq2+yqOmIJRpH+piNAuzL0L
 bk2XXlR+XWhOt3A+GmmS5HGUyJ5nqUVqV5b2v2vNwWrM2+1pUArjVO8FUA4MTHaTkRVQZ1h
 2TqwT6+kJt3ZnAlGZxQIA==
UI-OutboundReport: notjunk:1;M01:P0:jit9K7yzDMk=;1n+5mc44O8BhUzty0MxQt8HA4Lx
 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
 Uvl56Lccaj5qy7ryiDUNLocVzxM97hGIA==
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

Am 28=2E M=C3=A4rz 2026 18:15:14 MEZ schrieb Dario Binacchi <dario=2Ebinacc=
hi@amarulasolutions=2Ecom>:
>The Extended Boot Loader Partition (XBOOTLDR) is a standard defined by
>the Discoverable Partitions Specification (DPS) to host boot loader
>resources outside of the EFI System Partition=2E
>
>Defining this GUID (bc13c2ff-59e6-4262-a352-b275fd6f7172) allows U-Boot
>to correctly identify and label these partitions using the "xbootldr"
>shorthand=2E

Please, provide a link to the specification that defines what XBOOTLDR is =
and that this GUID should be used in the commit message=2E

Best regards

Heinrich

>
>Signed-off-by: Dario Binacchi <dario=2Ebinacchi@amarulasolutions=2Ecom>
>---
>
> doc/README=2Egpt     | 2 ++
> include/part_efi=2Eh | 3 +++
> lib/uuid=2Ec         | 1 +
> 3 files changed, 6 insertions(+)
>
>diff --git a/doc/README=2Egpt b/doc/README=2Egpt
>index 386ac2e0fc8f=2E=2Ea6e1fd7ce8d4 100644
>--- a/doc/README=2Egpt
>+++ b/doc/README=2Egpt
>@@ -286,6 +286,8 @@ Some strings can be also used at the place of known G=
UID :
> 	                    (E6D6D379-F507-44C2-A23C-238F2A3DF928)
> 	"u-boot-env"      =3D PARTITION_U_BOOT_ENVIRONMENT
> 	                    (3DE21764-95BD-54BD-A5C3-4ABE786F38A8)
>+	"xbootldr"        =3D PARTITION_XBOOTLDR
>+	                    (BC13C2FF-59E6-4262-A352-B275FD6F7172)
>=20
>     "uuid_disk=3D=2E=2E=2E;name=3Du-boot,size=3D60MiB,uuid=3D=2E=2E=2E;
> 	name=3Dkernel,size=3D60MiB,uuid=3D=2E=2E=2E,type=3Dlinux;"
>diff --git a/include/part_efi=2Eh b/include/part_efi=2Eh
>index fb402df6f13e=2E=2Eafb21569c932 100644
>--- a/include/part_efi=2Eh
>+++ b/include/part_efi=2Eh
>@@ -59,6 +59,9 @@
> #define PARTITION_U_BOOT_ENVIRONMENT \
> 	EFI_GUID( 0x3de21764, 0x95bd, 0x54bd, \
> 		0xa5, 0xc3, 0x4a, 0xbe, 0x78, 0x6f, 0x38, 0xa8)
>+#define PARTITION_XBOOTLDR \
>+	EFI_GUID( 0xbc13c2ff, 0x59e6, 0x4262, \
>+		0xa3, 0x52, 0xb2, 0x75, 0xfd, 0x6f, 0x71, 0x72)
>=20
> /* Special ChromiumOS things */
> #define PARTITION_CROS_KERNEL \
>diff --git a/lib/uuid=2Ec b/lib/uuid=2Ec
>index 0a166320e077=2E=2Ecf5f8be48a32 100644
>--- a/lib/uuid=2Ec
>+++ b/lib/uuid=2Ec
>@@ -86,6 +86,7 @@ static const struct {
> 	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
> 	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
> 	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
>+	{"xbootldr",	NULL,	PARTITION_XBOOTLDR},
> 	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
> 	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
> 	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},

