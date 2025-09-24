Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB09CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 13:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1064683447;
	Wed, 24 Sep 2025 15:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPqTq9yH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126CC83447; Wed, 24 Sep 2025 15:52:14 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B491580107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 15:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce534a91so2770738fac.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758721930; x=1759326730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPLQ8Goet5189EhG4yoSrGJtAgnVvIvbEtHR3/xBR0o=;
 b=PPqTq9yHM5pLslV8qUS7tU0SHYiNUdEZYNFp+3gwxUEN5KHBzyylk29EvygzW0eHId
 TSvdksGtHBct6jfvbhnT3s5/ppAGE5XOChvk3eXvNSnmH5ZxXqz6ZZf8uhF7Lv0ZdwAL
 uBGkiShR87EfYbqDZ2tV57icjJcFQUyRWOE1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758721930; x=1759326730;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPLQ8Goet5189EhG4yoSrGJtAgnVvIvbEtHR3/xBR0o=;
 b=QslaQ4mComSWoHjjusyGd9E+70uGVBBBVmxKje/PnR2Yg9qNzhproUckeZjIj4VMNG
 xq/+2B3rAUQHMuKs/oBT2hiz6Pzwy0a7wobRybjlBF49mJCeHmMCmmhD0/fdRwRpw37y
 O2XiNuOPz9DbUwgsuO3VwE6qmKXcWd9RP5ljfDhFXFOo7eaCozOtNiB7bk/4vS1B5z40
 /+2jkUWTyRGgXuivvNdz3JndGwSx7ttOuk1aohDnTCQiSqIVEwP6X5sgfLjoKoHYkX+6
 E5FHiwQTBov1Eg0o92UVBylizfnaiwBHkD213eoImBpg7pvYDturLRpSfU39oLSNJ/zi
 vxjw==
X-Gm-Message-State: AOJu0YzBVbVhZdbVMJt9ZNWhpW8mWc7+QQFXOUyu6B6zN1Y49nz8f65s
 Oe4NJt1+cA3QtYdhOzIgHZCxXaz1aCx+2WSQuQERcV6VHHZmR8VS5qgal78Q12hfkfmFjuZU/Vz
 pzG4z2y4=
X-Gm-Gg: ASbGnctxsqAZ/aXDJxVSjSz4Sb7ftJznJ6d1CiJ/Xe5vpRoj+M/fHoTYbr7RZdANan2
 k12X5d15djh1ilMlTxznvxn50B61ch2z84HgGdHQzGqg+YikWGNpVQ0Ws6PG0vK8lqs3FKraufk
 V9sgIFM1esMDVrolX/UWBYLejqS4DpusFELuk5rUz6wGjNmg0Q827ezV8Wgp8DcMVmQ0kqTuWh8
 5MYRxMdxq/0W1Msa8I6t436kOUlI66DY2XLvJbKgkWU9NYERjrUEp8kSoQ7fp5iCF2bJyF6bxJK
 jpmlMU5pMI/iEGzJcKLeHic0TetZf0UUe5UGrxw8pHojt3z6sINnH5wfGcolfeQ7RQxFX+bEaik
 PuLZQbGZKHBqVvtuxxfJvE4+Y+GrWi46zKyuRQSvfI8WtUDK20sBYadM=
X-Google-Smtp-Source: AGHT+IEiOwesXJqaX7VM0ANbzNxs2c7UUCuyzvCdY5YG76ZhmzMuKaG+OAjBDDE5AuUxM9kNc6WlXg==
X-Received: by 2002:a05:6870:970a:b0:30b:9053:147d with SMTP id
 586e51a60fabf-34c891dd368mr4476438fac.26.1758721930377; 
 Wed, 24 Sep 2025 06:52:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691b11a8a0sm7751113a34.13.2025.09.24.06.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 06:52:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ggiordano@phytec.com, d.schultz@phytec.de, bb@ti.com, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20250919063948.3093358-1-w.egorov@phytec.de>
References: <20250919063948.3093358-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/2] Fix boot w/ scriptaddr & minor newline issue
Message-Id: <175872192906.333621.10806821068422597111.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 07:52:09 -0600
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

On Fri, 19 Sep 2025 08:39:46 +0200, Wadim Egorov wrote:

> First patch fixes boot issues with script boot method and the
> second patch is a minor formatting fix in our board detection code.
> 
> @TI: I think the scriptaddr should be also updated for most TI/K3 and
> beagle board boards.
> 
> Wadim Egorov (2):
>   board: phytec: phycore_am6xx: Update scriptaddr
>   board: phytec: common: Fix missing newline in error message
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] board: phytec: phycore_am6xx: Update scriptaddr
      commit: ac046ad1873cb3d85f4c81c0bed592a4ed7a5903
[2/2] board: phytec: common: Fix missing newline in error message
      commit: 96971e5090cd6975023d0556b3d47b195442902e
-- 
Tom


