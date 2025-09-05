Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC463CA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 17:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 313B683807;
	Fri,  5 Sep 2025 19:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Oc7OLVch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2A583826; Fri,  5 Sep 2025 19:45:36 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BDB837B6
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 19:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-61e74d0539bso556422eaf.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1757094332; x=1757699132; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pC8+Q2pNIBGda1e2END3mT1EK9fEi0R2eTT1oWJ0LM4=;
 b=Oc7OLVchQxblQPmuCtZ8uMJ7La8XlHSHVMMyPH0xRjLXTdOkxWC6FCD5Wahs8SjoOl
 72fFkgNmSTjYfpRPHJCou3COWDmKL//igth6jDdClQTisj8qkN1Hh/Pqhbbj8yV4LI7+
 3NwCCh3XPOdCYqnaP5tMlzqYR0l4M3GeK1V829i++1NIjaCz0fFnhTEguMxXu/AcLOKw
 CXnUbZ/Q2z8XVNhU/57w4d34cDJlLL4v+dXCbKWBTc1Bf3wbq4C6L5E56GGXl1ey4+dl
 v4PKwxOnUqpa6DJnKqtdhOOQwDAlDOdn+JYl3wkapCS5KMSTUZP3f3kHMOi76nLc8lBl
 lKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757094332; x=1757699132;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pC8+Q2pNIBGda1e2END3mT1EK9fEi0R2eTT1oWJ0LM4=;
 b=YaJQNV2n9KouOHqL/8cyBXgnS8ZFdyZxmw8HhIkOuItaVWcSZy1YnTTDRpK98jMVZB
 9Kj7G7Nq3AtdLtLxNhKa7w8MYhgaaIL728xd5yBEOLZK40bV1SVhXfpYqQ+r+E/k3SOm
 cKTJjXF88TFfBYZJIzs0g79ezdo/MEzxhq6y8/SrjsiRXtegcIaRNKi2u2mFrvoiMjVd
 X7xrgGQ7uIK3dBNK5LnKpLdTnaD+2u4GIfy39NejKUSH4pilIYMe8aUaJn5+ELuQOE0f
 suDBOSQFKkqExESuZUKxFd/OAYR+7/TaYGA34s/Qg2Znhr9TvxpEX3JqcoAn/iJp/y5w
 BpXw==
X-Gm-Message-State: AOJu0YyA2PdbPQbi1V3jHvG1Xyn8e2hFXLaFHqzmPPXbSDpvu3a/XVry
 BGM5v31eNDJ7f5hCDVZicxkaISBgSGW7O0xSi2WrMBW1Ynmqo1tz4QPc1QPDjVs0d8CYt40kBWt
 6Daya7LI48hD0yA7eX7rY2oKsFGHowgS4mebg+fmwYH3w4EMUfWI0pKA=
X-Gm-Gg: ASbGncvfjv1BKokFSmXldDsQKmEwA0msa4khU1D/MuC7Qgio87CUOYVTs1CbAk0M34U
 LsUg3DcD0jVx9M/u1gRzxi2hDQnPd31M6ogdoOdo7Xy3Lo9bd816UH2Lgb/V2Wb6LLQ1+XqJRBF
 R7wGJdEPpsxf2DrjMWkVZ1G2bScPpdihS7OkVxXZCt2WBuLFbZ0GQMJ4EM64OdlLKicqcrdLrwX
 qzN6/k=
X-Google-Smtp-Source: AGHT+IEA323LgKfRuk80iWHfJmmgxSEGX/RBQP4Q3aV6wcrZxJNIYdOZGz1L3dqLbdmBC5tAwo6TLFEXFYB/A1jrhGk=
X-Received: by 2002:a05:6820:1609:b0:621:7234:99ce with SMTP id
 006d021491bc7-6217234a05fmr870804eaf.8.1757094332131; Fri, 05 Sep 2025
 10:45:32 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 5 Sep 2025 10:45:20 -0700
X-Gm-Features: Ac12FXy0r_vdiGnIeRpVqYEv3gnkfZ3Tmw5qcr9nsx8kjzhURxdDbm7LoqUHvVE
Message-ID: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
Subject: LWIP buffer alignment
To: u-boot <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
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

Hi Jerome,

I'm working with a board that has an IMX ENETC MAC on it
drivers/net/fsl_enetc.c and when configured for LWIP it fails and
warns about RX buffers not being 64B aligned:
WARNING at drivers/net/fsl_enetc.c:776/enetc_setup_rx_bdr()!

I tried changing MEM_ALIGNMENT to 64 in lib/lwip/u-boot/lwipopts.h but
that did not align the buffers to 64B. Where are the lwip buffers
created and do you have any suggestions for working around this?

Best Regards,

Tim
