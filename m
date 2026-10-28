Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D99606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fynmv0Rv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MMqfJaDb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D45F81108;
	Wed, 28 Oct 2026 14:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xACVbHsztYuf; Wed, 28 Oct 2026 14:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2F8380F7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199292;
	b=J2H4a95Z4a5yn3TFAEhKPezfz5I8rR5TMbI7wZf+4qFw8J4j+hp4EeAhPozU5roymKmZ
	 FEyqNqKEE5XvieemqwRKqT8ePkdcxN7WUTYRrnri8InZ0dWy/Ya1b+aLS8TZfk6EXsq1E
	 OiCxCy82vWus4DTaJJLkAJV1lP3Df76+UaVH5d2Vx+vetTucs+jFyrmPhaxc6eA/a2rij
	 LP3957/P6MTZee7mrLNXmqjod4FVarZd7dN+8rDH0nmIyCVLo5MLlCzGe7+AhHqUxzMSj
	 Uxqlli0libeKJ/TVbyUjWsaMv/6kX1YOSCU3gWHnuOXTXbwxc8AZukNIIDyKSQ6Cv3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AU68gS49k331hhapCrKX/wF5GAv7NgL8pIZV5Bq1EGg=;
	b=n6oB9ZP7ZS1ExcEFGEWk6yhr9CyZdnQPhs5KEXzKWjDN9dsnBn345GWVDR/1JIKObJDT
	 dihGGtztffYff7Abr3pkEuaKfAv+ouSVjow1c1r1bRa1f6TIt5PM8deMJCNeJhBT9b/wD
	 RUjnirtz3zAhFSTNLBg96SG13IG9NhWtxv3xS9k0pcV2MCLBAPI+45wRRF0cZnjk3deg8
	 dTWBoXTQ8YOb/9KUo6rPs4v6JKJIhHPBEDv5c/Os9bGqvNdZW5v4YF84I0komEQrRDhU1
	 108ynDEXxuM1HhszC/U42mToQephQgtF34wWOdvtCSTRjoiIDRQ1ZGaQZDyaOjSxjXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199291;
	bh=AU68gS49k331hhapCrKX/wF5GAv7NgL8pIZV5Bq1EGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fynmv0RvG/5LM0RKhBpirsOaTY6zXUsbKfhIXLzxpAzP6KyYR0/0mMLzNjTdav7OD
	 zm9aDqTco3uvcMUvpS6HYnDh/+iwIi22wpZLHFuetPG3+T6VAGI2CfAkBMv9K7hOyJ
	 Mh2sh852G6JLHOFbZz2fpQWsLVbjoAlZv76V5Bc4/QYRwBunWedjUF1oRAKB9KlDVJ
	 dZDvbyHFYkG4ItO6xME2qH3iIght9jgYrvlz3hB6NoltdNXCpfPCj2bE3R3+gNHamM
	 zz+VbZdONUBO5ztxojRNSmuJCPYxzpBpfn+P9EqgWOoeoCa4QkbSQO6eHXobQ9aHcF
	 cfQs3/adX+yeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2F8380F7B;
	Wed, 28 Oct 2026 14:54:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE5D356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50A5260633
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xzPIlUo89Nw for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD72F605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199282;
 b=TmcqwJaHsxAAlU35iRX32U+v0Gf5IUSDIaJM4I7hCfytlIwqrYxNkrm7siSUVIexcL5D
 raBe/AGmb5LE3LL7A5UkaiGfmGPDVNbbeH21ttWg1UwVGwXfIXwR4EinaQMfrDz+JCLI9
 19BgnbFTIBWPvg5lT2BAjY1YqnKU1Wf7rt1q+yGJIpkQdk5v+0YJrABv4kYvt7aWWdzfx
 SqjqCzh63IsOF2DZYOncpRn8bZY7NhHdhKUg9vOZ2IgfPhVvu9J4x2YInpwqn8hdF/uPC
 ojR06IvhvH3PtHBCON0ATV+63UcldJqYdPy6i7mW8uu7QuAQ+J4Sbowrv66KrcVCMMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199282;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=AU68gS49k331hhapCrKX/wF5GAv7NgL8pIZV5Bq1EGg=;
 b=k0K91TOfN9zF4yiUTnFypxk7pM7mYqmjU8RM0IBirJy3fwtfTEZOvGb0yerPwvjdl6Ga
 LZxJhIce1qlJ97kBtZLNHqk7Gt/W6M4DFoMxlYSMAFq0yLfvFN4/q5K8xr193vtQehqHU
 CvCxmpVaDZ3gvsdBhgjzXfIdM1qgvMVRgKl5WshJURceKHv0Xt0NNRb+mQ7D2yP9wfk6g
 X/ov34MmIQBzWUrKCAU4ytk79BYvGskteb/oN3CJciwSqKHBoMLECrW6yT/T6//usl2U1
 Zn1txk2eXvK7MsBNWxtTP8suD3Vs1HZOAoSKd9dTxRCnDVGBhdTTH6rGcUiMyWoEK3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MMqfJaDb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MMqfJaDb
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD72F605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8241a56cd70so713794a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199281; x=1793804081;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AU68gS49k331hhapCrKX/wF5GAv7NgL8pIZV5Bq1EGg=;
 b=MMqfJaDb+TSeL8ZIRKnyOnWhfqN0U6YuBcRnA3ETtGMmFizDfRoKRRwAX0AjOUPOpR
 iYdTWk9n62NyXZ7RgkZfVeB2DlmoFZlSD1S0oLfY6S7arU2kdDYKlMx+4yvn/EFb8iNH
 37HXt01vpD6Jw0WWDXxubqkWVMVKsEPXuQXEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199281; x=1793804081;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AU68gS49k331hhapCrKX/wF5GAv7NgL8pIZV5Bq1EGg=;
 b=ZNfc/8sK365UK7RrgCfPJ05pkDBO1qGsIHiojdr48m1qqU7+sbQgmqkIULx16xq+vK
 tMeE2xJM6d7Ve3ahny8QTio/r4oGZu14xM1eVNUjL6GKhM5/TNbQw/khyh34lLqJdIf6
 oD/57LxiKUPKmDQFWs/p0eGwj2lKKTCtGTCz1MePR5bxn+VNvr0mpKD8P86A9+pFQzZq
 RqbxRWbK0a6YoLbCLuBZ2n6+0XWakNOCTymqO9scDBgh3fEzFGGcSIul605GQM3DJJS6
 o2GuIWQOnLzggvLwBYud/DKn6fkbNn5GdDxRc3pMDPpYdVjp9WZ/4Pb+h53xkSIuVuBc
 y8jg==
