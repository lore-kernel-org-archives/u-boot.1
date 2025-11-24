Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5847CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 10:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3C783BF1;
	Mon, 24 Nov 2025 11:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GyOF9rZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E538183D5D; Mon, 24 Nov 2025 11:17:16 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD27283BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 11:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so23641195e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763979434; x=1764584234;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAMFaPUEuc1uXP0C6nS8YyrEYSj1c4rlc/PqNOrzc7w=;
 b=GyOF9rZkHs0piXWxU7oys3JY6DsCwk4T2e7Ze+UKlscIp87o1ET7w25+pHQDGDOUg8
 v9Xc+f5z1fGO9oGHju8LK5U97FSs+cG+lvWLyVmMgev1oLB8qLECOaGjBsBc1J/gYa4l
 OmzzC4yxzof+h6zbwVi0w/1kdnqKQV+SatffgCitXuib6NcOGmZV36L6L9Njhq4iMkIx
 wB6SdWFcpB3LFAUQW5hGG/ifSmuUM2bFTdV385nZ5+KDi5Iu8Lf9SGLd7Ol2PJRuXd4l
 WeBuEGh3cYE4ao6pw+xdTB35cfapIdACq4EvVLUV3WnNEF1Q1Jv/NHtdKP+6E4c5F69v
 Bb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763979434; x=1764584234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAMFaPUEuc1uXP0C6nS8YyrEYSj1c4rlc/PqNOrzc7w=;
 b=Izi1WoYuew8Ygomtlcnq1Yj/+h1xq+od3P/kbCaJv/gIKpnEkr3uw3qwN6RoU+7yqz
 NqO5t2+WUyGzOrecIjNaXaYyY8gR2mnmB9WI4OuLN3hiZXaiOn1jvFX36WTpuQiBLo2g
 das8GN1D7PnfKPVTMYhx0GNQ7RCkPnVk0f6cbJLiuN4wmmWNPx3beW1zqNIF+U3Yyvj7
 DfNVMU5mdmw1AuNb5o7dmkbGcuLi3iQP1ixBKJC3ocaAFHfImgIelCHCJNqKBLvDbZW3
 h/Qo7mCxxVFCXYeRZJoP1VabfEiq9d5TXcM29P92ZJOz8MAFNp1DC+Iq6++lj8AyxFIA
 opKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVafbCsVVdk6PYLLIz16lMCu4IJt+AbGwuXWVSHHaQJ8wfTK4gqJdk1TkYknnFhMGmHptmdflQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxYMP+NIpu9xKlKlLRUsoQL09r5xkPRz6UUkZmoWLp8AOCl05dY
 X4zvCv4yGDe4Kf0MbeTTWt4NodASS5pRLvPh/vVPqBDZJXivYN7a1gDE7nQMdd1lv2HN3gtHOjF
 O+WA7
X-Gm-Gg: ASbGnctn+KU2u8/GwdHNwC3r461XKQFuWDF8Jmbm29oE8DsEGGtUAvDIJykzuW3P9Dw
 KQVe+tWhWutYhgffAPy4I9/SUwJ/Q3Fm3RiHbMKMzthFsntXw5okXHxLqdAnfOxCmMjgO6GctbU
 cdrsnN8aMtmPvUTEVp8rNvCgQ2j68tPZsJ1rOehTXwDEybx8AK9nj/b0p9t0QRqrJIOSn0TQ3Xd
 b//won2TPZmEqQ451QhdklgdXHvM0CoWZxoFMsmwDMHLU2lXWjI3RH0njCppECH0rLGq1Hzryra
 Afi401pHoscw//iKN3G+QNSbcr0CQw9r5aUC8ur7xNi+b5NxGlCtF0LxPbZYog4uUiUknkYLrHV
 NrqPt+ZlgxbPXLxtYILhe7WyFKvsGZmYzY6D0RQtCdH/o6p0iKkzKZthuQta9+e6m0pd2d7JdfP
 3akrYCzCmUNzHXkz48FocPQB3f223NpgrxBXGP+NDWCn8lIOoLTdJKmThAHQ==
