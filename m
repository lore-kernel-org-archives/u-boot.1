Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5475EC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00EB85F9F;
	Fri, 25 Aug 2023 20:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E23PYrQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3D7864BC; Fri, 25 Aug 2023 20:05:40 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A3F8468A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so951466b3a.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692986736; x=1693591536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZdJ0DcpYRfRw2x8S5rleoUYFCdURgeRij3t0DUWaG4=;
 b=E23PYrQWc/JuE4/0UyvZiw9JYtJ5/1gUCDSMKEtPosT5uwidO2KpIl7JHrLXLUILbJ
 fwRT8NgWkx6IcS915XhSQxY7CcVBS8VWrfpOVdLvC7bSjHNRfaX9Z+7MkU9RK/7nMQnU
 W4fNZs9w0p0bmtBt/hAjysKp58O1PIWpScQTq0QgG6zf2tP9CELm6g0RR3VMrZXY4qE7
 CP3/BWqxVL1cKnC9F5CUZxr3YudtcohorBWTx2p42GPOhk1QYV/exWYBeKV/BpAOZeKC
 TY3BZbFb60mvSt9L8OhcY6kUBaQE5SgKpZL/6KwLCp5s+NzTPn3sx0Rv9AncL6a1cBnC
 PmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986736; x=1693591536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZdJ0DcpYRfRw2x8S5rleoUYFCdURgeRij3t0DUWaG4=;
 b=lHJTsheoq9clK3OwG3AjNQEQVX/opougxo+Mj9fiGD778UUjFvS26ag8xkOtBQoMUH
 Vt+uWxbsb+yADlwJkpwRoDlPtNhVzXJeEgDtyASAECs5DyibXZMZfKx1i0icZtGvhFF9
 nsv9snKXADAJWO1XPNAcpVqsPffZXb4kCQdwx0QZf8mP52qmUDa7AFksmKxT7G0Lh3Si
 qNEVtGg1hJ8ABmDb2eFOPe3C8KLJcFQEmS3MrSjYGbXlF+Q+QK9sGD+kmdRf1bMf0OFK
 XVcp2uUj7ooHcv5iLZk2enRUCPbZmevRNzvT2V5yqQ6o9HBdPmOsxNlAP1Pzd9Ixmsd5
 8Eug==
X-Gm-Message-State: AOJu0YyHsbelGgevTBoSGfSopG3Wwtm6djRqwtmyPsSbc+eRcrOG5Les
 Nzr6ZYDbsh/hEE9XN0mIOGA=
X-Google-Smtp-Source: AGHT+IG17sWNu6TXv7sGT9vZ8N2JQ7kcazdNXHwpkGWbe8DfYCRJbUz++tE45j9jrqhC2TZGGDo32w==
X-Received: by 2002:a05:6a20:7485:b0:123:828f:68c with SMTP id
 p5-20020a056a20748500b00123828f068cmr20074667pzd.50.1692986735603; 
 Fri, 25 Aug 2023 11:05:35 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 k5-20020a170902e90500b001b8052d58a0sm2024060pld.305.2023.08.25.11.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 11:05:35 -0700 (PDT)
Message-ID: <69909b61-f57e-fc91-43a5-0f4bd23609c9@gmail.com>
Date: Fri, 25 Aug 2023 11:05:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
Content-Language: en-US
To: wens@csie.org, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Marc Zyngier <maz@kernel.org>
References: <20230531201520.15479-1-CFSworks@gmail.com>
 <20230814213854.408962d5@slackpad.lan>
 <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/25/23 00:20, Chen-Yu Tsai wrote:

Hi Chen-Yu,

> IIRC the GIC manual says that the secure bit is set or cleared to select
> which bank of registers is accessed.

Which secure bit are we talking about here? Do we mean the *configured* 
secure bit (SCR.NS, what the code is attempting to clear) or the 
*effective* secure bit (AWPROT[1], et al)? The distinction is important 
in monitor mode (where this function runs) since there (and only there) 
the CPU core ignores the configured setting and runs in the secure world 
unconditionally.

I'm guessing it's most likely the latter since the former isn't exposed 
outside of the CPU core, unless the GIC has some special signal going to 
it...

> And I suppose it is here to be more robust.

...but if it is the former (i.e. SCR.NS is significant in this function) 
the code should be retained, but moved *before* the GIC register 
accesses, and the old value of SCR.NS should be restored *after*.

Either way: I don't think this line should be kept in its current form, 
because it's written in a way that strongly suggests that we want to run 
in secure mode after exiting monitor mode, which is flatly not the case.

Happy Friday all,
Sam
