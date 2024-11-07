Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C61D5AE7C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625748922A;
	Thu,  7 Nov 2024 10:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MBFSXLO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B99E8922A; Thu,  7 Nov 2024 10:43:11 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1721891E4
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so607737a91.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730972587; x=1731577387; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TR7Wk+r0gf+nHPb46zpG50WKX/vF3Y3+ClNjg+ZPsqc=;
 b=MBFSXLO7wOjSDMHmJn+Igoid+e4Qm5YuhlL9G7qptw+kdtC4Vlw657eoPos7btqd5H
 rzbaZGubpifPk0D63VhNwdKp7qDydXqOS1hG1qZBorxvGuXpqn7bSF1Ez5yWMeaaKnL4
 ACgIsG22dwQeL0Cijoe2uaD2K/TdP5bCmnz8RncHhOg7d2lv+bZo+GUPg4Ae8e2MHsfm
 bz922ttS/Gmcbl7XP9X/F+oRmZayWTR8kgVzhQvebDzZAg6eBzTs+il3LWZNaid0TEWV
 p9xcVdYJDN6LbyLPFnrwRG1H6aO2wjAJ1X/ABtZ716QIRsEssDithoJLtU6HvhfA9fNS
 +M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972587; x=1731577387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TR7Wk+r0gf+nHPb46zpG50WKX/vF3Y3+ClNjg+ZPsqc=;
 b=Qxc2Ahiy2i8ircPmADlB/wXGBa4O36/FJMRl1E+WfGT41QTUrODDlKt7iWs7YnAyJ7
 nA9dCxqcdJ5oKO82P+vW7v77XcbxBVMmsFKMFUOECkv5jU106obzYDS3CJ3h0l6aem8F
 832kYsZM5vahwIPPc91xCxJCjfQ5MkbYUAPOe1kg3ZpRwqsaPiZvP8Vvs54aX1wu7WKF
 Z97q/SmNuHn9JnEKLOaPp3e1Kl+93h1KpXdp58X/K20cENQAd3pbdxE2iMcp/ME6XSqR
 0m7FnDVHJItF9NtGYlMx9CCjnHBmPcqzgn/GQxrCvr9xo/9Gjtii/I3UYjgCye3wQcdr
 B6sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIx33fzwXkcqnrnFEmPdcfVjSTn+sbSCzbYJcr5n2UweOOXCYPf194Wir3Fnf7U8U6QsbmnU=@lists.denx.de
X-Gm-Message-State: AOJu0YyqpU0dkpmYtTrXM1HeiPBhLCGn+GawlM90i8XcRwkg8SZBVyfY
 /jJen6Ddg57k81UOc9Ca9eiIWAn4PTEmNU67VY1p8plHcEZ0j+xptfmbwwBWdVCjlbxzhXeY9fu
 F7NeLjPsTTo0BGTee+n38+7aig7zaYUUUwBAdWA==
X-Google-Smtp-Source: AGHT+IEC41wZwPKySmvMWPthbNdT9Xhm+bRAGH28Ej57qlQPpHJ0u7C1+q+TGyN3xQ/W6LI4i6XG30SdfqHI5UY1tj8=
X-Received: by 2002:a17:90b:2785:b0:2e5:5e55:7f1b with SMTP id
 98e67ed59e1d1-2e94c29d178mr31258193a91.4.1730972587527; Thu, 07 Nov 2024
 01:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104135544.GH3600562@bill-the-cat>
In-Reply-To: <20241104135544.GH3600562@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:42:31 +0000
Message-ID: <CAC_iWj+k6-JZX3JZcjCDy6vKi2B5LcK6AMTicqH7fRHo0V6xmg@mail.gmail.com>
Subject: Re: [PATCH 0/9] CI: Set up for an arm64 runner
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Thanks for this

On Mon, 4 Nov 2024 at 13:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 04, 2024 at 06:39:44AM -0700, Simon Glass wrote:
>
> > All gitlab runners are currently amd64 machines. This series attempts to
> > create a docker image which can also support arm64 so that sandbox tests
> > can be run on it.
>
> Thanks for starting on this.

Tom I'll probably have an arm64 runner available next week. Let me
know how/when start testing this

Cheers
/Ilias
>
> --
> Tom
