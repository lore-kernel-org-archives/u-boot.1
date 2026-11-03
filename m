Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709C606A32F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TIEVNhmg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=O3S5Y+YI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CEEB605FA;
	Tue,  3 Nov 2026 23:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GSVHkyfx7zW; Tue,  3 Nov 2026 23:52:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBF746069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793749954;
	b=LgELAkPoj8hRFw8643111VhvxIzWq4ddDPez3KyCJ4pl7aY7pbZ5FYdfqwVR5G1GbGiO
	 5jwWMbLjUbcg9LzAF211X9AQGttIlUcAu5Wcxjt5VelhFafPmeGPbgrdsvQ6gbzBHjJTq
	 +VR70OymXW/mt2p8TvwSJSQusW+Yx4mSpzzCQuHN8oSQ7sT6sUWNiWTugwYPNQ/FAshBU
	 ik0pQ7OiX6piY8KFRR70gltlHch8gtpT7/ym1Iexre054rWxbkjGvAJMrcLnSndzz4him
	 PYGJWrBOGBqZ1nCm4zx/Y49wVAbMd8ZG9PqzTrzUkCjo363AanfanMzCpsm5gR1ScAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793749954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GC46bHIGBTL3jk2SCHuWRItAph3VBWK5kwzfmSDbSfM=;
	b=LEGCrwa17uGJy41+GF+HTYRGVNYk98ML7vvIGNksNKlwT1ZDUTSl7J6BtlAhf9vkRMw8
	 xA4UL1dfJWM2uQZNwYGo/MnVs33kjwh9ItsYkMOtRXzT+TSo+hrPIepXro4HPGgyAkFVN
	 ZTESYJcpZGXdnYqKaL+Mc3PuzJjRArXgMnFDmrct+JhXx2gVZ/Ye717D2Eit4tR/GK3+k
	 qlh11Ni6TCo464Ghshx2UiOvlbo3gNE3/x1dVkjU2ZHyI1ZRlo9IHr8PZ/uVKv72X4SvJ
	 Faa4H8/NRBDwXsAduyQ9R7Pg5VaiyW0xAwPf9OVK7LCj+1u3AKtw8SP1Na1F9XpDHIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793749954;
	bh=GC46bHIGBTL3jk2SCHuWRItAph3VBWK5kwzfmSDbSfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TIEVNhmgnAHogzfGXPOewurAp8Sq7sOhIHdfy8toWz+DYDXQIquKFOrnSCFJCmOse
	 z7N/d5Jl2CpCC3ofDtf9+S3JNMw2+JSzcdUIEtec0epOO12eLU9fTUZLSI3FxOFsm7
	 8tBH3md2AvfKUZXNn+m7kle9LRLMO8SG8wcJ9eEN6reS7gt6StdgthnTl8EfCkQ0lK
	 zhOKsXZZ5+/UeZzYQDIixnDCdz3F0R40EPyDW9N21AId/UFyCeNPjyhHfGqArIvJw8
	 MrnlcUDvj6JEQC9601PUWRlvzK8C6+FLLkhirz3fVT5/azRithjLOE3QZyzF9lNLN/
	 lXesdI0+n+yAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBF746069F;
	Tue,  3 Nov 2026 23:52:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFBD5784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 23:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0CB0405CF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 23:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_eFOsy_bLL8 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 23:52:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCECE403EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793749952;
 b=B2bVgWwFlRqFetyrKAloLAZQhQAnsD0foBE42/qDmTHxHBzCaWosm5ty55Pa7XiW5edR
 lTtfKOtC2zBoYOgexN6csqOXqMr6Xva/4wOIceII78ZLwFPYsnuujlIo/fU1yPxs4II/9
 1IM5gEKXlZPgebEmyvyVXmrjXokiEtvKoa6LiuIU3o9zBTNbs+x78MgqQw44ncaKxV5D4
 oPVIq6bGlNAwfdm1p7iVCFhHFhGUPJDbJl9kUBdQAbZiZuwKhyXGjDTkHEhpraDm73H8H
 r6K0f6wfoHsVGx8Ex2IR/+SMsITkPiwXMlgtOzETwhznaogH/Qt69lR2lU10yrtKmsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793749952;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=GC46bHIGBTL3jk2SCHuWRItAph3VBWK5kwzfmSDbSfM=;
 b=XbxVnjUJFyNbikTTxiIrCdV7oONEFroLmxHoIv7cg2Ev9D9cflMkJOjPP/5eFAexJTiw
 4d1xfBPhuhHmnW6jAlk1PuDpjBeERB1RmpVEiKeiGME3C7al5BTYIrSppgX8omfXfwd4D
 6NPnpmoOaMAs8rP0/oMMNghovz2OGM0rQU1sSuxte+Xj5OqadMvGPC6O/ofc1LkzSoggK
 Es+MAeoA9cBNv989UGa0qun+DrX2wTM6+Xr3LLYPtvLPJ3xqrgf2yng1weBhkqVP1nMfU
 wg+E+HUdj1Ox6QlO1fHPSYccp2R9W7QU7QnHGsFeE64oQd9e/xBLgQ48etnaoI5OSEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=O3S5Y+YI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O3S5Y+YI
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCECE403EE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 23:52:31 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-703be215729so48864eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 15:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793749950; x=1794354750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GC46bHIGBTL3jk2SCHuWRItAph3VBWK5kwzfmSDbSfM=;
 b=O3S5Y+YIPIZXK+1T2Eh40Vga6ps3lRSFFV+XP3wL4bbNXGzb4KRnsKuUJoHGS77dVI
 c6rGD/ITouYUnFmRns2HW2Gc6aA08De5gAe1WlHIsIPhtpjlLF9IJGfk3oIG22aOpCQM
 l5Av+N2ijpocCwnqIcd1sbMnsCEMQ4sDettV/2J/juBZGsK2vAQY2OBk+jR2zssmOvnh
 t6Wam+3ruDMizTMY/Wgs/D24uv5QPhOtCRejrpYVyndNiR7E/Bu8DMvSyBvncaam4C7k
 eWig//OCbyiY2AZpleA83dgt3IHfNLEBLXEyDEiMLe5G7M5l90kEtcxs0NKMTKuZmbPV
 cb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793749950; x=1794354750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GC46bHIGBTL3jk2SCHuWRItAph3VBWK5kwzfmSDbSfM=;
 b=rmDPAlK7zeH9MKNrrGgb07Rm9O4YXQejXt+WQQ7pRLtAPC4Mj3XDQADcszCpuBJRSa
 NlojaDGjeZHVHZkhv960hm5fYHGaL0n4wdXZgEfs8TE685JGCDz8KEcxUhSv1guqy6/4
 L7INGo15xyT95Z/oXWRQgs71iQLycCy10foDqYZ9Foh0zVEEwJj6D1ahzDlY/XZXICOv
 zTbhdwmYQcyuvGAxMTCwcx7gyn96gP0UVz9VBofVLFpQrDBokqck3KnD4f/0rDjhFfqd
 izvTXbLEicYNk2P3L52E3nOxtYdQYdobhcXnGggIVQO8W+i1V4+eUW/qEorz0HhFJVYk
 HtHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb69LeuTKz30TPiAmt5tMFbZGyiRiYMOsTC51xewDScjRIjIgAN355FAm2BOXlwCg+NcSq/qY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9AGkxS+ll/oKVHn7YPTCAC35/ivE38Hrg3d6lIuGfsD3sAm0T2
 8t30bvkeTrzl/UvbzActfERtlkphj84UeVqAftzw6kDh8BHeYdQZtEhp/QXkD0f7UIw=
