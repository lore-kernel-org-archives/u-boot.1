Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32526CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7688883CB9;
	Wed, 12 Nov 2025 16:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sSBXSGUK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FmHVEHUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09E183CBD; Wed, 12 Nov 2025 16:24:42 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A9B83BDD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d66df5KCKz9v7q;
 Wed, 12 Nov 2025 16:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762961078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMOAxC7ZQ2HpRutxzDQUDJMRZmkBobwMWbzJVpkkguc=;
 b=sSBXSGUKlg8Q6PDxM+fKA2SsKBjLnw7EU+PqRL/Nlb20l5sSpVSHCVj6LWnMvPhbEo62F2
 eDAQmj9kxQNFYI8fdT3YtemEwFvdz8CvI/HQ1U2BPo3Buh4FiuJ2W9rUMR6Mi52LCw7KQ+
 FB0DTkw/3CxAMXz57pnAy8O9b5iTzYcLwqKIhqmkIhjnqOiaaqL3VK3QEJwF1RLkpDjKHh
 ly7BoA2lm+uFrX+EVRUYvQVQ6pS6r2tdN8k/E1/Bijuon2AVZiPW//yk+pWuSyIKLZWojw
 fTpEtHXoB4xE2VQOWGJOHRuOm3ED0/ssizsvMH4s6hqxZA5H7sIAUhDvhbLmew==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FmHVEHUj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1933c9fe-22f5-4405-8938-fa28fe89a330@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762961076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMOAxC7ZQ2HpRutxzDQUDJMRZmkBobwMWbzJVpkkguc=;
 b=FmHVEHUjdoVrBfsDtr+XPxkZHExrl1fPneVwDM4qqX/jY6WWLvOWf9PZS4YjYcu+DegrzP
 3GV6c5orS4uHMrGshWfH3AZ1DATlgdATDsaFI/rn3eZCKwvEZVLC5442usUMVEYsKmxGq+
 rHqmj9oh4ucghFriVyCOIhaeHfg8GJdC2FOFy2eLXLJEIcduLbkdiL1giiuieG5rU4sf5V
 T3xuZu4UR3rcZ0Si7/Y613YU8yJAYIiveTGTeSInvrT5SZNru+RZRupd9QU2SGQu9LOSKi
 +xb5N3lwYS+exYfse0bdIFb3bYP1QruxV4gk4NQZa2/z1TXTh/hfq9oFHRq3QA==
Date: Wed, 12 Nov 2025 16:24:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] test/py: Use aligned address for overlays in 'extension'
 test
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>
References: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
 <20251112133558.GY6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251112133558.GY6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q9chfx3xmn1gmiygq6bo49ub3y7xjaf7
X-MBO-RS-ID: 5d0a5fb50a7f946f803
X-Rspamd-Queue-Id: 4d66df5KCKz9v7q
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

On 11/12/25 2:35 PM, Tom Rini wrote:
> On Wed, Nov 12, 2025 at 03:02:21AM +0100, Marek Vasut wrote:
>> The 'extension' test would set 'extension_overlay_addr' variable to
>> decimal 4096 due to conversion in python. The 'extension_overlay_addr'
>> is however sampled using env_get_hex("extension_overlay_addr", 0);
>> which converts the 4096 to 0x4096 and uses that as DT overlay address,
>> which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
>> as intended, which is aligned.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   test/py/tests/test_extension.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
>> index 61223496054..ddc62e7d5ca 100644
>> --- a/test/py/tests/test_extension.py
>> +++ b/test/py/tests/test_extension.py
>> @@ -38,7 +38,7 @@ def test_extension(ubman):
>>       assert('overlay1.dtbo' in output)
>>   
>>       ubman.run_command_list([
>> -        'setenv extension_overlay_addr %s' % (overlay_addr),
>> +        'setenv extension_overlay_addr 0x%x' % (overlay_addr),
>>           'setenv extension_overlay_cmd \'host load hostfs - ${extension_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.config.build_dir, OVERLAY_DIR))])
>>   
>>       output = ubman.run_command('extension apply 0')
> 
> As we often get patches to remove the "0x" portion, can you just correct
> the format character? Thanks!
Do you mean s@0x%x@%x@ in this patch ?
