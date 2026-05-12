Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1851BCD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDAB838BB;
	Tue, 12 May 2026 16:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jiQ3yCTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DAD83CD3; Tue, 12 May 2026 16:56:02 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F23836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-47bdee5bfc4so3864219b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778597759; x=1779202559;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VXyNLbeRFhqrb8ayEQuTXstvky5Yiyh5MOAreDTF6W4=;
 b=jiQ3yCTU/0g25q3a53vOtDb5c9snCs6ihcfJTgQUWM5p8861Yc0vz4O9UtoL70HM0C
 6VvWdaOPQNNInNkjMszmjBO2TzlT6mhNNV2Hy1cCMc6CPRAinQHvejTVgmxZ/Z5OSZ3w
 cR3Cl0RQeqq9CTf9aRF+MVaKKKXCwsgLO+OiwE0ja56edzyiI1u0JBVKufvOHzS1gwxn
 8SU7BKczXCFmZT2s6IpoEVERoNit81u/p/1XXS7XjK/crTzSgR17i16AWGC1OJpx2Bxn
 QGHWeVMBCunA33csBzKdXY9sUjQ3u2g7XBJzBCv6d0P5zCjZWf2aLUi0ow19aQtVfJq8
 7Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597759; x=1779202559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VXyNLbeRFhqrb8ayEQuTXstvky5Yiyh5MOAreDTF6W4=;
 b=FOmKKlezOkDOD8zsib6xBaE5orKqhLZurpKXJRbGPikqmMlss0L/sxwIlvNvo4XIYK
 XoP2qqS0xRuawI/wxZq6JulFE6uIG/PIdpVtG2R43QoZQ2Ht9M3NDlk2hkbyHJ0ERBXZ
 9A1MZvfeKqvuyODLDHvpf9GmTMx7f4SHd7PHpwis+6sNhC1iS4P+eLLXr9AbV1XqqU2M
 jH1YFhRSoAbcEORKoEgEG1063pOzTfzAkJnaopCBznouL1KR3op2CvF7w0OS1AnKlgIw
 jqIZkTJEALJzryskLJ7OH8kanqEkIIj4OwioG3DFVdT0l0HMJ/tNZEQH1B5Vlmr6Yqpy
 e7Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jXMuOnWFi1Tqg+WJsu1WsVDlfrTxAetvq39/LSHCqwAZ5/WIDHdnowypw9jdKCHIrtu4OBTM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9jiktYp/fHkBrt8ZTdQLc9iw9j6QP6IHeGPpprhFG61oF/v2p
 wVrvU3VKztamJZ4EpOPbvEeDvzkrqPPrQsEGSLibO4ApD8p6xU72FGYUrhN0yY41JIs=
X-Gm-Gg: Acq92OEaaMTXt9hPOla8rGyAzRHRX/N3T79SgsosoTfeWYX/bFu4LwtICkypqUCRNYD
 yCDsjXboT2/u2oSFDZ6eawrTpaKczy97GVz+HFB9htRtqCeQd/2apWr+ZksvBW3s57DSdAVOnAo
 KmiNoR6gBwqTRxhWM1kfTFncsxXroZDmpIsx3kzLXWXzTqWYGTeWoXsh2A+3ZxS3zZfj1sHo+D3
 PZDXgpnftsodsDo0OrZvO5hGbaXgTC/2Mha0O3QGso9e6zpPa88EeRzJ8zLx/uwptM3TykeplNK
 F+6r8VKJ0Psi5X+17WrzCRJVrRHJdu3ShIxO0YDV8TcAVHrAw3TXRxenZIeWViGKg44N0XygtFn
 YvtmCL59Xc6U9KkGkbur9fI56mU78HB/xh0I/9M6SlKFxHg+eOkOB1XETFQPk4z685t2MHJp/gQ
 nQCOjc29ClI45Zq93Rgs+MkK5+9LlB2fUsfefye5Yjlwu7jiOjNc73VxnLBZRO8jlWUjZ3EbiJr
 A==
X-Received: by 2002:a54:438b:0:b0:479:dadd:5326 with SMTP id
 5614622812f47-48293d1159emr1791279b6e.22.1778597758815; 
 Tue, 12 May 2026 07:55:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457?
 ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76936271sm22391006b6e.9.2026.05.12.07.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 07:55:58 -0700 (PDT)
