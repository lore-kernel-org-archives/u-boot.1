Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42494E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 16:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F5B805F0;
	Wed,  8 Jan 2025 17:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CtIJSgf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC734805F0; Wed,  8 Jan 2025 17:58:02 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB63F805FB
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 17:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so5869266b.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355480; x=1736960280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jKBb+aryaqbje8FlWq10obXbq6Y4Gj9PLZt3jzb31UI=;
 b=CtIJSgf1jF62qsEwF1uvrc6P0RziQk1++V2UbmVWxzRSYiqgykFk8Ok3qfvXKCcB6P
 jjVY5e8VbfwL8tV1PCgyvD5u7VvYf4S+dGcbJDxwrkgtPq6w9xJT/M6pxOWsq7gwu1WH
 SgMvIwJwGJgEi5ttEkSnoEfDIio0LZA7ohioQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355480; x=1736960280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKBb+aryaqbje8FlWq10obXbq6Y4Gj9PLZt3jzb31UI=;
 b=qQUOnib8uO8D6z2Nag4p04esKMOItjNffIeE2uLo9IxdCrwRf9WnLvQJR/eIhcmPVQ
 anaU5N1jOI3S83+Uo3uqg35ABD7A4AA3nH6ooROUHI0EbpCTDMIKT0NE0Vm2saOvw9OH
 8CbWo9vYmtLcRSu/pxHAa0pXHuj0bG/dQcK+EH0gj290MqKEhaJe7BgDx6rJx7SYWCTc
 jcQgncavM/a9UVhpxP6Gdq1ZxfMUdoYHWCyB+P9p/rMJvMkcPBrt/WADP6WOv1Vd150J
 toTiN5Q8CBPiJt7+J1WcyymU7cyqqhop5RkUUPTlVZ9FLXhZah1I4ncwp4QDCC5Ob8Rn
 Y3xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsmo4YXL6aUtfl5O2WIvHPW6N3pKxXcjDusf3QI3K3m2ItMpO/W5b/IYes27WPQVTCx5ZU6l4=@lists.denx.de
X-Gm-Message-State: AOJu0Yztl1G36Lp3LjHj3DJ6+Hs/1ulQFlc4ZXJCCZqzc2ihU5e/iTOq
 EEKWFCRvfccF257EcDembPIO0PCUnOtcfjYpXahP9LRwq9IsdjWnzMvVVj3T6m02gBFESWgulAr
 EkpVILVATe8cQxEipmLWCst9ZuweqKcp+XPyF
X-Gm-Gg: ASbGncva1w9u0PhqR9vN6DEwiZIwzRnsozm+awAhOS5wvhMcYpzKAK9ZwXKnqK3t5zM
 MaCQ282WSA9WUqz7mMmOrzxv2Gz6GhxEOLHioij8=
X-Google-Smtp-Source: AGHT+IETmj9Qhjh7TE2rgX4sGk4/utiIrLBCFlXoGBHrLRcp8ioJPhuoSDgc057bf1eEqiYdsCjs9FGeSFBU6CAJ2UM=
X-Received: by 2002:a17:907:781:b0:aae:b9e5:ecf9 with SMTP id
 a640c23a62f3a-ab2ab66fd90mr316794866b.1.1736355480230; Wed, 08 Jan 2025
 08:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-15-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-15-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 09:57:48 -0700
X-Gm-Features: AbW1kvYplzLcTNC9yJzUbM4T13io-B5ZJTs6BxUpbSEpZvEsRKpnG2-T4c7PTfk
Message-ID: <CAFLszTgi9BobAAD=BkXqNDWQXcxpzVqiwv1YLut4uV4xtX2=tw@mail.gmail.com>
Subject: Re: [PATCH 15/15] qcom_defconfig: enable QCOM_SMEM
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 12:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Used to parse memory layout in some situations.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>



>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 30f7b1c773fa..b49d897123c1 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -109,8 +109,9 @@ CONFIG_MSM_SERIAL=y
>  CONFIG_MSM_GENI_SERIAL=y
>  CONFIG_SOC_QCOM=y
>  CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_RPMH=y
> +CONFIG_QCOM_SMEM=y
>  CONFIG_SPMI_MSM=y
>  CONFIG_SYSINFO=y
>  CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
>
> --
> 2.47.0
>
