Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3021EC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716E88895F;
	Mon, 15 Jul 2024 15:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SG/NEvmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2279A88939; Mon, 15 Jul 2024 15:32:03 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C2F888CF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6561850a7bcso39245537b3.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050316; x=1721655116; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D8O/gwHcPNAkFFbY48XfHR8Szw0kBI4Vyg5AzURWn1c=;
 b=SG/NEvmLgD9Fv0lMCXzCMIaKA8+r68SieeyJd0QUxogwnupY5a9jUNehOto80BbeTt
 Y1F3ZuqxMBk5fu045YvJnxf9EAd3bUQOcXOc6lGZ82ZE6mmaV/058bDC3zt5/63kIqMh
 owxJIRZyeAzAFSibxQLabet1csDfgHaOcJDYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050316; x=1721655116;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D8O/gwHcPNAkFFbY48XfHR8Szw0kBI4Vyg5AzURWn1c=;
 b=WQb9zgucdf7ajLCZNHzE98fd4LjVjrr4F0kDmyaOQhYRV99fNJDeZBlAWN7Lkz6MJc
 F0WAxVwQUiUQz8G8BF0HEVdctAuhvk4uMDRFJl3niKFWBbvZG+PSkpmmYQC40G2tMTjJ
 4T3cSp2F3t+HomfGhG8e6gUAcqbqzI3Y4W8xa6Xzau6o60ROPmPCAU46d2XBtZzITjOr
 ZmfFzWfd6mMmd6v7CQnmrs5duEtCMCeyPchbrDHLaDhk1nT/JigfcQcb28I58Q0jJPeB
 HtlZ8rre2Tn2YwXlIAN7Fp4lAYrqCYhv89Rml3lfPsq8AZsXvXIsbDifd++scoP49U/9
 aBTw==
X-Gm-Message-State: AOJu0Yw7D5Ae1P8Sfqc1fWAYwDFk/v/ktEtAVjLfoIzYAaKPOKycU98a
 A+888lGc7Fda1MY9j5qmaHszzSzUfH5Io+xpFWB29GikUCB5hCtik9pR2JPmwDAujVhOOWZ2kDY
 PlnITbroDoYTswfFtz3sd4WY1ajwU7y1trF1b
X-Google-Smtp-Source: AGHT+IEyTVg73XYUyT+mTSYw30iA8+Qj/L7NL7b3xNXYf65vwIrk1RdiNeEmF3gs5SIJXdDpzTqn6SkgbRy+ZjdTiak=
X-Received: by 2002:a05:690c:296:b0:649:8f00:525d with SMTP id
 00721157ae682-658f09c9123mr234451947b3.35.1721050316145; Mon, 15 Jul 2024
 06:31:56 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:55 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTizGyw3WYKu22Y1sPaUrmCnpoBVfVuOM-Ra97fEnd+byg@mail.gmail.com>
References: <CAFLszTizGyw3WYKu22Y1sPaUrmCnpoBVfVuOM-Ra97fEnd+byg@mail.gmail.com>
 <20240525081053.2818481-1-net147@gmail.com>
Date: Mon, 15 Jul 2024 08:31:55 -0500
X-Google-Sender-Auth: FMSwuW1Ri3uNRverRT0Ub9z0iE0
Message-ID: <CAFLszThU=QE7-eV1qDSUpghOR8cGzn7jtwF4+3Dv7Z9zzoAJcg@mail.gmail.com>
Subject: Re: [PATCH] sandbox: enable support for the unlz4 command
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Jonathan Liu <net147@gmail.com>
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

On Sat, 25 May 2024 at 02:11, Jonathan Liu <net147@gmail.com> wrote:
>
> This does not work with sandbox at present. Fix it up to use map_sysmem()
> to convert an address to a pointer.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  cmd/unlz4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
