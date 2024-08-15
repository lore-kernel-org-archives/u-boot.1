Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7DC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0DD88B63;
	Thu, 15 Aug 2024 22:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aeaDYqO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F87288C2F; Thu, 15 Aug 2024 22:33:19 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F2388C14
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d80752933bso929998eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753988; x=1724358788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVzFPxQAKWo2UvyvYaHkH6FCmCTjx7gCC+526N72SbA=;
 b=aeaDYqO+llWR6nUKI4/7LEhRJVnOBWLNNAezz6ymNGoXuRDlM0OoIIlUQRleUiZYi3
 f12HlCbZ88Qmk47TrCPKZ39adsANqSP8orShBiCg0YJJLZWFQmxaJPqyVgu24+mpYWgi
 7smB870Xjl/piMchTn9h/ejK3FqergXxk9MhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753988; x=1724358788;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVzFPxQAKWo2UvyvYaHkH6FCmCTjx7gCC+526N72SbA=;
 b=TJdxpb67fT4k3HpM2TDdXaRp9M+Uo8AGPOnb6jjZb/4QjWBwKvZ7974haFy/BMNwMs
 du2yZ+p+EPg7xN1wUfvVhPGSYtgiILVfO4SEEEQvlpwo67IV9mTgJsuwnljl7XeBfaMb
 WwpHxZ3SZeEWQckrQHx+x0zqCsEtyH1zZJHP87eSvYDpAVwwxIsObjeLQ3Adfe2as310
 MhTA9GS2n4i791EEqafYsU2Q2sEwgAuzycCun/E0NeveP154H1EalTIpBTHOGvijAmGV
 eNNgQfrPtqgB76vptj9A8VcTbHtH+Q0cJTaGwQNDLNmXWhWiFyxIbzNVDxk2mTfsVfqT
 n0yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBOF0Ogzoz6aMjk6HNsq/j0YO1EfOrTU5udwuni8/ZOl+OcHzk4jlOzgcDlqO+0rnYj75kulikcctb5QT4HETJ5cyTPA==
X-Gm-Message-State: AOJu0Yxu8RQyMM5ZLZgpxQepxuxqLB+DXAsoA/85G7SIr4YC2nSYqrLN
 0RvBJvA/a6+VHfrdamnkcMI+ehO+WKfuR5ZnrKaHNIwIwNCsdYiZQiprvv2BAZk=
X-Google-Smtp-Source: AGHT+IErWVtBD0YmOzZcYorXYFcubwgfLdfHrqyR8uewB9g4mgG8tl3WUi/7ZecZd39BGgh/7h7uVQ==
X-Received: by 2002:a05:6820:168a:b0:5c6:9320:53a3 with SMTP id
 006d021491bc7-5da9800e818mr1200195eaf.4.1723753987830; 
 Thu, 15 Aug 2024 13:33:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Ravi Minnikanti <rminnikanti@marvell.com>
Cc: quentin.schulz@bootlin.com, U-Boot-Denx <u-boot@lists.denx.de>
In-Reply-To: <f1a2067c-942c-7e2d-ab28-7906a904a58e@marvell.com>
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
 <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
 <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
 <CAFLszTgN3AqhPzT+Zpe=sfM_cOZOmOQPseG_ipwMcNYzLbGUdQ@mail.gmail.com>
 <f1a2067c-942c-7e2d-ab28-7906a904a58e@marvell.com>
Subject: Re: [PATCH v3] env: remove vars that are not in default env
Message-Id: <172375398705.3490037.76855518389056723.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:07 -0600
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

On Sun, 11 Aug 2024 11:44:15 -0700, Ravi Minnikanti wrote:

> current env_set_default_vars() doesn't delete
> var that are not in the imported env. hashtable
> removes vars that are not in the imported
> env but present in the current env only if H_NOCLEAR
> flag is not set.
> 
> This change is to avoid passing H_NOCLEAR flag if
> specific vars are passed to env_set_default_vars()
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


