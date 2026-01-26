Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D7AD19523
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 23:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542E483BFE;
	Tue, 27 Jan 2026 00:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H18lC2nO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C9483F2A; Tue, 27 Jan 2026 00:28:26 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C329B83B43
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 00:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d148db5fdcso1742501a34.3
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769470102; x=1770074902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcKPA6032OUVsPtzSCck/voAfHp0sULIK0AmrHEbXN4=;
 b=H18lC2nOxNneRZ86vvmgcDg9tdLF2E1yCDYYHzbefVzvJqi4oCUrmK+9tT/LW/Ql2p
 y9B/qI1pjOufRlMrTtQe4mADkkGRt3tDuFwYselq3FL/Lw/cnHKtWDMIu9hwD+VoBJaY
 aT4NeCLrAGvHE4Ns6ZiJA11QcOJNjxB8U3bZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769470102; x=1770074902;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KcKPA6032OUVsPtzSCck/voAfHp0sULIK0AmrHEbXN4=;
 b=klcMI/66HJ8Cd9N2FOU2zt1g2GYLvSHINvSyyCO4YToKBhJiYgikwOYeorygviSN1B
 DOnWSNyQmKarf60o+vBqTgs1wSGVLoM6rkvpDHXvPhocVcWMVMDNADv/iqXcn5xD1QqS
 VhxIcUw/dDvY7hSNsuEt4C+NptTHEGuef14e58mkuksatOcNm5yLBU94JCnZobplNAGm
 E40eTU0dU5dBA0fme7AOtsq/XIvoL/TmL28tiu21goTwSky/ps8lGZWFSpxNc1pkPsqd
 DH7oSXTjV1421qMjQaZpZIx+uR9LMXOAYJoJ6gz9T+acmyGzzzbkumPwbVZ1hwLR0CiA
 HwtA==
X-Gm-Message-State: AOJu0YxgZ0yNGnDiUm/ehtXj7sYEDkqw50VsTyBbzq4O/UB5Us2KISBC
 YBocIZwS0dwPnHukymLtdU1SOqovR3w64WlBX0UP9HL1lvW9Fs8h8qRU3Znym8uAjJkdZhLetER
 DuyBx4tc=
X-Gm-Gg: AZuq6aLgxyGoOQ2ebnHlp8QZyqm4cn2FwNvDXNM+XqK3JchUeIzDf5wz+jp31JDlggt
 5EuLqvI387aojcRKHaCIkZD2HGn5bJYTUhxk9RvkIC9o1YVqx9IEya4xzILhWMkDnGddR5dYysg
 Ew3UMxTNCxvjY7Qnuhfu3uRmKMbITjp56+P++VpKVNYybyUSA5QoNyEJY2upKmlst3IkpD2NzXz
 ecFlELiv4fm2MfKmRsN17Ayue80VmTtohS2v5QoepQSMUObTsBjgxFHWHPBYwbVMxIC4ivxOjdc
 rbHsNseKT5SCy7aaYc1RUq+L7UMh2QLyw3lZtN1YbdiK106X8WgEXq0oGf2IXfnxWiGLL16yHc6
 EenNvITodAF3evgQ5/3rbb6LRQnCX9weeh58618XscUkSeFxzI362e49kDYL9v+RVSBWVV8Pt0x
 Trkyjepmgvgu6tqRHa+5PHO9Wjow1XytfdQnAxIIkFS9asyNIQHFa1Ft6vvLSoLRYxEB+Ny6teH
 JTLhg5P5J4TMPbXfqbeLWL0PbNLltB6C3wrVA==
X-Received: by 2002:a05:6830:348e:b0:7cf:e41d:f0b0 with SMTP id
 46e09a7af769-7d1702a647cmr3808529a34.18.1769470102476; 
 Mon, 26 Jan 2026 15:28:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3d2abbsm8960729a34.20.2026.01.26.15.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:28:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260126121002.383545-1-andre.przywara@arm.com>
References: <20260126121002.383545-1-andre.przywara@arm.com>
Subject: Re: [GIT PULL] u-boot-sunxi/master for v2026.04
Message-Id: <176947010181.3827022.13886990763019837363.b4-ty@konsulko.com>
Date: Mon, 26 Jan 2026 17:28:21 -0600
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

On Mon, 26 Jan 2026 12:10:02 +0000, Andre Przywara wrote:

> please pull these sunxi changes for 2064.04. Some improvements for some
> boards' DRAM setup, to allow boards with "odd" DRAM sizes (1.5GB or 3GB),
> and to support the T113-s4 with double the co-packaged DRAM.
> Support for a new board (X96Q TV box), and a fix for the DT name prefix.
> Also we support the new AXP318W PMIC, which is used on new boards with the
> A733 SoC. There are some preliminary support patches for this SoC, but
> they are not quite ready yet - though maybe I push some uncontroversial
> ones a bit later still.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


