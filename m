Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C3DE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56DD7874C5;
	Mon,  2 Oct 2023 03:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ex1x0fNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962D8874B5; Mon,  2 Oct 2023 03:22:58 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFC887286
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5346b64f17aso12502511a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209762; x=1696814562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gYS7FfplJS40diF1YtIDaZfZUt7poid6fjOptITHCUI=;
 b=ex1x0fNx/QnctbrB5U2UYnDygKzDztQmiJBKbjch4e7bAG2Mv79bv+pPBV6WPNsNoj
 54CE53eiAIVgSMjvkx6lw8xl/56S3DbwlfG1R+AIFH8udMovOVsWGnfvxbTwx2zwISpS
 SW5mDISmJOjERFH0FaUPyJn4QtDUoNU3mLpgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209762; x=1696814562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYS7FfplJS40diF1YtIDaZfZUt7poid6fjOptITHCUI=;
 b=rrxIDGSHxtM+8H5ypBv/Ut/doP/J5qGwkBTD4SJ9xfY5UVJGgFPMu1k+W8jRgfk6xl
 mdHUB+tfvhHcnCQt+DbUE34vAYXMLtpe5KcYDKJf5ww4ArFX7OHQmpfDj3JBSrP5qynx
 UWTxgc9KrKRApv3GfsU+HIsuRc7KErC3MtbU9XAADf6hNIXB23/zzX4rJ8+HXE5sgn3P
 TNfGtr9a6BNA6ihwpg6hS2r7qqEjBwbRIKnfCQAUMViQPPgSQSWVk3eS+eHS0Y/eHbrU
 5WeA6Hadrvnu46SGm6gjAbsWRo0zJS7fhe7rVokW4umscuVGkNhPQbM3wFYYUt76qQTR
 5hPA==
X-Gm-Message-State: AOJu0YzJezgcHLxFpuxQ6fBE3mQ4ss+twuDRgyfwDcvhfVerw46ldDBO
 pFoxUh84ePiZueFww3Hklwjv1JuS6GCtY4Rp4cFppw==
X-Google-Smtp-Source: AGHT+IFgRTQsvKgvVtlkKauR7uce7QMP+s9a53iDHFAU4ET7pT4tH24nlw4Eisv/zsWOJM/YQoDJUuiXDIzo2l5lqD4=
X-Received: by 2002:a17:906:5a4e:b0:9b2:d367:d818 with SMTP id
 my14-20020a1709065a4e00b009b2d367d818mr6932642ejc.38.1696209762566; Sun, 01
 Oct 2023 18:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-6-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-6-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:58 -0600
Message-ID: <CAPnjgZ3YUKHeVf_-LeU4VmLsGKbVqyV_P57BFPmFYw2vBJ7Uow@mail.gmail.com>
Subject: Re: [PATCH 05/15] blk: host_dev: Sanity check on the size of host
 backing file
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 26 Sept 2023 at 02:49, Bin Meng <bmeng@tinylab.org> wrote:
>
> Since we are emulating a block device, its size should be multiple
> of the configured block size.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/host_dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
