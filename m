Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469EA606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGsUappu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNr0dG06
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A2584066F;
	Sun,  1 Nov 2026 21:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHJ4YqruLyBS; Sun,  1 Nov 2026 21:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16C9E4067C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567175;
	b=H6rLJxANkBvtMhExpxGA9PmfssXmWLZlPWUsP5DbsBK83iOk1yiZQV36guNL4usipTuq
	 bP17bWZeGpRWYfo7q+Gi0cwohXePo1u8bREqm668VSA8eG4yg7X5pr9P1U78ajxVZq8Ga
	 NfomCBjpDwFW1nV8FDU+HhGFZeXKdnT3G12QRlgI48irEE5fb1IUjm/cYc6slAajQpe0v
	 P9fyItytle6WjDZ211pe9BibFDR1PT8BgBxtTpbWQGi1JG3Jn9L9iV1jabJ02RREV6OL1
	 VY8+XHpJwBekajlNtTKHEGWgvYkJBT6awaWcEu33r9CClwBEQ3Oy0muDSX82NnVdPkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0MLzyjLdV2gu3vOjld8EQEIWKH3ags/GaAsMJzGgiD8=;
	b=CWNLSKocWXWryzuOZnj9/1TiobV+K2W0GdB1sXFL7ArlTuhtJs8Tv94BWPjCkFLFmJ+H
	 Jhp7wMTph7RXwDZdnxZL0uZ4rhqjfSTfw/+l644AiNbrJ3pVFX2ZLXRwDVGJ3IljgyoFQ
	 p9NsVMCREE2CK2Rj0IrRLiU0gkt09cIcuHon6eIANc6/BdGH82gV06VD/i11jUClBvqmt
	 oIdrlbamL3m4rEGouQl/j93kAPiAuYp3+dS21T8A7qNAgYKxXNpNys/FGRdJMFz3tCLva
	 NdUFzgoVG8AyBuG3/VhwX6Ysnow6bTcilrBGn0ORt8z07S4UKF1EYNZHWZdm5KuYJZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567175;
	bh=0MLzyjLdV2gu3vOjld8EQEIWKH3ags/GaAsMJzGgiD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGsUappu7H9c3X5TagT6snEUB9GTftzFesMcOYRM/VvnRrPPXtQT5v1azjvCpGrq5
	 HFDuLUl6aff+2Mb3hyizzvhIyknAfMrsXGSZ5Hm4pwDUZziIx0sDHNMCMa/j6NDLLP
	 FoEs+dhN8CrlizEhkriimmMaieLCDf2ctiS+m4OKEC4G1LnBv8pCXAadwpMB9OvED+
	 nGrtoKjupU24K6xhbptG+WmWYbDos4gV1kf8k74nWN42a3I4WpktqfzGyrGwFPPe77
	 64xYfKjUMix7ijbv/QIoEyn+qMucysyJlscYphzqXInaxonfD6Qi6amo3OEz4ScYNV
	 NXkH0w0BbNc4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16C9E4067C;
	Sun,  1 Nov 2026 21:06:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04F912AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAB9F400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwWxp79LcE2i for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 18:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3205D4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793559306;
 b=VgTW8MKH14fyJDkKGu63BQRUOXxhOEbqqgk7omfaKoY5uieWsL1H5ppkDoCc6ZD7M9c3
 lAn5jrVlkAlgCSmLiwezJPHV3uIRMmepNLuVLZRXjZ/2l4PTHWMlO+/Zj90d1uFnOv1H6
 GpmblLudOct56oqCFlPTxrYFyHkBWwECCmF9530Mi6a72okPexl1Po6FCxZjLbAOdJkZX
 bS3nZYxVLuqLumbV6MBm0gwcVZX9XC/T+rCUR7gLXiW9gGKW/IYnyLBFsOnbzHdckW7fu
 j2QFiuQUWClB/Q2niLlK56Rky487NTBm8s5o/PSaF+D5iv7HzTlHwmWN5ZG8LOOe1lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793559306;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=0MLzyjLdV2gu3vOjld8EQEIWKH3ags/GaAsMJzGgiD8=;
 b=Blwce2MQI6RpXsmN6Q8DEylaVsnkl7JVQnf9stfX07tWiPyvcAsBJzWTXKXqYdG2faeJ
 A7Yt1sUoMMy+H06Rbitzs33W6Rk1m01TBx8hTtbWYp/wHZZscMBkfavWMQvco+B4aRAhT
 2Zts/qWukWwZgYvtU8senCH0PKsFPk3COcfcKoZh5tdjeIPaLYOhaKOk6Vv/djaWrOznK
 ridjaKi9WyLyi4bCVrF+7NOp7YebPmlsPq+qI/ZXFHFDACvMJwy1xNeXAlRfXDzFC59IC
 f2rGDYy5ih6L4g5fNzbMEJ6QGMXzwsjR/G26QjLAn/BRb2qB5DlrUBWEEJvlGdq4AFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=gNr0dG06; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=asai.6265@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gNr0dG06
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3205D4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:05 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so3350121eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793559305; x=1794164105;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0MLzyjLdV2gu3vOjld8EQEIWKH3ags/GaAsMJzGgiD8=;
 b=gNr0dG061yNV0akJWeFKhkzINAubeEH8YuNzdVQa99Li6SeIMSq+4G8ya6QGgnVLtb
 Q1hH2W2+KH7h1UK3DRq+ckJ93eP//jGVkAi+JmmNKI1oWvP1V29scAJBpt6zC0k1smjD
 7vwQgw6VBH+yEhLWCDb0Mos6K2ukI+eCSqxFLf/2+wh4IqUW9cHIIvS9nkhm0icTP5BG
 Obm/g/+kR7TlA5FFzIMYjhrkThv3Av213W1kfUPeLNtX5yiQV9UDTmE62770+XkWjBUq
 Z+afw2IPQ64n9L6gwyetwweri7dWVid355ccHJhoa306PkDn8XkzHTQmsB9nCoOyf79m
 IoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793559305; x=1794164105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0MLzyjLdV2gu3vOjld8EQEIWKH3ags/GaAsMJzGgiD8=;
 b=xeu2skXZPFBs+n7Wzh+2k8bCZ3YuWgsX8soVuHrQPxVhSv4cFGmXbwk21pXsiOVPL5
 U46jcVxZx8lUdw172l2yZMh1VzwiguPu+zzGiTnz6ue5Uu6DnYtUrWivSD6LkwckfdUT
 tChHO7HCTLF1AcmN+OQ6XJQjgnG9UsaZvvSwNBmOhIz/vHiYuPnTidFi9KFSGmKgAzHm
 TC9IIKov9MG6h+VFeflxD1Pb+2wJuyf45DP1hKNq9HIi8DSstXrQFDQqRqWB36eIbmnI
 4GsK6eDhJXRbdz0lZ16Tixxv6ZhHVzN8BvBfwlBCsL6s+HZ8DlpvSf+P2/S5gYkA+Zfs
 NG3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpzol1vaaCEc9N7a1IGl2S+FCD/IhpsvGn7EIBWzvS5crJSM7n8qwfdOKwq+JnWghYkM1LBO8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9nkva9HxT3nbhiR7yox69Yz9ECwkrLOvKNfGXU73+7IJGKJ53O
 UN9I0mwycSq8K8kUqyDPhcbupZmJbvPu6zfKOfhqc7VlDKGj97N+/cLa1BIOEhNm6es=
