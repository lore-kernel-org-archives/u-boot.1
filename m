Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1C1E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 21:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF5E88EAB;
	Mon,  9 Dec 2024 22:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PpAQHLjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C28289420; Mon,  9 Dec 2024 22:08:33 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFF18932E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 22:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon.anavi@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4676f1a43dfso6664651cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733778510; x=1734383310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OSPu06kKwMljsJtDaDqQdNZuIV6PusENKfLkpYNKRdU=;
 b=PpAQHLjcz6YzmjJkekMRQoOuouXev97OGAO9oFPwExa55BE5N2/fCbFSH6dWZ8tH4j
 icDDvs6E7egjqXgnSceYzcYpntFJyx9kV2daJLJ2F2/JEPL+hr3pCbAwdryAkh27YxMO
 O1UeuNpZ63orU2EVTS0cqKJhp08RPdDSR/OxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778510; x=1734383310;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSPu06kKwMljsJtDaDqQdNZuIV6PusENKfLkpYNKRdU=;
 b=ah59KjpuX/xSmfSP12Pa88ttIyBS65ot6M4cGmnEHrbr4qcgxel7XDWPGC8D6Tjqzf
 uPum3nW51bsh0cp5X12CRUV0u9QANSy5+F2/+muDNzzK4xYQCFwWanbWSpNG8f3NSanw
 XPD7w5kCiVd0rpHBokkCivuHHYtEqhzClYUBDbj5+5H8A+vZ84ePAT12LHoJjQ9ezZw/
 PaPEkTZGyV55pyKLxY25RDkyePAFcA+qtipf6EnLxMDZGciut9Elp7IQZLsK71GEZqQD
 CJJ/rnzU9og+hYdOsvFWVJWgvaIxcSHZOnsBj3k6xYTm6rTRzn4buVcxlbHZ33F86osc
 15zw==
X-Gm-Message-State: AOJu0Yz3bLkbJjMRi8R7JgqzyysLHXs0F4yDQFc7cl2pJt/Q8Z8HJ8bo
 I1F407RMoyAUcgxL2vAAxcCT/ibB9abaQ90RgN3XorVL15IoZvP9pY0VOlWfb4m1Sq+9WAyG8Lq
 e8px+mqhLorjRpUkGGMIH1gxfbRtxlTcL4pwZZw==
X-Gm-Gg: ASbGncuSoQG9E4d74VzzJSgSIOG2UBBWfQ87/q+y7NBS+ItqiITkXu+rSDR9jeLGw7O
 4I8wv4iRMmh6KATPQea30LyT0zsocYfE0yxzt
X-Google-Smtp-Source: AGHT+IHNRDWdaVnmbXaBwfZP1Fq1rdNy0Y3luIvPz9WknUxvzF5KnYHjhXpH4IUe6P+0WLzKCu6RN966e4CYBIaR2Z0=
X-Received: by 2002:a05:6214:240f:b0:6d8:7a52:5d5 with SMTP id
 6a1803df08f44-6d9212b7673mr14957126d6.6.1733778509798; Mon, 09 Dec 2024
 13:08:29 -0800 (PST)
MIME-Version: 1.0
From: Leon Anavi <leon.anavi@konsulko.com>
Date: Mon, 9 Dec 2024 23:08:19 +0200
Message-ID: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, lhristov@gmail.com
X-Mailman-Approved-At: Mon, 09 Dec 2024 22:39:47 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Commit ffb0294 from 12 November 2023 that simplifies early PMIC setup
conditions causes issues on Cubieboard 4 and Merrii A80 Optimus with
Allwinner A80 SoC (sun9i). The commit was introduced with U-Boot 2024.01
(rc3) and remains as of today. Because of it both of these boards hang at:

Starting kernel ...

Older U-Boot versions without this commit work fine. As a temporary
solution I reverted commit ffb0294 and this way the boards boot
successfully. I tested this work around on Merrii A80 Optimus with several
U-Boot versions, including with U-Boot 2024.10.

Lazar, a friend who owns Cubieboard 4, also tested and confirmed his board
boots with U-Boot 2024.10 if this commit has been reverted.

How to fix this? Is there a known configuration that can be added to
Merrii_A80_Optimus_defconfig and Cubieboard4_defconfig to avoid hanging
with the existing source code from commit ffb0294 ?

Best regards,
Leon
