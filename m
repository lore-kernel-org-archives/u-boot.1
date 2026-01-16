Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80827C982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F791839E8;
	Fri, 16 Jan 2026 19:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X/6ic52Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C64682BF2; Fri, 16 Jan 2026 19:03:18 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ED3836AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b872de50c91so362187166b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586596; x=1769191396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WDHQTJd1Oc55JMnkSQtvBVBe6YpYNAWLiuI0PGs4MPw=;
 b=X/6ic52Y54shdgqtPImgTQrNNEyyO3qVICeOAGHU6vnQ+UIGlnZ/DX7GyC052ky1DT
 WKHNvqGOxV05Ms4Nn09FBmm5KpRy6jVGyXiO8tWrkLbgc95yfh1LB7lcC6TnaRBZ9tBU
 ayh7y0FMXLnclDvoOqqfs9vRYn0ZqHARm2RtjvC/m0dpPOCRxPfnDiVTAYv2xu8wJTTS
 yLYB6vL0nIGt1/Kiy2BPFftWuVi2ihjWaubj5tuv7WaCmbGHEYpgkBcZ62utvyzTbRPB
 mx+7cAUqB3ZvppBMs07PRDQUx62FEd3YdqlBdbe2wHqR0XJz0w6AJtDGdqFe4B3g1sjq
 edgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586596; x=1769191396;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WDHQTJd1Oc55JMnkSQtvBVBe6YpYNAWLiuI0PGs4MPw=;
 b=vB1pMAQ9w2T3jyv0u72QQnH5ypVNw8iN/GDadmJQX6TqWmCAF4Yg+YyGtg37r9M3mb
 XqfupvQnOrhtnTDZCcS6rq68ghKikrcMX5fvpNX3P3lHIV2u+bcYtu43mZv4SdiOuayd
 apoM4RxbaioOBubOzaaDDlu5cuU9qmzsojjxYtmyKYvoLIzlXTWHcxHykpDDcqFvMBpu
 SLX57kWlwxnEzcgmNIrikHt5Kc9xTKGcHJa4IJd2yWeGxh4+zAwUfg/iobPOSCZ90G6u
 0Od0/2DuhbexJ3rLceLDQUwVoSFYdEW4TI6YSJ1oeEmbPZgjNT2FNPLj5auvB1QxZr/H
 daRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ByFMJ/+9P1viEZvOVDyy25J8z8HjeyjG39QnAQZjGejSWLTWU/2uNQQRyUVNiKc6An+CiG4=@lists.denx.de
X-Gm-Message-State: AOJu0YwRTVimP6Y6q+WxPCc+WRteQ+GG2xtPtH01FQYdLYV7GjJY6iKK
 FDuDUz1BPoufNTsggbDJv3M6UcxAx/ltEwnx0IR64LJJEBLCOYZZakJdV2DzDLdL3YRV8PwITg1
 kWR5vqI0=
X-Gm-Gg: AY/fxX4P5NqQNh3XJ7kAKLx4QgXPIyD8Lzt76vsnmNsPIjlOe37vhHhH386hMjceOLr
 OkWe7JShPSHIHSya3fYgf0xPiywHL7iGxOeUc6xaJJXJzwHXegSiRr8A6/Q/Msda8wRHvWifLNX
 R3zr8p9VC7t7kvByxP3Wiu2GpJOEsOTy7hDbztWkO3V5pyPN51S5qKSe06xrTM2v3pyh1mlyVxb
 ewZHMfBlH3f+l5kKYV+wJN5rXaM6I1wYxxbsWDX+nd2+/uW458uevuxvb/0cZPHkmpRlFGpBEKp
 V7Fxut0GHDUwGHA67CeUEJto4XJQLPkrZuXdDwBDRdwDQvmJv09AGqEGmKuFHLq9AxP8HYURQRN
 lyLfyvsLs3QBCZONOLy7kwU4uWUP4uoI6wPZlpIdF0RVTiz0yO1vu3YAeq+CIDXlSogKRUO0tY4
 VXKYKAr47AoN1js8dSUCM4F0EQTGK28yQDPc7y85ZzxXEnpD8UrAhDcQ==
X-Received: by 2002:a17:906:fe0b:b0:b87:2e8a:e270 with SMTP id
 a640c23a62f3a-b879324c893mr339208766b.57.1768586595713; 
 Fri, 16 Jan 2026 10:03:15 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:14 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
References: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] smem: msm: Fix memory-region lookup, direct <reg>
 mapping and update SMEM host count
Message-Id: <176858659378.3399278.13947581821934509683.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 12 Nov 2025 22:28:51 +0530, Aswin Murugan wrote:
> The SMEM driver was failing to resolve memory regions on some boards
> because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
> valid DT node. Modernize the code to use driver-model/ofnode accessors
> and make the probe robust for both DT styles (direct `reg` vs
> `memory-region` phandle).
> 
> - qcom_smem_map_memory():
>   * Drop fdtdec path; use dev_read_phandle_with_args() +
>     ofnode_read_resource().
>   * Use dev_read_phandle_with_args() +
>     fnode_read_resource().
> 
> [...]

Applied, thanks!

[1/1] smem: msm: Fix memory-region lookup, direct <reg> mapping and update SMEM host count
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/984ebe2d553b

Best regards,
-- 
// Casey (she/they)


