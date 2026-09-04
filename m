Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2DDC79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26B4640B37;
	Fri,  4 Sep 2026 07:57:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adRfnrnH8I4K; Fri,  4 Sep 2026 07:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DF6640B38
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788508641;
	b=eH1IAldTtQaDIBQyiskM7AGRRJoslLHXyR9ZwAYgRCJ0xxeJHjO3KJytI1rAYSJL4sJ+
	 HJGUtMhI8FPKWDqwUt73cOcgGIL+sQ8NQkoocjfSxvi9iqTEnVzV+uMzvRzB/Qdx4K8jj
	 FiQ5duu3HgFLIktBs8J4Sz6KExBfGWECzxrbFTA+S7N07Vjuyfljq7Y07wgRZgLSb7mWw
	 5DcPoAndGhTO9wtQPe6o/FGrQKmf3QAKdW8vLmmLU5kLWuIEgSbfARfVJRred+bnWrpbW
	 P7XV8tDIAwznWDLvPXSH9Gel4gSXW4DljqR9CiH1FVKERl7+6XQnqgQKf3MjNN/QBwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788508641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=cjx5Xx2RJJV2wpJVmHrI/RbkvOjtaciMhPU4xU3E+oU=;
	b=JLkcBMmfybp4VHdFyw3EYSiKkmQwxXxx+YRcRnT17RKRxdznIQkCJfeVBQPiQ7MLiHDT
	 Ws1wFptI89yig237/fMCBRfsOjVF0KCtUBozGlf2itIuzMko7tvZrQeieAEcS4uF3AVaz
	 zVqc6lKRzsf4dIM3+ZmQPiZs8BtcMr3YIxBA2hymedBc2wNSTjTBhwMgpkqpCUhq+mMoQ
	 Dz2ywSVngxj9f9ErrAMNVsnt5cSmQ3vBObl6xQpl1UKGPhUb+6b/Lam+HN2Y0wXdx6t/0
	 mWgPzjI6OamTdcH3iGS+6hC1PhbhNWkGhX8lnLudWR+iCWDRw31SE75eAGEPQQo7mSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788508641;
	bh=cjx5Xx2RJJV2wpJVmHrI/RbkvOjtaciMhPU4xU3E+oU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ncO2zOLfnyDEq5kNsIfq6jkMMNvDmLDpfiU0S8KWOVN7q5KQF16LCTL2VwdpN0Gxq
	 Sp4wv5FIw6+OdTlK9IhoD35O3QEhmysF9iAoA8ipl3x55xhkK8Ues5lEkkOlWbExKQ
	 Nlejlt1UfeYJoof+3Djnb0UAY+Pqg7tJLX+EFuL8A/vVLfQayjRZ0Gecr6xfRDfTK/
	 iipHrlgwwsij1WN1h2QhPBYhxP2RUKzwKJEbZplRlIbHq44G2kIFZTePiDJKym/kq/
	 4xGwIh1fRqQPrD5KbLp3ikdEjL0bKuoa4nLj505c84S/HUJou0WBAOGS0Ro2i2UGhE
	 22EIZYq2rdA8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DF6640B38;
	Fri,  4 Sep 2026 07:57:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DECD3363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C49B481140
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQTyDzV2_eqf for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:57:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D99F810DD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788508639;
 b=Lw1+AVzZjxMVaagOWafKXBOY2DefFZduDI9qq4nYS39YUPUXqNFqPcnvEiDkPc0kpMkG
 FXKsGBCfwSKNPsL1K94Xur8S/By8ncZHPt57TB2IKLKJKvAxTUnPZ8lIjmvAJgRuWg8NP
 mcoinNyBF+3lzHhmROmmFad2jxQ3Myi8cHVL4tsSB4VCifpvkflzuXNkGqjqwJWNCKrGA
 +UVc978+9t5446jTK+R6rxbcZ9WX+z7ICUu8iCKAu0EP9Ocm1FUZpbvXuoli/mj3sN14i
 +gx1HNm+E2k92D7Y6CBz6MFZUmoYAekmWERYem2sfb+zlmd9aFtcrDNik4hp5o7I5iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788508639;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=cjx5Xx2RJJV2wpJVmHrI/RbkvOjtaciMhPU4xU3E+oU=;
 b=NhwM+2EjrNIoT/EfrWvGwZ0l+SEksbLps5gBLS921L8NvGcSSzGJ+plQcOxZueLVyMaV
 oTDPLcrKyKZKINmjN1xzGTCDSeWfHBlvqKHYTzJpFhQ830tN20SdfqYy6lbIcwbVQyTb+
 jM9Y876qUs9CEz/ZbKbo8DeAbXbCagnyZu+wwJ2MnbA/VOHckVLKFYbAds+CTR3lshjEz
 mgwSURZg2Yy7K8+KohREGkWXH3gqOV7UzYUNQtmNZ1rpGXf1gEkP1kCDF2ceEljsXk+4/
 8EREF7WYvZFAKOoY0br0OILYj0ynDHQ+X7KKLwXn4eJtg4ntRELFLr6MUJcsaSpuo8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TIjFRjgh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TIjFRjgh
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D99F810DD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:57:17 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso430379f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788508636; x=1789113436;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjx5Xx2RJJV2wpJVmHrI/RbkvOjtaciMhPU4xU3E+oU=;
 b=TIjFRjghbZncCG3Xo3EioLK5eEp3PQa1B4I2f8RGW24Xp1K2+pk6iYCp8E3idTlRrO
 UCZPuPfLwCJKb0tsOPUfX3rZgaCrxgW6wR5Bfv4AH6vpik0K0f4w0LT7oHtY68jQmYQZ
 raA0h5CcwLLOq4NmtBJbUaoZ+NTgt2adraCgrveoGgvi2SAKG4MgUGr8525JLNOcPd83
 XBQzekH8cgtrvvnkOkuhOCDmycdvmlCULIlp28E5cenJrda1BG57QSuQ5uoWQj2qgV66
 EaoygrI14lyalALCKK/5Hdqc2trOd1+b6qq2M3WpwnSl0svmovv5fcP/6yvgQdq5F5LK
 5uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508636; x=1789113436;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjx5Xx2RJJV2wpJVmHrI/RbkvOjtaciMhPU4xU3E+oU=;
 b=iaqqVPLvOOjmp4T9+RNHg3ksX5ZCPHwr50Z5fQdFnY0J8SSzoPHT5q7A37HqQg+xYs
 fOlXwdMqD+/D5Fp7AdIEXl+l1Vbu00fM1iEVtNHNgh2dt8f4N6YDqMyRsXPKOa8ZXQeD
 Yp7SH7qgEeLcScb9BpV5vId6nq7qM8YRqQGZx5AMsvJwX5Gs9khFgi6vaSD1hv5g0Gey
 7A0glK0jY2evcunjXvqBDhE43V85KG6t1Rh6bNQ4JX5VbjZN9tZ7VNv990n+IRCVt5Yi
 t1/NCHnb9HhsZdXqtVtlAg2LE7Mhr+Sms8vDP8Sjfueir1OuvRlh59o90Zbb6xlLJjgE
 ehgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNLOuSlgMxgK/ibXRPHbz9FhLwd8/2+hH/MTIOGZW+IfBmIyu4PR5u3MU64PpJJ6ZA7GyGrYI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kCZjAkhOfMGUwOad5r48HKKTm4e+k5ImMecrHVSubE8YrxYmT8
 18orE2kUXZHxMcyC/dkQ1n27ZvkpRbnr3jHnZCMmgclTooJ7lzA4xJKpoOPgTwIDCb2HkamqBh2
 H3tcs3/U=
