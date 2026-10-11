Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693C1CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A3DF60629;
	Sun, 11 Oct 2026 20:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqKGYiyNCPPK; Sun, 11 Oct 2026 20:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 679E46067C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749590;
	b=iOknwk4I0s34HHsF1A9aoyy++ogi3PvHBqy1QlcRmSrC/cXvyOmZ8//Ogkg8DMmu+K18
	 K0B9/eUAlKofm7hZJVFEzC+x4ExA6xnlnpzahgYW1SuodVDIArNUg2kfbRfM+wjUb9Jzr
	 JxJuuRLRfVaz5TvGYFmmD7CUYJXd9txZneX8mRB+3rCvw0uI5X2VcrjSR5d8bpLWqPcmt
	 s5X8SLcnxYzQ3C0kBJ/axog4yKizoqxsaziqeesYjqyKi/iH9j69a7r993qalJo+dGJpY
	 ACRQdh7pMRDPVS3AYpbv3L9ZYjnYDJebx+UTfYEP/lnetsXcPgbdveHTRQE55HTg4+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Fr5oNX4XxZTHmg00qYdxSmOjqqoA9iuAVHk0aVQ9kzA=;
	b=bIsuQwTqZuUbIMR5HCgkQnSMwFRjn3zkTnIE1T8bWGkasGh19WBqeiHzBRAY6Iyg4eUT
	 Qk9XT61KR0cennUVy49tI4MuOuogmcMKrt6eSA03bUevZmhZjo4LdJtCa8vyPmhgKtTQ5
	 gFkKrotQxbBbIKpekoQISudtjISRi+S6EsoKDzIBWgHL+qe3eyeaSB7S2MpCeMKdmxy44
	 GNrVbvXnRtBqWZN3Zm4Lnvujd+eNZgxGNNs6teKdXMbX6LdyGBIebb/OhK9zhL5Rgau1d
	 cm005qiIY2H4FvUYP8iDN1CdJ3uT/+oYjkhQ0aI31ZSMwL0BKVeTKDETKhGOXqV9t6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XmaiVPZN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749590;
	bh=Fr5oNX4XxZTHmg00qYdxSmOjqqoA9iuAVHk0aVQ9kzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ueZTzuaz+9TkSkc9Fw6g0Nk3VwAHlxKS06IldwoA7PUSDtJJN3XtwjF5n0z3ypVsu
	 oqK34HZVqd5K0xT7risFe0NFOqFdIwDMmBQOIXfz0T4TNmburPecZib3onwO3J2B7I
	 YX2xkgD1mA+13gGA102/hKzAOWdCVbUicZAuSDoxnAjrw1L9pIXX9jUJfAdCEzcmzk
	 Gi41KzNCPryhIuuHiaG4Wgp5JZMKinJIAVLTDIk3goxQ0fki0vT0TJ9Qg6YyHy5nT6
	 AD6fd9togmA4wRNGDAuQREhocOQgN8jH2wEXUZINhVMSVc1VJB8llzo6UqcmUaBv6t
	 5s5tzqQC3PiXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 679E46067C;
	Sun, 11 Oct 2026 20:13:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10E272E0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAC746061E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0LPrW_1ALas for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 359D96060E
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747352;
 b=oMbCmgdxcKS6+Uo7sUyYpXeCWnFEByENe3XMXx82kx3EBkXC95f+pfGZ2noBucKCJL13
 yA4EQmK8RJbh05i2KwXaBcYByEOyws5VurEQctYOtVEMXpEq0Qb8LrgHjqR22yGl1uZjL
 hhZaBPCxctwHjeAjhFzYgyqrY+SAJcIp31RYt9wMluxyMhqRpO5IwCBjaXq7sqHgchBDG
 4xXfLct6I5a+Ot7NYR3wCtfvaygVbgUgqvpA9p3gSdgt9+26OnmnWboQbjUMYyv/RwJdr
 qjzGTuAtWaGJyyVtnSh8716kBD3vyp9FKkol4dgKu3XBEVMPzs660G1nxjggR+G+3QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747352;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=Fr5oNX4XxZTHmg00qYdxSmOjqqoA9iuAVHk0aVQ9kzA=;
 b=Z9n5yPvchxEgeSY3gqfOW6m8BAuAsP2qdl/uoTiI22A/9HkP8h6ZWmCDfuoxordR2784
 p/6HO+P/jzYzWtsrRu+Lb1A62xV9653OhCpiEZJxn7IsPk84zImhOqdZsEO4QuJQuEowF
 6YtrBw/8r+Ri+tPXXfLFK2jtfX+T9TkHAhNkGTCv5bPA9ppOpg95uLvDKPqW8WQ8AoGBL
 LWfR0O6VUHUbEyhItTLACyiCegJnX5j2/fNj8GZooBQcLgyki1z/JCngnpWQ0r7dyGnLo
 Padb8k1Bfc9JQbB3nqJiibBCBzRUcvdWDAHyuJN1tQV0ChZHbO4pALHZIWZXuK2aV5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XmaiVPZN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=XmaiVPZN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 359D96060E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B136343FA0;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95A8FC2BD00;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=9ebw4andO9ZZQ8eq3UGYeLArTbMigX/iPi8vgZMyGfo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=XmaiVPZN43k22t6tSbiGuY7ifTmYJSKyMkEB5Q6yPBwKNZ0G6iOpcHdrgJvQrOyVR
 tFtWIvcYJHC75CF/QFTTwJrsgCWL3OT6eJtnKeRlLbydHtaQxpvljpZqMwsCHMnFxs
 UoluTMPQ0BCpcyi1RQLEA0/r1CNgLe0mIrOTXZr1bThXn1Rf6ALbmn1PJYon2AqNV1
 bPIQr/5a/urzLIlI+D/vsnM67SWNLDzh+UP5GFMjysGNqCuCsfaVyQSfMdgv7nxc3k
 93J0p6FMvTvwB+d4LOQFP2yCC70y7+ZwPfXxKQ3xywCHH2wTcfCxAvyc+BBBuhyH9v
 WplYEAlkLq+og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 85463CA9EC7;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:49 +0200
Subject: [PATCH v2 7/9] arm: dts: rk3399-pinephone-pro-u-boot: drop VOP
 clock assignments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-7-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=1253;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=gTmDh5AgUAZwjac0+N138NYZiGlNvOgxxIBxbjeW3P4=;
 b=cW8cg1KBub+iU0XYrXW8LrrGPRl+pipEcJhVmZ3KPtGsn/cXlX6pV/+oWDnFllmT2q4rHD1UL
 I0maXnpns5SC7CQJLXD846k4G8zvxlc0QoHngYIzdqmJKwrQ9UjBIqo
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The RK3399 clock driver cannot handle DCLK_VOP0_DIV, ACLK_VOP0 and
HCLK_VOP0 parents through clk_set_defaults(). Therefore probing the VOP
fails with -ENOENT.

Delete the assigned-clock properties on both VOPs and disable vopb.
Only vopl drives the panel and the driver shares a single PLL between
the two VOPs anyway.

Based on megi's fd095c54eee ("rockchip: rk3399: DTS video output/menu
support on Pinephone Pro"), https://codeberg.org/megi/u-boot

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index 2825d43a9d8..a3a8610d56f 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -41,3 +41,15 @@
 	status = "okay";
 };
 
+&vopb {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+	status = "disabled";
+};
+
+&vopl {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};

-- 
2.55.0


