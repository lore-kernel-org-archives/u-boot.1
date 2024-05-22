Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67759C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E470C881C3;
	Wed, 22 May 2024 20:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fRQ/SGwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D418849A; Wed, 22 May 2024 20:39:54 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305DD87C83
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b097b202so797692266b.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716403191; x=1717007991; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9yXwLtGczt7dDbcJSVaoRhctSi137MamISgqEPCINc=;
 b=fRQ/SGwIKAz2h2a2V9ks2hgGJC/U/Gbv1JI+u1s3b/jMM8apzb76+OOAN1dXIqM8NH
 eu+pC+nkzuaRffnkvcq9ks+FfNbpWRXAMPMhPPssKraHVknEYsA8seZKteKfpKgHsAA1
 2OupXdFDe7gu6nNpOy/v22+xGdBA0KQFP+EWgxPEvs6D11vZEKg2WnhnzXxKOqBbeIF6
 1PuLSud8HIdZVEMr9Q+D2JulDQ+jPRhJPV3708f9kGxFzdzRtcxvViajOB+8PbqjuOES
 WlSxIyse/UXHKDCciVBfERk3B5e/dFJRqmqECbUcq/esSoond6absdub3atacHHnFzHc
 wlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716403191; x=1717007991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9yXwLtGczt7dDbcJSVaoRhctSi137MamISgqEPCINc=;
 b=LrScbqTXyusKhMuzRCemorP4Bkv75Bh8Vh1nX4nWQxxTV297n8UbQk48AIToYZnXHI
 yYaVySNUDVu1qToSe9wb18Ze2beHA+FLyKFXiS6qzBJ4jBGyKTMD+QlYcgo8UwxtVEz0
 UN7BF/kpciOK+CrC/hJGgph0OtgA44apCC1eCVHHebacW0X3+hjbHrAibaxV5L8+mBYR
 6FX/AzDfoQ/Jgz+mwj3EaJHvTHKbIzCPwwmmxyfGN17T4Qb6OTl9yppcbQWFNFb3uppP
 e81y4i+FEVakK22ry8sDzC9iWpL5emCswe989CiRAjbQN91kHnZ4jKQKmOAqT9KWsEoO
 MPpQ==
X-Gm-Message-State: AOJu0Yzxudz/u0DynKVkRq+jf6l2fkyyE/MotybPbTkGhNc5ZInLNZe8
 5aAzZBq8o+s+93qlaTJKUf9Yo7CgC2CT1Z+WGFM4p9bohVYb6Cx4cbEf2cIaVuk=
X-Google-Smtp-Source: AGHT+IHYTk7ZZo4haXqygO1kfeZRbkaGl0ZQH8llpEgQ+h+K+JgRZ20eVntorQX+MsB5pPdkYvAnnA==
X-Received: by 2002:a17:907:6016:b0:a59:af54:1651 with SMTP id
 a640c23a62f3a-a62281646d9mr158210366b.57.1716403191600; 
 Wed, 22 May 2024 11:39:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4ddc:8210:4043:e30f?
 ([2a01:e0a:3cb:7bb0:4ddc:8210:4043:e30f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b015ecsm1838373466b.177.2024.05.22.11.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 11:39:51 -0700 (PDT)
Message-ID: <71414bd6-680e-4d54-841a-29cbd36c8477@linaro.org>
Date: Wed, 22 May 2024 20:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] test: dm: dsa, eth: disable tests when
 CONFIG_NET_LWIP=y
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
 <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
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



On 5/22/24 20:07, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Wed, 22 May 2024 at 19:04, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Some sandbox tests make strong assumptions on how the network stack is
>> implemented. For example, the ping tests assume that ARP resolution
>> occurs upon sending out the ICMP packet. This is not always the case
>> with the lwIP stack which can cache ARP information.
>> Therefore, disable these tests when CONFIG_NET_LWIP is enabled.
> 
> Is the ARP Caching the only issue?

No, but I don't recall exactly what was wrong in addition to that.

> U-Boot isn't supposed to use the network stack that much, so it might
> be a better idea to disable arp-caching in LWIP (assuming it's
> doable). We might even get a few size of bytes back

If ARP_TABLE_SIZE is 0, there is no caching but in addition to that the
lwIP stack does not work well. For example when requested to send an
ICMP packet to an unknown IP (unknown as in "not yet resolved at the
ethernet level" i.e., ARP) and assuming ARP_TABLE_SIZE is 1, it will
automatically do the ARP request/response then proceed with ICMP send.
However if ARP_TABLE_SIZE is 0, only the ARP resolution occurs and the
ICMP packet won't go out. So I am not sure that 0 is a valid value.

> 
> Cheers
> /Ilias
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/dm/dsa.c | 2 ++
>>  test/dm/eth.c | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/test/dm/dsa.c b/test/dm/dsa.c
>> index c857106eaf..147e2a4afe 100644
>> --- a/test/dm/dsa.c
>> +++ b/test/dm/dsa.c
>> @@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
>>
>>  DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
>>
>> +#if !defined(CONFIG_NET_LWIP)
>>  /* This test sends ping requests with the local address through each DSA port
>>   * via the sandbox DSA master Eth.
>>   */
>> @@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
>>  }
>>
>>  DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
>> +#endif /* !defined(CONFIG_NET_LWIP) */
>> diff --git a/test/dm/eth.c b/test/dm/eth.c
>> index bb3dcc6b95..cf97b1c1ab 100644
>> --- a/test/dm/eth.c
>> +++ b/test/dm/eth.c
>> @@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_state *uts)
>>  DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
>>  #endif
>>
>> +#if !defined(CONFIG_NET_LWIP)
>>  static int dm_test_eth(struct unit_test_state *uts)
>>  {
>>         net_ping_ip = string_to_ip("1.1.2.2");
>> @@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
>>         return 0;
>>  }
>>  DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
>> +#endif /* !CONFIG_NET_LWIP */
>>
>>  /* Ensure that all addresses are loaded properly */
>>  static int dm_test_ethaddr(struct unit_test_state *uts)
>> @@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
>>  }
>>  DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
>>
>> +#if !defined(CONFIG_NET_LWIP)
>>  /* The asserts include a return on fail; cleanup in the caller */
>>  static int _dm_test_eth_rotate1(struct unit_test_state *uts)
>>  {
>> @@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
>>  }
>>
>>  DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
>> +#endif /* !CONFIG_NET_LWIP */
>>
>>  #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
>>
>> --
>> 2.40.1
>>
