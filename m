Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA42C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5E686A20;
	Tue, 15 Aug 2023 00:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JJx5j/ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD47A86A2D; Tue, 15 Aug 2023 00:43:51 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D95869E2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d3d729a08e4so4753765276.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LdgOR0wwpvFf+wPWIOTSDzhoE5jQ8TpOhFL5cY2k5PM=;
 b=JJx5j/ue0znxzdic57qIyLeuDJnhiNCMexTh1UilQUSMqS/MWWjOzunOodHWKQZLK5
 0IghRzKvmVGOm9zU64VcrmZQSVifm2DNfU7aZm4iVcTNkO0AuwQ+L4q2kOtqH2l9a7Yj
 qFM0/T745nSkWQjDOsogrfNQyrxhYdaPqt1b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LdgOR0wwpvFf+wPWIOTSDzhoE5jQ8TpOhFL5cY2k5PM=;
 b=ifunLi1xovuHMKAOMN5yiohsjoiE7uP0m3cugzxy8j4XUdrAUDEij2P1UU6A0Sdfji
 +yI83tmEY0mN5CJG2Qcvm2TswQYnV+5wCdA2FuLbfmwLie9w16uqMm/U32Ak53hTWZsf
 lfj7EfAa5yF0UTX4OmZwjG1sf8BmxaFE3Ea2fNQb+O6yZ0Wv5toPIv+PB+pAuBnBBFQ4
 eOpNaXUp+ZWVfRPXFvG/vDUxosSzsOi2IV81di6Xh9ZXxGAuB3RdXfuTPdvShTveVveZ
 /fxazjXnZOxLd5JZjBBfiMxG6jkBn2NxBOiD0ibtgP0b5YbvKlEBRiwgf6yLU5Q2Q3I3
 Pf1w==
X-Gm-Message-State: AOJu0Yyd4Re6eZlad3Wy8hcAQeQJt1tdXJ96GNcjhrDPqXSUW+st2nOq
 ZpuJTvKtTT/Yg9RQIfcorJBZ1ZHsyC3mdL6+W47ol5BAD4YEKDihVNQ=
X-Google-Smtp-Source: AGHT+IGzNCQ2sSdm6328XMEff4OnV7b8JTCvCHpiAO1Yni+UqNhd7nHAN5I/bPGY+pAUm+NWBiCaFKYddJq3PTicqmM=
X-Received: by 2002:a25:428b:0:b0:d36:99eb:fc01 with SMTP id
 p133-20020a25428b000000b00d3699ebfc01mr10923615yba.15.1692053026606; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230813195219.159629-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813195219.159629-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:54 -0600
Message-ID: <CAPnjgZ3ahTmHPwa8bESuiZbjapA05m_+My3QXv4yWP-KhM7G4Q@mail.gmail.com>
Subject: Re: [PATCH] test: cpu: Handle both 32bit and 64bit CPUs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

On Sun, 13 Aug 2023 at 13:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Handle both 32bit and 64bit systems, i.e. sandbox and sandbox64
> the same way drivers/cpu/cpu_sandbox.c does, that is in case
> CONFIG_PHYS_64BIT is enabled, assume 64bit address width, else
> assume 32bit address width. This fixes ut_dm_dm_test_cpu test
> failure on sandbox64.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/dm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
