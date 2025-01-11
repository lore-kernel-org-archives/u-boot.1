Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F0E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0C3800D0;
	Sat, 11 Jan 2025 01:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jw1yMOy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2742D801B0; Sat, 11 Jan 2025 01:12:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D2F80050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736554367; x=1737159167; i=xypron.glpk@gmx.de;
 bh=6xhmYgZHip18Y1wDqvcRZ58mizDxjLE0V9sPjttl4+A=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jw1yMOy43rJIpx3Rc1rioiH5im9d8FjZAx/sSx4GQ5vHua02uVo/skJmmigsstyS
 jm7pT6SF1F4INMQwOcI/DS+8BVDjG5VUoo1S7AxrPSH1emkcaZuUYhfMxVeLJvXqW
 UiydBHpzIlbgaEGxqHf2uVBRt8tneRPxMTREAw5AuLGQRHVaaNusPJUlvNdE+Ngn4
 xociLnsvSeQRHgGfQNgFFCOA0SIiND6erlxVUwIojTQcvAGTgqA61kNVNfGaovxWJ
 aOy0xTKtqYSR0lTdB6kG0tQ5CrqZsd0AHFFBDMGgK1bm56+yP5tws6xFEgWbV7V/t
 dKyl9rxJ3ya6zRYCFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1t7lbC2csD-00gek7; Sat, 11
 Jan 2025 01:12:47 +0100
Date: Sat, 11 Jan 2025 01:12:45 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: Re: [PATCH v4 3/3] tpm: get tpm event log from bloblist
User-Agent: Thunderbird for Android
In-Reply-To: <20250110215640.892539-3-raymond.mao@linaro.org>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-3-raymond.mao@linaro.org>
Message-ID: <C7D7CE8A-CA02-4093-BA34-DC990717D32C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:15CtRBe9omTGArq1ESf3H+vNaywYXbTgk0ClDhhjZVOtHPmOku4
 5lfJedk4lInFvZiihoDpRRR1lBlCnih2ZaqLs02MNdme36hZpgtLb325G3ii4qWkauW276r
 ApqIh1YrZ0iSksmFuSSd1iDacgactZvhSygkcq5Vblht/oEjF3fFMO7SDHQsFg31zwyc4Sg
 ntXcWsU/QoQbvQhUd68vA==
UI-OutboundReport: notjunk:1;M01:P0:Vp/n68PuYr8=;Fr/DK98bDMTkZu9TMcViB8KrDCG
 5Trb4lWMEVsAM7wcokCs1fBBW4giXZ8flzVj3kkUSeXI6VyLyXM7EAB8e1Wh5JJFo92KHS7Ci
 hG/KS1asa8jBBseiddf/P2Y2qVGJDwXVn36TM5ct7tGiQJsmpuOaMwtPQMa/kVc15GofFcY0P
 6tC9bUQBkOCeQGcjgPqsbF0hySbpvsCvnnTYLBhmdVPVaizw1FIZuRG2XSqNG91VgImNw6xD8
 /scHyLLRivi8yPrLc0U+670aCR9Q2u90HY5T4cDu/ZNqZH9viWRj6fhpRnAkh5UP59OpX/BnI
 k1rbCJJcNtcG9FV15DQJ2R76B6sNEp0gxskekc1gXzifBKCCzn8EI895oT55plh3NCZbyBrbb
 Q7hkLYv4n/usO2r5Ag9Ap7tfzS095oKlk8lPLoxkjTqNW87VdzL4OydC2gZnx/duTQBLrR9pU
 ypbKd25IxkaJHuqTr/qFmFSGxluHCUqxQvHUVbXNSDd/XRTrZMH4j7DFrV2d6gyWsxDOvSZ93
 U+BU8GC3kfIngtjsjDYUiX64edjXEGemO5sBaQyUB9kcScFgI+RbbxVeAH5U6czcwCELIHsN3
 zntuTCHAWm0d9iuHbdHn/wnKvjdeRAsyvcYyc84vQVBhcyCC/FjCjf/iixjAMcRVnof2L8tSX
 IBc3jfoRO6OGWenr+30GBWXWzvovAV0mYr5vZDJjE3shHOIcUjSd4C0afjWCgRJewJkn8EbN6
 uSESflb8ndSNOj+KUvHMVmM30iVhg8yucw7pkipGJW9rUoquDbouA8n60xNBo2vTBrGtQJ1X1
 s7nCmu1KGg5voU1KIiQOPO/x/aVny5v27MKYx7iAQAyi/TM1HRQPd2J9+GaBRZAeiV5YplW/m
 ISgI6Yfk3CrKbwlGrqxE0FW+ei2kp1sxOpPKTc9yG5FJX2g7BVj1hGJg7I4MzsQsuwuHstFNC
 YrFAsQQUjhHkqOxOgPIL6YesCT8FSvOT7dW8PpZkOvrPThCDsdupCPkLUZuhpHwp0YmfKJ6Jd
 9IoFYhDBKR7+yBGpbvVm3460bDwedhMrsC0ZTvGAGcmuWluMOZXl93d6WLMMUolkiRXeChtEm
 sR4zbAQ4RDoecthIbFh1rKw8hT6ub3
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