X-Gm-Gg: AYBFou1xWHSam9RbfqKzCUpbyYjerFAkCbKdZqUcLwjttw7RGMJ5buQuKjOW1Toi4vX
 PPahmreKE3RIrndIYtTB61KpijoEjR3yUWCfYL8WSI63ysXrVko/DL3olXylJfTL/mXvMPqtnM5
 VIWuLWoxofm+QcKLiYA1PGdN54TxsytuEpXEYFuspW6AX4JTV8658Ytl1hlPLPycKr8u4EO3RIF
 FLtOzM6OmLHQqPEXpFtQBOXRtS7BQpHV9KdCqh50WIu+wHU7e0yvnFgNbIiTcAYqKYpBo46CdqR
 Zl87m4WW1dOTl0d2TGlngh8/eeC1OidTXFiKBkgbnnaDxbxNUAlehvd7u58ZmeviPPGMfpJtY4l
 r5JLkc/dy5JnnVhkdAPt4/g/gABBS9Q6ZlqBsvEe+dw2upYWoM+avdVM98X+yNaZNsChXZkhawx
 zzMZfvnUVii+NFtW5yKmS4M3hoM9U5NE9TuPc6EP8ioE2vHo54QJFoRUbDE+kNo3xB/a+vfIY5f
 dwj2TM6I66v4tq2UbQ3c513Myb2TQnscyyrQb2jtF8=
