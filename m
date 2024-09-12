Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F8BEE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564A388D06;
	Thu, 12 Sep 2024 02:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G7mm304t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E7888D06; Thu, 12 Sep 2024 02:58:32 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0289288CE8
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c53bc6f9faso3352046d6.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102709; x=1726707509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0NxRBiQ8oWrU3/bDnjUHCQ1vXLI9vKGrUiwcT6d3Um8=;
 b=G7mm304t8+/hgh/zwlaEy/YwxJiRHK5dQzE66J8exHk7YtLeFMuBNkUVSsuCmGcumR
 Qizp9hBrrjNqtuzy2MRqgVeEb1gXw7bHdV42p03Sm/IEkLQTHW+oUvlhnACCI75Ktqpd
 H6KgWI62bu5bFi/HoKqlav+H7xz1V+G1VO2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102709; x=1726707509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0NxRBiQ8oWrU3/bDnjUHCQ1vXLI9vKGrUiwcT6d3Um8=;
 b=ipkcUaMvR5qOauXItbpPQW7dIHMK6Dl93/WMZ2miW1cQfZru/saFyp8+TOg81nmP6R
 t80g96lFnPTmGssI+CEX24sWNn0XdmPfEwxX7uNs9jkB3cjQMalHbZxXMIV9kfjFsUeE
 RV1ej8evhGsll12hnYC2r1UAdg6reHQefr956sHssKhLky8pGdKHmmi+SKuiOEcGHrLB
 4o2Xwldbq8HaRrAnACL4ESqR3mvFW4Xki4ppPPnVRoUjtt0h9/XHutoSiQqDnGgvjdFG
 8L+At3PRgkWCm43ecfCnO3FkV4iA2xZqlBeMRsLQzO4GbPPUMy6qV6YAbvx/hLFCVg2h
 dgsg==
X-Gm-Message-State: AOJu0Yx9sXcpCcpNSZJcKNIM9YYugMh+dQixhTroR1UNpluM6KHCU/4D
 /xD6mUKrqtbfJHepja8PpWnN3vcMM56Hva4YAoBRooz4Vesoj3YFrclLsPjr82A5cbSAIjz6lJV
 qq+DNGGZfeFknST759+0AGfwxFgl3aRcleAdg
X-Google-Smtp-Source: AGHT+IFq/IjNlm73GCEWlW47ds8fbixaCHkv1nC07xUTEQUxjPtJeuxBIrqm0wkyYhluIk1lURRD7v3nFs71Azl4HeQ=
X-Received: by 2002:a05:6214:3205:b0:6c3:463b:e1e1 with SMTP id
 6a1803df08f44-6c573530733mr26271336d6.26.1726102708928; Wed, 11 Sep 2024
 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-4-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-4-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:17 -0600
Message-ID: <CAFLszTgVJhx9aWK+1L-ieVfQcZnZq7_jBrR4vw8Hui+RySxDHA@mail.gmail.com>
Subject: Re: [PATCH v3 03/30] acpi: x86: Move MADT to common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Write MADT in common code and let the SoC fill out the body by
> calling acpi_fill_madt() which must be implemented at SoC level.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
> Changelog v3:
> - Pass ACPI context to acpi_fill_madt
>
> ---
>  arch/sandbox/lib/Makefile         |  9 +++---
>  arch/sandbox/lib/acpi_table.c     |  7 +++++
>  arch/x86/cpu/intel_common/acpi.c  | 21 +++++++++-----
>  arch/x86/cpu/tangier/acpi.c       |  7 ++++-
>  arch/x86/include/asm/acpi_table.h |  3 +-
>  arch/x86/lib/acpi_table.c         | 47 ++++++-------------------------
>  include/acpi/acpi_table.h         | 11 ++++++++
>  lib/acpi/acpi_table.c             | 31 ++++++++++++++++++++
>  8 files changed, 84 insertions(+), 52 deletions(-)
>  create mode 100644 arch/sandbox/lib/acpi_table.c

Reviewed-by: Simon Glass <sjg@chromium.org>
