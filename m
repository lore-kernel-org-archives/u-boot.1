Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E68C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 13:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D25D80FDA;
	Sun, 30 Mar 2025 15:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r1cWslER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0BD81879; Sun, 30 Mar 2025 15:30:54 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F3C80F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so3095393f8f.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743341451; x=1743946251; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kVmFKTID/yXVhMylSs7V4Dq8lGE/WIQZU2Ag6B1OoyY=;
 b=r1cWslERvvWoxGVl9C8CiLCEpKgSD4FXoSUDumuXe2TfohyYqewOPrKJrfS4EqGhZh
 t0j4NIdBYi9Kme0AFaWuj2+v8XduNi+JPYSRc2mBqc2Kcn06mcv8VCLETE/NTaoy2WPQ
 E/35pBEUaHzb7ENo4zSgD+5HC+RhAGqiTnyrToBDmMIEHLrYC/x7ZaFK5or9P4V4DcOw
 d6Fp+OlZGtF1UguCU6tUo9KzGjveQh6EN+i7tmTpCOagZdxGX/SUXRhfG3uUVKNRCCoS
 T02xv+0qyXNxPZlOujWI8MiV5iecEv5MWGbl9Fn7MMZPFLRG2Mv9N5vHcD2OMKCohchW
 +uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743341451; x=1743946251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVmFKTID/yXVhMylSs7V4Dq8lGE/WIQZU2Ag6B1OoyY=;
 b=Px14rqNrVSpNnixkMob9Mrs0bleU8GhZ9nyXFIPqABLGJw+QmOvFaeo3svpRtb+bSN
 j6hUQW1ITSeo1UlQPF8p2d0qxo+BHfVC85CcMuoUJnlQKpgSL1r56lKrB3C0rB53EyPd
 Wgl9eZbBy17Gzyayfyp0m4GnrA3D/8jT2TaaImLbvZli0TJFkRdoEEWUZjx6u8LvocGq
 EIJ9+jl9aOhw+W4YFyCGxXOSQktpXDkF8xlH0FRuTzA7N7uW0/ApZsFcdIGpRMmBAnYv
 Rc8pqdVH2U//WvIN8XKx02HaQyrKNvLW4YSYiswKQY6R3aAzfIDrL9XBoPTUDQwsYops
 fWiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN4QZ9o6LWBEur+P+Tyoq2xzr2udq1sp44jUu+FqY+eUX9T5HtMvJha+8zT0453XfErGyF6So=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf8pQzrdPihcstr87xqndCTtPJd6KDZsT7UuCJQCZgikqX+Y26
 GpkK5GcfejA0eVAxduZk47naVa9SgXrATDtFjjy7nNBLmD1zG8S5m6GBkCLVMbc=
X-Gm-Gg: ASbGnctEtcQTUvZuOREw6Fe2ASuoM8m8Y6mH0Rl41DOek6HqRPQlmiBqDrdI5OmRhbw
 8ylcqnwxH9aLs2rR6pqfDR4IcOtQQjZTLRlmXAciluxIfA3pifEvnmWelHKV4TvGlBaYhEWTDNt
 V++hIETdABx1kSUTfV5bGdrln/FHWLT4pi4ELAG6fUlDnH6PsjoMy7hfTmXmgGCqjfGB8YVhqN1
 ZfTThjl2Wr2ryT9deeNv9Qp7CK9sN0L6/XB5sPgdrczSUISyuaXenMeZ3xzSN3IDoVSKrKhLQ2b
 CRHH2jMfUtdNiNFAgE5VZFsytUg4PdDyN/r5MJcXpYeW3gnpH0ndzAWBipoW1hgMnSKsBO3VtqY
 =
X-Google-Smtp-Source: AGHT+IFrxemQjfntBg2aXf06D1AogCTO4toTEp2ncisDQNpxEUfTd9OBuRcYXi3ndYyG8sswMm49XQ==
X-Received: by 2002:a05:6000:2910:b0:39c:1257:cc25 with SMTP id
 ffacd0b85a97d-39c1257cc6amr4759917f8f.56.1743341451187; 
 Sun, 30 Mar 2025 06:30:51 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66285bsm8481681f8f.21.2025.03.30.06.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 06:30:50 -0700 (PDT)
