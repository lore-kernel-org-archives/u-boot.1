Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70DDC4829D
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD7A879F2;
	Mon, 12 Feb 2024 21:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N+ABRlJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D7887B7C; Mon, 12 Feb 2024 21:41:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E37879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dgilmore@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707770470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUU5xiBAnsYVnga9lP0a0rbdhNRP/IImXU+tb8G0n8A=;
 b=N+ABRlJXMNqPyncr3oaqDBrxqNAwHnUqQybjItMfSAIxzAvZT3G1uhZSRV5vc7JpkYcQ41
 qPl/azQzmzMzxtkAlzKY4p0Lntrdkpj3bP8ujLPYvJooONrSYqoA9aw4r+H2MJppIZzGLd
 Aq8wCU8kguZ6h6JeYycVphSsmVw++bs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-h5aI7GXUOqqT0HWxVqD5OA-1; Mon, 12 Feb 2024 15:41:09 -0500
X-MC-Unique: h5aI7GXUOqqT0HWxVqD5OA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-298a2564b5cso28069a91.2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707770467; x=1708375267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dUU5xiBAnsYVnga9lP0a0rbdhNRP/IImXU+tb8G0n8A=;
 b=XYjGCJqxlnqKKTDoIBvoeNo6HuH0gUH+ueU+UJQ60S7hwn77BsNA58P9oATl0O6pEd
 iXqqB6lm1+HyeOZnJF5AedWJjCYafk0oopbCgxEdxBerL30JZ8QJcMAzfL9wFjZoinzT
 JHsMzrzus27iRjbj7oqqkWjEOdM04gKCKu/HNyD8o5DL6uR1LWXpsIToE8ezsc4dPook
 vhEIwhEmhwQauiuIs5H4Ym30j4utbY8LME98vRvEnAEuEgSc9lnfwPa2U0lzkNTK9ntJ
 KE5tGDWswIXFxYv7H+V/R+COF2P1jHvoaxo0B3ZNcbrUkoLg285/gDuEiwf10z59rLBU
 Uw/g==
X-Gm-Message-State: AOJu0YwYCOGD9y/xoSUIA3jlZQPSGrP5Mw+jw2cKddTB9ifnAPgQOcgw
 0H7YqnjrKCc3sft+aZF95RhiT3JtSlDMEnn7Fpk2VPNQzwis/Gv2zj7szJIz7116P+kNZaMUsuY
 qX4XJ6lEseVNLV7XtMGgy7PVXRKbqXu62b4tx+Ydr2IuQ0rbmK8yI7ienH+6QCzdAeoYq962QWd
 ymwylVtoKhngDny2Pyp5Q8s+1lYXxIuXgzWdqg
X-Received: by 2002:a17:90a:a896:b0:297:164a:ea52 with SMTP id
 h22-20020a17090aa89600b00297164aea52mr5448079pjq.11.1707770467344; 
 Mon, 12 Feb 2024 12:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzeZ0Abxpttoxc1tzHxVxhBa8wm6zk/isfnpGkn00vlNkmqkuWw+A9o7ekETf78IqWGWpqrsN3l6GUBeQbiXE=
X-Received: by 2002:a17:90a:a896:b0:297:164a:ea52 with SMTP id
 h22-20020a17090aa89600b00297164aea52mr5448070pjq.11.1707770467068; Mon, 12
 Feb 2024 12:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
In-Reply-To: <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
From: Dennis Gilmore <dgilmore@redhat.com>
Date: Mon, 12 Feb 2024 14:40:54 -0600
Message-ID: <CAJesf3OEfkTw_02jX0rnT2mRqRkHOHRrwpGqTvXHw6rcWAY_8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: mvebu: helios4_defconfig: enable setexpr
 command
To: Josua Mayer <josua@solid-run.com>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

I am curious about your use cases for this. as ideally all systems use the
generic distro boot paths and it is not needed for them.

Dennis

On Fri, Feb 2, 2024 at 9:13=E2=80=AFAM Josua Mayer <josua@solid-run.com> wr=
ote:

> Update the helios4 defconfig to enable the 'setexpr' command, which is a
> default and useful for various complex boot-scripts.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  configs/helios4_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
> index 04194004f0..73f0638344 100644
> --- a/configs/helios4_defconfig
> +++ b/configs/helios4_defconfig
> @@ -44,7 +44,6 @@ CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_PCI=3Dy
>  CONFIG_CMD_SPI=3Dy
>  CONFIG_CMD_USB=3Dy
> -# CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TFTPPUT=3Dy
>  CONFIG_CMD_CACHE=3Dy
>  CONFIG_CMD_TIME=3Dy
>
> --
> 2.35.3
>
>

--=20
Dennis Gilmore
Senior Manager Systems Enablement OpenShift Development
