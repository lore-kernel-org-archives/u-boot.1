Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3F5C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D76E83721;
	Wed,  6 Aug 2025 16:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RB90jW2e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xHnNKkS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387CF83942; Wed,  6 Aug 2025 16:35:56 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571B5836D3
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxtBc6vtwz9t7G;
 Wed,  6 Aug 2025 16:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754490953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENdtw0n2L4cV+syIIrkJKve1nsH03qnGlpoGfKZ1Tws=;
 b=RB90jW2elcXjMMfAJ7oi3cMVCp6fvUMuy73oAPi+yjgn34FYxh8bM9Q8FNVz+1niT+vGpW
 CGEl6Ajdm2pk2RLXIsPxC0v74yh69RHOr8M0yA6ltdepg/jH4j8FiOsPZ6xWw+Nf65y7Fq
 tfenMC/gPskn31wxRuhKRVMvjILTrBKOchLTAjead9BBRfYWkqbPOp7Y/gkM/TbJvUAuVy
 oDQeR87xd6m82+a0FawINmOfWF/n88V6jwBCZXM43y5lIVMH4MFogIuy6LpKvRMX/6as3H
 8/c4pIS2qXoMexGi0QMEz5AzWb9jCY6GYrRdAtKH7qrg3+Bi152xuP/OaWaiRQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xHnNKkS0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1985b227-7b2d-4299-905d-fc860eb698c9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754490951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENdtw0n2L4cV+syIIrkJKve1nsH03qnGlpoGfKZ1Tws=;
 b=xHnNKkS0jjB4hLNsaMKkSscNm+vfLN73MSNM9+LuwO1Kmz2m0rGm1WRZtMQpHji2L6yEWe
 SxMAbr8VgqT5teDotS77dak0DZtbe1xjGy5hbSpJnJUIgQDu+GDrlfHE7JzJVOiWr8BzuA
 WI/OmvIk6UfNck/9njX88yGHPJ6LKdA0S8b4bZxFmZsDYK6heVNU3EHGxVTsrCvyJa6R/v
 aCjoM/cKv6+/aQLpppah+feLBiqF1ujDpeqgC6QmbNPkFgrYJMFLE7GtpRIWXU4POmKSCE
 BCmyNC5Q7t3Entrz7Zu0s7Y/SjRz2Z2Fy0oyCPDyi8Jp7PV0SPc3BxNOttbNEw==
Date: Wed, 6 Aug 2025 16:35:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: rcar_iic: Do not use unitialised variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250728-rcar_iic-v1-1-00dd08660421@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250728-rcar_iic-v1-1-00dd08660421@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8a702a5e72da496d9f4
X-MBO-RS-META: 7r4rnzfusefkiw41ay3fdgk9aoncsqcd
X-Rspamd-Queue-Id: 4bxtBc6vtwz9t7G
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

On 7/28/25 5:04 PM, Andrew Goodbody wrote:
> In rcar_iic_xfer if nmsgs == 0 the ret will not be assigned to. As ret
> will always be 0 if the for loop is entered, may as well just return 0.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
