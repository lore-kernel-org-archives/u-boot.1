Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BA8C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 09:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10EF87842;
	Sat, 28 Oct 2023 11:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7fdqsqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5155A87850; Sat, 28 Oct 2023 11:51:37 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BA687836
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 11:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id CE19CB8187E
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 09:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDCC433C8
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698486693;
 bh=GNDf8LvusR6ZgGhwmyHmDzU/pVpBClhIYC2hQq+9buA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=B7fdqsqk031Kn0CZi/Vy5J5mBKlp4xRzDmAKB7gPzntJ2++IYKSeiLLFxlNFIcg+m
 VOqGmTr63NsMjWGFRXRdiFwHPUekGU4iOb3uzrwIwNPMmZtQHPcfr06BfX0hc5fTe5
 ckmXJqek0ziJuXEk7W47B5ESf5EPiPbPSB7kdF/Vd1WzT/YTHcDVg8qAjgh8JX0WiA
 O6Fzuli4/6Nh/tH6yvAgcI4waL+v9Rkc4+3ovsW6R9Uwa7pPhVH66ncUUWCxIQBbEo
 Md/Jj07sq1a+uLerZF4IvIDwGS+q+GqgdeZ8+Uxljz3/LCpo0SOz2AskcvlXo7yKa3
 b9eI+YbKA3A5w==
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-1ead2e6fab7so1901672fac.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:51:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw6iOa8/S0AChHkvRZVG1yUA1VnBG6+UHbi1PRQ8yedtJh4p+iX
 FO+Yt5YXTJAesYHZVRuG8udCDELR5E91uBKKPUA=
X-Google-Smtp-Source: AGHT+IFv8vMfCPjd/oJREySU+skr371cgt0AF/R8GRXXTgjWyAhUUoLUAoqzKpwogiRLOFUYnFiyMD40qtsmfZstnHM=
X-Received: by 2002:a05:6870:b48f:b0:1e9:b0fa:de48 with SMTP id
 y15-20020a056870b48f00b001e9b0fade48mr6157186oap.47.1698486693015; Sat, 28
 Oct 2023 02:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-2-sjg@chromium.org>
In-Reply-To: <20231026072628.4115527-2-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 28 Oct 2023 18:50:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReQB4KF_Ka=SUWSJ2psvqCrEm=BOkKXCYDK7Ux9uYutg@mail.gmail.com>
Message-ID: <CAK7LNAReQB4KF_Ka=SUWSJ2psvqCrEm=BOkKXCYDK7Ux9uYutg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Correct missing architecture-specific hyphens
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 26, 2023 at 4:27=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These should add a hyphen to indicate that it makes a adjective. Fix
> them.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---


This is trivial.
Applied to linux-kbuild. Thanks.


git grep -i 'arch specific'

 or

git grep -i 'architecture specific'

finds similar patterns, but presumably we are not
keen on fixing them tree-wide.





--=20
Best Regards
Masahiro Yamada
