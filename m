Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAF1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B92874FC;
	Sun, 12 Nov 2023 21:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OMB4H7F8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4B0874EB; Sun, 12 Nov 2023 21:04:01 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4E0874F4
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a90d6ab962so43553047b3.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ovyRfiF4WPeISgULE3gMpIgAX/Z7t4ZX+stLkCLvCnE=;
 b=OMB4H7F81ejlJS1pKF1HRetHJnTicHyV2lh8FaNJ+n8bEwgbjJs9pLQyD61TAxcVpB
 JWhdp/Wk8WfWBeCAyamYXBVgPXqtSoFHm8eK9x5Yfk2K3+haawK1Tc9Y4hfRJ1fdy/Rx
 vmDyuikIfXawK5lQvXpHwJzMbDH65yRrr1Rzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovyRfiF4WPeISgULE3gMpIgAX/Z7t4ZX+stLkCLvCnE=;
 b=V0FKzdHNgbVemmNh1e9i92C4vWlojT30vLkgDcIK66HsokFL+JBFE2JP9xp954UhRM
 HYKrWVZIXo3Vq3ZYeOP0IL4rXE59U6+jM+PXCgrYhGw//QlI86ICB4CT3bZT8h6wdD+D
 QfB6WAFKTjx8MzCSMV1pgIgaz1OtKl9XiDFenN95n0qLXY71X7E5pCfSLTivW7kUCBUx
 R71m48naaS+LV7VjJvPnAhojBodipQFdwyk3zf2++ZHgghxf65LAYLE1DPiUVwKiRLjL
 jLdvZowPNIB69xOskEtCXbOyRaCROI9knV4h6cQS0K41RsPRawI1eNeMUWrZQ0N7fvl8
 NJvQ==
X-Gm-Message-State: AOJu0Yw8Cf9SeZ64ptIUIrBWp7fV84mOBZxE9MxEY81TLhLrrBT4dCuv
 YzmTDi+QKojSldNRY7ZZIVE5Vu/LiWqEaEHn4Cv81A==
X-Google-Smtp-Source: AGHT+IEjMKZq9Q/NO0t9JIG2AbE8B2FC/CzHQMum5BgJZOK7o8sCPgdDryGs4675psAYarZG0TMIRyuM/miVpD/SPsg=
X-Received: by 2002:a81:48d0:0:b0:5a7:fcae:f3e2 with SMTP id
 v199-20020a8148d0000000b005a7fcaef3e2mr5201626ywa.43.1699819434113; Sun, 12
 Nov 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-3-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-3-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:18 -0700
Message-ID: <CAPnjgZ1m_5dqwkZ2p3p7OufB2c-M9qEswssFDOqb7oE=Ppi3PA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] board: ti: am62x: evm: Remove video_setup from
 spl_board_init
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Remove video_setup from evm_init sequence since video memory
> is  getting called at an earlier place to make sure
> video memory is reserved at the end of RAM.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: No change
> V3: No change
> ---
>  board/ti/am62x/evm.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
