Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475AC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8AE088099;
	Wed, 20 Mar 2024 06:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CcrD/oGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACAD880A3; Wed, 20 Mar 2024 06:28:46 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8D587F78
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41468993f93so7527195e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912523; x=1711517323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IDlOrCVKQ+OXTfLpu6C8wdEc8MeG0rYfIu4Amm4kBmk=;
 b=CcrD/oGS4kd3dJCebq+8Cpq3pMWbERpCIyxRnI5QeOib5Lzskaz0aMtiGci2846WqD
 hXubCLA2ks6HOVI61s0NqPZgLmbI09zm14c/ZlusWlDTRqQb/egrPacVP8NM2J0gvBJQ
 UyTFDCB6EQdwk70Jc/pN14OllPG61rQ2wN86R3aOR3YahDrJZXa+BwifjzF5nB0YYhbn
 UfQAkAb2jup9zZhdAFNVJVwlGkf99VjjNPjAxsdxiRLkPqV2OhSbMabBHaGX9GZzVMAi
 yDpCsch5VZHfxb23kj/gK+ooRjsP+uNi7jUjAAPQe9CcIbssJl3nHwRiTK0RvjwJ9w5K
 Cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912523; x=1711517323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDlOrCVKQ+OXTfLpu6C8wdEc8MeG0rYfIu4Amm4kBmk=;
 b=hW5oHMDbfz8OMlLSY3MOOH34/YLbdQ6PdAvnahEmEbWjYB8Ivc+73i+uDMSDk2ZTwp
 Jpg9eDpnZGql072Ou/UNL6zeSL3RlKgsMfp0ISkEcUvXvIEmZyb4fBlz9fJ3mUHNgR1W
 luJokPPg0nIVn5q03tLGJXlaV0XxOHHACGt3lfl5RAAZFqy3Iy/0ABJm354r33R3tc/V
 cUAA3setiF2M2nBHS/2evFbGi0D733hlzPtVfhMRB2BUR0Zl2uo7Lg/3Dm83gGfUpMhE
 lpKJqgdwiqBr0l5LZH2Fu9HuWxV8+ls8GreC35S5B8ObW4qJDrFkXqnz/+TvaPGbbJT5
 pA/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1OMbZ7sy9PIFdiWTgW/kJ4PsgiudEMkHNOss/c7gmwLvh0CevR6+koAQ7fTQkD2nKAZi2aZTbF7VejXIdXUq716NUsg==
X-Gm-Message-State: AOJu0YyQFvldeFabIT5O3FyLWn5jgVD48hoNsbwMecQ4PfOzL2Ob5kP/
 2iX3fCLa7d4jRkpPSDV9rZn4dLxxGnF8QhIaLeU60jh2wlWKS6NVSEO9oPpM2YI=
X-Google-Smtp-Source: AGHT+IF+ctcB7UXGdCvuK0N+Be6HmNKhq4wEpi1PA5nc2ZGKWgz4cfX+PFWGZjALPU6lgNdrX8XDiw==
X-Received: by 2002:a05:6000:544:b0:33e:bf0f:8156 with SMTP id
 b4-20020a056000054400b0033ebf0f8156mr2922372wrf.38.1710912521517; 
 Tue, 19 Mar 2024 22:28:41 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0033e79eca6dfsm13781217wrm.50.2024.03.19.22.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 22:28:41 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:28:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
Message-ID: <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
References: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
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

On Tue, Mar 19, 2024 at 03:53:24PM +0100, Neil Armstrong wrote:
> While meson_sm_read_efuse() doesn't overflow, the string is not
> zero terminated and env_set() will buffer overflow and add random
> characters to environment.
> 

In the Linux kernel we would give this a CVE because it's information
disclosure bug...

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  board/amlogic/jethub-j80/jethub-j80.c | 6 ++++--
>  board/amlogic/p200/p200.c             | 3 ++-
>  board/amlogic/p201/p201.c             | 3 ++-
>  board/amlogic/p212/p212.c             | 3 ++-
>  board/amlogic/q200/q200.c             | 3 ++-
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
> index 185880de13..d10492cc46 100644
> --- a/board/amlogic/jethub-j80/jethub-j80.c
> +++ b/board/amlogic/jethub-j80/jethub-j80.c
> @@ -28,8 +28,8 @@
>  int misc_init_r(void)
>  {
>  	u8 mac_addr[EFUSE_MAC_SIZE];
           ^^^^^^^^^^^^^^^^^^^^^^^^

This one is also a problem.  You can't pass non-terminated strings to
eth_env_set_enetaddr().  We call strlen() on it in either hsearch_r() or
env_get_from_linear().

All the other functions had a mac_addr[] issue as well.

Btw, this kind of bug is a good candidate for a static checker warning.
I can create a Smatch check for this.  It would probably be easier in
Coccinelle even, but I'm the Smatch maintainer.

regards,
dan carpenter


> -	char serial[EFUSE_SN_SIZE];
> -	char usid[EFUSE_USID_SIZE];
> +	char serial[EFUSE_SN_SIZE + 1];
> +	char usid[EFUSE_USID_SIZE + 1];
>  	ssize_t len;
>  	unsigned int adcval;
>  	int ret;
> @@ -46,6 +46,7 @@ int misc_init_r(void)
>  	if (!env_get("serial")) {
>  		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>  					  EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>  		if (len == EFUSE_SN_SIZE)
>  			env_set("serial", serial);

