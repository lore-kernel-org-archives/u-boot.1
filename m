Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F58D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D996589117;
	Mon, 28 Oct 2024 18:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gEkRxY2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE6C890B3; Mon, 28 Oct 2024 18:04:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046FB89119
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so749946766b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135089; x=1730739889; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VbcwYq0+Cu8848NmeF80UEJs+lz+xPlX9ORO2cXgbJQ=;
 b=gEkRxY2qIpGQoWMeZ+cMXIHA3T/eMUZyLso2Its7kjnBcwNmB9t/lqELKUQO7av8ko
 /K/uDJzeoRIYrNw2O6SwPUO06/7XLVtAy0pK5RcD+XegoJxO/vSg9VeYvIcT/E41GSCd
 6XwpqDpFDlmdSgF1ljSX2TB8rrAp71o3wTJeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135089; x=1730739889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbcwYq0+Cu8848NmeF80UEJs+lz+xPlX9ORO2cXgbJQ=;
 b=cSpqI51tNdNDUTBobULnUMhzty1YYGPnl4Ywzly0q/tRpFygbXWlHpdF6LBeyEUPbJ
 V+vnxHZIvdnRmxWz02SUYiVM4KWX5Xopue2V/Tq970+Sts+9jKXp5klsaLfrBYfxPfkH
 +fCy57xVZmHD4WXGcqdztldV2tyRrLDf7VIM5RU2hxw46UId6jreO8qlCA19KDByfl1g
 Hf/O8NavZCw3+/mXBUcMLtNH5bZE/trtMjJmv1NygGtudaAVXb94IEPq4RtsWZxFo+aO
 4JF0YDhp0t33nH9ItQEoh5DPzc7YlrKOv/ihciB0NHfWjsb/s6bfSUhMymPXU1LEUeCs
 HXKQ==
X-Gm-Message-State: AOJu0YxR5t/v3GZPVf8H+MbRcXBAeM/UDt9hyD5DSLYSXSVfo3E9cf+3
 XLFkP1yWeE6CPbubORYRS1CU/upMLTeZqloTbyZP8UV6bS8VhkHs97NTCwwpQ03LR9ydVYf7s9J
 rAQfPEziD6x7fS1E6M2dbJDbPpefFPv+tNp5K
X-Google-Smtp-Source: AGHT+IHruuG/bzQIbtvTPwGPKasSV8ah34q03XTALuiO7B3VsRzG/FcFjBVGSPLD82Tlr65txp54+O4oqfS8UZRrcyk=
X-Received: by 2002:a17:907:9712:b0:a9a:55de:11f4 with SMTP id
 a640c23a62f3a-a9de6191f51mr883016766b.54.1730135089447; Mon, 28 Oct 2024
 10:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-5-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-5-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:04:26 +0100
Message-ID: <CAFLszTi6hMrArrJFJpc+jfh_aCBsSCUsYpkDhYF6255y8Bpd0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] smbios: Refactor smbios library
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Angelo Dureghello <angelo@kernel-space.org>, 
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Raymond,

On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Current smbios library does not fully match to the specification.
> It hardcodes values instead of exposing values from the device.
> It does not support dynamic length for contained object handles
> or elements and misses the handling of a few of fields.
>
> The refactoring of this patch includes:
> 1. Expose values from device via sysinfo interface.
> 2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
>    string values from sysinfo.
> 3. Add smbios_get_val_si to get int values from sysinfo.
> 4. Use sysinfo_get_data to get data area.
> 5. Miscellaneous fixes in smbios.
>
> Moreover, this patch adds SMBIOS type 7 (cache information) write
> functions.
> Link cache handles from type 7 to type 4.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Combine with #7(v1) patch.
> - Move the changes of cmd/smbios.c to a separated patch.
> - Refactor smbios_get_val_si to get values from dt when values are
>    not available from sysinfo driver.
> - Miscellaneous refactoring.
>
>  include/smbios.h |  14 +-
>  lib/smbios.c     | 420 +++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 383 insertions(+), 51 deletions(-)
>

There's an awful lot in this patch.

Can it be split up?

Regards,
Simon
