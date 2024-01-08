Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2491C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2726687A82;
	Mon,  8 Jan 2024 01:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eH2j9kay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657D787A9B; Mon,  8 Jan 2024 01:16:35 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C02687A60
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78315243c11so103607085a.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672987; x=1705277787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DumTl8UylEYj2c4022A9wXHBifufO9hKgLzUQFVoUpM=;
 b=eH2j9kayEKzF9l97PJyBFnO8u62DpHPvHL6K0lhFul0sPgcuGWLfFzveTQoLOKmX5J
 llTt6hFn7WT28UbTOE4HGNyaCMNT6UbEijtKxFAqhFOiutVLMBygPSs7DdJ5uI1OaIBs
 l3jVxJ+IMJXsOnrFvJErKGk+VD6r2jz5r7h+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672987; x=1705277787;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DumTl8UylEYj2c4022A9wXHBifufO9hKgLzUQFVoUpM=;
 b=C2ETN14DRlB2iMNn8/mPlo7WqNWKO0j+HbjYHxzKNl0sVQcpzr1HhUfG63pxL/mY3J
 WCajDxseKckUeZfQT2ln5JHjAcxZl6js+E2F5OY94+2m/fcEkWADcvqNZkydGGSFMs7K
 Wy1lIDyU19ieIRgCOYgjgcz0W8YMRs2uH6fruy+KuS2cvWXM5LcdWVufaveT1eV9l36j
 8ReKVAo5ixdKVFeNW4tg6kA4s9lEDDxjCxQdFeuprj/ZrfjREGsu6ZO3rf0EQfAfE13C
 Xi1YOUriYHSqvlDoV+YTuBJ9Gvchq8WA72IdYWDMfWpBU83IOV0z58Wt/2U40NclEoOO
 D7/w==
X-Gm-Message-State: AOJu0YyTjagirE0b3I6W4MVEvLwp4fMRmE/H3XJ2ZHqIamH6hqoeXma+
 q3PlCwDxFFDsm673b+JvjKfTN1gbq273f2OPqzhJLvHI45sw
X-Google-Smtp-Source: AGHT+IFreHl43psscXxe9NNZ0zV362CR8VPkV41bGKHZnEO3JhxP3Ax7ImuSe6tbVlXwF7NCaYzywkHpBKl7W8nXSCQ=
X-Received: by 2002:a05:6214:1c8d:b0:67f:4867:2ec9 with SMTP id
 ib13-20020a0562141c8d00b0067f48672ec9mr3027981qvb.16.1704672987148; Sun, 07
 Jan 2024 16:16:27 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:26 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <ZY52HXjJGruD7fM3@hades>
References: <ZY52HXjJGruD7fM3@hades>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-6-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:26 -0600
X-Google-Sender-Auth: KRhl1RAjUsk5nnshjCRPfL7EqLM
Message-ID: <CAFLszTia7HvFnFmZv7HecebfiQP6zceAB_ZOfcAiwzcb=mT4oQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] acpi: enable writing ACPI tables on QEMU
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, Dec 19, 2023 at 04:04:04PM +0100, Heinrich Schuchardt wrote:
> Invoke write_acpi_tables() via EVT_LAST_STAGE_INIT on QEMU except on X86.
> X86 calls write_acpi_tables() in write_tables().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	new patch
> ---
>  drivers/misc/qfw_acpi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
Applied to u-boot-dm/next, thanks!
