Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCD606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LFRk2JKq;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EZb0t272
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE0A880D9F;
	Wed,  4 Nov 2026 17:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aYfaQkbWp42; Wed,  4 Nov 2026 17:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19CE880C41
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793812975;
	b=E1Y77p4oryX1o72Z1uM191NXwWXx/1QvzlE8pk+1kO5C061Ea85gnToGrjpsA0QMd+RW
	 lwRN88NkvWvKGDs7Om2DmozQifdCoNzjBh0+14CLYdHueG+dJXABeZaIwPScWUAJekngz
	 mX5S6k2SfTmFG+lK0sBspTLaecmyJURfPQFaS9BKjp5Tr4/ZrfUtXRjDJVAYDwF/9SYqh
	 fTFWuaDW1fq92eUqZxprfU67oMfozqZ2BlQPkSB5HeHvzwMmuKgY5raVsDN6buxGHo9oi
	 Tl/9nV+LEM9zdXIXZlfchkz3ztU6+ffAcqcwxQtDhzW+adY18HvWhX+V2Sw1/BWROGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793812975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u0D4nheeL+LMlYPLaJ+NJMhP5NMjcoQpsZeMkTlFnes=;
	b=NMr325vyDvGrMrxHDVgcnrFgjU99pcJmI7rnuOxCEhFnCADkyf7feAP4ykVSsdS/jd9S
	 0TwsuqfgvTvJQsoNHKBsyKFkEzGMLXoINGp9lObNnJdlBzEI5odVfmM80W2Gk7oJyiLR2
	 UlsFkT4IPEyeSpM/IdmIkiY+AQ5er0+XSJp3UBqoPrk0quTcwRYc3wmsEuckjCxZw9tFX
	 2yFJ4iSZnXAzLjk+4S7KDcWDNp7TRrf9/osY5y45+aXmXcGz6zrU4ehFXmGl+UxA/RTWZ
	 5Tg6ra/nM01I+iz2gIqTikv3yS86AoXpZcmNdaJxj0eZU+ZX4/lIzYsK8KFyCftr1GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EZb0t272;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793812975;
	bh=u0D4nheeL+LMlYPLaJ+NJMhP5NMjcoQpsZeMkTlFnes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFRk2JKqkNUmf98PHIABaagEwxsx4syO+1qMBrRQX1KrbGvD9x/F3LArOsfXUHLgy
	 ows2E+rUOf0PiPplUKczyyeNdPGXukqDcuocZ3IokXLu72oYBPSNeuftVciyHuCRUY
	 1dnLA63nW7uUtbCGV2VLJH88EQCGJipGnmgw2xzXLmi5QtM8FBdhwdvhEqd+XWDJen
	 RV/51AzIV7iXCOnEHHUrFvFlEAD9oX+oBy8gwuxiCRVlD6PeQsM5S/C5ShdL2q1Jop
	 PLzhE1hubMdsJJ9wMxrpYaZJcGyx/I1FrLksGlakjd/wwzX3Ao+3FoJ0gAuAYVQeLR
	 Dvgn7w+wJ8DLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19CE880C41;
	Wed,  4 Nov 2026 17:22:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 622C3EF6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5335A80D74
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6ZHGXOvOaRj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 17:22:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3892B80C41
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EZb0t272
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3892B80C41
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:22:52 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso8701345e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793812971; x=1794417771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u0D4nheeL+LMlYPLaJ+NJMhP5NMjcoQpsZeMkTlFnes=;
 b=EZb0t2720fJbS15+Iw/mpWYc6CVjr8Ke0D8g6h8dzkfXfU8e/AVTJC1HdanRYNTAKJ
 kqw7VK1cZ/Qz88/Sh/g8w/w8z3JOklBCL0S7Em08JYZhnIUWoNxKUBk3rSd1De0wiJpo
 AedjmmzzKPnuTgdAtGn1jh+ZIs4vRL9qolCcQjdg2usuMKQNn95H1e09/uLu92KgazmX
 fA3BIbf4xTf9HY73eVgyK2KZGB+Vxeec/8EX9IwxLSIDJswIAs+vxh0tYAggWRGzECpm
 69HQAUivE6czgiP9LEEVau9HBZ+AzTiwBoWl0Cfe1tqRQfYGqmCSwMXLtKGUQgJIw7T8
 yXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793812971; x=1794417771;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0D4nheeL+LMlYPLaJ+NJMhP5NMjcoQpsZeMkTlFnes=;
 b=mvx+hKNPfepbhT6dhBFNuPrh1ZK+2EaNC/ickV7LXqWU7NSC4oV2bfguy8Yr6PkSF5
 cMZhj3OEJvoYzHQYFmzOuhAefHpieuYmeQRsnguJHwxnwDB0wOw5Ty2g5TSI9AJ93ZnN
 2eu00G6yzgg7KNVF5C5fdNTLbcvTCPz+1STI08rSJz68iFba9bhQr8mPINaM5G3VLwdG
 fHyuJ1kO8P8plYv/1Nh9WCj5bf9TlUXNEHQPzfj6fiFVV9e3gOO/jb6F1CZKGG/paqTF
 sgNmTE60ZcpOUPZDUhg1KPRACDecQ5YiHHSwoGevu3sXLgHblIsHfPOkB0VR4X7gAe9I
 eKiw==
