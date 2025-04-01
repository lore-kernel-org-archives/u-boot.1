Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA66C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB36820F6;
	Tue,  1 Apr 2025 16:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IVgUgKFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED3581FFC; Tue,  1 Apr 2025 16:01:01 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBA8820AA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so2282938f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743516057; x=1744120857; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vwQO5mjEqTHxNzO7rAGFY8AFzXvukBXCmf3muFIDAIU=;
 b=IVgUgKFTC3Y6N4mykkgRVWuu6wtYljPggvDLiiTjdhXRIoFU10Ldn6D+sXYvWdfG4k
 ha6gbcV/H6eGNMtGUb6/KVu5gnwBi2IbTWN5eosFvJ1wS3ZQDIYdHMksuW7FyoRVI7PW
 A6wvxRjemH9Shxtk+/uscrMROpeZtsNAlamozKwdykj+//SOZxqYbSRpJcPMiTHUcTlr
 3eSa65NPTv+zwXl3Sz1Zr2P3l4iCSHty5eGaHKQwWRwE3cDcraMXbNRaE3sCWVem+PKF
 fcOW59RmB4d1vRAcLbnMUFlTTSNahjLcWgPWIJzvXWlvgQIWLBDNBPeDmJRxrasrY8LN
 vmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516057; x=1744120857;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vwQO5mjEqTHxNzO7rAGFY8AFzXvukBXCmf3muFIDAIU=;
 b=tikYEKJpHQVaQgjMVZTrSSgWklQaQRHPgGeftRfCfFu0L6w6Yg4n1D6fzCLWENZC6s
 Fnvi2kyR8W+o/F+KGMGCmbJ4a9Q9kTyfKl//acFaj5ojpsFl1YalkvvXnepmBUSt2+f1
 Sys5Dg4+zR1vV3BYGe737RqwAIBVMlsyU4shnT9SCgJvaKEuPRRjwpwdVBp8ncrdJqLW
 3d1TTz5ylba04gbPsys1owmpSvRnebEZnRKXdgqaq1nvy8rsp9lqYUmt5l13AX3RZ+Ob
 xwMLrODUBvx6fOOeigRCcU+yZLP1ECNKUW0tbFcEPu7n1XeBn5yNGfn6hlNrArgnd/4y
 L0pw==
X-Gm-Message-State: AOJu0Yzc0ChOULBqCDhZxMa2kk4qCcEr2tTPlC+affrCIb9y6rzEN/cG
 i8NP/gIpHJVE2ggRS5MK9mE7CQS5r+1RDRih/D4NFFYRqJZ7rTFfQS7D9xK/zhk=
X-Gm-Gg: ASbGncv6rz4tiZqjBsqj+aOYXz/Sj5JCaaiknuI1ucC2UYLm33uhtthUWsJNaPfNRm6
 LRzMp++Y1BAm5+L5pPdKSaj/99kov0U532vyaZVhhy+C8rCDTjwkZQlewb6b3bUaZNk0ZYoHcCb
 TKaf+ymMWsbjWOaw6EJAgzZpEbZWklD1aryYQo5ahadZ/An3VRfUNlCmT7ndnfVHqqD1YaxeC7W
 T3CjnGUYh0mryMt2upQsLRBD8qFUB49q7YlBSIAjMi40iLMP2cswJFMN5TYcKOAxsDk35RPF9wx
 6E6JCDk6a14P+4ldR0U2hCpkZFO0RnaduQG73t1CYvH97/VnC47hApHWkV6VvZZhfJ7Fyo1cSCd
 hxYWZtWEM/fP1ya9M6dh8+A==
X-Google-Smtp-Source: AGHT+IH8MFTb5K4B1vWAolQoo2Oe4EZXoEzWN+4iv+GmBMl9r/CsRYJIyo6F4hQOtNbVPocJ3/QqOA==
X-Received: by 2002:a5d:64c7:0:b0:391:4bfd:6d5 with SMTP id
 ffacd0b85a97d-39c1211d5c8mr10413263f8f.52.1743516057314; 
 Tue, 01 Apr 2025 07:00:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9eae:2c33:be54:89e4?
 ([2a01:e0a:3d9:2080:9eae:2c33:be54:89e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d0dbsm14327421f8f.58.2025.04.01.07.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:00:57 -0700 (PDT)
Message-ID: <5feeefd0-79ed-4a04-bebc-83dc58f8b445@linaro.org>
Date: Tue, 1 Apr 2025 16:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
 <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
 <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
 <eb506671-c8be-4a00-9341-5db15cdc5d44@linaro.org>
 <CAOWkq4koPm8O40yjhCbfq+9poLjJ3ABWLh-xejX=-XrEfbJ07Q@mail.gmail.com>
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
In-Reply-To: <CAOWkq4koPm8O40yjhCbfq+9poLjJ3ABWLh-xejX=-XrEfbJ07Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 01/04/2025 15:18, Dmitrii Merkurev wrote:
> Hey Neil!
> 
>  > Ping, did you find time to resubmit a new version of this patchset ?
> 
> Apologies, but it looks like I won’t have the capacity to complete this patch stack after all. Please feel free to take it over if you think it’s useful!

Ack, I'll take it over then and keep your authorship.

Thanks,
Neil
