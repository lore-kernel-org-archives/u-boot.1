Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=egWYzfKq;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lAGJXFeO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49FD3407D3;
	Wed, 18 Nov 2026 16:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoFAMN79KuEq; Wed, 18 Nov 2026 16:21:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AFA14069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018861;
	b=UvyhA41Ytr75A4s1a0K4okFc1AQR9UqYnTLo8/OEg3iRoWabshrv4Fzq4ZwoIKb8OZVf
	 6FRhUb0ByVi9jSmeDuIwq2AOKrIDRGJxifVp4OQB5tAfZ8R2+uvEJoV8mgqjiBFdcfynQ
	 R8k2Ni8bVmHhBWn8xWTBVVMENT+tu2zcTX0XobZ0bT4yVcXrqZvd/LGQOwRWMKjgpri84
	 t0jI+bZ/BGLJSiXLHMqmUcL63Hif9oBo20NjX8nVKVf4diGJiHvsAiJI2ftymo09yPJCY
	 k3p2HfZb22uLyCMKJtIuSo0QgAETpTbcwm8c1SZFkAHEp2efnXo+yl7v53oxTqFfQ+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Tdn1m6XH8qhfk9NFhlWJeylfxF2zR2k6ZjIiC24lr3E=;
	b=QQqgeXeeNt2HwHKA9xHs8eQvpzRFRO9/T2RRF3eBOdLb5RWpH9ksqw71gLDw3qo5Lgo7
	 Tmc4U+6R57Vog1xY7X96WYeS4SfEtiIazLXfl98yoSxtjvfXC+ykQwnZ0OA0rtKTSpsei
	 g1ieEK8S2OhmhXFVQAaHJD5lfSsLK/xdoAFjEjpcZlffqqbllMg+iuMsmxP82BIxj+Fjy
	 CQalX+xa3hruOofpOTGoxJZH2u9cYZWJgmzuikLDpRsgjCH3borbDVueZQY5XXYyg6VeW
	 KPDvJNynqUu5vtWuY87WNhGoo0cWkOx0YB6EUIiHctuypQfiaeFIf4NpX4HViMC5Ixg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018861;
	bh=Tdn1m6XH8qhfk9NFhlWJeylfxF2zR2k6ZjIiC24lr3E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=egWYzfKq3kHV3GIKoDLPn4+8936SUeInCXIwi+m+WFgvaFp2bmw7yXZl8lLvp+KO2
	 kgWhdG2xI/t4+abIo/T0Xv/oklMdnHHEyBF9i7atT1gQftO6dTm1/1wE/IFI66DsgD
	 wXjNbTmGQ69lXuUyXWtEm4+sUUUhngNjBh9u7NAKJBLcb0EjVetekSWVM1TKdpCDoQ
	 x30QQK55bjG/vhWrbih/Y6z7geu2w9jcXCeTxKCmLSQfL/HbS7e/nVaPG6do61Rz76
	 d30kIrCouXMA+jAdlrLPhYqExTJI1vPrKoIroJKo+FRoOK/yGPHDD4eglwiiOCQohG
	 DOPYNShneF3YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AFA14069D;
	Wed, 18 Nov 2026 16:21:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03B07977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9B5E80F7D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw4H7MoxlA4C for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E55580F4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lAGJXFeO
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E55580F4E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so12834545e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018850; x=1795623650;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tdn1m6XH8qhfk9NFhlWJeylfxF2zR2k6ZjIiC24lr3E=;
 b=lAGJXFeOSUl1v/uyr5mtqbsmaEfANWe1nbORjNPcHZBkOLCbJya/y3ModB11g2SAeC
 CHVXGnXTWKp6pwVr1eFOMKQN7M0/uKMRagK1oasaVArDVXce+baheTrewsz97CBLD1/I
 CtN2T+CW/TmxMDR4mErhb/r8RA7D3y/tCNTijk+6PcG1zQFIfQtYcOTQZS2AhaCtqdU7
 LqO8Ktv8/QLU8aWg9E9UWQLgYXNGoNImdPtmWIUSQ4jj3kWe6uVJgPd5jL8ye2+5u4Kf
 h8xSgvjcm8L7n2WJALUSuT8u6cMLyjJqotlRbw/ebrETA1Axoe771yCZcM0SnFiC6iS/
 qgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018850; x=1795623650;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tdn1m6XH8qhfk9NFhlWJeylfxF2zR2k6ZjIiC24lr3E=;
 b=ifvfSGZ2NQ5xCMwxyZUXVACJ9O6y6EpdN1lSWp1PtdNjAF2Qsx1/I0hXOKIfbuty4b
 nstj9asiaTYw9bbO+0GuSEnRwG1JLzpgmGY9dysr0ZVrcjuLX2xy/o93I18vCIbpOWJE
 LKoyL1o4AfVOewsTWNdp/xR0Zf/mJKsgId2zhMgxgYfd3DZWYK71vvplUkSDl30H4370
 I2ettP1/Xqy03X90Ba4nw9jBGyqFWb3bQr0SHgLRXtKl/vtnZNOM3E+z36SyQ46+hLpk
 YW4t7yVbFJzqAnMGhO/9dGvjzty4c2c1YCI+RTuqUh6GZTc7p4h7LewBdK/lSPjZIL1d
 BrDg==
