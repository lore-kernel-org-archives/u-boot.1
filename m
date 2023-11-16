Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62140C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DD1874B1;
	Thu, 16 Nov 2023 17:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gW1Z00Dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CCF86F73; Thu, 16 Nov 2023 17:04:45 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B309C874C3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso133362466b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700150678; x=1700755478; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jUeL105+MHsjoejKJdHuvm5J57ZJfbLorWjW0i3NhN4=;
 b=gW1Z00Dvy+WqCn5ASdlq5W+knJOotUqR4nCRKCS640wcIhbt2v2+VHjjmGwOgD7bby
 aJqC5JYShTdpG3CgaG1VFcxnhy7fHdAR+zd9K4t0eQ+5bNtiXuntMpPg8YuXM1vzzDQe
 dNf2X5nM7jj8NFhSdQvJvp/Fx/eaHOGMroU1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150678; x=1700755478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUeL105+MHsjoejKJdHuvm5J57ZJfbLorWjW0i3NhN4=;
 b=vuXoCfB4Gdc5F8i0AFAi9265JcuAlOxCJ1Y5NO3NHNRFpUQsyfHyFw7QYOidV75eFl
 OiIliCjuV0BAin9z3/dS0Y+7r83JK76HSbGp2Ube856MHK/peNhcr2lFE5jy2SwLCqZ9
 o1KvlUrOSiXyKRmt19GHFuF61aB+U+mymFlIUekATpt9n+BYcpmQHNRB0Dxgzqbqz5h+
 QQISEZs7l7KJ9vdW0FIIH7KyZx/hNpFTAX7xgHbLo3sdgYrGswICiZWKaBBOn+maylwD
 UFLoQDZohivaCeAXNkpzmj8Zk+udo8k1eLpH1IGfjP1u58zgHyNuB92R3qgnvDyPo83T
 dOWw==
X-Gm-Message-State: AOJu0YyUJ83bBUgx0Sjza7MjWXwU+Rwcw1AL2uXYc6vPkRiWhl0cM8s5
 +NqAy3VFll4habdOz0pRGG3AGXmwLTjQzJ1rgy7WX0pwIPO+jA3UOOs=
X-Google-Smtp-Source: AGHT+IHaFEGI1cK85Siyk230IhTY+jFre4BYqJwFGiF4ykkhEO2zX0BOfugX3Zj4B2sPHtB+jJzfhTWaX2Re7HrAX98=
X-Received: by 2002:a17:906:d9b:b0:9e5:d268:d750 with SMTP id
 m27-20020a1709060d9b00b009e5d268d750mr11957484eji.60.1700150678083; Thu, 16
 Nov 2023 08:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20231116091033.20770-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116091033.20770-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 09:04:26 -0700
Message-ID: <CAPnjgZ14z_d0Z3LSS4FMfu9a6rzZ_ERZ5aFtfu-OKf4KbjQQFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: typo fdtaddr_addr_r
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Thu, 16 Nov 2023 at 02:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/fdtaddr_addr_r/fdt_addr_r/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/bootstd.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
