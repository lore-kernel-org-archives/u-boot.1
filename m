Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC8606A31F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TZbMODqx;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n/bNm+0+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34AFF8120B;
	Thu, 22 Oct 2026 07:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYUgRwVSaDCv; Thu, 22 Oct 2026 07:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57484811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792655275;
	b=kWcXisshXDsWCQHBlc7hZulbY70jI4F/0T4+jLs450lk5iY0xTmMkRihCUqNt5feTGAJ
	 /EW16g7bKJ62g5HvZxjHnZoMP7jMb1EydmvRFnTuz9RNpFTGrNjQV32gVXjn7KPqt6e3L
	 0TGD8ZDnY1M2wtStRdepygIqEHIjj7/CyErhrWnILovBYjtbNl6hwtzpgiDpj2+O0QrzK
	 lext/d8Pd7SdMMKIbuVuyvi8cJowLRqgfZUBIbGJF7BxRWUrjFovMm5fO9dt/ROTHGump
	 pwD5VROjYlwwfwYxHOLSl686mf6LTReTxnvTRMHzTXkL9HvnQichVdlVfpftd6XmgWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792655275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=sqTX4rcObH5Y5eGH0KdiiJj7wXHwTNPQP93PmfeviJI=;
	b=ClPVi1Uiaf00g3ibYSq7uEUHETQ7k8sfG1qvX0eBMvm32FBAI66gHIlSSsEVY1P71uwx
	 RSMx6JOmjFpDDQnZ3+4/UFPxFXAWRyaVPxjMbR9YmYw95qfB5x+DSlqNeWWHr0cHOtnE/
	 LuVwYp6MFa3aby1XxrO0dPQbJttOfAXliiiC901X9N9JlnIsQzUYo4sKY289RNwxcnhpJ
	 JIxIwix/2DJPVLH1mFBXpNgAq/0c4TlKXrFqbZKxrcmhtiPCwvo8eephKdKXznPXzmdgA
	 UWeysxPut2Es3PYpYiqr1jv+9wTagZmGSx5BKu7ofyjwakyFc78EJ5uJL3bmQdIDNYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792655275;
	bh=sqTX4rcObH5Y5eGH0KdiiJj7wXHwTNPQP93PmfeviJI=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TZbMODqxN2DjgRG+rZ31ZIkHjBXOWzHw2dmxtzziy4NcIE5e5SliLRF2pf8Z7JF5K
	 YUE0CjO3juSO2k4i8qirGKRmk5MS4huzfwBMrsz4r024hKVDLR6g5tGOTlbSC39mRo
	 C4LnWRgpzvDRYz4OvkDzCAMjArwrJbMM5c7wAH3lntTXTZNZRb1uqeLgZAMxwZmvpF
	 Vm+V0Ou5WF55gs6uQzX4BkfbrqcwB4RI0a+3C5XDyHXNXKonm+E/cbhPReUNtYUpp1
	 xAltUzSu8t5p0WDztsT84KHmHz7NMrqL8MF44EkFmYN5upwpifp5dbwIaIm4z/tee9
	 P4/gT3O6QppWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57484811F8;
	Thu, 22 Oct 2026 07:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E60173C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBB5C4089C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gf_Bg33lin38 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2F1C4050D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792655272;
 b=iJvdod7m5HVXSe6udMzPfulbe6uq63MAuZkHk35dWpej6QHTn40cbA/VP4sKSmx0emvl
 zHFIwzwEB0aHQ9GiXl/wNV+gkLkx9gbo2rWXX3l1qcaMt3xSOWXVlG84BAa7kZb8B+ch5
 6P+C7a6Vx6omYzN5W5Ng7k1DTvaCzSsfN93TUdrcE9vNPXwVEnGXS+UvPjIVP578wB6Ft
 6UtKr/66UJGLutEfn+9HH3elbUix8C3DSVgZXj9Vm3325JAky0xjtA06vUkUg53bHUmou
 e0p5TxvlQFLogZGkodcjF2NtzeaNg78F4D0kj6Wt75i+2xbljc6ylIEAR5qwhvnEMbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792655272;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=sqTX4rcObH5Y5eGH0KdiiJj7wXHwTNPQP93PmfeviJI=;
 b=JH5KeXfi7Tgy6ndKdyZ75alfPYK7Jf+ol+glP11lv/whr6o6idk7PAtcj70tXBKrBcvs
 IdeawDwhSTLpJHiq6N7wG5xFsT+FxtrWoUzcTRQOmgEgwrAxe7eN4PR3pzzsSBgTUuLOM
 dY6zPDG1tQ5XYbndJDoycXrkSER1vBUaGSW+fMVH5oXRfYGzQtLbiTyOzp6SSnOC8ijgj
 bzpNv1uX6GbIJsIk0zzZ2DE6WOqgfPAZgCyREv1Iwfk8Ib+bOQekQ+9aIrNN88raCiQcY
 rdUJT7cuEt0tiZGBTYob6lQJGC05m/vo3zxwGXgs5TqYgzYEn+syXEz9wyzp/RnQytg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="n/bNm+0+"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=n/bNm+0+
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2F1C4050D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:47:51 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so15535945e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792655269; x=1793260069;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqTX4rcObH5Y5eGH0KdiiJj7wXHwTNPQP93PmfeviJI=;
 b=n/bNm+0+NuJa+SlGgB6J9e4ZQ5Ih33EVapgDK/cxP6gfb4ji9y9NnAe17s86F9p7Fy
 9nILlRaWUf99QsymM4vVYvAS788g+pKPhReDsD25jzoScmfPnlSjTLcO41Ll6Qfik8gO
 2wgN5j56ZOg/pJxHczrW5JVeODkfDFos/2I5TxoRXB3ELD84xoOROTZNK3xi9ax9QiLs
 1fiRr4miHgxySER7QckGViBLzw/MjivQEqHb4TctpJz2u77g1UhWY4XyT9zPW/jjotQD
 LZktV8L0+MEw2jAfW91j+ev+S6npN+GPZxaUa0UT6/Ld4VCNG0VQL7p+dSiBfrzlelv7
 1Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655269; x=1793260069;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqTX4rcObH5Y5eGH0KdiiJj7wXHwTNPQP93PmfeviJI=;
 b=bOX60fiyuPgIsg5LSf4wHmNCqYdXczApO0idJ+Vyky8CV7OPuxaWFOfRNJRDiXArK2
 GAk0DbHtWetA6AbhnP//3Xqj+kAquT7nb/CvN9odc5qf/8271UN33XEmqGKmmW8xiux2
 A/bhqrD0pgJirWXZ3kVtEMlok9rLoYT89ULo21AT2c2EbVv7g0jG/niUUyIv4buG/+tF
 627MbEo5GnqPJ6s+EXAldNkEDtd3xZKK4Go8sc+W2lLnnSjCbaMlAIRZ0xfwUP0v30xo
 97vgV4ci7gHlI6Ky0MC2g4vnEayIF0j8LJmDyYAO8O2T9GBHwA0c+LBgANiG3MKqRQBw
 ofmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuWFexbEbi1BWZ1o/96BMt6sOSc7kuBY4wUqRHJhWuKv5rir25cTna2OT7my1PYg1lhFtMWkc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJyvD83whwHlsJwEcqG0+n5lKXheOoqTiqmuUX9CzBbjvZJTE9N
 M1sXaB+Z0+rkjgZ5s7cVYheAAuMukOB129CoeD1ZnuZKDjJHQz5H97HmG+5VFimGVzFTJcxRvYl
 H3LJo
