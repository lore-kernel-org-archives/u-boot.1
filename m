Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B8CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 20:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1E080107;
	Mon, 18 Aug 2025 22:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dXPBAxry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CD3801BE; Mon, 18 Aug 2025 22:15:27 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD728006D
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 22:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-435de818a74so2494337b6e.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755548123; x=1756152923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coOm3O0yXKOM4a1Bcv/EQasJBk6A7FpQju9oy8EEiGw=;
 b=dXPBAxryDy81gMdQPl4ltHdjmTGSFXNJioe4ISjodx57QmJerf8LUFYzSM3agTrbUW
 fuYVQ1idbVD1c9SMibjksp2dfS0m1SHJpOKMxqCmpmarsvQ4C5OpWM8IwQc3RoaVAls3
 ZpGL9RDdNAcW2ghbKljvPi1UtpwZWqM6x/n3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755548123; x=1756152923;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coOm3O0yXKOM4a1Bcv/EQasJBk6A7FpQju9oy8EEiGw=;
 b=Ha+/DuodGTicjCX+v9sa/OW4D1GVmj/4HAFbkvpXh5g6wUj1EyjMj47ke5Wo47NQ4J
 3Il2vHVM0fwr4D8K70YazyENaxRqtyG8zg1NCEo3J0oWex9jMlKqm7Tmfrkqe1+I0sOK
 /zfZZeN2+4kxDHrLkipHAm7H+aq6LZAvq6eHLclFysG+PuTQBEe/yq4PTrVdjIC1zp/J
 aU51jEh8MF+mfBxqJ9r3jjKH1oIUZg2MiX1leLKnYT+jLOQS2hExN6OC//Xk/Fk+ToRf
 qtmQMK+4YpTjVx+kOnOxXvtiao4g6zhGzdcIiSwHoNj3A5iSyHxVhQ2hMFyLgEwibIJp
 eAsA==
X-Gm-Message-State: AOJu0YzaoTvIjDwhh7BXT0/63IxlR3tg485cVQkg69r3Cw/5c40XCLt7
 NeLdinG4e9agrRvOA6R1GedeZQresUw1UQbCCdWQqteQ7sgbV/qwqbbapdFe0WPf1uok1EmZKQz
 46u4jcB8=
X-Gm-Gg: ASbGncuaGJm2+2aSFsOjP0otCOM2dDt0eSsYNpggWLYUaexCVLuWLHD+fIwu8O207u1
 tRTzEgB2VyIO5mV+PHns/qdtCju8KrbtQD8rw4bXqflJwsJmSTWFtwkJ691GLDKBRliVI64H20C
 /ETp4/TKvfSWbOVVNcMNGL4Qb0x/II7FQJjxpDKRkFuqiH9o+QBHkBiGBDLXulbgjHuEYWT9NKK
 WFx8GY18vGI84gNATT1o3fLbGQB1+L9giLQH/yjpEbybgXxnnPT5QIU8utuOE2zj/mDKCZRDolm
 C/ueLx5G0YKUwwt0F/5pM5cXrQBdIyyJBY5oq9ZyP5eM9cwGlQWiHCY2fSok68qO7dhQdtArzns
 q697kycfbiXo7R9HvxUpOyIsvekKvBhtYikjGy5KRoAjMBaMPG/RxD/A=
X-Google-Smtp-Source: AGHT+IEyjm/59YkFJIby/QwQXCjJFp6HZ+GPjzx30/cwAygtTJjMcjzkx4WzngezfHhf0AyvGp0gOQ==
X-Received: by 2002:a05:6808:144a:b0:434:21c:e14a with SMTP id
 5614622812f47-436cdc8d2bamr65162b6e.9.1755548123290; 
 Mon, 18 Aug 2025 13:15:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ed2054fcsm1925397b6e.31.2025.08.18.13.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 13:15:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <e31cd4e9-78f5-4876-ae28-af5eda292cb6@linaro.org>
References: <e31cd4e9-78f5-4876-ae28-af5eda292cb6@linaro.org>
Subject: Re: Please pull net-20250818
Message-Id: <175554812239.3213752.12430847474905544764.b4-ty@konsulko.com>
Date: Mon, 18 Aug 2025 14:15:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 18 Aug 2025 17:02:15 +0200, Jerome Forissier wrote:

> The following changes since commit 0c558bbad9e7581808b358091d1fd979f860e8ac:
> 
>   bootstd: rauc: Change global method to check any partition (2025-08-14 09:18:43 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250818
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


