Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E60C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FEA879C0;
	Thu,  4 Jan 2024 17:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WV25sFSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DC8879C3; Thu,  4 Jan 2024 17:06:50 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C5C879BE
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67fdfed519dso3012116d6.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704384407; x=1704989207; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aT7SDS1398XP/aayC/+34vo498SJ6ZBtxCra/sNccSM=;
 b=WV25sFSWh2L//Hj3HS480XcQbZtpV2JcndXVAJOJmOr8AleIijTf+CzZ9Mcj07oMWb
 ZN+llDbdOfrCtlyUeiU7QweXrIi2Uh9Aou2b+AsRN/wVTGGHIHOQsdKxvSBm8Tj0M5K+
 fGJVS6vKcdaH6ElOgsEGOANV28K78vR1B9Mf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384407; x=1704989207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aT7SDS1398XP/aayC/+34vo498SJ6ZBtxCra/sNccSM=;
 b=wvVHl6NgXFlaysl6L/ckMDQ9FIlgsyfblES6PdYDKFazeAgA9oYGueiJKsrvh0jl+7
 txlDY5LEa4dHsEgE8RY298Xjl4tPB6pwqiuHFGejnk7X53opONMm3tBkyUcK4bNujVTd
 j14EM+hMo7tvjn555kCmPUOsi412HHI1qtiPFzf+G0lJ9rz21OONLOkZFx8lkFu/wbNm
 AGbxrUWez7sigrGF5eIQuJEEtWVy6tjvtiQlGvSf3LOX/Ek0Ub7BNCKIKtYIPQyNMOPe
 hEWVHxIjg9DnkiX2mdTgnhsEtRBxjfPdJEup+pZlWebck+ayYDZ4GHzMP6Z8wgJw076W
 w15A==
X-Gm-Message-State: AOJu0YxWiPi0az1+Fm73cOEmRhICmnN+ZoITB5uBUxTghT3rEOYC3Tlj
 g+pVn9KtetC8UEMjYqAOuO4wyWFCPi+anuus4c3sckkkTOGPgF+tLigPu1A=
X-Google-Smtp-Source: AGHT+IErm4v+2v36r2BPtz0Xzv4y5q3AIAjO7aP0FpToqONIBZD5RCjTOeROepAm5ah0a3aiSI71n3AgCMGxjdRgcv8=
X-Received: by 2002:a05:6214:ccc:b0:67f:3cc6:4420 with SMTP id
 12-20020a0562140ccc00b0067f3cc64420mr831625qvx.2.1704384407447; Thu, 04 Jan
 2024 08:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20240104160346.285881-1-caleb.connolly@linaro.org>
In-Reply-To: <20240104160346.285881-1-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jan 2024 09:06:37 -0700
Message-ID: <CAFLszTiU-A2bGbJG4k-sVB9W5gMF34fi4eq6Xjhab8s_ez3rEw@mail.gmail.com>
Subject: Re: [resend PATCH] bootdev: avoid infinite probe loop
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Caleb,

On Thu, Jan 4, 2024 at 9:03=E2=80=AFAM Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
>
> Sometimes, when only one bootdev is available, and it fails to probe, we
> end up in an infinite loop calling probe() on the same device over and
> over. With only debug level log output.
>
> Break the loop if we fail to probe the same device twice in a row, and
> promote the probe failure message to log_warning().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Resend, actually change log message to WARN loglevel.
> ---
>  boot/bootdev-uclass.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for the fix. Is this something for which a test could be added?
One that fails (hangs) now but works with your patch?

Regards,
Simon
