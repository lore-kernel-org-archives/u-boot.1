Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD6C25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD4E88307;
	Wed,  5 Jun 2024 04:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lG65QQnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA4688245; Wed,  5 Jun 2024 04:13:55 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B0E8812B
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ae0c4d23ddso10164096d6.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553632; x=1718158432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qc0FYKMawvi7MxRBWYSP1HyfvSg0q2aM+RJHuJVi2r0=;
 b=lG65QQnA5om6yaJrGZdFShvFKW+/n2hun5QR92TNG9ud38u8R9DRSGOUQbApBnvOKz
 eyEgMGbytF5gtESm4+4a19mN3zhsNx7DAPv8xSUFRnOPIJUlNjjx0ophl04dTgLsZ4F/
 094DQxW00HNdc8BsN41Pde9zEJ6SJOQLc/CYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553632; x=1718158432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qc0FYKMawvi7MxRBWYSP1HyfvSg0q2aM+RJHuJVi2r0=;
 b=Vy9Uj6JJGVHnRMgHaUkHjMlNrKXJQktepe2fBSBOwODWWR/Hn9lbfNRowK4xJZP96W
 xCSzfnW342A8dzRLPUXrmBCx3Voa3CkTi6HqIURMxMI3Ju9/sqTqmxGie6ODm8C9DuUy
 a38lFbsN8EKgBHKkTU3wFVVdFTVqci7h7+4RdsgtzQSkaqsOdC13ZFagvJIemxd/+DML
 hAyyMYSqZQnmbQGmJnxHkdenL/meaphq6ccM2P133rFkq6gH/bo+7QyzgqwEP4bLBifd
 jbqf0zQPOmuve2rkd58tQIEF/juGVe4pxPxGWgUxyjN7DyeoeX3yo4md/YzJsfFmvdmL
 LAPw==
X-Gm-Message-State: AOJu0YyXVv3rIttCJfXJGpOUAANdR1H1unxQbBJ/xG/0qffIf+8LtJAF
 6q5PSjYmCrmF2AMV5RDQnLhO7mzlnOZPo3P9/xBJ7B+rr3rFXsN0VHIxP1K3pNy/PncUkwQFNDm
 WvOlVCriY4zrPIP9gYl0oea2ta857r/ErUF1B
X-Google-Smtp-Source: AGHT+IHwXw6Y6Yz6AFJlNCzXckqotC5qD8gDqo0jbPJMYkDmhv4Uo9z3JSuoK0gi23lDscIiDXQVE7Wri+ETArrzuDQ=
X-Received: by 2002:a05:6214:3d0b:b0:6ad:670d:a4f7 with SMTP id
 6a1803df08f44-6b02bf2e200mr12900886d6.22.1717553631959; Tue, 04 Jun 2024
 19:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240604161607.1133032-1-brandon.maier@collins.com>
 <20240604161607.1133032-3-brandon.maier@collins.com>
In-Reply-To: <20240604161607.1133032-3-brandon.maier@collins.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:41 -0600
Message-ID: <CAFLszTimUpUPdKycn8opcpKeXAA9JO1iVVbfnvMNfDfZp660jw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: patman: fix deprecated Python ConfigParser
 methods
To: Brandon Maier <brandon.maier@collins.com>
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

On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com> wrote:
>
> The method `ConfigParser.readfp()` is marked deprecated[1].
>
> In Python 3.12 this method have been removed, so replace it with
> `ConfigParser.read_file()`.
>
> [1] https://docs.python.org/3.11/library/configparser.html#configparser.ConfigParser.readfp
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> ---
>  tools/patman/settings.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
