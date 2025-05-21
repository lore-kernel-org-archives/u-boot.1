Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417A6C54EDA
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 20:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6239682ED0;
	Wed, 21 May 2025 22:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f1MfbpbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E36482E28; Wed, 21 May 2025 20:52:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A5082E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 20:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747853565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2peapZ3Y+YDJOiDzCV58FJiDHRmLVpi7Ho4Hv7z+ss=;
 b=f1MfbpbPuPmGWuw4YKLC6nU2rjN2pYer1y3OY36ufyrdGFKW9gX82vBugkL0zPBtlkIEgi
 iw1MVM24eyh7c4nm42e4My/qcxTVgonx04cDHEh89I8zzSZv+M9HmhRx0JmrTg3KMsMQ3Y
 MqngLHvTZoKqnoUn/eBZhCphhg6T7yo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-tGyTnOzmM1i68in_uwc1aw-1; Wed, 21 May 2025 14:52:44 -0400
X-MC-Unique: tGyTnOzmM1i68in_uwc1aw-1
X-Mimecast-MFC-AGG-ID: tGyTnOzmM1i68in_uwc1aw_1747853563
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so56506885e9.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747853563; x=1748458363;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2peapZ3Y+YDJOiDzCV58FJiDHRmLVpi7Ho4Hv7z+ss=;
 b=Vlj5/b3lz+sM7JOuOPokwp7Uxp1m1O+M1bRB9QDBKCQQLL+BMwWiXOhh7qzaV5Hkz0
 2dnVNzwJR8RJr0xqNnXYPtUPOAzr/ZdaYA57KOzqKE/M/9lu76/kHToXk96klHROM6uo
 7VPne+qrWSvRg6aGhuZ87G2h78tywJroMfjQfTgGDO7epafsrMs6jwVKsc6fNVEOeG5H
 YZiJvG27eSch640eiq2KEJNjmEsJV2UUNVkLIQeR3qv39mBACeqWVzqwAI6dy4r4kuJY
 2ct8ZkA7VTuKVNNBgrtOYxoXRl4YnAXE8HghibKcOLxybrsl99TgwJse/R1aLCNi76Yr
 LnpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX331yCm+Dv0J4BNS+xCMuEfCs7F6+Ua1A/f9Lw+acZ7l+XBZIZuXMNtVi8zgMvd3JyEAlFdT0=@lists.denx.de
X-Gm-Message-State: AOJu0YwuDlijeBF2BuHH/XDhMrbzGLf+ooiMfdcwOfPoM/hNZuvwfw11
 vzhtGTA14RH5VKpyL1n7aTbI5CBd7aeYQaUw/qzNTTTEQo2XRp971572v0fvW9Bg8ircvftQR0e
 O5Dg0h1uDwBTKx4C/kgHqCQeC9Lc3kfJVv0IrO1PJn4G+W7oHv4B2ZKU=
X-Gm-Gg: ASbGnctInlLfKIYM712HTe3sdra5lnjAm7WxcoUqE5KQS5doSvN3ovjMvLxA9BQJV0r
 tvspUZbXxbKi4/TBBDhMAKh/6OwPYnld5oDwzf2QKiY1LO51rQvxd+Rjhnzk/bsWCSqfzd7xv1h
 GKH+gKj5T+ypF3VJau3H3dFa3M2lOdLxNQzYAziajE+tW6QBPxTJmUbByXq56d2eBNtSYvAgbxa
 kSva0d4If9DPUP6iBlA9y/LyFBbZD5oTchDQZ0G1XkZCyQDQTBAmXJp3+JFQeHBXcO8XHRbdF4i
 T3EC36sHwlbhmciQrPA=
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-442fd6649bdmr199341305e9.24.1747853563138; 
 Wed, 21 May 2025 11:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJCsierm63CmRLWGGzpH7mASGqMC8Rx/ce169hCUrtDa1O6Jz27lmsiVIZ99Twpep00mzIVQ==
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-442fd6649bdmr199341145e9.24.1747853562755; 
 Wed, 21 May 2025 11:52:42 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca6265fsm20359724f8f.43.2025.05.21.11.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 11:52:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@redhat.com>
To: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: neil.armstrong@linaro.org, u-boot@lists.denx.de, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <20250521151236.GC100073@bill-the-cat>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org> <20250521151236.GC100073@bill-the-cat>
Date: Wed, 21 May 2025 20:52:41 +0200
Message-ID: <87wma9okxy.fsf@kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EoWnnT__gHfJ-A8vSIBy7LN9jbfHGQea6KsBcJVy-Ws_1747853563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 21 May 2025 22:12:24 +0200
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

Hi Tom,

On mer., mai 21, 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wrote:
>> Hi Neil,
>> 
>> On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>> 
>> > Hi,
>> >
>> > On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
>> >> This serie permits using any block device as target
>> >> for fastboot by moving the generic block logic into
>> >> a common set of helpers and also use them as generic
>> >> backend.
>> >> 
>> >> The erase logic has been extended to support software
>> >> erase since only 2 block drivers exposes the erase
>> >> operation.
>> >> 
>> >> [...]
>> >
>> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>> >
>> > [1/3] fastboot: blk: introduce fastboot block flashing support
>> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
>> > [2/3] fastboot: blk: switch emmc to use the block helpers
>> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
>> > [3/3] fastboot: integrate block flashing back-end
>> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885bd8c969e25d03bf406207d89b1145c9490fb
>> 
>> It seems this series cause CI to fail:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238
>> 
>> Without the patches applied, it passes:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235
>> 
>> Do you have any idea what is going wrong?
>> I could not find anything obvious by skimming through the logs.
>
> It's a Kconfig problem then. Some platform is prompting for a value (not
> a y/n) and there's no default.

You are correct. Thank you for the suggestion.

I've applied the following diff to 3/3:
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 68967abb751e..fdf34a6abe1e 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -200,6 +200,7 @@ config FASTBOOT_MMC_USER_NAME
 config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
        string "Define FASTBOOT block interface name"
        depends on FASTBOOT_FLASH_BLOCK
+       default "none"
        help
          The fastboot "flash" and "erase" commands support operations
          on any Block device, this should specify the block device name
@@ -212,6 +213,7 @@ config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
 config FASTBOOT_FLASH_BLOCK_DEVICE_ID
        int "Define FASTBOOT block device identifier"
        depends on FASTBOOT_FLASH_BLOCK
+       default 0
        help
          The fastboot "flash" and "erase" commands support operations
          on any Block device, this should specify the block device

See:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/e9e185a349fc1dd5066c9b79758b0434e3385003

And it builds successfully:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26268

Neil, can you look if the above diff is good for you?
If so, I can squash this in.

If you prefer, you can resend a v4 with the fix included and I can
re-merge that instead.

Let me know what works for you.

>
> -- 
> Tom

