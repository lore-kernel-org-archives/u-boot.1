Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A7C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB7087ABC;
	Fri, 15 Dec 2023 15:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jdlmqXw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C9187B72; Fri, 15 Dec 2023 15:36:12 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A22C87ABC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28b1478d85bso79130a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702650968; x=1703255768; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2UjRcuC7eulneU7JVxXGQTSiU1/yky/1NOKMgPct80=;
 b=jdlmqXw5VpfB7z0SltSieMqHYIcwlOYDu7JEcTqP/Fgm4mecTxsXSX7UiegtP+JG0+
 YQ53LNA8rFbPx5FZHcFXEorzCzir7nsYETg6aUDqUXAgcvgPANfDXm8hKB4ShS3wbbq0
 0JWIVGzKcKLc54uHJMg+2VWr9MJCkJ8YzMfzaXWO17GDTlaKLF8owwDJIopkvmd6iMso
 TVQVmjarc2WC9ItlKUlhKRKDroyt3UmMHyvQ9kJf5GjWpmijQ9im2DM940UolOdFYs0F
 RCoV4PrzO9dEKF7gljpKcglW37Bc0nLeW20TJ2M3I/hLk+Rb7bojvtTeMMJVc/ENnRfc
 GZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702650968; x=1703255768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2UjRcuC7eulneU7JVxXGQTSiU1/yky/1NOKMgPct80=;
 b=kpttEV6/HY5UiG/yUFrTDPXM4d6dQ2wVp3s8rCNmEzJnaW/kUl7clDWNM6wEY36s70
 1wgU0Ntn1kxmkIVAAgX3rXc0Yr5I3t8vElHmxOYpHdE0d5ClaDd7Qk6MflkZxtYNEsGh
 XT9sEcU+go0evPBKUYNAZYgwoi4DUK/WClHhZDftTCKY0G0+xHnQTXms7Z09SMnnVstU
 zi/0+GTrVd3N48dg+F0VodxVhQqRfShx6hkuHGbzWlKOcpDyRo74xhy5u8mZRwCRCLKN
 YUxx6LZaAYnKnknmOe43aSnv6e+96RKS6/YK+Cu2XSrTbPMqpMv8K3E/BrvHpjUn6Y49
 uaqQ==
X-Gm-Message-State: AOJu0Yxc9IHWnGJsBgDrApmOz+r4Z2n7JKRvB1mHOezw/QiLMzAL6n5s
 BxUCIOo5DnlCX6jDU/os0/kO5u3YWlP96pzemt4=
X-Google-Smtp-Source: AGHT+IFF6OTQR2o3NawagcqbBScqt9/J9zWuLgxApDS265uskBFr3BDurePhpDijPMjc2Yf/Ex/fPchjTBvz4LFcxPQ=
X-Received: by 2002:a17:90b:a4e:b0:28b:4007:a7b9 with SMTP id
 gw14-20020a17090b0a4e00b0028b4007a7b9mr239944pjb.4.1702650968517; Fri, 15 Dec
 2023 06:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20231215111333.31286-1-sebastien.szymanski@armadeus.com>
 <CAOMZO5C8F3EpzpMS3=XC5n8uzzR30LBpY9V7t-Het7NEe+krXQ@mail.gmail.com>
 <8e73cb81-b40e-472c-bfb6-cb4ff32dff19@armadeus.com>
In-Reply-To: <8e73cb81-b40e-472c-bfb6-cb4ff32dff19@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 11:35:55 -0300
Message-ID: <CAOMZO5Ao-uwqRTCbDx-pgU17-cRJJDURp5DxT2W7uHgNXqtx1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: pass -ansi option to cmd_gen_envp
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Fabio Estevam <festevam@denx.de>,
 Heiko Schocher <hs@denx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Eduard Strehlau <eduard@lionizers.com>
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

Hi S=C3=A9bastien,

On Fri, Dec 15, 2023 at 10:26=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:

> With the -ansi option, the C++ style comments make an error:
>
> include/generated/env.txt:1:1: error: C++ style comments are not allowed
> in ISO C90
>      1 | // SPDX-License-Identifier: GPL-2.0+
>
> I should have mention that in my commit log.

Thanks for the clarification.

Please include this information into the commit log a and submit a v2.
