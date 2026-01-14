Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4271BD37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C153B808AF;
	Wed, 14 Jan 2026 15:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dewMclO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576C182C7F; Wed, 14 Jan 2026 15:12:24 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1758063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso43913455e9.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399942; x=1769004742; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9GT+Uf9k65pGrNREZnQEfw1RGdbRg3yiXsJS15bcPjw=;
 b=dewMclO3i46dUyGKVyAuJAcsTWNpbc9ZZ9WhrS6X4J8QaCOL/COy/q9MI4B/0m6BZd
 33tRrbQrcOtoWyvWw5VR1k1lGkfbgx+PsJOMbXdGcvRSzGZ9lnpY/hev+fPKNL4QgOb9
 IQPDqOfhvBfTYwLvY0A2cpfymVXZjto8jQAcoQgdvqKpHLtDJ/v5Ure+Y/Hl2g//lGGy
 s5VQcjHNfm2wmQmRtbJZjCoW3J4tRzRZM3CySkeHacuxRLoqStGInhjDNHAeTbqzAFb5
 Zr9LQdyZozAeXI9V3kvMcH9eH/Z0aUPs4Cw41cgGsj/yU7zDSWggIT9qTTSHecQaOT+s
 qq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399942; x=1769004742;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9GT+Uf9k65pGrNREZnQEfw1RGdbRg3yiXsJS15bcPjw=;
 b=UVRBU/svhhwLtf+dD/rRrlIxLjL/+Lm13vf2RPmva7h5Wm114awiHTfQFaVbPhOzkP
 iVUqGSnsJMcpz3Va9TNmG2LHVWUKmYE5eU2e3dKD00zwg+Pikqs4e5LGfMRo2sxUMncM
 f0u2e/+TP9WpcMqQRKJ4iSVO+6YH0MmOWfEKmekprbhEH3TNzfeaPhBh1fSXPn2/3EaX
 qwfRmzPG6JQyWXqOkN3JMoohjUrM2YKl/8f3Hir4RH1fe9380gSl8Y35Noj0ThIeZizn
 /zsB28jqetIAhyfUE8EZiuBKd3xHme+REjuuNUSdWusH1jkzzmncsHONfRo3vihseP4H
 MpDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYIdZ4zTWUgSMop8NZFsUJYIQKgW8XoxMM7Cvych2gnbtcaM+ZTDTygcOSWb2WwV3JdwtCWws=@lists.denx.de
X-Gm-Message-State: AOJu0YznpbmJX/LByyVKNBHDs81Ou6cTFWLYif6DWKG7W8S+fxrZeh/q
 r9xD/gjIaBm9IyTdI3P4IRf8LLb1EYy5jCWSh9OmvdzdGCmJY7I1KClDfnv/Dx2SUCM=
X-Gm-Gg: AY/fxX6kvB11RYZc3mxLdHGMFPyOwdYicBz+jt3jESm3VsGb+cKRH6xo69YTO7cL22Q
 mZj4/R6Okw/UYGY0OyrGPE2veF/+Goj7fSEq9hvnV/pu/Jsss6fYQTG/hkBHA6SExY+oApg0stK
 TWTSbgljrRJMP8tK/l8ZFXKZvYHMVY1qwQtx/4d+NFPMr0+ROeK+WhB7g0XfurCT6GX4yQNVTo1
 aRUc6BeQ/Ed1I1RHsM6wIP0SrH3QXJhPDoqytosEk9P5DDUk6c1osQ2VPpLg82AfA8OttUFcVda
 xkYRblg3OOnDIOdgNXYS4Y4rStWxdraG1AL4b3UpQ0uiKU6fraDjxUZ7RtmPi7ah+NgSm+3S/gH
 GGqQH4blFswk/pEXrBwTAPct9yEw+HqBri5d9CqE+tVmjQmDkTCnJv1VFOycb2ffKEwbvuM5r5p
 1CmJ9T2tVbufF0z21lMYMny46DXCjTFReW4Crm6DBYKdroExVgzAI=
X-Received: by 2002:a05:600c:548c:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47ee32e0c52mr30302865e9.6.1768399941630; 
 Wed, 14 Jan 2026 06:12:21 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee97b2bebsm1217955e9.18.2026.01.14.06.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:12:19 -0800 (PST)
Message-ID: <299b5e24-ec98-4adc-aab0-495bb0cf144a@linaro.org>
Date: Wed, 14 Jan 2026 15:12:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qcom_defconfig: Disable
 CONFIG_EFI_PSCI_RESET_RUNTIME
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sajattack@postmarketos.org,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com, me@samcday.com,
 michal.simek@amd.com, sjg@chromium.org, j-humphreys@ti.com,
 paul.liu@linaro.org, raymondmaoca@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
 <20260114111624.2321852-3-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260114111624.2321852-3-aswin.murugan@oss.qualcomm.com>
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



On 14/01/2026 12:16, Aswin Murugan wrote:
> Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig to let the kernel
> manage reset modes and handle specialized reboot requests correctly.

Please disable this in kconfig instead. Could you validate that this
doesn't cause issues on an older platform like sdm845?

Kind regards,>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index a210f4dc5e6..0bd87b1f5a1 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_NR_DRAM_BANKS=24
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>  CONFIG_SYS_LOAD_ADDR=0xA0000000
> +CONFIG_EFI_PSCI_RESET_RUNTIME=n
>  CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
// Casey (she/her)

