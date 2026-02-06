Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE3CEE6B44
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4B083BC8;
	Fri,  6 Feb 2026 19:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CikKR/on";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093FA83A64; Fri,  6 Feb 2026 19:15:26 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D951F83AA7
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1872504cbso1953162a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401722; x=1771006522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcf12sh6hGJyhH/3MC2y1R+n/H70zIW7/LHeuj2taAA=;
 b=CikKR/onkFiFLnEQqxFp/Jw3SUuT5zaPjS1dWKsSPvNyC34GOybSdgQ94VKTXnRyj4
 3fqZeE41YmjTVKfLSXdJ/Q2Qm/GBp5bnXws3O/eWupFqVxLqGrJdJrtB22asyK+wFSZo
 cydbPNUJ2OwtQAykeQQO+PP6iAM5Ho0RNoEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401722; x=1771006522;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vcf12sh6hGJyhH/3MC2y1R+n/H70zIW7/LHeuj2taAA=;
 b=eXbyI/bsDC0mC0UyCKz1/1/Rg3/1huCPT6KLJTI2fAocDnP1H70+CoePfAl7bP3xm4
 RoNcJusMH+RPeOiYJaFOhTSHLmpw4dxFmak7pRcSHPzU2wr+72QX2yxAumWVgvjf5g26
 YB2jf8fZ4/YLQTFca/jqDQzp7z5oJc2C5wNhfpOKnDJzkAaqleDNzLm/xeG/dlmBDZhx
 ya/yF3w8JTIlVJBEGf0ZwyZBaur8+xYQSmCJyHtHYVsQMWZDZaxbuxUaUWOWygch0XTL
 uMJWkSUli8xn6jhv0zV17TISdAJ3znmqrmHlGXcj5xWDQ9u22mzTXE0alWRdWMLU9Wm/
 0OUg==
X-Gm-Message-State: AOJu0Yw4u2NufnHu1W63c3+nRMOLorBKPAWiiuS/e4wOv6JvPTex68XL
 mKcne/yv4ht53CJCGtzD+XWxzgN0dFnj4vF5Ad24FvJfuC6L5E9yEC9yxFR4HkZtspM=
X-Gm-Gg: AZuq6aLhOv2fYdcHGKIL8Os1rkO7K1PctuOXXnc3urUu18M8nbWvuFyA+SH1EPKJFRx
 n9Hw+RQXv5bpM29gpURpvMiXBQB80LqE703YY5nxIYbxbJSjPdekbScdSHqVrJIoElO6+nK+zO5
 gfCWlWAJze/qFlOcwvz5aGxftskZ+lyJV3fNcYcGk8D5r5ydJbekzfU1iDkaYItSolclV3Cmahk
 xZ/QtJYGa87FwU+78FXbA7eE94JYLNolmjMkx/t/YKjLwLXxlGPTT3aVTFmj6trWsA2h2c9DKTr
 /klG3jc7qQ7UpoV8eRDpyob+sVMTIa38yRN95F8jjkQc1WpOE45cJERIrR8axyyBHdGIkQXoTh0
 qQdEYGeqGkgLy9VuY3hD4eIGbJR5+aZuH/ZFZY5iKf+kmA72DWkeqTx5dCnNoyKDE0gl/Ue1OwY
 6TOLuJBlrUOiusy/KQp03W2hiy87qzjySrGcj5s6Dn8WNbXx/BQdzvQ//qer+3VLjXAEvKaMmkG
 ITMOdto/S+ZBFZMN0GI3T3Wiao3lgDYnBDJZA==
X-Received: by 2002:a05:6830:67da:b0:7cf:cd27:57b9 with SMTP id
 46e09a7af769-7d46333934dmr2110593a34.1.1770401722360; 
 Fri, 06 Feb 2026 10:15:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Leo <ycliang@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Cyril Jean <cyril.jean@microchip.com>
In-Reply-To: <20260120153314.95091-1-jamie.gibbons@microchip.com>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
Subject: Re: (subset) [PATCH 0/2] Fixes for boot failures
Message-Id: <177040172143.4023747.14204893558496879169.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:21 -0600
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

On Tue, 20 Jan 2026 15:33:11 +0000, Jamie Gibbons wrote:

> The following series includes two fixes for master causing boot failures on
> Microchip's PolarFire SoC Icicle kit. The first fix is for "failed on
> fdt_open_into for DTO" on dtbo application. This is an issue with overlay
> alignment that is fixed with a oneline change in the fit-image.c. The second
> fix is for a boot failure introduced at commit 217cf656e24
> ("dm: core: Default to using DEVRES outside of xPL"). The value of
> CONFIG_SYS_MALLOC_F_LEN needed to be increased. Please see the individual
> commits for a more comprehensive breakdown of the issues.
> 
> [...]

Applied to u-boot/master, thanks!

[2/2] configs: microchip_mpfs_generic: fix boot failure
      commit: 2e6b5185bd509d5c39bbdf900bf6ac9c12f2ed59
-- 
Tom


