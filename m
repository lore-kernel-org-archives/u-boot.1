Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3797EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBD0871AE;
	Mon, 21 Aug 2023 21:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RD7UwwO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A6587110; Mon, 21 Aug 2023 21:11:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CA087072
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-525597d891fso4727767a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645114; x=1693249914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd6RW0flI+K86nFojj54+O+48Isdroab7wBBqU7ihsk=;
 b=RD7UwwO6mUK2WPdYI/eUMZ9iKrM14KC5An4LB/31iiyvAd8k6FnFpEWynkx3wHC+pf
 hxVLHn/J7cMpMwHNljANCdK9sUgZGV/lSij0d/O4TsjuwCKudpcEqRFmNJSloxPRu1Gb
 4KX2vJZpa+n9ZoJH5LBxuoEm6HRmucJytDFM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645114; x=1693249914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rd6RW0flI+K86nFojj54+O+48Isdroab7wBBqU7ihsk=;
 b=FFROp2J4RZnIBbbSqQlA4pLH6yS9epPv4KFGblG02Nhu2I6GU5G5N6iDlD9E/9dt4n
 EH7ciD7tR5PDLL+wrWJzv1l2NQa3HrOSZ43S+Ji72iMQ7Kf2FvEiq7geox4kLqpZJzLE
 r/09TAaDnu/nI5nT6Isc9EKKaHu2Rco8nDHF6rJxVD0HkDSJgnNLUoB62R7WaTPOFQ+t
 kYp0jNtiwe39sQ0ZCMk71bruLl9TiwTCkqxATkN2S1i6dm5rfNM0+lIcxYOlLFmFiJPm
 Edb8JixCoTp8M0VsoORMutHtEpsB3uFWRJCoAu5Gs2u0G9aZ626WuyF466P/k0HdH7iq
 NMfg==
X-Gm-Message-State: AOJu0YynHoMFuPrG5vg/4rCwUOTGsZst2ZePH4i5gtNdMVt1hc6hYLLh
 EEE3YAEzLMpPDOY/gsQKfVZrHkhiSxLypq2hQJuI1Eoy7rhHg7PSLDs=
X-Google-Smtp-Source: AGHT+IFNExPczKC3NExESVBvVwCmMebG4J5F8KwZISZCld0bFcyyjaSjlKJ/+oP0N1IFupzu+tz032lVHpmyevFg9ek=
X-Received: by 2002:aa7:dad5:0:b0:523:33d7:e324 with SMTP id
 x21-20020aa7dad5000000b0052333d7e324mr5883465eds.38.1692645113800; Mon, 21
 Aug 2023 12:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-2-trini@konsulko.com>
In-Reply-To: <20230820173129.781985-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:41 -0600
Message-ID: <CAPnjgZ36=nfdSOESkpUDQS+hC-cMaE9Mn0P4oXyDUWJxKfmPFQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Azure: Rework build the world jobs
To: Tom Rini <trini@konsulko.com>
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

On Sun, 20 Aug 2023 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>
> Now that we have 3600 minutes per build job, condense and rework things
> such that our overall time largely doesn't change, but we can also
> largely avoid having to re-tweak this job to avoid timeouts.  Given that
> we have 10 threads, we also move a few of the specific sandbox test
> builds to a prior stage.
>
> Note that while sandbox builds with address sanitization enabled (ASAN)
> not all tests pass, so we limit ourselves to just checking that the
> version test passes for now.
>
> Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml#timeouts
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> I believe we merged ASAN with the intention of fixing some of the found
> issues later, so this isn't really a functional change.
> ---
>  .azure-pipelines.yml | 100 +++++++++++--------------------------------
>  1 file changed, 25 insertions(+), 75 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
