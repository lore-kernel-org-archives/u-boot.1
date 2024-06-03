Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC4CC25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B7088400;
	Tue,  4 Jun 2024 15:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AcY3W+gL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C44487D07; Mon,  3 Jun 2024 16:49:12 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E5B831A1
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 16:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7950c1b0220so56055385a.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717426149; x=1718030949; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcI+0ZdWTybOnZfqxgc/utvw0kU+Nylr5AQA9+8Sjfg=;
 b=AcY3W+gLcaPEqK36JDvW803VrNhwnQzb+h3KdbTUysBtSmPYTcErvX+6hTal5Z8S/S
 CR69sp5uskiotIp7bQdnsXOLVBHuTdWVviWcP+rnbzqrvWY5KpIwb1ZLXmX5qZOj7Dzq
 rQb0e5/82bGw45RoyMcMKr1NLSNGGqs03OECn95zDXfNbmOQNB8nmKxyeMM5WpwpZYFd
 qaq9HhzJ0aPTY7iCV0titBS5OB7dPCaQPtInFQnXLXgtLj28iUjIQqc8DfzV4fZOoMzi
 e8ZcuCEB8nbeL5DpJbkSVKqfEEIkylJdpCX+AeorsSl7sQtHT3t+GGwcS/8ckECXIzfD
 44/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717426149; x=1718030949;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcI+0ZdWTybOnZfqxgc/utvw0kU+Nylr5AQA9+8Sjfg=;
 b=AzM6KvWEbCIVqvl7jZjgHypVMH/scyGDcOcARX3XKm85dDVwJgh/wlszhyvwja/txv
 dOcH/gkeYOROamMszAOSatRdS6Q9WqBao2zgQ8eEHssPjQOuZ6WH2oHOtR72Nf1Tg5NP
 GUdwodK4As0Tgw842N3XfoZ67OMkjxsTbc7hONH/MuGO5GPtQwIfMliRCDPZaUhzyTNT
 DFq4DL+Qj+y95YYwh8tkluFoumwnAyrJ8JG4Ivcnj4hs8/Hntc4ppeJTUa5LR3TGLqEJ
 8JeWXyr7HvcL2/8IQ6kfUGge4kol87EiEsx/Bk69+XK8+DmG65/l9pnnP4gXW+6nICtN
 OgBg==
X-Gm-Message-State: AOJu0Yy3oJHX56efsdb7UEF9aKsel+FW7PD0S6t3JgebnS2WU6MRKQt3
 aSBS1znFQSW/pth/VbBvNO3Lv5mTAb2Qc0GkJpwW+5xJxQFzTkX+wUnt7xTkHSfhoROw7CIRQCr
 gxNWF82onGWOGGRfBDGn8Dira+NKlag==
X-Google-Smtp-Source: AGHT+IHuS5SZn0bse62A1JzhXrdie8NGZtSqJWuumJULf6vX/040sicM7thtRnQ9LWXcjvK5k0G7s6KsvDfn9SQO9qM=
X-Received: by 2002:a05:620a:5650:b0:792:94ab:cfd0 with SMTP id
 af79cd13be357-794f5ec1c8bmr928865985a.56.1717426148610; Mon, 03 Jun 2024
 07:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6OJk3D0X=dnciRjtcUGzDb4qj1JGLGnCMwW7hVoqzZjDQ@mail.gmail.com>
In-Reply-To: <CAMn3X6OJk3D0X=dnciRjtcUGzDb4qj1JGLGnCMwW7hVoqzZjDQ@mail.gmail.com>
From: jianqiang wang <wjq.sec@gmail.com>
Date: Mon, 3 Jun 2024 16:48:57 +0200
Message-ID: <CAMn3X6Op+euyEqp1JOqFTKg4BuhVH_B8PgZaeMGDUaYPzcvW2g@mail.gmail.com>
Subject: Fwd: A potential bug in das u-boot nfs implemnetation
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

Hi,

I sent this email to das u-boot one month ago, however, I haven't
gotten a reply yet. Do you know what happened?

Best

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A jianqiang wang <wjq.sec@gmail.com>
Date: 2024=E5=B9=B45=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 16:14
Subject: A potential bug in das u-boot nfs implemnetation
To: <u-boot@lists.denx.de>


Dear all

I found a potential bug in the das-boot network filesystem
implementation. I tried to mount a remote file system in U-boot.
However, it failed. I checked the network packet. The server said it
was a bad directory handler. After deeply checking the packet field, I
found that u-boot calculated the wrong length for the directory
handler and added it to the packet. After I commented line 381 in
net/nfs.c: *p++ =3D htonl(dirfh3_length); It worked. Please check if it
is a bug implementation.

Best regards
