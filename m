Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94084CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 14:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9CD83EF9;
	Fri,  5 Jun 2026 16:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="nIYR52Iv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCB0840ED; Fri,  5 Jun 2026 16:31:06 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809E1838BB
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 16:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8ced8f44da0so20602476d6.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780669863; cv=none;
 d=google.com; s=arc-20240605;
 b=V29626WzbAeqV+EGWKLxVYve5+6C3bINwulzQ1ONqr54Pv0lYyxv6NS1vxbS9HX+Kh
 DQYT8YFb4xWsRqsBCC45F9ykTkhka5j7dFiJcw3+RQgbpEAj2X+C3l6JXk3hKQSefMC1
 NWvO48Ucww8FqonGMdfJ0LflzveblAYXsJojBCeRFrlOwlIbM11WSOXJywM9fT6SH3hn
 pkA4J6Uz99x0f2TD0Ev6wJEn8pCpxnGj7xk0n9IZHEBMF1DAw4TWlO2g/NSaExKIowJT
 2TCfAK2dGOmJHeAVwZBiYdR6pj0soMPYQnmZ1sKl43f4IStRew+wDS8fPZPcxJFq8oBD
 sZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BayOqsFN+zLqRud9bB/NEWmcZL4xqZ+JVz3Ez3wHnvU=;
 fh=Uq/KN9Y6xjfKMH2kg5LKPJXuLRYWI5NchBvZmJBe3ZE=;
 b=TR0d5Coxe98yXIXPte+219Z7SW9T2rev281p/FjzIku9gEzmMLN7ua3NSLWOtRVqRn
 j58tFHq7u3Ob9bLyWilOrtwUOxpVXlzPN7tQCjfykcvZeZK57WieY9SLD/px0vtpZUB1
 MTDrrTN+7LRtoB1MtTWaP62IFWMFSBmFnNvn6pBRMzZJlUz+yeBEsJ+d1TH15365g/nA
 4hsEMRHOIkZLksD5dSpFDpr8P4syXitl4gpUX+oyJNl+lBnl+tLjyXtEll303mgJvX5T
 l8r/MTeqRkJHgX5vEyOWWGP2aB7dT/TXXheCadNLVhN8hByVzTZZUB/bHMTXP/VctDHE
 9+XA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780669863; x=1781274663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BayOqsFN+zLqRud9bB/NEWmcZL4xqZ+JVz3Ez3wHnvU=;
 b=nIYR52IvycRY1YkpkPNfQZJmeL0JWSz4tc7zHrGSmkDl56lsUU2UdcmIb0HTj/aq1q
 oafNzA/uufS2I4Iqo1SDYcWfQxWaLIVYCFajcBsdxYtXAI9k+m2SJ3mnYFwM2Jp7onoR
 W/zsOD0HSklJwVByjtn1web/POt84H2RGA4gdQwdFf1C1HRaMQxJilQcoaCigflI7RDI
 KFjFVhu3dhKjUTPx/5lyZ6jFy67duc10mllZt+0bBF/XZ452fKfGGX9XU+ZgJ+3d4IDt
 ITIZou7lHr0gSN2D47oqO2UFPerk0uxRE9yONukQbsVdQNtIReWUYsym4OUiBjJ7fvgo
 t8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780669863; x=1781274663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BayOqsFN+zLqRud9bB/NEWmcZL4xqZ+JVz3Ez3wHnvU=;
 b=ZXav5E5OaSDH+/U/8G5oy+fM6bi9XiYm2A537aDCKTxGvDw7y3MJJTiQXdGx45qhYg
 e9Lr9IsAgApNqCS6Bxyb/iLognkv420cCwWk2EjojyBGUWuqsc2M3HNzld1qBD62RiaH
 /1JkyOjZK8c/LxgLifKIB68zjWcLfuf0buzo8rg2KwCfMp3HzvxUiuhBEFEIwEVo9h5s
 iRnbJj/sxdRN9oZvzWx/65tLEXoUmnFcHft+o7ODFu8NKiWFO6M2PZtt5tKlwuY/r4Ez
 xmHQAWwRf5DAsAwW7H5V9ht6cHN/P/eyuQQGFzcVkJo837sSxCBtzStypP4utUSdjEzR
 IeUA==
