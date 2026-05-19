Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109DCD4F5E
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F973847D9;
	Tue, 19 May 2026 22:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZkV8jpta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97A984713; Tue, 19 May 2026 22:00:31 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A918483C
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso9065619a12.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220829; cv=none;
 d=google.com; s=arc-20240605;
 b=LHiuUsdm0Maq0OIkAaFswIXFqhTuGnqkGdbiO+R3b57hbf3Ak1CxHPY/dG9ggQsWv2
 m7PA133xet7U/6GDSVGaOaz/xUvROQi4BydYWGz4wDBwRlvcQt4DgOfCFrBrJQGWFIgz
 uMoiMFDG6/aoie+X/z7082vcNwIOaHvPn075GdASjAN1jiR8mBB5eajE79Dpc5IZ3pXN
 naQA6+uMDXZw2G5o6snyqeWtxxA5omoza45LDTuf11lkwOkWksrMLpE3XgErjnP8jjNJ
 5vjughdVHxK5uLSjZSczhWP66w3h1sqXT6QLo+GoaGrMTjeF+aqyINq8oTyRHcxOet5b
 GbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
 fh=v6sT2ZXdowu7RQDQZev5RJ9L+XzIwuWMbmwqM6bFjDs=;
 b=VPCeqr+kStKBz/ronEVX084L7S1c4/zrM+CJyc+c7GapkkuhVuk+xUc/LVUKFT7taI
 D7IPoR3bwaV0uXvKCiPkL6uLUJkm22NLMnPyB1NdHz2CpbwTR6AH/ctpAwFw1drN1opt
 Q/UFvY7nypxY4ECcc/z/48UBsDuVSWBPb13tk2v48YWSpB1c4Z2ggwU7wJ9eZOwkB2mu
 2WAhkukStePX5fRKtdu3BGijs2mJke3Zn2VCYBUM4qbswdDFt+QOAlGZwhe0YQvr8G6Y
 XCINeWLKKX4VQm1S9WmBp/8OLYFooTHsn4JfrkWB5vTczfOkq8vUrBZAqKwwtvRfnImE
 Hzzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220829; x=1779825629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
 b=ZkV8jptaARDYAEAzAAkwwktvMYjmprzb+EP0xPx64Yf9mrCfCIw/tBqdguuAmLOll/
 5aPG5DQNJ85codIWySle2XqiZsIGB4PoyIxQIDVEyh7VM7xdZ2Uqv8lhd5V/UuWyuD4W
 8Q5DHLd/zzm6yLBk/aQQVqGtEseoKI4T2LcKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220829; x=1779825629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
 b=cb6pxuXEHLxOU87M5RAAkxxLSWso6FGGhF08qRgLi47VeUpBy1WjXK6EqAiXbVgb3z
 B3FBrCpqjuR5KNlas/osmUpYFveTF99C5GZ5mhqEJkPJYZWR599KCD+olU0d6G7q0JoN
 mOVU8FOn+HP8f03tp3yGuXRMP+HahXY6GQ+MK1ssNrmU3kzLAMCnHGcASvfC12D3Aqt/
 y+Vxkr2U69nBJROmP8ES+EgRN/xNqQJrqbo16Ig564WMG0EEUVHbzH6SZ3AAsm9Jml8A
 94TasvU77rB+KwAeBKo7kePZr50tocWgzYRbXVxw9Kgj6Dnnc2OAkgU/gL182X97y9n2
 rjJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DLj7mFhroUGakB1CRcywWzOCuWh02E9EKYo4oRQJ8o8KOU4SQBkGsDdpHvGfcs9YT6weTX2A=@lists.denx.de
X-Gm-Message-State: AOJu0YwlWWMorKbEwx53leP/we+Gt6EedELG1I7h0FTW/vyQHiWtB2pa
 qN4G6Vnn6Y59+VNLEgjdBSh3hbxNZUeYrN4RyPvs3/hRxyYrK/w/yo5JJjTnj/JXIPbFaGV4JbL
 8LeZne5u5FVn4kEfa7la7KSe7sDqlCnqs+vfaciVN
X-Gm-Gg: Acq92OFOgKGuj8j9da2qO/09KHUW33jzjYo0Ofi0CmXZoKvJ/ypCoEhaZ8coPblFRrw
 hm3iQyk+C/uZsL0LDOOjee33V2q6V3da9VbnhNUwapXORoMwiq1RoikIm3t+qclzPiqGs4jImyB
 82Qre2/ne+tKNF7rT+hnwmBxwwihxOcfECQ7u8D0ow+O800g1sefRZ6W/UEini3eNw6nDgOxL0S
 plQfN/eyt07mVAEJEE5AY3HSuBt9DWGfBHRFOAxUYcXv8OekYiC0bkfSKcP3ayHBwvkI12zDy9g
 rpnxbQ==