X-Gm-Message-State: APuU4Z8OCWts7ngi/ymouBCPa532lwLOVUj7+3ZG9WX5lp0FWkOJL8m9
 T2cC1Fv22zAbcpm6r0BZetGblOVTmn56n52337WqnCJwYqytZ9Ot8TlU0kGwR2xD/UygQvg6JEQ
 IrNFIIhFU0g==
X-Gm-Gg: AYBFou1wHCQV5nCVRF2rSy5wL3PdIq4pp13AqnQarmIQRj1NPq+cuF1m5JxIBGVlIgS
 J1oEUmgVq1pXNVX2IWVCTNVJW86NIqwGHEl5UWQA2L4IMtpe2R3/Ct10Ly18jE9UItJi/4I0PYs
 7ElykwrFNcfoq629epUItcOIyOGlGOzaYOgLTguWikSiRusUF2mDU5du77L+REFThxq9J2U9fKP
 efTMVKX0mtVZqBQZTECmEVlNfef0lAfOZJnDLXd8xsenOPqEziLJbvHJaZV/H1Javp0C9FgH1jX
 Zy4YdaP6PBUzvBmjHiSU+Jpg6aLUlPdfqzoGA7AjNLZmhACQa8284gef+TQoReai0Klb3sO0f8P
 Ne9UkJyCHPLQTyU9G09hfRUs/0ZK2m+GyFLWm1cDJcX6MoiR5Z1CkPYKmNsAIoW7RXZpN+guUzM
 y6vXFwA+UvtWtzXlaoUfEzhJstXN2xTlx1QyMkQjFLvi5KFQtsxdss7MW1Qeud9JFLqB11i6yi8
 GMqXDvi6L/+kUGacxmDTwPlW79ofUdV1/oifydqsCA4FfmI7+JqszAClBPWgsUsSI1Pdwh91tdj
 BeGx/kntYGZnXCoOfDBovmGIQoOeRTlvdT8tHdbRR0sHlYSir1BSg0NBsDi5fCEFmTxXX1V+kru
 Z2q3lkNeC+ys+il9f7neYfNEClbM=
X-Received: by 2002:a05:600c:1387:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4ac1793fa6bmr390806765e9.13.1793812970734; 
 Wed, 04 Nov 2026 09:22:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:f322:367c:4aa4:272b?
 ([2a0a:ef40:e16:1f01:f322:367c:4aa4:272b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda203b6sm4870031f8f.48.2026.11.04.09.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 09:22:50 -0800 (PST)
Message-ID: <edd00030-80b1-446d-9a86-875e17fc4574@linaro.org>
Date: Wed, 4 Nov 2026 17:22:49 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] binman: btool: lzma_alone: Update version function
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Francesco Valla <francesco@valla.it>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
 <20261102-qcheck_fix-v1-2-f1f547c4a731@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-2-f1f547c4a731@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02/11/2026 09:57, Andrew Goodbody wrote:
> lzma_alone 24.08 now prints its version string to stdout instead of
> stderr which means the current version function will not find it as it
> only looks in stderr. Instead look in 'combined' which contains both
> stdout and stderr and so will work with older and newer versions of
> lzma_alone.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/binman/btool/lzma_alone.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
> index 1fda2f68c7b..aa44c897223 100644
> --- a/tools/binman/btool/lzma_alone.py
> +++ b/tools/binman/btool/lzma_alone.py
> @@ -116,7 +116,7 @@ class Bintoollzma_alone(bintool.Bintool):
>           Returns:
>               str: Version number of lzma_alone
>           """
> -        out = self.run_cmd_result('', raise_on_error=False).stderr.strip()
> +        out = self.run_cmd_result('', raise_on_error=False).combined.strip()
>           lines = out.splitlines()
>           if not lines:
>               return super().version()
> 


It turns out that .combined is not deterministic in the ordering of 
stdout and stderr so I will need to send a V2 that copes with that.

Andrew
