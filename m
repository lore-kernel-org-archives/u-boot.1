Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4908DCD5854
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 11:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770D1839F1;
	Wed,  7 Jan 2026 12:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GIYtIO3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEEA83AB8; Wed,  7 Jan 2026 12:45:31 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB11839E4
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 12:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dmR6v0zcFz9sqh;
 Wed,  7 Jan 2026 12:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767786327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CCOSrOWfSb34/TlMRQc6w5Wa+bc5mfXdvQ9aeir3rE=;
 b=GIYtIO3OhfCPW9p7bwtRGi/juLPjX25ixuh6//BhSsudCVXFzrRJg9wuyygnYvh7VOrBZD
 2QZIaJnwPTlNAwqEh2/mTSaRzAsIpVLmj5+H7CaP+IvF2WzyWYeWVMRGHY+Ji4EDfyZNEz
 O2ZQzlLw7B3L/gMf9ySzsBD7augHiGV2q3mmgt8WwowfPKPJZMJHX3w9F3Dd27kx/RQiv+
 yTC7cd5WV8Ew3I/mvhojbBzs5tVD7mLTDAda/3vZu94hduIsO0CYw/d2fsCw1R/KzyPPdG
 eFH8UmsWnvN8I7JTg4RmxiNyNdAlp5XXuWdtBqULV6ssJr30iTrMjkXfsZk48g==
Message-ID: <9d6469c3-aeb6-421b-b7a0-ed1bbc829fe0@mailbox.org>
Date: Wed, 7 Jan 2026 12:45:24 +0100
MIME-Version: 1.0
Subject: Re: [FYI] ufs: rename split across commits
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <689907b7-f185-4357-8d84-f9ef23036701@socionext.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <689907b7-f185-4357-8d84-f9ef23036701@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fo96o7proec7ct94eh5d6hwrq9w9s714
X-MBO-RS-ID: 34a079b7b3ebaadab44
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

On 1/7/26 7:06 AM, Kunihiko Hayashi wrote:
> Hi all,

Hello Hayashi-san,

> While reviewing ufs history on main, I noticed something that might confuse
> future readers:
> 
>   commit 1de63f1be48b
>      Message says "Rename ufs.c to ufs-uclass.c", but diff only deletes 
> ufs.c
>   commit 067c1b033282
>      Adds ufs-uclass.c together with .post_bind changes
> 
> So the rename is effectively split across two commits. No functional issue,
> just a heads-up for anyone using blame or rename detection.
> 
> Sorry for the noise if this has already been discussed.

That is a nice find, thank you for keeping an eye on these commits.

Indeed, this seems like some sort of an application error due to file 
renaming.

You are right, the resulting ufs-uclass.c is what it should be.

Niel, do you know what happened ?

-- 
Best regards,
Marek Vasut
