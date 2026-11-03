Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1206606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KkQoySLT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBEPKUsG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDA460848;
	Tue,  3 Nov 2026 13:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Auecv-XkH6xG; Tue,  3 Nov 2026 13:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1496608AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711154;
	b=rBwaSvwQW++FxqBgWiAkb0GshNse07uQHaIFQy9Zr18iFRt3J2+cYQaWPYZhtUaBcQ4g
	 ROTX9CMgFaUAvaJ2+J7LuR4UuDnMqkImiGCFZ5NQaCYFJk977kLM7rtE0jMn/o+soC430
	 Fa5l15l8ISaGulSC6khz+/67f37SBPx3pBUqvjxaXvxRcO/kpSqoGTV2cLgVxg1IqWIvM
	 k8fHy9D7BPN46rqzsO2y9ZZtY+QlHPYp1rf0yA6RjLcTLtqnkSk7F9LYFyBLH458xS4yJ
	 Jeo+LUSzlH/KaMNmoSOcYtqEAFm75kldeTg2f5rO55BXswyA00XGD0rEuxyu9CKJROA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ySBU0ZvdnCW4N3auj4fbANpvjCyq3AGjsPx/U/TdNA8=;
	b=dYWq4abjuIeWDtnqMjONENMyINza5bZT7CrqKdThoAY7nnK9tf9/cIMctoecC5HBtbYd
	 ZlN1s8OO/XXgcJF7zO0caPfhHpioSLd+lWVOpCHmaM72a22aGYxITkMvwKrVzF7vunfLw
	 4PGdGUm0FTUtfiGtGW1bl8tA0AKl2CAPpx+vhpKtI2GBlmfaN7TDWtn08B/Yz6GFZfXTp
	 ZUe+FV8JMhDkwJtV8xDnKFLqh0isHigsOHAjQy3Z0sqeQyBuzPAsoQ8zoH/yNdoXJEevD
	 On+2vHs1KuzbZVnfzujy8CetIROXeR9IoBVDf8gsoZ3YLEqB7hwgK2w2FKtbqg2r65Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711154;
	bh=ySBU0ZvdnCW4N3auj4fbANpvjCyq3AGjsPx/U/TdNA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KkQoySLTlnnahK850bhMAfaiBCF7H6SK4IgznN1eA03zWg7ZlUnSyFtp1QOWuhCN4
	 //zyYLttdA94Y7texWMFz9sHCJwPay3FXv22ag/Pbtjnid7k5v4xAhz0lDAs4d0/Vj
	 7oJFrvL/3gbmfH1OK3tBcpPb7tknNpmD7nEJ1U4wGcuN0Zmkef2YqmmaHYrZeRoNHR
	 8aPcGxyjdvocGJ8yBqyNsoHUxhh2hRdSCC862WEbAUGN3X1j1jvOCD3nfl/5BS8xN3
	 PmgXs/cK5n7W/VhVtMqmMVB2NmiW1xMCm7MkPntVDI185kP8B1t+EMl9Z1RP3KoBci
	 K2jYrpSXMve/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1496608AA;
	Tue,  3 Nov 2026 13:05:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 806562AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E4324005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDZwpOJ9g-nx for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7F36F400B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=S73F+/BW1W9ea3kXICwTROb6cYdG8Paayx3XAF7RcK1UENgobPVh5Q+TYycui4ROfb5R
 SF6bQfmLs2x4Ac72/Yyncaw4TdBXKdr8yEcLEnz4JjDt69a88Wx2vLfka95kbM07DNWNQ
 PFicKJ2DuJ1Spwx8zl1Efmb2qaoXtlkrlfaVazwyOFlctppGD/manO1ovkwEvoLga+PRJ
 WpYHn2FZjUUTUGrjGH+S4zb3PWfj0BovX6FQvErHI+AkmKY1RyNGv2cZxp74ZftPbYuXZ
 AsHLYu8qcXPYt7+Bb3TWt1b1MGyLrXre8CW67CSJFnHOufEjPgaHEMNDYYM6oOHENnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=ySBU0ZvdnCW4N3auj4fbANpvjCyq3AGjsPx/U/TdNA8=;
 b=UoTj+TRK15dAZLJwCz0ZRtd/MbxRp8fGDMps2PlIKyHdBYxcjvncBikxOD9eTjMwV/wy
 K7bOtsPKmNheuy0oUPfwYZ8A07Q8xrAASVRBff9Jj6HYc9chisFBDUelLippceMoVnDq9
 mzQPIyIg6tAv7+52a0cqkA2DTO6wcPZxwyDYJ7ACx9LvluRg7V9m3D/IfV5WQQ2iC6w7N
 vMw8W+cz0fAHtE0ehDGr3GWtUW+fBrn1sqjzUSasqzEEs5QSj9o04RpwYL6/I2JoGEXw8
 j3gdWbhaQmVv/yxHncuKdlX3L3YHBm8ebwg8M1mXsQ+bITTJk5J9g1IkbLdwlm9OZ8w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VBEPKUsG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VBEPKUsG
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F36F400B1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A09D6057A;
 Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702232;
 b=iV61+Dext9wmUza7KsRU6i8NuXG2cLLlfY9LY+DS/G0QYp1ZjFB8LUzhy2FSxsYtjmzg
 I/BBV50iB7RxAaHZ1CEYFj2n7Z/xRyOJf68wF55wGDdw6L8D7V4jUSHcrqAtzo+3FDY3M
 TXvCOTA6VcqK8MuH5vNVXpHkadeUlXLJR2t4/Y3b2Kl06IWVHa/DWhbAIDXSUeiACJq9l
 dcY59X/OEYjZUqUTwNpf2fPFZX/9BB27/ajd1Pk579a2Abkbai5ePL/0UnV3z9t29lBtW
 XgAtJPf10DHhP8U2qtJOjUlNasCGbPDWmtUSTBEv/3q4F9M/TfjPS1l1GExp47sEHQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702232;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ySBU0ZvdnCW4N3auj4fbANpvjCyq3AGjsPx/U/TdNA8=;
 b=0yqnNGwHLAlEjU3DZ0nwqqSxgtZgPoI2i3RkEgZ9zywHwyzfw7K8CBMLqVU6ME/gonDb
 H2ZVs2mU+UtuFTv+7X2lAeZjHM3yAKzSGZltR2Rkv4cT/rNkdtCETi6qG8rZv/dKMPf0n
 hqZLCOlTyh9bcs9SxXL+QdCegjsFfKUT5SArVUr+nMrQQvIl3T5DdXDgoTUARxq3QaO6T
 9ab+xpLsN9nvo38Od49MdoJgOCPep830YycaLf47j5MTmvmpqLDi6A5TEq0Qm62xyZWai
 ZpfXg+wXFM3yOEUUWK2u57t2HYxCdpO1EfVcw29v0bNYyJWaaWWl29PPbD4r/bZGSJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1651F1F000C1;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702232;
 bh=ySBU0ZvdnCW4N3auj4fbANpvjCyq3AGjsPx/U/TdNA8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=VBEPKUsGCOSU/1Zyla5WsOS4jfHf0hEdrqYC9ZtKmQcATaTZkyG6GG9WzHT9g3OwW
 b29xuJ9mIKjCHQs5trUlsOuph9uEG+0rCJBGvxbp0T/n0JJqsf1fxbxuv2DtRFPgIE
 c8dTd4Lu3uwhnWQlwSDbFXsRUaNu1Pi2YPMYY3NUrPX1AVO44Ha1gET/lq5Ux7uRji
 AtD9qBG+KclZl2vmhtd+pbh9DH8ha8pGvMP2cLPGyr34F5+JSjfZkeIRMWbu7MGr3z
 6MxtA4LtSWORLY/d0ULGEhe3a8da28Yo6fOD4f/NxhID9SwiYX+MoUxIUozXK93ItE
 Lq+BJRHvkixNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 04C32468DC;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:10 +0800
