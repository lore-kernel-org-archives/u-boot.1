Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B208C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD0B88AE1;
	Thu,  8 Aug 2024 12:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQO+wPVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3AF88AE0; Thu,  8 Aug 2024 12:13:51 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7348A88A67
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb56c2c30eso1360098a91.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723112027; x=1723716827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+R4v6TuI8JY89C+kmlOQkaIN5wrzxaIJF+5lNMDXJnk=;
 b=nQO+wPVsm7ZKgqesPo6F38LGwb7k15HpsKm99X3dobxKbJoZJk+W/Pz/rawmBe7HAA
 gp98y1IHbZixX+iwckOs00SCPx+LhoiCVC66YK2xMC7R4JdXjWv8SHJkUjyMnELmqE/8
 XVlQw9ctai08CrGE3258tPmLvSnv7VfzfiJuie6RWquUB9xcXZtloP0v3qGOXw7X754g
 rcMhBf+g6ll2PFt/r2lQf14vaxGswt0Jpvxb0h29P3kSyNw5Me4jCLoiZOS61mDrlW/S
 4tSserTKfwWS6yR5qsn1MbMxLe/bL6ymuSvdxKl69TtupxGFvHo51OBous12FQcAJuTR
 W3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112027; x=1723716827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+R4v6TuI8JY89C+kmlOQkaIN5wrzxaIJF+5lNMDXJnk=;
 b=HRPfYfReFBvSaumzdCZLRKyUc/diAOBp4e3BkeoglMauUdp8BOhQnuIT5kOBhxFBzm
 uOS4apgLRBXSSmllOn2X3ASTK/Eb3yyNN3F1RBIzJ9KH0gV5GlzMGrt7PQY6uXEY69Sg
 9vdU6n0Leh4Oqp56eHch3wJuiqeCTmY7nL7P3zDyyYhZEU8C5af1DyLNTxXL6yGYwQad
 ADlCjY+QjkvAlE1gWS+6y67g4hrCi8wsL4b/qgqKAAQ46GNfFUUQeLHVTxISxPSIefZv
 24lvlFZvTdjJzvxSvHi59qReYuiz71KhQ0vqwno/mbKD36pZFNGVKzjrWI3lqNUTakch
 opqg==
X-Gm-Message-State: AOJu0YxILj2U001GuxvUpDCgC/UVKwkkh/8R4nvclLdppWo86mS1E6t2
 6UJzXfcFm84llSMMvjZgtT5Nri0lbbRhalJ0gXjMguBbm6WoCvrerSoSckb+bO2W7qg1I9RlY8t
 se30Q5XO8isZjAZx0G8G+8ywrMIRInM6N4HDgFg==
X-Google-Smtp-Source: AGHT+IHcFw9jHaG0vY1y13OTjNL2np7Vn2xxzRs6oEdFTM1Jkvw8PW7XWndeVUzhRmRfe7NB58BSqVNwPt9vTmJnF/8=
X-Received: by 2002:a17:90a:67ca:b0:2c8:4250:66a7 with SMTP id
 98e67ed59e1d1-2d1c4f7fcf3mr1903502a91.1.1723112027299; Thu, 08 Aug 2024
 03:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-22-sjg@chromium.org>
In-Reply-To: <20240806125850.2316956-22-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:13:10 +0300
Message-ID: <CAC_iWj+-2RtLhCFkY27G-SYvbcrWfu4HWMajT4L0WfjEV+uUqw@mail.gmail.com>
Subject: Re: [PATCH v2 21/39] test: mbr: Unmap the buffers after use
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexander Gendin <agendin@matrox.com>
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

Hi Simon

On Tue, 6 Aug 2024 at 15:59, Simon Glass <sjg@chromium.org> wrote:
>
> This tests maps some local variables into sandbox's address space. Make
> sure to unmap them afterwards.
>
> Note that the normal approach with sandbox is to use a fixed memory
> address in the RAM, to avoid needing to create a map for transient local
> variables.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  test/cmd/mbr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
> index 1a35ba3351c..8a4d61b2928 100644
> --- a/test/cmd/mbr.c
> +++ b/test/cmd/mbr.c
> @@ -461,6 +461,9 @@ static int mbr_test_run(struct unit_test_state *uts)
>                         "5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
>                         ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
>         }
> +       unmap_sysmem(mbr_wbuf);
> +       unmap_sysmem(ebr_wbuf);
> +       unmap_sysmem(rbuf);

Seems like a Fixes: tag is needed?

Thanks
/Ilias
>
>         return 0;
>  }
> --
> 2.34.1
>
