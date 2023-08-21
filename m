Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24991EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 09:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B56B87038;
	Mon, 21 Aug 2023 11:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xyIqqsxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D098703E; Mon, 21 Aug 2023 11:16:23 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B08586354
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso828735f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692609377; x=1693214177;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nZBS9Qwx9GImr+3e1w87gQehgtMsLPxjKacJ4PCB5Jo=;
 b=xyIqqsxpM6ffRIBM8rOm4uwHJdKMXOrqcy/WuOBU+rCHcApCTc9vP3bFtb7APttZAR
 wiEyqyeo1nF23c2q6tz7pObY9Y/tpeTS38x1RBKnxwAmF9pJPZ5ZD7smQemajrimpcM7
 lc7J1yapJyzcRQ1MN5wPDZ0k6q3oSOtSqy9cjrDlT40An1DX/jjwfLgm0jkTBQNf03Vx
 Z80fvqYzJ0ZuZ7gORXElZN1thbSy6oeIMmycROxI9euvRxBG5hL9Tw5smmlgQO0psUqp
 8RCdJe5dMHlMIaBd7JxbppkkghrcFpEHB6oRypNbCP0NNKr+X0YyQZFQqDmnRXLBSNA7
 M51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692609377; x=1693214177;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nZBS9Qwx9GImr+3e1w87gQehgtMsLPxjKacJ4PCB5Jo=;
 b=JHey343/dfpvLZyh8rVtS35DvrufZzIGstQUwP5nMT15+d4EuS58wzuZo41hFBARr7
 olM/65KnzB5WedRjl/LNVTW8pw8TEy2xfM9KgegoUKrKbuB2YDBFUjaeWCodwsiyf4gR
 bGPTPTUTkLiso3kI9VU6ktTa8GVhV3Z0tp+HnUMREhlCxk7DlshuaWgrSYRjhi0X8gzi
 pxfNDpuOlFvDtwipPMtLKGR3olpmrpZShzox0r2e5cFpXjSCbnXhQIfnOKNL7a7ycfgg
 esRVMSdMxVpgQdZaqItrsiHze1thvXdhV20i9BqxIZH/axU7zgvZRk/SP76/o/Lre1c7
 5l1Q==
X-Gm-Message-State: AOJu0Yy5f4f79UeZaN5z4JfH+CDgKrFMQuj1WaiV5VKQCKJFlQFn1g2/
 3Er7/DT4kZdIhkmFpXdeShJcdQ==
X-Google-Smtp-Source: AGHT+IEOCfvtkzzHSn9XITEIbL6hSEql+kzw6ikjw6n0Z8Kz67ZlayqF3wX5GSBmPYx9k9wWe5SjKQ==
X-Received: by 2002:adf:e645:0:b0:316:fc63:dfed with SMTP id
 b5-20020adfe645000000b00316fc63dfedmr4403791wrn.39.1692609376792; 
 Mon, 21 Aug 2023 02:16:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:8418:651e:836e:2521?
 ([2a01:e0a:cad:2140:8418:651e:836e:2521])
 by smtp.gmail.com with ESMTPSA id
 v25-20020a7bcb59000000b003fe4548188bsm8051740wmj.48.2023.08.21.02.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 02:16:16 -0700 (PDT)
Message-ID: <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
Date: Mon, 21 Aug 2023 11:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
Content-Language: en-US, fr
To: Simon Glass <sjg@google.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Alexey Romanov <AVRomanov@sberdevices.ru>,
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
References: <20230706112020.24528-1-avromanov@sberdevices.ru>
 <20230706112020.24528-2-avromanov@sberdevices.ru>
 <CAPnjgZ1AqUYxAU0BNhxZLXc+y_h5XKbuoLBDekbkqzaJeon-1Q@mail.gmail.com>
 <20230707084313.vecmsr5z3aj4gqxs@cab-wsm-0029881>
 <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 16/07/2023 01:40, Simon Glass wrote:
> Hi,
> 
> On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>>
>> On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
>>> +AKASHI Takahiro
>>
>> Me?
> 
> Yes, I'm asking for your help to try to clean this stuff up.

The thread is long and hard to answer directly, but as AKASHI
said there's no point to add a SMC class since it's only the message
passing instruction, and there's no point using remoteproc since the
firmware runs on a separate secure state of the same CPU.

And I don't see how we can actually define a finite set of ops because
none of the secure firmware interfaces has even similar functions.

So a new UCLASS for each firmware interface should be added, not sure
this is scalable or required since those firmwares are mainly SoC or
vendor specific, except the PSCI or other ARM specific interfaces of course.

So I think UCLASS_FIRMWARE is good enough since it avoids using UCLASS_MISC,
but it should be probably documented somewhere that the ops are implementation
defined.

Neil

