Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95BDCCF2C7
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77B7F40AA6;
	Fri, 16 Oct 2026 21:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kbr5z5OJ-9UY; Fri, 16 Oct 2026 21:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1481040A86
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184504;
	b=QOPpoSV3JThSEj8mCI19+0aSAMdqZAWPwzcFz/qYmWYWk6Ll8TuXloKDtkYOSKTIz5S6
	 tTrhutXvkpBb1CnkqZolZ6RaaLU+NsAZrBGWgvRWCi3jsNCpRV3+nuCx10Be5HdYRfmk6
	 vciUTiykH3cXYjPsj4Zs+nq8nhaibeAkwDJgnqkcVOl1az4PI6Q7KZuT8+LbyTnwY+reB
	 jFpLogaDvVrIZ+v4o9cFWAIAQRstYqGw6N1MgUgeNFG+wUoSwQcuGJjuD2ibWRO+FhyRy
	 00tgfGcLpiTHTahnLlOq1RtM/UDGngO4HMg3Lt9uZKk6JQPpr4m/XBmBmsAb/NQ0reA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VI2qGeM1xb3U4pcbOh2g/63r9AwysaO4OdxjiLcJab0=;
	b=JO+B7e81TiCNwp3Esas/Ua1ctZXHcUkBRuftKCPTEI8v73Ljy9PVcnsG6sQ1gEJQ0c3v
	 FqihBGubUqRne+VFI72KkkPrSsdBHIpXaCatIc8RQWMc9gmsFsxvq1cJD/PBrY6aWk7r0
	 G1S1nHL+BW38VA1cLsLl0viJmw6tpjoCZGyVQs4w9m8PrEAgG9rRqOiNQkxatjGWxd7Dl
	 bI87kHvVNL7wKghA3X/5PY0pU3FiDftZwukB2eiMdNJuSLZSh4VzZ5TL5uTGpJiJ/86nV
	 VyomjqVpkilgHuUqKVzhn7vx885I3mLEdEw78DTshmK+hWJX8rgDiM2NY6Ia95N2lEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184504;
	bh=VI2qGeM1xb3U4pcbOh2g/63r9AwysaO4OdxjiLcJab0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VeFYojf1QlRhuUpEkDPE9mzUf4fJQ1EoWDLU25YzfdQmKVTvfs74fNtzQMrUUFvxk
	 4b16fTPQ4gd5x9n6kUw/Lrdxe5A19bZ3OphxLW1KICk1pW+2R6cdjDVd0XmXoVCoP+
	 E3ovqdODqUtt9JQzh+oNPVT2Cq4VFdNRqbzd5+PXInewoq2FnpdxcgPjVVwBexKJPF
	 fmKzLjQ1iEw3OEyQTWvLcBizfYX0KJq7vdu2r8TJ6PCYE1Nt+s2oFCBjwxnMBiE3bt
	 mYdFzq/bqdZuhSeSIP5deOpZ53mFY/45tXv6FbPsbQ/3ODb8xfF28JUIkR0aO+Vr/l
	 6/fPfUvVjDAPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1481040A86;
	Fri, 16 Oct 2026 21:01:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 140BD75
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0444281770
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6s291ac9ul8i for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF95B8176F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180375;
 b=idhhFsGIywldxs/e2+xR4IbYGzWdGeiUqXH1ZEJXLaV+OkQFsCiwHDwhBnfCOgxfx8QX
 ixNbB/dYIUeq91+CBZwy982H6p3XtvwhRcxZQiWsBciq80gkfSTntdrOoAfSvhqZlOlct
 79jzSM0aiClw+/kt1+SVh4/xdBOq1kpnOT2/8vjv4OS0qISdMF3qGPNm5DhQDPFoWe26I
 hDCop3+YbUAboqWDMx50dupe3Z0qLNzu6KyPITOAZidWsuN0F1KaRAecCigZerQuH0h7h
 wrzkWVVGsDoFULapJ+UJR364kOuGvLpyH2/MewQoZVdzt/hk3Y5HpZLzjG72yxHuh0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=VI2qGeM1xb3U4pcbOh2g/63r9AwysaO4OdxjiLcJab0=;
 b=PQBoSJbPKVm1dJPk83P0EgRUs4TDsWEoSGkS4/2ISOfvr6wQMvmD94eO/XcUaDSZ9MBT
 /LOzwKbqWJ7SiPplZcMs+yTXMjWCHD2nqN9nsqONFkhfP6t3nEC+D3nil100iPKCc29n/
 SovFrVxjpASj9ZNBoJKvy3eawvAiQz6XSIc/xem+P1szIOBrhsMjtDB1X6MhJPwM0CNQ1
 dLh0ZZ2LYHlO7jJurOepJxeXpbnPRMK+KoZQdtTv+JAjpts/kzjav32twPcePAmX/Cz/M
 kBB9XnSGxnzzY+vM9FCp6HzDPhux9h7FTXstXcipKtqjZNoDFAQM5SMDXeU0/FJsxLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RHtHXUGG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a29; helo=mail-vk1-xa29.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RHtHXUGG
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF95B8176F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:54 +0000 (UTC)
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5e6b5794d26so375234e0c.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792180373; x=1792785173;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VI2qGeM1xb3U4pcbOh2g/63r9AwysaO4OdxjiLcJab0=;
 b=RHtHXUGG3uSztufT63asICMERV3SkdAD6KUko7Jf40DfejfVfdclbIkQOumdbG8zh8
 keK6Eu+UC7Id9hHcnHSIKHH0x0ruQp8Ge/KGu4HUrhfytphrKOA4T309xN3UI+a9eabt
 r81Nhf0ODFt+cZiFwdV3niC3Em/XcvC0RahRLsOSjMlL6s5u+2J+kIgg6cvroAOxvQOe
 q/6eZjG4dblhj0UBFVAFJGo+3+G9Wx42RhctHpYNpT92bjIV7eDpykERviYbJ6F65H6v
 icmN7A4I9ICs1KehUmUk7PpjmpkNN0d+Hpg/UBQq7p7Fh2wjojAqzH67haHIKi+m1qwL
 I2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180373; x=1792785173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VI2qGeM1xb3U4pcbOh2g/63r9AwysaO4OdxjiLcJab0=;
 b=p93XpFH1fzpVDYK5JnCzEOja05flm2pDxD22+Xfx5ulyiUkxj7EzDuFEYGN3odxRTN
 g37uGW4zvKoVe2BNgs3cMicrTjA49toReKcST+RsQSKzzs5mY/MKxzkh3SsxQ8v1JvYn
 pfW54frl3kzg3dmVTWlLQthzj6Edbg47x7MeTVezme3zR8hYH64zq9Oq4hbvA5cvRpk+
 2daucmNZrGt8Y/zPrRgwubgulbX3pKSnrWBXzL92pzbYe5a9kG43IEWFFy3PVm1ZXBYa
 efm5ItXAAwKi4ix3yEoyYmqy43Ou0RghehdufsYS14jG1EJutjlafAwzO1Ch/ucDXTa/
 F4Tw==
