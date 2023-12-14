Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A654C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B66F87B40;
	Thu, 14 Dec 2023 19:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lhjwHXT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D9387B54; Thu, 14 Dec 2023 19:13:28 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1384B87B40
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cece20f006so84147057b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702577605; x=1703182405;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCdIYbX2LcwCQK7MedsibwXCeIkhRDT6CeWtB3Le+vw=;
 b=lhjwHXT9fYdj3FA7dIJz9sl0cf5XZCGknEskUBOBQOByp8fiT6lS16PPBiXxi2OceU
 CV8R4eReaDKOZFbT/aD8iRAVOHQz8z/WsDO9h72wAL5QEQ2N/vIrWIEgVDFRYbD9lDgV
 Oowpg5UpbFpM4WWpS7OJX3hbNsrlwjWG33WNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577605; x=1703182405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCdIYbX2LcwCQK7MedsibwXCeIkhRDT6CeWtB3Le+vw=;
 b=Cr/Rw0rOM9l0JtkDKGjXPxs1q5Gvyd4jy9ufWJix5fYUOc29MKbFdQAKR+qS2cPCo1
 eKWx4z9isymkmna5v4JNWgqbgunmWda/rmr1w5/cnW0ILN+ju6/vDBW83ZFyQcAJyiBK
 is19jfcaJ9Wzo/dtZpgciQh9UA7dFrogiZ8Ee/O2S1TBUcNtCEVtyZ9kfGsNnFMuZNsb
 IOBmGiG23aFzEXyZYaOLHo9DIzicIKmezHAcsbHehp+O3DSPMwPp9cAliyrLxNEshNz0
 r3CStbqADOBNWhJ5mVxnSqpISsVhPaSNZUbr0/UoD3XAT5Z3gbUi3fILK9BQ4uVAG4HA
 m0zA==
X-Gm-Message-State: AOJu0YxuDfSzZhCiqgHg3qe8/CkG5Eg5U7YaNmdlFsbFL4x4xh+F7ZZp
 PYi0tvLVYjr3eEm5T2Arxd0/fZO8ZdsywYQt/Ky1NA==
X-Google-Smtp-Source: AGHT+IHOtn9U+eVolcHkYz5t41gUArQ+IjecGuwreBPvWMG1FejvjIaTopEl4CFF558vAaCZlTsAfEC7rTYFWVZO4D8=
X-Received: by 2002:a5b:b05:0:b0:dbc:c39a:b3cb with SMTP id
 z5-20020a5b0b05000000b00dbcc39ab3cbmr3281934ybp.95.1702577603825; Thu, 14 Dec
 2023 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20230804022548.24138-1-jit.loon.lim@intel.com>
In-Reply-To: <20230804022548.24138-1-jit.loon.lim@intel.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:43:12 +0530
Message-ID: <CAMty3ZCwc_EEdRFn4d9RL9b1rZnwUi0YqkujcuzMFDNeiUc8fQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: mtd: spi: Add support for GD55LB02GEBIR SPI
 NOR flash
To: Jit Loon Lim <jit.loon.lim@intel.com>
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tien Fong <tien.fong.chee@intel.com>, 
 Kok Kiang <kok.kiang.hea@intel.com>, Dinesh <dinesh.maniyam@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Sieu Mun Tang <sieu.mun.tang@intel.com>
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

On Fri, Aug 4, 2023 at 7:56=E2=80=AFAM Jit Loon Lim <jit.loon.lim@intel.com=
> wrote:
>
> From: Teik Heng Chong <teik.heng.chong@intel.com>
>
> Add Support for GigaDevice GD55LB02GEBIR SPI NOR flash as QSPI
> configuration flash
>
> Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
> ---

Applied to u-boot-spi/master
