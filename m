Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0DFC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 18:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C95580214;
	Thu, 23 Jan 2025 19:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L8GJ2cJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D720280243; Thu, 23 Jan 2025 19:38:21 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F201080137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 19:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa69107179cso276125066b.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737657498; x=1738262298; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ypU2mp2+/tSj7Z6QAZNzDZIJecnNpEFcTrHKwutQf4Y=;
 b=L8GJ2cJCmUkg2pl/OxA7dyny5LhltGc+Msi0P4kmbKb+qdXSzrZZswRpw8USQA0EAr
 DhmZ5Wr0pDtJBnN+g2Shan3cE5p3uC4XHLFLs8J0/vxU72cMwC6rH7aXYPHBEpM9qGuO
 DVgMMdQ7ofPCTBOcXYW4dAsH0A9A6M9sgcBH+HOi4cK5cDPvd0RNPfguvuC8ntXUNG4F
 0srVpfMKp6a9QMCuinsWwFRHqfBGIfRGyS8az15FdrOw0CFzBqmqLnDEQitwzg48GRcz
 Hym34e+ZrbPmf9RXcr6rfu9iiZ3X1IxK8IGDlfqV0ElH4w9gM84AsebgsQ6sMytKjf05
 lsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737657498; x=1738262298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ypU2mp2+/tSj7Z6QAZNzDZIJecnNpEFcTrHKwutQf4Y=;
 b=TKdWtN2dBM9FlGsx57uxopPkksWMQf3vvK8WTmzX6b4W+S0xkPOyc25TFCdBM0OXyK
 ZdHfgJQhIP2qpCi71Gzm1+jqFvgwzhF5ru4UrbMNnWHF4LrZ05k+RqrejDtHG3PQMF0Y
 AOqnuYra7OXLtXklxDCSZTxxsOXfDvwWR5EXlx1URYsXyfpoKzTIIdlnQNZWyQv28uME
 q0B+pElO6Ca4ScsH7CJqOUOGhJjZif4yA1e/Z1mc/AuE4SxDAKaqyeh306w6/zfXEv7z
 T8k0N5C1TS9yaqdIsBsdOlnZiARGiOwjVUjSJAkOLtu73EVdCP2WljVJ2NbOterRRfCe
 BrJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvsH3VXiQyT+KqGt2mgYT0Zds4nanxL97OV8V6P8v273+9xZ7dGKIJBlI92W+FO6YLfrEjXY0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzsw+PsKOYQo3Q+dkuqp0554w1ICt5Cbivv1rDvK0zyQ4KtruJJ
 XoEZjmYfOyHb0OSpO8Qwe9odpUGHFji1kmlI3vcad7hA1bZqyNyNQNkVI1Xb7AI=
X-Gm-Gg: ASbGncs7a24JqNIBsu6/LVnjehqn9ViHq5yX6yjp0g7GkquD+xXKCMiD07OGzi9NFvl
 B8sVmaTtFPnabOkSQnDGwurpa8owcul82CQK8O9pvDwAkGlOsekfvJsMj41JPHdPW/zhi5Biv33
 XoPcEqI1MDuU0bHn425i3eMQ03nxzkAyhimEU+dwtU5CLwK017EPXI/MfAhXZqbbgwlzNoPp6Uj
 xaMhvWpq46gcsTZG4Kf/meDUAsoQYuVp40hBJ8Tox4LbiQpRgg7xWcxoq5qi2c0yXx8Q71DWB7l
 2qI6UoKivpiYI0GlJVdNT9H5mJ44mlLxYBXBefC+Igz+0K2Rl1+TdLxOF2MzaB8=
X-Google-Smtp-Source: AGHT+IEYrHY+mbKUh7mlFD35oxfezHjDal/BxuXDSfX784jBJjfw0vYvvX9o5sZEsPIltYDFAoBPYg==
X-Received: by 2002:a17:907:7207:b0:ab3:8b1:12aa with SMTP id
 a640c23a62f3a-ab38b0a2216mr2736092866b.8.1737657498289; 
 Thu, 23 Jan 2025 10:38:18 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760ab363sm1333466b.114.2025.01.23.10.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 10:38:17 -0800 (PST)
Message-ID: <55e7f954-3fab-4a16-bab3-21103cfd188e@linaro.org>
Date: Thu, 23 Jan 2025 19:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: fix board_fdt_blob_setup()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250117102734.3725009-2-caleb.connolly@linaro.org>
 <CAFLszThD3VCJC_2X_Z0DYBiEgtR_AfvMx11f-tUAvEuYmDU9eg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThD3VCJC_2X_Z0DYBiEgtR_AfvMx11f-tUAvEuYmDU9eg@mail.gmail.com>
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

