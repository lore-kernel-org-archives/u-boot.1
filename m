Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3879606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KtP3hqnH;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oRI/OhJa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E5440DBD;
	Thu, 12 Nov 2026 20:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_NPatENeYap; Thu, 12 Nov 2026 20:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D362F40DB8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794514431;
	b=SauqKPR3Rx96RcpD8vQDEdSGpqwysN3pHFUt/tSI2uTQyDjbMN+0X15a8ooz92yXhpuv
	 taqGLui206AkY+EMUDWj8LuKGVwmeadJ46weHlGUjhrTJkcSEk8Pv3m+9XB3EgUFChikt
	 6s4fhkLAREXmzCtGzyGlyhF38kaMfkGh9Bu6fLkg0lTTN1atIl+sDcRKWlZEdO1hwF++S
	 M/Etnz043WRoz5HXXfU5LSPZTNuCKLZKS96qvqPIyMdy8VbKbLH8rAH8fPA8BwsXbwU5E
	 QL80naDYV4OYrWjMq1HZNMFiHHGlf63YaO3Ay6qlKI6cwWCVv7XrzfJuQtxUyOiUcHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794514431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p5PvLbqwFqjPMUJBeT4YrNeL8IP84ggnzjLSf31Kzzk=;
	b=TSHOVBj5ODYYFQAwL7AEJ4BVwQGmANkVeQoWvwreJ6hKYhwjFnecbWaV8RWikGFIwVeR
	 pXeXYm/k5SbYVwqLu/vhWw/n1WSHtzMKtYdSk4sRE5bsP969EM5qNOleYtK2EZUcVma+/
	 70Wl+2yh7PL+8Xpe/RDAr2fkXm+4eZHi2MGhadkNIb2RtqKcGbS6WL5UyGuxEkXI6GZ4c
	 h2NERU5vhuRCq+ePryu//9UDlEgjGqRLnajkDqmJZ/sH1pMxOF4TwNGjUyt7imzW6sdEc
	 k8+EuDfZg3Uu3IB8uXsFUhAnwCSOlDiZ3AlVkKEdodV94MC8jbD4JE9vOTQSuPpm2Mw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794514431;
	bh=p5PvLbqwFqjPMUJBeT4YrNeL8IP84ggnzjLSf31Kzzk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtP3hqnH3F5ad8VvYpA5sDOE7uHCtKGKGvfWmStsBiprZHoREaVvBugDpa/CR9wnS
	 qO7i8BB+iPLw7ofyqf5K7W+pKMLy8ZQqwuXAMJtZJYZptqTVEHA2UhVWyJJyrGqOKK
	 x2YWEVC2E7KqLPKJtKOaKIss9WIAlXvEZui+AjxwfeM0RYQFpqzK0MFBz4UPKO1iB4
	 BvKVkNaOIzgGHfYsfAWMiB8aT4dGFlVkZ/Z18KY3e/dtyc6aqSnA0ZHDKVTPuAmxTH
	 xB4OyTVDh9mTd6mYfqb2BILLtGM6SMyIh49UUNkzUJcsG0Wl2Jj2uJyKrU7wFFILcn
	 5ozHnmSmiDmZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D362F40DB8;
	Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA0C12E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF9248154F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJsOv1f9EO3x for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1939A81544
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=oRI/OhJa
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1939A81544
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:47 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-86288992de5so187397a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794514427; x=1795119227;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p5PvLbqwFqjPMUJBeT4YrNeL8IP84ggnzjLSf31Kzzk=;
 b=oRI/OhJaPrlwas0LBVV5KNa+Dj6XVawWwNbnXJyt95Iq2FFzKVLjMPHkLYigXvAfXM
 lxacWbu5eVsKyONI9YrX0KSZuJ18peh2ydYVHIxO7r72XR9W2xQbNtOVJjZEkW4cQE1o
 EW2qLGiiiyRQFBqpI/uc28ztqGVx8PxdjCxQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794514427; x=1795119227;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p5PvLbqwFqjPMUJBeT4YrNeL8IP84ggnzjLSf31Kzzk=;
 b=CTdyxEpa2ntLacttkxk3NiM8DYOdCzogRcCQgPDTTABb5Rxdx95KTejXfRRtL6W1EH
 LCS+ccKVcV/nyrgQmpaCX22NpxcNgF9CJHfJUdt8rW9HW/fr+Gk0bZC0O6Ngm/zb8XTT
 6SvzvYLTd9MuBLljODa9bEhl15AcxGv0KzE7DfRllnPsRVzw4UV3tArc1L6GxhiRzTYe
 WDcsTIZ6wF5goIL8VlYjl+6DbVhvpYpw4yA3eEH3dHjazN8Kd8HKt17JaJ5u32ZA+BEj
 2gvvbI7xEe6AVZVo38cUskcPRq7M9hk1kYuPVbiVUfSK9IWbTOSMech3Ecb1v/4JQiH/
 rgDg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZqWjZ6icXERqIK3G0sJ2jWT5TLg+8kFEmR+SGurOnTbteYss8ThYX0QXMxlXYeq5/ndi6XbY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84u/7f6wjyU3m9fKZEXrFjVl+FFo/oKovyAadXBQEpZaSMmfd2
 XLr1mjLQoJWX0F1k2lwIr6Xm8Wial6QbfrNMyfHMVoNrPNg75QKInX6scL3Ri9p6tEOV2S2NeC+
 9PzbP9A3F1mIz
