Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CCBC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4915F607FA;
	Wed, 22 Jul 2026 15:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFl3ZbYRhUxr; Wed, 22 Jul 2026 15:23:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8B94607D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784733803;
	bh=IUPnZTVQEwTDavi1Rvwrgixa1gR1LGBNBowJU64UOzQ=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Gcb1uuugDlXGkKqxHdY1HM0ZroPPL84YLCoeFm1+bhyFZdyTrzIDrAiCdDKL8Di4a
	 I7Fbnh0Y82rlo7+LD+xYkmQEhiF9cgn5t7D+e/dJ6KPorlz2i20DRWOABtSBf+vgv8
	 GWjOqguZgFT4L4VWtI1ycMAAFslObQDvLD5oJezOVFz/M8MUOSMfv/+1umDR3gRynw
	 y+Wo5U2GcQ8aJ6JFU1aS2Co7KGFfhEomXV96FgbrgFO8cTyH50Yp0vMINtrAKnqM0z
	 iFGVESy5YK8mgvUzTLo0Ikq9waxzZ80jw4rQWj5gZuBJtlSe/z53ikGYorR2jGbtEL
	 AG6rbwL0vvTmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8B94607D4;
	Wed, 22 Jul 2026 15:23:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3645F788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D10B400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WI9ZQe9UJqvX for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:23:21 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CFB2540087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFB2540087
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFB2540087
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535C78494B; Wed, 22 Jul 2026 17:23:19 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BB3848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:23:17 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b0117dda13so8910693e87.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733796; cv=none;
 d=google.com; s=arc-20260327;
 b=gOseBcBSPRj40kj9Sd2yNwcCe247eOXGB+L1PXLUCuxXwavMz/2PeQNIckRAzSCvR6
 thKkXpK+dgLeULx2YFyjDSTrmqeeQnI9fnNFVbsyYR/U153crCbIZQACef2mC6oTGwPP
 Zv/YAL8BdRK6kBy8kI5xFKuXdqH7+f5B0yXsPDtHG4THKM41NVrSo/wWiGDCbAE53t7W
 sXBndOoXUbnIuPYC3/UFkSDkDrUH4isYobErZaN0+PusOLqmjv4m/NBMho1xWAstyEBt
 piXmRzM5z7FH2iYLmAZ2T+PI9gnhJBP/hfz4M2foxMCUteepS9MPt6tzr7tjF2oPHUGC
 iugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IUPnZTVQEwTDavi1Rvwrgixa1gR1LGBNBowJU64UOzQ=;
 fh=S+ivklAkCHuUjdma8r0lVsh++00swzucw6twLjXfsz8=;
 b=BsyL8jWtaoye0/RnOg8nWW6w9M1k+cxg2CFxMR8wplGrp3iLbC8KpkgOXv0SQH1vYW
 wpY07JmuiFUpdlDLyCNJnOTmmBOiF5Sc/QyHuF7hkz8pUrCiIxTfSuj/UbbZa30fBe+N
 9P72cTO0NJddUNBWEK4NNvUdCDH2msj9DRLJ6X2Caf/6c1Z5zWF76CivRINlNBl7fZBR
 GJXP1Gfk323Ptj0aGzBNntlaBvWjb+jhbzZhMzyz//Z1pP+CdMPqTm/0LwJK4bsth00D
 cL0rlJQFO382+FoU0e0SJe7AulKzdF0g91tMz/533wKr/7nLEGtb1bp/1/SD1Lb+d+6q
 mjjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733796; x=1785338596;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUPnZTVQEwTDavi1Rvwrgixa1gR1LGBNBowJU64UOzQ=;
 b=Qcx52jePAjORCwS6Sf39odePjh6VY/OqLPOGXtCy8f4aiRKS2m6oT8JHXz0gUYA5ZF
 9v10k+ufDk4ezcAuljqwedTI6Dyxu1szuFz5853OcPwz+5c7vn7Ll+sQgJBHhO1MyjGe
 egFWNHzF3T3zFzX3zhfXGGlXKETzh33+wZoOsyIxUpXf0Jn//LtFZIbQIE9tTy9EgQJO
 /wdDTlSccvbF2Ym7AhmEydwZe0c20uPWifyxqh2J4/xtvMdkU1sU7lPAtKmR+Kd4jZ2G
 9xreW1eHhYYEJhXCNuGluaBIPYhIByQz8ovK2oVD1ALRGf/fTiei2gHpOWLTiPE/QpWb
 Uf1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RooejJuLWqQxMuUPtSUwCp4jYPqAcYckOTvpzkom22UYKN9x9x/vl2aLvok8LX3Q4gpsHD6gzc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo1zplof+bZGACJKvNrM/gYyUD+iucZ7hEqPKnkI5wKKBV3N+1
 13ex6uLpui+qciGj4DCFH3R5ILBDJ9ACO5rAkqPydQZZM3bR+FBcyqOxB9yAfWzIOKhWpNHAYRV
 73W2PIZjGTZwkdWY5k3TATg/1U8GyFe7mECgqGP/Ovg==
