Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1237C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 09:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902438655E;
	Thu, 31 Aug 2023 11:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fYPT6Rqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92828655F; Thu, 31 Aug 2023 11:25:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFF286556
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 11:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso5574235e9.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693473914; x=1694078714; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uc2c0xPtnoXRKoQRAsCCV2mchl29y1wj8jAD5MOvbv0=;
 b=fYPT6RqfUQVnM7WrwCdhN2Qjv6WWTY1AHLDDMuR6O7Oz0GLiTQ04Tl71bBfimlIwER
 awhzGEvqdDFu+RC+Kl3gS/SVt7uZwPfs+au1iMtaO/cbWqFnO7B5YX4408bTUTG/jXyG
 x4k9ojRCEtNk3wzxhOpHNvSn+92V9u5nMS5p5lIh6GoKNwZXu7PKjdeLx2IQ9L4uUWEp
 s2iIcx37G8jNgveiodtu8Xe19ILK8+XsTYbtoFd2vz/cXbN5bieXXfVAOil1ck9Btl6N
 Y9aOUYxiHEEEEOie07aY/HIp8RkOX9kAor2azUfUISQ/IP7d0JL4rIA7BdTwCej8rMXW
 Dctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693473914; x=1694078714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uc2c0xPtnoXRKoQRAsCCV2mchl29y1wj8jAD5MOvbv0=;
 b=YVEX/9zA5fkZTVfbIxULlMbtWRgvqvjcMsNnk+gGXvrO/YY/2e+mOkjR2s4BJ0w01h
 TMuj4iqg33W3rxPSZMZMv1NHlWleQCKp6xvjV64eBBh+TfZFS++qshvnDUEbDqZZJlf0
 ndp3KLhwzY20fqm92VZ5nkPmlPABx5JYR2wgp3GJ4BMtdeJoIbqaDyJLigpYUG4gshnh
 DVdTnG7vnB3gDOCA5sNdWjzoR86Wa0TNTQNimW7iZhWBCsTfUImsQBdbNUWTAlZ0Z0AU
 6U+sFFqmvyPO+1OP78rTkCwSHezRUTjlDP5Eb5InEo7VkMxz8MuGN+l4dTUT9UZkGU6C
 c1VQ==
X-Gm-Message-State: AOJu0YxovoSasAhGvoP4CUnrfcftQK9PPJw8CuxE89qci48EP9f5MlRU
 qVCcAlFw8r/ms0h42qNr7So=
X-Google-Smtp-Source: AGHT+IF30qeGkOBNCpcPyDSF2fIGG1mVZBSLH2EBrhUwGnjzUpbcwGapxjYYL+qq3nzDy4LP9bFLQQ==
X-Received: by 2002:a05:600c:1ca8:b0:3fa:71db:56ff with SMTP id
 k40-20020a05600c1ca800b003fa71db56ffmr659840wms.40.1693473913451; 
 Thu, 31 Aug 2023 02:25:13 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c025900b003fbca942499sm4580137wmj.14.2023.08.31.02.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 02:25:12 -0700 (PDT)
Message-ID: <4e21c034-102a-4aac-b630-43546e97de5e@gmail.com>
Date: Thu, 31 Aug 2023 12:25:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
Content-Language: en-US, tr, en-GB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
 <CAC_iWjKADqX3HaJON6CELbGeAD5VDvdyGfgHPxCjA8G+YRd7gg@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAC_iWjKADqX3HaJON6CELbGeAD5VDvdyGfgHPxCjA8G+YRd7gg@mail.gmail.com>
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



On 2023-08-30 10:33 +03:00, Ilias Apalodimas wrote:
> Hi Alper,
> 
> On Sun, 27 Aug 2023 at 18:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
>>> Hi Alper,
>>>
>>> On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>>> I actually want to put the root.img device first so that the VM can boot
>>>> into the installed system when it reboots, but U-Boot can't find the
>>>> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
>>>> scan -lab`, but it seems to only ever search the first virtio-blk.
>>>> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
> 
> eficonfig, apart from displaying the boot options on a menu scans all
> media that have a simple filesystem protocol installed and configures
> the efi boot options.  That's why bootefi bootmgr boots properly
> afterwards.  You can probably boot even without eficonfig, but only
> bootXXX.efi files will be accounted for and no boot options will be
> added.
> 
> The EFI spec describes the bootmgr functionality in detail.  Back when
> the bootmeth patches were added, I suggested we shouldn't deal with
> EFI at all simply because it all already works and is backed by a
> spec.  Instead, we should just have a boot option in the methods that
> spells "EFI" and let the bootmanager deal with the details. But
> honestly, I've lost track of those patches.

I think bootflow and EFI should be different views on top of a single
"what can we do now that we are in U-Boot" model. IIUIC it's possible
for e.g. UEFI Shell to be built-in boot entries, so we could expose
bootflow entries (and more) similar to those? And EFI-based secondary
bootloaders like rEFInd could let us choose them in a graphical menu,
efibootmgr could change their order or reboot into a non-EFI flow...