Subject: [PATCH v3 5/6] board: rockchip: Add common NanoPi RK3528 board target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-5-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6188;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=HboyIzzulA+TijYJDv463UW209fkjiWrZEUJxID1dl8=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwYHvP+56YFXRc2T0FS3doePtydO/C2ZuuyEp9zPL
 3/aLM7Ed2xnYRDmYpAVU2TplP488cvjC9O/3pyUBTOHlQlkCAMXpwBMJKqAid0zr1l/2sogPqFi
 857KFOPOjQ9O1DnX7Eibys4l2CstwHgl8+OGZT4KWZpPKstsv+lkPYsysmvZ3x03PTC85NCTkoY
 VTByLV9SnSHvLVBWeXn10Eptx6zGewCPzejIl07ZbLHJM/vIltHC5Wr6WtKPU95j8+DsCmxaqX5
 m5uqb4zm3FA73W67MdZgAA
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=5A3AC293DCEEAA41A8A3266A910205A0AEB09D84
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/20261103
 with auth_id=1393
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: 安容 <HystericalDragons@proton.me>

The board variant of the FriendlyElec NanoPi RK3528 family can be
identified using the HW_ID voltage divider on SARADC channel 2.

Add a TARGET_NANOPI_RK3528 board target, based on the Radxa ROCK 2
board target, that reads HW_ID to select the FDT in SPL and to set the
fdtfile env var. This allows one defconfig to support multiple NanoPi
RK3528 board variants.