Am 10=2E Januar 2025 22:56:35 MEZ schrieb Raymond Mao <raymond=2Emao@linaro=
=2Eorg>:
>Get tpm event log from bloblist instead of FDT when bloblist is
>enabled and valid from previous boot stage=2E
>
>As a fallback, when no event log from previous stage is observed
>and no user buffer is passed, malloc a default buffer to initialize
>the event log=2E
>
>Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>---
>Changes in v2
>- Remove patch dependency=2E
>- Remove the fallback to FDT when BLOBLIST is selected=2E
>Changes in v3
>- Malloc an 8KB buffer when user eventlog buffer does not exist=2E
>Changes in v4
>- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE=2E
>
> lib/tpm_tcg2=2Ec | 55 +++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 36 insertions(+), 19 deletions(-)
>
>diff --git a/lib/tpm_tcg2=2Ec b/lib/tpm_tcg2=2Ec
>index 7f868cc883=2E=2E685699688b 100644
>--- a/lib/tpm_tcg2=2Ec
>+++ b/lib/tpm_tcg2=2Ec
>@@ -5,6 +5,7 @@
>=20
> #include <dm=2Eh>
> #include <dm/of_access=2Eh>
>+#include <malloc=2Eh>
> #include <tpm_api=2Eh>
> #include <tpm-common=2Eh>
> #include <tpm-v2=2Eh>
>@@ -19,6 +20,7 @@
> #include <linux/unaligned/generic=2Eh>
> #include <linux/unaligned/le_byteshift=2Eh>
> #include "tpm-utils=2Eh"
>+#include <bloblist=2Eh>
>=20
> int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *acti=
ve_pcr,
> 		      u32 *pcr_banks)
>@@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, st=
ruct tcg2_event_log *elog,
> 		elog->found =3D log=2Efound;
> 	}
>=20
>+	if (elog->found)
>+		return 0;
>+
> 	/*
>-	 * Initialize the log buffer if no log was discovered and the buffer is
>-	 * valid=2E User's can pass in their own buffer as a fallback if no
>-	 * memory region is found=2E
>+	 * Initialize the log buffer if no log was discovered=2E
>+	 * User can pass in their own buffer as a fallback if no memory region
>+	 * is found, else malloc a buffer if it does not exist=2E
> 	 */
>-	if (!elog->found && elog->log_size)
>-		rc =3D tcg2_log_init(dev, elog);
>+	if (!elog->log_size) {
>+		elog->log =3D malloc(TPM2_EVENT_LOG_SIZE);
>+		if (!elog->log)
>+			return -ENOMEM;
>+
>+		memset(elog->log, 0, TPM2_EVENT_LOG_SIZE);
>+		elog->log_size =3D TPM2_EVENT_LOG_SIZE;
>+	}
>=20
>-	return rc;
>+	return tcg2_log_init(dev, elog);
> }
>=20
> int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *e=
log,
>@@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct udevice *de=
v, void **addr, u32 *size)
> 	const __be32 *size_prop;
> 	int asize;
> 	int ssize;
>+	struct ofnode_phandle_args args;
>+	phys_addr_t a;
>+	fdt_size_t s;
>=20
> 	*addr =3D NULL;
> 	*size =3D 0;
>=20
>+	*addr =3D bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
>+	if (*addr && *size)
>+		return 0;
>+	else if (CONFIG_IS_ENABLED(BLOBLIST))
>+		return -ENODEV;
>+

You are querying the CONFIG value=2E Why call function bloblist_get_blob i=
f blobs are not supported? Please, simply skip in this case=2E

Best regards

Heinrich

> 	addr_prop =3D dev_read_prop(dev, "tpm_event_log_addr", &asize);
> 	if (!addr_prop)
> 		addr_prop =3D dev_read_prop(dev, "linux,sml-base", &asize);
>@@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct udevice *de=
v, void **addr, u32 *size)
>=20
> 		*addr =3D map_physmem(a, s, MAP_NOCACHE);
> 		*size =3D (u32)s;
>-	} else {
>-		struct ofnode_phandle_args args;
>-		phys_addr_t a;
>-		fdt_size_t s;
>=20
>-		if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
>-					       0, &args))
>-			return -ENODEV;
>+		return 0;
>+	}
>=20
>-		a =3D ofnode_get_addr_size(args=2Enode, "reg", &s);
>-		if (a =3D=3D FDT_ADDR_T_NONE)
>-			return -ENOMEM;
>+	if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args)=
)
>+		return -ENODEV;
>=20
>-		*addr =3D map_physmem(a, s, MAP_NOCACHE);
>-		*size =3D (u32)s;
>-	}
>+	a =3D ofnode_get_addr_size(args=2Enode, "reg", &s);
>+	if (a =3D=3D FDT_ADDR_T_NONE)
>+		return -ENOMEM;
>+
>+	*addr =3D map_physmem(a, s, MAP_NOCACHE);
>+	*size =3D (u32)s;
>=20
> 	return 0;
> }

