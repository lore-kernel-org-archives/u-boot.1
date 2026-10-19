Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EDFCCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 01:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4881480F7A;
	Mon, 19 Oct 2026 01:41:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9veUeagVWNG4; Mon, 19 Oct 2026 01:41:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C50380EC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792374102;
	b=eBSr0DYWEdLjVXaHgLBVuZpsP1dSnqJ3DrsvqD6ZkuHcEMeXwQ6hR21baVs9lwY0z4jQ
	 dRYaND7j3zz/+gW9LWTCFsuvWiwcGHfrd1aLrtM4KGjO1caG7ka0K0VPYhrI0BGteNvYz
	 WB6iiMnsi7u1EEmPJcU2qZ+56RN573nKve/YFYiKO1gcgxnAIfJnWvRtzUTXtsayIlqNu
	 Ph33Yvr7R2B3BKLSYBQaBoQ0KiLn/lusYRdwy8FviSC7aypw8NDCs9K5hZw5GGR155mAa
	 39yGqQlj6ByjKGG4D4hZfzDFs8R+byhxLpOUegXp1VXyUdVHc3Iuzazbz4id4NJz4ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792374102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iIeCdD5or6QzQJTq3+pFp1Y+7TGNVBEyUiUwcw0jM44=;
	b=lN3WjXGFEYbZBdCJJAuzbFNtYunMFjPaqw0tCw0yy84HhVuH1h/RDZbleva8dQRUW/0/
	 AbvYVREoMzyWGW/yFC44jDjOOljhHbNoeAf8KjK3YajjkfJIX+FLks12vYTJcuQas0jHp
	 I7ly43ZjvXX5jK8hTNkHoiBPcWkETD0x4YJhx2Bt7mbV20P55SH7i6rCenFDflsYpI9WM
	 yzLOhHvQE/0cZ9OtDF73cIPPFtYArkE1cN6GbhxasgxB0+fjm0elUWLAeI2Dj0kzGneCc
	 pdAVjB3wyf4cE+j/4dfbD5nlk1rQsRasizhxLLgIhuunCh4dZbM/I/uDfL9c7kKvqtQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=T6WZiAdw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792374102;
	bh=iIeCdD5or6QzQJTq3+pFp1Y+7TGNVBEyUiUwcw0jM44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfOuAwWdOLw4LMF3IGVmGp1apayp6ZrNxK6mPpXdeM4NDR0/6vX+AG1PmoDJzNrKT
	 4Oavv5iPrd1BZfKT55ej0FAuOOUrdigjJcCf8z3rcyU3ujoko0kVJeUdIzdDE7CsO+
	 +1z4INrLR5Zy+B2j+MknBtKQR+GaceBEGI0LzQeey/qbnjYY9skAOx6ZthKTPwTHA3
	 ZG8q7tpjIrPw+FT7oGcfk2PEiYgZEMxBvce0lgoi3ZSI5hLi+1j2L7T35Z0qYqf6za
	 dIMn88pLf20T/n9/ZNW3/anasmHUMVYrz6WbSPyFBbEKtCKKaidZEVNYPuAC6XEjEu
	 uiE0/3DawtH3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C50380EC7;
	Mon, 19 Oct 2026 01:41:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5053C769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4228980EA2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kA2S5kRGSRtv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 01:41:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB41680EC7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792374100;
 b=lVfPCgFClUr/oPFOFkPznpecyQLeoRKOk88EAYbUrjWgMhpyfi9+r6W9HVkxSu6Ju3ZJ
 jtI8btclVfM0dCfASsseYicznDrH59R6rPH60WetMMaznbAYP7Mkj2uXiQbPKWpZ9e3q0
 L/9wc49zo+IprKNFDXxz/G15l+SmuUmMSA9BBHGFsPOXMJejREBsF0pFXA8CjOlAGLP/O
 spjw8uGRX3H2ItEH/+o0n3XGjx26kEZ1YjRSv+JtbC9hdxJd3RunuFAHqQIFJu0nnjx8/
 2RlqZX3MO4utIeeXiared5bv7LKku3yXU/aDjVe/gRAXszaQaS/tYhej4wfdLlsAP3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792374100;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iIeCdD5or6QzQJTq3+pFp1Y+7TGNVBEyUiUwcw0jM44=;
 b=iEegivqWvN4inQM5lJWwTKqoq8VZIbrZC7sf/4JSPuTKUnsfJYMD1B5iWiFR/PDOY0gP
 CiaiAgX2Dg6d5xPBYP6b1k1HBKWfEeeyPD+nWK09dIANbxK057euP4WFOKQtvmqMnkM9Y
 +AGmIBeMwKXUIOhRyh2ImrrkmDyhKSzTZBhDU9LmR/BC/db5xUGHWHYiGyTQLMakOcKbC
 T7O8UkfoPFnaxADW2lugK/JqxAfm8ts+fI9cmHj++zk1HJSZIKmoUBfMPiD/nHvksj74p
 O0aUjcz5XWWi6WH45Wvo4VDJJjJxgONxSZ1bdbmpJbtrDneEzorPD5bEYJlqRhrMbEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=T6WZiAdw; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=T6WZiAdw
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB41680EC7
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792374071;
 bh=iIeCdD5or6QzQJTq3+pFp1Y+7TGNVBEyUiUwcw0jM44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T6WZiAdwgPWpMEtS0YDP5anbbq13ndPNN+l4nWwVwVchvMEwnfR+q1zb8B+95dJZt
 66NvhPxXl99PVdLB3cdS+4Fvl4ItORon7Nzp3Mr8FA5WvnucecwPgnnW7yRFYXYI82
 uO9ZiGJBqjrB4GEj7lGj8D5fzOc0WDq0ZB2fkQf79lrLmkYGh0SLHca13c1Z74G1ji
 wNFPlHjMuEnE5ZNApVMAcLCAviGK4+gvImZYwV1Fs5XBV+XlHvTAtnciSgzFQPnDeP
 A6l9dvvRlixUsRxuVg/Uw7U57kGoFdZBGH5vx6Hk6vXZY9DQ7MuYRMEaGBcLd574GJ
 OGnnRnDKi3VkQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B47E1B22013A;
 Mon, 19 Oct 2026 03:41:09 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 1/4] riscv: dts: spacemit: enable the i2c2 adapter on K3
 Pico-ITX board
