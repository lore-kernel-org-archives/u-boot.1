Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6441DCFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 10:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4E183BF1;
	Mon, 24 Nov 2025 11:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eVPcFplZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AD183D3C; Mon, 24 Nov 2025 11:14:16 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DA483BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 11:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47755de027eso21426105e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763979253; x=1764584053;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmhqYR00nnfomzxtIftCfmPWSJQHgx6a6oqUAM4CrZ0=;
 b=eVPcFplZ+E0jwjuGOeO6JVjXwEILnCu4H1/QOZ+CTduM9HT1vZO/SBZW4+uRXkR+H/
 DCXtmkhvwq/35aQzmLbWqltWfeXQ7MM37nfSFfSj6IWKW/1yq54yoaP9QH0b8h59cVfw
 OTajKO0Sm4D/ARwi4gSsy0wVQtLHGb9YB223tZ2ByJ4HsRzLRCpJcXgMokvqR7+BK/h5
 VMRwK8BXNj7dUGMbaPejUyduArrS/e7R+OpYJvc2GE0ABV1/WRVbHsV8QfWhZjvL0jDp
 PYABZprrZQDLphjFa49dUFWSkZRyyqXc4qd8E4ZeyLCAHPpYhBjucvjye2jMjrywDDk5
 Y0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763979253; x=1764584053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmhqYR00nnfomzxtIftCfmPWSJQHgx6a6oqUAM4CrZ0=;
 b=Q2KmOOgJac0w4J2icQAVfJj8peNOdfjqTlinsdo2zGDJUB8+yVN4dqbLvf9xCFl3g3
 2M6QVZq85mj+VqpxalqmGXw4+dc4EiA8p28/18Hv/MIYB9MboZLuspm0bAHQAxoSSWm4
 0y3lmVGfKH5vmJ/y7J+pUiR6jErZgw7pwT2K15Qc9cdOD6W93LKH0gR/GH/Ip0QYpTos
 YUe88AcxbeKMCyUpB0RNFoIP9mKoYX7ts2mXre8/UWDCfbwaKc2SrdQNoN09Mkt2Bt7q
 ymgcm7C6Nrql2R2meQBg8E4oXRFPkbzv0un58tEopH+3aCPCmBRy/ltr6FGH+Tf6NIv8
 YB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXjn3t/MymdnPo4RlsSu+I8efjZU/T2ViPp7vHPTbovGjvcWBuykUrze6C5w3DGZe6kRbl9/0=@lists.denx.de
X-Gm-Message-State: AOJu0YwfcHOd88I8FQAMHdJGHAV19J7fLdNaJ1VYwpCJwbtHnS+QHOo8
 ORXZg+GiGploTmLR9+U8eSAIQfOHpoWOlEo0av7nLbRORDOsAE9MkucLA2l0JXybRvY=
X-Gm-Gg: ASbGncvNxFXG0ZgUsXMDfcCgZnO55NKRIkaojLq8JFtw+pixgDXv7aBEc1mOrIXvmsE
 yw0xvYNrEVdjRAkvJJrvI7M5Yg45qav3EVAhPkrv6BWZtafJrx5HtZVllVl7FDy+mj9EHBVlZXD
 P0aZMtb1ALiAAnx8Ysjbh9JdtaolyDZ6Htom+MOqTpt0c2154kBEbvH/NsiCHdmj2krDGqTNm9X
 aQ6JnnwoN68TGrDef6YCqpnYlZPZch2YtyinQiYqeJULkj1XLl+hJXOC+lIN2k6Ks3Wgka0bdPD
 iOR12t0cdlwaIAjzpKZQE7M5vP4x4gNvwyNazC5Zkf0pDQE14QmJgNIKLEndyYWxh6nCuZ4FsQh
 62X6NXLKqMgnKT7CDnwm5dYVGJh51A8OLXHQtcRp2u1jfp6MS8c/cYLo8gx2JzYfxdbFObvc9wJ
 yfDeSoyt92eHDUsI3eUJ7QNoTVvOboZdRHtlWuaW62sIq4uUDMPG3Yr8Z7iA==
