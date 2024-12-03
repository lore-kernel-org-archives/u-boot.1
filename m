Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6AFE74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3808896B5;
	Tue,  3 Dec 2024 20:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cj3s+myt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0022389662; Tue,  3 Dec 2024 20:47:50 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF3A89634
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2eed4fa2b3aso1899862a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255265; x=1733860065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jojhEpGk+14svzJX98PfiJg/6Ugp7pczfWcWdpW4Jfg=;
 b=cj3s+mytewTeKEGh/7v0zeU18Beyku7U1yBte/PlAai6B1lgUBJOqxA5QE1CRRhVSv
 0gAur4dRwB0nyqb/R/FLf/Wlie6AIvE+aoDWxa/eXxrzON2NTyPmbJcdGN3S7MimNABF
 SGg4505iOpk5nCGB+CCxcI7ayOHelfHX5jjyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255265; x=1733860065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jojhEpGk+14svzJX98PfiJg/6Ugp7pczfWcWdpW4Jfg=;
 b=p4Zy2F//eMA4gbFBuo8v5vokT9decgO4uOVIZysEJOKS4xwq2pgxh0klwCjHhtUPsW
 8HBrjowK1XNjP91Ub8HzdT+CPmOcAGQVIn7TAFnTdYL1QW0IiKclvr0TKEDxmLFAf9iN
 W/I48P5X3bxTS0DWjVA3jnLPEvZM5hDwmJl0YbYgUr3FaiFr5SRQkCZmHb6cox6WS/JI
 2+0qivuodVhhG5PL0OlR1n5OdVyYVV9908e9OD2FvQnDrnG3j2BBoa7PC3aQVHjVXVVL
 O3Q208dh/Kd2KKRsiRfhHCp/Dh2vOZi3ZE+U2ctxVuHkH1vetz8S6R+WiZWPa1Dck1rj
 aRpg==
X-Gm-Message-State: AOJu0Yz7r/nr+3ce6W+1/vSsrR3WF0xSEzYj+pFy9DeHPp3Aiyw+EIBG
 Q0qsgcRAHzj9WFPzcVcmGOXH8jLS0QTEDPZ9/ZVx4EtLPJnfdrVJZv8y6yJwzFfYwCA5w6BqDOk
 u0optkdbJ2Ah3XpOIV2HVDE4PBpLFA3CHQ2uGuOPru0ZbWvA=
X-Gm-Gg: ASbGncvvhZW3AOKG4tx31A813rUyo61kX4mVrjNtSNbVDm4isNTICtiPggV41amPTch
 ZMBAs7/j1G0jLANdJSouh0k8ODfPHyA5z
X-Google-Smtp-Source: AGHT+IGLe3OYGx/pDdojDleQ2pilPh6XV7I1IEn4ZmqDn131t0DuzOXRnOaN8+YsvDvHxYCbwIktkCAA56XuJW/TdqI=
X-Received: by 2002:a17:90b:3951:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2ef00f19544mr5396296a91.0.1733255265297; Tue, 03 Dec 2024
 11:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-3-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-3-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:25 -0700
Message-ID: <CAFLszTjJtD=+34Zq1=xEi4dsk+XVOL-0c8-DXh7CxMdgVB5FBQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] vining_fpga: Drop status-LED code and use LED
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
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

On Sat, 2 Nov 2024 at 18:34, Simon Glass <sjg@chromium.org> wrote:
>
> This is not used anymore, so drop it.
>
> Enable LED and LED_BOOT instead, since this is the new way to access the
> LED functionality.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Combine removal and enable patches
>
>  board/softing/vining_fpga/socfpga.c   |  4 ----
>  configs/socfpga_vining_fpga_defconfig | 13 ++-----------
>  2 files changed, 2 insertions(+), 15 deletions(-)
>

Applied to ci/master, thanks!
