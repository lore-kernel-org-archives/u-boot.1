Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28FFCA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 05:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E12B606DE;
	Wed,  7 Oct 2026 05:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9lRMlG9MO7I; Wed,  7 Oct 2026 05:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CBC736068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791351687;
	b=JPY2YykX87+wvS2A9ptOyqzjCoLhnDpo+kViF/AfMGS2MY6MNkJPJqthjUYU3uDOTaTZ
	 NxBRrcsXmkpqXIy/8l05ScM9SUqdblu9hawvMjg/xsA4T0Y4M8rInl/O4e/SwkIs4Zvfk
	 P/UNOtM6dB5OCqJvvkhFp5AFTseGjn+RwX4wVLyp5ZCHAR+mb+WKDwi3LE3F0x1dEwvI9
	 eafvTU2EutDIkVGcc4sZIaotAqgefk9GJhvkRaxGi/bF6OIqaMIFiHFDJG7B0KUC1RE4D
	 Yv8/TJyfTh5XHIMLI3BNp05N2c3OpqA2DUCbHDZAqAT9HfllgxLTiyZi5sAUE042/Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791351687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aZ+2CemSuuGVkMBJKNtA6xpwvojCWYh1qc5BzgbX3eQ=;
	b=Q1r1BW7U1K4m6JJTn4LitxyzAPcR5lMqsvPCZk0a/BSIMVrqd0LRRonJ3+OfB0Stf10g
	 DjYNbLbHKdzlxtRceh24n1uIghMgQqbIQ2E/9Je8vzD/KaJkqe62GZpSimuhEb3Fx2X4h
	 x3dL3pbMI/gmtqMUTPgxO+8RU4pf50V01I8BNYuCs5Nw6tDy4C2DjV9k48ointXpi5gJc
	 GJvVLflPha+QYwEuWRCcnP6Pj4Ea7rHy3l/OoKg9I7SrFQGlulFAnf1aAaRpthTtlfTG9
	 afqKjFHcrVTTEwTty7zPiQU6AdH8k+5oYHcSVEXZm93WG9rK0DtLUurFhtKquAt/gqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791351686;
	bh=aZ+2CemSuuGVkMBJKNtA6xpwvojCWYh1qc5BzgbX3eQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NOR+mfc3ODSFFhdnzOdnzqXr3Lpsl0REuX/Gwy7t/xku/8P8xPjTFKfhoeOTkIVRD
	 hWGNX7WDJZ+eusEu6GffwKPknjtAeV/94BJFkWGcY7gouO+4kI52pPGkJIgt1msfBm
	 X535e1wfGpk/zggUHqobZu4aOu2anVX6qOxyWoRA9TSrDa0188eE0o41mTOSLXo8he
	 MhAupNl10Qx87dt8IODOdcs+AgrD/+UYx5yJMjBrWDuAydTbQWfa7i7C4znnqgMJTB
	 +TNbZmXV4utzKRiUo4/6YOeoW6793l8vZ4SvA588mvpn2WAr3nAd3xPF3srJmS59t4
	 XWR+0x1JYH7VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBC736068A;
	Wed,  7 Oct 2026 05:41:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 304E922B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 220944070E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id beTicJvh-FHw for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 05:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A7CE4070C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791349925;
 b=auUmNWv2zSSMXjaQJaw5mmty2EOfns+VujHVlzHHAiIOkxddxmjSuzFHaA430mze+ZQB
 7YjVTSKtGBnsYnH1He/JMucpyVg+tZKzlV0wPxLJbR0cs6SMZ7TTZJLJ7iwSuzveqvTwx
 BOMc38li7K6vFeQGYsNMgXZXf48G72LvXlfx+kc4fU6S04Gosmt8Wq5QPVDg6TB8KuYPv
 4dLs8pn148YXH/LK5ByeUFTKdqwW01kmWCJhVp2I/1pFEvw26cRzlLQD5aniObzlNi64v
 2RirwbnEtfHA83Gzlo6NYhJ/hypTstYQ8pfIz713l/v+BKTdwqpipTUdcxCvAkh+Qrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791349925;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aZ+2CemSuuGVkMBJKNtA6xpwvojCWYh1qc5BzgbX3eQ=;
 b=ZFmAPNEI2IOQcWdGJRyUg/t6+UfK1jU1XV6KeNavjL0X+dcSxGX/JSNGKbUwtYFfDXGr
 RnTyCQ8wwUgKPCV0T2BYSQndCg/9WbbXtj3ejQEizeFVv0XmJZLjNq5xriURfsUY6Pb4k
 +N0IPOsda31dEM419ghJO80p4PJTFTchMyA0qYK3UQ3umeyYBZZ9kBcQgybnLe9up8L5y
 shfQzrqoHj4HzSjud9dS9OPTpBs4RiTpawN38u6kFikhajQBE8XNik+EIacZf405WrHxS
 O5m1gECQAuNunBEeOTek1ZX6idB49XBPDsNCrssT/dUmRspRWDX5ZKbfYuMg33E6mog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A4JTPccj; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=A4JTPccj
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A7CE4070C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD8B8601FB;
 Wed,  7 Oct 2026 05:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3581F0089B;
 Wed,  7 Oct 2026 05:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791349923;
 bh=aZ+2CemSuuGVkMBJKNtA6xpwvojCWYh1qc5BzgbX3eQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=A4JTPccjiOxIJ5Ob66JeUniKxhlxr9yGNYfMSeopLZ2yLVw1u2UVCAzlDPjF5Gy4+
 nLwb8LBddO/G5/LLaohLKLKa5eegr9hQ/Tg9wgFSm11k4JBJRkXoaZrK5vXAcHlV9A
 wW5n1qM62jAXg2TjuSWhi3xqpg7AaSAP0pm1i4UhSQL2QQEf3Tkb5ua0RMES+t7Ldc
 l6MERy7C0C9lHaIezmp1XLmdw0GTXv+T/rKTu35bqEd+nvvpCPGbBzCqT18xGocFLh
 1iVrlm8LcX2Ct1gu0/+d7tS3esnfahmkr4nIE3tSOC0RYzz41BpIfh5v5qptE8JPPY
 RUEn+K105OcHw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 07 Oct 2026 05:11:32 +0000
