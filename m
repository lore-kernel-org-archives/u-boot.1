Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A6606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tn2Or8Ok;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NGXP7WdY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0873F408C4;
	Thu, 22 Oct 2026 07:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOyxbC9ik33T; Thu, 22 Oct 2026 07:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B648C4077B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792655360;
	b=NjZpqOEF5N0a4vjEwXseJnDbeKy0QKWPmHwxBs2Ax4FhxOiKKW/2OEyfnqDhSwQw5PhI
	 La1/dJJKesbmAYkl05gLyUlS1FkSijLHKQ+FDx4EIbAq7jJc0yLR6Xu0+fkXLaqA/ig+T
	 zn5xAr7AAj9WFMQH98zTz5FfUgFA5rfdHQCn6IJle5w/pKaoYz787zkS3tZSvMZ7vc9Hl
	 aMd8gtpfXU8NzgpGY3wjg0UBmdy2hdlPZhp/WlSrqXlXwqUdi3TJcYeBu5UkKTtVA3lwz
	 lwPFh7ySsR5A5do3rhyFkS7dzzcd8w/1l/RSAq8H6JJWX7lx6762Ew2LUvUUKyv/87g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792655360;
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
	bh=Bc1lxAlKj8D+eYEvLRmawPbvf7ggT9xrwz1NwPS/uDc=;
	b=sbCFekS/khbvc8KNwFGrtP29Sxt/8Y2iZF0WppxtBKxTZdVvtrs4MQ/ilDU7N7HHgA6H
	 SZfniXAHLP/Yl/9UI0fPri1Qa7RlzxtmthZNj6aLOWJrVwz2zpd3NsFFZBxgMQXI5BLCG
	 fgCYtBruSiIODZaPMIck35I7yrGJ7JNiwazYJjuMSUX7FZRd0nkdeeS/irAwjvGm6MR19
	 kFgudqkzxQup0D5BwQ6QO+L3woj1oWqbTQ43GNCWOgH++P7nJujeSSp0vIuVsmEtN1Qzv
	 tKrs6ICPGc7BpZJItlfAdnR4rbBMRZYSPHq640qNXb0MkbD+qNP8VXX6sDMwSoHSdLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792655360;
	bh=Bc1lxAlKj8D+eYEvLRmawPbvf7ggT9xrwz1NwPS/uDc=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Tn2Or8OkQBpnjqP0aA/D5j1xe2Xltf9vvq9YCOk0Lj5LPVDibYxxxW+vRnsnoV8Tk
	 aZ8FrDK/nnqtJrKsrWtNl2IhXhhkpxcKN3CPjI20R3yJ8Rp44aDeSLMieQO+nprEOR
	 2wW6/uzfkzakAvu2Yzj9HblBaS61Q23w5JJGE/9RdYmvC4057lLL45jNdPqZ73QogR
	 Z1kUQls91jyjmZ7ibvZDB/bJchqz62ysk/I/L2ik/DzKsI4m4z27cwaURhuoYapnZD
	 4UJ71cmnsUIN9NpIcU0qn0EMEFRjkAPTQymlypXPovdwaUm9oWAKmZJj3ebGLvORn+
	 mNoFFbmdfaMmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B648C4077B;
	Thu, 22 Oct 2026 07:49:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1178235
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B393B607C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6XjCxF0VRXX for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A8E36066A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792655357;
 b=WI4HFjTlLnqczEVh6eVrqBMPlQldbl/DPXniMYA+xLVXie5DCJ/br7zx561mWTHFzUly
 zWGHzaEICDtuSwgvAAc3/KX088B6Yy9pQj/VHW1Lo7y4/gozHZEspwl+ujApgKc3nCBHn
 qR2RTWbn5rMX9b8Uti2uutf4Q9aAziiXeqrYfLxt5HXoJ7ncpsgucY7giz8kcEWX6eObF
 QsKhANomq6+EnbF0ASMxyA0pmoNQFVdRjQ4kin87ZM9mC5QbtCN1dVQINelywz/qBUxkU
 Kee+XvT1glbh97e6vh0N/Pw5CGf01YXK4otoryw0q6DIaXY90jn1/WKAbcPqTmh3ZqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792655357;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Bc1lxAlKj8D+eYEvLRmawPbvf7ggT9xrwz1NwPS/uDc=;
 b=USTxBuno3mhc25ddGzC4MHylOPeApv3UEvGd+HcBTIglS/3l18PwxhUwiJ/ta9bG3/eT
 ilgiQKdX0heepH6u48HL7ouQIZEyapZ11jRvjmjh+R/qA/0qWOnDmaCbjF/Cqt0rjol/f
 1ZqbLgOh77S2r9n48Z/PBR5s2LLuRpJ6hWMthwxjgDnSKxgF1ThsTOqLizXeptKaM1Rm2
 kxXyLYdy5ILInhrAXJkkLLGFje0iGmVx7t3Eh9/26i6N9JXMohzTn1tPtx32NZzUKDxFz
 s1MEw5SMRFRzL0NM0ohIqh0Lvja3BRzVepZOcPLmZF4zmW2VY90kpOLW0JWS4H5idyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NGXP7WdY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=NGXP7WdY
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A8E36066A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:49:16 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso993932f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792655355; x=1793260155;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bc1lxAlKj8D+eYEvLRmawPbvf7ggT9xrwz1NwPS/uDc=;
 b=NGXP7WdYWFZUXJNoLRoHgHqLiowtKRBnueV/9q+WQLQkqVDy0KTadKJAgYM8rdIV9q
 9VoK7qEBZtF82dcMFQhK9akFTc1gkf//9cagRToe2XYVL20xcwmW1FgRu1ilNw7rENGY
 eyvVfHGnn99Uv5k3Zx0pfj2P3R+xJ5zrqPr159WnIcU5GTHvXPM0uq345k9j+PdpyaV0
 amcWyLn29/MPuIzcUPnRbz7B8zfxDeaDjj4SOz6NvK9XI3QWbmw2QnNWxVG/kvScWMip
 AeJpFrgQgjEiW6cj4R5QZWSmWfUPEc6+oLMI2JBXpMAnY9Dd90lyFU62KQnFEpySDagY
 7xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655355; x=1793260155;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bc1lxAlKj8D+eYEvLRmawPbvf7ggT9xrwz1NwPS/uDc=;
 b=10X95xg/wdebcAhQ9pULAzYRGjxl12T8tnZCXr11ZCkbAioH8jsy2IUr6d7oLcRahW
 HsaGFRc2PoZuut8QhdSRScvptTmZ8o5IPKLoMJR2BD8yRMUoJHayGQwvtVWgvRpW0Cko
 FI1a9DR8f5vah470RHq8x48WOrT1RBIbnmJqYAzlmnO82/wvCvQELTxjGJJ98kn5HoNI
 yTjLLCzJIceEgPSmR+YJWn3Ba76VPcu9xjAgv1d4Srs+HFOm5TqwbRtcPp8MB6T/as1/
 F+eFaW/+rdhaHFNLu4JcmBtw8Zw6dZ3lsenl9NIHHbSBAiM+LbedJNqoXhOCb+iCjKbo
 jZpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKYdA6j9wGzc8ANtSE7ab+ic/BFa4icHAXyF/WURXzkEpw5jUNZWhGL4DzST5rMiIGFZpyMX0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIEi8WNVVlbWKxQdXyHq51ls0L0zXCz3n+jOaXchr1AG3YrWa0B
 HssyC+3DmXPSsz8eSoMR9KpE3Pi6cZOCFDvFWsFg075adttC5n3FPUkjk0c4l4dzSLE=
