Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799E5EDF158
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 12:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421AC83AA9;
	Fri, 13 Feb 2026 13:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xxPFcwtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF5A83AAB; Fri, 13 Feb 2026 13:41:01 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2AE83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 13:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48069a48629so7922385e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770986457; x=1771591257; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjXJLF1tfhz1YeoOncZ1oKCoSDf09BIqcEOW/7C/Rss=;
 b=xxPFcwtN63UaVo/CNiCfzOQEYVIlHP3KzsNsYLhnJPKM3SFm/sLi6h+GWKRVncxEub
 9g4nudhqSXzo8sVesVt17OJ/CKWm1+CRSat4bJcf1Gf6cd5bK4akuXJkajQZIO+oGoWG
 M8Thg0Ca7WDSNthzIHcec+drxDudbwgKjiUeRtLN/dkUH8+B3ZU2zJ30w1+8wnRhbsBE
 qSuolRVCTo9rrb6bcLtXSJNAR85L5A/EwIkcncUe5F4dVHWIyuo4G3FRmEoPrAg0A/Xc
 lBPpKC+zNzTDiXIvMRQqIXC9UwgNjRz+nvstq9DK3RZPuHUd/SaZbWia5GEnKHboSMXp
 xzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770986457; x=1771591257;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GjXJLF1tfhz1YeoOncZ1oKCoSDf09BIqcEOW/7C/Rss=;
 b=BBuMeF4Ltt9OfcKupzOWeYr8N8c/QWBllkE2he4Nd6Fl/mv00FIMGUhop6Cg0Ltl8L
 Py4elwUETXSlb4XHz8v6qIyG1zUbCBayOIfaALXDHUx1tgHTGH5fni73YqWsVToh5r37
 Wg+kDdZCDzQYW8o/LPZ9CnPWn8l2eElz7nYFUyei9K+c73LAV45dYkaAwdd8EgY8+D2d
 OOoFUoUeEQkjZ5HhL0ywtLDePLRk94kdt0W88qpjF8lKaDOo4zSo0Sa614V+kZ8oWl+/
 cQEYPdJL2xkQvC9W/975ST3sj0GEg3PxBu+AHE7uJ4+3eKbRf7+bZRfvYSLmrrrv0vMK
 GYhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/sEJ4sid41XmBlXnr0zlW9i6O1BZRU5NjHT7ScjEx0zpy7LqhjfCzIVP7r5SEnr7S9qpE8uo=@lists.denx.de
X-Gm-Message-State: AOJu0YzbRWlu8dIcYLzrGuuhqHtAk592ogqA382TkE+60nw9zuErQeSd
 HQ9Aq94NGuM0RJjanq5KqFjmQtHsTjqj4d9gJRzXgEyRdOFFpRt+xU7RP4IYR0gPnxc=
X-Gm-Gg: AZuq6aLtKgIYjyIaPvlsTOIrwnWDo6QOOuZ0wNCUjSj7p/l1Nr/ofUNpIMY7Cku5tYf
 MgWbtBH1iigKaX1Fdilj8gjGobJA3rMsgUMGkEAtF6tuiyDyslRmPXypTZpLQ3W7e1TPnROF4Y7
 tae8y0XDng7FmTP0+7XU4+2k36WiRCe7a2KsqIb7+G0SgkQRtWau7BGaEw/+GkMNmIUPbKDxm0J
 kX4S+1217UCB2AdT2fvdUu2hGtsW0aYj7uaRKaJDe4HCmT6vRqPdMUo5wSPmkgIT64NEc9ixMkQ
 CuG2Q6WhvLuNZCwzXW3CShOE6WfErP4IFvZ0gn1BOJddlY6JRnmDvkJlmwPiYtg5DWay9Gr+DU2
 D5EpvdAqtkyM0B2r7C14rUUQ+iEztXtMamQw/Pi4N6rB24YJ1Vv0AWEfja0OA2j4xdvXvRFm2aG
 fJ0e+nCh4T14HdLNzUfzzH16DWr44ZC/gpBTn3nUcqQSIldRLV/yEb6J5Fm1AWtoLchD9jPG1bx
 O3pBB9ii/iXIwBJEYn4N8wM5M/sptMwzSHrQ4dCcVFaa1kgsuuTq171rgp0mFC1RxGGcHEYyKHm
 B1l13WFXYSVSm9oddhtnlNLau8G91BT/s5T3b6ohhFs6oXhefueLgxk0FhbfJqcfq1JOjYMqcaB
 svtN0voea2x5gbfzCE/cpCyVC0CBDPfhrSwpWfqPPH6JUaq2/m8XIqCxotL1seOcGMXCWDE2YkP
 MasoVSySw7lf4JKCrR/Op/Y2QJ1bOtqhCzcYnJ3JeviHud+PMefshIlTLaX1gPNRe2Xq0=
