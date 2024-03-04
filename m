Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAEFC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C8887F86;
	Mon,  4 Mar 2024 13:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiOmcl9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680FC87F88; Mon,  4 Mar 2024 13:16:35 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2C4875FC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1698867a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 04:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709554591; x=1710159391; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqDqV3pXnC3xWDvG3PBQcEtA8Tl4CNQ2khyqyj9w6qE=;
 b=kiOmcl9Bd1BEpoI1Uv1Y6N9zYWWJDb31OWHzlGYrwFiTrbhpfqcghqUZc1Qflt+tA6
 YimyMVu0pJHZFRRa2vxeWDldRrzplmvGX3B5L/cjnYa0hS/TNM7FJNOjZTdBtS4557tQ
 gIez5Yvsf5BgBXgiBgCAYxjlGgxu2csKRnnMX4MEzjC0jGrsjl6AGhBYxSHVylkK1x8o
 PRgL6e8F8NUXTOMYsKERqTSvNCaDoTXNJImiqdahHVSAhhOryGXKbMnojsgP1zAdW5pv
 hm23ueOMAYj9K7syUCy/f4/SuT5J1ZvGjVe3e6A/X6LZXpe7VsEMPbKmm2WzkR7hPJ4i
 vUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709554591; x=1710159391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqDqV3pXnC3xWDvG3PBQcEtA8Tl4CNQ2khyqyj9w6qE=;
 b=q3r0NEuss2tB0FqP70T16WtGOCJEirt47zXlplilPSDy4aaFn1ZbloWAmiM0VE5qY2
 hNV9WWFeR6DkK9mkqPmogu+tTCIr6tFwxeoi8u8MOFkQrb9Kxh7m+muRnmh7IztMfQlq
 JMjxJ4uUE4H4NCqqYBarjb4oMC0jDcp5BMCds3t450FmhsS8NL4Ty/ueVTKS0ACvkV63
 ZYNhQpmxxW0qOwv0oVke3xtBDPEP9YZKj6CMyGrv8pwMq7VyyjzE6IwBLSTHIF9p4HRq
 /uTibDmwrR63w1BveJ1ddGQdIQA+V9Guh0aCxgSRYsF0Ojz/W6TFmNxbGPJl8YV/MbQr
 5w1Q==
X-Gm-Message-State: AOJu0YxGq6kEvonGdUJEe6UBOSZIqw9m8F1bfswKURHIydRLswPZo9V9
 QPQDWoWDX8fBDWTvg+CiIQhgVOjMXPz5oqnbKieQrosXkz3LxrK80mr0KxwWn0aXbiEAwBRcORU
 nqpRl1EjHSicvf6X6lEajOmfBA/Q=
X-Google-Smtp-Source: AGHT+IGCLA1sGQpnA/63+t5tBk8dZP5lhA/lOuMm2tDqz+Fps1jV9IOM2O0zpJBj436tG6uuSJKZIj2C1NpwQYs1N4A=
X-Received: by 2002:a05:6a20:8e26:b0:1a1:4de6:dd5c with SMTP id
 y38-20020a056a208e2600b001a14de6dd5cmr4476243pzj.2.1709554591620; Mon, 04 Mar
 2024 04:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20240304121257.3551104-1-sumit.garg@linaro.org>
In-Reply-To: <20240304121257.3551104-1-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 09:16:19 -0300
Message-ID: <CAOMZO5DbGN=6rGGx1BsPECbA4dhYt1VD3=C5k9ZswX3Rr+HAmw@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile: remove hardcoded device tree source directory
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, bb@ti.com, 
 nm@ti.com, n-francis@ti.com, a-nandan@ti.com
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

On Mon, Mar 4, 2024 at 9:13=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> From: Bryan Brattlof <bb@ti.com>
>
> Some boards that choose to utilize the OF_UPSTREAM directory for their
> device tree files will need to specify that directory instead of the
> traditional arch/$(ARCH)/dts/* path.
>
> Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> is selected or not.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Tested-by: Fabio Estevam <festevam@gmail.com>
