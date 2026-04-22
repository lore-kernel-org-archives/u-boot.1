Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E3EFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579A28457C;
	Sat, 25 Apr 2026 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q8kJbhqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE08384558; Sat, 25 Apr 2026 22:37:36 +0200 (CEST)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918DE843B8
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so13264646eec.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777149453; x=1777754253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZIWGXFAyZT/lMgnm9W8F91Vl2w0kweRJ0Ai/SJKWbs=;
 b=Q8kJbhqMGzvwCKudq16L1WzZLGJubj6x/FfdVA5OOTG9hO6alxTBmd8ZR8yYmMdmrY
 1SLZxtUEPY4955CHKNSIpzTKXK5nWz84QK+Cytxd43Qu0iOayOx+3DwG0swJ2Y46zRdf
 WBN/gtHsTXc4UiRbMceMLB3KDfbUehXtA/7BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777149453; x=1777754253;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ZIWGXFAyZT/lMgnm9W8F91Vl2w0kweRJ0Ai/SJKWbs=;
 b=YtXEAyRZVkJncphNgODlu9/vSP62sOqFZPDijDRhdgn0c4Ygk5KYf7j5VkXFO6mshN
 CJu520sF7+7vH0MPAbl9GAYRtFTPi0ndy+tJOhEqvbZpA0LQ3l4BGLRCqzpStbAuDdGO
 SKGJLOXuapi9nQO1WkL2eEl1z5/MeZ4Fmlutr5vh8Z4i0pUgNtWamqrbeG3yo5B7E/XC
 PQGO9pbFNpAq784HamnWLPGer9JZqVI0hz0OqYhuj5FGH5PGoBGFLugjkDzET6PHyABW
 7UtSOir+nPOjl5vPACa8mIVMj1LPE0FcwV15XfMjCDmEdGyjXPnHagPsEQATU2WRLe54
 +G6Q==
X-Gm-Message-State: AOJu0YwOXgriZIm9v9FC+i1K8NW05IZtVQwD40L4POl/hUnkfEbc2zau
 zCfzxdbkhab3TB9vEmAfBUB2Nx3nbHQNmqXEEJN1+JZU0EaOo3OoJhbFfxydn9x8yZrK576bZX9
 XvtphF65P1Q==
X-Gm-Gg: AeBDieu1VglGSacY8tgxaPrg4wnC6haf+e4ijx30/JYhceKiYrl96MK24TIBOszsZ29
 zINXFXSEAV0GoJt71+G9N2b886h5OQKH6pkte2poUsQCgk8nEpUrLOao8XcMggAMfCv09cFVD64
 BcUq/uzwxckTIkalg9FLJlOEaLae/Tz5LpxdTUU7W1uSzyos0eHRRVp3+7LNnrDS4D/y12Xd7sb
 IAjzbV69vJjPKZSQK+H7plcxDytVIan6W1XmQGfnXJF/UlyRQrzZ1YORq0rXBlsjAUXvTD22rlk
 GSXQGnI/WnqwKZ/2rIEIgc/CB/cTmMWMNSHRCuxWC56dxVp6ZklyATL956pG/RSvIBW1VaVCmxb
 OxBQ3roxGTeTcU2aBLXeTUGpM9JbxwTXoGeua5OCaYiZctQPdq8cNYbotuvlvH0xfQ8HyzzfGpK
 1DNO7q9SemjY8tO6pTYnfFM0PUJ6HvjwVmxpS6OFLrb12MoSQIpK4Ffqzd6XUBHEB5j2cAlNbjR
 7hyshb7qEwyynIfUJMekQtRIYxDricRfAKyP5FK15QqPJshd27qy8v/pGpr
X-Received: by 2002:a05:6808:6f8f:b0:46a:7c00:5cd8 with SMTP id
 5614622812f47-4799c9fb44amr12317468b6e.22.1776898138392; 
 Wed, 22 Apr 2026 15:48:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f3cf40d1sm3874175b6e.12.2026.04.22.15.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:48:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.dE, Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
In-Reply-To: <20260401093354.3608142-1-philip@philipmolloy.com>
References: <20260401093354.3608142-1-philip@philipmolloy.com>
Subject: Re: [PATCH] board: adi: Fix exception when using standalone SoM
Message-Id: <177689813754.1956774.1584582090840741597.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 16:48:57 -0600
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

On Wed, 01 Apr 2026 09:31:56 +0000, Philip Molloy wrote:

> Although less common, ADSP SoM boards can be operated standalone without
> a carrier board. The SoM can be powered over USB-C by moving the jumper
> on JP1.
> 
> The board configuration needs to be heavily refactored to reduce the
> number of defconfigs and leverage the devicetree. The TI DP83867
> support, which is dependent on that configuration, needs to be removed.
> Until then this change allows the same U-Boot binary to work correctly
> both with carrier boards and the standalone SoM.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: adi: Fix exception when using standalone SoM
      commit: 1994e69d4e5b8b8bb01436b6b8e7ddf42d8e4785
-- 
Tom


