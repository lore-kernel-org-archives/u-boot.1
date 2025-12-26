Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D4DE8FDB8
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1603B83B63;
	Sat, 27 Dec 2025 00:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgDS+dyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516A083A2D; Fri, 26 Dec 2025 19:57:19 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131858398D
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso8499437a91.2
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766775435; x=1767380235; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NWcf9Ow6tbOoEwFtUbTuzfNjDjvi/vE7rpStlSjOqV0=;
 b=SgDS+dyrjj9WYuw+Tf0Yu9pvqO5v5WLG5hvJ5r1P5KN4x6Dr9jjn2s7X2jQQ8LVc+n
 C5844hoSdN78hLGNOmHQg9j5ql8gwQ4iszvE9lJayMmtnE+qwsEw8uNnlxkj2disMTbN
 o+geWZRVmV4Ycq2lXYfYJ5b5GX45VL3QWXHPdc29RcGvcAVKNvwyYfR7jE+4SbuwDrsu
 ysPEAX0fAIjfeYNpwnONuq34lLmuaT1cvm0WqJcFTJPG35ceVif7HWP0eeI7hnYJgQHO
 PTOD2aRO6EeI/gS6a/dNM4wPVcxw7s0XKtRpy2xQbDvKqSapuHqgFMEcgcr5Q7GhUxqp
 bfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766775435; x=1767380235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWcf9Ow6tbOoEwFtUbTuzfNjDjvi/vE7rpStlSjOqV0=;
 b=pWU4KjFY3Vu6sUcezYawXn6n7DuAL53jparyTy1vG5V/H77KJ/oQL8x+4KF3WDkFie
 31x2BetEVfrMZVMaLTG7KK+kAE/s1BbflZ4Etc2TnkEuFh2WgfIx4D/SFrhrtpOkY9vl
 s7NyiKhFdeoXRJiNexATUebNpOSJc26swTPB6J3BTqzOjDWNCJTIFPXv8MgSK9VOTSk7
 L0aM1N7RPon0qEOkb58N7TihhqxFfsIMcMewkd4VFaY802W1Js7FPdfR2QOPQnzRSJ0D
 mh2Y37VAPT+15wj4laF68DfLdZ5wcUUHNnuk+jBIFqBPkmlSo1X+EzEivO8Nb6ajgzaW
 +d6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ehxWUq2Iv0w8zliyEAuNtClFdKD9zmvKebSp8MUeMWwrxdo4RJYFmKZfNUVJQZOm0i29C5k=@lists.denx.de
X-Gm-Message-State: AOJu0Ywliaf3AOS04roBQ3pAlxfVI15tUVD5YGByF7Y9zqv9ug326Qfg
 bQ7FBOH5krj9DyhHFfHur8aMzRMVuBkbte6H2X3tiDwUUBjnn++K/boV
X-Gm-Gg: AY/fxX43Na8KvtT6FQq/hhKosaC17WCdF3YIBQY13H2O+qvi+GrJthlWnv5oq49T5ST
 TGR9sMB4quNWJ9Go+CSEiDzmxlBqG6lufyI95aT3t5WT5ppZ1jFesRAsr2gETmMFAHE1ok+nVJ5
 GtHbvHTsi1dflJxnit4OQmSenMtooYqbwdlXH8iAE3s77vfbSM6/BSldxgbwQfaWUJrd3cBabmZ
 qrByCJjsD4ZcEHUx1eIZ64Zuw9ZzdEgXrL82voIKlWNqTxJiLZQJRS6aGQiSc6s+pbz2dwFK5UI
 9ykjYHWpEa3+sWLvKMC0HBZSNBtwEQtMwJKtX+WxB54+ATwVm/oeNux3zxUy9dfxKuJE6XQOrvf
 1AOzp7aXwGCe4G9ezCdZBZbYCMfhbSXARvwzSycYkG36on3hJYxWH0FOb6oJ3Brg9h+zISOXvir
 o02nRRDrmxkLUnA0ORBs8U98Xq4/D0a261WoxMNbSfxD9EwpoPT6zo2Hzzqg==
X-Google-Smtp-Source: AGHT+IE10MbZv8k8CKvMz5eML34IhOHPb+47uCE0/L8w+5lAaMzIVkLDEyMO9g7p9/BzX4vijVnoDw==
X-Received: by 2002:a17:90b:134d:b0:34c:ab9b:76d6 with SMTP id
 98e67ed59e1d1-34e921b9fb1mr19427152a91.25.1766775435401; 
 Fri, 26 Dec 2025 10:57:15 -0800 (PST)
Received: from google.com (61-230-47-222.dynamic-ip.hinet.net. [61.230.47.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e9224d9e5sm21101792a91.17.2025.12.26.10.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 10:57:14 -0800 (PST)
Date: Sat, 27 Dec 2025 02:57:11 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] CI: Add test jobs for QEMU m68k virt machine
Message-ID: <aU7ah4cc1maMH1KU@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-5-visitorckw@gmail.com>
 <20251226180904.GF710860@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226180904.GF710860@bill-the-cat>
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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

On Fri, Dec 26, 2025 at 12:09:04PM -0600, Tom Rini wrote:
> On Fri, Dec 26, 2025 at 05:54:00PM +0000, Kuan-Wei Chiu wrote:
> > Enable CI testing for the newly introduced QEMU m68k 'virt' board on
> > both GitLab CI and Azure Pipelines. This ensures the new M68040
> > architecture support is built and booted correctly in the emulated
> > environment.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v2:
> > - New patch to add CI testing jobs for gitlab and azure pipelines.
> > 
> > Note: This patch depends on a corresponding patch to the
> > u-boot-test-hooks repository to provide the necessary QEMU
> > configuration: "travis-ci: Add config for QEMU m68k virt machine"
> > 
> > The gitlab CI job has been verified locally using gitlab-ci-local tool
> > with a passing result. Azure Pipelines has not been verified.
> > 
> >  .azure-pipelines.yml | 4 ++++
> >  .gitlab-ci.yml       | 7 +++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index e4695f1c55b..41bba8ed0f1 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -518,6 +518,10 @@ stages:
> >            TEST_PY_ID: "--id qemu"
> >            TEST_PY_TEST_SPEC: "not sleep and not efi"
> >            OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
> > +        qemu_m68k_virt:
> > +          TEST_PY_BD: "qemu-m68k"
> > +          TEST_PY_ID: "--id qemu"
> 
> I see why you set TEST_PY_ID but that's only used in this manner for
> platforms which can be real or virtualized, for the qemu targets we just
> omit that (and then name the u-boot-test-hooks files to be "_na" or can
> just omit that part. Thanks for adding this!

Thanks for the quick feedback!
I'll fix the TEST_PY_ID usage.

Is there a preferred waiting period (like the 24 hr rule in Linux
netdev) before I send v3? I can send the fix immediately, but I want to
make sure I'm following the proper etiquette, especially during the
Christmas holidays.

Regards,
Kuan-Wei

