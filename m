Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57EAC30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE139886DA;
	Mon,  1 Jul 2024 15:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V92yykv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513A4886C3; Mon,  1 Jul 2024 15:57:58 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407058848D
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b4fe2c79fdso17554876d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842275; x=1720447075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xMvenyAo+z5FKTl2nc65Uf/PwHJso859mdokYVhchk=;
 b=V92yykv3megSCpl2XChOOH7OSfgjWIfp1+YAZ9+f2AszvA0PHBT6sw7kHYlFFK+SZ+
 4jaS4wA7koEA5cAspqLP1gZb2JrbrnMm8DKwc81c2VHKNjKBbmHjp0hNfe+NuELqbrv5
 eGTTJgh7oCZS+rCPf/3n0Gp9jyP91VqecsF8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842275; x=1720447075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4xMvenyAo+z5FKTl2nc65Uf/PwHJso859mdokYVhchk=;
 b=sM8yLC97Yo0jhFbmZxCmifjtG+6sHpdCbewmx6i8QdiPtWeJBvTd0dn9i9MBsBibsK
 yRy1d9sqwaHrR+4czuq8EVjV54NOe0F90V+0gDShmnCCFk1AesnMsYvwBuUX3sRnsjis
 OD8pyHGsoXWN+XjEkRhHkQ0CfXDE+UoylRuJx4CbhGuMqJDUQ2RpZi0JXgzgxjOmoAAs
 OoxcZXiJ0K7ohZT/wHtvidNz2Fk5oc+emMGuHIeOsVLsN/bR5WVyzZBpNZ2W3bVHXCjK
 JQmbJnRLnNqiQXqFwzXhaMcJF+YsZ5KAsujm1NaqNAdPJZzpiJMQ711UgqxTqoH2tEyw
 zNxA==
X-Gm-Message-State: AOJu0YwOCMPJ66f6TzDfiibIGnMq+lbgMAhZejFuVA84X63hgGWyQC6B
 O4vs6dHSNRrPYsKlSR2nnwM7nYjUF5Bjn0DBTAz3YehU13tHekBjQ3Y9Z+dQbaPO8UvAdx22jqE
 OV00jd/r0M7d8VqYGrT7Hztu5h5neGWYrlh4hJW6Z1GOdkGQ=
X-Google-Smtp-Source: AGHT+IHvvvPwGJ4E2XTGF+e7jt4f9+8OcWe8VXBRao1hojFgFXZJhiVOxbP/F7BPVC7JZ82xa17qSxHBA2dQNcHaOJk=
X-Received: by 2002:a05:6214:21e2:b0:6b2:9c0d:4849 with SMTP id
 6a1803df08f44-6b5b6f5e9b2mr75873436d6.0.1719842275195; Mon, 01 Jul 2024
 06:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-3-seanga2@gmail.com>
In-Reply-To: <20240419023632.29078-3-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:44 +0100
Message-ID: <CAFLszTg6OyE1tnQTjkci1Q5J2X3NOj4L738BEd80pdTLX-T5eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] patman: Add Commit-cc as an alias for Patch-cc
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

On Fri, 19 Apr 2024 at 03:36, Sean Anderson <seanga2@gmail.com> wrote:
>
> Most tags referring to commits (or patches) are named Commit-something. The
> exception is Patch-cc. Add a Commit-cc alias so we can use whichever one is
> convenient.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py                                    | 5 ++++-
>  tools/patman/patchstream.py                                  | 2 ++
>  tools/patman/patman.rst                                      | 2 +-
>  ...dt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch | 1 +
>  tools/patman/test/test01.txt                                 | 1 +
>  5 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
