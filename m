Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49082CAC5A7
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 22:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A037383211;
	Mon, 22 Sep 2025 00:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r/3AdRRf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K4WCcPcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8AD83390; Mon, 22 Sep 2025 00:40:44 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E46082B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 00:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cVLmp1s0dz9slM;
 Mon, 22 Sep 2025 00:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758494442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QD7AyJ4OyW4yZPVABet3VvdM6vsJSloKu/4sjw6RjUQ=;
 b=r/3AdRRfH2AQHxn0Jq5brK2P76e1C7PVgSzbPbOBh9m5Bb3rKzxIzeE6755FX2Z5+FZDGX
 4miaH9XCaMOBsyaBgUmhL+Dl/t9dhKFW757Z+tDzLW/bxni5knuadjN6vnMElBBpiUGgTo
 dRcdxlRLfNDAEWVlyHaVVSCxmpZDBoL2Jc8IMIuMz9cFZfMNs0hr4vyoaMAPW3z83qNoUv
 Hj2einCKez2/uRYVj1rWPkfKrHuWxJi8jUYPVtLI/DE9pz0kCCqwxoL+NOD/gzcGjrrnlu
 HeWUMwR31uLvFBZ9dj7CuOPIgCmLk9Hh9AA7ZbecNSqVtDNURhsZS+E9u69GIA==
Message-ID: <8429f5cd-2c8e-4e2d-a661-a7f6d6ddf215@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758494440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QD7AyJ4OyW4yZPVABet3VvdM6vsJSloKu/4sjw6RjUQ=;
 b=K4WCcPcqAFozXeCpX+/SrPHuFbcTf9owyd7jCrbMJgmCgp7Eu66lChw0g4HtWFRKPa8T6A
 wTYW5mORmzjQ0ohJOuR+50+kMU05EpRUfj55GQ4Ltml4Rh3YlNnY9h2lwRe2h5fITGJTrW
 Q3NlCK5Jv5ruZKMDpwmtXzdQkECUgX0oS8LD+GCnxCPu6ZoKFB3seF0oLBFeiJ64eCRR7+
 +eHgMiV2mIGTof9mDKZIaK9DzCt/+8wHacjTYugOtkht0hMzgjkrL8VKT5bowWl4WiZgjN
 M7pPi70lOIMgEESiI0SlRqLt6CViIYJq/C+wvdjX04RF0Yhvn1R8PNbhJOPn2g==
Date: Mon, 22 Sep 2025 00:40:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [U-Boot, v4, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250914044115.18391-1-lucienzx159@gmail.com>
 <464e0429-ac06-49fc-831d-b9e86946446d@mailbox.org>
 <0924393d-c87b-4a6a-8590-3ab49d039dfa@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0924393d-c87b-4a6a-8590-3ab49d039dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gff1tyedsegxd3dkwncnf9x9a4wrpdhg
X-MBO-RS-ID: c5fcefa8022d0ba754b
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

On 9/15/25 4:35 PM, Lucien.Jheng wrote:

Hi,

sorry for the late reply.

>>> +__weak int en8811h_read_fw(void **addr)
>>
>> Does this still have to be a __weak function, now that it uses generic 
>> fw loader ?
>>
>>> +{
>>> +    void *buffer;
>>> +    int ret;
>>> +
>>> +    if (!IS_ENABLED(CONFIG_FS_LOADER))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
>>> +    if (!buffer) {
>>> +        printf("Failed to allocate memory for firmware\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    ret = request_firmware_into_buf_via_script(&buffer,
>>
>> I think 'buffer' without the & should be used here.
> 
> Regarding buffer,
> 
> I've reviewed the function definition for 
> request_firmware_into_buf_via_script.
> The first parameter is void **buf, which is a pointer to a pointer.
> 
> I think passing &buffer is the correct way to call this function.
> 
> If we were to pass just buffer (a void *), the function would receive a 
> copy of the pointer's value, and any memory allocation inside the 
> function would not be reflected in our original buffer variable.
> 
> Please let me know if my understanding is incorrect, as I want to ensure 
> I'm using the function as intended.
I was confused by the current request_firmware_into_buf_via_script() 
interface.

In the current design, passing pointer to pointer into 
request_firmware_into_buf_via_script() is not necessary, because the 
request_firmware_into_buf_via_script() function internally does memcpy() 
into the 'buf' buffer, and for that to work, pointer to pointer is not 
necessary, plain pointer to buffer would do just fine.

I think this current interface which does memcpy() is actually better 
than the one I originally suggested which would use memdup(), so let's 
keep it.

I now sent an update patch to remove the pointer to pointer:

[PATCH] misc: fs_loader: Use buffer pointer in 
request_firmware_into_buf_via_script()

That should be all I hope.
