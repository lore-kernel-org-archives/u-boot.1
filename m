Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD33C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 13:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 983EC80EC2;
	Wed, 22 Jul 2026 13:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JdMSTz0tbTUP; Wed, 22 Jul 2026 13:10:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 740BF80CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784725830;
	bh=XkCnjDi+ufMxFmCvsHphatWBBHuDHFKqSELc18GjRnc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=POuyN2g/FTWrnFzylevhZcWSC/FK6T+oo58bOSb1F2hB2PcMG8aMpatGwuPy+znKM
	 k8EVCoIpEty4HZmSeb7RYaSKZvM/A51OVNrnZrwTLG6ctgF2kYsPZPoK5D4d4MjMMQ
	 4nncvsXWhE/Sln9po1bgfrB8mmRhvaKIYr54ZoQI7Gw3r1G3UYZedCbj/hoxk/LoBg
	 XenhGskMidF1QwahJ3V3NtXCyR2C8aEi4F0526tAYNOu0wqFIW3+cBcCQVhKlfoIzX
	 FjW3R7rsHuYeHPQ2/dZcEaIg3vBo2lp5nAtVhvilzYhUNAM0HKdOGnq1VRkND//rqU
	 isq2nHXK9eiog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 740BF80CCD;
	Wed, 22 Jul 2026 13:10:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC8C390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1EF2407BC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZX3RBfBe6aX for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 13:10:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A7F59407B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7F59407B4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7F59407B4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:10:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240ED848BA; Wed, 22 Jul 2026 15:10:23 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A42803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:10:18 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495590dde14so35879075e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725818; x=1785330618;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XkCnjDi+ufMxFmCvsHphatWBBHuDHFKqSELc18GjRnc=;
 b=GYaLCCxyea6u0XkNh/C+cx/NXSfXm6NjM2IeDRFzyklLAKBrbMjFLHmGsMFzVdmrqJ
 YxwDY+w5VQxdc92OObK+6V1YlY3niGBZR+13wUc5BSdmlT4T/Jpd8Ru4IKyVhKHLBlGm
 F0oqA61wT8oQhGZvF0JrrLUS10P3FM+WFt914H33A/i1mwr33fdxLZAL0ZCYFOuY6mH6
 STU8OqBumxmYyqbXCVYdSBR8sxVo03SpSkTcqQ5y8BoUc3zSt5B9xgWa/u2D/tBdV4Jc
 PhFLDmPvXSbD/ukeRX8yd0Z5M5MNa+yGUakHByNtPqL9pj53m/W2jkJJFLYSm2f3UFFN
 XU6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkBi3POpqNwvye4iVxUKVEFH4UcVErzE5OpnS3o40gFxrwg8PCFVPaY5UE7SGL2XVl2OIMBiI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4lBtSvsh1PguOMjf69W+lkm2Gh5o04yif9Ncg2yFtFxPT3v63
 fGIeyXKiX6cw7FhF4dFoiNzq+liUYw4Y5aYsFJxd12v4OkJR3z6o0VibKjs4C4xV5wY=
X-Gm-Gg: AR+sD11BYJC4hBC45oEPvRlAtSDKb02AbpFdhz/HrdsxcshUPUDBYNjxRx000Mw0P0X
 q8uMKTKSjNXO4kxvJMlAdeow6F54oSZZYtKDsTqtd47w5quchs2eQpG1HQNXK4mjM72ywMas7Wp
 zAbIc8TYWPJGgRYi7sJJ2zwZNA0nXg8++z4E/eJap/voo96iDtoLhRDXoSVnqPOJNDLm6jPva0N
 oRmPWf+BwfLXh6rnBeCTz0UozU3V0Z+npFK5iVjGc45JdI+lkIbeE/HOBbzpsoODFGA1SDoghaj
 OkAAUcPwuVMJUbghyatJittq1sT/9ZbopFyWwoUTTySEmckV9pB9EVf7CRJ2CQny+4N3B61arFT
 gGKmNscPMl6NRn/86YDzZOTwkcAgaItoQA7QM/8+fMFjvp5l4NlsXd9Iv18xpOvJRM9XnPt68ea
 yEzwAqf67aYaqJLCTqKDvk5JpZ2K2eOjwHEFdPxGZQAt+huYne24vZ8PTygSNsaEebVA==
