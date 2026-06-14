Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFA3CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D2884704;
	Sun, 14 Jun 2026 14:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cf/pxBlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2156B8484C; Sun, 14 Jun 2026 14:43:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFC083EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c32f3c6d6so2330273a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441016; cv=none;
 d=google.com; s=arc-20240605;
 b=Eo/wWQ6NGA25Z5YnUAJec1/UBB2OEIaxybQek8BHiZlwc/9OrJIsMa1zqazEyaju5A
 mwgpyH284kzhJLygy523/69sHfN1GW0muqW7Ik1UNhdxBxXgvDpMvSX31UDD0XWPvfoo
 eKuLOzowfn9PITVpc+Zu4rNfXftBCHgzLKX3LyKxIjcEIe9fc62xux1kNTP+PVDk3tay
 4srQlX/zIClVl9rjqu9q6RA5QmD4sQfENHqvgEmprJ8pznB/pP0u3LFRZyFddhKo0IpT
 kY2wtsr2J3IlDGHye12EnkLmZA8l9//fAXMauejl7O/ut4Xzk/siX+98jALAyQ78oj5c
 IlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ur+T3xnYweMD5jdELb47Be6RJi0qAINgJdo8Oay/AW8=;
 fh=xKRXBuT5rhUeYH95vDRHzFAR/bbOG5bPOBaf8tvk80E=;
 b=Dmismwrd8dVsoPV4cr8MsodV3Fq9xalIXk3QFbcXCcgr6F/4uw5Mpyr9dkZ0lOIqVh
 u5B/ItZgwYIKvoaRRzbZTa44YFt2L143umSFZMCQ1IQKq/07q0lGP+AXVFHh6fLkyT6b
 DtIFspHGGsRH7cB/Uet5AcxGPHaA0Qj7TjO8GJjDhmyHg/FX7oZyEZgqzjZruLcRd9fJ
 6es5eW+3pG3TV6QXmfP2iilgbl6q9Mmp/46+YxntE+fdShiFc1B8i4E9Xkc4GZjzdfr2
 yP4HnB9XgSiPVJEinLDrrwXlPrEhcl3GBR9+sd2h0dBW8/4/c5vZnuDNETZ83v4eQhlJ
 0BYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781441016; x=1782045816; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ur+T3xnYweMD5jdELb47Be6RJi0qAINgJdo8Oay/AW8=;
 b=Cf/pxBlfO/flEbdofYQeD6xkWlvJ5hv3qobhhBBj75nsTLNnr1lW72dFSBpda1JV97
 Ipi5Rlf7nXssKk4WSvEdULe9WskRT8YmRbOjB8f6wyWP9YIc2Y45RcAtrChxxinqkn9V
 +PrWwjK5zm+WxwHykrP8PwvZviJ2UTOxNara4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781441016; x=1782045816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ur+T3xnYweMD5jdELb47Be6RJi0qAINgJdo8Oay/AW8=;
 b=RuJk8olEO+zSxR3aq6HEFTJBlNZAcneXG5NxH1CZC6U3adZPMqkq7qB7xt9dbgKPkI
 5wFs7elRtbSxJ8+UQEgKXonABJk2QnnVq97fl8UBxqA9Qojqfp/a8S2jO2JStRL7Qolk
 +N8jQ/e7ndMfDV1MVh+7U8STDJmqfyuK2Bs/eYUu2XhlHo3lqbeI8l+QeEi2o91PEGH6
 v/SABgklpaef29JxpsDZOA3tgcBwVvh4Yeo8583zX3eUJmQ0WQkPr0DC9pI0S1y+lObB
 mdu5k4SyeaZUml8iPK/ekUvtz+biAatW0OqLWm+/FKGc1l+rBEbxSJmz+TwkF0dXmFBA
 mwaQ==
X-Gm-Message-State: AOJu0YwveDQn8HLM4I0oDJp8lClvixcPbYf5G7sjJDZiNisbV9a5Qoev
 ydofBj5rmrK1infBtSkDDuZ6WQ5X1k1kzuXyYjTulfXsc1hLU4BSFQPEtQsNrwFTNExFDt+Vb0P
 uo4Z+ZrWW8JzVStyb+jop4DdUlk35gMxrfWxcMU2tL9rPo9xWFMdliw==
X-Gm-Gg: Acq92OHT+MF6SRE1YZiWEDyjGFiXMQQQIPxs1/PNPl/7fHiJoFiIFwSjiEpqDmgdyRy
 0XqzOZaV2UwJNUmy4IG2W6TXfz3Qf6alFBqZSSFK/MuVHsBF2bV+lPYkzwpuzPZodjJRAcuWv8B
 y8224EKaYkm+lr8hVm0WG+a3WefpSsJ0h+kiuPpkAMkfiI7t/qENlvrCzKATdrKGxVC7AcgkDzy
 qsaFgLADP+/ACzUxfEJYngCzi4PfRAivb6xb/v9fraEPwZan7D6T7v8IkpqLqmsfwHLAb9bMCtM
 zxWGDA==
X-Received: by 2002:a05:6402:434b:b0:68b:d10a:a490 with SMTP id
 4fb4d7f45d1cf-69378a103admr4172377a12.13.1781441015672; Sun, 14 Jun 2026
 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260612015932.283341-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260612015932.283341-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:43:24 -0600
X-Gm-Features: AVVi8CewTxPExnkm6HPpcCvyPFYlcgqmAxnSS9InxGquaSuaRp5JVfaPuyKnbFQ
Message-ID: <CAFLszTi=2CbTv1yXxhHmyW71Hyp_s3-H_-_omAURVch1XyzSRg@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: Convert dm_cros_ec_get_ops into an inline
 function and constify dm_cros_ec_ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, 11 Jun 2026 at 19:59, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Convert dm_cros_ec_get_ops into an inline function to improve compiler
> code coverage, and constify struct dm_cros_ec_ops in a few places.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/misc/cros_ec.c | 9 ++++-----
>  include/cros_ec.h      | 7 +++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