Message-ID: <fb7afec5-402e-476d-8bfd-b5cbc27b6f68@linaro.org>
Date: Sun, 30 Mar 2025 15:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] board/qualcomm: introduce phone config
To: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
 <20250311-qcom-phones-v2-1-83dcd88a6a87@linaro.org>
 <D8TGF97ZRSMG.2NFLDZX72HZ9E@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <D8TGF97ZRSMG.2NFLDZX72HZ9E@samcday.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Sam,

On 3/30/25 10:23, Sam Day wrote:
> 'Ello Caleb,
> 
> On Tue Mar 11, 2025 at 1:31 PM CET, Caleb Connolly wrote:
>> Phones don't have keyboards! Introduce a phone-specific config fragment
>> and associated environment file to make U-Boot more useful on these
>> devices. This allows for navigating via the buttons and enabling
>> various USB gadget modes or displaying info about U-Boot.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   board/qualcomm/qcom-phone.config | 17 ++++++++++++++
>>   board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a2aa882285b61746a243a7a1c7c384f33839f1b2
>> --- /dev/null
>> +++ b/board/qualcomm/qcom-phone.config
>> @@ -0,0 +1,17 @@
>> +# Settings for phones
>> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
>> +# Hang on panic so the error message can be read
>> +CONFIG_PANIC_HANG=y
>> +# We use pause in various places to allow text to be read
>> +# before it scrolls off the screen
>> +CONFIG_CMD_PAUSE=y
>> +CONFIG_BOOT_RETRY=y
>> +CONFIG_BOOT_RETRY_TIME=1
>> +CONFIG_BUTTON_REMAP_PHONE_KEYS=y
> 
> Maybe also include CONFIG_CMD_UMS_ABORT_KEYED=y here? Then folks can
> bail out of UMS mode without needing to hard reboot their device.

good idea heh
> 
>> +CONFIG_RETRY_BOOTCMD=y
>> +CONFIG_FASTBOOT_BUF_ADDR=0x1A000000
>> +CONFIG_USB_FUNCTION_FASTBOOT=y
> 
> I would propose to also add:
> 
> CONFIG_CONSOLE_RECORD=y
> CONFIG_CONSOLE_RECORD_INIT_F=y
> CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
> CONFIG_FASTBOOT_CMD_OEM_CONSOLE=y
> 
> This allows folks to pull down the U-Boot logs with `fastboot oem log`

