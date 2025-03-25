Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB22C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 15:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E8F81CAF;
	Tue, 25 Mar 2025 16:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/uG7uTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCA381951; Tue, 25 Mar 2025 16:19:01 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0095981CAF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 16:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso43701155e9.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742915938; x=1743520738; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=60ukvXmcT46F5z8Clv1Hp2ojMhWkyr8ZKDSIjZFwXcc=;
 b=M/uG7uTPkkUH19E7OnwddNIiyieHD3o1lj84WgtB21zi9SX9GhEEkqFWdDEBjY7546
 qIUDeD+gJiFt/3Dtx8VEa0Z+JF0XAED+OwNbN5nPmy1h+Gurv0A2lRXwEdOCifPBWCUf
 lNAb6NURgpw8UQrDqAWnhev3huo6nOOOiKdwOEdg9TteeGpclT1ToG4VWOQnon6kl2f6
 QGtzavLwRr+Pjq80Xp5AbxF01Idakzby5yqKFt0HDjxfeggk3uYdnxfbzC1++sg/ZY/L
 TUMbxI4IP8+420oWpwc1OTV9M6A0g6+JzNiUkHcgyJJ6co/aCWUN+6IJ70GSjcb0PKz5
 JoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742915938; x=1743520738;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=60ukvXmcT46F5z8Clv1Hp2ojMhWkyr8ZKDSIjZFwXcc=;
 b=vsRtTbO/s9G+jRvZHD6h/7phQa21LtRldOGiOlKAH1pzPyDpIvWEEwr6ulc+mVkY8w
 9D7UqVs7Z7/XWxozZjINBU8mMpp8F7f6wgNZjoKf0bcImlFFoTDuWlJT9T5MIx4AOBHA
 wlpPdJqrCtY6WH/7Guy1avLIiTsHhKpUaHlhd7N8eOjwnAz8x/+PlDJGUgn0K2ChZTBq
 0RWd1h/kTqx0nBldlHI9nnVKjjZ2jbJDIA51JLYxr9Siwz9FqeiPmsp3RvdfJ21RxnCj
 1BWV8wYf1163kXdVj7MRukTlHonOoOrh1NpLkWNY8jpElTsMLW7dExA26ssj/BlBTDsy
 f0kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYvGIne6Dl+X3yJVUmT9arEteHbKmRaoxkXTiT3Ykpzol1HsCbOoyXWn1AFnpzqJl36NXVd8E=@lists.denx.de
X-Gm-Message-State: AOJu0YzhNyHY8VlFeWGD52u9jM7pkGQGVeoGsO2AVDXT1GmNhf4PhwGs
 DP3drUlHB2IJLI686crg0Ag1OJokfAOkk9iDCELu5JCTY/eyJgDn3LcuM0O8+xo=
X-Gm-Gg: ASbGnctZtmlPcYmc5CqBAFRT6TbPPJTJSKfaf60DJ0YSCz6xpXYu3x+LDmA+P4CJAQq
 B1ZE9PWn8oZOmakuw1W7dKZk1xr2c/lnfaJ9ENA0+l9RO+c+bCmNwZG/AvTZro0vuaHGS7meLHO
 MMqVT193BULeIVtVZIOtQDr9GarWWSH1EhchsspxdEc+haK1b2N0hvI59uZbKRp6TURsZ5Ck9Pf
 FcAKlPOfLxOShVn+tqduNLFsYSQ3mHtAFK89Z9exx8cWD12MYN4IcTJkmG+qZGa/t1ZKKvdLU+n
 zZhA5860fnU1bop8mEjhjY0bl1xVfxfi51kzFNgSOnF7PydlpMvP3lEzZ29sBNbiYvbvv9T4iFi
 D05jPFQlSK8Waz4nYlaZ2DbWiv60=
X-Google-Smtp-Source: AGHT+IEinT/VqaPXmalFE52ISIxzrl/ryu3RKP3GWrNDrYvyKURuRBvNDJH78xMM4ssPQRKRsr0Hew==
X-Received: by 2002:a05:600c:1992:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43d50a553f2mr159822635e9.31.1742915938237; 
 Tue, 25 Mar 2025 08:18:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceae03sm159787535e9.8.2025.03.25.08.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 08:18:57 -0700 (PDT)
