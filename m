Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F5606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=efUpGjKl;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=U+M4GF2N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9A6D80F74;
	Wed,  4 Nov 2026 08:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNy4kfhB8wJf; Wed,  4 Nov 2026 08:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A194B80E16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782309;
	b=Kg6wX6eUvv2lGXBlUwTnPPWlgFYhICae8gpnN4+P9ePLo6Iz8T8MPms7Hj38BNVKYtRH
	 qlfWqEmYoVyAXik/hGZH9mqNrDOfF0d/spd8tlugLB1NpyPB+5Wepq+QThuhHTmEST26S
	 U1vZl10Ct2LGDBrCGiopzpuP9KM4rIZpZZsaa9QtE7lhgDwxYW6ajVj0j3tT4lr2HzmE1
	 WtbBNsw7s2Xt/JlPhHaR6fKL+gG/WKXFzklQuwwedWfNI+rT2QO/PzuWn2kwcSGFSdJni
	 qve0B96htpv1k86YG95JveNVwzR6OqqK9w8cBWq/Drqp5qUcJ4x/r3Pqtg7GQApKySg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YSUHCIDcmZzEeXSprcIzOzkXpsWfub2fItkHzGBqiCw=;
	b=gMC70SSx8fFSXh2BlOZctcqAF8Ub+4iZjUfruKy7umSzGtP0gr/CLvghUbKnM5DJwDuD
	 XsMOJNtTOmnphYNMe3t7ihzouXJTePs9aSJP4i+aw7CdtAvEptlMUPjWWZHhEyTUmdmgm
	 nrzoabKz5yTnaF6ACYhuyUzkt97OmaEzXEi5gF0R5ai/AgnE8ix926dK7UNoInp+O26+z
	 2e94s/2kIaU3GfpJWxn6qJoLvJ9vhpMVAQ5tHW0f6mLeq/la/wfK+CquPT3JPDrGAd84p
	 o8DM8J2Rs6I75OAhXjeIX94JgwTHjU+I2xUpIqehVKD/aw5/b5rrdp7/3KLpMqzes3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=U+M4GF2N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782309;
	bh=YSUHCIDcmZzEeXSprcIzOzkXpsWfub2fItkHzGBqiCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efUpGjKlnjIxOlCIU/u3foyGCXE0vtdKs2BIJiVhkIVgDuHEmjQKcsUOv6RYxpF0I
	 hyOtvhn+/sBHG3L1p/AyGKaELjnatKPvLBqmJHGNvttCRulElvc4Qs9UBvdzvIjzsP
	 z2VDSp0UlvA2mzQ0RbHSQT22MCsHN+jjBr5PUPqRScDS5biCegmlx4w9gxP9dTzEh/
	 dz5XHHjTNZgg1QbiJQu5byQRIXnr+Mx+sMIAGflFajxRXm91tyPhRMhxGugjjJvcmo
	 w1QLgWD6S+6c0R76MjBcePl1kZyhiiyKfiGxU45vvKrqeHHYN02VH/CQDb8IePUsaz
	 Xh6DK9qtPps1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A194B80E16;
	Wed,  4 Nov 2026 08:51:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BDDC235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 626E180FDD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUXg0EX823ok for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4639480E49
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782307;
 b=aenrCiKe7cC3YXmoAI7dINpn49Pjy2AHJdg61WbO1q1CEzj0+Agex2F+IHJI1e6H3flB
 48LOC48EkHrWmltVC7eNt1Ksvc5px5UeSQBYKPlLDfmrnqsLP/cV3gjPSWi+mK7m6cAEa
 7N2XQznmxH0jXFFEuDK43Lb+XBpCfeYMKmC63foktDVs2PKOocPaioFToqIdFkGH1dyGW
 LQQw2ZD+hSdNkDq/fr6k8oh3qaNtYr6lLeEkTwubgsb39zAc8k9/33HsIPkPFs6umzWD+
 m+UUhoDcH+W4QEbP9W8g/XToyG073qs7FEFxvCZfK70DpMK2SSl4xgqJIPX7UqzD6mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782307;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=YSUHCIDcmZzEeXSprcIzOzkXpsWfub2fItkHzGBqiCw=;
 b=bLFBD6Qr/hM71HRsWOQb2jnATTFZ+Z1tM7OplVgK0YfN6GlRbPNmQV0v5wuE8mlanLvZ
 tfYBSahDjfcWAdnpu4z7QdfdoczEip8EryHljSpokkgjQKOxvO8WI0S9dYLDPQTmRrg9c
 PvbUgE4/H2u8XDl1vQQn1P9vIJ3GjB3E4MKK2MnzU9E+CxNYEAHq56gGBFR4aFsPUlvGr
 z1KYXJjQdVALePq2BHdEfg++N9gsZ2S1TfueqSYfuubn8LTm2P/yAc8Dk29zB6U6xrXYY
 3kzWgHhmDu/Bq0SQnh/k50Hl3nDcVod4tWgDIKx3ZM0PSSpY7Q4n45Pcp8lyqr+u2Pg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=U+M4GF2N; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=U+M4GF2N
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4639480E49
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:45 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3376265e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782304; x=1794387104;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSUHCIDcmZzEeXSprcIzOzkXpsWfub2fItkHzGBqiCw=;
 b=U+M4GF2N9fhczDYd4mXviXmF7jrNMDgK7Mr2I20HoBmOiwx+8vpf+EhT1NyyZ1DNZH
 ULAavJWcf3Wel9A9Jy+jYEMxwsi6EoksWDGq1rIYIsYuzG1lf6elxMqr212ENnPIPIoc
 EhQo9ZcgVzIXzztApTHBK0WQn6OTlywqXzWHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782304; x=1794387104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSUHCIDcmZzEeXSprcIzOzkXpsWfub2fItkHzGBqiCw=;
 b=NTg8ciSptZq+G0VkuZvxEMg/vmH1QSDnGko4dVq1WxYmIHREx3LCRP+1y6sjvAgKCz
 A2mra+Vkgo2JIcTCbE7cy48tZW8oYVMFabZxx575sXSZ47AShDZjEIaXDYDVvz9KraTG
 JhcdDpK/2G2LbYLIHzFPSvFFCZEzhFh0D1k5MqhYWzM1gNfXvzkZBXSNuMDwKpyc1OgF
 GTcNdKTVIwbBCjZK5Kcuh4+LPsUWx8t1KdsLMJvPhb0QfNoeTJSRE01f7YkQbuMx4yyr
 6Vnm7lrKTSVpURl4q+UIrCNHKwYlYDTvWSkTp1qlkG17FJbbPv3gCCFvQ9CR7X+Nq2sP
 M/ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKRX9t4dE3vD7ffgqCm6NlieDshr4R937bWUhnajYYjxrUrJyR8p573zwztbDbAjKXXpyKUfI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+atFJkCMhI8Qb2SmgedMOYFP6hQ7MzscA7zhmpwv6hfjqNFyw1
 huzXajkKtdko+cRg0rSFpEbZvrTtVwCYhIhD3XhCadJusI/z9y7mdIvWNLeXtR1xkEg=
