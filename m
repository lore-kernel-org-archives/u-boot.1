Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB17CCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 01:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46C260679;
	Mon, 19 Oct 2026 01:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOKn_jlRRaGj; Mon, 19 Oct 2026 01:41:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05B2B60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792374119;
	b=AEgvaKDKH0bBNglVhc+Gk7ni5HGzpVQBo1cN+midfgh+uQJMUE6lDKFhjkF4TOVG3ZoZ
	 QQ7pAbQnwAJ9E2yFm2SnAQ7imtTqxkc5Z2xGMfuZdWXuTQfSGX7aK7ua6k/rlsLXz388g
	 YpkPKkSab2uc5gx1IBde4aKoBpyT2oT4qK8qysmP4NhQdgF1hLpHMzaF7OJTvinA5b/og
	 839rDloaXMQf8UY8SneQPfcXLk6lx2bjUBTd3QBrwbcNVxFjbpiCOhm/lRxPWrP7q5++T
	 Y7a7ZvxHOe3d8fWWvKE8tTZIVa6kQxF34I1loVsAEV7kipZ21nzE06240uRu4hjYrQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792374119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DXvwwNZByMJDTiEfjw4PA7ln3WsM9uUaXZfdOZr0J2Y=;
	b=tZxE5Q8bKwKr/qtlpQMJXeyDedDTE9aZDq1iUaywLjrB69lM6Ole+RSOecdG6zUzrdoa
	 CgQNhgh8c+D4mKOZaSzEg9A5KSqYwSGZAa3y0yYY/dnYloi73/4IrIif48j6BOmrmm62w
	 zICZS5nauM8cLjAHYEh+0P8r9ENzJZBlZ46DyBUYmjZ84dgi2RkUIPPHNRcH84VS9Kyx1
	 iVe0JklWZwUrZ1QetG+Ax1+0cdXhXU9cod4vqHOMUxL04scf47HGTW7EvfnwH6pr22+D8
	 N2aKr0/X+Fs4E2piao8lQeDIQKwbj0yOxDpPMHa5GHlCcKoAYAGy7Qth8SDCFEz9gvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792374119;
	bh=DXvwwNZByMJDTiEfjw4PA7ln3WsM9uUaXZfdOZr0J2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gh4SOl4yKKrhgI6IWylrSZV5gRyId8VLL/IdWug9ZBOUgWrsvXxDOYxDlGQKWGmOv
	 kx1VLQxpKoK0XkVYqp0GZzqL0An+O7RG0jCXW0hNrYCNlzpAJq/nWKc1cgxidsyAi5
	 Qd+SWPbYc3i/OF2JUWO3teSnZ2cLVuqT0TRKW/HOcZMoZuc58TISPu6T2u0iJMsEOj
	 nSskzxPIxbCkuKp4/IeoKP5Ev4Rr611ro6P3CvvnAf262WM3/gwK8+qE/1CLPqxSPa
	 wzAIchD1kzSuKBAfOxvvVI4nIfUSSQvBSTKsC9Wcd+rDoew2fLrKqXY5fR2LvhcZ+3
	 ckY3d1uFPOs0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05B2B60600;
	Mon, 19 Oct 2026 01:41:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DAC41DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F1EE406D2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nq5fLaI0PGYV for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 01:41:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3F1140633
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792374116;
 b=ZJfj469kYVTMRdg5FNhQQxGIYnYOxDvoVVIhBlj04Lw9Wf0375dOYDQDzW2YwTunCBxB
 e6paEkEpmzbKK3U9j5TeTjqUj61qsQxQ3brIgbwyeMG1B1QcFiuxKVrouwjMnVXWV1wp2
 FUTRs8IPUercNpM5zfSh3XBrcvTgvjsf6CBDGn9C/AnbQWF83cfd/Shq6vlYRydr0oMq6
 sam/hK7aumHK+CDO2/5CVUan3QhrscM81VqOUIi7caS8XVAnGKzNrMRE8hTekTpZeZl/c
 RzezF87vS5/HZGNI4CBiSH/uppr9uuYu5qbxcbHj6k6MwILvtzpXBem8UkUKYVWMJJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792374116;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=DXvwwNZByMJDTiEfjw4PA7ln3WsM9uUaXZfdOZr0J2Y=;
 b=jzkTtbORNyBp2Dq56RjdtFAnQOYPW3tXkTXUva53BM1+Zy1ok7VQZYHcsJ17c1RqcBHt
 VGfxoar+rOdQKvDdC73ym0jRlTCNYmTv1YPHgdF6hykXPcIFTqzv9EXQ7xaghX4/7It/n
 1M7MJuVDy2WmA3PjexoHQH3d5rqIbTHTaTSUqoDtT3LG6xJSDcWYF3EVWex32NdjezwKJ
 dKyzMrktTJ+lYrM+hna886QgNi/lHi9wmT+VwCQ0wZS8lu+3jcpATtgB2liVkw3rorkEb
 3qYcnBr7hVCKhuA+obYrlnsdg1cyqkDnq11eTqA6bBGmYgWpJrKMc23O8J/N2oxZTKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=n2TJr1Rk; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=n2TJr1Rk
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3F1140633
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792374076;
 bh=DXvwwNZByMJDTiEfjw4PA7ln3WsM9uUaXZfdOZr0J2Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n2TJr1RkBwNdYwmk5VpzA3R76ywABxHDE19yshCYuoSUIt4bK3+Gy33X67K2INQuk
 zhSAODqE7yq1id1Je4k6mv//bJtsMODd2SwJGQB2MYqc5eFx4L1N+sIyR/yONOXWKB
 rk/GL/jO8MuXxv+VdY+w88AE8FYJ1LLJWe/g+pIUB7YdlvJGiS7HK2ESY+wbKP+FZw
 t4FZiNwN1NnvB/iWBAOz3tUITsPtxPY6nBV9lWbmIl6Q9kqt4ulJ3Kkp43nW3K3CB4
 akejjMGN/KlprQvAEQdL2Ia0XgSVQji8GWJjZxV281Xr2141/w0oI7uMnRD5jGFzsJ
 NEAU6P7pe+oFQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 58ADDB220187;
 Mon, 19 Oct 2026 03:41:15 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 2/4] riscv: dts: spacemit: add 24c02 eeprom on K3 Pico-ITX
 board
Date: Sun, 18 Oct 2026 18:40:19 -0700
Message-ID: <20261019014044.698294-3-e@freeshell.de>
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

The K3 Pico-ITX board includes a 24c02 eeprom, that stores the product
name, the part name, the MAC address of the network interfaces and the
board's serial number. These values are also exposed via an
onie,tlv-layout nvmem layout.

The eeprom is marked as read-only since its contents are not supposed to
be modified.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260623204431.498700-4-aurelien@aurel32.net
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 930491838c55c41317da9f263e3e9b013cb9aaa8 ]

(cherry picked from commit 3146b373c9699a456fa58b56a23d1127096cbc86)
---
 .../src/riscv/spacemit/k3-pico-itx.dts        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
index dde6028a5ef3..143bf6f41260 100644
--- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
+++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
@@ -47,6 +47,36 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_1_cfg>;
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+		read-only;
+		size = <256>;
+		status = "okay";
+
+		nvmem-layout {
+			compatible = "onie,tlv-layout";
+
+			mac-address {
+				#nvmem-cell-cells = <1>;
+			};
+
+			num-macs {
+			};
+
+			part-number {
+			};
+
+			product-name {
+			};
+
+			serial-number {
+			};
+
+		};
+	};
 };
 
 &i2c8 {
-- 
2.53.0

