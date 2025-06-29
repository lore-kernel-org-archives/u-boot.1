Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4004CC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C7882F2B;
	Sun, 29 Jun 2025 21:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FdkHQkOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB3F82F30; Sun, 29 Jun 2025 21:27:37 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF2282EA9
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bVfSg1Hw4z9sWt;
 Sun, 29 Jun 2025 21:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751225251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+mcxLedep0lJAf4LIwlvshN9Mr5F/ha/jWQadRVJ1Q=;
 b=FdkHQkOkx2Pkf0AOvrkyaMC3Z1RDtmTXl8GFN6Mv26HStPlFA5ZTQuPUf4M0Fy/u78MkSl
 z3V+V3VIkoq7kaWcq5AySb4LyUwkevep3NfHgx8NwmtsCJLSRzrJEr741Mh8+/RoE686AC
 mxv8atOUD5Gqe8OlVieiDHi4eKkRcpdQbvkizOlE/GVMn2WWK++4RPY0jjisheqsiULrBU
 mXJKuGrGFHNbl/gZkE4DzX1tu4GAWk4FeAUdA2fbtvV7DuLyjicR1Wn+CN2uxdXBxDlY9b
 In/jWgdE3BmfpjjAS89vpHkNFegxvAbrRmrnHSreYugZXNHEVC3lj14OwXW0Bg==
Message-ID: <87a80ca3-6310-438c-8aad-cea5f51ca531@mailbox.org>
Date: Sun, 29 Jun 2025 21:27:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 04/10] ARM: stm32: Add STM32MP13xx PMIC initialization for
 DDR3 DRAM type
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-5-marek.vasut@mailbox.org>
 <69b334fa-cd92-45dd-aa91-2e0dbc78bd92@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <69b334fa-cd92-45dd-aa91-2e0dbc78bd92@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qhunbr3taa5kxycq88i8emrkgbcu6ga1
X-MBO-RS-ID: 5314f275fe22133d34a
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

On 6/3/25 4:00 PM, Patrick DELAUNAY wrote:

Hi,

>> diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
>> index 45c2bb5bcea..b46f89dacb9 100644
>> --- a/board/st/common/stpmic1.c
>> +++ b/board/st/common/stpmic1.c
>> @@ -14,8 +14,19 @@
>>   #include <power/pmic.h>
>>   #include <power/stpmic1.h>
>> +static bool is_stm32mp13xx(void)
>> +{
>> +    if (!IS_ENABLED(CONFIG_STM32MP13X))
>> +        return false;
>> +
>> +    return of_machine_is_compatible("st,stm32mp131") ||
>> +           of_machine_is_compatible("st,stm32mp133") ||
>> +           of_machine_is_compatible("st,stm32mp135");
> 
> 
> return true;  ?
> 
> 
> no need to check compatible if U-Boot is compiled for STM32MP13x..

The compatible check is placed in here deliberately, in case U-Boot gets 
compiled with support for both MP15 and MP13 .

>> +}
>> +
>>   int board_ddr_power_init(enum ddr_type ddr_type)
>>   {
>> +    bool is_mp13 = is_stm32mp13xx();
>>       struct udevice *dev;
>>       bool buck3_at_1800000v = false;
>>       int ret;
>> @@ -30,18 +41,21 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>>       switch (ddr_type) {
>>       case STM32MP_DDR3:
>>           /* VTT = Set LDO3 to sync mode */
>> -        ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
>> -        if (ret < 0)
>> -            return ret;
>> -
>> -        ret &= ~STPMIC1_LDO3_MODE;
>> -        ret &= ~STPMIC1_LDO12356_VOUT_MASK;
>> -        ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
>> -
>> -        ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
>> -                     ret);
>> -        if (ret < 0)
>> -            return ret;
>> +        if (!is_mp13) {
>> +            /* Enable VTT only on STM32MP15xx */
>> +            ret = pmic_reg_read(dev, 
>> STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
>> +            if (ret < 0)
>> +                return ret;
>> +
>> +            ret &= ~STPMIC1_LDO3_MODE;
>> +            ret &= ~STPMIC1_LDO12356_VOUT_MASK;
>> +            ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
>> +
>> +            ret = pmic_reg_write(dev, 
>> STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
>> +                         ret);
>> +            if (ret < 0)
>> +                return ret;
>> +        }
>>           /* VDD_DDR = Set BUCK2 to 1.35V */
>>           ret = pmic_clrsetbits(dev,
>> @@ -69,11 +83,14 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>>           mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
>>           /* Enable VTT = LDO3 */
>> -        ret = pmic_clrsetbits(dev,
>> -                      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
>> -                      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
>> -        if (ret < 0)
>> -            return ret;
>> +        if (!is_mp13) {
>> +            /* Enable VTT only on STM32MP15xx */
>> +            ret = pmic_clrsetbits(dev,
>> +                          STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
>> +                          STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
>> +            if (ret < 0)
>> +                return ret;
>> +        }
>>           mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
> 
> 
> Support of VTT is not linked to SoC but to board design...
> 
> I think all this part should be reworked / based on TF-A binding

Sorry, no. TFA is not an authoritative source for DT bindings, so I 
don't want to add such bindings into U-Boot and support them for all 
eternity. Get those bindings upstream and then this can be reworked.

In the meantime, how do you propose VTT can be enabled/disabled per board ?
