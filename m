Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D298ECCF2C8
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 913CB8165D;
	Fri, 16 Oct 2026 21:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4UwcI1qbSUE4; Fri, 16 Oct 2026 21:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CF57814EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184506;
	b=Jgjtoy+Eta7eprDuVci0S6bdiwN78wXnb/NenKCOXk3G6ZwDGRFp9wF37b1+grGxJ/el
	 0HtyPinwayI7VHs9UewTXRKhm+wWOe72ws4ZVHVoLIWVfrU3w6BwDqo61nL9bIFGS0AK6
	 x/C67dtjQW4nq2pi1ilHMlRoyr7xG+6sGqbFoxRhX5m3Uycmwbno3KxYEReG4tjSckmrL
	 BBta4oY38+sWHTrkF9I/8l+mkizlhl7u86CY1zbz8WjzmLFlXPji9GUtbDv89/52N1Vl9
	 p5/lrJJlc8a7NNgGEV2WW0t5dNWwD7lGwuzjpaXF9hD5OkYI/t5gSJc7HjxlBVtWtVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A2KfXWJ5D3uTnpe8N1tzUpXUIJWwLjU856Hc3kgnZBk=;
	b=HGIrkLo9qAt+fplFfTK1Zf54tkeMqgEuq0S+0WKTvgc9Ds8prvMtigA9ghn4Z84pyJUz
	 2u9BDJVmWEPFgsN9bkG+OWSp5NJZvlQtcRNeMtj34/BZzTWbLlVa1oZvUO8AvVnrE4qtv
	 ftfPZ3cdKbcCYqFbmcZU+bgcKYoHIRNv5levRXOaJWTFuN1pTeBJ7n65q526IJlydA1JL
	 xWNy+WQ2TnWEpT1r2QckwGlzTrFqylRPaQ7P16pI4aljzLWupM9gBLXDZ3IAJ/mUfCn/f
	 LQw5cJgLOhZabbnEGX+uv9H3fLy/aGZidSfOgtogVSunH7Y1B/yFYxMIhq+MixJrDIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184506;
	bh=A2KfXWJ5D3uTnpe8N1tzUpXUIJWwLjU856Hc3kgnZBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zIszSbyYDYBrc4X34Edj4PP0umHGh8id2ZUQVnMDvUvkeDlmYsZrPFfFGWJHOZ4K8
	 ntjQlEhYPuuZp/rtyiE1HWDeI4K53JH6N0TECTylnqlk4jOQVnYzBubgGsd7FP9faO
	 JkNcTt1I/r6JKXG7DRFaE2uqVNVT0X74O7HsCNtizDM1Q/GHJUtcTI9aGkBDRUz5Ya
	 LIyigYzTsL8WrEtEJ+0EN8k89wpIw/tR1as6dfW3jwrGgF4pUlXg6jR+UELTapJ5k/
	 QjZ5fVQW5Z2X2nKwL/cs6h7oArVvBps0dEv1OKXZIYbYzNMrX2cLUMtXmL5nFqyTA9
	 nM8JjdFoDuhFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CF57814EA;
	Fri, 16 Oct 2026 21:01:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7008C7AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5618840C18
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EG-18kRGLGag for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FBD240B86
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180380;
 b=OkMRAwy+WIPe1uwVI5PkqUW5nLSQVe74H4ragoAn5/lXzn2OQ/M151s8RTSgrI2rBktN
 T69wVxf4wHoBnp3NLKO4NJ3XvbyiM0RJFzDLHmBsL3O0lg/gbupT189jseTK3V5HNLBS+
 KzSZGidZQEr4cmebKxuTtZnPsM++xMXpXjj9BrHXIMITGzpJ5u99KVw7KTJ9PY76tmiIM
 ZaZBfvN4E2sLl4LN7ForS++GIZy9b9bCGkcfw8hL+uc25NyAA6U4csmYWti6+3ZRY458i
 xt0pp8mTRZsvdi7G95HKOAEFQq0lyBTeS97sdj7vc7O1s3Ue4r9NWUTWiASBbSQd8JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180380;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=A2KfXWJ5D3uTnpe8N1tzUpXUIJWwLjU856Hc3kgnZBk=;
 b=jIfVhYC2eqyIFJL9MLD/mchJ+0WgXEKSEfP9ExCtznb1bTEoNWABEeiko+0n6JiSXX6o
 RmOTo6t2Sh84umTzNeXZ+IydbGEtEB7royvG3SZSmlksgzeshGRmuqUruN1kqG2FBGswy
 A6vve2WG1VyP+Ta5MMRmeF1PPTunzJ91JnIPpQhmkS5aAXavgoXBhBekeds7O1ExTR219
 1Q23OGM8AwC9rIVwTjq7RGIH5iyZqp4uHWAr0bUCDC+XnYo09Es5/76nJdslK81riXTpR
 XCWciUEu2ytaq/OFJOPnAlVix9uchR+DXoyCEuHXpz10fWaCg7Lc1zPqcsblqF6aMHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Rxf08M0N; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Rxf08M0N
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FBD240B86
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:59 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5ea969fafeeso129939e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792180379; x=1792785179;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2KfXWJ5D3uTnpe8N1tzUpXUIJWwLjU856Hc3kgnZBk=;
 b=Rxf08M0NRRv7u3NWIcu9cBVn6YMklfsDGRNBWc7vNnxyZ+GQf9U/rwCgRMEhNzRBXo
 o9aFxcVqhGq0c/MfqTFmMWOpKy5w4janyVrSer2orm4JPdwqVAVijFmDeKyjojl9pWFL
 LGMPro42it8vuw2Wjx3MBLdGvothnzpG4h7mPRpE7zpLe6L5oMpTSDKTq/VYoFZPW4Xu
 OkorlIHuIib4mE5SejzxX8P4S6gLMhkvTCUdR6w7vcoDxjniFJtYn9M9sNRUitpF0mFP
 BOvAkntHxw6qy/N3d4rlrJPv7JjfgUzXclTZ2ad6rojR3BgZz78hHUamfv3cWQNzsIOt
 eyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180379; x=1792785179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A2KfXWJ5D3uTnpe8N1tzUpXUIJWwLjU856Hc3kgnZBk=;
 b=oLyCRRcsEtSMphXkdqs3fHIDW1vXx3h9ONes6ROmRnyZaveD0rOTgkW+9KpmaONyON
 iya1g77UN+lPZE+Ai+WSfQDddrvFlPPS0otLMc7OEaFyUb16Drx91cB4aaAhGlCxXVuU
 yrwY6NoNq8ZjzVbblaO3C6vlhZ3VU5WXXQGgsixQbHEUxdJPBDpH8k+CjqkiFJHwD+Qp
 cH7e+msTXbKdFEeM1Y3IGclanWPcbtPj/bNoFtONNIaCL8Q5xjt7XTCrLj9RSEA2BkvB
 xggkMVQxkGu9MAS4HTQMbd9751dyJFlLmzOqooPTdeVrVCK5CcCWXtRmo+YUdDkSQ5QD
 Jfog==
