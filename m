Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4880C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8388584A3E;
	Thu,  2 Jul 2026 12:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KKzcfsTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0155E84A47; Thu,  2 Jul 2026 12:31:59 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110F484994
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698b899b4c8so230431a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988316; cv=none;
 d=google.com; s=arc-20260327;
 b=a95pHiyGNpot3qUtyvR68Pvaae8Gizb2z7lX25Lg76/6SyeaHz7td+LCRq27tGWY5b
 tah0NQ9SbpW9Rygn6rHNcJtZIUaaO9NP8Eh0sIR4Msefq+iwjUty8Wqpbvmb+7+NiShF
 Gc19YQKzkz0io/nSBllEwhkYo+o1TDAzKAuFDAADKTlrnW+zpgg5UKuLfqrHU9r9zeb/
 +jDu3eynrDAUpWB5RIjqrRW/tGF/XirBM4tTS5y/njxyggRIqxK7oZ1s99d01PsvBK3J
 3soNSV9gyaRDTy7EGNKE+aYHec4SIQXNecju8V88KuwlYm76E3CEdrTYaFLHK7NGXFqO
 VLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AGuNUYHqRuBqXu9aqIeKYWO5y5CDETu+Zc04BbMhUN4=;
 fh=pt2uM+ZKWrD3EHxOE2AfD00c+eqnHO3zOVp2+lroPqU=;
 b=fEO/nuxjcoJSg7kDRNxdITT1IqX8FeCzC/EaYUkIQTyFRC9F+lPauHQcj2UBvsajwm
 bilxX91nt19QH1+WWbBXae4TO1rwgk+K+VQ6Nr8JoTVMJgotkq8psAuZRVa5AC60kZL3
 WJdqZpYHrp9AxTzDLbhoRyh9oT9gZ9nTqGYhZKQoDac6CCAdNXIth8dqir9nXGKv3XlN
 bow7diNuKtiPHD+M3jTFsW7083KEUBlhy/XThFOPx+ECBdXCW8f2rtAC77LF3C4bYW6d
 0CCaQeIskFocau3xeEGR9yHonJWfo/AKPOrUpSbVvakWjKpTwG0mBEU52LzrX1C3zZ/f
 1Bsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988316; x=1783593116; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AGuNUYHqRuBqXu9aqIeKYWO5y5CDETu+Zc04BbMhUN4=;
 b=KKzcfsTACK3ddMKO+/OCVlgBTOYZIsMHLk8O6qOgqvJwagYyVWgrTbyWs4/bAM+X7N
 DQIe8BEJr3Y2sId+n9W5+Eib5eiEYhM3Mt8mHlQoXD8+PKnt69D9RpHpgllIxSsp5bNj
 kh6hWggLQGZBBm8dPh/0iB1nDAZ14MT+qZn+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988316; x=1783593116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGuNUYHqRuBqXu9aqIeKYWO5y5CDETu+Zc04BbMhUN4=;
 b=SsZDp+VfVvI6ex3qpI3eHzKV3vTVSVjtqbobq+af0YV8KWg6hSBeIHM26lueJOCB3h
 AkpRyf526nHR7PZJOqyyX4gyTQrkBSLSaPtcmaBn/z+VB0Rc1M5Fp5477BrhxynCHg0I
 aeh41wHVKzyHw/1FSxsmK4Z4DZBrufox0VOnxJuxJhpo7aEfMGuyaf6odt+/IQ9exsyq
 fIA1JG37+/A5DRoe4Vh99AkHOqGqiiz5U7DnqvSPX4M54C5J+h0uTTFmnwjCCp8S3zQB
 FvbkQEJJumzxakJ5ZWlQ0zc6hkzGYS4tVHrQW8Tq/R4alozs001kMSaN+DlMz4guZgqa
 PdJQ==
