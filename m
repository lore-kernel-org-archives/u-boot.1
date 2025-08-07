Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73502C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 19:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C3E845F3;
	Thu,  7 Aug 2025 21:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pwaTyzmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7007484609; Thu,  7 Aug 2025 21:42:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3FB83C30
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 21:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bycww5GYHz9ssk;
 Thu,  7 Aug 2025 21:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754595696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1GWd+ej3+gIni2OvRwLuSnWo/ZWASTJMaQeIzFSKyo=;
 b=pwaTyzmfHqs9ZTJz6fXIbNbK7aW2K/aM2VHl0k6yAXOdeink8t+HMQ91pJplVz6ZTlbB0F
 5Hvo+LA0oAb8xJuAoFBziNgJJyM/JoIB1UWVgvoRjh4FgC69v8iqwSFpmYaB74tXoHVS38
 s+8EcXIUVBimwv3ZSk0W75bLRBgOCR2JPYUtB+9touKQwOlkyzDTxlpG8CV3t+XcHvwvwk
 58vqkK4/auzwMmFZtWgTj0EHnxQ2dEluwAwnBsNrCnQ2+0VTL5U2KwVeHRNROmOibQGrnC
 OImz4S/hRHkZFlZjWyiPuN1CoPP2SY8+LQhZ054RreTg7Sq9zFNwwQJyGOm5lw==
Message-ID: <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
Date: Thu, 7 Aug 2025 21:41:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
To: Tom Rini <trini@konsulko.com>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250807162115.GZ124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e468fd7f59c932ad274
X-MBO-RS-META: 95ryoe4rmm34au48u1d8gq4ct6q1yccn
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

On 8/7/25 6:21 PM, Tom Rini wrote:
> On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
>> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
>>> CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
>>> "zero" as "unlimited".
>>
>> This sentence makes no sense. Is the variable not obsolete if its value is
>> non-zero ?
> 
> This is phrased oddly, yes. How about:
> By making the code treat a size limit of 0 as unlimited we no longer
> need to guard asking about having a size limit on the platform.

0 shouldn't mean unlimited, that is just fragile ...

>> [...]
>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index c2aa88f59fb..36eed766d31 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
>>>    config EFI_DEBUG_SUPPORT
>>>    	bool "EFI Debug Support"
>>> -	default y if !HAS_BOARD_SIZE_LIMIT
>>> +	default y if BOARD_SIZE_LIMIT = 0
>> This looks wrong, no board size limit does not imply EFI anything.
> 
> This is however preserving the existing functionality. Saying that no,
> we shouldn't enable EFI debug support by default in any cases would be a
> stand alone patch.
... fragile and confusing. HAS_BOARD_SIZE_LIMIT is at least clear about 
what it does.
