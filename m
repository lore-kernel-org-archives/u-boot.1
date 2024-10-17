Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E0AD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D538910E;
	Fri, 18 Oct 2024 01:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPebBZHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0D2890E4; Fri, 18 Oct 2024 01:11:46 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65FF89109
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe700dcc3so9333576d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206702; x=1729811502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ViHq5qDSDp5QRMyeHOH9VjCiJfD9qt+1Qvi1v5oSY84=;
 b=ZPebBZHg0KmihVUe8GdHgw8YfttW7C7pq9uDQeb5Ph6+60Ojj45ryWa4uV3HdqhYqY
 FhWThNkCGtz7+aUg+RmTfjmUzYeKt9Mq/++AQ7PuZh6Z6fDlVM/xNs1+mJxDITHtoeuU
 QLwrb/6mdOnvhM9tXgazmVkSB6cEjt1cRs+l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206702; x=1729811502;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ViHq5qDSDp5QRMyeHOH9VjCiJfD9qt+1Qvi1v5oSY84=;
 b=rXGemFjqQICSMTFZdLV/+iCBa6lH0L7a4G0XvCmK24UWKk19Xq6vnsEmofhw9DWwjq
 VekZaebCuv3EDaU7hJQ6oW2ZyKxaXyDeTusKLekbODi1kQy8KAQVFx6/SqStHjwd2bLK
 62F2yKvoFnr99oRc4Se7gdh84XJKWpsxCCgUmu+cztzX7GqfnPIYSNheLHkt7lvkyvxp
 Pmvn6951UnQO8ROJ62azjir6a/xzWnYX1GgGx/TCw+OYonp2qhuqOHdydU2840a6mlfi
 kt0LLm2G2ETfpB6Z/aY1rFAjnDyGqmjkt0myt1zS5gFgo8rmTOuFCJlqNPYCort+EX2q
 dh0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn3P+8wJua5Fdp0jpBG4BO8ft5OovVwarA060kJ/Jh1vPYXWJAR4+6Lebc13+g4U1O0V6OMeY=@lists.denx.de
X-Gm-Message-State: AOJu0YxEhDTu9DN8FMM9EEkfhX+7Jofav4mKDtId7COqoE8Lwu6rM3VU
 HhDdKF4psADitV+h7YikUzp9VwgNhCLtJGv9xbggn4jvhp2kO9xV/nOC2emRtFLZnr9Q5rbXZ7k
 aIMHgGkxhdgHMgK6c1/Cp+Vei+j1J6AWrhrtN
X-Google-Smtp-Source: AGHT+IGY6OmZ0FbQWctQXAgP+acHTzCS5EkRB2H8/czVtGZYjN+rvCrj1UcxaYRQJ4DVLOIJCU6srTCzorbZggp9gS4=
X-Received: by 2002:a05:6214:33c1:b0:6cb:c54c:b782 with SMTP id
 6a1803df08f44-6cde15dedc8mr10393386d6.32.1729206701800; Thu, 17 Oct 2024
 16:11:41 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-6-sjg@chromium.org>
References: <20241014223212.2212442-6-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:41 -0700
X-Google-Sender-Auth: j0rfzwX_2HVpz1FOb6_Pg8pTZWM
Message-ID: <CAFLszTiD=FQfCiD0r9UDjLLwy_ASpZFiOQnUOC6Hu9dTZW2qVA@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] expo: Use standard numbering for save and discard
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Set aside some expo IDs for 'save' and 'discard' buttons. This avoids
needing to store the IDs for these. Adjust the documentation and expo
tool for the new EXPOID_BASE_ID value.

Ignore these objects when saving and loading the cedit, since they do
not contain real data.

Adjust 'cedit run' to return failure when the user exits the expo
without saving. Update the test for this change as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c               | 24 +++++++++++++++++++++---
 boot/expo.c                |  2 +-
 doc/develop/cedit.rst      |  7 ++++++-
 doc/develop/expo.rst       | 12 ++++++++----
 include/expo.h             | 20 ++++++++++++++++++++
 include/test/cedit-test.h  | 30 +++++++++++++++---------------
 test/boot/cedit.c          | 14 ++++++++------
 test/boot/expo.c           |  8 ++++----
 test/boot/files/expo_ids.h |  3 +--
 tools/expo.py              | 33 ++++++++++++++++++++++++++++-----
 10 files changed, 112 insertions(+), 41 deletions(-)

Applied to u-boot-dm, thanks!
