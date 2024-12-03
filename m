Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791BCE64A8B
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045718939E;
	Tue,  3 Dec 2024 14:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Oo76w74R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4049889655; Tue,  3 Dec 2024 14:13:25 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A1888875
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6eed41d2b12so42900457b3.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231602; x=1733836402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=45vJlDNC5Qtz2dHU0DsxMNNKCUrjzJLevadpnrKjV/Y=;
 b=Oo76w74Ryijnd7suB63OCEuJjPlcSkJR4i22f/v4AuyQHnHlRTTjCi5eTgaAW5ET7a
 a3i95+gOHe+10u/znQWxuIVcg34wD3EA6IAu6S5lQB2ucWSgplmqCBhXExV3vuN2uamw
 1qGx2fTjFzZ4HFzzjCcyn9OEB2zo3dOxcqCdX/Ox6cWOpxXlGGcng8Zk0QYyMPoXgiMQ
 J2vLZbQuK4WqmS+0YCwoeaz6tFmG0/JUFPVPkBTlDnqhh+NUanSrwjk0W8C3TqUC3U8M
 G0jUXyPt3nPAFXJ1ZBteFrvM53R29mnVbIs6gAQez0/b8CLthX78lTaoHkaQy72rIKRr
 OW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231602; x=1733836402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45vJlDNC5Qtz2dHU0DsxMNNKCUrjzJLevadpnrKjV/Y=;
 b=BJVo1tjTq1NHAxXoRBVsZDS/NTbaShocE9kVXa0G+YhS83GGgUZ2evietGEKuULhG9
 H0v9BWlfkAtlBHqCbRKJuB+YRgn8W/wJaibqQfPCcM3EKm9yQfyyTfOeAlU1H/8/ue/A
 XJB8RVVDgYL4z9jiSAYImopzz1vVP6hKW3OYaXql3ZRuNANv1YH8XcDcTE7OcSbDpPM7
 15wEfoK6j7x7m20XYkTYPaHleSeiZz6ZzLPQUR1x9qhPaca8rP0noZRQUzIz8I1UTuKl
 /XCXSvCJhxODQCePQPpVFmhH92yyPKnO49WDL6eKTkwmxXxcNEtb1+hCmBhW4ApX0zBo
 W5wQ==
X-Gm-Message-State: AOJu0Yz8cA9sqXIcs6c+1j4uhotqK1J6kitGe0CpEhT04pqmtVdM0cs7
 XQmwRrs2lAFAQNxwJrO00u0NS3QcnO2BNzz9uXAQwbJS6J6Wh5UCjop0E9tUeXtQZAMa2ufqKm2
 CDSgMgXNkXJZXm7S0+bLCA4SOvCxt105GdaN06w==
X-Gm-Gg: ASbGncshegckuM9ae50NeFnum+gac7ZVhi9tr6T52Dj2Q8eZc/Esz7o8G7DkaKT9ba+
 gxxXmUAPOyF3uaPasri/ZMeO7FM8P3U8=
X-Google-Smtp-Source: AGHT+IG2UfF4WTBlZUWgOuPeLec62/L9y/r0l5jaVlj0yh/BbtTMdqeyPBqLsBrYw9oaxxiR+e+RIMzYp/BJ2bOGvUU=
X-Received: by 2002:a05:690c:7487:b0:6ee:55c7:6128 with SMTP id
 00721157ae682-6efaf940fa4mr19814617b3.5.1733231601858; Tue, 03 Dec 2024
 05:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-4-adrianox@gmail.com>
In-Reply-To: <20241128144416.604126-4-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Dec 2024 15:12:45 +0200
Message-ID: <CAC_iWj+hRO=zaZ-_rx8as+G49BmX6Q+ACyr9g_mKjhVj1suEWw@mail.gmail.com>
Subject: Re: [PATCH v6 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v6:
> - Complete documentation of efi_dp_from_ipv4
> - Return NULL in efi_dp_from_ipv4 if allocation fails
>
> Changes in v5:
> - Add function description to efi_dp_from_ipv4
> - Allocate ipv4dp in the stack
> - Make efi_dp_from_ipv4 static
> - Remove u-boot log messages inside efi routine
> - Change (void *)(uintptr_t) to char *
>
> Changes in v4:
> - Fix memcpy mistake
>
> Changes in v3:
> - Remove some unnecessary void* casts.
> - Change sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>   in efi_dp_from_ipv4.
>  lib/efi_loader/efi_device_path.c | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index ee387e1dfd..6fcbc91e0b 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -974,6 +974,53 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
>         return start;
>  }
>
> +/**
> + * efi_dp_from_ipv4() - set device path from IPv4 address
> + *
> + * Set the device path to an ethernet device path as provided by
> + * efi_dp_from_eth() concatenated with a device path of subtype
> + * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
> + *
> + * @ip:                IPv4 local address
> + * @mask:      network mask
> + * @srv:       IPv4 remote/server address
> + * Return:     pointer to device path, NULL on error
> + */
> +static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> +                                        struct efi_ipv4_address *mask,
> +                                        struct efi_ipv4_address *srv)
> +{
> +       struct efi_device_path *dp1, *dp2, *pos;
> +       struct {
> +               struct efi_device_path_ipv4 ipv4dp;
> +               struct efi_device_path end;
> +       } dp;
> +
> +       memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
> +       dp.ipv4dp.dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +       dp.ipv4dp.dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> +       dp.ipv4dp.dp.length = sizeof(dp.ipv4dp);
> +       dp.ipv4dp.protocol = 6;
> +       if (ip)
> +               memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
> +       if (mask)
> +               memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
> +       if (srv)
> +               memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
> +       pos = &dp.end;
> +       memcpy(pos, &END, sizeof(END));
> +
> +       dp1 = efi_dp_from_eth();
> +       if (!dp1)
> +               return NULL;
> +
> +       dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
> +
> +       efi_free_pool(dp1);
> +
> +       return dp2;
> +}
> +
>  /* Construct a device-path for memory-mapped image */
>  struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>                                         uint64_t start_address,
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
