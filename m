Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E310C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 12:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71C5841C2;
	Sat, 27 Jun 2026 14:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ze0eK+px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2315842FC; Sat, 27 Jun 2026 14:26:39 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEC7805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 14:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39ad400e762so10502131fa.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 05:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782563197; cv=none;
 d=google.com; s=arc-20260327;
 b=YYkvJbHaKzaujYdIEQBLK3DM2IJKOYjL86qU4yVTl2O2Cf+6OHOA5SRCa5cEqT8qb2
 NRHOXFs/5tpTIm7benBMVdmPBE16V43qsgU5D2SVjvGrSc498IEPuyRJFssyKcu78lyn
 MFVqJ+VJ6o7xLbZEMx/KiGtfJyuh+Qx0u7w0cm0BctYSRY7GFej3ZKFPCMB9b0gM5Add
 QBR+bjhXSglaCPuKSE9EgG3FYz4nj5Y6BKO6umkertFc4628ARP/KNOoYDuMIM8Th+tT
 GMuDL8peqw/UhB97KO6YQenvWEL3oYZyW6x6t6IFSQPFu2e1gu3GdcmSpo4t5Y17yyVF
 85og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+FGTvugBr6HdKSUx8G2DNQ0tiPcZwJ/UaJVAbBLuoSY=;
 fh=x7e/pGv4TKP8EOTomru4TrANzH0f3Qjdg/hrZNHxSQg=;
 b=M9VaRdD2aMexxpt8OndwvOHir8qmeQjT1SAcG9Ukk72w5uq5WqGMP4s4THl/5hPFCC
 qAiPNXzuvkWHiHIzkMLFnwdcqfg/MQneTGbj8hrUXEAaCtx7GdDxGMBU4UzlRfpCzGEO
 F8bV93JIqraLATsLVZZKNTbrcMfMSdXvFEKZac4jlYQkIrYY+O3cGvG9WgHG7Ckp0aSZ
 Xo0zDhOAsWkuZG2vo6l/G6ltC3hDVybIwDdjiCCQ7G0f3vyM98+KDpZZZhi1GVwhdWkN
 mjbePu+l5See3+4hcpnPKoF1Ovm1ogOgmMYFv5YVnn35FPVPTqzgBaGw1JT6+iuPGmGt
 mcZg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782563197; x=1783167997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FGTvugBr6HdKSUx8G2DNQ0tiPcZwJ/UaJVAbBLuoSY=;
 b=Ze0eK+pxTuRjmt9OdzK/WrAPrKV335Ck+BYIN9JT2zkQHnYr1u4kHQY6VdUMPGgUGI
 wo6Rl9JPGte00g95VVVs2imJlHiU/ubP79DbmzzeizQZdHm6ec7Vvp5lSXW2AFRKlerR
 vUNYyPYovoiSB92PQQRLgwlrHDej9FoZtz8taxpav0aE4A6mX5/z9P0wWQIkkN/In2Su
 VQLSpmz5hFkgoVOiCtEOaa1vwffHkKZszq/oQPSBt/pyB9SOjtj4H9bP8w5JVML/hQLB
 VfLZQUiaj2NUrG6/qIKIDaWelumLzyTjE7SqhBR5qMagWyDg9U6qpR5UePp8BgjRX+80
 LgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782563197; x=1783167997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FGTvugBr6HdKSUx8G2DNQ0tiPcZwJ/UaJVAbBLuoSY=;
 b=CjEeFneyD7PhntPvbg4h2ZXgFSKdvbGndrcEln7p4+x8m0WrG5GW0BK+YFUBzVSs/b
 h8+FA4KqgbOKBKJF0izt2ZSjlU5AWuhJWj6+Ss2KDiIu61t33Hrj1My6HfmVYNJPS4EM
 EhTi6OhlRTTFIV0tEi2r+Xv1YHzgel3itN7+XUefuJn4qYiF4oJ4IbjOzVDHRF/FoL1C
 oSGZNg9h8+Er51YD1W08w/P1Ml1qhNgljUWGuYxF+dUITtt6nBrdPQguZWzwtxoAkqAz
 rkd/LhLHkO+pyAAN5uSz4XpIqO65QHZbeNqaiW/w3i/Lz1tSrvY3fd1S37h91tc5+pZ7
 880Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK75jZuiMAyh21xF2PNjcIIJ4XBYptioU5mTf44E6eJmh5n4JF++GS1sCiQ/liD9ZPojX0UeA=@lists.denx.de
X-Gm-Message-State: AOJu0YyweEH+fPyw8Nny6dxnmci0uu3n8m2bk3XswFK6cJIKtYIHuLi4
 QtbBvBUP6/b+aNi0YUubamQ7EiXzcuESbKhEL5ZDezO9DMlSTFO66O908FUJiO8ewuyGCA5RM12
 yzXZTNM/xYHMXLeGAszPoZ8OfiftHcYRISQ==
X-Gm-Gg: AfdE7cl4MLlHTmHAuAF/zjdaY0dBuKEosQ2ZRp389EozQyAzbAMOcpoOorPaZQDCVxr
 c1VH0zCdSO0z7zDomuVXlCPQSyozuOhttkzwq7FjarA4tAC9BTB2N8Im8hcPisUgz5Itdleh/zN
 iOsW84h/43J6oeH4iEJnvWcPfmnkN1ASOH6055qIdLdCSihlNaNWZp4HU0cjKraqL6J0mmzTUAT
 tU5keTuTKa2AC0wRVpeoUoN2zqZoWZnyEQovlDxw49DAxwQ+tz3EhyDiglT6ar3thhNo31JzTSE
 Pqp40o3VnAdopHRm4aZ8MrN6OHO2RvezEUSMJiT93jkxbBn/4MmdjUThiZPskw==
X-Received: by 2002:a2e:8045:0:b0:393:e571:277a with SMTP id
 38308e7fff4ca-39acb63c1b4mr20609351fa.9.1782563196710; Sat, 27 Jun 2026
 05:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260627013852.3002838-1-festevam@gmail.com>
 <20260627013852.3002838-2-festevam@gmail.com>
 <ddacbcce-17de-4ee3-a5d2-fdb5cb4ee777@nabladev.com>
In-Reply-To: <ddacbcce-17de-4ee3-a5d2-fdb5cb4ee777@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Jun 2026 09:26:24 -0300
X-Gm-Features: AVVi8Cc9fXzRdJSkWijZE_Cj8LViomUy0-R3ufAuZZt4MTYZhZ5DW7bpgL0ez-g
Message-ID: <CAOMZO5A2NpxMxUbq5M2npFWYbhDfviR0DHYip7ChnpFNyVDJfg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260626
To: Marek Vasut <marex@nabladev.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, alice.guo@nxp.com, 
 ye.li@oss.nxp.com, peng.fan@oss.nxp.com
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

On Sat, Jun 27, 2026 at 9:18=E2=80=AFAM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 6/27/26 3:38 AM, Fabio Estevam wrote:
>
> Hello all,
>
> >        mx6: ddr: Subtract half a cycle instead of three quarters of a c=
ycle after DQS gating calibration
> I am not sure whether this one should be really in master, I would like
> to give people time to really look at it.

Ok, I'll send another PR wth this one removed.
