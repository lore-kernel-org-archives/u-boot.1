Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F26D20698
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BD088C3D;
	Wed, 16 Oct 2024 05:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhfNcV0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3E88ADC; Wed, 16 Oct 2024 04:26:18 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8B387F7D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 04:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gerhardtbryce72@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a3da96a8aso22224766b.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 19:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729045576; x=1729650376; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6ct8vQGRsuka70RewQTjMuj4Vxg7UtvvoKH5sVqQygI=;
 b=hhfNcV0vOgeFad8C0qRReDvIHLuposlpsPGeuog74VtUTtLcCtRFVLqevewB9fNGVX
 nMbfJRAyciZct/j9kc72AQO/pS8L8yxgYOfHVnofFpZcc1Jgd8tfJ4pfdaoRno+M+94e
 izWbx73UwtUucUbNRG9yBgtay23nQotZFV3HA1CnKNdDi1ems1CaXVb+ohCN4tOOvbpc
 5zMOZaKvFs+H2+4qYXsabWkuU0ImRoU8mArQ14yAYzya9XzRGOKfCmSCJgmGLf8MN1G0
 qDweDNPba/9H+/3w6tCZX0q5IDFOmUIoJOyOPw4D6QqDC5yokeLDrgL74Zjz87z//PpF
 X3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729045576; x=1729650376;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ct8vQGRsuka70RewQTjMuj4Vxg7UtvvoKH5sVqQygI=;
 b=m3b5r1/yr7F5XU/+5PjQAfrYE+FLHJUwrTfXq9T5CLh9UD5Z8HSQxBkTBe2dIcbJvn
 khcSiKIt19r8rFZFf/QdXgGIfDo5b5b1xs1aGBKzx/j3tiT4h7VSE+geQmBpx74jwtbx
 MjU3PJigVjizT8LiR5I5z4bMi3aiK0uHtKk5GyUwP9ZAYk+tX8nSnthOYe6joeIzhL3L
 /bXEe7PyzLWl/MayDiPNomJ+uyXpZj/DF1lg9xy60PRynGskGt8TvlKo21GrcD8lGIYu
 WxocpbC6ubCthdT15S3QIFSGXOWLwrc/OuY1duqWCxXKDImE/Vi9Oji4HCSehXRfQnIp
 wJtw==
X-Gm-Message-State: AOJu0Yz1nL3zCFu6sOFnuSbMITXnIRqU1mBpskVVTCRqWpj3kw/aBZBm
 +P9sIcF2XEo0BUhsdxoJ2OYsvoU76RCeEabQWph2pLB91IDuA20nIGG1c/Uy580mjVzQ8sAsocg
 etF5qtvHQrrP8kWigcJ+sLSmOMM70lirN
X-Google-Smtp-Source: AGHT+IGDOqaF8JzjKLUvWW8pAXGuNIC4oURR2rMVx0ioo1euFaZaUh2dMgKoXX6YIgD9Q5rfT9J3pVtfrFuK8DGQhwY=
X-Received: by 2002:a17:907:1c0a:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a9a33572723mr247151366b.4.1729045575575; Tue, 15 Oct 2024
 19:26:15 -0700 (PDT)
MIME-Version: 1.0
From: Bryce Gerhardt <gerhardtbryce72@gmail.com>
Date: Fri, 11 Oct 2024 09:26:20 -0600
Message-ID: <CAEsDzFZFaEYbZvSMCBw5RTswgHJbohVxUuLE1t_5BJq1KHO_Gg@mail.gmail.com>
Subject: I'm using Gboard to type in English (US) (QWERTY). You can try it at:
 https://gboard.app.goo.gl/cSdoq
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 16 Oct 2024 05:43:46 +0200
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

I'm using Gboard to type in English (US) (QWERTY). You can try it at:
https://gboard.app.goo.gl/cSdoq
