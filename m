Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E124CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 21:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AC683C23;
	Thu,  6 Nov 2025 22:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PUEm47iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F318283C34; Thu,  6 Nov 2025 22:57:54 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE75083C28
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 22:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-656c4ed6ea9so21027eaf.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762466271; x=1763071071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jPQ3IFZvg94YTF0GGrY4qZXlpDsqi7qGv+5iCqOKWWI=;
 b=PUEm47iTL8iw5TBL+4FnexIPvN8DALWtAQ3uNZbYxyGMdeLePYhfaiyqKX+18b7PyF
 xVcwo2JhCXOTEKzHuOwMoNxeRtanKqNajQH1O1SJ8M9u3+WaS+zTr6e4kJxQ+3hhS3/Q
 7r8MarKAXYWdzUwsQkHNuQQyRns5lcixjBWdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762466271; x=1763071071;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jPQ3IFZvg94YTF0GGrY4qZXlpDsqi7qGv+5iCqOKWWI=;
 b=Na7g9jaE421XywCIaPIIackUaZrJKZH8Z9VOaPIng8/RMsyeNhswMFio7RDYxD4jy5
 7er5dBQp1F48fRzbN8PuRilmnYkVLsWl8oFySyUBmj/jdYrZsLgbz62qKzCFt1jrvww9
 0PdanmYkbuHZmtaWm9sDMz3vZQodlDOMOc3BBWdbP4SzggxNJZifMMTVuFdDpQb2qlhO
 crCXTWG9KW68+tbvP6zJRMTxXT560UxXsOQpPtv0qZUJMVdDLZwhLUyRNDYZ5L37xTCx
 s9aLFJ+CB3dvk5ldmuRnwspwjBlvGdpVpq4DIVnzsHpGumWG2pYuH0OEfsqYdjvDyDRz
 8yIA==
X-Gm-Message-State: AOJu0Yzak8g6EfIotbDfyjTmS69l8u5VZ8oWvuQmo0iPvff6W4pvWyFl
 V7/iXxQV98wpFMcU10+cMrKN+djyA9DsyXA7goKREITkwmwy8CesVrDLqDM3E6a34Jk=
X-Gm-Gg: ASbGncsh5ULA4Z9wiRXoOVfaD0Tcnx8ijxRhEH9yhtPvoUdY2vhmmLrjUm8M0eq2aeT
 Un+OLbwja7EHXnPkmM9nubr7HNpFROQs4uN/JKWpPb0MF/uMsNR59Irmdu4hdKPNoQuffSIlKN6
 pD4uOGYvixTUb6fry7t8lzwsPJAtSoGlU8YfGTy5euY0SIbchIivelJuC791X/5oWN5o6yDkKb2
 xPzMJa/lHwnKpcaBtQZZpZSEXrPaYzfDdCfGizxWac2wvNJl0pMzGUhJxeTGKErtvSn+BUS8r0F
 t06L2JsRvAo8MpwzPNj3md07McVKUZsUb5lDjbmWSZ9wr5LHn0r6Cgc8KcESUn+K1DeJ5YsMf5X
 brjjio+n/XAOA3p11YUriDCh0S0oYmmhzpUcs0G4q981GHflXCHK2KRIi4CY3jEwc5cXDwcACeI
 lqlzFl3ei6JbM/dqzUD+W7qtz/FvTwmK8sbARlCbVd1YF01d+x
X-Google-Smtp-Source: AGHT+IG7SJ2k32sGVQ21akyvC+y3P+PruRgNU2Ri6np6nGI/ld73DWTriFGc+e/y3jlZjHMZBnLGyg==
X-Received: by 2002:a05:6808:1890:b0:450:9f5:dcb9 with SMTP id
 5614622812f47-45015d191ddmr616624b6e.24.1762466271572; 
 Thu, 06 Nov 2025 13:57:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a715sm370514a34.4.2025.11.06.13.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 13:57:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251030043558.2620797-1-trini@konsulko.com>
References: <20251030043558.2620797-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab CI: Rework our tag usage again
Message-Id: <176246627096.3129497.682434390557357881.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 15:57:50 -0600
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

On Wed, 29 Oct 2025 22:35:58 -0600, Tom Rini wrote:

> Now that we've had jobs running on both amd64 and arm64 hosts for a
> while, we have enough data to look at usage and findings. For the world
> build job, make use of the new DEFAULT_FAST_TAG and only build it once,
> on either amd64 or arm64 as we don't run in to host specific results
> there. For sandbox, continue to build on both arm64 and amd64 hosts as
> we can find host specific breakage that way. Remove the mistaken
> restriction on sandbox64_lwip.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Gitlab CI: Rework our tag usage again
      commit: ddc916334a7a7e180b532dbb2cf1b778466d2b9b
-- 
Tom


