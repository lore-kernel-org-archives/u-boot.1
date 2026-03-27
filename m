Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3003810F2873
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B011183C14;
	Sat, 28 Mar 2026 00:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UT7Gza1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D788C84011; Sat, 28 Mar 2026 00:06:33 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0FE83DA7
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-662f30d3f1fso2169230eaf.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652790; x=1775257590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vxg6HgOT3WXrBWYz7Nlou3Rkqr3E1dEOZlDJMcF3Cfc=;
 b=UT7Gza1sdE0KHTycGNvw87ynRQB6r4adokNHkTNa4rnemucQvL0tHYjIxwfBzKWjcM
 KYQE7wk5ulsj4sGd62QHTyXkokLAn+hyZyPLzWE3554bfYfZ0gSfJkVgiBdwQ0uXrmdP
 JEeX6iHWbzjSniavVwmv5SasOe/MrWlNi7b1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652790; x=1775257590;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vxg6HgOT3WXrBWYz7Nlou3Rkqr3E1dEOZlDJMcF3Cfc=;
 b=VINF4lPyTCdqoz10XbqU9SufVcYvPqxugV/NSTkZ1fCIikQZA9wcQrZxGIvyLK5plm
 H7JTe55lzxSLq7vd7PG7FC9zJw4FMxHgvFMGB7XBAcRdW9AonKdPGI0A8ND/kqKk2tEl
 yU8JctfgXJrW/kNYBlWA2bK+/VxOE3iSAGteXthXgzih4lmKVMBiLd0iM89IdUFZepvP
 XwaNheBdZmlTfAvW5GqWrjqaD2c7FIlL7eHs4iirowSunjJrzApITfho5BvwbtAdxUT/
 5ZgWqhrKAgJlnepBPDZvF5SEH3+5XLxoVt1iVdyfNBeEpRMVloNs+qx6Oqb6JqNwQGdo
 bb/w==
X-Gm-Message-State: AOJu0YwAXgh02Zssu90RGEdlkHvfSzhjoIz7Q1yE3r+KWO5GLjAEuK62
 v7f5Wkp/JJoAnh3m69Rr66lNohyPT94y5wTDAtatIo22nZwQqS4OvQ345YkWB5nSKnw=
X-Gm-Gg: ATEYQzzP92bBARLB9jqj885e54zWbQTjNNhrItEti3/Uc9GWtACC4r/irVtXalUnPuV
 ZFtJkHTcHJUKSqASxh4Bk3guzBEQj/zJfY/83yYNDvPmwegBJH+z9SbfS6wlWBcwws7GmZZYqBf
 Q8MwntILans3JEOAPo8rj2+IaePGK2Gdabq0cswxumq0rDRFftcgg7gvQnxq4Z4IDNCfMIIjkKo
 5jDUSBajIzmMTIRzY4NM7foK9vlWI+tyGUMsWDKf5jW+K62OBaayPZEfL1OZsVAcmP4ZQ/BD3D6
 gVj1jopH0YYbh5YrJ7ZywGH1Y8hbAGtVuoFzzYSgQT+vy8gBGxbIPseSro3HkAcsvZEtiqgCwWR
 SRXJLcu0wUyXniPKIQ1OuXb0aqwlE6+pcBth1US29MyQPjFj8QgMyO02UKsN53OGoLzoDSDDaGw
 p6hkm0y2/AtOAEKNRFCBUgM3s1sirUKJnF7VFiAsnMJR0lhZ3MdG0VC5l2qnLShTXnH/UNXH9XU
 MNWSgWVFaeMr3p7QjcRFMcpsnhizMCfh46G2w8a8ikDrAo=
X-Received: by 2002:a05:6820:907:b0:67e:18c5:b9e7 with SMTP id
 006d021491bc7-67e19621d92mr1830936eaf.34.1774652790245; 
 Fri, 27 Mar 2026 16:06:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
Message-Id: <177465278909.41705.13646859978216846842.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:29 -0600
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

On Mon, 16 Mar 2026 00:54:05 +0100, Marek Vasut wrote:

> Introduce new mode of relocation which relocates only data, not code.
> This is mainly meant to relocate data to read-write portion of the RAM,
> while the code remains in read-only portion of the RAM from which it is
> allowed to execute. This split configuration is present on various secure
> cores.
> 
> The result of the relocation is U-Boot running at its original address,
> data relocated to the end of DRAM, but with added read-write area offset.
> The U-Boot binary area is not reserved from the end of the DRAM in this
> relocation mode, because U-Boot itself is not relocated.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: relocate: Introduce data-only relocation mode
      commit: d9eee3d17882ec40f8ca5e231046bbf287ab4369
-- 
Tom


