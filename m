Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A722CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 17:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944E488A9E;
	Tue, 23 Apr 2024 19:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSwUYgSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669FC88A9E; Tue, 23 Apr 2024 19:05:47 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDAD88AAA
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 19:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ab48c14334so987185a91.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713891944; x=1714496744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0S4O/9g/mnOk90+vhY9kYh/5kndLpaUaaXXxgmUZzY=;
 b=BSwUYgSMAa0VOxiyd0DhNW9C/xFqo1NoCVDi4g9FXNTw/UVtT7DkZ5iYqysTkkctVy
 HqF5F7nuO//+aWyqhQ6xl02adWO52CPcpvicbf7LZyNQUbXAtAvZdCHHrmL6XS0kf6Yw
 FWk6b5cmS1ry/aFfp83CU7ifcw9qDkTq8jN6AtuBlFROXEqxVAlslx4vTMluW8R6KN1U
 0Rfb/UKRL4ihCTI2HwQsbnNuqTpHS69TCcRRX803eZ2pDUFRDC1o6j+SHpsoNOt+bEAp
 A/r9y9ZPmb22Jql+Vgsz88p56MJ1A1s8SueK5rqZEp5aDISdEcuPOrcMg/sxkbxhw9oZ
 O0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713891944; x=1714496744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0S4O/9g/mnOk90+vhY9kYh/5kndLpaUaaXXxgmUZzY=;
 b=P9K98fMMOSRMLQdDam5xVRuioCufBYvud1njZH8UqkefGX1exkrnCFcyrFLWYGbwTh
 4e+fIJyRphuyhKGYSRY7c1VDUDMGDv/4Yp2plBN/kRvKu7RqVJcbVOnCUQVIPYJNBknS
 +CI9yU3Cl7QDWdAS3bAQAg3D9AeoWlXyaBvDt7o7hoOKNQiV9Mk5BD4Kuulb1OWNgXIi
 +up7kyAV46WmC2elHIu+9E8wGiAuvcKG/c1V+8ZtvKk6qPl4KZjM6fUTI8Mcn7ILfI9T
 XjkGg3htYq+4ANa9jL0bz2qFlo6P7rN+0VFyx9n9Qy8q39//r9bkow/BcaJ5NNDt1hFn
 aImg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTaWF2ws3htM6qVuyTXR2wiYXgBeCshrpKiCDw6LyXUGb8DkvExy4BuAmNcVsTYxggPyvgUfTtbIluIYUKutg0/0mBPw==
X-Gm-Message-State: AOJu0YxsT67NCQ+i5aOgCaRNR2lxx9E2GhnOJu7aw7xDzuieHOa+V8oj
 Np7lDCMitiYanZ+E0qpS34P1XpYNbjnmEM1qIxGLG+BT9F/YeBjRzQwDRNx+De/h0j3MZoZ5q/t
 0U6kmjNHalit5cE0XNY8gTNilAcb08A==
X-Google-Smtp-Source: AGHT+IEp8iZVmDRc+HeEguZ/ShFfZFTxzEow5vWTSV0Sj+IlhG7EEBvk8ktNrzCKaoL8R2iG1sahcUtqG+HR5hNHDho=
X-Received: by 2002:a17:90a:408e:b0:2a5:3f1f:a1d1 with SMTP id
 l14-20020a17090a408e00b002a53f1fa1d1mr35572pjg.0.1713891943740; Tue, 23 Apr
 2024 10:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
 <20240419113746.73110-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240419113746.73110-2-heinrich.schuchardt@canonical.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Apr 2024 14:05:31 -0300
Message-ID: <CAOMZO5A1JfdqQvXnZhj8_WA4u63h2Zz5zvODMgGaqXgQrBaBdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: type arguemnts
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 19, 2024 at 9:13=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/arguemnts/arguemnts/

There is a typo in the Subject: %s/type/typo/
