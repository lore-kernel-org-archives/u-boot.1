Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1AEF436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92668429E;
	Fri, 17 Apr 2026 17:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l7KU3LPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F42684307; Fri, 17 Apr 2026 17:52:34 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9496C842C7
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so368247fac.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441150; x=1777045950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERjflVoKoOR1/wZgfiz+ORe+GefM4wXbI1sT0QjSGJM=;
 b=l7KU3LPo8kZO/PmutfiB7vEHrVHd9iy9xVAvJy9VE48DKnuSEAYl9bHX53OKlDdjmj
 SoE1J0ERtIQYskZtLYZ591iwKxBileAYawgwRLKGOI7DoIYsYTp3SPgPJiQ4vMKdbxFd
 IJKxcfqUMD2bKbzH9ZUpwotpqqQo8AzQ08MmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441150; x=1777045950;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERjflVoKoOR1/wZgfiz+ORe+GefM4wXbI1sT0QjSGJM=;
 b=cayog4kJ0fAd0XkNm8CfGxJoZrA9Az44dlKza220CTgN8WH/1ZPWwixWLBNXScrYnu
 9yDppSdeg8Z/i1SC50DZalLhVoIr8aOudscrbYgs58wQoYq54zCnNOkWnEvhb1MfgFig
 J1lPDFCFTxjufANcRlAmph9EB2Skt9Q66zP04QmCj0W4dUsTFuKHIL0xKK6JplZNGiCZ
 20t7R0lrfVdFvGaIAzI6Cvm+UTbqDl2yP09W0V6wb+6QlxMtI0q2eXZ9m3bli0kexkBr
 6/F0aeqWvj3XABGRH02wXbDIF4e3S/eYH4h3mz31g7rtBSZ35P3IPZFL39VUETOyWj9n
 rPyw==
X-Gm-Message-State: AOJu0YwJ46slgQa1cLswtKtUsKH36knqnbM8ozF6FesYbDUo4vqkFOJK
 iHtiO+ddlIew9aVlca/lUx5Rahczn7WDTNkNjMD7BQV1QDxCKZ0qkh4ykYv9yG/XnLY=
X-Gm-Gg: AeBDiet1/+msJtZtK+UWKgiUN1QWZvg7+Z8VFcjbEWPo8AJFSz9SSIdmS8zxrJoCU39
 TzjexhF80/OvMgkexSCnkwgACL0fR2EGbFoS2t4jj+Cny8IgOt3CV1quV0vkfgCkOfrhQWs0apl
 FwJTDLZY5mg5gEaAe9o4kLS9ZEVuYQ7fsOrnMUwLbdebpupUh+ojwVrnwaIY57Fq9izWlcWANaM
 RPiVx6m4ajnS0mLIHq6FtNtH8wwExxZfu/zbBSJxrxoQP11BnmlUqzCPSqcdVSoXBkpT10lGbXp
 FrWEPUboIfb8YDXo2JXaTfRAUEJovxPNkWryLv5YF75MlDiovsrVoUQBoeUM5sRbsMb/cS9UHkd
 CGk6liYDk3skVA6y1a8uXNBOYH0Fb8ZkeTOocclOz2zZDNPqQeOo3n1yNHkbdQLFBo2Guex+RVA
 S2wKJADkV4/Jmka4ycuLvVIQR+plNqhpdE+VHOMWyeVcG/YZ+tw+k6XyBa8DXYgFt3quTiFzjPW
 294AYfvqGPkc+hZgVyU9KNnwsOqbpW3K2b+g9GJnYI2Gzk4UGyXuWmyWbqH
X-Received: by 2002:a05:6870:56a7:b0:417:3307:e1cb with SMTP id
 586e51a60fabf-42aded0ed85mr1936434fac.21.1776441150271; 
 Fri, 17 Apr 2026 08:52:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jeffrey Yu <jeyu@issi.com>
Cc: "Mutya, Havish" <havish.mutya@amd.com>, 
 Ron Kalakuntla <rkalakun@issi.com>, Ji-Ho Kim <jhkim@issi.com>, 
 Johnny Chien <jchien@issi.com>, Anand Bagchi <abagchi@issi.com>
In-Reply-To: <PH7PR19MB7361D02E5CEC8F26BF50ECECB677A@PH7PR19MB7361.namprd19.prod.outlook.com>
References: <PH7PR19MB7361D02E5CEC8F26BF50ECECB677A@PH7PR19MB7361.namprd19.prod.outlook.com>
Subject: Re: [PATCH] mtd: spi-nor: ids: add ISSI IS25LP*J/*MJ/*E and
 IS25WP*J/*MJ device IDs
Message-Id: <177644114918.690930.15847059112023279825.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:29 -0600
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

On Mon, 23 Feb 2026 20:59:24 +0000, Jeffrey Yu wrote:

> Add JEDEC ID table entries for additional ISSI SPI-NOR devices.
> 
> These parts previously not yet supported.
> With these entries, U-Boot can match the device by JEDEC ID
> and use the existing ISSI SPI-NOR device handling.
> 
> Newly added devices include:
>   - IS25LP512MJ  (JEDEC 0x9d6020)
>     https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf
>   - IS25WP512MJ  (JEDEC 0x9d7020)
>     https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf
>   - IS25LP010E   (JEDEC 0x9d4011)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP020E   (JEDEC 0x9d4012)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP040E   (JEDEC 0x9d4013)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP01GJ   (JEDEC 0x9d6021)
>     https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf
>   - IS25LP02GG   (JEDEC 0x9d6022)
>     https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>   - IS25LP02GJ   (JEDEC 0x9d6022)
>     https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf
>   - IS25WP01GG   (JEDEC 0x9d7021)
>     https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
>   - IS25WP01GJ   (JEDEC 0x9d7021)
>     https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf
>   - IS25WJ128F   (JEDEC 0x9d7118)
>     https://www.issi.com/WW/pdf/25WJ128F.pdf
>   - IS25WP02GG   (JEDEC 0x9d7022)
>     https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>   - IS25WP02GJ   (JEDEC 0x9d7022)
>     https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: ids: add ISSI IS25LP*J/*MJ/*E and IS25WP*J/*MJ device IDs
      commit: 3d623b9d39c167ba58fe2e04650a9ddfc4d8c55e
-- 
Tom


