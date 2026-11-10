Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC9606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IgDjUGaf;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uRuSE6P2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D236A60690;
	Tue, 10 Nov 2026 18:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43DENUQ4IpYb; Tue, 10 Nov 2026 18:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FA0A600C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794334382;
	b=WkG9jmBjP4tK5wQdtjwBSaEl0S61Nm9EqHhUsQPc6Zv9aX1f08iZILZPa7ymB6JXotK9
	 OAySnOmiuC0pZSXo8ubaf2Xsib9tQZ84YvYlzEPvTFPe7MX7ZVlP0M2ZW6QzmCKrZqphu
	 BoGEkGhAxT+PaFCBp4tVSknScyaAQjPg4IdIc389NVzv8Gt5f7s4OkixsGeaOZzsgz3HJ
	 2GIoB2T6t4e+OMFRwVdiV1fs00LN74TqE4qDSqZNtctKyYPyV/SQQxV6VCyVoPixSL8Qm
	 9MgfirAp/TOtyTTRc9V9EJOf50aaSiKfMaJlS8KAxmjuGQsPo6KLC4KkWNywaXtiCog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794334382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JFEE9tNhv/s1R+RtqKXuUBRRLC40RTWoSdwGaTPCD8g=;
	b=sDDMfCJel5XD1ZvytWfw5i+UIE/dvDI54/da40DkY0eRusjx0Cz9tdUlep7RszHaLpBk
	 hsxruWZ6HU274pqK2lnkYtiuneSXDjz4QUy4s8Uh2mSOVhRmJiyN5rKaHkecf1gUkWAe4
	 MRXpr/zbHX6rWo3rF62BMLV/u743wVIGFFpNEHH+702fxuG8dYvBD5FxwS0NpeIM672m3
	 tihfhCtmxerhpd+if6yqNTjx49/B7XPhQ4i6Naq93cNCSCcoSIeqPw2BbkH32pnW1bMIq
	 plvo41qYhua0h2ucLGiW7A3wREpZSCvlZTWKuSc3dRdzQQjzvG/N50ppm+BUfWvwBew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794334382;
	bh=JFEE9tNhv/s1R+RtqKXuUBRRLC40RTWoSdwGaTPCD8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgDjUGaflrxo1J0c6U6ax4tFtGvf3KxAL50z/4rwKpkzKgHOkbhinaixQqEHz4C9P
	 tMVKK6qerIjKYf9l9ZyqJcfPsKa47PonWTiy9SSfDp/HazsX41eOMpSlyfdRc98vg2
	 NOxWtctvPypzILKrWCZ/CP2kaGkSwX1n0kMyWVROhnmDlktzoXzj2fs+20DZb4S3GW
	 JWf6rCalH1zfDtuiLOEOgvC78iZXAZ8IvQbiawWyAR3Tx5C3j6BjzZ7cOZb7NRVfVt
	 oq+6hdzfkF5pgtvHW+0Cze4vxaeHS3GscjwW4I3QeieigIYu0pzTNs85wwVhFVt4lv
	 8RHkOTbUzGoSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA0A600C4;
	Tue, 10 Nov 2026 18:13:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F7DA1FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 656D64030A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xM8V-dN37GNy for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4420F402B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::6;
 helo=mail-wm2-x06.google.com; envelope-from=andrew.goodbody@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uRuSE6P2
