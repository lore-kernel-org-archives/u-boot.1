Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99840606A338
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KWqpslxk;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GnK+smfq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188C160D5F;
	Fri, 27 Nov 2026 16:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjVx2OcK-Rgq; Fri, 27 Nov 2026 16:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C63860755
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795797228;
	b=iXFdx+BFpygpzw+UOnlP4z1dVXUVOEvSNVUDuylIqDDbpVaZR2PzDeSs+9E/LF972zoD
	 +L1bsOjbGysfP/DE6Sw2s7eLEyz4pTl7z55XsIxob9D5U1p05gG0LvvNfF1SxZNuSp7Ka
	 DN8N/8OxwRfRWAzGG+bnQAmtCKb9sutvj2dCX3hxBgB83E5mJA4luc8kyVTzTtyKrTVDL
	 O1Q+t+AaChzUtx5eIATH6sx5FeyDEpw1Venqn+nXMsBWSptRYpD6EMfbXWLv/Z01EHaVy
	 R6AaOqT9RfdsVovarBBlTDGL0Dxgtn5SeIp0YEsAIRfa3wYiKSM/PZwAF2h9YzfIxZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795797228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QJSOIUN+GXXT/BU5BXOD/wTL5NBN1wRIB9nd8c5WiBg=;
	b=VlUAXN39VoqZCoRxyzTHLx+0GCNDgLOvPNabJfqq5ZGNVRJJRtou4q6ImRHfLrRT9I2K
	 I5ioFRry4SX46SVzTzpA2RPjnfxj9EY7uNjnB1L5AXVZMXhHY6IQ1fUBw5Gf192tjTQdx
	 UwZ5HZ22Esp+y3Y6uDXkLdjgHDx3FdVpQRkQYnka64iAvgknLzjsm7Cn0lGn8Ufo5uThY
	 hJQiXBmuixrmBoUJA80kPCQmIdT/NXJ4H7ydzAu3HE9aoCUXuslRzEHuErbQdxr7j36rv
	 PDRq1asgXDcQKcGHNQ/IkNjKuZh3E6Sj6i9DP+2UUPieZ1gSUfwnFL/km3H72tgO5cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GnK+smfq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795797228;
	bh=QJSOIUN+GXXT/BU5BXOD/wTL5NBN1wRIB9nd8c5WiBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KWqpslxkz2p7k6tIUb5dNITFgaaz1ug651R8sZ7lzBCfyYsPJkROcdvqLiRK5mPnB
	 HDyQzbpjL/FyLT8dqF8QCDi57x+rNOoji8OskVBjOJ/klRRwJS86RFXCU1TwQ5gfqM
	 8fdAglW2UVW+auJq2A5zDNIdEOSi7Dh+9PPC7VKaD5uInZdiFKZPRpgapRZh2Gczwr
	 p8SDEoQ3XPwsUYJn93n6k9qib2/JMwpvrRTuNYSTJZBTyizrt6nFpdkmpq39ozUQoQ
	 jRbPOHXKaWaY0n0JaIQvMZnl3renLFuRT9W7+DVRSzK6uxr2Fp6sn6b9fNIkY+ngKU
	 ciGwrAFe0HNKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C63860755;
	Fri, 27 Nov 2026 16:33:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F30C8311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8DD560755
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hOtGSYHLX103 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 803B660621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GnK+smfq
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 803B660621
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:33:44 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b28d7c729fso6281072b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795797223; x=1796402023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QJSOIUN+GXXT/BU5BXOD/wTL5NBN1wRIB9nd8c5WiBg=;
 b=GnK+smfql+lUwSjiujaTYDaFFLp41QXEWcvBpUPDkdAEUyceuVhN7GL8Z1IlfJ4A6E
 DouhF6s3bHxd2ezyGVrG1G/luVnDQZs0LmTGZmgroOHOsYe7XQwU+5BVf/6Xfb/q9Yp1
 0Kwvp2/JGDmzOPhZdv2yJk7DsZQhUwSxHh7/m+oVPiUu2vhhTVi+3YFWjh3lpOrDtsSv
 1PF+eWXwCle8E0cjhSShaGGL+CsFgKXRUZVHDY0vla4i8y69QpaW2WSpoV6T2dr8+qwc
 HbVv2KG4HfXG6siOLrEsN8/Ath3T4TwVtVq4m3UUK8s0YVGQG+fPaKAYuWmf+6V2ABq5
 P+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795797223; x=1796402023;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJSOIUN+GXXT/BU5BXOD/wTL5NBN1wRIB9nd8c5WiBg=;
 b=QjF8cae49s7nGzE9muvRMcJFprRy3MsGpN7dTB6Q/MJYgJH6xk+qFbgItlJOdeDf8V
 8YQdZYgf3KV3e6b+NZOuN4fqG80sL9y0SQYtuFn+6u8B0F4D0EEXKOdQwTYhJBh+Uk1s
 YQy/aj0RXskO3FrNXTzs1ClK9LSyvxMte7cFJbpXkYGMXWngf5knqLC4ZBF0FsKD4nW6
 PXLfSpNPYEU5+430vrt57A2R/I6aV86AFRUO3679pNAMCTuKqokhHlkHxG8f39QZO1/Y
 Dst1vlcr2XJnrbHe4iw9W1NSTjUjAFLdorMQsjX0pzNlrSvxkVuFUtL/LUoBpJSJJbS4
 1E8w==
