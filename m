Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2079C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 08:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6286D80EA3;
	Fri, 28 Aug 2026 08:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iysMtht3b1qr; Fri, 28 Aug 2026 08:09:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787904549;
	bh=DNtinMcwcZNowpIxfV0SWbF83R7YlaYuEGW8fefIEGI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BIYHCztGx8jtEdNwrmnOflJGO6YpJqxlBR6h5ZMWx0oyKPx1eQIXd9OY7lBvW4FDp
	 gGJLJkmghVFyWN3Qpxpb0qiejJMuffhmhGTwSM65pf6inuq6eMYTrt6qfqrhdtwPRN
	 gE2afV8vrBaHJfEt9cYUz8Y/uvjn2AYt1VkPc91KxXigOZvFFhxjAQ7zVRqUq7jKJS
	 +c++K9/1tOIqnyuDuAt4d8JVnA05fp+oNg3YcHOupl27c8fGRCfbjdUf2lkOifXOGH
	 RWQGIzHaAAAfB3b/0RGghX2TA/+PXcuy/OOrqUGWFmxGrCpq4IArYDlnvntFcbsozE
	 mLlklq3amC/AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40B8A80E9C;
	Fri, 28 Aug 2026 08:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26DEE386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CE326069C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YTBb9a0KsQk for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 08:09:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jNg1D0g1
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C44236067E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:09:05 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so2206565e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787904543; x=1788509343;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DNtinMcwcZNowpIxfV0SWbF83R7YlaYuEGW8fefIEGI=;
 b=jNg1D0g18TiLS/WOOlR/BahQe/WqiKE5BtlwRQ7tJDFf6jXdzPaWTOXAUbXKFJxz1h
 +rwSRDxqy8TDHNZvnvyHJIUvqsG4hTEPmwgBShm28axe4eF6MK7JYQYOF2Cav/r0OZI/
 VQ44vmfGh3ooI57vrfr3rhPKfo/sU4UlJ5wI0s6CKWpgOEvChLKAZo+g4xfVlhrtEYQr
 TnohM5kU1kL4zfXzJDXHku+NFGzkt8A3hZ2p6QMYnMpk2SrsEY5yhXdKEIBNHMkBfgcd
 lkPYfMNNqQrY24AVDnrhLPgn3QMfNK2u7RJFg/NNKloF75UU7kjyWp1Ww6NAUqVL5LrL
 S40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787904543; x=1788509343;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNtinMcwcZNowpIxfV0SWbF83R7YlaYuEGW8fefIEGI=;
 b=KC0TrV5FyCtiEzIe0NG+OWWxClT5GYIy64WPaIMIgxtdWmxy9Ru0+OTc4IvDr5cvZp
 eSUl0NpEurouXZSjoOqraOe5uaWneT9TBb00tYM7qdrnYT219ylTF4JJyG/FqhRgbi97
 xphkii41E5ny7vAkpZ5I/3fWL7la89q6UTRP8TF2v720YiVA4z0mBK1XUro0w+rq/vOR
 ZFIh80SaPpoFMjoRZLPOCPnEh/E5LwS0QOwZQIAvpIzyeE2h/tImH+UcX0PppDhNQpwL
 EPCIb7pkSBzhIPrlyvj/27uYCN7+/Dum6tasqO6zJAcF8HwoOnRnrEdGHjV1kKc5as7N
 zU4w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd5+rqULZ1c6IKiHIcpq8DHPEkWqRQ99udh3awNJc1oS7wxJHef5Cm47GM9207VlNu1jq4lGM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mVVmuKYOA4kVHLfqfC1ULJLlDBq5PsYZeO1LeBD39XgZxT555V
 OZeS87N7UaztRAu15bOl6974YVuQfQmvIaioetGWa8GRfdTP51CTLPVCWk2+BuYAoWA=