X-Gm-Gg: AYBFou1rfRDgTllMfzZsTXk7K+Y1olWOhVuinidQDkSAKpgFrBaqhphOZTGy83dxo1k
 lIe5DOpGa8grFoaufqXB75lj3YJJWpSKIYZZYazuFv3qq4ZPQwcY08wg7YXsC0SdRGc+7mG8O6d
 273HrR2p1UFr9nYf7tkj+fWCQ3vjFKAgosl6S5EwlMZstYbs4KOpZ28R/Kr+un5DnswodEBIkuW
 2iv4LpJKi14d1SQNmROmjSwzy+vyAw5aXhkMFwxmKBwX0D7yBrOCPCz03xlT94qvgC2g2ThcmS9
 JeyRdcpICwQB+T0bvVTXMJMn52/GMa8Ci6ZPfVA0mpjwWObWyDu6zzExrMVRfXTO2b5EwJdkr26
 TYzaBXAbWDclk9Qe/r+vayxu9YfzPgKDPGJSCQ5jzUjY1lulcT3Shs38btuBnQnWayPxBBtInRp
 LSZOse1Fz4aAFJtwP+IbxVQaLi/0DP+ZJC0pjJo0+EhJ1mTa+cfNiMZryTREcHvCyBjFFSIzb9S
 ehn86WlddnJ+HtPW62mXdYBKhHzcLWuULYwiJwvZz2tex5vytqLFtF/PYjV/Q7SK7KNGGeyip2e
 l2WBLPRyCcnbzes/l0z88yHN2K5hoZIuCzuqPBaVZl+YVeYkYqTeYyJQkYRa8g==
