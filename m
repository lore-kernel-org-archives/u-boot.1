Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A18CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381E588D99;
	Fri, 20 Sep 2024 18:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZiF63rHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11024889ED; Fri, 20 Sep 2024 18:04:17 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2131688D02
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7197970e2aeso1635378b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848253; x=1727453053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l5Q7ky89n436DaiASmhIKftqT1CWcc/Ng3j/sB4mf8E=;
 b=ZiF63rHlD472H/vzpsJPDkLZXKPNY/FXB4JI0Bg3susj/8EF18vmnnIzH+6yx8MCm6
 wujO7gBl4tVNGxszozghAXzCAVBZPNsD/dhm0ZT/B64JthZZpHbD78BSFzCI2Z+mW2qD
 zehkBNFflQmN2HNpE7OCG58feV+2tBEACDSqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848253; x=1727453053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5Q7ky89n436DaiASmhIKftqT1CWcc/Ng3j/sB4mf8E=;
 b=LYuWyx7L6GVaEkfr2cajfW3meZp2F6//12E0f53dIUbfJPFfxDnIkT1D/LwIT3bKs6
 O8rXbqDZx9dDDCfhZ6Rkhk4MUMyc4L6JpWQM9kjkpe4uoeA8Mt5THKMf8aVIya5FLW18
 wCWgWirB9XijSbzAPXDzEn0hu/0E58Eqa1fnO1olf49EyDQ/INYAIcDhfUP/MaK7raGf
 trZazDhrVGprSmsXQSRYHGnrNSlKqUCJQeEP3ezYmyjRwIML07wwi8a5F36HdFwlPwU0
 KIBP5LURxOv/rRStgOgGmJOr7CsCcjjTcKyD+bxHMfJbR1ZI5R4YllGJ8qlFbKYVMNez
 DR9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSvKxEvs2whuwwuEb3Rz+7BkeLaDzmKU1+csLrdqdPhPr2vaCGPfR4o/RixuV3Q0PMOFqts0=@lists.denx.de
X-Gm-Message-State: AOJu0YwGqv62YKlgUDBNazUsnnwYdCkvzN9sCQCW/wJic2D/QU3vpYIx
 9E7btmP/wbvoAoeoO2/YsLXuCr4hXBNbqzWtmBvTipZbL5fTQX3u7KT9u6h8oSXd8glrw6WpDaO
 7OmKA7U8WLComYlcTQvEUqkiiafa4TFCndSm9
X-Google-Smtp-Source: AGHT+IFThfwgU0OfkQ1VeVBKHpqcStaNYFuZI2Q3za3yuvJmSy8y5gfV9iCZq+Gc22Z+Ad2wk7XBomonFSqWE5bu5QE=
X-Received: by 2002:a05:6a20:9f4b:b0:1cf:3e99:d7a5 with SMTP id
 adf61e73a8af0-1d30a9b1a68mr5396645637.31.1726848252692; Fri, 20 Sep 2024
 09:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
 <20240824092716.1042696-12-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240824092716.1042696-12-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:53 +0200
Message-ID: <CAFLszTiFen6i7CUW3x8dLE8qSaZfrAjv=rUK+38ABiDSwC+dVg@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] net/httpd-upload: an example web-server
 implementation for file uploading
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 24 Aug 2024 at 11:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This is an example web-server implementation. It can be used for files
> uploading to u-boot using a web-browser. It acts much like tftpget, but no
> special servers needs to be installed by the user.
>
> This code can be used as a base for other implementations like firmware
> upgrade web-server used by some vendors.
>
> Usage:
>   u-boot: start the we-server using the "httpd_upload" command
>   PC:     open the "http://your_uboot_ip" link in the browser
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/Kconfig                     |  14 ++++
>  cmd/net.c                       |  20 ++++++
>  include/net/httpd-upload.h      |  12 ++++
>  net/Makefile                    |  19 +++++
>  net/httpd-upload.c              | 123 ++++++++++++++++++++++++++++++++
>  net/httpd_upload/error_400.html |   9 +++
>  net/httpd_upload/error_404.html |  10 +++
>  net/httpd_upload/index.html     |  14 ++++
>  net/httpd_upload/upload_ok.html |   7 ++
>  9 files changed, 228 insertions(+)
>  create mode 100644 include/net/httpd-upload.h
>  create mode 100644 net/httpd-upload.c
>  create mode 100644 net/httpd_upload/error_400.html
>  create mode 100644 net/httpd_upload/error_404.html
>  create mode 100644 net/httpd_upload/index.html
>  create mode 100644 net/httpd_upload/upload_ok.html
>

Reviewed-by: Simon Glass <sjg@chromium.org>
