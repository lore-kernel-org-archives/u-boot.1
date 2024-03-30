Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A25DC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6938882B6;
	Sat, 30 Mar 2024 20:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CBggb2wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DCB882C4; Sat, 30 Mar 2024 20:47:43 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7782882B2
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso711547b3a.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828060; x=1712432860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2oE8yBTYgNUCfOFmnaKr8TlJYm6DDt2SSXlrLhfsw4=;
 b=CBggb2waM6EfkETKhkKUJD9mQBpbuFARNVXILzEIbCOMxq6UiYlENIVghZ5ML8gWYo
 Eif6t/H4HOUnNKILokA18kYSWKs9Aeg3XfOpBJEkTKIkNnLj2WQDQBPCasIsATx6Fa/m
 iIHtSHG4HoSUVLA/q0BbASvwoe3I7WzF7SfZD83VTm9GhrwGPDfhhfp44HJi5cO9KeK3
 hol3XKLZ7hMeJZX6M7ss0Sm6AjHDZtBUVg403Uv4OWuTqKCYoveDsxN0AvM5Q6e90Ri8
 HJwGDs1Htozlp8RKnbHHvUTke17alq2gC1LfwWQtSkzd74trzLb1u3TbH/zhns1dwxlo
 Fvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828060; x=1712432860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2oE8yBTYgNUCfOFmnaKr8TlJYm6DDt2SSXlrLhfsw4=;
 b=BuPhHnXYP8TRnQlcWu2wzzVfdeZT/HmitJIHVuNJeiinkCUl+LOeJ5xXbVzLfvJVPw
 J0GLC77GAVOsZX+NvyQHIffP6hSiaxhh4RoFTbHIy/fjkF8dyOnGmePpjK5T6Yl0IjVa
 BbVW6l8EDs+l61U9iDizCcfth69S7raHxMbyQ0/M1RVtNZw7GnOsIjpHsTwbOngmh7z3
 cC7z9MC5nZPkAvMolnZ6hRhoTPjOh32jmrihxlX/05TDGZf3O/KvLGCJUPo8BjI069RZ
 8OD4xbwewi3nDuFnKjY2elpT+Dy5d1TzzlEIvtvJC3pAgCKPBEVsQz9QAc9vsqcKjA9f
 phcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSVnQ5k1iA34RbT2glT7R2bhmEXrVejhAEp2LNuDJwCHYHP/EEZm0YRM6Y8t0hbw8dCilGhSeZyddtlRD6BBKWw9qqCg==
X-Gm-Message-State: AOJu0Yzn8XbIFj0vY9Wm1PCarlBoPJ5rsVbg8fFdryFbjMAa2AGuKep+
 C/ettgHzdZgSlhi1Yk6t+oriX6WTaPWfZRciKMbhxTABhqRRu6MmVayM2F0QyWVzeMGFXsbdiMG
 huDeJ7F9Xis95KtJLuKCIgSCNKk8n9wBUhH4=
X-Google-Smtp-Source: AGHT+IEjiLE4875ck5PjDR5DN/STaTWn0BFn+xI/xTFAbyink/HwDxZ6b1AuEGikEt5FJms7YxfbimMScy11Y7d6pg4=
X-Received: by 2002:a05:6a20:7f92:b0:1a7:c66:121d with SMTP id
 d18-20020a056a207f9200b001a70c66121dmr2770372pzj.3.1711828060154; Sat, 30 Mar
 2024 12:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240327124550.32138-1-hiagofranco@gmail.com>
In-Reply-To: <20240327124550.32138-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:47:30 -0300
Message-ID: <CAOMZO5Cscpx4yL5H+iuF1j_A5c32i8MhoqzFp2kSCq3ojcMAAQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: colibri-imx8x: Remove board_gpio_init
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
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

On Wed, Mar 27, 2024 at 9:46=E2=80=AFAM Hiago De Franco <hiagofranco@gmail.=
com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> On Colibri iMX8X, the gpio initialization and usage should be handled by
> the device tree, not by the colibri-imx8x.c code. Therefore, remove it.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Applied to u-boot-imx/next, thanks.
