Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92E2F46126
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A1784154;
	Mon, 23 Mar 2026 15:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="j073Be6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41168418A; Mon, 23 Mar 2026 15:09:14 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B3984099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad8435f46so3207330d50.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774274951; cv=none;
 d=google.com; s=arc-20240605;
 b=SBe5ep15zueDhTi1WursFmxwBXGo9j0eUS3ZR7Hc/moFzA9Berr66ww4DfSy68//2s
 LVdLo1i6TUxMVOCX1VVCsX8/cwp32iRCj7sx1G++PHpBVRRTLOOEdenEnMhLkW0la5Cx
 GpvTUTOAB2xFQ+ylZ5o+xhkPthERh6YZL+uhE8zqLxfHdU0UaaUI25AAWC4Q5CdodF9Y
 1leBur5T8Aaz8Yvt1cwnJRrQzs5gFjCSuJ0H5N0jEoZxHRnfcx7r0FXx7HTjmczuPpx/
 8rAz7l+rni9Ej2pvAsWLix2mCA6kgQSjnKG2F83c4ZmpMdkA8S7CsuYNYfupPiijOn+m
 s8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k3D0cyWekRLkIA4HyAue3rst22fcNNPMUjyZmFPMPWs=;
 fh=/KN9hdoQy9CA3T5HcjvmoQFbaoBuKwo+oDcI5oS1IgI=;
 b=X8S5kq8CM4CJvBoD1aj2YOvTw7fFV6DmkwSjxqRbXm201+JPWnp/IC30Ny506Z9cAm
 FD9dan3YL35e2maYR0nkNfYq6cLJtfrclDjxrv/Gp/Tc6POHxCcw2Q1DKjhQRaZR/PrH
 A+X8Jo7011kLl0e2xjJxi6or6e7cTjCLB4rap763ysL3HRCoJk6xpUrzHQsUr4DijzHU
 FvTlU6f+4FE0NAjf50v2GXDlp8gh90XdW0jSGUP6idETxml0k94G/G1t/bCOCz1CruPE
 5JH0p4bRBX3Ia+0GoYRyJy9lizfQAU5j4TAzflq8yhn/1To0SHMDY58s3zFigZXFJ13y
 rK1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1774274951; x=1774879751;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3D0cyWekRLkIA4HyAue3rst22fcNNPMUjyZmFPMPWs=;
 b=j073Be6K4aPrisdvx4TIx3nQ8T4aCQPT/7L944PAfwAXx94PP9N6MjoYR3JQgQPL54
 TDOzrM1B5OwvSIKw4SjqBQ7Xt4yT/bKEYqUvP0EKCAP1B8VJx0io2troKun56sVjaixO
 dsqzaZdeFAqHRDm/xnXTuWWUpJL1NIVhcNvdBU5LdAg6O+a8yda9/pWlkGc5Uk+8zyWO
 jMJiihIouSMK8jcvRsC2OE8Y8cr8aX7Gyb496Tp5OkPm1RgLuL/objQc4K05H+7hFunx
 mMHZ+Bsz/RlbaRfWBoQveSroTg6nq03ffgQbqv4DNFpmglrFRWiibF/6rxhmSwhPM2C6
 pgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274951; x=1774879751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k3D0cyWekRLkIA4HyAue3rst22fcNNPMUjyZmFPMPWs=;
 b=hIZ2UGT+u0n7fwDMMB1b31FWBZlS8AapjTw4qcok9KnEr2oHRTfZCa1ltSLZ+saUP6
 o+rnX4b3lq64Oj+kr2daQaajhjdBamzPXxJhdtfTvesvBVuVjj5hl6DehYVVqCKC9BgG
 TYD+KaZmjD4sAptkgDYMbG7MGwHCqNjH/xquXTTjUrdzTBnWQEVKjpEM0KBy0R8wGj72
 zP30xHsGrvxA/E7YJTipaqVVzT3by5XpaZ/jY9/YvrqK5zX9GnUqO525roQ4E9JFfcuV
 EL/XPsgY2OEJQPaikaE9UDtX8k6mLTSM76g2h57CtKzg4QIUHLxVNCyFj5ZBwxkrO52j
 h5iw==
