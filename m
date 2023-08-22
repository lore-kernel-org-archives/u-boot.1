Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEAFEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B49C864B7;
	Tue, 22 Aug 2023 20:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cIuCM6Et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B405855CE; Tue, 22 Aug 2023 20:56:51 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1C485CB5
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-523bf06f7f8so5824791a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730608; x=1693335408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UWR+dDB7Jq48DmeO2N9iHxoILZPMwrWrgiChqNNKOGE=;
 b=cIuCM6EtbMc3W4wj5aiEtLqkxGF5lBE4V+zbyv/LbW4WgYwA2icNwHtOpMHdIIo2SG
 xHt8VjKS3mCtWVWZNooa0k2A7lOvtkSPXWvFlILNkz/CN/yd0LfsJ/1Ace04a4yUbseU
 GiL/Q5GFhlFxQf5yjeC/Aazokdm1ChPwFtn6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730608; x=1693335408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWR+dDB7Jq48DmeO2N9iHxoILZPMwrWrgiChqNNKOGE=;
 b=LkPCFkPQv3x9JKDElXVDoqBXcgWUBusdpkiEW825dfyMuNJnkfM/Bnqt2HFjtr0FWs
 sJgpMa3boIy/QxE7FayKyc3gMTeqQC40zzo62AwFrO+m/+FYa6Gcyqf9xCpTgGkff/Ir
 AxRW1U2sQeMmn0JQshrngWASMSE17SvIf5P3MH1SapB8KmZSdjMcybosX8RGglOgxeZu
 Hid1E+DQP3iney07BagT/rid0N8Y+G01VOQM1sX5ONy5ZYWmtmUvao7sULoJeLIgGysT
 SPiDqcYLqsCBPTCuAxNbEWleMqxhW/hugsADWy1nqzuWd3GCcS/X5znsuvN7TOSRADRm
 g1pw==
X-Gm-Message-State: AOJu0YzcYTSymqM/4//cm4uMgFKO8d97siiThXiQA12kfdktEO+PEa6p
 RAlpzYkqq6vcs9dkTQrmUHuo/d07qFgkcvJq808xGQ==
X-Google-Smtp-Source: AGHT+IEnHlAygfEcD1DmO4ZxOpYmuEBeXL2ssW6IkFV2dCkXd4XkuBNsmrQ5PXxso7S1pRukpN5nIrspErfkssJcFtQ=
X-Received: by 2002:a05:6402:204c:b0:523:bfec:4912 with SMTP id
 bc12-20020a056402204c00b00523bfec4912mr7809595edb.11.1692730607795; Tue, 22
 Aug 2023 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-3-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-3-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:34 -0600
Message-ID: <CAPnjgZ1YDJCFsV4Pqwa_c0Socq00tu3HwcbqKw_j4iKartwRCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ramfb: Add driver for ramfb display
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> QEMU implements multiple ways to expose graphics output to the virt
> machine, but most of them are incompatible with hardware virtualization.
>
> The one that does work reliably is ramfb. It's a very simple mechanism
> in which the guest reserves a memory region for the frame buffer and then
> notifies the host about its location and properties. The host then just
> displays the contents of the frame buffer on screen.
>
> This patch implements a trivial version of a ramfb driver - hard coded
> to a single resolution set in Kconfig.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Deduplicate depends on DM_VIDEO, drop MAINTAINERS, decouple from
>         EFI_LOADER, add .bind(), kconfigurable resolution, struct in .h]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v2:
> - Remove extra "depends on DM_VIDEO" already in "if VIDEO"
> - Drop drivers/video/MAINTAINERS file
> - Decouple framebuffer allocation from EFI_LOADER
> - Add .bind() method for ramfb driver
> - Make resolution configurable with kconfig
> - Move struct to qfw.h and add comments for members
> - Use RAMFB_* definitions instead of DEFAULT_*
>
>  drivers/video/Kconfig  | 30 +++++++++++++
>  drivers/video/Makefile |  1 +
>  drivers/video/ramfb.c  | 97 ++++++++++++++++++++++++++++++++++++++++++
>  include/qfw.h          | 10 +++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 drivers/video/ramfb.c

Reviewed-by: Simon Glass <sjg@chromium.org>