X-Gm-Gg: AYBFou0PS7LxclEES6LEN0cLlKU1ySRwA37K0ogStGQfmXVJQZbsg+K1fZTUqApXkNh
 wK7v6xVlosgRvGldcmGLlMb6Xc/SVSqmE8Rvob+894dRndPYGqmIL6Ufy6jcDvP4dfkKl69gWJT
 fw8hRScgtxneAmTh6nFH/H3onAE3V4YKWhNtT80yrFgctXa3dK19Qjy5tbdYwWgLl1N0sJsGvxR
 PcSdxCxcWREnZF4a1kr49eYMcePm5rWxtMQKK2cARgbvllmNihS2RsUzvyvnLLJKtKJkUZMkFfL
 rceUGmtRM4S9BNVqiyFgGar45rHOsAXT+AfscYbAjccYTsGNyAn/OwXfkqdnD6is4EvxluMsi89
 A1J9Fcm6P+bIEK3v49iUmUIcytLQ5zSbnc87P9hAEkhQtsekjvF0+2JmC9BXh2VKDqALXYHbqFF
 hurIquxLj3vLl2MqcslOBDjYTCjRrd9qpwgUR+m9X5CUTN8WxM8+Pho1Vxi8YOxZLSe2lP65Q1r
 0wjF00pVEc63M0WFc1ZgtGS/5pXvEmjz9IfiQbnYuPHdMdcXHmzq8EbLLP9AQSqIIsBODTiGXR3
 EBtK6W4WZBxsQzqd58vyoeX4N711WVUYFSmg1Ol46Q2z60EhICf6iXffWPhZ+AC2HXCiro3Zhj+
 FXgv/TPGCIT1LYmRfaa02e0Kl+Bq0Veoo9BDAA23CKuZtbchR+61puh0peqOnK4J1QbwcBDNUFC
 GENwMzhg6ON55isysnbu/rfnzyNSm+Dg==
X-Received: by 2002:a05:6830:b16:b0:83f:2c3e:e157 with SMTP id
 46e09a7af769-8628982e083mr202663a34.9.1794514426882; 
 Thu, 12 Nov 2026 12:13:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm613222a34.8.2026.11.12.12.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:13:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 u-boot@lists.u-boot-project.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20261103014031.683345-1-mikhail.kshevetskiy@iopsys.eu>
References: <20261103014031.683345-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] airoha: an7583: add missed definition of
 CFG_MAX_MEM_MAPPED
Message-Id: <179451442624.966571.76605083023968324.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 14:13:46 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 04:40:31 +0300, Mikhail Kshevetskiy wrote:

> Due to a bug addresses above 4Gb limit can be used for 32bit DMA.
> Add missed definition of CFG_MAX_MEM_MAPPED to fix an issue.
> 
> 

Applied to u-boot/main, thanks!

[1/1] airoha: an7583: add missed definition of CFG_MAX_MEM_MAPPED
      commit: df477e482e94ee5847be5f5f49fe996f88773324
-- 
Tom


