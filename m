Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39955CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 17:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438E883642;
	Sun,  2 Nov 2025 18:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="duCyU7ew";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W4M+V1W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C695D8389A; Sun,  2 Nov 2025 18:15:44 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C772830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 18:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d01ZP69lpz9skk;
 Sun,  2 Nov 2025 18:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762103741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEpac7KtMO66C4ljjdp29exvYuPHfvw43gk6c1WpMPQ=;
 b=duCyU7ew7+jCCSn4fcoJQ30YvivcaCwAGVyjnqxOBkAIY3pXGymqvH5CPDFOII/JmgvPHF
 CYqiSPCCcEeayhgTDNKYMZrPA+1d8M1nj0sQ5eGOI5PUnUF200nJ7QWc6pqfgmfl101ZV9
 miqbWWOsaphleJVhBaooJwtQTJRRcI75DRp+0EAhdKN+aga3gKF/O+Zf6QNCNUSGcxFY/L
 455RX2qTfIvKX5/zxDWyC7y8a3IBLOoc4t9TdqQaIDpWm9sMDW0wN7HAX4fI6185FdEdVY
 XuJGJRz/V52MVkWF7VFSItW4f2NQM9ZsUEeO1xt416ap1fwc0hqpov11d/fjxw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=W4M+V1W7;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a3e748e8-8785-4f74-bed5-5fd1c517d44f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762103736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEpac7KtMO66C4ljjdp29exvYuPHfvw43gk6c1WpMPQ=;
 b=W4M+V1W7pVNVwmJhbJ1RNrKn7Lv783NuP8KRmQm1P+CD00PL/KdZr0goIuuJfs756qoKae
 Vf9aBiDKS/mAmgrAKuDKzp1Q81Ape+b0CGF+w7caa1Pd0xGjSv4fdDE9nBnKGQVqmntmVC
 m2mcN4kokHXgjtev4UYXnmmPwJ3g1UEbBYK2dybZult5UtCZeo1e4QI8AWx4iddCkLivPu
 zM7o/LRXWul3Svk1SDCWxG3tfJ2pme0inUCH4bdwz4bfQdQTnSOIO0s7jgbiG93a7bKHkC
 Ixjvs1pk0/QVNEFWuM4AhOkBvRytwWhUnjMGGgHqL0KMsc4qNXJ09EFiNlvAxQ==
Date: Sun, 2 Nov 2025 18:01:17 +0100
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: "Lucien.Jheng" <lucienzx159@gmail.com>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006124915.13647-1-lucienzx159@gmail.com>
 <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
 <0c7f155a-3bdb-4d4b-8f2d-3b79eec3cbc2@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0c7f155a-3bdb-4d4b-8f2d-3b79eec3cbc2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6edd3ac7f5f98029854
X-MBO-RS-META: 5ehezp46xge4bwxnd7wzxdca8pa75yem
X-Rspamd-Queue-Id: 4d01ZP69lpz9skk
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

On 11/2/25 4:34 PM, Lucien.Jheng wrote:

Hi,

>> On 10/6/25 2:49 PM, Lucien.Jheng wrote:
>>> Synchronize paged PHY helpers with Linux v6.17.
>>>
>>> Add support for PHY devices that use paged register access by
>>> implementing the following functions:
>>> - phy_save_page(): Save current page number
>>> - phy_select_page(): Switch to a specific page and return previous page
>>> - phy_restore_page(): Restore previously saved page
>>>
>>> Also adds read_page and write_page callbacks to the phy_driver
>>> structure to enable driver-specific page handling.
>>>
>>> These helpers allow safe access to paged PHY registers by ensuring
>>> proper page selection and restoration,
>>> even in error conditions, which will be used by the Airoha PHY driver.
>> Are there any users ? If not, this is dead code.
> 
> I have checked the latest Linux kernel, and these functions are 
> currently used by several vendors, including *MediaTek, Airoha, Marvell, 
> and Realtek PHY*.
> 
> Therefore, I believe these APIs are not dead code.
This is U-Boot, are there any users in U-Boot ?

If you plan to use this in a new driver, then please send this together 
with the new driver.
