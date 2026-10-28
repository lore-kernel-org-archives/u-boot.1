Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GPrTNRGW;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YmG2RKTN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90135407A3;
	Wed, 28 Oct 2026 14:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lOS2fUT0Jd9; Wed, 28 Oct 2026 14:55:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D96EC40742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199303;
	b=lVzAw87ES4VEvVD4HiFVjnrVlk+P5lahCOaBrmbdpN17RD0ZLdF9tKspGeipnOKge19Y
	 VjPIa6msV325Z/TjNbr09JrxUjSOPZ/IsEvIFlAtdwq5y/PyLxvmFGl2jo1SLCYe9Gb+q
	 XgiMGdlLDCP7gfVoOcfr+SFuTX/E0sduWRm7fyS2qDcuYNxl2/K7LAeO0ektlh+Thg3y5
	 f6U7nQZ9JXf9wF9SZn81F6uTRz3BBVsedZ/8d9dG0j6634YZ+e4M+GcV8HHq9LZSnCRyk
	 NWILmzKEB2fz2ipNnDyvekXS6En8oBDDAtTN/YO25W9sAz3yWgchyoXrCaOEqW6iATA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199303;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FCvE1u0yn50TBLQtpPykVCx5TIi/DcZfo+fiP2TzOGc=;
	b=IsQQn0SwRrrBGgl/k54FvhyHoBWSxxIfbexU1HPMew2wMaSbH1GdDHMu+YQ0FeTG7aN2
	 HMetQ6spxRxkEVV4Q933BWSCYRNxK6KMzS+5SjuLe/tv94ikmJCN9Oov34WtKu1t5XJN5
	 cqpWeksdmrg0M7pYC9DNf0OJRanGlQyhrVCzKr/FnpgidrGX9nWnbUFPnKPlP2qM1Hw+D
	 7XviCppDUFfTV9OghHR7DZo2zh34U8LK910QQmhpSzyIboQ7bti2rzb06LP9NqOgmTbfi
	 WjaI+kEjbQmHJRxGVtipDemUT0ZNUwOnQTJc67YEVjiHBfeuhlG49pj8mP/cI+XTRUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YmG2RKTN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199303;
	bh=FCvE1u0yn50TBLQtpPykVCx5TIi/DcZfo+fiP2TzOGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPrTNRGW0Yw3qmMjgXeeqS8/OjwSB8m+i3J9nhd1frkdIojHTEowAS4zXIaLBSz3b
	 GFIoymULkWw0IPd3+fIxCFbM8bLv8EIHORiMU+YANOt8cvYPdffEbi2UPqRifCh0XP
	 cYD7Ud83MxWB1mQq/LnELlezN80CDdUOtXG8QiiBlWRjQNyYXbLxEywuppbOUE6WBo
	 n9qwOy9wVcKNiEtoMhdN0a/kxwTFKMbSug+/VNRjTC2Y3OKDq0huD4o/ptixLCBtQW
	 76OIJlyCUr5HDzIollqkAcXsS7/NKYnmAth4m6kSFFI51qTcXn7OTflF7cYhY4j3o/
	 s3DQ162Oy1stA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D96EC40742;
	Wed, 28 Oct 2026 14:55:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB44A235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8968E40743
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4u1mDUtZjiQW for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D48924070F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199282;
 b=ZvNF4yNHCvq7yDj4xef1wtExZYekIu49Twu675jSjwvh06ETK7RHJeEn+4+eLQY7adgV
 k6VKa4xS5YnGqu83O6VjrPy5t7oMOMz5tqKEl4MCp0CPVAAT2cyIcvx05BPcj8bmQ+0j/
 Sba3ViRX/8DEQQFDKrBlhpgb+R58K2P3dCCMcfeYeP0P+sfcstcjsLGDuvqglDU5BCohD
 VZvfd88+kXuy5iuGlzVG6mbIPx0kwPK8L6U1poCrPZm9vaL/YbXgcx1S5mo00d5+73d3h
 E0AweKlQ3psr60kXPEldY0NpRzgmCZ50OOrbUJ8kEmW03bHFhZiCdWfUkyVh5OJYm8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199282;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=FCvE1u0yn50TBLQtpPykVCx5TIi/DcZfo+fiP2TzOGc=;
 b=UzsgLY9Tb3qK1Md11P5LOkXmU9DymqTeFxWvn9mMu5av/BNE+SD6EPxrelVhwmVhUIH5
 SDzWLvV8QhBXQRhoZ2Ve73VEVjMTuSv/635J+8Y5deotTC3PNoCcynTP4nBbAVx0uGTGE
 Ou0LROhJXcO13NeGUYJgh/lLaxnW6S/gbn9qHB2qR+tEx9QZ4OtYqzUAKhM+qB7dr+hUM
 eWD82AHOVyZtKrhtIn4POSPQKLzx4DB9kgoJsbxwFMRqKxNxLNidvvoUsEdLbaJD3Cniz
 QhJCuBCrdQLl1t0e1S6RN3LWhTrraZvMWs1k7MDXLjb+1iZlDhoQGIkwDkBws5G/frg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YmG2RKTN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=YmG2RKTN
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D48924070F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-84a248254f4so692870a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199280; x=1793804080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FCvE1u0yn50TBLQtpPykVCx5TIi/DcZfo+fiP2TzOGc=;
 b=YmG2RKTNb7OwiohYKiQE7VHGCMABF/hvChHdaPCEGNGkumxbfCYjHECGm0iS2208uL
 MJWjYoSJPMWjiaKw3Gtg4RoZI42ADAYnPbd8FWtqt4clw2klguagEGQa+LBcUI2ZFRr+
 rQKQcaYZZnAyArg0fFpDXavUx7jozUZKula/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199280; x=1793804080;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FCvE1u0yn50TBLQtpPykVCx5TIi/DcZfo+fiP2TzOGc=;
 b=W/r10ieMNZufzzOm06braw3sQ+15g6RPtTc53CN5qeAO/BSrI/A79MaDysa8nwj8vs
 o5p7bFeKY9qKAPwrxVVWllQUgirBcE9+2uJ2XjPL2JJS2rb0hn89Vrs44lXtIXEFPjOw
 rcJ3c55VK5Fd/kBQAR1goHyqCGgbXIuUSsMnipKCkU9w2uL+QnlMLIIQlr2MjJ096tPx
 RdRfsJnC7AJvQeUJZu0718H6fNY5vf2wa/9hsdNuGf2tiNoj1c6w0iI9QXXuPdw3PnT8
 oQNsdFCAshhz4NAtA6LiC5/i3Dd3zj5vxo0KDNTYyEgerR6BRVAjTxz5fpvMgZwP/+Xg
 7aZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhhRef5K2UGtHuCXNpArlspxwfJmBJ3qe1JVgcpWCfo016J/sMFIZD0vSI6w8I6yCGlt3CACw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ8/o7ph/rP1vkyyN7xKMbR6k80qsEDP5OTtHBJXRV+jlv2BBZW
 bMEUdNeJ6mbTIFbyERZVnXiH8P/N9JY7DKVUUJDHZyipJzTU6Fiwcp+JA5NMcj465hk43V9PA7C
 NuKJ5DAYswIBO
