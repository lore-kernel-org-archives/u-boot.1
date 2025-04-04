Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD9AC3601A
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 16:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0BA829C3;
	Fri,  4 Apr 2025 18:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FtM8lQEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF078829E7; Fri,  4 Apr 2025 18:21:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB67829A0
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 18:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso1321516f8f.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743783697; x=1744388497; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oNpexF/8RWpAt6Cf7e1jRwlqZCxZgrPycIpt/o3GSj4=;
 b=FtM8lQEC4+5FOA8PUoXD6RQSxwkQ4Tb/5VB3sncvXy5kQEZpClQCgyJbTfEdelQ5kB
 752KNLxwNz2rzZEdzRNAk4hwNdR2Z59lSfudQf3cLOo5ui6LDri4n+M3TQC8RvdewXwM
 WI2mTDCoF5NMamW4msmzNIuiKBMw3q6zhB6Ox2rSux/bDWYzmyJkhY9/FJp2MyCoYVjH
 vfNewCfPfpZe7BHrBfr/PpHFZzOt1zQhVcBcxC8GgPKXESH8zmHy4JgPQW5GXXD0NExY
 BIxIDcCdO9SbW7Vjf5YmC6o7KHXlZewUX1+7aRMIImz1Wp0wEZT5KA4JmdMNvMIa6zUC
 uh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743783697; x=1744388497;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oNpexF/8RWpAt6Cf7e1jRwlqZCxZgrPycIpt/o3GSj4=;
 b=qjn9FVhPbNTsm7yvmM+SBNjq0go1EDRIxE+MfjTl5bbrAm4Rh4QjMLueGCamlKlTT2
 0j/22MgIaghE2g+baMMo9dgwFCIk9bOHiLCR+8slvhJX3nEMbDNlb0QbvT31JnaiKrl8
 DfQSiR6WApujWj0Y1e8WRNIlxHgEqExR/tgrNW3ioupCpUgq9PlV1Bt6X49vi+vrT85d
 ISdV7GCSCfHu2CpO8Q9BlKXiXl4Tx9JvugQwKLqQLuqAh2lCidsSV2WgwdOzFrs49Ihu
 vmO8RzYT5xYVOvUGmh/GKpkT5RL/EcsGgn9LYrzlggXLcCL/FTlfRLbnJH9HFJW0DRIX
 7b1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVORBaHQgIx86uz/LKuEYtx+EMRs+Pp/FElITEdq4kLYvu2/+IZ1dvWHZZGF97BcXVohA13zYM=@lists.denx.de
X-Gm-Message-State: AOJu0YzM20A8ixB/bd8U0m0UVOR0pbvJrEwVrZgRHL9zZbCPVOVrHQWx
 vU6+w+KHt69DWGl6oefW6fb5IG5LL++WzCdvcqcexU+fAS6xnfzWyDdr+vspBQ8=
X-Gm-Gg: ASbGnct2bkDbYK/lWjNgPiyH7yKQ1NpoO/WdwbbsSY8lWx41sl46GQLPbqUWUPam+Ia
 gIeddwOORYzebqKWb8FEmYVjVblltN5XKRQ8iQeLcPJBKBVpPBr8tcVwJPNqWJLDUy5P9ktIcjE
 UnQ7JisNE3kIoAAectgki1T0oSTSo9MqBTYOke24jRalh3N0uBeCWyErJVTcmsNaXMKBShPX0F/
 ccv6B3Uw98BjRJYxV1v1H7heR652CoS2GnsfAj2qCVTN8ET4m5ir/kjMN/mnrLcprxQxJA05cCI
 xQLNMJqqGEjrEWykaj8PueVH7UX1cmoHB65vUnED/xZCoSFwoBS7vlk+1nvdaIQZ07yUcYABBOp
 3J5449VpiibW8wpgKkdM=
X-Google-Smtp-Source: AGHT+IHOzfozF0iNf/7k3+3ErZq7dp6uoz6oqiTio0pRytZLkfY2p2ggbUC48hmrce7z1oxwDiIJ2g==
X-Received: by 2002:a05:6000:4021:b0:391:2df9:772d with SMTP id
 ffacd0b85a97d-39cb3596914mr3398959f8f.13.1743783696868; 
 Fri, 04 Apr 2025 09:21:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:19b:8166:6e82:3840?
 ([2a01:e0a:3d9:2080:19b:8166:6e82:3840])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6608sm4687045f8f.23.2025.04.04.09.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 09:21:36 -0700 (PDT)
Message-ID: <d1bb7301-6006-444f-9586-59ed6f3ca7ee@linaro.org>
Date: Fri, 4 Apr 2025 18:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: =?UTF-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Reve?=
 =?UTF-8?Q?rt_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
