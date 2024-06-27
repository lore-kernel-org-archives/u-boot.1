Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08F2C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EF888580;
	Thu, 27 Jun 2024 21:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBn9jqSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C178884D1; Thu, 27 Jun 2024 21:06:01 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CED788549
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c7b14bb4a5so1594863a91.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719515158; x=1720119958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBArB5OYg88Q04MuxSVKYeLluIuVegC6Y6axRyw22JE=;
 b=SBn9jqSOkZ8x1eEEFN5D1bGOx/ACtIi/tBOPJGEYiu4QHilRlPFv07CpfMp4xdlXXV
 R7dvqhCf7zroZ+g4st3hUp9RV1pEUzDi0dsJPE+Va6Gdvv4VfFirB70d32xyZOFzQ9jP
 ZMeHv90BGZloj2Vm1AUKqyZgvnS09J2124adU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719515158; x=1720119958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBArB5OYg88Q04MuxSVKYeLluIuVegC6Y6axRyw22JE=;
 b=MlSYeQNgohBXRhdcL/OBpskShonqSnBjgfeEsIG5RUR8sDlCY/AkrXbRG5KwjGTa48
 OpppuhEiKsV+3AxSYdDfdpNEt5rQlK1lm6uHruPQvkZVNXbo9HPJ9wrb4Z6kKVQ/TMW+
 WL9ZeBVgmLrt3MkscN2Ix2G0sh1w3suAjrl5j3qiGiTed4deyLay2Q2oJfxTr0ZbRb4I
 4YNMbr0vXhsH5gWsQ2fzRp2B2oz+fCpIjvtTjtZLctch4Hu6e3JZTdWxNa4qf/5o1YY1
 bl/PjqKqjhVZhaX00Z9rfXb5Il4e2idJEK/jXFCKcDTs2IlK7OhwT7f+ZtR2xGFiJ2w3
 mQ+w==
X-Gm-Message-State: AOJu0YwQXDyop3yKssLzwFcXDoWw2M8wCDlkRzR8WL2p3bzZdXEfofuj
 QKcjgxBVu01/KSQvts+mdYjBE2ra6d0T9aZcSTlQX42rKo+OR8PdNt0WtBFlMnyeL+TkF6xZo7L
 9S1sKEtmpzOae5pbmTUNzaNzteRsZBSsHrX5UuCeeBOt/lc4=
X-Google-Smtp-Source: AGHT+IHb/jPMUs5jsHPDLHSUamWxWvVaUgjLT/uNys8TAkXTT6dnzIaIVudKCgdaM9tY0zJn0YKMR2jDff5eZTAm5ek=
X-Received: by 2002:a17:90a:4a07:b0:2c7:b392:8f02 with SMTP id
 98e67ed59e1d1-2c8fd5ba153mr3725889a91.23.1719515157661; Thu, 27 Jun 2024
 12:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240627134320.3518272-1-trini@konsulko.com>
In-Reply-To: <20240627134320.3518272-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 20:05:44 +0100
Message-ID: <CAFLszThziPUCUj8MqSoSTdg178DP+HQ2oxtbs+N8k6UvADzmNg@mail.gmail.com>
Subject: Re: [PATCH] CI: Make pytest export JUnitXML
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

On Thu, 27 Jun 2024 at 14:43, Tom Rini <trini@konsulko.com> wrote:
>
> Both GitLab and Azure (and other CI systems) have native support for
> displaying JUnitXML test report results. The pytest framework that we
> use can generate these reports. Change our CI tests so that they will
> generate these reports and then have the respective CI platform pick
> them up. We write to different locations because of where each CI is
> (and isn't) able to easily pass things along.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 12 +++++++++++-
>  .gitlab-ci.yml       |  5 ++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Nice!
