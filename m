Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE4CA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06DD3812F1;
	Thu,  1 Oct 2026 09:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjuLtqMN5eUE; Thu,  1 Oct 2026 09:56:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2AA5B812E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848584;
	b=tBxMs8t2OSZWSyADxQkSM2Ogi4EU68OYKM9x2pGNtLlSVaCDKjShKsSXsrQn4YUFE7eH
	 4tcgsEUdTfkXBjX25M3W1bSgyDfR1PDrkQWuq3deW03atPK7vKoAJ7T+X3uYiyMS47YvX
	 EUgSb3eb2za/ICek0YkAM9IZL5/qIfCiM6Pv2XjoQMPPwssDJqe1MYeiFaiAYP7SCMUG6
	 7kH0u5Vo+DVLRFAE/knnHE19DlPpX9HxCxh9FarDaKtHIjCD7GjmlGZmjLylZf3qwJXWe
	 gTtHx2KWhl3PdJnkf97scMuS8YtKI5Bavg/7Iz4OTx0LKwl6jO19DyDxS/Him3OtvPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b1FAHO9/Kqe/AxhtOvakcSwBR5N/yTVo7MlENG59v78=;
	b=Fl3TSJnMeP9GvMyUv/PxkpOqBiShzLyyznmAurIrQ0ik0J8/jHgjiXyptpX0XEkEcEUh
	 P6V5upv2fDa1BOkKkCI8e+PcuJgzn9Sjevy1gUJCFuFp+FsHkywAnpkz58AAKRsGTCGCJ
	 nV1Nt1Ilv3O8r31jL7dKGN3vTmBvMk7h4eXlAUcUD9dveCTKLyPJ5QTGDlN5XklDCtELP
	 hVmOwGiq0GlZDT/pGFjJjHsNzj8cBa8JCDX2ut9Und+5nLxSmLq8ZoUi+syI3g5aZogl8
	 zaQmOyxjHUSGFZFY8SbIXDCACuY2qkSNLDikCAWObiRZiAFgiWvNPBBVojRcyfClZsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848584;
	bh=b1FAHO9/Kqe/AxhtOvakcSwBR5N/yTVo7MlENG59v78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wgQBCanjQGkH5ZJcSchKHBk2/TqzUICep90SoDbbtZmDErQixYuzX8EQvnjdkYhsL
	 PlL6+eZMzK9vhh5jHyxl5b130nWrw4ZAPrf+mitMnRstdyltybR2L67JY5QeQt9EP9
	 CUyZP/KzI3S3VFlnoofeofb1V33CutP2CSSKSVg106n4EC02Jp5WJXnmrRNQY02/K+
	 hr5w8jOu4GT2u8801KdceYIhAx2Mc1y1+bQUgw8KRm+lftGHjJ8wKyGXJ/ddrQDZjp
	 M30HzaqNFsDI68L1E/uuYy9u3874o0yalTr6BlloEj0pYLx3DYyGuo1hyBtgE3lGGn
	 fdgNK9waMbb+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AA5B812E8;
	Thu,  1 Oct 2026 09:56:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4096034D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2238560C00
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APy7mtR1erHD for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C3F26605AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848579;
 b=EtmxRTXBkT8HmdcQcwp3IQuWUaaOiOC+3MXYJC+NuLTxdPkBqBRzHl6aMcX8vm19UlLm
 K9KrosSBb2/EgcVh9WiTKsNAT9iD5Bu5NplDZyP3SAwMd7TrrJPWHO2s8GrVWSE3j3Rj7
 r6kPDj7piG3FwCdhDNayowvNO9XOnJYCvs0dXeZ5lMRXIOLHUUbZA7xWxWl5J1cXO0OQz
 J60JXDLsaMjeJzIeIqp5/cFaI5m+wxyQLEXHF1GlZ/lbXYd/K6o2EesdwLUSrANmMtZa3
 B1pldZNiyuhjNmf729/+S3UD7zF9AjPFR6uzKYh4Kkw13P9ENXZE5ju6pX26SlNOkOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848579;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=b1FAHO9/Kqe/AxhtOvakcSwBR5N/yTVo7MlENG59v78=;
 b=pnRY7/pEiHvqu5C+vBBgXjjNczkatSgCC+4rSa+Sv6LHs6SDu+SrImx7hQq/CF6FiBxa
 Q6coamSNXVXB9ydcTMnge2HuMbzmLXzM5Gnw+4MoOZQc3egtwBhyMpOi0ikh//KOyYili
 eSd24LzCBotqRH812JdIE702JixTK0AffKy1aVnXPulKUSziXnFFIQaUITeMKk/ngzI1F
 rEkmMQQ+y9rMMn4ELhE6BHFJUwuZWkVgr97QjeboDkfS6uwH5x1QiKTTN3m/cS5OxjlsJ
 8HdEyDpwHFLEzR8ZTrXND3dcZaToFXN6VBPyreB8+2Ak1zWMdcbURedcF1YU/+d/l0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CMtrMTQH; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CMtrMTQH
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3F26605AF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:18 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so4542160f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848576; x=1791453376;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1FAHO9/Kqe/AxhtOvakcSwBR5N/yTVo7MlENG59v78=;
 b=CMtrMTQHPy8nQqI8yirQR3nccJjlOxBiP633swQk1tqjb2hGtDG+kuUlISp6EBHJXb
 auTWqx83/IPyBJ0NqCiP0wYM78glna6zMsG8q9FaxUS3pDeVpHvzotsmxAYfCQbL31i9
 5nywzDdgH+ywi6xMy8G5hsQngVmpX4vNJV//ph7ImCq/1sePlCUhL3WkbcguIYGjTVHp
 nWWMLNuVHj4jsJu305Us+ihnKnV2E6KrZD7doc2TTJliTyLWJ7tWhzk6Yi0zG0dEY2RI
 HHSkcDLS5D/GfGHcTGYt0Yevuxm1WX1CcAXxD4eS3rC/eQ1XgA1OCgazSTg8Pm08oakw
 R6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848576; x=1791453376;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b1FAHO9/Kqe/AxhtOvakcSwBR5N/yTVo7MlENG59v78=;
 b=BeRSmKZiSD4lo0YLRthONv8irawE8Pxk6YmwJoI1/ntiY8PFnvta0nuMvkY8aqjbeP
 /CvTv96x2k9oJcqovjT4/r0ZEH4dDpIap5EpJ9Bty47FX/JUKJFDChkT4WO3kRh1upsd
 kbwudC5OxazAdo/fQf2SMV7ByFBEmwaF9TVDC8jgILaghvDMLKX6sclTopkRS5NBwAiW
 8eeNa3ntg0pkyEuT7RNyOHGb7YfqLzU0aGxcp0K/qKZJTHI84WJZzhoVKc4yl6ujmRou
 WKE7O3QyuUyTQQYV2e3XIxMUO19+doxE/X4fPhOQv+sHTHsUPz8RUwgTEfn2+o6fAhGH
 8lPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv+TENsr7vuL65cFOfx1nrG4Y57CQ+g1vBYUKelg1bY+kptx09mBvRFyb92i9gBsOQUNWydAg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l8hhILZ3nUKP166sbi7rTojfVL9uZAMGkgYPWCseXo0Az2Afkz
 Res4x3NuO7/wYBuL1nBlJnj1WQGJcTRxRT8t/rfYZB/hauDL7r0KzHYL4qaKV+2B4bE=