X-Received: by 2002:a05:600c:5601:b0:493:e365:7630 with SMTP id
 5b1f17b1804b1-4954a3f4ac9mr188976935e9.14.1784725818147; 
 Wed, 22 Jul 2026 06:10:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5997:c083:919:7b6e?
 ([2a01:e0a:106d:1080:5997:c083:919:7b6e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm125839085e9.8.2026.07.22.06.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 06:10:17 -0700 (PDT)
Message-ID: <c4846039-2d4d-4436-a4bd-3baf16547319@linaro.org>
Date: Wed, 22 Jul 2026 15:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
To: Peter Robinson <pbrobinson@gmail.com>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org, yoshihiro.shimoda.uh@renesas.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org> <amCRWI7K4Jj_psYp@trex>
 <CALeDE9PV=1-8sgWZn7n3w9A2p6A_TDus1gHyjetaT_oR5uA0Cw@mail.gmail.com>
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
In-Reply-To: <CALeDE9PV=1-8sgWZn7n3w9A2p6A_TDus1gHyjetaT_oR5uA0Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784725818; x=1785330618; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XkCnjDi+ufMxFmCvsHphatWBBHuDHFKqSELc18GjRnc=;
 b=FlRPxvlNGNHVCTHbA9OR8SL9drfZXXOa87nEtDwx57nWXWZx8LpFQgpHTk1tLifOzg
 uSOPbNWRBGXCkoifPNcZv9PpBOTUMcrNR9PSzJO7PV5RqfRgdNKuMn1bowDCUFWaX1Mh
 mLWYA7gT+zKMGio4pB8qdJAaICMnOGvaXmQZKOHW/hFD2I6IGgYLkszH/0Ce0GITrXTf
 JuwPgw02fUoHF8cvzcbbzBcLGunah3gBnyGRHNzpATNwNRoe+VCBuUCZOuRh1N37UJ1M
 Whd7OjmIIUDAHCcSf6a7wjjKoo5hYwqBGrVxaYQ3GF2ShZm5LzdZrMO1wsxJI6srrNRn
 8r2A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FlRPxvlN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="FlRPxvlN"; 
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 7/22/26 14:33, Peter Robinson wrote:
> On Wed, 22 Jul 2026 at 10:46, Jorge Ramirez via U-Boot
> <u-boot@lists.u-boot-project.org> wrote:
>>
>> On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
>>> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
>>>> This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
>>>> supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
>>>> name is free for the RPMB subsystem interface added next; pure rename plus
>>>> its Makefile object, no functional change.
>>>>
>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>>> ---
>>>>    drivers/tee/optee/Makefile                  | 2 +-
>>>>    drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
>>>>    2 files changed, 1 insertion(+), 1 deletion(-)
>>>>    rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
>>>>
>>>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>>>> index 36ac085ef42..8321cf53a19 100644
>>>> --- a/drivers/tee/optee/Makefile
>>>> +++ b/drivers/tee/optee/Makefile
>>>> @@ -3,4 +3,4 @@
>>>>    obj-$(CONFIG_OPTEE) += core.o
>>>>    obj-y += supplicant.o
>>>>    obj-$(CONFIG_DM_I2C) += i2c.o
>>>> -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
>>>> +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
>>>> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
>>>> similarity index 100%
>>>> rename from drivers/tee/optee/rpmb.c
>>>> rename to drivers/tee/optee/rpmb_legacy.c
>>>
>>> Why not rpmb_emmc ?
>>>
>>> Neil
>>
>> right this is what is confusing about the current abstraction; op-tee has two modes:
>>
>>    1. Legacy mode (legacy_operation = true)
> 
> Does the spec refer to this as legacy mode? Presumably it's RPMB on
> eMMC vs RPMB on UFS (or presumably also NVME) or the revisions have
> actual version numbers. Maybe name it after the interface that
> supports the revision, or the actual revision of the RPMB spec, as
> opposed to just legacy. What happens when next version comes along, to
> we rename legacy to old_legacy so we can have new, legacy and
> old_legacy?

So I did a small dig and both commands are still referenced in OP-TEE
and the TEE supplicant.

But indeed the OPTEE_RPC_CMD_RPMB command is only used in the userspace
TEE supplicant _and_ U-Boot, while Linux uses the other RPMB Frames
command like this implementation.

In OPTEE the usage of OPTEE_RPC_CMD_RPMB it's explicited as "legacy" in
https://github.com/OP-TEE/optee_os/blob/991587c721a603e831cad228626078289adad159/core/tee/tee_rpmb_fs.c#L486
so we can describe it as "Legacy", even if it's not described as legacy
on in the OP-TEE headers nor in the TEE supplicant.

But, I'll stick to my proposal to rename as rpmb_emmc and rpmb_ufs and
add a comment in the rpmb_emmc explaining it uses the OPTEE_RPC_CMD_RPMB
and may need to be add support for the FRAMES commands.
And the other way around add a small comment in the UFS implementation
explaining it only supports the FRAMES commands.

Neil

> 
>>    - Uses the original RPC command OPTEE_RPC_CMD_RPMB.
>>    - No device enumeration — assumes a single, fixed eMMC RPMB device at
>>    - CFG_RPMB_FS_DEV_ID (dev_type = OPTEE_RPC_RPMB_EMMC).
>>    - This is the fallback for older supplicants that don't understand the
>>      probe protocol
>>
>>    2. Probe / new mode (legacy_operation = false)
>>
>>    - Uses OPTEE_RPC_CMD_RPMB_PROBE_RESET + OPTEE_RPC_CMD_RPMB_PROBE_NEXT
>>      to enumerate RPMB devices, then OPTEE_RPC_CMD_RPMB_FRAMES for the
>>      actual frame I/O.
>>    - Supports multiple RPMB devices
>>    - OP-TEE probes all devices first, deferring key provisioning until
>>      every device is examined.
>>
>> This PR adds supports for UFS using the new mode of operation that
>> enumerates devices instead of the legacy mode.
>>
>> In the meantime eMMC continues to use the legacy mode.
>>
>> So the super-sets are legacy (for emmc) and probe/default (for UFS and
>> eventually eMMC/NVMe and so on).
>>

