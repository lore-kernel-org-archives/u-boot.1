Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BA1D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C442890E7;
	Fri, 18 Oct 2024 01:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k+aa29hC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB2989065; Fri, 18 Oct 2024 01:11:36 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340E28909E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so9653446d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206693; x=1729811493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0y7iv/56Qse52pXaKKggzn9XeJkj7o69ABN5JAcgvKI=;
 b=k+aa29hCnUmMU74A7paf9HQhTw8BzfSbH7wHraepzz2DJ8O+pcoS1tUDmy46fpoLxQ
 rdFMh2e0ZG70l6fLobEhcAVwqxHzpwpANYu+ixlG4wG67oQUyvvKSJtk82d+2GKLuNTe
 Oj1HepypCR0pbamtL9B0yuqci1WW/VM0jXC+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206693; x=1729811493;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0y7iv/56Qse52pXaKKggzn9XeJkj7o69ABN5JAcgvKI=;
 b=WeeLw9CLbix/QnQLIS/qaYMus+263EDtQ1aJB3KBrMtKO+GlIDPGqAw3dDU7321+AS
 xL60HvcIylcajPPflzJWj9aWS4QeStUl9eoJWrQvQDcM7npSLdunuhbCy6uMN6ZRpT85
 vd2eG8z8s25yTI1F69njR69ar8+rtMxF5K2PeNLP+wTGmTXVGTg5nKS/cijpcumQRBB6
 lmaWailxGi/ZW/J//R1tBxY8nSyKfkkwrJtxLbja8na0cmcRS7B3/3Av9MT2lxBld+C1
 MZD12fAfOtceW5lZejC779WqgBOAliRilb4neeWo55BZNz+PmhIsw2NU7RiGNp8skmZi
 Z4zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4MN5PbQtuqYjSv7Z1MZtAFC6uqkyUSuISFnEQksJj3CaxNvt4zskj4WfdC+ZlzWBx4U8qMtg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+uSRpwHr+pvlS7ey4efQbtTtIBeo9+e0WQj/xGZep3otXMtlw
 TdK8ZEGhilUwjl2hLdHDh2qILweNtbqyFzXdAlyT8MFq+Ltme8z8CkuXWRTH5YM09WNaqegnnz2
 NcSCCED2i8Yk53rknAY1eGYKLF1DvYFtLIXimgeSd2RUnJjU=
X-Google-Smtp-Source: AGHT+IEX/Hn7LTVZmrRwQ9n/V73SAHPK8zq3FqhNfrlm23wgv6S4NXlAaRvyzXr6lZUOU+K7HiTClvhUkEju0S3qYgw=
X-Received: by 2002:a05:6214:3203:b0:6cb:e90c:7c72 with SMTP id
 6a1803df08f44-6cde14d74b3mr7671016d6.21.1729206693094; Thu, 17 Oct 2024
 16:11:33 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:32 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-12-sjg@chromium.org>
References: <20241014223212.2212442-12-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:32 -0700
X-Google-Sender-Auth: d2QsCzLV4BUoY6OvlBdfQ-78_zQ
Message-ID: <CAFLszThpvX_gScW9UAKApY_cZTNzsM=zL4PrbEFK7m+cnY7P8Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] expo: Add forward declaration for udevice to
 cedit
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Some files may include this header file without first including dm.h
so add a forward declaration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/cedit.h | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
