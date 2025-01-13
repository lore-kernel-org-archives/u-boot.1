Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3799BC02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 17:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B753D805DA;
	Mon, 13 Jan 2025 18:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZDXjiyRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A00F805E9; Mon, 13 Jan 2025 18:52:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DEA801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 18:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736790745; x=1737395545; i=xypron.glpk@gmx.de;
 bh=U0YOyxQ7J0IBTN4uwmSwOsc3WXd7F+Ssr22D0mUDqgc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZDXjiyRMR2YXD0UW/cv9WqU44c4NFdvIJ7jWrL4LHT99c8qgEPNEKNW9uNpWvLc7
 yorj8V50xXuliGp0LntZbHf+hLML9aZDEOUuOvXONt6RHTJImM4XOrcdjSeKF7q8B
 YnVtMVDjN7Ei5HwSM7RZ1xqppKXde5K0NHlwNFb3NeFd/o9e2lxJyP2GdjLBdz0cW
 RzNP+izb9qrQPjQDPm2mljlSdrteJqwX+AkS8XETixhmzx0WtF/yuFbJzOq4ieAeQ
 a/GCB4J+7HOM1BRFEEoZBD3YJ08KnV3lD2sFmiG3QGziFc83JEGnJfB+557d/KA0N
 thY5HmuhK2Fk5AuIGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1szznj24ha-00qLxl; Mon, 13
 Jan 2025 18:52:25 +0100
Message-ID: <6f9ee72c-ca8c-46ea-935f-9b5b697791c0@gmx.de>
Date: Mon, 13 Jan 2025 18:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Levi Yun
 <yeoreum.yun@arm.com>, Evgeny Bachinin <EABachinin@salutedevices.com>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-3-raymond.mao@linaro.org>
 <C7D7CE8A-CA02-4093-BA34-DC990717D32C@gmx.de>
 <CAEfUkUKpiHrgbUye8TaQ2_+HT1++1i_n65bmbSnq0_R0oygLLw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAEfUkUKpiHrgbUye8TaQ2_+HT1++1i_n65bmbSnq0_R0oygLLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EY/s1KPqo1aCGg1nvfCx+0PBEbvz1JLSIS+ww2n7s2FfzxsaTNd
 lkvZXl/vR3JBAqDhQPkidh4P1tzd4C/YATano+nSs1OOwwq4jqd0QhWZj886BQK4HHfm3As
 h233QYntVEJAb3amRcKS/KpN7rdVGsIpRGIIzSJoi6Gwg2j2mtERHuk3Wg+tKeFojoKlrQx
 s7mMDCar4r6qjJSw+gkOA==
UI-OutboundReport: notjunk:1;M01:P0:i2mZ+AQ2tV0=;5XDke03HB4IoCUs/3M3+bgALj2+
 P1gnWoKnkQXsA8NqbEPWWtODZ87Fh0hOroUiCbNhYhrFRohNvgnXS4Y9vvR2KCzNdJEBIMK/1
 hdQbcdcmp4ZM6b217RrVRVIhHZnJ7GHDTegeGD/luQEIcsdhyU4paldSrTuPyJs4sLfjMGREG
 ZgiKWH4Wj1V4dd7UuxbYUK0fGjFQsetUP1C4kI4iJMtGpNkqx7xFD/yRwRE5cScJN/iMcodGT
 AW/Ss2JTPr7YeOlvdR5o/VzH3vCydcW4dT2COqoGLdD8juj1uDS/IWmJOva/Qb4EbpMiONIq8
 BmPF1SLrIhgEkltA6zndQ1M4SazCE7r1xKh1Ac7hVI/DgKsFRg7tdC3upaIowu6FIWjAAx6BQ
 3uPmNEFxpLhnMkR0jysyRz/nbHDh8fj5p8YFwrmEnuXCRl5Uc0mJ6MWmXAyH3/rkDfpMQpt5E
 7CT6giZ2SWeOIXcA143Zbi0AkEDxkqJEkBYYXY/LW2pRxZjYqJ1ykohHV6iBPZOj3tGSxY6Cg
 TNqbZjta5SrOGqcuMVOxvg5Qw4xApEl8rQWHP7tEc+x1g0lSFsufPNKSFMQdhNj+O7fA2OF7n
 mdtAKtWJbtP+udQFYfFT1PsaDMGlz1K2okkYjluw/ltuMj1T2aRq42K5rtG6TEXmERnSkQTL5
 5aqbTpLWGiTIFqBOXNT9xoZGwHMhJ8+SmFDsyj2O91YpTuOhif/HC2UPlEBCyaXpS1plw+LCc
 k3Rew18pLqlDxfI6AbZxGcpqA0nL0qgvC4yenxt8gIzhmUNdELpaL48NjAQMLH3MISwABFpSH
 UOJCpz7LVIwkZQQUwTJHluU9ErsWuzoXR0GDF+NN27o1kBKOgkDj/HOia/5FBVUejhPGJyTLo
 qf3b7Lr15sm0WFVUd1qgLUO341WAWOTR04FRKWX9c1dbkh9RqDnkdt1cPQ7E+QfxemxaLEw2l
 fuIZaTE0rj2y2efdGSfsQ+OZTIlFY5s8CZ3ute2PilI4Vo8ifgv0Y237/hkc1Uws/PXram69/
 6ilQjKEZCwyODea5+K3bdM6qBK/v3QCC5r/o22XJirLSl2k/xabHQCxFWXrTzmpFCqB49KGx8
 fkVPtAROkffsHfrhXooyvxpF0FTYTo
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

