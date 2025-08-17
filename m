Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E06CA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 12:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7168C83845;
	Sun, 17 Aug 2025 14:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qsQtlQ6q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="opMVPepz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F286838C5; Sun, 17 Aug 2025 14:27:08 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC7783844
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 14:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c4Zpy0rBsz9scL;
 Sun, 17 Aug 2025 14:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755433626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZUkoSk+57sxvxsrnFXNMdogti+znJHPM+3UXVW4cuc=;
 b=qsQtlQ6qbjn6aOWFLYZAc/JWJmyaINm4UDpS40Fvqjh6zS9TNXWQ3OHILeyNAlBHBJfs2E
 zU8/iMStBvj1nBrid92P9YZZkVljYvkpHbFeKF3JvHalO6lqUoqU27LG/cY9BPMsMmBhYp
 tdjFvBL2R3cB7su6uKwDKel1HRfHpU40CZkNDMdZnQB3rwAegqO4rWyKCAvxCkZI/69Q43
 1lzuzYIMsyqD3bWDRtYEO9dmhUiRxkrT7ZuU7Deto5YDVHEKcICzDVyHKvNBVdkwTC0ski
 xSAIQh1vtc77UFoHQ6Lo++tZFqzcillsXQd/bJ/lQvri5wvCSM+H26ujoxytsw==
Message-ID: <ac2915fd-a91e-4b2c-a733-ee45e3f4f58a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755433624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZUkoSk+57sxvxsrnFXNMdogti+znJHPM+3UXVW4cuc=;
 b=opMVPepz7OtUhu1KjMB6/xUwOuzZJKvEVbYpZm12jOTFWWgaxgfiOkRpEb9pxVBXc2Whv9
 POoi8fUwjxtnRihyrGB2jfoOTvNQmsr+3RC9FJn3kdBEHK09KZWKWajEOTMjGRcTRr+RsV
 iUyUPfmLuR5qNBotBROWopzJ8HMdf+AX6RAQOap1VG8h6k4LU945W48tpLUi/KxPBLyjoB
 OJtuJb4pCp6quBKpUFptvkoZ8yd4bC2w5FzlBG6Ol4c0idUnmYTuk6SXyEu09USwbYETjO
 LDtVBx7safa7C6xFKIU70QIlilZUG605J0CZ1xqeIPqazzEyD94zD3GGNgykxQ==
Date: Sun, 17 Aug 2025 14:27:00 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v5, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 daniel@makrotopia.org
Cc: lucien.jheng@airoha.com, frank-w@public-files.de
References: <20250814151253.11053-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250814151253.11053-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kg4dybmsbdnxqj9ei4mefoyxgcnidxw7
X-MBO-RS-ID: 5f92670f2cc052befa0
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

On 8/14/25 5:12 PM, Lucien.Jheng wrote:

Hi,

> +	if (size > max_size) {
> +		log_err("Loaded firmware size 0x%lx exceeded maximum allowed size 0x%lx.\n",
> +			size, max_size);
> +		return -E2BIG;
> +	}
> +
> +	memcpy(*buf, (void *)addr, min(size, max_size));
Do you still need the min() function ^ here , now that size is surely <= 
max_size ?

Besides that, I think the patch is pretty much ready.
