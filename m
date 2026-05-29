Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C0ECD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC06846E6;
	Sat, 30 May 2026 00:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OnUNxoD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239D2846E6; Sat, 30 May 2026 00:47:07 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BA9846A5
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43bfe055ffbso2993450fac.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094817; x=1780699617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64cjy5klb3z7CjL1bHHmIZe6KrsX39bomtoYIWmY8yc=;
 b=OnUNxoD3g/Gb0jhXH9RtC+42EQQx4pmwk/oHlcOwgZVWs7Ms1/zmW9AL4r/AyMRfEV
 xHN6/4BB3wldshzoju5QvtLCmsEAnE9y0zmKrRfa6shTb9hHzcKGaaI7C3GafCfMmYel
 NB4lJ+OhZoqd1pDJOFB80xPJ8mSStHHGKVqxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094817; x=1780699617;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64cjy5klb3z7CjL1bHHmIZe6KrsX39bomtoYIWmY8yc=;
 b=j2PS7S1zOHSk0QqbyOhIYlqMfHTop7dLX7vDyXEhnYk6o+Mqdg7kbQjhlENYNCp48D
 EJ1zMMXqbUqIczGrV7LyrQEpJlaCb1EwLXW+xPHgeffQWrufWEHIlvBG1aaI478WIu97
 Cl+0Ez0W4MOAj2hYF01B4I+AiScyOgnSG4VSONKy3UL9GFdAI1HNXS+1RlR+lR1OURqM
 6Fss6tbiFTx3h8dmft10ASv/12RrA1qbxV1EHpaCMkW95C+fTT6TLTmqOUtNBsMfpBmg
 nTNWpxyJQKbuKxm6WhP5wwTfpM+LtjXXZAucSmXGa1apV6zmo3X7Fu+/KKh6zi228nOL
 hx4A==
X-Gm-Message-State: AOJu0YypFeGqhOGONv1YpeqoM+qCpnfsYlXJ0Yv6yg9m0tTI6BBX350n
 cSLm1AJAivPar7nebwUQvy8maW9Y8VMRHdbDkvdGmvgC0hv4J5xB5s7ksnw33LxI68Q=
X-Gm-Gg: Acq92OGn44FjUh9mNZU2XGXBh+sNNCoqjV72L08YTPO6VTxc5CyyQQMfKEdNwh0MdBR
 kPZsjZ+nPUPHzWM8S0jrdnuKNIo+b7GG8xxZwcyHhL2AtdN0O9X7j6+qlFGdgsQSpJ0QnNT+Bco
 8Ts8eZNv3JagX6YV6d59o37Pz7swBBiCyZx/lrAqao/cHmH/TbfinRuKzjo/VgkyIZjfcizKAwp
 y9q7tzkeQFAGtCpMAK+nOKjNtUtLZSo3KV2M0JkDjZzzLjF5ZS75WfyrgOmWCNs8Pgui2QIdsXh
 IgZgxE+sjvvftc4+pMdVbdFu/QpqjYS2AZ5I9HYIClLydYkmh9lKCnwF5e4lOLGrwIgK1kjzOzU
 cT5GgSBIsp9yipcNYCkwmF9XKAr628LW6N/32kLBCRMr1n0n1rhD240QwPl4TQk2+xmrnj9atwa
 CzUmaM6bb8xms8DdlDPGOIbeIE6mbrooI0s8kqDmHR8t3+5oKA25F3h9sjIQHX3BlbcdwkIjK69
 I0HYZZ+zKO1eLj5cjTl2ULQ7yIRCk4k5XzBVZ+3zo1t85CQIFC3LAE=
X-Received: by 2002:a05:6820:1c8c:b0:69d:8f9b:f2ef with SMTP id
 006d021491bc7-69e10563fe6mr718698eaf.29.1780094817468; 
 Fri, 29 May 2026 15:46:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <BESP194MB28056BB07D2C25BD5409444DDA032@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28056BB07D2C25BD5409444DDA032@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] boot: cedit: Check ofnode_read_prop return value
Message-Id: <178009481684.728062.17666619596227153424.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:56 -0600
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

On Mon, 18 May 2026 16:39:27 +0200, Francois Berder wrote:

> In h_read_settings, val variable could be NULL due to
> ofnode_read_prop returning an error. This variable
> would then be used as the src in strcpy.
> 
> Add a NULL check after calling ofnode_read_prop.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] boot: cedit: Check ofnode_read_prop return value
      commit: c39e0e257c931c1cb03613f46b01e4db6cc0d44b
-- 
Tom


