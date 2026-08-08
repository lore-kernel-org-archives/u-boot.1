Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D851AC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 18:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 794A680E6A;
	Sat,  8 Aug 2026 18:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMjwFiaGdTZr; Sat,  8 Aug 2026 18:47:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5174F80E62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786214870;
	bh=VC4m6xxfcVqQy65ePWUOgg87DBwJKDcAUu49pFd0/eA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T6FpUY1LwcEgDYYL7HMtWMwgfDoFyL+C9O+UV0cYXkSDF0kSL2GzzVb07sPkeXNN6
	 vDdJbVwrK/L5eDP36Z/W/kzV46aQxMctEfEUaP4LxWG1769opoLyt4SLlUN+syyXHd
	 mIEnGKjzLiIwJMRmM2YmDxy3POzY/JNeg8Bjf2xANVdbILWUACoNFlosv08d/r4CaL
	 kR9qzex7wP5J3j2T3R855XOhzUtcsYjG/HO99uRGRs5zULZj0MGjo+t7AN1lAFx6xO
	 38/96iLJK1qBbK3g5vXo+g4MU5TDZdJfSmPPIQBaq3sDKByjKh+aakUyY2K/9rNlxt
	 59XGQc/BK5naQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5174F80E62;
	Sat,  8 Aug 2026 18:47:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E935710E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF6F86066E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 330edgqzDnet for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 18:47:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 77F0F6064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77F0F6064E
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77F0F6064E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:47:46 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso321222eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 11:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786214866; x=1786819666;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VC4m6xxfcVqQy65ePWUOgg87DBwJKDcAUu49pFd0/eA=;
 b=sqdk5o4T4Sv/Y8ZuwNpWNQhOzpeulUO+8rT9Z9gJLhkazS+Yg/CQvJC46o0jlmC6FD
 Fk/M9MOYIeY7YAE4b4jIWqzHrxO/thjscCyrkmgrHFhWUEbjJz13sllZSs3nC/HVNlk/
 ryn5UZsFKaJj9N5SKbmxDivqYTanceprsQKzUMu2mZKAS4Wi/Ie3WuhdubWAom363mng
 VN3IQC/tAa6IIafieptTkgg0UqVc+zllpJWdrFkQID7HCXmki1kbfoSF99bZ+l1cRtk7
 yZpiYzNI3wbwZZiXmMPGXPha8XIgOA+7LjaPEekMQ5zIZLeBb6RAU8BfpkyHCURIr1sZ
 ApVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZitvzGcOY0s5uusl5QRLX/SV5rPWcJhKy22ZEDgO/t0/hwXXs+/CxdJvoSyykjyW/XsVh6go=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxGqdnxw7hrLWYhuBm2eFW8iY4XhTWVgHgY6u2/kUHnjxKf3eQB
 ScjUNSSaE5KK0RcizRkIM6vcohAgVlhlrRxOWoDviojm5dSKF/SJoATq7b1JcDm7CYrmgKreetT
 G4CdpUeM=
X-Gm-Gg: AR+sD10hmv1FCkPYw9UEjrN5kzTTBYgZXzGV837ZW+vOcN4n9PAr4AvGEjZhdR0IB1e
 9VXrsD+ptBQrMiurOs1qGadUsiTLw8INMYky9b9HNpoLlB/xcqaq5WqSzjfQ/gyiJQEJiNLGiOk
 94vZy+d7wFCrt8/Jf3mYcGo5Ysn64nh68m7rTLj9E7zrY6OhbTWwVt7H63SWEvevH9lP2tlBMIw
 dIrTJsq0rnX6M5FqM7LmeoYSchLU08Xi4W5bw3Br2/Nq388sGrtPtMJ02vpzHM9XSUpuyuQS40V
 g3kHtxH65lzQFGqkn+nfY7I0uDkmJqPN3rLNTx2EYA44LDTIBA04d6lvc3fzTxur1Dgot7A1o5E
 ksUHMh/n4F2p4uNgHuNBXfAXmaTpM0RjzvYjm3wtuioxc2o55RZl41J6B/ZPzQNQMv8121x9jSI
 VUbFfBiE/Owloja4cfYDhtbmED+BNdyEJSBYExb6oEQUOC8hkk0wjkPAk8vNOcRT6WsTP9eUQ/G
 6KsLNAuFyP0fB6/yoSOwFpASaBlsOSD0OliP6s=
