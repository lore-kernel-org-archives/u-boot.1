Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32702C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E674984B76;
	Sat, 11 Jul 2026 02:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GIvMQxd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434A584B7F; Sat, 11 Jul 2026 02:17:28 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7B384AE2
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a38e51ae95so128300eaf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729045; x=1784333845; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vrpv5axbMufurX76QC0nohTcRcTW5lo9lCMlFCpC3K0=;
 b=GIvMQxd/TI2cgDf12l0XZD7jdeyw2bppUUEWRyrjgNq5WDUcQ6h2wfxg+hn7Is4u7s
 Bd8UNJlII5yM1dVMcGTvC+Xs6JH83LnLcZTFek0bLSDf890yjcF/vUo4VbuzY3OlG3/A
 1hnGBuCnPc8iupOpgnD7cNTG9QG9A0A7F2Bd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729045; x=1784333845;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vrpv5axbMufurX76QC0nohTcRcTW5lo9lCMlFCpC3K0=;
 b=A61OCXFz3fDMI/TzqbKbUu4CBp+rQvzBdgap7zcvjbQWeI3kB3pyT7BN8kDgqtiuoz
 W1kiYmkCTHYQ72KgnyqIeRBPIxRmCrVnofdOO1jEy+S2X0ViwTylldOqg/izAtoH9wFh
 5ZYGSnHdbIhlA+6Dj0h3AZNVKUhrUtsRoEdXCq2uqFwNu0y2buMGaMYao7Z5fpTWlyvt
 ABp/xIAK9P4OQFj/jXmiDODZKh3qsY+dfevornaQKbmbuwzHdOK19XduVELMV6f509tO
 Nvg6kaaxhD1rWwPDYap1Z+38KyhbIKmHdjW1yTEWmTETXmCzWHMv2z2+BGTwz9nRrcXz
 Dh8w==
X-Gm-Message-State: AOJu0YzWMzI2E7GaiwyRPxNGejNzSD1e8DMQ94VVC8QoT1vct1JGade+
 eADB+XnoHtnqsG6Hi/KAi74T7LYJdrzcKuNVnnR1i7WrVLs5omO2ZE66c1RLqhC1yHk=
X-Gm-Gg: AfdE7ckgTLMxNKWQCGLpATdxkmlWwnO3CXOeMkXOS/GmOPrd4IGJ7diRTnpkIx5DVBe
 r83VKQh2hXuiYmT73Ne6D+WUDddbhTUtD0zXEzogko7aas0N0hjy3eUhRhMpktuVHJcpZ1UyQqH
 LKlSdsLz5EvxFiQ+KXO0uAl8eVxBayGQPjqIZ4VdZCQpr72SMF5NbgAqlC8GTDjDJxbjlk5oZvA
 kuSnG05jH+cC40WqsgZt4L2CEphoJfHa8G6B4TLknS/1zZ+rk4aWAmxS5UUeIL0j8nCTLC+i0Lh
 HVUNTpA5pUcDDfLNoCZxUdXu+2t5NsFze+GXNgy+XZ+fi3QTz75/YR0DlNyrfx05UB2SGagsrex
 7PftkbmcVfwtI6te4Dhr2M0SpKvQzElYpD2Fx17My9nNBg/lh/QUMmktbgJlv9RYZRmLD3gSYeY
 KcxwFIhiewqh8HrmSF73mWQwlmrH4lMNGWwJes3S1uumuySw4tAyppe+nvMOJBA//0sXLnhMF1+
 T+wQqJaXaqQj3WKVJWdhLJASHayRCWzT7n7U9uSJncty+4=
X-Received: by 2002:a05:6820:1c88:b0:6a3:9853:acdd with SMTP id
 006d021491bc7-6a39a6dd184mr840889eaf.33.1783729044803; 
 Fri, 10 Jul 2026 17:17:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <tuv7mfxrzuciqveqccoy6gl77szlhfnz6nr5wohjmcmevjlxpm@3l6l3zj6rxxl>
References: <tuv7mfxrzuciqveqccoy6gl77szlhfnz6nr5wohjmcmevjlxpm@3l6l3zj6rxxl>
Subject: Re: [PATCH] cmd: ini: avoid NULL deref when loadaddr/filesize env
 vars are unset
Message-Id: <178372904420.2905849.13717618743885643937.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 26 Jun 2026 09:18:02 +0530, Naveen Kumar Chaudhary wrote:

> When the user runs "ini <section>" without explicit address or size
> arguments, do_ini() falls back to env_get("loadaddr") and
> env_get("filesize") and passes the results straight to hextoul().
> env_get() returns NULL for an undefined variable and hextoul() does
> not tolerate a NULL pointer, so on a board without these variables
> set the command dereferences NULL.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: ini: avoid NULL deref when loadaddr/filesize env vars are unset
      commit: b81e716b263479e7e2194f9a2df3c04c83307545
-- 
Tom