Subject: [PATCH v4 2/4] riscv: dts: spacemit: k3: add binman node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-00-basic-spacemit-k3-v4-2-c44d09937088@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=dlan@kernel.org;
 h=from:subject:message-id; bh=wLNrprL7mlncJxXcimIRnVC5hbhoVXmi+tmga/7Q75g=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxdSRtuPgQriadvVV+sMLLOgw/lqKFV/cAUpnh
 UP/4+YJZTeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasXUkRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0mEQ//TV7MYsDeCmUOqa3BZqmr9YQ91fBruW4sPTSO4/y9+zLwm2+9WYSWm
 UkE47qPpulc9E8szu4+TD6Xb0lpADPWMhjxhnkVn1pQsixnY0htJj4BxXlZrqU3RPKt+LgEra2t
 qPxLn9QZH/XC9kDFO2r5rXceiDArXuvBCGE2G/mZPV81XPNLZZau9znfdL3CDqOtfwb1tPIRlhb
 /xGW4v1KTEw5OR8jTJ50bZJfKFhUkTV2wKeeNbyREB49kvYY5OhF2OMLqZDtzuV4BvwJ5a9SoSH
 dXaBb97IuD5HAJZgpBaFgUL6x5R+jdef8GEsK4OW9cnfgC8m/k4mzJU5REs5ou5xUEm2vvDIwPF
 QJuNGrztanc6gfB1a22+/AN2AHKi8HZIl2VPk5EYPaqC2RRaUBMhS4UsVEZHM0p2+6UNEgzdWGc
 HeINB5TGBaMoaHeMnT/zhMStN5v88jzFgy+u2Wqclfqyp2gs1lMkAWJE9eyJQxtWXhov16H82w+
 sw0XBNJLABwTtYbvY8m7esGBZgm1VVvr9ml5eebd3B3p2y8yiC9FJzSrzcJ+6lJmb1gW8ZOG2wx
 MoVQHyUYTc1g/0OWleREg3dL8bme/7pib9VSiAob/BXgk1I1JX2DKOZp8kBFrNpsslOPB+oAPUs
 T6E2yokWlxLyLAqDWLwCv/Uy42vHwg=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

SpacemiT K3 follow the standard riscv binman layout, which has opensbi
and U-Boot proper, so include the common binman dtsi file.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/dts/spacemit-k3-binman.dtsi | 6 ++++++
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-binman.dtsi b/arch/riscv/dts/spacemit-k3-binman.dtsi
new file mode 100644
index 00000000000..f1c1c3ee6fd
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k3-binman.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#include "binman.dtsi"
diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
new file mode 100644
index 00000000000..352e85e7de8
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#include "spacemit-k3-binman.dtsi"

-- 
2.56.0

