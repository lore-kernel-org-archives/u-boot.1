Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B53C83F15
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16687864D8;
	Mon, 28 Aug 2023 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/OSQbQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5494864D8; Mon, 28 Aug 2023 17:22:37 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AF9864BA
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso31774235e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693236154; x=1693840954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LtD2sD6JpNsZhFkULZhUQo3DIrlonVPAq5puOjerfa8=;
 b=X/OSQbQcC58gx2NL4FxuUZV2e/WWgeVNAz1pvFfWdQnI0IkKx5gfGiWlPNSqgc8cDT
 hNOOJNH2r0M+Y2P0hhzYgsm6PVUeJrjbz42+jgfC6Hk4/XVHxzpo2f/39i050aTw2PBp
 OqWBOwQ+HqYPzdMaWpoNhUGsNbTri8mhygqr/kz2zqEfo32LgZWyNlSiG/b9hG0XVbiV
 bfdLBF+uKS/RWUzgY/3nhs4hIBYsz8Q4umyBD5RKqRmIhP9qveNsWxBxHU+3cRbu2FGB
 7QsM5+ThpQ0x6aq89Gx6FJlB3eWSwYVhCRhkzU/hL5xfQRkLUF5FfN5CLSoOVZmE6VDx
 mccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236154; x=1693840954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LtD2sD6JpNsZhFkULZhUQo3DIrlonVPAq5puOjerfa8=;
 b=gZGmxisw4HvEVnf2Xz6XchH5MeyslFgjBHgKlYE3FXCVQOcVbYSeMKhSi4AIiKcW1m
 b2DWWZT1M6gwcROmElVmbrO3u+0nq/RW4lJh6sHIcHdpSvoMllOQuhIKjdGKnf3LvYbm
 esWSWDCTAiAGA0u4YlyLKIZLVrFhRHQKJwkVcd+XkmikMGwLxhy8LM2ZbI1G89MTGcZD
 IrNx/cuko3gzJBlaEDzdALTahdnx+nJ010OgQ5puNntG5mE1PYvkvDaIBcEK9V1Akpzd
 lCZIjY3+FOrzDttOthe5TFH8KmSPMp2YdD0CVAV9sMYW1GElZdN64Ori6uS4fWMFxd30
 Pcnw==
X-Gm-Message-State: AOJu0YxyFRmJH+t/E5cpygnEgNqDZGhPuu21L/EKcvs/TCiPKy1zlfhT
 rg/7MsZinKKGkkQsyl4p8WA=
X-Google-Smtp-Source: AGHT+IH6cJh7Z06Oxm7/EUD4UWX0jQSIfyvMqNtAcVXW8q37YbmNBRNcLUA5dWEAv5xGInsyrwhY4w==
X-Received: by 2002:a05:600c:2181:b0:3fe:228a:e782 with SMTP id
 e1-20020a05600c218100b003fe228ae782mr20112900wme.37.1693236154381; 
 Mon, 28 Aug 2023 08:22:34 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a1c6a0a000000b003fe407ca05bsm14164356wmc.37.2023.08.28.08.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 08:22:33 -0700 (PDT)
Message-ID: <347da6dc-7adb-48cc-afb7-a47ca621bb06@gmail.com>
Date: Mon, 28 Aug 2023 18:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] qfw: Add flag to allow probing before relocation
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Alexander Graf <agraf@csgraf.de>, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-5-alpernebiyasak@gmail.com>
 <CAPnjgZ0uez=Wj+_G7nrz8iknuc_Tn56TdHjSS2R_73h5-FrJvA@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ0uez=Wj+_G7nrz8iknuc_Tn56TdHjSS2R_73h5-FrJvA@mail.gmail.com>
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
>> QEMU firmware config drivers need to be probed to bind the ramfb device.
>> The ramfb driver needs to be bound before relocation to properly reserve
>> video memory for it, otherwise it cannot be probed after relocation. Add
>> the flag to probe QEMU firmware config drivers before relocation so that
>> ramfb can work as an initial vidconsole.
>>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>> Alternatively, I guess I could default VIDEO_PCI_DEFAULT_FB_SIZE to a
>> higher size with "if VIDEO_RAMFB". But it exists because "PCI drivers
>> cannot be bound before relocation unless they are mentioned in the
>> devicetree" and qfw is in the QEMU-generated devicetree unlike those, so
>> I assumed this would be the preferred way.
>>
>> Changes in v2:
>> - Add patch "qfw: Add flag to allow probing before relocation"
>>
>>  drivers/misc/qfw.c         | 1 +
>>  drivers/misc/qfw_mmio.c    | 1 +
>>  drivers/misc/qfw_pio.c     | 1 +
>>  drivers/misc/qfw_sandbox.c | 1 +
>>  4 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
>> index 4e4260982cce..265f45290011 100644
>> --- a/drivers/misc/qfw.c
>> +++ b/drivers/misc/qfw.c
>> @@ -414,6 +414,7 @@ UCLASS_DRIVER(qfw) = {
>>         .name           = "qfw",
>>         .post_bind      = qfw_post_bind,
>>         .per_device_auto        = sizeof(struct qfw_dev),
>> +       .flags = DM_FLAG_PRE_RELOC,
>>  };
> 
> Should we add this to the DT instead?

I've experimented a bit, and got something that works nice on x86
because we have the device-trees in-tree. So I can add something to
arch/x86/dts/qemu-*.dts like:

    / {
        fw-cfg {
            compatible = "qemu,fw-cfg-pio";
            bootph-some-ram;

            qfw-ramfb {
                compatible = "qemu,qfw-ramfb";
                bootph-some-ram;
            };
        };
    };

Then add the compatibles as .of_match to qfw_pio and ramfb drivers, call
dm_scan_fdt_dev(dev) in qfw_post_bind(), merge qfw_bind_ramfb() into the
ramfb driver probe, and it will work without the board_early_init_[fr]
hooks or these flags. That all seems to be fine.

The problem is other arches where QEMU generates a device-tree at
runtime and passes it to U-Boot with OF_BOARD. It has, on arm64 (and
with @10100000 instead on riscv64):

    fw-cfg@9020000 {
        dma-coherent;
        reg = <0x00 0x9020000 0x00 0x18>;
        compatible = "qemu,fw-cfg-mmio";
    };

As a proof of concept, I used `qemu-system-* -M dumpdtb=file.dtb` and
`dtc -I dtb -O dts` to replace the empty qemu dts files, then set
OF_BOARD=n and OF_OMIT_DTB=n, and added similar modifications to
qemu-*-u-boot.dtsi. And everything seems fine like that as well.

I think it can be automated in Makefile, but I don't think disabling
OF_BOARD is right here. I see there's OF_BOARD_FIXUP, so I guess I'll
try finding the fw-cfg node there and adding the bootph props and ramfb
nodes... Is this going the right way?

(And the pio/ramfb compatibles don't exist, do we have to use u-boot,*?)

> In the case where it isn't present it can return -EPERM.
> 
> Regards,
> Simon
