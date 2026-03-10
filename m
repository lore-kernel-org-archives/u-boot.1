Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BFAFCC9D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 08:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FEA83981;
	Tue, 10 Mar 2026 09:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="dUYcoDAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC63283CF3; Tue, 10 Mar 2026 09:28:16 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66E083952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1773131293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4Cz4zfh3NmMDp7rrcuFBhr0GL5u1QJ8w+6K23eS6Vg=;
 b=dUYcoDApkwWggKo2V5TiZtN7qCijBeNDAt4IrXUYEGxbLC5cAUc8aWTeSteKQQ4O9yKzfs
 imKXYrzy8Deb33fdvJdaQSD6DNpoe/K/cn88/63nMY0RVp9mQU8zuHgKqcQnocdbDbtay9
 p8epS7tsor/ITt0wGKlFqIJ7WyAjFFM=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 26ce71fc
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 10 Mar 2026 08:28:13 +0000 (UTC)
Message-ID: <ff44df05-654a-43e8-9ae8-9e3823930ecb@kernel-space.org>
Date: Tue, 10 Mar 2026 09:31:47 +0100
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

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

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

-- Angelo

