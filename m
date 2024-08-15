Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8CBC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C7688C3D;
	Thu, 15 Aug 2024 22:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KJuV9jEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A1188C60; Thu, 15 Aug 2024 22:33:48 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A208A88107
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7c9a2b339a6so17375a12.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754024; x=1724358824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKw3Lb8UwaRa8h4NZLAiFD3fDBUrC8OE3cwmqqfph14=;
 b=KJuV9jEXJjKY6igM2pWAMSRjUshdrz1pD9hQZv0kki6RYe2zds2NTMW/byJaM+b5fs
 yVgY7aOtkDrs/Y7zQPd/ymC9tTIJ4rdCiBsfnNsx/g7ACguYmBP93vGxmxFaa4+avETk
 Z78R1ZaDC5wpLF5xJArAiTtuM2wZ0peUY9FR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754024; x=1724358824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKw3Lb8UwaRa8h4NZLAiFD3fDBUrC8OE3cwmqqfph14=;
 b=A/Dbo0F852QxL/bvE/jIzotG39jKkKl+/agAHUpBOXHQYfKe5PJT+B3YMdYA9KO6Yo
 j8nXef86o0isQiw/unpqSL8onNDnh6PWCskqbMHC6HE5sVtfMsqCu/MxN54IWrd76Dxc
 7lL0qsE48pzI9DpiG7cbApj3bJohCw+axUGVWzTSSHSHYBbrtvTbjqqNIMVf4hFwG2NL
 LQyt0mQgFhtXQgpYrj9nIOzbiEJJ2YMybqn47zajwQEqyLHZqNBWfVJCMCNLCFbdK58Z
 gbb8O7i3hUtSCq7u+L2M13RvCPFZU2XX+OnrpfhuHRn3uBLh6eJVnAQDj7GVohY5Sqg2
 bMjA==
X-Gm-Message-State: AOJu0YzXUoXWGiV2iyAgPn2MnJQjxuJDykOSFRHcs0WabP+3GmpSzGL5
 lWMKmcLeHMeET8qOwICOHMiVqepS1gZhu18K7mjGaNjMmJuIWEaSHk3lsoIN8H0on02TAtjqqwn
 hUbhlD2n/NChiRw7/CkcBxNONLqwWGzwlBFsv
X-Google-Smtp-Source: AGHT+IELGd9pYtJ1FxOLU0z26egteHAn7ZKaxvxENKbEsv0I4i8qBGFHSIj6CSZzuH8dXCEvf68ayO4UEbUg/rTMgSA=
X-Received: by 2002:a17:90b:1051:b0:2d3:c976:dd80 with SMTP id
 98e67ed59e1d1-2d3e0407ac1mr994588a91.39.1723754023780; Thu, 15 Aug 2024
 13:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-11-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-11-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:31 +0100
Message-ID: <CAFLszTh3RaCSsUetT90aDhZyo7z4FgngzvB4H5PozZ+f8jw=Fw@mail.gmail.com>
Subject: Re: [PATCH v2 10/32] lmb: config: add lmb config symbols for SPL
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

On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add separate config symbols for enabling the LMB module for the SPL
> phase. The LMB module implementation now relies on alloced list data
> structure which requires heap area to be present. Add specific config
> symbol for the SPL phase of U-Boot so that this can be enabled on
> platforms which support a heap in SPL.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  lib/Kconfig | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
