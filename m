Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1091D2F326
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4143680433;
	Tue, 13 Jan 2026 17:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="smmruB9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCFF80325; Tue, 13 Jan 2026 17:13:25 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B511380325
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65e9430489eso2742984eaf.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768320800; x=1768925600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/VNjtUODK+nLZ4joWIai5byIKucNKO9Ccy+F5vsato=;
 b=smmruB9dvKDRQq7IBxGFcTvZj11wfadvMi42tDdEgrxDqIZ/0rd2JJDSXh+KJL+8A4
 b/k1hge/UgMe+iOBkuSTpDfCyrHKg4foSBIqjEGG1+OdC8J7bGhKtYduExNPsYZunRKy
 JjH/FkKuxz99z6IfB5SpDfShkzj/MsDjmCQo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320800; x=1768925600;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/VNjtUODK+nLZ4joWIai5byIKucNKO9Ccy+F5vsato=;
 b=vsny4LadeARrJ48wH2vEQWxAqCoPJWodQ3Ht0gLgk+iuoXvUmVidVcVCIsO5/6SxMv
 DZQvExBkDxYputmKwjPNRqWZVeHzWrvLFP/H2utD6lzk6SAGSy39fST2LV6EzzVi8Rls
 hb3LyKVUjLNy036WGoSFcq+ApxRInRacP+zO6O4Wc6YvOKukm8olfnB3ZcAOuB9HqmDD
 oOsNre1PpBLK9vZzycJv+yId/t/cht6QNvdGAKcL/rzl8wInbhnWaXBO81R+sNqpAuse
 h3/ZRv30a1FMKtcLNDZCrf2pCV3DqbbgGWNJ5FVAscOklLCrijv+nLaL/pSp2x3++6zj
 9blg==
X-Gm-Message-State: AOJu0YwMkbTUon+eGQz3Vdk/9rdcZnvWi0f2fF+Je5tV7wxy8YIP0wrl
 Q53AmNW7MqA3KXWL7FZCDMF9ReyeF1oTy6a0gfkxzLSUcljRL1nuNKKFKeL5KXc49sw5g8eVOMP
 FeDeRplk=
X-Gm-Gg: AY/fxX4YOrBoTXSoTpcqH168FpYo0TvNsnEfPQxkgFnHAErEuQQ1nwdOuIUpSWSkoez
 cZkGRRshtPEjGF6LU7EfqtsdXGCNx1ewdknlKqYK4Af8Sgt6gsxwfddHJjVJGnmpxQ0euYaacad
 vLU1PAyxBtRgBR5ddpjP2Bo83aKY2/mstF9FleC5jeGmxQXF6hf32lb28koFUG6garUmzdQKhuv
 AM4fmPP5xG4YkikQt0iGZxjk8ysT+2pNUem4AP3Y/I0y5Z/7pUSQ3kN1NqPXI22yyRubjxtxLVE
 ln5nRXqeZ6aQd3nBR4CFUUg1mwehiuAEvKNMqG2dc+RJRWQye46nUkfMwqrXNUmcWOjNWo9SE4s
 8Sd+nH/ZLWvicMfMpD7SBdPv+Z3froXWja4lV4ObdtleQoYRyCaIfb/CDvu/UKhn0OcWO31+9g0
 TL4H3tjNVdcWNdUeTLguMl+UGcZ5ZAClhxdnLK4CnjXC5Iw+k0zcMHsAcvpxqjyoY894NCCuihw
 VFKKYu51pwbKuOu/xUHpZtScQ8EKTO95zHxBQ==
X-Google-Smtp-Source: AGHT+IEjpUwxb5B9VTAHbAX/Yi/bYw/CZuMoIczDHhy7RI0E97uxqe7LE8OvBnaXOYWnQ6XnfD/Bnw==
X-Received: by 2002:a05:6820:2205:b0:657:42c3:42f0 with SMTP id
 006d021491bc7-65f54ef1d20mr10982048eaf.2.1768320800367; 
 Tue, 13 Jan 2026 08:13:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm8575162eaf.16.2026.01.13.08.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:13:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260113013211.1947438-1-trini@konsulko.com>
References: <20260113013211.1947438-1-trini@konsulko.com>
Subject: Re: [PATCH] gardena-smart-gateway-mt7688: Disable CMD_LICENSE
Message-Id: <176832079947.2039494.5866647829843754305.b4-ty@konsulko.com>
Date: Tue, 13 Jan 2026 10:13:19 -0600
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

On Mon, 12 Jan 2026 19:32:11 -0600, Tom Rini wrote:

> This platform is unfortunately frequently very close to the binary
> size limit. Currently it is so close that generic bug fixes can trigger
> build failure. Remove the license command from the image as that frees
> up nearly 7KiB of space.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gardena-smart-gateway-mt7688: Disable CMD_LICENSE
      commit: 84fac64026556a0aba359fb10aa7875ed30ce6b1
-- 
Tom


