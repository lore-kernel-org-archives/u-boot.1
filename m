Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E19C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 22:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB1A809D0;
	Mon, 24 Mar 2025 23:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jEtqm8ov";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BTNkcP76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E8680EEF; Mon, 24 Mar 2025 23:58:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742C3808AF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 23:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZM7kY0tcJz9sdP;
 Mon, 24 Mar 2025 23:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742857093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r+lpGQbiO6eIE6Db+KD5+HLVdvy3zY3xoV9m00+Jb8=;
 b=jEtqm8ove48oPJSWA2IT7FPXIdf5SP8FROj0nrwgQnJayKvMHXlcc0+C77V/qmoZ6hq80V
 4eaPxqcgmW6r1Y7fK/zX4P1sgN5skUve700YpGQqJ0GSp6ZnXazGxOKjy2TS13hiJ9ulff
 KeNWCEG3cBdSesOOWzeRemy0y/GFrqTTWVEgu2dZEvhk4NMXO4nY9vEt+7ytmq6+f8W6k0
 nmqO5ufDapZCxkunfOWcfkxSDxBYTknd+SK+bzz2Vc8O4tYqifA08e0cQ07sKpLR978SJg
 wPLtzd+yMCe7YmiWPfVVEzCTQDvR2M6AVOoqBBp1pMBnCjgtZjBcSL5yw5I9ZQ==
Message-ID: <bffe08af-3151-4064-bfd9-8a660a70599a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742857091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r+lpGQbiO6eIE6Db+KD5+HLVdvy3zY3xoV9m00+Jb8=;
 b=BTNkcP76unibcUN1PiKjRBR3dLuB0CghibHPPQN8rzaDsQMlbxB2dtaTD4v8jP7Ft6nj1h
 Ps0C/R2UWeUC9q8RnZi89GtVH65yoHZLawkogTbukLGAjk27zx2LgyWv+QMIviLEsNBebk
 HsTLSq/32x3CCpxI4GVHkHgNUL0S8KFIcwcwW/yhhlwz9GUmlXRPQkdthyhDGMHNXeRnyy
 xcs8KOmY/FiC0IjDZ5ARCd0a8brHWOtYw9qnlex3NPLzpIa4S9hBAJQ+MAh02X4VIGhMQw
 hrvfx4ka7JPUoL3U7KfHAlhWIcX0vQTdW2/JIhEg7orUElHHAJgI9u4EsL+0Qw==
Date: Mon, 24 Mar 2025 23:52:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to
 ENV_REDUNDAND_ENVIRONMENT
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
 <de961532-3565-49f1-b205-556684105a11@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <de961532-3565-49f1-b205-556684105a11@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 952cc5c1ba548196523
X-MBO-RS-META: ijpd9on5sxt9p8ucctggiyzaqi7azy4y
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

On 3/24/25 1:33 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 3/22/25 10:55 PM, Marek Vasut wrote:
>> Rename the variable and add ENV_ prefix, so that all configuration
>> options which are related to environment would have an CONFIG_ENV_
>> prefix. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
> [...]
>> diff --git a/env/Kconfig b/env/Kconfig
>> index a177a354c8b..9ef45a7e3fe 100644
>> --- a/env/Kconfig
>> +++ b/env/Kconfig
>> @@ -463,7 +463,7 @@ config ENV_IS_IN_UBI
>>         the environment in.  This will enable redundant environments 
>> in UBI.
>>         It is assumed that both volumes are in the same MTD partition.
>> -config SYS_REDUNDAND_ENVIRONMENT
>> +config ENV_REDUNDAND_ENVIRONMENT
> 
> Do either of the following:
> 
> 1) fix typo: s/REDUNDAND/REDUNDANT/
> 2) shorten name to be consistent with other symbols and avoid 
> "env[...]environment" redundancy: config ENV_REDUND
CONFIG_ENV_REDUNDANT works for you ?
