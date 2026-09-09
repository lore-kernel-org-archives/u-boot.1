Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09859C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 07:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67F0480D74;
	Wed,  9 Sep 2026 07:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8Oze81bGgZ5; Wed,  9 Sep 2026 07:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 849A780BFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788940262;
	b=pUnnIn4eBiVPFHNd2MCIA6BSCwffBj/pVVoAnVH8dvDidHJoNOSMFoq1GmepRnK1g48A
	 11ph3Up938MR/xJhzJnA6rY+jCl+bp6HW5P+lqTwkkX/Ig8SpHQdimhZ6UspS0O3zMeQL
	 k79KvNr9Z2SJqfdik9xgiHgz3t+rX8sMrLbQ7EMorP6N+MnBxPLlV8w031fJ6vlXMOqLI
	 PniEoAD258D2olcO+f7KjtmlFqblBOQcebFw3KET/ga7LdAPGQhk7JqQ5iGVa9CsNvWr4
	 NcGQSOdLIZ3kTa+5vCm8oolF4R3bswgZ88NE4ln9b0s0WUzeSWahNbOvsrhxZMmidPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788940262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
	b=Z1JYHrkxmFWY90rjs2ZR9OcMooLd+7PCMW4dRea/AOFXM1yCygBC4eIh9ESgtH2aJD4I
	 llDhHIWJ/d5IqGFSQGhxFMzLZjRLsbcyrlzQgLWjEHYnRI0KicxBq0/xJoYPwNaNZzFn/
	 yo7A9xX07L6ISbtfGV5ljKY0GNvRQHYpCoBSWfZscFHYXUxv4z4B3qVAsMRdmouMsyrv4
	 IoICbagmTcvHjSYeSzZAFA+i3f/ct8zvkS5TXvWtJWPYWa7VL/7knoVD2m7Skw8xZaNYR
	 in55ogclkOyxJXc1E+fG0uGEkeJzhUuPMhFvzlRDSUHw2KsFY8/mzpN6MOlVrV7qm7g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788940262;
	bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XAA2FTLefXYJc88ezsXYwsRz0QRvu4J4L0UesBCyk7Lggn3KE1vvSXaUTjGs9oZiO
	 2i9aypDo/AaqPVAl4zBxLPNBQH/FAHZgI0KmWynf07+QTfWtOjtA21IpNA9Kx1ARdX
	 1p0wETwDWHxxdNtNXP0RVd4e5FIkXV5O5oF5IBhG6XsSih39ZREaC3YVpczwMPkIYJ
	 0Zkoz5JBYzJFMuNW1gUvedVUBLMTzmle/kGB4xeZgLiMs3lmL9dz1bYPWBem6zJQK0
	 vU7NcFz7lHrkplqsmAL+yuON+9jOXd3Wgy0krouVMmAY1AMLRBvRh04LycB0VijHqA
	 X9xkAgu8RVT0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 849A780BFB;
	Wed,  9 Sep 2026 07:51:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DFFE43AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C55D14057C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWsUTz71vLJK for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 07:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D7FDF4053D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788940261;
 b=niXXznzT6oA5iaSbXlBeYZFS6gdimlxz6cPVce+wsa+ksrZZ5ClhHQxN3Ckb/pF4h69C
 JQsoNkSEFL4++A9ZzBv0PnrXvN+aYAqGi/BsKSzd+CWlqyEkOFos7sayytYT8cIagX+Df
 RpPIFel1S20lAz8uURa5HmdFrvDoIX1gbeIEa/qg6Uin5nD8+TQVoqFIgNh2XoNpe0fha
 z05c3SrE5rgwCXHuSx1FqXqLI/lk+goj/poUgHASE6g0tYLgMF09axu16+R0Zq/td2GH/
 f/XSA8jfst4WLVOdAk5brfDrcpzx9+YdXq+nZwYwKRxo1Palke/VMky0BErH3D6Fv7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788940261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
 b=j+mik3mJ7e8+CplD1gRFN3Ill+JWTA2iQoPpvh3qHC/VbNcN5skbaNZwMmOC1EZQ0Rix
 ElB8h9F863W8WlRL1cdnWXtXpfn37VVPe28kyMczDDRA7kt/GmuxYuA+fjSVjfUlqj24F
 bpADenlRGQRWC0QtekBD9x0Ok+mlbe4L5TL+87O0E8ahtG6tCVakBFvDSlhKBfBoyMNhb
 s3hgJcEdML6Y9RMnIAzQGgoo6+VGbraM/giTVCNRGI+5/QvnojrMlKmWnB1WUyXjPKj74
 GLrdD54MzRWqzvTPuOAi6lfPTxynXcXp1VWgP3tRfBFiSq0ZeWpqgLJ6fWm/9omEFVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uRLU1OPi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uRLU1OPi
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7FDF4053D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:51:00 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d46e4cdccso7790087b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 00:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788940259; cv=none;
 d=google.com; s=arc-20260327;
 b=lojWkFqbfo/RFHOFOLTrrWq6SGUe3Ws364OqjOuV6QpWtovDoFMKLu3seqQT2cHGKy
 9+3KSpelgxTc+1GGSalCVkMnKxJ1m1+PG/q9M2K1RkzPTLJaieOQWGPqXnXX5ZUFqDqG
 ZZfFQ5SPke4lE1PRcIqL3QhVFHvbv7G2r/Bq51XSa6ffiepbDU2DsyREhCVIA4c8EHzq
 lsmpnefRP1Xu6RpCMY0uufmn4/s2xsnjckPTGNgS3WmMc/f+oPKoGUk2NZWdspesImlz
 Bq7dlxn6UwnzW+yGczsFCntBLW14QKzlPJr5iBinBRYyEborky7qenpCnjaLD1ynO/9L
 LrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
 fh=SgX3lzKXsL5uOHPUteg8m8HKJkb5mKF9KCqOub2vpgM=;
 b=OiaXv2QlfSXrgO70eodO1mNHVaCYygTLzPlx4wFESj+qKeyCHtEaTeiRluEaREVr+Q
 nLMOwYsR8JTcoX2+huPoTpODkAKWOGtPfB4265tJxMJcpEg2ByB0/FWHmqtLILb5GNWr
 oRpCxIWGlWAjTwrpKnb1qsDJHZf9WdTvcOY/wwJdgmFwW2fiFFte39WcU64e1YacA/lT
 RHPdA6rtLkydahAHnhwema1cjb0heH2escEOwSd8HIot+gD0AKy8NHLT5wN0RaLqRN2R
 sqwyGa5Ewrg/Xk2acFa7RIkJZYnia7+U+IgnEJl1gvOivavIpxuLo7AuRdHYqlLEoAub
 /xWA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788940259; x=1789545059;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
 b=uRLU1OPil1SfoWk0S2HSdlmJaB+r2dCLtTJScIySdq4SEjGWqIMNMg5VsdXCrqNJZu
 DYQOo2K2+rRAwi7nCf4fHVWp4TCAVLc8TTVih1fHi5jvdK6WJqWVxtdiE7aeb4Rsvdkf
 f2uncs2+gMT2uoNyZBYZcS/2OXX5GUZAbrdShhycBjS1GSGfZmg8YkQrnqmo+s2v3lKT
 owQDUykHqwD52X86qHOf8pp4pbyJcc36h4yKcgAo9TPtDPhXgwJYji1HxaNBHYocbYHR
 eOA6perYbgy7lLgrUEtIb4oxharyBsEclKL7r3tpySxqha/1FiPHoAWG6lH8j5pCn+23
 Nl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940259; x=1789545059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TXNQ/q1bPCJRnFR+N0xGPkEV7zebCzPrWjrIGvPrt20=;
 b=HXhnxAS4JORQaz2a7PRGv5bp0gLNzYuSDEGNWy3xgxLC9jCmPCYc5vF9zSSE8p7I2N
 iT8bRu4NzATgioWJCs7/rAr22w+1seK9tZpVuP8ZE1u+QyoZhN478bxFDDFFTgb0ZidI
 q4lwMy80WwBkNLtmamm5RdA4uOSEApzq4S05J5TwyNxiGrzrKQjbzalUyQGGqHgatKUj
 LR4PyJWXdi+KvjiYItA/dXqzpG++s8YkqA+77NuP9MQ9077x/CykQwqnUvpCmMyi76qh
 haa8g16xZSRdO8qdAwMlUIsopWK4RoipwxxFvM00wId7mtqipCwkQuLrYcwYm3eK2sRR
 Ycrg==
