Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BDCC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA6888800;
	Thu, 15 Aug 2024 22:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xb55F0KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C126B88800; Thu, 15 Aug 2024 22:32:46 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918E188BF3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3d58d6e08so538987a91.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753962; x=1724358762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NzEb4JuHB54gCXe3qk1AX+H2RkN6uIcpjRYo4WBbe0o=;
 b=Xb55F0KRhpgxGkozFVr5dnJ4ZLM05cvuwUl8k8+hCZbhM7JutCOqcE2DsJSJINlK34
 ESPcxakjnxLOr1gwaQeFk4XAnT7i0Rt1BnvTV+oScnQqaU4TZnqe40UXLaICB0X4W5J0
 rvP6iB5wYMmbLeGyBhxVaywHuowuJ9CSVPHA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753962; x=1724358762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzEb4JuHB54gCXe3qk1AX+H2RkN6uIcpjRYo4WBbe0o=;
 b=BPRJW4ksym8tA5QxS3nK8Dm4ZzPuUCKSS3amQPvbEkcD/+YekyEWgukjUixiO2pYbI
 Bmr9Gj9K1FxmLOi5EfIfEkxdfu5xMIKc988dC8/WAdlQbIG8M7jNtFt4om+Ux9usExLB
 XoCkQFf3F6y36QubsdH4H8Is8nVYTYd4AzHtibacvactHu43MU7agF5yPok/pfW2xSEh
 rZRHH9ToqCOxAJMT3hTOskC/ZlqS2qwo0Z9qDRtZxpp2HA+mTJBNDYezdQr30WaoRJnV
 e9GzV02poKdi8AFNrG/8RxOz6Ty5gwcwYHNIl6uDruX3c9HxJFFszNuFYBlNVcY78/83
 SO/A==
X-Gm-Message-State: AOJu0Yx/Fj0djxBv4x/k8+CPpNrdpjYt6KNkZVmotJ+UXUnshsdRqNSH
 wrmGS+J8ZGeSmNYy0bkx8gWi+fb8+6jGjKSKprO+PxEYioFi6Lvl+sOfRa3wl5nCoAVOX9vzxvb
 o3UqO795z7kKs2VUdV+geWKfo0TytyoULl1T1WzD4eDqP3DAMGw==
X-Google-Smtp-Source: AGHT+IHi/fMCY3/632XYVoTSXB49x3XTeW2eDltxhYOMXP369ITx8LkZB6YqfuAu9ClvxU3UvMYJcP595aMA1yqZLY0=
X-Received: by 2002:a17:90a:f189:b0:2d3:b49f:ace3 with SMTP id
 98e67ed59e1d1-2d3e05628bfmr889835a91.28.1723753962069; Thu, 15 Aug 2024
 13:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-28-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:29 +0100
Message-ID: <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Instead of a randomly selected address, use an LMB allocated one for
> reading the file into memory. With the LMB map now being persistent
> and global, the address used for reading the file might be already
> allocated as non-overwritable, resulting in a failure. Get a valid
> address from LMB and then read the file to that address.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Don't use the API version with flags parameter.
>
>  test/boot/cedit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

No, this address needs to work fine without using lmb. Same with any
other tests. Tests make use of the sandbox memory space memory
addresses and it makes things easier to code and debug.

Regards,
SImon
