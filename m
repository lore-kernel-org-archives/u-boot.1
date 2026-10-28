Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E229606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EbV16iUw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=doPuEFyM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76EF24051D;
	Wed, 28 Oct 2026 14:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTsZ1UAJAKTY; Wed, 28 Oct 2026 14:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C2EF40568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198754;
	b=ao3NCqzq7EFM1FemEQf3D+7Y7Mmm5TJ4kLJXM9Sc2NvaM8HyPnjzPhX/iEfUPkM5idkN
	 hd4rwH8ZNLCA3Ir9O5K+KcRO+N/uTLYSGADBwI6AC0w2NYJhkdx0l2En7LjG4PR0srBko
	 kDIf0tA8J0kxGGtAcesMzAeMWFqnEvTs7e44m6VUKl4ZKyMx6fAFsIcMGSqNKv0MMLiyR
	 v/CkiKhAEVJJl9Ee6NoQ17NuQ8sOZ1m/qHhiUkenvI8JFVHyrK9xCvjbh71uLcKBl9RDj
	 S92is7GGAbjuFmWmUkm3/9hoXbK1qwZbOiBY8qeHK7r1t6uInDWyUJRpFlJikwul9Bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198754;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
	b=GGYXtPQAPUHrbXvnMIfW6+dH57f75KEIQBsYhAtj/xLDpTPFk1CbtowYC8Z6GPw9Do9N
	 D0j7tB+Q4dJNiP+/7MDM9J4Yq5OvCiSRi7ihXJCYky2Sy2hS/U74seNv6v0zu58ir+u5O
	 atu0Cc8a4mrElagT/hAC412W1CIiUy/VdU5ydCbewZ3Yj8Tw+Ufrecrm3IpqlVogmOMU/
	 lCq4suY5KLNyTuFEewEGA/u4IL+COwFM2OPXWoBp6wBA3iBoK1ISl1GtWScex09UhWqir
	 c+22ZKa71QHL97wtX80NLfv5TsJeHcJM7Pzimc2RJt8lwbm5v2Dw5XzfB6fcoePPcbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198754;
	bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EbV16iUwtckzX3Jlg5Esviv8hCGysa5gl+++tbj7KmFK5WWThLjuscP+ilBqJ+mNc
	 t1J12B/ogNQwHu2AB+JiO5IZbGumJHTGYmQkvFQ8MkrMrH8rId+Pcsxut8hztLYh+1
	 /hiNRjqIraZ+pq8fh/amK5sxNmWYC3s9uaD3x0WBKcyGQCmB4nB6MkbxUIP1jwkoT2
	 cFUqKOJrDqX80l7bEs2RdYsRw1x8Bn2RtVNwtS+tk/V2M55F0zVh9IqlVn1c/Eu2C7
	 Yi+YoWQtWKLceSie/1eUgSeAySy9lpJ8fnc654zUdMpyoP9JZsOrl6+FNK0RXgelnc
	 tr3/KAhoG2Akw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C2EF40568;
	Wed, 28 Oct 2026 14:45:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEBF6356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D506E80BE2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zg_ngIRsO_U5 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B58C580BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196593;
 b=GXk4uIPp8M5qnZLHESGULIWCJdq40WhyZeuNY7BqW2WsslYuwyRacEjFIoS5ZVS0taaB
 DS4us6G/52ztdOUcF1Yydy96D1cfuYNIsWVSwbFC59t0S+R+5+0v1pfyVP6bTRhueT22o
 qe/HCuR2XzPD8NGLx9FcYmtBj+MTnUT2TBCE1lDvXvMyFSbGUTacufTL8nJ2v+DlMZwKp
 qzGvAzBtztYqh6OsxEzeVYGTs2rCzIiqmsKCofS0sUl9EyM0ZkCPJsF/Sodv8dw0Is+PY
 D+JIXFZ+VyDo6e6hw+Bea/GXGQoCpfQyXt+lxS93EQlA1oomV6cmf/5JkfzdvbxN3ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196593;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=KUPcwf9J2HnS8HgyF3mZS+tNMcV+TTpAJlkHXaapv6pRbct7XA4vUBpqz0DGQGebgxvd
 t9kInwcfWMWm+pMhRM2/d8RjIdPqz2WNOYoj0C3KvgtVjoTFx4lv/ry2OZZcQGxuqHImM
 xJCowN5X3MJz5vpgcNYR0fh/v6dHAejZkt8bHat09QUDN9X+24+f5fzi5AmGXYe6SrYIn
 c1xVC9QQ5I0OCc2sbg/zNgUKpk6zCvAQBR1qUC09P1zM+lNjnYqOAjrByi1J+rag7YtCU
 WBlfo1tVXSqNqYi0bgalM/KHzZxjCI+jUkubY7bKIAdDrgmB65sfQjLWZuQzqEy98MA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=doPuEFyM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=doPuEFyM
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B58C580BA6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:50 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11125366b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196588; x=1793801388;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=doPuEFyMtClj7u9TCmS12GGqQOOFkmW6xWxE96b98dU5pATn/s4kfnixMk4CEt+Ebk
 9unNt4l8mQ+0t6FvGTQdYBNFz6XVaecYtK2TdtQQWCgLGFhNjFAy3W9cyDFsjhOHuSbp
 Pv7fheu2vogHT7iRf85KUFcrQkotGXsgZstZU1zLbQD5osEZsLQkEikNvfnmZQKKSNPo
 MWydOJHZGRnf6v3e8EiyWVgEw1k5bftKDtW6InYEQ4bN1UiIQhn5gYE7prpkNyLU/VzF
 PAjXizn+gRd0Wwhj0tlLlLkDyHnux/SWhuWiS523/Kt6aw8wAl7ltflUQEueV1CVVbtO
 phWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196588; x=1793801388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=mg1bIOF0ATBJpj1TRdzklcY50lg0CtIO0JzstLjXmN66UL2SgDFGdGsClq85CvI10U
 Rcqr5UcZ9p0RhOgyIRi0PdNxl1zDAiJymf0GffqTG+bA8M0Eq7sjMJxNt6I1RNZuJCmh
 J93P0+mJRfHwi4ch1V+pYBpVVWzasP9MqSypLVy2bkA0a9lLRLw7665sZDLabYCvmx66
 WQy7RhgEVSxO5LLvrwsYGFJ1GniNfDpn9i7eBpeNxm3HuHq8zWnXoZ2DlhJx99guT5Cu
 DYiSnlz9HwegSRVMBigxiyaqOKM/QburNFLmLWkzuwrvnMt6kXvRph/8qfmmHFi0wud1
 LPmQ==
