Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D84CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A712F86AA3;
	Tue, 19 Sep 2023 09:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q10dODgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080A786ABF; Tue, 19 Sep 2023 09:20:01 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BCB86A81
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so6503582a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107999; x=1695712799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9y+Lcvlyfko9kSck2Hc+eG6UBsW1nKghAtNV5CnPQTc=;
 b=Q10dODgnRgi7xsxHQxiNrdMgCce5GiCdylGVJInNMgWz3w2WV0ETsCza87aodpBMDx
 cTAu4RY3B7LuSSMj5IvIMV+zyesczgtuHgQ9mTz9wEtA0UQM+UNdHANEqbWj4IDOpBHA
 bzgvfAjF+rki2sHRObkne/Wd5HmI6N1yY9gQTM2lsQlBdHQVAZpo/jhiP49Pk4zg6IM6
 XFnSNcEWfOknZSub53nnLZQdg9jvU4wnKMGYUBrERhLmIlj02JSjqZMx+PAA3UnbS4lm
 5MPyG3ME5lFeaPIbD7XsGyn2EPI69AcCbelYrxVD0VFBvW6yxfHKEO+B4+sEDFN5cH/t
 3yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107999; x=1695712799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9y+Lcvlyfko9kSck2Hc+eG6UBsW1nKghAtNV5CnPQTc=;
 b=keb+5kV3+5aXYdlRYkaBs0kvBZ23C3MLezXp7qUfigfuJnYfdT5bFfgdhN6h31E8Ni
 yI7eX1YUbtQi2d/DWtViuuff/Wc4kUSR2XSrY0nalIOS4IQD/M6RYVrkljy3uWGM7oaR
 wEF7h0dHHIPU/oofrueUxDiuqveNWo+1qQegGA80rZuWI1RTEn6RQ7R++9jsoNKe94aO
 QlaW1RqHq0xAZWCVbg2RAsn6+eXigsfIbeHhjsu/O4RCZiLh3r5zQ3cg46/nZSYy45tR
 jQHMh4KJ1rM5wPzJNg2HjhErJuA5PklkLBRxAxvIwOYs3HGUG9lhe4+bAZql3m4tADN6
 2jMg==
X-Gm-Message-State: AOJu0YzxDvp2TIZAmzeWsJrtNYt1yN+y87WS9p7iIfphNAlmgjAnClm4
 wRxuno1Rr94KpScrSeUNqfpADvNd69271ORRIARG9dMd
X-Google-Smtp-Source: AGHT+IEy92gNyz8nIr+bzx7mZJq2KCOYFR/uti+n0MA0eyJCRM1hmEQVxtc436S5t7VMr1WFKTGWlZBU8x+djmy6+KI=
X-Received: by 2002:a05:6402:b32:b0:522:1e24:afb6 with SMTP id
 bo18-20020a0564020b3200b005221e24afb6mr9259647edb.0.1695107998725; Tue, 19
 Sep 2023 00:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-11-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-11-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:44 +0800
Message-ID: <CAEUhbmWNmro6ancrARUWwyW4UA_BnLHH5-61tcEPvgq9wVea9Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] x86: coreboot: Enable VIDEO_COPY
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> At least on modern machines the write-back mechanism for the frame buffer
> is quite slow when scrolling, since it must read the entire frame buffer
> and write it back.
>
> Enable the VIDEO_COPY feature to resolve this problem.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/dts/coreboot.dts    |  1 +
>  configs/coreboot64_defconfig |  1 +
>  configs/coreboot_defconfig   |  1 +
>  drivers/video/coreboot.c     | 12 ++++++++++++
>  4 files changed, 15 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
