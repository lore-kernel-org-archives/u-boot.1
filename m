Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915F5D462AF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C3D88C0F;
	Wed, 13 Nov 2024 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZCPmXWG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A8388F94; Wed, 13 Nov 2024 15:27:24 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C138862E
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-432d866f70fso2873805e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731508042; x=1732112842; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0XBClfxOIAUl6WgiPV1SWrNouiLu9AMs31i0YCJ1FQ=;
 b=ZCPmXWG7Q75RJ5JSGDHxOAlPiltVC8pYdMEef7I0bIKWYe1uwbK90ap6aPA+11tWlX
 etc0xM16luUMV3q48FBTaK2RcJ5HCmAwJd+o4UKz20lDiIlo62xqFpobqqspRYllvm26
 FK6kq2A4aRJu7rZnO2gf3z4vlqeVeRrFz9Ws9qSHmhfd/pL9rgVW9bLh2kCHF1/OVcZo
 l2qkvCODRDlC3ddRuQ95P9gMri7y9In+M8xZd1eBy3cE+AppbOGkFtaj4SNtVqgyEGvK
 FMHdsxrmC0tn2gFocj2+3L9sw0IXtI5mR+YAcsB3sn3FKmQhc0hs9PafVhxmVPma/bYx
 WWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731508042; x=1732112842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0XBClfxOIAUl6WgiPV1SWrNouiLu9AMs31i0YCJ1FQ=;
 b=Dbg9Vdd/K5d3LsdE27omDQhoU3V9Dog+oYsBtFKIZeCRRCEecrXqSIPcGgGkFxO4Ag
 zR0dPHH2wBR437KNGMTed45BQBIcIBN6wfvjiqMe9bLQpZbrj/5yzb1HlrrnLQszd6lL
 wWqOWJLaybEBKlDfhjR6Qqji1Fb9Vq5CnTDcOn5Z9geRawbwMDzuoGB5HN92Mf9u9lv9
 OooWhEQmNnJ94IFnU092HFc/qXgdaRv1RPlrx5LJG8zlQcl3JxavHziSZDy+xUxp0aRK
 Ma8+UWCyR7p06LpTpodEe1ZKJhix+C7TGVwnmfXDXD505gG8BU4qUgkq17L9Gs7OgM4/
 y6NA==
X-Gm-Message-State: AOJu0YzClz8AQTx4bD5yLIIX7s9e+ke0ZT5qq6kIpt5JMxrplHUcJb7m
 d/iJA6Qi/SVb9+l6+W2ZZ7PsJcdFB6KFL3Ib044BuzixLF3sEZ1h9MlA3iFuRg0=
X-Google-Smtp-Source: AGHT+IFIp4rP2l9IcRI3ZU1/6V7TA0xztWdpdjKF7GQptiujL4PZWmrtTF6LvdQdpIx1L0bCxBqjSQ==
X-Received: by 2002:a05:600c:8608:b0:431:46fe:4cc1 with SMTP id
 5b1f17b1804b1-432bb99a52emr159929835e9.10.1731508042324; 
 Wed, 13 Nov 2024 06:27:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:be89:2e45:8eeb:41c?
 ([2a01:e0a:3cb:7bb0:be89:2e45:8eeb:41c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54f70d8sm27442105e9.16.2024.11.13.06.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 06:27:22 -0800 (PST)
Message-ID: <b4855529-50c9-4993-9817-7ca73baad316@linaro.org>
Date: Wed, 13 Nov 2024 15:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nwt: wget: drop Content-Length processing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20241105110849.41348-1-jerome.forissier@linaro.org>
 <CAC_iWjKhO3FnjbAYujbyp5kdfs7w2GLJ6hoyEtK19nh0UHXe5g@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKhO3FnjbAYujbyp5kdfs7w2GLJ6hoyEtK19nh0UHXe5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 11/11/24 13:47, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Tue, 5 Nov 2024 at 13:09, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> We don't do anything with Content-Length except a debug print, and the
>> strict_strtoul() call is incorrect (it always returns -EINVAL and leaves
>> content_length to zero due to the presence of trailing characters after
>> the decimal valuoe of Content-Length). So let's just drop this piece of
>> code.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/wget.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/net/wget.c b/net/wget.c
>> index 635f82efbb3..361817ace65 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -26,7 +26,6 @@ static const char bootfile1[] = "GET ";
>>  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
>>  static const char http_eom[] = "\r\n\r\n";
>>  static const char http_ok[] = "200";
>> -static const char content_len[] = "Content-Length";
>>  static const char linefeed[] = "\r\n";
>>  static struct in_addr web_server_ip;
>>  static int our_port;
>> @@ -46,7 +45,6 @@ struct pkt_qd {
>>  #define PKTQ_SZ (PKTBUFSRX / 4)
>>  static struct pkt_qd pkt_q[PKTQ_SZ];
>>  static int pkt_q_idx;
>> -static unsigned long content_length;
>>  static unsigned int packets;
>>
>>  static unsigned int initial_data_seq_num;
>> @@ -251,17 +249,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>>                                    "wget: Connected Pkt %p hlen %x\n",
>>                                    pkt, hlen);
>>
>> -                       pos = strstr((char *)pkt, content_len);
>> -                       if (!pos) {
>> -                               content_length = -1;
>> -                       } else {
>> -                               pos += sizeof(content_len) + 2;
>> -                               strict_strtoul(pos, 10, &content_length);
>> -                               debug_cond(DEBUG_WGET,
>> -                                          "wget: Connected Len %lu\n",
>> -                                          content_length);
> 
> How much work would it be to fix the parsing properly? We could look
> into that value and drop it if the memory is > our available memory

TBH I have not looked into it. This is the legacy stack; lwIP does
decode and handle the content length properly AFAICT.

Regards,
-- 
 Jerome

> 
> Thanks
> /Ilias
>> -                       }
>> -
>>                         net_boot_file_size = 0;
>>
>>                         if (len > hlen) {
>> --
>> 2.40.1
>>
