Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01DACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A7D87FA7;
	Mon, 14 Oct 2024 08:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S4dN7Rar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C88788F57; Mon, 14 Oct 2024 08:56:18 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1592987F7D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c97cc83832so790507a12.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888974; x=1729493774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=suCo//vCmt6wMr67De8PLu2GZ+Qs6qlF9r4GARIUmVw=;
 b=S4dN7Rar16v33Lpl7SZK6b1dwtZlFzEWe4R4L++gcUvxEQ8ehPDL+dM1wvtI+noeFJ
 UuuRXeNnm71xZuXsQ5ThgMhC2hAidpLJyl8vuTjQxFEqpQXTRSv/clqW9GamVlJaKKSN
 7BLBMTYlwhD7YBJpxGNPDRv39/ojevcpPabz6/qu7VRhSvoqGkexVwijhF79guTOMdu2
 56slf+S0T1XgQRzJJbDzVxCUpEvB2TW1/8dh+zACnPZmedVO034xnRDpMesHf7Oc0s3l
 Y8/XljJ+N/QQLNhckdcUHlh6Hs2c7WXMrGsYrnP1QhLRf8YBspJFpORUrxESfIhqg6wt
 R/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888974; x=1729493774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suCo//vCmt6wMr67De8PLu2GZ+Qs6qlF9r4GARIUmVw=;
 b=Wlje79dCw7RludTObj0CUhIr31ce0wzSCGzIf//jNG9zFSO6fBSOxEzGGjNeHiQY1x
 kJwTD+Ci6KCoLJs2LNhhd17cwkVr8z4AX66kTbrZkdQQ/+SbE8SDWiZUh3mC/GBOvuuu
 g88ymGuBpN2BMqjuhJ6Ikd/VGfKWPxmGyrKgJpkTNK9WRTef6mffejMUJVd7zF3JQkLt
 vblyAK8inaIv4+fMBdLTaaC5ht6KyuXZ8X7A0+QxdEuC9qfws3f2s9txWdrRlyJ0xnGu
 XY/sLNnGAFKJtjzSnYUiZe5bYWYRoWRFwibmVUXwGeZ6CcxFp5TrrKUJ6GpEPh61+BqF
 bZkw==
X-Gm-Message-State: AOJu0YxwTH0+lA8c3JtVMnxjZNFGyIgEHL+3xHxNSnN9CvCWB/QhRxLi
 bVfyV3hCFg5507dX8moNYy7EGhosHxwVP/r8BirLMS8CBMA83l3nyU/G4XqbIrAi7WrkXTDf1Hs
 twoEk41+VsuhskT8AXMI4xxiCc5JZkjc1IAm41w==
X-Google-Smtp-Source: AGHT+IF94HieRwIcyBxwdAu2AOJY6ThQeEtfDxxY9scsc/rpnPAUCL1Bk/FKue9YvspyVj5IictwC6xMsSqh0aXKtXk=
X-Received: by 2002:a05:6402:234d:b0:5c9:753f:5aa2 with SMTP id
 4fb4d7f45d1cf-5c9753f5e61mr2900464a12.7.1728888973782; Sun, 13 Oct 2024
 23:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-3-sughosh.ganu@linaro.org>
 <20241013175146.GN14210@bill-the-cat>
In-Reply-To: <20241013175146.GN14210@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 12:26:02 +0530
Message-ID: <CADg8p97a5jVR=_YRpbzBDEFLzPea-UtBFHc+X679vyPhGfC2Xw@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] lmb: add a flag to allow suppressing memory map
 change notification
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 13, 2024 at 04:25:09PM +0530, Sughosh Ganu wrote:
>
> > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > reserving memory. This will then result in no notification being sent
> > from the LMB module for the changes to the LMB's memory map.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Can you please elaborate on what we need this flag for, for example what
> the valid situation for it is? We should be updating (or adding comments
> such that updates are automatic..) to doc/api/lmb.rst as well. Thanks.

The flag is used to prevent notifying the EFI code about the change in
the LMB memory map when the alloc/free request originates in the EFI
memory module. The EFI memory module adds the memory region to its
memory map as part of the alloc/free operation. The idea is that the
LMB module should notify EFI about changes to its memory map when
these changes are initiated from non-EFI consumers of memory.

-sughosh

>
> --
> Tom
