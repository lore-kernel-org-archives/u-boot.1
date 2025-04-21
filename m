Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C39C369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E31820B3;
	Mon, 21 Apr 2025 18:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="evoz4Fdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302E680BAD; Mon, 21 Apr 2025 17:00:49 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E110680584
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 17:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so3124510a91.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745247644; x=1745852444; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=79iOO8KLwnj2KcWhrGqhM/GiSlx+9DDsYwhvLIcT7WY=;
 b=evoz4FdpVZFpaPuqiEd3r2wgqpS6L/b/69PYau8K2rxGp5IHoTYsr/408NUIwpUwd4
 uQQ6x+zE0UeBshYtDcuCXPuUXvvkl1fU00JfX931yUYO7aUrgT1JmjbPjMOVHosM6n53
 vN2UJ9jf2fuopnBPx+T0z2MfDbkZk/kS13xFlSQhAitcuijOC3MCROkqnzjiMKp82PzU
 8iqqBAL14LgwgZe7dP4HN6ukZkGoitF4aJUkLiAqYpw65uMzww7LrF51O4BpojNAxLKu
 7F/Zz4oRPoj5y6tRfwYkkynQKTrox2Kt/fnGZIGyQzqZ0Eus1P/dSjes0zrYI2WuuGJ1
 8XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745247644; x=1745852444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79iOO8KLwnj2KcWhrGqhM/GiSlx+9DDsYwhvLIcT7WY=;
 b=cTWWhgDyUZK0SRksNZNwMvkkATOn5pLJuehaYSWOB02iDP2x0fTg1+0QerA4tOfLxf
 n2aKCLiinjydLWtnLmYIBsfcotZYA8I38VcQ2oMeZpOoOqi04og2xaNCbtF9u1bUkO4h
 J7VD7S0EluXjsydRDzEx4NLQni90D6S2YuoI2aA7mtfgWZWW2Mpsq41exSdfL/EMD9q3
 Dw/o3jjuUF0NO0BolkEFPeTliNPLxvRvKSIvHExbbvxtRT490ojY5JvJHiJNYDQMx5Ql
 zmB9rG35ufDB5o3yOPRfV0nclwkmkqzwc87n5EpFRJLVRy1ELwpFcMabuClst1aVBWoU
 LDEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzXOJudhgPfg+ba/pO32KKRWj1xA6VXWkgsEG9APY9z3WZY9AvZ72C7Ao6G8mnSPdO4gSMTq0=@lists.denx.de
X-Gm-Message-State: AOJu0YwSim0Nty6cluZDPahO0NbstoZ3ANkom4m4C4CiohDfIhthE+cn
 SLH/cfRfub/0l6FvVTICVxIG7vsOsFfzs2vskqD00JAPeV32pOES
X-Gm-Gg: ASbGncvXsfuI1iNUt7tEtshFJcwgaC6k2amQuJTBY05tWstKQCo98nCHH6SqIfLm10W
 7EU6YmBUy+yoidbcereW/lqNc8nWfFwlindWE0MI98IiyjljAYY8knc8UBD+Bjh7mYmWJk2boDk
 KkMMCLBG4pXLg/pb4bQPDbWzqDwsor8qW+Shr6k+Lnq3ipzFov2KIEFv5i9bw8uo7k0detQXlNZ
 lnrmTNRU+C5ZarjkCb7fqX0G8DH8ObljeZDWq2JYBfkw1/avy/6DayfhEc50nt9AusKrUzXrybj
 lLwLYqFyjZ82U0ZPQwxr9z1xKBg1wZqvdfPaYD+QsfJ9/OP/J1OOjrFAauuqUUdojzDMLK0AZ/E
 GY3VHyU14wKqoAJd1NhKK+XiuUA==
X-Google-Smtp-Source: AGHT+IFOGBIUgqNDL/UgGSpsH/c3OaOYn3AdFyru5sCNq0363cbxcso4UrG0YJgKV4gT9PYZLz6dHQ==
X-Received: by 2002:a17:90b:380b:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-3087bb3e794mr18062980a91.2.1745247644308; 
 Mon, 21 Apr 2025 08:00:44 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df24dfdsm6659405a91.23.2025.04.21.08.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 08:00:44 -0700 (PDT)
Message-ID: <0f8cd909-b105-4d54-b1bc-0adeb4ca0051@gmail.com>
Date: Mon, 21 Apr 2025 23:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>
Cc: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, ericwouds@gmail.com
References: <20250406130244.19496-1-lucienzx159@gmail.com>
 <eacd3b66-0262-4bde-9b91-6ca7eea789fe@mailbox.org>
 <2aa57092-f844-4ef8-9b97-0998a697c0be@gmail.com>
 <aARRJ85ULmqsYgPo@makrotopia.org>
 <e011b2f3-afd3-425a-900a-db0ee4ace166@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <e011b2f3-afd3-425a-900a-db0ee4ace166@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

Hi Marek

Marek Vasut 於 2025/4/21 上午 01:55 寫道:
> If the firmware size is fixed, it shouldn't be exposed via Kconfig in 
> the first place. Linux doesn't do that either, why is it done here ? 

I misunderstood this part when I was porting the driver. I'll modify it 
in the next commit,

thank you.