On 13.01.25 15:43, Raymond Mao wrote:
> Hi=C2=A0Heinrich,
>
> On Fri, 10 Jan 2025 at 19:12, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>
>     Am 10. Januar 2025 22:56:35 MEZ schrieb Raymond Mao
>     <raymond.mao@linaro.org <mailto:raymond.mao@linaro.org>>:
>      >Get tpm event log from bloblist instead of FDT when bloblist is
>      >enabled and valid from previous boot stage.
>      >
>      >As a fallback, when no event log from previous stage is observed
>      >and no user buffer is passed, malloc a default buffer to initializ=
e
>      >the event log.
>      >
>      >Signed-off-by: Raymond Mao <raymond.mao@linaro.org
>     <mailto:raymond.mao@linaro.org>>
>      >---
>      >Changes in v2
>      >- Remove patch dependency.
>      >- Remove the fallback to FDT when BLOBLIST is selected.
>      >Changes in v3
>      >- Malloc an 8KB buffer when user eventlog buffer does not exist.
>      >Changes in v4
>      >- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
>      >
>      > lib/tpm_tcg2.c | 55 ++++++++++++++++++++++++++++++++
>     +-----------------
>      > 1 file changed, 36 insertions(+), 19 deletions(-)
>      >
>      >diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
>      >index 7f868cc883..685699688b 100644
>      >--- a/lib/tpm_tcg2.c
>      >+++ b/lib/tpm_tcg2.c
>      >@@ -5,6 +5,7 @@
>      >
>      > #include <dm.h>
>      > #include <dm/of_access.h>
>      >+#include <malloc.h>
>      > #include <tpm_api.h>
>      > #include <tpm-common.h>
>      > #include <tpm-v2.h>
>      >@@ -19,6 +20,7 @@
>      > #include <linux/unaligned/generic.h>
>      > #include <linux/unaligned/le_byteshift.h>
>      > #include "tpm-utils.h"
>      >+#include <bloblist.h>
>      >
>      > int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr,
>     u32 *active_pcr,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0u32 *pcr_banks)
>      >@@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice
>     *dev, struct tcg2_event_log *elog,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elog->found=
 =3D log.found;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >
>      >+=C2=A0 =C2=A0 =C2=A0 if (elog->found)
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>      >+
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0* Initialize the log buffer if no log =
was discovered and
>     the buffer is
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0* valid. User's can pass in their own =
buffer as a fallback
>     if no
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0* memory region is found.
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0* Initialize the log buffer if no log =
was discovered.
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0* User can pass in their own buffer as=
 a fallback if no
