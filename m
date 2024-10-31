Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DE6D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA0A8928E;
	Thu, 31 Oct 2024 19:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NzKm6+oZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0415E8928E; Thu, 31 Oct 2024 19:02:31 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74F6892DB
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so1019790a12.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397747; x=1731002547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xOiPAV+Lyojd+S0sD7WtfFnI5impmDfePyQwHEJ9vvE=;
 b=NzKm6+oZyzSXmCFnOwTq3+eVhqWq47zGC5YQyGUh2OCZWi2CU32G69DH9l7OMxOIls
 UUi3kWp+bnDNMpb7HTX6PSR7H+bBDLacvtnkc8VImy03NrlKou6VXPFDK6bKqW7t2RUi
 iDYMJd4+fCS1SPEEZS3FZMEcyM2MIK6KozgNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397747; x=1731002547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOiPAV+Lyojd+S0sD7WtfFnI5impmDfePyQwHEJ9vvE=;
 b=lQx8McBkovx3nFvT+OpOxbUZSiAZW73SySDmWdse0eOGhRagfIJbmsZerQGzaZK6VG
 Tl6iAItCQX8hAc389uY/urqhmnHNKcWOs1wQZZy1NKZtIgd6fUKkVml6c5IM79WpkTjL
 XVYHL02s0ToudJ5AwukXODr4nVrASPBPLV51FdwDbTLMKQyIeshYRwwKNAqEIO0OjRQq
 pKfiMH33BhiUL8LPS4f33+piI1+THj1HdFvp7/OTMKMglmbujIUv0XoUy4GQ0DdKPG1e
 5wiiYUPHSPITx4gtbeLxgEQL/T/2knx8w/EqZQ5VhAM6g7FvinU2LDc4PUdmqfyoW52f
 N9Wg==
X-Gm-Message-State: AOJu0Ywm7nVng2aFGwdGHKlBkW2IWnCDhPVPNXKSTFJOUu39t+AJ3D1o
 /vTI759gjJzmDNpS9/FczJSMbmnxlbbYoNvbYDlk4qJ6AxSG/Xi30j1R8EFuRetLMHdVmU6OP4Q
 kyi9jjaXXDcHSTb1Zw3S/qS9hPH/c80u4g9vMBzZnQtsFmIHzLg==
X-Google-Smtp-Source: AGHT+IEKMyaQotnXwqf1DerRiB1EylBvo0S/CqFiTzbBmsjhlZ43STkGD4LI+R2Q3rJbK4N1MGfauExrloeczqoFkvY=
X-Received: by 2002:a17:90b:1f86:b0:2e2:d1c9:95c with SMTP id
 98e67ed59e1d1-2e94c2b035bmr1148414a91.16.1730397747374; Thu, 31 Oct 2024
 11:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-6-sjg@chromium.org>
 <20241029235319.GF2558755@bill-the-cat>
In-Reply-To: <20241029235319.GF2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:02:03 +0100
Message-ID: <CAFLszTh0A19Ggp3DCCJoUncq=5KJYsi+9Z-7wa8a3ipYfvVdyw@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] test: Introduce lab mode
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:39PM -0600, Simon Glass wrote:
>
> > There is quite a bit of code in pytest to try to start up U-Boot on a
> > board, with timeouts, expects, etc.
> >
> > This is tedious to maintain and is peripheral to the test system's
> > purpose. It seems better to put this logic in the lab itself, where is
> > can provide such support.
> >
> > With Labgrid we can use the UbootStrategy class to get the board into a
> > useful state, however it needs to do it. Then it can report to pytest
> > by writing a suitable string along with the U-Boot version it detected.
> >
> > Add support for detecting 'lab mode' and simply assume that all is well
> > in that case. Collect the version string when Labgrid says it is ready.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> First, I worry that this kind of change will make verifying boards can
> reset harder, not easier. But second, taking the "tedious" part and
> putting in another project's config file instead makes it no less
> "tedious". If I follow the labgrid code right, it's got the same kind of
> "check for a string" that we have, except it's not caring about the
> correct number / order of banner prints. Which I find worrisome and a
> problem because of the times I've caught "oops, didn't actually test the
> right stuff" because that was wrong.

I am not asking you to use this Labgrid integration., though Please
feel free to do things as you currently do. For me, this works very
well and avoids the persistent failures I was otherwise seeing.

Regards,
Simon
