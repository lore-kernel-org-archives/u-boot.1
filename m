Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD5DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DC386A81;
	Wed, 13 Dec 2023 17:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JF+sKzTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA5E86A81; Wed, 13 Dec 2023 17:31:44 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADAE86564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28ae1de660bso230113a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485100; x=1703089900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyeKcVCYBs4IJawAuE84IHooo0K/3FQPjlIt7pE7J+Q=;
 b=JF+sKzTBjjGw8v+20/tpHNLzgFamKRku3QcYXS2jFX/3WijfPZx4O0A4cDR5h+SzF0
 FtHg3yn8P727rsuC/J9Yd+rRi9GPMBH5iZOnsG8F+ViLB+3jiPWU15rRINeYdKjVgttZ
 pWYK6/9WWz2LAAx3DXRQCgKVnXfZjtzb4pfJMlmSfNRWCde86NtWls3WiYPE+sJhxUSA
 5/CUr6RINE2bVvKr7OoutGgXWfqPFpcphVwhHpZg2x5WuUyYG1CzDIL6+U9/QeSMCZeM
 WQIGEc2TIjDCk9te5xkee3afGan8liAu1LCNsu1P+eR9qe6sWng/U0JLvspHEhRGXZdi
 um8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485100; x=1703089900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyeKcVCYBs4IJawAuE84IHooo0K/3FQPjlIt7pE7J+Q=;
 b=tfYmkH/WPH5dXoBNG0fIva2OVmHUEq7z2fdANeUoL8ex5SInCUSQ4o6CA3Z6bGSVrC
 p4ML735hOxEuIu4AsbtK7FaE2GNO1GG0zXi9VBq6DfhoegSf446SnCKS3oBsQaRLP7MH
 NQCJ6YCZGXyO1qu6RL7dwM+IkmAVtGPg7oO3EFMSAe/XucbEk+F4ynvxOs7Hj4rkD7Xc
 YKwbHIpoBbK9SQloppiozANAbL52nf/bfEXBeRIYVA+DH/MKgtpz3tqcSv5hB+4QIU/F
 MmyBJaSKb50sv0vJS6P7cLCMkfcok4bDlHvcQkFlu5uDV3UeHdrpcgf8yb5CdI9fWoqx
 N+1w==
X-Gm-Message-State: AOJu0Yy59CQRGCNpDWLBVI2MJRquEKbKM0Se6rpHYUmuBDm4IXSMLRcb
 IN802yn9mSlzqpx4yK2w2+xlKS4IpVv3UayXF3o=
X-Google-Smtp-Source: AGHT+IGeAmD69dLZmh+wV3E31HnjB0rv7FvR0ZDU+Jz7/70Ozso8qO5IBqsyh4r7JY6ciU8L7tStmOLQOsiTnyCjpA4=
X-Received: by 2002:a17:90b:3909:b0:286:f169:79f1 with SMTP id
 ob9-20020a17090b390900b00286f16979f1mr14191239pjb.2.1702485100333; Wed, 13
 Dec 2023 08:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20231023152629.2727547-1-hugo@hugovil.com>
In-Reply-To: <20231023152629.2727547-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:31:27 -0300
Message-ID: <CAOMZO5DPTQqERC7_ozTiZhATJLDdYVQCqY7RLPQcegY0UETZYg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove non-working address from MAINTAINERS
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Mon, Oct 23, 2023 at 1:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The address ariel.dalessandro@collabora.com is no longer working:
>
>   A message that you sent could not be delivered to one or more of its
>   recipients. This is a permanent error. The following address(es) failed=
:
>
>   ariel.dalessandro@collabora.com
>     host mx.collabora.co.uk [46.235.227.165]
>     SMTP error from remote mail server after RCPT TO:<ariel.dalessandro@c=
ollabora.com>:
>     550 5.1.1 <ariel.dalessandro@collabora.com>: Recipient address reject=
ed:
>     undeliverable address: host mail.collabora.co.uk[46.235.227.172] said=
:
>     550 5.1.1 <ariel.dalessandro@collabora.com>: Recipient address reject=
ed:
>     User unknown in local recipient table (in reply to RCPT TO command)
>
> Remove this address from MAINTAINERS.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-imx next, thanks.
