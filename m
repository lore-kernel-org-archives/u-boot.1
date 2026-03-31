Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320FFF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2249E83E7A;
	Tue, 31 Mar 2026 21:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RiQMeDP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A0684035; Tue, 31 Mar 2026 21:45:40 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3B583AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66b2f6e983bso7612539a12.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986338; cv=none;
 d=google.com; s=arc-20240605;
 b=W08pBus5EVCXVACP5/lBhHNzSKbcx4pSNa83VoEkX+iEg/t7QxQ1gat5NoQRSMZtDU
 Darg/EO99InHisstB8k1jGLTFlEg+b/6GMN8CgZX+ay2I9zST6qxQ1guifasN7n11Ida
 HUAwkfQirxODBW2PGDjjdNUIUUsj0Iz/MYqMfGdOmPYHg/SzPr1+BoMqHgw3jPcwU+Nq
 U2zrYuNy+PN17XhkWdz66YC9YaSZAL+6PSgkmfrKuuSuzB/ZpKrGkA+Filx4TMtP4sDO
 2NfFFPu42KAJ78LhXmhizC7gv/uyCT+b7n+wpB4cS5kJLrTZ8pRwhDIVHVGoJcVh8vck
 iu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/EkJtZ/gkTyZnO5BgDbhmDTlK98tUnZhzkUrcsqKV04=;
 fh=JCdJx2K0GBN+AZ87mZvEOR0LWNhHB5OW78s5AN5Hw+A=;
 b=EEqdx9USCImlo9afQGICauoM27BZUpYLx4ljx42hwA6Lir+qkQqjRyKnEsNxej73Fk
 RlnfIAMwOF1jMuShTpNNx4SRtZ3qxbSoa7TggdeNb/7lg/R2pkpOXtfKMXDf11c81+H1
 b4oF93w6OiTu1pp5nGB9z0TrcG8T9pv3hTK/7JnXzn33ksTtnnkEjTjNL/ZkZmF+UYRT
 ytjbP+meORMyOja19c/J0cBcNgc3oBBc/CA/hng+Y0mmY6ES1hRGXfE3t3EZyi8N5oJD
 FcQUc4Xdn//og6mdcxjkb+nKubrvNk/80HrX6YwozOr4N0e7qQbOvJbjtDC9SeoAJp1U
 kYEA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986338; x=1775591138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/EkJtZ/gkTyZnO5BgDbhmDTlK98tUnZhzkUrcsqKV04=;
 b=RiQMeDP5sbkHKP3tdZ288vRcjAQAPBSK5ffD18UF5kbJ64Vn9ONjw1HIduuHSYOYNO
 HkNHtQUmlMqGjV7/Yp37tH60AjH8KbYgPOBlqqwUgKcFQFGPLFprCjyFEZYZcbtJwOIN
 aCSlu98BdtrehcnflWtTJFvHuw/VRIE8TuM9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986338; x=1775591138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EkJtZ/gkTyZnO5BgDbhmDTlK98tUnZhzkUrcsqKV04=;
 b=ihI4S3rEfceajwfOFbbbpSt9jQNpQoWijcNotm8HtyxOvg6kPd/UDNVC7I3YACmQLD
 xJaxiem0FixgvwU8Y9RVRnKw29x5eFzIqY6fvr9b1Sy7QP3T4lg7XR3DYGBWIsSQPmJM
 NntO7NnNKDCO19XIzajboP9YTGLYXU5kB8TKJ57IvBGds409yXb1OSacjX6ZHZN8MDtd
 jyqsX3e9eA5aTSZtBiySUHyEEGf+dVCaYXM7IaNpDbTnGmMe3f7WSh2U2zBXnoR6N2ZD
 eZ0fGl6Bz61VMFObLaWDvCYggvyCSzQ9xSldtTqlyEmk4eWbMnpsfUxGuRAgb1aSSABO
 lyCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8/U0dOFLF10zGmDg85WmBMWaRtrapwQxzhynnjypkFxVpS9Yrqjm1A4u4nYL9lP/u85RG0pk=@lists.denx.de
X-Gm-Message-State: AOJu0YyILCdmyXowJhYHDBCtxJR4ygLXJHHNbVMqOjS9KQ6Dk8F5/M7D
 qa6xtGOa2GyjVoo1VhwUvlBQIs8nhC+00smdiyPGKGZ/OaPCh9qy3NfQ1z9yEiPj5xwnYWJIA9m
 1P6g5tsqaDW7UpQayHRW4mOAq8739DXSCX+Wj0dHT
X-Gm-Gg: ATEYQzyHclq7ziTvl2/S8V5aJhmhPi2TySwUfKOL42uTEj6uVRUCdqo7SMP3db2z4tC
 8NWtVomclxffvpTl4Qfq+Ygr+3ZqJtZdkdg073hroRO+5H4V+t4TEDkmIXI6hhS+338M831bzJQ
 xHQ3y2LdnACcU4h1Wj1mgDThBFlMPWOEAa2SYf0qNVDS/Mo0nh2WPZ/Z16fNHuDZix6ZF3SuO7j
 eURNzwJg2iQ5G5/8jEYH6e07h+eY5Ezjgo++GRnVPmkACMzVAHoqKCU6hjsC92WX5NWUXgRlmVC
 9OPOxQ==
X-Received: by 2002:a17:907:c784:b0:b9b:207c:f7b7 with SMTP id
 a640c23a62f3a-b9c1378f253mr67125166b.3.1774986337807; Tue, 31 Mar 2026
 12:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-4-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-4-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:45:25 -0400
X-Gm-Features: AQROBzAsu7tb48NGC7nw2zXBKNltbITuqyg0vsIz_9tj4OVbXl-4oLT1nG8AKuQ
Message-ID: <CAFLszTiMoTYAnA550-Pys8UDiBg9fH1cvCs7O5Gj5E1Tuk_tRQ@mail.gmail.com>
Subject: Re: [v3,3/7] mach-snapdragon: Integrate reboot-mode handling
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com, 
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com, 
 mkorpershoek@kernel.org, hs@nabladev.com, marek.vasut+renesas@mailbox.org, 
 msp@baylibre.com, dinesh.maniyam@altera.com, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de, 
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
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

Hi Aswin,

On 2026-03-30T17:14:12, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
> +static void qcom_handle_reboot_mode(void)
> +{

The function is defined unconditionally but only called inside #if
IS_ENABLED(CONFIG_DM_REBOOT_MODE)

How about just adding 'if (!IS_ENABLED(CONFIG_DM_REBOOT_MODE)) return'
in the function?

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
> +             printf("Entering fastboot mode due to reboot reason...\n");

The rest of this file uses the logging subsystem ('log_info',
'log_warning', etc.) with LOG_CATEGORY set to LOGC_BOARD. Do you want
to do the same here?

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
> +             run_command("run fastboot", 0);

Worth at least logging a warning if 'run_command' returns non-zero, so
the user knows something went wrong.

Regards,
Simon
