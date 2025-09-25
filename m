Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BBCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A600180819;
	Thu, 25 Sep 2025 22:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="k/AktlfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F05982998; Thu, 25 Sep 2025 22:53:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5647880107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cXmCh31V6z9tDX;
 Thu, 25 Sep 2025 22:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758833632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnY4xQv9jg7WxzBuA5nqXyFFwGDwbsPImwhZR2+YZJE=;
 b=k/AktlfHJh0jHcHSeGoosxFX+y6dO+6odGG6SYYYzo0te3AK4lB1gLG2RCEP82V8AJoP/q
 kQH4VX2E+scAsvqo+Dz1Kc8JBRUQI4bJSGWBOd3c8/DzLkWWHlwpefynsxvZYXl5Ilz8Ar
 YEkpbPGsZwkgytkoQljOgYIKYh4+SzG1tbtIV58V78aCFau5QWEe4O7r8E9xgXY8Hgh5zI
 OnXfW2Wt1rYV7eVcJrdhH0Z4y/a/AArdQMR3Ema2ZfRKakkHdk2PK9YAQ613sU8hO9L5sw
 P+C/hHQi8vrN/Fg8DbH6utIwOovuzSPVo61xuZ7gLj3Kel5rxxXKCjSOKe1NHQ==
Message-ID: <d4d60493-6c8c-44ca-8cab-4661f8bf5cd8@mailbox.org>
Date: Thu, 25 Sep 2025 22:53:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] usb: musb: Remove reference to drivers/usb/musb
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
References: <20250925204225.3560724-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250925204225.3560724-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: eb4bfbeb09f5055bf9b
X-MBO-RS-META: 1x9ptdu4fcpojdw6q798nyd87f7wasc9
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

On 9/25/25 10:42 PM, Tom Rini wrote:
> With this directory removed, remove the reference to it in the list of
> directories to traverse.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> 
> Marek, can you perhaps please fold this in to Peter's 3/3 on musb
> removals? Thanks.
Which patch/series do you refer to ?

Can you both maybe prepare a combined patch/series instead ?
