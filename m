Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7116AC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8102809A5;
	Fri, 28 Feb 2025 11:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K+23d47g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0474880BA4; Fri, 28 Feb 2025 11:35:19 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1004807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-520847ad493so1799754e0c.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740738863; x=1741343663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mmyaj/VU1GW/UUW0IdfgA4MRIfnMGIJEbKX3geni1p4=;
 b=K+23d47geoTlkU35pLdJwyozqV6BxsbhEoPs3P+mD10TZUWB+7afe+ZPJs62g3ZI38
 qjaCyRdUME6UwGJs36SbDmkxhcM8gA4QbEGFLl/qRA2eflonsqRpTH6n6lrfHwJOh3EL
 LUNHDMOgrYcRGKVtv1z7o48pr6M/YieDP/jW+Z98eefPPaozGDnsRInkESpNFLrimmd5
 fK+X9tWBC4vEEwzNSikYbZXZJWJ6A/dATPPUyPbzKKXaAgqbzsr8Zbm/j64E0gAK6fi+
 ClKxcljpBNVXLPcsvxqDPO7FPpI1F/ykHEvlOQmmxRKRmo32gpv9kOSTVZKiwhlZ+sY7
 ziaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738863; x=1741343663;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mmyaj/VU1GW/UUW0IdfgA4MRIfnMGIJEbKX3geni1p4=;
 b=J+HYXwiN4q6sy7FMeCWQj1O6VomnD23CIiYO552+Bg3yP+g2pOFV/B2pvugxsIpHz1
 /RGZrzWxr90gpJXLmKtoKAZ3OEmO/D4KVqPpyOQ7rQ83d3lzQIt3O5kVdQhG3YVMfMzV
 vpJ4f3/us6udnR8I3oxc3/tvlJzy6qEK+ZMpC9cyRZYgE6t8p7J2MMmw7xa4ue1q/enZ
 oEeAR9FzQXPKgypm6q7DC0I9LsWQQhSs7Ab1e4+wweOWH171YV+NG3iLKDOqY+lWGDp8
 blEi5ygd/5q0edZBcAdYUa8gLclXY/OCW61tbkTxG6++uMvfcCJW+X6m60esoBRdzMn3
 7Ilg==
X-Gm-Message-State: AOJu0YwaraY0tAdRLwtYab+TQ2pCwVFsMTTL54cUMbFGA9Rd35bTmxmO
 6jt+uIbvfSGElB8VWZMmn/EOZwIsuOQ66JI3XvUHaZJTd1aKnspHxFPTIAQSUBX7rCoASdVxz9I
 l5y5+V2agaFdDcOgigPBIJUxQmeopVERUQYcGJA==
X-Gm-Gg: ASbGncsxRuNnuz7M+mtOf/zcNS08q/aI6hgbYqAMJur/a24vqXCS9FhGgO91ZOdGx7+
 GgAVV3wPff3sdNc5+ZA7KNUaoPDUIBIDrf4UrvC+VnKli/jbvOxDG6ams6Lai1pY73j+kVqX+GN
 L24h7fz9te
X-Google-Smtp-Source: AGHT+IG9a7fpWeucvzgVcc/qnYVskv+w2gl/RrN/gMZhLoipX9RcV6gp0S03x7lx08UjrZ9z2HwcMhihvQ5hJMRB8FA=
X-Received: by 2002:a05:6102:4b8b:b0:4ba:99b5:60f5 with SMTP id
 ada2fe7eead31-4c044ef7176mr2108430137.23.1740738863444; Fri, 28 Feb 2025
 02:34:23 -0800 (PST)
MIME-Version: 1.0
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 28 Feb 2025 16:04:12 +0530
X-Gm-Features: AQ5f1JrnUX-FUkaxth48q_-oML74KowY-Nx-1ytjH12HJl7Q7CkXU2UyAUQ3S4s
Message-ID: <CADg8p97dZNnizzt7Z-3_=_1bgJV0mJAd+HmK+BFmZ7rhmdx+uQ@mail.gmail.com>
Subject: Re-installation of device-tree as EFI configuration table
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

hi,
The logic in efi_install_fdt() is such that with the
EFI_FDT_USE_INTERNAL passed as a parameter to the function, the EFI
configuration table is first checked to see if a device-tree(DT) has
already been installed as the configuration table, and in case a table
is found, the function returns without any other changes. However,
there might be scenarios where the earlier installed configuration
table might not be up-to-date, and in need of modification. One such
scenario is that of adding a pmem node to the DT that is to be passed
on to the OS. There could thus be a scenario where a DT that is
installed as a configuration table does not have the pmem node, or it
might have the wrong/stale values for the pmem node. Should there be
some logic to indicate that the configuration table needs to be
re-installed afresh so that these scenarios can be handled. Thoughts?

-sughosh
