Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ldjq8JkG;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oBZwNhLx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E885960721;
	Wed, 11 Nov 2026 08:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dN3aapLEXz1v; Wed, 11 Nov 2026 08:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A67F3606E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794384847;
	b=bny3g1ZMiGOvCANMFrlQev3J5HRTi9u2bEZJ1S3VKvJoaXGEiXosMxKV8BZewZetY8G7
	 ACGiKFexHuQ5xyYoTpgALdWKpBPxrziyJF7S9QTroU4EWOSXeRnbzOcHDYqxwJvJ04+fl
	 iPGRpFNmNur6NQdaA+jtYXqpHn3tQbhUHVc0e6bMEC/j1RM06JeXdpuvKintreXKA4elU
	 JW5H1QQn1rtdt8vy05zE+WpGBnfKMuTjz5iNU4D4bxIbgK+2QUPZWOaK446dnL8vPZRDf
	 ZpKysMw8UusA7en8KhPMT2Nn1fnG8QNzFi8n6Dhf+gV73+jsa4UYXbOkEL4k5ZPNGwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794384847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=GNN5CnkgZ8SAJBfk6yT4XOwq/h27WarH6lkb6l5bX2c=;
	b=dqZCCBrsjX7qhn2VNUDUMGIfdaSG7eu2IOVIstYPavBqF+DQpXRoJIV/+gN3HfrAH9o2
	 90AtaCo6HCB8DlQGC/5SMDj2RfI1hZNvb0WSUGQoXaDW1v6AUX0raKBjOR4iPyQfIXVnd
	 /X2kg/H9Hq37F/lTVYGtIT7V/SIjiD9E+TzJG312kjgVcd+sOwq99qISzp3IzcGGCKJ9C
	 bnwL1HKYbFhHyho1ug/aX4OZNU5JFWnmL/PsMxsO/76Hy8rNIXct8ISHrVV/ER4mBD7sX
	 SNVuApjOTtduUgnaJzkwcWOFMEwdTBU+doVp/HY5Cad7Cl8B4w1zFtB/2yxKvKMQRaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794384847;
	bh=GNN5CnkgZ8SAJBfk6yT4XOwq/h27WarH6lkb6l5bX2c=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ldjq8JkGLuFmBhahGdko6OFerxxVoqkTrvSBllZA1i0xWgEeW4ElF98gy6JwCK+ff
	 VdKyLVuyhRmak5UAsEOISxcTFT85TewmzkpnuOM8jaeiVvBKeu93//jPh989bD41zy
	 pPJRdwL/miP+7eN3QhdKBeyt0yA1GjNlpECAI7lkUpLfsDGrDhk4ivOx0JhOKG3Uyo
	 vFqFPftqz39bSTGy94UvBoVEtR9x7wyLHvNMPnu3qYX/SW/vAwSADhTCquNVwKUuTx
	 Ds0mS8AQE8/jnfBl7g652i/PVPVpvz/McFsDTR0LOMplbwVTMI+fdbTfKX0EjATVIg
	 QgKM9ElWMwPbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A67F3606E0;
	Wed, 11 Nov 2026 08:14:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C6D9DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E49E408BE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhMxkCf_c5rP for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C70DF40875
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oBZwNhLx
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C70DF40875
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:04 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so730173f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794384842; x=1794989642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNN5CnkgZ8SAJBfk6yT4XOwq/h27WarH6lkb6l5bX2c=;
 b=oBZwNhLxnZoPBMRr7P/fyvqWLcvQoFWHRn3UqgIKkJK/LH4BmPjOIwaCRsiG7nbzpe
 h2wkTkPGwO1xn0YsZEQOMm2Hv9/fWyMueu6LgoIfEdFRioWmBzEfzfTE4QOKSCaHEOZN
 mnZnOVlB+fuBv7az1KAkPY9b5Q64nE+5xm/Wn/JDgWkWuf59ITokMYq1J+q1kHQEJWYg
 +dNRiLkjQWaGdxDY57c7ea5HklYXU2Vv3sZ08uTkcjzZ5CNPyQ82YcjgEZlgu+WsGGhD
 +Y6e+Sdzv7yUdfn/Ge0XJKsyO4g9zVzVbwo4ovDoNMfK/E5nLpDr1LLAd66eWQiUz7mx
 Mttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384842; x=1794989642;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNN5CnkgZ8SAJBfk6yT4XOwq/h27WarH6lkb6l5bX2c=;
 b=iHc05pkru25paFTUhKCIO5PMTn/jtR4CZkTC8FCMxI/uOKDY/8fwcIJGSV2CatKiHu
 p9cqaAYCygpk03RW/gZDYQ42vtYTWIgQ0UEe+Dn6pOZoMdYspm8kUFamdaoRWA2WZzA3
 uWDBOoiC9Romi9jj8tJucPVCajmrUz5iSRl+t5cDBvpc0n75d9V5+GqHzynF88mUvtBJ
 Y5jYJjspvHK1BydYeEQ4oREFeEX2D/uEoT8h3+m86MGPTX6RJuB5syeCbETbZNx0sEST
 5Cul8QPb3MHGJ9ULaEGNBm20APxNctPkvSZNzTFPkVNkZpGVkwf4W/rIs1Ne9WGfbYim
 O2+w==
