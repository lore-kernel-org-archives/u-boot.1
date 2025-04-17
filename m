Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E05C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29CF83156;
	Thu, 17 Apr 2025 23:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RfIZPS3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6949A83125; Thu, 17 Apr 2025 23:37:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B5C830B4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso191736266b.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925862; x=1745530662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FKxdgq9iWwjmOpEio1ytGieQmMHTXd5oN1EKLXrDJjM=;
 b=RfIZPS3FHe5ZoxuXpkXEk+RwIhw0bnKkBkukSz6EZiHwmkdLoDN76+s/BkWRJ9k7kx
 ztEvjaT6jhc2U4AR2tvudTWcN9JEMcfoatNi48TP6D3z2RPbq6a7u98aMm53l+J6vMeE
 9fZfKp1vfBtFcGXoylsofqmqSBRmyGbox5+/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925862; x=1745530662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKxdgq9iWwjmOpEio1ytGieQmMHTXd5oN1EKLXrDJjM=;
 b=cU4r7uWfHvh49xGrVMqidRzOrWYWJE17KB4RZJ1jQ4oW91eL2wt+NAFxP+mIVvNPbW
 iS9NtPvzjr0NmRHzx5vy+t+27R4MF56JOWZEo517gLNdp0o1ZKnGpnhLykW3XAdYYvFM
 9z8trScmnv6YHSd3+aRr4CKYZsEpcQn0SaTKKOaEFZKnKXtVH6kTylhqKhC0CdOzXime
 OH8TnMHkLy2tSIwsDU0Y+rCAhYmOsgj3xfXI5X5II1osvDRJ+kJwrnKVPRe2jCUjidU4
 3ii+1f2bclhBvboPfG6gYOhWT9PKhSzJ9NzJYg4+o3h14bISDvlWWD/c8H5BXncqB8SL
 rGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUModJfrnvH5Y3Hi7UP4cjyocqbUEgCKPJ8XNm9rLvMM4BmNcuDarQKFSgORvx8YKPd/GuVQR4=@lists.denx.de
X-Gm-Message-State: AOJu0YwAod9nZBGL6pIy1nHXIMGMWzLxwhf4PMHx0JNIpKva6fEzaItv
 7qZjzNFvSUsxC6ls59ergLmTfPhmzDZZ+Vip22LZDuECFtgIv7pKnLSEnJgp+fA2Q5DOw2paaD9
 2tUgw7QA/Bz+uTrpWZKcu85AK2eWhFDlrRAK7
X-Gm-Gg: ASbGncv99vXMkBhK8BstVnuOXcjr/arrX6oz0DPb4vl2UJgxx1KBvSwjiiXmOChEX9W
 ViD7rpESAJFraVEkspixpSD/EGrknimg+vTYwsz1WQBVBWRl77OUyVCBkCsXK1y2/TKkPVPlI4F
 nxeeNbd5T+M5CrJsIua3H6pmk=
X-Google-Smtp-Source: AGHT+IEBzH3kkiUnVinDEyEg7/m9tZGPqy4lfJBwSqP+zDOajhl3CRg55bD35EoMTKQhKf0bPSBYqkFnISQShzc3AaI=
X-Received: by 2002:a17:907:746:b0:aca:de15:f2ad with SMTP id
 a640c23a62f3a-acb74e52929mr24696566b.60.1744925861930; Thu, 17 Apr 2025
 14:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250416224032.144791-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:27 -0600
X-Gm-Features: ATxdqUHyk1XJt-XgyA6b-BAR6iKIW9UdGFd5rKILzrTiZ9mc2_RpzLRN6VsMiL8
Message-ID: <CAFLszThTUUDu0sbGNddzOdK-OF2E4stikbu72hvWzUyLxatePA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc/buildman: describe using fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
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

On Wed, 16 Apr 2025 at 16:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Describe the new --fragments parameter
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  tools/buildman/buildman.rst | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
