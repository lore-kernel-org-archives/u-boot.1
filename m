Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8D606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b4ox0hd/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1Hd5hDB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D78811B2;
	Sat, 14 Nov 2026 08:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ciSzUmAfWG0r; Sat, 14 Nov 2026 08:59:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00454811CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794646742;
	b=MdOWB9Aj5sJ6eD+wikdJKDXGsghf9aM23X9k7f+3mQFzgkmxBTwaJciXNnwWPs5FcGUH
	 LBKnOywKhpsdP3106B/dUOF6XKCUxuhUm6STGirMPKqKFJutgJn1Megfo4kRc++TURmqN
	 em8dvDUZxez+n5LUJ9SMPOYeQ1mw/Hujhf9Vs1lhdQsUwrMknAtG7LySNT/wdV2fTF8Lx
	 Er3R+CO0R+dAIJ7zH0dcx4TGzqA+dm0q8vy6EvR+GsnssBaNidUOEcznKN+nqYE3uVMEC
	 MJJX/rnr5osOnbTNYeurSxNmPYTt1GnWzMndjLtiBgQZFl6xBachHwiM91EjpYHtaLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794646742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2lQjtEvHSWYO67bf7puvLB1DT02vMRFcdtBV7SY4x0k=;
	b=DSHF4eHactMe8J12hsYqJfl776qFTLWiK4+adtNmWwfCXNtLR7kmuSwqqa9RmYUHp/5V
	 sl7IFw5pgctRsSoGpP/m+Cde1+MkGWcbvkcbdw/OVWKJdwNw0jDwQCadIiW71wQdavanL
	 3I6gFcKTnWuKfrr/VJVnQR7ZXbJ3rnE5nv0oRrB/+5XlKELYp3SitwUPxtfMnzonbCLpO
	 suBn/xPjOfuCyHS+wCoYQdwDHfj9ob5564YmkendpKes0DtUV3nFZzViiK8/C6hVY8ftE
	 GLhlESvCM6lBdo+ccWMR5OBTz4ID0vNqGbgSbNN3qTIaG83tqA46U0u0tD6aFeVJ59g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794646742;
	bh=2lQjtEvHSWYO67bf7puvLB1DT02vMRFcdtBV7SY4x0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4ox0hd/IHjmsjv10MTVdjY3b8SPdaTe0whWgDtNs1xdSq5jTWno2oQ8qRr0b7NQm
	 Y39C5GNy6Mya9svmc6YcBO7i5h+FN3pqnrp7eLWineTlbTPA8BLUQY9ZarWPVjeK9b
	 9WciiVJHbjS35Z96m03/tKuzkamwgvNo33O+NhABM58bg+dqunjgD+cjhzbe2QWywG
	 GiblKNBJVBRLt9VzBwEyGKEwIzZ30C+hKGDLzB3qIe4gdxgCzk1YofY4FZPi65L1os
	 mYVD6IUi3ugPlKgsS3nATlThfwnXsjwmgWwpxwjeq2tsBWh4clb5mkHUPT0M/lMFIN
	 zMFBZeeY8IXfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00454811CA;
	Sat, 14 Nov 2026 08:59:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DF7F1E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F76A400AA
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0UoBd1vtvQ94 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 08:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD24740050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=r1Hd5hDB
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD24740050
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:58:59 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b56bca14b8so285458a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794646737; x=1795251537;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2lQjtEvHSWYO67bf7puvLB1DT02vMRFcdtBV7SY4x0k=;
 b=r1Hd5hDBdYDzxMCpHCWuTj1OJq5oAkFlkhoPzGdVWUp/Wx2fHCzZAuRBvYowUHuhM8
 pAW9+q2H8rePOsyKuhJy26j4MqoXVY++tSA8+pzqdXdU2Lk3V4/PBYYLs1+fI8d1ykjv
 2UtsasEkaGFAaUxnR2bcmFJF1F32zjr8bZEURNKmZjCMNL0cpgdnp/YJzTBhyE4PB2kS
 dxSk56K7JknVf459nu6Om8dwLzAmYRqJoOx8lAH3AInMJ89klRjFJ63pDZ4DsLTUpXbb
 PjmSC6e2Au130Qd6yWZ6H8+IU5tkgV0u2Wm80cO+Z0OvWg24gOcQTqFPRA1NA4Me7Skt
 7JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794646737; x=1795251537;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lQjtEvHSWYO67bf7puvLB1DT02vMRFcdtBV7SY4x0k=;
 b=rYcriPVbiTAvTo8+UT+ay3djJ1WlZ/niF/3EonzaRKIPa3vIkxwTbRCKt723QM9uhl
 7qUta7mJzlnB92habD5AvnLlen2o1lYKOYmjs5kq84ExADIbNZLFxbDAYYtp+YxSprRR
 pq2S5XnNG2TscJMWs+UG6HgvtIAd12Y3e3T32Q04+tMkiJM5KQRX3t/vdqSZ9S55rNoj
 19jqwa8NJArZRHLp2T36W6+/Z5GHFKWUbqbMxNY9CHraVn271UQ8HTr61ezx2Hj0WFVC
 A0OJ+Jlh8mUZbgTofpVla6+a1QlznLYM29nFMFht0zM14ERHiqhlbkvinzeUZb2k3hjQ
 5lTg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZ+PsaKBOeNcpHQ0LxqKOCKI4kE7YkqItSsXGpItdb/4D0Gh7qYQQMuy8d5T26RqwwPc4I3j4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/pz4Mv9mra/5oiDqxPLN1Wobf3o9NqbfTBCHmoQMhX5YC6uPzh
 B6UKQzeKQ5HfpzkaCYqn38EAFUTNTdAtC3xVT4WxGdyYgM4nhlo7GJ9M
