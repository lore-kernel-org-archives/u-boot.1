Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8677DCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 23:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E4AD40537;
	Mon, 28 Sep 2026 23:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4L8cn6tFxsM; Mon, 28 Sep 2026 23:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F27040531
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790638504;
	b=MPDanK6RP904qGpmxZ1ukWbAe/TwmpmvegMrP2EB6TDmrwEG1P8Rz7A+AjE6hgWIjnAU
	 uIb6hcixQPVKtF5yH1JZBLBr/9a6kYS/MexiogDQwYyincXEmDP60o2bSp7vihPUxj/n6
	 GhqgBx1c+SIqm9cim1WCqxD3bkELULbAzu0QKUXVr1SsjB5XN4Tw4RQGck5q5nFi4kixM
	 itt6dkBn49SSS5/5PO0fYIBuA/carD5z/9UWZPN7mpHrrhjKs+QtGPtjfigtCkNRSj1w0
	 JwA959z6A/2YPXq8yVr09fF3xpyRBSFZULa4cNwUG7OCetxfbFsB8EuyjHeA7p2GtIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790638504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cbgMG2K+3EvGjiLqv/6rruO8wL43DohP2PAUAe+5/s0=;
	b=cGlzmTssMVH91rTx6yKEB2nAjdgrZXBM1PFvQeziOLHm6tmALvagMftV7Kmp85CT+PPI
	 Ebzws/scEbTp0mYR1EL8EM3q9G512wEUR4MBFWwSqwI4hana3ruMNlBfAwbt6j97jBI7L
	 8P6F/I5UNA/mXNhudrGsDL2lZvc1ENguwsBu+yYCqAjYBSpIRUA+7T/vZa3POLwFA28m8
	 WeZqKxfMP+US6rF+R3l1XNJHoBrEnBZwLx+oJZhs/t6MSiO/bvWiy6FP10mklvBoQ9z7G
	 73rpTnYk/0l4eGilbc4/k9/JfxAnY0vu3NII2rrHZpuF/TWqLf3a45K05r/1vK1sDGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790638504;
	bh=cbgMG2K+3EvGjiLqv/6rruO8wL43DohP2PAUAe+5/s0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j6UsLYbi0P/m0+toBpM275BTcTaNGfeqXsauqmzaDtexcnzMSLQwwpXxLWmt4Odlv
	 hCHJpdaST0Zerg+OJiJlM3sw3Js7W3dwiZT2NpJXKtNqbeKkPcf8Q93g/D9ZoxC2uL
	 Ks4I4rmrRvexNYHFSqoZWFKCbxZWagEmroIBrZdxeIGNDFsUKtLBwGm5qGRS7ctBO4
	 sqIbE827Hx2d8aq0pDd7EuWRFxshbcMqacv4jy930AkC+ZbPbp+WnNgMSjIxjYFMwK
	 cON3PP1M3pQMhsbiiCGVw8kU+bj6XDNpSSsTcCWPNGacz1Cv50peaLYZGG8f2UIe37
	 0Do7lm6HZiLWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F27040531;
	Mon, 28 Sep 2026 23:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D72335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1927560638
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qw9J4iM6h1uH for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 23:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C51B60632
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790638502;
 b=tGu0Phz6N4AwvL1TuRIGwTsIuI9lxiDJaq/1NJnvSbZ29C3B10LBts0afWlMU8h4BRJ1
 mmZf/sBKmodM9GFl/rZC7Nddl8MRcThBAPxy6OwAZP1zsJsQc5uZ7kYT84Km7EYUmUiM1
 mC+MTxYnyKt0Q1CNodQ2f+2m2RDKm86lUQ+9feBiuHO2t4l1tL9HxIkd5G/DV8n5aOQoJ
 PX36TiKkAufJZ7ZY2b0+ktrvpRXFsmY9RuhD6IGmMbASpx5vwBiQ472c4JjgO9K9JTq8t
 BrcDIis9bkKCYhQKJ4FA3cALgi2x3VZbAeoji7oj4To2axDRcBYvPFD/e01HYY7q+VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790638502;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=cbgMG2K+3EvGjiLqv/6rruO8wL43DohP2PAUAe+5/s0=;
 b=OJNPwRjV9CgBGvkD8e0xy/cHbm7t+JciOKNfYFoAMt4uHqD4bkqlQYiTbBgWzNVVWs4w
 cfBMJS7tLXMLRNRX5Am0ZeNNsB1Ia1QyhIbgepBq0tJwNGKXKyAsd4btunhK8D3f99Q30
 zmxnezsF9sGdzFmxDedbqgJpdQ+OrYJtCUc/OcPTaEHwHRzqaK9Wiz57a5slRU1QEvI+6
 jMoppytXDujDzQv1dhZ68djtGsLqaOCkESa0EWcwTnjAaquHTC25QRm5yL43L31roA4RW
 pAHXkI+cSoogvw9LbGG+y18pOeeesNJpiEtJ8OCjnnVfqnMoP8v8AyiIzHS9Soc8uAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="h7Vo38/E"; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=h7Vo38/E
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C51B60632
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790638496; x=1791243296; i=xypron.glpk@gmx.de;
 bh=cbgMG2K+3EvGjiLqv/6rruO8wL43DohP2PAUAe+5/s0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=h7Vo38/EwvBKaT9mjs9YR00wR92Mct6Q3YEUQ3HaJ3TfYimwQdLtub/k0H/ukwUr
 w4w85z9SgUZyXhzOWDKQ38dF6FZx/JblVQ3iuF+uNaSnSKp+gL9F5aa4lboD+Lb6B
 Y/WeD5w+fQQfcT+E2t+foEThCIXZEvI/rb0vpmBv/Uoie7Xnz/+UMCj2BtIMz1MxK
 6y+geMKiLuNY0kC7Yd9qZCO+NLsl26Ij9pPjVMsj0LzOojjRyH+4QjU1e9CKyg33S
 87/tPyUNoDR+V6AQG33vBA861fKkKqWUXV/gP+UuqaR8Hesm0J4nOtVAOQ6vJr+5t
 BWYrJ6Mh34Jx/wJJZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1wOCXa1Roo-00pOld; Tue, 29
 Sep 2026 01:34:56 +0200
