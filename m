Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A89C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 08:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2068060738;
	Mon,  3 Aug 2026 08:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uV-glQHq3sk1; Mon,  3 Aug 2026 08:05:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3B8160708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785744340;
	bh=OhtFOjBV74djGmSFhZ65ecrtBZC61gLXbD0vsMhSJRQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uAenaOnZQ5Lh0O4KdsJ28XXxrrQBQWyw7nDQm4Ah9284iP2OgpU61zsoQRxzNyHUQ
	 7PO4eQzjgOGWRZd5rU3oKuqUKxv4Fs2nkQM7oyKCcx2D0kVrp6w1xouXZKg5JocJTO
	 BbhAXvnQOoorEXKhk+v5IpufI9voqtn3DiQgLHItUERq4GtuzZdkY2aa/IhQiF2qOK
	 ymnNN5g5OALcZeFOftfj0zDq/isIiltI8ZjgcV51GmHj5/oAyy3ydbEP4PRoV4sLDu
	 yQzEkyMHyylThwYRG7GNq/zcqofISiKBSPuJIvooxGE9QR3ASB31/y5cD5kxqe96TP
	 FCo5ueHTXB86g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3B8160708;
	Mon,  3 Aug 2026 08:05:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71E9F3A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6375A400E5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmLmcTSqfTMa for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 08:05:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 68C8E400A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68C8E400A2
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68C8E400A2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:05:37 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so13392815e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 01:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744335; x=1786349135;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OhtFOjBV74djGmSFhZ65ecrtBZC61gLXbD0vsMhSJRQ=;
 b=l5ngItaeMzTewXwfF5WfD7w/aFAgnWGf1g2b143qDVk4cC/PUY6Ksv/syCa2LmbYBd
 zCEWrQXZzTKNHaCpYLiLTYKnL5aLywLXHi9jJ2kVILWVUeM2k/fdYJEhnhA5UCFw+v/D
 pYOQ699wrrCxOSVV+743l4HIOq8xbWO8lJzY6/t09DlL1mFoZZu8UspMgJy6sojjUTaw
 KZ2czgFYTHUoY3XR20jaeYNXGa3uZe/v0aqXEuJX+U/srH/kmdDF3nbOC4ZNULWumfNK
 3qe0nPuNMcQlVkJx4NDQ1eNf1Ub2ZQSwUsgqWjx7do+ZHCIRTuaL+6hHBHWcQct7iO5q
 ewMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro++UGyPvTdqP60YbiN1/7/nuthaEkuCEw4RDeonkQJMI/ZdL3ZwkW2rd6NnCh75rQNQBj8KhA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxTt4apa8cqsPZG/FUsXOhpxD1CTEZNAyHh7ZuTeEo373bARIb4
 hV8pFXSzHzzjvWOJcxoansQteJKKkA3nsoqJcgxEW+yWdzmm/A4HgbVgphZJmEcdDUo=
X-Gm-Gg: AR+sD11sSsm1AhScslQkZQq9iamnMt+M4KPl/PXnUQIzNtQwMzRhTvS1esaiLmiXqxY
 V9Ykr1AWRHHZ/8Qf857Rj4ZYZDHqxOYT9+ubXSPOXMRX/3JI+c7mzOz5JdvKK6oyvk1zGAVsLyZ
 mneM7LXg0EAsPvQGlHNXz3y49hdMwIYr0r0efkvmpJUs04h7IQwEj5+i5aETp0R88TIKWDyYMGT
 L5F6iq8m5h4JruH2O3nQnnzLXzOxiUFHCekG16l/vRCxLodZb8bRl5OG3HKdWnD5pGSbIIixgZf
 RlJETv48qmd2uDzr14NFfLwLaACXBTSDEZ0JIGNLqEIuFCvq3uhubELJGnfL1SOaPxYyD/wZg7z
 1IVOGxWs1U6jMkUJZXEYs57YKd9kRdIQP9og7OFtBt+453auljPRr4/d8FudKvH4cmylS6Fcs2m
 FHNjVsHHTzvdybPHsMkggbcJlldVkB9ROABxk8TnGQ506CxywEI+jAFvTtMB0Z72Q+xoXvIfH1c
 2cTPl87bRmBng2uUrtO3CychV7Y9TkdAst+B3s7diDb
