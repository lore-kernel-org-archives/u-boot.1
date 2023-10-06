Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C6FE92FD3
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 01:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582B686C37;
	Fri,  6 Oct 2023 03:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="0nSjSyKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A357286CE5; Fri,  6 Oct 2023 03:42:10 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1C786C2F
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 03:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso280404166b.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696556528; x=1697161328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewy0AmZJZFngP4RQC+logInYXaexg5tPe8bWvZwkM4c=;
 b=0nSjSyKagCXrMy+NlqwPWRR6ES+F8tqSdF+KWfejZfcO9Sn8a5PPVaS6VHa51bSD6j
 2mCNUrGDT/QNJSYdKDadOi4iFBbg06XJTup737pT6K2FYPUZtWD9TM1nANaQltak170q
 GNl1W8OCO8V4BjllGzY5p8ZDGO3V12BW//PZTnqTiQQOuJcAHhMLK6HYhDuQaCoo6Jqn
 eYxb1RneovI1hZ6ViNNSrdnQiQSA3Zrf2sXOCk0Ag8XvoP49lUrv5m18vwVL+HwmpGXk
 8Bjy4UgeI6aDkxAUHJYcs05AIsbvKLqH65xYuLTD+QttpGecZHgyX9SLUtG4XOf9jW0v
 jIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696556528; x=1697161328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewy0AmZJZFngP4RQC+logInYXaexg5tPe8bWvZwkM4c=;
 b=d+4QexXKYIMC//Mj6HnCQvIcrx4cs57HS+oylJwekyBOc/KnlLHh5ncfzrqF0P1Pmu
 S6EDBkz2ews4TBb6ue+MA5oCmpYQ7Fmg0ohxLRMxiF8/Ee9fd5GXXx881uJGbnJ8fimj
 iGGkM+K/Od6gcQe6PDZSYBbHXRfmidauR0lvmhBFIdHcJD4x/uEvXbidyIK2GzKhSdhc
 ibd3R7T3rv/aIjYYAC8kUsiZalSmimPEDoANxb37MwXkSwzvmsVAq7k7tupawlXwyeOK
 H38wlgIiYC+e4JBJvcp3IkKtOQ21o25FiCOyph9m7Wo3wQmgF3gI3WqdpEfFArXKFDzN
 JNYA==
X-Gm-Message-State: AOJu0YwSP6osbVReQptftzO11psRxZe1K2W2W+chMBJ7MlHtMA0BUUjY
 9qaGQJM2Xg6WuviRc8qAS4V7WNkxzCUDHC4UAdH+BA==
X-Google-Smtp-Source: AGHT+IEs+cJvNKVStPg5YDjZcNJo/aSdcxjPJxC7oo6N+UwCFOVFde5g3wyB3bpcXPyE0zD43SFd1uUvz5XQOwzOdow=
X-Received: by 2002:a17:907:7897:b0:9ae:3c6c:6ecd with SMTP id
 ku23-20020a170907789700b009ae3c6c6ecdmr6662397ejc.19.1696556528054; Thu, 05
 Oct 2023 18:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231005162738.3327197-1-trini@konsulko.com>
In-Reply-To: <20231005162738.3327197-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 5 Oct 2023 19:41:53 -0600
Message-ID: <CAPnjgZ2w-u68LQSoy_0140PrkGDgrEGi+Wvypcunn0p_shfb6w@mail.gmail.com>
Subject: Re: [PATCH] sphinx: Bump urllib3 version
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 5 Oct 2023 at 10:27, Tom Rini <trini@konsulko.com> wrote:
>
> While not a direct issue for us, urllib3 before 1.26.17 is vulnerable to
> CVE-2023-43804 to bump our version up.
>
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  doc/sphinx/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
