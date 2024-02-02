Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB3C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 23:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D427887ED6;
	Sat,  3 Feb 2024 00:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jUX9s7en";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3A687ED7; Sat,  3 Feb 2024 00:54:29 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D49E87ED0
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 00:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.guo@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f19a3ca7aso7259013a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 15:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706918066; x=1707522866; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkgOcOwUjVFCYTmHvZJC/mu2YJ+6vSJb6WSKt/9CX6M=;
 b=jUX9s7enrsjs7JiJYFwxJ+V/13Mty74ldFrnSvJRtQfZJcCeu5vfr7EilMZ38Iln+u
 N5cFDrzaX1nBSP1vuKT94pdNp+Ng2j4Uk+VN5HzkgoyXpCAE5mJCU3XxxLhtOC/THheG
 zAb7iM++/JQBXRGt01b6wtLWGysquOSOi+un+KgHeVlDviB8AWRgrDqT6Bs5J9J5UUov
 qtDycGxp2kxVEy4Gwh7LLq78rmeihScmeYHRBHcQs/yyXlSWFJq1TFVmv3ZYAuQ805A3
 Z8AXFeQ9chBlZG05aUkCeL5+CFXa7oqhsxm48i68XE2aTtm4snuFRSxRpoNDrhvFFAUx
 tM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706918066; x=1707522866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkgOcOwUjVFCYTmHvZJC/mu2YJ+6vSJb6WSKt/9CX6M=;
 b=wC9arFzhFVw0opE3RThJpC54jtaT9sjAvKTQChhkIA2mFw8M/pBDFcYvtKzZ8Ik1K9
 SIXYFUg2LzqI69i5ZbUBmwaqN+RzqUAM+h6ORGDrRBcN6eKM8vwioKN36dnL6y8gIUU0
 GWXvbDEd6CmJd1+HoP68QOT+xU6qG3YSx2xliMoF0O8/JRUpyFnylIK5+bxGE8yiZJnQ
 ILc5S4hgHobjqgn5oPCQbivjjPx85/g/lHmo3+tQhDZvRdu16HLUPb9V4PHVuQMoPweG
 JZXp/bVkCGVK1DZS7bJUzDt4evxP5w8P26I/0aJ25CM1eEKqVgPoNtXrFITbtpD3swKW
 Yewg==
X-Gm-Message-State: AOJu0YyOeWRP6zfTpi82+D+3klA+NtcPDZ9NM4x3wvStYTG3UHfaLA6Z
 JeV97MoSN0GA+XnOz+ZpooezpLGrJSLBEM/gIdLTcG0oLR7qCooStGDEnKEyx4E4dtL38FfhSKa
 H1zmWajF3IwMlxlhxOUzDRpbSez0w8y8SAHdlLA==
X-Google-Smtp-Source: AGHT+IHKNPxApyc5YI0zFq3SQXO+nUu05MdScTwMBb69hyMLv+1bhMwZ308S67DfMcCvn+RMxR+ulAy9KS3YLY0msXo=
X-Received: by 2002:a17:907:77d8:b0:a36:c275:55e4 with SMTP id
 kz24-20020a17090777d800b00a36c27555e4mr111007ejc.15.1706918066515; Fri, 02
 Feb 2024 15:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
In-Reply-To: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 3 Feb 2024 07:54:22 +0800
Message-ID: <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
Subject: Re: [PATCH] poplar: add myself as co-maintainer
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Sat, Feb 3, 2024 at 5:44=E2=80=AFAM Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:
>
> Add myself as co-maintainer for Poplar board, as I'm currently
> working on it (re-testing releases, addressing issues etc).
>
> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

I'm not actively working on poplar any more, so maybe remove me in the mean=
time.

Shawn
