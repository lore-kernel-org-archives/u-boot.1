Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85263C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 10:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1218718E;
	Tue, 21 Nov 2023 11:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AsFaVr7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA0A870F2; Tue, 21 Nov 2023 11:27:35 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CDD87585
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so7282938e87.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700562449; x=1701167249;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KACkZwVUsfSbmWf48aQuhNz+RICf6zQGrA3i1E9aIvc=;
 b=AsFaVr7LHYjskbdeATred2T+AGijO4Ay9vLjoCvpvCRabF/E8N+JMJ35baj95/I54A
 gNdyJyYK8S14e8ZGbIwa9GUZro7tuu+4gm581IK5cnQnfnXXyxvCnHWwQlC2ZpyLim89
 jSuzGYul5IrFerIKqBXVgMaR9jfjUk6uXqO/E/P4198h3ODk7cBrDh0AMhwLDoJf6Gl+
 TF9THmIcdGwvM5+V/k7gwF3HK3eCF/ykLQKRoaim+GMPefpHtu5Xpcda2foRDyQFQFqi
 IhMutk5UoRkM2eQw4zcDnfomxImXnmXuXJIl5ykqM5aP3+yKANrteQ7rGlUk3WtlqXKn
 GH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562449; x=1701167249;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KACkZwVUsfSbmWf48aQuhNz+RICf6zQGrA3i1E9aIvc=;
 b=arkXYwH+LAR0NIO2q0bUtURc+fj7xECnl8TNj6VM7pjNWKroPODEIY5Cv+EjQV9Vnc
 zcaodJgbsRUYlz4MB2T6bdc8bOT08Y+BtMivQVg8rbntlEkN+kjklzu0v8lOAZ89YIOy
 GYisFUPaOJt++YxbhiVPJq/8Z0jppNSYlekADsm6s5h7HVzfbIJlzH3hYXMP8VVSm+3Z
 lTK1dHGlaArRfKpYfS12+bxUTaw4r2CDUDPh92T0wMH6S430MNPVAfPC/E4FvYmYYKZo
 r7QH1cFaZzeGAoMYInvypEe5Ih0pED4wiXS8U22Cy2+muyEqNZfC42spOTF3iEE8j+8y
 KoiQ==
X-Gm-Message-State: AOJu0Ywd/0BV4O1PGjuXGOF/FAGYT2O08see0M3Mvcqk7vy6UXLComQV
 XIK1XEgX5coM+/NQSer9FP+JDA==
X-Google-Smtp-Source: AGHT+IEV0eOcsmZMbFRVle3akWxRZOkDDxS7iuFg2xPNmgp7YSUycqvYktSNziqpoBdnk8tJhOsYQw==
X-Received: by 2002:a05:6512:3f1c:b0:503:fc2:bfaf with SMTP id
 y28-20020a0565123f1c00b005030fc2bfafmr8016221lfa.33.1700562449366; 
 Tue, 21 Nov 2023 02:27:29 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e29-20020adfa45d000000b0033169451a84sm14067972wra.29.2023.11.21.02.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:27:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/5] common: console: introduce overflow and isempty
 calls
In-Reply-To: <20231115153836.16537-4-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-4-clamor95@gmail.com>
Date: Tue, 21 Nov 2023 11:27:28 +0100
Message-ID: <874jhfmmen.fsf@baylibre.com>
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

Hi Svyatoslav,

Thank you for your patch.

