Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97081C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2798E60B51;
	Fri, 24 Jul 2026 01:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eIn_t_FhYqFq; Fri, 24 Jul 2026 01:02:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DE0360B2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854944;
	bh=OtZh6D/ucRMoorwCz9oAiwaepvm8TgnhYN7tqqxM5bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B6XEBzYRXlvSoioVzT9gH5MPzpSstYyk8jaFbY3bbyc7Hir/9C7AvJJIGJXjP1WmQ
	 OKJ6uvetAVpFc3wL8HS6NjnB+eRkNnrXIc5R18SveV0eLvdnj0FKqcXu6tKdQSAsxC
	 dKl26wHbIRCx2jpM4hoQ64LA5CfQOtd+4IpTVpv/9YCQiqNkvUZxGHNaHDX0pMMidR
	 aZXBJV2/zJNKN4jhDO1l9MM02ffkaEv/SySAjJjWs8Vwd6WDl7wFGpIws9EmyeiI0r
	 oy089SWFOxOtDP27ankm2S6cLDITdyzAK6/D4k0KYkmqJxYWGmdaj9ZtxgQx7Sa50Y
	 CN66eALHcqhTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DE0360B2E;
	Fri, 24 Jul 2026 01:02:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE3893B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE38D60AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sNiXmJkvyPZ for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BA7B260B13
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA7B260B13
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA7B260B13
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16878848BA; Fri, 24 Jul 2026 03:02:12 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0805B8063E
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:10 +0200 (CEST)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb34c17b96so829473a34.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854928; x=1785459728;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtZh6D/ucRMoorwCz9oAiwaepvm8TgnhYN7tqqxM5bE=;
 b=rVKZR+wGORSi/ULfAMx+jTsISzRh8SatV19TYj5hsNct+l/HAb+DmjLNyvW8AMJXas
 TtpxAQjgj9axeBgFp99WbI+waQXd64S36NgmKCbIse/+fCXGkxO0w7xkoSk27sIlTA7y
 s8VeAcJg/5pRbBaw7hNPmyEHs5Tl4nayHMv50MjWAGWbkVuKWg6ov6NPZyCeh6L+NeaX
 NtAutBhQb3SBwLwmurq7rgN6tkhS1utCjnqkoCxX4NE6G3qOiQabZHxZyjfTB1BXvk4b
 nuKw26JlyI2UffZ7gp/rvGjv7VXNScOUAWANPA9mCCpJr2yOs5z2C38p3n2GSJ4ZSupy
 isRQ==
X-Gm-Message-State: AOJu0Yyo4LG5QlkLLTx+aXEUj9sicdEhLWwqqkIj31DMQbVgUEhq4XC+
 CpdxPmgdNbPZFnW8bKyveoa14fYqcSQcYC4yZBiheXmfovPDJMtHfU3oLoL54+F1jVk=
X-Gm-Gg: AR+sD10hXaiX2C/eAk5/SGeigPAQ4r6p6XvSdYbjUJr6QgHoimIJrQFd2oe22dYjtc8
 WeZs5HnkaNZQFl40sKgX9dx9iIWwIcODLp71QMLbioyDNy3BIs4Jfsgi2XMrPhBT0Zp596gnRyC
 zRcMLRULHPE8lgS2HsTaDYXFA8apJG0Dc7MdTZ0NNAYxV1kZ31i7sHq0WY9yM28qrOU4jgW/CE8
 Vq1gXCIB7g+uCvEUyOvWHpGK/SewBenuXYrvKnSI4EW4rncN8pQb1A2lr3q0tHRx3xkKEobGit+
 vvLjTHkHwJC5vUtVc3kmt4iUph+xIUKZN0Ti2PNk4uZpUNXrngMXT9wvfzO5NRlpV7sA6Z4YJX/
 cfBo5gfHJ1repVfhpg3hFyZpgIFw0ZhRC06ylLtH90FGvzvGQyGnt0OrN6Os57VUBjVhlmD3Vrq
 NeMjQTg3tU4IHRmfg1Aui0Jx+NCkfzSQDg9eFCjLyUdMJov97luYNQDOyDi3H81X8RXDGzZ5oYh
 jQ96MwzrLQ2kEtVO/jwCfXbeQ==
X-Received: by 2002:a05:6808:180b:b0:485:48da:133d with SMTP id
 5614622812f47-4ab352f17f4mr2485282b6e.10.1784854928625; 
 Thu, 23 Jul 2026 18:02:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, michal.simek@amd.com, 
 Akshay Belsare <akshay.belsare@amd.com>
Cc: git@amd.com, padmarao.begari@amd.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Dhruva Gole <d-gole@ti.com>, Simon Glass <sjg@chromium.org>, 
 Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20260708111721.1455945-1-akshay.belsare@amd.com>
References: <20260708111721.1455945-1-akshay.belsare@amd.com>
Subject: Re: [PATCH] arm: armv8: mmu: fix DCACHE_OFF incorrectly unmapping
 region
Message-Id: <178485492688.3246206.2067075014234729262.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854928; x=1785459728; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtZh6D/ucRMoorwCz9oAiwaepvm8TgnhYN7tqqxM5bE=;
 b=K3T4PBYjeQldD3StNGTMyj2yKbgWnS6dg05g9Sgylz7bSOJkjrAnd3HDadmE5u+GUN
 fc8/HYLnInYpZGXN2m+dIJKRpJ+fuQcAkj9LT0UnoKUk64Kx7XP9xxxLuoF2ibZtwYXr
 FRbB/9QCn9Wokz8D9jFPlVtdYObJ1DRcB5NIU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=K3T4PBYj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K3T4PBYj";
 dkim-atps=neutral
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

On Wed, 08 Jul 2026 16:47:10 +0530, Akshay Belsare wrote:

> DCACHE_OFF is defined as (0 << 2) = 0, and PTE_TYPE_FAULT is defined
> as (0 << 0) = 0. In mmu_set_region_dcache_behaviour(), the cache
> attribute passed to set_regions() is computed as:
>   attrs = PMD_ATTRINDX(option >> 2)
> For DCACHE_OFF=0 this evaluates to PMD_ATTRINDX(0) = 0, which equals
> PTE_TYPE_FAULT.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: armv8: mmu: fix DCACHE_OFF incorrectly unmapping region
      commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
-- 
Tom