Message-ID: <d6649879-a372-4be5-9b65-933896916ac8@baylibre.com>
Date: Tue, 12 May 2026 09:55:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
To: Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
 <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
 <c92efcca-0b81-4b67-a628-0ee93da6862c@baylibre.com>
 <CAFLszTj1y0=N2=PqW75q3-_3E88XLArDUPfVDOH9X_Zky6NQTA@mail.gmail.com>
 <15d24b12-a5c1-4d10-905c-c28d8c3fcb23@arm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <15d24b12-a5c1-4d10-905c-c28d8c3fcb23@arm.com>
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

On 5/12/26 9:36 AM, Jerome Forissier wrote:
> 
> 
> On 12/05/2026 13:41, Simon Glass wrote:
>> Hi David,
>>
>> On Mon, 11 May 2026 at 15:48, David Lechner <dlechner@baylibre.com> wrote:
>>>
>>> On 5/11/26 1:08 PM, Simon Glass wrote:
>>>> Hi David,
>>>>
>>>> On 2026-05-09T17:36:26, David Lechner <dlechner@baylibre.com> wrote:
>>>>> net: lwip: introduce net_lwip_eth_stop() function
>>>>>
>>>>> Add a introduce net_lwip_eth_stop() function and use that to stop the
>>>>> network interface after each command that uses the network.
>>>>>
>>>>> This makes the behavior the same as the legacy net code and avoids
>>>>> potential issues with the network interface being left in an active
>>>>> state after a command finishes.
>>>>>
>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>
>>>>> cmd/lwip/ping.c     | 10 ++++++++--
>>>>>  cmd/lwip/sntp.c     | 10 ++++++++--
>>>>>  include/net-lwip.h  |  1 +
>>>>>  net/lwip/dhcp.c     | 15 +++++++++++----
>>>>>  net/lwip/dns.c      |  6 +++++-
>>>>>  net/lwip/net-lwip.c |  6 +++++-
>>>>>  net/lwip/nfs.c      |  4 ++++
>>>>>  net/lwip/tftp.c     |  4 ++++
>>>>>  net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
>>>>>  9 files changed, 68 insertions(+), 22 deletions(-)
>>>>
>>>>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>>>>> @@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>>>>>       struct udevice *udev;
>>>>>       struct netif *netif;
>>>>>       struct wget_ctx ctx;
>>>>> +     int ret = CMD_RET_USAGE;
>>>>>       char *path;
>>>>>       bool is_https;
>>>>
>>>> Initialising ret to CMD_RET_USAGE changes error paths:
>>>>
>>>>    netif = net_lwip_new_netif(udev);
>>>>    if (!netif)
>>>>         goto out_stop;          /* ret is still CMD_RET_USAGE */
>>>>
>>>>    if (!tls_allocator.arg) {
>>>>         log_err(...);
>>>>         goto out_remove_netif;  /* ret is still CMD_RET_USAGE */
>>>>    }
>>>>
>>>> The fall-through after 'Certificate verification failed' also lands on
>>>> out_remove_netif with ret unchanged. These paths previously returned
>>>> -1; now they return CMD_RET_USAGE (1), so the command framework prints
>>>> usage for a network/TLS failure.
>>>
>>> The code I am looking at says:
>>>
>>> enum command_ret_t {
>>>         CMD_RET_SUCCESS,        /* 0 = Success */
>>>         CMD_RET_FAILURE,        /* 1 = Failure */
>>>         CMD_RET_USAGE = -1,     /* Failure, please report 'usage' error */
>>> };
>>>
>>> So I don't think these changed. CMD_RET_USAGE is -1.
>>>
>>> Happy to init it -1 though as you suggest if the name doesn't make
>>> sense here. That is might be why it was -1 before instead of using
>>> the macro anyway.
>>
>> Ah yes I missed that this is a pre-existing bug. We should return
>> usage only when parsing is wrong, not when something fails.
> 
> +1
>  
>> So what you have here is fine and actually makes the bug more obvious
>> in the code, which is good.
> 
> Yeah :)
>  
>> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
> 
> Thanks,

I have prepared a revision that splits this into two functions so
the -1 is left untouched.

If I am understanding correctly, it sounds like I should add another
patch to make the return values of wget_do_request() consistent.

The docs for this function says:

 * Return:	zero on success, negative if failed

And there is one existing caller checking err < 0 (efi_bootmgr.c).
So I plan to replace all `return CMD_RET_FAILURE` with `return -1`.
Unless we should return errno codes?