X-Gm-Message-State: APuU4Z90fA+bNf7znKZB3FqhTg2I2fOTDg96tsMmn4lRCBkUUiPUOMtc
 Q0Hn5cX8RR48MNDXAM3bOxn7ZhczyJGN+R9bSH5jC5tGI6KFslbvruSdCI6dgvpF/PINv5TkRcj
 3mFZB
X-Gm-Gg: AYBFou0+2WFbsOd4+6tF4btBW3rNy0Dovw4kw1cUbogpS2Nc0W3oRxCnzI9lwtNOjNZ
 PoDQW3U9YGSxDexdQ014L3weBSEHfk8XOsbEnKoWYnBn6GiBUWuO/7hRec3+YTxZnh21Q1mNr04
 etnSISvrBfkquHoYuyXgpttv6Mk79GEpX6di0HxylkHycUoc6Rp3T8w12BvFvcgzEx/dHaA8hlp
 O1gPj8ERK9eGEH5gXCaLv7is85RzP0mzbOW043WSEhWlrs2JRjOPt9Dee5P/nyyhU5x7Pmb1mof
 Gvi9D54Jv77rxqdBs4O+QVOt7BeuPE4JTCbaU9iLH50UB/VECuOLV+d0gk4XxSMBGOJcqquKmr7
 suImW1uLZq4ALZGPtRwyKQlemFnMKR1mVeenPIcoVEGBlkTagYcSFPSY9UftkIk0B/Pifi0Xm55
 4KsEGbkAQ9kBTm6DMO53KQw8EssaAM71spD4NADJ9yE8Yk07TZ5D/Uuf9vVovYOYvYtraYlPjGw
 f7T3OzCervPIBFiom8sURhopagoZAI6WZhePCFwupizi1kLYxqXCDDF1hA8gmH/K5MPGfwSAvPU
 KQNQ9YNXL9r+IqG/wwggnkuPMxh59ufcq/A2hdXrdTZIwfNiSlYYb2o3QZhyfbDbFmW+jri8AFI
 e/dMJnlO2