X-Gm-Gg: AYBFou1DYhYavpug4L8EEi9gd5ZvkBbN4kGAIamRZNBQFdixx/sqiko2plfATWk/v/q
 FjbYMhm0xEYhWNKZB7P89qH9mMcAyL3C7K65BzcNxe3RKe6YCPO8B/AsaPjj+vdRRvIrLYuJVQx
 SeAEStcEQkJ1CgXocixkMabTeCmiF6WMQTc1bQunFogck2Kank0ow0pj4r9TIA9JYGsdvmmOE9+
 0Gjw8AsPjbNUcj3Nwag+CleN33UjC5mZhipsxY/nRkg99Q2/JUd2oGCsvci8F9CW/6kJBWrG/vQ
 /oZHE2wMMoAO7bglDenSlEa9NU/9+3AUwETJ3Ct2LouCEwoORZLldAz/DK8/o9QgtT4E3nUjSoq
 TWt2pMbegzXJdHtR8Ghe74nRv5AEHJ1JeAJBXRg61m9xtKDfWVFfeD3mac+TYtNHqrWmIWfmevA
 otVs03FUK1oBJFSMC8LeSkkzUUydJDS6Oui0yYvdIACp3oQ8pHTB2hlddQg5F4oOLjYk5MBJyhc
 HGLTEDeDGBebiFgg80y6WFYnOBKvUyQ86pt+GvtQXtB0S00ytCdcUJcxMRkxUAjvyrXKDqzmSwR
 OFXWMPVaJth9ezl3dCJu80JYrX7gFYHTmy4=
