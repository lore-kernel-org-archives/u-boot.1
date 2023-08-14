Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCC3C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBD686A31;
	Tue, 15 Aug 2023 00:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBsmNAXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DB086A1D; Tue, 15 Aug 2023 00:43:51 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1AE869ED
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-c5ffb6cda23so4962951276.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2dB8EVKZpQ9Y1o+H0xqLO9BAInC3qAakCNukbmUTCPU=;
 b=SBsmNAXVrOntCh+hjEW4rc+YogDlFM1/1HURw99yors81m3yN0qZ0om3oZRBj7PXH7
 VetY1Str8p3V26eQFgBFI60KgZ5EXStyc1rPbPAcxmha+8tZ+2ecrzMmhG8YSqW/5Okt
 cei7UeDPkQmDom2RgrhzW8IXMMWY4SJmvQkaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2dB8EVKZpQ9Y1o+H0xqLO9BAInC3qAakCNukbmUTCPU=;
 b=DWYZQb3aSB/UABvSae93hPSTVDlvp3B6v6Wtg+7u00mjm8wBQY7dsql9WzRWVQAGX3
 Gix0gT+35S8NN1KBDK70gA7bSp48XmA6DJpEFxAb9b0G65zbArjuqHmQy6qBajGZzaxx
 XO4cDHggVCBkA3iXBIr99BLsXWRWOnlmuR/xgmqdOD01Oaj1ogvH5yVGlGO31ILKTHX6
 ZhFIix0Pti/bUkc82UMxj5Xr3MXW2uDbrDim35cqk1XkGYDXOkNulmxIqq76lpZVDB3v
 5WUR6wdoTQddIKillN5vIIsBqucVm8yPcynFzHMI3e26f9HKR95xr7UmEK0XxMe3vhcl
 M/7g==
X-Gm-Message-State: AOJu0YydahCJQvbRIjru4TQpwdblKhqe0ciaFgf/FgyqQSDbXEC88DV8
 /5E06azcCHXB/ephw1VMLIEbhcIVJDPBk635jHVBUw==
X-Google-Smtp-Source: AGHT+IGY23bVUXtsY+cnSdmWTllN9KS6KPkaVCt3uLTx5UYeYl3vywGpNSKd7eiUhkmUhBSbjxZsZOLdD/G2VCkWbHU=
X-Received: by 2002:a25:83c4:0:b0:c86:a5b6:cdff with SMTP id
 v4-20020a2583c4000000b00c86a5b6cdffmr11442870ybm.19.1692053026611; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
 <20230813214659.441964-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813214659.441964-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:58 -0600
Message-ID: <CAPnjgZ0rCX+hUn2rtH-gpVB9X+Rfv-FTGoxGsB8tKa0e_QEBGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: sandbox: test: dm: blk: Enable NVMXIP QSPI
 and update test
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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

On Sun, 13 Aug 2023 at 15:47, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable NVMXIP QSPI driver on sandbox, since it is already enabled
> on sandbox64. Update blk tests to match.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox_defconfig |  1 +
>  test/dm/blk.c             | 63 +++++++++++++++++++++++++++++++--------
>  2 files changed, 52 insertions(+), 12 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
