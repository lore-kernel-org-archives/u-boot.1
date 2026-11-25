Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A315606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QYQyR+OR;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KCUrPrxh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2300D6089D;
	Wed, 25 Nov 2026 11:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMBThZB44b88; Wed, 25 Nov 2026 11:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 616D360706
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606256;
	b=EIrQiYljeLnriWExvlXc1wjKMtPL4l2x+rRQYxLg1HWC9qAO/bQkh/I0DH6LoHtngxT5
	 0+wOvMtYZAEMzBhVvsfNN9zTSNDi7S27yu10oifhfqpGch/NRmU1VJfxesOWX1lB31Sbc
	 CR/IHeidvtXcB1mEmBbFt6Gt8jZAkxJ4FExZTkN/aAoXDQ81zm+vw9Qf1Hd2+iIGY3Nhv
	 tyHLA0oPNQme27QsnIpSsqb4/6EgUr0ThecdZfOTELcVfnVO8FB8xAHHx+vTihRQfSlR+
	 XDH+7uREC+NayzftbPuZNIp79wfDT2y5bzMdDaj0WcaiFfn7l6R8/0DSaFFX+Fkrgxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2MWvYsURXz5zsNexOPVq2JZGwt5W7doauIXCyhsHOgs=;
	b=DQRQ4U8NN6h3wybaT8xI40lUmN2cqS4o3gxg4Hkz8zP+krAYoGWiGC94h2hjImKnhb/6
	 K3GRgAwgGFtuHeoR+0SGT/fBR3KATPMP7mq25nFugRGmMGkQskx4YJxjXyfxePvkhji1f
	 WEm9xjt9riZEVf5ZA8tdcOf6RverK15I0gkdtesX4g42rm++XfShE8vURPCNsmgzKN+QY
	 hUkwQFv6dZ0ExZbOHIETOV8PMgxhCoDbyaFIShknQ8Q8KcPiFx70bSuQvyK4LPZMdiboB
	 q4YCgLGShkILaN9S67wNCekKK+Gm1Osd+UqFpLg7+/1XXVZxYXPBS2zOw0yZxuWuK2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606256;
	bh=2MWvYsURXz5zsNexOPVq2JZGwt5W7doauIXCyhsHOgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QYQyR+OR1sxMKOsL+YcVtpFMg/z1gWsYt9DO6r1KhuyB4GtdLEzqeeXOAnVbWq+6Z
	 3T7h9bsVY0OKdBlDCevl78PeLwWfrVfwmUuwViXC8D3HTqfPMdqNQCVcfNSkoXr43K
	 RxdRP6K5s2fzGeKuclD7vtmToT7XUL2mAxqEuxeCqqVb7xA5NgDj1ems5HZkFEgB9p
	 fvJ7zOfhkEFV16BZsA4SqjW66gunr7cN/jcSu4ShgX7Z32XHq77cvURISSxa8cCBqy
	 FjPfsUX1lPERe9fWxZcrHkfJZaPdKKga3S6fkvkMYNi8GiMyra6a5EMeJeVM6Or2A9
	 jrynjl9JJDD7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 616D360706;
	Wed, 25 Nov 2026 11:30:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4650A325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37A1380CA8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dhZO0AxnkNK2 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FAE2807F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KCUrPrxh
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FAE2807F8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:51 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so3658416f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606250; x=1796211050;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2MWvYsURXz5zsNexOPVq2JZGwt5W7doauIXCyhsHOgs=;
 b=KCUrPrxhushrsyznvpvzJjVqiWgtslwqEx8kViu37x7PZf3w8uW3TO2t9xXmqlum6B
 se7rF33mGEbg33pL8XU3h0toaJxM9/13LeEGo5yN4GUclKACyqbpnPBnkAdp6qkGyapR
 pA8w2hcLOI0vkVLjAgPokszlTFNav4vRhcMXdrnYNRMGkQf4Ub3RwIZ7fcgY5JmfLrLd
 cRFisAsHKUByMVV16eGYbmSOfnc2ZDU6GzEzoyl7b7bf/Z+nsJOdJ1gv5zgJlfR9C65T
 UWqvV/or0G1qAiw0d+HPE10ygBpzMREA4aRKwwZj9XdycrFe8BfiECFFdLckXfaeoqRC
 5MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606250; x=1796211050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2MWvYsURXz5zsNexOPVq2JZGwt5W7doauIXCyhsHOgs=;
 b=lL9dXpADVXodzt5j+wlg/2AWNot5uGTstz0QAL92DwVgE+1gkbOyxEnTep7tbDZh5F
 Qd5GiZ6l6xf8vkq1j7oyQ3tFnvrus+9jeBS8p+SOCk9S/Nacrl8tzQCWzhXPWxlVRtJA
 dxuED/P4L15pW25ibpsJJTBjy8L4bImr7ThfH3EEQObWX33ux0RVFkg2m6O62k4MEsMx
 1TTWqNmf7Gp4KOrYISW8vDnx+Me8P/jxFYZe4e2AmABIxgqKoU0Hs2FsPGBvp2JPRjzB
 NRQA5sedPbJMxwzNOatHhJ4q5bJbY8Kg6+XV6TZFf2iUEOq3yN9sljTgyyFlqL0pmias
 BjqQ==
