Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1575AE6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 18:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF6384175;
	Tue, 23 Dec 2025 19:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fjnOaIch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A559884178; Tue, 23 Dec 2025 19:53:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B82784167
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 19:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dbPKm1C95z9t6b;
 Tue, 23 Dec 2025 19:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766516012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJjbAVaspRrYb61dZbTYjETub68+eVKDw2ue5Iq8aps=;
 b=fjnOaIch7M7OIMSYIoGHgZ2XfGc5iIJFWbTaSApMNMz7Xp6hNIDSrKZMRZEi9FSGeuqGsX
 WBXkiCkCuMAtVIzAl86gORUXuvhWdNfJIhHXVPJIVh7i7N0D8rF5mVoExdExyIe1qzf+CR
 dm3pdUdCD6QNM84m5KJqfZVz5MSfo+XpKEZ4O7IYvxtwGA2cEKYego/dHf+IwgOHcqWLPd
 9IWbcMt6axa8nvCcZLw8TMeIrBif0udfFwAo/QZv/LPDDKm1OseCv/tFr70pVwjdZKkLoL
 QkHTSIZto7VAlmiwnHYBbLwiU5/cnXSCSIjMo1igoBOz0kKV3757ql4XIG9B1w==
Message-ID: <6230abdb-0e9a-4a27-90e3-34a8a8fee8fe@mailbox.org>
Date: Tue, 23 Dec 2025 19:53:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] env: Add single to redundant environment upgrade
 path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <20251223143130.16266-2-marek.vasut+renesas@mailbox.org>
 <ac80d9cd-4890-4382-9ce6-2f237933d32c@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ac80d9cd-4890-4382-9ce6-2f237933d32c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 31097b6131deee1d60d
X-MBO-RS-META: uiws8dzpu4sietsiei65p1pn1df3srdm
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

On 12/23/25 6:43 PM, Heinrich Schuchardt wrote:
> On 12/23/25 15:31, Marek Vasut wrote:
>> Add support for converting single-copy environment to redundant 
>> environment.
>> In case CRC checks on both redundant environment copies fail, try one 
>> more
>> CRC check on the primary environment copy and treat it as single 
>> environment.
> 
> Why would a CRC check suddenly succeed if it has failed before?

The previous CRC check was for redundant env configuration, the follow 
up test is for a single-copy environment. This is used for single-copy 
env to redundant env upgrade path.

> This needs some more explanation.

Please read the full commit message, I hope the rest of it clarifies 
what is going on here.

>> If that check does pass, rewrite the single-copy environment into 
>> redundant
>> environment format, indicate the environment is valid, and import that as
>> usual primary copy of redundant environment. Follow up 'env save' will 
>> then
>> store two environment copies and the system will continue to operate as
>> regular redundant environment system.
>>
>> Add test which validates this upgrade path. The test starts with spi.bin
>> which is pre-populated as single-copy environment and then upgrades that
>> environment to dual-copy environment.

[...]

>> +++ b/env/common.c
>> @@ -473,14 +473,24 @@ int env_import(const char *buf, int check, int 
>> flags)
>>   #ifdef CONFIG_ENV_REDUNDANT
>>   static unsigned char env_flags;
>> +#define ENV_SINGLE_HEADER_SIZE    (sizeof(uint32_t))
>> +#define ENV_SINGLE_SIZE        (CONFIG_ENV_SIZE - 
>> ENV_SINGLE_HEADER_SIZE)
>> +
>> +typedef struct {
>> +    uint32_t    crc;            /* CRC32 over data bytes */
>> +    unsigned char    data[ENV_SINGLE_SIZE];    /* Environment data */
>> +} env_single_t;
>> +
>>   int env_check_redund(const char *buf1, int buf1_read_fail,
>>                const char *buf2, int buf2_read_fail)
>>   {
>> -    int crc1_ok = 0, crc2_ok = 0;
>> +    int crc1_ok = 0, crc2_ok = 0, i;
>>       env_t *tmp_env1, *tmp_env2;
>> +    env_single_t *tmp_envs;
>>       tmp_env1 = (env_t *)buf1;
>>       tmp_env2 = (env_t *)buf2;
>> +    tmp_envs = (env_single_t *)buf1;
>>       if (buf1_read_fail && buf2_read_fail) {
>>           puts("*** Error - No Valid Environment Area found\n");
>> @@ -498,6 +508,25 @@ int env_check_redund(const char *buf1, int 
>> buf1_read_fail,
>>                   tmp_env2->crc;
>>       if (!crc1_ok && !crc2_ok) {
> 
> Do we really have a third location to copy from when both store 1 and 
> store 2 are defective? I would have expected that if a vendor provides a 
> single copy then exactly one of crc1_ok or crc2_ok is true and the other 
> is false.
> 
> Please, provide a documentation update explaining how this all works.
This implements upgrade path from single-copy env to redundant env, see 
also what Tom wrote. So no, there is no third copy, there is only 
primary copy which is single-copy env, and that primary copy is upgraded 
to redundant (dual-copy) env.