X-Gm-Message-State: AFuF++kJITOQjnT2FdhcJBiNEuNb2N8r+3jcjtOUzwLfYzLwrbjqXtd6
 uLryatxLEgXs4/CWSq2NQBEkyzoHLggO60uOsuhRyT/gLr6l51sCWIEwYWyW2wb/+r9Fm4fNnnb
 P9Id6UD1OodKwGxQgTk0upK7uPBsKzZ20q/hFykJeUQ==
X-Gm-Gg: AYBFou0kznDzWBrfrOy815kQQTP0TnzS+GmnkSeeACgGRjUzqcyRaxcCiiL141UUXbt
 epF4nPXkuioF0+yBvf3HNc4axGyU2Q9TFuLLGFkA/K7ruRvixj7Z7wKc48NBslYmxYXLvUXFrIe
 1/ILMtUgDRzYgjJOqTtvQuyGIU18PWTVWe68pPkSY8dlZTznXFskK/ZJ+r+OZYOFaXmMrxv5Fa5
 CQ5il/dV54yMWobFjbYB71h3X7bh+21dH744hWBXcbkZDKRmPEra0Ji5kii5ylO6pZUeqZTx//Y
 Aj1UYtFr60Yi//roKQMnd77JNAF69rkXPnwk4K0Rfm5yit/+5EyoCm+ButKzd8lDgyumbOqp4wv
 /7fh8YHANfkOg+EAZZJSEd15pI+PlT28ZXpfooHYvA+M1n9iw0f6U2KDlSTLvAPl4y3Tf1qhPa+
 25Uev70LnZLs33uCJZ+yPJ4+XpsvBug0Y6Er/OCMkvbgMAlUOZ/uYLM4j/krv/wpyKy79+PCwIY
 TIGuM0DJjvDxopthMWRMYt04X4VSmP69Igjd/zmTss6aPYy4mC57/Q8mTdw2PGdqHN5C+lmo5f7
 MwW0jxOOygMP1QWEqeDt2sFI33XhipdoldQx82v9pg+iAuPdeAZlld4P/BTiqbrthsLUdl8CQ/u
 6DKgqOWOT6INpS7UCJ4n3PBFmZeYJ/Wo4n/DpS4fVHc5TyK41YX2yEg==
X-Received: by 2002:a05:690c:9:b0:836:ec9b:b468 with SMTP id
 00721157ae682-87f2a0de993mr21735357b3.34.1788940258954; Wed, 09 Sep 2026
 00:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Sep 2026 10:50:23 +0300
X-Gm-Features: AcwNN1XR2EKzUXT7nOHxiuEmtdrVphTWe7SWbN-_Mx2M3-Zpr4ATz5Fi2xstbrs
Message-ID: <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jan

[...]

> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -27,6 +27,7 @@
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <div64.h>
> +#include <tee/optee.h>
>  #include "mmc_private.h"
>
>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>                                 mmc->cfg->name);
>         }
>
> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> +               optee_rpmb_available();

With this we'll end up calling the optee bind methods again for
discovered devices calling bind_service_list(). I haven't tested this
locally yet, but is there any chance this ends up binding the devices
that depend on an RPMB twice?

Thanks
/Ilias

> +
>         return err;
>  }
>
> --
> 2.47.3
>
