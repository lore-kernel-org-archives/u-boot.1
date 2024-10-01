Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90245CEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322A589255;
	Tue,  1 Oct 2024 19:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F4fpMWr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A2988001; Tue,  1 Oct 2024 19:37:45 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F7189266
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 19:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-458366791aaso28907321cf.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727804262; x=1728409062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43ZkY00BYkdrN7Wdf/7UXmEIL/IUOPsVc8K5W/Tvmxs=;
 b=F4fpMWr6N8adlT5i92Zo9HQM/nf9X2USJ/k7TUXnotTuKb/jYX8eAut9pol0gsO8bD
 u52aQTKlJzlRJppGzTsAl61/XOR3EHwLlfs+6chAP+ghpvete3T+ldMKU2yV+oYBRRx3
 uqfzom7IMpLBN9EDDf6StnPJ09Fv5QBPRjdlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727804262; x=1728409062;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43ZkY00BYkdrN7Wdf/7UXmEIL/IUOPsVc8K5W/Tvmxs=;
 b=voz7VTllgrWKb8V0cPXTChCaEOeYZg+a/KY233fZExSmuY5c7PSN4XlSb902JvLPLZ
 YajNFsaba4DzqazZnjsqL8PYuRa1c+keBj4Np5V1O9kFpyw9me6kKko6Z6ViVvIfZ11g
 Dk2YD8PtbCU8s3T8SZJ2CDFybFraV27ytZ2UlpwpYCRJ0szaBS/VPxy4PLG74qso4eL7
 j3tiO28Ye2y4J9t3OqSCm+zUPf6J+QR2FTpx7MVcr8BVqgrk/XNxgmcZaXNo0mFCal5O
 V52aX4DoR4/m11IjsLgFuvPi6jmvXyI1SoAxx5p5ugnZtMRiIEq3sthA73w+cJ2baAZ9
 604Q==
X-Gm-Message-State: AOJu0Yz3stiQiSYvoIrQYT/FJs1n/KrDEgBcYKlhJzxWtzNZ0FoIU6QR
 kOhnnkfQnQdeyC9FbfNpBXlzTTCh8kABIwieI92rBHFA72OAmDie+v8MS+AMiTw=
X-Google-Smtp-Source: AGHT+IGcR3H6u2DZB3/H/K/iM6s1PWdEYzPwr7rBjKTEui0aq0ftBbvcNZrf55UjyNlm0/XUPHSx8A==
X-Received: by 2002:a05:622a:130d:b0:45b:60ec:ef57 with SMTP id
 d75a77b69052e-45d804c3cf4mr5009751cf.15.1727804261678; 
 Tue, 01 Oct 2024 10:37:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f362e06sm47205781cf.90.2024.10.01.10.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 10:37:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
In-Reply-To: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 0/3] env: mmc: fix use of two separate partitions with
 proper type GUID
Message-Id: <172780426066.145788.8791629090784368497.b4-ty@konsulko.com>
Date: Tue, 01 Oct 2024 11:37:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 12 Sep 2024 15:41:38 +0200, Rasmus Villemoes wrote:

> I always define a disk layout with two separate partitions for the two
> copies of the U-Boot environment and, being the one who introduced the
> type GUID for such partitions, of course also set those partitions'
> type GUID appropriately.
> 
> This has worked just fine, but, it turns out, only because I've never
> had CONFIG_PARTITION_TYPE_GUID enabled on any of my boards; I've
> always just set the offsets of the two partitions via the config
> variables CONFIG_ENV_OFFSET(,_REDUND).
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


