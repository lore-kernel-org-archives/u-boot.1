Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4819C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046E68773D;
	Wed,  3 Jan 2024 20:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V8hGBcX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBB987809; Wed,  3 Jan 2024 20:32:23 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101B0874AC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so2420567a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704310335; x=1704915135; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2rYUjAP0HYQwaqfxPSEJ+Hw5g4KJVXx1UPmluum3So=;
 b=V8hGBcX+S/zXK1tyvKaokb09iTKJcMoovlNs/tT8CRiZpt269bh/Bw3+Iyv9OQb6a5
 1+wrWjlsIcHFdeLEN8fxmTqNTUBQ/g7GQu1bMoL8Zas5agyi+XRaeDiMgqSkv/gn3bWG
 lEgR2HKwnEV1iA9l+q+Jhy0YsTsQFHP1zPZEGf/CSnz36ERPcmTuzxg3vXnHqYMJnP3b
 F7qvwKbC2BLNp3fuNf8frbVpESZ0P2LNn2424cavJvLupqWxKBuoyRrgG/aMsy3lf2QO
 THmy7rPNMEFFim/C+Wkl+PDDgrB6YMkcThTs8mI8N5R8M6SVGAVSjDe5pLf8ujtlQqBe
 Ipew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310335; x=1704915135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2rYUjAP0HYQwaqfxPSEJ+Hw5g4KJVXx1UPmluum3So=;
 b=eFJtDRLdm/13yK98UgQn0k19yu0DIyff87azMQOJdQbkhICqlsJLplP2SYEYneqerx
 4puKHNDdhNtR9cYANNv2nvK7m1WTYNax+wAKc4NOA30QECz/GGjSFvOJ892TRCKAnY97
 rgtEW9S/W1rSOW1rzewu3I2xsVGBY+CT6x1rBAOqsFUy3SiOyxWiYYw4QY+KKs1yDaIV
 7HtSKm1kR0qpWkaz5jY3lRn1Mo8F3BzAPnPDUNgWfpUI/vUq+Qx9a2nIpwhLaXzkfD9p
 1is/zzN927jTAO/OyVjI36iWuqvr5xtesT42PNakeX02bSoeP04w7gW5yRcvi5+9Ml8B
 duEw==
X-Gm-Message-State: AOJu0YyHdPisbeHofaTx7lTgjTENhLavt1G4XUPD23Hts2AfbRPYcADe
 9lxmfQU5XTx1hkTpXY6nzV1+KA/DRe859Xcvh+w=
X-Google-Smtp-Source: AGHT+IFzPS9s+xg4kw8wbzy9yzQ/Fpt/7Ih+WLcZI7JeWYmXgB0EjyRwEUqPdiHUyVxkuZ2zeLR36HNXqysoenHwwuw=
X-Received: by 2002:a17:90a:bd17:b0:28c:113a:9678 with SMTP id
 y23-20020a17090abd1700b0028c113a9678mr27666232pjr.4.1704310335657; Wed, 03
 Jan 2024 11:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20231229111701.10696-1-othacehe@gnu.org>
 <20231229111701.10696-2-othacehe@gnu.org>
In-Reply-To: <20231229111701.10696-2-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 16:32:03 -0300
Message-ID: <CAOMZO5AhbA70_0K44jdTi40LS5WgwMc9Y3REAgQaf_Xmdj9wag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] spl: binman: Disable u_boot_any symbols for i.MX93
 boards
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

On Fri, Dec 29, 2023 at 8:17=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> This is extending commit 6516c9b349b3 ("spl: binman: Disable u_boot_any
> symbols for i.MX8M boards") to i.MX93 boards.
>
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
