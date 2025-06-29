Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34137C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7355A82EA2;
	Sun, 29 Jun 2025 21:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qn4+y9Zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530F482ED0; Sun, 29 Jun 2025 21:08:44 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B346682E35
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bVf2p3jwyz9ssr;
 Sun, 29 Jun 2025 21:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751224114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=komzSIjPPmepdIOb2HgE9LP+I6bWmyz+n7UbSNiMZdo=;
 b=Qn4+y9Zi7UiK6EffbD715cIq84/uzOPLO6AzkDYGjAly6n6F/MCh25wnzNgYZzsgFmVOVx
 G7txMBtPcSELGanPMfUqCCSRBHnj80xx2AdkaR4jxSef6EPziBltn7Fsi9ElX47ZpAnZrp
 6n0lJs9rhL77BgZss3W7jEKucdjvRY4yA1eEALHQMgynbAGrnfXJJ/WDI+xwe6CKaVeC4G
 j+r3CyyJf9NBFw2XlNoWiIZZA1vuCY9AMWsj3rpDAPGqLOxWfTQz5M+nsOaN00epT0I2vq
 Vq86443p4gPYOEKVPqIzLmP6Hd+5rMHpNQKW9Jh0klPGLWeo1ZrvSIov0ymw5w==
Message-ID: <43ba9ad2-e2df-44e3-9bc0-1b7e343ff1b3@mailbox.org>
Date: Sun, 29 Jun 2025 21:08:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
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
 <20250512172149.150214-2-marek.vasut@mailbox.org>
 <ce033305-387b-4732-a711-5a4a9f4237e3@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ce033305-387b-4732-a711-5a4a9f4237e3@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 46dd29496a6b17b4e35
X-MBO-RS-META: meq7oz4n5e5nee4dm8q561uw8dpe4r8w
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

On 6/3/25 3:26 PM, Patrick DELAUNAY wrote:

Hi,

>> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach- 
>> stm32mp/Kconfig.13x
>> index bc8b3f8cf77..cecf9e3b8c7 100644
>> --- a/arch/arm/mach-stm32mp/Kconfig.13x
>> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
>> @@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
>>   endchoice
>>   config TEXT_BASE
>> -    default 0xC0000000
>> +    default 0xC0000000 if TFABOOT
>> +    default 0xC0100000 if !TFABOOT
>>   config PRE_CON_BUF_ADDR
>>       default 0xC0800000
> 
> 
> I don't understood  why you modify TEXT_BASE here.
Loading of data to the very beginning of DRAM may fail in case the data 
are wrapped in various container image types, because the image loader 
in SPL may use the area before the data load address to load for example 
image header(s) in there. This is one example of such header loading, 
which is triggered on STM32MP13xx in SPL:

https://source.denx.de/u-boot/u-boot/-/blob/master/include/spl_load.h#L18

"
  18         struct legacy_img_hdr *header =
  19                 spl_get_load_buffer(-sizeof(*header), sizeof(*header));
  20         ulong base_offset, image_offset, overhead;
  21         int read, ret;
  22
  23         log_debug("\nloading hdr from %lx to %p\n", (ulong)offset, 
header);
  24         read = info->read(info, offset, ALIGN(sizeof(*header),
  25 
spl_get_bl_len(info)), header);
"

The header is loaded at CONFIG_TEXT_BASE - sizeof(*header). If 
CONFIG_TEXT_BASE is start of DRAM with no usable memory right below it 
AND sizeof(*header) is non-zero, then this loading will fail.

That's why the TEXT_BASE is shifted a bit higher in this patch.