Message-ID: <5256bf47-ba7c-4ec8-8757-6d59910176dc@linaro.org>
Date: Tue, 25 Mar 2025 16:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] scsi: sync cache on write
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-3-3575aa1342e0@linaro.org>
 <b737a955-36fc-4816-8169-2a27270d9fce@linaro.org>
 <b10dbf6c-c30f-44b7-950b-f7fb16afcf73@linaro.org>
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
In-Reply-To: <b10dbf6c-c30f-44b7-950b-f7fb16afcf73@linaro.org>
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

On 25/03/2025 14:49, Caleb Connolly wrote:
> 
> 
> On 3/25/25 14:33, Neil Armstrong wrote:
>> On 25/03/2025 14:02, Caleb Connolly wrote:
>>> We don't have a mechanism to safely shutdown block devices prior to a
>>> baord reset or driver removal. Prevent data loss by synchronizing the
>>> SCSI cache after every write.
>>>
>>> In particular this solves the issue of capsule updates looping on some
>>> devices because the board resets immediately after deleting the capsule
>>> file and this write wouldn't be flushed in time.
>>>
>>> This may impact NAND wear, but should be negligible given the usecases
>>> for disk write in U-Boot.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>   drivers/scsi/scsi.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>>> index 1aa7fbdbb5278e387de72a3c3e73d19ea0342fff..1b71e580b89b100395ea132a4976366a713cba8a 100644
>>> --- a/drivers/scsi/scsi.c
>>> +++ b/drivers/scsi/scsi.c
>>> @@ -77,8 +77,25 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
>>>       pccb->cmdlen = 6;
>>>       pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>>>   }
>>> +static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
>>> +                  unsigned short blocks)
>>> +{
>>> +    pccb->cmd[0] = SCSI_SYNC_CACHE;
>>> +    pccb->cmd[1] = 0;
>>> +    pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>>> +    pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>>> +    pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
>>> +    pccb->cmd[5] = (unsigned char)start & 0xff;
>>> +    pccb->cmd[6] = 0;
>>> +    pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
>>> +    pccb->cmd[8] = (unsigned char)blocks & 0xff;
>>> +    pccb->cmd[9] = 0;
>>> +    pccb->cmdlen = 10;
>>> +    pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>>> +}
>>> +
>>>   static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
>>>                   unsigned short blocks)
>>>   {
>>>       pccb->cmd[0] = SCSI_READ10;
>>> @@ -235,8 +252,19 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>>>               blkcnt -= blks;
>>>               break;
>>>           }
>>> +        /*
>>> +         * Ensure the writes are flushed to disk so we don't lose data
>>> +         * on board reset.
>>> +         * FIXME: this ought to be in a SCSI shutdown path instead
>>> +         */
>>> +        scsi_setup_sync_cache(pccb, start, smallblks);
>>
>> Why can't this be done at the end of scsi_write() ?
> 
> We have the same limitation that we can only flush SCSI_MAX_BLK blocks at once. It could be done in a second loop at the end but I figured it's more sensible to just interleave them.

Indeed you're right, another solution is to leave count to 0, and it will sync all data after start:
````
If the LBA and COUNT arguments are both zero (their defaults) then all blocks in the cache are synchronized
If LBA is greater than zero while COUNT is zero then blocks in the cache whose addresses are from and including LBA to the highest lba on the device are synchronized.
```

And it seems Linux only passes 0 parameters, and just flushes all data in cache:
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/scsi/sd.c#L1145

So either you leave is as is so all data is written as soon as possible,
or we wait until the end of the write and flush everything.

I think the last one is just simpler and safer.

Neil

>>
>>> +        if (scsi_exec(bdev, pccb)) {
>>> +            scsi_print_error(pccb);
>>> +            break;
>>> +        }
>>> +
>>>           if (blks > max_blks) {
>>>               start += max_blks;
>>>               blks -= max_blks;
>>>           } else {
>>>
>>
>> And perhaps a sync subcommand of the scsi command would be nice to have !
> 
> Good idea, that would tie in nicely if/when we get a .sync() op for block devices and call it prior to board reset.
>>
>> Neil
>>
> 