X-Gm-Gg: AYBFou0Am9NEgltiF5X7MmHRGltx6wTkG3XfEmJzURQnIYO1hRwmPEd1lKfj2gfyF6r
 P80hmq3nAorg4R0XF/TlklUOiLRtmgpwitMOZ0PpPTTTA8ioqoWupTy+U1G5QOs0v1NEpvnd4aD
 4Bh8yHrJ2TXTgwAfHKzexSNwfFv1JobjaB40eT9QN5WG67Mmec+3cFnhQZeKbtYvzHfDy5n9cCz
 qmbtMhDTAFtXI6T1dWcHi7/QmwdOcDGU52hBso/OnD5eJcDGTAWWQypP4ypBeuqOJitjGTqGs7h
 lsJ8NE/yc0+oRuTnsHWF45orxVKl8mC5npbg5f8zdwqeKF27/8lEjB02e6OmGEkeFTlodC24NcR
 OXJUqOoSTG5YnmDZLYOVfxX/0MqVXZygRzBgrebVUJyZet7o3ls79jLm7Yvv9VjNGQz8mmkR50p
 6oHDcSi/DZy8Amels1DrjXjudFO3nKKWlVwlV4ojxhWyv8vOZ6ODMwWHaAM51Jaf0ztaQoREmT7
 udPh5GKEtb9cJrQ/JmU53h2/yTRbCCvk9ENjVZR12xh1SHsIEQUbWJil7O6X4V5VKZuCt7QeHpT
 3YTShk3OKEeHZa0AN7hDL5Dlw+cvBCqnZo4=
