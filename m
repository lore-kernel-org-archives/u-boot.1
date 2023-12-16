Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27190C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064D187CCE;
	Sat, 16 Dec 2023 19:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g91OkH5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30EFD87C86; Sat, 16 Dec 2023 19:48:44 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33A587C87
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b71b10391aso91216139f.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m73D2wxkSXlvDolSNVk8DcrGk1NMm2Whwru1CzPzArc=;
 b=g91OkH5fGsIllSsAf7OZmFYZd+wKabmPT7V3MLgX4pjva7pCt1J2sZeJL2ryaQ/gS3
 YEwf1IHSTvIh6sq5FoORmbS1xwtLT6fPxKd4RhrEKR+Ox+0YuTlNqnVm8fMTkxvDMjo4
 45jV3sGfRnVIIzi1Mk49Euhx2I51MSXcUTpnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m73D2wxkSXlvDolSNVk8DcrGk1NMm2Whwru1CzPzArc=;
 b=jIt6/qhFusTflz0hd/scqlwDPn+AaHTvUhk6lfpn+eha3H674YacCbGN4kRiC1FEW/
 0VCGC4VnALen1G/TRLcTeC9h9S24E5g7dXVeAj4XkjTE7bWK4uB+DsUJog0pr0qVhAI7
 trGXbTqOUiGXr1bOFEL5xnQPm/1U8xETg2noDYoHfp4tECfMmf4s6ZXlyi83SZ/47LzU
 sKASgcmVfgBUcogGmTIXBYtqEaX+vJTp1pZXA7OApvaqrNL4HoslDTQB2HMbrRkTGK60
 O/wy1Kfk2tOr/LUAvxIo8qvyslxDXzfWfcmj7fMoERatK6J5FJzzt4U3bjYomWvllVMP
 TOqA==
X-Gm-Message-State: AOJu0YzDwLf6HABIcsHguZgUefMjELIgRLZBmefMOtu9geVZDXGDkCB1
 DUIrNlOjXJDZ+99rLCBj1b2tQ0dKoWbpJy6kKyhWHXw4kjaurBXrihE=
X-Google-Smtp-Source: AGHT+IGW6YtFF9DQw7jO64fD+ap5l7bO/s0pvTBQwjcJAIGfkgdcAkauUtCpaCk5DEY63GinDFcyGV74rVphUgYtfg4=
X-Received: by 2002:a05:6e02:b4e:b0:35d:6e2e:9d18 with SMTP id
 f14-20020a056e020b4e00b0035d6e2e9d18mr14465789ilu.125.1702752514173; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
 <20231215182658.187516-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215182658.187516-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:15 -0700
Message-ID: <CAPnjgZ3HDTKMHkSVxt_Hc+pv3FGv7ziq9_aaQdm6+MWoDjiL-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cmd: acpi: check HW reduced flag in acpi list
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 11:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On non x86 platforms the hardware reduce flag must be set in the FADT
> table. Write an error message if the flag is missing.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  cmd/acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

This was when the mistake (of using ACPI on ARM) was made...
