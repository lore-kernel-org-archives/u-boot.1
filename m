Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41191606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SCGWp8mh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mhcY5uZ1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB6B981786;
	Sat, 14 Nov 2026 08:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fyK4loAZPhZE; Sat, 14 Nov 2026 08:57:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F4DB81771
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794646640;
	b=R3J9Em+8+ffFZjyZfSmDvizImredkW+raNg9cdbzSDVPeDRtNwi8Qw8vSvV43dEXOrqX
	 gNCWhF/XyUogC/OBwlHre1mxsW1VTAH3jhpZwFgZaFdB+dTXFvy8Cdr5MNz9IxEHbHsgT
	 AgtKoe1jzn8hEx4GvbKQGhUI4GXzyP1p6yCW5hT7zvq8IthaQLZyijCwcew8a7ucbA9tg
	 YFLWE9pVn7PCMlSMBYb/V+O1kHgJHm6RpebVUqUKQR87FLdZgUWgQLJcHw1AT0O33kwQH
	 Qh7ezEpomjWFTSPkIOTNagjM7UxGYhbHOoStKSs8qEhFrDQXl64PdZ7GAYYF0qkrJMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794646640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VHHWsekkf9fBhi8y22+IzssShhkGbpAJux8Vity2tXk=;
	b=PZKAydjT3z44SIucS8KjyJhCVjuk5K+zwoZeUIXgc30ArGRNUOIOs4y416W2N4LMWnNz
	 KD8HhV11tY5Db+vtavUwcH1Aq4XulTIoAQ7gBlNCL3UbPhQoQdvMQIbM8cNS4fUNWEa/7
	 GeknhiD0efJOh1Bmysw4C7+7cZ6HO474e+WO/CuDsQH7y+rz9a3XDXm0ny6rdDuq3Tldf
	 4GKzzZq2X7H8GGlQMCg3LGJtOwPM9c9rsYSIGwQzCzE8DIlwea3r4RAMwPEhZK3wlsDDH
	 5oC0t8h2d2NBg3AgVq6eb5V7gnWd4hHoZehzhIw62YQ+MYJognlABfIVwWweLjexFXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mhcY5uZ1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794646640;
	bh=VHHWsekkf9fBhi8y22+IzssShhkGbpAJux8Vity2tXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCGWp8mhx7OmfL47mHn9lBhIlK3BA7F+DVlk7JNv14ZyFb4R26HwDbUuy6Op1o6DR
	 ZBzpHSnrUKqFjpj0w/VDeZCi9eR5vpc23vxkSkrUFftVv9kwMKhdDCfol84ugTeQfD
	 DDHSwB6foKSVrPV688bJ+e82VKkY3/b6l1bUWF7EdgECwmRcUgHZxzbokC3hhl2nH8
	 qspleNdnGxZfJxWc+K+kXQDw/4qHMo/LrcLMw9TYSRUVw5rEEhoAsyiykK0ZIX1Epc
	 1k8Sw2PRZGf1UO1BDnqpvviwevSwl91YWn0KggwIlmfmKmmQQqBt6iUZjR4/Ac8KAs
	 LYKBaC8Y88tQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F4DB81771;
	Sat, 14 Nov 2026 08:57:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41DB32FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F79181771
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94hpAYn0dmmj for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 08:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5169381702
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mhcY5uZ1
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5169381702
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:57:17 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b56bca14b8so285285a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794646635; x=1795251435;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VHHWsekkf9fBhi8y22+IzssShhkGbpAJux8Vity2tXk=;
 b=mhcY5uZ12vT7Qst4YU4u4f4trywGxbxndGtqiwOmyRyLXDlsvSb6zY+x3zjLRhCVtK
 vSZzjSACBobuK2JwFXmdGIgHHASXbki7VMxeLedm1QQIHJmXr3zsdHgtBO5toqIw8JU9
 ZGun8/ph4+BrCa8dUzPsITo6Zzb4OM+UEMWtXhs3Ni14zsacjnd/neKADPxwIE9NHoRs
 e2bmzKVqNN2KLVhBkI3na+f/mb8atsNaNJJSUzL2fCN+mwssEu0nYPjkzMCU8jaOJTRD
 O8nh58POUml2RTiVp84Kfm64fIo42g4ZmU0/fT1qBUWRBjLLzPDZFPQOpFONLzlM2rdA
 LrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794646635; x=1795251435;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VHHWsekkf9fBhi8y22+IzssShhkGbpAJux8Vity2tXk=;
 b=aXfTZX3o0j2qQCNTqGyKmmAemEl8JceJMuCWUrM3/H8fzL8fKuMGPg553+pSAAxj2g
 SAfUBMPArN8o0qdlRqQjTTpr1RxSlmV9vtyn3oOT0cRKFo0INbXb+fz+4+uQcvr4L1Ln
 ATIHJwWYgb+MwqeZxpd+onKIVyoBs4wYhodJKmHyNRReUMsuNCpdNcCEzfOAiXIB9R9G
 t4fJbPNGPZu8Nc0iMlQHmlPFNVvuFumrPYsI6NSAilCk9x7C4zZbLdLtcF8nVdsrbGCG
 azSuuP1tAxWT7Cf/Ozj5LPoyyZuQwxM62zIQAWkQPw4sXZqpYSSq2umVWx6qMG1xA7iM
 lC7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH4meHAMLnzzUVdUkmz1vqol+6yIwEihmXYBgK5dZoDmfDrUA0vU1SbE9s3z4gXwZKnUeyZdTM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8SRhxUMvaC49dNGwIOe9oVmvXITM2b7IrXGNeyg5EheOHpFlRE
 HPZqVKFNs5ui5BhPLnlugzbNYZOF8zGV0uWWyGcna+8O1mPsB+usJ6x5
