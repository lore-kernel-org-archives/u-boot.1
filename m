Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD20C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6B580657;
	Sat, 18 Jan 2025 05:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OJ2wdVLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CB48070C; Sat, 18 Jan 2025 05:32:59 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4783C8036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so128060066b.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174777; x=1737779577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBGNILwQIh+7Bo5kyXCmiQkOBWo2jGIp6+2TAFefKE4=;
 b=OJ2wdVLcVBzN7i8iCovOATx+Bqi8y4tpXoF+HCnjYR/SroSbLB52MAACRxlLO8tbnc
 aMl1/QsT/oYo5hrv0GEJCFl3CyflbyLcCw41KYXeiD1MYhS5iuqTV+ny13ujzU5qEHNI
 cEJnTgriTeehioVxCVLdFTmfF4V/Xz7cq1Gx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174777; x=1737779577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBGNILwQIh+7Bo5kyXCmiQkOBWo2jGIp6+2TAFefKE4=;
 b=qIRuBeHs3DUnKpGf+qAbjLUDjOaVfyx59IUSrvyeQbmiI/a3y42YtPYUTocxLF9Wbf
 dzD9KhKfj1cssXpR90Bgn0RnUFCdpBzdjrFOy7LKbZwY6Zjs3oMNBdvhiPapnjzGm4Tm
 vEJRVmi3Tda0VIZmZz1WenpPMt6KluQO6mNclVhEZAlLi7zOhY7wu4VNC0iewxNNhxy4
 7oDQtB2KubKfnJf5HrTLWOSJk0RYd8S3+olSHqb9NKTvUxZCkW/SWDBSdhfrjO2909h3
 691SeULQhczLGzatYve2SYPx4apnzS51vL1ZGRNv85SL3D9TFs8swjFc1bI9a+9b23rP
 6UoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOh/4F/+5S7+Dc4CAzGxz6z4glryiSvaJrmolJL7+XFXhlxKzx/xuRJ0IZ8qNVsYIyJEVd+jI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0+mQT1cerVkcraESqd9bWSK7MK1i/F0ekK6vBum0oipU/Klus
 iROGUW9vXuE65QSvdqM18YtmRGWSeKVuau/tCMaHN4c68aX3kpYZJHCCcYtSkq3XeltD1D8ougM
 kiItzvlsqgqG5Q0GYFlnvP7F12d/4f13ZxYYS
X-Gm-Gg: ASbGncsorH+3g9TnRN8I4by8y9afp55tMI6gP/o02u0/cO0mWBK4rjoccHer3+51OUv
 UXWmf6uaAnbfgRDFJDXtANAose2V0T1qQTjTBbaxx2ky8FmQVTPYEVDq6wLhFV2r1v0O810ntwU
 J0khe3lNIm
X-Google-Smtp-Source: AGHT+IEu5OvX7QjLtGzmawRR4zWizgWjpxA2zlM0cIbB14sqj5RPF68bEaL80eK3ibCgnFa7lsMltyUicySxbF/7Hcw=
X-Received: by 2002:a17:907:7e93:b0:aa6:6ea7:e5a7 with SMTP id
 a640c23a62f3a-ab38b190f6dmr486997766b.28.1737174776690; Fri, 17 Jan 2025
 20:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
 <20250117-clarify-probe-after-bind-v1-1-273f046ce5dd@linaro.org>
In-Reply-To: <20250117-clarify-probe-after-bind-v1-1-273f046ce5dd@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:32:42 -0800
X-Gm-Features: AbW1kva2PNIrtk2i-dWgh9MhOXSPJAw48rABJelSDc3aLqblzdkEnGZmN_kHr8c
Message-ID: <CAFLszThQZfmjp1rQqgT1_GgT8apyMEw3YfMqM9=CWdzF1WGUkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: clarify DM_FLAG_PROBE_AFTER_BIND behaviour
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Caleb,

On Fri, 17 Jan 2025 at 00:29, Caleb Connolly <caleb.connolly@linaro.org>
wrote:
>
> The DM_FLAG_PROBE_AFTER_BIND flag only makes sense on a per-device
> basis, however recently added documentation as well as some confused
> drivers imply that it might be added to a driver definition, this does
> nothing.
>
> Clarify the new documentation and expand on the comment by the
> definition to point people in the right direction.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Anecdotally, I've spent several hours being confused about this flag,
> this information would have helped me greatly.
> ---
>  doc/develop/driver-model/design.rst | 6 ++++--
>  include/dm/device.h                 | 5 ++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/doc/develop/driver-model/design.rst
b/doc/develop/driver-model/design.rst
> index 92f638a02047..30093737200c 100644
> --- a/doc/develop/driver-model/design.rst
> +++ b/doc/develop/driver-model/design.rst
> @@ -842,10 +842,12 @@ steps (see device_probe()):
>        cause the uclass to do some housekeeping to record the device as
>        activated and 'known' by the uclass.
>
>  For some platforms, certain devices must be probed to get the platform
into
> -a working state. To help with this, drivers marked with
DM_FLAG_PROBE_AFTER_BIND
> -will be probed immediately after all devices are bound. For now, this
happens in
> +a working state. To help with this, devices marked with
DM_FLAG_PROBE_AFTER_BIND
> +will be probed immediately after all devices are bound. This flag must
be set
> +on the device in its ``bind()`` function with
> +``dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND)``. For now, this happens in
>  SPL, before relocation and after relocation. See the call to
``dm_autoprobe()``
>  for where this is done.
>
>  The auto-probe feature is tricky because it bypasses the normal ordering
of
> diff --git a/include/dm/device.h b/include/dm/device.h
> index add67f9ec06f..678cd83c2716 100644
> --- a/include/dm/device.h
> +++ b/include/dm/device.h
> @@ -80,9 +80,12 @@ struct driver_info;
>   * e.g. for clock, which need to be active during the device-removal
phase.
>   */
>  #define DM_FLAG_VITAL                  (1 << 14)
>
> -/* Device must be probed after it was bound */
> +/* Device must be probed after it was bound. This flag is per-device and
does
> + * nothing if set on a U_BOOT_DRIVER() definition. Apply it with
> + * dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND) in the devices bind
function.
> + */
>  #define DM_FLAG_PROBE_AFTER_BIND       (1 << 15)
>
>  /*
>   * One or multiple of these flags are passed to device_remove() so that
>
> --
> 2.48.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Any interest in writing a test for this feature? We have already found a
few bugs.

Regards,
Simon
