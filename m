Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B14AC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8004380569;
	Mon, 28 Aug 2023 12:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tXJIc3CJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0339A86420; Mon, 28 Aug 2023 12:57:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FB5803AC
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693220244; x=1693825044; i=xypron.glpk@gmx.de;
 bh=JSfT5YmM0ldejQlnZf3sKCwbSUeEEnYwC33xg4eNsFg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tXJIc3CJZDAuXdSZwLk4rLMxhmd70HOcyZojfpEM3VAsmjVyWi7OSao5Q0/LZRIHdvQf79N
 YHA8qhBvhBrw1WJaZPdVLmWPUIN1bMshIwIhXGbo7dF+ppoGA1nj2KAVeGi8lRvn/vUoST3fy
 raVup/R2C7Lf6fOyPmQlx4lVzpMEgNZur5athpLQwTJFkYBt1FFYCqHpK3OA9EaIqq4P3t8bR
 2GCT4XIuCyOXVdSND01T/BYnOPHysAGrH2g5/XneyTZeF16r31fL8Zc3orEVk+gRZe6DWT2Er
 1qzK8TRN004x+xDAcKzO+AX+chU/SV1dXm/dK6Xs291qBlRy1G/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1qXXX43qt3-003eUQ; Mon, 28
 Aug 2023 12:57:23 +0200
Message-ID: <c149c664-7aff-43a9-8d41-f098622e1809@gmx.de>
Date: Mon, 28 Aug 2023 12:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] bootefi: Call the EVT_FT_FIXUP event handler
Content-Language: en-US
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-5-sughosh.ganu@linaro.org>
 <5c05f436-8c92-4b01-fcdf-ed9e0ec31d44@gmx.de>
 <CADg8p97io5JX85MJj0U0U0sNCiC5D8bDjioe-fGwvEpPy7AUcg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p97io5JX85MJj0U0U0sNCiC5D8bDjioe-fGwvEpPy7AUcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AggY5v5qpQz7uT2byEDqcdUKoAGoFIeakr7xafVM33fYLWhBG80
 xsMWESPpEIZB9/gGMCGtbk+bIjDT56R2GKQMLnX01dGwMTzAnqHNfQiyb92nuXWDO4wl7N+
 o5yiJ8NepLOJEg/MIvk46F+rdGZ4lB2DPk65zlq8GARlACVXjGCJQyFYnQfpBVWbdbeq+as
 BA/9n0jzXJaBf5Ye+bd9w==
UI-OutboundReport: notjunk:1;M01:P0:AJ+Rmo8VKqU=;qN91LQER1jknktW8SS06eDKaXwQ
 aQYUboKU3gsCTMHAPnkg4oyrOjzlVJWDjsBk1Fq8Oljz5F93rNQB4ccJmOo69aQlx+Op2BPJB
 +i4+uCIv34D1VS5yrSFPU7XbgxoJezjZHRxbVLzqJl+49R0lg/VHliZ6ZmE4WE4ie9bS8ZUZt
 FvW2mGCSs2wbsCQAnUXySyFFGY+m5eWkH+BI6vAQZRoF5iffiXhP7gX+hF8kbHBHD5sG4Kd59
 /UXf9uQ5vm1dywNp3hwRFuqV302NaDtCW3991d7ggpU8qlbVJjW02VQ2RVEF/2DYF5KecF/T3
 2KdOSKFNMjUUJteGkEDVbk4SUKsOp781lnTvIcTt6QviYDDym4hegx8paV7gVJYtzPlCo+6NJ
 LIMF5Ki3KG8WcU/k5oXBEGU1PscP0HK26/cHvKdqXczUpZsfRFNElffy3PQcNgKE1dOlhRrj+
 ktRWBnmwRzO6RWiKKhJ5BAiOWwot/caQjOKto0DjqEuyN5g2v37FyYMeVlr99JRw843rPMxxl
 cDEUVgmlLHu4suuIxdw0Q+mrwECtsAo3d9hTQkinmJK/S2wCIMKzKp9d1+XBi64LcaHH46Dg1
 efkItYWE2Tg3k78cVg62YUt11gW7DiDdh9eD4vHQg8XN7WVoBUZKFjHFlBFT8YG3PZnt1BAXC
 E9hNV5sivXlfkcQLE77nlOjWLo1OTPaB7X5289i3Lh2F4piYFN6jgMYGoI7vjpKGZVURqkMFd
 YkQx5DOhOTUpMeZ/OHIzFhf3u1/6CyMdtGIUOabs+eTMTBQcl1lZ7nNH/GtSomWFlyeuHf0V7
 mWRtCYCyySzxQId27x5Zz/9o6yRTxzZZl14YRIAd2Cc8PrKjJC0ZKWC3km6RQHwIwb59hOGIi
 +ScwLxGFwL9xEB8fnBVHrc7Ah2YaaQKGXjNM/lfDgK1noyDJN2DNsPrXxE9nAMsTc+4Gay5mZ
 yI3iog==
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

