Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2160C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 07:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA63830B4;
	Tue, 22 Jul 2025 09:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIdM8zEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D595831E1; Tue, 22 Jul 2025 09:32:57 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0356682E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae0df6f5758so851185066b.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753169574; x=1753774374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QLNsNWCR/Tp0q4ttqNHv/QScApwddBV7HjN7EPLAkO8=;
 b=UIdM8zEneauqCIpkO4lXlA9vX2yF3CDfs9en8sDSYjXl+tmdBB5K9/Eqzh+dNV+M++
 zynVjuJx0f6vcDCYyttp5JuWy+p1ugxOTlHR5AWyfx68V6zbwTnqoW07kWhJUOY8+UBk
 RlJmLxVtcr+pWlIiwOvO8pEyaSoa1joDbX8WtREGQtQCRvt4eL2htKtR3D1gXawiHW+5
 /1nMxbixmLxZbWkWawggAeG77DeKZcApfVNRTc49L81XZZ0XchuOf1G6Dvbm/eQLYXZn
 Hxg737h5lsD/x9KhiVOrOs2i+AguEsVLUw4pMb0v+peKt4/nvZ18ofsiAmTiJpDzrsvB
 NOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753169574; x=1753774374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLNsNWCR/Tp0q4ttqNHv/QScApwddBV7HjN7EPLAkO8=;
 b=JJ0Ruzkna1yGy3DBLonN+9RmbC8rDGNZm3gb2UfuB0K5nEX8yl26a+LC0rxZPEB04W
 twRmKvw596qFdcJuXG5Dmv66HWG23HWrtYXMClUGWXYZ/hWUbkZoi6ueIGk/d9IbzWM7
 1pvZVJ17S9p8Oensq960/U8Sute217aqfKuPjgymWWsHU/YBAect0TxD5ozZn31btbFh
 srU4H3DSpZ4mK8UiByWttKAmOIL+oqYfoLQleX9wERcHC2gLxSDjoJj3d067Qb9PRgkS
 owoXsBtrNRLrsUbQ75SAczPQctGpPWKZ3tX+cK+MFev3xrEvGfzCDchFllrFEj0KcrKz
 JKcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhPXYNqKamkDWw7e/XUEQ2y+pSSc/V/auJUElp7gql0S7dOpPQ8EtI79chVOfpcR5rRJVxSdg=@lists.denx.de
X-Gm-Message-State: AOJu0YyDcEkdMc6OTpI5ZStMRjt4MljvnW+ZwZyvH/bP1Dmf4pCXIXu3
 UNoxxS02btSAw+1FixMXSEKLj/fVSzDt4MgARLixqu3jB9SA5LcnnYTocrRg+4iuuyk5hOMl4lx
 dSj1Qy9bDEUct8qcmNXvgJ3pYL6JBKGI=
X-Gm-Gg: ASbGncuZO0SNKk8sM/+VDv8Pn3U+tC/Sn9BCcXUsBs/rGLxhJMnMT8dxEYRpovmNo1u
 2Zwj3CeswRxXn8ii6gMAPtS8uXc1vciwC6/FiqihD7ZtbPyqYSpy7u5bgoEC7/+XE+Sf+06xpUm
 n3MigVn86pMqDNkEzbwjrw33zAwSPfZleZgZD2RbfdeTe26vms3oEG5lBAZLCqrRdseT9s5nIFY
 z+v
X-Google-Smtp-Source: AGHT+IEBUzGoM5+1ahpP1VSNSd4lWceDX1xcl+VYnmd74hKiFKLbkroaHs4VbtAdfQHyMu+CXdLZA+VbVjsT+s2mjuM=
X-Received: by 2002:a17:906:c04e:b0:ae3:6390:6ad3 with SMTP id
 a640c23a62f3a-ae9cde4b4a3mr1945869566b.22.1753169574080; Tue, 22 Jul 2025
 00:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-3-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-3-cb705abfa594@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 22 Jul 2025 13:02:37 +0530
X-Gm-Features: Ac12FXwQ1eTW4E0G-qdizRvkVTibTWKVPqcghuV_3hLwhObxDcpkmopvXYfXnJ0
Message-ID: <CANAwSgTRW4fo=qGqW4B9-5=a+AnkoyShN--2n=L5c4uwDcXOyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: exynos_dw_mmc: add exynos5420 compatibles
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de
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

Hi Henrik,

On Sun, 20 Jul 2025 at 22:40, Henrik Grimler <henrik@grimler.se> wrote:
>
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> The exynos5420 DTSes in linux kernel uses the compatibles
> samsung,exynos5420-dw-mshc{,-smu} instead of just
> samsung,exynos-dwmmc. Match the additional compatibles in the driver
> to make it possible to use it with DTSes from Linux kernel.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [ grimler: rebase after clksel reg abstraction and re-write commit message ]
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
