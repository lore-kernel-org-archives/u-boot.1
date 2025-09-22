Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A1CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A8682CF4;
	Mon, 22 Sep 2025 16:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZnzcG6f5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fIhZSm9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A99983211; Mon, 22 Sep 2025 16:51:40 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E63282998
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cVmK50XZWz9t7D;
 Mon, 22 Sep 2025 16:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758552697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSy9as065FiVj/pt0YUDo+zmU92l1HR4vxFkrXaE4Qg=;
 b=ZnzcG6f5/nq4uk60sjVXXCii+t+vrWQdTFB4RGbyDEzD69ektFlIZ8xkPtnPprDZwx4OhF
 1KqdB98BanCFTkhFQ82CIYCpdd3oD6A2EmjKq8EWy9mb0H0VVG93QHZ2M8rpHT2fqo/kIp
 oWVKjvF+FYsOAuNiwYhqnuyc8sB6PSCJhk4yy/nQX6G+FK4vN1msQYq/B8dl2klQNowLh9
 yG9+O/RWmBnX0QY3Ie3ksKkQwq5pOrgRoOTaNmG+mf3L/iZ6u1iVIDj6SJSItFeWwoDHfu
 w6mrrPzyUDGxJqb8wN7qfGvRv8zo7KaJdRImJly5zHrVBv8+skg0JN2lBR492A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fIhZSm9D;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758552695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSy9as065FiVj/pt0YUDo+zmU92l1HR4vxFkrXaE4Qg=;
 b=fIhZSm9DPfPilPrH/x4nqWCjSuXEvtJwi6MZm3wilyFnuTwbOEaoUjDXc+WgQxYxSlmInp
 dmxwVcjQ6V23rdKAUwtImKVy3GcWQ7Abgbkp7zeN8Xv5AL44WGq5Q4ChPo4yKQjLvvdmBv
 SacBGW1Bw7TyLVf77QBF3AeuTOKP9FCfnleQAwJWrtdRMVUS57EUyfTkoS8debDrP0b2kR
 rsEaYbVUnvX4cRGvHBJumrs8Lff6EMGf3Qe5b6apK53q0uu/aQxHH8obJgxawjhPuQP+Rh
 H6jfoQJhOo2H6gf6HnxtZtLNC5XvWyxQGhDbczuCnIa2bJqSnYtmMwzQCU3gHw==
Date: Mon, 22 Sep 2025 16:51:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <48de987c-1255-4c90-8477-964d153809d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 236e207d17d9c5a0a52
X-MBO-RS-META: dww484e86d5he6xzoij9379muifqm5ck
X-Rspamd-Queue-Id: 4cVmK50XZWz9t7D
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

On 9/22/25 4:02 PM, Michal Simek wrote:
> 
> 
> On 9/11/25 07:40, Michal Simek wrote:
>>
>>
>> On 9/11/25 05:28, Marek Vasut wrote:
>>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>>> In case of ENV_INVALID (uninitialized variables) the first env location
>>>> should be used for storing variables.
>>>> That's why change the logic how env_valid is setup to be aligned with
>>>> offset calculation.
>>>> This will also fix the print about Valid environment is showing proper
>>>> location where variables are saved for the first time.
>>>> And also fixes behavior where the first two writes were going to the
>>>> first location instead of the first to the first location and second to
>>>> second location.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Simplify commit message
>>>>
>>>> Origin commit message with more technical details.
>>>>
>>>> When both location for variables are not valid (or empty) gd- 
>>>> >env_valid is
>>>> 0 (ENV_INVALID) which is setup by
>>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>>
>>>> When saveenv is called in case of SPI env_sf_save() is called which
>>>> contains logic which describes new/old variable locations.
>>>>
>>>> if (gd->env_valid == ENV_VALID) {
>>>>          env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>          env_offset = CONFIG_ENV_OFFSET;
>>>> } else {
>>>>          env_new_offset = CONFIG_ENV_OFFSET;
>>>>          env_offset = CONFIG_ENV_OFFSET_REDUND;
>>>> }
>>>>
>>>> In case of ENV_INVALID option the first location is used (else part)
>>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>>
>>>> And
>>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
>>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
>>>> but that's not correct because the first location has been written 
>>>> and not
>>>> the second one.
>>>> That is confirmed by
>>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>>> which is showing number 2 (ENV_REDUND).
>>>>
>>>> That's why change the logic how env_valid is setup to be aligned with
>>>> offset calculation which also cover the case where initial state is
>>>> ENV_INVALID.
>>>> Then print about Valid environment is showing proper location where
>>>> variables are saved for the first time.
>>>> But also it is fixing behavior where the first two writes are going 
>>>> to the
>>>> first location instead of the first to the first location and second to
>>>> second location. Alternation is happening after it.
>>>>
>>>> v1: https://lore.kernel.org/ 
>>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>>> Sorry for not being clear, the original commit message structure and 
>>> technical details were fine, it only needed slight rephrasing, in the 
>>> original form it was very hard to understand. Can you please 
>>> reinstate the original commit message and only clean it up slightly ?
>>
>> Can you exactly point me to part which wasn't clear? It has a lot of 
>> details about flow and obviously it makes sense to me that's why I 
>> would like you to point me to exact part which should be improved.
> 
> What about this?
> 
> When both SPI environment locations are invalid (gd->env_valid == 
> ENV_INVALID), the first call to saveenv writes to the primary location 
> and sets the active flag. However, the logic for updating gd->env_valid 
> incorrectly sets it to ENV_REDUND, which does not match the actual 
> location written. This causes the first two writes to target the same 
> location, and alternation only begins after the second write.
> 
> Update the logic to alternate gd->env_valid based on whether the last 
> write was to the primary or redundant location, ensuring the first write 
> sets ENV_VALID and subsequent writes alternate as expected. This aligns 
> env_valid with the actual storage location and fixes the alternation 
> sequence from the first write.
> 
> With this change, the "Valid environment" printout correctly reflects 
> the active location after each save, and the alternation between primary 
> and redundant locations works as intended from the start.
Yes, perfect.