X-Gm-Gg: AYBFou30gH3HZ+Xjf8cKEAvNorpTUtg6Zg/yxxQ/58ZqF04SCeXYOYbBktwaY0O9Moe
 HBBUaoFvApuQMAPy5FDOVNynhBTYSVVdk4nBW3DuOm+kf+MXxRqsYgG2DIhN0yQhEsx8GK0sO12
 eSNiEwnEYHbmByj07ypJzKvqVkZ5rEIvpsPpbY3HbLXYRkJO31tMFcmAKoJhKz8eK6n1T1PIRiA
 RLElKAhd1OLORNTesfARtSRHN/cgmEURut2p9JqC0KGPV5ROXWcw5K/GPAFz4lhrpa8WLC7O7ZA
 l5mXvDrDJ8PvTpmSFd1VReymAkaLFuMwCXsIRRk6cnhDLl1svKCBQz3q7V5mF/jvB/6dbIF+yyp
 ItDK6AEPJzBuiXoF6WHSJhVMGAlDnEwObXBdwj3Av8cNpmw0xCP3hEUN3nOjhvBAd7aSAEjD29M
 dF6iCbWAcaP2PwDNLzlaJ5qf1pul55bkFdKAlvVW99/vJnr4gMw4erkWj3DDI75GiJtJb1NfBL4
 6Bup6DmNEo75R3uinthouyPcTyNJWbljSEPz2nwL4WExCq/mWhdtX9hX6dDMw==
X-Received: by 2002:a05:600c:4fc3:b0:49f:f099:6f8c with SMTP id
 5b1f17b1804b1-4a01aff0c5emr69113655e9.9.1790848576017; 
 Thu, 01 Oct 2026 02:56:16 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260723-lemans_emmc-v3-1-4dfea75e0f78@oss.qualcomm.com>
References: <20260723-lemans_emmc-v3-1-4dfea75e0f78@oss.qualcomm.com>
Subject: Re: [PATCH v3] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
Message-Id: <179084857393.7191.4534326111816846478.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Thu, 23 Jul 2026 15:09:17 +0530, Balaji Selvanathan via U-Boot wrote:
> Add support for SDCC1 (eMMC) clock on SA8775P platform.

Applied, thanks!

[1/1] clk: qcom: sa8775p: Add SDCC1 clock support with frequency table
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3b784c1ffe5d

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

