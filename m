Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FD1C5AD2B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 23:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB1C76085B;
	Fri,  7 Aug 2026 23:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8eDRIlXyvGg; Fri,  7 Aug 2026 23:06:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBEF260846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786143983;
	bh=6BWOIpGaxnsb46+M28mVJPNqofUexhFv/41OEXVR44s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uKCITrOwORXDNjqJebahlMpsTjIv9a83t52qrWTbn140QgDtyizwcyGTNMOXv0x41
	 o4armAFPA6eqlkUSIU5boDm7OBMnlc1zVoT3c/vaPQhDadl1evk7Ys6AP+IqNsluL0
	 2zB8kV5ghWZ+w/LAywiTZTokHbUMJ48FxIo8fo+Pr4S2YcJ4fn0fmg86JzuTcwV0s3
	 oebTFhi2w2EeVyo4AXAathqxZP3D/UBrDxx31mxv8sLMxdcEzPWkQAElYNkdX1n8f0
	 x6l73tywCw/Lz/+bNd0pttViSHHPt2PSuwXIcrCzKCjTh54R0a+rRxmXb0GVP5ibjQ
	 lVQ/WpvmuPOTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBEF260846;
	Fri,  7 Aug 2026 23:06:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE1EB3A9
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 23:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3CE34031E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 23:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t0BNgLfpWMJD for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 23:06:21 +0000 (UTC)
X-Greylist: delayed 5112 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 07 Aug 2026 23:06:19 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0FC6140226
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FC6140226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=bda0=gb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FC6140226
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 23:06:19 +0000 (UTC)
X-Forward-Email-ID: 6a7664e8cd6642dfb886ba1a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <da12d1c4-d3bb-4b11-82c9-1210ee1ac97f@kwiboo.se>
Date: Sat, 8 Aug 2026 01:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260807090431.464978-1-jonas@kwiboo.se>
 <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
 <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
 <CAFLszTgso=ayEMwx+cF9FDPis1VmO4yQYH+3qoxWbah_GSnfug@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgso=ayEMwx+cF9FDPis1VmO4yQYH+3qoxWbah_GSnfug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786143979;
 bh=6BWOIpGaxnsb46+M28mVJPNqofUexhFv/41OEXVR44s=;
 b=ARQIW6DOnhhgTg12b3vIG61k/ZWsqC2SjCkUkbdj7SfBLI8dDvEGM1iw7XFFFOnTYHoGnk2ya
 x8ZAkvtRjaL5wKCEn3NmXLoYAIG2yhlFujAH+gOHXRQwm6rpS+YMKmTHlSkdgaBx2M1e0MJJqBW
 oeltxrnUV8a1CkNnB8rO0yZ4squhEic54LgWL3WlBvOlYnq0tVFYjfLdaQBkX8sI3MWnN4iCbUF
 nw02EvbIdz0Xd3ehpfWqTF4tM/7ZjN5TVOpv+Ip06EnUzC68MUMwE5KmNPl0WzdnNdHL0jTylK2
 q5utS+UKthQTkUAvDABiH/PDnPouAUw002ORimaBOswQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ARQIW6DO
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On 8/8/2026 12:00 AM, Simon Glass wrote:
> Hi Jonas,
> 
> On Fri, 7 Aug 2026 at 15:41, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 8/7/2026 10:40 PM, Simon Glass wrote:
>>> Hi Jonas,
>>>
>>> On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
>>>>
>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>>
>>>> SRAM addressing only seem to use 14 bits, meaning that reading from
>>>> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.
>>>
>>> Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
>>> below -> 'possibly looks'.
>>
>> Thanks, will update in a v2.
>>
>>>
>>>>
>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>>> reserved region for its global data, malloc area and runtime stack.
>>>>
>>>> TPL on PX30/RK3326 does not have any use for the malloc area and the
>>>> generated GD_SIZE is typically around 304 bytes.
>>>>
>>>> Current memory layout possible looks something like:
>>>>
>>>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>>>>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
>>>> [...]
>>>>
>>>> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>>>>  common/spl/Kconfig.tpl              | 2 +-
>>>>  tools/rkcommon.c                    | 2 +-
>>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
>>>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
>>>> -     default 0x2800 if ROCKCHIP_PX30
>>>> +     default 0x2c00 if ROCKCHIP_PX30
>>>
>>> Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
>>> stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
>>> __image_copy_end and is not counted by the TPL_MAX_SIZE assert in
>>> u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
>>> headroom is a bit less than 720 bytes.
>>
>> You are correct, current BSS is 72 bytes, will update the commit message
>> to mention that the 720 bytes must fit both BSS and the stack in a v2.
>>
>> What is interesting is that global data is so large, especially when in
>> this case nothing here is really using global data. We could save 16
>> bytes by fully disable CONFIG_TPL_SYS_MALLOC_F, but that was too
>> intrusive to be part of this fix.
> 
> Well we have DRAM in there now. Actually now that Ilas' series is in,
> we could take a look at trimming and aligning things - some things are
> long which could be int, which matters on arm64.

The px30/rk3326 boards do use CONFIG_NR_DRAM_BANKS=1 or 2, so dram
should at least be limited somewhat.

I think there are some DM related fields that could be excluded to save
little bit more space. With below diff the GD_SIZE is down to 240 bytes,
16 for TPL_SYS_MALLOC_F and remaining 48 due to the DM related fields.
Not sure this is safe, but the odroid-go2_defconfig could be built.

I do not think the global data size is really a big issue for this
board, but rk3036 only have 4 KiB that need to fit SPL (2716b),
BSS (0b), global data (160b) and stack. SPL image is down to 2716 bytes
after upcoming TPL refactoring at [1] (tpl branch).

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index dfdea66cd70c..c5fd6514010c 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -118,3 +118,4 @@ CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
+# CONFIG_TPL_SYS_MALLOC_F is not set
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index fd116b0cebf2..886c12900ddb 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -174,10 +174,12 @@ struct global_data {
 	 * @arch: architecture-specific data
 	 */
 	struct arch_global_data arch;
+#if CONFIG_IS_ENABLED(DM)
 	/**
 	 * @dmtag_list: List of DM tags
 	 */
 	struct list_head dmtag_list;
+#endif
 	/**
 	 * @timebase_h: high 32 bits of timer
 	 */
@@ -228,7 +230,7 @@ struct global_data {
 	 */
 	long precon_buf_idx;
 #endif
-#ifdef CONFIG_DM
+#if CONFIG_IS_ENABLED(DM)
 	/**
 	 * @dm_root: root instance for Driver Model
 	 */

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/8c8b98a29aa35880b93bbacce8daf68edb537eca

Regards,
Jonas

> 
> I also did some work on struct board_f which is another way to reduce
> space, if we can find more things which are only needed in early board
> start-up. I suppose we could even expand that to include the
> board_init_r() calls.
> 
> Regards,
> Simon

