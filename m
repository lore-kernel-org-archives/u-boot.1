Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4E5C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94EAB409A0;
	Tue, 28 Jul 2026 15:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p42_nlPPzsu4; Tue, 28 Jul 2026 15:19:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7DF44065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785251942;
	bh=oP4iBnLpP2lj4yzd26L7JK/cK/7KsHidxViD/wTPCMs=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TJy0tQuMVUhv2cbsE6oExFOa7GQuD2r/5vnQbw6+haUgmuwIYXoZKstmdiPUhWR/k
	 ZIJuIyl85Gf458vzaEHTAz80XMAt3xrthWTjaBUrsYDL/k+k1mXiF2upEArRrNzENK
	 xiIsKQQ6S7dXF5WmZ7/o1Yyfr7nmiUL0ivneFUARgd4DFnCW2KQc60PVOAPbE2acX0
	 XUwwG4dOhFEthohMmVr7OUk6YSYQCOEoj9vuCs+WJthscRofVKXMQ90otvQ2z5XnBx
	 44IeoDUf61F+vlI+fW7XjVXSolKdKYXp1K4GLDDnTIZjFqvuBjCsVzeaBevF/SWrMS
	 2DbPZ4LXVOYpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7DF44065E;
	Tue, 28 Jul 2026 15:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED06026C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2D924033A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXm1hJE8V3N1 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:19:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 88A5B40328
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88A5B40328
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88A5B40328
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:18:59 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3997949f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251937; x=1785856737;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oP4iBnLpP2lj4yzd26L7JK/cK/7KsHidxViD/wTPCMs=;
 b=AjwElh8d6blLixxiVD4Untcbh04Ryjdd5eeHwB6eJoGWHLgvkOHevACPsMh7332ySV
 8tJo/H9drMa5Ld1RsNsnfY5zYjm9TJQK6YilB0lTcFxEtnXDm2V1xwTAuFgHIV/rJMyh
 Zavc9+VYWWLd4i1QRdEg8g1hQ51HUGOB3joPXLNgDVVAuwWtLdkSnWNQ/1umK4Wsk0PT
 sQtNrMqR/Wfud4JyQ+TvZm/nR2NKZlg5zsdljUFTB+9000GCS/SwtjKZLlcJdkuVeObv
 Cg6et8xjwuqMjKd1fTkFsRmgOCTgsbND0Me9XaNDO3lF7bI3Q7JkiqGfkZS7quIPRjR2
 S3Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrO126HgrEfX9wo6bVzamOmG8VgBUGRZ18Q+0jLl5RhrPE/+Q2o9VAv/pHei4+owWeBUYBFFLA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzoN/sWnA+odbCYobjCNR7xiPIiGjpb+irC/ZY5r5hVMmN1SPsb
 azjY49dgRTyXbjDWw4zoJtGXAlrmNi0tp6zGhFTCdBNcdXEw10FVMzpC0XACiVRemL4=
X-Gm-Gg: AR+sD11ZOFept3HxZMxl/H0mScVNTBD7QAGOyVD0knteut4ZsYQbPzwuFngTaQlL4/4
 BUtyiEOSHfI8bSZE4tyKx/HMvL5t0MD1NKixheOKTW29QkqtLkAXmw6afxi8lyMdT6SbxOYxo7e
 J2BPHunLt1J8jY9tg0K4XvM+7+abUixyXb/ZH0DrcrsMU5Td4k3s//KyuSuKXBSpkG4BpmBAe0k
 nMyIReh2bF62Ij2Fr2RTDR6QDE6rdzXHvZb+oz6EKsysGpceS142W/kCkwP2cw5DQEoFiqRsBlb
 Eje/PBN4EqsnGYcqB5u1ZfhXwJGk8ZmpPQ8R5BWs94lHmkmWNnY0IHvyyPhFC1ShUoiYF4L2GWF
 jwa6LJOycI/mDeOZJpqsqNa78RxzuemFaQPJCROQufRnUAjBXKpo7YqwgBOewdu2GZMb/ySPmKi
 DpsTPCc12T4FCmvEtyuMGHboFIuZI+i5xnCaLWbt7bc0gBSHKiB/PJcY6e2A==
X-Received: by 2002:a05:6000:186f:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47fb1e93a79mr3372009f8f.20.1785251937046; 
 Tue, 28 Jul 2026 08:18:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6843:9af3:9745:9034?
 ([2a01:e0a:106d:1080:6843:9af3:9745:9034])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm58121795f8f.22.2026.07.28.08.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 08:18:56 -0700 (PDT)
Message-ID: <142bf69a-7f65-48f9-94ea-c90260f3fa43@linaro.org>
Date: Tue, 28 Jul 2026 17:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-nvme-next-20260728
To: trini@konsulko.com
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
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
 d=linaro.org; s=google; t=1785251937; x=1785856737;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oP4iBnLpP2lj4yzd26L7JK/cK/7KsHidxViD/wTPCMs=;
 b=VGM9MWCO6P7FOngr7HaNKBLFzIhDq8n6HzkJl5bA7xUp4ci+jTQOTgfJ7rOZF0by8d
 AcNuEYsA9z8l8P5p/f5MGtAuGHD1pu4Igl+AaalKGuKvpsIvPyQ89V0o2VMgV00LyEgA
 KKuj31Xe7iEsDPSP5k6T6QKMD06bqmUcRXdbOrLAxN89lQFE3C4dKe3hK8r7XgaVLKLI
 s+15Hp3FUhQOUrySenR+C2u+X1I8M5c2UJDuKwgHYXBW6AvNl+iBc/KuuV0D69yb9KrB
 qODZiKKstG5RyfgaS/eCYF+9zkx6G58ouz8UIRnzqKePVOgdqt45h6wH+bdm3kqwyAHV
 z/gQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VGM9MWCO
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

This is a single change for Raspberry Pi platforms to use the bus offset
and make the NVMe usable.

Thanks,
Neil

The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:

   global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme.git tags/u-boot-nvme-next-20260728

for you to fetch changes up to 09b1c0f98c0b0fe0291e6dac49d0013e782b438d:

   nvme: Fix missing address translation for PCIe inbound access (2026-07-21 13:39:29 +0200)

----------------------------------------------------------------
- nvme: Fix missing address translation for PCIe inbound access

----------------------------------------------------------------
Torsten Duwe (1):
       nvme: Fix missing address translation for PCIe inbound access

  drivers/nvme/nvme.c | 73 ++++++++++++++++++++---------------------------------
  drivers/nvme/nvme.h |  3 +++
  2 files changed, 31 insertions(+), 45 deletions(-)
