Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C89AC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FE3A607FC;
	Thu, 10 Sep 2026 12:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kR86jlATZXnq; Thu, 10 Sep 2026 12:42:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E0A36087A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044176;
	b=YqP299XBQyTcZ8yym0ddpyNzzCHQPUsOUO7H0RWH5XuwGdFcffym323nFJF5mC1x1I8i
	 X6g2nqEeoCe3vJBX7lKYoqfY7jopfLXYtaHFzlKRTfRcuJumL6CnGkFjdiJ2R1OovZIdn
	 YGCtReZ9HAdYyjUtUN96VfXxA3lR48Z7cWIHlQ0xK7PJF3fdhhJ8EOtckoIVxaP5ZTAot
	 xfIkLjOvtVXmlM02cD+c2pSXx0odM6jpGuCqnkycCgWdX1cT/7EwAg0h+bvg5UqfurRhW
	 +KuNmkTveGIgyLUO+Ix1Yf+WOJ3INfemoUKdlW3BQPnm1wHMH1BMNoeMT9EgkvtzN0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=4GX9XfQKOz0AO6fH7RqkcC0KFEu3UY0vmOY+Vn/fkLY=;
	b=G7PuOyLgw+w3zN93VWrm/caPYVvMXxMaDTn/H0kbAeLjrmC+2SmC0jMzxM5GMZX5r9h3
	 e7f+P5VYifJQQQt8ViaHpNvbE3Ach9Hx2jebBViMDHmV3GeCl1z4/2qjwoxI3TJVnLWVC
	 Vs+po1Uu1kMS6zbvprDez6FrhSZ71J41uu8IB8tTuKJCAlydkY0oyiqwLJOH5BDNDratm
	 PJEiuu9RW0/Wh1Pd0+LhrIrH1JTuh6DoVDrrQ52m2yTwOF2DOJwp0pciI/x7vUXBaeGVs
	 Djg5BbqFYI58LsDLbROqF6FYzIHYg3/1qEmWKIaDHcwfjQ3XyMndqLsyRnl5t0KVCBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hjXhysB9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044176;
	bh=4GX9XfQKOz0AO6fH7RqkcC0KFEu3UY0vmOY+Vn/fkLY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hu0BZc4SQVIkuxyjR06lvkAr5jkQD65MRe9vx0ZCRmU0lOOmS2vVXKN2mWY/h4j1R
	 +C+QKk+JeMy554meMCKP3uAIVL9WdY9KMks+Y4+q4GzODLhhsOVcGnkHFJrrwPZXYU
	 yKjE/UJzg/b/slTmJLWTujmLCNBnT3bJPnv8auU65dQ1Sw0Ha4T31GbP5LU0AgP23v
	 Lzznjj1+xIuDJc8bsEHt0C045xCvhehDsLA71zvgpSJ3C0C8AbkGtuI5Ssc3ylEIsc
	 5q4ROdozsmhjqb3n20N4j1+eZs5s+dRzqnrHjG2Pv+TznwvkWnT+63J6n72ww+chJF
	 6lcXdLo0TYFqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E0A36087A;
	Thu, 10 Sep 2026 12:42:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BE00E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1C706087A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oB-copgJIrqk for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:42:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1DC3607FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044174;
 b=sN9Dmi0bWotHyIdcfy0vVW7TIaXdo6B+rRi+OCklXJOUDmlo1pvOUXFVKrNR0zdGJEDe
 GiynWOntan/rPa/Tx7brUq2KfSsULv3zQ7Sj35EPP8DFGB5pA+8ifWEIJfw0uzdE33h4V
 WsEE4kUJSy/iKhUWEBSffMNRHdm4A3PfJ/GFLo2IGeQZjmcXxQDoYyuMMI84Fv8hzNtxf
 odrZLZ3Y2DpPd+V9YLtFbH643HLL7Lyvzh91Yk4ON7/PK704dHgQ5k9UfuwX714ZxifZS
 0eAZi2rC07HhXOUn7gqHuWWcC3uz0d/hh8YfMt/KBk3GRBOWH0MH20CY8qSJ1AUdCBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044174;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=4GX9XfQKOz0AO6fH7RqkcC0KFEu3UY0vmOY+Vn/fkLY=;
 b=bpk3T/xgR6CnNq9mSo34do76SdazFjq8D2RC96nqX3Rbwwt1MrK2BHAY6dEpnWdBfuUZ
 sfuAsb1eyc3rTiOPZHNFuKyj5tWeb7X0tpWN5XXKK7riZovVD/504icqJ9QnNSxLXKkRl
 9MyYCkcgn1ll38LqfJQB/NLp0YcfVOblOFPQZxK/V1yzUQCy76SV9I+7KAeoBQjiEwVlj
 9XxK78Uiaozvpd8DMHxxruBwzBx1aAUf+P6zo+IbphEeA55b0dpDqEirXQcywyG6VmN3X
 xV+J0tginN9TPVw9RhST4TV0w0vo9mOyUFfNUZKLe9JO5pSxHx6fhFukVnxIFxp1zBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hjXhysB9; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hjXhysB9
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1DC3607FC
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:42:53 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843172bff4so741074f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044171; x=1789648971;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4GX9XfQKOz0AO6fH7RqkcC0KFEu3UY0vmOY+Vn/fkLY=;
 b=hjXhysB9P1N4Zth7DX23InyN/0u/+1+SdunO32k6b1J+caUw8vrNJoTz2zgYamyx2K
 /Xu6aL7kfOxjeNDc6cgLpAh9TMa3QOLs+F+mIO8XH9Ec4szai4T88RxVghKUoL5dw8/p
 PEinIFkUibEWk/rJJMx69jR8zACYFB0HrjeuOlcfQhj+EcpEgFIOnf6E42/WlWW13kR9
 gQl1INCJxXyF1MXskChQt1RTugX8y3msx30bLxcg7fs+sFPgbTTgQOsPqlmTpFqOdWIK
 Jn/K35LrJvMAUsT5mfQxnpSLlmyjuwhZpdmLRQnvenMDl2JCp7eyAHh5hC76DjEjaVJ4
 tD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044171; x=1789648971;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4GX9XfQKOz0AO6fH7RqkcC0KFEu3UY0vmOY+Vn/fkLY=;
 b=Hfm7zxHwYDJlUpdArOc1CFLtNbjv87wtYcFYsXoX5Orvdt4BRiAFWhzemo5yHYtcUp
 Ik/wH/DHBoyDyJtS5BF3WK/lJfbgYAwWU+jBdRdEY7xfsn2mp+hFNs7xP+NoOLoopD+F
 aMKfwv9kY6jKLtLoqHX2aVdThfkMvB4JbZzwIKlyk5LBdmzsoexcq2br5rf//DDYuMOq
 KkGx/RVxZ9jHiLdwT9psgAL0YKW83cPXgvHGQecyd3k0j/ayKTTOECUmWf09w+29ohsG
 Q+MpxczdR57phtQey3JDRUa1IlswnUXUHR5IVo5B8naUw6a2+0qjiDsi+O1hEWMW/cik
 WMlg==
