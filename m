Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA2CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864CC86ED6;
	Thu, 12 Oct 2023 05:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m7sSOF/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BDB86E5B; Thu, 12 Oct 2023 05:44:34 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD11E86E5A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7ac4c3666so6821227b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGtdEQiES+cCDUh33Cf5pnQMDlQ0kkiMsjk2w9FHmdM=;
 b=m7sSOF/ka1SHB6WFDFaR+gbJds0JNguXhO+uCuGpiRIHE+DdyJ7zxgM9wZFxAzDQs5
 S6f/VCzVnxQYt1G+q1+/gREaLVAyron6WH9zTCjT96l5dhbzB/rEQSNuUwYkRbHggfy0
 sqhzZdcVrf6/5rVIXzL/9LjFqupOesVrW5K6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGtdEQiES+cCDUh33Cf5pnQMDlQ0kkiMsjk2w9FHmdM=;
 b=r48Tm0S3Xqw+sEeNsLe6lFz0jTNseF6MeRfFJ8fmLzPOW/POmvkc+oENR2HEnc2Wp9
 MJxIEcz2+niQeV13P++caZDSd9O4+Zpm1Pa1B9hpdhxBRC7x4Eitb77ceJoo17zHoCQX
 kUp3UDgEp8IFwaC01yVd9pW8E7W7HqWtKf2g9wTVHHu+CyXZtQtGA4AIvT7GVJE9NbbY
 nlCzdGxK9Jakp7TOGB1X7CyRLfxa7D4yd2+cqv7N47+flxlNeBxDeoSzIA5+r6NLkfTm
 UiX7fmQh8E6wsUxEN4n9kMFMkmAdoaZINh1isjaPVvTxSF5dvqW9HOwCYlHQazTA6qM5
 ApvQ==
X-Gm-Message-State: AOJu0YwBoejQHp14zEE1Qx5vWMRXlUDHAZOVwt3ImB7/K1wAdMkWlm7B
 8msJLjpPLZZeir6QBdZvnOUkCx/cDRhmmd6qTDVCkDaOLPVcLvdhvrs=
X-Google-Smtp-Source: AGHT+IE147tRBabLwIN4ro9EA3MOGYluCvIKlIgHN5zMQ+EHL9/8567ZK8kjCm/rtZ4aMs8OlheNx4FvETzw6q1dHgE=
X-Received: by 2002:a0d:ca4f:0:b0:5a7:bcac:7d3 with SMTP id
 m76-20020a0dca4f000000b005a7bcac07d3mr8848580ywd.9.1697082263668; Wed, 11 Oct
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-4-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-4-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:34 -0700
Message-ID: <CAPnjgZ3px+_fWaiU+vXgSZD6pgSmiW-GMuXVXvKBVmfpjTsbWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] cmd: kconfig: Make ufs prompt look similar to
 other commands
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> At present the 'ufs' command prompt does not look similar like other
> commands. Update it.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
