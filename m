Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4E0C021A1
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 15:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D788B88A30;
	Sat, 14 Sep 2024 17:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m3De782d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F0088ABF; Sat, 14 Sep 2024 17:08:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8028889E2
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 17:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726326532; x=1726931332; i=xypron.glpk@gmx.de;
 bh=/4GJNsO4UlK1NkhkNgRsxnklM+gad9tm2ab1xZLoU8E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m3De782dBSPRTMjTj2i97UZXu3kImhpUlE4ep7w80gesxTHn6ksA2DzdIv5ZNgLn
 9zUeVs1+7L3cix4cDmvOqgeJjn6EHoT42vYWG930Gdhw9AD8KjqZXj0qFmo+FtvaY
 TWyZQmtFQpO7mbyuUOQsTEsW+R0/qdYkspg5g3Sj2PUkVszdu9UuVSt9jIagIeixt
 PC1ep7cGRW/qztx+AimKMjMZQflv8/LN/7fJAS82CCylJisdX/sx37zrSsxkTiSBe
 djL9XHUI471E5/jGkc10YOx1hnz3wp7ohWpyQryHM7XdNha/M7jrRtJTsrQ/Uf8vy
 EnLuuHQeLbPIJiDzEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1s4h4M3DBO-0164dy; Sat, 14
 Sep 2024 17:08:52 +0200
Message-ID: <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
Date: Sat, 14 Sep 2024 17:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rhyLlHuWAXx0rZQI5suo0pBOlVbKPf8bLeyK/ZV/rJkjf5sr10l
 4ftBSzT3C7dTlEK6Miw/2pILHoWINyDSDIP+hRhfMQAYBaKmXrG5TrXemwdD8tTfbgXnBQc
 N3uQel9dnAUH81yO/ojBfC/kZMc5H6QyAB/nGrZQBhfZyo2OfVyIJkvWTKbaFN6uIRcNcCa
 srdlk1CfqWbOAOb0NfegA==
UI-OutboundReport: notjunk:1;M01:P0:svhAelkeeiQ=;psuyPD+D5BLGVkS16ngkKfZvXNu
 Lg8vfxEGxmqp/wh6g+m+JTNrKKw81BcWcSt3Br95G/0+uQw5VL74BiW1hewmNeT0Ny1OHwApy
 q/BALeiEF3lKYCY617j4HAuUBXIZb2E6HosoPAHjmzUgvo1IoQb87rjyAozZN+bVUzXr50NCN
 xYklf+2Mg5xBp8JlF1PXirwcA/ywrbKu4uq83d8HfB9czrsNpb8Hyx+pKvrtff7k5YpksZnnI
 jnSFGwP4bwuJkSXc4eGBbJpWD+wtaDt3aJ5sRcx30a+49Zq82LCzWe2lQ/3hqTeiVnZyBpbl1
 atziPaEhH6NrJd3qAOPdyy6uRKilTS/BYkJOR9wZlDimT8JbeqZlyp2ni/WOloZcIfPEbhIo5
 cmhuBrtcXvaWHaPH1rkYEZIIzlnCYaaVFXVa0qvIxBE1cJ6hDvyn2Ok47/3wHoksJhQVBL6Jn
 IKcdfMfXcqflzuQPywMHNJv2gD1VHWFyC4JJmKvJ4RT69WX5w+GDdj3EWNc1Nq3AmaZL5yX+g
 Tncv7d28nRlJzNh/PE6cHm3TaxEJm/RU/f/6YZPMKiQKZklc7K8it2NrfUgJDaNSbpy8+PZQn
 LLCUjO941oLGx3GQEeogQDIIagLTLZOjB1/Ac2qbtKNbcu5Wd+9imkWjd5aIjJ8lWHhhDC/u8
 yPtEaAbjcdi38K/Hi8pqf8j7VYFiYFhBHZWMrRdj7otVxnkcpAaZ4ZTA3NnSsWxlSb/I/Z2nx
 005I9BhSjIEwGS+i1N6+KwHlv4H58vgbmPaH3WJN0+Oyh3ZqtzBPWR7ih2lgMrUm+uHCengyw
 YWn9bd2czPDz89y/nQrRGmEA==
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

On 9/5/24 10:27, Sughosh Ganu wrote:
> Add an event which would be used for notifying changes in the
> LMB modules' memory map. This is to be used for having a
> synchronous view of the memory that is currently in use, and that is
> available for allocations.

The synchronous view problem only exists because we are duplicating
data. Store the EFI memory type in LMB and the problem vanishes.

The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.

Best regards

Heinrich

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   common/event.c  |  2 ++
>   include/event.h | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/common/event.c b/common/event.c
> index dda569d447..fc8002603c 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -48,6 +48,8 @@ const char *const type_name[] =3D {
>
>   	/* main loop events */
>   	"main_loop",
> +
> +	"lmb_map_update",
>   };
>
>   _Static_assert(ARRAY_SIZE(type_name) =3D=3D EVT_COUNT, "event type_nam=
e size");
> diff --git a/include/event.h b/include/event.h
> index fb353ad623..fce7e96170 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -153,6 +153,14 @@ enum event_t {
>   	 */
>   	EVT_MAIN_LOOP,
>
> +	/**
> +	 * @EVT_LMB_MAP_UPDATE:
> +	 * This event is triggered on an update to the LMB reserved memory
> +	 * region. This can be used to notify about any LMB memory allocation
> +	 * or freeing of memory having occurred.
> +	 */
> +	EVT_LMB_MAP_UPDATE,
> +
>   	/**
>   	 * @EVT_COUNT:
>   	 * This constants holds the maximum event number + 1 and is used when
> @@ -203,6 +211,12 @@ union event_data {
>   		oftree tree;
>   		struct bootm_headers *images;
>   	} ft_fixup;
> +
> +	struct event_lmb_map_update {
> +		u64 base;
> +		u64 size;
> +		u8 op;
> +	} lmb_map;
>   };
>
>   /**