X-Received: by 2002:a05:600c:798:b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-4980eb96c74mr115782975e9.2.1785744334966; 
 Mon, 03 Aug 2026 01:05:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:de23:a565:d98d:318c?
 ([2a01:e0a:106d:1080:de23:a565:d98d:318c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6d7sm31398030f8f.19.2026.08.03.01.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 01:05:34 -0700 (PDT)
Message-ID: <11071b0d-fb58-4022-99ec-3cc3bea00790@linaro.org>
Date: Mon, 3 Aug 2026 10:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: layerscape: fix pci_iommu_extra hotplug
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260729222118.242013-1-vjardin@free.fr>
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
In-Reply-To: <20260729222118.242013-1-vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785744335; x=1786349135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OhtFOjBV74djGmSFhZ65ecrtBZC61gLXbD0vsMhSJRQ=;
 b=rVR6xZdCuNiGgXfcD8T5cFPGedYyaYsplmWlr656XIxIwt/4IOMDzi8gJV8R7AZR2N
 Vw9fkQAGzeuURLaXg7KYGwlpJAL0HnkpwTXZydqVO0ir6dBi7da4KQcb4al6/fUPdlrb
 d3FH+YK+S5qBzOE46X5gbkXUjV+r2KrvPTh/2pvcae6bMvYr9XP+A4x1E9cRTF7bxXrX
 TAYtiCwk+KoIBeMeQigq5yoQfxMZNLz8Q7xLr1veJ+OEkZRk4oeCtO+72r5YA8kPZLjJ
 BVfSq55tZPqOQKUV+AiEu7n+kuAOis2ngBOcayflMRoFi+WJ0/5PoExgj1ckelMQHvHo
 Jsww==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rVR6xZdC
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 00:21, Vincent Jardin wrote:
> We can have many pci hotplug groups, each introduced
> by a "pci@<addr>" token such as,
> 
>    pci_iommu_extra=pci@0x3600000,1.0.0,hp,pci@0x3700000,1.0.0,hp,
>                    pci@0x3800000,1.0.0,hp,pci@0x3900000,1.0.0,hp
> 
> Without this fix, we have the error:
>    Added iommu map for hotplug 1.0.0
>    ERROR: invalid action in extra iommu entry
>    ERROR: invalid action in extra iommu entry
>    ERROR: invalid action in extra iommu entry
> 
> Fixes: 2a5bbb13cc39 ("pci: layerscape: add a way of specifying additional iommu mappings")
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
>   drivers/pci/pcie_layerscape_fixup.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pcie_layerscape_fixup.c b/drivers/pci/pcie_layerscape_fixup.c
> index 97c38c0bfa7..5299aee63db 100644
> --- a/drivers/pci/pcie_layerscape_fixup.c
> +++ b/drivers/pci/pcie_layerscape_fixup.c
> @@ -319,6 +319,11 @@ static struct extra_iommu_entry *get_extra_iommu_ents(void *blob,
>   			/* Hot-plug entry */
>   			entries[i].action = EXTRA_IOMMU_ENTRY_HOTPLUG;
>   			p += 2;
> +			/* Skip the comma separator so it check the
> +			 * next "pci@" group.
> +			 */
> +			if (*p == ',')
> +				p++;
>   		} else if (!strncmp(p, "vfs", 3) ||
>   			   !strncmp(p, "noari_vfs", 9)) {
>   			/* VFs or VFs with ARI disabled entry */
> ---
> base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
> branch: for-upstream/pci-layerscape-iommu-extra-v1
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
