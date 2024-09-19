Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D001CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA9B89215;
	Thu, 19 Sep 2024 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XxcW3eam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F00891B3; Thu, 19 Sep 2024 16:12:05 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C062891F7
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d8fa2ca5b1so797254a91.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755121; x=1727359921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvw6GNoWXo3xgsZIMbb8b7PaFCxKuEuRhTZCBrOcx9Q=;
 b=XxcW3eamyFlzZSjXIbuvjlg1EQWY6gnD6y5+ddp1+lys21y9BXktUr3O4zZCwM9vjv
 xvZQDBHcoDl+5GF8ogNQU0eftwHfvvqGO/8DPr0TmxZbBvOhi/QKfPvPgpWq0HUcGQC5
 SapDltLjWIGKbqi1Qzdi6QJm/Rkq3po3PSKc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755121; x=1727359921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dvw6GNoWXo3xgsZIMbb8b7PaFCxKuEuRhTZCBrOcx9Q=;
 b=Fr475ht//il3cwSWOVFJxGJig6j3d3Cw5t01d4cOuI0VlMPruaYJ9TyANXursg69UY
 9uPPg3awhCXk4sMH+xG0LwJ+eFN61oygq02GcyZXkvt6UoiXXUwYhO/lRei84euRqdZE
 HLFFqNxWzS+/Y1Sy3jd3V6a4HCZA3J930O60oaC5wXF+jso26r2v005RWIgTtqzkCYuL
 CIiuNxElahCkSZeKiTgz6ap4aWxzODvanHoYmm0cBHjmteme7rL9Pu4MVoS4CQcN7Qco
 xHILhAPTwi3dEZ84GdmXT+vVVlu8dWrVf2lNrF8267RVkVrADe6UhDsR0VkGHXa2O+wF
 MmwQ==
X-Gm-Message-State: AOJu0YxOJnS6HCpVN51f1+WYnhy9RAbTSRMni02nzHb49aN/KE2xaQuS
 YnqE5Tb/+w9vRu4FLV/Qo/NIAmuDodoV8KDhvHwdm2VGcExvy3TVMwyLu8qW/Ry0aCUrGkFDT2z
 VuxtcvjrjdQg+pWDfqIA36I++uClA1KIr9d+W
X-Google-Smtp-Source: AGHT+IFPkralzFVn+KwtWhT0VQU9jcp3Su0esZKZQWWNCZ0q75jE9tylo8Qng68/8jgzhatZVoMkCP9keL6BT37tGDQ=
X-Received: by 2002:a17:90a:9a7:b0:2d3:c8e5:e548 with SMTP id
 98e67ed59e1d1-2dbb9dfbddcmr29148227a91.13.1726755121587; Thu, 19 Sep 2024
 07:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-3-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-3-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:46 +0200
Message-ID: <CAFLszTjpi1VZSYKzi1es83hw-JUTsA9Jd_gjmmZVbOsR+84_4g@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] acpi: x86: Write FADT in common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Maximilian Brune <maximilian.brune@9elements.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> Write the FADT in common code since it's used on all architectures.
> Since the FADT is mandatory all SoCs or mainboards must implement the
> introduced function acpi_fill_fadt() and properly update the FADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
> Changelog v4:
> - Drop __weak attribute
>
> ---
>  arch/sandbox/lib/acpi_table.c     |  6 +++++
>  arch/x86/cpu/apollolake/acpi.c    | 20 ++++------------
>  arch/x86/cpu/baytrail/acpi.c      | 17 +-------------
>  arch/x86/cpu/quark/acpi.c         | 19 +---------------
>  arch/x86/cpu/tangier/acpi.c       | 25 ++------------------
>  arch/x86/include/asm/acpi_table.h | 12 ----------
>  arch/x86/lib/acpi_table.c         | 23 -------------------
>  include/acpi/acpi_table.h         |  9 ++++++++
>  lib/acpi/acpi_table.c             | 38 +++++++++++++++++++++++++++++++
>  9 files changed, 61 insertions(+), 108 deletions(-)
>  create mode 100644 arch/sandbox/lib/acpi_table.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I was really expecting each file to have its own ACPI_WRITER() decl
and then call into common code for the common part. But I suppose this
way around is OK.

Regards,
Simon