X-Received: by 2002:a05:6000:2308:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-499c0781a7bmr2741238f8f.0.1794384841990; 
 Wed, 11 Nov 2026 00:14:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:3969:bc96:edc1:c5dd?
 ([2a01:e0a:106d:1080:3969:bc96:edc1:c5dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c5c4sm8034701f8f.17.2026.11.11.00.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:14:01 -0800 (PST)
Message-ID: <8296a815-d563-48f8-a32d-928bacfae98c@linaro.org>
Date: Wed, 11 Nov 2026 09:14:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [RFC] blk/scsi/ufs: scatter-gather read support
To: u-boot@lists.u-boot-project.org, bhupesh.linux@gmail.com,
 n-francis@ti.com, marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org,
 trini@konsulko.com
References: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/10/26 23:52, Urvashi Sharma wrote:
> Hi all,
> 
> I would like feedback on a design for scatter-gather (SG) reads on SCSI
> block devices, with UFS as the first to implement it. This is
> a design discussion only; no patches are attached. The struct/function
> sketches below exist to make the proposal concrete enough to comment on,
> not as a finished implementation.
> 
> Problem
> =======
> 
> blk_read()/blk_dread() take one contiguous destination buffer. The UFS
> driver splits that buffer into several 256KB PRDT entries
> (prepare_prdt_table() in drivers/ufs/ufs-uclass.c, MAX_PRDT_ENTRY), but
> a caller cannot read one LBA range into several discontiguous buffers.
> Such a caller has to issue one command per buffer today.
> 
> Use cases:
> 
> - FIT images: a FIT can bundle several images contiguously on storage,
>    each with its own load address. Loading one FIT means pulling several
>    images from storage into several different destination buffers,
>    which today is one read per image.
> 
> - ELF loading: U-Boot has no path today for loading an ELF image
>    directly from storage (bootelf expects the image to already be in
>    memory); I raised this gap earlier in [1]. If such a loader is added,
>    its segments could land at different, non-contiguous memory
>    locations per their program headers, and would hit the same
>    one-command-per-buffer pattern.
> 
> In both cases the data being read is logically one transfer being split
> across destinations, but the current path pays for a full command
> setup / UPIU exchange / doorbell ring / completion poll cycle per
> buffer. SG would let one request cover several destination buffers
> instead of one request per buffer.
> 
> I do not have measurements yet -- this is still at the design stage.
> 
> Proposed design
> ===============
> 
> Rather than extend the existing single-buffer read path in place, this
> adds a separate flow for scatter reads that runs alongside the existing
> one, with its own error handling at each layer. SG is not inherently
> UFS-specific, so the block and SCSI layers below are meant to be
> controller-neutral even though UFS is where I would start.
> 
> 1. Block layer (include/blk.h, drivers/block/blk-uclass.c): a new
>     optional op alongside the existing read op in struct blk_ops, plus
>     the scatter list type it takes:
> 
> 	struct sg_entry {
> 		unsigned int addr;
> 		unsigned int blk_count;

Where do you pass the the buffer for this entry ?

> 	};
> 
> 	struct sg_list {
> 		struct sg_entry *entries;
> 		unsigned int sg_count;
> 	};

Maybe passing sg_count directly to read_sg would be simpler and avoid
an intermediate struct, except if you want to pass some flags and extend
the sg read.

> 
> 	unsigned long (*read_sg)(struct udevice *dev, lbaint_t start,
> 				  struct sg_list *scatter_gather_list,
> 				  lbaint_t blk_cnt);
> 
>     with blk_sg_read() / blk_sg_dread() wrappers (LBA, scatter list,
>     block count), returning -ENOSYS when the driver has no read_sg.
> 
> 2. SCSI layer (include/scsi.h, drivers/scsi/scsi.c): rather than add a
>     parallel set of command-building functions, struct scsi_cmd gains an
>     optional
> 
> 	struct sg_list *scatter_gather_list;
> 
>     member. The existing scsi_exec()/command-building path in scsi.c is
>     reused unchanged; when scatter_gather_list is non-NULL and the
>     normal READ(10)/READ(16) command is built as today with the list
>     attached.
> 
> 3. UFS (drivers/ufs/ufs-uclass.c): if scatter-gather is enabled,
>     prepare_prdt_table() grows an SG-aware counterpart:
> 
> 	static int prepare_sg_prdt(struct ufs_hba *hba,
> 				    struct scsi_cmd *pccb);
> 
>     that builds one PRDT entry per segment, within the existing PRDT
>     size and count limits, with the cache flushed and invalidated per
>     segment instead of once for one buffer. The existing doorbell-ring
>     and completion-wait logic is reused as-is; nothing changes at the
>     hardware-facing end of the transfer, and existing single-buffer
>     reads are unchanged.
> 
> 4. Kconfig: the generic part is under SCSI_SG and the UFS part under
>     UFS_SG (depends on UFS && SCSI_SG), so other controllers can add SG
>     later without pulling in UFS code, and builds that do not select
>     either symbol see no change in behavior.

The overall design looks sane, but:
- the naming may be misleaded with the "sg" dma, maybe instead use something
   like "multiblock" ? I'm open to anything, including sg TBH
- could you check if some other interfaces could make use of it, or
   perhaps if a dumb helper could be added that would simply go over the
   sg_list and run single transfers to emulate that so we could have
   a generic usage of sg_read in FIT loading for example

Please send a quick RFC to we can discuss the details.

Thanks,
Neil

> 
> Thanks,
> Urvashi
> 
> [1] https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg04243.html

