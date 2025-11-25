Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45265D0E6D8
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF5884011;
	Tue, 25 Nov 2025 14:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wyEgLJBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A660D84011; Tue, 25 Nov 2025 14:02:30 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAB183FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dG2sV3LyGz9twM;
 Tue, 25 Nov 2025 14:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5boNwHv5ya061yqBKGoV+WfyxP69UmUkpOpb+Y8ftXA=;
 b=wyEgLJBREh4i4xbdAZVz/6VxnMBGu/23gM+gO8RKZ1XcILekY2PTKzfWLHVCfk2H10DruI
 oejmf62/6zqlyWraQwmhLxlQnPMQZlScmobJHPzUPqXIkXZ6LMDbqkSsfvoX8fy46umkNn
 HGbbYcyJRV1rFgZ50sGrj+JSi2OTkIcOCLNC7faeRIvc0kNMTMZyGNbrerGyk6hkcUDbB4
 GbmorpY2BPjZknj+3oVzpCiNZY5m0BxJm8ZAwHFJGY/MHiIrcqNgMXfMImd7PP7lm7zYvH
 NSNCRLqWIeYBsDJhV6b2qMJualHjVzHdLvCGFupGYYsFLXC5vKdgr8Q4CCOtTQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <45a5d75f-99f6-4583-9071-2f892aadb2e6@mailbox.org>
Date: Tue, 25 Nov 2025 12:55:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, dinesh.maniyam@altera.com,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
 <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 34a98f32053b4a4c1a9
X-MBO-RS-META: 5rw8wcwomwt6tquh8wxyk3rcmpojuwd3
X-Rspamd-Queue-Id: 4dG2sV3LyGz9twM
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

On 11/25/25 1:00 AM, Heinrich Schuchardt wrote:
> On 11/13/25 04:03, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
> 
> Thank you for looking into this issue.
> 
> In the patch you use CONFIG_XPL_BUILD not CONFIG_SPL_BUILD.
> 
>> to prevent running `chip->scan_bbt()` in SPL builds.
>>
>> The SPL only requires basic NAND read functionality to load the next
>> stage and does not need full BBT management. Running the BBT scan in
>> SPL unnecessarily increases code size, memory usage, and boot time.
>>
>> This change ensures the BBT is scanned only in U-Boot proper, where the
>> full NAND subsystem and dynamic memory are available.
How do you guarantee that the content that you read from the NAND is not 
corrupted, or read from already spent cells, or is even aligned with 
what U-Boot would read after scanning the BBT ? NAND suffers from 
considerable bitflips and short cell erase cycle count, the bad block 
table scanning is very likely mandatory. Disabling it because it 
increases code complexity and size is not a good reason for disabling it.
