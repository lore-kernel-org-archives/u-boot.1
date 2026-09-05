Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524DDC624D3
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00A3B60C23;
	Sat,  5 Sep 2026 00:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKaiKxz-TxUT; Sat,  5 Sep 2026 00:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 355B260BFB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567285;
	b=WhNR5MUfwtvDKRsOS6tBfg7PRIV708IWQU0VuILfvyopI8t4FvV6xFAzyvCJUZyIvgi4
	 W5QX5x4+PBB/O/eg9dR99HFuAtTipkhALwBezaerTE2fKm6xCr4Apst9nqOwIiFj7AdIs
	 amsTEKOoxBxbdTsd9yfk6ru7ymsLiC5e5oYO3od6KC4swN5VWsG2kDA62W1K6fbGdoKG/
	 Scf8QctGpUdlYz/lhpLstFVisEz8a+ld+vS44Ies/hjIVnJ5M8LIUiCC4Y/P1XI7VvkHy
	 7vs5Jmlgn7yZAtuvW/sS0NIqRWQfLf/wpKPxIT/CZoX0F2Oc4l+86qqi08kOH7FM+UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PiKlwGrwF3TlcGEz/TqBxhauSym6bEFSL3B6acTokz8=;
	b=Ojk6F+j8wyARRVMD6tJA8FV+HBOsc/ISBLVimz2SPNpRjFZg5jDhprAaPRB8iAOCm6bB
	 +R59PJi376ZdLBYlTCSzB0Fj9XmGvjVxOiAiEXfC4ijoxMuMNMUdc1UzZoxJYXAF+X8NZ
	 quO7QKkX/oRDSk1NAG24NJbdUNMAb43aVU4nYzEjZUhszUfTL7hJUXSs8srEPGW62byZw
	 NO7f26WWDb8Gda57EF8I1MCuKrBQODu/oZPyNxKq4Z+u9nCZRFPUUpzaPWvpiBR9SOwOr
	 n0BcMWLSR8pzwNl0BMlPVs9YZ7/Md5DOR06+cxd3spGeCYzMEw9VS9g6OfXELrEKB7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RgmRhRFp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567285;
	bh=PiKlwGrwF3TlcGEz/TqBxhauSym6bEFSL3B6acTokz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9r7YCl9jShtl3Mov5Ld15E/MeL2ca3VC+iPxor4kVc439CzqrI8Jx5wufvSra35m
	 qqfHM2yHA65jB2GRguVeK79ZTOxJ2AmI+y9GVjhspCyZAMyya91Bfo4n4NMJ3RWZVZ
	 zSJHm3vL1rxqBlKZw9kOkpPNmSjhygjI/FNqkKYVbtmu3NKXfjySIVowbfKgDwXx8j
	 7efg8CDV+zGR+wg/bz+Wb44csj9WpccUqdfhpMULZiMtNnPc1KFXK2rpXx7S2fk5gB
	 bZmZ6RFhchG37r9FPI002ESFTaGZtlJNZt7R5TIQzena2d9GU25JQR5lz7Szfdtsb8
	 VCE4g9gYaMAow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 355B260BFB;
	Sat,  5 Sep 2026 00:14:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 534B329B
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3563460BEA
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYiiNvZnFjFG for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7863D60BED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567280;
 b=tI5p8IPtOW1JdTTlPjRlxxexJ6AVWlkVig2vV6FaZuAIM7LPHtrfR+LM8VrFtBeQE4xO
 4cD2kg2PQopuBCwRv634PsmOSGGFxXnEAhamtB1b2RJ5zOKgTp75vBCW6dkz5Fmh1I4e6
 b8enOgmwqe7PzrxUHGTeYiNTOHg5boOXaZYlXG1Mz29RlrgQ2h8NkfzlRylI25ZVyCfzZ
 zfUUbeF/uFoZG8GKi3vyuiXqhyGXs4wFmVhhYPIHmeU2O0BVFTYNcFT1mAln4f8gHdaui
 BQmmFF1JWCsGSjs53wjZgxn1k6A6ua9JFO7wBed5Ut/bZ+6j9M4vKpPBzxJjqGrMl0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=PiKlwGrwF3TlcGEz/TqBxhauSym6bEFSL3B6acTokz8=;
 b=ddSmNQQVPKIp0HTDOSZA4yvBSYLtOBvQ8k+Hn06jBFvi0LH5+FcOkdIZiL3ZSkjTRq3M
 lCMCZ9hU8FOokroUr3UXQxKa7hSOLb9koxWNJ8Floa3zTauJPCyrqHnpCvrS6rYl0/6hU
 t4YVMaPL1zGgBjElGZolzdmjT5zM7ahkwNB3YjqWSpC0cpD0SJrubtUxktx4En13n/r24
 2/YeoMudTNS3mC30t+pozc6ki7ysjNh3b9m00g1R3FeLUTL+Ezhz0LdU90tSrwaWVB8O1
 QY6ezQr+4FYGtcYUu80yzg+yUYl/kieawwmgYYYoxGMGTS84El6yJdfV79g+UZTP7Ag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RgmRhRFp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RgmRhRFp
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7863D60BED
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:40 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4b383347fa6so2091631b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567279; x=1789172079;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PiKlwGrwF3TlcGEz/TqBxhauSym6bEFSL3B6acTokz8=;
 b=RgmRhRFphHTjCw/HhtShdMx9eSiKa2DBe9pOVJkA5t8Boh9BuukgVWswvdhvjkJ9om
 EWRRUr5X2WsMlHTKlU/edNQyA2/iq7BfFLMmBZ+CdY88xmy18S8R8RxskeSrWFlSInZR
 6t3ZlJBDeutfQ2kITL/giVqAumr3butpctI5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567279; x=1789172079;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PiKlwGrwF3TlcGEz/TqBxhauSym6bEFSL3B6acTokz8=;
 b=ICQ01dhrP8G8niGKAT13Te7SAD1gOiVD2b9D06sjuRpM0KwqeK8BCiwIAIi8Ylui3C
 3StUt9JGQUxPHYjkplS6uN7V1cllj6DVs/bWpxVaOy7SD3/jyBbMxW0H0hiBj+vk+79H
 586SE48cY7tuUhMJMYe9IUlCpm93yj/VFnmbkH2gHseT0O2gNKpLaqD/StRfM0EExr/z
 K8/k5lXAMauHVTzcxCaiEt95qQUZpI30DyBJC1HhKQignUWzBEDTKQX/OYQOI9CbyfjV
 Y0t/viOCeVuQgu94+fP8VJlw3rav7Uo+0bL5Q9os1E7w1UrkVFL8QGXsjNTbxJEfal9g
 L4Xg==