X-Received: by 2002:a05:600c:314f:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-48373a3f3bcmr24227145e9.21.1770986456826; 
 Fri, 13 Feb 2026 04:40:56 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a34d66sm19366045e9.20.2026.02.13.04.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 04:40:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:40:55 +0200
Message-Id: <DGDUAXWN8ZAA.8A73T56SKN9C@linaro.org>
Cc: <trini@konsulko.com>, <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 0/6] UEFI Capsule - PKCS11 Support
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>,
 <simon.glass@canonical.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
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

Simon,
This has ended up on my patchwork, but I wasn't cc'ed.
I'll have a look at the mkeficapsule changes soon, but do you mind if I
re-assign it you since it's mostly binman changes?

Thanks
/Ilias
On Wed Jan 28, 2026 at 10:05 AM EET, Wojciech Dubowik wrote:
> Add support for pkcs11 URI's when generating UEFI capsules and
> accept URI's for certificate in dts capsule nodes.
> Example:
> export PKCS11_MODULE_PATH=3D<pkcs11 provider path>/libsofthsm2.so
> tools/mkeficapsule --monotonic-count 1 \
>  --private-key "pkcs11:token=3DEX;object=3Dcapsule;type=3Dprivate;pin-sou=
rce=3Dpin.txt" \
>  --certificate "pkcs11:token=3DEX;object=3Dcapsule;type=3Dcert;pin-source=
=3Dpin.txt" \
>  --index 1 \
>  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
>  "capsule-payload" \
>  "capsule.cap
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v5:
> * add bin wrappers in test for all external tools
> * improve error handling in python test
> * fix data types in python
> * standardize option name in mkeficapsule
> * fix typos
> Changes in v4:
> * adapt mkeficapsule python support to dump detached signature
>   for authenticated capsules
> * verify detached capsule signature with openssl after generation
> * use p11-kit to figure out location of softhsm2 library
> * fix missing long option for dumping signatures in mkeficapsule
> Changes in v3:
> * fix write file encoding, env setting and extra line in binman test
>   after review
> Changes in v2:
> * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> * fix logic for accepting pkcs11 URI in binman device tree sections
> * add binman test for UEFI capsule signature where private key comes
>   from softHSM
> ---
> Wojciech Dubowik (6):
>   tools: mkeficapsule: Add support for pkcs11
>   binman: Accept pkcs11 URI tokens for capsule updates
>   tools: mkeficapsule: Fix dump signature long option
>   binman: Add dump signature option to mkeficapsule
>   binman: DTS: Add dump-signature option for capsules
>   test: binman: Add test for pkcs11 signed capsule
>
>  doc/mkeficapsule.1                            |   4 +-
>  tools/binman/btool/mkeficapsule.py            |   8 +-
>  tools/binman/btool/p11_kit.py                 |  21 ++++
>  tools/binman/entries.rst                      |   4 +
>  tools/binman/etype/efi_capsule.py             |  17 ++-
>  tools/binman/ftest.py                         |  66 ++++++++++
>  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
>  tools/mkeficapsule.c                          | 113 +++++++++++++-----
>  8 files changed, 221 insertions(+), 34 deletions(-)
>  create mode 100644 tools/binman/btool/p11_kit.py
>  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

