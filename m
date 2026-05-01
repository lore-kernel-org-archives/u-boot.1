Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01CDCD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C9484255;
	Fri,  1 May 2026 03:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="aOTfToTm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTyqYt4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4AF84198; Fri,  1 May 2026 03:36:17 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0405839D5
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2B87F1400159;
 Thu, 30 Apr 2026 21:36:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 21:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599374; x=1777685774; bh=uJgmXWrdKWpG8LTIPLqqQvsymZd4kayG
 Rjbs5KSqJIU=; b=aOTfToTmbMQYqWLvlgtIedTv5bbEgLVMsTeyvOgYEYRenrcR
 AYZuCCVNo7OeY4jEANbngemmhW7SmHNlPhI1Go9wuBRti1Dn3f2f42fQTDZsOhQl
 +i85zcZiHM0paWmveW/eY4HJcqs2r9VoTUgm6U3EBkAHzBRc7aYFvoPb17lTVR7k
 oo4Djk8gt9hDcb5FjSwFMlVnHqRavX9rmxByR8HxKi6pOqJblXP5i9D9OoBdQGih
 vonzLOdkb3OvGxYq+UmWI9hUY0WQyqDIPvehrSQW0l8oD937+HQtJWlyasdWXHDX
 2SOC8irxwYpxe81enFw2VoiXlpX/hT1iJ3GNSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599374; x=
 1777685774; bh=uJgmXWrdKWpG8LTIPLqqQvsymZd4kayGRjbs5KSqJIU=; b=h
 TyqYt4rHrLDTbfESI48amItRPGovDeK/HiRdyC4u/39epq0t1lKUcWG3h90mdCEV
 ow8NPJqaJIiZCsVDO5GTKPKHv8vslox0lEGaBor8Qw3FfShc58mECTeUAavG95Li
 JeUMXvLDxLV8y52kvVNLD31ngibL0DVDPC2ubUii0C8sA5bMH4pNwb8PtKl/ZP4j
 Vpm9LfBYrgMI41b0Pi/xO/VO39esP66CQ7ykbpbkw7T8Lnd95RpqSWD2hjKnSnZZ
 OM/PsiCA6osGn3qYnGlz8O+o3T1pfsrsHlfxGrgxd7uLzORKM1OLKvDzjsBFgCqN
 MrgnXhurL/bqO/MwL55Hg==
X-ME-Sender: <xms:jQP0aU_Ia6i6v6bozJrSKqJSlMiEovcHlEyFIdxqousvEfXQ6PpC8w>
 <xme:jQP0afxEJOcIrnDKZ5Y17NsnU02vXBCjAc6X9z2m8ufXE4BXZqoG3stZacDXLlWmz
 G0Ivjy1htmTMoKmIk98xBySJZdbwxvw-FyStiyClT8RfDAQtrAoPT3E>
X-ME-Received: <xmr:jQP0aUqf2XwlGqjn7Cbw2JaFv_jqw64SJDL--JVpSCg055C85W_TcwMLdPCuLMBYXr18evGMSd43_Qf_UPTPFObTkfpk8z9-71nrNKLHNG24uNSNnZR8SmGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeeujeffheejgeegudegiefggfegtddugfeitdeuueffudejteejheek
 ieeuteeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdr
 tghomhdrrghupdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghupdhrtghpthhtoheplhhu
 khgrshiirdgtiigvtghhohifshhkihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtth
 hopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhi
 shhtshdruggvnhigrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmug
 drtghomhdprhgtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhg
 pdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrihesrghmugdrtghomhdprhgtph
 htthhopehpvghnghdrfhgrnhesnhigphdrtghomhdprhgtphhtthhopehquhgvnhhtihhn
 rdhstghhuhhliiestghhvghrrhihrdguvg
X-ME-Proxy: <xmx:jQP0aQrG_4r1Lg64CCBIP15WNZNal7nxDY8TfaIrXG7qMDgSnuZn-g>
 <xmx:jQP0aUC3zMs5a4EajMKZ4rnPUmoMRWX9rygYKIH-0JVTp1sYY0DUHQ>
 <xmx:jQP0aeuWP-TfBlyEfi8vXK_rmQ-PakhgFUnnK0DbRRBtkBE9lLli6w>
 <xmx:jQP0aTImycTX122sXuubfRuf9xBsogss41PkZGubfYLe1_LiBkNKdg>
 <xmx:jgP0aWh0y6mm6wnaWYhcDLm-aPDqZTxKQSr-8oPt2T6nrCHIWUzzessy>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:10 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:02 +1000
Subject: [PATCH v3 1/8] arm: gpio: include integer type definitions for gpio.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-1-234c5b2f8c6f@traverse.com.au>
References: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
In-Reply-To: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=1476;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=fRF09GWj7CgE6ch9WIhaqpq2ZKyD0FZVPLrbS0Z/ynE=;
 b=Uhg1AvPiZgRvp2au3SpiC0KATBQEeWkAL13OY6Io3YUrxYxUEnq932+8BdzWUROUD6UojiJeG
 zG3yOZy8CcRA04jhDgjGMNgKY14sfs958s3sRcYoZFB0ZjOpJmKT31F
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

Both consumers and sub-arch specific versions of gpio.h
may reference stdint or other non-C90 type definitions.

Ensure the common ones are available by including linux/types.h
before any other headers.

This issue came to light when the usb onboard hub driver
was enabled for ten64_tfa_defconfig:

In file included from ./arch/arm/include/asm/gpio.h:2,
		 from common/usb_onboard_hub.c:10:
./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
   17 |         ulong addr;
./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
   18 |         ulong size;
./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
   19 |         uint ngpios;

(In this instance, the cited errors actually originate from
arch/arm/include/asm/arch-fsl-layerscape/gpio.h, which is included
by the arm top level asm/gpio.h)

Implemented as per suggestion from Quentin Schulz in Link:

Signed-off-by: Mathew McBride <matt@traverse.com.au>
Link: https://lore.kernel.org/u-boot/35038a9a-fa5a-4f9f-b34e-17cc80a7824c@cherry.de/
---
 arch/arm/include/asm/gpio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 650783ae732..eba7bae9351 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -1,3 +1,5 @@
+#include <linux/types.h>
+
 #ifdef CONFIG_GPIO_EXTRA_HEADER
 #include <asm/arch/gpio.h>
 #endif

-- 
2.52.0

