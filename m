Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A925DCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CBD84957;
	Thu,  4 Jun 2026 19:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dmTdIvcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBFE38495C; Thu,  4 Jun 2026 19:01:55 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143A48493A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so124540466b.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780592513; cv=none;
 d=google.com; s=arc-20240605;
 b=boJnzyk7N59ihbIDYKLXc7uBxj7+scJNiCrr/ddXo+d+cumDq7LpokfLMN8RxDQB6B
 NXAY4QxYltftgayndM35n+7kxWoeoj9G28eHUz1XwT7a+DzPtPPLRb2Ch+qtpWG9iwqN
 4Ijz84wKHQ4OJzNoWYNcytc1pmtJjVNB+qerlDgWBw9B+vr0Ovh1SBNiT9q1cJTC0pd4
 MgA0f2zHRDRAna0n3lxL4Ub43WN3N5RUgIDvGUXRaH23uYrIUSB5vFKEQM2OnkP/eR4o
 v3HJwwkNtcXzUwIfGxpxLN5NlEQxaHEZlx3kR9TSqkhN4NtZKxmOOLGFlYeU/DEs5dYy
 OCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EO7R0EIRwThGjdTrvpnsGV+fBCOyOOnp0l7vZu3hcXA=;
 fh=j4KgKFsTRUTpoUCanYSFU1or5IjOFW5tZy+TFvq+bqs=;
 b=Zl6md7VUpPrIO2tSy09+d4HbDEi5l0fZsLdqGmlxf5rhJ9/Q7e06m8IJB+tjz3ARY+
 SjVQkW9zWWTyBJocGQG2QLB8bZeozwcl5aTLWNgagPMpV1T35wmMIebtt2HzB4UkeAxH
 28d0TNni83DodL00AxYF35TSMvuMBLk4piNzYxZHoygEB+Te4jzzTe2UqQKk3tXI3uBi
 alcJlmXBM9lUAO+TDiIj2ecNYVkBh8fCHYzu0RPr8OZc1h/vqeYA44E+V8U0Q2ALyM4l
 EcS8WLAHJT88Fmvmj2Td44m1Qnh6HplaCAswpGHjf/aP8dxCf3pRRJDhotxrpmNsHYdx
 2Xjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780592513; x=1781197313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EO7R0EIRwThGjdTrvpnsGV+fBCOyOOnp0l7vZu3hcXA=;
 b=dmTdIvcm34/NVwEOWAq1vOQaumIHSGByKOq5esCls5GecwgQaWxJ2KUkmJrZ5QtCVF
 NniljR8W4tR1lpklR04vlCXzoMt8SBbu9lYuE3R99XjxPVjPaFUrxkgVMVx5D1zPqO5S
 MFdhekKaHYi4Bq1zuSPh72y9hrZ7bs1M4/4+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780592513; x=1781197313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EO7R0EIRwThGjdTrvpnsGV+fBCOyOOnp0l7vZu3hcXA=;
 b=jHgU6hZwLZ6vduyZtfg1XqdqxH0LcO4Va6wVCjRTrYI+jO7tDhrf1v54JVkdJ5JMIx
 fqeRTnryYRwQ4BoLywbkAVl0gn37AL23j9ylqAxf2ontP/4Wv3uIXmVfaazb6QpsSj3A
 gPTwpbCIE4u9Om1rQ0AKF1d8skCt1HGLCxaPDJZJSj5uGTH6JKqHMbP/BSJgHNi/4kkU
 tENRhucWrXABmpOQNhQVRrgzc2E6cYjd+BUtcgKVPTVrtOEAZJftPVYHUdkhDGXqHfFO
 5Dyx7rorgaUVBXS9V9mVfRxIhYEJv/wzSomqZ+JxSpW7/ay5ZJBbmy1pBsB+FyZFN77D
 gwGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ99a8PFvQrS5ifb6FHGKVy1lLY/b32x2S76bdO+lS55Op0YoAknTguOWhSMs1ajS3YpM0dUzN4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz7vGpwcqSr4g1aSsqwgN+veR4RAAQdXwl8Yq7BvYc8pnmvV8u
 D2toAYUIEdxmt0+8Dl9wNWBBwYich9hmDeOtw7J5K+HnfYm/Jg1JYfg0H9vkc9J6Qc4HbBRzRW4
 Xla6qp0SVvPNvlgk47/LSkFJZx3C5NoK75+UMJiGZ
X-Gm-Gg: Acq92OGGudSqdkAK7EvMOGBhXUTwGtAftPutgdYIp0IoL8uHHQrSnDR9/i25IqTxaeR
 f5AlXxcu6Ne5yAuXxr/EjYxWoUO+nMCvDzkDrN/8i+gkfB1TkvQTJDETu7mYbvrY6Rbc2s/OBIM
 cfw9dtrysJPNVARzy4ahJ3fEHpxQWHF6Ey41GtCGYgRVqqfOQD15xzXpHeYb3893+OAhyAMN/6G
 3XkiprBcU1L10D15a4Rh7Iq5iXR43PbA7v7zM1UgAhNtARAgDVfVm6117ONIRgp/ZXXvwxmg9QX
 T6TB3UOSSPIXK+Kc
X-Received: by 2002:a17:907:398c:b0:bf0:59a2:4ccc with SMTP id
 a640c23a62f3a-bf0ac40a9ddmr464700966b.3.1780592513040; Thu, 04 Jun 2026
 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-5-dmukhin@ford.com>
 <757cf33e-0a87-45d1-29f5-aac6fd5282c3@gmail.com>
In-Reply-To: <757cf33e-0a87-45d1-29f5-aac6fd5282c3@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jun 2026 11:01:39 -0600
X-Gm-Features: AVVi8CcB4-fsE8q7MTR48UIEjSszrAKm9FyesNfYvTmgyYTLZpD-dAwibEien5k
Message-ID: <CAFLszTh5QsOWg1tWBX0ec6TawPh=e1ep6OECQkzHXbwOK-hqug@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] cmd: Add flush support for all blk devices
To: Sean Anderson <seanga2@gmail.com>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, neil.armstrong@linaro.org, 
 trini@konsulko.com
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

Hi Sean,

On Wed, 3 Jun 2026 at 11:43, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 5/28/26 23:44, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> >
> > Introduce `flush` subcommand for all blk devices to allow committing
> > dirty data explicitly to the given block device.
>
> Shouldn't this be done automatically as part of blk_write? Similar to
> how all FS operations in U-Boot look like
>
> - Mount FS
> - Perform operation
> - Unmount FS
>
> so the FS is never in an inconsistent state once an operation completes.
>
> Is the performance impact too much? I'm just concerned that a lot of
> existing code assumes that blk_write is persistent and that it's OK
> to e.g. immediately reset after blk_write returns.

This is actually for a device-level flush, so more like a Linux 'sync'
than just a write. If the hardware supports / requires it, then it
seems valuable to me.

Regards,
Simon
