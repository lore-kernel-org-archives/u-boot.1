Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7C5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E940D8768F;
	Wed,  8 Nov 2023 05:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izf33Hfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF87874E9; Wed,  8 Nov 2023 05:27:05 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0651C8775C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59b5484fbe6so76399097b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417621; x=1700022421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DTsKCCNJbRXCFgSP974nNNFmlvXOnzsa8FR88UMGDaY=;
 b=izf33HflqKHpAnaqzxnGoGuERocE2WlT8j0qA+TX8H/9xJpWTbFDZ5cyCGgtkldety
 SrG/9lkt+gpyto9jPr1t3WfBWPCGbk0IGJN0XHqpk2AxM7SP+G5Ru8x9RGr8Uc3kvPqI
 2YAMn48NbWw2wr8wLEwl6umrjYSOHVOrS7Vis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417621; x=1700022421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTsKCCNJbRXCFgSP974nNNFmlvXOnzsa8FR88UMGDaY=;
 b=Pqjtwk53ubuir4VPBvuRb1n3its80uKLunazi3c2BmJlpx2D1Att/i3i2RbRJCmLv/
 g8s8x4IRWfdpIVjTb1O5xoN8qhYSRauVGnOKYq4saqaWOlRsVnzMXTLQD8e+2BA+BdcU
 5xx4/h3a4gNKvRMMzOJRFk+6F8SVo1i3Zfceb1fLMWMSG98pKqhp6Ik1lZ1bTbcEBqv5
 mqijFmbsfsty0u0C1KNO4CL6WcF5Cz4wbG3KIgneR5S6t6ftgaZZGvf0btbnz3n9FdIG
 qRpIXGrHbalGQxGFrn+GBeOQIpSOml4XqoNXruhdxbDGKZHuRNBo2PRqGxLBt/d5EUxo
 pTLw==
X-Gm-Message-State: AOJu0Yze1DRLPZLknSWs3DZsGE/zQut3STAySzBS4RFAws4vpp2M17mq
 /WTEnGk3BO2n2qATiqftodlFLJHpmRoilGpmsMHLFQ==
X-Google-Smtp-Source: AGHT+IHBoieE2ko3MudKNt/lsoqjsCPLtdrSjsSepDdN3sa95Bs2cGmWDYqAlmCFtrtwxHAguYixxvmQlFlSXS7Go0E=
X-Received: by 2002:a81:848e:0:b0:59c:678:7a32 with SMTP id
 u136-20020a81848e000000b0059c06787a32mr669550ywf.29.1699417620599; Tue, 07
 Nov 2023 20:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-8-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-8-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:37 -0700
Message-ID: <CAPnjgZ31U_cUajH48_0Eak7vFf5kmxrrVJqB+2xZ4z2WNSzG5w@mail.gmail.com>
Subject: Re: [PATCH v6 07/25] spl: Take advantage of bl_len's power-of-twoness
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> bl_len must be a power of two, so we can use ALIGN instead of roundup and
> similar tricks to avoid divisions.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_fit.c           | 2 +-
>  common/spl/spl_imx_container.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