Received: from mail-wm2-x06.google.com (mail-wm2-x06.google.com
 [IPv6:2a00:1450:4864:31::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4420F402B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:12:58 +0000 (UTC)
Received: by mail-wm2-x06.google.com with SMTP id
 5b1f17b1804b1-4b76b2f6bd9so7068355e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334376; x=1794939176;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JFEE9tNhv/s1R+RtqKXuUBRRLC40RTWoSdwGaTPCD8g=;
 b=uRuSE6P2XG+gvX4ehX2XH6QhQOrJ5jWVO9fxAGQ+oRsLtlvIg7EjPfKPhTsRHPd3KV
 Ac+3JE8z8la5qm4nChpb+LxQNFqn22h/x1qm1mmbqRXM9BS0LSgRJkShObt310+3Ke9W
 qAbQc0fhhAPx56tydco3Gy6flt+RMYuZJUw26JFNS+46c+b3DSb5Gqb+qiqNM7/WSafE
 yitTfWNkD94xcYQ74eLljO2byt1xE5+aWwW1Hi3mh2UTfrnqr1jFO2tok32UBhe446sZ
 gMkl97dpcY/uPaxRDgvBZiLstuhcyo4OMl/dV5/MSaHM0IvOuhT4GVsj9uOopGU5nYnv
 YKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334376; x=1794939176;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFEE9tNhv/s1R+RtqKXuUBRRLC40RTWoSdwGaTPCD8g=;
 b=lvwkxOfatbnPHZHLp6TDas/4j7ZeL7bJAu6umH1xryzcCPQBBBVkk80oXOaowN0x/2
 eiRE9fI+1AD33MbE4eIlrL4hRz8TZaVqXL+s7BMt8+hOrY0/UBgtSHvLT2JXVYOm/oi2
 Q2q2pXLIWDNKAJuis8M8/79NyfSier+HxIuuxc9grDb9b2CxGzx1rd/l2RG3ZV4g7NKD
 2cIrflc9KzWV7jP/9F+InqSRCiUICCbCegaowA/nhKxp6kzmzNczzf4iaSQ9xjoWJqQ0
 Fl4nhXQVIdz92Ow3Gg/WGEZymGI4TdxifiUNwFIfHcGGWdJgOOBOlLMM6p0Z9MajJLyV
 XRFA==
X-Forwarded-Encrypted: i=1;
 AL+hErGT0hr3td9sUckirgHIxaVXvFSaSDN47VyiWPEajW7cy65ss5G+4C3FYwRqoJpGRMCpnjCXqAY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/P7ZJsXlQNvFk+YDFH7OcTyCUpmOZ3DdtV9TOKt4br5aXNtrsR
 OIi5NK7qPh2iOj3Gaodne5guXL6RIex6PhwuF0Uqvu9i6JAKiTbI6OB7G/GLgHNzc5U=
X-Gm-Gg: AYBFou2GD1lVX6rEUdpzV15RxbSzv/kOSdHwjSj8wWRKcjZnQITMbzpRld2rawIBrvY
 hHgqCN1pJ2APlO49NepMBT0rk1/exWLN402FcLAC18EBUxijEpBPtQIqCU58WWbxRoB0/dg4SOH
 mt9/oub/+liwnwIlWtg67JgeoEHM2Js4ZpBGh7uM8bt1u3kFveViMM7yYzIsC/cIoo8QYhNQxYN
 moL44HrlEF953obXnxDj1RGiEZq534jI96zEIqaEmob2yxArxItkY49AjnPOdi2QTHnSo3y13oT
 NzbuhQma7hwyuKB2xE/GK1ewrTrfCVSonBT6uJTJlv/RB/3YAImYGuw4jHmvo72Fs1mJhuU7O4+
 uKxQahls+zTMBeqG6XVIUdG+a34lleWv3+eToVqc8cO7KSoNHCf9JF2vghvMP+Ux3JX0YCSE7i+
 LwnDJ39vW0isQ4R2Rdls6OpBCHC/87ywyq/xcdTmpgTkZYK7BRXgC2NgtuLUN2NlEg9vRFepd0j
 /TRPjUUxwVVs54EOAP8ClAJUv+Aul1tEJhgA4/6e8I6YafTOqCRKMYGI+c+/R3OUYY0IR8e7f0o
 Slq5noUjdYuLZQ4ibY9IDPcUgxUCWHdU3J9vOD4Ax7vXfMskAiIZLHzQSbjVm1kuWZA6DX9+Dt6
 lTKJE
X-Received: by 2002:a05:600c:64c8:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4ba02343ac3mr58873805e9.16.1794334376258; 
 Tue, 10 Nov 2026 10:12:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm6385362f8f.18.2026.11.10.10.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 10:12:55 -0800 (PST)
Message-ID: <79b8b094-eae2-4d13-a544-af416b3fca11@linaro.org>
Date: Tue, 10 Nov 2026 18:12:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] binman: bintool: Do not add empty argument
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-7-1c76e0b68f29@linaro.org>
 <6f2681a2-1488-42ef-9909-169b47ba311d@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <6f2681a2-1488-42ef-9909-169b47ba311d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/11/2026 14:41, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> If lzma_alone is invoked with an empty argument it will emit a message
>> to stderr. When 'combined' is used to examine the output of this command
>> the content is not deterministic in that stdout and stderr may appear
>> out of order on occasions. To prevent this situation do not add an
>> argument list to the command when it is empty. In this situation no
>> error message is emitted only the usage and this is always sent to only
>> stdout or only to stderr depending on the version of lzma_alone.
>>
> 
> Then this patch should be before patch 2 otherwise we use broken code.

OK.

>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   tools/binman/bintool.py | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
>> index 4cf8d5b165b..15e2df2fd80 100644
>> --- a/tools/binman/bintool.py
>> +++ b/tools/binman/bintool.py
>> @@ -290,7 +290,10 @@ class Bintool:
>>           if self.name in self.missing_list:
>>               return None
>>           name = os.path.expanduser(self.name)  # Expand paths 
>> containing ~
>> -        all_args = (name,) + args
>> +        if args[0] == '':
> 
> question: is this really correct?
> 
> What if we really want an empty argument?
> 
> Say
> 
> echo '' 'test'
> 
> for a simple example, or even
> 
> echo ''
> 
> which will print a newline.
> 
> I'm wondering if you cannot simply remove the '' argument in the caller 
> of run_cmd_result?
> 
> That is:
> 
> out = self.run_cmd_result(raise_on_error=False).combined.strip()
> 
> in tools/binman/btool/lzma_alone.py?

Yes, that works. Thank you.

Andrew

> Cheers,
> Quentin

