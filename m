Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C534C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 01:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A521C890CE;
	Fri, 26 Apr 2024 03:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HncqHRMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEA4890CE; Fri, 26 Apr 2024 03:37:33 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56544882AC
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 03:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-61b4f3c03c8so4217497b3.0
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714095449; x=1714700249; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inmiLfTxjzNnB2L+qFGhhInyf7V+Tif/8RILm5yGNQk=;
 b=HncqHRMYGmqWjhQynbok57NLOrVXB5+PYorjqBvt/9JPcuX96RRbTr43a8I+Z/Fo55
 FTcfUfLqTkjYV6TIuFLgiaHBZDAM63IzlI4b7zHzHycJ1Bp20GtvGvYV9uXM1Qa7LKKk
 8ERfpIz004/b8IUjW0QFp19U9lssce2N8+GjePn+XG6iEAn0/8jCnwG1deFswjsTZaEk
 STKK7FGdUSYPLTQtYxE/fWhyITO/jML2F4VWDhw38Tlp5c/5nEIAofcBRP0saxHXBNV0
 cX+osnnM9OzTaYmGYwsDVP4AXDwTJRdLFGkenQUiUFWQih9Rr18+ZAMLCxnYffs+JSjo
 LS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714095449; x=1714700249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inmiLfTxjzNnB2L+qFGhhInyf7V+Tif/8RILm5yGNQk=;
 b=UtsPQISKfREzYzcsyKPCXKHAweQXthC88ntf2tkvtb67lh0hyC3LQygWP/HaflOIU3
 RAaL3Drs2af0UgWY8qNZmSKf9wUPYBnZUSPDvgT86nXmLkJyRx2VnPNPy9jRxBfMiys/
 gANSw2AXvhIkwbd7g/PtggtVLr9gQGiflf03slm+Su57b62Oa1UtEcVWa0AP4Jx7OM7r
 Bl4Udy9i2vWYQPlYwpqzcn22MapZJA6bQiUoUOLh6lob9Fh3VgggkLkTNtYIwjcA2ial
 bVeGUx9eMdKQJeJV5VK5R1uxcFrYTS5acQ4wOlX/8YdDzgmn23q6/8UY7cFvOFyxwxob
 YMDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Y2deOABO4LndfNe/nJ3f28EgXJhAQ4ms39xF4T3HAzTi0B3an3Gb8AAIyyvWecvttA6lHIIGlA+/ocsWPvujXgVF/A==
X-Gm-Message-State: AOJu0YyXcNfiRE4v6lDEhm7eXIztjf+55rfoVB02RxCIsbCW9jkfGaBn
 d3B5GulFdIhKmt/UPUVvB1XqiV1TdFVoq2U+A0cJcAwdz+ZSUKxBM1TuiAB9ZSRiru4xiOp89g+
 I8oFYEeFpF1YpFtUAlWcSAyx+47E=
X-Google-Smtp-Source: AGHT+IGO01kdJ4RKF/61H0egyVcINhq2BUpnWfUPLYPGZat4SYazScgITE2DuQqN7jQ7u4qQ/Bn/f9vtMMY0ha1x780=
X-Received: by 2002:a25:ab8a:0:b0:dc7:491a:18c2 with SMTP id
 v10-20020a25ab8a000000b00dc7491a18c2mr1329953ybi.6.1714095449065; Thu, 25 Apr
 2024 18:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240426001419.1210364-1-tharvey@gateworks.com>
 <CAOMZO5DYtWRxmBH9n5W362ajx8VRxmwwD7xEJ7hv-kAFbrKkMA@mail.gmail.com>
In-Reply-To: <CAOMZO5DYtWRxmBH9n5W362ajx8VRxmwwD7xEJ7hv-kAFbrKkMA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Apr 2024 22:37:17 -0300
Message-ID: <CAOMZO5D512G07JUX9=ZDxFJciD40v678o-2_mo_awn+-u4=Mow@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Thu, Apr 25, 2024 at 10:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:

> This is a nice improvement:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

There is a typo in the Subject: "partition"