X-Gm-Message-State: AFq9FYLPQ90YVCKrMHuwLRrgcybmUEDGkwUjzRJrfUQH3Resc+znfrND
 50t/QpqE5zU1VRZs5+LN5Eies3pTEyOm4raMD3eTzWz8rdXaFXSKKpftc1ON7mijt4hoFgoYmO9
 Rq3RB
X-Gm-Gg: AYBFou0tb7LwUVKTPXZiIN1cEKh8SnyIQdHpx4MEt0FA56zXBpoJBmR35KKdz0QG0EV
 IKb+TFkH0fCN4N5x2Mm907NB/M6oJAdUQyWy+6fCr79B39GkzhV7mFaMEswkq2Ow7E7tEpnZLRJ
 3D2yqPb8XT59ktbGYqoT0W8/+hg7E+TN4SkKBiCWDLuvqunQ52h7cPup6Ww1V1DFMJLIDHNf5Y0
 IP7ucnja0DVIyhPRCPiq4GEHPyMZbTrTyVUi0DTDz4i6cmcwT7s7PiMa+IoGyvJ/1BiaLls7XE3
 j31o2/FFteVPj4aVyLA7CEgZPKdS3zfve98w2nEHqlbLcu7jVxBOv7otCZOzaxrFRofgAbEulq7
 rZUaz4vtqoMWrtfhM4wbsMDoY36yNk9OcZrQZwIj8y7INTUukUhseu4pFu1IuVrPwSBZpu3+7qZ
 oC198NFXLTttQDmLWsO7gZgjhyFeUcQNX7sf1chqaHTBt80ZhSCVra9dOjSBH/iUVY5gpBxGK+h
 pSmPcne7KycVkt9Gvb0tBIfocaNhDxDcC+Jz5D2W8JqDFDhSIcAixYAzIEE2BJIkz6r6fQfuKRl
 DDtLKu/oXSZtZulbTfLnbYpW6znlpL79aM29JhmMkPrvsXnkxOlOY/LPAMPSJuQ/Exh3lVgJd+9
 DyOPevRAqJm54PZ275Px71/VVbfuSXHY=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr307574766b.0.1793196588131; 
 Wed, 28 Oct 2026 07:09:48 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:47 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 01/63] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
