Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ECED767F6
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10456892DC;
	Thu, 31 Oct 2024 19:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="frL9DrL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DDD892DA; Thu, 31 Oct 2024 19:00:39 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1817288B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20caccadbeeso12965775ad.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397635; x=1731002435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gLZ0xOapYT12XaR0Ns6OKsaPC6Mx7hsG5HdH9Cr3e/Q=;
 b=frL9DrL2xkNi7omGNr3cyDBIhaYZrhhLkgzm0bZeUoJtZP+owbYCqkVnnkq7ERbAeG
 hfPii7geSKsdRjA2avobHMJGO8j75TWZtf8pbzqU/O3Avbnk8QV4/L+2FkNYfJaUakoz
 zn+SIBi0/K4C/n0OyB/MEoZMOBJ+TjqCEka/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397635; x=1731002435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLZ0xOapYT12XaR0Ns6OKsaPC6Mx7hsG5HdH9Cr3e/Q=;
 b=fv3X8XQsHmH/dHkLxAlLQBt7ij3XEj9Lg7edvJu7G5GZcPZ73KqcUj3G4/SgCqIPA+
 pkDOmDZoUZLPZrwJnFP1lanqx4GSJpFZAdhQiZH1S+9fNywBUbFT3s6YSt2a83qE9qlW
 lpOItxaV4S6Y5+FMdwOALqsPKkxXsttuDHz2m2BO4rBX3DZqXWlqn7f8pPNePGfaqS6b
 LY7ezd7MuYnyKWMaexX/eZBImGYHto/k1vGxxWSoCZ7Ct1+WlQRCRbsi3tXjqNxQMpKO
 dovgrgDQSSpf8pX7okdyYCbFrwOUdUzsESpLF1edUiu8ljuRlIJ6+Yuia/NUSq4aqEch
 bCrQ==
X-Gm-Message-State: AOJu0YzxVNyZVmM8iY+Jz9o+4XdNH7iIbYaF+re+x4xvAXbDjFLj+BLT
 Sc6e91AwcY4jpUlj3Z51R6IwAULMLxyqlqEhn5N0w7Rd0v/7aQCWQydrrpdC+Bv6HEC9GSEPoQ9
 XO6i/PclwiLDRSFXr22GYZsgL+Cv52yC0noseb3INvH7ZhdFGtQ==
X-Google-Smtp-Source: AGHT+IH4+V2wsX2DmtvM1mtqahkHEBPo93hmRJOc6ivHWF96BLdFlLU4iiktt2vvqMze3UOsutnHXCNj2xXwWONtfg4=
X-Received: by 2002:a17:90b:38cf:b0:2e2:ffb0:89f6 with SMTP id
 98e67ed59e1d1-2e93c14fd1emr4959064a91.15.1730397635540; Thu, 31 Oct 2024
 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
 <20241029235303.GC2558755@bill-the-cat>
In-Reply-To: <20241029235303.GC2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:00:14 +0100
Message-ID: <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
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
> On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:
>
> > When a board is finished with, the lab may want to power it off, or
> > perform some other function. Add a new script which is called when tests
> > are complete.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> But please note I don't see an up to date version of the
> u-boot-test-hooks side of this which would include the release wrapper,
> and presumably files.

Please see my patch from late August "Provide some basic scripts for
Labgrid integration"

Regards,
Simon