Date: Sun, 18 Oct 2026 18:40:18 -0700
Message-ID: <20261019014044.698294-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019014044.698294-1-e@freeshell.de>
References: <20261019014044.698294-1-e@freeshell.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Aurelien Jarno <aurelien@aurel32.net>

Define I2C2 pinctrl properties, and enable it on the K3 Pico-ITX board.
It will be used by the 24c02 eeprom.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260623204431.498700-3-aurelien@aurel32.net
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 48dd3d020528e05795dfa46308ba5b59a1835bba ]

(cherry picked from commit 5b8d10184a9e7fb8b31d279e09e3673b8d69f690)
---
 dts/upstream/src/riscv/spacemit/k3-pico-itx.dts |  6 ++++++
 dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
index b89c1521e664..dde6028a5ef3 100644
--- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
+++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
@@ -43,6 +43,12 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_1_cfg>;
+	status = "okay";
+};
+
 &i2c8 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c8_cfg>;
diff --git a/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
index 3ee1471f3798..50dc124c097f 100644
--- a/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
@@ -78,6 +78,17 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	i2c2_1_cfg: i2c2-1-cfg {
+		i2c2-1-pins {
+			pinmux = <K3_PADCONF(46, 5)>,	/* i2c2 scl */
+				 <K3_PADCONF(47, 5)>;	/* i2c2 sda */
+
+			bias-pull-up = <0>;
+			drive-strength = <25>;
+		};
+	};
+
 	/omit-if-no-ref/
 	i2c8_cfg: i2c8-cfg {
 		i2c8-pins {
-- 
2.53.0