X-Received: by 2002:a05:600c:3512:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4a1fdb128f8mr87214035e9.21.1792655268862; 
 Thu, 22 Oct 2026 00:47:48 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:211e:45da:8a88:2665?
 ([2a01:cb1c:fcf:4600:211e:45da:8a88:2665])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254eeef6sm10789382f8f.8.2026.10.22.00.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:47:48 -0700 (PDT)
Message-ID: <1a3bfe51-c21b-401e-ac72-d12a7a6f15d8@linaro.org>
Date: Thu, 22 Oct 2026 09:47:48 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 05/12] phy: qcom: add QMP USB3 PHY driver for Shikra
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 lukma@nabladev.com, marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/21/26 18:09, Aswin Murugan wrote:
> Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells = <0>),
> which is not supported by the existing QMP combo PHY driver.
> 
> Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
> initialization sequence and configuration tables from Linux
> drivers/phy/qualcomm/usbphy-qcom-qmp-c.c. The driver is selected
> through PHY_QCOM_QMP_USB3_LEGACY and enables USB3 PHY bring-up on
> Shikra platforms.

Why LEGACY ? While looking at the Linux patches, I only found [1] which adds
the usb-dp phy in the usbc driver (qcom,shikra-qmp-usb3-dp-phy).
Add a proper "phy-qcom-qmp-usbc.c" like on Linux and name it USBC instead of LEGACY.

