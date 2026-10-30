Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A02606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QmigtfuK;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=EpB6/fNA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFC0A81467;
	Fri, 30 Oct 2026 17:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1B4PQr-A-WMB; Fri, 30 Oct 2026 17:18:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB64D81461
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380694;
	b=N+lVazXRLsHdAQEO8/ozkPaPf6JesPSpiO9h5B309UbKBPMQG9SQSpoZ9LZEXGEvWRbu
	 Rs22AXvTjO+iEPhnMrmft2dvw4UZt/5Fjep9GyPS2MAxv6EjfW+M3/mxcP0UDNEfOYtf1
	 rI7x9JeEAKCywGS26p7dKGx9Hp7tI0adalj+R5mhSe6mj5aAuNVx7FK9thmrAQISEQ3P0
	 9gBoiRb7gInz8hlMUoixOoqMSWCUFLWtyU1VKK4T/pPq1inxTrAGTosciFrxvOjh2B0X3
	 lk775IKeKQyB/pi6p74Ff13y4y4ctIwJryaqRXx/s2OZIesZWTPjj4fkpxFKydf46pQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GscRuB2Bu+PsXiOuNmSze4cTsQA6LZnHO/12d108Peg=;
	b=kUS4z/FFIBwJAmkhJ01TCHmX0bw9k0D33Icn64Oa+TR167fu7pDptgbLDzbPYSFFRqDa
	 2O4Q4jaTplkhXWBtPIxCB6n5TZirJ242VVp+01qJEa6x+iJRAIpt1q42bB8sttIL5gbSW
	 sdXDUhXvf/VzE4QjssugPT7tzXO6bwEHvXs2/t24piNpNfVKwHHSvY/k1DVInsmXiC99O
	 2Sut9TexzJuOhS5bS5DkjX4PqX37k/sySiwq/z5T0Z1bdBgtUwMjOcEsppQ1JEPA8hkau
	 PUGPRVplL65hmy4GqH1Bqj+ZKA1USFZyypo0j9k/2kf0OTK7HYJ/ogh7NRMOlB+gioA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380694;
	bh=GscRuB2Bu+PsXiOuNmSze4cTsQA6LZnHO/12d108Peg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmigtfuKa2EBqqmqtmGgp5wSpMdSbviItf/Q6x+ebKuo+d4ghPVRx/NAglEzpGUq0
	 JOG/vvK5pHaJOjJuQnMV4W6dGrPwSjWLYw25uZikkYrULj1oWmna+ua2ztsLRiOLj3
	 bgwk3Y23h+37c0T88/lEmfkDm8GD7wcpFOmkc1efprLA3boTJj0LfOtpLx7k2EkpnC
	 VumLVuKeTwNgWqUpTwSoLqoMo87vAKgOVJ8bAaD+8gYLm0tyS1v4inRIWeH4m//C8J
	 +K4tBn+mhWYsO6z7N6hBQS72RxCCi638ngz8uV1cxo2QoYo5G23Ulju7E1x3Smmk+x
	 G2ap+/A3Dsu+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB64D81461;
	Fri, 30 Oct 2026 17:18:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0F7D411
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8677F40B7B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJ9StDnBP5be for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:18:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 152EC40B69
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::bc0c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380684;
 b=AVW8kfAwpvN6koeOg96L0m9LSlCAanF9MbI7736LmGcm750q2tstbpbuHq/65uPFAyUN
 f/YCHgui8xAKWCwi1PCPNDZLqc8e3S8xGusRfcC8quZlbI11TKJK4jRqwH5iocW28JVyP
 1DwXjtuNeTcR15ctMa4Bpcytfjfm+KvuulGa3JvsCaJZxIA/2euruz76NZnODMmgX+ulH
 XXeUQN/x51lATnB14/DtLlipcJiXZSmIm1usYT05GZw56KPCAS9kZLsCGi8soGBzgwEQB
 jBmXdsJU0YopfVojzhD26LhzuC08n8wFUahEm3zlANReQYdD8dz+t5m1yQKajn+Hb5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380684;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=GscRuB2Bu+PsXiOuNmSze4cTsQA6LZnHO/12d108Peg=;
 b=iRAde6k6TcALKN1dMfr03ArtlRNA2FDFcpVXE2LpcRuq1+oJvaRmPrJ75TF5M9A4yPAo
 a4cCJLCHHZk0iiV9rnaSezBnSh6cIZv6TZ/fOMZNIrPPiQdAUpPoYam6cZ7qwNcsVZ6FT
 Cf/Rd6sS6bEqTzyWMwVRKpti9LBAwBApo/h2tWfx+fGd9IojUbBTW6r+Ffhcky048ERqz
 ivZ+c0Rzp/qQXWZd2fqmzfX3D5qVe0qjwIgLm8TMBRRJ2d+B1QIYyHHD1cFjRabCxlomW
 a7rLw16EbHxIONjJ+e1HFn0WIO5GdF76ry0TeB1HVUjct4ILWn8UzZlOueewE0wK/Wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b="EpB6/fNA"; 
 arc=none smtp.remote-ip="2001:1600:19:5550::bc0c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::bc0c; helo=smtp-bc0c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=EpB6/fNA
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 152EC40B69
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:03 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSV006vVz5dL;
 Fri, 30 Oct 2026 18:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793380679;
 bh=GscRuB2Bu+PsXiOuNmSze4cTsQA6LZnHO/12d108Peg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=EpB6/fNAObWn8vkI6HF2pZEDyqnaP9qEAsV47+gs+2jIT1OFXTKOehovf95C8f7hy
 CAzNXhS1KEzD5GIrz6VcryciD/MXKq3QmoONQ1y7SKWxBp4j2nJrjCOfVqbyvxCaQX
 Pw5zAadppZt7xWJ82sGqNQaBduceIUc1ZlA+lUrXWYJA1ASS7uszeu6puIL8OVbAcT
 GgqCO1SBf9wlCG0OGeZo6ryO0dASE8anWggnvjGTSn23Q+Ty6XrexwGQHUO2Vhp5VE
 b5hUu+UTFfRcl1evooganjY3oaIBtZ0vpZUNyjsA4xOMwjhX6ERb8/Tu2Mp1+WrB6U
 4mpJkOSsKDI/w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSTz22rLzZ5j; Fri, 30 Oct 2026 18:17:59 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261004195853.59863-1-jonas@kwiboo.se>
References: <20261004195853.59863-1-jonas@kwiboo.se>
Subject: Re: (subset) [PATCH 0/2] rockchip: mkimage: Update init code size
 limit for PX30/RK3326/RK3328
Message-Id: <179338067925.786412.13298758717481896565.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:17:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 04 Oct 2026 19:58:50 +0000, Jonas Karlman wrote:
> mkimage is enforcing a smaller init code size limit than what BootROM
> can handle on PX30/RK3326 and RK3328.
> 
> - PX30/RK3326 is limited to 10 KiB when 12 KiB is supported.
> - RK3328 is limited to 30 KiB when 32 KiB is supported.
> 
> This series updates mkimage to allow using max possible init code size
> supported on the affected SoCs.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[2/2] rockchip: mkimage: Update init code size limit for RK3328
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7fcc2b3948860d1146bc84bb523ba185d892b09c

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