Awesome, will add this too
> 
> CONFIG_FASTBOOT_FLASH=y
> CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> 
> Allowing to flash to partitions via fastboot (not sure about if/how UFS
> support works here though, I've only tested it on msm8916 with eMMC)

Unfortunately fastboot doesn't have a UFS backend (and the whole 
fastboot framework code is a big mess that needs a rewrite tbh).
> 
> CONFIG_FASTBOOT_OEM_RUN=y
> 
> Allowing to run arbitrary commands (e.g `fastboot oem run:'bdinfo')


for sure
> 
>> +CONFIG_USB_FUNCTION_ACM=y
>> +
>> +# Many phones don't actually define a serial port in their DTS
>> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
>> diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..2a0791c888c62b9f2257448358dd196a02e4b6fb
>> --- /dev/null
>> +++ b/board/qualcomm/qcom-phone.env
>> @@ -0,0 +1,49 @@
>> +bootdelay=0
>> +bootretry=1
>> +stdin=serial,button-kbd
>> +stdout=serial,vidconsole
>> +stderr=serial,vidconsole
>> +
>> +# Fastboot is keen to use the address from kconfig, but we
>> +# allocate its buffer at runtime.
>> +fastboot=fastboot -l $fastboot_addr_r usb 0
>> +
>> +# Shortcut to enable USB serial gadget and disable bootretry
>> +serial_gadget=setenv stdin serial,button-kbd,usbacm; \
>> +	setenv stdout serial,vidconsole,usbacm; \
>> +	setenv stderr serial,vidconsole,usbacm; \
>> +	setenv bootretry -1; \
>> +	echo Enabled U-Boot console serial gadget
>> +
>> +# bootretry will run this command over and over, if we fail once
>> +# then bail out to the boot menu instead (with a pause to read
>> +# the error message)
>> +bootcmd=bootefi bootmgr; pause; run menucmd
>> +
>> +# When entering the menu (either from button press or failed boot)
>> +# remap bootcmd so it will re-open the menu and we won't get stuck
>> +# at the console with no way to type
>> +menucmd=setenv bootcmd run menucmd; bootmenu -1
>> +
>> +# Pause is used so the output can be read on the display
>> +bootmenu_0=Boot=bootefi bootmgr; pause
>> +bootmenu_1=Enable serial console gadget=run serial_gadget
>> +bootmenu_2=Enable USB mass storage=ums 0 scsi 0
> 
> This doesn't work on my fajita unless I run `scsi scan` first. I note
> that this used to be in the preboot= section of default.env, maybe we
> should bring that across?

ooh yeah, the capsule update series should fix this since it calls 
scsi_scan() as part of initialising the capsule update into, probably 
better safe though.
> 
> Also, if you choose to include CONFIG_CMD_UMS_ABORT_KEYED=y per my
> earlier suggestion, it would be worth adding an "echo press any key to
> exit UMS mode" here or smth, I guess?

Makes sense
> 
>> +bootmenu_3=Reset device=reset
>> +bootmenu_4=Dump clocks=clk dump; pause
>> +bootmenu_5=Dump environment=printenv; pause
>> +bootmenu_6=Board info=bdinfo; pause
>> +bootmenu_7=Dump bootargs=fdt print /chosen bootargs; pause
> 
> I think options 4-7 should be at the bottom of the list since they're
> less typical/useful than jumping into usbacm/fastboot/ums modes. Reset
> device should be at the bottom of the list.
> 
> I'd maybe also go as far as suggesting that these could be removed
> entirely? Once you're in serial mode (or fastboot mode with
> CONFIG_FASTBOOT_OEM_RUN enabled) you can run these commands easily.

yeah i'll revise this
> 
>> +bootmenu_8=Enable fastboot mode=run fastboot
>> +# Disabling bootretry means we'll just drop the shell
>> +bootmenu_9=Drop to shell=setenv bootretry -1
>> +
>> +# Allow holding the power button while U-Boot loads to enter
>> +# the boot menu
>> +button_cmd_0_name=pwrkey
> 
> Two issues with using pwrkey as the boot menu trigger:
> 
>   * Many devices display a "custom OS" warning screen which can be paused
>     with the power button, which this will conflict with.
>   * When I trigger the boot menu this way, releasing pwrkey when the boot
>     menu shows up causes the first boot option to be selected. I note
>     this doesn't happen in your qcomlt branch so I'm guessing you did
>     something extra there to prevent this undesired behaviour?

ahaha i have a patch that makes buttons trigger on press instead of 
release, i didn't work up the courage to propose it upstream yet though.

These are very good points. We'll never find a perfect option but a 
volume button is almost certainly better. Unfortunately not every device 
names the volume buttons the same so, urgh. I'll see what I can come up with
> 
>> +button_cmd_0=run menucmd
>> +
>> +# Hold volume down to drop to a shell with the USB serial gadget
>> +# enabled for debugging
>> +button_cmd_1_name=Volume down
>> +button_cmd_1=run serial_gadget
> 
> I would propose to simplify this and just have one button_cmd that is
> used to pop the menu, since the serial gadget option is available there
> anyway.

Makes sense to me.

Thanks a lot for taking the time to give this feedback.

Kind regards,
> 
> -Sam
> 
> 

-- 
Caleb (they/them)