Date: Tue, 29 Sep 2026 01:34:51 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>, u-boot@lists.u-boot-project.org, 
 trini@konsulko.com
CC: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, sughosh.ganu@arm.com
Subject: Re: [PATCH RESEND 1/2] rng: airoha: add support for the Airoha TRNG
User-Agent: Thunderbird for Android
In-Reply-To: <20260928224338.505923-1-sochnev.v.74@gmail.com>
References: <20260928224338.505923-1-sochnev.v.74@gmail.com>
Message-ID: <9B3A9CC6-F1F7-4FC4-9F0F-599CDD709D36@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v25siyDN28UQIki0sLO94+VTAu3T4S/d2XMhXIqIDvzJlMAqBqn
 zjZvTjBnT8Ak3t3Af1jHLjTLEvp4Vb9QG4i+u+Qpyk9+U6BHGr87pt6dMiyS4NIsZ7yJH/4
 2mE3C1x5LGZt2Fx4LktkiKAiwZEiliY+l/IX8qH5kXasFMiFMXQ9SaC7omZMJgWUgQDc6hc
 ZLk4vKHyGM1nAs3MYrMZg==
UI-OutboundReport: notjunk:1;M01:P0:+eB+M1kHfzU=;X2nGb8UqOB9JlAoFHaqL2PLPviJ
 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
 rJX2Mrhsv0YkLZdTA==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Am 29=2E September 2026 00:43:37 MESZ schrieb Vitaliy Sochnev <sochnev=2Ev=
