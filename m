Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EC9C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACD38886D;
	Mon, 15 Jul 2024 15:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E5lTygzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502A488856; Mon, 15 Jul 2024 15:31:26 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D6E088865
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b6199ef089so26160576d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050283; x=1721655083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KhPEvzlSZDQkmAA1NXVU+0MlmAELmEXFUFq3+y6lTn8=;
 b=E5lTygzEA3kQ7Yq6BQStnrVnl9KH/u4iS2xyPjMGIsJw9A3wjj1ntl/c2/fbZbspZ8
 GOjuvE6kJzOh9mhjRjaVpSouu+vunW3PcnVEAObVc3Njftb6V10SYxhw/DbNHJIOfENj
 LxlRNNuKEr2Ov+B70JckVxl48y3V7maqq75Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050283; x=1721655083;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhPEvzlSZDQkmAA1NXVU+0MlmAELmEXFUFq3+y6lTn8=;
 b=WdpVoOzFB3TBR0W6GQcR0IuyIk8oXj0AdtS/BwYuWqcatTy9456Xv6o+pucAT6L0Si
 Qh56Kr3Putn2MonxW5OEd1K5iUu4kptddDNSEfbITlUbq0uNJJsbGvVQv3quau/LglFQ
 yLx4EXSnq34mqrz4YliSZqJPLhAF6jCuxQwJIt0aLTU6Jx6gZknIacv6pfAbEeRYs/EJ
 AcfPvwV0rjqBy+Htf5RaAvSIEyRYIMX8xPHxUWKpT/CevuzPFKOCv4kkWGPlc3UwLV+1
 MLCP1ACuiMf5tbohdLJSjLjDd9pFb6smV12BFzTuC/fSN3/SLWuMtkwXjaVzAyacxsRD
 FfCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7/WR6mE6Gid0nFohIgPM2LbRtUPHDpOSDEklPpzRIvzdHIAuoszttYDe0unHXZhNjiJkDOzw3OhMA7VZJvLv3yiCAtQ==
X-Gm-Message-State: AOJu0YwuHVrwGOSeJSbf52hMB3Z69fYuDXpQdm8S2P/CbHEucEjMlclF
 N46KnFlrT9Kh5ieRGqKTDCJrBXKT/s+13pwc0gqg3B/gHSI9Zual8dJedClibnHODPzPBee0uIi
 4r3d5kHMSkpzv2YsTG+Wp3YTah8DfDtMKo5vP
X-Google-Smtp-Source: AGHT+IEg/rGDE0Zz62uNRt/ByFMozgqYWQs8ST/gJxAW13fYLKaOhg06kIj/BBKXoPt23lMjYCb0jJXMm0Jje72D1Nc=
X-Received: by 2002:ad4:5be8:0:b0:6b5:4098:abe2 with SMTP id
 6a1803df08f44-6b61c1f5264mr263205216d6.52.1721050282897; Mon, 15 Jul 2024
 06:31:22 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:22 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175622.1468600-4-sjg@chromium.org>
References: <20240623175622.1468600-4-sjg@chromium.org>
 <20240623175622.1468600-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:22 -0700
X-Google-Sender-Auth: AnsrvPQV1zOqqDZQsqOB6aMCUi4
Message-ID: <CAFLszThDtDs2xOU7hTd0S0+FdZyAa0fUMBhQRfWkFDnPC2KrdA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] buildman: Fix a few typos in toolchain code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexey Brodkin <abrodkin@synopsys.com>,
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

Fix 'Thie' and capitalise 'unicode'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to fix a few typos in toolchain code

 tools/buildman/toolchain.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
