Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1160C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 16:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7768F8107D;
	Thu, 17 Sep 2026 16:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atbvqACN1mrA; Thu, 17 Sep 2026 16:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9880380F7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789660878;
	b=HUfILDyjRYuSW847DgM0zytLxLolx9OZB5q2+4HDx3bMWYGD3cdXsGBwfh4ZUftFGUEP
	 C7hkg+N+e80u6UKz87xD7/E12iqorHCKm2d880HsAZDAiXhgBgu7QzWdop4MkGfv+OP3H
	 dKioKIo/HYLOdyEajknHbAK00DtO7wVV/yP2eoV2THXXLVnWh7nzyYyKRP6Gcz9dXvchB
	 zLScBcEEvLGR0vrp15HbAktx91hyzel1CM78U5a/a2Byk4LeHL6eEQNUtKeoZIeavlR1m
	 x8l5kcNsr0YRQH1j6Q4HaD61SWjWKhf0j9holxXU2v95qqoQoF1InpQq+3eFT7AmRLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789660878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
	b=ZETl51AOf+9YBY2A+sq//7KzGvL1r9J6MWzG3/5XM3f41XGE5Farj3ZHgyll5KNcIPWx
	 x/S6oPQghERAjJApeB8bQzrseFqNm2OlFCuTrM6C9NN9TmguKrLqrKDDxGT1s/DBlWJ0t
	 OgO+lTwCNTF1qTegDef+a7CSm25+4xS7q1xCF0V/gbycuwIXGbvAcn3BtJmxinQRX6nEn
	 GMsLmQKWCw9hI/byDQIBtPNA8aK6ZiJ3hXBDJd04YMtdu/30F6ZFtflqvofWpd+03T8F+
	 UWlJ9fyZa7WzqCiuIXhPBSbvyNWuXHN3kSmKnEertyMhmIaqi+iyzwKknUV/hEzEV5A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789660878;
	bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZV4slgVxpmhRrvVoLoemmTxXO8KtgI/xuG4QUINHogzP3DNUBNOEIo7hxB9PerD6
	 e6VwWeUXx4EdPN+uplfKI3sUGZRa8y6emD70UrS2P0RVTIH7kzOw0Wg+BsLL7UQKqm
	 koPmr8G4VkZFJ/gy4NzxSeNkLdVSfA+nS738B4EUoMh4tHJN7/EBzwBnJ9Yf470CnT
	 DOYu5qRUgSEAnw8sRH5v7LlcM0l45rWX2q+zBy8ChlwhCt3n+wYxsIA0FbQo+byFOI
	 C5fROqjfURiefez0DrKSO5ZeVhFoivNIiVS/wtH6AVrZ9MBfo73uAnSy5ujFUHn1up
	 zsW/opCaCtEpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9880380F7E;
	Thu, 17 Sep 2026 16:01:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00275422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA2D6608A8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfAHpT6mTo36 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 16:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C617C6085C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789660876;
 b=jO+ZWN6ukFZR5WrxJD8EXqlldYXjQpHxe/mw1mf/d8q8SC2qiKufQttq2UFA8+dG1nNY
 Tfsd/gn5RXySTh2NPNpvCPc1veNJ0heFsDux72awvzHkp2HH+jm46uOkyYZbyMkAXH5p4
 RZP870bPKBeWHe+Sh/pp0SkqAuLYvwz1LAHJV9x1HcYNPCY+vVdUWwFOLKzuEGID9tyOh
 fJ+hcFFIU/rkpTcjvy/sgFSjNLlSlC3p+vZRpV4b4XMkMvPV9Wd6NLBS+hCbOBrxUVPPg
 8Es+e6Y7JBAIaFiMaoy86A4yLv5uTMh2enB/BYnCXiQqBPLYeI9G4LbmqEOWXglInEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789660876;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
 b=GtfO7JkwgltG1rqTk3Rt3FWoaHTYPjHE42cyzSu05ctw83LWFO6CQCwO6IBbj2Ct8d/X
 uQeDXJbw5fP/wDC3rqDhlksc2unEA0G5KQ2hQllBy3DOmsPZVbFPPTCoOMvnI5+sDOse6
 obTi9uZYvfWND5aVhkl+86gNjl1VACRpPblY+FSIyH4maLL0EI4QfLEIQnxUVp6EcUUe8
 cjv+9PGKLuTQGb6PA887xYoWFusvUtokXk8KtbcKrP2nHsLN+c1QLr9v8CVxcdlNPCpl0
 fE+/yS5M1GSMg1a1WfTa6dirv6UKXleFmmgy+EHGwt/jPCq+5X0DpOUH4I8tGw7Cpaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ItlywHSo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ItlywHSo
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C617C6085C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:01:15 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66d1447e2b1so427050d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789660874; cv=none;
 d=google.com; s=arc-20260327;
 b=r13VJUi54tNEmw8QWd9jJUIvOYcY9e+JFX1YWm1BtWlz9BJ0G71R844WnTiONdBHDL
 g2jMZVVjGnwJfn2aoZgUjSKDMyNloYX/faPeLRsPhcgwZXytYxY3SHZlPvvq9NPTWmnY
 /1Q6RK9q0YguZq1ZCPf79QdXkr31jE9TNbQZBgGU+PWnpwlru09Fb/BGiv9gfqCHeXCF
 ZG5yIiivMKFm39yuDCOs8nqN1cl9iRdtjgMFpUeM6LNTbauzBURKDzyQCwwJEuzlsxhc
 D/4F1Vx15EjUbJZWR88irqj+jwNmUnAbtZbjAShChjTMnaqJpa8/lyvGVkFZtaSBlhmv
 Ex3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=LVB8v5MHbHAaRu77MfDtj1LiQSPirnB7IdwB1oIIx3zSBek+pZSVDv8LYLZVKFkvZX
 I/un/TlZIDVC8+Rlg6+/GlTEf0UP97luO2EV/jKMBT8DyP4oZo5a7Ll5+XqDSl6sSUHl
 LqIgQChveHVe67ZVEtizwqgAnAq+P5RF5PYnaxjRmdnzgWcgLIqD8zHZKFi6yD/vn3V6
 lTRY1sLB6kh443dmJwrXLsOPfgP2OIoy83pO4FiYF98wTk68boEUqBT/3gOQAx0ZhyrW
 aGL85cT1v6fdlU9x23adDvoPLMn8m9SHz38n0G4tJDxGJTRD6oBRJniBU2moeZoD3rES
 sG7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789660874; x=1790265674;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
 b=ItlywHSocHzSFvrb2fXLJKagdRFBeo1Ga8gRaCsstK8rqebaO+PnnX1MZ6PfMmO8sG
 RQbRqQhZocn9pMs1rtGNansEJjonCk0wC4H8nOCuRfKwyS+RNlHYMHIY51vgp5mgh1Lq
 pUrGUAo1KDXv38qwKnJHeWN/C3RtywbXQh9sdhU79827y00OZIZVE4WJupbQSsOxmazc
 TmHh3fg14hsvqJqh6titiPa9CNO4HksPe4ah0VGl52MX/vwuaCoGqvDTrcnFJR3ZmSMK
 I2/bI0XDo6pvOwWada5ATVaZM0FJlKengf3BhfIDRwkn1SmqtbnZEraHsEAxm69RmOCj
 qtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789660874; x=1790265674;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ekN/ZdX6M5HXzrRiaD2eCAh1cMXuap13ZvyIsCb18kA=;
 b=1wbogwcblumwPxfymX4Nplls4FcQ++EArDZQEFhVXCgjuFySrNYzaHhSHTB23gDS8C
 bCMDmyOpGwNP0k0OdxeX5FhNNxQ7LPqloaHnUOACSEvOlEAtC7UzWnvgG7yaNienTZeD
 EzibECdHKKoRsUMEODVjvSOrNRCEPqtjkbKmvS+jwYmoh+pxydvUdMslBlIPxEl8K3CC
 wwQY2rf4qPEj/v7Ka2HYgHv3OKlBL+bc6maqZZFtuJkN/Ac4qwzQJGUBtQ108DIe7bIB
 B9B5bwPU0lpBMZVOOBTuoP3FInk/h9IDFbZBhh4ZxxztN+LUlezo2sEdhKWyateu86Vy
 KHiQ==
