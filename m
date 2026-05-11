Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21646CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE118845E3;
	Mon, 11 May 2026 23:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KWCoboN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9635C84653; Mon, 11 May 2026 23:48:08 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591A4800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso4003438a34.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778536085; x=1779140885;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=brtwnSJcu+ZBEdNKg31QHWnS9n7qMw6pzMhCnWqRnHM=;
 b=KWCoboN+mGEySRMWAIOOrETy3MBYvhxu3PZ4KHYy1g6S3HHvWMohkm1fqiL2F/J3XF
 CkJO+I/eKjxJIFFGm+IfLA01EzjJVbEu90zapf95uqor7UzPMvy80/yzFlOAyl9ulOQg
 jODUFSgU9WpaY+Afoyko7oo1AUH7v/eDXWc0oA3SquDK3ZLvb2cbuJK1MburWCj1chEs
 vXYeJn24v7MX3oB/qfdm3dZokmQk4SghHUF6zd1PsoPzNwYdhMdK7cYywDZ3JxHCWyY3
 YqJnJZKA85jZ2L/RyTgmbYj48eULXN5zplAL6VXxlDI5RSZqXeMUnlpn3kiUahe/Dm6+
 R0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778536085; x=1779140885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=brtwnSJcu+ZBEdNKg31QHWnS9n7qMw6pzMhCnWqRnHM=;
 b=bKYVsdD/o5d6twbID6fFbM2mEKTNjj/zIjfcnZCFJq6qh57sDB+xwkXUwiw+M3pcfY
 XwTsJDzC1Ba+oOXBlqDfzXPF76HVOzvOkmCILXJIaN7UwxgxXn4x8kFKb+SUS54XHiyx
 arcTGOeBQTAErzBIMN9NOoii5aEEDv1/bG/8z+g5bs9gqpa3eo0MquohDcosSZdOmI0I
 h19kG+Hv7o+LQGh35sPuv/ov80bvgmxPEVtVpY26J4azTPJFbJsF2ne/EcExORI06Hfv
 idF+sBnnLHYyhenXlL9c5B3KS5x7gy9UGWAH8iYNBmO85wkk9TfOLGFklQ87y1xpT3GM
 xWcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PCPsxjZZdRIKFIx8K9Ng8K6Fpuu/MJc2zVyEMc4YF9tn6lctWVcpuJYY9FyaqFxHRgmJjUME=@lists.denx.de
X-Gm-Message-State: AOJu0YxcrxUEqPxhbvicJR2tvCagPj2O8pKzl/6tX7npjY5ElAOE+zc3
 dI4y+nBmcWhMoPwuDFo0HgnJnTY0dBgPi8nIiWCjC2lVEAQXe81wXk7W6OR0Pkpnu3g=
X-Gm-Gg: Acq92OFtCG0iwM4O8hHQ52+E2k3GxalHwtBVObKpYcf2SkydBqiDFF5zSt0nOHYf/Da
 bJRnKdoN4TJ1qQrmIi/Qhfhk9IQDsgySHmYJC3nf/0LM/4zxfhdOxOk0neMxnOQHHbU+IhoHtSS
 cKRGQqmqdirAuxkvJjXCrpb8PzwR4y2QLqcOdh3DempLLTlor5NHM9m9JAGmqldq53Tlr3Xm313
 d2zZNZNHUWE8IefJg1u4Y8RYY8ajWO79kixQ3vLahXYj1W0YlHkMUjkVduQGEahOYH2Aj32uhYJ
 mWbgwTGB/m+hrVbvpamhCW5wPrwWuG0msDACFJBPB4LrkUsy6y0sHP4F2wD+Ax7Znf+O/AUddeU
 BbEipG2Nr2Z4vG9SXdi7vq3F4XgJVsAcrvKUhp5e6yBY/PTBAdC98SyzphN7Fj3bbDmN5JXAcFr
 XbitCZZa3lUApgahasWxmVwJsYe5/d7StGBGJpEoD88Y38dbeAz+/QmavwaB7xYJz9B9bFBVQhj
 CYBy2E7CA==
X-Received: by 2002:a05:6820:2214:b0:68a:116a:a5e5 with SMTP id
 006d021491bc7-69b25cd17b9mr9293232eaf.44.1778536084995; 
 Mon, 11 May 2026 14:48:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:591:4577:3439:3a1e?
 ([2600:8803:e7e4:500:591:4577:3439:3a1e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1ba56sm6590140eaf.3.2026.05.11.14.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 14:48:04 -0700 (PDT)
Message-ID: <c92efcca-0b81-4b67-a628-0ee93da6862c@baylibre.com>
Date: Mon, 11 May 2026 16:48:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
References: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
 <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
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

On 5/11/26 1:08 PM, Simon Glass wrote:
> Hi David,
> 
> On 2026-05-09T17:36:26, David Lechner <dlechner@baylibre.com> wrote:
>> net: lwip: introduce net_lwip_eth_stop() function
>>
>> Add a introduce net_lwip_eth_stop() function and use that to stop the
>> network interface after each command that uses the network.
>>
>> This makes the behavior the same as the legacy net code and avoids
>> potential issues with the network interface being left in an active
>> state after a command finishes.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> cmd/lwip/ping.c     | 10 ++++++++--
>>  cmd/lwip/sntp.c     | 10 ++++++++--
>>  include/net-lwip.h  |  1 +
>>  net/lwip/dhcp.c     | 15 +++++++++++----
>>  net/lwip/dns.c      |  6 +++++-
>>  net/lwip/net-lwip.c |  6 +++++-
>>  net/lwip/nfs.c      |  4 ++++
>>  net/lwip/tftp.c     |  4 ++++
>>  net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
>>  9 files changed, 68 insertions(+), 22 deletions(-)
> 
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> @@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>>       struct udevice *udev;
>>       struct netif *netif;
>>       struct wget_ctx ctx;
>> +     int ret = CMD_RET_USAGE;
>>       char *path;
>>       bool is_https;
> 
> Initialising ret to CMD_RET_USAGE changes error paths:
> 
>    netif = net_lwip_new_netif(udev);
>    if (!netif)
>         goto out_stop;          /* ret is still CMD_RET_USAGE */
> 
>    if (!tls_allocator.arg) {
>         log_err(...);
>         goto out_remove_netif;  /* ret is still CMD_RET_USAGE */
>    }
> 
> The fall-through after 'Certificate verification failed' also lands on
> out_remove_netif with ret unchanged. These paths previously returned
> -1; now they return CMD_RET_USAGE (1), so the command framework prints
> usage for a network/TLS failure.

The code I am looking at says:

enum command_ret_t {
	CMD_RET_SUCCESS,	/* 0 = Success */
	CMD_RET_FAILURE,	/* 1 = Failure */
	CMD_RET_USAGE = -1,	/* Failure, please report 'usage' error */
}; 

So I don't think these changed. CMD_RET_USAGE is -1.

Happy to init it -1 though as you suggest if the name doesn't make
sense here. That is might be why it was -1 before instead of using
the macro anyway.

> 
> wget_do_request() isn't a command handler either, so CMD_RET_USAGE is
> doubly out of place. Please initialise ret to -1 and set ret =
> CMD_RET_FAILURE explicitly only in the paths that previously returned
> that.
> 
> It might make sense to split this up function (perhaps in a prior
> patch) to try to make the error handling easier?
> 
Sure. Is there a common naming pattern for that in U-Boot. I would
call the inner function __wget_do_request(). But I know opinions on
such things can vary widely. :-)
