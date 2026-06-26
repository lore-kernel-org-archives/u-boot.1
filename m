Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B580BCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881CF849EE;
	Fri, 26 Jun 2026 12:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXjKDkr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29BA4849BA; Fri, 26 Jun 2026 12:45:00 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3742C80398
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c122b25cffaso39974566b.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470698; cv=none;
 d=google.com; s=arc-20260327;
 b=l4fRBNW8X9hguxVYoPNgdKazVhyUqwH+IXl/JD7OUSIeVFIloKm0QAObWzXimtMT37
 R/zFgaZe4Kz7rt0PsO4G57Z8qT14kBoo+LTYqF9L8ETik3onaGb5e9rCfaSSycC0U2/T
 EEl2ZYzQ9s65PSLraNA6xoLMfpKO1hWwveFWeLtwQfu0zMvom47e5sHXG5/w0ag+IvCs
 Kqnmm1oQYdM2L6dyEhPx//sUvelNH1m9FLFi7S23O9fNBHvCJrU+vT+Y9REmIyG9FEAC
 ejL9K8nn6dcjrwt3DeRJvdU3QdifmeejgnVkE2iDlzWHbvW2CnsHhyXOt5hnN+9+6UdL
 +Xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Co3UNvXi+2bXMg5nFtJviYDvEgQGbM/u5HQAWNaWnXc=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=aDJ7Re5FbxWGSzWz9bUj3ogTykVjPWkz3bj6p7pERrIsziUPn9HVRP6In2cqCELfQq
 6/5AZie9AlVBKIsmpgkbOLSXreN7mWjGetY+PrLgDfY7Sc6sg5P9RbfamNoRWoWTZEBo
 5B+vmWBNrQsxLVp1dHvSjWbZVuozw8vFiCKNAa+nxziF+FUINdkMve+DMxAmTAGAo46h
 oYtAMq3K7b5/30i62KBcAikjyAYhpTdoA2ncRhIeQfXhdYOqG5yMCImHo8nNOmY7mw3a
 aBdfbhCQqvlUSC26BnniEjoxYB30lmkntTE4CAMAIZ0DqlwQcZZLxQY+6QaWxyi11nPT
 /8DQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470698; x=1783075498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Co3UNvXi+2bXMg5nFtJviYDvEgQGbM/u5HQAWNaWnXc=;
 b=VXjKDkr3bzznr80DFF2a11k5EBgp6Z1klmm+sswhjVpbeeJY+Sv9JpUVsUK1aoQ0SW
 UmJhMkfCnKrgjfU7RMOessoa3h7RaHFeVyexwG1X8MeY4B/TzghWO4P6LWjbjYfrRHBE
 iicmLNeIr1GPzgRbWSTU1f7WsErPrq6PL0sGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470698; x=1783075498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co3UNvXi+2bXMg5nFtJviYDvEgQGbM/u5HQAWNaWnXc=;
 b=T8NUqH5a4SkN59nhBrWbuda/IIfwT8a2MgiW4uwG3bWloyg8xI+c4BHpy8DxoiNbSt
 M1zZU93qQDUd3j6M3AJSQZPvy2DQEfhwOPoy8ndH+G5F6paJHFqSBmF3RncPAA4EL/lz
 QnEMkGRTYKqut/+JtEBxsWse9bTK6RGnC/h586IN/aAW+Opm/w4WwP30Glpf8u82vtbF
 1mHl+YI4rc3uRmbDV83gGxNqSNzcRC9OYmlrC6nd3l+qKmtHMvcP/k/5uSKiXmNGji6J
 /e6KKGTpxS8obEuTNh9hhiJWDUC2HPxbBmuSCHIXG6SmJYOD2zsKCw3UlsrAFAXayi9O
 IMDw==
X-Gm-Message-State: AOJu0YwsZeqKE+UvZUNycmW4+AErPUrvwEjduB1LtWPioqcuSDvyuSiQ
 JupjFunryO9hd/AZ3hXLD/5p8UgPjkVrc5ydTIyKmTu9g3WnrmK6+D0bfj22HDTAIgWgFd4qpFQ
 lwRzs7T2QWi3JXVkDPseUKnyZ4pweIv9wnk2hQfW3
X-Gm-Gg: AfdE7cknZHLvKOTSjIOIzWrGHRka6M0Rkh5Qr31HA5dehfGwy0m3riPclyv9F/MyelQ
 EU7Cn8YW9NrtPsvP/bZU2CYDPH08yuCGAq7JVft1YZPjxiwH/MVKo+J599N1LlUv0NJCWy0CAes
 /yB5h6NS18esOS3szKJ5y6WvCaZjCuqdO+w3bqR5gVNHpCvK2Vl/mmXMPqISVu4ocer2P98SNGt
 d5v5QyRFkSGx3JbnxCMsC7r5osSMzaYYlBi/PZ9tAk3X27FsWVOSrw6wKRcszkys2Tl4flha554
 n9mrg7Vx
X-Received: by 2002:a17:907:728a:b0:c11:f52a:4e70 with SMTP id
 a640c23a62f3a-c12061aca45mr399522566b.44.1782470697710; Fri, 26 Jun 2026
 03:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-11-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-11-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:44:45 +0100
X-Gm-Features: AVVi8Cd42NW27eN1yGMTkDf59u-URbAiXV-UjiEvqIrWflvVlUimCljNGiKRZOI
Message-ID: <CAFLszTjAkPWgjXtu6fKPtw3dRXTR2WErMHNrSV9cQ9_rLkwTRA@mail.gmail.com>
Subject: Re: [PATCH 11/11] qcom_defconfig: enable reboot modes
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> qcom_defconfig: enable reboot modes
>
> Now that there's a PM8916 PON reboot-mode driver, it's worth enabling
> the reboot-mode DM uclass. Additionally the newly introduced fastboot
> support for setting reboot modes is enabled.
>
> Signed-off-by: Sam Day <me@samcday.com>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
