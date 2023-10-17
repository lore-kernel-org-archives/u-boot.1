Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C0CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDA686BAA;
	Tue, 17 Oct 2023 14:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlOyDO/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDD686E37; Tue, 17 Oct 2023 14:44:58 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAAA86BAA
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so9726907a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697546695; x=1698151495; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NcJV99SNOv/PQ0DkkMQ0BekJnz0bz1POt6UAzQQb5wI=;
 b=FlOyDO/k2PuUn0PClSnSI7lpMeCCKCFrL01pUVNC6ENah4XahVmNYiVrdG4+DbgsCW
 LSt1KQ6SIqK3dZc0k7Pj0e1BZF6opLmKdTAIYLZEaQEyqDjDTDN2GsjeINjEU/NQ5J7C
 UjyvI6CijDVUbNvGCNvHsW4n8Emw23FY+RxttlKp9XG1rnvgRlIjMjU5vSQdifa7Nu/S
 xCHFNbJxUfo3biqv2JRh4rywBDImuI1BAON4XkSAdjUnwpJAh2a7PVGw8XPtmJA/y1b1
 FFCOX0t6swNSXGRxUUPncP7wnoaJ9OcqxRGOfdy2gSOX9vINCl5A6EzJaDQKdne1nUY9
 MUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546695; x=1698151495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NcJV99SNOv/PQ0DkkMQ0BekJnz0bz1POt6UAzQQb5wI=;
 b=jMmYw3HOj7bRw2mXogbghiwSIw8kEyqLVO6yEHkAmWObhkoIM5tOXtwzcOx2WY6Ksg
 5DODYgg8vyQO8WEE+IEgBNrzcfs3SG7+rJrkWJFgqSxmmHmR4JK7CfVhsAbQJqSFmNMV
 fODOqk8aHRu3WVCkYrvdyrkBxMHsvjmpNiNysLMnppZjL021UcIZy2z9M1zmZZ1au4KJ
 iNNb/SzkZMR3Dl6FGpnuVWmjHTxiudroA2gTjaev2e5EftR77FDnr4qmRltDWj2J+ZsX
 HzGWiE2e2PcFuzbrJ4MBr+gelPbqN0zUop6vnlSNNubVEjDapTGVmjwrV8TTyYrgjXhY
 NVWQ==
X-Gm-Message-State: AOJu0Yz8JjbvMUU04sjs0GjRds0CIL351IeY9SjMbfD10Qis6IJ4FgoA
 TeNGDSKaIHpV0opWa5oY5YI=
X-Google-Smtp-Source: AGHT+IF/SNKGSNRfSw/3NPslIVZnaJhbud28hSdTeei2cuXYdR4Zs21tSHrOxFSWWz25nLBwyFj/yQ==
X-Received: by 2002:a05:6402:26cc:b0:53e:3584:d395 with SMTP id
 x12-20020a05640226cc00b0053e3584d395mr1701555edd.34.1697546695478; 
 Tue, 17 Oct 2023 05:44:55 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a50d597000000b0053e2a64b5f8sm1159490edi.14.2023.10.17.05.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:44:54 -0700 (PDT)
Message-ID: <64400549-5a62-8079-cbd6-2a099c2b06ec@gmail.com>
Date: Tue, 17 Oct 2023 14:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/8] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
To: Simon Glass <sjg@chromium.org>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
 <fd206328-2ffa-c174-179c-85f6428e5d9f@gmail.com>
 <CAPnjgZ2bs2ZE87W71h_4V91M3gyCtCV7vbHVnGwGE+Hmt2LfuQ@mail.gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAPnjgZ2bs2ZE87W71h_4V91M3gyCtCV7vbHVnGwGE+Hmt2LfuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 10/16/23 23:54, Simon Glass wrote:
