Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A3FF887E
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 00:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D9C8493F;
	Thu, 30 Apr 2026 02:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hv81nFtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6015284942; Thu, 30 Apr 2026 02:02:46 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7214C84936
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 02:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6720c7968e4so702527a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507363; cv=none;
 d=google.com; s=arc-20240605;
 b=RfSIoIReOzvOa3ejk2O0pI7zRG7czay9A4wyzOg3AnjQlUVdNge3vB0THUeLrU+RVi
 Ua6eJAjziovlEzfoYB3j3tSKyDRvwOUsZJIjIXt2wpglK3DNsd2bsHOCe+O7Gh8485Ci
 wvinYzwOfUtfOd55Uekb3foWTfJGt9qilEKyn9TdGxF91GTaEBHH9DSkOGCMB3LPKBNe
 nL7DSk8Z2oSloqF91AuFUNPST6fn6HqOT4/oiIzpDVZn5Q083szQPsGwO3NCScD6OfPS
 jzns3tnWslQznlURO8SLknCEhDh6yQh1bimfgypjBi6mk1aK+9vSaZM7kVu+2emuoSnG
 qQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cane7yuaFfxmoA72d/LcQwZMLfyk3tC3nPzvNP2P3L0=;
 fh=pP/Ie95w8nJZLbC+xDsByMDxNdw3oub9m+xBA2tN5ek=;
 b=ShSXTUJV807tHjCXbnJ91MxepUjjAQzj0ctKMRhoQxNRa9uZTj9N51wiCSgW2KdPie
 p1PwSpqOJBIp6YBL3rKL7SgKrMotEn1dMxOOprEf7pCkrsGlATu8oAnbqfy59v2qBQeF
 QzJBOLkqQML6CVdRatpADM7l2MreywifHyAkRhnOTSSTy/xWgY+jZMG55rOnGHsXvZpB
 9ClvL0c5vu9MayG6ZrcyNlw1t7nmcKLONkNWkIEFm6XFQdZJWU/Xy38c5wW1bRsm/02e
 kSEEPLIEX7jodfSOSMAE0pR5MhRvl04b6ngPUg4E78tf40hjUSeljasJZrEOmqBPd0I7
 6G8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777507363; x=1778112163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cane7yuaFfxmoA72d/LcQwZMLfyk3tC3nPzvNP2P3L0=;
 b=Hv81nFtl+SM+47RcxXiK0XKHGCGN4oH/SH39z2TrM+zBJWloVZQJ8KcnIXXPfN98jy
 7H9Jw+fiWSydDJvFSA31Z3WxSSnD/ylZvUetQNZt5qObzV59oP9zfIWbNQwUgRLer/90
 BqRNyKUUYh2Pfb9wdgLUExWkeZwlPdrvcksD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507363; x=1778112163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cane7yuaFfxmoA72d/LcQwZMLfyk3tC3nPzvNP2P3L0=;
 b=aROFDpRGMyO3zvmk3lgbVtW32owCfiwy80QLuqPKHSF6O5TxIZKhu5ZPjqBpDiUpwa
 DtiZPfe5MhUWv2Cl8jQvTwkWJDv3ASF0BdY+snbU2+r8HN8kWhHEfuFXkS9EQ/kRx71a
 cxa0tfKZbii5lwG+h52+64e+TTUD9PXu9N7++L15JqAVy8nvn8925B4CMH4IE4wcJkDO
 zJxXMzxY8YZSTuzCBCjNGfhPuU0dSO22v9gjpyQq6Hm+mHH2fs0McrKZEk3l2tRP7qtz
 +CQjeA8TstLmcFusv4cOdrJetcsUjuUzHM0yE3vdaRbkLFmWHFSxLIZQHIB9k5nh3dMI
 kSEw==
X-Gm-Message-State: AOJu0YwWeUs23+7l1l56+G5oFtZQIRLjUQBL42W7Fo9r7mV87b2feaeX
 x/VjKa/GHBTyk+zL4kCSGwxew4mg2X+gi9Fr/l2Mvw43bhFcolRi9o7XiAgilNE4YIXtBWorqh0
 idD1MNOV2t/q7kcL7RGWXWcz064dWCfI/UvTIUQNI
X-Gm-Gg: AeBDiethiZPX4pPCZ0+DOsRWlquE6vyscAzKrHxhr7H4Gjjm9t0oYyHmF9Ng1F+td9I
 T+M2PLQRVzrX/DmVKjG6uj7oUi4TkXQQLGdSbm+Evi1yFX/frtLVoUvC60C9w8xSkdvtfkvg/uW
 KDoaM55+pRB5A9lMKr5uHsxC2OFYPsKCUKU781hqF7/lBZS9DubmX/0gK1JVXIywUSvvCq2hiMe
 vfT1e0alG4r1xT2Jcf6mj26W71BzI0MEyhK/uCKMA2yLOezkrlpyc1cpBSrxa/FXq3RMqnc00J6
 kCSyT1ltXkl2rDfq
X-Received: by 2002:a17:907:704:b0:ba3:961e:d5e4 with SMTP id
 a640c23a62f3a-bbb96fadc25mr9093666b.1.1777507363457; Wed, 29 Apr 2026
 17:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 18:02:32 -0600
X-Gm-Features: AVHnY4LVlBEW3JoqR54a2oFsr5mcGsLm7QRKQTyCNwRLuv6BQ988WxgCiFKGses
Message-ID: <CAFLszTiwtioRRMCNEWTJLAQX=L2pXwoMjY7n1TcHn8YsrpHZyQ@mail.gmail.com>
Subject: Re: [v4,00/11] Add support to boot TI K3 HSM M4 core
To: b-padhi@ti.com
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:

> This series adds support to boot HSM M4 core from R5 SPL stage.

Could we have something in doc/ for this series?

Regards,
Simon
