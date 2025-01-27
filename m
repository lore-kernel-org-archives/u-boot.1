Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE529C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 11:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 029C781119;
	Mon, 27 Jan 2025 12:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="et9/BnzM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PWxMNKO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C6B8111F; Mon, 27 Jan 2025 12:45:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178A981115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YhRRY3r5qz9sRn;
 Mon, 27 Jan 2025 12:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737978297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oS6gGgPBSH/dYs1qhK8rsYbPjRGj3Iw+lGgJfQzTG1Q=;
 b=et9/BnzMCD02T3g8YWcUrQdMRYHAgYOEYZQIjKitpY26+4f/50yURK3kBvGgpiNNPWm37m
 UuooT+IWK92QfvocQHSCuiGqw3kYDvWcAhNXDyhCRKnT5VYz+QQQoFy0jupYbpYZe72fyS
 5TPMDfCSBDm3sjMGNVpnDbJpe/rzIdQ0JBk+LqjD75BCXB8hah5cAkYMJqDUHSHKTBTBPw
 HTNrwkwDCgHHsX5+zUdqlC+9GFPa09Ki8PfcPmvZidftoS0rr4BFMp7tI0IP7X4mmzvYSv
 xZAsKRKHFSqGwUeUXBMiEoA1L6gExvUAGcw9OJFQA9uaisEdUUGMAvSXzgjarA==
Message-ID: <e09dbf26-1cd8-41af-bac7-c14957f42108@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737978295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oS6gGgPBSH/dYs1qhK8rsYbPjRGj3Iw+lGgJfQzTG1Q=;
 b=PWxMNKO1/azRdmtpGUt9kzZ2+/2a0omJl0PVzxe2bQ5ZzWFDKJEmwIHgSu/ydOuhMYtrNM
 jBBhal445wjC34XMvND6d1a0z3ekLNeIquCaZNV9SSjHCF67UPAWLMT0GC5lx7DQ8eOMqY
 BQGNHIAiEhw1hnO85vpYNjaZyUndHjvQ7MkRjKVHQolMkH5SHDROygpvt25HVqR+mjJmnM
 FqTVG8NDj5Z1od2gz9vmvD4cmN9ZGP/6NdX4UE6+s2lhxCO4gOpd/juRsKLa/NRwJlz+Ti
 XAbN18BPWQ3ok6dj/DhwVeSDaB0YJX4hXsLvnBgk8swK6+ycotQGaxk1toGKhg==
Date: Mon, 27 Jan 2025 12:44:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] cyclic: Prevent corruption of cyclic list on
 reassignment
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ronald Wahl
 <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
 <87cyghx2ru.fsf@prevas.dk> <f2192348-1c8b-4858-b138-e1a894dff92f@mailbox.org>
 <87r04putxb.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87r04putxb.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8gf463idit78yys7t1o71fp3bhddu849
X-MBO-RS-ID: 9c772055a65ac336cf4
X-Rspamd-Queue-Id: 4YhRRY3r5qz9sRn
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

On 1/26/25 10:49 PM, Rasmus Villemoes wrote:

[...]

>>> Also, I think I'd prefer if double cyclic_register() is allowed and
>>> always succeeds; this could be used to change the period of an already
>>> registered instance, for example.
>>
>> This would be terribly overloaded interface, no, let's not do that.
> 
> I disagree.

Can you please elaborate on that ?

>> Better introduce a dedicated function for that kind of period adjustment.
>>
>>> Also, that avoids making the
>>> interfaces fallible.
> 
> And I believe that _this_ is an important property to get/preserve.

What exactly does this mean in this case ?

[...]

I'll see what I can come up with in V2 for the rest.
