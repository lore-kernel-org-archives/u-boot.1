Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88B606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ufDd2/Gf;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzs90HR2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A0F811F2;
	Tue,  3 Nov 2026 13:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUo8aYNGUC2C; Tue,  3 Nov 2026 13:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42830811F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711146;
	b=TkPFLLkd7OCqT3zEgvHd65HU8TzQp7sVV8ubi5BtW7kbkuhQayJ5y4JycaV7B3GeGToW
	 TjbsjYlEWYiqE4AgS9syooT7hv7g2EEbYSHbXvpDxKkVSse/Aph57K2yKJVJcj6cQkwvE
	 NfZhJCGEciTg+s55y90LvQWofsPnnhYntN8M7LnEvd5pjv3Um6AshDcvo6B7whk3yoqDN
	 kUgYl7dltOWoJ0C+fRBeel9td2ni3O19/0dsvdaU5CHIuFMEX/K8W+vFEcHIuUyhT69Nv
	 +6k97h7u/j4lmXe//wpdesG5SOecZ95jPNAZIJiF7P0ENhwwLIYcG13RYwomEpgnDBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mDjn3MIoKetH7rUTWWxR6trpSuYWgIiSpgXajSxcel0=;
	b=BgXYJuHBfP4/H5nBTn2R7MiG1OLxsAiJcDAbnbEts7SSedYG9ow4pfrfXRbnDEW/4fVj
	 qNRwKm3CMCiLv/VsAvZ1euWmviMaoUTzN5FBOuRKKQdTc+gwPUJKkgpx1YVRF8tS8egTe
	 Y+eyrNVwPbxSqZ6tLUa2f+bowtH2qVE75qqsnk2qmms9UDWGaVxqRJLTpXb6yeNFWWZqy
	 nnDzlypfWW7TD/l+eNwIdSeV1ScW5/4rlxUQ+xmWxDNAKoLal+ttoP2cejpfvsgHFt1i6
	 92bza5KLJ3Rnwtc7+AGQPmtrhE6J1U9mgj5EjyQFCYSyHnVvPXvGtK3Sw1oyfMvVWLA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711146;
	bh=mDjn3MIoKetH7rUTWWxR6trpSuYWgIiSpgXajSxcel0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ufDd2/GfnnayF/Bo930b4sNtsrFYtijG6vvRUBYEGn89XXCbjm0zo5c3vTCQp/sry
	 HKsMbWDxAeXkl+mssv1j+NpZgZ3bVcx+G3nDD8k6aXkIlHMMYMdu04fuXTBC3S7Md4
	 F7pcFTAKoWxsh/h9evL6hxtJ4ZRfBxOvagzXREtAPwgmdVy+M0DY8g7oYDMh6055FK
	 gQGFbq6jYcEHEqQH2yRNtJ4lSSELfxsnbpIg1jHhGmnQMTZ7ge880XCREbStfv8tDv
	 9QKN4MjpL/dYDKvCGCQxlQPB6Z8RmbMeAHbXi/I/EiAy142BReMvAsHoQw/mWlxO61
	 d89yMeE7lOfPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42830811F1;
	Tue,  3 Nov 2026 13:05:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1D17356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E35A3606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGUB3MJJMcm8 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D069260611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=CQQkRd8NKJC1XHWzz0QDIQIVUV0bMPPTYbgXqQqtAvVvBchFPNRVlEqfrqxfCCuFWGXx
 tMH2OCN6sP7V7blWeutECzJme2ds1/50ED5pkCEVIojzQL3zyYol+JQLsmBWDx+f0C6Bt
 L7HeqaNOTrnCc7WpdNcNwyGC1M9YuHNEq2ivgt07V7+7hGVWYqqJ6su5m16DjtLLHq7gd
 HQ8FnSp1EcWIG0u1uEzcNisuERhQPvgZAXq84C2nmW5+uXCSa6W5eznnBSV9J0qMLlyyw
 qbOInbGL/gasH4gUrWKY6JyluF1vqkr7NgwqAn/qVHudzyW5ULlyHy/0kjl8DiiYmPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=mDjn3MIoKetH7rUTWWxR6trpSuYWgIiSpgXajSxcel0=;
 b=mW+Cw26ZrnDxNObA5SJO+ROzfzKExFReO+/4y++bAtiNUQO5uCXUAEPrcJIjEVa9Vcbp
 10/9TEzxWQytMYP1I7GXTqOBPDuM+/hXUG8/eYHfBI2SJ9/+187a8s5NXvtMKEXx7MRDY
 lxeJDm/VnpXyPZUA4NK0u/EpO+D9THb4NYOMtO+xUNPnbJ6+HXQ9vBvAtR3b+54pJLA2f
 Upv5hd3yy+ZWkdj3Pi4UJkFECkTgl5LWUebyaZbCbZ69hnRk+L3RwtZNh2vHzJ3hlzX6X
 skxrGFCDMrE3m2FutAAdbuWRqKbzPIwOuQRO9LQvTq7F5YsxKqJ5RIU9I/kcYbnbD2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hzs90HR2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hzs90HR2
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D069260611
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C88EB60098;
 Tue,  3 Nov 2026 10:37:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702230;
 b=lZgKOqxFgHer8LMw/QinhTXufxA3Wkl9jvfUOOYHaD/fb572emP7mWWsMeEAKAi3jmMC
 nmaSblMltBp+FW+rIYu2nlR/SNYDit9UNxHO2cjWfZfqmwmqTrXtj5ymbDT2FiS53VW0n
 BwxXIUD17BGQHBuhY/374qij1Ul6sDGzVSzcYjs4gm3DGD0XDlKZYkUj281PymIgrd/hf
 9tX6xbfUZekrTWseUD/M5vBn01cJsgQ7/dqeg7Iyjs4P2UnPGbuinw1NoCDlsV+gEOluA
 6+Eb6+7IIpT1ynZrivJsryeb8MTINF+Oew46sExAmpugaDfBvgM4lA/zVqm/qCn+7WQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702230;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=mDjn3MIoKetH7rUTWWxR6trpSuYWgIiSpgXajSxcel0=;
 b=SpYKkkAc9wUYHvSrIZTqdKARpwtoppQVoV9xVvdcEPyHDbGVzMJRZ2ZloPTdleUeLt97
 7snZ7871gsmFtFYifs1BYMVlukl8L/qNCob4wM5yUt9hQ2l+LYKq5WdgJDobILe7S0PFG
 PKpNmlbNzOog+nZNmkqldvG3fGnaSy6xNenpW94rE3rcKh0LQpRZ7b8Oz6Q8NeMlaeemN
 IELukEocBKRoDUEEbL2pR3zY/eoKViJeb+YytAWv8hUGM5ohr6vwElWxRL1sFNOS0OKYP
 aUDX0BXjD7MumRG0+0OC8wD9XN6F/jjqBjLKmjkNQ14fQxzgMrfbPLQUVADiLRN9Vcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 672751F00A18;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702230;
 bh=mDjn3MIoKetH7rUTWWxR6trpSuYWgIiSpgXajSxcel0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=hzs90HR29eEVcWrYoaZi/UZM0aMbh6Nu1EQIuq9Ev5DFcM+AOypibk/SFbDQIK2+w
 iSKW0xm9j+lNmZipTMbQRrKvBk1UASbugdTm/ri0WPshWt/6j1OJjoj7tSOhcvr3zA
 MfIlMXZdp+BV6BuTx9E0q7p2pddzn5BVjriDSz0nNqrB6UGcIJ/4PVScw4Ee3XuHJC
 omZ4/fB1K4oArDi4v1+lsvHuKi8PNIkXT71bEZpwHesJbcMqag5ZLc2NM9qZzqcr3i
 Iu/MKvlS1MgU6KoJaUlcU2OKumsnrue6SfnN30i4KXQctfO/O6TgUHfXhX6eOcSziK
 A/RObmFC6WIDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CA186468CD;
 Tue,  3 Nov 2026 10:37:08 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:06 +0800