X-Gm-Message-State: AFq9FYJmmWDT8r1SVCK9yKtFkEs0EuzJCzJ9tPSEISHpQbo1c+m2iS7O
 qa+N9wyKxe3wmy/vd3HD6JLB8VuGZPI1NCyc4hmT1Ix+yBnR7mjnuWLnMgys0Ei66Ks=
X-Gm-Gg: AYBFou1ifa5iG/Cdz0Uyb8oiO338l2OAllfeAQ1R/Xh2KVdXM1TSeUENupFhiLFyYU/
 KAglBZcXkN/WBG0BGoC/isiEIelhpFKDKmyk2bbfKZ8N1Rq+3/WMZop6qHxl+rrpdMLqTH5bk9N
 Iz+2bOngQPe/M4zMmz9jHaQXD2YdKIG31aGcFYyzJIRXdU/2ewoPLi2VDYmUavkALkuEJV+yLyz
 EyLhTp6DbnJz7L1FLuwz098aXB4cW4XeLfW8p9I+VnKoFQzQrmAxQBcSO0xM2iLJSkeZiwqcEQi
 k0Jt7fxZXbkdVNFbr+08zuZ7h+vtKnYyYSHgc1BFdzCBHQfQIuEhsR4ABT1AFHzBQuNW8j7+ase
 jwRRAgNqKtF9MYSve57QnIng+JeJ5ddWDBwmdzIIf506E48GTc+OhE6IQH4KrX3XsRox6moYi/8
 PIYUGTumz5CRzSBgH39h52LjxU4MO5S0vVsUdK9vTn0TZJId3vAZQkQf+YQfUUt9unHe7SQloet
 EbRRvUp9lOdBfRW
X-Received: by 2002:a05:6123:2eb:b0:5dc:d0cb:7d6b with SMTP id
 71dfb90a1353d-5eaaa65aa82mr524960e0c.14.1792180378808; 
 Fri, 16 Oct 2026 12:52:58 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b2fef79sm2340305e0c.1.2026.10.16.12.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:52:58 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Fri, 16 Oct 2026 16:52:32 -0300
Subject: [PATCH 2/4] riscv64: dts: sophgo: add initial Milk-V Duo S board
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-upstream-v1-milk-duo-s-v1-2-e4bf386eea2d@gmail.com>
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

This adds initial riscv support for the Milk-V Duo S board
[1] making it possible to boot Linux to the command line.

Link: https://milkv.io/duo-s [1]