X-Gm-Gg: AYBFou1MSbqsPEO341A88bnLcCSCIrAOMcJzDdmBFMa6E9uwzwuwve1TlZpmOYPGZKL
 kwleHObXqhsrbm5acrMyBOm5kMis8weEB+y/wq96wlwSQjGVPme4Es6CHGXCUV+cixf4HZad0K6
 W7eLKZKbd6AJIwRl9U5FfbtQ4S6C+3tKuJM2bhgx/4mEAbbWvZqNpa8ocgI9HXAYQ48usS0U08u
 Lkqmhb1BQSiueOLwkqCaqnfxhvyVsd88/PQM6kQxwzjBOAB3483blSFvpPkIoNCM/pkj4d4U9Bn
 7NhiJUvkGs1B2SpmsPn8G2daq2kEBWYQzAjnkXn9fdjrA8esXeaLW69nI9yBNqlOx09ZQIMPGMp
 KH9yLhSOATxrxjQEdqj/z+TwhwVxJX1T4dMRhsstv5Mut8Wwj+lmY7bPy4hj57Omq3Kn3R80eZB
 T5w3GGdw9KAzOyxQvu3O2Bu0h4cG0cy2p9p0gggPXJ930uImm2Q+0+HAV8gNjE/HFcccp9VCBzL
 cg5Jvzd7Rui669VEDDDf2WHkOhurmcT0c/u9UIOyY76FyIAHqZNun2Exqm/PAjDim61532ehPWg
 cB/agaiSdedkGG+gI6xKGawZDkfE/JT6P4DEeBpH3zdW7XIdMXQkwQ==
X-Received: by 2002:a17:906:31d0:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c509610e1e2mr418339366b.1.1794646634945; 
 Sat, 14 Nov 2026 00:57:14 -0800 (PST)
Received: from ?IPV6:2001:470:b51d:1201:56bd:184:ef6d:ccaf?
 ([2a00:7c80:0:3a2::14]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b56df7sm199737866b.47.2026.11.14.00.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 00:57:14 -0800 (PST)
Message-ID: <90639ee7-eabf-406f-ae36-fa33289d9682@gmail.com>
Date: Sat, 14 Nov 2026 11:57:13 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] net: mtk_eth: an8855: fix bitwise collision in
 RX_CTRL_8 register
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-2-csharper2005@gmail.com>
 <7a142599-6c0c-4656-b23a-bf339f40c4b1@baylibre.com>
Content-Language: en-US
From: Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <7a142599-6c0c-4656-b23a-bf339f40c4b1@baylibre.com>
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On 11/10/26 00:23, David Lechner wrote:
>> +++ b/drivers/net/mtk_eth/an8855.c
>> @@ -627,8 +627,8 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
>>  	an8855_reg_read(priv, AN8855_RX_CTRL_8, &val);
>>  	val &= ~(0xfff << 16);
>>  	val |= (0x200 << 16);
>> -	val &= ~(0x7fff << 14);
>> -	val |= (0xfff << 14);
>> +	val &= ~(0x7fff << 0);
>> +	val |= (0xfff << 0);
> 
> nit: we could drop the << 0 and ().

Good catch, that definitely looks cleaner. I will drop the `<< 0` and
the parentheses in v2.

Thanks!
Mikhail

