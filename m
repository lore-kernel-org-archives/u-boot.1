Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC0AC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAB78344E;
	Sat, 24 May 2025 07:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STnc84mT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78AE83303; Sat, 24 May 2025 07:05:47 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7D08344E
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso60547066b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063145; x=1748667945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PB6IJsHxGgVAh+3OgxypQN9VEYdIJgDWSrZe5cSorG8=;
 b=STnc84mT7/b24KPv8AU4d31ujFpiQOsAfZxy8i8wStH6W5gibWH8qOFjsE0jyDpWhU
 cPUeT+V3t2G5ETtxB2aqLc/jGGazcjR3ZkLvwYpwDlC+EpUc9W2jWaryo6Wcfw7mPrCY
 aZ8iwO0AAwQ5is/AgZWD3S/22eK9B7oAMZlxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063145; x=1748667945;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PB6IJsHxGgVAh+3OgxypQN9VEYdIJgDWSrZe5cSorG8=;
 b=gf7Hr9+fAq50mnMFRJGcPoISyfeprzHgW/sqhZYeqYvjrHPjqnj2pBRtT7u/FBfUtH
 +H4s6p62z8DkOumXVNk8JZnagi1kRQv7mIpEtEOGKXSMVCzzbvaJ7he4QRbXksLYaFzi
 GLVI/u+0y5sLZ/fSQ5LHz7ycO54Q/EmXwWyoXRaRshEJMWpJdtBLl82moFUOBDP9iwLc
 nsoY4XpMIslulKgpAetaoMNURLeXB6gqo7I/z5AZqjUle6D4QAWN1oAY9Cowq8jw9KcC
 /0zZszbeYLNNGecjTFR8gyws5pIcLiDrRNYgm8MuJjIN/WkBR0NRwjPGL/K4V77hkADE
 8+Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxbF1CEXrPROz4XZz/uwIMMr9zczEnvtdVRDz+xsNKgkLopMPgBxhku2SdNnVOfvRkr+VDc/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzMeViCFkBeUd4Ut7cttM+o/7ErXYVMkltVoS/mafwRC9dboARw
 Ggq6v5EZT5N8p/UDKuRQZpws1JO3RbPGMxIi3zrvRHdVOxrYsGno/q+q6d16S96+A7n6ak4MKBo
 wFGZOLXbClreamvFPvYULC/rCpvawQHX8fIpKAM4C
X-Gm-Gg: ASbGncsrNes0LPhpyG4/TOghxPjfjt3MpqlbSLwfNFGHriKhIgN6Z00zXDUw9pwsAGQ
 b0GbdtKyI+wSRBOzLdoIfx46zqYRYq/TCAbo7nYZIjr946XqbdPnobHA+/wn8G7gbrmNPle/Enh
 PrAIE2YSHdfKSd2ze2megyrMBQvRyqUhQ=
X-Google-Smtp-Source: AGHT+IGJeizIWkktFnT+6GNrpU+E2yvggaQxpe+90QNfDOTNixUlSi42uP7/V+BhV9Aoy0DS48GIBJIJWx/Ar5QlQuA=
X-Received: by 2002:a17:907:c26:b0:acb:b9db:aa22 with SMTP id
 a640c23a62f3a-ad85af3c2b7mr155539866b.0.1748063145257; Fri, 23 May 2025
 22:05:45 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:05:43 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:05:43 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-23-sjg@chromium.org>
References: <20250510110535.1453745-23-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Fri, 23 May 2025 22:05:43 -0700
X-Google-Sender-Auth: vmAlcksUCG-Obn7ZAXFM870QBDY
X-Gm-Features: AX0GCFtW-yYRMrrh9Wwl0r1vWq5dkk7PaI0xLSAv6aHx992AzPKlLFi8QUTGKWs
Message-ID: <CAFLszTghQipNPMMRALEAGQqUqhPDiLi1UaB9Nh1w6Po47QvBtg@mail.gmail.com>
Subject: Re: [PATCH 22/25] patman: Implement the series subcommand
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add a command to support management of series. These are local branches
which may have been sent to the mailing list, so may appear on the
patchwork server.

The new functionality uses a database, stored in a local file.

Various operations are supported:
   - add a new series
   - send a series and automatically link it with patchwork
   - 'increment' the version, to prepare to send an updated series
   - gather review/test tags from patchwork
   - check on progress, i.e. patches which are received new tags or
     comments
   - show comments on patches and cover letters

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 183 ++++++++++++++++++++++++++++++++++++++++
 tools/patman/control.py | 107 +++++++++++++++++++++++
 2 files changed, 290 insertions(+)

Applied to sjg/master, thanks!
