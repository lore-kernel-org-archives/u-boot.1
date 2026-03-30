Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CDFF4923
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 00:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918DD8394E;
	Mon, 30 Mar 2026 02:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V8hKQGFW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fhNB/Pgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D155783B48; Mon, 30 Mar 2026 02:25:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE4E98063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 02:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fkX904zt2z9tY1;
 Mon, 30 Mar 2026 02:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774830356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhA7Z+ufbhmn+S9S0uAxdt6CgU7VargQik0i0VHSinY=;
 b=V8hKQGFWkLhdjT94pk+UAGTwOtMhh3kIc6e2286pM57xvWk62mJ1oNrX9NgmWkaBxyRVVc
 y2/4DvXB1r6BQuH/QZE3SDeZMgrT35R1ZkdnvM4fdNQ5WXQKLq/m2yP90/uC6qkxuaUMtb
 dbdkGLQVevR1p4E9evnmLEG/RoSxGJTM+Hv5et5Fw7AsdMZRaqmqgjTdqWrWquWgMFjE2H
 BKbmlUTy+ZiTuyAtVTyiCw1dEGGFvjkbMI3t+cgzHm/bYc4SNh4EegfuuGZ+woORin/U6o
 SlwFYHNjbtwUctufiM0nAXkYzWTFfxyLeaGj4dVs5HNQi9vGRDpneRhhS/Bq3Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="fhNB/Pgi";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bd745b7c-edda-40cd-9512-3e0113459ac2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774830355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhA7Z+ufbhmn+S9S0uAxdt6CgU7VargQik0i0VHSinY=;
 b=fhNB/PgiKTRYTBAgon7Zy/UJad8DiGPfVS/Y7qBButYLjlzDSKHos3YYkpk4tWX5j2wOct
 E6hztk1iTeDk/i7RsdY9SkpJjfB06QNYG2+uHK6mSpuEdchl6Qag/Z6Ix9wW87xpPzY29M
 NpAqbU8hWQIve9ynPDTsUqun6VTsXCE04vduf0yoGOsGdC+2byPkLiPMN3dI/XSYd39a0/
 JCaAAostK04N/yWO9NhQmie21matozauvracTB2xU+aZiF/arGttDpiurzmUHNU4tIFJfn
 BRbO3FV5NepOWjI3zdYiRWJUBgkn/SYWNeh5/jTAtwzhGgUs6UqK7NC2DZRWcg==
Date: Mon, 30 Mar 2026 02:25:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: Add ARMv8-M aarch32 support
To: "Kumar, Udit" <u-kumar1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>, "Francis, Neha" <n-francis@ti.com>
References: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
 <60358e0a-225d-4747-95c8-d060f27eb8b8@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <60358e0a-225d-4747-95c8-d060f27eb8b8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fj4z63a18m41trbc1u1fjnez66wp4f54
X-MBO-RS-ID: 676d93810656b5dacf0
X-Rspamd-Queue-Id: 4fkX904zt2z9tY1
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

On 3/29/26 7:49 AM, Kumar, Udit wrote:

[...]

>> +config CPU_V8M
>> +	bool
>> +	select CPU_V78M
>> +	select SYS_CACHE_SHIFT_6
> 
> referring to M55 TRM [0], (which seems to be next processor in this
> family)  page- (68-69) CCSIDR,
> LTM cache size is not default to 64.
> my suggestion will be to keep cache line same as of V7M, unless you
> think otherwise.

You're right, I did switch the shift to 5 for both V7M and V8M in v2.

>> +++ b/arch/arm/cpu/armv7m/Makefile
>> @@ -4,6 +4,7 @@
>>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>>   
>>   extra-y := start.o
>> -obj-y += cpu.o cache.o
>> +obj-y += cache.o
>> +obj-$(CONFIG_CPU_V7M) += cpu.o
> 
> Why you are dropping cpu.c compilation
Mainly because its content was not useful, but I isolated the content a 
bit better in V2. The only thing which is not applicable to V8M is the 
AIRCR reset, which is no longer present on CM33. The rest can be gated 
by other Kconfig symbols.
