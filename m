Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7CC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167E282FAB;
	Sat, 28 Jun 2025 14:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ds8aDpve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174CF81D5D; Sat, 28 Jun 2025 11:27:58 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E81806D8
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 11:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maral04371@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0d11bb2a7so406959466b.3
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751102875; x=1751707675; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dDZ/K+ZSKPoExGc4qc/YbitCQJcJchaXfHn+GleGcjE=;
 b=ds8aDpveiJq1bhtS5YobR0fLbg4s+q/nr/1CkgXp7dVOMWCSMNmU1MM6Zysh4Yim7S
 ccH69p6AHymJIHyKyzQMOIay0JaMCoh1ASJc1OI7ixInAQ2xiQPeYuVsxBRjTigFx6+q
 pksBl2WJRVGSduoRQBHrWtL1O62TJKOUu1NspcxTX4rkiHHl7BXhcs/HagDXm53K1LHL
 qRrro+ITjPjEuD/DIGAO8afSMVTKh1rQ33o0f/MJB29SNZ0vZm6785Cclg+Ttwj17FKz
 qJaG0sgG0qlZrC6olcpOi/8QF/ECnqi/BHzoB3Qb+VtUyiD4fe3OSIs3VYQHh5xPnHaj
 eAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751102875; x=1751707675;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDZ/K+ZSKPoExGc4qc/YbitCQJcJchaXfHn+GleGcjE=;
 b=xGCGJnwBvPi2AN59JVtK00EpOWoMtElI7VA7eR6XDZcMviIL4HTTvEYB+JfdEI2zsG
 r9Ap/drcOZqDyOSf+5BkoO02f7gvxrKiz8pwTrx89ctU+YZFW1uDVTusxL9lEjPYm2nF
 SvhihtT2HI4zmj7knFbOG1XeiqKJMGunZ2qVTuvfsjiqM9eh5S/z2vvn3wr1I4fuIegk
 qp2IClGTzenQ2t+glYIcvnw9MEExvDxCIsElTBvwoAFKy1EiUufwPlJAHJmTn0fj1NkG
 DlLc9C6IACJEzqzuquI3daU3H6OIhWx+x4i0/Mziwf08mTTd4+C84iA/V5KhssGTcTxr
 v9bw==
X-Gm-Message-State: AOJu0Yw54vw7CqKg2D2qN4xpxjfqOENaj6v6QMoPpNhDmtzr9E5mFq4r
 7YKZ8qxb2MWBwoWpfHJsQZFaS4xOZx0wzLVuFRJUGgQaB6nb15sjxDHzFg4gEN2M365LdVZkvDv
 cG7LoMBeY2mdsm0PEx3VND5M9ChpTsJGtQnIJ8BDjJw==
X-Gm-Gg: ASbGnctSDLjl9sXecY2lSzF6m262kEUn3ctnQMfDUs1Xvq1FLaw+G0VI8GyKSYLlXR5
 spOPY43yaBk0n2cun/fzFwjpxV0oTvqICSQ8l5eAgNdwYSpsFXVuCgkoYbMdeOmhQFD/U7Nx2b1
 N4riTPCGc9m5YrbbFh/b+gEAu2k+2ezp6MhAKPgPVeOj8=
X-Google-Smtp-Source: AGHT+IFfOhruTRLZcPzBRa6kjQD+xzcDPOTsYp597xNGe4j29bcUgIGzWfMyHz9cdurWiELD72X6eQxFV7TKKCvBlnc=
X-Received: by 2002:a17:907:944e:b0:ae2:60ba:da91 with SMTP id
 a640c23a62f3a-ae34fd94b73mr629188866b.15.1751102875290; Sat, 28 Jun 2025
 02:27:55 -0700 (PDT)
MIME-Version: 1.0
From: nejmi <maral04371@gmail.com>
Date: Sat, 28 Jun 2025 12:27:43 +0300
X-Gm-Features: Ac12FXwM9J7AWekt0tgsqO9KGKCZVcw13oUs-0AhdSWlGCd6LlGOwgxrrMl13wM
Message-ID: <CAJ0Vu=00fqrHKr5o28nghvaWHiWB3ohoo0FKgQiXKYHGtwG4Tw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: mach-k3: am62: fix 2nd mux option of clkout0
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:19 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