X-Gm-Message-State: AFuF++ne4ZfctY0nHbZJq9hQFsWLEngKdkWqebSwR+nT4UnoF6AkQZSW
 EEJtSIzJ4V5V3eGmpkj8kLDMi7fzWqnZCatCeRRGnVJAkUuWD7fj7f5qL0dK545mixM=
X-Gm-Gg: AYBFou1GUH6IpgKsbZmx8umh9a7d0L9wITyFiFDu14rCnftg6GQb7GGxKrbkGpwuH2x
 NXXchmH98idkR0YfIeNV68MUX2KGW2QHcUOcMo/Ve3sgkjFamJNPEJJyI5OGFK3Qxxxou9oHpzi
 JAQgFKrcKo3LLSJC1MErwKSCyTZ3uN3UAhkzd99VCudP6FsGiUgC++//8c0R6xlAboPfJRGpZJ5
 xAYAHkc3NptaS9FHdjCsM7nJZN7lB7NPRdHVyQmSP2nfxu3vldKajpn7gL+sGI2GtkOpO7sx8yQ
 gOkglSl8qs+L6kAv82zUG6sBOQndSNXgwFkSL27Zd7SYlEmXZ3AeNcxk3HhC4SKpW3QRjypHYMO
 IQILykrSyzLK2a4lypnRrZsgUa4gZ1t6e8SelLA9lSLuxTS5qR2leZKFI0Qk9Y9A70RMUWZLWxU
 aa7M1ukPe128YHLXhfKwg8wrhoc8Hr1pq63AoYlR194R+egmQDrKiNpSAsCq8jKyzGbssrK6B+o
 5sZr6vuR3X5/hfudEj22vq8EEjmG+zbdCjkRYbG66VdzRnhhFcRj17AGEU9/TVO3HcoaVTRHwtx
 ShidMmAY
X-Received: by 2002:a05:6808:1c0b:b0:4b3:3e1:499b with SMTP id
 5614622812f47-4b979e6c1c6mr3330130b6e.6.1788567279049; 
 Fri, 04 Sep 2026 17:14:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Anton Ivanov <anton@binarly.io>
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
Subject: Re: [PATCH v4 0/4] fit: Harden handling of external-data
 properties
Message-Id: <178856727762.3086907.9867316166863218879.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, 02 Sep 2026 22:23:22 +0100, Anton Ivanov wrote:

> The data-offset, data-position and data-size FIT properties are 32-bit
> unsigned values, but were read through signed int. Also, they are
> excluded from the configuration signature, so they are attacker
> controlled.
> 
> Patch 1 switches the accessors and their callers to u32, removing
> the ad-hoc handling of "negative" values in U-Boot proper. This
> transition was discussed and agreed on in [1].
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] image-fit: Use unsigned types for external data properties
      commit: c4d81d062790c76ef0db4ead2ac69cab7245c2fc
[2/4] test: spl: Factor out external-data FIT property checks
      commit: 506ef1fd79c49d9c8326c9e73e89d35771cb650f
[3/4] spl: fit: Harden external-data offset and size arithmetic
      commit: 01460dfbda162ca9a2fddbba001edacabc38dd2f
[4/4] spl: fit: Bound external data like U-Boot proper
      commit: 3158b844335a4a84a5504a813f2daa6acff5985d
-- 
Tom


