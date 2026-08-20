Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125CEC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADD1380DAE;
	Thu, 20 Aug 2026 17:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQaRFU3_JZMl; Thu, 20 Aug 2026 17:46:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787247997;
	bh=KGNARU2JevwdN2yt6OAXuviaK5/oLGo+Am52XHo/3f8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPt3ANsi1iibqgnPzM6uzoM5yryaEmvsHowjqNqitNVX4UgfcZLO+qYqTOlqA6DLU
	 mv0u2B8vaQrGcmkEMwPl459FGEVR8Kdf8bhr/8gN/UikEL2lbFKpV5b4NEKIgmgBaY
	 t8+P6x5PpD6yRyO03//qHCk0ilRrQ43CnN3Yu/clp9vCHcw9h1Oi9xiJ9PMMY5qrsw
	 ud5hJ8rIJZl7mct1epJx+fl4guJiqc5knOAsUc5RAmJVjdh4KlvCjcQKBQztoG7YIq
	 8L3nwbm9nXw7WXeIIB/C1kXoRbdfHnbslItepyciA3vaI735nXOR5liJerVpR8dvw0
	 eIRhouJPduXOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE6EB80E5F;
	Thu, 20 Aug 2026 17:46:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FC0BEA3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA5B280DAE
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1e9DKuC5ZXVT for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:46:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=4da3=go=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=SQXygdp9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE6EA80C6C
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787247993;
 bh=KGNARU2JevwdN2yt6OAXuviaK5/oLGo+Am52XHo/3f8=;
 b=SQXygdp9yYQcvCA+dNw099ze2hHMLzIeTU59rXcjfY+DA/4pcWh2vjFva1/gob/55f1Y5MRwN
 U+wGQ7bVN5vQ3+Um11M38fjDdDoa2cfwoY5h/OjmayF4fmx+CUma2HktLDDA6ERpJ0DhUKbpSdy
 b7JJvYPOVoU+2FYJdXQE4zLPVkB8V/Ie6HA7Sqe4i31MZyTe6imRz+DuglT9jhiICHkKDXigHaZ
 0o06FWVp1LLxY41mnsUzjzOmz8ggRcYZ7x0hvPYVNBHFE7kgSU+RMx64fV455/4RQY7spZZHOpG
 jBU4hyTvaFL40yvGh8njYpd8cdE8bER3ZKkNTBOyDqNA==
X-Forward-Email-ID: 6a873d70c1bb5b8470dc5de5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e172b074-798a-4b29-b080-0e2f8eb28d29@kwiboo.se>
Date: Thu, 20 Aug 2026 19:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFJl77yaUmU6IFtQQVRDSCB2NF0gYXJtOiByb2NrY2hpcDogc3Bs?=
 =?UTF-8?Q?=3A_Add_hotkey_detection_support=2E?=
To: =?UTF-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org
References: <20260818165526.764686-1-valentinliu@icloud.com>
 <20260820162757.665777-1-valentinliu@icloud.com>
 <5328ff1c-2b50-42e2-9137-9e5f6720c345@kwiboo.se>
 <10130988-a918-4968-b2d6-b4b4600d2f85@me.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <10130988-a918-4968-b2d6-b4b4600d2f85@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/20/2026 6:52 PM, 刘垣辰 wrote:
> Hi Jonas,
> 
> I really consider your idea before writing this patch, however, this patch is a standalone function. The Rockchip U-Boot branch has the same function

Vendor U-Boot having a feature is not always a good reason for including
it in mainline.

> 
> If you want to use "reset" command to reboot into MaskROM or any other mode, you must be able to enter the U-Boot (not SPL) or higher level OS. But sometime, we will unable to enter them (Like booting failure on out our control of firmware), we just need to rely on the physical buttons to hard (or cold) reset device. But if we haven't the physical button, there will be harder.

In case SPL fails to load the payload we could implement some kind of
hang() fallback to BROM [1].

We probably would want to use a watchdog to truly recover from the event
that next stage crashes/fails/hangs. Possible something like write value
to boot-mode, start watchdog, try to load payload, re-arm watchdog in
U-Boot proper and clear out boot-mode.

Btw, there is nothing that acts on BOOT_LOADER and BOOT_FASTMODE is only
handled in U-Boot proper, so those are not really useful in SPL.

Some SoCs also clears out the boot-mode reg during reset, see [1].

[1] https://patch.msgid.link/20240202001221.531207-1-jonas@kwiboo.se/

> 
> Absolutely, we also can't rely the fallback of firmwares, so the SPL hotkey can control what mode we want to enter in SPL stage.

Are you having issues with U-Boot proper crashing, or SPL fails to load
the payload, or it becoming corrupt or similar? What issues are you
facing that prompts the need for this SPL hotkey feature?

Normal boot path for Rockchip is to use a FIT and let SPL checksum
validate any payload before it gets executed. So as long as working
firmware is loaded reaching U-Boot proper is typically not an issue.
And SPL can typically fallback to load payload from a different boot
media, so recovery into a working U-Boot proper it typically easy.

At least those fallback options is something I validate for each SoC
and/or board that I contribute on.

Regards,
Jonas

> 
> I also like the unified "reset," but that is unrelated to the functionality provided by this patch.
> 
> Best regards,
> Valentin Liu
> 
>> 2026年8月21日上午12:36，Jonas Karlman <jonas@kwiboo.se> 写道：
>>
>>
>> Hi Valentin,
>>
>> On 8/20/2026 6:27 PM, Valentin Liu wrote:
>>> Add a configurable Rockchip SPL hotkey feature that checks the
>>> serial console during SPL startup.
>>>
>>> Ctrl+B can be used to enter MaskROM mode and be widely used.
>>> Ctrl+D can be used to enter Loader mode, Ctrl+F for Fastboot mode.
>>> We can add more boot mode support in future.
>>
>> Why the need to have special hotkey handling in SPL?
>>
>> I would rather see that we extend TPL/SPL/proper with support for
>> reading any 'syscon-reboot-mode' reg and act according to that.
>>
>> Also think there is a series on list to extend the reset command to
>> accept a reboot-mode.
>>
>> That way we would be able to reboot from OS or U-Boot proper into
>> maskrom (or any other) mode, instead of trying to implement platform
>> specific hotkey handling.
>>
>> Regards,
>> Jonas
>>
>>>
>>> Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
>>> the serial port to be ready to receive input before checking for
>>> hotkeys.
>>>
>>> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
>>> ---
>>> Changes for v2:
>>> - Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
>>> - Remove the conditions for the newly added includes.
>>> ---
>>> Changes for v3:
>>> - Add a dummy spl_hotkey_init() to avoid undefined reference errors
>>> when building without CONFIG_SPL_ROCKCHIP_HOTKEY.
>>> ---
>>> Changes for v4:
>>> - Add condition of CONFIG_ROCKCHIP_BOOT_MODE_REG != 0 to prevent
>>> SPL hotkey be compiled and used on unsupported platforms.
>>> - Add more hotkey support (Ctrl+D and Ctrl+F).
>>> - Remove prints on the standard path.
>>> - Add some code comment.
>>>
>>> arch/arm/mach-rockchip/Kconfig | 14 +++++++++
>>> arch/arm/mach-rockchip/spl.c | 54 ++++++++++++++++++++++++++++++++++
>>> 2 files changed, 68 insertions(+)
>>
>> [snip]
> 
> 

