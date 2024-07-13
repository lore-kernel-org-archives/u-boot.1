Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2503C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBE8888B3;
	Sat, 13 Jul 2024 17:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9seOslQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB2B888AB; Sat, 13 Jul 2024 17:14:25 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8A987E13
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-78006198aeeso1845295a12.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883662; x=1721488462; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5pV4G9e3zkwuKQv9CCTUTj0XHSLiJbex+QCqCPL81LY=;
 b=T9seOslQgIySsla0WzWaCZEv0hh+Lk/8TjfQSlsXUI4tVncwzk/Yi1ukWOXk1MJB7d
 1qeNKK/fyx2f7G8fOg/Eu14d2WeJV8gA74OinOrR4USBnmBaTvOoAHurznfkrA85u7aC
 w/E5UJlYy8RcldnJ4luWMIiNqF1zMEugoL/eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883662; x=1721488462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5pV4G9e3zkwuKQv9CCTUTj0XHSLiJbex+QCqCPL81LY=;
 b=u6nUHLV/uGw7SUPpKH0gz75iDwX1lCyDgJr7Lo+E+8Sc6BTjRsJdfGSR5hCwOp8pui
 cb4DtkFo+i1isy8hc5/8nt08HHDHRpOq3jx86y5sAknme/dN4sRAYPGNwNmHIUxhkw1T
 jSnb63qR7MjHtxXc5RYkrnow/CKixDF93M2GR0l7msIL4C6CSH64tBJP67kKHcv60zd9
 vW8DD1PKpZGjdNq0r9bun6a3qFaHO6zhzCkqpm561WXKePjVsfr+lXkk2l2qh/SaXZsT
 7fcGguxszGTBuOsjNq8nrcNjz/yh8rlw93iPyFA4clwptTsUflVhBHHFvuyx0dztglhx
 4Stg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnFB5byuUWYdwZmzJvSAPVZbQZ4K7kfFZwJmyMzCd0Ctzpjd8LpCVnuTYb8eSFZb5zukiJS2L/fSaHsZSyAVPJeVmM2g==
X-Gm-Message-State: AOJu0Yxjp0SmpCLmF+zJcuxYO6L0TQxX8SRwy6q1X94s5m3Izen3eW03
 qJ+5y58Y7/XL1/n34Z5Vsr7zpebJWiiPwWezVWPiYBOApkkYqWZUjeTNVY8q4nrSe2hodEXBKRh
 8FxDgWdLf49r3bgt6CYNMbxsnMPx52OLBHajY
X-Google-Smtp-Source: AGHT+IHX6xmZzs/cIk4c04SZMtTjF1+ZNhZJOudWqIA+n+5KGVY7WyAvJMlASCWGPAcqjPGEF0J7IWs2Kf7IuFhh364=
X-Received: by 2002:a17:90a:de8f:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2caeea56f4emr2538764a91.9.1720883661645; Sat, 13 Jul 2024
 08:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240710135320.2697805-1-yeoreum.yun@arm.com>
 <CAEfUkUJ0XVAQZ0pqQeOVEcHH_QZg+Dk5B0aMOVK6p+U4noU1pA@mail.gmail.com>
In-Reply-To: <CAEfUkUJ0XVAQZ0pqQeOVEcHH_QZg+Dk5B0aMOVK6p+U4noU1pA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:49 +0100
Message-ID: <CAFLszThm7SBv7puZbAJWj9_yokOZ5N7cQMbku45uJ0FSVck6kA@mail.gmail.com>
Subject: Re: [PATCH v4] bloblist: fix bloblist convention check.
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Levi Yun <yeoreum.yun@arm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, 
 bmeng.cn@gmail.com, nd@arm.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 10 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Levi,
>
> On Wed, 10 Jul 2024 at 09:53, Levi Yun <yeoreum.yun@arm.com> wrote:
>>
>> According to recently firmware handsoff spec [1]'s "Register usage at handoff
>> boundary", Transfer List's signature value was changed from 0x40_b10b
>> (3 bytes) to 4a0f_b10b (4 bytes).
>>
>> As updating of TL's signature, register value of x1/r1 should be:
>>
>> In aarch32's r1 value should be
>>     R1[23:0]: set to the TL signature (4a0f_b10b -> masked range value: 0f_b10b)
>>     R1[31:24]: version of the register convention ==  1
>>
>> and
>>
>> In aarch64's x1 value should be
>>     X1[31:0]: set to the TL signature (4a0f_b10b)
>>     X1[39:32]: version of the register convention ==  1
>>     X1[63:40]: MBZ
>> (See the [2] and [3]).
>>
>> This patch fix problems:
>>    1. breaking X1 value with updated specification in aarch64
>>         - change of length of signature field.
>>
>>    2. previous error value set in R1 in arm32.
>>         - length of signature should be 24, but it uses 32bit signature.
>>
>> This patch is a breaking change. It works only TF-A is updated.
>>
>> Link: https://github.com/FirmwareHandoff/firmware_handoff [1]
>> Link: https://github.com/FirmwareHandoff/firmware_handoff/issues/32 [2]
>> Link: https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1db75213e458d392b751f0707de027 [3]
>> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
>> ---
>> v4:
>>   - Remove FIXME tags on xfterlist.h
>>   - Modify commit message
>>
>> v3:
>>   - Restore arch/arm/lib/xferlist.c
>>
>> v2:
>>   - Modify commit message
>>   - Remove wrong swaping check in xferlist_from_boot_arg()
>>
>>  common/bloblist.c  | 11 ++++++++++-
>>  include/bloblist.h | 10 ++++------
>>  2 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>>
>> diff --git a/common/bloblist.c b/common/bloblist.c
>> index 11d6422b69..2008ab4d25 100644
>> --- a/common/bloblist.c
>> +++ b/common/bloblist.c
>> @@ -576,7 +576,16 @@ int bloblist_maybe_init(void)
>>
>>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
>>  {
>> -       if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
>> +       ulong version = BLOBLIST_REGCONV_VER;
>> +       ulong sigval;
>> +
>> +       sigval = (IS_ENABLED(CONFIG_64BIT)) ?
>> +                       ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
>> +                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
>> +                       ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
>> +                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
>> +
>> +       if (rzero || rsig != sigval ||
>>             rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {

I'd argue that this is unnecessary, since the point of passing fdt in
a register is to avoid having to search the bloblist for it.

>>                 gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
>>                 return -EIO;
>> diff --git a/include/bloblist.h b/include/bloblist.h
>> index 7fbdd622bc..b0706b5637 100644
>> --- a/include/bloblist.h
>> +++ b/include/bloblist.h
>> @@ -78,12 +78,10 @@ enum {
>>         BLOBLIST_VERSION        = 1,
>>         BLOBLIST_MAGIC          = 0x4a0fb10b,
>>
>> -       /*
>> -        * FIXME:
>> -        * Register convention version should be placed into a higher byte
>> -        * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
>> -        */
>> -       BLOBLIST_REGCONV_VER    = 1 << 24,
>> +       BLOBLIST_REGCONV_SHIFT_64 = 32,
>> +       BLOBLIST_REGCONV_SHIFT_32 = 24,
>> +       BLOBLIST_REGCONV_MASK = 0xff,
>> +       BLOBLIST_REGCONV_VER = 1,
>>
>>         BLOBLIST_BLOB_ALIGN_LOG2 = 3,
>>         BLOBLIST_BLOB_ALIGN      = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
>> --
>> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>>
> Feel free to add tag:
> Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
>
> Regards,
> Raymond
>

Regards,
Simon
