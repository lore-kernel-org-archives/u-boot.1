Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C867CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A24D840C3;
	Wed,  8 Oct 2025 22:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXEZjLg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2721283A8E; Wed,  8 Oct 2025 22:59:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B7383F6D
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7b00927607eso222784a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957187; x=1760561987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WWnTLeWUQa3nDpfDoxymcbemZAglCQ8Q8C5hX8mSWQ=;
 b=XXEZjLg/UWzMWy7YaLgHKnV9OLMCH7MIZlPJo4ynpDGiuvtJ+njoPa39LBQzQZB2aA
 szEQYhfIdkHutZPxNyXebexlWqHtqbcYVCIVNBm56p9E9s/nTjIWP/3bAHlGzg0Nun0x
 8Pk5HGNzvqp/VIdMZausOza1PKjE+fgfU5ctA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957187; x=1760561987;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WWnTLeWUQa3nDpfDoxymcbemZAglCQ8Q8C5hX8mSWQ=;
 b=braIuZXeBGAfGWExy+SO5gN1TVN99xroI/+M/4OtV1gF0PzQX3OaTU1LfnrzFdsf3s
 PZa1U1er3wcSFJd/AqxARn0N8C3Bvmce8twebj77KQOeUK/m0mrP9eHZzKpf15YKqldK
 IMziyHolHYYPi+aLyqpHhTg6Tl2mXv5VBXct9klRuvlqL24slzYJDWfqvCyByFO99h8s
 lye59siZSoPWMNlrOLDw0sUiUNoIcfA5vewUmrith5Gv7RIp+UCk237nuuy7dd4izxGc
 3LGkFseVxooq8Ru2wGvCRfi/IyQH9E8JyM6h34BiPAU5S+ouW79lP3+u3PDgVD3ncBSu
 NmaQ==
X-Gm-Message-State: AOJu0YzcVXjB5eMBpoOBFrXGWKhZm4vfqbWhcDv8b0spscORPQxfsZjb
 a7szdEU+yl82wTpyM9zsRof2ZU2Q+B+Kay1D7R7MES5/E03sEOpjnsjgE/inmECfZP0=
X-Gm-Gg: ASbGncszIz1f96UNhuh78k8bY4KGuBDfGNkHvSp7hBmSD9hXcniMKl98DPAlXS0Q4UE
 +X0RAg+fUX+Gwj+pymtVJ7AGUR219BqDqkhZbFRTn/HWR0ryT1z4bykONGCyd4F4uOhmj4lq/Lv
 LnzhPtPITKuaUkCe8sUUHFDNjywfMcMiR+pCk878xoPpVXf6PifdVBBer9JEabgxnBeagCx9aXz
 /9vaFRnx/S/8FUGAqjAG4BSaOL8FoSPQyjkVySnDCj9V2py908ii5nNTWvwxhtiepQKVZb0QPaG
 VIsP91HPw/YXvFRzSxU3TycmbjLgBKY7AJJYSZVx/H7cVU3rCCpZKptNApHP/UZsLaTW8ELKBJN
 ctRZiOyqMj7ifp6iKTjmIurrv9J0mQGVZePdI2zpnqE9Cgrg4eqF39y8WvgTH7TVIhF/Z2rXxu8
 pYfLQaBtn7
X-Google-Smtp-Source: AGHT+IEVR/logAs6RYgq9PcJPPQ+v1eVrNFZK/JLMQnYpTLGAoAUoV4qygCRzQIysKSsq3SvZN2nIA==
X-Received: by 2002:a05:6808:1a20:b0:43f:6f82:e16f with SMTP id
 5614622812f47-4417b2fce76mr2943540b6e.12.1759957186712; 
 Wed, 08 Oct 2025 13:59:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
In-Reply-To: <20250906000507.284853-1-marek.vasut+renesas@mailbox.org>
References: <20250906000507.284853-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] thermal: rcar_gen3: Add Renesas R-Car Gen3/Gen4
 and RZ/G2 thermal driver
Message-Id: <175995718567.3059512.17298787766791080823.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:45 -0600
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

On Sat, 06 Sep 2025 02:04:19 +0200, Marek Vasut wrote:

> Add support for R-Car Gen3/Gen4 and RZ/G2 thermal sensors.
> Fuse readout support is present, including fallback trimming.
> 
> Example usage using the 'temperature' command on R-Car V4H Sparrow Hawk:
> 
> "
> => temperature list
> | Device                        | Driver                        | Parent
> | thermal-rcar-gen3-tsc.0       | thermal-rcar-gen3-tsc         | thermal@e6198000
> | thermal-rcar-gen3-tsc.1       | thermal-rcar-gen3-tsc         | thermal@e6198000
> | thermal-rcar-gen3-tsc.2       | thermal-rcar-gen3-tsc         | thermal@e6198000
> | thermal-rcar-gen3-tsc.3       | thermal-rcar-gen3-tsc         | thermal@e6198000
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] thermal: rcar_gen3: Add Renesas R-Car Gen3/Gen4 and RZ/G2 thermal driver
      commit: 0581328b5812b1297204b520acf8b6bbb09e6700
[2/2] arm64: renesas: Enable thermal driver on R-Car Gen3 and Gen4
      commit: 79fe4655d67fb68e4172e45e8983815e26a4cd05
-- 
Tom


