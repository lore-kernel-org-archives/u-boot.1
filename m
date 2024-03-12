Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690CE87FA0;
	Tue, 12 Mar 2024 16:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EsVD1gUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDA787FA0; Tue, 12 Mar 2024 16:12:54 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B18487F16
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so4214490f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710256372; x=1710861172;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=M+l93FsEn5aD8ddD+wVroahWpY0mAIl3XGJaGhyvmQ0=;
 b=EsVD1gUojOPSX0pgdDb/Evm4vTE+EM8OypwC7VjbhdeWctcAoMNvQZk/pq91tupaRV
 8eRB1mhOpzROQERGLuBMXws1kbD9dT+X+D3JyKAVCKRCgP2sYQylPVRR4NeuLaqh8WqT
 S9jp1EM343JF536RmZxiRr0iHA8Uuqwu/iKe8Uu04IKZ6ZZ1h+k79M7m8JpWWREb7O5o
 90fjzcIE96AdjeFFwEkgFuSGw+5Q4iXJlHOpftUpZaaqm9LnGZGdfR2g6TsRPAHWcvyf
 EEXOeZvnuOYHE2Wo4xm9DZBLxKw6cPneySGeQPhcnQ4tQIQYyE44J1Mk7Fz0rEiYIe3R
 9iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256372; x=1710861172;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+l93FsEn5aD8ddD+wVroahWpY0mAIl3XGJaGhyvmQ0=;
 b=jH+x2t+lXq4hgP3VA6dqXeb7/XxlCwwFbJD7PLxxobAu4ttuy+oC1bGK9yjIoRuEsS
 u47nlRnIZqTqm++I00tRT6Mbw2+cqCiP9bUw67FE1iJvJkaO0LXFu4pRbOQuX4SNcsS7
 QNdgJgEluj8HpD4wpw2mwxj5NWo4jSMqcJcbUQNUU2ozaL2thMyJZABN4XfZd9TlgSe+
 CnVIVcjUTG/uk4iDvQyiKjjwd//2/X2xJxsusE5FrbPfUV3j/cFNVH9MkizeBeUTd8qD
 CjoBL+cZlyovDXU6icYZJDtocVzVsP5Q5bGVF6QtIz1KW6UQg54Zk5rZ6d8EOdogroNK
 Rwgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSn9TuQ7bcVbF+jcuRF2t3uNiGseN94FLCd4b5+vAi9pEjCMgD3DR7AE+bl4DutL1UInuQckWzAhro1Sk2EfJHAQmDRQ==
X-Gm-Message-State: AOJu0YzYafrlsaLOaIirzxCw25DDPcih6jFfPfmOQgN7b/VRv6Nk++Nn
 /bfjcvtYnijD7Vrp7RJk0mZeW99k2PmK+O3Ybtcc32rW6h51uol8VLYunP4wfQ0=
X-Google-Smtp-Source: AGHT+IF6wzztImSOxmWbUJoxvZNUlboovm1ZotF3l4A7oc3DEzLm13HlsWdZfdi3fXh9vJFI5bGLGQ==
X-Received: by 2002:adf:f984:0:b0:33e:9451:c299 with SMTP id
 f4-20020adff984000000b0033e9451c299mr455341wrr.26.1710256371968; 
 Tue, 12 Mar 2024 08:12:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 r13-20020adff10d000000b0033b278cf5fesm9192090wro.102.2024.03.12.08.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:12:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Colin McAllister <colinmca242@gmail.com>, u-boot@lists.denx.de
Cc: Colin McAllister <colin.mcallister@garmin.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Colin McAllister <colinmca242@gmail.com>
Subject: Re: [PATCH v4 1/2] android_ab: Add missing semicolon
In-Reply-To: <20240312125729.82695-2-colinmca242@gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-2-colinmca242@gmail.com>
Date: Tue, 12 Mar 2024 16:12:50 +0100
Message-ID: <87msr34h71.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Colin,

Thank you for the patch.

On mar., mars 12, 2024 at 07:57, Colin McAllister <colinmca242@gmail.com> wrote:

> From: Colin McAllister <colin.mcallister@garmin.com>
>
> Found a missing semicolon in code protected by a #if that will never
> evaluate to true due to a separate issue. Fixing this issue before
> addressing the #if.
>
> Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Signed-off-by: Colin McAllister <colinmca242@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Since Sam gave his review in [1]:
https://lore.kernel.org/all/CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=+bRU=fdub4K1uX5p33Jw@mail.gmail.com/

I will also add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

When applying.

> ---
> v2: No changes
> v3: Added "Fixes:" tag
> v4: No changes
>
>  boot/android_ab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c9df6d2b4b..9a3d15ec60 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  #if ANDROID_AB_BACKUP_OFFSET
>  		crc32_le = ab_control_compute_crc(backup_abc);
>  		if (backup_abc->crc32_le != crc32_le) {
> -			log_err("ANDROID: Invalid backup CRC-32 ")
> +			log_err("ANDROID: Invalid backup CRC-32 ");
>  			log_err("expected %.8x, found %.8x),",
>  				crc32_le, backup_abc->crc32_le);
>  #endif
> -- 
> 2.34.1
