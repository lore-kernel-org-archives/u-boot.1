Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9F5CD4F5B
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C96178460E;
	Fri, 22 May 2026 08:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kiZtDvdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB07584673; Fri, 22 May 2026 08:47:21 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD15841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so6823016d50.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779432436; cv=none;
 d=google.com; s=arc-20240605;
 b=SeJm6MEnftCEJWbQ1FOTh4Gp1ImlIOBndwj6TpDUffBa5sYFkIPLSqJcPeH7fcH4ho
 gOFttUCaWo+/OxXqLzWt+KpS/66fs65w73jugl4wm7EMaDNUtdy2t+x1ows6TA49dYXA
 DH5y+tsIEGn6mbMEKKQTjjb5Z62tHzwTpklFN2KtJJfgP0ZON2rV2Z45rDmxtcgdZmt3
 7IV6oyhLUQrkjbmwRhsQBiyop+Bl5vNm/qTg5VOxGFgLpipjn1CDPPgh2HdFvyoYYGgY
 PW4XyVHWAB/xdJIpCUndDtlF+9dfOkawMj4a24KaP/XzQZ7SQnGLErl9XbwGmABy8uOD
 PyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W7/Nn6mb1g+CzXyzevOpNRTOaSf1kHCbyF2TdMRnqso=;
 fh=BFSrEyEcRxWmm8Z0H8OPDQXjpIIg2tw/jut1EUU5Jpk=;
 b=lCpBuBpvx2gha89feBybwzIWv+UWsGS4aA150KwJKfWaf3VLw5Twb7UN6t5868Xrjy
 iF07TipFjCbBvvoAnYNlCMWPaEoRWYEgOo/uz8qfzPIQBGOi8zebKH1F45hjskePyHI4
 YG+WuidC4xd/4LEM9I0O9YvUofa+yNXHFat0degRUiFxVAyOwkQsZk22mjBqFkvDwwba
 MsIAX/5LpVWmdJPcxdQJEPbp+DEjB1/Sypp/a9kLqKA5/+Y6VnSIHIip2BT19yxu1Nh7
 mLQ+6W39L7CIO58sN+vlr2vFid7pLMrMuLiuR01xw7pDFx/wtQvN/vAF5wd9EbkwHrNU
 AC3A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779432436; x=1780037236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W7/Nn6mb1g+CzXyzevOpNRTOaSf1kHCbyF2TdMRnqso=;
 b=kiZtDvdNbnb3Vyt055Xg2N42XPu41KXOrllhnI17urvpLkI0M/nZtME79wIVIMI/23
 PuYu9gQMzmBRrVGBj/QixBfCA34UGxW14YVn9Z6VnccI+751C0DJjdGljygExSvPHraJ
 2eDcyTFQGkbg9PF9anmHfN8k2nzof0L9VzPZrllcfunn67e/J1X3t3PZZp/egRjenqAZ
 YoTIrxVLqAMr821ZbWK/5x7JwW2+hmARkBpjULuOFYPEY53gDf847ZA4Pz9Q6Lrf9NbB
 bKIamscfxUHVMYwVjddXvVVcdjdAbsCcd/jCVMK1oiPt3XfoUlbPDOKTiqj/sV+Xqkkl
 d0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432436; x=1780037236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7/Nn6mb1g+CzXyzevOpNRTOaSf1kHCbyF2TdMRnqso=;
 b=GIHNMg+2hT9cpEOaS3475CTwQyJccBroNrH0Xs3NNuyN8w6kz32U3CM6G8lRJEpbRJ
 tF33qOOzy0QHbY+QJE/WeMoaYg1dA5JJYG4PfXTH6ZYOo0A4p7/0Bu0pH/djQNTTFedQ
 2DDXgj1hHXmOAc9sHHoi48O1y84dxEqwFr3Nog6GyINl1yVNQicoStXN45ZT/jUbcqKf
 uFHkhenyR4KHu+PG7GIbNa1zFDmryg94Y04d0WCS4lFHzm656OLDIsKHjBtEp0Ly13jk
 LI+cB8ufw7MntaMiNCJ9MBw/nzeN3PEyrJSAOe9WlsYq76nKr7aqBetGohtc5baeCT9l
 yesQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z+/RBE72sT6EKBCXvG6L0CYrxVWvy8wjUkRN4eH7lmGvVTumkxH4gAH9C6pfxggSeouxhdfE=@lists.denx.de