X-Google-Smtp-Source: AGHT+IHgqIAgl50A8aDYxsEP/OqGNsydMWeCPp44ppRciwn+z0t2lAyo8A7upv+KlGa0iaXgtPEEiQ==
X-Received: by 2002:a05:600c:19ca:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-477c1143073mr101575165e9.22.1763979434214; 
 Mon, 24 Nov 2025 02:17:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:d26c:ecfc:3035:7758?
 ([2a01:e0a:e50:3860:d26c:ecfc:3035:7758])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba20esm27678206f8f.37.2025.11.24.02.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 02:17:13 -0800 (PST)
Message-ID: <2de98cfb-4de0-4075-8264-eed1695812b4@baylibre.com>
Date: Mon, 24 Nov 2025 11:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] cmd: abootimg: Add 'get ramdisk' command
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
 <20251114-bootconfig-v3-4-a28b813dba90@baylibre.com>
 <CAFLszTh9OMr9mskSXZ=kN5HFz8KHa+eGxqHwRwzdOS8EkFUFsg@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAFLszTh9OMr9mskSXZ=kN5HFz8KHa+eGxqHwRwzdOS8EkFUFsg@mail.gmail.com>
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

Le 19/11/2025 à 14:17, Simon Glass a écrit :
> Hi Guillaume,
>
> On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
> <glaroque@baylibre.com> wrote:
>> Add support for retrieving ramdisk address and size from Android boot
>> images. This command allows users to extract the ramdisk information
>> for boot image v3+ which combines vendor ramdisk, boot ramdisk and
>> bootconfig sections.
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   cmd/abootimg.c | 35 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
>> index 6fb52153786..2a8e2c20941 100644
>> --- a/cmd/abootimg.c
>> +++ b/cmd/abootimg.c
>> @@ -230,6 +230,33 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
>>          return CMD_RET_SUCCESS;
>>   }
>>
>> +static int abootimg_get_ramdisk(int argc, char *const argv[])
>> +{
>> +       ulong rd_data, rd_len;
>> +
>> +       if (argc > 2)
>> +               return CMD_RET_USAGE;
>> +
>> +       /*
>> +        * Call android_image_get_ramdisk with UNMAPPED addresses
>> +        * The function will do its own mapping internally as needed
>> +        */
>> +       if (android_image_get_ramdisk((void *)abootimg_addr(),
>> +                                     (void *)get_avendor_bootimg_addr(),
> Casting an address to a pointer seems strange. Probably at some point
> the API should be updated to have an address.
>
> You can use nomap_sysmem() but that is more for things like ACPI
> tables which embed addresses, so in this case I think an address would
> be better.

i will do it in other patch after this series if it's ok for you


>
>> +                                     &rd_data, &rd_len))
>> +               return CMD_RET_FAILURE;
>> +
>> +       if (argc == 0) {
>> +               printf("%lx\n", rd_data);
>> +       } else {
>> +               env_set_hex(argv[0], rd_data);
>> +               if (argc == 2)
>> +                       env_set_hex(argv[1], rd_len);
>> +       }
>> +
>> +       return CMD_RET_SUCCESS;
>> +}
>> +
>>   static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
>>                             char *const argv[])
>>   {
>> @@ -249,6 +276,8 @@ static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
>>                  return abootimg_get_dtb_load_addr(argc, argv);
>>          else if (!strcmp(param, "dtb"))
>>                  return abootimg_get_dtb(argc, argv);
>> +       else if (!strcmp(param, "ramdisk"))
>> +               return abootimg_get_ramdisk(argc, argv);
>>
>>          return CMD_RET_USAGE;
>>   }
>> @@ -315,5 +344,9 @@ U_BOOT_CMD(
>>          "    - get address and size (hex) of DT blob in the image by index\n"
>>          "      <num>: index number of desired DT blob in DTB area\n"
>>          "      [addr_var]: variable name to contain DT blob address\n"
>> -       "      [size_var]: variable name to contain DT blob size"
>> +       "      [size_var]: variable name to contain DT blob size\n"
>> +       "abootimg get ramdisk [addr_var [size_var]]\n"
>> +       "    - get address and size (hex) of ramdisk in the image\n"
>> +       "      [addr_var]: variable name to contain ramdisk address\n"
>> +       "      [size_var]: variable name to contain ramdisk size"
>>   );
>>
>> --
>> 2.34.1
>>
> Regards,
> Simon

Regards,

Guillaume