X-Gm-Message-State: AFuF++n6mhLEYObGM18xv8mD7vuuUFRO2wAIDRyK5+3UUubQtgQ/6CRC
 +o4/prt2T/fBUTlP6w123XIOUcWf3mujvnstIPHoYmsq5wtCxRiPIL0m1s4+ewB8vDI=
X-Gm-Gg: AYBFou1GRP042qrzsAv/EBUqN2XbHknLtTX4d/sWUT2LNHkS+j2Fkzz8vVAbHXPU2ui
 sdQKd+A+TV5F76+CM4Hv3aGWNYOBXijbuIDykNNZUMXyLtVZA9SlXQ7GYX7c2rJ5TuCKQPNUMKI
 BQI404TYT88me6w+L1UmBPOk8mDOGtpL8nr9AWRvh46xGEfNLVbsXMEHT//kv216Qg4S+iIjLRs
 v/ZuGLjM8lR/v2rfCxPED/Huk0lgPwroH/AlDmUAdZTxb7QVz+lLusnwUWgqCDal8kaoUrlKTuW
 Zt4w6YJG2xokl7Bxs0IgjH5rwqs9Imk1++nzMJjX2tN5cV3IqHuZHqE58m/+4iGeO4aNVnDbkpi
 g1nvgZ9JgpPTab4CSSciNpNVi2X2HbPy3qmWl+sykMUmKidj+ouBIuZCb3XQfXcMbKM8ZsoZgll
 FutjuI4M2EdeHXWiaqk83VvH4AGGS1Af9QgGaYhZeQpfSrKhC58J13FKMAY/ZlZtXrt/eh6t2In
 uVnOnKVwTysd0IvLImRXKWa2EGfBKyr2fttfEn/2gBqg/CX8HsPjA==
