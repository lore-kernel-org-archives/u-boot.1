Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F22C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AD280FDD;
	Tue,  4 Mar 2025 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fQQXdxJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27E180BAA; Tue,  4 Mar 2025 17:57:34 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD1C805C3
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6fd2fca1cebso36910237b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107451; x=1741712251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5urP4Nf7KIcYi+p7FxLLf2qFhJ8UNkxWKtoxQgWMUMc=;
 b=fQQXdxJ0bFMLn64M1NcM84JCp0rJtrsa2dPaBCh13/lWVEE6T2vp4k0UWdk/cCm7wu
 qDu3Mnp0y1HvdGNheWmIDM+f9rq+jPClE/OxG2igSyyr4lhDxI6tsr+tVUtvM64VONwp
 qAd0EdMEme6m7yzcil4A33eZpJt346RTyZtCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107451; x=1741712251;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5urP4Nf7KIcYi+p7FxLLf2qFhJ8UNkxWKtoxQgWMUMc=;
 b=eAjPhfNLi5L/PNHTqUCF4jeW1NKNqeG5e+svyBnzaLNaP3At/1B93mAid+VTX0tYBX
 ZUWJcyRH9gv0m9pHZZEMgbpl38uDSCMKiS0xtHeNPr5COQQfmcQw+E8/pSzaRKOZ41kb
 T6G4Hb5vFcEWABaJX0pxnrB5szpGFMISIXiCxmx97NXgkTU8cD1VWGelIEVAcHX2UdMa
 qBrXYuqv+Mj+W0W0CfAE3aCIGtQs4b7mYSKRSSHZIe6muKyJW48JFDxug5OgeIdvV/VQ
 f450I5YuqpWvr0h+84nweTsim4zC18NzCyIRZxyuBNRM7W/UXI0yE+TaMAGmOPVKyG63
 omVA==
X-Gm-Message-State: AOJu0YyGiHlYxVQ+/Ph4Nlfh3UE1MwTYVudtosLUmj79t7/WYY2iHRSj
 cyB9mA/AfFnrMbCa57QigOqZ0tTOB1J/m0E6RN2yvCkJF1JJ39ZtbwlRDbFo3Q7vyyCsin5YcV+
 v
X-Gm-Gg: ASbGncuEsLtTo5O5TUCFX4oV2qh4X9XCoFV8BMlxgeAZahNdZLweqSVljvWRxEvKcKV
 BZ+1tQ8+81REaSK0kDlnINo4xvYhcrQbwKKzQgldzrTGnS36q6x8af9UqrwrO0iRVaaQgwWZ/OP
 j4BITkYR1a06hMKBP7gcqlkuwQHsZ5s7zk8vIskmDTNOqj4N3HOy2mc6E2ygdamo8kwQ8lihitY
 +r6vQJewjQXx619Ap5Vb4WANLf/lJSnJOblizGf9ANs9rmxzvwN1KNEGPwHZE5kOXsTr986ETei
 7FbThcuu9cbpuCyl+K0lBADiC1yDSRwGkCu6hm6MSw==
X-Google-Smtp-Source: AGHT+IElwyYDUUpg4Yj5ioNDBlummDNzVh1kNlIsRRiRXMAv0Tg7cntIr5+5a4WhyGf/20MTTSbs/w==
X-Received: by 2002:a05:690c:4b83:b0:6fb:b78a:c0e5 with SMTP id
 00721157ae682-6fd4a0c2ca3mr232047397b3.28.1741107451670; 
 Tue, 04 Mar 2025 08:57:31 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb9f7casm25268957b3.108.2025.03.04.08.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:57:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <hackpascal@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20250125152632.26665-1-hackpascal@gmail.com>
References: <20250125152632.26665-1-hackpascal@gmail.com>
Subject: Re: [PATCH] miiphy: define mii_devs with LIST_HEAD()
Message-Id: <174110745066.1812793.789717859415304264.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 10:57:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 25 Jan 2025 23:26:32 +0800, Weijie Gao wrote:

> When enabling net console and console multiplexing, a boot crash was
> observed using mtk_eth driver with stdin/stdout set to "serial,nc"
> in persistent environment:
> 
> > CPU:   MediaTek MT7981
> > Model: OpenWrt One
> > DRAM:  1 GiB
> > Core:  35 devices, 15 uclasses, devicetree: separate
> > spi-nand: spi_nand spi_nand@0: Winbond SPI NAND was found.
> > spi-nand: spi_nand spi_nand@0: 128 MiB, block size: 128 KiB, page size: 2048, OOB size: 64
> > Loading Environment from UBI... SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> > mtd: partition "ubi" extends beyond the end of device "spi-nand0" -- size truncated to 0x7f00000
> > Read 126976 bytes from volume ubootenv to 000000007f7bf0c0
> > Read 126976 bytes from volume ubootenv2 to 000000007f7de100
> > OK
> > "Synchronous Abort" handler, esr 0x96000004, far 0xeafffffeea000018
> > elr: 0000000041e63cd4 lr : 0000000041e1b844 (reloc)
> > elr: 000000007ff9ecd4 lr : 000000007ff56844
> > x0 : eafffffeea000018 x1 : 000000007fb552e0
> > x2 : 00000000000000fe x3 : 0000000000000000
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


