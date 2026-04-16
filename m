Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AFCF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82098437C;
	Fri, 17 Apr 2026 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmQHwETa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F398407E; Thu, 16 Apr 2026 22:54:47 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46E583EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-671c24f23b1so6767848a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372884; cv=none;
 d=google.com; s=arc-20240605;
 b=NOyxEcDUIDiY/vkRFASuFu+m+91TXozOae2uQpfpgZRk4uaKJpyc5tqDf1u/ychyZs
 ky9m4pK3ygrogF3efepH+VezcIhYR6flhzXb3UOvxA9JhITEC1w+BVdnWlN6LcJCZPQF
 Ojly/3Vao6l7xvmqD5MQjjBDcCwi9cnlHO6Vir2C7LyI6WAXkhv93kTUUJP9oxawLXcn
 iesyuAIoz0iwYUaodLkQOf9yE6oaKlhYOXoRzeZ4JXrncq99qD4PwOGA7ERxTyLof2Fr
 uV4nKQ2O9l+TZX8l25lQcvWki9uIDColixSg0lFWj7hZ69UGV+Xgodw0owjR6t3JzI6v
 kcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PnJVtyYGld468F3DHO37W00cejxCldoBffSCcbbwpsc=;
 fh=PXJx/Mb3DSRd7uUbX1ZSl9BQGaoWKiQr+pn5Yqf5nv8=;
 b=YU/hyW7ogpgHp6HrbXDp8jkmdzQjQyoyAD0v2HpphEzRUd2KtcJm/X9nKYH8kFMeIw
 mnlWD2Xpajoh6Ca50RrILlO1hbxMyAPf8tTd48iba5VYZ/KmUbeZTHRWZi9GJ6UY7wqG
 xjVhqcLdxuZXbQK4ff6mrKgTki7rFEaCBiIuZyq3dGt7p0NdGoQ9yAyhdEO2/I0vpHDa
 unjsmjvQBIW9EQ/DBTFfXUH/JXFaSVzkBRlDWFX8Bs5xro/Uy/EYaEPTmbrOfjtxnZgW
 foWCv7M0V59GROqpBV9WvwOwHoKdJBpIk1udvHuz6j0eFm5xxZ9jF+rmoxF+UMQiJhQD
 Ou2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372884; x=1776977684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PnJVtyYGld468F3DHO37W00cejxCldoBffSCcbbwpsc=;
 b=kmQHwETa8atq8F8EqG1T0bsW7JchRZsr2ST0QzgJcQ/8Hek1iNNDTYiJBOEfG5BQY/
 +ScP5y7Zi/sm8gjdZ0j25rCMoDXnj30Rbt0sI/TuWE9bAuexkdeP75O86TPiErW1mfwQ
 a4535g60CgGfg/WVFJdi1JPd30Rysj4d3CbDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372884; x=1776977684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnJVtyYGld468F3DHO37W00cejxCldoBffSCcbbwpsc=;
 b=Zi9E29ob/QLm8ZAfg22ecErdqPmjBg/cTg9niz/k/5do23cE/lDsru+JIt4TFm/PyF
 c+5AzgVzxOqQFjAi82hi2HZivhf2Yh/ZXpZl2yJPyCkup9IH6BtV8yicub0rudZieNgz
 J0vLbQxq9KtVkT3loet51++DJ7EJJmQQYkPUeSq3660LOCCftGgVbSTXybqwJtmjCAgN
 0yICYKs11ZaCWGwkbenP6jOGL4cEWLs0qgeCRrgfGzbRAMOiHU2Ieevy3gSgVl9ZUxZr
 oew3mlk+gL1BxpMJTxp1go6QKrZM5AFtwmmp95r/Dh1XPegL3RlQpAUxtlqajU4rhBAQ
 jXtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pqfrnjnIJG4glMH8zYVBJbe07z3uANeHELeR9+P9nqBrH7CKfdo2qAq9aE637C1pYD85+nEw=@lists.denx.de
X-Gm-Message-State: AOJu0YyHna+O6cV46NRnheM9TFyDeA55VHuZnbcmQHwonvq6r8X9Zl9+
 B+auwNg6O3VSlnSQiOt1OpIPyY4fW+sEBR8IqtTK2deDHI7Le3/aeP72FMEowplPgkrOeYRDiUa
 CI/GHHLL+S2I+L3bxNbKnjmCbZ45GSjBZq+DRu1UI
X-Gm-Gg: AeBDiescd8fZc0j7IbLPHKj576iweiuU5cWSry2WKuI/KccrxkNbz1fVJC6vituXgOA
 mbgnIB8dA2KzRlbDauU+gVvFThGDnGbVCoD9M0ELgYeAsbhOyxuhPViWED3cuY1+5Eneux4Bw3+
 8u+a37za6dKVhGN9gQDuZ7RJWRGiW5NKpX+bI7ZKaJPocofuo1QA0wYze0Iy/SdNE0/EyAPY/OS
 8IWallpLoOE/NS5LuWMf++I1UG+Hq1XUOi9EejJ/MTJ+7KkkyYNffg/wr6rfGd0i2lKUIkxLRQI
 ZtoopKT49ruSElgyKjUf
X-Received: by 2002:a17:907:d865:b0:b97:8503:8313 with SMTP id
 a640c23a62f3a-ba41a047014mr5417666b.27.1776372884020; Thu, 16 Apr 2026
 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-11-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-11-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:54:31 +1200
X-Gm-Features: AQROBzBH9TkH2DEK8V2Bn_9ZE1UpT0CypoiCJtyiswtlWlFrzFvpoaBS5fFubuk
Message-ID: <CAFLszTjRs8Wv8wjvWVCPE430HSNv2+_O4aH09KRhW1C_oXOPxg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] doc: board/qualcomm: Update RDP build
 instructions
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, tingting.meng@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, adrian@mainlining.org, n-francis@ti.com, 
 wens@kernel.org, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 ycliang@andestech.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 richard.genoud@bootlin.com, michael@amarulasolutions.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Varadarajan,

On 2026-04-16T05:39:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> doc: board/qualcomm: Update RDP build instructions
>
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> doc/board/qualcomm/rdp.rst | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

> +.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
> +.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
> +.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
> +.. _OPTEE: ...
> +.. _qc_config.elf: ...
> +.. _QCLib.elf: ...
> +.. _template.its: ...
> +.. _TFA: ...
> +.. _tmel-ipq52xx-patch.elf: ...

These link definitions are not referenced in the document body -
please can you add the references in the text?

Regards,
Simon
