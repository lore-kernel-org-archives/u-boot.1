Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634ABC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C761608D6;
	Tue, 28 Jul 2026 15:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRT0g49Swi9j; Tue, 28 Jul 2026 15:17:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7602D608CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785251828;
	bh=6sKSH3njrUq0Na+4KZNw/5Lu3EE22fKG+mf+VfdHuM8=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=BaDdMibuOHXXrizrrSXA29IOfygGG7CQeQgPlKMQaCB48nNxUVyjOn5jzXWccJif5
	 EVT28PbBGmqs/h0+by3ukSkY5gpXGe5ipzwmkbM4n2NHg71ItUkc4kVp21pvZOm8i8
	 MB3mtqULAV5y7uZIfmiYvIcKG1yXSvTCDfKF4dkCekTlfAbY1e2urghsw3AsgQcCfR
	 kIskX9C3M6g6/tfjpzQwCjBoSsqYntgVI30Sws22sVphC4hbI5ZUhC4+gC18L6JuT0
	 vXxuU0zzR4xru/079oy30nUWw/K7mXu0o0OfkbORjHuMT8LDeUkp6rfYo44t6csZo9
	 BKfA8fkN3Lb+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7602D608CB;
	Tue, 28 Jul 2026 15:17:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFB8B788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B11C14033A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rB15AiFKExl for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:17:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5D52940328
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D52940328
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D52940328
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:17:06 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2247296f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251824; x=1785856624;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6sKSH3njrUq0Na+4KZNw/5Lu3EE22fKG+mf+VfdHuM8=;
 b=mjaAh29gJrizTkYQ/OSVQGVbhiBUqpoFuR5G5zc2M4T7ZdpGtxw92BmPrHXofV7ZXP
 gTd/qkNpva10qVqmfS9QzcSZjUKX7O07Uh/M677sIGALV9mbxXFqFAuu3L7nHAYOU+iC
 UDrbe3GiCnAc5HCbCtZ2At65xSUgNrpNjdRkUzdkjyLYVu4RCvPj0TrnpHciVdzDD2cn
 i9FzBqODE9q5wPGKUkdiJ8CeXBRAl6HRU+6OSAE7JRilxRewcTV4eTAeNlv+iudziuJO
 t2nlAbGGRl+jWQXHdC1+OAEvJUesP82fzv8in/Hwq/qeEyguKEdiuHQR0E6Pfl951NxO
 hhkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy5Hmn+f3JP9hOo16NdNfIzfmFWRlbVkMeoPidLW66AV7rOl9IHGUlVKwvipWCVg8LtPOzvio=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxafZcqiTiZYXYvgBTkTVQ/ukA8HGzxr7Gf6NMYRNALeM1UjORy
 uqvOTtYGdJeTgf7IbSptoUJEZulEeO1IwjJoj6JZm9hPH7jhf64QyD71ao1UPVEg6c8=
X-Gm-Gg: AR+sD13HFoeezatK6WnNHWvjIc8KZVuzu8y6koDOd+ZfdyZKIjkRLfrGOPx/D2Andqi
 yObLRXQ2OUD/KwN/ugyPimppJs+hjs62RjbBryX81VIX9ZMFJMN7Kq57Cxpf3odK4SVwUPBNyYo
 rIevirxrOdANBRtxWPuZhAqiIaQDz0K/hnhlRNjGZXLhfjMc5tYxjjuR58kcyKQyyWk0KMaptlM
 zuEJKOc5CFcWSDWQRYL1RXbsMygHWMJ37HD7duSTfRAyW5X0qXfQCW+JABw5flqbAaK5jWg0stf
 xebo6BmnKRembqecr0zA83rdGUqKeYd5Jf/8C3+WV1CmynQ89O4JnV6QtfIQxTpfZz4TIzI7CFS
 T2Wq752B8QwcHXsvRbR0WdKDelLpBAdizYI5AR+xeEKZ+N7dihakgWPi/jRl+ipaGlBlM2YCwDj
 QrQj+Qig7zUNorxE0r62igtNYs94tfit/A6qtkC+Yp3pscBGoINCEtnCPYEA==
X-Received: by 2002:a05:6000:4382:b0:47f:6fbd:8a23 with SMTP id
 ffacd0b85a97d-47fb1e5bcf2mr3479368f8f.9.1785251823949; 
 Tue, 28 Jul 2026 08:17:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6843:9af3:9745:9034?
 ([2a01:e0a:106d:1080:6843:9af3:9745:9034])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fc0sm59115583f8f.23.2026.07.28.08.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 08:17:03 -0700 (PDT)
Message-ID: <4f847166-b282-44c2-81a7-b3878f3a9480@linaro.org>
Date: Tue, 28 Jul 2026 17:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-fixes-20260728
To: trini@konsulko.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.u-boot-project.org
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785251824; x=1785856624;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6sKSH3njrUq0Na+4KZNw/5Lu3EE22fKG+mf+VfdHuM8=;
 b=gTG0HZyLzpoJrZ2r+Y7dMUpmvayADtSGoUJp9BMhhG5acyooCTXX8Y5rZQbR0bhX9c
 EIYVoLhioqFsnLrNhJANXSuC0pto/fgr0Crcxbj6fyLqiIDhVqjWuPX4oxn7pWjw9DIt
 GoQBUCIaImYHWB0JjIK2qXxWAWydF2W0+cctRTWe43JBh2/erO2OO1GRPRyBF2qGl4pg
 u49BByvmfmQl1PPnOyMQj2kUlEtH3VjKs16K7xLqdb3yR6zhHk3bjTRvnUQfclsj/EqE
 oCrfUr0rRV6Z/fgGH6hjzO8zw88xPyDvLHh86+rF5AriD30XySbby9mEUdvzRr3cr6ti
 GjUg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gTG0HZyL
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

Hi Tom,

This is small cache fix for UFS reported by Jorge Ramirez-Ortiz.

Thanks,
Neil

The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:

   global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs.git tags/u-boot-ufs-fixes-20260728

for you to fetch changes up to 38bfdf0a770219e2f753023998bc9d0b45254785:

   ufs: invalidate the whole descriptor data segment after a query read (2026-07-21 09:22:58 +0200)

----------------------------------------------------------------
- ufs: invalidate the whole descriptor data segment after a query read

----------------------------------------------------------------
Jorge Ramirez-Ortiz (1):
       ufs: invalidate the whole descriptor data segment after a query read

  drivers/ufs/ufs-uclass.c | 1 +
  1 file changed, 1 insertion(+)
