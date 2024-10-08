Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E041CEF174
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EDD88DA0;
	Tue,  8 Oct 2024 15:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qNOPI+Gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E901888ECC; Tue,  8 Oct 2024 15:44:31 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E278088E89
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9b72749bcso481913285a.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395069; x=1728999869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6BBNMmuuu8fT4zK60r4XyU9MxBn4os6R/MzYX4RWlg=;
 b=qNOPI+GsObnTlTxGc7xz/S4fmpD4uwmbKSQIxCxMEcm36YmlUvDHbUzf4WfeYTny8W
 ifNnM9apwU40vFRSmzqrqprKmSkwqxjKt5bRcCXtz0iu87HG4x5IGW+HWAk7bAuEcl6a
 B5p6MbioesjhlayxLFwnjKmkh36diHM1FNKkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395069; x=1728999869;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6BBNMmuuu8fT4zK60r4XyU9MxBn4os6R/MzYX4RWlg=;
 b=Y26fUGzK9rj25A4Hngdp9FLuvIcpjJvCIh9n6wbjacDwn45Y8gSYU7XkMUz+qwx/Qv
 Owzzekqkh+As0BdhzY7koe9INMFmyEYrfs4wAvktH5X91F+swlhKiPIs2eKIKxEPRD76
 Jznq33EH6naVhnEb1OXk1KYogD/bFJFAmwiLN9zslrixiu1BGUx3DT73G2feM+gcCIzb
 fn2Z+5ml72KnUIWgqph5a8NftmQFG4ny/nfBz12AHnttV5Hzta2HueymWNS3GNo8zbGF
 QQew+9aZRBF66qkeCoH0SgRusPyN/6wy1lrqmxR6Wehl//30+rBYRuSFnfPUa0fzwT9o
 Tlww==
X-Gm-Message-State: AOJu0YwKV9TXQp7hQs9UzNLfpZqv+T2DAZpEgkwlmT+nnhWok1pvzj8V
 qrPi2JE6GK9x9Xh7eZ6wfJMMfOQCwdkkcUfoLmfreFex8z3k0QTfgnE2pRUNuaIJ0T/iDYttggf
 uABc=
X-Google-Smtp-Source: AGHT+IFhkY7b/ge+rb3fbnV9iEL79ib++28H0UVQN7C0Mu2ijh8x/lYU/u5tM+pQxRPzQ+JZ+G3uhA==
X-Received: by 2002:a05:620a:29c9:b0:7a6:7793:b6d2 with SMTP id
 af79cd13be357-7ae6f494096mr2747929685a.65.1728395068735; 
 Tue, 08 Oct 2024 06:44:28 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Matthias Pritschet <matthias@pritschet.eu>
Cc: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
In-Reply-To: <20240827160054.26819-1-matthias@pritschet.eu>
References: <20240827160054.26819-1-matthias@pritschet.eu>
Subject: Re: [PATCH] mkimage: ecdsa: add signature/key nodes to dtb if missing
Message-Id: <172839506774.112860.7650488967314784162.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 27 Aug 2024 18:00:54 +0200, Matthias Pritschet wrote:

> If the signature/key node(s) are not yet present in the U-Boot device
> tree, ecdsa_add_verify_data simply fails if it can't find the nodes.
> This behaviour differs from rsa_add_verify_data, wich does add the missing
> nodes and proceeds in that case.
> 
> This change is mainly copy&paste from rsa_add_verify_data to add the
> same behaviour to ecdsa_add_verify_data.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


