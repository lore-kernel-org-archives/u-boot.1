Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3140C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404F9876DE;
	Sat,  2 Dec 2023 19:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iu2tm4QC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1F687713; Sat,  2 Dec 2023 19:24:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A5D87642
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d7692542beso4072887b3.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541474; x=1702146274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnAvep1ScZ9SLduaRWrebor0/9pU9a3qx7A7RxxBOik=;
 b=iu2tm4QCtbiY+zSOIVGd+MKj23ePziETtXVLXzNTMRimSBJHPNrX7lNkCoxKJEAob6
 MJzzznv8kxTDskM7IEqhQSroFkpJsEIxSMVUU/eK4qZ7qNSq2Z/D5Kfw1E09fJLk6LE6
 ZFm/X9ld4d13CNSeOU8mTAkYYdxt3QnPtu9oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541474; x=1702146274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZnAvep1ScZ9SLduaRWrebor0/9pU9a3qx7A7RxxBOik=;
 b=wGx/hubIYBFSp7RR99Lrb65cVMInKblrugq0cT+s+y/QWL4gv5rhnqHpNUPbonPz03
 PJIOoIn8i2nix9NARWsMwuqhNSLOz24ezsC+5LuQsLaUWao76r4CxKaJmuZPFejJljuN
 +4t/gMAPsjbTi6kOWu7VGSTk/nFdFDAQmT9pe8dzf5Z0pQFzI4jsnQ9oYXMTl8sf++ue
 aIgUF6FZsT8PpbMRC+bkHQruFmGtqZeOLQgkYeP1021HXHoNlWaHLGz8jyTx1PLQXa8E
 8gO8Cvuz7/M13hjx6Y0aCqDfKZr3acQoviucBPh6G/iQoAIAJhxAuhLTDkRBXZ7ZA3TJ
 wt3Q==
X-Gm-Message-State: AOJu0Yyx0DDnwpUP+eZznQQvjKtC/qbm6ifIlKwa4IWo3lnsQlNURJDP
 4i95R9qzsg5lE+s2gXjMBggYZFrCyrAg4zfFQDOuRg==
X-Google-Smtp-Source: AGHT+IHBwhsXqm1Tz4blNoz39RvG0infoAtEu6BSeEi3FmzOa3R6S0IplYMAMNEPE92xlYhD0gz8WanVoYffeFkj9Jo=
X-Received: by 2002:a0d:e656:0:b0:5d7:1940:53db with SMTP id
 p83-20020a0de656000000b005d7194053dbmr949131ywe.83.1701541473563; Sat, 02 Dec
 2023 10:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:18 -0700
Message-ID: <CAPnjgZ07bCZ8jOLyLHO-iLGPof9-KJ3OTThhLojEPSh02cBQEg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] riscv: allow usage of ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Select CONFIG_SUPPORT_ACPI to allow usage of ACPI tables with RISC-V.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Oh dear, first ARM and now RISC-V