X-Gm-Message-State: AOJu0YzSgTUjeKGrp95xUdqcjk4Tta6iQX8rBv3sZVDLR3vRqiH5bI+3
 QL1ToizyT+93/4KKGky55U4G5F+dQ5CuDdLOBjJqn+7t6gpF6gUZtb02rdSUpmK155KiHLlcX/8
 sVRitV0N2S0rNGNCg2XDIMn1Cwl0ZG5RTIRnv09sMug==
X-Gm-Gg: Acq92OGEXRrhR/i63PWHJ8PO5ysW6gqrgdhDFr3yaL79xxZawEtayZewnxoe8jqIdpd
 NEZwW/mk1aOqqSMJZ2DM6uEtJ+FjNdOOj52dcIjIhlnDw0I46DfWKot0DUMv65Aog6HME2foK8r
 xcl8YgLeRCcrOzmfyydnLsGKs3YbUaoMKNLCvDJbd8ibcyGUMNK2hrGVQVgoGPSsk40n9EBtKvX
 QUoH2gclM5k8uU6l4nWCu+5K3vlYSdM6FA3SZ3mxBF673b6ZWqz2WKPc0nNiFF6MA1sZlEVyMDW
 v/7NwjeaciGWeWB/Wx620L+6DAT1E5YM/Hg8OT2oq0lPGe5u6QByt7fjMXW0cy7xnUsNsSrmcsA
 Zn8tsA5mxyPvTkLCvDiPQh22mNTyiew8verpdNDUeSX3dzHK/QW7b0FdWW9aQIb/ppalLkg8zFL
 b2IP+tE2wetGalhyt729zPiNZLDDkkXWed6aVGUMjwmUSIutHy8SQEWlgA72HQpx/nqD+AeT/Zd
 CvUQkanNVW1N74nLiCDFdjGooysO/uTPBU6X0vemKZ9qOeKBGp2qCwDzp4+H7iqhPB0ay1V5Omk
 vOZWh8Up+oIH3ceT1PDHARryh+SXJgjUmBfSwUhCE3oYBGNAysfn40iY4cq4xYo/fNstGLpmaiL
 N/wLaAw==
X-Received: by 2002:a05:690e:43da:b0:65e:3df3:1c30 with SMTP id
 956f58d0204a3-65ec96184e4mr1757582d50.7.1779432435801; Thu, 21 May 2026
 23:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-5-ff0ac9978d48@oss.qualcomm.com>
In-Reply-To: <20260522-capsule-v1-5-ff0ac9978d48@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 09:46:40 +0300
X-Gm-Features: AVHnY4IvKJ2nYPi37KxNX3DJ0SfyKNYAkHzOSm6EELbgL4JQoOOfDQEgaLN626Y
Message-ID: <CAC_iWjK7JxPaDDe7CZt6O_MdGr-wvVkPLmsXR6Pc9V9JWnigzg@mail.gmail.com>
Subject: Re: [PATCH 5/7] configs: qcom: enable FIT capsule support by default
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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

Hi Balaji,

On Fri, 22 May 2026 at 09:10, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Switch from CONFIG_EFI_CAPSULE_FIRMWARE_RAW to
> CONFIG_EFI_CAPSULE_FIRMWARE_FIT in the default Qualcomm
> configuration.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index d0d54ec5a70..25059d2e6b4 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
>  # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
>  CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
> -CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y

Why? The reason we added FIT back then is that we lacked capsule
authentication. Is there a reason you prfer FIT images in a capsule?

Thanks
/Ilias
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>
> --
> 2.34.1
>
