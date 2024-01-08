Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C6CC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972EA87AAD;
	Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DNd9RBOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6868387A4E; Mon,  8 Jan 2024 01:16:38 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD2287A97
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-680b1956ca4so13694376d6.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672986; x=1705277786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgf1RzVTqfvjKgVp/XBjMRMSEQm4p1MSriitKb3VVvQ=;
 b=DNd9RBObf7Jq/3rSrJmyYpbV4QyVhdcNIKlAenO9qr0a2pU+ATgMV9ZCFlpt/zRTKY
 yqLrxCRaLVerrHCajnnyWcrmoZdCnG+el/cLqknQ6ciC825HSvq4hznoPQwNGErr40ze
 0CIUTXO22nK4gFCGRCGuf3SN0Ljg/t946JoNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672986; x=1705277786;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgf1RzVTqfvjKgVp/XBjMRMSEQm4p1MSriitKb3VVvQ=;
 b=MafILUC6xs5adJ8Ir+S9RiIcgcnaxPNbomn3BHhcN7RPsGJZmSxBs8NqGjV0SUdOVw
 fWVQbmpgGqt4lDjN1oeKsvtOORDHTbYbBQIeasaqXbEu+gGgXN3WqWKyR2cRD6CvjOIA
 ZQidWz6bRuPbcR4n0WAoRzhuAIsi91QhO52ylgXQ+orGagVZRCu471JBkROej0bK8VXG
 EIt0YnPn/zcSPupPt5PITxCXHvM48Pb+LxU0H1NFZ27nxdZsoirl5U12PJyxXR8fdoPJ
 PdasJj2SYGuUARmxkR/OIsG6IBW6DyFf3KIjyhfNA907OrPXaQar3aaKy28qXQBvHOOI
 4myw==
X-Gm-Message-State: AOJu0Yymf+D007t+OfbJwhBCAnvAjNOcJhdcQ6W0LembttQXHuUv82tW
 nkJtjlQNjAg/RhcZJxJulVvPUvan0COrtB6tJkNxAD7R+Gm4
X-Google-Smtp-Source: AGHT+IEQHiWMUwVkmZqh3GTmAgGoqzeEshjwwW2d9SNLwNA+e+byQxceEt2fPsOU/H29sdOt82UKwAfwWG7gIAvJzHw=
X-Received: by 2002:a05:6214:cc9:b0:680:d151:229 with SMTP id
 9-20020a0562140cc900b00680d1510229mr4490385qvx.104.1704672986729; Sun, 07 Jan
 2024 16:16:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:26 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219150408.10949-7-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-7-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:26 -0600
X-Google-Sender-Auth: X22pzeOPezlZ32M7TlMW_zD4Y3s
Message-ID: <CAFLszThvGZfm06Z_X=FV3nN5xZYOb0RzNVPDitDN+tM=Jp_3Tw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] riscv: add support for QEMU firmware tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Enable the QEMU firmware interface if ACPI tables are to be supported on
the QEMU platform.

Enable the QFW MMIO interface if the QEMU firmware interface is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v4:
	no change
v3:
	no change
v2:
	no change
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

Applied to u-boot-dm/next, thanks!
