Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD452C44533
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 495E740939;
	Tue, 21 Jul 2026 14:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPfHjfNzmZUW; Tue, 21 Jul 2026 14:57:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 675D340785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645855;
	bh=6E/0+/0dycmy9CWGEeB6BH3xfBv8dLFf0vplhibUM1E=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ogpwkq2uR8NVJrNgy/7YCnBA0b44ls8Bpc2rHF5k9Y1bcCnzWxHOWnMvEo52HgSCe
	 myYal4IQzblD2QyhIgFWpBeNxHAGbMnjGurS6wOoueenNfmzzkxWDah1tEpv3/fJm/
	 +4wFPcICL8hSVQRojoDQ5MwI8Xqalk5xcNBd+Zbw7cf5/WGaJVwEgyii4NGgKaSjJ4
	 49lb4HbgdYWIrMEkld7XLvOzD3ONLAWUfO4WRUCH7JulkPkSL+Ra8dQ95x2F/XO1DQ
	 A1hNf0JjfyKoLZJD+fhU1VPQQb07f+tQwaES8IjsdBXplTm0QtAr2ji8OqoKX7DqR8
	 MMfPJV70gefIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 675D340785;
	Tue, 21 Jul 2026 14:57:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D62CDDF0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3C0740164
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjbrQbkYgoEl for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:57:34 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8D3A140071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D3A140071
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D3A140071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:57:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F9C846A4; Tue, 21 Jul 2026 16:57:32 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0CA803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:57:29 +0200 (CEST)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a39a267d34so3553693eaf.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645848; x=1785250648;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6E/0+/0dycmy9CWGEeB6BH3xfBv8dLFf0vplhibUM1E=;
 b=pOrTGo4HzMRV0a3bS3L1usHmtAYo47SeGPBURCRLTnRars0+MbNkSr8hjRZSbNUeKi
 wr+NrTSJI7Y/E+C62xQW6NoLsmHa/YaSlGG1x4bCZfuHi8pXSKlaeAGEUD1mNdD7sSGG
 T8mpPyxg3vaUIei+T21q38kQowWAuhyFl/7L6UGsPBk7H91U7kvyyKzkXFSllGO5cqtX
 YkARtzjl0XY2P4HepIz1YzA75mAoMUUtIAAu38hxHTRFOPS1jUoS9KP58+kuihkIHqfq
 Tgju1IKYLeigChW4I9eQGUO2OLy1T/uvZ33LRGo/MFYrN9AEkpsH3u8eOJdD+qmfZ4gt
 89Og==
X-Gm-Message-State: AOJu0YyoobiLAPwhown9oQQh+lIdL/Bsl30XzScV8W64UPcsum1dJesv
 aCXOLq6ZkenHi7HjGYyeFPtBkxWcO9LNoFwNvFnkc+3HFl0+fNxhhkMgYgxc4BSnNYPxrgz40pb
 +YTJ62Fk=
X-Gm-Gg: AfdE7ckS0g7bzjlGyJgy4d2Yc0hlYWlkM4wL1Axa1dJJc2AM93arnBGsLPXirwUzpZJ
 H2YB7EWqaHN4/TNYrUoIijinCAzrrcqcZl6FY3I+6YdF1Cy9G2aqmil8P1Zhcn9feNAPc2V9dAp
 yX4Zihlxn5UVjm9xMYiDl2qvijVFH2uaHs8QYBIB3847L0wsv+h08WiX7nluZ89mAzBCJ17rmEd
 iiNC4F9FO5qYFGjljsEoBnNd7YUXEjpezFJguN44qlGKvaAN67uTW3+cazDrSuq6ALfh7qGflbP
 lX/e9rhjavtqeBk6wy/grVUCzy/0H2j8kqo6/HSZHRrfaxrmLXiUzPP9EK0PsoFxRiFLkDbRjv2
 n0s6gXeMa6XR+U7ikmwxgPVQzdnaWVP7m6HUxsrSh/x3Nk6CbB2sTOiPG70ko1iZoaIs5gn0jUP
 ZCe18/unVgXQgAgp04m4P/ZuVTXVVfWRaOnziUkp3LVqZNzCXIUokgw5gxWz+h3x7zuF0MPAr5L
 MxHZAE3fAQX+TXelb28K5cTiIG0raSs2V+8
X-Received: by 2002:a4a:ec43:0:b0:6a1:4347:8ff1 with SMTP id
 006d021491bc7-6a53683c0f4mr8763343eaf.38.1784645848510; 
 Tue, 21 Jul 2026 07:57:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e61d5fesm12831673fac.10.2026.07.21.07.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:57:28 -0700 (PDT)
To: U-boot Openlist <u-boot@lists.denx.de>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Chen Huei Lok <chen.huei.lok@altera.com>, 
 Kok Kiang Hea <kok.kiang.hea@altera.com>
In-Reply-To: <20260312044633.29242-1-boon.khai.ng@altera.com>
References: <20260312044633.29242-1-boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] spi: dw: Allow bits_per_word to be configured by
 device drivers
Message-Id: <178464584749.2640163.6583183914340386202.b4-ty@konsulko.com>
Date: Tue, 21 Jul 2026 08:57:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784645848; x=1785250648; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6E/0+/0dycmy9CWGEeB6BH3xfBv8dLFf0vplhibUM1E=;
 b=WM8FowkWsNdGWh8nZVgUpbdKjcbzveTu8LCTCDbBK8ovcvKrtdAvuELyOhooap1uWZ
 EnlD+hmgJafPj7EAN11Lljc4AOrmWefHopOUmP9uvJernZDydU7v2M79cZnvTwlZtnmK
 KT45w5HFI637S2rnOk6bSO4NspW7NGt4W3PzE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WM8FowkW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WM8FowkW";
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 12 Mar 2026 12:46:33 +0800, Boon Khai Ng wrote:

> The DesignWare SPI controller supports configurable bits_per_word
> (typically 4-32 bits), but this was previously hardcoded to 8 bits
> in the driver initialization.
> 
> This patch enables bits_per_word to be set dynamically by upper-level
> device drivers, matching the approach used in Linux. The controller
> reads the bits_per_word value from the spi_slave structure during
> each transfer, allowing different SPI devices on the same bus to use
> different word sizes.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] spi: dw: Allow bits_per_word to be configured by device drivers
      commit: 5a83cae32d9a1f29209d4f171a8de18bf82fd630
-- 
Tom


