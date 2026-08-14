Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B9C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7182380F73;
	Fri, 14 Aug 2026 08:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0i67Swt7pLbb; Fri, 14 Aug 2026 08:17:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB68680F62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786695469;
	bh=nagBMAj/Pos01XSwCsmxrXz/zVebl8lYfWWsOwbziNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=omEpfwBQTICLIRFMeHhQJxGIFBEJoJKYJT5aQa5hQ44kWGxxgjZ1XamREwEE3OlKz
	 lJjELm3rdZyaWJPGNc18Mu67gbxu1rS4hz/vROkfgITkfO86YKC5/5S26k3+ap10W3
	 pEi9OyB5Ub3byi7LtsP2heZo/lvvrpkulGO8QC9G7Rz+SJP92hSMAaCFK1AkFldGgY
	 OE2Lr4CTYZsUCY94VSpha81vuwBdgd6054tmClV34IEJbPDdzbbi/yBfIUuXZUDFIh
	 /fBkBI9G66lpW248ysRYga5PkI9LMBKfmNkhre7jqF+zaVlE5T6KI6MO587TG1NQch
	 ynLsYaBkJ3f2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB68680F62;
	Fri, 14 Aug 2026 08:17:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2BAB392
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88101407ED
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZ8wJIj17atF for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:17:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A877F407A0
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A877F407A0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oTEwGDhB
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A877F407A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:17:46 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so399976f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786695464; x=1787300264;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nagBMAj/Pos01XSwCsmxrXz/zVebl8lYfWWsOwbziNY=;
 b=oTEwGDhBN5thnjAuZWrZtUf06sx6OH/UfuRsAfpS80HZ6cuApatI5goO31IFoKYH0U
 CWIqgmeCdQLgV0JSvSD8xTdEaAdL6uFiyvnbJnyvJgZw9FDIUc/OmTgycYprli5cy6K3
 NE0RRkp9cXnyy8BG6f5DinLKalYvdiky1/QEHWen2wNnd43ay5uF/NJbC7+Q8O7P9oy0
 z8TUyeXN4ttoYevkxTZmNFjSMlhdQe6dsdsCnSWAkmNhg715/3Trjdn2XlHpGgO1Nied
 E/FSNldwbiKaKNBQE5f8LfnGaWXTVYMQWAAaCYH3nB06ZrwxNl6vgJ4XiqBCDAK1/5Oo
 f/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695464; x=1787300264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nagBMAj/Pos01XSwCsmxrXz/zVebl8lYfWWsOwbziNY=;
 b=MwLZsaho06gCGS7nshyci5JFNzbh57R2wF5fyMrVYGGB0KU0yX5O+DoXmgHd0Bxaz7
 KZaIKSUPdY2b929TE9kZ+JhNzsPNJHzLbffOwPXOITV3c/tpAAcK25YiN3Dz7XRiXw3A
 4KKNqKboiqNG6VbtFaeZjc6BmOYRZZBqwrfE98gK4o6VtdjMwDBmSjtQ1Qaygxa8Mr/o
 N8rsNUjroF40xqKuK5e+QDNcX9uZNmTVXyzXIBEIerNnRNrthi60S3fVkjfrHl4HwiEl
 jWTH/atEGJ/KeKhuhMZU0U5q9oACHkJ2ZO9ehaLs3HMaLGb2gTiT9l1epbvZPNC8hTTy
 83rg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5QGsS8YZeFQ0Q2JbYhyKE1Pfk3o1RToOFmVzvSA/kMh5U+DDKtWHgWxF7bjc4vypAjIGTLf8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyVhSqKN6GVjyFCrK8KF11UGcI2KjBnfNRAXLB467ii2x+MCPkz
 NOKh+HcG/gXp6igE8rGdbJqMTwYb3r0+VWkdtw3OSG/NSWBe3vt9zbv/
X-Gm-Gg: AR+sD11wXdw6wx5Y+XojMe3IfxWiaAmSwhHR7IxnFi4dh7IEkIY+U4xboi4NsvOOZHv
 3GndHKjhJO8841lSMBkR+kztZ5iM6e0kIoG6UaDPZ4MTHhtEbxVxl5Ps9X2be8Nj5lsGWhE1Nuv
 xQebQNjF3QqPhZkfGv3jmoSntLOFer2bGv6Aj8v/xHOvARX5i4WOjimQk5RUeSHt6RR0OBy93vP
 /UxTLcGqmmsIOuJTkWOAJAq99J0aqExkTmL5vi5xVBqARlM7cyEfOg0dQTi/Gi9Sd8wARJHGjFh
 vSP8eug6pXC9MkoM4Cey7eE5jl3/HJhvswIenE2yqu7fnm9yPJ9jdwd++ARjxLCO7VtS2rzJ5uL
 Tv9OMOFbrMtKGa1c9kiDoYESnB87SjpaKlJ/s3rQnh2gt6cdEDQFOFOhdTfVcTLYRXLpKjICtuL
 50pCSY6Fcuo/LgNF0ZuFWtp8Z5V+fzFrABzp3o8e/ZtDGuqbBpGlyxoxGaKF1vbvSJGA==
X-Received: by 2002:a05:6000:2882:b0:481:5bce:44a5 with SMTP id
 ffacd0b85a97d-4816077aac9mr4596261f8f.25.1786695464458; 
 Fri, 14 Aug 2026 01:17:44 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fb7sm6553824f8f.17.2026.08.14.01.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:17:43 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefan Agner <stefan@agner.ch>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 1/2] colibri_vf: restore the pre-2017 text base,
 the BootROM refuses the low one
Date: Fri, 14 Aug 2026 10:17:43 +0200
Message-ID: <20260814081743.2498173-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814071920.GB5246@francesco-nb>
References: <20260814071920.GB5246@francesco-nb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Hello Francesco,

> Stefan: do you remember any of this? any comment?
>
> Unless Stefan says anything against this change, I am ok with it. But I
> really have no idea about it, I trust your analysis Mehmet.

Some more background that may make this less scary.

The value this restores is not a new invention: 0x3f408000 is what
mainline used until 2017 and what the Toradex 2015.04 fork has been
shipping since, including on our seven Colibri VF products in the
field, so it is the most field-proven number this board has.

As for why the low base fails, the reference manual gives a hint. For
NAND boot the ROM first stages the 4 KiB "initial load region" of the
image in internal RAM, parses the IVT at offset 0x400 inside it, and
only then copies the whole image to the address the IVT names (VFxxx
RM, table 7-51). Where that staging buffer lives is not documented,
but the imx_usb_loader Vybrid configuration points its scratch/DCD
address at 0x3f400000, the very bottom of the gfxRAM. An image linked
at 0x3f401000 asks the ROM to copy the image right over that region,
which would corrupt the staged source header mid-copy, and it matches
what I observe: the ROM never jumps, it falls straight back to the
serial downloader. With 0x3f408000 the copy target starts at
0x3f4074e8 and the bottom of the SRAM is never touched.

That said, this is my best reading of it; what the commit message
relies on is the A/B measurement only. If Stefan remembers the actual
constraint I am happy to spell it out in the commit message.

Thanks for the ack!

Mehmet
