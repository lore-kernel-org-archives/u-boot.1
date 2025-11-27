Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EC7CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB3183B4A;
	Thu, 27 Nov 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B8bUi78v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4868447E; Thu, 27 Nov 2025 17:55:52 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6818D83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ebd1b07919so272067fac.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262549; x=1764867349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hQGHVzmTonZro0TAaVBiRXP7oPJK1nzVw4Dli8nQuM=;
 b=B8bUi78vyx7xLfRum2U8vIdk4RES81Z/9VClq9OL8IXYddJBEIF77R89Fvl5AhMCAO
 1JwOqEsE+nAafPsVNwUE4UpVvPwiZSkW8r1zV9oBi8ZKT/Yzn7PqRxzGYCXtanPD3REa
 Cu2jWBY6TZE3Rmrroy171+jv+nseL4Lq1FJjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262549; x=1764867349;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6hQGHVzmTonZro0TAaVBiRXP7oPJK1nzVw4Dli8nQuM=;
 b=n8V5O/jg3nwUeN3BR915QX9l015gDWa+d3xsmcJnoPPenA5adnfwXQrkKC21hGDjrz
 HWFlBnLR77h75XYXG6s9q00204SeFF4XvFnFSkj/TFAIyW3ZqZj+qZha42uR9yuJ+WR4
 BSyhNQbsEM22FXKrMgMlKimcDmkFJvQLgxjOjJfKvQFVdTbjJkAWIxKqT5AX3ejERk6O
 6HE/gaq3uOacoMK62FEOWr6vt7d3szDnc8iQvYR0N8DSJVAx9ei7utBkNSqSnBMeMpmF
 ylz3wbHHZTd9sVfBwrBIL3vgGu97pqwJhCEi2GiPY+dEj6X3T+tSBPmjz+ncVirfjBwe
 e3TA==
X-Gm-Message-State: AOJu0YzxTSFOB4UQZG15g74cA4ncLuM9HMuCvuz0mjHHOXmG/XWkdTiJ
 noDBdAM9/Pw28vszggD8T4LxQ+Ug7VxKpMPb+WW8/uJR3+Yt+y9sPVHjy4lZpzbeBrDIZGbJH89
 kNuCIyS0=
X-Gm-Gg: ASbGncusxAEw+TYGgJyhnu7XgJwROW0nfBX6/l5KezxAbt/M0rwBXW4UEYwVvYxx5ol
 o2Ne/PVdfITJYMVGTMu3VSOeA2bYJA+kBNOJouhu9ROiq6GRi+RHMVvY8aFG/gunXp1MBYhHeWw
 s9/RTApyZxV7Acg+6HefDpkkvJzLyrpaNER5v2w+7J8kNLkJ+aK4io9NvrCLIQV8iKtiVwhApkb
 +jlExy1FQMWDV7IGYTqE+kamy/gQCGmQwYRqNjEVrJ241R05wpt90SDSiz1ReT4i25mtTKumreY
 9r7C4NzXzrNzzewxm5m1Jl31wGus4gx62y3tRAIgKPJZJChMLA0f3YDKxLsOppEGDvJyhA1p9FQ
 fDcVCAtP06HsE1cY+jiAqIGfj4WkxDFkBATcuCQ88i+MuhDUBiGc+R83py4HUfWUEp/5CFbonVe
 FQIKv2tVgJqM+cFXU3eThk/oThqrzfnQeKNH+Xj4dTF9r22zKC
X-Google-Smtp-Source: AGHT+IEyNPp/xVkvToq+wgVCDYm5SDxkdQtkU1MHBHpIgIFvydSayCRu4cuvXEW4bu0AwuirS0JRtA==
X-Received: by 2002:a05:6870:d6a6:b0:3ec:5cc6:315f with SMTP id
 586e51a60fabf-3ecbe2c4617mr10094027fac.3.1764262549196; 
 Thu, 27 Nov 2025 08:55:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
In-Reply-To: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Subject: Re: [PATCH] board: ti: am335x: Fix DM_TPS65910 condition
Message-Id: <176426254846.4117678.287766807160012328.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:48 -0600
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

On Tue, 25 Nov 2025 13:55:24 +0000, Maarten Brock wrote:

> scale_vcores_generic() calls functions implemented in
> tps65910.c, not tps65910_dm.c. Change guard from CONFIG_DM_PMIC_TPS65910 to
> CONFIG_SPL_POWER_TPS65910.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: ti: am335x: Fix DM_TPS65910 condition
      commit: f06e1c04bffb89cd14d559c8d3e219ab2b815093
-- 
Tom


