Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D544BC83F21
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3D28645F;
	Mon, 28 Aug 2023 12:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+toC9sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A784807C4; Mon, 28 Aug 2023 12:33:54 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6439A864B7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcde83ce9fso45476191fa.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693218829; x=1693823629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3z95XzOe3ZF2SDLCQhR6hHjsyrGhI+kOR7x7SCS34Y=;
 b=P+toC9sdrcgTA1vvQG/M//KJm29A5X9zosNy/zVpiP4Iu7BUe4+64DuJIH/CO3UiB6
 3dVE/8O7QSHslliQEzNDERv0z4KgQfyvEh8GdR2Dp8udkhRkWOoQ2QyGoRlTwNpSF0fS
 yZIaYkYrz7jCYwbL2eUcxcJNJONZEdCQUyAIPfesGu8auMkTrdEpSGXDP5VW25SVG6n3
 TrouxXp6vLZR6cTasHEFDq32Aje63PqoAcQyt++4nyn0R5+s3gdgv/eU/5Fs+/ob+ydy
 ++INIX/df7Lt21fyDexlN3mEbrxqIe4O5wuAre7A/0BEWSPzdPC99RJuwOIKYvmM1YDr
 O1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693218829; x=1693823629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3z95XzOe3ZF2SDLCQhR6hHjsyrGhI+kOR7x7SCS34Y=;
 b=eA/Q9HKKJX9TZNd5x7/Rn8AvWWA3hGuXwAnAvcmnwRRZ2aDqfxuGp2J+9jb9jIX0bI
 Pe5vjTwtq7RbXaT0ycv+TmjPKpQWrwz3xe6EpfPcxR5YMZHZ0EMbulu5PkSgikdLY5WV
 BAnRIjAgJdLlqBVkjQfuquiDcVfNZ4fkvvhsHqF1WcPLByobGdrYBCR1FWyIldrd9sRl
 nZgKVtUaqswoOAuukxX3hqnOmNS9jwJJNjF6zNfprwMI98OUEjMqjWb5A2YpaUL8o7RW
 FQXLjI0miCoufH67SleE5QLn2fU11Fi8U74/W6O4QCC8euBK7DXGN9FkcwlM0xwWQ2KY
 ZCKA==
X-Gm-Message-State: AOJu0YwcUiSyPHZPF1v6zmmXxlhsA9rMJjU4VfXEC4ePvaIcffhBykvz
 99la4fJB80QciY+kyB3qKvo=
X-Google-Smtp-Source: AGHT+IFiOVZolVbp8nC2L/4rh0eJCxNczzE/4GDpcgTEXyqrCAc214gyORG+4GNADU8KXvwJdhMoKA==
X-Received: by 2002:a2e:9bcc:0:b0:2bc:bc70:263f with SMTP id
 w12-20020a2e9bcc000000b002bcbc70263fmr15563667ljj.0.1693218829188; 
 Mon, 28 Aug 2023 03:33:49 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a7bc7d3000000b003fe2b6d64c8sm7880996wmk.21.2023.08.28.03.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 03:33:48 -0700 (PDT)
Message-ID: <c87335a8-735f-4b19-8761-002dddc3da5b@gmail.com>
Date: Mon, 28 Aug 2023 13:33:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] qfw: Spawn ramfb device if its file is present
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Alexander Graf <agraf@csgraf.de>, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-4-alpernebiyasak@gmail.com>
 <CAPnjgZ1f14MJFz0vy8SNnzud4VFEkHunu8_+Md1C1UOW2pKTwA@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ1f14MJFz0vy8SNnzud4VFEkHunu8_+Md1C1UOW2pKTwA@mail.gmail.com>
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

On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> Hi Alper,
> 
> On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> From: Alexander Graf <agraf@csgraf.de>
>>
>> Now that we have a ramfb device driver, let's add the necessary glueing
>> magic to also spawn it when we find its qfw file node.
> 
> So then how do we select which video driver is used? I think we should
> have this in the DT so there is some control.

I think you mean choosing between multiple potential video devices for a
video console, but just in case: AFAIK only the ramfb driver can be used
with -device ramfb, unlike how either vesa or bochs can be used for
-device VGA.

This series is less about being able to use multiple video devices, but
more about supporting by default different configurations in which QEMU
can be launched: with "-device VGA" or "-vga none -device ramfb".

That being said, I had some success with multiple video console
attempts. For "-device VGA -device ramfb", we need to make `*addrp -=
CONFIG_VAL(VIDEO_PCI_DEFAULT_FB_SIZE);` unconditional in video_reserve()
 to correctly allocate for both vesa and ramfb. Then we can run `env set
serial,vidconsole,vidconsole1` which sets up both video/vidconsole
devices with same text content.

Regardless of this series, with VIDEO_PCI_DEFAULT_FB_SIZE=0x3000000 and
"-device VGA -device VGA -device VGA" we get two broken and one empty
display, and `env set serial,vidconsole,vidconsole1,vidconsole2` puts a
console to the third display. I think it's a bug the first two are
broken, and it's initially using the first broken display as vidconsole.

Anyway, my opinion is: if stdout/stderr has "vidconsole", we should
enable a vidconsole on all consoles, but if it has "vidconsole#" we
should only enable the one on that video# device. Then device-tree could
have /aliases { video0 = "..."; video1 = &...; } or something to have a
stable order?

Or, you might mean adding a ramfb node to the device-tree, in which case
that's going to reopen a can of OF_BOARD worms... (Same as what applies
to putting bootph,* into qfw device-tree node, so I'll reply there.)

>> [...]
>> 
>> +static void qfw_bind_ramfb(struct udevice *dev)
>> +{
>> +       struct fw_file *file;
>> +       int ret;
>> +
>> +       if (!IS_ENABLED(CONFIG_VIDEO_RAMFB))
>> +               return;
> 
> Needs an error-code return
> 
>> +
>> +       ret = qfw_read_firmware_list(dev);
>> +       if (ret)
>> +               return;
>> +
>> +       file = qfw_find_file(dev, "etc/ramfb");
>> +       if (!file) {
>> +               /* No ramfb available. */
>> +               return;
>> +       }
>> +
>> +       device_bind_driver(dev, "ramfb", "qfw-ramfb", NULL);
> 
> check error
> 

Will try to fix both, thanks.