[1] https://lore.kernel.org/all/20260712-usb-shikra-phy-v6-v6-0-1b3e51bf1541@oss.qualcomm.com/

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/Kconfig                    |   7 +
>   drivers/phy/qcom/Makefile                   |   1 +
>   drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c | 534 ++++++++++++++++++++
>   3 files changed, 542 insertions(+)
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 1fdadaccb12..ffb523fffbb 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
>   	help
>   	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>   
> +config PHY_QCOM_QMP_USB3_LEGACY
> +	bool "Qualcomm QMP USB3-only legacy PHY driver"
> +	depends on PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the legacy USB3-only QMP PHY (v3) found on
> +	  older Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
> +
>   config PHY_QCOM_QUSB2
>   	bool "Qualcomm USB QUSB2 PHY driver"
>   	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 714013dc572..dfad1f1e56a 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>   obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
>   obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
>   obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
> +obj-$(CONFIG_PHY_QCOM_QMP_USB3_LEGACY) += phy-qcom-qmp-usb3-legacy.o
>   obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>   obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
> new file mode 100644
> index 00000000000..d1aad6e7952
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <dm/uclass.h>
> +#include <generic-phy.h>
> +#include <reset.h>
> +#include <power/regulator.h>
> +#include <usb/tcpm.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/err.h>
> +
> +#include "phy-qcom-qmp-common.h"
> +
> +#include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-pcs-misc-v3.h"
> +
> +/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, legacy USB3-only PHY */
> +#define SW_PORTSELECT_MUX			BIT(1)
> +#define SW_PORTSELECT_VAL			BIT(0)
> +
> +#define PHY_INIT_COMPLETE_TIMEOUT		10000
> +
> +#define RESET_SETTLE_DELAY_US			10
> +
> +struct qmp_usb3_legacy_offsets {
> +	u16 serdes;
> +	u16 tx;
> +	u16 rx;
> +	u16 tx2;
> +	u16 rx2;
> +	u16 pcs;
> +	u16 pcs_misc;
> +};
> +
> +static const struct qmp_usb3_legacy_offsets qmp_usb3_legacy_offsets_qcm2290 = {
> +	.serdes		= 0x000,
> +	.tx		= 0x200,
> +	.rx		= 0x400,
> +	.tx2		= 0x600,
> +	.rx2		= 0x800,
> +	.pcs_misc	= 0xa00,
> +	.pcs		= 0xc00,
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> +};
> +
> +/* Per-compatible config; add a new instance here to support another SoC */
> +struct qmp_usb3_legacy_cfg {
> +	const struct qmp_usb3_legacy_offsets *offsets;
> +
> +	const struct qmp_phy_init_tbl *serdes_tbl;
> +	int serdes_tbl_num;
> +	const struct qmp_phy_init_tbl *tx_tbl;
> +	int tx_tbl_num;
> +	const struct qmp_phy_init_tbl *rx_tbl;
> +	int rx_tbl_num;
> +	const struct qmp_phy_init_tbl *pcs_tbl;
> +	int pcs_tbl_num;
> +
> +	/* clock names fetched by clk_get_by_name(); "pipe" is fetched separately */
> +	const char * const *clk_list;
> +	int num_clks;
> +
> +	const char * const *vreg_list;
> +	int num_vregs;
> +};
> +
> +static const char * const shikra_usb3_clk_l[] = {
> +	"cfg_ahb", "ref", "com_aux",
> +};
> +
> +static const struct qmp_usb3_legacy_cfg shikra_usb3phy_cfg = {
> +	.offsets	= &qmp_usb3_legacy_offsets_qcm2290,
> +	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
> +	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
> +	.tx_tbl		= qcm2290_usb3_tx_tbl,
> +	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
> +	.rx_tbl		= qcm2290_usb3_rx_tbl,
> +	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
> +	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
> +	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +	.clk_list	= shikra_usb3_clk_l,
> +	.num_clks	= ARRAY_SIZE(shikra_usb3_clk_l),
> +	.vreg_list	= NULL,
> +	.num_vregs	= 0,
> +};
> +
> +static const char * const talos_usb3_clk_l[] = {
> +	"aux", "ref", "cfg_ahb",
> +};
> +
> +static const char * const talos_usb3_vreg_l[] = {
> +	"vdda-phy-supply", "vdda-pll-supply",
> +};
> +
> +static const struct qmp_usb3_legacy_cfg talos_usb3phy_cfg = {
> +	.offsets	= &qmp_usb3_legacy_offsets_qcm2290,
> +	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
> +	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
> +	.tx_tbl		= qcm2290_usb3_tx_tbl,
> +	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
> +	.rx_tbl		= qcm2290_usb3_rx_tbl,
> +	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
> +	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
> +	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +	.clk_list	= talos_usb3_clk_l,
> +	.num_clks	= ARRAY_SIZE(talos_usb3_clk_l),
> +	.vreg_list	= talos_usb3_vreg_l,
> +	.num_vregs	= ARRAY_SIZE(talos_usb3_vreg_l),
> +};
> +
> +struct qmp_usb3_legacy {
> +	struct udevice *dev;
> +	void __iomem *serdes;
> +	void __iomem *tx;
> +	void __iomem *rx;
> +	void __iomem *tx2;
> +	void __iomem *rx2;
> +	void __iomem *pcs;
> +	void __iomem *pcs_misc;
> +	struct clk *clks;
> +	struct clk pipe_clk;
> +	int num_clks;
> +	struct reset_ctl_bulk resets;
> +	struct udevice **vregs;
> +	int num_vregs;
> +	const struct qmp_usb3_legacy_cfg *cfg;
> +};
> +
> +static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg |= val;
> +	writel(reg, base + offset);
> +	readl(base + offset);
> +}
> +
> +static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg &= ~val;
> +	writel(reg, base + offset);
> +	readl(base + offset);
> +}
> +
> +/* Quiesce the PHY; shared by power_off() and power_on()'s error path */
> +static void qmp_usb3_legacy_quiesce(struct qmp_usb3_legacy *qmp)
> +{
> +	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
> +	qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
> +	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +}
> +
> +/* Fixed orientation by default; use TCPM orientation if available */
> +static u32 qmp_usb3_legacy_get_portselect(struct qmp_usb3_legacy *qmp)
> +{
> +	u32 val = SW_PORTSELECT_MUX;
> +
> +	if (IS_ENABLED(CONFIG_TYPEC_TCPM)) {
> +		struct udevice *tcpm_dev;
> +		enum typec_orientation orientation;
> +		int ret;
> +
> +		ret = uclass_first_device_check(UCLASS_TCPM, &tcpm_dev);
> +		if (!ret && tcpm_dev) {
> +			orientation = tcpm_get_orientation(tcpm_dev);
> +			if (orientation == TYPEC_ORIENTATION_REVERSE)
> +				val |= SW_PORTSELECT_VAL;
> +		}
> +	}
> +
> +	return val;
> +}
> +
> +static int qmp_usb3_legacy_power_on(struct phy *phy)
> +{
> +	struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
> +	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
> +	void __iomem *status;
> +	u32 val;
> +	int ret;
> +
> +	qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +
> +	writel(qmp_usb3_legacy_get_portselect(qmp), qmp->pcs_misc);
> +
> +	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
> +
> +	ret = clk_enable(&qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
> +	qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
> +
> +	qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
> +	qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
> +
> +	qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> +
> +	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
> +
> +	qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
> +
> +	status = qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
> +	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
> +				 PHY_INIT_COMPLETE_TIMEOUT);
> +	if (ret) {
> +		dev_err(qmp->dev, "phy initialization timed-out\n");
> +		clk_disable(&qmp->pipe_clk);
> +		qmp_usb3_legacy_quiesce(qmp);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmp_usb3_legacy_power_off(struct phy *phy)
> +{
> +	struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
> +
> +	clk_disable(&qmp->pipe_clk);
> +	qmp_usb3_legacy_quiesce(qmp);
> +
> +	return 0;
> +}
> +
> +static void qmp_usb3_legacy_clk_disable_upto(struct qmp_usb3_legacy *qmp, int upto)
> +{
> +	int i;
> +
> +	for (i = 0; i < upto; i++)
> +		clk_disable(&qmp->clks[i]);
> +}
> +
> +static int qmp_usb3_legacy_clk_init(struct qmp_usb3_legacy *qmp)
> +{
> +	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
> +	struct udevice *dev = qmp->dev;
> +	int num = cfg->num_clks;
> +	int i, ret;
> +
> +	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
> +	if (!qmp->clks)
> +		return -ENOMEM;
> +
> +	qmp->num_clks = 0;
> +
> +	for (i = 0; i < num; i++) {
> +		ret = clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks[i]);
> +		if (ret) {
> +			dev_err(dev, "failed to get %s clock: %d\n",
> +				cfg->clk_list[i], ret);
> +			qmp_usb3_legacy_clk_disable_upto(qmp, i);
> +			return ret;
> +		}
> +
> +		ret = clk_enable(&qmp->clks[i]);
> +		if (ret) {
> +			dev_err(dev, "failed to enable %s clock: %d\n",
> +				cfg->clk_list[i], ret);
> +			qmp_usb3_legacy_clk_disable_upto(qmp, i);
> +			return ret;
> +		}
> +	}
> +	qmp->num_clks = num;
> +
> +	ret = clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to get pipe clock: %d\n", ret);
> +		qmp_usb3_legacy_clk_disable_upto(qmp, qmp->num_clks);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmp_usb3_legacy_vreg_init(struct qmp_usb3_legacy *qmp)
> +{
> +	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
> +	struct udevice *dev = qmp->dev;
> +	int i, ret;
> +
> +	qmp->num_vregs = 0;
> +
> +	if (!cfg->num_vregs)
> +		return 0;
> +
> +	qmp->vregs = devm_kcalloc(dev, cfg->num_vregs, sizeof(*qmp->vregs), GFP_KERNEL);
> +	if (!qmp->vregs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cfg->num_vregs; i++) {
> +		ret = device_get_supply_regulator(dev, cfg->vreg_list[i], &qmp->vregs[i]);
> +		if (ret) {
> +			dev_err(dev, "failed to get regulator %s: %d\n",
> +				cfg->vreg_list[i], ret);
> +			return ret;
> +		}
> +	}
> +
> +	qmp->num_vregs = cfg->num_vregs;
> +	return 0;
> +}
> +
> +static int qmp_usb3_legacy_vreg_enable(struct qmp_usb3_legacy *qmp)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < qmp->num_vregs; i++) {
> +		ret = regulator_set_enable(qmp->vregs[i], true);
> +		if (ret) {
> +			dev_err(qmp->dev, "failed to enable regulator %d: %d\n", i, ret);
> +			while (--i >= 0)
> +				regulator_set_enable(qmp->vregs[i], false);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void qmp_usb3_legacy_vreg_disable(struct qmp_usb3_legacy *qmp)
> +{
> +	int i;
> +
> +	for (i = qmp->num_vregs - 1; i >= 0; i--)
> +		regulator_set_enable(qmp->vregs[i], false);
> +}
> +
> +static int qmp_usb3_legacy_parse_dt(struct qmp_usb3_legacy *qmp)
> +{
> +	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
> +	const struct qmp_usb3_legacy_offsets *offs = cfg->offsets;
> +	struct udevice *dev = qmp->dev;
> +	void __iomem *base;
> +	int ret;
> +
> +	base = (void __iomem *)dev_read_addr(dev);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	qmp->serdes = base + offs->serdes;
> +	qmp->tx = base + offs->tx;
> +	qmp->rx = base + offs->rx;
> +	qmp->tx2 = base + offs->tx2;
> +	qmp->rx2 = base + offs->rx2;
> +	qmp->pcs = base + offs->pcs;
> +	qmp->pcs_misc = base + offs->pcs_misc;
> +
> +	ret = qmp_usb3_legacy_vreg_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmp_usb3_legacy_vreg_enable(qmp);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_get_bulk(dev, &qmp->resets);
> +	if (ret) {
> +		dev_err(dev, "failed to get resets: %d\n", ret);
> +		goto err_disable_vregs;
> +	}
> +
> +	ret = reset_assert_bulk(&qmp->resets);
> +	if (ret) {
> +		dev_err(dev, "failed to assert resets: %d\n", ret);
> +		goto err_disable_vregs;
> +	}
> +
> +	udelay(RESET_SETTLE_DELAY_US);
> +
> +	ret = reset_deassert_bulk(&qmp->resets);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert resets: %d\n", ret);
> +		goto err_assert_resets;
> +	}
> +
> +	ret = qmp_usb3_legacy_clk_init(qmp);
> +	if (ret)
> +		goto err_assert_resets;
> +
> +	return 0;
> +
> +err_assert_resets:
> +	reset_assert_bulk(&qmp->resets);
> +err_disable_vregs:
> +	qmp_usb3_legacy_vreg_disable(qmp);
> +
> +	return ret;
> +}
> +
> +static int qmp_usb3_legacy_probe(struct udevice *dev)
> +{
> +	struct qmp_usb3_legacy *qmp = dev_get_priv(dev);
> +
> +	qmp->dev = dev;
> +	qmp->cfg = (const struct qmp_usb3_legacy_cfg *)dev_get_driver_data(dev);
> +	if (!qmp->cfg) {
> +		dev_err(dev, "failed to get PHY configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	return qmp_usb3_legacy_parse_dt(qmp);
> +}
> +
> +static struct phy_ops qmp_usb3_legacy_ops = {
> +	.power_on = qmp_usb3_legacy_power_on,
> +	.power_off = qmp_usb3_legacy_power_off,
> +};
> +
> +static const struct udevice_id qmp_usb3_legacy_ids[] = {
> +	{
> +		.compatible = "qcom,shikra-qmp-usb3-phy",
> +		.data = (ulong)&shikra_usb3phy_cfg,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qcom_qmp_usb3_legacy_phy) = {
> +	.name = "qcom-qmp-usb3-legacy-phy",
> +	.id = UCLASS_PHY,
> +	.of_match = qmp_usb3_legacy_ids,
> +	.ops = &qmp_usb3_legacy_ops,
> +	.probe = qmp_usb3_legacy_probe,
> +	.priv_auto = sizeof(struct qmp_usb3_legacy),
> +};

