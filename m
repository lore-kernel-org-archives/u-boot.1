Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B983FC3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC99588276;
	Tue, 30 Jul 2024 09:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k3OoQepT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D662E88356; Tue, 30 Jul 2024 09:49:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE57888247
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso24046105e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722325779; x=1722930579;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vTs3DZY7JeMF9cl0FJ/np4pUsIuPDYI5vL/EkP6dmbA=;
 b=k3OoQepTm8cN4HjswMNP+iHYW+iBgL8Lypj+Up+aXK0HGODoVzE5Zc0OmN3C4Lni8Q
 ZH9gHvAYVtky4GcQDyyKGvdY0mS9irr7KvwzHVM/G6HuhEEsQ4M9cLutWQ1xOqik5yNK
 AmvGJQyqwFQ8KcgRldu/PjG2kC4wRseURpR/9Ta0LOZFrUStZEk/l3n++0IsrfU2457H
 aTDTTgJ6GD5ANQuJv2wDlQaghU5LD4rpUjYajtauD56e7VdRZe6TTdLwT/ZFSF/6FQfW
 VYSlA1SKNyO5xrjIkXDDPFWokQqPJNoC8QMPWd6uK3L82YhCJcgQXkkHsdJuPoP9FjBG
 AWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722325779; x=1722930579;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vTs3DZY7JeMF9cl0FJ/np4pUsIuPDYI5vL/EkP6dmbA=;
 b=U6HSisu7U+UDvlXKytewjdU37isuXsP/wY/qZx4ipY5O/mBVJdydkVdbb02dg8SC+u
 HggXfzOuwsvNTxJzst9tjTdhAdUHbYnO1mMkv4GStReUB5JHQYSdyGHtOzKBnF+OnFph
 2vS/SQXLXBQYO3u7EGHsh4FDQ4yYTsFyn12V6mKY3DFx+iB0yFOXzaqIPp+X1gfwEaZQ
 bugLMqIfp1bSbQf1uqeodrSrnBcVk2lRbhHbUEj6uHeZYkJZAvQ/7quEiHexJw8I+ro6
 TJqYSFmDRVLalaOCnrIJFmFwyEFeca8lPNjySuCnEgFBkXyC2p+lG3Lsc1M1kFtbm0EX
 S6rw==
X-Gm-Message-State: AOJu0Yx67SrYzvkwUsEhA2ToDvjXJYOWi00v1MecjnvLRoVv3F67rVML
 CPiYQX4pRJ8uuoPhg/a7Q3QKJ5l494KuISKpBI3aFydgUPH2kcrUum9NATpaqFg=
X-Google-Smtp-Source: AGHT+IGlBQrv1HYVpKbczJ/umQHtVI9AZQbdKJdsfgMiSoid9zcBtZecL91Zm5MQJew3++zrnCaiNQ==
X-Received: by 2002:a05:600c:1c02:b0:428:387:79ac with SMTP id
 5b1f17b1804b1-42811d8642bmr81794305e9.6.1722325778752; 
 Tue, 30 Jul 2024 00:49:38 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280f027411sm143065725e9.33.2024.07.30.00.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 00:49:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com, avromanov@salutedevices.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1 1/4] cmd: ab_select: fix indentation problems for
 --no-dec parameter
In-Reply-To: <20240725194716.32232-2-ddrokosov@salutedevices.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-2-ddrokosov@salutedevices.com>
Date: Tue, 30 Jul 2024 09:49:34 +0200
Message-ID: <87h6c7qpyp.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for the patch.

On jeu., juil. 25, 2024 at 22:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Command ab_select has wrong help description from indentation
> perspective.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/ab_select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/ab_select.c b/cmd/ab_select.c
> index bfb67b8236b6..9e2f74573c22 100644
> --- a/cmd/ab_select.c
> +++ b/cmd/ab_select.c
> @@ -63,6 +63,6 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
>  	   "    - If 'part_name' is passed, preceded with a # instead of :, the\n"
>  	   "      partition name whose label is 'part_name' will be looked up in\n"
>  	   "      the partition table. This is commonly the \"misc\" partition.\n"
> -           "    - If '--no-dec' is set, the number of tries remaining will not\n"
> -           "      decremented for the selected boot slot\n"
> +	   "    - If '--no-dec' is set, the number of tries remaining will not\n"
> +	   "      decremented for the selected boot slot\n"
>  );
> -- 
> 2.43.0