X-Received: by 2002:a05:6000:161b:b0:48c:7caa:12cd with SMTP id
 ffacd0b85a97d-48e264b1606mr6142307f8f.22.1792655354474; 
 Thu, 22 Oct 2026 00:49:14 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:211e:45da:8a88:2665?
 ([2a01:cb1c:fcf:4600:211e:45da:8a88:2665])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10548454f8f.41.2026.10.22.00.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:49:14 -0700 (PDT)
Message-ID: <a8c912d2-748d-4f4d-9acd-99924c54837e@linaro.org>
Date: Thu, 22 Oct 2026 09:49:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 01/12] clk: qcom: add GCC clock driver support for
 shikra SoC
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 lukma@nabladev.com, marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-2-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20261021160916.3894471-2-aswin.murugan@oss.qualcomm.com>
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

On 10/21/26 18:09, Aswin Murugan wrote:
> Add initial support for the Global Clock Controller (GCC) on
> Qualcomm Shikra SoC.
> 
> This introduces a new clock driver (clock-shikra.c) implementing
> the required clocks for early boot and peripheral enablement.
> Update Kconfig and Makefile to include the Shikra GCC clock
> driver in the build.
> 
> The driver currently provides basic clock definitions required
> for system initialization.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/Kconfig        |   8 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-shikra.c | 344 ++++++++++++++++++++++++++++++++
>   3 files changed, 353 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-shikra.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 95b650831a3..1a7957e2201 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SDM845
>   	  on the Snapdragon 845 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SHIKRA
> +	bool "Qualcomm Shikra GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Shikra SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SM6115
>   	bool "Qualcomm SM6115 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1adca029b11..58d8166072d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>   obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
> +obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>   obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
>   obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
> diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
> new file mode 100644
> index 00000000000..2c3c5c9b4d8
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-shikra.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,shikra-gcc.h>
> +#include "clock-qcom.h"
> +
> +#define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
> +#define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
> +#define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
> +#define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
> +#define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
> +
> +static const struct pll_vote_clk gpll6_vote_clk = {
> +	.status = 0x6024,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x79000,
> +	.vote_bit = BIT(6),
> +};
> +
> +static const struct pll_vote_clk gpll7_vote_clk = {
> +	.status = 0x7024,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x79000,
> +	.vote_bit = BIT(7),
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
> +	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
> +	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
> +	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
> +	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
> +	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
> +	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
> +	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static ulong shikra_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP0_S0_CLK:
> +		/*
> +		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
> +		 * GPLL6-sourced; vote defensively even though this port's
> +		 * only requested rate (debug_uart_clock, 14745600) resolves
> +		 * to the GPLL0-sourced entry.
> +		 */
> +		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		clk_rcg_set_rate(priv->base, GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
> +				 0, CFG_CLK_SRC_CXO);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000,
> +		     "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +				 0, CFG_CLK_SRC_CXO);
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk shikra_clks[] = {
> +	GATE_CLK(GCC_AHB2PHY_CSI_CLK, 0x1d004, BIT(0)),
> +	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),
> +	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x7900c, BIT(1), 0x23004),
> +	GATE_CLK(GCC_CAMSS_AXI_CLK, 0x58044, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CAMNOC_ATB_CLK, 0x5804c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CAMNOC_DRAGONLINK_ATB_CLK, 0x58060, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CAMNOC_NTS_XO_CLK, 0x58050, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CCI_0_CLK, 0x56018, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CPHY_0_CLK, 0x52088, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CPHY_1_CLK, 0x5208c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CSI0PHYTIMER_CLK, 0x45018, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_CSI1PHYTIMER_CLK, 0x45034, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_MCLK0_CLK, 0x51018, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_MCLK1_CLK, 0x51034, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_MCLK2_CLK, 0x51050, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_MCLK3_CLK, 0x5106c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_NRT_AXI_CLK, 0x58054, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_OPE_AHB_CLK, 0x5503c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_OPE_CLK, 0x5501c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_RT_AXI_CLK, 0x5805c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_0_CLK, 0x5201c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_0_CPHY_RX_CLK, 0x5207c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_0_CSID_CLK, 0x520ac, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_1_CLK, 0x5203c, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_1_CPHY_RX_CLK, 0x52080, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TFE_1_CSID_CLK, 0x520cc, BIT(0)),
> +	GATE_CLK(GCC_CAMSS_TOP_AHB_CLK, 0x58028, BIT(0)),
> +	GATE_CLK_POLLED(GCC_CAM_THROTTLE_NRT_CLK, 0x79004, BIT(16), 0x17070),
> +	GATE_CLK_POLLED(GCC_CAM_THROTTLE_RT_CLK, 0x79004, BIT(15), 0x1706c),
> +	GATE_CLK(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x111c4, BIT(0)),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a07c, BIT(0)),
> +	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK, 0x71000, BIT(0)),
> +	GATE_CLK(GCC_DDRSS_MEMNOC_PCIE_SF_CLK, 0x29044, BIT(0)),
> +	GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC, 0x79004, BIT(11)),
> +	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0x17020, BIT(0)),
> +	GATE_CLK_POLLED(GCC_DISP_THROTTLE_CORE_CLK, 0x79004, BIT(13), 0x17064),
> +	GATE_CLK(GCC_EMAC0_AHB_CLK, 0xad010, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_AXI_CLK, 0xad014, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_AXI_SYS_NOC_CLK, 0x109d4, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_RX_CLK, 0xad044, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_TX_CLK, 0xad03c, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_PHY_AUX_CLK, 0xad018, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_PTP_CLK, 0xad034, BIT(0)),
> +	GATE_CLK(GCC_EMAC0_RGMII_CLK, 0xad038, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_AHB_CLK, 0xae010, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_AXI_CLK, 0xae014, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_AXI_SYS_NOC_CLK, 0x109f4, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_RX_CLK, 0xae044, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_TX_CLK, 0xae03c, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_PHY_AUX_CLK, 0xae018, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_PTP_CLK, 0xae034, BIT(0)),
> +	GATE_CLK(GCC_EMAC1_RGMII_CLK, 0xae038, BIT(0)),
> +	GATE_CLK(GCC_GP1_CLK, 0x4d000, BIT(0)),
> +	GATE_CLK(GCC_GP2_CLK, 0x4e000, BIT(0)),
> +	GATE_CLK(GCC_GP3_CLK, 0x4f000, BIT(0)),
> +	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x7900c, BIT(18)),
> +	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x7900c, BIT(19)),
> +	GATE_CLK(GCC_GPU_MEMNOC_GFX_CLK, 0x3600c, BIT(0)),
> +	GATE_CLK(GCC_GPU_SMMU_VOTE_CLK, 0x7d000, BIT(0)),
> +	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x36018, BIT(0)),
> +	GATE_CLK_POLLED(GCC_GPU_THROTTLE_CORE_CLK, 0x7900c, BIT(21), 0x36048),
> +	GATE_CLK(GCC_MMU_TCU_VOTE_CLK, 0x7d06c, BIT(0)),
> +	GATE_CLK_POLLED(GCC_PCIE_AUX_CLK, 0x79018, BIT(0), 0xaf044),
> +	GATE_CLK_POLLED(GCC_PCIE_CFG_AHB_CLK, 0x7900c, BIT(27), 0xaf010),
> +	GATE_CLK(GCC_PCIE_CLKREF_EN, 0xb8000, BIT(0)),
> +	GATE_CLK_POLLED(GCC_PCIE_MSTR_AXI_CLK, 0x7900c, BIT(30), 0xaf020),
> +	GATE_CLK_POLLED(GCC_PCIE_PIPE_CLK, 0x79018, BIT(2), 0xaf050),
> +	GATE_CLK_POLLED(GCC_PCIE_RCHNG_PHY_CLK, 0x7900c, BIT(31), 0xaf040),
> +	GATE_CLK_POLLED(GCC_PCIE_SLEEP_CLK, 0x79018, BIT(1), 0xaf04c),
> +	GATE_CLK_POLLED(GCC_PCIE_SLV_AXI_CLK, 0x7900c, BIT(29), 0xaf018),
> +	GATE_CLK_POLLED(GCC_PCIE_SLV_Q2A_AXI_CLK, 0x7900c, BIT(28), 0xaf014),
> +	GATE_CLK_POLLED(GCC_PCIE_TBU_CLK, 0x79018, BIT(6), 0xaf098),
> +	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CORE_CLK, 0x79018, BIT(5), 0xaf094),
> +	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_XO_CLK, 0x79018, BIT(4), 0xaf090),
> +	GATE_CLK(GCC_PCIE_TILE_AXI_SYS_NOC_CLK, 0x10f2c, BIT(0)),
> +	GATE_CLK(GCC_PDM2_CLK, 0x2000c, BIT(0)),
> +	GATE_CLK(GCC_PDM_AHB_CLK, 0x20004, BIT(0)),
> +	GATE_CLK(GCC_PDM_XO4_CLK, 0x20008, BIT(0)),
> +	GATE_CLK(GCC_PWM0_XO512_CLK, 0x2002c, BIT(0)),
> +	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x79004, BIT(9), 0x17014),
> +	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x79004, BIT(12), 0x17060),
> +	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x79004, BIT(10), 0x17018),
> +	GATE_CLK_POLLED(GCC_QMIP_GPU_CFG_AHB_CLK, 0x7900c, BIT(20), 0x36040),
> +	GATE_CLK_POLLED(GCC_QMIP_PCIE_CFG_AHB_CLK, 0x79018, BIT(3), 0xaf08c),
> +	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x79004, BIT(8), 0x17010),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x79004, BIT(21), 0x1f014),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x79004, BIT(20), 0x1f00c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x79004, BIT(22), 0x1f144),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x79004, BIT(23), 0x1f274),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x79004, BIT(24), 0x1f3a4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x79004, BIT(25), 0x1f4d4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x79004, BIT(26), 0x1f604),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x79004, BIT(27), 0x1f734),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x79004, BIT(28), 0x1f864),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x79004, BIT(29), 0x1f994),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S8_CLK, 0x79004, BIT(30), 0x1fac4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S9_CLK, 0x79004, BIT(31), 0x1fbf4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x79004, BIT(18), 0x1f004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x79004, BIT(19), 0x1f008),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0)),
> +	GATE_CLK(GCC_SYS_NOC_USB2_PRIM_AXI_CLK, 0x10a14, BIT(0)),
> +	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a078, BIT(0)),
> +	GATE_CLK(GCC_TSCSS_AHB_CLK, 0xac024, BIT(0)),
> +	GATE_CLK(GCC_TSCSS_CNTR_CLK, 0xac020, BIT(0)),
> +	GATE_CLK(GCC_TSCSS_ETU_CLK, 0xac01c, BIT(0)),
> +	GATE_CLK(GCC_UFS_CLKREF_EN, 0x8c000, BIT(0)),
> +	GATE_CLK(GCC_USB20_MASTER_CLK, 0xb0010, BIT(0)),
> +	GATE_CLK(GCC_USB20_MOCK_UTMI_CLK, 0xb001c, BIT(0)),
> +	GATE_CLK(GCC_USB20_SLEEP_CLK, 0xb0018, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_EN, 0x9f000, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
> +	GATE_CLK(GCC_VCODEC0_AXI_CLK, 0x6e008, BIT(0)),
> +	GATE_CLK(GCC_VENUS_AHB_CLK, 0x6e010, BIT(0)),
> +	GATE_CLK(GCC_VENUS_CTL_AXI_CLK, 0x6e004, BIT(0)),
> +	GATE_CLK(GCC_VIDEO_AXI0_CLK, 0x1701c, BIT(0)),
> +	GATE_CLK_POLLED(GCC_VIDEO_THROTTLE_CORE_CLK, 0x79004, BIT(14), 0x17068),
> +	GATE_CLK(GCC_VIDEO_VCODEC0_SYS_CLK, 0x6d044, BIT(0)),
> +	GATE_CLK(GCC_VIDEO_VENUS_CTL_CLK, 0x6d02c, BIT(0)),
> +};
> +
> +static int shikra_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map shikra_gcc_resets[] = {
> +	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
> +	[GCC_CAMSS_TFE_BCR] = { 0x52000 },
> +	[GCC_CAMSS_TOP_BCR] = { 0x58000 },
> +	[GCC_EMAC0_BCR] = { 0xad000 },
> +	[GCC_EMAC1_BCR] = { 0xae000 },
> +	[GCC_GPU_BCR] = { 0x36000 },
> +	[GCC_MMSS_BCR] = { 0x17000 },
> +	[GCC_PCIE_BCR] = { 0xaf000 },
> +	[GCC_PCIE_PHY_BCR] = { 0xb1000 },
> +	[GCC_PDM_BCR] = { 0x20000 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
> +	[GCC_SDCC1_BCR] = { 0x38000 },
> +	[GCC_SDCC2_BCR] = { 0x1e000 },
> +	[GCC_TSCSS_BCR] = { 0xac000 },
> +	[GCC_USB20_BCR] = { 0xb0000 },
> +	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
> +	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1b020 },
> +	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
> +	[GCC_VCODEC0_BCR] = { 0x6d034 },
> +	[GCC_VENUS_BCR] = { 0x6d018 },
> +	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
> +};
> +
> +static const struct qcom_power_map shikra_gdscs[] = {
> +	[GCC_CAMSS_TOP_GDSC] = { 0x58004 },
> +	[GCC_EMAC0_GDSC] = { 0xad004 },
> +	[GCC_EMAC1_GDSC] = { 0xae004 },
> +	[GCC_PCIE_GDSC] = { 0xaf004 },
> +	[GCC_USB20_GDSC] = { 0xb0004 },
> +	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
> +	[GCC_VCODEC0_GDSC] = { 0x6d038 },
> +	[GCC_VENUS_GDSC] = { 0x6d01c },
> +};
> +
> +static struct msm_clk_data shikra_gcc_data = {
> +	.resets = shikra_gcc_resets,
> +	.num_resets = ARRAY_SIZE(shikra_gcc_resets),
> +	.clks = shikra_clks,
> +	.num_clks = ARRAY_SIZE(shikra_clks),
> +
> +	.power_domains = shikra_gdscs,
> +	.num_power_domains = ARRAY_SIZE(shikra_gdscs),
> +
> +	.enable = shikra_enable,
> +	.set_rate = shikra_set_rate,
> +};
> +
> +static const struct udevice_id gcc_shikra_of_match[] = {
> +	{
> +		.compatible = "qcom,shikra-gcc",
> +		.data = (ulong)&shikra_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_shikra) = {
> +	.name		= "gcc_shikra",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_shikra_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