Signed-off-by: Joshua Milas <josh.milas@gmail.com>
Link: https://milkv.io/duo-s [1]
Link: https://patch.msgid.link/20260615120324.1527881-4-josh.milas@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com> # Trim empty line
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 66153532fb18474c83f9bcbb27b039c7788e664f ]

(cherry picked from commit 2b4cd02ed6873160a2c8be4cdaa0d63e92b52830)
---
 .../src/riscv/sophgo/sg2000-milkv-duo-s.dts        | 244 +++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dts b/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dts
new file mode 100644
index 000000000000..78a257839f6f
--- /dev/null
+++ b/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dts
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/pinctrl-sg2000.h>
+#include "sg2000.dtsi"
+
+/ {
+	model = "Milk-V Duo S";
+	compatible = "milkv,duo-s", "sophgo,sg2000";
+
+	aliases {
+		i2c4 = &i2c4;
+		mmc0 = &sdhci0;
+		mmc1 = &emmc;
+		mmc2 = &sdhci1;
+		serial0 = &uart0;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&porta 15 GPIO_ACTIVE_LOW>;
+		power-off-delay-us = <50000>;
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&pinctrl {
+	emmc_cfg: emmc-cfg {
+		emmc-rstn-pins {
+			pinmux = <PINMUX(PIN_EMMC_RSTN, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+
+		emmc-clk-pins {
+			pinmux = <PINMUX(PIN_EMMC_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+
+		emmc-cmd-pins {
+			pinmux = <PINMUX(PIN_EMMC_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+
+		emmc-data-pins {
+			pinmux = <PINMUX(PIN_EMMC_DAT0, 0)>,
+				 <PINMUX(PIN_EMMC_DAT1, 0)>,
+				 <PINMUX(PIN_EMMC_DAT2, 0)>,
+				 <PINMUX(PIN_EMMC_DAT3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+	};
+
+	i2c4_cfg: i2c4-cfg {
+		i2c4-pins {
+			pinmux = <PINMUX(PIN_VIVO_D1, 7)>,
+				 <PINMUX(PIN_VIVO_D0, 7)>;
+			bias-pull-up;
+			drive-strength-microamp = <4000>;
+			power-source = <1800>;
+		};
+	};
+
+	sdhci0_cfg: sdhci0-cfg {
+		sdhci0-cd-pins {
+			pinmux = <PINMUX(PIN_SD0_CD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-clk-pins {
+			pinmux = <PINMUX(PIN_SD0_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <16100>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cmd-pins {
+			pinmux = <PINMUX(PIN_SD0_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-data-pins {
+			pinmux = <PINMUX(PIN_SD0_D0, 0)>,
+				 <PINMUX(PIN_SD0_D1, 0)>,
+				 <PINMUX(PIN_SD0_D2, 0)>,
+				 <PINMUX(PIN_SD0_D3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	sdhci1_cfg: sdhci1-cfg {
+		sdhci1-clk-pins {
+			pinmux = <PINMUX(PIN_MIPI_TXM4, 1)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+
+		sdhci1-cmd-pins {
+			pinmux = <PINMUX(PIN_MIPI_TXP4, 1)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+
+		sdhci1-data-pins {
+			pinmux = <PINMUX(PIN_MIPI_TXM3, 1)>,
+				 <PINMUX(PIN_MIPI_TXP3, 1)>,
+				 <PINMUX(PIN_MIPI_TXM2, 7)>,
+				 <PINMUX(PIN_MIPI_TXP2, 7)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <1800>;
+		};
+	};
+
+	uart0_cfg: uart0-cfg {
+		uart0-pins {
+			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
+				 <PINMUX(PIN_UART0_RX, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	uart4_cfg: uart4-cfg {
+		uart4-data-pins {
+			pinmux = <PINMUX(PIN_UART2_TX, 5)>,
+				 <PINMUX(PIN_UART2_RX, 5)>;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		uart4-control-pins {
+			pinmux = <PINMUX(PIN_UART2_CTS, 5)>,
+				 <PINMUX(PIN_UART2_RTS, 5)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+};
+
+&dmac {
+	status = "okay";
+};
+
+&emmc {
+	bus-width = <4>;
+	no-1-8-v;
+	cap-mmc-hw-reset;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-0 = <&emmc_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gmac0 {
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-0 = <&i2c4_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+};
+
+&sdhci0 {
+	bus-width = <4>;
+	disable-wp;
+	no-1-8-v;
+	pinctrl-0 = <&sdhci0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhci1 {
+	bus-width = <4>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	no-mmc;
+	no-sd;
+	non-removable;
+	max-frequency = <150000000>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	pinctrl-0 = <&sdhci1_cfg>;
+	pinctrl-names = "default";
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-0 = <&uart4_cfg>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "host";
+	status = "okay";
+};

-- 
2.53.0

