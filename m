Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F77C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0A28367B;
	Sat, 24 May 2025 07:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CXujoUtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D37834BC; Sat, 24 May 2025 07:06:44 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDF283303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad52dfe06ceso51244866b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063200; x=1748668000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQOTzyGpROWVVqWlpVXPxewkBSYz75j20JaJwDvYXqE=;
 b=CXujoUtdZ+d/PESe3LkbR/uc8/S2UPRCP7M/j+umzvnPqpZUZLubqZ+xN4rvel5k//
 lD8yp9xKv9kZRTZxLKSLQ9le7mFLrbM0Z8shk6bTh/qdSth35EHhPmWnKikt7l+7eVoZ
 XN1eRZk9UJgnhlmWJ8Oy3hdtGAqZP3lk/+rFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063200; x=1748668000;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZQOTzyGpROWVVqWlpVXPxewkBSYz75j20JaJwDvYXqE=;
 b=nIkk8OdFDOw5UEMWhUaow693Piqa16bdtG0JBsp/tDJXW5AnBIJ5pnl1+0Rs2WxhI8
 VDfaBaMU3KvsAJaPvFgXaVOyclrFoZJE3sYXqf8sLtsNmX7INXDTS49+7yvdYj4O0VGd
 aSjBW/yQLqBy3TvPpK7NFjsBJaatYauGDFO9dB8FTDsyTKTE3IV1UPiJ8cx7xC+63zIG
 /BIMskqukYsShKyJRL+4dPuvTSmNb5YJe06nt6q5jgFdfk9coPhYavfz7TkbopVK1wY+
 YgRDv/y/SAFBJRLduzUdoUNyOt0g69GMC9ValIn85YYzDo6aNPy3QfhGqkX29uOjRoIh
 DEbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyVbc+2hKw+E27/+bYUNIagmQ6FqJsDDHd4oWZM3iGRespghdi/xtl7ux/2mc2aTaMgwR3U4c=@lists.denx.de
X-Gm-Message-State: AOJu0YyKpiZBsvspKaLH/ULTovDhkTtjbVHMszCm9GqVQWaRqKdKG1T3
 FZ2MlfeahnQ0ezD9jmvE2+7A/HUTToYmKyeor76t8PkuSiTKmhkJJQWmtvmdXM8mZWmSnQ/BUXw
 7QEEBwXBPCcyit3JIzT8r7EuzHdqK9/J/5tyYSvto6HhdI9XOg2QYI7mB
X-Gm-Gg: ASbGncvp9BR6IYqVNCgn9udOM8PfBrDRYL1rgi2wc7ZTc9h+bzVzp8G7/e+i8tI81wi
 2hHoy5tRo3DiESxiBElR4US6OTogV54MD0xvX0dLP4bqqVyyfWtYpjg070evYnVeq6qL8/z/Vsq
 KSkoif4MNaxGOap6ZWb97+7/7PTdUw3YE=
X-Google-Smtp-Source: AGHT+IHTt5MGGsP3R544IM0dhe9Et/5m4z+jra7ifwuRQLw/quOH+s3VywA9oSGBMwQEg5CqZhClcZdBTRZpxm6YwWM=
X-Received: by 2002:a17:907:3eaa:b0:ad5:50da:691f with SMTP id
 a640c23a62f3a-ad85b2a50d9mr149513266b.59.1748063200144; Fri, 23 May 2025
 22:06:40 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:37 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:37 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-3-sjg@chromium.org>
References: <20250510110535.1453745-3-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:37 -0500
X-Google-Sender-Auth: igQjPprH6E0EYPKj9YlGw1ePCBw
X-Gm-Features: AX0GCFsRlBLXHrsvzfeCPUJ4UzlrOA6ir7u8CKX9uS5mMlfsfpTRrodPqJQLDLM
Message-ID: <CAFLszTi-K-86B1ghXCkD-iOL=-G2qLAXPif+gjEVO4A3PXaxpA@mail.gmail.com>
Subject: Re: [PATCH 02/25] patman: Deal with git safe-directory warning
To: Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>, Tom Rini <trini@konsulko.com>, 
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

When running tests where the .git directory is not owned by the current
user, various warnings are produced and the tests fail. This happens in
CI.

For patman itself, modify the gitutil.get_top_level() function to return
None in this case. Ensure that the warning is not shown, since it creates
about 1000 lines of output.

For checkpatch, the same warning is produced even though --no-tree is
given. Suppress that as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/checkpatch.py     |  7 ++++---
 tools/patman/cmdline.py        |  8 ++++++--
 tools/patman/get_maintainer.py | 13 ++++++++-----
 tools/patman/project.py        |  3 ++-
 tools/patman/settings.py       |  3 ++-
 tools/u_boot_pylib/gitutil.py  | 11 ++++++++---
 6 files changed, 30 insertions(+), 15 deletions(-)

Applied to sjg/master, thanks!
