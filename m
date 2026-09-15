Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC29C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F50380AAA;
	Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZCdnuRN7iIzx; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF8D880969
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504523;
	b=aejhmQSN5MZdr3IVbeRRtf+s+RrOJHFa90KPrm+X45Nic0Gp5AoMPRteKTFA4vOCDx3G
	 +yrZ8Y80ZbqVYDaKBG0YinBLG47ugpT8Fiofnh5bEfLa46u/TBlGtGiz8gh6uF0PhYyFs
	 85vsUskQXHQNA7ROn7CW/l9fEz+xbFUEpgbs3C8+5loB9SP76P/HY5wEUxcatye61toDT
	 QpzMfuFjRxhVQIQ8AxtcMKBAEt5ONPtdgC1WjRxu9ms/5o7HPtETbrImEDC7N8h8Tz2N6
	 U8rKT781CWuLX4kctk8R3ASY2i8rN2gTpJkjyzUSSReyAWb4cYNn8AdFrsHg/osjnXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qFDMLH+g8W217W21BIl5/MaGVRhnoHf0CpK3XBxJzV0=;
	b=EJ4A0eJedZMEgzN1eoFLmNtkUb6YAGAyd9AASnfk/3iXbZU/iu5z5yEgvueF4Ka7dt8z
	 Pd2CHHUJkdYmQeJ1qt0Ef+eBJKgRC9TG+fkiqlzzRwyD9D75Q0/M64TZnaokDR0CaW4y2
	 0AHLe77x6XdlfJjq6cLbKv67NBhEuJSEqmTtAeoSpzcYLQ7t4dhqeAzT/47ntvK/K4IYL
	 mEKVwCDxPAU1lENU+hsS1+ryB+XB5I2ysV/KylbZnH/04bf7ebV22ZG21sRBlKOsDWhm4
	 kmfQmKdUUDY++FM8KGH38xfYXCEk+Xrz7lkrGYOLc44z7zzZ5JG+GEt9EU9ycG4Vc0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504523;
	bh=qFDMLH+g8W217W21BIl5/MaGVRhnoHf0CpK3XBxJzV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9TMA/fLINJBKCHIRXz1zUooWpYfXAheLwQw7jnRccu31uzif6Pbhrmbd5U2DQs87
	 nF6sA4ythZeBriBt3RyB/OLO02+PsuyuL/xge5U5Q8Ss1xQL43Br96SNQ182LEl54r
	 PN/AQEq8ouj8GLNqeis+QMywmY4bGLmN3cbmSX8ewO6hrEsMm11qyW1Ivb+eUz2TA5
	 u36FguAB6ojRVKZTiMGry7T+ujbltH/hCofQrk+jU/XPRe3OHddJNTXTOnLvJxsC/A
	 UtHQcvFZO6878dB2jMXL9vLQXUfFYFYbf0sISnnyKb1t0FyKca38CZ+dtwLe9nojUE
	 tP1VVztIxFJHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF8D880969;
	Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32D26352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D00E40231
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_rTLMdmU2ca for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7B65B40224
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504520;
 b=ZGV9qBQWbbi9DwRPr8m32NOO3/fZ/54htcppedxUVNb+ylXX4GpxWemhnFPFQRy8+WF3
 +mUtQgz5lqdfdRZ5u0HwY1FxuW//fXdvZvaJXux2gvXY/qgEMM5iGCmOoMzwPMMU4WPnL
 P5jjalYkZ+ek7pnyYiinAP244SAu2L7r5uK9RuCsu/3lCp/10p6VJU+UD6oOnFzV3T2fp
 0i/9w63GtyOduIl4N0S0nJdW2h32aYlxUoYjjwz5fLi2IHryNcqU+ZElC56hRU8sQUZlR
 jEvB3AvSYcI+wP7RQ6JrN1XmzTDe28BwOx2zmpmdkH8TpTJroqjA8X6Sg+k4RhJ3HBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=qFDMLH+g8W217W21BIl5/MaGVRhnoHf0CpK3XBxJzV0=;
 b=N7MJPAhwdd9qL1yGOL67MNyaKq2bxBhtxmRRuPTE6PyVKgVCURe21aHm8xgzNhTqPCx5
 JtW39AKRMwFQFxuKqjzWLxv8FYDEwAY8vfWFtYV5odecjavEd0dU8I+LxBhQelLqYGGpU
 IXup7x50jKlOTsKZhCV9BCbvQf62HROi3KMfGaA66O0a1F9jjQSfWYKJTgfo9hYukutkG
 Oshu5rkTIRzHwkMH2Bi3J9pWPJ8mcMEl7nW/PA+gYH1Y9ehgS1HCX4BV+Ajw3NTDa5Qbc
 UFrFjdqkXApnSRiRZgpcqeU9AOIX6xXWOYGgRDlTkyLwGIDXEytpZI3P1kq0ouxtBDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cyJOlkdQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cyJOlkdQ
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B65B40224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:19 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c4923c9429so180255b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504519; x=1790109319;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qFDMLH+g8W217W21BIl5/MaGVRhnoHf0CpK3XBxJzV0=;
 b=cyJOlkdQAWkCHgjngLbe+rmxT2buGChUqhw9BxL0tw693o2A8NQP/9YX3i6uJxDkt/
 Tm0A+PJwzJT1gKgvhZuLHCSQUbTGpGxIann2NaLL3I7zxWQE8/P7VsT+mVt9RBWBTmi+
 3BQ4JuHw/grTfXap7D1jodmr8BwgiEJBI9u/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504519; x=1790109319;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qFDMLH+g8W217W21BIl5/MaGVRhnoHf0CpK3XBxJzV0=;
 b=hFdb8byfuuasrvbUGda4t/QiqzYAKpRVoaFeSQuyG0cLWpfBU3Q15q6avE9arizDyP
 iRS2feunuiVHOonDY5pV6DiUIwrtzq7EQwI4HGHe8RGxTD6q4qhaH3DGvQAWk8es9BdD
 gLxJagDhQNRzW1T2CCoUeri2FVY8YI5nOfu9+3PzADUiwka8xmF2YeBmhjjiN45MVWqd
 hnRc8bJVfnb9Q6wI3h7G26h6Nhmi6+9ljvBsarbRRFuF+/z2E3lghdi/b9SSCi+zrrUp
 f4E9v4RG+8TF0IdMCS8vO8aFB5CHfbuFdtOpj94MXMtpcZXJgYIbbnOL5QesLMEoow6/
 fnRQ==
