Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F416C83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFEB283479;
	Wed,  9 Jul 2025 18:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EMhU4eBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163D38349B; Wed,  9 Jul 2025 18:33:42 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38268344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso129061f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752078819; x=1752683619; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pG5N+yHXV2okdx/j18q8un/k22qujk+8O+zkRSOHqM0=;
 b=EMhU4eBHc/MEsUPsOkTFtRV+ozH+gI7svtx4KleshDvn8Qdpr0l8MAswIIYF97oPvN
 H+xb6KYx7IR98EzRdziSIq8tq8Amt/79sapjJZ4j8DcOMR6cq8vpbpCDoc8Z/auP8O4p
 X+cfT9OPoW9ISEd27pINgNmsV4LCmNXArIRNtWmFjKZbVSB3iIJMHyUEuXJF0Nw4+xe4
 ZqHJMnMZHITsXmjVOTm79pFIYyhe2IORfaFNENZTKoLXFrCK6I/4US37vOdWOIy6Xde0
 004XoFWG9joxBcJSgOCXAl4Lz4vmA8dpcVR3wD2lfzHNMmCIbPOhGqe6AlJ6TMXCU2PC
 JdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752078819; x=1752683619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pG5N+yHXV2okdx/j18q8un/k22qujk+8O+zkRSOHqM0=;
 b=dvp0rKblHcZUNYHQvNmBnPy6kPG1jpHUHUS/9n9rG4ZUokriHn8Ogp2VZzUAcSE2X+
 dhLhVAx10X0NjBAUICoFeHY5drGHQGe9CYF/vgTjWnSh2+9GblhdnRKx+ja8itmleGtq
 /WWAi6QjdyB52zJqkEHQrqjaoX65PjLflFzQyLdB/Ym/ZzowpeXn1mQKFADYR4FG29rs
 nEyt03PcrT2ShIlppEIAt2SpBbXwxkp+ZB+G9fyycNnvXinCGTvkWZ0n0wjpBxxVsD0H
 Ku3dMluwyXzQect3f38TMDcqHbKlYDCbAGAwPNiaFb3Rosp/9+tH0fpvLh2iteEmx+2L
 R4WA==
X-Gm-Message-State: AOJu0YxoUH9n/H3hdkK6L4/P/rz/quvR5ybkBRClh8akxVzwkZ4eqi9C
 kWCBJ1OiaogsEZe00wABfkHo3K6oWABp+5M9F+4mdOv73FEXXnVDR6IA0le3GsxWU2Yk2bciSaF
 9fb/I
X-Gm-Gg: ASbGncv5M3Ougf0mjUQcvnfZ6Tc54LSDuPVsd7ASD7yCpST8AYZg/CIplMkSO9HugtH
 /rxtkhQKgTGW5po9Lg/BZEAlF0nRWWOBNIsYXllm8RXCpF/dqCbunLaZf2a7TH8/oB5//ehjd60
 27L5J62iyCT5h9ulSXGSNVcImXE6uiKZA+q80dfN2uQL8cLCclrASKUEf2V8rYi8MTZBVTZr4Fm
 OyN6UOVGPyDAbywAwnRtSxJXfWGRYz2kmD7gmifSgXSLsWwFKQuo830Ex+1KDi2HOU9pM4GK3U3
 7lcMpkcnLB1dsGZ3I2DUdoddN/rgfePg5hJ8QH2PVFc7e8nVsOhqIigvKESbxTJXsb+NhEkg3LW
 HQ6xo6RA5zd90d6IXfp7/l8ZyyLRvU8PryvU+k+4Y4LwzL+xONw==
X-Google-Smtp-Source: AGHT+IEHO1nLTvbwljRdrKez07r2im57SChk8SyJbVEbs5Icq5JZsdAhubNSgHTLhYkKVfrfN6GS0Q==
X-Received: by 2002:a05:6000:21c9:b0:3a8:38b4:1d55 with SMTP id
 ffacd0b85a97d-3b5e78d7d37mr423138f8f.28.1752078818959; 
 Wed, 09 Jul 2025 09:33:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7978:74ac:133f:8950?
 ([2a0a:ef40:e07:801:7978:74ac:133f:8950])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030c2e8sm16165225f8f.3.2025.07.09.09.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 09:33:38 -0700 (PDT)
Message-ID: <6e922f7b-27ab-4e41-8f8c-baf20adbd896@linaro.org>
Date: Wed, 9 Jul 2025 17:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: bootflow: Ensure sel_id is initialised before use
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250630-bootflow_menu_fix-v1-1-5d75ced54484@linaro.org>
 <20250709155046.GA1823165@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250709155046.GA1823165@bill-the-cat>
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

On 09/07/2025 16:50, Tom Rini wrote:
> On Mon, Jun 30, 2025 at 02:25:44PM +0100, Andrew Goodbody wrote:
> 
>> sel_id is only assigned to in the case of EXPOACT_SELECT, anything
>> else will leave sel_id uninitialised. Initialise it on declaration
>> to ensure that it is always valid.
>>
>> This issue was found with Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   boot/bootflow_menu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Can you please rebase this on current master? Thanks.

The patch is no longer relevant with all the changes. Just drop it.

Andrew
