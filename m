Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DEC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 074AF4084E;
	Tue, 21 Jul 2026 07:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3QRAt3dPUcM; Tue, 21 Jul 2026 07:32:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3809440840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784619172;
	bh=3/rUS1Zo/9H1Bs4LrsVCIP6URXDzTeMomvM9rlNK/Ko=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sBZFg0BAYtmIwpdxsNbxc66eAIP9xKPbMZOXNnGajTtMuyipsiVgEvtGs0pC85lJB
	 0Ewf8chcdLihs4kZTwVIrslMukr8TqLeSfISaCsTOyMM3snzfzCBnjh5HJpEUj81To
	 IOsZU/W1MIBtmep4aU0KnMKs1sxPONDEH/bS737a3yj8fxPCqCmhHDIsuB1S0+rI5G
	 up8Ezwphx0+FPEm6V9FLUMIauVSFENh/5XfWBPzB1PMvIMbjSQ9vyvX2eBoXn9Qa6O
	 tHbHstG5P81QgS/WAQIsXHWzUYjxmlXyPT75MJL4tnsGNskTBL6SvPUzdBMCCkLZ3p
	 nTsde8947W+Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3809440840;
	Tue, 21 Jul 2026 07:32:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B721224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CC0840840
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iuZXq6I1rREs for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:32:50 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED64E4082A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED64E4082A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED64E4082A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:32:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2599C84659; Tue, 21 Jul 2026 09:32:48 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C47803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:32:45 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-475417f010dso6133022f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619165; x=1785223965;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3/rUS1Zo/9H1Bs4LrsVCIP6URXDzTeMomvM9rlNK/Ko=;
 b=Oklw6uq2xfveLUXxvY2yLtTcQzggfzFEHJnjbGaljl511s3MyR6+XuYIjRrOw3ML6J
 0qbjCKrMlEUWpT5YabeyH9DbnXBlp3Rey1CBaBgCIyi8yaU+NFrqz6UKJlUN8ctMZldZ
 5Nk6Ab4+F6nVg1C0DrtIHQQFyvyxeRvyBIZ1j1hxEfrEt4ycXbQdAHURet58fImetewC
 9yAMAB6uNixQGVtBuMiSd8UIw+p1c9Mr/lHTehIYRZIe0jR1sjpnawbZsd0/o48ZdJeG
 Af6ao2cRhlhXQR5ZhOE/maR3cOqWwwZKQSikM7X4OLE1L7btWIp7/AfNRk+x5oZxtHdV
 GlPA==
X-Gm-Message-State: AOJu0Yz9ct8jp+DruPi/qyWnnp1PzNpeHjjFNqQhT9sZ8OtuFxNwidRn
 iui2xHZJclCVKIJuMioFhadhltdeTAwb53Bgk1JdKnTaFwLU9jq9ybHIg17Ac7gg8ms=
X-Gm-Gg: AR+sD13O3De47MBQxB60LCmuHZIVcEVamV+IOFIUf+b6LhF37q9gzJqV8be/33G4/ys
 RZmD33qSb4u7VydP+u0XYQdaXpWBspO2dPkZVD/1PzjQ4767HfcZpgbPoMZ/0DvOnx96W/1Dw8x
 EnbA5R3uPJODHzifhEoYfCDHUeymPzhT1XIZgDcTzWpjQ0Ag35CIJ3C7ZUaOnniY9RmRCLKmKba
 NTultLqQXGdqQKpUfnm8NqOQLVMO+cv099Kk47bj/z4KAbxv54aL23ayysGtWu9tLUXg96M3h5t
 DdAJDFmXBWMAOKo2kde43JB4fAFl9KkiCq8nQ2Ti7IubkppX2KGrHXjSwKA++B2ZZHrgsNK8GGk
 PKJkhe+xdYo2YwViEkTbtM3hcBOtUywv5yM7e5CD5Wd73EvXSGLMy0hM3PkWl0hKE3lJKNCSkJG
 G7PX7q3rKbeek1P6YMg1ocp2LR+M45OntptN1VUm0zneNb+0QY+pmXhCobww==
X-Received: by 2002:a5d:59c2:0:b0:47f:2baf:5e2b with SMTP id
 ffacd0b85a97d-47f623074e0mr24772069f8f.1.1784619164987; 
 Tue, 21 Jul 2026 00:32:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496ffsm35829447f8f.3.2026.07.21.00.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:32:44 -0700 (PDT)
Message-ID: <72878f7a-81f1-4216-8eb3-6b41160068fe@linaro.org>
Date: Tue, 21 Jul 2026 09:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] ufs: decode string descriptors as UTF-16 big-endian
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-2-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260720085202.537019-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784619165; x=1785223965; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3/rUS1Zo/9H1Bs4LrsVCIP6URXDzTeMomvM9rlNK/Ko=;
 b=GrbaMfxEgFYOs1so2CI2QVvfyk8m0vSsditwwpkYWBNIXfAlRiw0eb3dz1kfhU00w0
 7rzrii+PwaW1RkkxFSZS6phK96QZeFjN5gA0iISyL4OEAZwPdBxqAD/OGUo4AeMYBQvm
 ICYK7Wrdk2FaZnvvXV4XHsuVTqcZCAaRbAsIOHzHpaV2+fmqLYR/aZGXEXmV6/9ZiqDt
 goorDe05IF+gdrSQa4ts6A3D0Wq2bKQMaFsSbbFsErEOoq88rEO3MAxuj6mewrQzQOwr
 sm8C09ha6la38eRdBZ2Yh7WF5lT4VvaIM8TXBR4JNWvHNQNyG/Y6d/qikovGBi4nb4HS
 yx+A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GrbaMfxE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="GrbaMfxE"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Neil Armstrong \(Linaro\) via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> UFS string descriptors are UTF-16 big-endian (JESD220), but
> ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
> host-endian code units, leaving dev_desc->model blank. Byte-swap to host
> order before decoding, matching the kernel.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-uclass.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6a51f337e47..4d10e0b11fe 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1765,6 +1765,14 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>   			goto out;
>   		}
>   
> +		{
> +			u16 *ustr = (u16 *)&buf[QUERY_DESC_HDR_SIZE];
> +			int num_chars = (desc_len - QUERY_DESC_HDR_SIZE) / 2;
> +
> +			for (i = 0; i < num_chars; i++)
> +				ustr[i] = be16_to_cpu(ustr[i]);
> +		}


This block looks weird in the middle of ufshcd_read_string_desc(), move it to a new inline
helper instead.

Thanks,
Neil

> +
>   		/*
>   		 * the descriptor contains string in UTF16 format
>   		 * we need to convert to utf-8 so it can be displayed

