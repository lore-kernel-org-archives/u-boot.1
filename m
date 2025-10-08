Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981FFCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC0A83A7A;
	Wed,  8 Oct 2025 22:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B5MvTZ+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEA383A2A; Wed,  8 Oct 2025 22:31:17 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D4783948
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3c73e93eadfso39611fac.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759955474; x=1760560274; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGgGK/jMiaCwO/0jSfc0GNGOgmgcubuqCQVYsPts+PA=;
 b=B5MvTZ+nKAuddMF0yv2SyIKuTE+3xI3jRUA1EHvArAyRKd7lj51pYtjFeB79Szqd13
 hMkWk2Sg4sZy4EYsO4fvSq98SksU1M8UzSEmcjJF9JFUIaRp//X/ZHX4HCTCELs4ow+i
 lgd3Z962pl8Dby/4DEvNi4cJGSJZmaFRXNqR/ImCt9qIQmosp2SaPdDQLtaG1byHQmGH
 CyYDC8hNOJ+hyNivyVkV2MrLd3uY+gT+FvWm2xu5Ub5WIx5Wxc/toMUHvBFELiBjH8kY
 u7WPa7kxREEuRhMYN6OARTHCA5Ve4fVEi1CpDuzN9/Vt7M/zTp/J8S0mN7ej22Y3/GAL
 RRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759955474; x=1760560274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGgGK/jMiaCwO/0jSfc0GNGOgmgcubuqCQVYsPts+PA=;
 b=qBW64OdKekJncvzzUWpzPY8W54UwWL/aCTVc1Q+APfgJeigJUZ/72lttuxrFvtfD7I
 gTS/RZ+n3QPW/adT0QayDMh/g3iPzN7vRpwYiLsT8SrWVhxspPDe6cMDWRMXq5A5SP8F
 Vcrw355i7O7ajj0SRWpmqNTOGWvD47p5lkIS8+d4fJNMPrO+XVJ2UoL1jrlG0kYIABIg
 0EBntwlbO+amTnd6Ban0jcQg5WZg9+q8igY/kKv3jvpX80BPL/dcGpqqD0rV76OiLjFj
 OKy+bDXq7VriyCLVzQgXm6VeVRwCxIpMd8TGDwHxR7EX8kItKqtIg6mvffv+8/bkf8PI
 6Omg==
X-Gm-Message-State: AOJu0Yw0Uvnp9WRjocu7RIQw1la3Q91GqD5RufZ6kxvwTHp+D/SgbEXC
 tBIh9YQjEDYx2gexyTQAj+cWZjAQ/B6RZ3nRkae4U6ELGWVoRrrmYyZ10eVd5bKDAK8HfGq4Tbo
 BzLrHjrbDDdH1qJq9Ew6aC4o5HpMObUnyQ/HM10pGlg==
X-Gm-Gg: ASbGncvBHT58wPJsZInnjTentrIOdjk6UUCMXn9I9eS7rkoFKQ9r9wdowjzk6tkXW8T
 ZvPL9jJXBDYFQtHj1ZfGn1puitejSVtHJ9FYQRMY4h2bcbAIsdmGiyth9rOmaOuGgs941mypSV4
 9FYc/f20ioD06oUiEGNMlcOttmem6tstDWb214ppxFFGrGitJiVsVSmXOXBR4xBEjsIg25xY0Bg
 XE+NafzOlaE0JAXhCKrNJINx/yrrwE=
X-Google-Smtp-Source: AGHT+IGmWc3YD08+MNBhdULas9SStl9sX3SzvgxWKOormIgx1tDFTUl11mNOsXv5I9n4SFqnxtLttLxUZz5uHN26Yfc=
X-Received: by 2002:a05:6870:1595:b0:321:ef6d:c736 with SMTP id
 586e51a60fabf-3c0f51a5b62mr2872795fac.3.1759955474464; Wed, 08 Oct 2025
 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
 <20251008193306.GI298503@bill-the-cat>
 <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
 <20251008194613.GJ298503@bill-the-cat>
 <CAN7C2SDR9NLpmF3Pcd9QRVRk5gBrR2fciiPwccCsev7tpRYHJQ@mail.gmail.com>
 <20251008202412.GK298503@bill-the-cat>
In-Reply-To: <20251008202412.GK298503@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 04:31:02 +0800
X-Gm-Features: AS18NWCk6OkubdngHlcIzYyGZc3F-CKWfQEn5y14Z0eOBu9zKvV1WDTz4IoYKJU
Message-ID: <CAN7C2SDA9BP7rMPzCN6qakSDFF9BDjBQRJpMsSsHZwFynvGfBA@mail.gmail.com>
Subject: Re: [PATCH v1] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:24=E5=AF=AB=E9=81=93=EF=BC=9A

> I'm not sure what's going on with your environment, sorry, you might
> have to just push things to CI. All of those errors don't make any
> sense. Docs are build that way as part of every CI run, so they aren't
> generally speaking broken.

Aaaa. Python sometime is very touchy. So unless there are a general
env that can be shared to test this is no good as well.

I do see a warning on the previous .rst so I fixed it and no warning relate=
d
to the new .rst file.

I just patch as such can't do much no this.

As for the built I had already use another system with 3.10 python.
Yet still returns those thing on dry run. Very puzzling.

Brian