X-Gm-Message-State: APuU4Z+MECgcaY4TXJebN1xxVJsLpDmAZq/AU88qIlgewxFwr6p0Ie8y
 yIdqwoS8cayAPcC5Ghj6Co2GCKf3Lfha7O898xjAGDC3AXHTOHZjOtoi5elVwy1XWZM=
X-Gm-Gg: AZFdTZeHXxiiUWcilENh5gJx0hVVnd/jBEI6RKvTof25Alk4qkmGWUSDx57RrXEk4J0
 Ug0o1JYScMIHycoTD+Eatckp1HGLJNdv5ogGn63sUHCM83PHcECAyy0oD0kRvixPDZyAwp2iqwk
 qDdYmxf7/gt0YYRMbWG5eczHxssorHNmMIfpZK3m7AaQeHJMM7RR2I4LRXuiJr5ow/r1O+30O8Z
 LvKPNsbjHDKxXOpBTzeQcK8UtkPrAmr+KSswcvZyc/MGj/zOXXbfI5siPQpao06Q78zLadNkzVH
 2eLojeEb+PMLoJUqzqUKm4FxqvdYqiOZ3VGEDg7l4jVhS3zFmBJxwUcnd2KZPd8EUL2COuWLco1
 a53nlZ0MnhRmPYyiuiwZucSwXxY8FQcGyMveTURX2QXk2f82pSeRYnyXpfK7Mc97vWk5SxFk81r
 /Xd8zXPrg5Ky1WIKn1lp3c0zLhcEhR3lAb12D/O/N1FUFl+7XAWNoLvNqtwxrZbJM9HPD7Ool7q
 p6Z6itpAmIhqcLqZKbhhy7xEFIp8CZ+ExTuWwaQjVzti0DeWn+jWt6cnDhMV0Zn9ZE92+p/sSLU
 qbUdwbD2/ReGkLevwSQ4ugqjEWDl5OQvbzGqg/T/kI0F89IMlJeLifOSrqJKhNaIRVCEU1frAQ1
 F++ba6WqrthrRVHea
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-4abaa97702bmr32668882f8f.5.1795606249863; 
 Wed, 25 Nov 2026 03:30:49 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:49 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:29 +0100
Subject: [PATCH v3 2/7] arm: dts: am43xx: Add missing board u-boot.dtsi files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-2-7f5c72c1116b@baylibre.com>
References: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
In-Reply-To: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=1409;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Dm4ykr1md6JJ1mnqBX+wEibRtq1NoyPw71Wi/leoDYs=;
 b=a90AiuvX2fFTLzyHDM0eOjWOKIN8yBvee4gB+f1xnL8oH0q7GLB+4zn2TAF2bWyZtaLyA6uR1
 nMVdXDY26snDENnuKnZPVZlMT2K3tsvokIVl9DyaVuCRYqpwUrh7vyv
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
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

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
overlay file. Add these in preparation for OF_UPSTREAM to include
am4372-u-boot.dtsi.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/am43x-epos-evm-u-boot.dtsi b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};

-- 
2.43.0

