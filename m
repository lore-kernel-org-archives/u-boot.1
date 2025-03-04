Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDFCC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B897281782;
	Tue,  4 Mar 2025 14:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mv3RC6Pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B388281895; Tue,  4 Mar 2025 14:49:33 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D18181668
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so5015805e9.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096171; x=1741700971; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lf8P55RH7lWuQgtvcWzExj4r4jCK+tOtBFbJ57gcJOo=;
 b=mv3RC6PzNxQRyTQ1RbtuB4TaLcoH25jqHrSukHKzZdSOVxfg37F4sziwwly6Gt9s3R
 Ys2YqYM/IBCpmnlqCkCR2/XeHLKOe/93t0uamSbkIUhTcd86Si5rxSjfjUkDb216g7QB
 Xrnrcc1hSRnEj57vRuIpg14yaz5RDgQ0YBK+VUeIpxNAnAoUGWMI+PmgPElsN0GYoHl+
 CMi/NvLB0XQDbeTXsuUQYlrXR+7BeWwwS00cINS84fyf+B3jEUSzQ+56uJm+1lO+oXJF
 uMX2HDWlfrkJqjl2KYekskMYucZB5KwWLtVvkEEvq6LgVE9IdceR8OBD4WnbSUzNGsj1
 mC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096171; x=1741700971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lf8P55RH7lWuQgtvcWzExj4r4jCK+tOtBFbJ57gcJOo=;
 b=MpMr0NibMF8MunJ4xv1wL+UdaG/82UKM9nvOeYwHSKkIRV6atLKxHt2srHQEoY1sUS
 0aZ2havfkqMx4qadPmc4PSjmID9htxA9J/BTA0NEKRTZi2DOO7RQzaRE1hoVl9IyffQU
 Rv89SHpgyB+240uWdbogYG1jWcN00oLnm0bGXy3wamvEuS5D2gg7k4q3e/ydAfNXjfvt
 NmkmAAKeWz56W1xySbl+lndIKpJHvvMdzLEv+xkUXADdl+h1b3aLT/xllc9N+3UnOS/I
 t1WM8dRUTaFMaROaaK1ybLOylogCCmkKpoQTymZSpMoGUuLpYOhnkatCnB/dhNjj7qQ4
 GvQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFL3QG3jCvHcpfV32fh+Yc1HUL0bt2MtkZ7STHvmc/C0C5Z+/uK4Z9D84c0gGpzbdQZFFX5t0=@lists.denx.de
X-Gm-Message-State: AOJu0YzMfTGteIj9dKd/5a2PfV8B2fhyq/7PIIX3brkUSzNYFcjlS/Af
 5f8YfNpW/1P+ZTh7uPwZ7mBH1hRMpccrHtYwsREc+tE+7uLo5/vJM9B2uEno0Ak=
X-Gm-Gg: ASbGncs36SkdAuo5Ur2SAWckhuRxstL5c3iqagNIT5p1zh0ZEftLzVt3eHUeyppCwHi
 98BncDopjReeesu26xRL9nIqm9d/9rgdJ1elgeL66QoxX87puG+L3hpO5fkiOtZen031PM4yWOQ
 D+uIhA6S0PjSHNqpE78Tn/PklNsXCrKbxkocxRkvQ1jMvCbVdR0ljcZJt68hbPboqTcN8TsPBGL
 QyaLtddMgLZo8/A4KF8LT++g8/J2PB+EX2fFlzYFS9fNIcSgpkL6oE3TtX5eFsrP6OUOBNxeWmL
 cnoyjNNsxhh2TJfr7hrCJNiPsgxQ7/2VQDW2EY7/jfb9/wA0DvoN7FU=
X-Google-Smtp-Source: AGHT+IHWPAMrkn1vps6OBdVU9XAyL+p6K24QT91VZs5V0fPpO3gVUX3uikdXhMbSPtrTqu8NRm1wfA==
X-Received: by 2002:a05:600c:3c86:b0:439:8346:506b with SMTP id
 5b1f17b1804b1-43ba675a810mr131860355e9.19.1741096171019; 
 Tue, 04 Mar 2025 05:49:31 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc2828afesm70265095e9.9.2025.03.04.05.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:49:30 -0800 (PST)
Message-ID: <8c1ea34e-d327-4919-9be9-0f9bc658c51f@linaro.org>
Date: Tue, 4 Mar 2025 14:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm: use type jmp_buf instead of struct jmp_buf_data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Janne Grunau <j@jannau.net>,
 Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-6-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250302142121.150480-6-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 3/2/25 15:21, Heinrich Schuchardt wrote:
> Instead of using the implementation specific struct jmp_buf_data use the
> standard compliant type jmp_buf when switching exception levels.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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
>   * @non_secure_jmp:	jump buffer for restoring stack and registers
>   */
> -static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
> +static void entry_non_secure(jmp_buf non_secure_jmp)
>  {
>  	dcache_enable();
>  	debug("Reached non-secure mode\n");
> @@ -42,10 +42,10 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
>  void switch_to_non_secure_mode(void)
>  {
>  	static bool is_nonsec;
> -	struct jmp_buf_data non_secure_jmp;
> +	jmp_buf non_secure_jmp;
>  
>  	if (armv7_boot_nonsec() && !is_nonsec) {
> -		if (setjmp(&non_secure_jmp))
> +		if (setjmp(non_secure_jmp))
>  			return;
>  		dcache_disable();	/* flush cache before switch to HYP */
>  		armv7_init_nonsec();
> diff --git a/arch/arm/cpu/armv8/exception_level.c b/arch/arm/cpu/armv8/exception_level.c
> index 58e816007f0..746737861e7 100644
> --- a/arch/arm/cpu/armv8/exception_level.c
> +++ b/arch/arm/cpu/armv8/exception_level.c
> @@ -23,7 +23,7 @@
>   *
>   * @non_secure_jmp:	jump buffer for restoring stack and registers
>   */
> -static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
> +static void entry_non_secure(jmp_buf non_secure_jmp)
>  {
>  	dcache_enable();
>  	debug("Reached non-secure mode\n");
> @@ -42,11 +42,11 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
>   */
>  void switch_to_non_secure_mode(void)
>  {
> -	struct jmp_buf_data non_secure_jmp;
> +	jmp_buf non_secure_jmp;
>  
>  	/* On AArch64 we need to make sure we call our payload in < EL3 */
>  	if (current_el() == 3) {
> -		if (setjmp(&non_secure_jmp))
> +		if (setjmp(non_secure_jmp))
>  			return;
>  		dcache_disable();	/* flush cache before switch to EL2 */
>  

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome
