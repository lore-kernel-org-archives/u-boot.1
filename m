Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D54CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21810849EE;
	Fri, 26 Jun 2026 12:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWHcaS4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F24E849D1; Fri, 26 Jun 2026 12:40:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37E5849BA
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1214350188so88674866b.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470410; cv=none;
 d=google.com; s=arc-20260327;
 b=Gu7H1sEpIdqEiyy53tL5ktiXVm3xMme6PPm4kO9HnbT3cdNKe+vfShHJI3Gvzfqb6f
 8xfGK5frsG+EeASUEt6DH1Txvi6vpkQlVvtx4B00AEzSvWDqeveohOh/Wtan4YuqR9r5
 qFEZLoQpaW6swGFds7+XUr9kgkWQd5ZtGHrXJQ6hP8WzIhOinCiw/Is2toKb2Wdzm9Hm
 3c1R+ChIACVR0ycc9W2fl0JmwXuIQLy412x2lEf+qLHH65hG8+5AfyxvOOuq9xoFxdMd
 AQc+G2j3e6/S4xKUKKTyZoAEHkim86B0rbArtckHikzOt4pYPnQkwFLzjO6AtgYFKR0y
 Zy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8TZQkYfDYmuGI69Pp7f1EMYqRlaladfwb65MbqB6l3M=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=hqVTr/4J03NdTDwvychhJjaMITrgNCRZadg1DjNABWujy9VMMtFNM3UcTiTu+0KJLF
 imxXCjFrufpm3kl0pNEgOYiXAKcxv4tKoCnMewc8VzXx15lA2BXddNLzxD2qSeF8gK7i
 zsfjwEIZ0wrxIGtBwUyP66vtpcd23GgSJYK0F423vWtRdaH7bNw9GlWeWg2YWbjWsO7W
 mCP8FHHFEhDOFDpMhgo2qZaEsbXfl+WfQZDM+nzmvWulb6GJUIdAbTDPuaGAgiZqOs+b
 z0nV0bF7H0qdPq8qfHR8/1kbg9LU4w0STe990MmmV/TIskbz7gUxyoSCtBfj5RUYAYEz
 6EgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470410; x=1783075210; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8TZQkYfDYmuGI69Pp7f1EMYqRlaladfwb65MbqB6l3M=;
 b=cWHcaS4bFDDFhimhSkvXHXUsQ1ThwnE1BcCz85W/L9sWxNeJK20LUUZ+j4BzxFCN/7
 HIL9j6nVScyvIIexkgMvkYxXuFsYE9ud1JUFGUQhG5QeZ31p4E0dby1mofH6jlQz22hJ
 wBUEk1nPx1xw4I9VqaODXZbMSy9wLLfpffj7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470410; x=1783075210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TZQkYfDYmuGI69Pp7f1EMYqRlaladfwb65MbqB6l3M=;
 b=efHh42pZYetcxhMOERvCh8Vcpo89xW4rC31KcZRL32svr9UKMHIh6ilyyXrMPuCQGU
 odCLRbs5oXx1zaF2LOm2BinZweWweKyLQkXp92mL1JY4arTRCxO4Gk4Qh5jqwdH3qj8E
 QpDe9h6ha2VWuyQA5WnyaxbB98bGDG3hfpOsYHnPyaq2SHvi6tF6xKxGkVIginAkbidI
 ED4khbW1364Z/KHvXzzX0ASZAWBvOR5WDTbK4U1UgGhEQVQaI1MXBaFROopP1WFQgaI7
 vPcQxNAqS0pJGBvOo0uEiw1QgRopS8CQIx7JSCdLIunD7fj/UZqykSzJ07LbKZezm0DH
 XoVw==
X-Gm-Message-State: AOJu0YxN5gw55elI3xLaJug04nSm2qNs9/F/TWZUnMGTBCQJvb0UrRnp
 ybC0e/hKyW8egdVynvwPjF5zLCFyTXJdsYbN5y3FG//vauGDcY5r0sRA7v/Jf35GhFOaojQQ48h
 wnaznYzwqdGo7zpEWoZA9NPQ/Xz6ODvB+XaLn0lRX
X-Gm-Gg: AfdE7cmaaw5NZbmt938DiLIHB8hW37Io6HAi1PCBGyXmFer6HrD8jhqiIeFsvf42CBP
 iV8X1vKcMlWEv9oLiO3d7DmlpCvmUPXlSwzaAmHfTXHLHa94kX1TsJPGK8HC7RN4aPmHheP6qHb
 ErPgqs6Zxb64SW3vhQRse7DEiifMn9WZ4BQDq2dE+MSjoAl37MRmPXOVmJ+GXDPDkDZOjbkYOLU
 HdP9je9DGSA7HEwjo7CC/9YlFJjoeq++4d9ZsKwrIZpYWrNPBpuALDs6fizCadZ+e91OokzfRiM
 bkst1IjB
X-Received: by 2002:a17:906:c116:b0:c12:331a:1317 with SMTP id
 a640c23a62f3a-c12331a1586mr7761766b.18.1782470410272; Fri, 26 Jun 2026
 03:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-6-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-6-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:39:58 +0100
X-Gm-Features: AVVi8CcceSdsA9AwRVcqLsbYnReNCejTwG1SWBD2yaNgSuSOiWOfRpSYVP_ZQIE
Message-ID: <CAFLszTgWdxXhkOsM26afXipAnX3-H2NakA8DT=pCXa-q7SK54Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] qcom_defconfig: enable poweroff command
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
> qcom_defconfig: enable poweroff command
>
> With the newly introduced PM8916 PON driver and support in PSHOLD
> driver, the poweroff command now works on MSM8916 devices.
>
> This should also work on any more recent qcom SoC with a functional PSCI
> implementation in TZ. I confirmed that is the case on my google-sargo
> and oneplus-fajita, at least.
>
> Signed-off-by: Sam Day <me@samcday.com>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