X-Gm-Gg: AYBFou0ZDsrUjL8tOHO3UH75OYMGaGiB5eD9ns/XDjKLOj3WdhKpFOPXzm9wI58tnoX
 pvkUAuVhDgddliF3/C6P5nPsEfLqfBdbt/m++VZaITsUeYqt4PqYl/ESdkQ8LPMz04Kau9BnAQD
 xELB/TBAjhVMgMmMLlR8FRRzCsSLGSPT4b8nhH6vMznajh7yoqLnBMf3LEyOM98Z9TlslCaLQ+X
 PQfQzVhxOID8XrLmVwWKuDoUnGU+jXCEW9uyw+pQ5qLqZNNhJyRCnz1r8MHrMlbsgNxtgMthO4v
 XDZyqgfLeQe2uNEaZegaepdOpzjdxvq9lng0fV8AzPiUD/vaCe+SaBLd9K6naiEUlKvH5HHlhk/
 Z7l0WV50X9uPo3chR+6UAMXQmMhvaWQ8cG8h0FTQTryJDIe/yXRkdBIEQv+gVlZdcyPzehOXtN1
 zNw4PNUyPqrrdF2Y9rKgX9mPGsF06lwjjy9C+vTixNEn8uu7wmkWtNUPwa0NQAz5aj4PsV+hpb3
 gmwvd5/ur8pSOgLZpzSGbgajOHhsBsCxc169fj0LIDFmJnYKJWbcDszEJhXAGYHfTHGC7SBvH/N
 hz+EFZl0ucYEGLqqs6upZ6B50opP3KEIbXOVL8EA8K+Kr8WFBPHDYVg=
X-Received: by 2002:a05:6402:c50a:20b0:6b1:da27:34cb with SMTP id
 4fb4d7f45d1cf-6b7c0bd207dmr3904471a12.2.1794646737073; 
 Sat, 14 Nov 2026 00:58:57 -0800 (PST)
Received: from ?IPV6:2001:470:b51d:1201:56bd:184:ef6d:ccaf?
 ([2a00:7c80:0:3a2::14]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c1e49be0sm2076363a12.0.2026.11.14.00.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 00:58:56 -0800 (PST)
Message-ID: <9247f9ca-6bdf-4876-b92c-78dfd9f1a951@gmail.com>
Date: Sat, 14 Nov 2026 11:58:55 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] net: mtk_eth: an8855: enable link error recovery
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-3-csharper2005@gmail.com>
 <14306a07-86f5-4309-930d-5668f361e73f@baylibre.com>
Content-Language: en-US
From: Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <14306a07-86f5-4309-930d-5668f361e73f@baylibre.com>
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
>> @@ -599,7 +599,7 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
>>  	an8855_reg_write(priv, AN8855_PLL_CTRL_0, val);
>>  
>>  	an8855_reg_read(priv, AN8855_RX_CTRL_26, &val);
>> -	val &= ~BIT(23);
>> +	val |= BIT(23);
> 
> It looks like the proposed Linux patch also clears BIT(24) here.

You're absolutely right, I missed the `val &= ~BIT(24);` line.
I will add it in v2 to match the proposed Linux driver exactly.

Thanks!
Mikhail

