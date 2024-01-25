Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA7C48285
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 06:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E54E8644E;
	Thu, 25 Jan 2024 07:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EFK7g5EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317EA871D7; Thu, 25 Jan 2024 07:30:04 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0188786314
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ed28f8666so537715e9.3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 22:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706164201; x=1706769001; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UFzwAXXaQwYsX122OEukm/MHhOAXDlY25CnTYT2xlgg=;
 b=EFK7g5EKBTgCWd8/FhO5EB1T6pWfQKdKm3YWZgqcOKqhT0dkw8iDzGNyJ55ewB9we9
 U4eJuoe2Qdse9GgmQoa0kzY/N1yneGbFR12J6a4oq9nhsFUSkra8sPa/5+0CqV1YZK6S
 47u5Lu+3rGO0Rl9uqjenhSsXEsrOwvrlnfoErj80hFaf4zLSFcGacg9hY9FRCyQBpoAJ
 fm4wmHi2Ra71P4aGv/Hzmkk/CqgSuS7WwCak4xfPEOyt5naupzlIedhRCn6sovtTsj/F
 b+f0xgnXnjbOvDpmk55Nz3XKiet4qB8Nf1N0thUCT17O8aq9J4ARV7Gy6tFEvIX5vVC+
 i49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706164201; x=1706769001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFzwAXXaQwYsX122OEukm/MHhOAXDlY25CnTYT2xlgg=;
 b=KfYNxQQBXtqXnzf3oAIHs6rDMjTNMbeukFZDGMoJ+Rfxii6ON2v+933G8Xw4sRQQnY
 wl6gz6o/p8rMgOgGknvAmwkxHWTHhyR6H9TPyRKn/859iMoU3XmMBivMI9KpZ5DMU2Nl
 3LEsTZHUnAuX8rt3wEB1tlz3N5iUQ7sWQ3BiLfFGmvnmM3MkUGZ7jCSweLXIeas3nlXO
 P6wx3psuPwm0qzsYwBbfPKMOxJrcS8R7cNqKuOxCmlRJSwQscKlZFvHtMjJfYst85kWj
 /dsCNd8P2UnmW3uGXGPLhJPmizkqGm3oCdasFYUNkxgMH6/ufsyhoH4sYopXU5fDzahT
 RcAQ==
X-Gm-Message-State: AOJu0YzoOscu9rASAUoUETtxlnIP3tzNrNIsClOzXMtGVVq+qJ4OgHU5
 Ngek7GEYP47kAIFcfJnvsSEfIVi8Eetzi4IKJmD8HmLTf05AFE6T33oESl2jBPU=
X-Google-Smtp-Source: AGHT+IEnB+e/g8Z38eAHDnP1p9caGU4nBHxCbueC0zuyVgKjCIHkaTUnFlmHqqpVQlOMTqGEyh1sUQ==
X-Received: by 2002:a1c:6a15:0:b0:40e:53f8:5230 with SMTP id
 f21-20020a1c6a15000000b0040e53f85230mr40884wmc.76.1706164201329; 
 Wed, 24 Jan 2024 22:30:01 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b0040d7c3d5454sm1358451wms.3.2024.01.24.22.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 22:30:00 -0800 (PST)
Date: Thu, 25 Jan 2024 09:29:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
Message-ID: <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
References: <20240124202731.39212-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124202731.39212-1-clamor95@gmail.com>
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

On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
> Currently, if boot with extlinux.conf and do not set the fdt
> U-Boot will provide its own device tree. This behavior is
> beneficial if the U-Boot device tree is in sync with Linux,
> but it totally halts the booting of pre-dtb kernels (3.4 for
> example) since it uses ATAGs. To fix this, pass `-` in the
> fdt extlinux field as a signal that no tree should be used.

Passing - doesn't seem like the most intuitive thing...  Is there a
different argument we could use?

regards,
dan carpenter