X-Gm-Message-State: AFuF++kqJ2oJSB5VC32FIeoe9jMYoUUA8U9w3cPMPM5RvsH389FXv9P+
 n7Os+VbCBPqsTTxu3nNwtD2loNrwNuwvLkaNm9b16cWefRwQKXVBpbIrDd84dlsZU5c7wbT6hX2
 NLta9ALxg4Y/T
X-Gm-Gg: AYBFou2NOyOR8to5Y5L66KI64EU4a7d8vIikdMWXvWMtP85ao8cNcj1maXCxq+YFYhy
 WnBI7AhayE4aq3Rp9fyvyvi3lQCTpVdDHlsjImlFe0b3impVX/JAF0xtnGMUQEes4CVq+yqXLLh
 xyRnxS4nP1DSEM5rOYdabtFNMLPjtREePOApLOyoMc+5y3D/YSijrh6mVJG7WB4cKF4brnJMPH6
 LfSp1c3lARh88huF2LTaCGrnskSnYHZmrYdB955R4CJfytDCJb3BF+TtEpOQLLb8ZB116/SXpZO
 TT27yzRc8uCBuFEgsSrPX5LZUG/xSl19XiGm6Yzl26MpaiyRNFmKzmSWPXfTTuhs+51nbbpKP3j
 OVgOsGJdZ9BWmabJcVJhTNe7rqyGw1Jc7js2iURMFTxypRG6ocrqWkUDaqdVNgVNGhvelqMtemB
 07oMzAI6k3I9FbvC3/VITBzEvmg5/qOtrS3BePKMhhIGOMVXeWzvYfliNUOehHoUTYgTeEei8Qd
 lncltumjF7+6KxlnWQKKo5nqOZxhlnfL6btFcNxMMIWgJIph/Rpdubhl4wUyU9UzBVYCNlDoHAI
 lh1oaXWoGGZjRWLJYxI=
X-Received: by 2002:a05:6808:19a6:b0:4c5:a75f:c5db with SMTP id
 5614622812f47-4ca4c285026mr34475b6e.27.1789504518867; 
 Tue, 15 Sep 2026 13:35:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible
Message-Id: <178950451818.931545.4829321820429871099.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 27 Aug 2026 14:37:57 +0200, Markus Schneider-Pargmann (TI) wrote:

> The upstream devicetree describes the am437 mmc/sd controllers with the
> "ti,am437-sdhci" compatible. uboot's devicetree uses the omap4-hsmmc
> compatible. As the driver works fine with the hardware, add the upstream
> devicetree compatible to the driver to support the upstream devicetree.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible
      commit: 26a1060bdd7e275770a42a2c955bb61cc458053c
-- 
Tom