X-Gm-Message-State: AFuF++kipFksW6POUKKkDzqMa3SnzroZu5c4SNSzzqZh1TMCbMqUWzmI
 BWc2yLxp0xUL9zPA4htn00o4uOrSvq92VhIuLRZUXZZ8MsTDJR5GQ03gme9QYja7LrRTybJx6lJ
 lmrdAXGFXC8l252lDfuhnCxscDHxkrUsa3EsUuAPe0w==
X-Gm-Gg: AYBFou2SygJnANrxahndOaVzU3jgtH+DNc2lALTtuCP4lH4o9t6l7EOgo8NhY7HhI7b
 aUFGOz8Hi92nzUv+aT/lPVy7xKr/fX6474NU6qadJLooYdIbCJdIo2UFa0XQPgPa1efNh8dMlEj
 2auzNtC5kxOiErerc6sEeWrh+46T21lSJbS/j8YL/q6HMacDWsEcvh/NtA+KlR974VJ/qhwzOrZ
 462z18IejBnl+mExjmn75pWsSFD9Ibo1YGbotqXPHNgll98OfhR9kWURMqk5h+YtC/e1J+42eJ/
 OV+1MicFM+lBYQrOw+gfu52rWN0LjQ4umHd9gxgJ9jb3FWJcJL43vTRg9swEVr88VdJnKk1YZxh
 pJi4IOZgs1DtK+4ZTaiOJitq89daqsecuHYhqQa44Ohr4hIjL+D/O9HHzaWrr94Jp9aHxmTLzEt
 SAUMNVPwIjmoQUz9Cwat7xkINe72wrsc9L6gy8QJYQWT3YWBgIqSXIzJhKHcsuMFkeLMQAKzifZ
 VwaUJhxp54AQR9Uy4+fpQKqbapDq8EKZGdaSjnrgyCqdvWovlb9Y/6pq78suvGYLKuVTZFPldFY
 dnXhFpxpsb9ZMUnJTRU3uexRTcH3H1y7i93Emsnp2F/lTgTBtztxeELT4Xxza3QszBNDx+j0FCx
 ADCOGKQQH/k/cBWNK85Dc+RQNZt4APf1SDtb3zaHLp3qJBp1PVg1zEa0=