=2E74@gmail=2Ecom>:
>Port the Linux driver for the True Random Number Generator found on
>Airoha EN7581/AN7581 SoCs to the U-Boot driver model=2E
>
>The Linux driver waits for an interrupt to learn that the startup
>health test finished=2E U-Boot has no interrupts, so the TRNG interrupt
>is kept masked and RST_STARTUP_TEST_DONE is polled instead=2E
>
>U-Boot can then provide /chosen/kaslr-seed, which KASLR requires=2E
>
>Signed-off-by: Vitaliy Sochnev <sochnev=2Ev=2E74@gmail=2Ecom>
>---
>
>Notes:
>    The first posting on 2026-09-20 was held by list moderation (non-memb=
er
>    post) and never reached the list=2E Resent to the current list addres=
s=2E
>
> drivers/rng/Kconfig      |   7 ++
> drivers/rng/Makefile     |   1 +
> drivers/rng/airoha-rng=2Ec | 136 +++++++++++++++++++++++++++++++++++++++
> 3 files changed, 144 insertions(+)
> create mode 100644 drivers/rng/airoha-rng=2Ec
>
>diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
>index bacb02630=2E=2E3f829fccf 100644
>--- a/drivers/rng/Kconfig
>+++ b/drivers/rng/Kconfig
>@@ -140,4 +140,11 @@ config RNG_EXYNOS
> 	  case the LDFW (Loadable Firmware) has to be loaded first, as it
> 	  actually implements TRNG SMC calls=2E
>=20
>+config RNG_AIROHA
>+	bool "Airoha True Random Number Generator support"
>+	depends on DM_RNG && ARCH_AIROHA

This DM_RNG duplicates the if condition=2E Please, remove the redundant co=
nstraint=2E

The entries once were alphabetically sorted=2E

>+	help
>+	  Enable support for the True Random Number Generator (TRNG) found
>+	  on Airoha EN7581/AN7581 SoCs=2E
>+
> endif
>diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
>index 50622d470=2E=2Ec005231b6 100644
>--- a/drivers/rng/Makefile
>+++ b/drivers/rng/Makefile
>@@ -20,3 +20,4 @@ obj-$(CONFIG_TPM_RNG) +=3D tpm_rng=2Eo
> obj-$(CONFIG_RNG_JH7110) +=3D jh7110_rng=2Eo
> obj-$(CONFIG_RNG_TURRIS_RWTM) +=3D turris_rwtm_rng=2Eo
> obj-$(CONFIG_RNG_EXYNOS) +=3D exynos-trng=2Eo
>+obj-$(CONFIG_RNG_AIROHA) +=3D airoha-rng=2Eo

Same here=2E

Best regards

Heinrich

