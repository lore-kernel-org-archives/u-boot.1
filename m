Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309BC3ABD8
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 16:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5781C80584;
	Sun, 18 May 2025 18:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bs1q9ZdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4FA8059D; Sun, 18 May 2025 18:00:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAEB08004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 18:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b0lrn6XMLz9t2h;
 Sun, 18 May 2025 18:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747584009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZgDZMfcz4ZZEiGaLBYa1HXpyyQ7h7BY7n8zeuLHZAY=;
 b=bs1q9ZdJuf9ly+ZISHoLmggbKgzFdl/jpOvkC0P92wvlmyMxwrQwVZV/jDe7H9aCVgMsem
 FwrUCQvv31Lxc4mfSo33Zcww0XhBhHqsJ7d+Smv4rVr+z9iFrGTvN2lMcncpH8NUrUzU95
 LcxIDyc0KV2ao1E7IX3x/29oTkzZxcJaIgBmalJtoirC0aSQE9/7nPAeaHjUlFkDYDpkmr
 FdFti7yVYauIZiUDKhO0dTBBDSwbQtCvJppf7nvSv/0VS/4YalLXCmwFC1oZW1/yNBc8ff
 1BN2h8VTxW+SJVadyjnqpCJkpiea1X6sKbdPunuxCmWsbexZYcVTaPoI4gUdYA==
Message-ID: <9573debb-605a-41a5-a659-3e07e2831af4@mailbox.org>
Date: Sun, 18 May 2025 18:00:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250512161033.146396-1-marek.vasut@mailbox.org>
 <CAFLszTjuAXS_3oBaX5EM4SOtt6Xr+UO5r-CEqZ76sFf4gG9tsw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjuAXS_3oBaX5EM4SOtt6Xr+UO5r-CEqZ76sFf4gG9tsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cc4cc7fe1f67e66a0d2
X-MBO-RS-META: 5mxt83zb8bds8ut5x8frqbweegxxas9o
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

On 5/15/25 9:27 PM, Simon Glass wrote:
> Hi Marek,
> 
> On Mon, 12 May 2025 at 18:11, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
>> is fulfilled. This fixes a possible failure in fdt_find_separate() in
>> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
>> end at already 8 Byte aligned offset.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Sam Edwards <cfsworks@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   arch/arm/cpu/u-boot.lds | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
>> index 817e7a983ae..b2109e03ce3 100644
>> --- a/arch/arm/cpu/u-boot.lds
>> +++ b/arch/arm/cpu/u-boot.lds
>> @@ -153,14 +153,14 @@ SECTIONS
>>                  __efi_runtime_rel_stop = .;
>>          }
>>
>> -       . = ALIGN(4);
>> +       . = ALIGN(8);
>>          __image_copy_end = .;
>>
>>          /*
>>           * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
>>           * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
>>           */
>> -       .rel.dyn ALIGN(4) : {
>> +       .rel.dyn ALIGN(8) : {
>>                  __rel_dyn_start = .;
>>                  *(.rel*)
>>                  __rel_dyn_end = .;
>> --
>> 2.47.2
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Does the same need apply to SPL?
Yes, although in a slightly different manner. For SPL, the alignment has 
to be applied to __image_binary_end and __bss_end , see lib/fdtdec.c :

1243 static void *fdt_find_separate(void)
1244 {
1245         void *fdt_blob = NULL;
1246
1247         if (IS_ENABLED(CONFIG_SANDBOX))
1248                 return NULL;
1249
1250 #ifdef CONFIG_XPL_BUILD
1251         /* FDT is at end of BSS unless it is in a different memory 
region */
1252         if (CONFIG_IS_ENABLED(SEPARATE_BSS))
1253                 fdt_blob = (ulong *)_image_binary_end;
1254         else
1255                 fdt_blob = (ulong *)__bss_end;
1256 #else

Fixed in V2.
