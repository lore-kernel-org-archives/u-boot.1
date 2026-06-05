Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B9CD6E7B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE75849BE;
	Fri,  5 Jun 2026 21:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DsPx/0ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90054849C5; Fri,  5 Jun 2026 21:02:11 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DAE7849BD
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6cfdc8382so1543117a34.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780686128; x=1781290928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HJGDTQo4+BigUKF/6lfaLLR7GzwNBkRQBQYvS1X30E=;
 b=DsPx/0ke0ShpueyVLgzN6ITC1RoOzjUfjKhY6ev+Dy7Y6qwWdcX0XFz4GVGlKU546A
 XRgeiGN6rE/FH30jcXGVIHejv2xr4xhnT2arm6CKmikg7jgbg4p2jQRtIhkhJXRwN3MD
 Lo5NLyEmZ918QbTbrKVouIUXvaU/mS5LUhD/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780686128; x=1781290928;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7HJGDTQo4+BigUKF/6lfaLLR7GzwNBkRQBQYvS1X30E=;
 b=Qp/XrnmPK0tFPZcyZ7/0FCwj7TcCyYIXyw8ZUDe9t9zaDFzkwsWdY17T97HQQWID+E
 8AoMe4ityTqLyVUQQJtF09FkHyvmzLDANOl5D5+efolpxIvfuPYVoyb1KDt6/zhsVf7n
 LnVIiUgyd05t47XfVnVVvJ4oTuEPhaf+VCG38DY4FGZOTfj9TvtZL9BrTQ7nR+AD79eB
 j7sgh5x82spQZ1b/kv+JkfZBKCW08+azZ3hnIzisJgGzzmH0ju7U7a8bbJE3OKkq2J3Z
 zpOQ7uLAC8genEr6JhD7M2jK8Msm35/okmw1epvsgP92TPmNWjWvXA8LiwLeGFx/D2/O
 CLSw==
X-Gm-Message-State: AOJu0YwghT53vXEYGhzrkizridgcSvaDQLhukHRSfqoEs4BzsKoNn4lA
 OglHKRSfUZmB4BcHdL9hw17jkROY9+cAeOF5jEZbXorW4SUk/g27pvoRCP7VwPqzZ/TYPtkj7KG
 Q7PBfLFA=
X-Gm-Gg: Acq92OG3gXArZo+9conzFLfDAvZqqO3/nsTkuGzU2EYb3IXsUTGbynhiSHViuxEE78G
 y8kNnLm1MVz9k/EijYmyR9fkzsrZkyLFlw74Q27R6pmBk0an72p7U60NSeZUsFL+gFrCVkrR43s
 yJsNFsneuJ2xnMTPQKSzX8FBydV9TdY4zUtAOhKbZIq4WwyT9Sn0nCDu1aCZQrZr9Rq2jPq6vNW
 wN5FEvHvCacpafr6V0flxjWHl0IB5ARErMy7GXmRSfR/LRPqhV89XZElsKF9ZWJi4S2KwonhLnx
 WQM4DxBqJpA8jDju025IA+3GIsovuGlOPsQ0IeVdP3C74vYHu6ytEKiMGOMzh4hcSuQoljRaOjK
 30ixE9NYvnx1jqNy5nPjyzbGabrju3kYbGU5LG+dQ7hwnb9UOSZuUOk+rbVGmWmaNHK9PGIMrgQ
 OJAJgxQfwIpUyDe70xgaSMoMG7P3T4DCPk0NBKQ2PcwWXM0gkNyrWcmUIGGtNn696J6qzKMbKr8
 9J87AtR/NzDqs5YYrwNeAS7/0cy10JGcPO6bDKeLK+lui2rnNq2mnAuG/PIxRvM4cUdfUc=
X-Received: by 2002:a05:6830:67d6:b0:7e6:fa1b:d99d with SMTP id
 46e09a7af769-7e70ca4ebf8mr2984101a34.17.1780686127600; 
 Fri, 05 Jun 2026 12:02:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e14acsm6835681a34.14.2026.06.05.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 12:02:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, alexander.feilke@ew.tq-group.com, 
 alexander.sverdlin@siemens.com, alice.guo@nxp.com, fberder@outlook.fr, 
 frieder.schrempf@kontron.de, marex@nabladev.com, 
 Max.Merchel@ew.tq-group.com, nora.schiffer@ew.tq-group.com, 
 peng.fan@nxp.com, ye.li@nxp.com
In-Reply-To: <20260605165114.610245-1-festevam@gmail.com>
References: <20260605165114.610245-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260605
Message-Id: <178068612625.400343.1465003178017232149.b4-ty@konsulko.com>
Date: Fri, 05 Jun 2026 13:02:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 5 Jun 2026 13:51:14 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 397a14dd7142f381bbd316a13cd7e82c88c7287c:
> 
>   Merge patch series "sc5xx Environment Cleanup and Fixes" (2026-06-04 13:04:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


