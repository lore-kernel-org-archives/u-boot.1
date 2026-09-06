Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC7EC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 20:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3381860640;
	Sun,  6 Sep 2026 20:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdKsQarFXM5c; Sun,  6 Sep 2026 20:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D58C60608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788725588;
	b=J0ohGI6XyzgR4Tq72KRTXkM0bBkpsmc9LlfvjRZA0On9fK5O7eu4YTWTFIffLmlw/YxP
	 RYn45KT/2oCeUM6rEBUdLvANFV77TZei9EeB4gULT215WEpnGdJ49AoDc2UW3/79J+NaA
	 DdLjgIlc+Ot4DhVrlpMSSbYmO58mVRCoKYGyoCudBAY0Wu8FN3aohOlCOgUyCsK459PXz
	 CZ4Q7I+jiHmGGA/L5m2IjVSDZtP+FEFhosWA3Lznnf4fJyq30ph06/bFgTpNLqhNQImKG
	 1KYNAuUqFmd7uX2Gib0Wu3AEjL57ODa/dCkLG3lE0DTNuBTt59rKquy2owms5TeQMwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788725588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6avQaSfmUA1nSy+3n/Cf4igDSWmct+2opMH4xENOly8=;
	b=Zfk94MYPP8WHb5CXXf96xGiUbff+jyr9WSGtyaWj0puDpsOAQfv7f8Gws/JaHQH8voUn
	 Dguh5kwTRdCsnAT8Wk0voO3X1Zoty21ZT7t8cUWRgzp/iKNXov1CKdi1nSHhqT8VlxEnt
	 EfLXwoN0xXJsF8tgFo8ZL9ltVEJsjfHfVSH+H1Iwcpaw+lOOGeh8msak74BK9QbxBEKO5
	 fXKmx5EaKswtguWfVPe8rgQlSRTfaYpkFpnhGCuLUPc4w+0HU5E3iERJv/jgRTN395eOc
	 VIUOb03NFDTHeRogbzO7ZgiDaGgQZGVb9+IcbD8WX9WzGakGT7CqGfN93V64AwOvCqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788725588;
	bh=6avQaSfmUA1nSy+3n/Cf4igDSWmct+2opMH4xENOly8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zLZbcgIac3cUzQxseN6W8mx4PUQhmBQkHgg7jK6WnyM5yC+iLKz5OK2AAOHDTmAf3
	 jzDSmT7XT6c5k9yME6/6pPZu1BspDhMxGfMbZhLWRQ8Ayg9zNTiul/kPQxSfXkqLJd
	 G/589Ewlt3JrQKtRqEVixX05gCUL2Ji7kBYKJj/mqUBy2mTggsdbLokgN9wqMEhVa3
	 8aktpHPMC6dPyCbGK4G/FyMAS0LPGTFdg2C5tOFiqDYZKNMqehMPIbOVX5kQlHoKW7
	 0xvBGDDry1Qy4KFyk0duiOKhI7N+oFvonzBaiCU2HXXgRAbGHRDjJ3Q0R7zHOQ6p59
	 jZfFJNzNf5HWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D58C60608;
	Sun,  6 Sep 2026 20:13:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7C0B388
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC769807C1
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltTr4Iz8xT3G for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 20:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E120D80733
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788725586;
 b=Y1ebqSsYmliLTgbOLhA6D+pcgvNH5s6dQ4rRZ57mbN51NkV3s1eiVxmAf5LkieQ2ppuE
 c6R7kQTNkvkOfFzMbk+KfsBysxd7tgcgWL+aChwzcN07kVcxCppGh1BbBSRCCCm3jUT6W
 W1L38H+fmk9kF5wW+kU43SKypEDeSdT2wtlD95g3+nqBaAuiTY24A42O2yABNPBlrD6w0
 L2B3vI1cqOLxvya8Yav55EijaEkwqigTUBOPbXM4bI908R8km+hgETZcH6URqhYsW3f7q
 iFCDt4j8rg0j/I954ilNqX30SulYg4zWphV9T6CGLfeve6hdNKeUgk4nlf8x1rcziUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788725586;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=6avQaSfmUA1nSy+3n/Cf4igDSWmct+2opMH4xENOly8=;
 b=ZNghyglqdKjqN2D+jlkDHD/uXOQ3lFP5kNWOcrSkEVCO4Eu0kGCXskN58UPX4SeQcI6/
 ZKnuNCM56ji1dLSMhfdqyrrHhO6JDclRdBlGUwz4cTG4G9h/YrLhWtWc3eeJkED+XojGV
 7rXx5pSzCMZ/bPPI2B/Rv5Xmfu843Plm18sRughVZbNtTRC8cUu8xHSPKr+ivXkK+xdqL
 XOfGM8wAhFghkmr+/ia/UYGjGT9NyZq9ZaxObfkQXpIO1P9NFH2X/9JJcwrBZYS3eGb8i
 HtYF0G+oROZuE0NekPKThqTCXWFMl2MKjKDNcNeCdLmyo529tFblpVzX0/PiW0RtPFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KoSQ0HKW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KoSQ0HKW
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E120D80733
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:05 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6b1b233ca98so2186899eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788725584; x=1789330384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6avQaSfmUA1nSy+3n/Cf4igDSWmct+2opMH4xENOly8=;
 b=KoSQ0HKWRs1DHZG1eod7YRbDmw6H5LzrkDK0fHyE6Bdmkx+Z9TlaPHbEcLho8TAqsM
 aNKNhR0r5DFzGPAc1gbm+Wfu3yB7NVtfA+SkSXREiT4nNF3CExDhGKWmR29MLC9d18P5
 I2ee5gPWplVEQa7yvFYNiUFfCP6YwOqwaxHDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788725584; x=1789330384;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6avQaSfmUA1nSy+3n/Cf4igDSWmct+2opMH4xENOly8=;
 b=SGbEm6VcjCubB9uEImoh+t/j3dhHB65kkur8u7b0JYVw4VkGFQwlRZpfA8ROKsMQUB
 T7QfpXZCgFzeQgZmpupigyEdKSUKTmAlSxhUqXEBIXVJace72kH4spW1XRpQ9coSTHOj
 F1P3P2B9j+uvAH3nVHPLt9JOYH4eiccjzp+LoMqLQqVw+tIfT3LFcsws8wWqTQjhdWw/
 Vb9sfbQD2R19y13BPOkXslj6F3xt7ZeMWaSQkGbYN3F72dKOgbgn831buIXIL2zDRqNf
 l/X4AOL+/voi26RGPm+nrqRr9TWjl6HmDVK+HInKwuM0stZpMj9Jr4zpx246GKmmGr/Y
 8a5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTK6IyZ4MxBZUu5j9CyyeIFGmQ4FjgEGuBX92lc7lVg+Euw0uCBKeP+DlaDdOa6pIQCtJrA08=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n5Z/rQ/pXIAEIPxsERpLpETxZgMpFMGENReRJpu48455kRb7Ye
 B2mKfL27JRgZ/d+/m39yXCUpNfTAigHsEx/EJqa1VukWCjNsEt1jvPzUanxViYNfhboWsLdGbZm
 il9luSvQgxwSu