X-Received: by 2002:a05:6000:4810:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-485c23d66d5mr6872840f8f.28.1789044170843; 
 Thu, 10 Sep 2026 05:42:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm50645683f8f.35.2026.09.10.05.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:42:48 -0700 (PDT)
Message-ID: <9234da92-58a7-4f60-8bde-3a266e08d3c7@linaro.org>
Date: Thu, 10 Sep 2026 14:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/7] pci: pcie_dw_ti: fetch reset-gpios from the
 device-tree and use it
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, srk@ti.com
References: <20260908051741.868824-1-s-vadapalli@ti.com>
 <20260908051741.868824-4-s-vadapalli@ti.com>
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
In-Reply-To: <20260908051741.868824-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/8/26 07:17, Siddharth Vadapalli wrote:
> The 'reset-gpios' property specified in the device-tree corresponds to
> the PCI PERST# signal that is used to reset a PCI Endpoint. Since the
> on-board circuitry may not reset the PCI Endpoint, fetch the 'reset-gpios'
> device-tree property and toggle the GPIO line corresponding to the PERST#
> signal to enable the PCI Endpoint. In the absence of the 'reset-gpios'
> property in the device-tree, existing behavior is retained rather than
> returning an error.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Polarity of the Reset GPIO pins has been fixed since the v1 patch.
> 
>   drivers/pci/pcie_dw_ti.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
> index fb39132f7c1..ac2045991c2 100644
> --- a/drivers/pci/pcie_dw_ti.c
> +++ b/drivers/pci/pcie_dw_ti.c
> @@ -58,6 +58,7 @@ struct pcie_dw_ti {
>   	/* Must be first member of the struct */
>   	struct pcie_dw dw;
>   	void *app_base;
> +	struct gpio_desc rst_gpio;
>   	u32 num_lanes;
>   };
>   
> @@ -252,6 +253,17 @@ static int pcie_dw_ti_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> +	ret = gpio_request_by_name(dev, "reset-gpios", 0, &pci->rst_gpio,
> +				   GPIOD_IS_OUT);
> +	if (ret && ret != -ENOENT) {
> +		dev_err(dev, "failed to get reset-gpios\n");
> +		return ret;
> +	}
> +
> +	/* Keep the reset-line asserted until the PCI Controller is ready */
> +	if (dm_gpio_is_valid(&pci->rst_gpio))
> +		dm_gpio_set_value(&pci->rst_gpio, 0);
> +
>   	ret = generic_phy_get_by_name(dev,  "pcie-phy0", &phy0);
>   	if (ret) {
>   		dev_err(dev, "Unable to get phy0");
> @@ -281,6 +293,15 @@ static int pcie_dw_ti_probe(struct udevice *dev)
>   
>   	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
>   
> +	/*
> +	 * The reset-gpio (PERST#) should be held deasserted for at-least 100 ms
> +	 * before the link is brought up.
> +	 */
> +	if (dm_gpio_is_valid(&pci->rst_gpio)) {
> +		dm_gpio_set_value(&pci->rst_gpio, 1);
> +		mdelay(100);
> +	}
> +
>   	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
>   		printf("PCIE-%d: Link down\n", dev_seq(dev));
>   		return -ENODEV;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