Date: Wed, 28 Oct 2026 15:08:27 +0100
Message-ID: <20261028140930.3025368-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jerome Forissier <jerome.forissier@linaro.org>

Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
is needed by the updated DWC3 code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/host/xhci-ext-caps.h | 158 +++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
new file mode 100644
index 000000000000..c93bcf4f4f7d
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Imported from Linux v6.16 */
+/*
+ * xHCI host controller driver
+ *
+ * Copyright (C) 2008 Intel Corp.
+ *
+ * Author: Sarah Sharp
+ * Some code borrowed from the Linux EHCI driver.
+ */
+
+/* HC should halt within 16 ms, but use 32 ms as some hosts take longer */
+#define XHCI_MAX_HALT_USEC	(32 * 1000)
+/* HC not running - set to 1 when run/stop bit is cleared. */
+#define XHCI_STS_HALT		(1<<0)
+
+/* HCCPARAMS offset from PCI base address */
+#define XHCI_HCC_PARAMS_OFFSET	0x10
+/* HCCPARAMS contains the first extended capability pointer */
+#define XHCI_HCC_EXT_CAPS(p)	(((p)>>16)&0xffff)
+
+/* Command and Status registers offset from the Operational Registers address */
+#define XHCI_CMD_OFFSET		0x00
+#define XHCI_STS_OFFSET		0x04
+
+#define XHCI_MAX_EXT_CAPS		50
+
+/* Capability Register */
+/* bits 7:0 - how long is the Capabilities register */
+#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
+
+/* Extended capability register fields */
+#define XHCI_EXT_CAPS_ID(p)	(((p)>>0)&0xff)
+#define XHCI_EXT_CAPS_NEXT(p)	(((p)>>8)&0xff)
+#define	XHCI_EXT_CAPS_VAL(p)	((p)>>16)
+/* Extended capability IDs - ID 0 reserved */
+#define XHCI_EXT_CAPS_LEGACY	1
+#define XHCI_EXT_CAPS_PROTOCOL	2
+#define XHCI_EXT_CAPS_PM	3
+#define XHCI_EXT_CAPS_VIRT	4
+#define XHCI_EXT_CAPS_ROUTE	5
+/* IDs 6-9 reserved */
+#define XHCI_EXT_CAPS_DEBUG	10
+/* Vendor caps */
+#define XHCI_EXT_CAPS_VENDOR_INTEL	192
+#define XHCI_EXT_CAPS_INTEL_SPR_SHADOW	206
+/* USB Legacy Support Capability - section 7.1.1 */
+#define XHCI_HC_BIOS_OWNED	(1 << 16)
+#define XHCI_HC_OS_OWNED	(1 << 24)
+
+/* USB Legacy Support Capability - section 7.1.1 */
+/* Add this offset, plus the value of xECP in HCCPARAMS to the base address */
+#define XHCI_LEGACY_SUPPORT_OFFSET	(0x00)
+
+/* USB Legacy Support Control and Status Register  - section 7.1.2 */
+/* Add this offset, plus the value of xECP in HCCPARAMS to the base address */
+#define XHCI_LEGACY_CONTROL_OFFSET	(0x04)
+/* bits 1:3, 5:12, and 17:19 need to be preserved; bits 21:28 should be zero */
+#define	XHCI_LEGACY_DISABLE_SMI		((0x7 << 1) + (0xff << 5) + (0x7 << 17))
+#define XHCI_LEGACY_SMI_EVENTS		(0x7 << 29)
+
+/* USB 2.0 xHCI 0.96 L1C capability - section 7.2.2.1.3.2 */
+#define XHCI_L1C               (1 << 16)
+
+/* USB 2.0 xHCI 1.0 hardware LMP capability - section 7.2.2.1.3.2 */
+#define XHCI_HLC               (1 << 19)
+#define XHCI_BLC               (1 << 20)
+
+/* Intel SPR shadow capability */
+#define XHCI_INTEL_SPR_ESS_PORT_OFFSET  0x8ac4	/* SuperSpeed port control */
+#define XHCI_INTEL_SPR_TUNEN	BIT(4)		/* Tunnel mode enabled */
+
+/* command register values to disable interrupts and halt the HC */
+/* start/stop HC execution - do not write unless HC is halted*/
+#define XHCI_CMD_RUN		(1 << 0)
+/* Event Interrupt Enable - get irq when EINT bit is set in USBSTS register */
+#define XHCI_CMD_EIE		(1 << 2)
+/* Host System Error Interrupt Enable - get irq when HSEIE bit set in USBSTS */
+#define XHCI_CMD_HSEIE		(1 << 3)
+/* Enable Wrap Event - '1' means xHC generates an event when MFINDEX wraps. */
+#define XHCI_CMD_EWE		(1 << 10)
+
+#define XHCI_IRQS		(XHCI_CMD_EIE | XHCI_CMD_HSEIE | XHCI_CMD_EWE)
+
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define XHCI_STS_CNR		(1 << 11)
+
+/**
+ * struct xhci_protocol_caps
+ * @revision:		major revision, minor revision, capability ID,
+ *			and next capability pointer.
+ * @name_string:	Four ASCII characters to say which spec this xHC
+ *			follows, typically "USB ".
+ * @port_info:		Port offset, count, and protocol-defined information.
+ */
+struct xhci_protocol_caps {
+	u32	revision;
+	u32	name_string;
+	u32	port_info;
+};
+
+#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
+#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
+#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
+#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
+#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
+
+#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
+#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
+#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
+#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
+#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
+#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
+
+#include <linux/io.h>
+
+/**
+ * Find the offset of the extended capabilities with capability ID id.
+ *
+ * @base	PCI MMIO registers base address.
+ * @start	address at which to start looking, (0 or HCC_PARAMS to start at
+ *		beginning of list)
+ * @id		Extended capability ID to search for, or 0 for the next
+ *		capability
+ *
+ * Returns the offset of the next matching extended capability structure.
+ * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
+ * and this provides a way to find them all.
+ */
+
+static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
+{
+	u32 val;
+	u32 next;
+	u32 offset;
+
+	offset = start;
+	if (!start || start == XHCI_HCC_PARAMS_OFFSET) {
+		val = readl(base + XHCI_HCC_PARAMS_OFFSET);
+		if (val == ~0)
+			return 0;
+		offset = XHCI_HCC_EXT_CAPS(val) << 2;
+		if (!offset)
+			return 0;
+	}
+	do {
+		val = readl(base + offset);
+		if (val == ~0)
+			return 0;
+		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
+			return offset;
+
+		next = XHCI_EXT_CAPS_NEXT(val);
+		offset += next << 2;
+	} while (next);
+
+	return 0;
+}
-- 
2.53.0

