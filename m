Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42369CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C080C848AA;
	Wed, 27 May 2026 03:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0n+kxj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D28284908; Wed, 27 May 2026 03:17:09 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58D7848F5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bdd1986cc86so774232366b.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844618; cv=none;
 d=google.com; s=arc-20240605;
 b=BBetsP1bVdRbA2NKSTVyxMDIwWMUlW3ba77bJeD4DBcVYXjUBsKI2TGeugW3ejZG3m
 DIdY1HrspQGmD9F5S1IbmlYCkDLT8mIDmgfcfr5jUEhuIvxzjgoNO571QUcSPUFWKMFT
 Rcv5sJium9E4MUkOWEViErVlZfxvDWya5xIlw9Ko8Zt15lCsbC2mqM5iOrkW17/b6wj6
 jlBZhn/+wm6HKBOqoU2dE7m9E3cadHMaSjD76TlirSR5NKxgn7cqhixg7MhDJsAfGAsg
 FQ1HSQw4Z35KqO79BPjiyEYcJc/5A4D8oY8yXXg68X12JAMcBWq1Yzf9g2Ttwrg2e0vh
 30Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FvL4pYlB4cDCggWDq1SSvmQ98yUmOMEH47V9MwqQepk=;
 fh=XCO4wtAv2Z2+V3+WhXiOjzdBryQE33SQoNpLox9nNWM=;
 b=UygwLj3LGonsQfwJlZ3KkQvbutKTIao5nE7/r6mYJvOQ20WdEBJjYUWXH8oe9ib3Iw
 yqP5ssjnhMe9+pk6DOFmQqV9Q3CziWIRaUPEmHZ+8W5PnAGUp4oDKMR9j0LMjpg769tg
 rOcfE6PJMylI+Qar4U3vAUABxOgg4F0nOfJnwND089QjlrvOYy9xjs0H4vvJXe4nIaFQ
 g4kHoelwtvyf6zvaBZSYowjEHLB1gIbpkfbN01RN9aEjH9mLsOHMSC3kD0bywqpbWa5I
 iSEZE/j+kSDlBdc5FDNT3/mYksOdT6MMQFlpuNFn0E6xvKaNQm/A4Wh2TamwoqHaB3qW
 DnpA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844618; x=1780449418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FvL4pYlB4cDCggWDq1SSvmQ98yUmOMEH47V9MwqQepk=;
 b=O0n+kxj3j6mr6ifVfJi08gtgoT6WTGoptkJk7qSCnGD5GoTaaSaakD6ZbXemzPaJht
 7SKt9Dz8FFx1xCmqW0HPP2S2mHR8lFHj6jJvy6sCAL5j0wh6jh1Pjap1AlwfL4D51Z5g
 xgu7ShbVxjlfXjJ/xpidO0t0/DtmDW8VyMx/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844618; x=1780449418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvL4pYlB4cDCggWDq1SSvmQ98yUmOMEH47V9MwqQepk=;
 b=Suq7hE/tAB+lrHWDuSyjhZ1DrNg1UjxNPWPDXwzYZSltG8Iu4hreoH02Vlu6q1k+JS
 YG9Chami3GmJupFRuqCavelCRIbvmmC/KNecWvK/btT/CXVvuFMLFWzTBYqYWlp2sMYk
 L2f+pSYNPR4HICj/b4t0bYtPeyv2mf9/UaRDanxwiiW66jox/abvpFBKJ2dg2unSqXMH
 X6/J2Wb/wsTlrXJrjJeenmPGUeoBC26NTQwKhmmF2in+CbpDhXHUWGS0PPQ5RkC48oHG
 rqVDikiADq0q4GWISaSDO0zkNm3ziVUCHWRkC83XE/EiT2ANBjKJNZ57saUI7b9LDuwY
 ap/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lSdD3Cl0WJQzkdyMPAWAeinmAH7Cg5jvntKqV1ZFMVfOA9QGKf8dnimVtVcROiYBJV3gU7dQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyAoIc5RE5Wr6wRn5E7UQH7CHFOi/CcqO7n+lv7MnFJkpRbcPAv
 Gv11NLnnUqHDS56bTKke8rnUMmFEPwqRTpB5sajafAz+SzImyA/h+r3Y5134JFJ1cjNbud0WfnC
 LNzQkSk67W2TN8MKISsV3ufi9mPi+XK2DXOILLuODZK0NmjYRKGPnE7Iv0BnFLQ==
X-Gm-Gg: Acq92OHKIkLmQrekO+fxob/zAUaH8kMvnBYhU3RHl6zfms8fqqtHHKjNbDGeYHbZhf6
 Q7DeeA20D1gHF4BoZJKP2KKsA89DzUawvScjyMEohHZnML8MxlRz6HZm6sa3ivsEdEXbri7u6c8
 VqWsnouvKJwoij0lb4QTUhsY2dUVX6ds6G9ngyvc7JYwoigARfAmY37hrp46HS5RcaOewq4GSRZ
 RMKfM8bjQwxVbdX1qUxEPx7X0S3jVR+GjQNuVjAUhAxbr786ISnKYnQznHG1H1SF2KSoM7OzbWK
 YL7TlQ==
X-Received: by 2002:a17:907:26cc:b0:bd5:7c2:70ca with SMTP id
 a640c23a62f3a-bdd281aafd2mr1409521566b.48.1779844618581; Tue, 26 May 2026
 18:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-5-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-5-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:16:45 -0500
X-Gm-Features: AVHnY4L4QILnPQdVButRfD8dk8X3B_6RI9ZtrZSuaduj9HRD9WQI203xQBYThaY
Message-ID: <CAFLszThsDL1KCosDtwzYpdTH=cu9bZwHjBFBb-Nr28vS5D7m5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] board: tq: common: add sysinfo helpers
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
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

Hi Nora,

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> board: tq: common: add sysinfo helpers
>
> Add a number of helpers based on the tq_eeprom sysinfo driver and
> related hardware detection features. The helpers set up the U-Boot
> environment and fixup the OS Device Tree.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> board/tq/common/Kconfig      |  6 ++++++
>  board/tq/common/Makefile     |  1 +
>  board/tq/common/tq_sysinfo.c | 32 ++++++++++++++++++++++++++++++++
>  board/tq/common/tq_sysinfo.h | 15 +++++++++++++++
>  4 files changed, 54 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
> +config TQ_COMMON_SYSINFO
> +     bool
> +     select SYSINFO
> +     imply SYSINFO_TQ_EEPROM
> +     depends on !SPL_BUILD

SPL_BUILD is a compile-time macro, not a Kconfig symbol - I believe it
silently evaluates to true. You could use 'depends on !SPL' (see
env/Kconfig) but given the Makefile already gates the object with
CONFIG_$(PHASE_)TQ_COMMON_SYSINFO, this can just be dropped.

> diff --git a/board/tq/common/tq_sysinfo.c b/board/tq/common/tq_sysinfo.c
> +/*
> + * Common sysinfo helpers for TQ-Systems SOMs

The commit message says 'The helpers set up the U-Boot environment and
fixup the OS Device Tree' but this patch only adds a single helper
that touches env, with no DT fixup code. Please bring the commit
message in line with the patch (and drop 'a number of helpers' - there
is just one), or move the DT-fixup helper into this patch if it was
meant to be here.

Regards,
Simon