Move the NanoPi Zero2 to the new board target, it is the only variant
for now.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: 安容 <HystericalDragons@proton.me>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi           |  5 ++
 arch/arm/mach-rockchip/rk3528/Kconfig            |  6 +++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS        |  7 ---
 board/friendlyelec/nanopi-rk3528/Kconfig         | 14 ++++++
 board/friendlyelec/nanopi-rk3528/MAINTAINERS     |  7 +++
 board/friendlyelec/nanopi-rk3528/Makefile        |  3 ++
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c | 59 ++++++++++++++++++++++++
 configs/nanopi-zero2-rk3528_defconfig            |  1 +
 8 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
index 3e2fbd81da1..e8c8dc2f032 100644
--- a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
@@ -2,6 +2,11 @@
 
 #include "rk3528-u-boot.dtsi"
 
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
 &vdd_arm {
 	regulator-init-microvolt = <953000>;
 };
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
index 480ac2942ff..87b65d666e9 100644
--- a/arch/arm/mach-rockchip/rk3528/Kconfig
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -1,5 +1,10 @@
 if ROCKCHIP_RK3528
 
+config TARGET_NANOPI_RK3528
+	bool "FriendlyElec NanoPi Zero2"
+	help
+	  FriendlyElec NanoPi Zero2 single board computer with a RK3528A SoC.
+
 config TARGET_RADXA_ROCK_2_RK3528
 	bool "Radxa ROCK 2A/2F"
 	help
@@ -14,6 +19,7 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3528"
 
+source "board/friendlyelec/nanopi-rk3528/Kconfig"
 source "board/radxa/rock-2-rk3528/Kconfig"
 
 config SYS_CONFIG_NAME
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index d1810fb0528..e56108d67cb 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -10,13 +10,6 @@ S:	Maintained
 F:	arch/arm/dts/rk3528-hinlink-h28k*
 F:	configs/hinlink-h28k-rk3528_defconfig
 
-NANOPI-ZERO2-RK3528
-M:	Jonas Karlman <jonas@kwiboo.se>
-S:	Maintained
-F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
-F:	arch/arm/dts/rk3528-nanopi-zero2*
-F:	configs/nanopi-zero2-rk3528_defconfig
-
 RADXA-E20C
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/board/friendlyelec/nanopi-rk3528/Kconfig b/board/friendlyelec/nanopi-rk3528/Kconfig
new file mode 100644
index 00000000000..94b15b06691
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/Kconfig
@@ -0,0 +1,14 @@
+if TARGET_NANOPI_RK3528
+
+config SYS_BOARD
+	default "nanopi-rk3528"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ADC
+	select SPL_ADC
+
+endif
diff --git a/board/friendlyelec/nanopi-rk3528/MAINTAINERS b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
new file mode 100644
index 00000000000..67f14661087
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
@@ -0,0 +1,7 @@
+NANOPI-RK3528
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/friendlyelec/nanopi-rk3528
+F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
+F:	arch/arm/dts/rk3528-nanopi-zero2*
+F:	configs/nanopi-zero2-rk3528_defconfig
diff --git a/board/friendlyelec/nanopi-rk3528/Makefile b/board/friendlyelec/nanopi-rk3528/Makefile
new file mode 100644
index 00000000000..752426dcfdb
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += nanopi-rk3528.o
diff --git a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
new file mode 100644
index 00000000000..86932eab7c7
--- /dev/null
+++ b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <adc.h>
+#include <env.h>
+
+#define HW_ID_CHANNEL	2
+
+struct board_model {
+	unsigned int low;
+	unsigned int high;
+	const char *fdtfile;
+};
+
+/* HW_ID buckets from the FriendlyElec vendor U-Boot hwrev.c */
+static const struct board_model board_models[] = {
+	{  82, 150, "rockchip/rk3528-nanopi-zero2.dtb" },
+};
+
+static const struct board_model *get_board_model(void)
+{
+	unsigned int val;
+	int i, ret;
+
+	ret = adc_channel_single_shot("adc@ffae0000", HW_ID_CHANNEL, &val);
+	if (ret)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
+		unsigned int min = board_models[i].low;
+		unsigned int max = board_models[i].high;
+
+		if (min <= val && val <= max)
+			return &board_models[i];
+	}
+
+	return NULL;
+}
+
+int rk_board_late_init(void)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model)
+		env_set("fdtfile", model->fdtfile);
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model && !strcmp(name, model->fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index 2c725380ef4..dde9134112f 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
 CONFIG_ROCKCHIP_RK3528=y
+CONFIG_TARGET_NANOPI_RK3528=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000

-- 
2.56.0