To: Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Cc: trini@konsulko.com, Michael Brown <mcb30@ipxe.org>, u-boot@lists.denx.de
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
 <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
 <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
 <CAFLszTiJR3La6dwE6k5QbKMmtVpbq+VK9AYhkmeQSEhgozh1AA@mail.gmail.com>
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
In-Reply-To: <CAFLszTiJR3La6dwE6k5QbKMmtVpbq+VK9AYhkmeQSEhgozh1AA@mail.gmail.com>
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

Hi Christian

On 04/04/2025 00:41, Simon Glass wrote:
> Hi Christian,
> 
> On Fri, 4 Apr 2025 at 08:18, Christian Kohlschütter
> <christian@kohlschutter.com> wrote:
>>
>> +Tom Rini (actually adding Tom to the conversation)
>>
>>> On 3. Apr 2025, at 19:54, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> +Tom Rini in case this affects the release
>>>
>>> Hi Christian,
>>>
>>> On Fri, 4 Apr 2025 at 01:46, Christian Kohlschütter
>>> <christian@kohlschutter.com> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>>> On 1. Apr 2025, at 17:51, Simon Glass <sjg@chromium.org> wrote:
>>>>>>
>>>>>> but I don't know precisely what these various functions are supposed to
>>>>>> do, and I can't find any path that leads from any of these to eth_halt().
>>>>>>
>>>>>> Is it possible that U-Boot is failing to call eth_halt() in response to
>>>>>> ExitBootServices(), and is therefore leaving the network device active
>>>>>> and performing DMA while the kernel starts up?
>>>>>
>>>>> The dm_remove_devices_active() is supposed to handle this, but it is
>>>>> possible that one of the drivers lacks a remove() method.
>>>>
>>>> for what it's worth, this is happening on both ODROID N2+ (meson8b-dwmac) as well as NanoPI R4S (rk_gmac-dwmac).
>>>>
>>>> I also don't understand why reverting 06ef8089f876b6dabf56caba31a05c003f03c629 "fixes" this behavior. Does it mean that any memalign / malloc may cause this?
>>>> Also, how can this failure mode be detected and prevented in code?
>>>>
>>>> I really don't fancy the thought of remote code injection into Linux initrd by spoofing Ethernet packages, but it really looks like a possibility.
>>>
>>> Here's my idea of what might be going on based on Michael's observations:
>>>
>>> 1. designware_eth_start() starts the interface and
>>> designware_eth_stop() stops it
>>>
>>> 2. tx_descs_init() sets up the DMA and uses the device-private info
>>> (struct dw_eth_dev)
>>>
>>> 3. When the device is removed, the struct is freed, meaning that a
>>> future malloc() can use that same space.
>>
>> Yes, that sounds plausible. How can such allocations be prevented?
> 
> There is no need to prevent allocations. It is in the nature of
> malloc() that any memory you free can then be used by a subsequent
> malloc(). The bug here is that DMA needs to be disabled when the
> device is removed.
> 
>>
>> I assume U-Boot's malloc does not know anything about iPXE's or Linux's allocation, and vice versa?
>>
>>>
>>> 4. DMA traffic could then write over the malloc() region
>>>
>>> I'm not seeing where the Ethernet device's stop() is called. The
>>> dwmac_meson8b driver does not have a remove() method, so presumably
>>> DMA is still running after the device is removed. Probably the correct
>>> fix would be to add a remove() method to that driver.
>>
>> Right. Of course this means that there's still a chance that some future driver would again fail to do this.
>> How can we prevent this? Can some removal hook be added automatically upon registration?
> 
> Visual inspection of each network driver should help.
> 
> I'm not sure if we want to 'stop' all the network devices before
> booting Linux, but perhaps we could perhaps provide that feature as a
> Kconfig option, e.g. in announce_and_cleanup(), which could really use
> a cleanup to make it common across archs.

could you test:

==========><==========================
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbace..bf9c5e8f349 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -145,6 +145,15 @@ static int dwmac_meson8b_probe(struct udevice *dev)
         return designware_eth_probe(dev);
  }

+static int dwmac_meson8b_remove(struct udevice *dev)
+{
+       struct dwmac_meson8b_plat *pdata = dev_get_plat(dev);
+
+       designware_eth_stop(dev);
+
+       return designware_eth_remove(dev);
+}
+
  static const struct udevice_id dwmac_meson8b_ids[] = {
         { .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
         { .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
@@ -158,6 +167,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
         .of_match       = dwmac_meson8b_ids,
         .of_to_plat = dwmac_meson8b_of_to_plat,
         .probe          = dwmac_meson8b_probe,
+       .remove         = dwmac_meson8b_remove,
         .ops            = &designware_eth_ops,
         .priv_auto      = sizeof(struct dw_eth_dev),
         .plat_auto      = sizeof(struct dwmac_meson8b_plat),
==========><==========================

Thanks,
Neil
> 
>>
>>>
>>> Regards,
>>> Simon
>>
>> Thanks for looking into this!
> 
> Thanks for the report!
> 
>> Christian
>>
> 
> Regards,
> Simon

