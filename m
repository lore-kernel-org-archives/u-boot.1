Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895DD149D6
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C77188E88;
	Fri, 25 Oct 2024 19:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBF3SI9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6665989024; Fri, 25 Oct 2024 19:09:57 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B4488E88
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43155afca99so22937385e9.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729876190; x=1730480990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBRRDxeaPAzxQPB+6mR3FSgA/rlVH7DS3RaPBmk5oA0=;
 b=aBF3SI9PJxsXeQg7abdCMEKbhehKzYSa0VwuxxF9uGYoFyFOK3X/hmO8JwMnhXT/J2
 NeCSYiVbQicO18vCIwgcyAqy/Wb0EuPF3EzA5PgNkLo8J+sVcVf6smognu3E782l9ws0
 +iozDavSNC1z6bOH0ssvZ2+aahEiwv9CiwxZmnLNl2s0XmTZpyrhTJXVS9N/MedSaPLu
 AJFul9HFo/M7cmL6eed6eY2u1zym6AAc72GbzXpdHMgkWlyReqMDZ8JIuVQ5+JIVZbLr
 pyAZENiLqz19cSHL73qpvfH1DQniduvU57phsX6FYiFuavW24mDDVnVwShpEooX+8KV6
 rn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729876190; x=1730480990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XBRRDxeaPAzxQPB+6mR3FSgA/rlVH7DS3RaPBmk5oA0=;
 b=XmRGFzk4qH1xkKaeHPmOlE0yPrKl5V4Q4LRhKTBvKsU575ZLs9u6K7htjhJkqOe2Hq
 rjPr8xKJZmSI4FPyovtPZ3B8ki4DPn0UMA4ua3VPZ28ReQ9ETCXOozyvu8Z/eXRTjqYK
 J5JGjWNyw+ZSXKkaqs9SVjOCtlGK2NgMXhRJk/EHLLzOiqwVvrdIan8R3ymYnEKs9fw+
 Nfo/jpPGCsrixvWjGnabPTC2IIbrluXNOuHSqTLGECpV6VKmBxxSvdbWgJGgE44LyqZf
 6hJzUo4P2UPb+DPiC2kpAy3nwKLxPX0BXTX0Q67bQrSPFgqDETWWuSPEd2fG5QVb3TdT
 V7/A==
X-Gm-Message-State: AOJu0Yz2QnKy5oXl6w9g/NeTr2GMrKJtN0MElT3Qq/8Wiy8ETWxcQ9/U
 C6zVcS8IXvatDi2/V1/HxuH6wyxqCkmd0HitIA9PqANNg6l7vyE3toTlwB/0trM=
X-Google-Smtp-Source: AGHT+IFxWNY2+E0LfYK/81UB+fdQRnW/D8Hm6Jk9Afpag4+76dKefC5tSy4RnJ5wK7nDOgwRLDmjNA==
X-Received: by 2002:a05:600c:4454:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-4319a57689fmr2518865e9.7.1729876189879; 
 Fri, 25 Oct 2024 10:09:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:edb:fc01:ee89:e818:eaa4:afa5?
 ([2a0a:ef40:edb:fc01:ee89:e818:eaa4:afa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573d47sm23766065e9.3.2024.10.25.10.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 10:09:49 -0700 (PDT)
Message-ID: <b463d1a4-3f5f-4079-89a0-2a43d2a89a36@linaro.org>
Date: Fri, 25 Oct 2024 18:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: efi_loader: Fix dependency for http test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20241025164732.73121-1-andrew.goodbody@linaro.org>
 <20241025165639.GZ4959@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20241025165639.GZ4959@bill-the-cat>
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

On 25/10/2024 17:56, Tom Rini wrote:
> On Fri, Oct 25, 2024 at 05:47:32PM +0100, Andrew Goodbody wrote:
> 
>> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
>> of BOOTEFI_HELLO_COMPILE but the dependency for
>> test_efi_helloworld_net_http was not updated and so is now incorrect
>> preventing the test from ever running. Fix it.
>>
>> Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE")
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> And I see arch/x86/lib/Makefile has an invalid reference still now too,
> can you please fix that as a follow up? Thanks.

Patch sent.

Andrew