X-Received: by 2002:a05:693c:638e:20b0:369:ef63:ea95 with SMTP id
 5a478bee46e88-36a423624c8mr12080390eec.6.1793559304599; 
 Sun, 01 Nov 2026 10:55:04 -0800 (PST)
Received: from X870E-AORUS-MASTER.kkp-group.com
 ([2400:4053:d960:1a00:6c8d:b67c:1d31:546e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6f7f9sm34800309eec.25.2026.11.01.10.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:55:04 -0800 (PST)
From: Shigeaki Asai <asai.6265@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [RESEND PATCH 1/2] ram: rk3399: Use the maximum LPDDR4 tRFCab as the
 default
Date: Mon,  2 Nov 2026 03:54:40 +0900
Message-ID: <20261101185441.755448-2-asai.6265@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101185441.755448-1-asai.6265@gmail.com>
References: <20261101185441.755448-1-asai.6265@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 21:06:10 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shigeaki Asai <y-asai.0816@docomonet.jp>

Some ROCK 4C+ boards fail to boot with mainline U-Boot (SPL does not
start), depending on the DRAM fitted.

rk3399-sdram-lpddr4-100.dtsi sets tRFCab to 180ns regardless of the
DRAM density. JEDEC defines the minimum tRFCab per density: 180ns is
sufficient only for 4Gb per channel or less. 8Gb per channel requires
280ns, and 16Gb per channel requires 380ns.

Set the default to 380ns, the largest JEDEC value, so that all
densities are within spec. This is longer than necessary for smaller
devices; a follow-up patch selects the value from MR8.

Tested on ROCK 4C+ (MT53E512M32D2NP, 8Gb per channel), which boots
with this patch alone.

This patch was written with the help of Claude (claude-opus-5-5).

Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
---
 arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi b/arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi
index f0c478d189e..92677ec36cf 100644
--- a/arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi
+++ b/arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi
@@ -94,9 +94,9 @@
 		0x00041109
 		0x00000000
 		0x03010000
-		0x06100048
-		0x0c280090
-		0x00bb0009
+		0x06100098
+		0x0c280130
+		0x00bb0013
 		0x00000000
 		0x00060005
 		0x000a0005
@@ -105,10 +105,10 @@
 		0x030a0000
 		0x0c000002
 		0x00000103
-		0x0005030a
-		0x00060037
-		0x0005006e
-		0x05050007
+		0x009b030a
+		0x0136009b
+		0x00140136
+		0x05050014
 		0x03030605
 		0x06050301
 		0x06030c05
@@ -424,9 +424,9 @@
 		0x080c0004
 		0x00061c00
 		0x00000214
-		0x00bb0009
-		0x0c280090
-		0x06100048
+		0x00bb0013
+		0x0c280130
+		0x06100098
 		0x00000500
 		0x00000000
 		0x00000000
-- 
2.43.0