On mer., nov. 15, 2023 at 17:38, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> Separate record overflow logic and add console_record_isempty
> as available calls don't serve to know output has been read
> fully with readline's.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  common/console.c  | 15 ++++++++++++---
>  include/console.h | 14 ++++++++++++++
>  test/ut.c         |  9 ++++-----
>  3 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index 98c3ee6ca6..8a869b137e 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -818,6 +818,8 @@ int console_record_init(void)
>  	ret = membuff_new((struct membuff *)&gd->console_in,
>  			  CONFIG_CONSOLE_RECORD_IN_SIZE);
>  
> +	gd->flags |= GD_FLG_RECORD;
> +
>  	return ret;
>  }
>  
> @@ -836,11 +838,13 @@ int console_record_reset_enable(void)
>  	return 0;
>  }
>  
> -int console_record_readline(char *str, int maxlen)
> +bool console_record_overflow(void)
>  {
> -	if (gd->flags & GD_FLG_RECORD_OVF)
> -		return -ENOSPC;
> +	return gd->flags & GD_FLG_RECORD_OVF ? true : false;
> +}
>  
> +int console_record_readline(char *str, int maxlen)
> +{
>  	return membuff_readline((struct membuff *)&gd->console_out, str,
>  				maxlen, '\0');
>  }
> @@ -850,6 +854,11 @@ int console_record_avail(void)
>  	return membuff_avail((struct membuff *)&gd->console_out);
>  }
>  
> +bool console_record_isempty(void)
> +{
> +	return membuff_isempty((struct membuff *)&gd->console_out);
> +}
> +

We should also add a stub for console_record_isempty(), otherwise build
errors will creep in when when CONFIG_CONSOLE_RECORD is not set.

For example, on this series, we can see:

drivers/fastboot/fb_command.c: In function 'fastboot_multiresponse':
drivers/fastboot/fb_command.c:171:29: warning: implicit declaration of function 'console_record_isempty'; did you mean 'console_record_reset'? [-Wimplicit-function-declaration]
  171 |                         if (console_record_isempty()) {
      |                             ^~~~~~~~~~~~~~~~~~~~~~
      |                             console_record_reset


The following diff fixes it:

diff --git a/include/console.h b/include/console.h
index c053bc9ba82c..b5adae740650 100644
--- a/include/console.h
+++ b/include/console.h
@@ -145,6 +145,12 @@ static inline int console_in_puts(const char *str)
        return 0;
 }
 
+static inline bool console_record_isempty(void)
+{
+       /* Always empty */
+       return true;
+}
+

With that addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>  int console_in_puts(const char *str)
>  {
>  	return membuff_put((struct membuff *)&gd->console_in, str, strlen(str));
> diff --git a/include/console.h b/include/console.h
> index ceb733b5cb..c053bc9ba8 100644
> --- a/include/console.h
> +++ b/include/console.h
> @@ -64,6 +64,13 @@ void console_record_reset(void);
>   */
>  int console_record_reset_enable(void);
>  
> +/**
> + * console_record_overflow() - returns state of buffers overflow
> + *
> + * Return: true if the console buffer was overflowed
> + */
> +bool console_record_overflow(void);
> +
>  /**
>   * console_record_readline() - Read a line from the console output
>   *
> @@ -84,6 +91,13 @@ int console_record_readline(char *str, int maxlen);
>   */
>  int console_record_avail(void);
>  
> +/**
> + * console_record_isempty() - Returns if console output is empty
> + *
> + * Return: true if empty
> + */
> +bool console_record_isempty(void);
> +
>  /**
>   * console_in_puts() - Write a string to the console input buffer
>   *
> diff --git a/test/ut.c b/test/ut.c
> index 28da417686..d202644a15 100644
> --- a/test/ut.c
> +++ b/test/ut.c
> @@ -53,15 +53,14 @@ long ut_check_delta(ulong last)
>  
>  static int readline_check(struct unit_test_state *uts)
>  {
> -	int ret;
> -
> -	ret = console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> -	if (ret == -ENOSPC) {
> +	if (console_record_overflow()) {
>  		ut_fail(uts, __FILE__, __LINE__, __func__,
>  			"Console record buffer too small - increase CONFIG_CONSOLE_RECORD_OUT_SIZE");
> -		return ret;
> +		return -ENOSPC;
>  	}
>  
> +	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +
>  	return 0;
>  }
>  
> -- 
> 2.40.1