X-Gm-Message-State: AOJu0Yw812QJEHLp+d/seG56VynQ3BHf0eWxpOqBC74C4skHBjVf3pV7
 9+T3xjL7hh/oXFJ7iyIO3U9pE+0sP78dJVevK+2syL8difmspKECvTi9qR/zJzyNvwBMloNAjZn
 ZrTj6o7Sjly76hQNJQKqoCdwxiIR3d4O3Ok7czOl2ng==
X-Gm-Gg: Acq92OGnmPCzxEGst6TKQpxhXRhYq3gbvvuXiLuxoM3BEMwQ43/afIX4oDFr0/uVZIZ
 Bk1teHAXZssWIV2TA0Ij000aOZohzhMMp6fse09H4s/yb8DO9dgOTKxlQpOGxnESihC9ve4Iuuy
 L+APBm4BB+vK+/Nnvu9lINgx4KxxVWFaO90P/l4LnuKTuNZIlDsyRHpM0GgMB4cZACK5dFAXKlW
 32SuK4YG23pLDdNZJsu+GPzxUGNdIJFDmhogZoJJTEYTeJhH94ACcXmWhNkaK2o7GWzsuoy4Rl5
 tqUKNAdfwIT9uw==
X-Received: by 2002:a05:6214:2025:b0:8ce:aace:eaf8 with SMTP id
 6a1803df08f44-8cee63b0cdbmr64602396d6.43.1780669857796; Fri, 05 Jun 2026
 07:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
 <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
In-Reply-To: <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 5 Jun 2026 16:30:46 +0200
X-Gm-Features: AVVi8CdL5BasKHNEVjQcLmCHW2nPK719ePBAEzVorxhBePAWCGSq_WVg0r-J6Ys
Message-ID: <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
To: rmandrad@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, ryder.lee@mediatek.com, 
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com, 
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com, 
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com
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

On Fri, Jun 5, 2026 at 3:07=E2=80=AFPM <rmandrad@gmail.com> wrote:
> > On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram <rmandrad@gmail.com>=
 wrote:
> > >
> > > MT7988 detects the full installed DRAM in dram_init(), but after
> > > commit bddd6bbef3dc ("arm: mediatek: mt7988: drop
> > > dram_init_banksize()") it fell back to the generic dram_init_banksize=
() implementation.
> > >
> > > That generic path populates bd->bi_dram[0].size with
> > > get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
> > > MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB is
> > > installed.
> >
> > Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header file =
that contains it)? Or is it used somewhere else?
> >
>
> Not the header file as   TARGET_MT7988 sets SYS_CONFIG_NAME=3D"mt7988" in=
 arch/arm/mach-mediatek/Kconfig

We could drop that config too since the header will be empty.

>
> In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere than just in =
common/memsize.c where it limits get_effective_memsize()
>
> Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above 4gb... Some=
 MediaTek ARM64 ports may keep U-Boot below 4 GiB because peripherals such =
as MMC need DMA buffers below 4 GiB ... so, it may work on my setup but not=
 others. Also, not an expert on u-boot  I would suggest for others to comme=
nt/review
>

What I've done on the other MediaTek platforms for now is add this to
init.c to take care of the 4GB DMA limit.

phys_size_t get_effective_memsize(void)
{
       /*
        * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals l=
ike
        * MMC requires DMA buffer allocated below SZ_4G.
        */
        return min(SZ_4G - gd->ram_base, gd->ram_size);
}

There has been some ongoing discussion of a better way to handle this
in general though, the last few weeks. I need to check the mailing
list to see if any progress was made since then.

If there isn't something yet, I would still propose to drop
CFG_MAX_MEM_MAPPED and add this function so that everything is the
same.
