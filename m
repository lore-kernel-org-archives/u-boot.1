Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99DEC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF2687EB2;
	Mon, 11 Mar 2024 14:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qy8iy1Kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF3887EDF; Mon, 11 Mar 2024 14:09:22 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA9287D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1409901a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710162558; x=1710767358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/PfRfWfR7nJni5QHjWW3ou62Nj3bUsPPK0d36z1D7A=;
 b=Qy8iy1KqY5kiMETKbOgeTjABYCdCllbGMDgUHWsDxH5q1xCQ13wPqNkeFv/o9Vyc5J
 jbjYTABLRRjbos2HBQb9zB2Qr4vYo6hW4ACS64m5d/ZfyuWtXWc/2R56F3fRa/qeB3vR
 fD1epBGVnBRjcTm+yf+bm6Y+ZGpAWf3FXo+ezcbgdaIZ2EwW3oAHAoz50c2A7vsHsql0
 ueeuOSWM/yiaKEabSQeE2hPd9DXeRM849JNyEwDXbIZgk9s46ve0UHViesL8u+gaJPvo
 9HsiiHkwblBqe8E84c7kTMWQaWanCIRT5cnsFqecZHaNMObob9H5shyV9FhPoKWEJdv1
 eq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162558; x=1710767358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/PfRfWfR7nJni5QHjWW3ou62Nj3bUsPPK0d36z1D7A=;
 b=k+as1FBPx6znqf093BXVsZtcVBVHkQhmfioHn4ssjBm6AHp8ZGGTzMjyiJHrGpfLvY
 VCaIAnZPMzp1VhMDs6SKBSuGkPlcukV8cESU8o7OI5VjR5F3JDvUMNeWNL9SKOIjyQsi
 j813Bv0x+yvdZdLHYNpCF+KhiVWp3wkAruC6CrlaKVyxNdZoGQ0P3jAIByNTk+Y0HqO9
 STCC9qrA0oXE+AzDysXG1jVu+MLAeK47zqMemXG9Jg52VhlGpFQn4K8tLgXLi/EtWs9O
 BYZNyZjMwqDIxjs1mUkmyt7rNAZnw1i2DgQBULvOXkBs4m0XpDe7WbyD4XpukRdIl/dq
 z5qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO5PeebVgWhRpO4xoALz2/wTLT7sVZuhe+AnUw0WE33oCbwEswa926jtFCmOrEvGAg4sG7+nvr7i2R89vmrsOgDXW4Hw==
X-Gm-Message-State: AOJu0YyP3OPrQB+P4snHQz+70CClh2gULy0Y1rmSyD/toZCedalBF6/6
 XPQBFmFTXhgGmh9PsMB6akmTq70q6nOhueJ4HzsbkjSYpV4LwrbRK2F7fd0unPyclFyj6I91m1c
 s4qmFDwOx+n/sdeCEx4P19Dudq3wylrRD
X-Google-Smtp-Source: AGHT+IFuaLyh5rZN41lvsB+tSDwg9mUbhka3R9DaiCDOgw3Lk8qkgYKwcbApxw+6Cxa16c2cpCR9sYu3JEGV8UiVGIo=
X-Received: by 2002:a17:90b:a43:b0:29b:ef73:44ff with SMTP id
 gw3-20020a17090b0a4300b0029bef7344ffmr2937330pjb.1.1710162558275; Mon, 11 Mar
 2024 06:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240308141801.49081-1-jpaulo.silvagoncalves@gmail.com>
In-Reply-To: <20240308141801.49081-1-jpaulo.silvagoncalves@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 10:09:07 -0300
Message-ID: <CAOMZO5BxUO3nEe+BR47quLz0wgb-yXaFJELbtLjXy00EPHA9Wg@mail.gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: add 0087 i.mx8m mini product
 variant
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
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

On Fri, Mar 8, 2024 at 11:18=E2=80=AFAM Joao Paulo Goncalves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>
> Add new product id 0087 Verdin iMX8M Mini Quad 2GB IT.
>
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Applied, thanks.