X-Gm-Gg: AYBFou01fT8+MO+5bcvnrIcXSePCvk+Q8mWzXEtklDUfcZe4sg+KPtcDOfgGQwAsBwH
 cbI2DIJne9cGQKukFq9B4fzIm79s76xzEd4MfrBtr7GmuLODHhMV6oRs0nr+0J43ugZKWkTne8F
 SeMzGU6BS4NRl8iVJrLqVgZq63suSogwwzaKlrkrkHHdIKrDqMlu7r/+D4A5N2smOebMdUdGyap
 wQHjMQQ2AzYDX+0BPyGPY6lAmHub4WHP8OPY8SzKQSJOa8ImO5gkhljUxDXk4g3k89li8zc8zrI
 xzO7cFKbX83rH1VAFN8ScOo+g1bK348jKqWWvKB8mYycYOTIY5WNSQwl7tV2j0skoAMBPUkwq3Q
 dciIvB1PIYjqeXwvxfprFwhp3pzhA61s5jQBNfgJzS91Yx7abdrHyktC+rctewlmddk4J6j2FW6
 a9LoMWM3tKxkc05WoLwSl2hcCP12nLHFs4d4sN5HufHhHIqGH37jaiLYmw+bPhoOFr1A3c0Eith
 y5A9Na5NrVun0brTKRDvog46D2yAhBpvXqwEHZQnQMMJnqjdfWneAPU1zlIKN7qEI3anOqhtol7
 YTzkCXzJB/oSRg7XtxRfaHsTXGNpDd7TZUT3vmXIMXIksWOnEMts6AMyLAYcmMVLLvhS6/lMDqz
 6F26WCIBapSsPQuhv3uvDnnUh/N3f
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr369587335e9.13.1793782303928; 
 Wed, 04 Nov 2026 00:51:43 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:43 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 17/33] arm64: dts: st: add Engicam MicroGEA-STM32MP257D-RMM
 LVDS display overlay
Date: Wed,  4 Nov 2026 09:49:50 +0100
Message-ID: <20261104085036.4012238-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an overlay for the variant fitted with the AM-1280800W8TZQW-T00H
10.1" 1280x800 LVDS panel. Its touchscreen is connected over USB, so
there is no touchscreen node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260923155333.610134-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 29ee49c0f82fffb8b0eed14b4ef3ff19ab89f455 ]

(cherry picked from commit 535f863022c1f9491a2d224023f5a6e3419ebc6f)
---

 ...gea-rmm-overlay-am-1280800w8tzqw-t00h.dtso | 67 +++++++++++++++++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
new file mode 100644
index 000000000000..7655c1bf56b1
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ *
+ * Ampire AM-1280800W8TZQW-T00H 10.1" 1280x800 LVDS panel. Its touchscreen
+ * controller is connected over USB.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/st,stm32mp25-rcc.h>
+
+&{/} {
+	panel-lvds {
+		compatible = "ampire,am-1280800w8tzqw-t00h";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds_out>;
+			};
+		};
+	};
+};
+
+&framebuffer {
+	clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>,
+		 <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
+};
+
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_out: endpoint {
+			remote-endpoint = <&lvds_in>;
+		};
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			lvds_in: endpoint {
+				remote-endpoint = <&ltdc_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lvds_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
index faedddc2c914..96b7cb6b5bc1 100644
--- a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -43,7 +43,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		framebuffer {
+		framebuffer: framebuffer {
 			compatible = "simple-framebuffer";
 			clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>;
 			lcd-supply = <&reg_3v3>;
-- 
2.43.0

