Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27506CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EDAB83A41;
	Mon, 10 Nov 2025 14:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gSaj3YEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669FF83A84; Mon, 10 Nov 2025 14:05:57 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BDB83A03
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 14:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4F1A108428; Mon, 10 Nov 2025 14:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762779954;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Rki8WugJsNlmrg2km3Fw/PXAwswRy7ad+qJ9y2hzQ+4=;
 b=gSaj3YEKnFGUqyqXa+4t96JhFHXR0DDy9VLyoIdmMux6W4L8jB0FZ+QMDDWE61aTe/6SQB
 sSglw7Z2cJvEeiKEtpECDswhR3eFZPBVKhohF7z5wxaLvErKPDa5JX+BBsKK59PNTGemQw
 T4ilHZfcON6BPerjs8Q4T2nTlJ8wJjdkp+ECXAfQvJmXi0mRQfpmgntaoNVppWeUhw5F+E
 zH3v+wdAoSCxHOoWKwZAekQ3m3Wg/xJj7gL5A46zbIcAcOX9sG14iMQfNiH1XNgV26kXDI
 yziP9BLJI+63gs8SvvjNrY5uEmKBJqMPMZjdBbpvEN8uW4fioQNmjQEJg/siHw==
Message-ID: <db72999a-c2de-3063-5400-f8fe3c54bdd1@nabladev.com>
Date: Mon, 10 Nov 2025 14:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 4/5] tpm2: add sm3 256 hash support
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20251101064907.5037-1-hs@nabladev.com>
 <20251101064907.5037-5-hs@nabladev.com>
 <CAC_iWj+GH3kFfHJTpE57M4q+L+jmxtACuQqFP-+WiAvhPLk76Q@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAC_iWj+GH3kFfHJTpE57M4q+L+jmxtACuQqFP-+WiAvhPLk76Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Ilias,

On 10.11.25 12:51, Ilias Apalodimas wrote:
> Hello Heiko,
> 
> Thanks for doing this.
> This patch is fine. I do think we should extend this more though.
> 
> Adding the missing SM3 algo is indeed needed. But when using a TPM,
> the specs that currently describe it require all the PCR banks to be
> extended. IOW we need to add some code to lib/tpm_tcg2.c as well.
> I haven't looked at all the details yet, but we at least need to add
> the new algo to tcg2_create_digest(). I am happy to help if you need
> more details.

If you can help me here, that would be great, as I have not that deep
knowledge here!

I try to add SM3 in lib/tpm_tcg2.c and send a v2.

Thanks!

> [...]
> 
>>
>>   /* NV index attributes */
>> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
>> index 5b21c57ae42..0fea35e5ae0 100644
>> --- a/lib/tpm-v2.c
>> +++ b/lib/tpm-v2.c
>> @@ -686,10 +686,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>>
>>          pcrs->count = get_unaligned_be32(response);
>>          /*
>> -        * We only support 4 algorithms for now so check against that
>> +        * We only support 5 algorithms for now so check against that
>>           * instead of TPM2_NUM_PCR_BANKS
>>           */
>> -       if (pcrs->count > 4 || pcrs->count < 1) {
>> +       if (pcrs->count > 5 || pcrs->count < 1) {
> 
> Since you are changing this we might as well make it future proof.
> Can you please change this and just use the ARRAY_SIZE() of the
> hash_algo_list[] instead?

Yes that makes sense!

bye,
Heiko
> 
>>                  printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>>                  return -EMSGSIZE;
>>          }
>> --
>> 2.20.1
>>
> 
> Regards
> /Ilias
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