X-Received: by 2002:a17:907:a68b:b0:bda:2928:ff9a with SMTP id
 a640c23a62f3a-bda292920a3mr112394966b.39.1779220829325; Tue, 19 May 2026
 13:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:19 -0600
X-Gm-Features: AVHnY4IFIErVj3TEvq9UnA9JoyMbut4QP3G3ELTItm1k0rkzoCJf1CyfZqZ0EPM
Message-ID: <CAFLszTj2R-oT5jykouzGPcBfvJ+_Qp1YPqEbonk16uqAy9DDxg@mail.gmail.com>
Subject: Re: [PATCH 5/9] fs: ext4: set inode timestamps on write
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: set inode timestamps on write
>
> Replace the hardcoded zero timestamp in ext4fs_write() with the actual
> current time obtained from the RTC when CONFIG_DM_RTC is enabled.
>
> Per the ext2/3/4 specification (ext2 design document, section 4.2):
>   i_mtime  last data modification time
>   i_ctime  last inode change time (the 'c' stands for 'change', not
>            'create'; this is not a creation timestamp)
>   i_atime  last access time
>
> All three fields are set to the same value since writing data modifies
> both the file content (mtime) and the inode metadata (ctime), and any
> write also constitutes an access (atime).  If no RTC is available, the
> timestamp falls back to 2000-01-01 00:00:00 UTC, matching the FAT
> write driver behaviour.
>
> The ext4 i_crtime field (true file creation time, added in ext4) is
> stored in the extra inode area beyond the base 128-byte inode and is
> not modelled by struct ext2_inode, so it cannot be set here.
> [...]
>
> fs/ext4/ext4_write.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -21,14 +21,47 @@
> +/**
> + * define EXT4_TIMESTAMP_Y2K - 2000-01-01 00:00:00 UTC as a POSIX timestamp
> + *
> + * Used as a fallback timestamp when no RTC is available.
> + */
> +#define EXT4_TIMESTAMP_Y2K   946684800

'define' is not a valid kernel-doc directive, is it? I suggest a plain
C comment.

Also, the natural sentinel for an unknown ext4 time is 0 (Unix epoch),
which the read path already displays as 1970-01-01; picking Y2K means
files written by U-Boot show 2000 while pre-existing zero-stamped
inodes show 1970, which is jarring. The FAT-parity argument is pretty
weak since FAT cannot represent dates before 1980.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -21,14 +21,47 @@
> +static time_t ext4_current_timestamp(void)
> +{
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct udevice *dev;
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (!dev)
> +                     goto fallback;
> +             if (dm_rtc_get(dev, &tm))
> +                     goto fallback;
> +             return rtc_mktime(&tm);
> +     }
> +fallback:
> +     return EXT4_TIMESTAMP_Y2K;
> +}

The label sitting outside the if-block and jumped to from inside reads
oddly. Please drop the gotos:

   if (CONFIG_IS_ENABLED(DM_RTC)) {
           struct udevice *dev;
           struct rtc_time tm;

           uclass_first_device(UCLASS_RTC, &dev);
           if (dev && !dm_rtc_get(dev, &tm))
                   return rtc_mktime(&tm);
   }
   return EXT4_TIMESTAMP_Y2K;

Also, this helper sits at the top of a 1000-line file but is only used
at the bottom from ext4fs_write() - please move it nearer to its
caller.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -979,7 +1012,11 @@ int ext4fs_write(const char *fname, const char *buffer,
>       }
>       if (existing_file_inode)
>               free(existing_file_inode);
> -     /* ToDo: Update correct time */
> +     /*
> +      * Note: ext4 i_crtime (true creation time) lives in the extended
> +      * inode area beyond the base 128-byte inode and is not modelled
> +      * by struct ext2_inode, so it cannot be set here.
> +      */
>       file_inode->mtime = cpu_to_le32(timestamp);

The comment describes a field this code does not touch, which is more
confusing than helpful. The i_mtime_extra/i_atime_extra/i_ctime_extra
fields (nanoseconds and the high bits past 2038) have the same
limitation and arguably matter more, since we are truncating the
timestamp to 32 bits via cpu_to_le32(). Drop the comment, or expand it
to mention all the unmodelled time fields.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -854,7 +887,7 @@ int ext4fs_write(const char *fname, const char *buffer,
> -     time_t timestamp = 0;
> +     time_t timestamp = ext4_current_timestamp();

Note the parent directory's mtime/ctime should also change when a file
is created or replaced, but g_parent_inode is written back unchanged a
few lines further down. Not related to this patch, but worth a
follow-up.

Regards,
Simon
