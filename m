Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD09CF2591
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 04:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1BB88A7D;
	Sun, 13 Oct 2024 06:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WzeoHwLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6473C88C78; Sat, 12 Oct 2024 20:54:01 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE1688B23
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=razmik.akopiyan@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so26573286d6.1
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728759238; x=1729364038; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ij23Fa6Ugn6W2mm1gOMsE69Zz13Pqk/mR2/JrR+uj0M=;
 b=WzeoHwLIZ6tFFBhatA+dG1M3gwUn7EX82igbgDydvRKalyLiEVfb13JChZvg4AkUei
 c5X1fYAawlq3E+M8G228RBKrVqDtkI0yoYJEO5w7l8T0CYbTyyUq+vpggxYr8vmwSmM+
 bfklZE0lSIXwHDPiABVDnt0G6Aa7c2qm4YoG1Wwfody17tFvB8rz274C3FXsfXndkXhA
 tOFezO3FX0D7ZZH91PMl2cem9fu6179eAstormfqNvxHGodmP1I9YxO9AJgbgybY67/L
 YKsBOeVmUF3baHgvDE/ZEdy0P9zTUdWKP/srmHlu20PeBvGK2G1eYnOE6SukASqt2pNp
 OX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728759238; x=1729364038;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ij23Fa6Ugn6W2mm1gOMsE69Zz13Pqk/mR2/JrR+uj0M=;
 b=aGnG/lZUi1aIN4Q9eQNRX+XUmkq3RF8RWaeRebdddqlnn/dqsXCNuQC/afPFV1gwwv
 GpuyFVhaU+dRY0L60UP6FewfvE64pRd0RXtDCfY1ySzt7RLPtsrva3Z/he8/j5hfZ6UU
 q78dE/s7bzQtRfPjCtHy3yfQHoGgmN2XlFwQ8s+sjuii2p2xXRgFosJC4TEb/4F2fPbC
 i/4YSnw8QfsyN44xpkTsxlTbT/3Y2J7vPy/k6nMOnM5PXpvv6Y3uvxtWFJeVK3gkhiqg
 68BpIgoIDhlsblEf5nY++R8D+tlbwO1mxqdThcUewMSZ15anephpZvOiIeQ8+c5/adzL
 wa/g==
X-Gm-Message-State: AOJu0YzHIuqQ74Pj+gQsQmx3D73VAKcnfQcDk/3bnJC2Yz2O+aRTZYNl
 /KGd9tIYgepxJP5x5H5F53MnCJAJeqef+jC25y/1rMukkhlRcjEyJbx65QgqOj8oeozFqzfoTET
 QNRPgiKtIuYZci0PHIVRPzf0yq2yk6Q==
X-Google-Smtp-Source: AGHT+IGQvGQmfwGBftnEZujVgBvLhVWRg3UoYD/U13hJgaAwaVMNnjBCaqKI39BFsO+BWd9hluVK9ZhZznRKLaqo3Qg=
X-Received: by 2002:a05:6214:451d:b0:6cc:458:8128 with SMTP id
 6a1803df08f44-6cc045884b4mr12752616d6.53.1728759238026; Sat, 12 Oct 2024
 11:53:58 -0700 (PDT)
MIME-Version: 1.0
From: Oldskige6666 <razmik.akopiyan@gmail.com>
Date: Sat, 12 Oct 2024 22:53:47 +0400
Message-ID: <CAJ2HA6umF_7HJ47f7XuX1DhuSpuNj-nwh8JQ435sjWOfSB04=g@mail.gmail.com>
Subject: Re: [PATCH v2] configs: Transpeed 8K618-T: Add Transpeed 8K618-T
 board support
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 13 Oct 2024 06:40:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

0JXRgtC+INC/0YDQvtGI0LjQstC60LAgPz8/IDhrNjE4LXQNCg==
