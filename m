Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02225C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595A488B79;
	Thu,  8 Aug 2024 16:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bT6hxtfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27A888B63; Thu,  8 Aug 2024 16:39:57 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A690688B81
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc4aff530dso221795ad.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723127993; x=1723732793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8q95Pl4aa2AcJsqMJUXiZF8s9njO6NxRIb8hhXzLic=;
 b=bT6hxtfuFNH+ccmoVRPtUXmY72U2m0NbEuQS7RVW8D5h7WfE9itvGZVL4nTNdSnYOX
 HYjx/3UkGnVXdghewXXsOvvDuHzEYU391w6nFjz/t273TGTNg5bCsfNrbpe8eoDZoSRf
 +Wwqg2pTLXyCiAUHXjnA3a98fzV/9uCt/SrzXEifo4ffNQJDJBo1EWuA6yent09XvKAg
 FzXFqDbh74EwFK7pnGgq0kMCnlKBeDFvZw1BeNitM9B4AISXRYDSP6hi+ZEYMFewRHOg
 VJDthuuSuFDlwV92h9pz1ZuRkjLDjtGt7Tgl0SeUx892mLf1m8WuMvzK4mQAtC6hhfLa
 /fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127993; x=1723732793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8q95Pl4aa2AcJsqMJUXiZF8s9njO6NxRIb8hhXzLic=;
 b=wuVEAvg7AAO51tBlhhpSI9z651AMmpjruSK4/Ub/lWLzrqFNb0t8ymXffoj/EhUlRW
 WIjoTvyjM6fNmW493Knj4HwdP3KB57qoeY+OTf6XhKusdR+5jW3DEPsbkw6feC+LRmbM
 6AtU/LmeKQeOu5O75DwrvAqgMTvyPOcWrkai2hD4LGvXNPTJ0v+D95PGerE1EyHkBQ6R
 pQ9ZwO5b6fGkAOhxKYFQ7ZDC/hYWdnN0+NGXz2ltPLnFQzeNcPFa/Hgl0sB125I6s72h
 vQ+nuLp2JYdVOHaLtE8g7f8I/9Wv93hE05JZtL4jO1l/hEOQsXoo/FZs40GDIhmwP3NU
 kptg==
X-Gm-Message-State: AOJu0YwK6yY+8U+o/u3p2IASYOI2T1aaRTXRxG3h9uxDGYkNy7R1EwU+
 9ktHXAUDr5XQrcLfcbG4DiOJ3NHirD9diQu0QEmbNZYY/p1w9a4Z1/ITQIhNG3ZUtaAQC8j++B1
 9yCeLIlQZd9t0THLcUIzx5z/Kl4JwxrwkN6K5
X-Google-Smtp-Source: AGHT+IGSTlNA0koOh/pHlfBFRumbaZHXpX8kaG4HfP0kIq5OCF26T+W+YGnAF5x58p5hIt5kNq89RcclzVVGy7IlNsA=
X-Received: by 2002:a17:902:d4cd:b0:1ff:57f2:53c8 with SMTP id
 d9443c01a7336-200916f50femr3412025ad.24.1723127993194; Thu, 08 Aug 2024
 07:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-7-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-7-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Thu, 8 Aug 2024 07:39:42 -0700
Message-ID: <CAFyOScpZgi1CUNQ_bz82OpXGD=Sc4NSLT26MvQ6pHoBjTaQd1Q@mail.gmail.com>
Subject: Re: [PATCH 06/17] acpi: Add define for GTDT
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, mbrugger@suse.com, 
 pbrobinson@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, Jul 27, 2024 at 12:21=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add the interrupt flag used in ACPI GTDT table as define.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpi_table.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index 0de3d3f439..19771c133a 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -707,6 +707,8 @@ struct acpi_gtdt {
>         u32 virt_el2_flags;
>  } __packed;
>
> +#define GTDT_FLAG_INT_ACTIVE_LOW       BIT(1)
> +
>  /**
>   * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
>   *
> --
> 2.45.2
>

Reviewed-by: Moritz Fischer <moritzf@google.com>