X-Gm-Gg: AYBFou35NctC3hvbz7bpUC/apZBGQh06gMavDToi5QeaDnCUZ/OcViAg837L952BPd4
 yCAr2s1WNwRNy2iYRE+uJJq6gAE9UQHizHYyhM5FrWoet/Auy8Xp8Nve29RNjcIqWgM704CBx7e
 QkckbohLj5HIeMtuZar0EgaP7fYhdFqqk+KgwNMNFcDSknbXyx+m4nUZrc/P5O6A0Q2ZxSIWrGn
 pcMNmmsqPEzMlc3UOVfxsFUBK5xolxxSNXm7EtARmnjgli/CXcwCOHElcOhXCICD5t2wT8pvl0H
 an4bdwuFqUY+Z/hHjrYwu39jWduN81GLFRktct7q8PWkRxoO3chD1F0N55OXKxbVrA1lypnBxm0
 ywq2HjH4c0aEaoJlOlyyEIrdpQ+3wa4uTvLurGy7ziXog82qAwOuYrHqmsSHv+JJTMaARWX/Co9
 k/ZFpJjx3dumZs+meTQI3nYLI1mbQiUXC6K0iP545QoXAcKD6wK7Y0+oKMplFKvmNeE0F6PvNO6
 QI+tBzmjwq6Ac3V8vpTIvrql6guIHhqMPz7HTmWa5e3kITL9JrkPDp2yPoNAghaXAMhR1IHHnMY
 LOTaLYJoKsNuBDpmRr7Ol2m0KYKxR3N1mibMDOit2rv19p1XBcgoE1Gx99MVdvLky/WkoMwgyIk
 RqA0r2jcjf84pggT4K0hbjRDG18OBBn9Ha69GgIVbxNBFDfLdtrESKXWGIx7Hly42DoSLjhEgCr
 BZ5rT1ZS22JByKoHu47atQIbUPsd/x/g==
X-Received: by 2002:a05:6830:7196:b0:80c:d34f:5f61 with SMTP id
 46e09a7af769-85abdb035famr2352488a34.26.1793199280486; 
 Wed, 28 Oct 2026 07:54:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261015030815.17896-1-semen.protsenko@linaro.org>
References: <20261015030815.17896-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] sysreset: syscon: Get regmap from parent node
Message-Id: <179319927987.2677777.17315688487972138008.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:39 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 22:08:15 -0500, Sam Protsenko wrote:

> Follow Linux kernel example (see [1,2,3,4]) and deprecate 'regmap' field
> in "syscon-reboot" and "syscon-poweroff" drivers. Instead take regmap
> from the parent's node, which normally should be a syscon node.
> 
> The fact that 'regmap' field is deprecated is already documented in the
> corresponding upstream bindings here:
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] sysreset: syscon: Get regmap from parent node
      commit: ea87a239da37a5aca11b70b52ae60e1aed0214fd
-- 
Tom


