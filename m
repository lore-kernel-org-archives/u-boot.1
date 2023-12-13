Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA4DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15D787855;
	Wed, 13 Dec 2023 21:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gtqPi7ef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B8087861; Wed, 13 Dec 2023 21:39:15 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E15887863
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55225ed7ef9so1227333a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G9bt2o4PA88B2OBnxV8+SjZLlLySL71emlkoj2HNxdI=;
 b=gtqPi7efp6cZSjJ70h8zFdav+QfezH2QLQP4NYt7ri+cqVtOA8hv+6ABs6WH8+tkfl
 EZM9pfT4bSArahdcYSd7fLAnTDnAARrCVRLVsCM2E4hExFN81AvGf3leR5avdXAsorLy
 x1AS/R3QkK+wU/fi4+VnxL7Oer7ioZBbC19wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9bt2o4PA88B2OBnxV8+SjZLlLySL71emlkoj2HNxdI=;
 b=bbn/j3d6ERapfX9B9rgGH1Nk296c4qn+ydQ2jwJffFNJxjQdnjD4pc+DTowg0NawUV
 dhhchGT4JVFtrEq8Mco/f8VCh9fbNuFSrXIJ1An6F1zUE/tRKSlFAq2DAXCA7biboVHK
 X7P5WRdtZLX2Z4LWpEZRMFI6DPzYUtx68iagcHQZs2YTeDC09lnKst9oD78lTmLxsKBF
 BfL1b3/nh4JzF/y2Ib6mJuF35GscwCPxJVYAXMVNPNGdzUeN4imHArc1huRioHGS65b4
 bxcGLRiYTcTTx840ATgtMCGLS4Ic0RuKYJ/qh5u0iLw5Lmb+GRDeF4AT7K/6hZ1Lwdeo
 gbIQ==
X-Gm-Message-State: AOJu0YyuGirdwxPj6tYDXzPqQ/SsC1iiBFmNtnQv+2tZVKwFN+Bd+EQA
 UVCJIgVynEPxolPlX/8Cjvf7tRgok7iLP6F76DFNDw6GfLyPVeOwYwY=
X-Google-Smtp-Source: AGHT+IELk3/wJGyVg6bi+oZSLyWBdCj2+FUq+aZ+MRfmEiyAqY0SJFpqX6bTnJvQhdq05yQquZqCP8l1JBOEnnIKfQY=
X-Received: by 2002:a17:906:2085:b0:a1b:714f:c59d with SMTP id
 5-20020a170906208500b00a1b714fc59dmr4436439ejq.30.1702499952333; Wed, 13 Dec
 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:07 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-8-sjg@chromium.org>
References: <20231119153611.639252-8-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:07 -0800
X-Google-Sender-Auth: IxAiRQvihmc-oRVd1rU10RISedA
Message-ID: <CAPnjgZ2A1QrRKu1EnX9HHoUy8Riqb_bbRQonK4NQyE2wELn65A@mail.gmail.com>
Subject: Re: [PATCH 7/7] tools: Move python tools to version 0.0.6
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

A new release has been done with this version, so update it. Use the
version numbers in dependencies also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/pyproject.toml       | 4 ++--
 tools/buildman/pyproject.toml     | 4 ++--
 tools/dtoc/pyproject.toml         | 4 ++--
 tools/patman/pyproject.toml       | 4 ++--
 tools/u_boot_pylib/pyproject.toml | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

Applied to u-boot-dm/next, thanks!
