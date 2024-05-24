Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A42C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39006888C1;
	Fri, 24 May 2024 18:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZdurgkQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39E0888DF; Fri, 24 May 2024 18:28:14 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2761D88647
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bdd6b73a3aso394451a91.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568091; x=1717172891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGf9YYk7kjUQBZKk9F6//GNbePIdPZt4a4XkXvfPaN0=;
 b=ZdurgkQsMOcpCF2ru81tJKzu3N/4f2chP8iXDpR13MfKLJR+z2Z8ln0WZzvL9PbBSD
 aThFKJSr9BoOY4mA9JK56V/bctQWdgk+YjFUK2QUEUU/T2iU3REs3DkHuIA+fOn1NYNH
 6XnKOkamVH3m17TJKgivpcpwvJWRgF/rpmshOWGLWYgL6Wht+QyEiWpXPPTD+maM/6+5
 4Nh0LIdWwc6CopMma7ddirAyFc1V3TEwuzeJJt5jJX3n/CMh00AUJP0QSRC1F+zIuFwm
 iiZu4D9WUS1hQlB6TCUZNYu2+Bn/InDk9CVEncKf0ErVVUJpKIMQriIp4llkDdXgC/jt
 moqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568091; x=1717172891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGf9YYk7kjUQBZKk9F6//GNbePIdPZt4a4XkXvfPaN0=;
 b=nXllE+jMcITZYJNeeuZdpJeO/KdM8gm2Xc1elDzdyh1R73mke5w34N2hqnwt2fKmDU
 pYLeD6oqZsCKn9jNoA6dr+6EDGhPSKRrfqw0sySs0/twDAQC+YUIP8xlpGG8CILo6nfD
 iG+MEfQEEv4dgObFYTZgIgvlxaR0XDXwCTtHMU8+EuBILSM0pLLNysVJprVWvQG3j2AT
 NgVPC9QRS7aLEDfnUk3oCmF4U9US0a1jWRu7pVmvxXgT2TR08JvzOhmc1hwYx2Jg6PDl
 46m0m+6VMWKXWGu2ZY0vtnsaH2NRuCFXM+FSiAVe6z0qNraXnGrgxUGI9VC/rd/740OF
 lP0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDBsYF4f4XHx1b9v0Pq5K7oGNTWbe3uWFVlyc46EPq+XZ8IH69b60an2D3pdsv6zv6ziRIrv42xsCGE58ujYJeT7IXjA==
X-Gm-Message-State: AOJu0YyIFgCB8kbVpjMUTr6AXckEWNuFSdCtd7zaECEuqpKzLcMvZIpf
 0z8vt/s2gD0u3tyNt0Gt0Kn75dp7EaR1eRPN7EQFzIvMsmncqr2zbxM1OVZl77pVAWNHYCWsdDY
 NJHoRAuaGs34R2qVF47MrMGPQRl88RVRb
X-Google-Smtp-Source: AGHT+IEzRqL+Hak+Ilk9WQEEzffbZPF2jV+Ko8tM+/YOGWFxQZIC1e+AFQQjjHYEQn6e6B+6d+CrpZ73i0A2Jaq4XZg=
X-Received: by 2002:a17:90a:f411:b0:2b5:1cdc:9ac8 with SMTP id
 98e67ed59e1d1-2bf5f5186bcmr2704635a91.4.1716568090722; Fri, 24 May 2024
 09:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240507130650.713801-1-ch@denx.de>
 <20240516083614.510948-1-ch@denx.de>
In-Reply-To: <20240516083614.510948-1-ch@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:27:59 -0300
Message-ID: <CAOMZO5CrtgpTh2g0F4mvYRCP+06bBtwQUWAt4-xGEgr1erqDmg@mail.gmail.com>
Subject: Re: [PATCH v2] imx: hab: add documentation about the required
 keys/certs
To: Claudius Heine <ch@denx.de>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, open list <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 16, 2024 at 5:36=E2=80=AFAM Claudius Heine <ch@denx.de> wrote:
>
> For CST to find the certificates and keys for signing, some keys and
> certs need to be copied into the u-boot build directory.
>
> Signed-off-by: Claudius Heine <ch@denx.de>

Applied, thanks.