Hi Simon,

On 23/01/2025 15:37, Simon Glass wrote:
> Hi Caleb,
> 
> On Fri, 17 Jan 2025 at 03:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> In fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
>> there was a subtle change to the Snapdragon implementation, removing the
>> assignment to gd->fdt_blob partway through the function.
>>
>> This breaks qcom_parse_memory() which was also called during
>> board_fdt_blob_setup().
>>
>> Since this was a strange (and seemingly unnecessary choice), take the
>> chance to move this to the more typical dram_init() phase so that we
>> don't depend on gd->fdt_blob being correct until after
>> board_fdt_blob_setup() has finished.
>>
>> Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/mach-snapdragon/board.c | 67 +++++++++++++++-----------------
>>  1 file changed, 31 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index f1319df43147..fbb3d6e588e3 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -45,17 +45,8 @@ static struct {
>>         phys_addr_t start;
>>         phys_size_t size;
>>  } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>>
>> -int dram_init(void)
>> -{
>> -       /*
>> -        * gd->ram_base / ram_size have been setup already
>> -        * in qcom_parse_memory().
>> -        */
>> -       return 0;
>> -}
>> -
>>  static int ddr_bank_cmp(const void *v1, const void *v2)
>>  {
>>         const struct {
>>                 phys_addr_t start;
>> @@ -69,42 +60,22 @@ static int ddr_bank_cmp(const void *v1, const void *v2)
>>
>>         return (res1->start >> 24) - (res2->start >> 24);
>>  }
>>
>> -/* This has to be done post-relocation since gd->bd isn't preserved */
>> -static void qcom_configure_bi_dram(void)
>> -{
>> -       int i;
>> -
>> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> -               gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
>> -               gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
>> -       }
>> -}
>> -
>> -int dram_init_banksize(void)
>> -{
>> -       qcom_configure_bi_dram();
>> -
>> -       return 0;
>> -}
>> -
>>  static void qcom_parse_memory(void)
>>  {
>>         ofnode node;
>> -       const fdt64_t *memory;
>> +       const fdt64_t *memory = NULL;
>>         int memsize;
>>         phys_addr_t ram_end = 0;
>>         int i, j, banks;
>>
>>         node = ofnode_path("/memory");
>> -       if (!ofnode_valid(node)) {
>> -               log_err("No memory node found in device tree!\n");
>> -               return;
>> -       }
>> -       memory = ofnode_read_prop(node, "reg", &memsize);
>> -       if (!memory) {
>> -               log_err("No memory configuration was provided by the previous bootloader!\n");
>> +       if (ofnode_valid(node))
>> +               memory = ofnode_read_prop(node, "reg", &memsize);
>> +
>> +       if (!memory || !ofnode_valid(node)) {
>> +               panic("No memory configuration was provided by the previous bootloader!\n");
>>                 return;
>>         }
>>
>>         banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
>> @@ -134,8 +105,32 @@ static void qcom_parse_memory(void)
>>         debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
>>               gd->ram_base, gd->ram_size, ram_end);
>>  }
>>
>> +int dram_init(void)
>> +{
>> +       qcom_parse_memory();
>> +       return 0;
>> +}
>> +
>> +/* This has to be done post-relocation since gd->bd isn't preserved */
>> +static void qcom_configure_bi_dram(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> +               gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
>> +               gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
>> +       }
>> +}
>> +
>> +int dram_init_banksize(void)
>> +{
>> +       qcom_configure_bi_dram();
>> +
>> +       return 0;
>> +}
>> +
>>  static void show_psci_version(void)
>>  {
>>         struct arm_smccc_res res;
>>
>> @@ -173,9 +168,9 @@ int board_fdt_blob_setup(void **fdtp)
>>                 ret = -EEXIST;
>>         } else {
>>                 debug("Using external FDT\n");
>>                 /* So we can use it before returning */
>> -               *fdtp = fdt;
>> +               gd->fdt_blob = *fdtp = fdt;
> 
> Can you avoid assigning to gd->fdt_blob here? The intent is that this
> is done by the caller.
> 
>>         }
>>
>>         /*
>>          * Parse the /memory node while we're here,
>> --
>> 2.48.0
>>
> 
> I notice this is rejected in patchwork, but I don't see any discussion
> as to why?

I discussed with Sam on IRC and took his patch instead since it fixes
the same issue and enables some additional usecases.

https://lore.kernel.org/u-boot/20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com

Kind regards,
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