>     memory region
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0* is found, else malloc a buffer if it=
 does not exist.
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>      >-=C2=A0 =C2=A0 =C2=A0 if (!elog->found && elog->log_size)
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D tcg2_log_=
init(dev, elog);
>      >+=C2=A0 =C2=A0 =C2=A0 if (!elog->log_size) {
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elog->log =3D ma=
lloc(TPM2_EVENT_LOG_SIZE);
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!elog->log)
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -ENOMEM;
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(elog->log=
, 0, TPM2_EVENT_LOG_SIZE);
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elog->log_size =
=3D TPM2_EVENT_LOG_SIZE;
>      >+=C2=A0 =C2=A0 =C2=A0 }
>      >
>      >-=C2=A0 =C2=A0 =C2=A0 return rc;
>      >+=C2=A0 =C2=A0 =C2=A0 return tcg2_log_init(dev, elog);
>      > }
>      >
>      > int tcg2_measurement_init(struct udevice **dev, struct
>     tcg2_event_log *elog,
>      >@@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct
>     udevice *dev, void **addr, u32 *size)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0const __be32 *size_prop;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0int asize;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0int ssize;
>      >+=C2=A0 =C2=A0 =C2=A0 struct ofnode_phandle_args args;
>      >+=C2=A0 =C2=A0 =C2=A0 phys_addr_t a;
>      >+=C2=A0 =C2=A0 =C2=A0 fdt_size_t s;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0*addr =3D NULL;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;
>      >
>      >+=C2=A0 =C2=A0 =C2=A0 *addr =3D bloblist_get_blob(BLOBLISTT_TPM_EV=
LOG, size);
>      >+=C2=A0 =C2=A0 =C2=A0 if (*addr && *size)
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>      >+=C2=A0 =C2=A0 =C2=A0 else if (CONFIG_IS_ENABLED(BLOBLIST))
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>      >+
>
>     You are querying the CONFIG value. Why call function
>     bloblist_get_blob if blobs are not supported? Please, simply skip in
>     this case.
>
> Actually BLOBLIST is not required to call bloblist_get_blob here since I
> have added the inline function, but we need a kconfig to separate the
> user's preference on "fallback to DT" or not.
> BLOBLIST is not a perfect=C2=A0idea but a temporary=C2=A0solution before=
 we have a
> concrete idea to define one new kconfig for "blobs handoff from previous
> boot stage is mandatory".
> For more information, please see the previous discussion between me, Tom
> and Simon in v1 of this patch.

Why should we call the empty inline function, if we already check the
CONFIG value?

Best regards

Heinrich

>
> Regards,
> Raymond
>
>
>
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0addr_prop =3D dev_read_prop(dev, "tpm_e=
vent_log_addr", &asize);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!addr_prop)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_prop =
=3D dev_read_prop(dev, "linux,sml-base",
>     &asize);
>      >@@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct
>     udevice *dev, void **addr, u32 *size)
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*addr =3D m=
ap_physmem(a, s, MAP_NOCACHE);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D (=
u32)s;
>      >-=C2=A0 =C2=A0 =C2=A0 } else {
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofnode_ph=
andle_args args;
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addr_t a;
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_size_t s;
>      >
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_read_pha=
ndle_with_args(dev, "memory-
>     region", NULL, 0,
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00, &args))
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -ENODEV;
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>      >+=C2=A0 =C2=A0 =C2=A0 }
>      >
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a =3D ofnode_get=
_addr_size(args.node, "reg", &s);
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a =3D=3D FDT=
_ADDR_T_NONE)
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -ENOMEM;
>      >+=C2=A0 =C2=A0 =C2=A0 if (dev_read_phandle_with_args(dev, "memory-=
region", NULL,
>     0, 0, &args))
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>      >
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *addr =3D map_ph=
ysmem(a, s, MAP_NOCACHE);
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D (u32)s=
;
>      >-=C2=A0 =C2=A0 =C2=A0 }
>      >+=C2=A0 =C2=A0 =C2=A0 a =3D ofnode_get_addr_size(args.node, "reg",=
 &s);
>      >+=C2=A0 =C2=A0 =C2=A0 if (a =3D=3D FDT_ADDR_T_NONE)
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 *addr =3D map_physmem(a, s, MAP_NOCACHE);
>      >+=C2=A0 =C2=A0 =C2=A0 *size =3D (u32)s;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>      > }
>

