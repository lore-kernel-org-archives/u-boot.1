Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57116C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2191A607DA;
	Thu,  6 Aug 2026 13:23:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mcmW-SXfkAL; Thu,  6 Aug 2026 13:23:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5146060763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022606;
	bh=d/N6k0fqhvlRzqtyxyO03/cnC0ZSKwZaW4n6WHcQoMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brGalZamSTqWPM2SR0vyJyNwfHKUxHMPqpcASlOKlCdFAd/Zt+Cs0tKZi960M5Lzg
	 pkf/eXWdVj//5xvtlVpl6rPi/H2Y772q0nwG1WzmfReLHZnjkpatVGr6wFJ+ncTFgO
	 6IACfGhqj4skN6g/+IGR0H/+QEVsoc7FbeTUeCL46/H3chW7UuMt2YQLKLAhuhXYVT
	 PGXC9Mop0CHN1X01foo8vwxJxmv+uazmG5AIjv+qHxA6uhl+gKjV0rPzU7j72VEeKk
	 +P3afCgTdBysxpYBtUCzjtJxuFVrUuTW7d9cVogzjAZuy2eE7cldgtxSbYLGCJYhXH
	 W6WqsSb1MupbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5146060763;
	Thu,  6 Aug 2026 13:23:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52750218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 443C380D3D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxnXEUPoFfZk for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:23:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 821FC80D5E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 821FC80D5E
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 821FC80D5E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:23 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so2870098a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022601; cv=none;
 d=google.com; s=arc-20260327;
 b=B5gvv4CpUNUxBVgxqZ7kr/Oj2/HYKiQKCmpgO0z//s3Hf/cmdvSUE8ix1c3mofjl6S
 IWUEethF3qx3hry5NGdjnLbjGj6lGbeKgkyw6Zxcjpf913/A+XLhzBrq2zPFzzVvyEBb
 BvhafptU7i5+NwvcELdH0uTm96sRpSXiTE7533DJ+dXd74fq8Dlig4Ju/lDgbXMcfMsp
 8WSJ6m900ekWgrRmM0aZrpiJ7IbN505YwaQPvzH5E8VtGZf1ogafFWpf8Z3GitG6GFd3
 6YrQ3tonDNNh3SIqeBIepCt7/D4jFw2cztX+5rei/fKhEKak6UvHZZ/pss0VZnx/bfHO
 w3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d/N6k0fqhvlRzqtyxyO03/cnC0ZSKwZaW4n6WHcQoMQ=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=a/lXrwFq43jJuNFqwgNnm01EFpHYn+eFi7QU7D7fxmT5MI1R5hOliM3E12jMPt+lWN
 2JkrcWJXY3J4Z1El7SsCVbHIHG+/OrbCiYiYszgAshXSdjikss4qmKw5eW2tVSN/JfHN
 55y6sbZ6VZ+9wBv1iM1Tm2BOTCh6Q6+295+nomCsMOnIgVaNM83hkrV8nT9WsKihnla/
 TRDj1oe1T/mNyWF9lNzN7U3nfKuuyZ53UKGVHl1RW3/8IysuXJB1iLYnJHaKVUsDpHCr
 t2XwHHr02HRMAEKY3W4b5AQul/VhIOY1j8QCqLIqhrIHsUkiOSVIniWnsInPl4pu7zof
 2taA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022601; x=1786627401;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d/N6k0fqhvlRzqtyxyO03/cnC0ZSKwZaW4n6WHcQoMQ=;
 b=ecMnfU5x66YfPhgF6vRqBIL2ySg79FhBoc6njUSICDM63Ej2hqAYYrRE0uPCNwVTfV
 hMr9ea3Z/UBd5o1ZjZDeqtKWiK3bfJn/Q4vvHKIi/Voy7Ux2Ekca38w91wAIMl26AEaY
 QO4RpHafURtYDWCxsGZaQCey0P55hMVwF9snXj2TsWzz+9TrmlM80I2HMAp8fb92OyPU
 3SR8NZJnLh0LqCACJNlfcAXrV+rZz8Sm3IAcLOHxQvmd6jnmG4dLGoLmrZJFVybHOQPY
 PzicdZPz7H4EMfNX1iaL5DP4D2sdMrLt4y2tuVYfbQ1sx6iAtkIyGgoTQoF0uzuDbde3
 BoJg==
X-Gm-Message-State: AOJu0YzV1A5MlPaMc9vIhVn9Yl6HCLA3lGwxwyUyi1e7NJJIQZZhyutg
 tqq2Z4nIvEAqZHBOYa3bp8YFMuuY6pir7kS4n8hOYiAlRHf35hpQ36oR5z4uxaLvksUvVvJon2m
 ioBhpYgtjnm/oDghBoEVj2KRUpFSS1WKLptOjtTHDDKigi5enTpM=
X-Gm-Gg: AR+sD13RC7JUWFwErJvK+ZNMr5x/fQzKplgdfrcSaNkE7jDUJMwtXAwqIlpUZ3FTRh1
 YGG+qKXYRrw0LS7rNH/jMLDPWwoFNoK93uzMaIJrU2+lQiGwET2VOZ5bToKW0DmBsOBKvv/akeC
 wasiVcU1aPr6hM4y4sB61ERYBO8Io0m/4f05uGh67HJ4ESei5hadrdJfLqn+H8CFBRtwj0uTcKQ
 Rx++s+zs7SZ7CylX3Es1TwLVcLwNEPNOtlw1iPYMGMcSM3e4sF+vHe4k01/k7jjyquKkcz0dtvL
 JyBKqluvoyNBX3xePcuf7QUCD31um2ss2iA7YNOezVM=
X-Received: by 2002:a05:6402:5cf:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a14f1489b6mr7675619a12.16.1786022601612; Thu, 06 Aug 2026
 06:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
 <20260730094817.1937340-2-pranav.sanwal@amd.com>
In-Reply-To: <20260730094817.1937340-2-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:23:06 -0600
X-Gm-Features: AUfX_mxydTw5HcnkETKRSem6wn4fBclSoYe4z-oVVtKa2OCOfM5UnLqjx6-G4lg
Message-ID: <CAFLszTiLbpyFPemZ9o5=s05RN9KiYVuUqvhGK-RkKt3JYQT=FA@mail.gmail.com>
Subject: Re: [PATCH 1/3] test: dm: free gpio in dm_test_gpio_requestf()
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022601; x=1786627401;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d/N6k0fqhvlRzqtyxyO03/cnC0ZSKwZaW4n6WHcQoMQ=;
 b=k8glFTNWypi9couArDbEytyIgq06R+yF4xPr+QAOlIqaGuzStpu6dAuxiJw8JZtlYU
 MaL993vsRM2lmoShErGi6Z8YqJGgR5V0Pa+2whu0RTvnZnWYnELWJJlIl3bsqnB47tXI
 jAdGN4NHacZmL1PVoCI2UCH1hWub5urJFI/pE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k8glFTNW
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T09:48:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> test: dm: free gpio in dm_test_gpio_requestf()
>
> dm_test_gpio_requestf() requests a GPIO via gpio_requestf() but never
> frees it, unlike every other test in this file. Free it before
> returning.
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> test/dm/gpio.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