X-Forwarded-Encrypted: i=1;
 AL+hErGuDKrqm+/1/ASSYu7AgAQip8Kt7Y3IpVt+6/+Sc4rdzPthdTKIjUc13m7dcmiMKE0TvVZtNsc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9wMYa1RvJJbZrw4xcoFSKeJz8hFlEIaa9HnNxcDXluXhHTwvk
 h2hGM1T92m9uS046bW67orih+rWyH+28H8tzcx6xNP+4fgJblDywcnIj4kuvo+m5Cj8=
X-Gm-Gg: AYBFou0qm1lQmWtUmMWSA0b91gA5cMu5RmUjFx0w9zfGyJQ6fR/EFzfsZbtRTiY7DWT
 /iQh9RXTaybcYeH8BmD58DxhbtQLF02tF+MClwHvtcC8lejACxu4JmpSQ5vQ1WBL5DRG5wK9Csa
 4+e9KctSGXM89xFuH2hJGAfRRj5Ye8Awf4JvSAeuzK5lRJ4E+bwCHp7R9OML+yr1kgx51JqSAbs
 bZOVmYflw+fXmNKEB+s+iVJVMqmVVvuW/zONtDe3EdwXpT7bfm0xxar5dAbWPq6ufg4dfssr2xE
 AaD/mARyni5ldef1lujuy2ft3KM3fxS62s6cPCWhRDQzzHHesUeW+c6zWXdos/2wNQHxuyFPpd4
 hr9NXHFHURGN74i1uqWHuVKHUaZkjdHGcVeub8Gr74MS1L982FGTiYXadNPMn7Eg23OXcgGKIcE
 9GIw505D3XPnmXg5rPT9256yONvMxrfnr/S1kuuozCGOQiIxVrbqNGQvchDwXCdBjDzWJiUHtO7
 5mats4xv5BWLl6lbX91ZA3ANOc0DFz0x1QbfDnv6WcLsmpBg3FeYtAhp+PrVVhxf6mvQ8BUw+FC
 WQZZ8x1ZPw1trOfg2MwZdJjmiGvjrUOgP1lww4drBusXbm3ozNk=
X-Received: by 2002:a05:600c:1911:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb7d5d417dmr60796785e9.2.1795018849538; 
 Wed, 18 Nov 2026 08:20:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 6/6] doc: fastboot: Document block device selection
 syntax
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-6-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-6-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884044.2226612.3793896308033954372.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=865;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=kxL9PBQ1nYb4wbqrKeAao3aUx3zm6sPP1DVKjEG7mMc=;
 b=BtQ8bXXF5o748D4GsiHPykWJLzlGIbplxw36YAvsXLj+oZjij4PcpUH+FI5iaHVwCHDGgzHA2
 WD8W5H9xDkZB5DbKLmS4DPHqhREB08ZOk0d1em68rkLoHcNvJSbV5dF
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 16:35:13 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

Hi,

>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 8e15f287f9b4..404ebfe5f54c 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -195,6 +195,33 @@ The Fastboot implementation in U-Boot allows to write images into disk
> [ ... skip 12 lines ... ]
> +
> +``<dev>`` is the device number on the interface set by
> +``CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME``. It is parsed as hexadecimal, as
> +in other disk commands, so ``10`` is device 16. It can be followed by
> +``.<hwpart>`` to select a hardware partition, e.g. an eMMC boot partition.
> +

Partition number was in Hexa decimal too, perhasp it could be good to
update this part.

-- 
Guillaume La Roque <glaroque@baylibre.com>
