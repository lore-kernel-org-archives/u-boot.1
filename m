Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4960FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A5F84255;
	Tue, 28 Apr 2026 18:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VrH8LsXg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C6zP2RFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BD9842D7; Tue, 28 Apr 2026 18:07:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECC484119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g4lh23dbnz9vP3;
 Tue, 28 Apr 2026 18:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777392450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izlMu1jW/ja1vOuF4cBmfxz16XepR8MPApDx96iKeB0=;
 b=VrH8LsXgK+EPoeiHoXooAmzIvlMr01EqGKDLToWswMUNh7BKzjirMOxVh88mOO1iwuCG+Y
 0Wyvk+g9nCQ7wAmSZAEHTRwPX016EVVkwBgp5dYmzhS9YfbbbMsjQBji9Gt0TMrorBgoY8
 pxvAp8vNl7IWs6d9ahiahkIz9CkpJu+NiLER2ycnevOXHm7qwMKLR9l4SuOy3SAjcVvY8P
 LVtZmVeXLsS4pt9ipD9yxVn2CdRi/olT5eVzMQ3/dMUQNoesL7YGdGyLAm4PEZp/vgKOw7
 GpEe9Mm6x5FAcwxIm8xJs8V3hE7DYHmxYSGwc+GDkzvLz4eKNH8lnmVCDz659Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=C6zP2RFK;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fcf60081-849c-420e-ba7f-fbaed44ab108@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777392447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izlMu1jW/ja1vOuF4cBmfxz16XepR8MPApDx96iKeB0=;
 b=C6zP2RFKlCF5eMdMYW3KnaPrklRWBpzUicdyUBTZeNhQ+6l9pwrX6jnvNzr1eCwms5Oivt
 KUZvU/UiVUK0cr1R8HiOtgCWCSfcwJ0vPTVkTbTLcq7yYo3/y+IUxJkRGutdwK8mHgAsjm
 JMmZYf/JGRA88hfbuggUOV8wLDT6SW9hUtOFHONBFKdPdgtFa2jbU6WIot9LUK5p9LJyEr
 niBqxrumh2w8uiVXZiLldIHpiymkTCKkWseKeeqLu+MYiWZIct2HfGOzcOyYoifA/munpg
 fYjcBtrEUXzgbPHfDniDod2BXtLZdsW8vtXKYUmEaQ/cKc7nWzlneRna8472lg==
Date: Tue, 28 Apr 2026 18:07:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] test: wget: validate URI for lwIP
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mzbmzwff75bwejfzwyqurycj35km3r4j
X-MBO-RS-ID: 350965b37b9119bce34
X-Rspamd-Queue-Id: 4g4lh23dbnz9vP3
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

On 4/28/26 5:55 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> We've had wget support in lwIP for almost a year now, so let's do *some*
> checks in the form of validating URIs.
> 
> The other test in test/cmd/wget.c currently requires structures only
> defined for CONFIG_NET_LEGACY so it's left out for now until someone
> ports the test to lwIP.
Maybe this should be an RFC until it really completely validates the 
wget command ?