> 
>>
>>> Hi Alexey,
>>>
>>> On Tue, 11 Jul 2023 at 04:25, Alexey Romanov <AVRomanov@sberdevices.ru> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On Mon, Jul 10, 2023 at 01:45:53PM -0600, Simon Glass wrote:
>>>>> Hi Alexey,
>>>>>
>>>>> On Mon, 10 Jul 2023 at 02:34, Alexey Romanov <AVRomanov@sberdevices.ru> wrote:
>>>>>>
>>>>>>
>>>>>> Hello!
>>>>>>
>>>>>> On Fri, Jul 07, 2023 at 11:35:47AM -0600, Simon Glass wrote:
>>>>>>> Hi Alexey,
>>>>>>>
>>>>>>> On Fri, 7 Jul 2023 at 09:43, Alexey Romanov <AVRomanov@sberdevices.ru> wrote:
>>>>>>>>
>>>>>>>> Hello, Simon!
>>>>>>>>
>>>>>>>> On Thu, Jul 06, 2023 at 09:58:02AM -0600, Simon Glass wrote:
>>>>>>>>> Hi Alexey,
>>>>>>>>>
>>>>>>>>> On Thu, 6 Jul 2023 at 14:16, Alexey Romanov <avromanov@sberdevices.ru> wrote:
>>>>>>>>>>
>>>>>>>>>> At the moment, only smc API is a set of functions in
>>>>>>>>>> arch/arm/mach-meson/sm.c. This approach is hard to configure
>>>>>>>>>> and also doesni't contain any generic API for calling smc.
>>>>>>>>>>
>>>>>>>>>> This patch add Meson SM driver with generic API (struct meson_sm_ops):
>>>>>>>>>>
>>>>>>>>>> - sm_call()
>>>>>>>>>> - sm_call_write()
>>>>>>>>>> - sm_call_read()
>>>>>>>>>>
>>>>>>>>>> A typical driver usage example is shown here:
>>>>>>>>>>
>>>>>>>>>> 1. uclass_get_device_by_driver(UCLASS_FIRMWARE, "secure-monitor", &dev);
>>>>>>>>>> 2. handle = meson_sm_get_handle(dev);
>>>>>>>>>> 3. handle->ops.sm_call(dev, cmd, ...);
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>>>>>>>>>> ---
>>>>>>>>>>   arch/arm/mach-meson/Kconfig       |   1 +
>>>>>>>>>>   drivers/firmware/Kconfig          |  10 ++
>>>>>>>>>>   drivers/firmware/Makefile         |   1 +
>>>>>>>>>>   drivers/firmware/meson/Kconfig    |   6 +
>>>>>>>>>>   drivers/firmware/meson/Makefile   |   3 +
>>>>>>>>>>   drivers/firmware/meson/meson_sm.c | 217 ++++++++++++++++++++++++++++++
>>>>>>>>>>   include/meson/sm_handle.h         |  38 ++++++
>>>>>>>>>>   7 files changed, 276 insertions(+)
>>>>>>>>>>   create mode 100644 drivers/firmware/meson/Kconfig
>>>>>>>>>>   create mode 100644 drivers/firmware/meson/Makefile
>>>>>>>>>>   create mode 100644 drivers/firmware/meson/meson_sm.c
>>>>>>>>>>   create mode 100644 include/meson/sm_handle.h
>>>>>>>>>
>>>>>>>>> Please can you use the remoteproc uclass for this and add a proper driver?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't see it architecturally well. Can you explain please?
>>>>>>>>
>>>>>>>> This driver is just ARM SMC fw interface. There seems to be nothing to
>>>>>>>> do here for remoteproc uclass.
>>>>>>>
>>>>>>> Well you seem to be implementing a remote CPU interface, which is what
>>>>>>> remoteproc is for. How does Linux do this?
>>>>>>
>>>>>> The main idea of the patchset is to abstract the smc calls (which run on
>>>>>> the same CPU) and make a request to the firmware that runs on a higher
>>>>>> EL. UCLASS_REMOTEPROC may give the impression that we are
>>>>>> interacting with another CPU, although this is not the case.
>>>>>>
>>>>>> Also, UCLASS_REMOTEPROC requires two mandatory interfaces: load() and
>>>>>> start(), and I don't even know how to apply my current changes to them.
>>>>>
>>>>> You can return -ENOSYS if not implemented.
>>>>>
>>>>>>
>>>>>> My implementation is very close to the Linux implementation, they
>>>>>> also use the firmware driver without remoteproc:
>>>>>>
>>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/firmware/meson/meson_sm.c
>>>>>
>>>>> Yes that seems like it doesn't use any common infra. I don't think it
>>>>> is a great model for U-Boot though.
>>>>>
>>>>>>
>>>>>> I spoke to Neil on IRC and he said UCLASS_FIRMWARE for such driver is
>>>>>> OK.
>>>>>>
>>>>>>>
>>>>>>> Also there is a pending series on FFA - is that related? It uses smc
>>>>>>> from what I can tell.
>>>>>>
>>>>>> Not entirely clear, my changes don't seem to be related to this
>>>>>> patchset.
>>>>>
>>>>> So perhaps this needs a new UCLASS_SMC? I see various other SMC calls
>>>>> in U-Boot but no one has taken the initiative to think about this in
>>>>> terms of driver model.
>>>>
>>>> What will be the feature of this uclass? If it's just us adding a new
>>>> uclass with a different name... Don't know if that makes amy sense?
>>>> Then the difference between UCLASS_SMC and UCLASS_FIRMWARE will be only
>>>> in the name.
>>>
>>> Honestly I'm not sure, but I question why you are putting all this on
>>> the reviewer. Can't you look around the code base and figure out a
>>> sensible approach and defend it in your patch?
>>>
>>> I've just reviewed the SCMI stuff which use UCLASS_MISC in one case.
>>
>> Do you mean a "sandbox_scmi_devices" in drivers/firmware/scmi/sandbox-scmi_devices.c?
>> If so, it has nothing to do with the discussion here.
>>
>> It is a kind of pseudo device for dm ut, which is subject to manage
>> with the faked scmi server in sandbox (sandbox-scmi_agent.c).
>> It is connected, for instance, to clock lines or vol regulators.
>> (see sandbox's test.dts.)
>>
>> I believe that similar usages can be seen across drivers/, for instance,
>> drivers/clk/clk_sandbox_test.c.
>>
>> Do you see anything wrong with it?
> 
> At this point I'm just confused. Perhaps MISC and FIRMWARE should not
> be used as much? It seems that FIRMWARE doesn't really mean anything
> at present?
> 
>>
>>> I'm not sure if this is related to firmware or not, or whether what
>>> you are doing relates.
>>>
>>>>
>>>>>
>>>>> It might just need one operation, to make a call, passing a regs
>>>>> struct, perhaps? The uclass would presumably be ARM-specific.
>>>>>
>>>>> I really don't think this is UCLASS_FIRMWARE. That seems to be for
>>>>> loading firmware. It doesn't even have a firmware.h header.
>>>>
>>>> I see what drivers/firmware/psci.c is UCLASS_FIRMWARE and also use
>>>> smc_call() function. Or firmware-zynqmo.c. In this case, we then have to
>>>> convert them to UCLASS_SMC in the same way?
>>
>> SMCCC stands for SMC Calling Convention, where SMC (or Secure Monitor Call)
>> instruction escalates the cpu's EL (Execution Level) to EL3 (secure).
>> This interface is clearly defined by Arm, and many high level services are
>> defined and implemented on top of that.
>> PSCI and FF-A are ones among those users, and even vendor specific functions
>> may be allowed.
>>
>>  From the viewpoint of implementation, arm_smccc_smc() (and smc_call()) is
>> just a C helper function around one SMC assembly. I don't think we need to
>> have UCLASS_SMC as it is basically a communication method.
>>
>> Nevertheless, I agree with Simon in the point that the SMC related code
>> can be a bit reworked since there are duplicated code.
>> Especially, the followings are essentially the same:
>>    -- arch/arm/cpu/armv8/fwcall.c with smc_call()
>>         psci_system_reset()
>>         psci_system_off()
>>    -- drivers/firmware/psci.c with arm_smccc_smc()
>>         psci_sys_reset()
>>         psci_sys_poweroff()
> 
> OK, what that is a start.
> 
>>
>>
>>>> It seemed to me that UCLASS_FIRMWARE is a SoC(arch)-specific driver
>>>> that can work with any interface.
>>
>> IMO, UCLASS_FIRMWARE is quite misleading as all the drivers belonging to
>> this class do not have any common operations.
> 
> Well misc.h does actually have operations, but yes, people misuse it.
> Perhaps we should invent something else for these people?
> 
> For FIRMWARE, what should it mean? It needs to have a firmware.h file
> with some information.
> 
>> (And UCLASS_MISC as well.)
>>
>> -Takahiro Akashi
>>
>>> OK, well please take a look at all this and see what you think is
>>> best. If UCLASS_FIRMWARE is correct, then please create a proper
>>> firmware.h file and define what the uclass operations are. You can't
>>> just randomly create your own private operations and ignore the rest
>>> of the code base.
>>>
>>> Driver model is intended to bring order to the chaos that used to
>>> exist with drivers in U-Boot. Please see [1] for an introduction.
>>>
>>> Please try to dig in and understand how things should be done. It is
>>> important for the health of the project.
>>>
>>>>
>>>>>
>>>>> Also instead of:
>>>>>
>>>>> 1. uclass_get_device_by_driver(UCLASS_FIRMWARE, "secure-monitor", &dev);
>>>>>
>>>>> use:
>>>>>
>>>>> ret = uclass_first_device_err(UCLASS_SMC, &dev)
>>>>>
>>>>> using device tree to find the device.
>>>>>
>>>>> Regards,
>>>>> Simon
>>>>
>>>> --
>>>> Thank you,
>>>> Alexey
>>>
>>> [1] https://elinux.org/Boot_Loaders#Order_at_Last:_The_New_U-Boot_Driver_Model_Architecture_.5BELCE_2015.5D
> 
> Regards,
> Simon

