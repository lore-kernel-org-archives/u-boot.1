Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ACC87FCC
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 01:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D218373B;
	Fri, 25 Jul 2025 03:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tWP7RF/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37034838F8; Fri, 25 Jul 2025 03:51:36 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2132083734
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 03:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30063371404so602071fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753408293; x=1754013093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yny2mBcDUi0eX2QEGhcrqz908neZ4VeDNuVQ1wxoYiE=;
 b=tWP7RF/4r1I8KIKNUss6jBv0NJARe0oNpytYAZGhg+hjQal7oMgjaV2sGpHv1nsfto
 DYy8W1mjz41LuV1wsKFXCUu13XZ8o+IZq1/tfNgR5jDG6qCbmg+GjZli89nsolFRVRUD
 l5Ml5hf/bo/wtM6MAPWOUXWc9GFo8NDwIWFSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753408293; x=1754013093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yny2mBcDUi0eX2QEGhcrqz908neZ4VeDNuVQ1wxoYiE=;
 b=FrHhQpDJfbj3Fb+IjgjlRWNbV/lqo/4EC3rtQQLP2NHXbQMOvkyw31SQBB8ysIDu0g
 6qSwt7oAV1Ce2r6guj1/sqVOgHX9GKbFiTOGJ5CEpS30U7yVPEvsB1fbnePoPUXx2wDe
 Dz94/7sYlXdfNKvRcwV74KJcybI43NvE+oM9U1xLbL9cahwKBCEYrg5D2uInSOoaj+qK
 6SvLNfDgUkmnRnKk3O53UX8lVLbSIJyuEFq9K4GtQX8H6C3aUQlTSqmwKHY5uYRKxDKm
 op6l1361bOJuZwUncmwm4m2yzGZ/GgWnCf14EosFep2MaW2ABW2kjjuMYO1y6avCoGqT
 V3zg==
X-Gm-Message-State: AOJu0YzdICyxMDbOt53W4GVNCBh9NKxvbMeDTs3bPNlrOaJdfmGTvEcX
 ClsH1vCNbWSqS2KXL48OKPTsBrdgxmXYEjrH6vIafpMh1tObUAVi0V+mHoKZ8MvJyY1UQhIQqFF
 t/5TlyrY=
X-Gm-Gg: ASbGnctmFvmcHppH6NqExOe+YzSpFhcGP7UxXzFvqszBUJiQxWhxjBKR5gO0+VEvuFl
 Ie3+7iENjqDObX7mUIf8iItg+sPI81ZQNZMWC176Uxp2OhObk1XfzmiWi5sWiNw/sodUzuBYX0k
 0nXZ5+szNka1c5Q6t0rKEH3kKxFkgMz2WzzKCgmqx9PPRpLet8afZ15Oiw3HLQXuq1hwGNCC1Eu
 ikYBqqc7OMcVwqRvErrkWBRCVGt5zM9Vwnwn5m4KEdt6U3oZJw+V5yhNESQl00QGUYoRGfJf4mE
 JrlPbCN9sHeFoITd85fOgCMIln7i0BuLPx66x9tU7sKgP6IEarDHmg0BCJbF9d6q7ktqwXVifXd
 9vWOAEifft83uo5HVO6WQ8q22W+fP1U+WeimGOzSaI2oQXgCdIspfj98=
X-Google-Smtp-Source: AGHT+IGK0Hq/AsgSPsRInteDQ5MBwncwL/JfkCMGZsmgWqchD1GMjS13rNcmTTEwfNJ9G/09zFltWg==
X-Received: by 2002:a05:6871:5584:b0:2f5:2b87:416a with SMTP id
 586e51a60fabf-30701b47fccmr156407fac.37.1753408292791; 
 Thu, 24 Jul 2025 18:51:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f7b0e7sm795412fac.40.2025.07.24.18.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 18:51:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250724211339.2275409-1-festevam@gmail.com>
References: <20250724211339.2275409-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250724
Message-Id: <175340829193.1925592.4350328893524688566.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 19:51:31 -0600
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

On Thu, 24 Jul 2025 18:13:39 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:
> 
>   block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


