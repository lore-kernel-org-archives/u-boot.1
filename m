Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E681EE937EF
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 17:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2BD8352B;
	Sun, 12 Apr 2026 19:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="ATkxXfYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AF8839D5; Sun, 12 Apr 2026 19:57:16 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961788341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 19:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776016632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvcOqF6/gHCXxqMqbBdv7tOFwmrmqkrqFs0gFDyfZ4s=;
 b=ATkxXfYvjgJ4WOj8Na6S+4PrXOK4hIXxNUJP48UvvLYyMXOp+rxWUDe+RMxBck02sF3TcP
 DZRbP+CuvbDIg3qdEExNfYepkpeAHk2FpDQcnUiQ9ozop0Kr+e8fcgrgsoFXQIZrrJNhhD
 h+4XSp0mt1qybjVDQLKF2vTbWxUAuq0=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 9121a809
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 12 Apr 2026 17:57:12 +0000 (UTC)
Message-ID: <54e502bd-5ca6-4ef2-b162-fd7f9b446aad@kernel-space.org>
Date: Sun, 12 Apr 2026 19:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] m68k: m680x0: Initialise the debug uart
To: Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>
Cc: u-boot@lists.denx.de
References: <20260309105110.672832-1-daniel@0x0f.com>
 <20260309105110.672832-2-daniel@0x0f.com> <aa-zE7bNzY8wguoi@google.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <aa-zE7bNzY8wguoi@google.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Daniel,

On 3/10/26 06:58, Kuan-Wei Chiu wrote:
> +Cc Angelo since this touches arch/m68k/
> 
> On Mon, Mar 09, 2026 at 07:51:09PM +0900, Daniel Palmer wrote:
>> Once the stack is ready we can init the debug uart to help
>> with debugging so do that.
>>
>> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
>> ---
>>  arch/m68k/cpu/m680x0/start.S | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/m68k/cpu/m680x0/start.S b/arch/m68k/cpu/m680x0/start.S
>> index 0802ca1fca2c..fdfcd66f7785 100644
>> --- a/arch/m68k/cpu/m680x0/start.S
>> +++ b/arch/m68k/cpu/m680x0/start.S
>> @@ -42,6 +42,11 @@ ENTRY(_start)
>>  	/* Setup initial stack pointer */
>>  	move.l	#CFG_SYS_INIT_SP_ADDR, %sp
>>  
>> +	/* Setup the debug uart if enabled */
>> +#ifdef CONFIG_DEBUG_UART
>> +	bsr.l	debug_uart_init
>> +#endif
>> +
>>  	/*
>>  	 * Allocate Global Data (GD)
>>  	 * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
>> -- 
>> 2.51.0
>>

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

-- Angelo

