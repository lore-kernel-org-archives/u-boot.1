Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5965C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18247869E5;
	Wed, 16 Aug 2023 17:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+lvwj8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389F1807C9; Wed, 16 Aug 2023 17:08:38 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723A8869FC
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7225259f52so454878276.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692198513; x=1692803313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sN1zSGVQZs3/Kj51De/cexNjnbyIlw5EPX/wd4oZllM=;
 b=K+lvwj8YBnq+BNsxRM6atCel5koecNFhmudI1FtrZhlAfTFhAXlheE6PZlZROLcZD9
 0xYgyKrjOpcHjrWcBtOTpwDnBaOsjHA6UnqanRhTWqak7qASdznqoYnIpeCA6Pth3UQa
 9T+UKGtNbSCsjZYnyDKFW4gZVd7SBET6sM7uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692198513; x=1692803313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sN1zSGVQZs3/Kj51De/cexNjnbyIlw5EPX/wd4oZllM=;
 b=EMitn6a095RsfJKgy3ftzH5mxHf2Liqg+EnyA7JKfYPbuDeVvy/Y6uvSBzNMR3KH/E
 cxvIwdF5q7Fv9uCLkTCe6/jMiSgooEIpxoh4hPSdhY4/lx9fI4y8zYYuoA3o/cP9JyEu
 OOZDBZtkIpy79dkMLSisP1O7Zz3OPCh/S3GMVKo540c8nHICbE7ycYpz83cHltlnnsdu
 PvsfbtPbc9lzTCvURI0Ep1SjrXguw4K7KwHQlXfXsokoCKMRlI89g+C7TfdRgF0wvSqr
 Xwyw462RucFEMPJtn0PCo9S+Zq81F7qP0VsTtANnZBavrY3hEu82XqFfTeUPugAt8TC7
 UCcA==
X-Gm-Message-State: AOJu0Yy1HAswBuz1R02rJLOhPO9uIPOeCGP+P2+Mh2t/+BzaPBD3Cggn
 aTtFseuIXSwU9y+SkB+RPqIlDT7eDTOJplfXXv5PMYn3/FpID2Y3n/g=
X-Google-Smtp-Source: AGHT+IGt+ZH4n1a4G8U186yoGG7u/JLNjsnBWOzdE5nWEB2KKRaGddFsNCexMns2AQz75gGVrrt2rhifdMsjm9XVx+Q=
X-Received: by 2002:a25:d5:0:b0:ca2:f20:4139 with SMTP id
 204-20020a2500d5000000b00ca20f204139mr1875147yba.64.1692198512701; 
 Wed, 16 Aug 2023 08:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
In-Reply-To: <20230727215433.578830-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 09:08:19 -0600
Message-ID: <CAPnjgZ2krc9eTrCye9UC6=HM8oTrpVmv8mHEGHJRu5kqu7ts+w@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Matthias, Peter,

On Thu, 27 Jul 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> This series moves Raspberry Pi boards over to use standard boot.
>
> It also moves rpi over to use a text-based environment. Unfortunately it
> is not possible to empty the header file due to several CFG options.
>
> Fix the repeated "and and" while we are here.
>
> Note that this reduces rodata size by about 4.5KB. We could get another
>
> for a total image-size saving of about 15KB. This is mostly because
> HUSH_PARSER is not enabled anymore and the environment shrinks down by
> about 3.5K. Hush is not actually needed anymore, since standard boot does
> not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> pxe_utils code directly in that case.

It has now been about 6 months since I sent the v1 series of this.
Even this v3 series is now out of date (in the cover letter).

Is rpi still maintained?

Regards,
Simon
