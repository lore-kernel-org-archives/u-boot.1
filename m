Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A67C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 08:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BF080F57;
	Mon, 17 Feb 2025 09:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xo+n5/Oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D855380F5C; Mon, 17 Feb 2025 09:53:23 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A3D80F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dd9b3419cso2105628f8f.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739782401; x=1740387201; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3Ppo54XZ5StyQD4i2MT2NMxdbYFYh59qYcXP3iH2EE=;
 b=Xo+n5/OePQnzOWehDQnjmUChDb1jX9tM4ydwUGF0ayhpdvlBPZ9l1teY7oBLYE6xKz
 YeP9Hxk0/+T+k4XsdnRyhyN+h3VCZu5/ZiBvhIE7OWQFtyINHW6fCa6tYagNfsGHlRWE
 ifzg2Rk3ryxLC1yLX/TF0csq5TLme4jh+67adBYRdpc/ZPt4EMqPVGgWgEiOUFRIC67G
 6jzSu1ejwhs+wraBpSNN3lJTvpRnlKNbn10d281drF8qS4sVig+BHnQcLjHnhQ6cXNh8
 2rReoZqzsIrZagYE50XVTLuDILALjnAu2RBRzcykkNvH09BbsH/n0+icETMu9MhDiHDX
 b8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739782401; x=1740387201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3Ppo54XZ5StyQD4i2MT2NMxdbYFYh59qYcXP3iH2EE=;
 b=LpxBLo+LvoRvQgf/i59yPDY772cTgPSdV6tInH2LUMBdKeN3l+C4lGolZKEVYywtxw
 xvlwz88Waup1xe3Vjohkuusgox4DlcXNkJAHQgWyYHE/it3beIUJU3YRLeeXOM4pEsq9
 vDHnhNcFljKzfR2rbghAbTUvoIEuOfwWb3I44U4fp2eSK5M5AIL/TNBEAjNtj0CL2y8i
 MALUY/OYuPNZpJGckz/XUyxvxoO5cZiHmNmcc4cXOa71YZ8hiX0HrAW0HlXFyJF1ouRd
 giFPJw5aDC8pMIbWh4hDeLQMxxBGE7GDsNV6iLyfoPruKUWH4M0Gr6FGM8RjTspNShNt
 /2Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5i+3CesDE+82iIfgeb0Zaaxxa5pmvk10YtbTuaiubuq5HGDnjK+S4byp37nDNrN+mgRxA/rI=@lists.denx.de
X-Gm-Message-State: AOJu0YzKaRbMpAquNkWbTEegF+48Tip6zVMnVsq0MszzFQMffJGA5gjr
 oneU4itIFmi0csdaL49AhC9l4eppZoIC4AesYfmSPWKNfBCM+DDabVzjfJodRVM=
X-Gm-Gg: ASbGnctj2+anHY5EclebJ1b83f+cbo24sR5WmY25NJ+k8SoHeazpsO4o10A5ipQtXM0
 fewo2lNokWa3//kaQcFtLXcuEkBfK9TKKxJ6tgSB8kJfnYnJpwQgYIAHn81Wz/aumePHPLqcKRf
 VR9IvmnWxQ5TzK0v2QMwoDd2W7wwOYhWyTqcaQiYp/Ly7nQcY0VHI3SZ8VZDzHzsOBFoCBkR0tJ
 HSDCv+kNYyF2XOQZeuX5WpK22N06qL4QALmxp/Eh0Uwe+JXDlZWKFgjfMVWMBcxm1nqBjbbBSLz
 JK0D/oHd+D/pMW1xgF/QrK5W9U6Zifnstnw5dmz01rIKRuD7lzt8Bpx2CHHDYY6lECBkxX0=
X-Google-Smtp-Source: AGHT+IEbnmLsjXKssVJbBoTz9tM+1RgRZflr2AYiJ212fmjm0W1I1c/sZQR7KCrpA/W5nxOcNFECyw==
X-Received: by 2002:a5d:6d8c:0:b0:38f:38eb:fcfc with SMTP id
 ffacd0b85a97d-38f38ebfeacmr5973944f8f.7.1739782401185; 
 Mon, 17 Feb 2025 00:53:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18?
 ([2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d94acsm11821587f8f.75.2025.02.17.00.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:53:20 -0800 (PST)
Message-ID: <231641e1-3e83-4c5f-a836-8fc41718dbbc@linaro.org>
Date: Mon, 17 Feb 2025 09:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Gitlab: Add missing symlink for qemu_arm64_lwip boardenv
 file
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250216162903.211980-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250216162903.211980-1-trini@konsulko.com>
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

On 2/16/25 17:29, Tom Rini wrote:
> When adding the symlink for the conf file so qemu_arm64_lwip uses
> qemu_arm64 configuration information, the symlink for the boardenv file
> was missed in Gitlab (but not Azure). Add that in now.
> 
> Fixes: fd10d156db3f ("CI: add qemu_arm64_lwip to the test matrix")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I'll take this through my tree once reviewed, no need for a PR for just
> this.
> 
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  .gitlab-ci.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 920f61eaa099..46226eb2fc1e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -40,6 +40,7 @@ stages:
>      # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
>      # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
>      - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
> +    - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>      - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
>      - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
>      - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then

Sorry for the oversight.

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

-- 
Jerome
