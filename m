Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD9CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA49835C6;
	Wed, 17 Sep 2025 15:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EIfIvPfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79394835C6; Wed, 17 Sep 2025 15:54:29 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5128F8354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cRgHP39gNz9smZ;
 Wed, 17 Sep 2025 15:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758117265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI5uCJUIIwwDfmg/b/FwYoerWQ799xBJ8rzUpfIRANM=;
 b=EIfIvPfWDtwAp2W4i93kj0d8LPEPrr8zl5BXiOOM6dQzD6bkoitlHj6wk1DeG1OyaiP2XQ
 2Y5KbuX4bnCBLLL60hq1kulo3NdzRZNFMA5SrsHqdJHeljs4H32OxJTV8ebvoTg0fCcFq1
 nhRim4G+CY06VeNCBb+2mEyYF/6KCtLv3smC7dm/cN4gi6g4wO8pWA3eEtYrby9pfFePci
 gz5pMkxlPxa4aa88RstHJKVuw0Q7wgLgiXDtGEeH8kWQOJXxtLpdv4TU3LNCyWaa7piwkc
 3aWKs5lVLPf+5UVXPvU7l8kXENrg2cJ2OXF3PLV3Qm26vyLcdUo0OmrJBMlHiw==
Message-ID: <079fe8fa-1c16-45de-926a-58c6bf69dae2@mailbox.org>
Date: Wed, 17 Sep 2025 15:54:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] board: dhelectronics: Check pointer before access in
 dh_get_value_from_eeprom_buffer()
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
 <175811685980.752169.702390256025070470.b4-ty@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175811685980.752169.702390256025070470.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: edkfeb86m89fm8f6ha8ny8aj19ecpo9f
X-MBO-RS-ID: bc09dc8903d98575140
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

On 9/17/25 3:47 PM, Tom Rini wrote:
> On Sun, 07 Sep 2025 03:00:46 +0200, Marek Vasut wrote:
> 
>> The eip pointer in dh_get_value_from_eeprom_buffer() might be NULL.
>> The current NULL pointer check happens too late, after the eip was
>> accessed in variable assignment. Reorder the two, so the NULL pointer
>> check happens first, and any access second, otherwise the access may
>> trigger a hang or other undefined behavior.
>>
>>
>> [...]
> 
> Applied to u-boot/next, thanks!
> 
> [1/2] board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()
>        commit: 1c735620e19e2ae07705cc38da1552ee6a696ff0
> [2/2] board: dhelectronics: Use isascii() before isprint() in dh_read_eeprom_id_page()
>        commit: fd396316432ad4a0f2998ea9eee9720be0e5d5f8

These are bugfixes for master.