X-Forwarded-Encrypted: i=1;
 AL+hErFq9ssFjMw2AuCnj2bL0Zn29HeDuzdj5QArF6eJuB6paiaETzliWvYXAtMteB0xWWGfMoexeL8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5bdkmB+9AsPtXF5KAd5EbNXPxPKcdNUR3oMdfOtuNrSBYRHXQ
 AUZb9zGB6y6UEOjTNpDDkBv9X3FAGWuuhTxvcJVKDhyMIKLSWcuHH1YmJ736cHzuxHMS3A7Drqb
 PcEbt
X-Gm-Gg: AZFdTZedgd7wrFBgKgCc96IoAcI8RMj3leVRb11MPclUZjOCrF+0F83xB6QdXMALdr1
 7HeMHlT0ImyFp8j4ud5RK+8AXok9AxjumK/I7VO3enybZLvKwOmC3OipMv+iDFR8NspmQtm9YpX
 U8k0xC2lsmG4z/plitLfCt+c7Qtx2qRVH0cwa73JXbnu8tT0YygM4pO+Di5/qCaYDD6sS8xrzhf
 QZb1Tjp+nJ0Of5Nt1VAL/ioLvp/WMMpdZginSEAS52TXTWu80VTLOx9hwTRtTISFWmfHZwbziHE
 GC//l2eNkd+Yf3roQPgND2VjEWRuXoSFrPs5P6U1h1DreBT4rpfsHjnG2yicrGZC6pmLHBzGCi8
 4DBCk9/u5MoDTrN5ZnLUrDHcNrCkJvZgF6gQsU0TWgd7e3HU2GFrCoPGLWNYM0Bpj1XKHPnap9+
 JeG2uHhg9ONAfrMlOEvKCEpACdwP3GZxVzWeVJRDs/p3W2rJtqN2WPre8GJs+onyqhxogHW7jV5
 H8iKYQ4Z97wVtn69zqM70TcvT8/Vw46aO/otto5lWInaVtmO4oiFubRSlQi3KqeEwmrLcJdDajE
 wWZPtRiSgRS/uL0t5IXZrbQVXtBgdaYYTe8rVXeYqqhvRDU/3aCPjfpObs5bjEOKtPZHkTPCTlq
 WlYo=
X-Received: by 2002:a05:6808:1488:b0:578:f283:2471 with SMTP id
 5614622812f47-57a09e0ab1bmr26267676b6e.46.1795797223228; 
 Fri, 27 Nov 2026 08:33:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3f9c:a2ed:829d:5419?
 ([2600:8803:e7e4:500:3f9c:a2ed:829d:5419])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35c5ac5dsm19118251b6e.15.2026.11.27.08.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 08:33:41 -0800 (PST)
Message-ID: <847b94eb-3a19-49b3-aaac-f072212a3feb@baylibre.com>
Date: Fri, 27 Nov 2026 10:33:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: sparse: fix raw chunk bounce buffer size with large
 blocks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Carlo Caione <ccaione@baylibre.com>
References: <20261117-sparse-bounce-buffer-size-v1-1-bb0c4f7eb99f@baylibre.com>
 <179569064498.2141121.9269220371335043325.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <179569064498.2141121.9269220371335043325.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 4:57 AM, Mattijs Korpershoek wrote:
> Hi David,
> 
> Thank you for the patch.
> 
>> Limit the bounce buffer for raw chunks to 8 MiB instead of
>> FASTBOOT_MAX_BLK_WRITE blocks. That is the same with 512-byte blocks,
>> but 64 MiB with the 4 KiB blocks of UFS, which is too much to allocate
>> with a small heap.
> 
> Have you tried to increase CONFIG_SYS_MALLOC_LEN ? Or is that not
> possible because the system that you are testing does not have that much
> ram?

No, I didn't try that yet. It should be possible. I will follow up next week.

> 
>>
>> Fixes: b1aade87ca1f ("lib: sparse: allocate FASTBOOT_MAX_BLK_WRITE instead of small number")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> b1aade87ca1f purposely did this change to improve flashing performance.
> I'm a bit reluctant to pick this up without this being tested (see if it
> causes flash time regressions or not).
> 
> Did you benchmark anything with this change?
> Or can you justify that this should not impact the performance on eMMC?

I just did the math rather than benchmark it. Assuming eMMC has 512 byte
pages, SZ_8M / info->blksz = 8MiB / 512 = 16KiB = FASTBOOT_MAX_BLK_WRITE,
so nothing changes there.

> 
> Thanks,
> Mattijs
> 

