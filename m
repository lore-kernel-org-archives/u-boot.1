Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FE0C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788A0805C3;
	Tue,  4 Mar 2025 14:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WLXM3Wmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4656B8004F; Tue,  4 Mar 2025 14:48:38 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D018004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso14486365e9.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096115; x=1741700915; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQ0+WP2ZPbjdmHlH/cKbV2jtq5v323xcbhDw1dEg9KE=;
 b=WLXM3Wmzkvd9idzy0Pxw3JKV1i/FqOkVKUlLDjp2Bbaf05U8GCpzGByav1Vw1Av6Wb
 Q/n1rR/MdItOXAvcKW0Ey3QSz3QcYymUq79EFRlzQQ/CMPh4nDr9bRZxZ8Zc/ErsC0+R
 FuC9U5Vp3xw0hXZ9LipSpwvyYBIBbmPMJK3MsggGFzuwo3Pt7R0wPCsY1SXs8RltsJYf
 hTJIQN8hQnB6PPLawiqkfgpsKxfKo5mpuGVcGeUCZVlYOUIX9ERWZTATIMweLkgmorBi
 Sg8UZ7zhTjPU8SR4EZ//lVsePDUUO70vQTQDTKlYXLQygpqlcGNjyVCsA52YtutYnVVc
 23/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096115; x=1741700915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ0+WP2ZPbjdmHlH/cKbV2jtq5v323xcbhDw1dEg9KE=;
 b=FQn5Lv0DUfh0dTr9Abag54nscEFRpfScveMORoOrdtMOoxjYBOmyx09i1zgppFdgLl
 ql3UgvyvpyUZcWlPXOrSncTzCieW3j2jQHj7O1yMfAvsho/M/+e+siG+oG59mf/szbu+
 p06M/+eXIFtKZmrrqEZQBrxENnXuTIu4sbBMVbk53If2V+rrbx1l1ygemEntVjhrxpdh
 TOLQguzHTCk70bOSCUqXDuvebd18MMuny/y59MlZs8HCnOWUe1ASOxbPOEm6jA/97iy6
 biSgcDscC5aVCzvtozyhD/GmQKLv3gw/MN+NXPPbF6nJb51z7SYCzPn5h9alHyZkNRis
 4EEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeQIQff5COvHIUpmFSbaWQnO1bR5DJBr1J3Ldy/GSZtVoiy3Pe6JGjBDREtnVmYKKzq7tpaqw=@lists.denx.de
X-Gm-Message-State: AOJu0YxVPuFWmrQSArowOLFkv9b16mH9/cOxRZ4Afl1EfXULbH5CRMHm
 TpM5bgOMTsekW1SF8CEM7IalwRcI93b49XSOGOmT8R8MtqcOhwjqVfobEjyCdgw=
X-Gm-Gg: ASbGncvf0mVsc/X4w26EWapVfKEzhXsd/XtU8aYUiyAic+hVBsRQs1GISs/Wxg0SPFX
 9qjbQysMN3qCXDHgynGywIK3Mm9fBcEAnTij/CNiiqySGTZgkWwW22NzksgM0OjClcQ4jeTQZhe
 xUzLvaFwf4I1800jxa70NTQsrN4W0hmdF04DhmD8bTroDvllPwdDbntceQK2Y6pt4NA2t2o6DZY
 i2rBGPoGT6iFiDt/RCG0pg34sl7aj1Xi1LVhSdPrJWNocOUCFUeCHi1J4Somy77CnDhLx5I+bba
 dDOhGpNBvxFOw/QavmiUMrY1F1nd+62+dcZQJEF9QpY8tkFwDdt55e4=
X-Google-Smtp-Source: AGHT+IEiUhVXXi1T5BiVnL8D9ZyGIw0LNcNiWJindG88/f3sK4BNTsG8SsfpFP1LjBdLckSYQCTkZw==
X-Received: by 2002:a05:600c:154c:b0:43b:ce86:b320 with SMTP id
 5b1f17b1804b1-43bce86b426mr10380215e9.26.1741096115442; 
 Tue, 04 Mar 2025 05:48:35 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc13b23asm12837875e9.1.2025.03.04.05.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:48:35 -0800 (PST)
Message-ID: <aba811f0-5af3-430d-a21d-89c4e1ac36a1@linaro.org>
Date: Tue, 4 Mar 2025 14:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sandbox: remove linux/types.h dependency in setjmp.h
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
 <20250302142121.150480-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250302142121.150480-2-heinrich.schuchardt@canonical.com>
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
> ulong is defined in linux/types.h use unsigned long instead.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/sandbox/include/asm/setjmp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/include/asm/setjmp.h b/arch/sandbox/include/asm/setjmp.h
> index 001c7ea322d..47dc8938cd6 100644
> --- a/arch/sandbox/include/asm/setjmp.h
> +++ b/arch/sandbox/include/asm/setjmp.h
> @@ -19,7 +19,7 @@ struct jmp_buf_data {
>  	 * We don't need to worry about 16-byte alignment, since this does not
>  	 * run on Windows.
>  	 */
> -	ulong data[128];
> +	unsigned long data[128];
>  };
>  
>  typedef struct jmp_buf_data jmp_buf[1];

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome
