Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FEDE63CA4
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 19:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197F283D0F;
	Sun, 25 Jan 2026 20:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TdpwIx66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914ED83CF5; Sun, 25 Jan 2026 20:43:53 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BE383D07
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 20:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-65e943048afso986210eaf.0
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769370230; x=1769975030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKj30H4nvGQTDBkY6cfzexVRXox/SycugoeD9Shahk8=;
 b=TdpwIx66FKbT/oYfoXsmkSQtUzr/ZRCrk1sf9+3eA9XeUQ+mfpo+zkaIAEpOchV638
 GHjJ9CLOyc8TWJ99zWmrdX2ADwUayRzNXAKu1L69DYiigbYjMvrKAAD1iUicwmDeE0CB
 GSCu8pD7ZXkV5bS4vkObgiDT9pW72yLJ6Cvoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769370230; x=1769975030;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DKj30H4nvGQTDBkY6cfzexVRXox/SycugoeD9Shahk8=;
 b=eMJMD5j1blbtXKYuDWeSeMJepyax+llllDm1ZtOe1Hn3teWed15Y/cUUxvhrkXHsMf
 +ifGdtIz4fEy8KPpq1Y10Nu0RAS/7epBIVFCTMyjzlJJV6DnRRm/sT9f/3kXUUxx5eqG
 ilszTLlhBaAE34VT58gvlHX8DRfq7VpEBZmcw+CnYTAVTpth6/uqg2cp9l+z4z/qYuJ6
 OnhKBQi4q92LKN1dE6+KzMwF4PvBW5RnzsO62NBSGrDYFisWYIcNXFLvZXZvHcW1wsnL
 +2lfQHNpEj35hPfda1MV4xL1emP0uyLWzSZwsSH8HWtYBou8+ngWHuSFt0hjvcj/G+lK
 B0zA==
X-Gm-Message-State: AOJu0YzNm2L2xUrEMZ7QUQIWd+jE9ZKI11GX+MrVaqeZcNeGzPSnt161
 zMCk9TXDlIej5Mm/Cod5tK28sfE5jblRl/ZNa3o10h5UbeTko6GUgY9ZUxfnjGscbrg=
X-Gm-Gg: AZuq6aJ/nMpfU/2xQJjrJKlRb4hx75MiiupMwa3Ntqs2CyWW4yr2hmAZ95xrY5mDwfI
 MKBF+V4oqbWTgx+R0x0l7fI9hsv9WlbhDef+HOxIt3YBDXbcYTgbAmFL4tT2jWwc1h0Y4gj8Hc/
 gTOlOwOQgzHAPV5ym9mkIZCsd+8TTYT7aHEb59vzDvPuuYPseCHDeDWh4X9I0lSaLMf4nJqyFv1
 nFAfLyPTAhuGzBMiNxjgKJaCJ0t5S62n1R/L3NQJhGxRfPDi7tNa1kit21hNQmAFEDrP6rtcvJQ
 qg3Hohe6mtAaJ8h6DxInVcz/F7J46t8huc3VffeWu6IqQDixxcpbonm5s1t0BSH5BzkAM5tFkgm
 c+K4SWjtHsi90GWKT93UIwfVhydW9c/gbHStQL6wqedn3dauGeOjEpbk0HUph2FstwAdBQlK8to
 LoQ711hqZNWJ3tGwQ/DJmhBZTX9sV3UlWz6yHUoMZl7MY7o1KzqZzKPh4VaFbBQMfLYTlnleJ+q
 Ei4iwAkjzf44yUqwBbc/lVbIjHW3FCyJkrvWw==
X-Received: by 2002:a05:6820:62a:b0:662:c17a:2f45 with SMTP id
 006d021491bc7-662e03f8d58mr1203346eaf.34.1769370230159; 
 Sun, 25 Jan 2026 11:43:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662cb4e5a33sm4100544eaf.2.2026.01.25.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:43:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20260122092901.11771-1-malysagreg@gmail.com>
References: <20260122092901.11771-1-malysagreg@gmail.com>
Subject: Re: [PATCH] scripts/dtc: Fix pkg-config behavior under sysroot
Message-Id: <176937022908.3566385.12227150755329461724.b4-ty@konsulko.com>
Date: Sun, 25 Jan 2026 13:43:49 -0600
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

On Thu, 22 Jan 2026 04:28:53 -0500, Greg Malysa wrote:

> When building with a toolchain that uses a modified sysroot (such as a
> Yocto-generated SDK) that does not include libyaml, on a host that does
> have libyaml, building dtc will fail with errors like:
> 
>   HOSTLD  scripts/dtc/dtc
> /usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
> scripts/dtc/yamltree.o: in function `yaml_propval_int':
> yamltree.c:(.text+0x167): undefined reference to
> `yaml_sequence_start_event_initialize'
> /usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
> yamltree.c:(.text+0x172): undefined reference to `yaml_emitter_emit'
> /usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
> yamltree.c:(.text+0x1e8): undefined reference to
> `yaml_scalar_event_initialize'
> /usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
> yamltree.c:(.text+0x1f5): undefined reference to `yaml_emitter_emit'
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/dtc: Fix pkg-config behavior under sysroot
      commit: 807bcd844afeadbfe47ac132524cc7e3b699bc46
-- 
Tom


