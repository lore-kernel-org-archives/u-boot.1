Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D72E7E0D9
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93770805D7;
	Mon,  9 Feb 2026 20:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q3E35g/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07E48341A; Mon,  9 Feb 2026 20:16:38 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140B2802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso46203895e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770664595; x=1771269395; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtLORKm5r7e5Brv/m518YxKS1SA/Y0tquvlRoskEB5U=;
 b=q3E35g/mBBrUHtRVTOlmOtMSSgAoampJB0hrHXyGK0QGli8IJ3Ci2fVq3Z0Agq7GlC
 TPAIEGLSQ4uP6G5cpJYJ9+iEQ/ABMXV6X/x/YgReeR7N9xy3v16Hb9ZXJ2VDUbVfJRh8
 hmS4f0hvyhTbSVKB+iQsTu16HFccMwNmtkBla15qDLt/XX5iqvlKPjJeWPMC2HdmODeT
 vuvlbjP7awxZfqoAL6FZbSkzBZxIX9XwZukoTJcOYfQBC0ILe5yHvq2OcwSCqu8viKZn
 gUcy1NrycVHf6OWKVLfFNmY3j8VUKt09mVA6iskVF7jd8ldCvSePx0npkbipN51OJVym
 X9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770664595; x=1771269395;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dtLORKm5r7e5Brv/m518YxKS1SA/Y0tquvlRoskEB5U=;
 b=Gf0k1whC8o5haMlEVQCNL7SclwUM3F3HzAb+3MXGtHjBvMp8JsrnkDweVC9Ouvw34d
 nKHxc1dA//zF3leltv0b8H294hNIZITEuqw82zaeuv6vmoKq+LEIS4n/o7C+a/Ga7Yse
 B4+uaT7TsVDS2qV4IZ3ch/x0TGjri+c453PuMrzhnrPfl6yDJzgbbhh1pybc0j7OFAUY
 GdRX8gAhr0DKRfO2zWBs8ZQVrhnwPT1nNkqLetFEhOqNXvl4pzVeFOMwERbgd6T3RPpC
 ym8t/Co49BbNsBDwae9M7rAnScLHsoESTLeHJZJAtUyB5f4kdv8UiriwSpZWyySrjK03
 PGqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSxL+2G6JgXT90xXYsIkrzTi7c2fAImi7518ik6NYGpo0+pjT9M7EDgxhcC5gCTwtQRUPVZGs=@lists.denx.de
X-Gm-Message-State: AOJu0YwiiKZksIjrlO2OWTv890JexViDP9VsUmyBWlxVv3cpujAkWgiA
 tXWzDYGU39ip0TrJLjpXdYxOEhREJMFAODUlvUG0sdkjA+wX2g55dk2IzBr6+9a5vKo=
X-Gm-Gg: AZuq6aJ2bdIZuIVfJxSvJbLPundG5FDIYxP5v+N/jXuwZDw/bv8GesFMI58SyVu0bYa
 1GAZHQj2N5Q/bp6Q5BLUcmwDYZXudvrYENN04/Ky7i7S1LyuyvArXEB41PrrvmCZ6hQHrAyw6An
 rIZ0KmsiGhQjXuEmjDjNQ48j8s5sPywITlYVNaNIFaTPrW0OuCt+XCdm2Ftd65xWBqcQJtHKNwA
 rM3wk50cNAY6TIlaetdx8soSbHxgE7MBFIHVU7O9pUXiPCpeS5lu+KSA3qFgJJX1CCaIfcsXkXc
 SJAK9Z/Y379sywFFMUtYmen0CjkOjf479+/uoMXTUYggKyLvVX/iiC++szl0Y6HEI5es3S6bLq1
 XtdE9w8OF2yzqyKwgrg9FajB+OqM1IDLWwtmm6edIK4F81S6aRMk6Aa0FkdlIIQqDHz3KaMFskP
 7AJNU7p3fJD7NmujVEF0iFtRIsMc3EvZI70qJgHAiwQKi0DXxdQA==
X-Received: by 2002:a05:600c:1d02:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4834d820e1amr7834895e9.14.1770664595422; 
 Mon, 09 Feb 2026 11:16:35 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bcdfcsm30072900f8f.10.2026.02.09.11.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:16:34 -0800 (PST)
Message-ID: <73b5c25d-1fc0-449d-97bd-fc76578cdf6d@linaro.org>
Date: Mon, 9 Feb 2026 20:16:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] board: qualcomm: Remove SCSI scan from default
 preboot environment
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On 26/01/2026 16:59, Balaji Selvanathan wrote:
> Remove "scsi scan" from the preboot command sequence in the default
> Qualcomm board environment. The SCSI scan command fails on eMMC-based
> boot configurations, causing unnecessary boot delays and potential
> error messages during the preboot phase.

I'm fine with this change in principle, since we already do the
scsi_scan() in qcom_configure_capsule_updates(). However currently this
only happens on Qualcomm boards if EFI_HAVE_CAPSULE_UPDATE is enabled.

Could you move the scsi_scan() call from there to board_late_init()? It
would be even better to introduce a config option for this and do it in
board_r.c similarly to mmc init (perhaps rename initr_mmc to
initr_storage), maybe something for the todo list?

> 
> This change improves boot reliability on platforms using eMMC storage
> as the primary boot device.
It isn't clear from the commit message here but do I understand
correctly that you're booting on a board that can either have eMMC or
UFS storage, and that the UFS controller is enabled in DT despite the
hardware not being present?

I would propose (in addition to the above) that you resolve this with a
runtime DT fixup, I believe SMEM (or maybe the sbl1 shared data
structure?) contain a property describing what storage device we're
booting from, so the other one can be disabled.

Kind regards,

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  board/qualcomm/default.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> index dbf6f4e7260..7cfa8e0ce2a 100644
> --- a/board/qualcomm/default.env
> +++ b/board/qualcomm/default.env
> @@ -1,7 +1,7 @@
>  stdin=serial,button-kbd
>  stdout=serial,vidconsole
>  stderr=serial,vidconsole
> -preboot=scsi scan; usb start
> +preboot=usb start
>  fastboot=fastboot -l $fastboot_addr_r usb 0
>  do_boot=bootefi bootmgr
>  bootmenu_0=Boot first available device=run do_boot

-- 
// Casey (she/her)

