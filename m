Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB207E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27B480642;
	Fri, 20 Dec 2024 05:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hyzkH89j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AD2803E4; Fri, 20 Dec 2024 05:07:06 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BEA8036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aabbb507998so283612066b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667624; x=1735272424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WdUsGCx8IyfuxAibs9TNO6RztvjUdX4y3fzuuGR6k28=;
 b=hyzkH89jZ0T4ApvdmyVT6JazhEpFuNhu0e7sKLH7MmXNkeA3lAfF0v6fpb3fQGhPti
 6oZzdZBefOIonLq1Gnn3CoqB0uBhKi6GWx1rE168b8A6dmwDwH0QHdcCshT4utYCWV/I
 69g/m3XUtJwcFUF5bziB1o6IAMcZD12+NUHkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667624; x=1735272424;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WdUsGCx8IyfuxAibs9TNO6RztvjUdX4y3fzuuGR6k28=;
 b=bUFqt1n6yLJUddoLX9It8Mk4BC+ynWEekz/z+sOvGx+7GKVyFJF8sIe84dQv1JjkHd
 5C2vOOL/yADl2j2ujoSzljqtjmuVDtcwM4n3xRpo+LJg9ik09OqT4N1K6jFOLpk9zOVZ
 BxwsqxdjcSqXMCFnfCzfARYTiKVn6mPmhXs64s56CS1VkkvhMdar6318B3HQNmPxdHO0
 Rmi8p8TPoyKEgxTzWVsobhJIBkz0LNy2tv9dqC/8Q3nLWDy2L75+g7vIfZ+BajgxVFK7
 zCH0nfYoEB/9WMMfpFcFgu8uDOJYraHpB8RHJyFd8V6zzNVet+GaKFwKI5No+Gp9U95t
 a+9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUfg1BpEuetsdHQn5rm6AeDnfxEpWi1L/fEGAo3tOcN8WHVb5DIS8oJ/AMei9TLL8jBQ69ZVI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx6ZAWxjdnwrPnY1hBF7aQtf7tt6hZUiaXQJJu+DChSuU8rzSl
 OVqXXFhL7bwEoyFSGxDSqN61mdgXWtJhlRBLHvxAhNQkoxwakULBVXe2oAlWd+vImyJqwn8ZbXM
 ahdgADyKNvnfhOUqvUL3dUrwqDDT5lQ8srNZY
X-Gm-Gg: ASbGncuVXqxt9R4H+PnKGBt/+YzaM4vtK43qRo7UfQs1+XeDtL21uiixzfC9/m8oSPw
 /5PkHyVy1R2RbbkZ+0BU+na8XEiGduVXoIRV+8oo=
X-Google-Smtp-Source: AGHT+IH7By/qGUa9HW7zpzwrDiwHOLtFZ7x+dIaCT7r/35wlDvLr9AM57jcJyzo/Xk90h4ke7iotxQj536EsDU77JZ4=
X-Received: by 2002:a17:907:c12:b0:aa6:9017:eaa5 with SMTP id
 a640c23a62f3a-aac334f6277mr92906966b.37.1734667623789; Thu, 19 Dec 2024
 20:07:03 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:07:01 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-2-sjg@chromium.org>
References: <20241206023626.2456858-2-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:07:01 -0800
X-Google-Sender-Auth: CI6UbKYxJf1Y6DNbDzGv4at47TQ
Message-ID: <CAFLszTg8gk+o8+oj_PoZNHag8-7ymMa+51nkFM+1oUV9q-WxCQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/46] x86: Make do_zboot_states() static
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
