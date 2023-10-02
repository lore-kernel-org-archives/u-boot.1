Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A9E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B9E8719C;
	Mon,  2 Oct 2023 03:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V+EKxTDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2BD871A9; Mon,  2 Oct 2023 03:19:49 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DDC8747A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59f6e6b206fso140937727b3.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209553; x=1696814353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NjWjURYqx8wTGnXQxaLg/SV+On5h2A/KVlvJZlFFk2A=;
 b=V+EKxTDZ1ZGscfUiimZJfmAdlg+FVw1q625eY0cv71Y1rT9UPDlv5wC4w++9Ee9i2Y
 4zGcjXav6bdVbRilodh9dPf/WFX9v/uHUGnhoTfR6nrK8j0MM4LCKcRk4xfVsEZCaBss
 NfG+/ZdJci+ESKYiI3n7evpAuU6nHSi2mhTxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209553; x=1696814353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NjWjURYqx8wTGnXQxaLg/SV+On5h2A/KVlvJZlFFk2A=;
 b=jIUF6DawzsGiO5lF2jDEeAmA6RMLXUxapT7/Xg6NQEwi2CYVVRq1pGEE3f/P8PbLO+
 LVRzEBFGsjsC3nHrSkqbWPctFESHMjy/jm1FdvNtC86FQOe0vW+S3ULR5GmQISfH/XOO
 VlijoV4q7NvSCcMDhWjc6lsigSDZbke4ofN1BXTgleM8JVWnGRz9hla/gZFakA/azFNK
 RQpMhjW9IEYZZefMvsxgvxWoky4pLLumO+6GthMBSjevkuAhNi7zKKXqRF8RLrckOoIu
 SWBOhCkEzJG8eG334gHRtdv6nJUXFHbCm2Pkq5sv8RiExQ2JFQ7+u+qCSTlucU8RQaG3
 uHoQ==
X-Gm-Message-State: AOJu0YzA9yBj4SBI9uyS8bottctDFZTEQCfSz/NbEuTJtM6NNWmOx4h4
 17Qdz7gORTaSXcnzkyYsv6mWjV3qGe1BtzSp/TaUs8gMoDSP33Vs09I=
X-Google-Smtp-Source: AGHT+IEZ3Ime03mkRGCuB7Wnb3PrSrIztuSGxhvKFOK+ps+N4HpJ3boh0J1lo4gi3LfGZ/Vv3Q2YA8bxDG5fapaevAY=
X-Received: by 2002:a0d:ebd6:0:b0:592:9035:8356 with SMTP id
 u205-20020a0debd6000000b0059290358356mr11171518ywe.26.1696209552793; Sun, 01
 Oct 2023 18:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-16-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-16-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:06 -0600
Message-ID: <CAPnjgZ3OLSA4UhPTOqdXoBbrRxeRh3zJgkCG_kaV2HHjt5CP=w@mail.gmail.com>
Subject: Re: [PATCH 15/15] disk: part: Handle blkmap device in
 print_part_header()
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 04:10, Bin Meng <bmeng@tinylab.org> wrote:
>
> Print out the blkmap device type when showing partition header for
> a blkmap device.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
>  disk/part.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