Subject: [PATCH v3 1/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi
 R28S
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-1-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=L+1Fp55shYkTyH7p3MowRNm8t4fglhebV98qUkz2YWU=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwbPydqizc/7tIrlxbZYLrvM94mL3j9TTbo86evB/
 Z/vBZd/79jBwiDMxSArpsjSKf154pfHF6Z/vTkpC2YOKxPIEAYuTgGYSHUYE5uRDEdiSeNdjhye
 nWrbvcviapae1WNVSNHVnvWO+TCPFXtXY/uPLzJbNf4ytP24spTJMnetmqlT8pI3PeyPzxvGvVZ
 czMTJaM8lfGRNuJhEp8EB9q7Q163LRR1P1TNqFB06UaPttiz4u2sS0+mpjOUTw536S45s6tOV31
 /3Wm1Rp+2yE4f1TrVMz08CAA==
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: 安容 <HystericalDragons@proton.me>

The NanoPi R28S is a dual gigabit Ethernet router board based on the
Rockchip RK3528 SoC. It shares its base devicetree with the NanoPi
Zero2, so fold both boards into a single RK3528 series entry, which
further RK3528 based NanoPi boards can join without renaming it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: 安容 <HystericalDragons@proton.me>
Link: https://patch.msgid.link/20260919-r28s-upstream-v7-1-e80a6f8ef521@proton.me
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: bdcf29a379afecc02c3e99c0d1745363ad7a7407 ]

(cherry picked from commit e9eafc0ca521c8d12e1a65b43f899e336ef28eba)
---
 dts/upstream/Bindings/arm/rockchip.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
index a799bb843f7..a1f000b1bee 100644
--- a/dts/upstream/Bindings/arm/rockchip.yaml
+++ b/dts/upstream/Bindings/arm/rockchip.yaml
@@ -340,6 +340,13 @@ properties:
               - friendlyarm,nanopi-r2s-plus
           - const: rockchip,rk3328
 
+      - description: FriendlyElec NanoPi RK3528 series boards
+        items:
+          - enum:
+              - friendlyarm,nanopi-r28s
+              - friendlyarm,nanopi-zero2
+          - const: rockchip,rk3528
+
       - description: FriendlyElec NanoPi R3S
         items:
           - const: friendlyarm,nanopi-r3s
@@ -381,11 +388,6 @@ properties:
           - const: friendlyarm,nanopi-r76s
           - const: rockchip,rk3576
 
-      - description: FriendlyElec NanoPi Zero2
-        items:
-          - const: friendlyarm,nanopi-zero2
-          - const: rockchip,rk3528
-
       - description: FriendlyElec NanoPC T6 series boards
         items:
           - enum:

-- 
2.56.0


