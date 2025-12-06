Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F29D3B7D3
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 10:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D4883923;
	Sat,  6 Dec 2025 11:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EhjpjlW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C2F839FA; Sat,  6 Dec 2025 11:58:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31ADE800AD
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 11:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE600403F6
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765018697;
 bh=jG2XaoNxI9dga9Mm/qr68u8aleCylhljcoMo3inOxmE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EhjpjlW6cdBDlBWAH64ii/LB+sgSjHoSyX/T2ZIht8McPAnj4nUJJyGxLRqSirF/e
 Dkj3+OMjs3F45YRd9nXchqAMTkbCjRm4+l2SGKLDqB9mGQqXhxYW6GUFpSYN8t54jJ
 p2ubn1CbLNAE89pMtPoQCoEUphQBBeMmxcXjLcZDACvjggR8DfQSwxJUMT5xTJLSjd
 22UGutQS847sVPmsRc0d1WyG8kSsrajgqkjAiEtzn2z2TgnqHRUydTo8nx7L8l8AkR
 FasucLWT3Qfn3EgjJ5i1LwJhp8qpuu/wW5yJ1qFvnw6o9QpRL3igpNH/1pYo7/NHnT
 dultmBTWcEWU6CGbLcz18isfakyzNMmZ2g9TNRZzSfjMK81uYjW989qrwUDMxfOdbv
 JTt2xUqvl3Y83Jy9oNyGn8RjCNdpFQYZxaoC8NIyP/ejL1KUYqjm2Qek7mXvjDIcNl
 4tAqKJK5K9OFaWNSG3WeQhS1QrMRigNq03GTHnFUsilDmbajJ4Hwg+OZdiWA9k3WL7
 FwFpH1DyVaH9Yo5yyUNEpMSZG5m4tALDJFH3h/ZqRTdrNSpY6JiZdEXq9Re066ourD
 6jlNHgQICtnQoHH5s4miwWVcvckumGOiTtv1BVFI+W8RTj76Kxn5CiupYjz8it68Pm
 n2+v8o5OEbOgQKOWKe7JF8BA=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso28811695e9.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 02:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765018697; x=1765623497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jG2XaoNxI9dga9Mm/qr68u8aleCylhljcoMo3inOxmE=;
 b=m1J9PPYP/qPEmK/zAKzuShFJY2X9DRtxRlYctqUTW0zhdZXPuWLW2zQfuwl4OAuIkb
 5AZLyAfW7Xjv3s2AIiwmMEwq4Sey5jfWf11/baYaOyETysNi4J9kdyYvqoaw0fqEiI6p
 7NCWVhifRQwdm2tmtBEIinm00zmdTeHvrpiqxKynHqzn4PW8vUxZo8gIf2fDFgPgkG2F
 iyTzkMBdIOzZeD1EkFLZU9PGrKV/shLYmyTY2wDopBvxqJOHh66U9NMt4pl+56i0gtGb
 l3YUDn3U8HZI0pd5ej2MnYZS9Ak7vBGi1+dbyLi4IZiu0+2CafRhmKgdeUGT1ua5VJfK
 2chQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnO8Xbs8t41+9FhCGGhrVHl/iK0G7ZYom+rV3elyW/aiVw+3/eJ3bKlfU9DHt44Q3kzxLi/vk=@lists.denx.de
X-Gm-Message-State: AOJu0YznbKanUqFP5TKGcqQWbJ9QHU2R+eJSw8hQH6WyLuFY0ueYyE/D
 +iWU10u0LNktYBWnM9Uh6JXF0J05xg+1LDsfWtzNrznNMrtOZ6fC/DjADNhI+9rfjZmZo6vV/HA
 MUPnZnzKAUhRW94yiY3LIlAVFYXkcv7Wm4bPrm3ihudYZ9jarLgRdPFJVafR1lNko21eGIoE=
X-Gm-Gg: ASbGncuuUqH3zXfLLzWnBajGKrRf6WfcA2gEm5VxEjUDGPJteecPcJ7+nYUikYifMYx
 cfNH8j0CS21GdQgaNFpdYeYKDrrO0eZ2PYjQogFor2LAJI2ATbsFcBbBj+tSznCp+SoExAiEP96
 E0ziPbpyYvVjv5A+1HG1ECLK8MPiP4u2WPYNuXhzBOZrYW3ZfrbzOoorRHyI+ML2BlLGJ+NN7VL
 q9Z+LbA6z2j2zzsArmx/9keTIcFgU2dg+G1j7UuSzfCe4PFUwwRaeUySV8baAOnqG1g4FweVSxj
 +ErsP0BGlDlnH1pERRA4VKi5lr+lkD5FzSBFglUJGNx8KMASwwjGKIzVyHydt4hN+finlVAw+Sq
 3x4YGBkn536KteGV119fiskgkAnRpDnDl1Zm/SYoAj/xAgN1wE+d6kuQc/iX8d+me5ppKPA754p
 HkyPeVKdk=
X-Received: by 2002:a05:600c:4e12:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47939dfa3femr25466465e9.8.1765018696649; 
 Sat, 06 Dec 2025 02:58:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5bB6PXfeNH4mNi4VEikLGndFyAv8A2MdD6Gi9e9tDY0MG5AlOXRDftxbJO95hlf4eZJh+rA==
X-Received: by 2002:a05:600c:4e12:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47939dfa3femr25466255e9.8.1765018696272; 
 Sat, 06 Dec 2025 02:58:16 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90f0sm13864512f8f.9.2025.12.06.02.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Dec 2025 02:58:15 -0800 (PST)
Message-ID: <2a52827f-ee3e-4d11-a1cb-7fdac3e7a998@canonical.com>
Date: Sat, 6 Dec 2025 11:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: disk: Add print to show ESP device
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, michal.simek@amd.com, john.toomey@amd.com,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org
References: <20251204094758.2800428-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251204094758.2800428-1-padmarao.begari@amd.com>
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

On 12/4/25 10:47, Padmarao Begari wrote:
> Print a message for debug purposes when an EFI System Partition
> (ESP) is detected on the device to indicate how many devices are
> detected. Only one ESP device is used for capsule update; if
> multiple ESP devices are found, it may indicate corruption in UEFI
> variables. This is for informational purposes only, as the number
> of removable media connected to a given board cannot be controlled.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   lib/efi_loader/efi_disk.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606..8391de1527c 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -565,6 +565,11 @@ static efi_status_t efi_disk_add_dev(
>   		  diskobj->media.removable_media,
>   		  diskobj->media.last_block);
>   
> +	if (part_info && part_info->bootable & PART_EFI_SYSTEM_PARTITION)
> +		printf("EFI system partition: %s %x:%x\n",
> +		       blk_get_uclass_name(desc->uclass_id),
> +		       desc->devnum, part);
> +
>   	/* Store first EFI system partition */
>   	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
>   		if (part_info &&

Hello Padmarao,

Thank you reviewing the ESP detection.

We already have debug output with EFIPRINT() for this information in the 
subsequent lines. Please, have a look at CONFIG_LOG for enabling the output.

Generally noisy output should be avoided in the normal bootflow.
A "message for debug purposes" should not use printf().

Maybe we could add a subcommand to the efidebug command for users who 
want to look up the identified ESP.

Best regards

Heinrich
