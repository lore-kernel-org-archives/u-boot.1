Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824CBC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD08889D0;
	Tue, 16 Jul 2024 09:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xdHvWdbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28529889D1; Tue, 16 Jul 2024 09:50:51 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390D988907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266f344091so37429335e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721116249; x=1721721049;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2leGyKoLu+If5bWYRcR14KJ8LBv40SfxMORQFg/t8d4=;
 b=xdHvWdbSE/tACh48De6C5vE0gJYwduhpshVK8pZFnDJhhe3ULcOE1Hu7WTKQhw4JPo
 KscbQ5nvQAA0FjlzQR/4V3YwUxhLwMgTYWeoyoWzJzMLYu5mD353nwztGfNJ1TxquGTM
 S5TQglXg7Y2CmR6Do6PYIahoeESHbbkUqA8AFpo2o9tn/HEQFuxgd55q1TTIs4p9u8aL
 8mS4K1vNqLYRCBWdaHsfwBz0avKckleQsbfB8YTz9ziXHByzmeUJsuPMcVR3fmKwzZ51
 oENKph+A8UGjTDYvsDCxVnvoF0ROk0FB6D3PVGvyjy6CscYWKhCtrWc8TOdjvte11Cxc
 KL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721116249; x=1721721049;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2leGyKoLu+If5bWYRcR14KJ8LBv40SfxMORQFg/t8d4=;
 b=rKS8SQLPKvdny9B61g4pL6gmmVR6VCn1fxJKFX4dTpiM8F6Kj2qiy95cHRhrWAKFoh
 Jd1wbiHdW4x6HYULAWB19kWkWED5Wu8SyARA9Op/sxVRvJHttwEDo+mXEvZQ1pvz7DbI
 Rv77dVDxKfb7BB4sbeqdwcqHL3eBNf6d6OWMblsA5rDkx8C1EVgTcuO1eLW71YOqJi7v
 2NDZpgMNxB57XTU1/qj1VJ8GQ0TzNgkEocsJ3BseI9moDSkQK9TFY8Yb/d3C3IcxJwfr
 762U92NKG4N8DJ2hH2SscCuXlKj5la7WPa7aKfXOQya5LvEBtFkdoG5c1lLLEcbC2i88
 oorA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyhmeKXbdYjajiXhZUudGy+RNDDxoADoEn2nwAO/Fu/rw5BiVTE5t4MlXbbjXgJI+Rwi7m0NrRPZ3c/U391w5JdqkLEQ==
X-Gm-Message-State: AOJu0Yzf4x4989jptjWSlhoIaILaTlyvki1ef4U5WddIPwgetIMRCwL9
 J7Sm2iC4fSNrP/9cglOQfNH0N8bvl0BStg/fasXfhCQ/YzXAOVJ9a5IwqPUHkcc=
X-Google-Smtp-Source: AGHT+IHVAkcgPH67b6C0VegNJj1EhBp3MUrmETKIGymYnQY6yy+1xwaVdTArrZe3g8eXo4DK8VxqkA==
X-Received: by 2002:a05:600c:1911:b0:426:6960:34ac with SMTP id
 5b1f17b1804b1-427ba6b12d3mr8210925e9.36.1721116248515; 
 Tue, 16 Jul 2024 00:50:48 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e8387fsm113154475e9.20.2024.07.16.00.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:50:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glkp@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 13/14] boot: Correct indentation in efi bootmeth
In-Reply-To: <20240716070419.1897560-14-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-14-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:50:45 +0200
Message-ID: <877cdln5be.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Fix a minor indentation / whitespace problem in a comment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glkp@gmx.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  boot/bootmeth_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 56a6e47f5b2..39232eb2e25 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>  		return log_msg_ret("sz", -EINVAL);
>  	bflow->size = size;
>  
> -    /* bootfile should be setup by dhcp*/
> +	/* bootfile should be setup by dhcp */
>  	bootfile_name = env_get("bootfile");
>  	if (!bootfile_name)
>  		return log_msg_ret("bootfile_name", ret);
> -- 
> 2.34.1
