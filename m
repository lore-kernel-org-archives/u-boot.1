Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200FFE6FE41
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 18:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ADC088D2F;
	Fri,  6 Sep 2024 20:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Q6Sgrf+T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FEe0u3lW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9092088D10; Fri,  6 Sep 2024 20:28:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A4C88D34
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 20:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X0l900yrQz9sd0;
 Fri,  6 Sep 2024 20:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725647300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oMGXyXu/pfJPl9cO8uDXxV8HzVFS+HTJABZ9WlqFkQ=;
 b=Q6Sgrf+T9f+f5s1HEyPUpMMe8xErVhERhmYWNFppFBIbRwV2sRHdIvFMCw4KwqM9rAbJkc
 FpS4x+SAs48V1v/1Ws/yJz8pbI5+a60AZ9fiMO2SmrduIL/9Cr/CyIMOlrc90ZUe9J6wl6
 rE/2Wx38zrMoCGc+Kf3o7L1X2SwFH1gM8eF0JuYy26HlPEer1R28QlLCerqXDIBOp00W6c
 46y97dZqzlMkWr0UwKWhOXToULXjPy0xzX41zXXoei56Ou1+pc/U9bipiftIoKFyfuJ7Gd
 l/tvERqnBevUz0SVoSzlEdNrHUZpS3DFKN0k8W5l2nRxL5AUcsbQWHqhKK2f4Q==
Message-ID: <73e90954-e6ef-4fa9-a05a-90eac9196fa3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725647298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oMGXyXu/pfJPl9cO8uDXxV8HzVFS+HTJABZ9WlqFkQ=;
 b=FEe0u3lWsnhAdcjc0+LFot0OwctriXI2012zaTmo32V2QoA0OXQyN67sWcW8UTIpPOkxND
 GAd/Sr+v7SDZ8zBxv0lVq/UyA3dhLfHBFU2FNntm9osAslpw671FlOOW3v6CrZCdRvs/Vj
 Y7hd25dmMZOUUbSLwtAlspacG9/cBQ77aFGH7KCu5L4m6JG9XRp+mXwltF42+BQ0rZ2scy
 9wrX72W/YAg0DB8nfi1bBD0SJ3ZMJr+H5zOps9u4sTdoYmrbKancjhu3Z1mRqOvhrU06U0
 OXUX4EhjdoD4y7IMq/2QPmVqb7bTeJvuJDIChE447Q4JZ3wn2SCjVAgjz690Ww==
Date: Fri, 6 Sep 2024 20:28:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] mmc: Poll CD in case cyclic framework is enabled
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20240616145857.26833-1-marek.vasut+renesas@mailbox.org>
 <20240905220237.GA1823175@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240905220237.GA1823175@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: uaghmx7m45gtg7oqw14ni4f17b8w3gsc
X-MBO-RS-ID: ab26fddfa697b33750a
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

On 9/6/24 12:02 AM, Tom Rini wrote:
> On Sun, Jun 16, 2024 at 04:58:49PM +0200, Marek Vasut wrote:
> 
>> In case the cyclic framework is enabled, poll the card detect of already
>> initialized cards and deinitialize them in case they are removed. Since
>> the card initialization is a longer process and card initialization is
>> done on first access to an uninitialized card anyway, avoid initializing
>> newly detected uninitialized cards in the cyclic callback.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>> V2: Move the cyclic registration/unregistration into mmc init/deinit
>> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>>      does not work with structure members
>> V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
>> V5: Rebase on u-boot/next
> 
> Sorry for the delay here, this no longer builds:
>     sandbox:  +   sandbox
Fixed in V6, sigh
