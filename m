Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB1CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E8DE86F1E;
	Wed, 18 Oct 2023 05:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZCwfg/hN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43AB86F1C; Wed, 18 Oct 2023 05:31:05 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 014E486F1C
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so496444666b.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599863; x=1698204663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qji2VpIfGxq6sFc6+SaR6ZzC/Rq80q2+qZXwf8XOGcc=;
 b=ZCwfg/hNC/giIFbvD51aGuU75ig790EoN5RBXDZNVLWzMmhSkLpxUl4NQ4LBbA2VI5
 qRTVbRtcQxgMZ622J0lB0sg18LWnAvXkBgCh6jWY2rKueU7aXeSMZA+F98NXodx+HSwX
 6Ck2IvKw+YUvG/DY/dv8XCvg/n9wGTrgwXXg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599863; x=1698204663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qji2VpIfGxq6sFc6+SaR6ZzC/Rq80q2+qZXwf8XOGcc=;
 b=lwyw+mSBy6wruG56snJcM/6YSiHL7cHFf/UGivtUYtljppiNYADvtPLtKVk8rXAMVw
 +LqsXWH07MRnP+YRMdPyMBg0S04v+8Ojo0TYy9SBB1wlyHy8ps9QhzD8cYbm/2WysSwU
 +Nc5pTqjW+n6AxqAVqasuKoH5IAAX3vPOOOCpf6yDyPerUGTHLOgqcRyuGIsximXLNRF
 jhjfOE4bTWnmM+DKGcN/ype3G+D8+qCa7rXrBvqd5LtumXyJ4GykHQRTTJbJc66MTNSe
 WNiz7/TN22W8afODa5bA9mUtkv4mTBxSuPHdlIGPEuUyb3NT0gnmWl/X4I2s/dlJXMRI
 Zu6g==
X-Gm-Message-State: AOJu0Yx7iKa43daPTYCFJG29OZPVEbcsKRIrr39X9TuEa2Tv3PTY1mMd
 xC2TApEL9v2sHzIUsR3XWK0sdePymS/ooKM4sIQgEw==
X-Google-Smtp-Source: AGHT+IEj0rFH8jNrEjgRv0gDNg0z5eHFStNKjDh8n/SQfz+pHFaEwlPAWJdfYlWAfHkzVQhbs7F6QWiDp6wF5CKYWzc=
X-Received: by 2002:a17:907:928b:b0:9be:54a9:9b4e with SMTP id
 bw11-20020a170907928b00b009be54a99b4emr3470215ejc.29.1697599863364; Tue, 17
 Oct 2023 20:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-13-sjg@chromium.org>
 <20231017134005.GV3119521@bill-the-cat>
In-Reply-To: <20231017134005.GV3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:30:51 -0600
Message-ID: <CAPnjgZ2hoswhJDEbZOLav5PKk6GVGrnJFEBvuUbVKgwkvuUfbA@mail.gmail.com>
Subject: Re: [PATCH v3 12/32] env: Split out non-command code into a new file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>
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

On Tue, 17 Oct 2023 at 07:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:03PM -0600, Simon Glass wrote:
>
> > It is not possible to set environment variables without having
> > CONFIG_CMD_NVEDIT enabled. When CONFIG_CMDLINE is disabled, we need a
> > way to set variables.
> >
> > Split the setting code out into its own file, so that env_set() is
> > available even when CONFIG_CMDLINE is not. If it is never called, the
> > code will be dropped at link time.
> >
> > Update the Makefile rule to only include the env commands when
> > CONFIG_CMD_NVEDIT is enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  cmd/Makefile           |   2 +-
> >  cmd/nvedit.c           | 122 ++-----------------------------------
> >  env/Makefile           |   1 +
> >  env/env_set.c          | 132 +++++++++++++++++++++++++++++++++++++++++
> >  include/env_internal.h |  23 +++++++
> >  5 files changed, 161 insertions(+), 119 deletions(-)
> >  create mode 100644 env/env_set.c
>
> This feels like it's partly but not entirely correct.  We need to split
> cmd/nvedit.c in to cmd/env.c and env/nvedit.c instead I think.  And keep
> in mind that SPL + ENV (and so - CMDLINE I believe) does work today.

OK, fine, but can I do it later? That seems like an excellent
follow-on but is it essential for the purpose of this already-large
series?

Regards,
Simon
