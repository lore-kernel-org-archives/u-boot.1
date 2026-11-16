Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D09606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tpjce0gS;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ntqdQx0h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A2D80FA7;
	Mon, 16 Nov 2026 16:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REUNDW59Gnna; Mon, 16 Nov 2026 16:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 232F780D17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845649;
	b=MP1n7VOS6wyz8cJ81F59OkJ3SRqo9gstTxprrwmv9CdYiCL7DDKG1fl996NvgZrNLZwo
	 06yUbpWI8O2Pq2i1HS7IuewiTZS631Wz/A7PXACwMjjn/g+qDJCDrRsuNhEHW/9H/BjxA
	 uWOzd4hGlFRymyvfOm0jKcwjOK9SkARJ9jRexbZexkPSYcjI50N3Mv42LOKZ0eiqQemT3
	 /riNR5lVWlu5zSx/D2w2ynit4fFxr3/mRhUzeMkP0tfiby84uc8rydTIN2+yQZSmBTjC7
	 sxVggBmodDXl+kykFJsSrb/gIIwufl3xvloQd3LG7V6SkT+DsfX1hk68oinZa6nlnQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BVnCgWAjgtT9onqZwpfcydiDaMdVQwbDvQIbEiTYx4g=;
	b=pTRk7Yl1AfRAvRTDzBuYNTYQ0CBQ6FRjeMyO6X6KRXJ+lWFyIJrJyqkrsZiipqe1dn+0
	 u2F+FPvqSZOakxltGLe1ii5IhKXIfi8xpeb2eY5xwdPiF4YuQldowEo3n3R+sWwlddn6X
	 VCDrbcqXVnqJh/jAP5/sMDav3z7+KiE4KH7/FyBuB9IHw3JcUpe6resfSxN7hwjfFUze2
	 3xzXNttnT7yB2ud/EX6lt9voYjqijepvjfB89NTJO3thYJsiZPpOsvlmbBfwoDU0TPlcj
	 d9+YPdZ+O116Kjgv7seU7GsuE1I3ehfMrnVCQ7h9rKnZY1j3vYfoVFfxTz/gj8UuFgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ntqdQx0h;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845649;
	bh=BVnCgWAjgtT9onqZwpfcydiDaMdVQwbDvQIbEiTYx4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tpjce0gSt/OHNOh867ginLudGrYzmy9oC+FKg6Gx+BarPmDaJdQjl2kk4rpE3fPUm
	 sOYcU6BXP18bG8oZ0JSCgb1l+DD9PlOxEvb3RmDjdpIAmvPfgnFooll8J5LheOjjj8
	 itRnP+sw2t/QA9gcumCW5CX2zErXKk/g/vTUXx/JdLya4FnF4ChrfvZDKZO7YNE81T
	 FJ92wfryDlfj4hVOc7Av29JEW/oarQu5bAekRhOOlTtuv28PHYu9T2YWpVyYKAlPvG
	 44P728uRo33fZLOX+9j8LcOw04CY7BwvLLOp/xkV6/9CSUmOH5oQEMgjBDsUcOyVEQ
	 wTrQjm/2Jkq+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232F780D17;
	Mon, 16 Nov 2026 16:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFD2D4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DE880D17
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBdqB-J6nRG3 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F89980D10
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.11;
 helo=smtp-190b.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ntqdQx0h
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F89980D10
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:02 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGJ5tHxz2MVT;
 Mon, 16 Nov 2026 17:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845640;
 bh=BVnCgWAjgtT9onqZwpfcydiDaMdVQwbDvQIbEiTYx4g=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ntqdQx0htLWnxsawvUSCUnFk1O/sIJdap7VOpL4f06tPaq+AlORbSsppe6qcEgylT
 CZm0lc/LI0UAqareCBhZ5qma2bbbiAoSQZQetTWz7ImzKa8QZf0a453d2Cf7ftT/dW
 6UTa3MtpPsoqJeRzbv9XjzzZ/Lo7R7tAsxkNA02c+yJ38h913vz+3N6JAirGn3jiPR
 RrH6PiAwI0sAtbVgLM2PJxxj8rLtGHRLKbfjs1WX2Cxy2KMm/ICimTK88H3JX5HpYn
 NBjhh4QRgJpU36+mrIHmGdJoDUhMudHJNUHbmOg056tCHeFDKaFwR6WcP7OdSsOHA2
 4Mfz5s8+45FUQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGG6GpyzxbQ; Mon, 16 Nov 2026 17:13:58 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.u-boot-project.org, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chukun Pan <amadeus@jmu.edu.cn>, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
Subject: Re: [PATCH v3 0/6] rockchip: rk3528: Add FriendlyElec NanoPi R28S
Message-Id: <179484563881.1840799.7344667894628544849.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:13:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 18:37:05 +0800, 安容 wrote:
> The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
> based on the Rockchip RK3528 SoC. It shares most of its design with the
> NanoPi Zero2.
> 
> The Linux devicetree and bindings for the board are now in mainline
> Linux and devicetree-rebasing. Import the three relevant commits with
> U-Boot's tools/update-subtree.sh pick dts command, retaining their
> upstream commit references:
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R28S
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/5949dc67a319cf7330312cf8a494e474a841efc8
[2/6] arm64: dts: rockchip: Split out the common NanoPi RK3528 parts
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/e0eeca5960f0ecf9e056dd9a01f398d68a02d16e
[3/6] arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/fa7e4782468fbfa95dee2b21abde5cd86810a927
[4/6] rockchip: rk3528: Split out common NanoPi u-boot.dtsi
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/fff001a5d389facb25e999ed683e8426d51e5f51
[5/6] board: rockchip: Add common NanoPi RK3528 board target
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3ad7bc377887f87ef917f4c9bd790d70d37f90c8
[6/6] board: rockchip: Add FriendlyElec NanoPi R28S
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/28d923fc96438291c20658cde27452ceea124870

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