X-Gm-Gg: AYBFou2OgXI6FR1AVILsITEkPzCy+LxdqxfQ1YysE1pqEmtBJaCVuU10XQwU5TiB/Ub
 3mDrqqC5C3+/7a+ke9Sp95KRcUHobBhAKbOgRhLa+HrWAQVUgjDSc8L/l3rcTzgP2BuHpVQrwb3
 X1lQaWIevS80Wh0zvi7M7srLpfsiUOtHoyg1oP6tHMBY6JdYphGGh2nfrHrourmvKQTaXd2WiVC
 cd24BDCEDz5z29nA2TtZOpExC2LuamCGj2pjiIk4KX+4GpfocGtiGAZKztHWlvDp4lXGF7BKTe+
 GpVpXEW7RGfCulztQcgnai4LAfIRD/lvqelt/zCUKqy4NJI3s3mcEogAkVYqmET4MUvhoRyo8j1
 /D9Dqb3yCD4NPw0L0py7XhumO7BZY66w+9Z3+gO+pCpckwgEHMSxDZjoDNnPsa9plRAHFYsNFoJ
 HRVq6L7gdi9e8soRdOH5pLeqj1vdEzxYVUQ5jeThhq8Du8A9TVUKuDqJR+acT5vaTen/GxBPvdt
 i6WD+aJRzD3m0FNhgvfURrY9Fqkfs4vzpoh++iAT7l+Pm9JA+2grJPIwGSe/AAZz9khGpiC84+v
 kI4/tKAKLisg29czN0nYPE0oyly3XEjMsqUoRHhhxvVfNi+j87Fg3XiNKKCDYc9XdrCw9T/tUBL
 F9/lEJSOPKFaCkX8DlnDz
