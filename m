Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE94C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3187034;
	Tue, 24 Oct 2023 10:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="tjUP3d62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4493B87120; Tue, 24 Oct 2023 10:28:00 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3CC87026
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a87ac9d245so43222517b3.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1698136076; x=1698740876;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=er0D90AWkmRHfElnAVoAQIuqbJ/SHNfl/9Gb33bQTpc=;
 b=tjUP3d625XJ3tSca7NWlHH+2ptZa+j0RP2o/xTeeUSmmo4prfj9hSFfaG71sJKyKSP
 rS6XFtFUpq+amLtZ9zTTmt4/7o6gaCR5qJwlWaUggSZKJSfi9MD1GYPsPMUsADr/x+zZ
 n31Hx9DdDgF44favhaqj8at8krtMZ5QAfuhtoCvnbQ6CQgDIYlqdFPLr8YMEeRMswACz
 1gIQ8DnadNnOPZmIO62FHBsGk/DNnjKksKF7V0UyVMN/OsbPUUF9cmh50ZJjsgg+fHRA
 X0qNNaWqOH8l6SQn24TJsT8AkwVG54iBO3KcwWUOyxhq0LiiOL1Vuxnc/y03bium+rrq
 Uh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136076; x=1698740876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=er0D90AWkmRHfElnAVoAQIuqbJ/SHNfl/9Gb33bQTpc=;
 b=iqnhPyqJsuYlDNIYDl16y84HDQK7ZEVi6LAYjeY8GAD1HxKDPFO/tsg5VwePoplCR3
 s01S5wC6As7WE3N8q99Xo6GEc5OjUncf3PXc+sIBRPcdW0Pcg1DTRozcJ1oJA+P8hrtx
 ouR7O01VTQuKJPfIGoJeTaaCfBOgPm4awkKuSS9cMuckbzCOZx52SAS2mnJRRHe/xhSe
 ej/1wNEBvLIvg7NDcMkghqxtZgwKIFNGoH3Dp3nICw7wold56q3ABBT2D4DUZUiBP4zN
 xGwEUCWhEpHLzbSaaeE6+LAX0albLGyd1yFCJG+litA6LOyF28AeJeSOxA3ooi+45DrP
 eIUg==
X-Gm-Message-State: AOJu0YyEDyrMqD6swcxslG1nypa20pqDBRv/iI+OPS+SMt77T3xH6QKa
 LBJ11+WtRqoEMuUBDV0bCenvgjtQ/ovqNVg9fI7FYw==
X-Google-Smtp-Source: AGHT+IGbnrt+i+OLldyEL8iOjpLZdROepiWHXWgLmMADHirgUz5FWOxPkr1J93k/GiO+wc/B/34wrUrVBD22W9fJw0k=
X-Received: by 2002:a81:5216:0:b0:58e:a9d3:bf98 with SMTP id
 g22-20020a815216000000b0058ea9d3bf98mr12378040ywb.27.1698136075965; Tue, 24
 Oct 2023 01:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-15-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-15-takahiro.akashi@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 24 Oct 2023 10:27:44 +0200
Message-ID: <CAHTX3d+hU2e-Un244wVzmeanwXkG+cy7+LdLZxYVojM3kX__5Q@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] cmd: add scmi command for SCMI firmware
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, etienne.carriere@st.com, 
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Takahiro,

=C3=BAt 26. 9. 2023 v 9:00 odes=C3=ADlatel AKASHI Takahiro
<takahiro.akashi@linaro.org> napsal:
>
> This command, "scmi", may provide a command line interface to various SCM=
I
> protocols. It supports at least initially SCMI base protocol and is
> intended mainly for debug purpose.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v3
> * describe that arguments are in hex at a help message
> * modify the code for dynamically allocated agent names
> v2
> * remove sub command category, 'scmi base', for simplicity
> ---
>  cmd/Kconfig  |   9 ++
>  cmd/Makefile |   1 +
>  cmd/scmi.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 347 insertions(+)
>  create mode 100644 cmd/scmi.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 43ca10f69ccf..f46152ace7d8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2533,6 +2533,15 @@ config CMD_CROS_EC
>           a number of sub-commands for performing EC tasks such as
>           updating its flash, accessing a small saved context area
>           and talking to the I2C bus behind the EC (if there is one).
> +
> +config CMD_SCMI
> +       bool "Enable scmi command"
> +       depends on SCMI_FIRMWARE
> +       default n

This line above is wrong and this was removed from v6 with
"drop scmi command which was intended to be used for debugging".
It is fine that it shouldn't be used on production system but it
doesn't mean that
it should be actually removed.
It is useful for bring ups. Can we get this patch merged? It was
already reviewed
anyway.

Thanks,
Michal
