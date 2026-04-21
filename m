Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA9EF94CB4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910578419C;
	Wed, 22 Apr 2026 00:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RA4L02l3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B82839D5; Wed, 22 Apr 2026 00:44:01 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6FC8412A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso455243166b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811439; cv=none;
 d=google.com; s=arc-20240605;
 b=ZW83ZxzItsz3kFuu6V6AZViRz2H/VTLoDqnjQflJ3jsVekOl4xC2MEkpk4xMYDu1w6
 rRkhp4szgBAxUGGa2g1nEa3jB3pjQWuwehWl6w2He86okazeREhG4QtrCGIvd+A3q8Ns
 hLgBujbmnR7ghpQza6W+k/iCxkFbgw8SwEeXgzA1Ldsw73VWS4GQ7rCzYbEk4tCB1QtT
 94jLqgqLF9uIm40AozbFOfLmq8gfjui3nNOv6PvR7KpKGUUZTUFtC8y8C/D01t2abHtH
 V+WanO3AqbE3YIpK4qembtIV0ksRpcJIsOBJWkKSQs+l1ufYC23Z+U1l79GsJ05MfbmZ
 slUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nwFNxx9uEXodtfTsT+GBDPeCIXnlSV+ASqTS74qopDQ=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=hhBcIz59t5jXnYQnQ7jgcm/w90BX0N+vHEFvT1c8Y9bpCeRfaQCQCVFB1lYfdUFKwk
 5F2oUR4XVeBCWSLL6uDMOCdnNtGZMqU3giw+gcND8qJJH5PffELQ0Cjm1TGYVNRXvUJa
 25i+Cex2Sc8v2cnSp1nJB9MavVY5NngJMfcQxnQRJlHRfD+nNqaKMVVdL0GfUNrqDdaH
 /mJYWFSl7b9U5JujoYg7JgrlVTaLWkC/o/AZcKgw07cuhrXGYs0y37+CuCHK3bKFkrK+
 fCGf/L7ho5j9vikxO/QniDvTacRUlC8cM86Knp+OocuCYEKdjJFdrSdSGbGKYFVg2Lke
 SJzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811439; x=1777416239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nwFNxx9uEXodtfTsT+GBDPeCIXnlSV+ASqTS74qopDQ=;
 b=RA4L02l3f1rlf+XZbNW7L7L0lpVPxhxVPYmLRn0F+rQIUaHS5L8Av0nLbOEF2mtuQC
 p1CdMgUTYaCmNotIFwmZguTmS1yJbbU9L9+GhvWHFjZvWoSM9kDnWUd+i7rfxhsd8HME
 f9dw474H0xZMwM1K+EZu+AR7KYZyWuEPQK1d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811439; x=1777416239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwFNxx9uEXodtfTsT+GBDPeCIXnlSV+ASqTS74qopDQ=;
 b=tCQzBZzyeCL8nIlv/wi3dWMFyl6Jzoj3VGaDgyRIBYPTtN/2rGCCn9dUG3QPrx9arh
 lFk1j6dGtHbxemgBjXwP4ZiqklANI5I6igdP28ijxdgaPp7RWp828Obp3Yp6TGsmvbL3
 4UqMbR5DA7l48/6Q2708TUQlP1TUn/X/Vm4JzBVSInhT6If/EBENStH2d7B9XD3kcqmo
 GXIViyDc4MFujTnc0HGBVou6u0fp3FVfR0AqiOhwt0ZT/1AG8vDC5eJcmMpKWJ+Oy8nh
 8NswpI252FsgEcnpaD6u637vFzQoktiQXNbMsxK1M8NtPI2HJe6z7yESt9p7wlyndnso
 hLzw==
X-Gm-Message-State: AOJu0YwFCI1zLpxbwNdf0Ir6t0zfd4dnVS16UiTOXH0/Ph7DB5hfCcyl
 afqK8G04a1kIutTVtaNJpJHH9/JTq+gt3DJ60DXKeycpfhfWC8FYoeNZfmWIQA3zKqv8r9ULUgZ
 2CNq5KGJxCdK3tGV5anItKpX2aziqCibekVVVQC2wzOW7t4m+06n16g==
X-Gm-Gg: AeBDieuVN1CirAercV+zDYl4Fuy0z/AcwKuBkrQLfZcyUOxcGif7jB9q2NjIntFpAya
 wNSvdQEN+GZVr4Q5cts1gTYSJG3MIP/mDoReUWfPQASilx8KjwnrA1DOxVnlRbsMQDmlt+rvSCG
 SRHzxm5D5fg3qMXuQK0GjfQaVDgYgYQq/p8vOOqbSgFlh+xOUHrwGkHHYtauhSvFPy27BG+yPyQ
 gmVpe94Wgfv8Rqiw/Ft68J63mBbDlodmg9Ouuvx8fLJcGIWdkCSZXxAYHKCFPrdScJmIyybe4DZ
 lDNudROqZHL9Tpkd3NMX
X-Received: by 2002:a17:907:a603:b0:b9c:b682:83bd with SMTP id
 a640c23a62f3a-ba4190776f9mr976972866b.4.1776811438770; Tue, 21 Apr 2026
 15:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <20246b1a8a8389aedab32b017c21b35b3fd1ca10.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <20246b1a8a8389aedab32b017c21b35b3fd1ca10.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:43:43 +1200
X-Gm-Features: AQROBzDwz6fN64ccUAP2TYbtmcFGQ5KEeW7B1DVAi52AgW1s5dKbcomxH_MV-QE
Message-ID: <CAFLszTiAHq9n6u0ZvCSO9Z2KS6kwHND_xRUbnfJor2=TtwHFmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] cmd: ubi: use void * for buf parameter in
 ubi_volume_read
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: use void * for buf parameter in ubi_volume_read
>
> Use void * to avoid explicit type casting as what ubi_volume_write has done
> already.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c           | 4 ++--
>  env/ubi.c           | 4 ++--
>  include/ubi_uboot.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