> Hi Johan,
> 
> On Sun, 15 Oct 2023 at 16:33, Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Disable bounce buffer support for rkmtd.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changed V3:
>>   New patch
>> ---
>>  drivers/block/blk-uclass.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
>> index 30ad5bbb0024..ac1b43d757d8 100644
>> --- a/drivers/block/blk-uclass.c
>> +++ b/drivers/block/blk-uclass.c
>> @@ -415,7 +415,7 @@ struct blk_bounce_buffer {
>>
>>  static int blk_buffer_aligned(struct bounce_buffer *state)
>>  {
>> -#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)
> 

> We should not have arch-specific code in a generic file. Can you make
> BOUNCE_BUFFER depend on !RKMTD ?

Hi Simon, Marek,

No that doesn't work that way.

On Rockchip mainline boards MMC_DW is always our boot device BOOT_DEVICE_MMCx.
Therefore BOUNCE_BUFFER is also standard enabled.

The solution in this patch below is wrong as it assumes that if BOUNCE_BUFFER is enabled it must be used all over the place.

blk: Add bounce buffer support to read/write operations
https://source.denx.de/u-boot/u-boot/-/commit/75191f75bce45f3b9aff607c88f17778d3805c61

All implementations of bounce_buffer_start and bounce_buffer_start_extalign are located in the individual drivers  

https://elixir.bootlin.com/u-boot/latest/C/ident/bounce_buffer_start
https://elixir.bootlin.com/u-boot/latest/C/ident/bounce_buffer_start_extalign

The use of a bounce_buffer in block devices should only be allowed if needed.
Lack of "ops->buffer_aligned" does not prevent the creation of a bounce_buffer and is not a good selector yet.

	if (ops->buffer_aligned)
		return ops->buffer_aligned(dev, state);

Current blk_ops has no option to communicate the needed resources.
Please advise how to select the creation of a bounce buffer per device or other solution.

Johan

===
config MMC_DW
	bool "Synopsys DesignWare Memory Card Interface"
	select BOUNCE_BUFFER

Without BOUNCE_BUFFER selected /drivers/mmc/dw_mmc.c does not compile even rk3066 only uses "fifo_mode".

arm-linux-gnueabihf-ld.bfd: drivers/mmc/dw_mmc.o: in function `dwmci_send_cmd':
/drivers/mmc/dw_mmc.c:285: undefined reference to `bounce_buffer_start'


		if (host->fifo_mode) {
			dwmci_writel(host, DWMCI_BLKSIZ, data->blocksize);
			dwmci_writel(host, DWMCI_BYTCNT,
				     data->blocksize * data->blocks);
			dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
		} else {
			if (data->flags == MMC_DATA_READ) {
				ret = bounce_buffer_start(&bbstate,
						(void*)data->dest,
						data->blocksize *
						data->blocks, GEN_BB_WRITE);
			} else {
				ret = bounce_buffer_start(&bbstate,
						(void*)data->src,
						data->blocksize *
						data->blocks, GEN_BB_READ);
			}
[..]
		}

arm-linux-gnueabihf-ld.bfd: /drivers/mmc/dw_mmc.c:393: undefined reference to `bounce_buffer_stop'


		/* only dma mode need it */
		if (!host->fifo_mode) {
[..]
			bounce_buffer_stop(&bbstate);
		}

> 
>>         struct blk_bounce_buffer *bbstate =
>>                 container_of(state, struct blk_bounce_buffer, state);
>>         struct udevice *dev = bbstate->dev;
>> @@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>>                           start, blkcnt, desc->blksz, buf))
>>                 return blkcnt;
>>
>> -       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
>> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>>                 struct blk_bounce_buffer bbstate = { .dev = dev };
>>                 int ret;
>>
>> @@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>>
>>         blkcache_invalidate(desc->uclass_id, desc->devnum);
>>
>> -       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
>> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>>                 struct blk_bounce_buffer bbstate = { .dev = dev };
>>                 int ret;
>>
>> --
>> 2.39.2
>>
> 
> Regards,
> Simon
