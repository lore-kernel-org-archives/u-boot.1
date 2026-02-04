Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A6E87840
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9721683A5A;
	Wed,  4 Feb 2026 15:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hxps4kwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4568383A64; Wed,  4 Feb 2026 15:01:52 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8068D8063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-669287780f5so540355eaf.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213708; x=1770818508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6SiQxYcdJJUD7RcG6pK8/WdDKv6Pv3LJUaFiKatlaU=;
 b=Hxps4kwZi8esFlRgWeMrOMDa2xLbaMIgLTyk93EUqzssLFs2u1uDZp32n65PqkZFfs
 mbBd8a365D/v+vd1GerHcLdkjEiWjmtLxqLO13iqF/xS1CauVE5j0wavjo8lR2+0XQe3
 XtP8zPHeyFmyvXx1B9mD0E8/Fdqtx7GJASy8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213708; x=1770818508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h6SiQxYcdJJUD7RcG6pK8/WdDKv6Pv3LJUaFiKatlaU=;
 b=JQSPKWqeknOl6l6xbI4hU/MZA5TQaMDFyVKUC7QWvt8wrRPq/uwEXyGMDCLSq12ZzQ
 2ZK1l6YzumpcZ0s+wqQKTvW72W3dD2OOMuVp6hF6eKt9dA56Ctfru7rcbEfE+AwDQ1YO
 Aa6t5yZn2MBFDw/blYRR4CmRvvyEtwN6aj+1QS5gFKZmg+8QPBQKEki7FSU48/UqDKeH
 6pE4gHK6kw/thjwplvdlUranDXk/yBqO3YglVfMDWvhwoTg5cLAAJcbKGcXAanO1TyAp
 NvLOTmHExj0YNcruDkjlf9WhJR2gugbNHcJFR+FCHESwvAsqfG88EAGR/xcziQytgL6O
 ZftQ==
X-Gm-Message-State: AOJu0YwmW/4yeaPH66PFy1KnwGCGeP9Kc0GjQxge0Gn1nlha8WDOS2df
 +nnu9lHRBiO/gXaxXEkrbabff6xIba6R05cs8lXtXDRY7iO4RWhqRq26cm4a6teYm9smZIaNk/y
 9d5a/RaM=
X-Gm-Gg: AZuq6aLKf+1acZUonjPK8Ond5pjb+ML2KHCahd0wyz8t7bkt0iIEEofmaUtN8jwHBZf
 jesg0j7Fb+7nBaRYcyNwd80O6y8e0Qv5GYjjqClhrOtaZIdXXq1Ztie9dStm140THjRcCxXH0ra
 UcBmDmUTn6+tADlkiYFNckauv8+8qejVZFOokrkCi9jkCXr9i377O+CEOGugZsG4WO44Ob6WNET
 WRs9ivG6hajcUM1AovtVMrAL1pSKySLkgsyTXaW2ZIe1SQdFrN1Mb/YbBrYWH+/bY2Wp0g6YA4H
 vfR7EWxNvWU4v1xssAUY1PZ8oi7C+Oj1IVR8fUJoSgob+jFRQWZH0g1SQ54vMRwqrJw0iwG/rcz
 4sj40tSySqNR+j3I7u5JnFRyoZZt5hucTQ9vyVXuZrq50MKThaaU5sKWog5/NxH5EbZEImrs8gR
 KBHcTAOdVRjzmUMpcRi8EkoVrmYsO7XoLxGL+CO9WT6tlxBfZWpw1DGdw2cgK71yvXwov5bpEEm
 jveyfPH79dXBf0qthHvaqVrVD9flNQ1fj1SUg==
X-Received: by 2002:a4a:e90c:0:b0:659:9a49:8edc with SMTP id
 006d021491bc7-66a33476258mr1478175eaf.16.1770213707942; 
 Wed, 04 Feb 2026 06:01:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a590fe5f7sm1369437fac.9.2026.02.04.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:01:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, ozndrgt@gmail.com
Cc: linux@analog.com, malysagreg@gmail.com, 
 Ozan Durgut <ozan.durgut@analog.com>
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
Subject: Re: [PATCH 0/5] arm: dts: sc5xx: device tree updates and fixes
Message-Id: <177021370715.1736867.16746512527124395050.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 08:01:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 26 Jan 2026 17:15:00 +0100, ozndrgt@gmail.com wrote:

> From: Ozan Durgut <ozan.durgut@analog.com>
> 
> This series introduces updates for Analog Devices SC5xx boards.
> 
> It cleans up device trees by renaming GPIO expanders and removing
> incorrect SPI flash definitions from the common include file.
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] configs: sc598-ezkit: enable additional commands
      commit: d9f1fcb304839a1e1c3cec91b9ec91d01e02c9c7
[2/5] arm: dts: sc598: add missing GPIO hogs for Rev D
      commit: fb4a6389314333a302b85b245eb71feb0bcbb9af
[3/5] arm: dts: sc5xx: drop SPI flash from common dtsi
      commit: 89a197e7e34d7148ed3f9eda5d684d7e5e673c69
[4/5] arm: dts: adi: rename GPIO expanders
      commit: 9a49dcf6ab71b5fffa106554ca22a73122cdd275
[5/5] arm: dts: sc598: update EZLITE to latest revision
      commit: d047a99d08d83535020173268439b7793c2f3f27
-- 
Tom