X-Received: by 2002:a05:6820:a0b:b0:6ae:8b66:8726 with SMTP id
 006d021491bc7-6b0420b71d4mr4954571eaf.18.1786214865703; 
 Sat, 08 Aug 2026 11:47:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5?
 ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be475f7sm4937248eaf.9.2026.08.08.11.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2026 11:47:45 -0700 (PDT)
Message-ID: <41bfaba7-6b7a-4c07-b14f-49421723e0a0@baylibre.com>
Date: Sat, 8 Aug 2026 13:47:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: fix dtbs_check target
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
 <CAFLszTi0XiuovK3UW4Vq1XKB63ULKcP3DW5w-yYOkSrABpksCg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFLszTi0XiuovK3UW4Vq1XKB63ULKcP3DW5w-yYOkSrABpksCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786214866; x=1786819666;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VC4m6xxfcVqQy65ePWUOgg87DBwJKDcAUu49pFd0/eA=;
 b=JMZCUuN8zZFwEsulw75tccm/1TJedqDoliFfNQYNyfZJ3tPn4ebcSAONd5jROV6/vH
 GDjWD/Uo967ZwZu8oE3iM+RXJDaAPiJ5u7NhD7LzwtlfVQ9ZaEU7JHkdX4Ol2ETZTd0x
 QQWPEdwVKvPFaYWagww/yy9jF1sntS8T/199X4fyI2ni+50nm4pMxWe564aZe8U/d7ms
 oIS+fkl7sTIRe1onjoA5ezDUZ84jby+XGCQ6VwgPo7wPtp1GkwKI7A6ovD0Sepl3hOJO
 uouZa4LPXRWTyENmZT/7aqQ1unSRWfT658wt8/rvF3ZWeyBUjNNe7H9tqZZp1J/jsjiy
 y2Mw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JMZCUuN8
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/8/26 11:23 AM, Simon Glass wrote:
> Hi David,
> 
> On 2026-08-06T16:53:15, David Lechner <dlechner@baylibre.com> wrote:
>> Makefile: fix dtbs_check target
>>
>> Use absolute paths for src and srctree when calling dtbs_check via
>> sub-make command. This fixes dtbs checks not working.
>>
>> Without this change, we see errors like:
> 
>>
>>     find: ‘dts/upstream/Bindings’: No such file or directory
> 
> Just to check, this only happens with out-of-tree builds (O=), right?

I always use O=, so I didn't think to check in-tree build.

> In-tree the sub-make runs in the source directory, so the relative
> path resolves. Please can you mention in the commit message that this
> affects out-of-tree builds, so people know when it occurs and how to
> reproduce it?

Sure.

> 
>>
>>     find: ‘dts/upstream/Bindings’: No such file or directory
>>
>> This resulted in no schemas to be parsed and therefore no useful checks
>> were done.
>>
>> Since we do not want to modify dts/upstream/Makefile, as it would be
>> written over when we pull upstream changes, we make the changes in the
>> U-Boot Makefile.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> Makefile | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
>> diff --git a/Makefile b/Makefile
>> @@ -1455,7 +1455,9 @@ dtbs_check: dt_binding_check dtbs
>> +     $(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) srctree=$(abspath $(srctree)) \
>> +             src=$(abspath $(srctree))/$(DT_BINDING_DIR) \
>> +             $(DT_BINDING_DIR)/processed-schema.json
> 
> I traced this through scripts/Makefile.build and
> dts/upstream/Bindings/Makefile and the logic looks right: src on the
> command line overrides the assignment in Makefile.build, so
> find_all_cmd searches the source tree, DT_DOCS still resolves via
> VPATH in the objtree, and the output lands in
> $(obj)/processed-schema.json where scripts/Makefile.lib expects it
> (DT_TMP_SCHEMA). The kernel has moved to defining src as
> $(srctree)/$(obj) in Makefile.build, but there are more changes after
> that, so we can worry about that later.
> 
> One small thing: $(abspath $(srctree)) is expanded twice. You could
> assign it to a variable next to DT_BINDING_DIR to make the rule easier
> to read. What do you think?

I thought I wrote $(abspath $(srctree)/$(DT_BINDING_DIR)) which would
make it not so redundant.

Your suggestion sounds fine though too.

> 
> In any case:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

