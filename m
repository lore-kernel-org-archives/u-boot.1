Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BD4C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F2080756;
	Sat, 15 Feb 2025 19:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E8XwiWLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A7180EAF; Sat, 15 Feb 2025 19:10:55 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B7680077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38ddfee3ba9so2434243f8f.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739643053; x=1740247853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntV9JzIGNEOD0Dhq3CTAZ6jIec1bRJf6O64d/0FWsEI=;
 b=E8XwiWLnmm/jMGrIIG3kaj1PmWAsqmz2jarRwN4votTUsaS+7mt5Uyirwt/Fr01W+C
 Mc893sj39vQw0coPUhezrl9CYeOolJmANrV4x7M0t1VnzRFOFoByfO69uuDNypZk3+kv
 4cK0lgl2WpnSVoJkJmjDu6u+8gZZOF1EjnyNHYh/DwA/sFX+kT+ulcO9FIxSxdp3Atef
 ArSXDvNEmDRSOI8viwLDVNPqJ6jETgcQAoyl7kjPtDIcBRDUDl9OGKZbotqUxzeGvwsZ
 SaPM2cnSaAC0QcdBLgkPiz0BHWFIW2rNKXUP9kSdUTWZzNcvt6HlLeV6YrjtJ9fimdyQ
 OmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643053; x=1740247853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntV9JzIGNEOD0Dhq3CTAZ6jIec1bRJf6O64d/0FWsEI=;
 b=f7po+UF4t7ZWpDwdKQWa4AzRRLnIwYBKpdLHhQE9iA16Hihur8Lu7da1YrtSM6w0/X
 Ep/jSx1S5j1gZymLt6+srfa+7yz1DIjiadry6Btg0pFEFucNjP3joR+r9wVM4HZFPnX/
 9oDPjgS+2oVn+irtJCi6aru0M0EjDaF8kdIrj+1jTon03vQmtAbrNm670qg1olTw4LA9
 529zVTn9jRAoixNIfdtEkdw49zHYC9CsvAMWQGcr+GrRboTdjhD/DkFnM/JsE+VAwcSA
 3LWki+oAaray+C9fMKRisR5RP8Gaw/+z4TOZUs2bEDECqPIvN6NCjeKquOgj8Mglq1R2
 k6PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOrPrCQY7rQP2iw4v+TvMkW1vYB2v+596QZHpdfhTqUBEwR+PI5URhumUgPsz7pcBIZBSo7Zs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7FuEyoNLDdxXRjmiHWQH5QP+ZPF6HyhxPKktuy0jb7Ci4se0y
 vrX9Ot6lr7hF+e295ky9CI8KjzA5K4ibs64VUnLEhlpmWQc9FeusTE41XLf3UFcHv0YCG67I8Ir
 LP3ZOwSX7q9KvNUoOsUmcqVPXg24=
X-Gm-Gg: ASbGncs888qVlt6rbTCuPtI97fdggLsQivDy9iBiVZi02eaqMDc8YMDmIYKiZFEEl2V
 9l2vtNsOrFFuGPzagDgIHUL8ETxfa5bsFgDY2Vxj6FGohQ9Z52pSYo9D2dNLBOzbhhn2UR0KXjw
 ==
X-Google-Smtp-Source: AGHT+IFkzyWQORk/dj2yP1C21Fq/L2qCYkVhcHWr9LLYkBnkoe3+sPvOKYNAHZB1j3z6uFAXPHwSDp9scvnrFUPF+7A=
X-Received: by 2002:a5d:5f45:0:b0:38d:e584:81ea with SMTP id
 ffacd0b85a97d-38f33f4b827mr3633446f8f.45.1739643052729; Sat, 15 Feb 2025
 10:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20250215175534.203539-1-clamor95@gmail.com>
 <20250215175534.203539-2-clamor95@gmail.com>
 <CAFLszTjqDJdDUYVHchnrYn1e1_PTqCPusNCUWX_gBdncLJvMKA@mail.gmail.com>
In-Reply-To: <CAFLszTjqDJdDUYVHchnrYn1e1_PTqCPusNCUWX_gBdncLJvMKA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 15 Feb 2025 20:10:41 +0200
X-Gm-Features: AWEUYZnvnigMzshj2mjedCe0zYCc7FpZkvzLDfi1EBAexVAtnKkpdESns6wLGqA
Message-ID: <CAPVz0n1O59cj_r0jDK59e+Q_YD1yTz9UASai+BtCz2AhVGr01w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core: ofnode: add of_graph parsing helpers
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

=D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:08 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, 15 Feb 2025 at 10:55, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> >
> > Add a mostly complete list of ofnode analogs of of_graph
> > parsing helpers.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/core/Makefile       |   2 +-
> >  drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
> >  include/dm/ofnode_graph.h   |  90 +++++++++++++++
> >  3 files changed, 308 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/core/ofnode_graph.c
> >  create mode 100644 include/dm/ofnode_graph.h
>
> Can you add a test to test/dm/ofnode please?
>

Sure, is there anything else besides tests?

> Regards,
> Simon
