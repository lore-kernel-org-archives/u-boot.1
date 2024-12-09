Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C9E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CFC88C9C;
	Mon,  9 Dec 2024 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ga+cLvH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1665A88C9C; Mon,  9 Dec 2024 14:29:50 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7C588C94
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso19336535ad.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733750986; x=1734355786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qP1xONGuXu6sr+4Yac3/mjSw4FMGWKi6eR84S4CEWJ0=;
 b=ga+cLvH1IXmKVg6H3cmnQK+qplqG+N2bRwgI+WjG2YeHwmDvKYOlO3NgCeunbmmXnK
 bTDgaQUgy73+UzlqxZmNAgfkiN19D8wqDAVTP7Kf33yDwK24kR66P3zqnDvt5wd3HerS
 MsZRzBOWRgYQP3H27U1nKNHfZj4a4F4H2eRrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750986; x=1734355786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qP1xONGuXu6sr+4Yac3/mjSw4FMGWKi6eR84S4CEWJ0=;
 b=i+qawsXRuQ/H2e14Ff5U8PK5LSAbdhlbbH0v74qkvOGdFZ0xJKjLWLTNtNmiILw86m
 FfcsfJrIyAj+vi3gGlLgur580Cq9VNwM6+FXCsDw8maDWANIxOh5s4ybKztE3rXYjT3K
 HUpBfhg5s3wcsdodpNm7pKz71SLnCPVbC4e/eCdPYCYraCszUmc+OUDgXAq2vKYVOlV9
 K5tNdO2HMIYakXcOJ/tqTQmf4SRVwnGkjBaQ+emWqkwYqISOHxrLCsHqaIkldHE9uFOi
 vg+OzqiBT674Ec37rWsI3SKKB52Hl4BZ/2/H14ON0XNQ++cKyRuaJYjxXKsPjrvOtKiZ
 sX4g==
X-Gm-Message-State: AOJu0Yzi9jVgcWN+/qYz3inn391QHJO1YASJ+PWNe+Q9seJuZIhPtR4L
 W8nGII5i+ouOihpeUfX2n392h6UHK7xsLcYytKcH6TIGPnIfZwgDulzaQWjhMnSuDcTAzxJAdjR
 vw6eQU1NXlDpDfpwi43F+RW/KctA51WuHGbFSfQjnYEqEFss=
X-Gm-Gg: ASbGncvWnub75sy4IJpzV3KhHUBq7FdOoEuABCaVGy5cTyUr0nO2yX/kUMVpaNxoTiU
 yoOo4JOQ4nY0lyOhQ+dHv0vZ2SsGECnhz
X-Google-Smtp-Source: AGHT+IGByqWjiTe0r27CNuuVywrWH6PvskT5bneCm7gmbZ04VRgfH9qGgdD4itSvk98mJlmB5DIXVWlBzd8PkskVAIU=
X-Received: by 2002:a17:902:d506:b0:215:6b4c:89fa with SMTP id
 d9443c01a7336-21669fca799mr8378125ad.8.1733750986225; Mon, 09 Dec 2024
 05:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-5-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:29:18 -0700
Message-ID: <CAFLszTisJrjpjnix5wQsNS6qj3d+fpUxwGz-5bgarMTkAogRaw@mail.gmail.com>
Subject: Re: [PATCH 4/9] GitLab: Add a default workflow stanza
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> When validating our current pipeline, a warning is produced about a lack
> of a default workflow. For how we use it, we can add a simple default of
> "always".
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
