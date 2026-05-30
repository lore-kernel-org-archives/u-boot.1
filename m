Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046B1CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0593846FD;
	Sat, 30 May 2026 15:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iGozy/Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F09B847C4; Sat, 30 May 2026 15:27:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE53B846FA
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gSLd66z9Fz9vH6;
 Sat, 30 May 2026 15:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzR8uab+C4Mm0f6sZKiOCQ12OIB5p1gQHsm3++7ueiQ=;
 b=iGozy/RnkuiL5vimhOMze1hRY7qK9s6GIQpN93hsoKjDbjs6yg0JQcDGH6wdlzeZjvY84Q
 T0mLIJbJ1/BbRkL2+HR2SSwmnnljpxy8mZfm/9LTqGRMqh1SYp0Ee3mWGniCJLyVTak9Rs
 uOU5Rr3ogJFz0kyCF73WfcZJGKz3OnRNHMoEngx5jDSzKqoZI8FD7vJ1OfN4Mau2VJPrbk
 JG7j9iTWZ4tGfowTKOvDL/0UclTCVB4NXarnpqZZMyJQ1zCkgxFz7aTzUNIHXlIa7A5K6l
 RAR3ObMLdc+AIGRkxo5eEq8KzhknOCFjHxFtP8WEg7uLzupE8/mFQyye6a+53A==
Message-ID: <c2cfc5d2-7e3e-4196-bb34-cfc44c4217cd@mailbox.org>
Date: Sat, 30 May 2026 12:10:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert: "cmd: eeprom: Do not rewrite EEPROM I2C bus
 with DM I2C enabled"
To: daniel.nehrkorn@esd.eu, u-boot@lists.denx.de
Cc: trini@konsulko.com, marex@denx.de, hs@denx.de
References: <20260526060041.3898125-1-daniel.nehrkorn@esd.eu>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260526060041.3898125-1-daniel.nehrkorn@esd.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5sd3exu4tac5re6wrkzuaan3zgeo3ux7
X-MBO-RS-ID: c830a4de2d2db495cc8
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

On 5/26/26 8:00 AM, daniel.nehrkorn@esd.eu wrote:
> From: Daniel Nehrkorn <daniel.nehrkorn@esd.eu>
> 
> We need the EEPROM bus configuration, if we have the env located in EEPROM.
> Since there is no eeprom_execute_command() anymore, we have to configure
> it implicitly.
> 
> This reverts commit e3c2042ae7d188e00e48d984e373a2de505d8b77.
Sorry, not this way. If the env in EEPROM loading does not work with DM, 
then it has to be updated to be compatible with DM, that means look up 
the EEPROM, get its udevice etc.

Commit e9774afedd20 ("cmd: eeprom: Refactor command execution into 
function by action") may provide a hint for the correct fix, possibly 
use i2c_get_chip_for_busnum() to get the EEPROM udevice and proceed from 
there.
