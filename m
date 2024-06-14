Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22708C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36F9889B9;
	Fri, 14 Jun 2024 13:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9DzdXXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF46F88926; Fri, 14 Jun 2024 13:58:52 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6FE0889EA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c2c78f40acso383779a91.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718366321; x=1718971121; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7Ulo6sHpW8Bbfyd/slDn4+zv/dnHKGHG1ol8izd6BM=;
 b=P9DzdXXXMtbHBaxjrkxv0f5TAkvgz+YnD1Og14QHSiAWQkjTuSA/aAbw9ctumcfmuE
 YXtzqC3QrQWwKhALm8ggrtQbs7VZyeZzzQ3N/nIy/bTssK+OuKzj5vOZv9sHNbvMXI1f
 D2GoM6BgaOstOjgDAWmMMH/A2n/DNAduECo5GPLCvSn9S45yP6h7VI35iY/wijA1DIxP
 ElbO8Al9h35I01Wfm8hXwaKL4n+VWnEFLDd7NKCHOyTGi00RyBfGKyntjcJCpTQ5OKi8
 8mDUp5xNzaDCwICWo43dEPcRBL6vj3/7k9XWMTq4ZgoeK3OtfG5HvmuGM09X9EvQCg69
 N8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718366321; x=1718971121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7Ulo6sHpW8Bbfyd/slDn4+zv/dnHKGHG1ol8izd6BM=;
 b=QiAG4InLz3LZqMA3Jk+l7IbGfnUHmOOtikYnt55fFYwneqXSP8EEZJloUa0zDCVKql
 E+8lNFPCmU5bpWqTo7uQ/Z6xgkHx2e7gbEwbo03Da6DRouTPSW67XqgjlztpkNpF8iX3
 0zWxbw91ifai8n/A+uQOk+B5OoLQkucKMzuTItCp8ull/RKfd2WFIH/UWkrUAUZjOwO+
 dYOkZwOdZuM7JVmA2CQ09dR75pZyW0BFhp030+sjgCLec4tqrxnc8OQ7W6/ELEHG7UJ0
 OBl99hIay4PHugaT5o9G1tiER27URQF+WwNCFKYnEInoMfnCWsbrVDOP5ukPmnOMvP6P
 FH0A==
X-Gm-Message-State: AOJu0YwFum+9D864kofdxu5/d38u0NlNINMONLtCNVW0q+tsPGfVLAhX
 HV9/hAyAbYUemxW+TiQXAETdUYs1JDsMUZTpGR1YTJozvmYga/8mZMZTCNj60xDw2cYFirMN8RA
 WwH9NT99B+siw2SZHyLaWJaUw/PPOH7q1
X-Google-Smtp-Source: AGHT+IFUdp2CHxo4hFuoHor3xewU7NzzdbqzT/gfw+8AFOzCw7U+DsT97pKXwfJCHqRuNc3N8O47zNBOPpEaS+ut7NE=
X-Received: by 2002:a17:90a:578e:b0:2c4:cd15:3e4b with SMTP id
 98e67ed59e1d1-2c4dc03a6a5mr2448963a91.4.1718366321283; Fri, 14 Jun 2024
 04:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
 <ca425556-fdbd-457e-8713-5176f925cce7@seco.com>
 <fad372cd45b13bd15fb07c10c66802b0a03b4f25.camel@opensuse.org>
 <CAOMZO5B3krB1vyibGNYej9nrPMkOXh1+P05Boqd2Vsr1E5nmcg@mail.gmail.com>
 <e807c90eebd0f5756de613b4773d39aec71bb064.camel@opensuse.org>
In-Reply-To: <e807c90eebd0f5756de613b4773d39aec71bb064.camel@opensuse.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Jun 2024 08:58:29 -0300
Message-ID: <CAOMZO5DhJeQDQ74nvCz_q2XRBU4FzQxrDbuL9UPJ29BHzmB3rw@mail.gmail.com>
Subject: Re: silent u-boot not working
To: Jonas Kvinge <jonaski@opensuse.org>
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

On Fri, Jun 14, 2024 at 8:51=E2=80=AFAM Jonas Kvinge <jonaski@opensuse.org>=
 wrote:

> The u-boot logo in the upper right corner is still showing, is it
> possible to disable that too?

If you don't want the U-Boot splash to appear, you can remove the
CONFIG_VIDEO options from configs/rpi_4_defconfig
