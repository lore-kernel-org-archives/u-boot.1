Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B0CC83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 07:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8590846D0;
	Sun, 27 Aug 2023 09:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="eEC54v3E";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="qKpC9VoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182C484702; Sun, 27 Aug 2023 09:19:12 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8D580726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from ziongate (localhost [127.0.0.1])
 by ziongate (OpenSMTPD) with ESMTP id 58c803a0;
 Sun, 27 Aug 2023 07:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=2trLqNCx3bnBsg7BXp990XXWDyM=; b=eEC54v3EOat7TswowHJwL8+P/FdB
 XL37hKilok1DbPGXIevF/PVcJaYh5xa7IVIUeLUwq7H98USeZJbePN0c1JbXwdFI
 hn4AKqtN/Mbw7qy5fhQJ79Cizfa7Jin89/uK3GUdq3RuiO4XLXxiq9uZ8El7SjCD
 e0L7gimzYrXNcnA=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
 default; b=BT1lMEv7XtjhuS4YoaRyOET8m89krQXWNOXGTygQR60byHuqK0EjJ
 7qhTb+DCCZo5hLHxBzkOutOYBdp7VXB6bwBQj9FL380k8OSCLqRVbAGNWALR3SjP
 YlqVjvW04oDQ/WdOFXijt3N9N00pU75MYvPXRjF2Yz8XvCjTqfdK6Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=20190913; t=1693120748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmysFn0oBOaEDltWfmPLqgKbd6TVn1KB5xv82s8gJwE=;
 b=qKpC9VoMMsVVfs1JBy/X+Bh9QXQGX6nGxNpn+k7Rw9HEiSW1QnLK83b4G88cxypV94du0H
 naYcQtA6TiyxwLJmpZ0IYZoqZk/KLLjrXnOHJcVQnpeAI7r/wRQvupGn8WbQqfFr9V3+wO
 eQIuAr04MFM3IKbGATE6pYWdzGCNs7Y=
Received: from [192.168.0.2] (host-82-50-168-26.retail.telecomitalia.it
 [82.50.168.26]) by ziongate (OpenSMTPD) with ESMTPSA id 97ab116f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 27 Aug 2023 07:19:08 +0000 (UTC)
Message-ID: <fac72452-2fd7-6b85-68b8-4fbd8444c94a@kernel-space.org>
Date: Sun, 27 Aug 2023 09:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 1/2] tools: relocate-rela: Add M68K support
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Simon Glass <sjg@chromium.org>,
 Zong Li <zong.li@sifive.com>
References: <20230730222051.227660-1-marek.vasut+renesas@mailbox.org>
 <7413294c-068f-f0ea-8247-8b8ea414a6c5@kernel-space.org>
 <8eb81e26-acfa-db20-2a23-ca95b9f3d4c3@mailbox.org>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <8eb81e26-acfa-db20-2a23-ca95b9f3d4c3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marex,

thanks,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 27/08/23 12:29 AM, Marek Vasut wrote:
> On 8/26/23 09:44, Angelo Dureghello wrote:
>> Hi Marek,
>>
>> thanks a lot for the job i should have done.
>>
>> Tested on real hw:
>>
>> m5282evb   worked out of the box
>> mcf54415   not working,
>> had a lot of unsupported relocation type for R_68K_JMP_SLOT
>> mcf5307    need to fix the hw, will do in short
>>
>> i had to add this fix:
>>
>> diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
>> index 2d008c7f60..9722a6291a 100644
>> --- a/tools/relocate-rela.c
>> +++ b/tools/relocate-rela.c
>> @@ -40,6 +40,10 @@
>>   #define R_68K_GLOB_DAT         20
>>   #endif
>>
>> +#ifndef R_68K_JMP_SLOT
>> +#define R_68K_JMP_SLOT          21
>> +#endif
>> +
>>   #ifndef R_68K_RELATIVE
>>   #define R_68K_RELATIVE         22
>>   #endif
>> @@ -531,6 +535,9 @@ static bool supported_rela32(Elf32_Rela *rela, 
>> uint32_t *type)
>>                  case R_68K_RELATIVE:
>>                          debug("R_68K_RELATIVE\n");
>>                          return true;
>> +               case R_68K_JMP_SLOT:
>> +                        debug("R_68K_JMP_SLOT\n");
>> +                        return true;
>>                  }
>>          } else {
>>                  switch (*type) {
>> @@ -631,8 +638,9 @@ static int rela_elf32(char **argv, FILE *f)
>>                                  return 4;
>>                          }
>>                  } else if ((machine == EM_M68K &&
>> -                           (type == R_68K_32 || type == 
>> R_68K_GLOB_DAT)) ||
>> -                          (machine == EM_MICROBLAZE &&
>> +                           (type == R_68K_32 || type == 
>> R_68K_GLOB_DAT ||
>> +                            type == R_68K_JMP_SLOT)) ||
>> +                           (machine == EM_MICROBLAZE &&
>>                              (type == R_MICROBLAZE_32 ||
>>                               type == R_MICROBLAZE_GLOB_DAT))) {
>>                          /* global symbols read it and add reloc 
>> offset */
> 
> Wrapped into V2, thanks
