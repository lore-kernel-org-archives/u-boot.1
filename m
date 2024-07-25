Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02C1C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A17588599;
	Fri, 26 Jul 2024 01:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hnRvW9Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC898852E; Fri, 26 Jul 2024 01:32:38 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41AC884A9
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b79fc76d03so506916d6.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950355; x=1722555155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L6AuNGJ6T1OGXUxwm+7Gj8jsYbIy5BjJiUkSaNlKvnU=;
 b=hnRvW9Cc8hzflf9E1yKkJXcOvj2IX+AGnbPkrJJJi9BE8wSqZLZJTFZVdjZvMUOZ9P
 NxgxbyUIetX5b2QWIOrlTLnS0StjrzwopDrHO0j4SOaWLYqbDdKIfWfH+3wBftI+Pe4y
 CXe5VUKRWmvhe4pH3wOTTvtZyrH+i8xing8N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950355; x=1722555155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6AuNGJ6T1OGXUxwm+7Gj8jsYbIy5BjJiUkSaNlKvnU=;
 b=qxMIkD4HBQCITmamp2QICvRTYjN6VqgUehBnH7wdrVdOz9rQkGYznrRYRI/gOqfhwK
 BHwfWS9Cb5mvEqR7jvDw8lh3XBjR0jf2BShQl7TOPnUy2Pg9g0U+/j1ohs8ZCUSt3gkW
 ri8u+nI3/lZzg0LKPAKzkyzume8xu7qJSq41A329PmPmL0rV8E/eqjkYcJ6rU01cYqtV
 cqZqDx/ozvHDU5ncB6EunK6f3B7oh2j5VDAPUifNbDQ5O/MuCGKk0JHptS8dNff32tLx
 bc39Xf1NPBMbnkYk3lS2Q4GL1TSgRlAevz9/cmAt0t8WnSJY/nDN9ynF7hHALP90LfVR
 aKbQ==
X-Gm-Message-State: AOJu0Yxv9ND4MvSPXMSpr2x0ukrYGDJonpLWLEICtfYoisyfyVOSiVqj
 5nUcdq4X1fJEaOxoprjl0IvtoKoobDDEVok6wZfXj/bDGBtEUNMpKjWFI0zAxzoRePEi/Rl0kVV
 XnAOFE84o6L6joSHXo+w/mY0btZ0/07c6O58Ms5FASaWfP2E=
X-Google-Smtp-Source: AGHT+IEDLelVU8xGhQOMKGeATuaVr2dhJikrf3Sb2OyDSkst8Ll2lOxbD9SgL6xwR7c1zjm2kCXEEzVjdWPOHvJZ8qY=
X-Received: by 2002:ad4:5ba4:0:b0:6b7:9401:bb7b with SMTP id
 6a1803df08f44-6bb3ca3e3c8mr46350156d6.23.1721950354870; Thu, 25 Jul 2024
 16:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-6-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-6-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:24 -0600
Message-ID: <CAFLszTjCUWWZ1at-NWR17NJu1V3JjksFehy2=QgX2xf98SfXug@mail.gmail.com>
Subject: Re: [PATCH 05/40] spl: alloc: call full alloc functions if malloc
 pool is available
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> If the malloc simple functionality is enabled in SPL, it is not
> possible to call the full-implementation alloc functions even after
> the heap is set-up in ram memory. Check for this condition and
> call the functions when enabled.

Is this because you want to use lmb in SPL. Is that needed?

BTW I'll send a patch to allow alist to run without realloc().

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  common/malloc_simple.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Regards,
SImon