X-Google-Smtp-Source: AGHT+IHEr8dDamzQeNduV38Qcg9/b9IEV6ABrmifK42FcSubffdw67PGKTdCLjs6r9XrW+B1b7ruWA==
X-Received: by 2002:a05:600c:3110:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-477c01f67d5mr115466765e9.32.1763979253362; 
 Mon, 24 Nov 2025 02:14:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:d26c:ecfc:3035:7758?
 ([2a01:e0a:e50:3860:d26c:ecfc:3035:7758])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e0c802sm143248755e9.15.2025.11.24.02.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 02:14:12 -0800 (PST)
Message-ID: <229234c9-1857-45c7-8f60-50a055f45286@baylibre.com>
Date: Mon, 24 Nov 2025 11:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] boot: android: Add bootconfig support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
 <20251114-bootconfig-v3-3-a28b813dba90@baylibre.com>
 <CAFLszTjw+pc8pK42fOpyyxwQ1K0MPjBaWEnv-UBGO36zFBCx7A@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAFLszTjw+pc8pK42fOpyyxwQ1K0MPjBaWEnv-UBGO36zFBCx7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Simon,

thanks for review.

Le 19/11/2025 à 14:17, Simon Glass a écrit :
> Hi Guillaume,
>
> On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
> <glaroque@baylibre.com> wrote:
>> For android vendor boot image version 4 bootconfig is mandatory.[1]
>>
>> In the android_image_get_ramdisk function, after copying both vendor and
>> boot ramdisks, we extract all androidboot.* entries from the kernel
>> command line. These entries are added to the bootconfig section.
>> We then update the sizes of the ramdisk and bootconfig.
>> Finally, all androidboot.* entries are removed from the kernel command
>> line.
>>
>> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#bootloader-support
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   boot/image-android.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 109 insertions(+), 11 deletions(-)
>>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> index 613f2aa4b9e..94c2879dcd6 100644
>> --- a/boot/image-android.c
>> +++ b/boot/image-android.c
>> @@ -503,6 +503,112 @@ ulong android_image_get_kcomp(const void *hdr,
>>                  return image_decomp_type(p, sizeof(u32));
>>   }
>>
>> +static u32 android_image_set_bootconfig(const void *hdr,
>> +                                       const void *vendor_boot_img,
>> +                                       ulong ramdisk_ptr)
> This could use a comment.
>
> Also, ramdisk_ptr is a strange name for an address as it sounds like
> it is a pointer. Perhaps use ramdisk_addr ?
i will do
>
>> +{
>> +       /* Extract androidboot.* parameters from bootargs */
>> +       const char *bootargs = env_get("bootargs");
>> +       char *androidboot_params = NULL;
>> +       char *new_bootargs = NULL;
>> +       size_t androidboot_params_len = 0;
> As a general comment, some of the args are quite long and this makes
> the code harder to read. For example this could be params_len, since
> we know this is Android Boot.
agree with you
>
>> +       struct andr_image_data img_data;
>> +       u32 bytes_added = 0;
>> +
>> +       if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
>> +               return 0;
>> +
>> +       if (bootargs && img_data.bootconfig_size) {
>> +               size_t len = strlen(bootargs);
>> +
>> +               androidboot_params = malloc(len + 1);
>> +               new_bootargs = malloc(len + 1);
>> +               if (!androidboot_params || !new_bootargs) {
>> +                       free(androidboot_params);
>> +                       free(new_bootargs);
>> +                       printf("Error: malloc failed\n");
>> +                       return -ENOMEM;
>> +               }
>> +
>> +               /* Extract androidboot.* and build new bootargs in one pass */
>> +               const char *src = bootargs;
>> +               char *bc_dst = androidboot_params;
>> +               char *args_dst = new_bootargs;
>> +
>> +               while (*src) {
>> +                       /* Skip leading spaces */
>> +                       while (*src == ' ')
>> +                               src++;
>> +                       if (!*src)
>> +                               break;
>> +
>> +                       /* Check if this param starts with androidboot. */
>> +                       if (strncmp(src, "androidboot.", 12) == 0) {
>> +                               /* Copy to bootconfig (add newline if not first) */
>> +                               if (bc_dst != androidboot_params)
>> +                                       *bc_dst++ = '\n';
>> +                               while (*src && *src != ' ')
>> +                                       *bc_dst++ = *src++;
>> +                       } else {
>> +                               /* Copy to new bootargs (add space if not first) */
>> +                               if (args_dst != new_bootargs)
>> +                                       *args_dst++ = ' ';
>> +                               while (*src && *src != ' ')
>> +                                       *args_dst++ = *src++;
>> +                       }
>> +               }
>> +
>> +               *bc_dst++ = '\n'; /* Final newline for bootconfig */
>> +               *bc_dst = '\0';
>> +               *args_dst = '\0';
>> +               androidboot_params_len = bc_dst - androidboot_params;
>> +
>> +               /* Update bootargs if we extracted any androidboot params */
>> +               if (androidboot_params_len > 1)
>> +                       env_set("bootargs", new_bootargs);
>> +       }
>> +
>> +       /* Map addresses for memcpy operations */
>> +       void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
>> +       void *vendor_ramdisk_src =
>> +               map_sysmem(img_data.vendor_ramdisk_ptr, img_data.vendor_ramdisk_size);
>> +       void *boot_ramdisk_src =
>> +               map_sysmem(img_data.ramdisk_ptr, img_data.boot_ramdisk_size);
> We tend to declare things at the top of the function. You could split
> the function if you like.
i will create a sub function for copying data.
>
>> +
>> +       memcpy(ramdisk_dest, vendor_ramdisk_src, img_data.vendor_ramdisk_size);
>> +       memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size, boot_ramdisk_src,
>> +              img_data.boot_ramdisk_size);
>> +
>> +       if (img_data.bootconfig_size) {
>> +               void *bootconfig_src =
>> +                       map_sysmem(img_data.bootconfig_addr, img_data.bootconfig_size);
>> +               memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
>> +                       img_data.boot_ramdisk_size,
>> +               bootconfig_src, img_data.bootconfig_size);
>> +               unmap_sysmem(bootconfig_src);
>> +
>> +               /* Add androidboot.* parameters to bootconfig */
>> +               if (androidboot_params && androidboot_params_len > 1) {
>> +                       ulong bootconfig_ptr = (ulong)ramdisk_dest +
>> +                                       img_data.vendor_ramdisk_size +
>> +                                       img_data.boot_ramdisk_size;
>> +                       bytes_added =
>> +                               add_bootconfig_parameters(androidboot_params,
>> +                                                         androidboot_params_len,
>> +                                                         bootconfig_ptr,
>> +                                                         img_data.bootconfig_size);
>> +               }
>> +       }
>> +
>> +       free(androidboot_params);
>> +       free(new_bootargs);
>> +
>> +       unmap_sysmem(boot_ramdisk_src);
>> +       unmap_sysmem(vendor_ramdisk_src);
>> +       unmap_sysmem(ramdisk_dest);
>> +       return bytes_added;
>> +}
>> +
>>   int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>                                ulong *rd_data, ulong *rd_len)
>>   {
>> @@ -534,17 +640,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>                          ramdisk_ptr = img_data.ramdisk_addr;
>>                  }
>>                  *rd_data = ramdisk_ptr;
>> -               memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>> -                      img_data.vendor_ramdisk_size);
>> -               ramdisk_ptr += img_data.vendor_ramdisk_size;
>> -               memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
>> -                      img_data.boot_ramdisk_size);
>> -               ramdisk_ptr += img_data.boot_ramdisk_size;
>> -               if (img_data.bootconfig_size) {
>> -                       memcpy((void *)
>> -                              (ramdisk_ptr), (void *)img_data.bootconfig_addr,
>> -                              img_data.bootconfig_size);
>> -               }
>> +               if (img_data.header_version > 3)
>> +                       img_data.ramdisk_size +=
>> +                               android_image_set_bootconfig(hdr, vendor_boot_img, ramdisk_ptr);
>>          } else {
>>                  /* Ramdisk can be used in-place, use current ptr */
>>                  if (img_data.ramdisk_addr == 0 ||
>>
>> --
>> 2.34.1
>>
> Regards,
> Simon


