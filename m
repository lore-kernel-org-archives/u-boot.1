Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E45C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152FD87979;
	Tue, 26 Dec 2023 10:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z7w986XZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA71E878EA; Tue, 26 Dec 2023 10:50:38 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BB887963
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6da67ca9969so3372432a34.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584235; x=1704189035; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=db/jBjv1FLDq/zRTWkhLCsbRKKgbe2DZO2kaFBP8FEk=;
 b=Z7w986XZcGH+R5+Q4Z2ekHttWxW39l3TJ95FqNLx/22qt+0XxWcSbwLe7wDuFTAgWn
 6ue6WCMwIM25MYZoOhAcUTWQolcx9GD4Ed2dPoyr9GygH5xtNwYTQBT2ogt16zMZ4pBK
 Ccb98YpnmHlpn4jQpejaU8aol7+impiQKJHH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584235; x=1704189035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=db/jBjv1FLDq/zRTWkhLCsbRKKgbe2DZO2kaFBP8FEk=;
 b=KrTIrl+t/LWKGRTPYgX3RP/s9FQqEcZiCNrAfvHJfh5sW+3OZTC7BjlnXhCM6p/kmn
 c53ganCJvY8tpmHpUQ8/cY4k/O0A6RN+9gspwjDoGIezejM+oqgjKYV6pzTBdCec0zNv
 iiYQvSeijq02aHwan+Sl9F1kM0UkpxhTjGoi7Z68rjgF6NG5GNh3ipTYJl7uagcUIhVv
 fWftE39Yl7wbs87JQWY6bMdj3XTIetuGW3g/vRruzZG2LWYj8ZEc8IPSxPcuXcZd0HIJ
 N0iy1vQiNbZ5eStRXegDOuxsAOgkwg6JtwJaz6xeuGV0G580CL6MCur5RKIBTM1UYSZe
 Lc9g==
X-Gm-Message-State: AOJu0YwJ07XsaRs7gtDM4I3gL/ICzwYOwm9fBxuMji1EMnVC6aDl6rjQ
 LBBtFgg5hcHpv9sm3FUmAF5azcUnl55z7s0jC4FdNNRCIDaZ
X-Google-Smtp-Source: AGHT+IG9D10kZDwzkzLbekTlz0TQfWIsbnZjQ36D8fk8IIsbeN1gXy6JHVQAd7yVhOmivkrGozuETh1cKYtIySKDAlI=
X-Received: by 2002:a05:6830:191:b0:6db:9ed8:ea20 with SMTP id
 q17-20020a056830019100b006db9ed8ea20mr5791377ota.12.1703584234993; Tue, 26
 Dec 2023 01:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-3-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-3-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:16 +0000
Message-ID: <CAFLszTh5Vu9g5Z=ty17e1V-f-zLsKXnkP2wYAMYHfLKbCahG3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] smbios: type2: contained object handles
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> The type 2 structure must include information about the contained objects=
.
> It is fine to set the number of contained object handles to 0.
>
> Add the missing field.
>
> Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/smbios.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index e601283d29..88c19ae062 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -139,6 +139,7 @@ struct __packed smbios_type2 {
>         u8 chassis_location;
>         u16 chassis_handle;
>         u8 board_type;
> +       u8 number_contained_objects;
>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> --
> 2.43.0

I thought I already saw this patch elsewhere, but this one is not a v2?

Regards,
Simon
