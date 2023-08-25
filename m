Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE0BC71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB7186923;
	Fri, 25 Aug 2023 16:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ydz3TiAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789AE86A74; Fri, 25 Aug 2023 16:10:26 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04598680E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaswinder.singh@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-64ccdf8820dso4749526d6.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692972622; x=1693577422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j0MnzOlglQaC+2ERJprScSRQDnwuKP4mYnuSMXx1EhA=;
 b=Ydz3TiAjQHdup1ZWHq2KgVCjsqCRA1ZdZFu/On3e9dpUAgLQmvhC5Tbx5ahtkZ5Ndf
 y9ibq/gPpmevds40IRXoAb48ZgRARA4po3iVOKZrSHztciE9/EMD4i8DaYM1Gptk6HW5
 TqGGNEOiJ9ED843OG9RkrXgILV9p2nzRMq2U7rxXKc6jkdN9DB75Y3ZeM5WEZMNRBwJl
 s5xdTaIojpL+t3FKtjKgNBtRMWs8N1sWLd5EmlmmwDnEA4lqzoWhPBz5rMFdIvvhuxJz
 j560dZYSWVOPlG7oRAc0yj9W7wdyR/qYm+s9M8cMCRn6TP5ZGjEJ9tWduD3Fwi5HJR2g
 ZVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692972622; x=1693577422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j0MnzOlglQaC+2ERJprScSRQDnwuKP4mYnuSMXx1EhA=;
 b=la5p20vW9wyk6pgdge6iE1v4irkYJLx91Nl7Z7DhXJRzxXyaI+O95hBbQWMUrBRDbV
 hNNg2V3SuAdlVUS86pqof7GSk+4mFxTiIHHdtABUnywQQG5e+LlkfEtMWqxFXxE+F/+A
 /nD3o53IUBNQ7siFwvQ14ZUCm+wRVkf/JD8s5mOGTzJn2gXqxUC0EjFqyEOIzAx4RGWQ
 JGSRSoiDEUzVsYl112Qh87SBwoU3Hdx2TYeKlgfG/7H3YTNZck30wZuCg4zJvH+mQI2x
 +a/MW03a2jg8o9YNQG2EhBXd8aX2a80FjvvH/3Q/+aC7BcogcIggIff3BMFcK8ty0h8S
 FWBQ==
X-Gm-Message-State: AOJu0YxjONe6fKokKR2OyNEeYxmQCmiFwOamc3GIlnWygBREM5A6Tgf9
 9+LeaGXwr5WQXI1KJMJJ8AYukjWtZRaSdBvBv5PNxw==
X-Google-Smtp-Source: AGHT+IFEssdviTWP1RrPRRTK07Zcw+MNw4Q9IhQtic5BxrzO6isFH4hzxegLb/BdB6fsv/22JTVgOn3fodDS0jHpjXg=
X-Received: by 2002:a05:6214:1c48:b0:635:da80:e53a with SMTP id
 if8-20020a0562141c4800b00635da80e53amr24686747qvb.12.1692972622554; Fri, 25
 Aug 2023 07:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Fri, 25 Aug 2023 09:10:11 -0500
Message-ID: <CAJe_ZhfJ4Gsm7GSop89C-dbzHMXREpBakAWVAQ7GxifBEOJ-1w@mail.gmail.com>
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 22 Aug 2023 at 19:17, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The current CI test worked by sheer luck, the g_dev global pointer
> in the fwu library was never initialized and the test equally well
> failed on sandbox64. Trigger the main loop in sandbox tests too to
> initialize that global state, and move the sandbox specific exit
> from fwu_boottime_checks after g_dev is initialized.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked=by: Jassi Brar <jaswinder.singh@linaro.org>