X-Gm-Message-State: AFq9FYLQun1CdkFWgNQ5fRSA3WSBKoVUlhrFCFl46U38UVtMx6uTc1JI
 fQEbEuDV5WUB1Xed8BzhnPlOcEc9bAlm9KMfCXQHDL0ufpv6RAjZpLT4rxAWlA2Tz3LFbLg0DbJ
 64jVQzT+y408D
X-Gm-Gg: AYBFou2YWnbfpTMntK7shfiFyPc/ybrEk8v5N+ko6xfsPSyufbY8M85F4A6y6fUd723
 HG6RSNabasDc87WlKoAnB0qlwBU3+8fZeFMIGcuAF4J9RNk4HWDmjby3EYtnraMh4o9bXkgawwo
 ZHZB7zXT2THzjjh2FT47lNp6q5Q1vULnB1vorv0owaX4PQ8H5Maqb50IvbwkQAhr18PkZKkbOe1
 8U2ednwo6qUcvOTHoJ5v+uB/zTl7rgyGmb+uAHUchljkufXvw3ZWTlkDMN+9H2ptVuSstEdj0+W
 J84ntuHdwHwyya5UoXH0xzKZShuTWzsKLBzrUVgavVv08a1gItOtjw2npopopnKwrHDqKnLRf4A
 CTBu6glhaZPZPPAMsIjR03xFPIPcKae8n5m6GTFJ/Ro/w3/FI0+GMnj1mM720W42pj3W4wba5Lf
 DhAyYb25dW5l1/MAvXGlSk9VaQSgtpg5ANRknpmWTk1VQKsmQef6x9Mkio3gTA5TSqy+MMw0Lm0
 hGMNgUqdoEABXyNNL7qpeZpwnK2S/zyMjdytxLx3EOHGKaHNO8fy8rApY/sjyr1aw8hqQxuxavH
 tObXl6dheIhTvoLXjWkdNuqf6AZ8GZ7gtw4mdOUN34lxk+vTdTp2yeOrjdsHpvi4v2DNll/MWUR
 ve90967jRaseuMJpdAAraGR3w8rfUZbVYfdp3+Cnx2jvaWuCmYwIYN/5KorMn3rdZzEPFg5suK1
 UQG/yXGPL5NaxLAgBSrrW3Ecj7SgrYNg==
X-Received: by 2002:a05:6830:349e:b0:843:cf07:7a99 with SMTP id
 46e09a7af769-85ac169d524mr2282987a34.31.1793199281418; 
 Wed, 28 Oct 2026 07:54:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Aksel Lunde Aase <aksel.aase@disruptive-technologies.com>
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20261015-eeprom-zero-init-v1-1-81003ce77c1f@disruptive-technologies.com>
References: <20261015-eeprom-zero-init-v1-1-81003ce77c1f@disruptive-technologies.com>
Subject: Re: [PATCH] cmd: eeprom: Zero-initialize eeprom_dev_spec
Message-Id: <179319928062.2677777.12624497737583117682.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 10:47:05 +0200, Aksel Lunde Aase wrote:

> With CONFIG_I2C_EEPROM enabled, passing both bus and address to the
> eeprom command causes a data abort:
> 
>     eeprom write 0 52 ${loadaddr} 0 1000
> 
> This is due to the eeprom_dev_spec in do_eeprom() being partially
> uninitialized. When given a bus and address, parse_eeprom_dev_spec()
> sets i2c_bus and i2c_addr but never assigns dev->dev.
> eeprom_dev_spec_write() then sees a non-NULL dev->dev and calls
> i2c_eeprom_write() with a garbage udevice pointer. Reads are affected
> the same way.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: eeprom: Zero-initialize eeprom_dev_spec
      commit: d11e0b30ec96a1307e6238f28a1252d715e1e896
-- 
Tom


