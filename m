Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0928CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D3187768;
	Sat,  2 Dec 2023 19:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+OCVMDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697A0877C0; Sat,  2 Dec 2023 19:32:18 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E6E877B5
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so29712955e9.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541934; x=1702146734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6+J50wvE9wmMSqFNPno1VAOlPx7aqUZO08v3JNdjAdo=;
 b=P+OCVMDPwUaJnLDEK2tv2NtK5iPcNyqzDYY+B0705zEhEvWNltMiVwySxMQMtEMgIE
 ggAK45SV9igsxQsYfVoHTbC4o7khPx/l5G/9AWQDhZHXjN2XoQZxmK9G07uiH4kf2SuA
 f3OkweJw15XOL+d14NbVvnYziqJoKiEvxKXWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541934; x=1702146734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6+J50wvE9wmMSqFNPno1VAOlPx7aqUZO08v3JNdjAdo=;
 b=IM3pQXbPXCXSiU5CJq4+dygyXdo5uW3nqHHizbTMdlb9LHzh4DJ9YgDeEWHoCKQ/0c
 in8tS/ODOxt6W+K/aMP21Zl1E8HKfqPplnwfP7+7kmvny/AHfnMqujaVJU84QCVj9OY8
 FKNS8nVBagPQDjjIjoR4es2FSHviqj6hTMaAQLzdEiwbijkT0JXq0u6ah7yDyoOkeO0K
 JQDVW5zLgU3N9FHOF3PjoXLEGh8Caqil1z3ySij3QC0ehGKflp1IlL2n6aUBZ7Yo285/
 FGOhiNdrsHDxWsQ6Nq1Nx8bjb0sPKYilVDlXySQXjyyKpNnsHC7dny32Yt64L3S8aacc
 9bKg==
X-Gm-Message-State: AOJu0YwwEQ4ML4/SnnQ+EM4xHVujOP0W8PMbuHkMdymN1ArMjzueH/DM
 zYA5xrhXOqFcOBac96JDKy7Ro2fm72zOG11IbBVQag==
X-Google-Smtp-Source: AGHT+IFumS078OXn8ZD6FiSfu+04PAxe80+MMObrWyR9cFaLDFwR//VrbmFam/0JgVcslVFU9dwunUz+/TdmUYpkAUs=
X-Received: by 2002:a7b:cb42:0:b0:40b:5e4a:40a2 with SMTP id
 v2-20020a7bcb42000000b0040b5e4a40a2mr1032671wmj.194.1701541934184; Sat, 02
 Dec 2023 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-14-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-14-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:38 -0700
Message-ID: <CAPnjgZ35COPveLYJatjrqem9qxNP5eVfYxKjX3+VAnEV6r3D7g@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] bloblist: Add alignment to bloblist_new()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Allow the alignment to be specified when creating a bloblist.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  |  5 +++--
>  include/bloblist.h |  3 ++-
>  test/bloblist.c    | 40 ++++++++++++++++++++++------------------
>  3 files changed, 27 insertions(+), 21 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