X-Received: by 2002:a05:6000:230c:b0:485:8a46:b3cc with SMTP id
 ffacd0b85a97d-4858a46b4fcmr2340611f8f.52.1788508635761; 
 Fri, 04 Sep 2026 00:57:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e8f4:b358:2087:5bd3?
 ([2a01:e0a:106d:1080:e8f4:b358:2087:5bd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm5363914f8f.12.2026.09.04.00.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 00:57:15 -0700 (PDT)
Message-ID: <bc3a2bb1-00f4-4c49-a85b-b38132b502b9@linaro.org>
Date: Fri, 4 Sep 2026 09:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/10] scsi: allow a controller to declare well known
 logical units
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, David Lechner
 <dlechner@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
 <20260904-ufs-spl-boot-wlu-v1-4-59aeea16c4de@flipper.net>
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
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-4-59aeea16c4de@flipper.net>
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

On 9/4/26 09:12, Alexey Charkov wrote:
> The scan walks a contiguous LUN range, so units that a bus places outside
> it stay unreachable. UFS puts its well known units at 0x80 and above, far
> past the ordinary maximum of 0x7f.
> 
> Let a controller list such units separately and probe them once the
> ordinary range is done, so that block devices already created keep the
> device numbers they had.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/scsi/scsi.c | 13 ++++++++++++-
>   include/scsi.h      |  4 ++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index a60843e505ea..55915a021864 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -685,6 +685,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
>   	int ret;
>   	int i;
>   	int lun;
> +	int j;
>   
>   	/* probe SCSI controller driver */
>   	ret = device_probe(dev);
> @@ -694,10 +695,20 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
>   	/* Get controller plat */
>   	uc_plat = dev_get_uclass_plat(dev);
>   
> -	for (i = 0; i < uc_plat->max_id; i++)
> +	for (i = 0; i < uc_plat->max_id; i++) {
>   		for (lun = 0; lun < uc_plat->max_lun; lun++)
>   			do_scsi_scan_one(dev, i, lun, false, verbose);
>   
> +		/*
> +		 * Well known units live outside the ordinary LUN range, and
> +		 * are scanned last so that they do not shift the device
> +		 * numbers of the units before them.
> +		 */
> +		for (j = 0; j < uc_plat->wlun_count; j++)
> +			do_scsi_scan_one(dev, i, uc_plat->wluns[j], true,
> +					 verbose);

Perhaps check uc_plat->wluns is not NULL ?

It's not a serious issue since only UFS will declare it, and it will be valid.

> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/include/scsi.h b/include/scsi.h
> index 72fb6e4bd90d..fea2d0152098 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -269,12 +269,16 @@ struct __packed scsi_write10_req {
>    * @max_lun: Maximum number of logical units
>    * @max_id: Maximum number of target ids
>    * @max_bytes_per_req: Maximum number of bytes per read/write request
> + * @wluns: Well known logical units to scan on top of 0..@max_lun - 1, or NULL
> + * @wlun_count: Number of entries in @wluns
>    */
>   struct scsi_plat {
>   	unsigned long base;
>   	unsigned long max_lun;
>   	unsigned long max_id;
>   	unsigned long max_bytes_per_req;
> +	const u8 *wluns;
> +	int wlun_count;
>   };
>   
>   /* Operations for SCSI */
> 

