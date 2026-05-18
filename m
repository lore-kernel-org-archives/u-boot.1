Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD98CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6980A8469F;
	Mon, 18 May 2026 23:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pZaE50pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB7B846AC; Mon, 18 May 2026 23:54:56 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6950D84694
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39394e1e8f3so30231331fa.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141294; x=1779746094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bulGEaixZdSZyfCVLhPkJOljNeJgk0qv/M7h1tDBlzc=;
 b=pZaE50pfycWYk14UZb3ZP8ublchk/S/eAi01VdxiTB4i+3h0wUMgv2Emf198gqlEDQ
 LEUTY2YpjOQsNRtfTEwGEMFoPYOaT00eb9r5qbXnDXu/bJnPz5E4UVvCnb4jhfH18J7a
 h/TtbdNOPJRhE/DempNG4gQeRJ2rKqfnIya1UBaeX9mwrcB0/P9ja0h2lXzR9Q5QB+pI
 Z4O9k79GTwbl2Ksj0OXZQ3mqdAt4lESC5fLkMwH4BTU2v3Ix0Q22GieyJI3dEvI5ASqs
 7FG8ZC+NsJlRVajLuThcGWQZ1s2Rp1UnkCEYdPJEpzDiP3kY87xygiXNrb5h7t8VpQuO
 VG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141294; x=1779746094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bulGEaixZdSZyfCVLhPkJOljNeJgk0qv/M7h1tDBlzc=;
 b=Yovkna810FOlPhS4V75/8cVSZ7Na3s2qrA+JQhcLZo31OSdSwX8s5lLH4WrKNYs0ah
 hdnsjChi0txAE3x3gTQF+oKZtCr1J2v/YNUkvVDm7QY6NuteN+4N4lLXP6bm3B97V2tU
 i67vxkS7ebHms1BDqdc2w4/PNgzanZL/y2UjUs9RXJwAxpr7y9CIOCYXi929FjoEbrJ5
 iEcVIN8A21L1/IC0u7s/laDQH6JB5MABdoRJfsSsP5zzJP3jcxyW+QB6yHjQDpQecyFC
 XOKScSdAJV7bDCxOOhx4SyN87juw+XlmoIUPdvagp+oZ0CrYJ1F2lhyhkIvHkimYOgfc
 EiVw==
X-Gm-Message-State: AOJu0YxJEH6GiU3jiccX/qZ2FtXN+qIfQTUDheyM+axsa2rI25JnUoII
 0qkwmqNcuL0DIEllrz51pq38GEQKw3fLMV4Ve9OBQnJ8dpTlw//ukPif
X-Gm-Gg: Acq92OHpOfiH1q6WEK9RUXFkrFwOcz7t1dXk5YkXint8XHEjX8WVwmft9eO1+C0ouKd
 dVSXd6/qf8/ce11QzqBJPTQKSHd9qvZ4CLjtVeRadnhfSzZd8Wm29V3GmFuHGdkjX9hogRr7/zp
 vkyCW/tp5cM6Pq1PObxWxn8Arutel5+vXEQZCVcLegVSCfYq+6bOT2C3XfcecHBQP+8JpFRLD9F
 GI497BPTRt4uF93ZToO2BfTlAkIDnIPJ5USnE1KuaMzuO/yw3KXyJTfk67tEwikECNyxhf2PqA2
 wpSGnaJH9V+NfFW1maQKXgVaMNkP+zX3pvihQbnWnjTmSp6Cs3pI5FVicv0Yl+KzvBFo36FG6K+
 2iMqSnvGh0HBdHdnMCYTp7GjlOFoiVjpYZG4Hmc3pZ3M6flUd7iH2kkcPb5iUzyxH4GAmO3m8pX
 UYQwfwpai6R+ZkHCSxWyzkdQS8nZ9bAPbYgJjxVkdVK6HjiY9/0DZ1vR0u
X-Received: by 2002:a05:651c:1608:b0:38e:7a75:8763 with SMTP id
 38308e7fff4ca-39561d60079mr51939301fa.18.1779141293387; 
 Mon, 18 May 2026 14:54:53 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882c3928sm15158541fa.11.2026.05.18.14.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:54:51 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: brian.ruley@gehealthcare.com
Cc: u-boot@lists.denx.de,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 0/2] imx6: fix LDB clock source selection bugs
Date: Tue, 19 May 2026 00:54:43 +0300
Message-ID: <20260518215445.175753-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260518205734.163815-1-shofiqtest@gmail.com>
References: <20260518205734.163815-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Two fixes following Brian's review of the v2 LDB clock series:

1. select_ldb_di_clock_source() had clk0 and clk1 written to the wrong
   registers (LDB_DI1 and LDB_DI0 respectively). Silent until now
   because all callers passed the same value for both arguments.

2. The CONFIG_SPL_BUILD guard in clk-imx6q.c was too broad — it
   excluded SPL builds that legitimately need LDB clock init when
   CONFIG_SPL_VIDEO is enabled. Also adds the missing guards in
   aristainetos.c and b1x5v2.c so select_ldb_di_clock_source() is
   only called when video support is actually configured.

Md Shofiqul Islam (2):
  imx6: clock: fix clk0/clk1 swap in select_ldb_di_clock_source()
  imx6: guard LDB clock init with appropriate video config

 arch/arm/mach-imx/mx6/clock.c     | 4 ++--
 board/aristainetos/aristainetos.c | 2 ++
 board/ge/b1x5v2/b1x5v2.c          | 3 ++-
 drivers/clk/imx/clk-imx6q.c       | 6 +++---
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.51.1

