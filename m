Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B45C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 13:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9C583F70;
	Mon,  4 Aug 2025 15:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sfCsSYVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D547883F72; Mon,  4 Aug 2025 15:46:48 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA6983F56
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 15:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so7797455e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315206; x=1754920006; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XkcL2iDYXjiPwX7CEmZUqOYj/vKKn3BrHxMg72NJhEs=;
 b=sfCsSYVeOSIPHp4Qoi970pHzzovVnSBYxew6+MYks6VkOuVLtw+mwBAa8tbgPVtuh8
 Z8PAAlPC79btMFz0fFa/1joxlVUf58SXVxahPPXdKgzvfSmMR4ZmA02HxJqNLbQNmWjP
 8EgaapG/s/PTjI6BFPtLtOiSXe0rtg/7hTsD+I/43+KOIPIXjuwVKbBy+HliNoyP0T/7
 eNMBdu1O/ivGUGmDP0lriyrFPVItK7Xdetu2pS4Dk0MLR1PyuSsRt/wpxP7sYFUBEIy5
 uCFkZ2bnIYEzBOIdKw+6uJKQgw2/epFshAE8Zit5oO9cS76f4wTzKA2hfJzfJQ6FGMiw
 /Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315206; x=1754920006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XkcL2iDYXjiPwX7CEmZUqOYj/vKKn3BrHxMg72NJhEs=;
 b=Vx7SGv9kxiiEkSx7YoXJmmHu1KCngjq58yonmhjh59nHujoZC5mVhWC0Z/U41dgcCN
 zSVGFTXWoX5UPc9xH7eDDo1p8oCg06czo1/FNq4AkBLfD4xdpvBSP3oUYNHsEvWEvDUU
 vJkJTUSBeT3/XeJPSRSPGzvyBI6H05DEg4HuOtBVRmGCdjfGfVjNLx3Qp/0HDSdnpB8P
 F6/yy4ZyiJO20XlnKBuMcBRgCn+zvTuWlo4o1TmigchBECfTZ2xJaFBize2CDTkjWYSE
 /SRNakQzfJfgC9xKoXPWaIMSRPpUlOOfqRmAT8DBrIKGWEXQDzb+GfaR3PBTfWHJ5p6n
 kgww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhYTuSXje36Eeatsfc2l73K6v3ohY8VSfYBpuR45C0J0bb0a4lKMPbGzz2nVvvWW9qMAveHZg=@lists.denx.de
X-Gm-Message-State: AOJu0YzDOP4henGRlCUbuDJhc6JIHNlp8SMXNt3KadaR8ckK+nndMvDV
 6lru+mC973iB5mgJXfFxScLJAv8jMc+pt5vV9oq59kC6CJVy+Qq3cxgmKb/GBxfu5fg=
X-Gm-Gg: ASbGncsDci71OKMz1ohxHbS04n9mMHDGDBNyT+3D6wipM4i/SQ0oRf2DC2SZXl20OI9
 F6kvKY04Z82ei4InVyMSr52996uMdVNAwSsyOYsuwKZ7Lcf8djmBJFOoaz3sXc5QrsSRw6HhsBy
 dgM6z7MpvuUVSWE26jWEGkzN/hwaUTsTTRR3CauRuk4As3Ip+pk8KlZld5GBRc57V7pI8SZ6zMK
 Q/N196H57WrAge2kbfaWEts5lqIeSeqk632qTmsMVOxyp7Yht+WCQmhLaOi+8FT9DoUYUZ4shBj
 1Sb9KZusCW3GnjIptAqyEpoRHxO2BXlljgZANqhW6vzphB1FYCqWiZUtydaqm/ndgqKgPyz1i+Z
 TPnv0J0AG8nzoUmy/Qy4oXqaz9OOhahpamrli0dst5O7flFoCXtNcdNa/0C06xwVrXu0=
X-Google-Smtp-Source: AGHT+IGqah9GJoiGgz0X3PbiLgN5W4dIKATk1JknySVRfWbtZ9YRr7uqITBXtc5S5mmYW+D9WCmdcA==
X-Received: by 2002:a05:600c:3b03:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-458c0948d16mr49358275e9.12.1754315206190; 
 Mon, 04 Aug 2025 06:46:46 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3de8e.dip0.t-ipconnect.de.
 [79.195.222.142]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm21954635e9.13.2025.08.04.06.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 06:46:45 -0700 (PDT)
Message-ID: <cadf1502-9d85-4fdd-a70a-e8318ca1282d@linaro.org>
Date: Mon, 4 Aug 2025 15:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] configs: Add google-pixel3 fragment config for
 Pixel 3 / 3 XL
To: David Heidelberg <david@ixit.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250802001359.2122103-1-david@ixit.cz>
 <20250802001359.2122103-2-david@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250802001359.2122103-2-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/2/25 02:13, David Heidelberg wrote:
> Introduce a fragment config for the Pixel 3 and Pixel 3 XL.
> 
> On these devices, U-Boot must be chainloaded via Fastboot. However, due to

s/must be/is/g (be descriptive rather than prescriptive).

> a Fastboot bug, U-Boot won’t start unless a specific condition is met.

additional requirements added by google, the image header must have a 
specific value for the text offset.>
> To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,

this is solved by setting CONFIG_TEXT_OFFSET in U-Boot.

Kind regards,
// Casey (she/they)

> which allows Fastboot to successfully launch U-Boot.
> 
> Instead of:
> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
> do
> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig google-pixel3.config qcom-phone.config
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   board/qualcomm/google-pixel3.config | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 board/qualcomm/google-pixel3.config
> 
> diff --git a/board/qualcomm/google-pixel3.config b/board/qualcomm/google-pixel3.config
> new file mode 100644
> index 00000000000..2dc71c65d23
> --- /dev/null
> +++ b/board/qualcomm/google-pixel3.config
> @@ -0,0 +1,3 @@
> +# Pixel 3 (blueline) and Pixel 3 XL (crosshatch) will fail to
> +# chainload u-boot on the Q or R bootloader if TEXT_BASE offset is missing.
> +CONFIG_TEXT_BASE=0x80080000

