Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38534C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 07:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279AC86422;
	Mon, 28 Aug 2023 09:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="E6paKU2u";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="DfZalGzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5968642B; Mon, 28 Aug 2023 09:08:11 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CBF86412
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from ziongate (localhost [127.0.0.1])
 by ziongate (OpenSMTPD) with ESMTP id 475a5df0;
 Mon, 28 Aug 2023 07:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=y04ekkFc9O24F/K6ofnLSQdRMQY=; b=E6paKU2uaYnSAh2ns0lZ/e+diKNh
 q9XO9ubG6CTKo01CNfcVwtxnMoRs4w5VnjW119jNxf4rwpXg+91Gx8YgI5ixOGpY
 IFuJsht5xFAW7lOmZD6I15JwldIbCnG3puauHDzHHILV+dlelv/PJNvkQIC9qKgm
 mMsjF6ciAfJBmDM=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
 default; b=sV8Ws57WcXD0nyrrUyWAHjJxCsmAPMCSuV+nOro023rGhGqLQ484G
 S2T0r6jdnHUUaUKuh9KanMNeYr4yjvAQ2so/hrFpjamAe8uicrsKWNlS6BRz2iqg
 iwaUKeV3mJlns8RvjfJ/O83J0nqIGyaEOpCvRQuULduNx4e3SGZp9c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=20190913; t=1693206488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7xJCNrv0P9M2HFQYBmkOKgs1fIAEyak9W65bAylJ9U=;
 b=DfZalGzwLbIrZjuhKd7SdevRDDReJ1l66OpiJ/ExgPvjiF99OqnMD+YQWGMBtyxQGLxbkG
 yZ6kFQjWaOTb4xOvzSv+iB3hRgAgiXwpRkC58nuXIt+RQv+1llVELws8rUh3dA46RL8qCa
 cnofoTgDa7iScODNocunheBbTIRSfKI=
Received: from [192.168.0.2] (host-82-50-168-26.retail.telecomitalia.it
 [82.50.168.26]) by ziongate (OpenSMTPD) with ESMTPSA id 5d5008c5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 28 Aug 2023 07:08:07 +0000 (UTC)
Message-ID: <5cd2f16d-dd12-5aad-4cb7-9dbb9a574b44@kernel-space.org>
Date: Mon, 28 Aug 2023 09:07:35 +0200
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

Hi,

applying this patchset to u-boot-coldfire

Thanks,
angelo

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
