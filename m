Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04B0E92716
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4902283CB9;
	Sat, 27 Dec 2025 21:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gO4QK71M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A90183D00; Sat, 27 Dec 2025 21:12:01 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D8383C6C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 21:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3f5ec7636e2so2677430fac.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766866317; x=1767471117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5Df0rzjEUHEJctVqHB8593PNIKySTWvflrt7ulHvc0=;
 b=gO4QK71MhS+CLVkBmnvfvS10KAwoGpMr1u+2T74xxu5SfdsRDJTgcBT3Y4aoGXqgov
 za+1BTycALfwQLDGIFqak/wKv4yPwBZ2R+TxqbyfStKBIkhkgm6r/sydGngbGpyuej17
 7+U6Emz83cbBihjZyfIBZzpXdcf1DhUsaat+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766866317; x=1767471117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5Df0rzjEUHEJctVqHB8593PNIKySTWvflrt7ulHvc0=;
 b=cFuTnv/ns3KRxhi5zKY39FJ2C5XocsU3Q15G3Zsjji5FoF7Ak/3Cby9JF+OIugWyAb
 Os5bSliah06nDa7aF0d21vkacx74txisWt9NgupdJLJwKe2t6vHgu5rs3MEYWBgydWW9
 NitPRe99wKg4VGAc5BCurpXwDxVEFDgEd+KOwIa9M412F6aMOIuHzd3AKhSKkuUSI9mu
 6/eOVTdyokbliJhDnYVoy7CIuatZTndBBNaBc3SbNA0og/mhg5CQco/ZfZspNQ5rdC7M
 8lpNxda8l3vQ67SkcFlKY246FLTP/tpBOza2vOjhCOPgdPcoXUPq2vfnoFpYDsCx9wx5
 1PdQ==
X-Gm-Message-State: AOJu0Yxv3AO5qfkM6xQWeLkc2WudVfutmq0p8IOOhKhm1DkVtS8v9kln
 2+PD7JcZy9gm0VY4oOiqqUcn/lSwo1ZlUtDrzgd4IFIWb+bRSesPKpdYO7WY/Rbkk03+SrmcSok
 HGnECa5o=
X-Gm-Gg: AY/fxX5cZFPnFRI7nS6bBXLTXl8WH1Z7Wlkb+o3Or4Bx3Ylym9XPvPoNIUo151/yFhx
 CYHFAhD+kLWVL4sCmeK6vObG1s6dh8gm7eeeU8cYK5xF0pWxCcYHZWADisOflShhdO14cWto1Vh
 8EpPkPXWeSU3fIyqo2E34uYsiAql1X6p4ZmIhoO05oefQlUPd3sM7XG+4mNvEqqmljZAAXkMDr9
 uAkfKZAxz+6DOB2BKv8E3BFxvftePGLnmVSlEpVN20od0eeeYx4dGHIvZeovy0yUhtVyhAKs07C
 toQhq3yOYXr4Hh3BP5T8wJeWNmsUFRWZdcMeJOmMmr/7/PhE1ubi9A8eTRo3kHyUZ9W0qYcYcxQ
 JJV0ZoBWJHUKXXCbdr12y0nin/edjwc5fLUSmXJEAVAIgOkopTM3RCCHcvDN3euX2qHAxjN2ZW8
 DiRmpcQsljIx9JG9+k/8ifhvFqJSyiHMDMaPog9WBXnKuINvLf1diHX9P9jvU=
X-Google-Smtp-Source: AGHT+IFjZKn9jvOSSTsHJ3h0ufTkkSHmQhS0sRzK+AZyE2IBmBC3ECzuQ/h1IncJd4CTiiWHcaoHsg==
X-Received: by 2002:a05:6871:3869:b0:3e8:8e57:a7a9 with SMTP id
 586e51a60fabf-3fda592484fmr14204344fac.52.1766866317423; 
 Sat, 27 Dec 2025 12:11:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d366esm16223040fac.5.2025.12.27.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:11:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
References: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] boot: Warn users about fdt_high=~0 usage
Message-Id: <176686631601.2992512.11115325079245351427.b4-ty@konsulko.com>
Date: Sat, 27 Dec 2025 14:11:56 -0600
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

On Wed, 19 Nov 2025 18:43:53 +0100, Marek Vasut wrote:

> In case the 'fdt_high' environment variable is set to ~0, warn users
> about the dangers of the fdt_high usage. This will hopefully lead to
> removal of most of the fdt_high ~0 usage over time.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: Warn users about fdt_high=~0 usage
      commit: 9235da9446e5e896a06e1555251d11717277a893
-- 
Tom


