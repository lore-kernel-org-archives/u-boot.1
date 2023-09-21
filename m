Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD670CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0682086CFD;
	Thu, 21 Sep 2023 03:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="OJUDUGhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3CB86CF2; Thu, 21 Sep 2023 03:03:11 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24F486CAB
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59c0b9ad491so5357597b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258187; x=1695862987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=za9rj2EcOqaV93JRSu5Ipys2i1t8FM6njb26Ty0RL6M=;
 b=OJUDUGhK8ASCvveJzjFV2lsJT8orPZT6gcmLKvRXea+KvJdqxs+Q3Vdrth0ahBKPHt
 HDMQbtHI+eJD8wOJXg7DYWaWUi49ADLchj3MAduH2FClXAbSp32gtgVnEt7FxF/iXzEy
 HodzwyIzjjcKX6gMq5F5TJnN+q/HJ0bwj8kMSP6P6x5X7NvaGiBwn7wkNur/7/jhuXdz
 5x3gUiB+f0dsBTx+9T7vudRVzMaiA363t4HX+ZDCAgbdXTcinKslX8q2GG6Pe6e3MXsp
 S+Vp//ckmwUbBFroIGziT4VwEgPzwxvRMnYXejelPIqODJ7EFC2LrKwSJeMSqcO313fs
 VHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258187; x=1695862987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=za9rj2EcOqaV93JRSu5Ipys2i1t8FM6njb26Ty0RL6M=;
 b=WSyureneMHQrEoIXD2Sr8/LpW8PvwcSKshBVE8BXxoxVC76fEpX/ecwajtiLx8BvNU
 +IQ4FloPULa/oEZ0PtASSlh9tIdw1IPhGlgL4gh42buuD0Qkkb8/BC2yW01X7hXQjNNV
 +MPB9HaK1fiG6hMtkDsuAcADZmzN5+loPfBQSg5RQJROmt4fywQcEi4LVNojKTPmDowT
 0MBJgYsWcPfjsKv1o5PNEJPcV2kdBjojEJ3tNHs6t8dAS9oiw6JPOXrQEcBqD7JkZCsu
 XtLCyHzzSAc3mJZPalTsp8DRrQ8wIHBrQ7s+sHhpv10FefEEwXyZRuhnKfxMmwYR6Baj
 TT8Q==
X-Gm-Message-State: AOJu0YyYyEdb+P/5uSKPSjKZTy5tkLbn9wMSfVdd1AGmFESjdN79lb+n
 7jBowusxznMFf2kRobEN8vzEjk0bsV2nnBeG0DkqEw==
X-Google-Smtp-Source: AGHT+IF3zvWeITQ8fyo8rOK8b4FgpyxjOrPe7WNMu9GgrJ6LERNHkxYLK3+IxKAw6Rls/oQJbZJr61ZRQrPPhnURNYQ=
X-Received: by 2002:a81:9150:0:b0:595:733b:38b with SMTP id
 i77-20020a819150000000b00595733b038bmr3962439ywg.19.1695258187120; Wed, 20
 Sep 2023 18:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230920025450.6281-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20230920025450.6281-1-venkatesh.abbarapu@amd.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:02:35 -0600
Message-ID: <CAPnjgZ1jqbZDdQmzk__6JP6Fzq=bp0Jg01DDg09brVMX1ZbqrQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: sf: Fix the flash_is_unlocked api size parameter
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com, 
 git@xilinx.com
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

On Tue, 19 Sept 2023 at 21:42, Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> When flash erase is called with size parameter, code is checking
> if sectors are locked or not. But for checking, the whole device
> length minus offset is used instead of actual size which should
> be erased. That's why when only some sectors are locked it is
> not possible to erase unlocked sectors.
>
> The length is calculated as "length = max_chipsize - offset",
> flash_is_unlocked() api is getting updated with length which is
> incorrect. Fix this flash_is_unlocked() api by passing the size
> parameter.
>
> ZynqMP> sf erase 0 100000
> len=0x8000000 which is flash size
> size=0x100000
>
> We need to update the size in the flash_is_unlocked() api and not
> the length.
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Updated the commit description.
> ---
>  cmd/sf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
