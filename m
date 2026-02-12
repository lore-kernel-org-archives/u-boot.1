Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D9EEA846
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 18:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F878367F;
	Thu, 12 Feb 2026 19:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTyqI7zP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAB283B9D; Thu, 12 Feb 2026 19:17:24 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317BC83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 19:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4be94eeacso60373a34.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770920241; x=1771525041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzWOUFO6u4sVkQyVSRquBr5fVFTY/K1rRCi1uX6yl0s=;
 b=oTyqI7zPVFbeVCptNNK2DXdzMlD2IgOeTpY4wpJTfI/OMUHC8uo6GYbYdtOH/yBylB
 wkEtukHzoDE0pvn+KLiOmBBwgqgW+2O8ZMAz/FtCmlkdLOVdFz4Itndyt0SAGArQMArg
 5zvEzc5oousa0LWU/BYg9oqZ5aZOiate93Jbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770920241; x=1771525041;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hzWOUFO6u4sVkQyVSRquBr5fVFTY/K1rRCi1uX6yl0s=;
 b=RVb4zmiJWfnnSFrQZQJPDzpgWivT/Pofmv9mix3hfhqsr6m8amA+gSUpwiylITk110
 jC7WxpUge/llvQgV2OAxQAl53+OqxDaAiM/VuNAemGJt6Mh9DgZjI2jsxw7PtqtTirdi
 wchEYhR2pVFyjOjsijK/LG/pd6qTwIlz49O5W5H924+Zen127m2uh3foJNu1UWrNO5n5
 O66vzkBXNjJ+/pFGhclmfBgrq38+D/I9gqiLRI2zkai0SQ3T303pfyoX4jd6iIErM7Wo
 aQgz/TaL4DDlBD8iyMUpjYt1QAlNbLSnQ52jlWC9rM9a/biMl/dijGti0GVVk2cUCIt1
 ZKQw==
X-Gm-Message-State: AOJu0YwsJvVKTLjxhEbdTR4LuvYMe0yx5u13ED77XTVxx07OXCUNqodO
 38xVmVDXiuzA/GlvYlvapfN8N2cnQM8qYfMU+/Br7HqfD0TsJfCReB2p3T3wY5TVjrP8/Ar+sEe
 N+7Auy+8=
X-Gm-Gg: AZuq6aK+RXk44FDS7rmj9N6ukxRFfc20Lu4qyHDXUU66G6dINr2oDNDNv9782seRHOk
 +FOJk1z1sfAf3enpon/0lwYfxSVgBKQmdeO7p0LYz1ihRtwYVpT0eXMj7DYFrQlKFWm/CFVtEuu
 D+6Pb1c0goFTVz8vv28EAd2nm1kDgrU4b0ES3sCFiE0fqcVTOjSeuRfK9FLE0/sH1eFaXqeT6u1
 kbul/UtUtjgx4lRCeuOAywunhesqYWkVGt082+UUA9laH4mRwQRiB9/gpCCYJZ4VAlJqRXScOBt
 f/8cHXrWHomHUfSEaKDle1pbCZz3F4amADhZvMbc8Tblg141UNccLAM3ivTjxHpFxcMtLOVwyFY
 toEexeZvDaMSvnRKDc+12wpX1v6VTVYYGsv3MSjOcFCMPgdV064iGDfr5cJAOJNrpoZ23I5UmgE
 jScdnIZDCcmWYcKUSxHad0ABJx72IbJhGIlPUiwx9po8nz5ZhXwXuAwD2uQay0RkK/CyZiu80/U
 s49ahI6DuIXLA5OWRCX1jHoUCzAb//WkFF9nS2ikLs5XktXGQ==
X-Received: by 2002:a05:6830:6381:b0:7c7:68d8:f702 with SMTP id
 46e09a7af769-7d4b3fc11f2mr1748525a34.9.1770920240844; 
 Thu, 12 Feb 2026 10:17:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a754b162sm4057894a34.12.2026.02.12.10.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 10:17:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <c3030967-2a1b-45ee-8779-773fbbab22e3@amd.com>
References: <c3030967-2a1b-45ee-8779-773fbbab22e3@amd.com>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026.04-rc3
Message-Id: <177092024011.2032731.15928621339412663401.b4-ty@konsulko.com>
Date: Thu, 12 Feb 2026 12:17:20 -0600
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

On Thu, 12 Feb 2026 12:41:32 +0100, Michal Simek wrote:

> please pull these 4 fixes to master branch.
> 
> Thanks,
> Michal
> 
> The following changes since commit b99da05e1538b8fa153322da82917af2aa27e1d6:
> 
>    Prepare v2026.04-rc2 (2026-02-09 15:07:50 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


