Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E22DC021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 08:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08A080F32;
	Mon, 17 Feb 2025 09:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="QGyW8G7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A7280F3F; Mon, 17 Feb 2025 09:10:13 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B2480C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so26284545e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739779809; x=1740384609; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ln+lZBVM92C2IMHUW1RbRApgLs/vs9waNorximbyZI0=;
 b=QGyW8G7Znx/iQi/jAoYgh4in/AO+hug70BiFAe9ezFcItatj6FFLm1V4VLCT1Vj31D
 9LaEbBl/zKdrUi5K06RLoSzRQ2RjmejuQUN52Au/wZmmfe5p14lx8KOcq/Inw3AbUZN7
 +sxhoUIljXft/TzQLhbbdBvSko5dmsA1T3IjL9kkKCRxFEcuI8LqhAUBOHfeQDAN5KRd
 70rUF6jfj13HtpZWQkgiF03vagqw5yBh8QkuzjFVxpGwejFoh41qJ4MMXXBsiglvIY8D
 U+RPkSlYsoE61yDfifeToT/X8T7PYdbRcYymStYcrvNiCAem3Y+cB1iX6qHiYZuH6ccg
 vRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779809; x=1740384609;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln+lZBVM92C2IMHUW1RbRApgLs/vs9waNorximbyZI0=;
 b=Sx3CaggXr71jms1DqoBT6UQFKFBgfY+LcLE81wfvMYvFhp+2vZgGWBmZ42MoY7Qi3p
 NNdb/z90VAf+ZUfgFKpBMSg2hZZCZCHfH7sDpmq3M0Vryw8FDNvdyCaU66172D3YJwIN
 vFuTmQ3B9ikKnEuAjW8D6XzSEZKsrBRi2PO+HFVpGnR2TLk4l5r5JnKUJLQmXlQvBFPu
 ku6I+2vlbZ0diahEiiP95Obc9t7z1N4zadVk5CT+L/+OwIk7GJGRdI6o3RQ+NiAlGJxw
 xwpCs/xmxrOjqqWZ511Wz5r0kTbdYE1wpSBJvKWLTGSWShb4iyqFeCMom95r9+qnHndo
 Aazw==
X-Gm-Message-State: AOJu0Yz+8WP/xmJfgKW9ch00d/wiGoP4hNi3O57YY3Itt8yVpa9UCpB5
 tJpLAcdviGfl5BcmdDJjJdyyj+VUajHbNe7RgFLeV3igVleBZSrcRPM1iTsr4Qc=
X-Gm-Gg: ASbGncvXwMP7V5ef9pUMSfuv9O5HSXnlUI2l2bFSbG656mK033KE67D8yllJ/VAO7W2
 w357DXS3IS8g/WsgAy5v3pMPz48rmLNzlp2/ploED4JHqoKauCQ/uRsEG89LMQ4ekGVmaw4khAs
 1Mba/BpruGmfvejQJF4piubM7SYP4oFhP4/uU1eCAycfWrE5Bw8cPPKeejBqYP/R/t4Tf1VFoot
 Udz8kJTMSqwike4sZvZDVccsocDmP0WMqP1m06/P2KJIaZbHlQLcnu+UENJXxfhc6MaqIMjKxTs
 FNO9mnYWverG
X-Google-Smtp-Source: AGHT+IEk0VlaUcAe0pu9suaaNXduwEB+Vrg61iSap8ZCzMwheoJyXANavsa9topOi2yabSKDKIo5xQ==
X-Received: by 2002:a05:600c:5247:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4396e6fe2b3mr78915415e9.17.1739779808884; 
 Mon, 17 Feb 2025 00:10:08 -0800 (PST)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8217sm11713358f8f.90.2025.02.17.00.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:10:08 -0800 (PST)
Message-ID: <5654352d-3919-4fa7-855f-b0d8a2dde84f@suse.com>
Date: Mon, 17 Feb 2025 09:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Raspberry Pi: copy /system/linux, {serial, revision} from
 firmware
To: Simon Glass <sjg@chromium.org>, Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
 <CAFLszTgiA3_SsQEPg_+denTdJ3hMrWyKPsQUho5=EjeOF_W5XA@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <CAFLszTgiA3_SsQEPg_+denTdJ3hMrWyKPsQUho5=EjeOF_W5XA@mail.gmail.com>
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



On 15/02/2025 13:05, Simon Glass wrote:
> Hi Fiona,
> 
> On Tue, 11 Feb 2025 at 07:56, Fiona Klute <fiona.klute@gmx.de> wrote:
>>
>> Both the Raspberry Pi downstream kernel [1] and some userspace tools
>> [2] use the revision property to identify the board, and the latter
>> fails if it is absent. The firmware creates the /system node, so we
>> need to do the same.
>>
>> [1] https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
>> [2] https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> Cc: Matthias Brugger <mbrugger@suse.com>
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>> I'm sending this as RFC because I'm not sure if creating a temporary
>> overlay is the best approach here, advice on a better way to create the
>> /system node if needed is very much welcome. I know I'll need to add
>> more error checks, I'll do that after I know I have the right approach.
>>
>>   board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
> 
>  From my side, if my rpi seriesl[1] results in my becoming a rpi
> maintainer, I'll take a look at this and other pending rpi patches.
> 

I think your review would be highly valuable, being a maintainer or not.
I'm not sure what conditions the maintainer role with doing a review.
Actually the normal road for getting a maintainer starts with reviewing patches.

Handle that as you like, I was just puzzled by your message.

Regards,
Matthias

>>
>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>> index aa39afa338a..647716127c7 100644
>> --- a/board/raspberrypi/rpi/rpi.c
>> +++ b/board/raspberrypi/rpi/rpi.c
>> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path, char *property)
>>          return fdt_setprop(dst, dst_offset, property, prop, len);
>>   }
>>
>> +int copy_system_node(void *fdt, void *fw_fdt)
>> +{
>> +       const fdt32_t *prop;
>> +       char fdto[2048];
>> +       int src_offset;
>> +       int len;
>> +
>> +       src_offset = fdt_path_offset(fw_fdt, "/system");
>> +       if (src_offset < 0)
>> +               return -1;
>> +
>> +       fdt_create(fdto, sizeof(fdto));
>> +       fdt_finish_reservemap(fdto);
>> +       fdt_begin_node(fdto, "");
>> +       fdt_begin_node(fdto, "fragment");
>> +       fdt_property_string(fdto, "target-path", "/");
>> +       fdt_begin_node(fdto, "__overlay__");
>> +       fdt_begin_node(fdto, "system");
>> +
>> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
>> +       if (prop)
>> +               fdt_property(fdto, "linux,serial", prop, len);
>> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,revision", &len);
>> +       if (prop)
>> +               fdt_property(fdto, "linux,revision", prop, len);
>> +
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_finish(fdto);
>> +
>> +       fdt_overlay_apply_verbose(fdt, fdto);
>> +}
>> +
>>   /* Copy tweaks from the firmware dtb to the loaded dtb */
>>   void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>   {
>> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>          /* The firmware provides a more precise model; so copy that */
>>          copy_property(fdt, fw_fdt, "/", "model");
>>
>> +       copy_system_node(fdt, fw_fdt);
>> +
>>          /* memory reserve as suggested by the firmware */
>>          copy_property(fdt, fw_fdt, "/", "memreserve");
>>
>> --
>> 2.47.2
>>
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=437666

