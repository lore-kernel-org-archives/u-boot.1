Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96693E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 19:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A668004F;
	Sun, 15 Dec 2024 20:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L1CcsRA7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RbpMEytC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8541580050; Sun, 15 Dec 2024 20:03:56 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545D780040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 20:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YBCCr71Kfz9sl3;
 Sun, 15 Dec 2024 20:03:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734289433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdabCcjHzlkeSuWEpS5tJVToKlnt9q3y9wZhlvPOo/Y=;
 b=L1CcsRA74eCHL7cOmczzOqEn/egKv8PFHu0iNKRZSxSYYjsVcoVvQSZBQCgeVw4JNa59SR
 7VacpfgJlsAzxrTwc+B9eZTRhB7h8cxE3+AzB1KUTTcvjzPJlm0Reqj/wAVhQLviw2atIb
 9gYy90/Ncamn9L2c7H0EbwSBH+ir9Q6fhzafnWVGwCM/G3HYduTlJ9mfBkMYAMK2QMoF+Q
 veF71rBGpLbV/DL8YpV88LK1EVPYbkCSeQLL8SP0+VA+/h5SWksiYZ9vMU/f59TPHCQ0b9
 iyuIcaEBBjECfiuvaDEAJADsGN9VQkanc62cohuSk+9teG5lTGw9j7knSzGSYg==
Message-ID: <3ad25e20-c7db-4fe2-bd09-b6306f218a0a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734289431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdabCcjHzlkeSuWEpS5tJVToKlnt9q3y9wZhlvPOo/Y=;
 b=RbpMEytCZMentQcTDLyj6u3MTJEX1P8xBEHQaLCNPVYNGyO939BNu4a7T/zNNG1Eg27YaD
 UjXnRyAzrIW/GEjDPXDhgESIsrPrLA4Uk/VLuOKkla2oF8D0uR+A/V4CqTB4aOjBtFeMNB
 tPql9h0RAKlyPcuTvIS6Di4jF8HfZ+A0oHwEeo2VVooXbveC2qnYG1+9gYOsBB5VxAa0+P
 ptHDUWHUpZps4CFDWdcoqvf3jihcQOSYY3bcrniqI5btSiH0bJV79lt3Q6ZL+FZFPvAXir
 CsXETOUNnBbPCPDijEXuN1/5I6GPlWxKrqIGyWBLllhG/CF2GIPu4c5Xpf49aA==
Date: Sun, 15 Dec 2024 20:03:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: renesas: Align configuration headers
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
References: <20241214224529.303866-1-marek.vasut+renesas@mailbox.org>
 <20241215164844.GD1505244@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241215164844.GD1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3eae3872353207ac316
X-MBO-RS-META: fwphc6ng4oyy8cpg9qbmhfzpwsnth7jd
X-Rspamd-Queue-Id: 4YBCCr71Kfz9sl3
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

On 12/15/24 5:48 PM, Tom Rini wrote:
> On Sat, Dec 14, 2024 at 11:45:11PM +0100, Marek Vasut wrote:
> 
>> Align R-Car Gen2/Gen3/Gen4 configuration header file to look
>> basically the same way across these three SoC generations.
>> There are subtle difference between the remaining bits in
>> those files across SoC generations, but the common bits are
>> now aligned. There is not much left in those headers either,
>> most of the configuration is now converted to Kconfig.
>>
>> Specifically for R-Car Gen3, GIC registers have been moved
>> to architecture specific header file rcar-gen3-base.h , the
>> rest of the changes here are comment changes and indentation
>> changes.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   .../include/mach/rcar-gen3-base.h             |  5 +++++
>>   include/configs/rcar-gen2-common.h            | 10 ++++++----
>>   include/configs/rcar-gen3-common.h            | 19 ++++++-------------
>>   include/configs/rcar-gen4-common.h            |  8 +++-----
>>   4 files changed, 20 insertions(+), 22 deletions(-)
> 
> This is good. As a follow-up, since it's a functional change

Is it ?

> , can we
> just switch to the default CFG_SYS_BAUDRATE_TABLE of { 9600, 19200,
> 38400, 57600, 115200 } ?
We cannot, because the new(er) SoC generations use 1843200 Bdps UART 
baudrate .
