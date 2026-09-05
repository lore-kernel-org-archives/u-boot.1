Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0A5C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57DD340BF1;
	Sat,  5 Sep 2026 09:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eraaGZWcJeXT; Sat,  5 Sep 2026 09:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 35F6240BAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599649;
	b=Q6VzS/eOMJYSLP860IYIh6LScneYiTzWIh1UhhOvNgGOpKPIZzxXSQ3ZniY0f60uXPHS
	 eJQLNbcc6QgGXEmD0gdydjAraW3KD/oJNygXQe5pZ4lF5iWba31Hjo6x0E42Wdb/eP7WJ
	 7oOEfVpHcOFsJ3lQFIoF44JSZv1N3jJFMM5RsWKp01N92aXo3FyCxqo6NfOWlMfFvy6ah
	 Y8c9R4FdUwayQ+aN55zqWEfx8k9VsZxDQ1HG147Bq8sEgzegfMtNKZE2BlcT5ZXpPKePm
	 ih6X2/zGOiVBcprgNyeJxGOg1KobJbQPtBoAML72NWyXWZ5BOiGy3FiaeQOtELTy4Jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
	b=YpB/obLYuwVUtEuCnatAdL/mGp78iy1DLWMEuEPrxuRUGWwrTPACzrQamLqH0pluDtx4
	 jS0+W/qeJDJjWgh9HCTALVrodDG5pSh6qp3nhfngXTUQR5+p8+B5beyx5pfJ+xHmj11Ez
	 r+K4+IPfJ488dww1OMQG+Ovs4m9iy5Zj8BK088knt5a3DlsRAwm1/9u46Dck0ZKbTK1lL
	 plbIh89cY5XT5/SR4COljgXlDnykSFqtzN2gERU/qc6lux3LdXRd06TmjYT1d6+jNONWa
	 KzNYXU+Ree60VqLTZZHF5UDZ1bObjQxWcL6NKhd6U2sd00FVfNq4AlPpXt1Okihj6Iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LVXPKG5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599649;
	bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zz9EwkJKZiFeGRamrT0+KCMQ/xRRf2yALtc+ZuI51wImPd7+bNc44MrJfT6OQCalP
	 DdESYJYq1sX+qqLT65N2tUYNYTeLi0aPAaiTgpyQ2D8bcw0xKBlxRQ2BS+RFZ6e7Z+
	 XNuVgk75/o1W6/tcL1q2BkPQY4eAleKsXTZh2OI4QLb0rxKlNe35CkIB1AfNFMdHA1
	 KVlgpgg5wTeX3TpSS+W7CH2wiYoKZ6lHZ9UJhgGeXnLS3OpocH/H+pe0NA7uK9neCZ
	 9IGtDaduDnehxffsrMmOi/294BPqsrXAdyaiTvmuRCMgahr1chneIhiBW/36ZSow4f
	 sGwTaIRerQEOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35F6240BAB;
	Sat,  5 Sep 2026 09:14:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A9AEB88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3074A40BAB
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKOEwVqQkMoF for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 386E840B9B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599646;
 b=qM2pVV8SpfcXV7AO7zpdsWVKRR//fz+ZM4F/einzX3z+h8e76fTfeHDMhAXwehtq6Btt
 DZZDUM7c6qW33VqYGrpwmQUrikny38K2n7IMXFJvb3g4b50ywBA1f3rMNJPRSeyTnDsQI
 kL7dZ+anJXwXEoSTRo/3daibKKL46NAEyfGHCZfz7Nuxz6l3WPtli+b28k7wEJkv6F93B
 D+p7SJkZ9+hbcm4mjgAutwlcv3Z6iNe9n6lIpXM6w2lwZEaCHNQ4A+5pEoPbAWyev2TsW
 CF73QtifDMZImY49KJcJ4F/pScmnJBSJHfM+n1IIFKCL5fTinuxz7G0qu1czqz3yAlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=cvnlKwie3K8wZF1is8Pxw9G3vC6evbunWeaYSjjtMfQZpfFELdV+9SBYb+Z2f/vq7NcK
 R28bEdAv1JYjJlXwt459xH4Hc9uk45OujxMROKRT7PiNSxfmW8hcpX1GK2A6ycdYWLEME
 r73HfkYJEmV92niRiYJcPQAkx5tBlnl0QQ+s/ApyDK/0T+uXD21EaQMMqLt+uKTHw1gZ1
 8JbyUAEYDtefc7kjQsW/LTFpIDNEtY07+dVcPkEoOg3VfXDmx7vmlEyzQ2iEA/L3wvCa+
 5b8Gj7UD90ZPf+xXhJ0dGPXUaQ2XAda/wlrcPFdkzY4B6aXkcMu9Gt/DjQBPgXwdwJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LVXPKG5o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LVXPKG5o
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 386E840B9B
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:05 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso2133124a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599645; x=1789204445;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=LVXPKG5oql7OV5XIhkuwpHhe8GQF55sLCB0FGYHFV742XhembphOfj4tEae5F0O9mD
 s4qVv/RbpTJYU5K/EdtZ2dm470gKbHLTmkHJCZt8ItOA/OHzt0xFMVjBnGut8XjlVghL
 bb6Y/2zU+Ii4i7YD2IAP46Naa9HZ7A7KZ9dx+KXhv5/mZwcXf6ICDCEUHxOVCNNDPQaZ
 n35Tqfe7iBaXH1vKeRvEZddOFazbbDNLcUwGbMKHtCEbFUaxUVod/pX6zJAx3JFH8uwK
 qSwDanL5QwZaeLA7hy/b6YS5S5xioqMpOFxErkp9UME2wzihe+odxXAMQEeMX579Cbw5
 G8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599645; x=1789204445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=Gh2BNu5PGprNFESY9IYoSNVSCSGZLoIzpl/AV5L6dUWTp5AGfb+YJ24BRcYQPiAQei
 8RBuHO5JO/pK72U0EBzJ6XTIPH7r3CADKCu7+BkkGVJIbwin/bwEGotV6DmJgCp4xY+z
 S6qT+TUzPigiQPMIVvBOeVEpZf+XxH81rUrg5Vm+tdgo1epGdkEJbB77u1snA+awn88X
 7+0Z1Hrl/7EQpOKWNou1Tdz6qPwVyhhXRnDXuBGGaqf2i1VBhffAPRb+3dO9AngXwA96
 9lXQ6rUjTlYioYDwWpp/GZfh5j7e/Ma5EiqpkPh4IWi/iypkPyfF4W91csSQsvgG6QY9
 zvNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBdxDdJcTetBbE3TBLXXoGHA3yLEhFwWsWMEGwsq+B1kdmtM4iRRXQ1LpYmEwWRok71yKEcqA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ni7Abq3LS7nRII7WGAuQgLApe1RvRLhEaXYc4lkTjCL0RWUvxT
 ZpQrXINQwORwGhN4ia+BAuIPMWAyjlc2RH/J50mxUQczcy6afYrVs2LlraxgeXPZeWg=
