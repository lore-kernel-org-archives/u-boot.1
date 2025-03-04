Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C735C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24BB814B6;
	Tue,  4 Mar 2025 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNlTHGSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E19814B6; Tue,  4 Mar 2025 14:51:49 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639628144A
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f47ed1f40dso43322677b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096306; x=1741701106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OJdeTryoKFkv2MPisyuN8hU0KCI8IoMgXAbdqTGSOI=;
 b=NNlTHGSFpggEH0qOQzLZb6dYZ3Z3vBkbiVFRKXQ2q1X40niMo/Y4a0gR/LAPmDuGcT
 9cutPA8Vq3tAIRH26stcXDv3TtAK2RdAZZIKIDQlSqLr4/lOhMw7FIEhYS+u1yq1aAPR
 /0NsEKjEReQz2UxyFsuHY/iK9+T6y75SBJRsaB07kqFc5rY1yf14AGqh5PwHla8yeBQe
 okGIEvjL5I2nCnl+qOYmkSLY1qBXjjVFPLO8DgN19zPzMgPjL74MAEbP5h6GDnfld0dI
 YeZNVqxP2wm5Ld12aq7t8BaaPqkLyyFHAXjKfkqEuhccEZbdZooQVMZF/4LeD0MEb4L9
 5G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096306; x=1741701106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OJdeTryoKFkv2MPisyuN8hU0KCI8IoMgXAbdqTGSOI=;
 b=Msqyi3/1FyKFhmzM6LcV/FvZHhnnzef1zbiS/cf80uwXUHjrQw1aC2HcXKDhXdJaal
 Xfs+f9r97Me6JRzm3hzGBn5OQiW1wDPj1w7OctAUhRS87e4DJ0s6bc+7S6vSE0giiLsV
 H6pz5CbJwB89/9uvK3UZ7xGaPLsFdNsSOaJxcoDEMUjYbkIjS/L2XbUTYCLi73woUOfO
 Wn1C0MQd/Wv7D944K962yKAk1dWmDuIEaSaFb9M1vQWpShpIAGP1J1VcFqa6XAEQofwL
 bvYVqB0bxd7k5W0oBlCEiiFzR8rtA51dHPcfK9wk1f6Xp0+uJ1S+fWoKHAN3PJb1XyLu
 WsZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsGXFYgG/B+BzjfpT4wTcqViA2OkA1VSTHXMw6dyFFSlRWzbqjvo4XI/aqAzR3Muzk4u88lco=@lists.denx.de
X-Gm-Message-State: AOJu0YxTHghe8tAUtkCkK5vrMsePKrHrmHqPz1ib3euotrXM8AnBlv7J
 LVsNM3vzV1AHrfmoHnLHLc65QoiR6+S1FDe17no8okx5CNT/9z0Xic0vAhiov5r8W0Ma/oOJ3SA
 gPXQ6kuUmOiKXC4Z0CEd3TXbEsOv9popjUzX5YA==
X-Gm-Gg: ASbGncuhhdeK/lazcDC2RWsiPsgbP5atN6N1eEk9x3cBL/TI2yAaGzIZj+Jdzd31MN5
 cv+/1QBvI5liJoCg8mDT+Pkx2ff8hSNTavGa1puMCk59gyZaK31+ltFHzgIrsOwJprDcIicdqzL
 jp38b8INnjI3hRzN1CbrckSs+GzrS3
X-Google-Smtp-Source: AGHT+IHUTe3AvWgUX3PsgVzv/SRfAMDqHpTOCBsfQQEBN7k/nNCHRqyJauXdXbotsx73/rsXZ8DedzcUoEuPqXXO9Qs=
X-Received: by 2002:a05:690c:4801:b0:6fb:9b8c:4b4f with SMTP id
 00721157ae682-6fd4a1516aemr235156157b3.31.1741096306150; Tue, 04 Mar 2025
 05:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250302142121.150480-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Mar 2025 13:51:09 +0000
X-Gm-Features: AQ5f1Jom3Xlmc33bbyn8Rjf7K4bgE78rzEin6uzT24bOU1r1NdeHQzMNAdaiMKs
Message-ID: <CAC_iWj+Yapwk0N+Lef3v617yOcc+3iKm4sfuCsQmVf3br2KzXw@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: use type jmp_buf instead of struct jmp_buf_data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
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

On Sun, 2 Mar 2025 at 14:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Instead of using the implementation specific struct jmp_buf_data use the
> standard compliant type jmp_buf when switching exception levels.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  arch/arm/cpu/armv7/exception_level.c | 6 +++---
>  arch/arm/cpu/armv8/exception_level.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/cpu/armv7/exception_level.c b/arch/arm/cpu/armv7/exception_level.c
> index c63b0e13666..a55c158ce51 100644
> --- a/arch/arm/cpu/armv7/exception_level.c
> +++ b/arch/arm/cpu/armv7/exception_level.c
> @@ -24,7 +24,7 @@
>   *
>   * @non_secure_jmp:    jump buffer for restoring stack and registers
>   */
> -static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
> +static void entry_non_secure(jmp_buf non_secure_jmp)
>  {
>         dcache_enable();
>         debug("Reached non-secure mode\n");
> @@ -42,10 +42,10 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
>  void switch_to_non_secure_mode(void)
>  {
>         static bool is_nonsec;
> -       struct jmp_buf_data non_secure_jmp;
> +       jmp_buf non_secure_jmp;
>
>         if (armv7_boot_nonsec() && !is_nonsec) {
> -               if (setjmp(&non_secure_jmp))
> +               if (setjmp(non_secure_jmp))
>                         return;
>                 dcache_disable();       /* flush cache before switch to HYP */
>                 armv7_init_nonsec();
> diff --git a/arch/arm/cpu/armv8/exception_level.c b/arch/arm/cpu/armv8/exception_level.c
> index 58e816007f0..746737861e7 100644
> --- a/arch/arm/cpu/armv8/exception_level.c
> +++ b/arch/arm/cpu/armv8/exception_level.c
> @@ -23,7 +23,7 @@
>   *
>   * @non_secure_jmp:    jump buffer for restoring stack and registers
>   */
> -static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
> +static void entry_non_secure(jmp_buf non_secure_jmp)
>  {
>         dcache_enable();
>         debug("Reached non-secure mode\n");
> @@ -42,11 +42,11 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
>   */
>  void switch_to_non_secure_mode(void)
>  {
> -       struct jmp_buf_data non_secure_jmp;
> +       jmp_buf non_secure_jmp;
>
>         /* On AArch64 we need to make sure we call our payload in < EL3 */
>         if (current_el() == 3) {
> -               if (setjmp(&non_secure_jmp))
> +               if (setjmp(non_secure_jmp))
>                         return;
>                 dcache_disable();       /* flush cache before switch to EL2 */
>
> --
> 2.48.1
>
