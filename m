Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56C6CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DA3830B3;
	Mon,  8 Sep 2025 18:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0Jt2UIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF8A83071; Mon,  8 Sep 2025 18:18:17 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B3C82E34
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-328466c2aedso985739fac.2
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757348294; x=1757953094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qc07Biv7xMW8jbukycvZ92/001yxp5Kp0hRnwIIQwTo=;
 b=h0Jt2UIT7bBgpA7pfvS43E0QcOa1tID4vZbQFGu/Ype9ikrFdXw0Ou8vCYIjBy1bcz
 cm/sbZqtwzIyC7C2HNU0h2fKeMYBZQwxPQic5Bz+L2lIYLKArKhIp/XAanTEYS5Z3d4U
 Ja84NgqMIJUaJV0kkZmIueC+9rgjjdWTjMilw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757348294; x=1757953094;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qc07Biv7xMW8jbukycvZ92/001yxp5Kp0hRnwIIQwTo=;
 b=HjtiqbmaWulIp5l2lx1UOXkylrzDumIREwYgfg6F/g9iwTZQKnzpX3YjYLyPgxM3ct
 J8VdYkscjQRr3m2RiTPSp9UMUAO1oexQveHqMWFJpTs0Xz1cs1maLbq/kGYGHWDZJv6T
 24R0z7A/uRcBfRnn0BSrqhLAnh69DLbnJO42szxDLj1vlpjiLgIidn/X+QmDm2nUHM/K
 WoH0cpYMNrekkaCRxJJ8B5jCGVjfgKZuvbDXo6hbHzqCNKxOnPrd19J+C8EdOUammOBz
 0QYpXoM8NF/MLjcZZGslxUGBqzYcOwJ7mo/sR6eIOV+sqQdSwTK1RHuuNwyDmfB5alsz
 95aQ==
X-Gm-Message-State: AOJu0YyPmzLKwe3axt0/9v2DxsjMogUYPdiLLr5dTsh/9M8WCm+JmQ2m
 IP8MCARlT+r/O9yPMoUQHn4BuLMSCHBua67BTpqjyUk+bdIH8rf7YqWS/77VC1szVa0=
X-Gm-Gg: ASbGncs8vFMQgqyE6llxNQxpOYsdI5dQ0p6P8Ydf4LZxQ2gGQtpmoPHnK1LTzjWgJU9
 mbf2NxZovna7Hxcap7p0E/7EdfVcXnFpLQgcoqu0ekX4BE56nQ8nPAQl1eR1hp0qjJIYZZwc4A3
 +MOxOl6d0zUqLQWUbDZs2Wq/k/qaHARKdMySzfbM3tHwV06bcX+xmhJwrrWOv+7+LM5qO1oiGvT
 hHJb+0ZoP6kelLNpx2Ejru5LvuRrfDeFsaQ7xRJIor6nSWctlIYoTBhtG47XMih/g5EGjFEKr9Y
 5GHMuL7AB0Sqj+1F3Nip8Qn25qJxVlscw34KIkbEmF/hrbfntsH0GboTiCn7pO+fhhN9MzgkMTy
 sHpA7f48OnTlAnbeHVk9zgazuHEkcnbGmummfqlsr6d17ZePeDGSLKEg=
X-Google-Smtp-Source: AGHT+IEJCU6hVaz579m45z+veqPSyTtaPZv6d+Zt4so2H4i0zOYd+vFrXO9Eg76kccOagFLqfXcxFw==
X-Received: by 2002:a05:6871:d3c2:b0:306:edec:2890 with SMTP id
 586e51a60fabf-32265241c36mr3790706fac.33.1757348294281; 
 Mon, 08 Sep 2025 09:18:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-31d87e05270sm4597371fac.28.2025.09.08.09.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 09:18:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-boot Openlist <u-boot@lists.denx.de>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20250826030505.24964-1-boon.khai.ng@altera.com>
References: <20250826030505.24964-1-boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add entry for DesignWare XGMAC driver
Message-Id: <175734829342.1435428.734059681868549685.b4-ty@konsulko.com>
Date: Mon, 08 Sep 2025 10:18:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 26 Aug 2025 11:05:05 +0800, Boon Khai Ng wrote:

> Add a MAINTAINERS entry for the DesignWare XGMAC network driver to
> ensure future patches are properly routed for review and support.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Add entry for DesignWare XGMAC driver
      commit: bc52200ebf5ad9549081ebb65d54de6fce5ca8c5
-- 
Tom