X-Gm-Gg: AYBFou156pZozeSNOFyGmFmh7y1mBa9uWCyETxvbO+mPJFqElc5+i4Sq2FxTYBHa12F
 mOFKlJ5UQz/7SuOIXRPjQORH2asrmb6EDV4A9T7mMyzBUqB045U3wCy7ungzwGVOkqSy4rmsbQP
 Vzh2zWblpow5Sne6ouwlQ2jHDljRUD5u77HAlm4QWD5xGx0Fb8/A3yipu7XCGugo8cXbs+WZ38a
 Iciw+lTvgoPyxJC2b80Cy8vn9IQ8OkApxDLBvIjv8ouCo5/jDDdbsoxffJrqJ/MafU9LpRuyUE5
 A7IJN5nqy3KEhC9lAdIM0Q+jSV9lC4bpD7/XN3N0IrKSKJhGLQ2uqnN4mBPuBWUaSMVOSrPIIau
 5Qfy1F51y+VtEtMDRkvYHXfl5Bmn8o/+XxA2jsOVdgiawojZEFTjqxXpBNPdpb5g7KtUO5TK6/K
 WKgLY17rpWWaxc/s2Ft0mfT9EQuFSn4wQuKIT85/tZcvAvI7McZ7UW90UNuJMZ/d6XeOfOan/qV
 PCLz+wqn7oNNHoLKfaqa3Jp5RDd8/RUyHcAYEDke9X/MH8AzO29l1nAE9rMPnAjY2IgByZJGGet
 gKAcG744jo90LpTsRcWcWc05eOsaZmVyVr2s
X-Received: by 2002:a17:90b:394a:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39b2613150amr15287078a91.6.1788599645216; 
 Sat, 05 Sep 2026 02:14:05 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:04 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:17 +0800
Subject: [PATCH v11 04/17] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-4-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Anand Moon <linux.amoon@gmail.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.15.2
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

From: Iker Pedrosa <ikerpedrosam@gmail.com>

Add SD card controller infrastructure for SpacemiT K1 SoC with complete
pinctrl support for both standard and UHS modes.

- Add sdhci0 controller definition with clocks, resets and interrupts
- Add mmc1_cfg pinctrl for 3.3V standard SD operation
- Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
- Configure appropriate drive strength and power-source properties

This provides complete SD card infrastructure that K1-based boards can
enable.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Link: https://patch.msgid.link/20260515-orangepi-sd-card-uhs-v10-1-094af27e310d@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 2d77e577109967ef65f269c1fc1d6a659d4260fb ]

(cherry picked from commit 785af36511c3d3664204be1427c5cade3ce9765d)
---
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi | 40 +++++++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1.dtsi         | 13 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
index 34d88334e95e..4e9a62d0e85b 100644
--- a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
@@ -590,4 +590,44 @@
 			power-source = <3300>;
 		};
 	};
+
+	mmc1_cfg: mmc1-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
+
+	mmc1_uhs_cfg: mmc1-uhs-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+	};
 };
diff --git a/dts/upstream/src/riscv/spacemit/k1.dtsi b/dts/upstream/src/riscv/spacemit/k1.dtsi
index f8747190d2e1..acb608ee7b53 100644
--- a/dts/upstream/src/riscv/spacemit/k1.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1.dtsi
@@ -1214,6 +1214,19 @@
 				status = "disabled";
 			};
 
+			sdhci0: mmc@d4280000 {
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4280000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH0>;
+				clock-names = "core", "io";
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH0>;
+				reset-names = "axi", "sdh";
+				interrupts = <99>;
+				status = "disabled";
+			};
+
 			emmc: mmc@d4281000 {
 				compatible = "spacemit,k1-sdhci";
 				reg = <0x0 0xd4281000 0x0 0x200>;

-- 
2.51.0

