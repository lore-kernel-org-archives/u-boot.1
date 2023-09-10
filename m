Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA1EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4991986CEC;
	Sun, 10 Sep 2023 21:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Go5bmrL/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924CF86CF2; Sun, 10 Sep 2023 21:14:20 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D659F86AFD
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c07e122a78so2739840a34.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373256; x=1694978056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ssXGPqEp5oCjUh/J9yH3wbMkJZqjzLhMJqJq2io7yTM=;
 b=Go5bmrL/lVZXnfZfMlNxo0oH4jOvgcjU5sE0UHaeT4vkve79XkewK0WDDEZR5zHBfd
 NYzjcn6ETnedTw6Y6MzItsPEBdKWjbOA1eEPahyLvm0gmXGp7iECOeuYuglrEj0aMT0D
 WMykz5r4agAIj2oDHjrNzygjpRXDBLDw6CWds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373256; x=1694978056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssXGPqEp5oCjUh/J9yH3wbMkJZqjzLhMJqJq2io7yTM=;
 b=GTGueaU/dkNEgm28RoYC5Vkr7F6BxJxtxp5qzVnZyxa550eZT49ZfI75xQKTafFxNO
 cKZqH2XPIc6yaD2TUNZ8iAK8ncWAIRfqQ4qn+rDIzU4AhO8xrCLd4sdyf7W6JmR2vU5u
 MqBUsF2BIH48Gu/6AE2JrqItNQX1G1E12O3uQe6n+IWArU2fWadisW280C8hoypy+TsT
 NENg38bjHyNWtKVoRo6Qedifz3duZLlkbtd/vw1qO/G1fnPydI1BVr2Woj82asofOq+9
 GIbKs1UMTaMKNwPi0uST1gbPU6NzEe9ByTIlTYFYBsmPDjlRQQ11KwAhyKRujGm+S6VR
 6LkQ==
X-Gm-Message-State: AOJu0Yzb1SdpImkkmgkd3UnafwMO1LXIOetqpHEDluzSQH+qEmYK4vPl
 1VQb+AtEgAtaaWhNu6RWXbJeREFBEy72NdoUu2BlPw==
X-Google-Smtp-Source: AGHT+IF8SQB7EVSTnMeNC3XmRk1Von8NcuRDcXAdbFi9V6zLUN+6StKnLa2Cym5gscRHl8TBVm9t95WgPFrXF9mRzx0=
X-Received: by 2002:a05:6830:1e0a:b0:6bf:2476:a97e with SMTP id
 s10-20020a0568301e0a00b006bf2476a97emr9144232otr.5.1694373256246; Sun, 10 Sep
 2023 12:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230908141655.2307809-1-fshao@chromium.org>
In-Reply-To: <20230908141655.2307809-1-fshao@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:31 -0600
Message-ID: <CAPnjgZ11Em1cq195+KL0UTcWvo=DwtF1WPq19fnMkg9GvtgoSw@mail.gmail.com>
Subject: Re: [PATCH] patman: Respect include directive on Git config lookup
To: Fei Shao <fshao@chromium.org>
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

On Fri, 8 Sept 2023 at 08:17, Fei Shao <fshao@chromium.org> wrote:
>
> People may put their user name and email in a local config file and
> reference it by the include.* directives, however `git config --global`
> doesn't look up the included configs by default.
>
> Enable the --includes option explicitly to support such use cases.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  tools/patman/gitutil.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