X-Gm-Message-State: AOJu0YwNRYKVBxy1AFPq9E8ccm9QAoD3WbQXmqLEVhImz4/XhLYj0CdY
 QNAnB+HA6OTniSCkTd9OItT1XuIHL9O3Djgt+QGtZZbr93bfZ9ubZYU+oooSqGkz5ZYuSpcO7/H
 sjFZMynC9xgf5sZSYgpA2TsHwwrP6FRdHReoAOxfo
X-Gm-Gg: AfdE7cl6V8uq6f5T8u4IMa5Mds+DGSasnx4DrekqupFO0LnYZgD+X9pJN1j+O/Tb+BP
 iYHJrRqfreTha+RvtPn6FmT9ok/msezVxgaGNrWqNtuVcR9SpO7iU7N+IE7HAFxkalIEh+3Vpbe
 KSva9ZmXl39ooAiuIryfmtPWGh3+LVIyX/4xcRwQfDCXD2Kq1mzm1fy4FKQlHeM4BVlOmdrwFM1
 sYqYrs66yIIRPaqINMw9mLvXh8YK7+hBgV3QBVUv+XarFr0Jh6rp2smCU5VLAcoE0vlpnweJA==
X-Received: by 2002:a05:6402:518d:b0:698:b8ad:2349 with SMTP id
 4fb4d7f45d1cf-698b8ad24ecmr342655a12.30.1782988316512; Thu, 02 Jul 2026
 03:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260702071425.9204-1-aristo.chen@canonical.com>
 <20260702071425.9204-4-aristo.chen@canonical.com>
In-Reply-To: <20260702071425.9204-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:31:40 +0100
X-Gm-Features: AVVi8CcSPMSZatKa_5tUQJ_7K7mM9YnNA3EbLh1B71jCGZWnSLa-H2QGAHZUoyY
Message-ID: <CAFLszTj_AfQtNSTB5fOgp99MDLRfQHNn8pfLSZ65DVuK7G1CrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: vbe: cover vbe_read_fit() external-data
 bounds checks
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
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

Hi Aristo,

On 2026-07-02T07:13:56, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: vbe: cover vbe_read_fit() external-data bounds checks
>
> vbe_read_fit() rejects FITs whose external-data window extends past the
> trusted firmware area on disk by returning -E2BIG. Add two sandbox unit
> tests that construct synthetic FITs with attacker-controlled
> data-position and data-size values, write them to mmc1, and assert
> vbe_read_fit() catches each one before issuing the follow-up
> blk_read().
>
> vbe_read_fit_oob_position uses a data-position past area_size, which
> trips the load_addr - addr > area_size clause. vbe_read_fit_oversize_data
> keeps data-position inside the area but picks a data-size that overruns
> area_size - (load_addr - addr), tripping the third clause.
>
> The new file follows the existing bootstd VBE test layout and writes
> the FIT at block 16, past the version and nvdata blocks already used by
> bootstd_setup_for_tests().
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/boot/Makefile       |   2 +-
>  test/boot/vbe_read_fit.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+), 1 deletion(-)

Thanks for doing the test!

> diff --git a/test/boot/vbe_read_fit.c b/test/boot/vbe_read_fit.c
> @@ -0,0 +1,225 @@
> +#include <blk.h>
> +#include <dm.h>
> +#include <image.h>
> +#include <mapmem.h>
> +#include <memalign.h>
> +#include <mmc.h>

Nothing here uses map_sysmem() or friends, so <mapmem.h> can go.

> diff --git a/test/boot/vbe_read_fit.c b/test/boot/vbe_read_fit.c
> @@ -0,0 +1,225 @@
> +/*
> + * The synthetic FIT is written to mmc1 starting at block TEST_FIT_BLK.
> + * bootstd_setup_for_tests() uses blocks 4 and 6 (see bootstd_common.h);
> + * block 16 leaves a comfortable gap.
> + */
> +#define TEST_FIT_BLK 16

Just to check, the two clauses that stay unreachable in sandbox
(load_addr < addr while TEXT_BASE is 0, and the FDT bound behind
!CONFIG_SANDBOX in vbe_read_fit()) - is that why only data-position
and data-size are exercised? A one-line note in the commit message
would help future readers.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
