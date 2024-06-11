Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C0C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF5E882E8;
	Tue, 11 Jun 2024 11:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tsiZVr4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3818811A; Tue, 11 Jun 2024 11:01:57 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBEE885C7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4217d451f69so7684305e9.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718096514; x=1718701314;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=70ueJXaOTxDR8/vmZU//gFakVQWj70HqRXiimUWF9ug=;
 b=tsiZVr4+PotxQQOpb54NH2/KYH9PIn5K3UNZZTn13qNNouzi8irIfNv7cQbbJzG7nG
 vWU+71OXGSyRojm7nOVWHtDXQDqK9uZ7IUw2h1T2DOZg5GruQ/iMAN3TEI0fijILjlxw
 yrEl0yuHSbcV9s9+i8Mc4OqEa5Y4uOEQTxfsVA6GkgyH4NWcs6D+d85VFMf7+wMibJfN
 BSxluR3mHGineTGnHzjCEKUS8lErxiWapn90FMuUp5c/OOl5M/SMelHQ2vpmYol5A0L+
 jZqmD2Ja6jxFeicL2ioqlDNcLPEmac+P+cfblYz8G7bKnX8YYxy0UB9LG1FQC9x+8qg1
 7Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718096514; x=1718701314;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70ueJXaOTxDR8/vmZU//gFakVQWj70HqRXiimUWF9ug=;
 b=pC8SelXswgL8V7EdNhMVP4TnvfIKJ2KPvjjMAEFNS9hCX2JfT2mBfDS7RAp+BCvJvH
 A93j9qmik2pgspnhyqd0TwUyAWrNJh0HGBN6bR8Wi0kViS7BvzFhYklVkSZzcttu3mhP
 O73/r+loI9nTqoh9LvMxqR4kmyjcwuht9WztsPJQtQq0XGvb/Y2N3rj+8NbZQDALUJSR
 h+/8vBeGPcRrSxxhMoNkS93HoUF0tAOHupCXanqydGQXdakDetuHiM2LQQU8fHTnC/eO
 mjWJhufm0ytP6PEtlV/pREf5E6ygZo0lzt98YRrjxaeUytiN/8/aTJN06e673Y9GsTQD
 T4OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuMXAHglkHwFyIL+RMhSCPc/JQRFHGL3xgtrgGX1hnXZyA2VfKR1g81QQQPALE5szgUkvIofrHiX6yhqS9Q2BECQH/QA==
X-Gm-Message-State: AOJu0Yz264IMOf4aW0PFWJaKY9+wMITY7Kx1xXilFv2zG2h8DzKGUwyV
 DMglLAFMJI9gcahmjwOzjjQJPdF5+JVfVg187RYj5harmTncute77iQd6uY1IEU=
X-Google-Smtp-Source: AGHT+IEr6xfZeDfw24Z4JFprZh4YylD9LyPBzrzWVJfGGQhJEFueQOiRQs5CcPDoZXACkYyWnolI2w==
X-Received: by 2002:a05:600c:b88:b0:421:eecc:2404 with SMTP id
 5b1f17b1804b1-421eecc251fmr39802495e9.24.1718096513979; 
 Tue, 11 Jun 2024 02:01:53 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1efe9a74sm6466918f8f.104.2024.06.11.02.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:01:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Roman Stratiienko <r.stratiienko@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/6] boot: android: Add image_android_get_version()
In-Reply-To: <CAByghJa6gLyJHB7z3ME0JPewZ3JJizmY54XBO3MeX3TMrzB_tA@mail.gmail.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-2-0c69d4457cc5@baylibre.com>
 <CAByghJa6gLyJHB7z3ME0JPewZ3JJizmY54XBO3MeX3TMrzB_tA@mail.gmail.com>
Date: Tue, 11 Jun 2024 11:01:50 +0200
Message-ID: <87sexjzwch.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

Thank you for the review.

On lun., juin 10, 2024 at 11:20, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:

> Hi Mattijs,
>
> On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> When reading a boot image header, we may need to retrieve the header
>> version.
>>
>> Add a helper function for it.
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  boot/image-android.c | 7 ++++++-
>>  include/image.h      | 7 +++++++
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> index ddd8ffd5e540..4f8fb51585eb 100644
>> --- a/boot/image-android.c
>> +++ b/boot/image-android.c
>> @@ -185,7 +185,7 @@ bool android_image_get_data(const void *boot_hdr, co=
nst void *vendor_boot_hdr,
>>                 return false;
>>         }
>>
>> -       if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > =
2) {
>> +       if (android_image_get_version(boot_hdr) > 2) {
>>                 if (!vendor_boot_hdr) {
>>                         printf("For boot header v3+ vendor boot image ha=
s to be provided\n");
>>                         return false;
>> @@ -203,6 +203,11 @@ bool android_image_get_data(const void *boot_hdr, c=
onst void *vendor_boot_hdr,
>>         return true;
>>  }
>>
>> +u32 android_image_get_version(const void *hdr)
>> +{
>> +       return ((struct andr_boot_img_hdr_v0 *)hdr)->header_version;
>> +}
>> +
>>  static ulong android_image_get_kernel_addr(struct andr_image_data *img_=
data)
>>  {
>>         /*
>> diff --git a/include/image.h b/include/image.h
>> index acffd17e0dfd..18e5ced5ab42 100644
>> --- a/include/image.h
>> +++ b/include/image.h
>> @@ -1963,6 +1963,13 @@ bool is_android_boot_image_header(const void *hdr=
);
>>   */
>>  bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
>>
>> +/**
>> + * android_image_get_version() - Retrieve the boot.img version
>> + *
>> + * Return: Android boot image header version.
>> + */
>> +u32 android_image_get_version(const void *hdr);
>> +
>>  /**
>>   * get_abootimg_addr() - Get Android boot image address
>>   *
>>
>> --
>> 2.45.0
>>
> why introduce a helper function if there is only one user of it?

I added a second user of the helper function in patch 5/6.

>
> android_image_get_data() expects andr_boot_img_hdr_v0 anyway,
> as it has an explicit check for it in the very beginning
> (is_android_boot_image_header()).

Right.

>
> Have you considered adjusting android_image_get_data() declaration, and j=
ust use
> andr_boot_img_hdr_v0 *boot_hdr as first param instead (like it's done
> for example in
> android_boot_image_v0_v1_v2_parse_hdr()) and then rely on implicit
> cast when this
> function is used.
>
> this is of course all a matter of preference, just thinking out loud

I've given this some more thought, and since I'm already using
struct andr_boot_img_hdr_v0 in bootmeth_android/scan_boot_part(), I will
drop this patch for v2.

The helper seems indeed a bit useless given that we can use the struct's
member for this.

Thanks!

>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
