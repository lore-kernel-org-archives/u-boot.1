Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE140C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5F587823;
	Wed, 13 Dec 2023 21:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gnohKZRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B89F8782E; Wed, 13 Dec 2023 21:39:04 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1957877F4
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbcd7d63789so622070276.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499938; x=1703104738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T8fv1XGRqwlls54XsOTR5FuGQ0MAgzSk2SnBjj0MBJM=;
 b=gnohKZRXkmdA9kQubPRXOKNQ3i6bd0vESpdC+yCgL299m+9z8c4nHaNq80zW0hlq7j
 tSudiZH65jGnhRKKPpH2PxazcrvQX/Ly62e/bkborDugatyu6S2UTfe+NTVc4G47UvMQ
 sC1JmuGj3LTrSiZvxdN2mAMCfqycQe/m+W14Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499938; x=1703104738;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8fv1XGRqwlls54XsOTR5FuGQ0MAgzSk2SnBjj0MBJM=;
 b=jpWG4HFtrv1l/wbKK7pnpCpABHimbeos90KDnXeiqBuhPK+7pmxfptA+A/pFmh4czj
 RK9KXdJSDrC9gOwDG0M1LRpS4AS7JSbb0WTZs+dvzpE+UteoDM6J0pUpHvlmb5Njtpb9
 Ra1s0t32KNJPRtfGhNABFaPjNOI71Wyda1E0+/tQ2t4sfHN/buyOMS5F2v14f5rOeJmG
 AHS6KSWsqWf7d0HD3SrLySNaWLWqMRBxuXvyw2De29XZdf0c2QAbzegh1stBH2O+pymT
 AoV8V5RoKl48+hdd7YcifbKY+1U8tGuhmfX9SkD7zuleE/6CUYoQeHOFs5r5TOr03owS
 mlPg==
X-Gm-Message-State: AOJu0YxAypAbxu5lj2az0jH+Aky45d3KenXZRS6PpIrXrrj7zYbQOSTd
 HNFj7HC6qhASxGRylWUFglo5CQRGTx9aaL8cZ1y2TZ89aLTPJYBl7so=
X-Google-Smtp-Source: AGHT+IEt0h8d9VBcVjFBnyKZVrhsqrUKnk5M8ki7M2YhVBdiuyrB3AlWTA3Zh+hO9v2kun2OZyjPzHQDwO75BlmEq/Q=
X-Received: by 2002:a25:cf89:0:b0:dbc:d8e9:3794 with SMTP id
 f131-20020a25cf89000000b00dbcd8e93794mr787794ybg.76.1702499938256; Wed, 13
 Dec 2023 12:38:58 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:53 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1swk4h6EpQ+wF9E2GDUSJsn_k0PvNWqCUydaHQfdrNmQ@mail.gmail.com>
References: <CAPnjgZ1swk4h6EpQ+wF9E2GDUSJsn_k0PvNWqCUydaHQfdrNmQ@mail.gmail.com>
 <20231209170536.104700-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 14:38:53 -0600
X-Google-Sender-Auth: BrRHSyRcfbVjTclhTbPgiMBLTf8
Message-ID: <CAPnjgZ0NUDWcXo=KdFZCGJDggKZR-vF9ntn1d=v0OkiA3LnSsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: check argc for acpi dump
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
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

On Sat, 9 Dec 2023 at 10:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> 'acpi dump' without parameter results in a NULL dereference. Check the
> number of arguments.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

This could have a test in test/dm/acpi.c if you like

Applied to u-boot-dm/next, thanks!
