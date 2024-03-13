Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CDC54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 17:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF09D87EDA;
	Wed, 13 Mar 2024 18:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkyjiE5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D0D87EDC; Wed, 13 Mar 2024 18:18:46 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFBB87EAD
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e97e3d97fso1575f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710350323; x=1710955123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fIlwkP+dUh41/09cU4QXsvPV5cjFQl7V7/LPbTFm1Ao=;
 b=AkyjiE5+KjWGvxIGxIjt3gn3ebRShcchbNsS47KXrEjghjqxfslyAs7Bro1rrYAoNZ
 L3UM4Q4C1r2YSUveAyUhwxyb533XbOV7OY2xuCNlv3NMGic+ci1UXPaWUaUOrSwmNTQL
 1aFLk0AA1OvkJxllPMcJxupB4UC78N+JxhYkZWagTcUEVUsr0XeWCW2f2Wv5VPqgD8jQ
 nDX180+V0KDV2+rbfx+ANXgiqg1RLmfdQE2jzg6M7UkGP82BBYHRlP1HrDzWwNsZI4G/
 oHANOxSABjkjeR6JTdesYUr1I0Ku3/h4JKe8wm0iNXSA3rZBEcqU/B4UTk7bCjr4VVaQ
 Vm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710350323; x=1710955123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fIlwkP+dUh41/09cU4QXsvPV5cjFQl7V7/LPbTFm1Ao=;
 b=VtTQRqHWbRIs35z4MMG/UtHyv0rHq02UpE6lD41SfgS6heT1rQoT4UAF6I4V4WsYrc
 AczgYMWFIQ7icreU6TCnUS+QemAV9IKBXYnLHJJ0X3IB3zj2UTXEM7GeQivLh1Rml0ly
 LrwlRkTAxCRCtSGpDtvvIzgT0c6VV/qA8eS7ex66yL0AMVLWIjvjbEP2AV42/gF5JANd
 XjqSlVkT0tqhdfr0y7EebcQvoeiJ4bLyTVpoOSYSQQfXZANsqTFLfrrEKuViB5gH82R+
 g1m2TAtbbMCbRfIG/sqvxauF5NpJLvEd99JKv0+Cu8XWAg9R1c7O2QhIubhvNl3zyjoX
 lUdg==
X-Gm-Message-State: AOJu0YyAz6uvnLH/fgkQH9/WTwzbaFgyAz4EbPiyG1dgW1x10PwrNGA7
 Xjj/NQOhgBjYxW+ZXludiQxAN/raoqUWbzSgDWN+qkbJhffJrEgerEd6C4exNyBTM41N0HmsxN7
 Riwh3SVd/McqqyJBIk+Z/1vRYOh8=
X-Google-Smtp-Source: AGHT+IENIEY4tBy92KC3Pq/pPxK70Q2rcGBxkLW/L8NoubsQkOtKutdmtI+llHy/KphfRI4U6j+68O1KMYuOhVOPI/I=
X-Received: by 2002:a5d:4ace:0:b0:33e:c9e:991 with SMTP id
 y14-20020a5d4ace000000b0033e0c9e0991mr1760190wrs.6.1710350322873; 
 Wed, 13 Mar 2024 10:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-2-colinmca242@gmail.com>
In-Reply-To: <20240312125729.82695-2-colinmca242@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 13 Mar 2024 18:18:31 +0100
Message-ID: <CAByghJYYFppHV0J0Bs1vxRj7kzjhTCUMn+H86GQDYdsmLChqYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] android_ab: Add missing semicolon
To: Colin McAllister <colinmca242@gmail.com>
Cc: u-boot@lists.denx.de, Colin McAllister <colin.mcallister@garmin.com>,
 JPEWhacker@gmail.com, 
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, Mar 12, 2024 at 1:57=E2=80=AFPM Colin McAllister <colinmca242@gmail=
.com>
wrote:

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
> @@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>  #if ANDROID_AB_BACKUP_OFFSET
>                 crc32_le =3D ab_control_compute_crc(backup_abc);
>                 if (backup_abc->crc32_le !=3D crc32_le) {
> -                       log_err("ANDROID: Invalid backup CRC-32 ")
> +                       log_err("ANDROID: Invalid backup CRC-32 ");
>                         log_err("expected %.8x, found %.8x),",
>                                 crc32_le, backup_abc->crc32_le);
>  #endif
> --
> 2.34.1
>
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
