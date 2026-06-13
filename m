Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F3CD98D2
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 09:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BAD8056B;
	Sat, 13 Jun 2026 11:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NOhmvRi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107638063E; Sat, 13 Jun 2026 11:05:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C2780287
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so18350905e9.3
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1781341497; x=1781946297;
 darn=lists.denx.de; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E2d0rtNabevJNy/L8xyCGbhuFfavIcGUUKpnATvpaM=;
 b=NOhmvRi4k//BQciLHxtV/hOtKoFFRCV5YB90VtgY5lqF4uGbb8VUPYOvni1Slsr3eW
 XXPgDX20mVzr04RR9E53/GE55qmg2HM0LrhcK8Q4STbH+yKL5es9zDJMgKbbJ/Lq1rBy
 2Qms0Cn8F9r6RcqoKQKVtuBEBkdIjDmN+yjyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781341497; x=1781946297;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4E2d0rtNabevJNy/L8xyCGbhuFfavIcGUUKpnATvpaM=;
 b=goGVZYNcfIQrLY73XUxs3/Wt581/RMK25XtwV1MfmE4G4zGaWf3Zol9mDxXoag1nw5
 JEksVwJyls+62qyqjynYOPLo2iT0yfRo4STfFLKMhOaFvgbc4yn7Pcla4OZ5Q4Wfj3G1
 UsJAS/GTZvW7+bueZq5bKdsjbT4RcQbacwN4XxE4HAqPbGD3FUAXd8fHC7O7qQK3P55k
 QoDy5KUxvY4KQEz6uw2ZK44BbO38vUDbpC2Zaf41ocexft1SdKyeqbFuxV2eMHabf1QR
 27YrYcZIdwbjoKgCx1yJlWEyB7mwp7PSBFHK9U8jPB8SBhp56jZET5Hlb2d4JrphnIgz
 EKEA==
X-Gm-Message-State: AOJu0YxZlzJSVIVMAiqrFoT0iBqX7Q5r1kFbBWbvifHdVSlIrLTpMuyu
 xpCd0ebxkGyXV90x5lbwLuGY0lyWtb0u5D4ihxAXytYOnvjp/oJ/aLtDk6RNZunrUSA=
X-Gm-Gg: Acq92OFVxH+pOEHGtWTNrid4qbZbVV84vN1tA6F3DpUBt2OheyhZ1IYHC7kuN68/v7Z
 SxLirpLaTvUsypw/ovgQPgQxjVUrE8aJD2yVm016BqsetkS8iKfV6HbTgklC5kwpd2HyzomRfRB
 mP0F5lZoWvhzB1C4OKrWAndDsLoYF48uBIiv8XG1m0kQ3WU66WZtgf4n84HMA/Nl8BSYuupQJO7
 7M1l/09fGRkWE5ojB3ASfgnd4TuiLosmARZJTP3AUyIv3yPz5x+7W9nSfG/UYVYsz5lZ9ANQO6+
 nK77mqsP6Lhz0wrvuReAnSkyd8LIyrR1wtOdNnBV1gxD+IjvoLF/aZ1veMHroecsaKvrAZeYpHG
 Q7PLdfZ/+QkpGT+y1b0rjbcdurY088iBmVUILhT3g8oXOR5xWlhPDpGTbatColWI4qU310r3BIy
 4d4biQrYElwQHGWAf/0a5axkdqxIFwwZiasxDvqk85pxpesaUptYbfxS9cNRc+caQ=
X-Received: by 2002:a05:600c:8b5b:b0:490:acb8:1490 with SMTP id
 5b1f17b1804b1-490ec4a16e2mr76332485e9.4.1781341496637; 
 Sat, 13 Jun 2026 02:04:56 -0700 (PDT)
Received: from [127.0.1.1] ([2.197.55.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220308f13sm59448825e9.5.2026.06.13.02.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 02:04:56 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] env: mtd: fix unbalanced put_mtd_device()
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20260611083517.128739-1-weijie.gao@mediatek.com>
References: <20260611083517.128739-1-weijie.gao@mediatek.com>
Date: Sat, 13 Jun 2026 11:04:51 +0200
Message-Id: <178134149182.1469678.15896493557885395991.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781341495; l=1426;
 i=michael@amarulasolutions.com; s=20260613; h=from:subject:message-id;
 bh=GsgBK9KyRyvCtcU4ciN0+1/rsNlmIuG0luJx/ValVGc=;
 b=oA/qfxNdP9pnN4g8+4Rk5SrstdcJhSAdxB7hvyP7QAai7M7sNK0VqZNVaFtHywNWiKU8OUeBl
 yrzIIUkrTHsB19VdNVbinEhHuVP0SgRl8NlPNgZV9YE/bbMd4HjkCqA
X-Developer-Key: i=michael@amarulasolutions.com; a=ed25519;
 pk=7OplP/jFCxnfQ3Se/pirM0VGJgS3l3lERzGtWVq8vc0=
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

# Add your code comments below. There is no need to trim or delete
# any existing content -- just insert your comments under the relevant
# lines of code. Lines starting with "> " are quoted diff context and
# lines starting with "| " are comments from other reviewers.
# The final email will be reformatted automatically to include only
# the sections that have your comments.
#
> In env_mtd_load(), put_mtd_device(mtd_env) should only be called after
> setup_mtd_device(&mtd_env) returned success. Failing to do so will trigger
> BUG_ON(mtd->usecount < 0) crash in __put_mtd_device().
> 
> Adding an early error out path for setup_mtd_device() to skip
> put_mtd_device() will solve this issue.
> 
> Fixes: 39ae954b04ef ("env: mtd: add the missing put_mtd_device()")
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> diff --git a/env/mtd.c b/env/mtd.c
> index b26ee80985a..67d207272d8 100644
> --- a/env/mtd.c
> +++ b/env/mtd.c
> @@ -157,7 +157,7 @@ static int env_mtd_load(void)
>  
>  	ret = setup_mtd_device(&mtd_env);
>  	if (ret)
> -		goto out;
> +		goto early_out;
>  
>  	sect_size = mtd_env->erasesize;
>  
> @@ -192,6 +192,7 @@ static int env_mtd_load(void)
>  out:
>  	put_mtd_device(mtd_env);
>  
> +early_out:
>  	free(buf);
>  
>  	return ret;

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

-- 
Michael Trimarchi <michael@amarulasolutions.com>
