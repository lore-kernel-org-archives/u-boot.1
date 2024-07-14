Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84250C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 19:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F4A88168;
	Sun, 14 Jul 2024 21:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lJThlXKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800DE8780A; Sun, 14 Jul 2024 21:47:40 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310ED88498
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 21:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso433330966b.1
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720986458; x=1721591258; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NbqQpRW8Nd7uAC5EQgFSwOwXb7Z/pEDEvXX/NlO61F0=;
 b=lJThlXKXmahisw69kdF1hi92TxzMQH/SNKVczERKK0pzZfVXv8YPbJEzlkaIUWuYSP
 sDjPp1EIkDkgXkLivBldLaIXL/7BPl4qHld06GqsCOdv9DjTAjkdWWyz9x8EIQ9wdpUd
 FOdGt4l2a6yfXzBGWy1G/yLMLderV+28Xmt9511kNpkZ322UzrP/e+OXtzauwpMTCN0W
 4EtivEFYFriNO8EUPWfJglSh6KlS4AbA4IohtK2434uzHFkL0ywsbQQ1HaJEr7xJ0611
 vMlHJOUrjpicnFBnyFeQb88fs9fp3O2gYOIu7/eH6FTJr4UyNd34AGx1YFOkSPLQv7ec
 1gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720986458; x=1721591258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NbqQpRW8Nd7uAC5EQgFSwOwXb7Z/pEDEvXX/NlO61F0=;
 b=GEXZthhyZIO13lPr9SryMXm1FP+g28X2net5zAU8ZcqRHx5WHi7k80Ob48w66SC3IW
 Z9s4f9QZXEZuMzBfxiAki6351Vu+cIjjHiPaUC6qR/2wrLo1pVhAvCE3NmU0rAA5Nkrp
 Deusw4PHI+rM4KIasMS7Op/VC/gw8wddLtWcykNJwXJPEhlIChu+Pf0RfnSUgK5vRe6V
 09Q7k/x9R/Xf91YaNAIb8ZVA6ppOp7bc3lC+ITyGcixMjgSxfYHhNnepesrOKQbu4fuI
 UBwY13F4jW1+iIBUMjr6q3Q2J/z/WPOsp9MbvDC7m8ZcuY+b13x/LQ835rzFON64e4yo
 Pk4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ry1DQZ0kKPZHsmkyCr5CWp8JCbB+kScCvi9IaKjv7RxCflxjHc649ZZa/KuEVnilT68lLqpuZRzla0w+IQtZD9/4cg==
X-Gm-Message-State: AOJu0YxGGrx0nYNU5Y1y6KRXpJ+8W3DN5v8RAHkaXqOObAhPd5m8NdAG
 ryrtZC51qffnJcT+X07J6F9HsPDaHwoVZit+7NswaMDRlSpQeCa0Ta4UsnJ8QS8=
X-Google-Smtp-Source: AGHT+IEkEfk0H0d+K3nr+SVovEyRWt0nXAyu/gRqO8JrrWhLpjdl+q9sbvtrgCJnikOBW1sIofnh+Q==
X-Received: by 2002:a17:907:94d1:b0:a77:b726:4fc with SMTP id
 a640c23a62f3a-a780b6883ffmr1476070166b.1.1720986457618; 
 Sun, 14 Jul 2024 12:47:37 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc80101fsm159078666b.179.2024.07.14.12.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 12:47:37 -0700 (PDT)
Message-ID: <fdf9e992-d5cd-4c04-bcbe-613fb81e87b2@linaro.org>
Date: Sun, 14 Jul 2024 21:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] ARM64: add symbol name lookup and print a
 backtrace on exception
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
 <20240712164809.GV38804@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240712164809.GV38804@bill-the-cat>
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



On 12/07/2024 18:48, Tom Rini wrote:
> On Wed, Jul 10, 2024 at 06:26:17PM +0200, Caleb Connolly wrote:
> 
>> U-Boot already emits frame pointers on ARM64, but lacks the code to
>> parse them, as well as a mechanism for looking up symbol names at
>> runtime.
>>
>> There was some (seemingly?) leftover code for symbols lookups in
>> common/kallsyms.c and associated parts in the makefile, however it
>> appears to be entirely unused and unsupported. It relied on generating
>> one long string of all symbol addresses and names.
>>
>> The approach taken here is instead largely based on the implementation
>> in the Xen hypervisor, it performs basic compression using non-ASCII
>> bytes to tokenize repeated string segments which can later be expanded
>> back out at runtime.
>>
>> This is then utilized in the ARM64 interrupt handling routine to dump a
>> backtrace in the show_regs() debug function. As well as providing a
>> general purpose unwind_stack() function which can be used for debugging.
> 
> Just a few minor comments from me in general, and I'm glad to see this.
> Please submit the next version non-RFC, thanks.

Thanks for the review.

One thing I'm a little unsure about before sending the next version: is 
it better to print the address in the link register or the address of 
the function in the backtrace?

In the example below I print the function address offset by _start, but 
that doesn't seem very useful for either interactive debugging or 
decompilation. Maybe the absolute address in the link register would be 
more useful.

I'm leaning towards the latter, but open to ideas.

Backtrace:
         <0x0000000001bb4c> do_mem_mw+0xbc
         <0x000000bb729cec> cmd_process+0x130
         <0x000000bb7213f8> run_list_real+0x6d0
         <0x000000bb721b08> parse_stream_outer+0x14c
         <0x000000bb722164> parse_file_outer+0x34
         <0x000000bb72929c> cli_loop+0x1c
         <0x000000bb71f1dc> main_loop+0x54
         <0x000000bb7229dc> run_main_loop+0x14
         <0x000000bb777664> initcall_run_list+0x7c
         <0x000000bb722bf8> board_init_r+0x34
> 

-- 
// Caleb (they/them)