X-Received: by 2002:a05:690e:d4f:b0:671:505a:9da5 with SMTP id
 956f58d0204a3-6717043657emr809018d50.29.1789660873673; Thu, 17 Sep 2026
 09:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-conform-v1-0-475b2947631a@arm.com>
 <20260904-conform-v1-2-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-2-475b2947631a@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 18:00:35 +0200
X-Gm-Features: AcwNN1VF3lAsmB7PVvVydR3deZP48ZrXakZjprEscotWKGWmnYLhJ3qz8BqwSWE
Message-ID: <CAC_iWjL4YH5kAnB1cuy3mDeyWjo0=41x0tjetViJXkvGQBd4wA@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi_loader: add EBBR 2.2-2.4 ECPT entries
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Vincent

Thanks fo fixing this and apologies for the delayed response.

[...]

> ---
>  include/efi_api.h                | 12 ++++++++++
>  lib/efi_loader/Kconfig           | 52 ++++++++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_conformance.c |  9 +++++++
>  3 files changed, 73 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h

[...]

>
> +config HAVE_EFI_EBBR_2_2
> +       bool
> +       depends on HAVE_EFI_EBBR_2_1
> +       depends on EFI_TCG2_PROTOCOL || !TPM_V2
> +       depends on EFI_CAPSULE_ON_DISK || !EFI_HAVE_CAPSULE_SUPPORT
> +       default y
> +
> +config HAVE_EFI_EBBR_2_3
> +       bool
> +       depends on HAVE_EFI_EBBR_2_2
> +       depends on EFI_CAPSULE_AUTHENTICATE || !EFI_HAVE_CAPSULE_SUPPORT
> +       depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT || !EFI_HAVE_CAPSULE_SUPPORT
> +       depends on EFI_BOOTMGR
> +       depends on BOOTMETH_EFI_BOOTMGR

I don't think we need this. The EFI_BOOTMGR should be enough, this is
the additional bootflow and bootmethods.

Other than that it looks correct to me.
Heinrich, do you want me to fix this up on merge and send a PR ?

Cheers
/Ilias


> +       default y
> +
> +config HAVE_EFI_EBBR_2_4
> +       bool
> +       depends on HAVE_EFI_EBBR_2_3
> +       default y
> +
>  config EFI_ECPT
>         bool "Enable the UEFI ECPT generation"
>         default y
> @@ -593,6 +614,37 @@ config EFI_EBBR_2_1_CONFORMANCE
>           Enabling this option adds the Embedded Base Boot Requirements (EBBR)
>           v2.1 conformance entry to the ECPT.
>
> +config EFI_EBBR_2_2_CONFORMANCE
> +       bool "Add the EBBR v2.2 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_2
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +         v2.2 conformance entry to the ECPT.
> +
> +         Version 2.2 adds requirements around TCG2 and capsule "on disk".
> +
> +config EFI_EBBR_2_3_CONFORMANCE
> +       bool "Add the EBBR v2.3 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_3
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +         v2.3 conformance entry to the ECPT.
> +
> +         Version 2.3 adds requirements around authenticated capsules in FMP
> +         format and the boot manager.
> +
> +config EFI_EBBR_2_4_CONFORMANCE
> +       bool "Add the EBBR v2.4 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_4
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +         v2.4 conformance entry to the ECPT.
> +
> +         Version 2.4 adds non-UEFI requirements.
> +
>  config EFI_CONSOLE_DISABLE_ANSI
>         bool "Disable ANSI escape sequence queries for console size"
>         help
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> index 470141af483..c1234681bb6 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -29,6 +29,15 @@ efi_status_t efi_ecpt_register(void)
>         #if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
>                 EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
>         #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_2_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
> +       #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_3_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
> +       #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_4_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
> +       #endif
>         };
>
>         ecpt_size = sizeof(profiles)
>
> --
> 2.53.0
>
