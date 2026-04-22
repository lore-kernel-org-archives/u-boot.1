Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402EF94CBB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C4883936;
	Wed, 22 Apr 2026 04:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3EkVVhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB9F840D8; Wed, 22 Apr 2026 04:54:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74AA8352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so896897466b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 19:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776826484; cv=none;
 d=google.com; s=arc-20240605;
 b=d0ey0WxuVvOHwNXiSYu9R9PE2FGbGE5to0tMEbu26+hHxNcpjXvT33Pwxd/72fJkvi
 uCSFu+Oop/hUkI7Or/yYbSsbwwzadlr37KCK/FRNlCl1fjrR6d/Q3vkkzqj+oGn74GGY
 rEW3fnwU3Bkg8PBLO21/WXhhssKhH5G6VtWrJeGk6MY8B+qOtUC6Lap+ziu3DEJ5Ggf3
 SEpa7g+XDaOkCClvWodBe7JVDk3P/UmxqCeDsOmAYYJf4L2oAv59SlI95oBjqbQOErjo
 favt/SQKqGRyLfSf9Im11+z1a3EmvnFd+nsqEnA+ik3Lm19epzzhdGYiM1+iw6jbz7p9
 k3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HTSpXNWMnOUUvXNIjlFpvixH0NVYJFzcgzRXVYG+lGw=;
 fh=PHo6SxFQeYGijuQxNVj6Mu5BE7imZMp7yjwDYBEMLIQ=;
 b=gc5CwkbG1I+CmVAKnELxIy7wMLHMvEQZ4zZd8c5RIBC9u3L+ewqaxpNpwW+1OV4iSW
 I8WQPw1wB2TbbOU6wtW+xth4sn5R99otSpgN5KTpjm0+YbCRghXgykMwHnRFN6owyAib
 xi4PxgHKO1FTRs5VP/sbZCuxezOEhn2RZQnOy2tMY4wpIOkWInCO8gxX+xMEQE8JG6we
 daJYTO/ZwzSiuxS3f/Alqb4cPRq+Wjb0E1QgMU0K3csYAXV2rIFUjkVPQ4UtxcFD2zKO
 RG6obxcUGeufsg0x9+2RepfUjbqY2x38LeZncLv6c9nE0rYD+Km+qqvWpc1iFFYoQ3CP
 absw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776826484; x=1777431284; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HTSpXNWMnOUUvXNIjlFpvixH0NVYJFzcgzRXVYG+lGw=;
 b=k3EkVVhxUFoweCcniJJWQiwIEWJ3CfI5bCGa7LoyJnl/Fje2EgS0SloLb7H6F81TaC
 05BqBHi+Ox5emDP8Z7xuFBglfUTbdJSHRiI51Qgu/QUJj2RtUjqJsCicCdHfS7OFI+5h
 ufC1DgRa54RKPwtX5kWY3knxfTEsklN0JnspA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776826484; x=1777431284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTSpXNWMnOUUvXNIjlFpvixH0NVYJFzcgzRXVYG+lGw=;
 b=G9rOVIfz+c22alIWy1qk5OFoW5427WKNCvypEKofdBA2nY8/WTp6px0PjYwAWX7DaY
 cSx2LWvreyIy8/Bq+e1K5e7Ow9dwTbxy8uI0Fa25wuNgeVMRYo7civ0OoneysyfMl64H
 nLm5Sc07J25dd6DfVP/6o0o3lOOoqy8NmEw35qyE80nvSHdiaVVyG49j13ObqZxooJ1R
 bbm+oIbzR5p9P9JTE52/F1ehZr5lSVjB5xRPmfp6jLmcc0LK0prDPMdKrTj04fyR25Mg
 RqVNERxZqX7hF756tb268FQHtHGB0zZq5GeGDCtA5kksJOcKkRixJYBGMVwuns5cTLOY
 NSmQ==
X-Gm-Message-State: AOJu0YwaRKg15uh5YBd0T/6uZkHznsUfohjCAj8WESn5ku6KWSn6YXUS
 6so296XaMb41btRn7SojNheWCSYwaFXo4WrxU2MhPeLhPDm4P10gK4fKXttlpefsw6ltxZm5va2
 nP05cv+cj1EJK6ZIBXsARzRSk3MIbEbNV5fYdLwXajsNCeLVmO8A/faB/
X-Gm-Gg: AeBDiessAmC0KAeuQ0lGw/j0Bg1tdp+I4Sc7tskPBPhdvvC93eJiVym+WN8wclVsM2i
 rPbLT9CFC+60GZ+jZJLVirMMsgq9uHVEOr0UciuT2AFC4/Y8XAlX03HM54y1+Ytcn5iyvWuNPCc
 Dd/K+OCh5HCFEOIucZtReChHa5I+vLrHtnUDdOkMDjnOlsD5QL3o0NvhEOtZ6uyMI8dkTC+P1s9
 ZH0nF5PpcIl7mzqpE/81zH/cwSW7m6Jm2iFT9/gWaasJpHTaaao8yCojsp06HECEgQ3VLXZC1/2
 O2LcfIMtnhpfEm1A4Vum
X-Received: by 2002:a17:907:c1b:b0:b9b:3a1b:e2ed with SMTP id
 a640c23a62f3a-ba41de2db63mr990642766b.24.1776826483916; Tue, 21 Apr 2026
 19:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260421004719.73491-1-briansune@gmail.com>
In-Reply-To: <20260421004719.73491-1-briansune@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 14:54:31 +1200
X-Gm-Features: AQROBzCfkjOpyEtTAy68Jsyf7Jgx6SRRVG6_69woxpeq2uHxk0pfI3PPvXTeNok
Message-ID: <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: briansune@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
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

Hi Brian,

On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
> Improve handoff prepare on SoCFPGA
>
> There are some cases that the Python scripts
> are run and the qts files are not replaced.
>
> This patch introduces:
> 1) TMP folder for Python script
> 2) TMP folder will automatically remove on exit
> 3) If PY script fails, the replace will not conduct.
> 4) Only when PY script passed the replace with keep
> or without keep will be done via NEW HANDOFF_KEEP=xxx
> 5) When keep is selected the old files are renamed to
> xxx.h.handoff.<timestamp>
>
> As such this ensure qts folder h files are properly
> updated.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
>
> arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Some thoughts though.

We try to add a change log for each revision and use imperative
present tense (Introduce a temp folder... rather than This patch
introduces...). Spell out Python script rather than PY script, and
reword as prose or a bullet list instead of 1), 2), ... You could also
explain *why* the qts files were sometimes not being replaced - the
motivation paragraph currently just says some cases without saying
what goes wrong.

The message says kept files are renamed to xxx.h.handoff.<timestamp>
but the code uses .h.handoff_backup.<timestamp> - they should match.

> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> @@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
> +                     if [ -n '$${HANDOFF_KEEP+x}' ] && [ '$${HANDOFF_KEEP:-1}' != '0' ]; then \

How about:

if [ '$${HANDOFF_KEEP:-0}' != '0' ] ; then \

Regards,
Simon
