Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375DC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8FB800B3;
	Tue, 11 Feb 2025 11:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C8N5qro7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9042C803CC; Tue, 11 Feb 2025 11:16:46 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1A380079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D745B3FE69
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739269002;
 bh=zjadMIxKuKxIkseNPykxOppDytEv5nXIcpUr7Svijhg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=C8N5qro78/hXCxxpr021veWgY1MPqoxRLXjcvuhaBeHBO0unx8VBaJq+SPB4ei7Vh
 xpN5hwrVwl7PAve0wWmwI/qY6sBpucuzbuZNJu01hFaiuJS0FmC3wan/jqYQhuC2bg
 NC8t1HjyMeXCsn4kYrWl/new3+54BHrbIUsbytdBlzbrLeZD+kYmcKJEfbWDmliU37
 ZcZ9Ls0v7X2QwgbSLkYxWox+XWELuYJcTs5jYdE68t8wje4C7GLPQaORHSiTJShSQN
 LdNNAXXPAmDPArx0SqypGMCy2Fv4/BfksAU6dY3T0oXQygvUKuHtItEKkdCwaPEvJb
 nGLN9XUakJS3A==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dc709f938so2089779f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 02:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739269001; x=1739873801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjadMIxKuKxIkseNPykxOppDytEv5nXIcpUr7Svijhg=;
 b=NNvKBD8swPfETEI63hV7oJZDPMDZh4ugXqaXwNna3g79A2L1Q714R2yMOj7bTc5JoO
 Ss/3JOlO6PWjkRcbX1ydROJ4clzjz0BNrEah1FywsNEv3w5/rL8EV+1VedoqLBjQnUH6
 d//TpVB09aJpq8x/HLSyopD3+Cb2SeeLJppVDZ0Dwsb/H0IwUX8+fCIgHN5UhKSeuImX
 kKSk4mDXN3rJA5gwDhCAajb2d1cU2hgpn3uPPMTs5YsQ1fO9jajM/dnFE39c4t2IiS/d
 xxYcppEpaUJEYdolT9O9KsefCKkyvrECVg0CHDq1mDGwH3eDteNCUDUBLyOVyOeDjUAg
 TBzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXivMFp1jyOzYXwSR97V1U/ATN19WAaMyRiaYpTsJgsPi3BPHjo8Fe33rREmOtwXpH0lY86Ul4=@lists.denx.de
X-Gm-Message-State: AOJu0YwHn3gCQUe8LcfDtpeihODGn2SFsotGKFT8dt3GlolFUhEQrdIn
 slhX1o+JPUvVu26QJpeofWTsK7LGrHP9TreosZOYPcEywNC5nbARY2GAacAR1rX/SrceoIsN3TZ
 CU+7G4XXPqXEZFotrLV7L21mGNvcmI3IPPErXXjC0pUnbAbJ5yLTJHmS8X2b7W2tJq4E=
X-Gm-Gg: ASbGnctgWGA/wUdB4hZtb387h7D07seKyU8gpCYtxZCoVz6dheyKEUgyS42ZUgDGYDA
 qrfbWzDW5AdcgaKRrAOIL9PSzjDEMaYSHQ00prFV/LpLtausQ+0OKrHsLIeCvGN8DNHcWjXESC5
 SOkyuJSr6vObHA0X/hjc1a5gKMC4TzcScJ5EUl2FH/HkszzB+ZUj14mFdcEWWpXn+XljiMCcFgY
 D+Hi6nkrdAnf5uKDv+ysKNrGKvyNmObvXPYU8ff7by3tpgKcVuP1fSvjBKiYEXBSbla3HmtNJet
 8tBgWOVvCjcnSOungWsX9N9XbfrU6lLONcG6WaV7BUfo2naF753RmmxYxpqYrW9Nynq4/2oTSeA
 t2Q==
X-Received: by 2002:a05:6000:2ae:b0:38d:d026:5af8 with SMTP id
 ffacd0b85a97d-38de439d62cmr2435139f8f.12.1739269001336; 
 Tue, 11 Feb 2025 02:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKSybfmuhGvOGCGW54OWvc8QBOoYbycvOg+/48uoFUod3HIQb9gVOcg+JkMY8Md1nzN0RJcA==
X-Received: by 2002:a05:6000:2ae:b0:38d:d026:5af8 with SMTP id
 ffacd0b85a97d-38de439d62cmr2435118f8f.12.1739269001021; 
 Tue, 11 Feb 2025 02:16:41 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43941c09ee8sm67296655e9.37.2025.02.11.02.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 02:16:40 -0800 (PST)
Message-ID: <91efdab8-c04b-46a7-80d3-0a8dcfd1fd4e@canonical.com>
Date: Tue, 11 Feb 2025 11:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
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

On 11.02.25 10:49, Ilias Apalodimas wrote:
> On EFI runtime services, we manage to preserve string literals
> by placing the .efi_runtime section just before .data and preserving
> it when fixing up the runtime memory by marking surrounding boottime
> code as runtime. This is ok for now but will break if we update any
> linker scripts and decouple .text and .runtime sections.
> 
> So let's define the strings we used to compare in the stack for
> runtime services
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_var_mem.c      | 3 ++-
>   lib/efi_loader/efi_variable_tee.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index b265d95dd6ba..985e0baa128d 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   {
>   	efi_uintn_t old_size;
>   	struct efi_var_entry *var;
> +	u16 vtf[] = u"VarToFile";

I cannot see why this change would influence the section where the 
string is placed.

Adding a static variable marked as __efi_runtime_data should do the job.

static __efi_runtime_data const u16 vtf[] = u"VarToFile";

Best regards

Heinrich

>   	u16 *pdata;
>   
>   	if (!variable_name || !vendor || !data_size)
> @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   	if (timep)
>   		*timep = var->time;
>   
> -	if (!u16_strcmp(variable_name, u"VarToFile"))
> +	if (!u16_strcmp(variable_name, vtf))
>   		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>   
>   	old_size = *data_size;
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index 0d090d051dd4..8d173e58d2f7 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>   	efi_uintn_t payload_size;
>   	efi_uintn_t name_size;
>   	u8 *comm_buf = NULL;
> +	u16 pk[] = u"PK";
>   	bool ro;
>   
>   	if (!variable_name || variable_name[0] == 0 || !vendor) {
> @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>   	if (alt_ret != EFI_SUCCESS)
>   		goto out;
>   
> -	if (!u16_strcmp(variable_name, u"PK"))
> +	if (!u16_strcmp(variable_name, pk))
>   		alt_ret = efi_init_secure_state();
>   out:
>   	free(comm_buf);