X-Gm-Message-State: AFq9FYLvIxPeKQViUC5tl+BPj1wiYt61ikjquGcyrknZHPE6LeUQdFtt
 P8mtYNf+Hx+c5n6u58JYbPa+YVUwm1WXVWExoSIgi3vHUORg7ony4QW8
X-Gm-Gg: AYBFou3Sya9xVQo5Ip2myxoeXmSFax1wz8antaY8MnpxJtT3Iad8nl7KMgE6HlcRElq
 Tjlr1au8kSzLj3PARTFAPAMT0iILANooTFc6qw9rTpbzyO1kSbXc1zDd3gKn4hdIh+FzcpcyiAG
 81tPUN4SEkLWvj67EiZUkAd8TUY3lUpgfBgrm9FPFup8b+8m90sG6P3wZTEE3usgRkY/XiOKYML
 3H9f2Q+1In8yRGCBo8GH02FyKPMJaa5ty4KokaB4yLd49eWUk+ukq0n6XnSVLaGtZJkXThtQuHV
 Ve1rGR0M+a3C+jc5YycSONU3nEa3UBqYI/L48R/ImVWEYOsowVw72UosDg2WmlTkkz9U5JItilT
 hFv862bALmzFhPoHp7GDUZkm5+QWU15xXS6agZfTThCGs97TfRAqWOUce2L8inHMOBr9JxC410X
 PROl1e/YocVS6QJRscE4bpm/1+0fH733Sb26M7nM8tfqrkKoAEzolc/O13gscjAKr1BDgAf/D0b
 BMZIg82DPO+dNY=
X-Received: by 2002:a05:6122:84a:b0:5e8:ff32:982c with SMTP id
 71dfb90a1353d-5ea97fdacbamr900674e0c.10.1792180373661; 
 Fri, 16 Oct 2026 12:52:53 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b2fef79sm2340305e0c.1.2026.10.16.12.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:52:53 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Fri, 16 Oct 2026 16:52:31 -0300
Subject: [PATCH 1/4] riscv64: dts: sophgo: add SG2000 dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-upstream-v1-milk-duo-s-v1-1-e4bf386eea2d@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:39 +0000
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

From: Joshua Milas <josh.milas@gmail.com>

Adds sg2000.dtsi on the RISCV side.

Signed-off-by: Joshua Milas <josh.milas@gmail.com>
Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260615120324.1527881-3-josh.milas@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 418bd91075ccee25828db79390848da1ab3ef0a7 ]

(cherry picked from commit 48900d9aad54bcbd48db3e906e17526ee682354f)
---
 dts/upstream/src/riscv/sophgo/sg2000.dtsi | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/dts/upstream/src/riscv/sophgo/sg2000.dtsi b/dts/upstream/src/riscv/sophgo/sg2000.dtsi
new file mode 100644
index 000000000000..38462769574f
--- /dev/null
+++ b/dts/upstream/src/riscv/sophgo/sg2000.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#define SOC_PERIPHERAL_IRQ(nr)	((nr) + 16)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/pinctrl-sg2000.h>
+#include "cv180x-cpus.dtsi"
+#include "cv180x.dtsi"
+#include "cv181x.dtsi"
+
+/ {
+	compatible = "sophgo,sg2000";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	soc {
+		interrupt-parent = <&plic>;
+		dma-noncoherent;
+
+		pinctrl: pinctrl@3001000 {
+			compatible = "sophgo,sg2000-pinctrl";
+			reg = <0x03001000 0x1000>,
+			      <0x05027000 0x1000>;
+			reg-names = "sys", "rtc";
+		};
+
+		clk: clock-controller@3002000 {
+			compatible = "sophgo,sg2000-clk";
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
+		plic: interrupt-controller@70000000 {
+			compatible = "sophgo,sg2000-plic", "thead,c900-plic";
+			reg = <0x70000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <101>;
+		};
+
+		clint: timer@74000000 {
+			compatible = "sophgo,sg2000-clint", "thead,c900-clint";
+			reg = <0x74000000 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};

-- 
2.53.0

