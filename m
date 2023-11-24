Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F47BC61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 16:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E22986FD2;
	Fri, 24 Nov 2023 17:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="wxV2sBO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C278762C; Fri, 24 Nov 2023 17:51:25 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFF386ECA
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 17:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7bb4b7eb808so574651241.3
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700844681; x=1701449481;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ES1P5uzc8DR8LkBnX+OkusY7x8Pva8cNKMqEv6eBVaU=;
 b=wxV2sBO29FhHOGwNzmU0J4TCNygWIUqq8EVyzc+MOrqYWaUxRC7np7MeOf1axlNfSP
 11CzUHhUAevP841gv8HzT6CCe/DfA+XjT3vfmgCnbHKSRBqeSEVmQdSvvQAh2KNMTKXP
 OIxx/0bytnp951Vt8eRxYCk4LK0V/uJ77quSUOBEXxrmotAIqX4PwNgu1giyYlR7IvI9
 oJi91qsua13uUUeA/ul1L8idGSaHMf1m7D09ooH/4MDEJ1caec+4bkyPn6V4nQIfxLBK
 LzV8r/MxssjueUA3OTmjB3KMjDjAYKb92Nbzv7L9hpCLcWUP8FkVXaCYrxlpT/5L0Yn3
 a78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700844681; x=1701449481;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ES1P5uzc8DR8LkBnX+OkusY7x8Pva8cNKMqEv6eBVaU=;
 b=DSqGLrWtd3Lw8lAjhjMDRv7jGQVzphW4uV75pbl4IHs0by7NeDm7dF25VYve0O0pSg
 9aq6qW0tk9Y3FZ5tExKSQ3esvtlCYcMgcFkKT2AU9GQp7OFj6hR8/PotvYDrwMCvSnBj
 YqZc9aUaiuKjyEXXFQ876Y789EGB9Ihd1pSuXBdZ+m4UqMxFgYT0S30gAI4QquMyFezr
 ApgWqv9YI41AhE2/4iUizORSLfVi/eSVSE16oeNDBcjnuWf17/4uKEYa8hstOhGv9Zxg
 ZwP5sa+rS4GW1PJhg2l+/jPhYvqfcFw5hJvzE6EcdZiu96RVBCn6r1nHoWaMWeij/mDB
 aQyA==
X-Gm-Message-State: AOJu0YzyX1BhM53xI9RZYeJiM0mdyJGmxxpXcHxKJUj8hQeV4n3aHM+N
 0humuU21L6wT767a+QRYXU7OeCAsh3dKrYX36ziYFQ==
X-Google-Smtp-Source: AGHT+IEMmKzeyGWBUKQPf77vnTNJOz3wAB/HZlzTCkgAiz5l7gUftf1ENk9BLYWGhT/GNP1w8x6gEAX2BmwEVEW2VlE=
X-Received: by 2002:a05:6122:da5:b0:496:248e:43fc with SMTP id
 bc37-20020a0561220da500b00496248e43fcmr3620111vkb.8.1700844681000; Fri, 24
 Nov 2023 08:51:21 -0800 (PST)
MIME-Version: 1.0
From: Shantur Rathore <i@shantur.com>
Date: Fri, 24 Nov 2023 16:51:10 +0000
Message-ID: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
Subject: efi: Set Variable Runtime implementation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, takahiro.akashi@linaro.org,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

I am trying to work out how to enable the SetVariableRT service in
U-Boot and came across your patch [1] which initially had the
SetVariable RT service enabled in EFI but in the final patch this was
removed.
I am hoping to implement it on top of the SPI Flash EFI store [2] to
be able to set Boot order and boot items from Linux the UEFI way.

Can I pick your brain on why it was dropped in the patch?
Is there any limitation in SetVariableRT service ?

Kind regards,
Shantur

[1] : https://patches.linaro.org/project/u-boot/patch/20200331060541.4212-1-xypron.glpk@gmx.de/
[2] : https://patchwork.ozlabs.org/project/uboot/list/?series=383699
