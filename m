Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE3FA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82E584374;
	Wed, 22 Apr 2026 18:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nPy+IJHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52DF84312; Wed, 22 Apr 2026 18:39:15 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C160784277
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so5087443a34.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776875952; x=1777480752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4+t0icYSMZf+2rGnhDogxahQm+UuyW0j59HexZU6gI=;
 b=nPy+IJHSgawzWf+j9wPCi0p5IqSny8vYR4VouL4z42MD8GoLg6ohi1iXZ2BMQFKMNz
 v3WrMeq+IN5fuR8bLVbnaY2UsGe53qHuJ9mV7qbHVfkrBg1rfEj2Mjr9EIGxujS71nL5
 ZwaZTyDO+8fnvPrWUtP9IZTuRKSuOaYCdPMdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875952; x=1777480752;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4+t0icYSMZf+2rGnhDogxahQm+UuyW0j59HexZU6gI=;
 b=BxuHSjcuINWws1LKmK8cOTe44q/CMwlTuCAPyIomhxk0pEC+sqWe57zbAV6U2Df0sq
 6LxVcfh6DnOGOUWyCbOpiWsROCa0Nft0o6jqEHN3IGcaok1QgHugaoZX2VfxPaosUAYT
 gkfGWg2CzXGBhAC8TCe5T30wg9RAXlEd98L6M71qQaufnpqIrvy2CtZF/YfO1sYxg39D
 0vAWy0UmbgBIFSLqJgqrdieVwNcrk9U6prTN8potlZ4J2OhftmJqi8tFlCpu+gTsJS17
 8GEjzk/H5vppi8vG4L5hCz0QXLOEEnCLNLTajL2qo9d48Qut4fCZGpr1rmS2O4Ix+nvU
 r+8Q==
X-Gm-Message-State: AOJu0YyaDCgH9k1GWyCT3A+qAhBp2drLBOIw5isX1SC7x0uvjjWmV+U0
 rc86/O3IiloUqg1pDBlLk0AxSMOj1Lrl/qyIXhUBB5lQ/IgYCZ9Zqp3gIyuKy0PKzUY=
X-Gm-Gg: AeBDievwtvHenWu541zMh8wcOZjExgeanuQFak04aUTcCh47Y/D4UZG/ElNbtJua0Y5
 Q7br+OHgEdUe2Eef0fPMvtZO1hwCeEOZUIOInhyC0aazbOo7BOZwC+xc2joDYgENpAmK4SNlFGl
 gPEiNnlho+Z40Z4bXDkwCfwicC5El2VKkqOfoqOfj0I0zOSSszZVTOpvlAkqpr0Xbgvi0eTWpIx
 VSDkzvDOrXTlb3ELbnhqpz1B7LpwtDaduT8aVSZAYZzA/aNW6E3PilQtRtB5USVoSyBSsg2H4Pk
 XUeYsJEFOfZ6bERYtiPdpne0MxTWRWPdIfDxL1RI5FHxLHhN8n74fZYgXK13F7Dyla0wscHL+hP
 0khnj/MxugOyrA3Fi9ySz6JAMzR4gOGD9mrwt50w+hSVICdMy0tPDbqiExAW/hV+0XmsUaMxGBU
 iHXKlXlIuBkI5nrHuozEI+NnyBUIby8SP7hz39RfWLnXbTwgo0zDCb8rJ7h5urjhDOMNizotTPh
 GBTF6CcfVi/l0+Zie+nFTOuNibkEvhtvkBtwQ1vhGEMlOxs1eWDIFk18Cti
X-Received: by 2002:a05:6830:2b0a:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7dc9518becbmr14204168a34.14.1776875952480; 
 Wed, 22 Apr 2026 09:39:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9759bfa3sm14380249a34.13.2026.04.22.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:39:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-boot-fit-fix-8-byte-alignement-for-overlays-v2-1-32a7878e134a@baylibre.com>
References: <20260409-boot-fit-fix-8-byte-alignement-for-overlays-v2-1-32a7878e134a@baylibre.com>
Subject: Re: [PATCH v2] boot/fit: fix misleading comment
Message-Id: <177687595157.1874069.6041443009792108073.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 10:39:11 -0600
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

On Thu, 09 Apr 2026 15:15:43 +0200, Julien Stephan wrote:

> When load address is specified but set to 0, we ignore it and load in
> place instead. The current comment is misleading, so update it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] boot/fit: fix misleading comment
      commit: 86122451b5b987a41a149e385f09d8335348bebe
-- 
Tom


