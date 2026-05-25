Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B6ECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B77F8488D;
	Mon, 25 May 2026 16:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k9Rn/20Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00EF8488B; Mon, 25 May 2026 16:32:21 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6230784841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68707d88626so11083757a12.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719539; cv=none;
 d=google.com; s=arc-20240605;
 b=hmfubjmkOIXiVrloi7Ix3J7uiGNPhWCxUkCnzXXlZ+b6Gv6k6h/vJhYsAmlIWP/Gvo
 2+D65XKPqqc8ZXfPFFby0KASSFI7cM+8ONMR/erMxH0pnjAt8T6Elm5MZX5rtqWFtnoh
 09vidwlpsswAGJKveSx0p92EgFW3RMZ7Jv5/owkxL0Z5ppr4S/mVpEVyk5gACSC/hNJw
 XUVeCqQnr2TUIkAbYULNLPQc+xRU51UYGD+QysU5IaeuUps5ZQTd7ob4PxgiuSs462J5
 Y16G+ykkCY1Fd6ITxK4/fQxeUjE47E3ac2YPyNoDu5vy6wrCkGQsoqCd7AVOu8GfXmEK
 mh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Be+1E4Rz2KyRv/+dCQpLJ8DT6MMqA2xYU4dtd46KYtE=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=Hiz5cxoCyEO4HuMZRhMu0QIwUbhjXC03JPj3Av4X8LTA/S9Lmyi2vop9mayMqaIU00
 H374gYTBP/zjN9gPmAIR+mfqc9kp6T9pbJ1JolB2W/NPpT291n+rTQyxT/OcSkqCF2f4
 FViBefoEbikUkaIbIdSa/FmPiCiBxGpdSJ94/xp/8tgkcsr1IOLpg+JE1XqyCVTG/wij
 RDVE3Zubyu0ngBtYoCClrzTlNUg595dmLR4muJKzH7Sxz6t9L3wVcQi2UM2jfE9gdCcd
 6oZKdDU68jr9+MOrM8PPTDyjpqggc5eO0pv48urrHiNQD7ww4/QaskVAROYIxaTamhWd
 JMew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779719539; x=1780324339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Be+1E4Rz2KyRv/+dCQpLJ8DT6MMqA2xYU4dtd46KYtE=;
 b=k9Rn/20YMAq50iJmG+bcrF6nNcHG6bcAz57P6ABQ4dO7hWpVkbIB+8HbjymB7GUuWC
 jdw3DX1Eb8gb2mxzOhIg1/sCYrw5+1vkeG1pfqE0LTnQdc3boCt9ZT75IOkC0agEYrwq
 eojwgJjdYzWJjW46cwa0GAtEevsnZc0BOANlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719539; x=1780324339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Be+1E4Rz2KyRv/+dCQpLJ8DT6MMqA2xYU4dtd46KYtE=;
 b=logZWhSKgp2T8hVaAK7JfLGuQel/hLd4fRXayjq+ip3+p6ITQ+LQXZjZoXmZdPUkLS
 gUfFSYSAz/lXinYQs6uh2DkAY82EkpvjGT1/mc7VsMJamZVyoUUdHdCzqYNV3Y5CMu3r
 PE8KxwGF5bTr8nhRhPfGrPAHXhg+8ns5BaTFjDvQlgk8RCYE5Xyn1mu3loPlqRwSvJiJ
 9YEI4FrDumaRGRZ0UKDENNMwwewOMTGEzB6kZJK/keAiG4s937L8MEzmV5cXssNMBd8t
 qLhCSg/2ajYWV1tKGt0AE5G2bt8BrKvtjVb0WHdBHsVbHAr7o4U8bGFwOQjcImt2xOk8
 S9AQ==
X-Gm-Message-State: AOJu0Yxgkg4ScC7ISOEL3guGcjqG1XeTmiLqTHWYscyqFsOUjYCgFbJZ
 26AHHXrCBk85WNUnPbBF3mEK13N0a9h9nYy/o9qe0wRKeC6mUMxC3vN+Ii4+zVBatbV+/49Wjws
 nuJ9SjKs7kLkAbeJrOfd5k8PscLJLRqgZ0lbFp0eB
X-Gm-Gg: Acq92OFVL9mbBqNy68JgOJPMn3wz6udDNgLBuDjiCdnZdJ6ye9dXQzOUtZiBWWztRaY
 RX2xBsnf7WRGpibvgcn+HaAB4DXXMi/7/wpShymTjSmS47W4K90y+pJn0d6E0o1UPiZMbhV0oG7
 rebB31cxsZ9zB7HvtCD/39FqMjVkN9rsAZK3Pz6KzM+znEAHcfdevvbL+MBbqGERUnGaPo5T1V9
 jyjsBFcgwfBhuyankwr7SFk7mCL+8U64Cac6UgsD0xGtC4jWjOiS2GsJtQDnWpszijZyICgMjpc
 paaXeA==
X-Received: by 2002:a17:906:ef0d:b0:bd5:18e2:4c5 with SMTP id
 a640c23a62f3a-bdd26bd7977mr906504766b.47.1779719538802; Mon, 25 May 2026
 07:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-5-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-5-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:32:06 -0600
X-Gm-Features: AVHnY4IUXI87WpuMqS6Hz9LqHVA1p2PId-9s72l-IxeECdyUGjPmE2AfgcLA3yI
Message-ID: <CAFLszTh9J66Fsn30xF2ESgbE_AwWURs8XEXxdVPkap98VQ7gtA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] linker_lists.h: add ll_*_name() helper macros
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists.h: add ll_*_name() helper macros
>
> Instead of open-coding the same section and symbol naming scheme over
> and over, add helper macros that take the list name (and, for entries,
> the name of the entry/entries) and construct a suitable string
> literal.
>
> This will be particularly important when the followup patches add even
> more uses of those names.
>
> No functional change.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> include/linker_lists.h | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
