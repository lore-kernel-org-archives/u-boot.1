Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FDE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0102B8956C;
	Thu,  5 Dec 2024 20:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hehaCSye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37AB8919B; Thu,  5 Dec 2024 20:56:04 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6C689568
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso191820566b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428562; x=1734033362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bdxuAmJ7eUTqVflq5aTdgnIk4LoAjDqoDW0EywqECGM=;
 b=hehaCSye2IT/3/Nxyh2ha5jj2w7hIAYQ2YnRhNCWzPL2ScsN4Cd4xvZWkun8XG+Hy5
 j9dnUMC5aP03Q6HNfus8JngCid1IGh0KOZUFox2ERPw8fzLOPV6bOfrUgyiU2xUXVQRy
 LHw7iGC3ZQ9aSF7o9HHYZ4jKGiAGOi/5Z72BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428562; x=1734033362;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bdxuAmJ7eUTqVflq5aTdgnIk4LoAjDqoDW0EywqECGM=;
 b=LMaWpZ1oNdv2Fn8MAjC3Wge1YIhi8hBYJ4ET+H7zg+FFX/afRlYFYSoKcqzlXHMrg5
 U9TvY6lfzwzS3eaRoN4M8QQYoW2yDqJkXC81w/hxgap54IKQ/jTn+uq6lrD8RkiYhBy0
 nVkYg8kv/ELyZ/QiSmD8UTgoFiLT2jXMaOnY+bX+3xa7qoKYhMUH74i6dXPJxYV3ZCIe
 QRITEYKtalV+4obevlPeRJia6FpiXjHdUU35kFOpmMyNQ60oe40QuH3lEp2sj2/EmZA1
 2PhtajCrHHr0vI5p5IuWhSetPHoGPIsBuDfUb0aa7NkNSOs9z9WnBOohLB/C0PeRRq1g
 T3aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW404h0cIbjTdHC/wXO4v2hGp4h/XuNhFNhlwZqG8sZ10Ddatkb2TK21qxSUOyuemPS5fqj6gw=@lists.denx.de
X-Gm-Message-State: AOJu0YyUHJ+y5dWTDoBoT5/MdWhT9PKG78De1rLvIFbIppsYZNZ1r9O8
 d3NpKwYyaJ6mY5LKBZFKOlqC+tdo+gnhu8klk1atUVgBmpKlJ9WkCvKR9Rc+ByTf0ElqBffFKjT
 9ZS1JXpQJyy/jhtJHuE/Rkk5prfxlpwRn0ply
X-Gm-Gg: ASbGncsXQ1Z/yIRy9XuUTzeKVmua3Ht6XNW3ldH0oIipVVyh4S+po5c7z2bRRDvMVwU
 nPVtQYPVsiDGhfhn6tZ+/ZgYZI+TAbMVP
X-Google-Smtp-Source: AGHT+IHXV4faMxaUzuiQekWEBzlv590z8/TDqMCiMM+A/apwuww6Hg/XsnjVrB6IIBnT9sT21mHRAnN2Rd0LdOVYLCI=
X-Received: by 2002:a17:906:9c2:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa63a2432bbmr6609066b.54.1733428562523; Thu, 05 Dec 2024
 11:56:02 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:59 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-8-sjg@chromium.org>
References: <20241115231926.211999-8-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:59 -0600
X-Google-Sender-Auth: 8ZtQ1BoAbFtaDZQomc7qXTRgqM4
Message-ID: <CAFLszTj6pFhPp+ezZx31bQUy3bzLTCuv72yxFUGq293qt8WtKg@mail.gmail.com>
Subject: Re: [PATCH v4 07/19] bootstd: Update bootmeth_alloc_file() to record
 images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Nam Cao <namcao@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

As a first step to recording images and where they came from, update
this function to do so, since it is used by two bootmeths

Create a helper function in the bootflow system, since recorded
images are always associated with bootflows.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a helper in bootflow

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootflow.c          | 21 +++++++++++++++++++++
 boot/bootmeth-uclass.c   | 12 +++++++++++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_script.c   |  3 ++-
 include/bootflow.h       | 15 +++++++++++++++
 include/bootmeth.h       |  8 +++++---
 6 files changed, 55 insertions(+), 6 deletions(-)

Applied to ci/master, thanks!
