Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE383C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A68984548;
	Thu,  7 Aug 2025 15:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yRhKoxgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3374684560; Thu,  7 Aug 2025 15:42:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3427584541
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bySxk1hWbz9t1y;
 Thu,  7 Aug 2025 15:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754574106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sa/Ku36/P5nsKO/L24rU1lbovbT/4ICrqorBo69GYNg=;
 b=yRhKoxgEj68nREGdgAUj0QWq+7PesEH669KHtV71e/E5JPpQkxYJuwcMQasBJzIep8pIUW
 eqmuGTZCwQd2j46565/6XO3WWG4fvIMW8Z7R+S0/sDCXifRCx+jOP73RBM/STInJwIeRyz
 WPUNJaehjVPDvo/OYXtpuyHvYSyHF+fTCupXxMP/ZCRZMFDR4dLLm0wPhfK9fsKd4w18bg
 iEqvnW8/mJXhtkxE/7PGa3G++HoGmFkXI3LIXksnYLCzVy6LNkiU5ARo9ah8900O4u92wc
 JTEV2IGykG++2whWn//KKn3soCd+1HM9DsCyGDgB9rDQVreyYUwKYbr2KzKf8A==
Message-ID: <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
Date: Thu, 7 Aug 2025 15:41:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250807102436.452691-2-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0d0a356bc8ac2733a83
X-MBO-RS-META: ohjcdtf3d4bg14gkcwqu9zuaojpfcxs7
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

On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
> "zero" as "unlimited".

This sentence makes no sense. Is the variable not obsolete if its value 
is non-zero ?

[...]

> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c2aa88f59fb..36eed766d31 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
>   
>   config EFI_DEBUG_SUPPORT
>   	bool "EFI Debug Support"
> -	default y if !HAS_BOARD_SIZE_LIMIT
> +	default y if BOARD_SIZE_LIMIT = 0
This looks wrong, no board size limit does not imply EFI anything.

And use some common sense and reduce the CC list.
