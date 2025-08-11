Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17657CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 19:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D557831BB;
	Mon, 11 Aug 2025 21:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0Ai2e66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2461831C5; Mon, 11 Aug 2025 21:48:05 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E71280548
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-881a20ebf60so185328939f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754941682; x=1755546482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wqKrU9wDtOcoBZfU/zzA2ugH+NshQNe1luC7fwSZD7w=;
 b=h0Ai2e66VDIL23b4SnSxe+GiExUTY+IVYEpCnPNxBJTvjgFOuN9ycPZm7KTcSfPd1G
 k+snKqa6XOS4KrsqmHNRvWu1kf32vXhscArlXwVJOasWA+LqrFanLMCkdsGTtrTqwrO/
 9BI3qiQIQ2fofkGaPQy6/JznFPJi7Vl/DtPiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941682; x=1755546482;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqKrU9wDtOcoBZfU/zzA2ugH+NshQNe1luC7fwSZD7w=;
 b=AseuMjCUqyEws5gj9Nh95eZrtWk4oKCe7syktz7mzYp4jSxY/351CZNt/yjThl9xpc
 Z4DLc6a21LdmFogwwQP8vokQj5MfxZ+R7mf+OgpuafNIxEdZQOOEm5Gr8pJ1XkTkmPQR
 Ej30Abm8KY+G2TE5WUigyb8OhxfPZvQB5gHzsj74cDk2EVIK/HyBwv5JDaJm0cfWfoFv
 kW7cD8pSGB+TUvbtEx1M/4xxeipWReg5Hi6htKyU4G0UO47vnupPOFSLNvG67elaPmtV
 nCaPQqJtEwgAU/fiuPAvNCYo0AqAJY7UHTwAqZZMxwBbFV/d9HhLAgPlCs30T4yfn8w+
 hWuw==
X-Gm-Message-State: AOJu0YzhxHmmb9HacCovx6FltH91UZEfqTxlll0sOxwtqc4oNnspM3kA
 pjJQkZJUYwxM+pOzDA3BNH+UTA+TPVMU7vYrU4y05i/MCDHH4nEQLrjZMpBfQ4KabhfW4PPL0KB
 j5pw+OIs=
X-Gm-Gg: ASbGncs+o2ABpWOcYkjNGqz3fKVOC3xszz7nYlxDW4ExfKdntQ48Z4HALtcJ9Iszgdu
 cJmaMyDxk7eJDWh4CVHx3UtKe5IlPcc2HA2H36Bv+C2cKkD7/K+vJGGKUONbku3kHnh1VgarfpX
 ThDjo+Mt2tI4j9DvLGItPbmi1tfWdS0o40hfD6dCmpBC2MkGUdcl7bPQkc7kSaJAZiy7XX3zvmX
 Rr9LzM5fAbdjCOe3RVFLFl6Fe2wbsMxwa79rjy9L0RcY8ApkvJn1ZWVzueBkHi8VLC3FtDkHbP0
 IRuGHmX5X0U6fpRlpzuw4DFhjAxvliDpuH7vV4J9zHA8h5knyAvOBk8SfkBVHhb+jkCqXPPrrcw
 ycmjvh3ipFO7PJ30jWRDJbR2jae2Zi+EioJiGklI/BqMEboOUmag/YrSzmSvlMkpInw==
X-Google-Smtp-Source: AGHT+IF4GNN3oTOIqIIuZrnJOl53x9j2wm8dqIRCtzl6iTHT5UEXPPS+oOGKNTtH2GGoZXwIXOcvmw==
X-Received: by 2002:a05:6e02:1565:b0:3e5:4816:8bab with SMTP id
 e9e14a558f8ab-3e55ac60210mr14865485ab.7.1754941681479; 
 Mon, 11 Aug 2025 12:48:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533bd2b16sm40557855ab.11.2025.08.11.12.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:48:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250811191606.1577182-1-trini@konsulko.com>
References: <20250811191606.1577182-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: socfpga: Correct how we set BOOTFILE
Message-Id: <175494168055.1580912.15545291480235052754.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 13:48:00 -0600
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

On Mon, 11 Aug 2025 13:16:06 -0600, Tom Rini wrote:

> In order to set the BOOTFILE symbol we first need to have USE_BOOTFILE
> be set, or some of the logic might not work as expected later on when
> building. Second, defaults like this belong with the symbol itself.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: socfpga: Correct how we set BOOTFILE
      commit: 6d3382fad32baa0c09d43b526c99ea75838b3ca8
-- 
Tom


