Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD83C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05AFB87727;
	Sun, 31 Dec 2023 13:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XhPhEsfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D294877D0; Sun, 31 Dec 2023 13:45:30 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3F387727
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso72011236d6.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026723; x=1704631523; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNNiQXZFAk+uma29wF0twm1nPZn1dXhhBo1qJBUwjWs=;
 b=XhPhEsfjhLX+7OWZTEwXR+sfpxI6+AvmIIGhdt1k4p0mvGVE71V9sNXI7OI62tW1Ig
 Nr8RpRekTOWMfppIR312dA2995HByB6vDMjgWkBzktHpKUcaonn5Ol714188R0zPQ+eH
 WW+BqkCJN6kFfY3JdYs9a8H3uUqDXeVW/KwMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026723; x=1704631523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNNiQXZFAk+uma29wF0twm1nPZn1dXhhBo1qJBUwjWs=;
 b=ByxnWIYxSsghSwA2vG/LMCt0ESJxrO3wXVz9BgOl0T5wAfRFz4JvCynm/1LO/bf07X
 oLJNiKLwD03+CM6ALLUhDIwIdMT+jLjmYJjmP7cbV8lFB6n0OC8b4i0E4PaxaqzPC4uT
 2gd5mvVC+9a+V0fQvWa0yxRMTdqVFmn/JfNxtzmVR4PukYVS64mvVWMl/OGFtLdmv03I
 0m4Ka49ggcOC7eVA0Pb9s8rLZlIuyBTbTVUfol49U9TtT8UBEvFk3lNbzScC+MjyYzhc
 QysTnZtSnEUFbVqBFvKYjjt1acn7xDpXcTO+2uIvVHVMs9lxEWOGD6EXaYGfHpQOT6Z2
 TxRw==
X-Gm-Message-State: AOJu0Yzj1xXrvXaOxfUiY8XjiDehHKo1YcPadyb3vUiIoQZpXq2jhFEI
 kZkQU46s8XrHjy6NofvS4vdYg0H5GXdXBl3X/a6pIcZDHo3B
X-Google-Smtp-Source: AGHT+IG0Nut8BiY3fSWaU1QSmIAA2HHJrJkR06QL6AKSB7OSk12S7qetxutpQwpxn2tlrz9x0kKbrnjNn6H3DIjd5LY=
X-Received: by 2002:ad4:5765:0:b0:67f:7630:2371 with SMTP id
 r5-20020ad45765000000b0067f76302371mr23695909qvx.13.1704026723540; Sun, 31
 Dec 2023 04:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
 <20231229-binman-firewalling-v7-1-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-1-47ed4af303fe@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:45:12 -0700
Message-ID: <CAFLszTg3FGTFtwiv2uOdQBtmLmKq=oRt-5h-DYSufPw9pEbsXg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] dtoc: Change dst to self in debug message
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Nishanth Menon <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
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

On Fri, Dec 29, 2023 at 10:46=E2=80=AFAM Manorit Chawdhry <m-chawdhry@ti.co=
m> wrote:
>
> Fix the error message to not use dst and use self as it is copying the
> properties to self.
>
> While using templating if there are no subnodes defined, we end up in
> this situation where "dst" isn't defined and it tries to print the error
> message and fails.
>
> 'UnboundLocalError: local variable 'dst' referenced before assignment'
>
> Fixes: 55e1278d5eca ("dtoc: Allow inserting a list of nodes into another"=
)
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/dtoc/fdt.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