On 28.08.23 11:32, Sughosh Ganu wrote:
> On Sat, 26 Aug 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 8/26/23 11:06, Sughosh Ganu wrote:
>>> The bootefi command passes the devicetree to the kernel through the
>>> EFI config table. Call the event handlers for fixing the devicetree
>>> before jumping into the kernel. This removes any devicetree nodes
>>> and/or properties that are specific only to U-Boot, and are not to be
>>> passed to the OS.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>    cmd/bootefi.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
>>> index f73d6eb0e2..c359a46ec4 100644
>>> --- a/cmd/bootefi.c
>>> +++ b/cmd/bootefi.c
>>> @@ -237,6 +237,23 @@ static void *get_config_table(const efi_guid_t *g=
uid)
>>>        return NULL;
>>>    }
>>>
>>> +/**
>>> + * event_notify_dt_fixup() - call ft_fixup event
>>> + *
>>> + * @fdt:     address of the device tree to be passed to the kernel
>>> + *           through the configuration table
>>> + * Return:   None
>>> + */
>>> +static void event_notify_dt_fixup(void *fdt)
>>> +{
>>> +     int ret;
>>> +     struct event_ft_fixup fixup =3D {0};
>>> +
>>> +     fixup.tree.fdt =3D fdt;
>>> +     ret =3D event_notify(EVT_FT_FIXUP, &fixup, sizeof(fixup));
>>> +     if (ret)
>>> +             printf("Error: %d: FDT Fixup event failed\n", ret);
>>> +}
>>>    #endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
>>>
>>>    /**
>>> @@ -318,6 +335,7 @@ efi_status_t efi_install_fdt(void *fdt)
>>>        efi_carve_out_dt_rsv(fdt);
>>>
>>>        efi_try_purge_kaslr_seed(fdt);
>>> +     event_notify_dt_fixup(fdt);
>>
>> The event is already triggered in image_setup_libfdt(). Don't trigger i=
t
>> twice.
>
> The reason I put an explicit event_notify call is because the
> image_setup_libfdt() call only calls the ft_fixup handlers if the
> livetree is not active. So the fixup handlers would not be called on
> platforms that enable livetree. Although I'm not sure if livetree
> should be disabled before the ft fixup has to happen, or platforms
> that need ft fixup should not enable OF_LIVE. Disabling the livetree
> is not happening now, so I am not sure how the fixup event should work
> on platforms which have OF_LIVE enabled.

We still must not call the same event twice. We further must ensure that
our fix-up is called last (e.g. by calling it zzz_something) and not
before adding VBE nodes.

Is there any need to use the event mechanism here?

@Simon:
None of the other function calls in image_setup_libfdt() depend on
of_live_active(). I think it would be preferable to move that check into
the listeners. If instead of of_live_active() you could use a
configuration setting for the decision, gcc could eliminate a lot of code.

We definitely need better descriptions in include/event.h and a man-page
generated from that include:

EVT_NONE
     undescribed
EVT_TEST
     undescribed
EVT_DM_POST_INIT_F
     undescribed
EVT_DM_POST_INIT_R
     undescribed
EVT_DM_PRE_PROBE
     Device is about to be probed
EVT_DM_POST_PROBE
     undescribed
EVT_DM_PRE_REMOVE
     undescribed
EVT_DM_POST_REMOVE
     undescribed
EVT_MISC_INIT_F
     undescribed
EVT_FPGA_LOAD
     undescribed
EVT_FT_FIXUP
     undescribed
EVT_MAIN_LOOP
     undescribed
EVT_COUNT
     undescribed

Best regards

Heinrich