X-Gm-Message-State: AOJu0YySjMIKMc7g4p4fbXksShs2mUGmI7dE5sEg7qwuuD0bmZAGLoF7
 9CSeiRd5Ci2sVIYPWRdm5rAxgwJEYgZdVisnOeqRIObdl9hwjg21Sauxz2zrO3HXpOcUNOyw6Ba
 L3jNBXW7UVmElf69pYXEdN/4fgE2/cDwVPaVIbD44
X-Gm-Gg: ATEYQzwakcMrCtiaS/25pLHUQuAvpAvApruINer3R0G68rOU/t/PG/u4DOvtUT7EHiU
 9sDzlxaCokF+pE6A0xhuzp/l8dbXW3bjFkvcOllCU+/Xvr4YO0R1v+cEBJ2i+4JP2M3SnjOhaQN
 uqV/8IZiRdRqoD9/UIk7v/nAGpQE7JQ7xYWRSSivotuS5P2/wtbIrule+mtkbP+YTYx6oH2AHnN
 1wjMheSe+6TTRoBzdrTrbFLm20NSFNpL0mmq52tG5eW1/EMaYr1gglbOhHAuGb2ens64hC/jnmc
 +hfe3BJ4
X-Received: by 2002:a53:d909:0:b0:64e:a8d7:46d0 with SMTP id
 956f58d0204a3-64eaa8455dbmr9642043d50.63.1774274951043; Mon, 23 Mar 2026
 07:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251030175856.115246-1-vlim@gigadevice.com>
 <20251030175856.115246-2-vlim@gigadevice.com>
In-Reply-To: <20251030175856.115246-2-vlim@gigadevice.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 23 Mar 2026 15:08:59 +0100
X-Gm-Features: AQROBzAOMn4Eief6pSQV5VFdepuaBVNIK42UiMAOqcuyQi5m__qV2-2ALXISVww
Message-ID: <CAHTX3dKqpPFKty3ih07L4txmxvk9eWvpL6NFvXDVv82fJmHrFA@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] MTD/SPI: Add new part numbers and modify one part
 number
To: Victor <vlim@gigadevice.com>
Cc: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com, 
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com, 
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com, 
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
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

Hi,

=C4=8Dt 30. 10. 2025 v 18:59 odes=C3=ADlatel Victor <vlim@gigadevice.com> n=
apsal:
>
> gd25lq256d: add SPI_NOR_4B_OPCODES to definition
>
> gd25lb512: 1.8V 512Mbit
> https://download.gigadevice.com/Datasheet/DS-01014-GD25LB512MF-Rev1.1.pdf
>
> gd55lb01g: 1.8V 1Gbit
> https://download.gigadevice.com/Datasheet/DS-01013-GD55LB01GF-Rev1.1.pdf
>
> gd55lb02g: 1.8V 2Gbit
> https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.2.pdf
>
> gd55lf01g: 1.8V 1Gbit high performance
> Can send datasheet over email.
>
> gd55lf02g: 1.8V 2Gbit high performance
> Can send datasheet over email.
>
> These parts have been tested on Xilinx ZC702 board.
>
> Signed-off-by: Victor <vlim@gigadevice.com>

The same comment here. Full name and look below how commit looks like.

commit c5d82cab7722379c57e3383b5aaed83e5071adba
Author:     Jeffrey Yu <jeyu@issi.com>
AuthorDate: Tue Aug 26 23:30:03 2025 +0000
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Fri Feb 20 10:39:19 2026 -0600

    spi: add support for ISSI IS25WP02GG flash

    This patch adds support for the ISSI IS25WP02GG QSPI NOR flash device.
    Tested on the Versal VMK180
    board in dual-parallel QSPI configuration.

    Signed-off-by: jeffrey yu <jeyu@issi.com>

commit 311f9237613d71ac1807db59c16c2250076e9957
Author:     Christoph Reiter <christoph.reiter@evk.biz>
AuthorDate: Mon Aug 25 05:53:58 2025 +0000
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Fri Feb 20 10:39:19 2026 -0600

    mtd: spi-nor-ids: Add Fujitsu MB85RS256TY FRAM

    This part is an FRAM, but can be used through the spi-nor generic code.

    Signed-off-by: christoph.reiter@evk.biz

M
