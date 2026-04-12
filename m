Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF8F3ED6D
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 05:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4FD839D9;
	Sun, 12 Apr 2026 07:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="ixP2E/g9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACA783B99; Sun, 12 Apr 2026 07:12:49 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C43480517
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 07:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-12c45281a06so661136c88.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775970764; cv=none;
 d=google.com; s=arc-20240605;
 b=VxlP8J2Imbh0bQGlM+32c15QmU2Z6asFSi/bGCTc2wxvJ14XNL+7FLdKso3yHHCR/D
 dEqpjT7TbbXjm7b8zOfoXf12VpgxhEGe9HC9KyLd5JXsSDXPperfA9SjzKejispnLZ4h
 E9H0RT288lCmCTQkAcNE5/dOYz93uS8wIUmsEC8IvOELST9npIym66gONITx7GmHMVTP
 nQqmIRrSxxE3GK3JkJQ0dJH1/GgSlhJwYTtN8hAANC6NJj21GI4xcBpijb7Zzb57C53p
 aMR4uxCWZgy0h1n50xzRPUNxjXZur2rc5h2xN8JkZN4tQ9QPXC/lBA95RDZqTiulljST
 UAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E5DM+C0BVYPkwhDVDxkuZo2joMNmznOa2v23Tl+s640=;
 fh=FkMP/ei1tOJRQrGSPZFyjiCtDfljhwNveePQpEysuVE=;
 b=MF38CbLmCmh1rs3A59iurpFTGyRNeYATgNxorZifH0ECPN4qu9ot/4x+5HZla6jxNZ
 6ULcMLy4vqbyyu3ZYz5dTQdGMrs5l0NMi5t96xzd6NebgXvp1SOuqUw/3ST3tKQukpCf
 8FJos94xGB5ERTQkuoKaYIPWPAsRVIW8oSTL4Ti5VgGTaqhRKr883AXe9LAIePazv5D7
 WX/EgxvsC2/DVkIFQt7PVoWNo3QulVVGwgjYVE58EQ/BSpr6KH6bHGHssWR5+EeccLjS
 nVtIcgVb39pkCeiRi/9BgHwJRfg6pDUPVS4PCvv2pIDf9qmSuXgCTDPBH+kKn7GilRaE
 V+Mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775970764; x=1776575564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E5DM+C0BVYPkwhDVDxkuZo2joMNmznOa2v23Tl+s640=;
 b=ixP2E/g9LTYAsiSzwepGcltRqCEWka6ke6eD25qndqqrEfWnefRV9Xhj/V8JNgxUd7
 pAfpvTdOKkmLUBZAtRdajOna6uNh5419OziWVtdYBxsqCGEtPJ8813zC1FhjB2iGuiej
 xV1d5S3fLW1R5M1J49F8UFLSEVo1ziVSS3zkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775970764; x=1776575564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5DM+C0BVYPkwhDVDxkuZo2joMNmznOa2v23Tl+s640=;
 b=CEgGMsmJB0ulj4ngWjKIZQFvDr+ZEFK2VBFIBTMFEYzDpVIqyM6mP9cuF7uTZiXmfR
 ktV2jl7lM5YD9QmLZumv87vcxgJSiX7+z4+35NRwqcYGP4VVb4TFYzJ9+cTAL/BpDnjJ
 PAz7plTklyv5WZJnNMFs8IDjg7Zys2n9GzrlYDSpDm0X6A7XIc9g9S/UWv3TaZUt801V
 roQHqXkQgbPxq8/TedFYII1lRTvnQTSFJ6esLuTp+/K9FwhI/Yl5MowHGOpK7+OhR741
 jS3YdDTfkoW/uht9mnHGGte5kGsd6EGBzf3BD1FnlY/g2vFfPlgXeO3swVM8rVgDx/J9
 sujw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwMj1CNnnLAioHHgpiUci+1Jp3Iz1IOodTqTR1sqQfWesJDsX1SYhvUjIYz/FsM33s7ndeuJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxdwZIjOO6n6je0VpjlS5sMAeYpMNpZp2lGxKAPN3K/yk3+znNN
 iRyixAJ896R2ntYlTpyxS7km2qooyLTzcaUnjsXf9fX2F8MgV0hFOemL1Ho3AvBXJ27iMFQEfbd
 6omlrGxOGaeAIC+XDwJLsWIvuT8cxvQaA4fKkeri68Q==
X-Gm-Gg: AeBDieutHYQjRUDd/JGcAFx5MH1RUnfpn6vKVmeOMAWp9692sGrnL/AWJhL9wQDAVUH
 P9aGpEBmXCfD6omBAT1jVeBv50UhFApVphNwQAJ7KOTyyKiaJ8jvs3RUSvHVC90GzE3KSAgXpV2
 NqElyYFCC69HCqUN94vefDYkKcIlIKjU2SFGXh6peukIvKbU1soHs1qeWQ/XMAumaBQSyg+Rf4q
 LOaVnfTckEulV0aMsdm8/OlWtW32QLrsihLXtXPWDOLr2W3DxBM7H7g25ZE5CnpRfZh79VDFSND
 7btH
X-Received: by 2002:a05:7022:327:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-12c34e714e3mr4496371c88.2.1775970764393; Sat, 11 Apr 2026
 22:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-4-daniel@thingy.jp>
 <460879a4-5025-4a48-bbfa-7bc7915b267d@kernel-space.org>
In-Reply-To: <460879a4-5025-4a48-bbfa-7bc7915b267d@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 12 Apr 2026 14:12:32 +0900
X-Gm-Features: AQROBzCg4YMlcLNAPhj--CLiaGJkr3dL2cSIIEoH2uxXtCvVhuDiOxp3JXkfH30
Message-ID: <CAFr9PXm3t2eCD8ELah86JQaYdrKS1efgWGAXV4u=qQSPib0gUQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] virtio: mmio: Allow instantiation via platform data
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Angelo,

On Sun, 12 Apr 2026 at 06:15, Angelo Dureghello <angelo@kernel-space.org> wrote:
>
> A question here,
>
> this driver would still work for other devicetree cases ?

Yeah, I hadn't actually tested that though so I just built this series
for the ARM virt machine to test it still works and it does so there
shouldn't be any problems for the current users.

> Also, there are some coding style changes that should be in a separate
> patch.

mmm I think it's minimal enough that it's ok but if whoever ends up
merging this wants that I will split it into two commits.

Thanks,

Daniel