X-Gm-Gg: AYBFou2B2GCE0ejoLaU2gnyUlslv61pRpGE6uNQLnG1FccmmnY8ok6c1BZaNU4ZKoCj
 oX4eoTxHdfroWP4iNP9VZ4Vvu2tM6LSnCqpMR0NxwfAw5zyIORjVfX8PzPBrscSTJ6vlhgoffqI
 cSbX9g/ODNLWpGTwDAzivW51OWBe4tEnmEDd3yhlbkLoLyLufHYXIADgS4JR8lgqg6ApQs0GRo4
 D5c7BL8Bw16wesKMDNRh6lC4uPjlt+L9+5FcCYDuKfoA8hlkWklUycTV3Nb4UbJULd/EcmPvt7u
 gRVh3dgZ3Qm2c5MYzCXqSCKz/Mo/4sNJj7hJqCLaewH2NHUZioA4kZ+L29PRxwR+gler/ECX2Ru
 uWBFf5p9UTI9pDp8Gj1bxqDFoEueQdzjrWy1FEvn+XSX0WCvGGzo0HP99US44l/Eg36jVYVo0NF
 3yGNggisJmie53rTi5+m4tGr5Ms1uREKOnlemIYe6FGe2d64lnNr3M1KxkRY3vMLfIVgnNirCjH
 1YX4E5I7WftZDjYnjXGzLDvkFRlg3BS+okL0WaSUWl7p1uxogRsT5bX1mSE2jlJYQB8R5OxWri3
 DO3+rbix
X-Received: by 2002:a05:6820:603:b0:6b7:8415:d784 with SMTP id
 006d021491bc7-6b78415d7fdmr9322353eaf.47.1788725584352; 
 Sun, 06 Sep 2026 13:13:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4762bb39439sm7039074fac.9.2026.09.06.13.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 13:13:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: frieder.schrempf@kontron.de, marex@nabladev.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260906112039.6176-1-festevam@gmail.com>
References: <20260906112039.6176-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20260906
Message-Id: <178872558309.3634654.15906945229079458230.b4-ty@konsulko.com>
Date: Sun, 06 Sep 2026 14:13:03 -0600
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

On Sun, 6 Sep 2026 08:20:39 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/main, thanks.
> 
> The following changes since commit c46bd5b2136158d3380d626d79c96827818226c5:
> 
>   include/env.h: use plain old #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG (2026-09-04 16:55:10 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