>diff --git a/drivers/rng/airoha-rng=2Ec b/drivers/rng/airoha-rng=2Ec
>new file mode 100644
>index 000000000=2E=2Ea94161ad2
>--- /dev/null
>+++ b/drivers/rng/airoha-rng=2Ec
>@@ -0,0 +1,136 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+/*
>+ * Airoha True Random Number Generator driver
>+ *
>+ * Ported from the Linux driver drivers/char/hw_random/airoha-trng=2Ec
>+ *
>+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail=2Ecom>
>+ */
>+
>+#include <dm=2Eh>
>+#include <rng=2Eh>
>+#include <dm/device_compat=2Eh>
>+#include <asm/io=2Eh>
>+#include <linux/bitfield=2Eh>
>+#include <linux/bitops=2Eh>
>+#include <linux/iopoll=2Eh>
>+#include <linux/string=2Eh>
>+
>+#define TRNG_IP_RDY			0x800
>+#define   CNT_TRANS			GENMASK(15, 8)
>+#define   SAMPLE_RDY			BIT(0)
>+#define TRNG_NS_SEK_AND_DAT_EN		0x804
>+#define   RNG_EN			BIT(31)
>+#define   RAW_DATA_EN			BIT(16)
>+#define TRNG_HEALTH_TEST_SW_RST		0x808
>+#define   SW_RST			BIT(0) /* Active High */
>+#define TRNG_INTR_EN			0x818
>+#define   INTR_MASK			BIT(16)
>+#define   RST_STARTUP_INITR_EN		BIT(0)
>+#define TRNG_HEALTH_TEST_STATUS		0x824
>+#define   RST_STARTUP_TEST_DONE		BIT(18)
>+#define   RST_STARTUP_AP_TEST_FAIL	BIT(17)
>+#define   RST_STARTUP_RC_TEST_FAIL	BIT(16)
>+#define   RAW_DATA_VALID		BIT(7)
>+#define TRNG_RAW_DATA_OUT		0x828
>+
>+#define TRNG_CNT_TRANS_VALID		0x80
>+#define TRNG_TIMEOUT_US			100000
>+
>+struct airoha_trng {
>+	void __iomem *base;
>+};
>+
>+static int airoha_trng_read(struct udevice *dev, void *data, size_t len)
>+{
>+	struct airoha_trng *trng =3D dev_get_priv(dev);
>+	u8 *buf =3D data;
>+
>+	while (len) {
>+		size_t step =3D min(len, sizeof(u32));
>+		u32 status, val;
>+		int ret;
>+
>+		ret =3D readl_poll_timeout(trng->base + TRNG_HEALTH_TEST_STATUS,
>+					 status, status & RAW_DATA_VALID,
>+					 TRNG_TIMEOUT_US);
>+		if (ret) {
>+			dev_err(dev, "Timeout waiting for TRNG RAW Data valid\n");
>+			return ret;
>+		}
>+
>+		val =3D readl(trng->base + TRNG_RAW_DATA_OUT);
>+		memcpy(buf, &val, step);
>+
>+		buf +=3D step;
>+		len -=3D step;
>+	}
>+
>+	return 0;
>+}
>+
>+static int airoha_trng_probe(struct udevice *dev)
>+{
>+	struct airoha_trng *trng =3D dev_get_priv(dev);
>+	u32 val;
>+	int ret;
>+
>+	trng->base =3D dev_read_addr_ptr(dev);
>+	if (!trng->base)
>+		return -EINVAL;
>+
>+	/* No interrupts in U-Boot: keep the TRNG one masked and poll instead *=
/
>+	val =3D readl(trng->base + TRNG_INTR_EN);
>+	val |=3D INTR_MASK | RST_STARTUP_INITR_EN;
>+	writel(val, trng->base + TRNG_INTR_EN);
>+
>+	val =3D readl(trng->base + TRNG_NS_SEK_AND_DAT_EN);
>+	val |=3D RAW_DATA_EN | RNG_EN;
>+	writel(val, trng->base + TRNG_NS_SEK_AND_DAT_EN);
>+
>+	/* Health Test runs only on the transition out of SW Reset */
>+	writel(SW_RST, trng->base + TRNG_HEALTH_TEST_SW_RST);
>+	writel(0, trng->base + TRNG_HEALTH_TEST_SW_RST);
>+
>+	ret =3D readl_poll_timeout(trng->base + TRNG_HEALTH_TEST_STATUS, val,
>+				 val & RST_STARTUP_TEST_DONE, TRNG_TIMEOUT_US);
>+	if (ret) {
>+		dev_err(dev, "Timeout waiting for Health Check\n");
>+		return ret;
>+	}
>+
>+	if (val & (RST_STARTUP_AP_TEST_FAIL | RST_STARTUP_RC_TEST_FAIL)) {
>+		dev_err(dev, "Health Check fail: %s test fail\n",
>+			val & RST_STARTUP_AP_TEST_FAIL ? "AP" : "RC");
>+		return -EIO;
>+	}
>+
>+	ret =3D readl_poll_timeout(trng->base + TRNG_IP_RDY, val,
>+				 val & SAMPLE_RDY &&
>+				 FIELD_GET(CNT_TRANS, val) =3D=3D TRNG_CNT_TRANS_VALID,
>+				 TRNG_TIMEOUT_US);
>+	if (ret) {
>+		dev_err(dev, "Timeout waiting for IP ready\n");
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct dm_rng_ops airoha_trng_ops =3D {
>+	=2Eread =3D airoha_trng_read,
>+};
>+
>+static const struct udevice_id airoha_trng_match[] =3D {
>+	{ =2Ecompatible =3D "airoha,en7581-trng" },
>+	{ }
>+};
>+
>+U_BOOT_DRIVER(airoha_trng) =3D {
>+	=2Ename =3D "airoha-trng",
>+	=2Eid =3D UCLASS_RNG,
>+	=2Eof_match =3D airoha_trng_match,
>+	=2Eops =3D &airoha_trng_ops,
>+	=2Eprobe =3D airoha_trng_probe,
>+	=2Epriv_auto =3D sizeof(struct airoha_trng),
>+};
>
>base-commit: f61f50a79dab97c8a4109ee9c15b90bf6157d4e8