X-Gm-Gg: AR+sD12N8wIZ6ikFcIKaKkvA5BBeXzdkEJGNpKpxSFm/byGP1qG9/nqQUw9fsMHnSMZ
 DLzlIUEQ9seGqW6lfqHwF6nYB4MzNiETP/Y2dkygiFC10782gKeLZhilQy+n2ESdpsjWTqy8EFk
 o4mQqCJHd1g60Ak3AFYLzs1INylLnZUT1n9XFi7W2SqPUYbkAxcTrtSe36L03ZDb41QyfZhxvBy
 sAWp+0ee7zxx1zkDaGQNcy53IbgGrOUDZpWpX65hnUIdEMxr3SWhN7S4e9bwgXKxCdM0IUAJ2hD
 Uhmbbs8hBlfsURa6Da4mETTawJcXwGyVvKRnTLiE/P7QpBIKvPwBuO4dw1ImkhlOGBZccjyIC88
 ugX00tRh4yZg4pftCu5s=
X-Received: by 2002:a05:6512:2310:b0:5ae:ba8f:f9fd with SMTP id
 2adb3069b0e04-5b28f84a11cmr3795446e87.9.1784733796381; Wed, 22 Jul 2026
 08:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-3-dbd01185f911@riscstar.com> <al0Fk8JyfYhu5b9y@pie>
 <CAH22mJyDMK1-TyaZierfaF88NtgVvKF2Ac3yARBVcgobGQO0-w@mail.gmail.com>
 <CAH22mJx2f1V3JE0Lt4SJY4qh-T9i2i1jGFs3CK1Sbc7H3SxP3g@mail.gmail.com>
 <00b07af7-36ec-4750-ad5d-326767eafc23@altera.com>
In-Reply-To: <00b07af7-36ec-4750-ad5d-326767eafc23@altera.com>
Date: Wed, 22 Jul 2026 23:23:04 +0800
X-Gm-Features: AUfX_mwCNymiOlySaq-pmb9SHooDhZ4bxmraZCqWnHzro-M8c1eQtNFnkLb7FLA
Message-ID: <CAH22mJycWZAnedV_a29YveK-Z8_F3qkfe+W5Y39pj_ADPO6eeQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker <jbx6244@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784733796; x=1785338596;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IUPnZTVQEwTDavi1Rvwrgixa1gR1LGBNBowJU64UOzQ=;
 b=uywAvuy4Yd+FZ5QgMqBCcfWhdB/FDOFyb2vmBFDpkiRLredSEkyVyczZIizsCREAii
 phdxOq2+CfhcCSI4VehSNo1swLXK0rJekCuq5zOya/O8SragQKy2zDMB3i/Ly3bXebN0
 wUo/a3jNyh2RzDUhSjFgWFeesTcaDHr67SGbDdu2r+yO2biPcJNMSA/ZhxPrOvinr1Mn
 Rzw7Lswa3pmw4dfNV7JUBfp4WHqQ1XGP9+I3MSjFFV7n12Be001ww3z0YFi0W9Hkdq/B
 SG5T1QQWlISSWWGl4yaXlz+qpygmRIwuS5E6GzpqHmBm4DfxUlZlQuA3B3A8B1pHPKza
 mb9w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uywAvuy4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="uywAvuy4"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 7:54=E2=80=AFPM Kathpalia, Tanmay
<tanmay.kathpalia@altera.com> wrote:
>
> Hi Eric,
>
> On 7/20/2026 4:14 PM, Eric Chung wrote:
> > On Mon, Jul 20, 2026 at 6:42=E2=80=AFPM Eric Chung <eric.chung@riscstar=
.com> wrote:
> >> On Mon, Jul 20, 2026 at 1:13=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> >>> On Tue, Jul 07, 2026 at 11:21:44PM +0800, Eric Chung wrote:
> >>>> Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
> >>>> manage multi-block read/write operations. This allows the MMC
> >>>> core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> >>>> CMD12 sequence, reducing command overhead and improving I/O
> >>>> performance on multi-block transfers.
> >>>  From the description, it seems CMD23 support isn't essential for MMC
> >>> support on SpacemiT K1? If so, it might be helpful to separate MMC
> >>> core changes into another series, and focus on basic support only. A
> >>> smaller series is easier to track and review.
> >>>
> >> Actually CMD23 is necessary for Spacemit K1. So I can't split it from
> >> this series.
> >>
> > If I use ADMA mode, CMD23 is required. If I'm using PIO mode, CMD23 isn=
't
> > required. So I prefer it go through this series.
> >
> > If the reason isn't solid, I can split it into another patch set.
> >
> Both CMD23 and CMD12 are valid mechanisms to terminate a
> multi-block transfer: CMD23 (SET_BLOCK_COUNT) is issued before
> the transfer so the card auto-terminates, while CMD12
> (STOP_TRANSMISSION) is issued after the last block. The u-boot
> MMC core already has CMD12 support in place, so multi-block
> transfers work today without CMD23.
>
> Given that, I agree with Yao Zi's suggestion - splitting the CMD23
> changes into a separate series would make both series easier to review
> and merge.
>
> That said, Is there a specific hardware issue on the K1 board where
> CMD12 does not work correctly?

I don't think it's a hardware issue. The ADMA just depends on CMD23.