X-Received: by 2002:a05:6820:1c84:b0:6d7:9e0f:3336 with SMTP id
 006d021491bc7-714f24e84aemr7898249eaf.1.1793749950124; 
 Tue, 03 Nov 2026 15:52:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d5c1:c80:22dd:8a48?
 ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3eb127asm540135a34.24.2026.11.03.15.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 15:52:29 -0800 (PST)
Message-ID: <58235652-b968-4ee1-8eeb-af881c89e25f@baylibre.com>
Date: Tue, 3 Nov 2026 17:52:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spl: atf: pass the bloblist to BL33 in registers
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-4-bbbbb7e65fdd@baylibre.com>
 <20261103215700.GE785819@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261103215700.GE785819@bill-the-cat>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 3:57 PM, Tom Rini wrote:
> On Tue, Nov 03, 2026 at 03:26:03PM -0600, David Lechner wrote:
> 
>> Make SPL_BLOBLIST_PASS_REGS also pass the bloblist to BL33, which is
>> normally U-Boot proper, when SPL starts it through BL31. Fill in the BL33
>> entry point arguments that SPL gives to BL31 with the register
>> conventions of the Firmware Handoff spec instead of the primary CPU MPID.
>> BL31 passes these on to BL33 unchanged.
>>
>> Without this, the only way for BL33 to find the SPL bloblist is a fixed
>> address in memory.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  common/Kconfig       |  8 +++++++-
>>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
>>  2 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/common/Kconfig b/common/Kconfig
>> index 02eecdb5c98..2ac885d31e1 100644
>> --- a/common/Kconfig
>> +++ b/common/Kconfig
>> @@ -1243,7 +1243,13 @@ config SPL_BLOBLIST_PASS_REGS
>>  	  specification. The next phase then finds the bloblist without relying
>>  	  on a fixed address in memory.
>>  
>> -	  This only affects the default jump_to_image() implementation.
>> +	  When SPL starts BL31 (SPL_ATF), the registers are passed to BL33
>> +	  through its entry point arguments instead of the primary CPU MPID,
>> +	  and BL31 must pass them on unchanged.
>> +
>> +	  This only affects the default jump_to_image(),
>> +	  bl2_plat_get_bl31_params() and bl2_plat_get_bl31_params_v2()
>> +	  implementations.
> 
> So that's what I get for replying in order, oops. But is there some way
> to handle what the TF-A case needs, while having a more generic "prepare
> the bloblist" as I was asking about in the previous email? Thanks.
> 

Sure. I think we could move the xferlist_to_boot_arg() call to board_init_r()
like you expected and set a flag there.

Then the default jump_to_image() or ATF code path could read that flag and
set the appropriate registers/args just before jumping.