X-Gm-Gg: AR+sD12eiKleclauoiM9J64ZDdU80Xg4WL9vk17orxhZVyiCBIftc3S+QCNDn2onAsp
 6UOHtoQ47/oLcMmAB9IegRzvQFvqXieGXDqLVYBu6b/MUDUoABIB+DYEJ5APDTVihj3um41axUT
 P39z25eJne2Q41tBeTRdSVVdWCXsyGl7cJ5/aKIrjczjRi/O3t96UCt0y7J4Eg8GkHrlJbNcfHQ
 +pUcGDigylkfuuc1Ze75ii4PYWLTEZT40ywTxS+JWKd1V79ghOl/zw8LX+cKHubFEeMB2JLfuBE
 4tPeEh5C9gN7gu6GDdmAXVnEJZZmx306SYty11XO1HqVzm7DfU2k1N8BbbptsIXhj0IpvjoXjh0
 hIXQi4l/St81x8BWxxPEc3SkW2Y+SOPGRGRPdmz01ivrfgoElPfYxAWmeSm5n0xoJeiawzM5dwf
 A1S+/IxYWogM8vrntfeyGrT7S/+yGS2qVtM+CtS7USsVq4xZ5ImUwsFMRIAd48mrw1HmQKebt3k
 6JDyZiv6AkheIcL0wmSOZm/UWVcX4xJ+6Ml/2fdDynyxRFV/IUo5+4LZx/owPagNzOu3o6z0rxt
 Iix0xcmw49P55Wd9VdVuVGtfFPJ0MItnWIdVY2j+07EkpdJ86aFJiScK0o5Rp6fUYWpQLY8HFXe
 vyn8rIHCVY+kNcXQ7NtGMtC845BQNfT6BO6uNBS0Xej6yJkUdKU5yWgnHeS9rZwdQtBVorXt55l
 tPPii6YbeRqaEgIZ9lZ0153Q28EASqr/Hl0iquoLTwOBJZpG7VNUAssjlbpwpWCW10Mu97z6+Gw
 bV4q2Ho10ptZ6xrswQkVQWM4ooXbf5EjMtSaE/8XFmCDmrsiL+Tw+Cje+jh1yhhjlTO7Q==
X-Received: by 2002:a05:600c:8581:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-49b91c47bf8mr59844125e9.13.1787904543075; 
 Fri, 28 Aug 2026 01:09:03 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbad08d2sm2750383f8f.16.2026.08.28.01.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 01:09:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 11:09:00 +0300
Message-Id: <DL0F9J2C97EZ.27F7FR5QIOWAK@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Aswin Murugan" <aswin.murugan@oss.qualcomm.com>, "Varadarajan Narayanan"
 <varadarajan.narayanan@oss.qualcomm.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Biswapriyo Nath" <nathbappai@gmail.com>
Subject: Re: [PATCH 2/2] configs: qcom: ignore OsIndications for
 capsule-on-disk
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Balaji Selvanathan" <balaji.selvanathan@oss.qualcomm.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
 <20260813-qcom-capsule-dynamic-fw-images-v1-2-e595ff79496f@oss.qualcomm.com>
In-Reply-To: <20260813-qcom-capsule-dynamic-fw-images-v1-2-e595ff79496f@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Balaji,

On Thu Aug 13, 2026 at 8:56 AM EEST, Balaji Selvanathan wrote:
> Qualcomm boards apply capsule-on-disk updates from U-Boot without the
> OS first setting the OsIndications EFI variable that the capsule
> runtime normally checks. EFI_IGNORE_OSINDICATIONS makes U-Boot skip
> that check so an on-disk capsule is applied at boot.
>
> Set it once in the shared qcom_defconfig so the boards that include it
> (qcm6490, qcs615, qcs8300, qcs9100) all pick it up.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> The option defaults to y only while EFI_RT_VOLATILE_STORE is off. This
> series depends on "configs: qcom_defconfig: Enable EFI variable runtime
> storage" [1], which turns EFI_RT_VOLATILE_STORE on, so the default no
> longer applies and it has to be set explicitly. Apply that patch first.
>
> [1] https://lore.kernel.org/u-boot/20260720-runtime-v1-1-7f904b4cb3ed@oss=
.qualcomm.com/
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c52f619850d..960c44b1f70 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -9,6 +9,7 @@ CONFIG_SYS_LOAD_ADDR=3D0xA0000000
>  # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
>  CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=3Dy
>  CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> +CONFIG_EFI_IGNORE_OSINDICATIONS=3Dy

You don't want to enable this. First of all that Kconfig option is set to '=
y' by default.
Looking at our Kconfig again it should only be allowed if EFI_RT_VOLATILE_S=
TORE is not enabled as
well since it breaks the EFI spec. That option was added years ago when we =
had no variable
runtime support. If your Kconfig enables EFI_RT_VOLATILE_STORE, you should =
writethat variable
on capsule updates.

Thanks
/Ilias
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
>  CONFIG_BUTTON_CMD=3Dy
>  CONFIG_FIT=3Dy

