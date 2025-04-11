Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E838BC369AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3998084202;
	Fri, 11 Apr 2025 20:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NX3pA4ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F66684209; Fri, 11 Apr 2025 20:10:40 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D655684201
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2d0920ce388so574821fac.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744395036; x=1744999836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMsOqZWibxnMRgzVx0o3FWgtbchZR/F0UNE0WUnoxxE=;
 b=NX3pA4gaJRsR/IYGFVcQbyCpT/IiNMwJaQlZvBm2dhjO/8a2W81c9QlPWe+ExOkMwL
 sANd7pJZquXxkD7QPCU/caFiph3RycHTg1kNPVlVeZw1YnfoEtm/OmSnU44ENAOWvrrt
 iYKumNlS7xAW2bRneFAXvWb0gTAXSmK6AuuOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395036; x=1744999836;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMsOqZWibxnMRgzVx0o3FWgtbchZR/F0UNE0WUnoxxE=;
 b=R5PQgW7o7bipZkMX56XoOHzMr7sNmxABJcVtAEi3olMIJh7oZigCjpBbJDwx0ZWvbF
 N+FpwsNqH7p5uB6k8gnuzguPf+fjNseelWyzElURSjm2z3Ii6l2AMPsjB8Mpj421wcx/
 kIV9qudDBWLCR+RWt1Y19/EnuXXSPI1FhMISESxZKEs8g1bCflMWUVOWzxBsfrJm/uSO
 nVmdu0FHD9GQuhCg8yVGsDn8go2lbF6sNpxTuuLj2uahU/ZoN97uGOUPInR3FXCd/At1
 /dNVSSqjM7GJR0VwIiQ8a6LrRk+rKmyQvlRjH1ixgS8wcYL2G+EIqNGxqZdW1YD7VUTT
 k8vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1LSSlMDHP/vhIvPH36G0TMzduWMrxs5/tWtKYYT/tE3yJVF28z+S1ucu/9enBcDKgYoA1u70=@lists.denx.de
X-Gm-Message-State: AOJu0YyrozCvHalJ8Vj0R3/VrJCQgekcBeBhc6yDhyYFruDug3a2rO5U
 dF1k7V4+rWE3yuO0PssakwLhtAbTCsnTQzcrVIxvop19bmEVkII8e8FL1HYM0Y3YMHc2hVi27CP
 Y8nE=
X-Gm-Gg: ASbGncvF0olJYVaEeoOB8j9Tbt9vO508UKzyBp4S11LlXiV3emiYrYAWez3fV+NwVKY
 MRyaeRzRshIqxGqFoSIVsXrJ2eT+/8Hrx7YfJRqY59jWrsSOt1GwCJZuQcCq76HHfj7xCjI32ak
 DRglm3TkJqiqVmbX9xTE3GGJ3xTjBE7nUdMLQNtBeGxgWjbYeZsrMLkwzvUv9W1X92wNtiODGiP
 jyvWLgboykZBGTRS6KkwXVhwKe9+p2/iSrl+ld+SfJ+0wwbEyfQKax3iW8diTZwWrSBo5CyD/5u
 cbn4RVbHo0xxZNPr19uQHZb93N7Geh+d9kQDTpXrpIpiboj5/u3PyqQlPPbr5931ax7rVGgGYtv
 u
X-Google-Smtp-Source: AGHT+IGmBdcI1SVkIJfWOb86sX/mbtSMzVRomvo2RAqgh1wfLDJ4MR4bjl7T3XLXf+eTJE6B2cbdbw==
X-Received: by 2002:a05:6870:63aa:b0:2d0:3078:e72f with SMTP id
 586e51a60fabf-2d0d5f4dca5mr2057243fac.26.1744395036364; 
 Fri, 11 Apr 2025 11:10:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096a20194sm1261969fac.30.2025.04.11.11.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:10:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250411143052.2630675-1-caleb.connolly@linaro.org>
References: <20250411143052.2630675-1-caleb.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-for-2025.07
Message-Id: <174439503486.3256164.12253880920599725538.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 12:10:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 11 Apr 2025 16:30:41 +0200, Caleb Connolly wrote:

> There's been a surprising amount of activity lately on the Qualcomm
> side with the two oldest boards getting some fresh attention and a lot
> of cleanup and polish going on across the board.
> 
> * SDM660 gets USB phy fixes and a pinctrl driver
> * The recently added SA8775P/QCS9100 SoC gets a pinctrl driver
> * The Qualcomm pinctrl driver now handles reserved pins correctly,
>   fixing crashes on some boards when running "gpio status -a"
> * OF_UPSTREAM_BUILD_VENDOR is enabled in qcom_defconfig
> * SDM845 and SC7280 get missing clocks added (since we're now stricter
>   about those). This gets USB working more reliably in more cases.
> * DM_USB_GADGET is enabled for all boards using DWC3 and fasbtoot is
>   enabled too
> * A bug in the livetree fixup code is fixed (making USB work on a lot
>   more platforms)
> * Button label lookup is made case insensitive
> * bootretry becomes more dynamic, allowing it to be hijacked to make a
>   "persistent" boot menu that allows dropping to U-Boot shell later on
> * A new qcom-phone.config fragment is added along with a phone-specific
>   default environment and phone-specific debugging/bringup docs. These
>   make U-Boot more usable on devices without a serial port or keyboard.
> * The db820c gets fixed up and updated documentation
> * The db410c also gets some love and modernisation as well as a new
>   reviewer.
> * A new driver is added for the USB VBUS regulator found on various
>   Qualcomm PMICs
> * The Qualcomm SPMI driver gets some fixes and cleanup for SPMI v5 and
>   v7 support.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


