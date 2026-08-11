Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF31C5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 19:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CCFB60882;
	Tue, 11 Aug 2026 19:28:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzidQw-1JBaU; Tue, 11 Aug 2026 19:28:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1BA2605F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786476509;
	bh=hRj1//YhyuABXjjaRLBWDI8EVO+/cDA0LYcdxstxRRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gVr6SAb8PEp7qPQjz966G0LBbulKki3zFlAdUDaPloWoGsrnzJx2YQ0UpC8IMpDuz
	 b4XfwDPyDsVX6uaguP0Ft/MjXbQ56XjD+3SRWnqKAfIznZRscx69UxclHPaRTtIhwe
	 JyKDu8RgWXBRVCeGpHIeMQZOuxqgYjFUGE34g3A9QXWo5GAQ3FwBdy0SRv5Uon8wE5
	 kkdqS41ujmwv84xSPk4935TALZHpIK44QPiqrcDxG/SgxUeUS9+9DSyYnhLJmSPiuD
	 kgPdI8ACNmsRLy+QQHcxEp1ZioIoMhfLwqZ1EtfmJQyPrW4wDScKeMi9SIRBZD5moj
	 cJJM0RiF6Migw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1BA2605F1;
	Tue, 11 Aug 2026 19:28:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A68A92E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9843E4058C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:28:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yW2qSdlwiCFM for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 19:28:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB9AA4058B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB9AA4058B
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB9AA4058B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:28:26 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so230271b3a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786476506; x=1787081306;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRj1//YhyuABXjjaRLBWDI8EVO+/cDA0LYcdxstxRRg=;
 b=GGCC38xP7rllaDtdI5FEbqkNnCsEe1KNi5npFSBqU4Yp0xbwku7YnY21++/7iKcHjq
 IQvL0vGVzUSDHSMJEq+sT+0CiMDnQ9Yv4GznOTjLRhly2HVMi+zHtZHkrdyUnFsrBuIK
 wiYsQ8lflIp2QthV4kSiH53y9Q5yoEkAY0QyVvEA9X76uXuVazBWWDMx3YXCzpPNtzTY
 7loem9VhJZZM7P6w+5YZwYFWNMSSZ+9L5fjAxc+NMyNMhCtoV0YWAPw18OvabrX/dUYq
 lhyyv2oDDGXRJrCC+otaRrO4stFklleXZnScQ4aFGHs1vAgV18JLDrhJsJ95sP2TO1cp
 X/eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAfcOSkopzOtiNbkBL6r9aB2PPfNKu/HD6Gh5bgD09DoJ2d3xNENQh0HtnlLqXCUc4s4wspRs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxsArOMnBkjwbnIrZ9hbfbjkYI2fu8h/6uw+YrFS7XXmSErOh2o
 Cu1Pa1S3Y6ZgiEXZTPhl3ZQMJkJtlMpjwzt2xopoxywyfPTu/W79QJ459ohUX437R5FFFuyUtHM
 6rY2P
X-Gm-Gg: AR+sD13hFFoR/ZRoxTR4bAKQ9JdZsygGxZfO29WBQX0+yAc40F32WBBsdN1MwKJlt5u
 uaxzVlGhJAdZG0PxW0g6zk9xD7VP1O8tMePvx5YcNyo+3npy5AthZt7GzLRT7fbO6NMlRmD7ClQ
 RuCs4UcoIdCdigpy4dgC8zYXesNGmVY0CFE7GIGx7D2Gp1Ocgo3NujRoE867kjeHNieWOCal8Lb
 NmVBczSxBQi1wsyxeW21GZTKejtB44fY4QMv8VFgEwDurlSkVS0yOScN30IxS38HDAv4GVJkkOi
 aoHKuhU1AIxfEGi0d6zBYnhPfQKMCkySKtZajonP+pm0kgD4xaQhD0yMuYEqIW/324UA8kcOCbu
 czELYybpML6kMjb5Dzg2+LmVjOmX2gR6e2lEK6ZHLwod+g8ZwBC16vt5xCRnxDqB8E6YkFWmfWW
 rukqZzEMiAzGF4B6cYRwkIFCWY8MmrRrmYoqCtUymxqoCVe3lkq5XC7Hw6L2XwVNL82/fotMz2E
 JQJqV/KnR+FywP9vuNzCwpvazHR4dAStwvs8JnlLG7dZbi2tf6qJrE8yPWfiUygweqxUXJv1qq8
 IRSMHoeJBijCSlvaW+BS
X-Received: by 2002:a05:6820:f00f:b0:69e:98c0:4bd6 with SMTP id
 006d021491bc7-6b0ac84b4fdmr1326462eaf.1.1786472647581; 
 Tue, 11 Aug 2026 11:24:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad4c19dfsm491869eaf.5.2026.08.11.11.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:24:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: pbiel7@gmail.com, u-kumar1@ti.com, bhimesh.matsa@gmail.com, 
 vjardin@free.fr, michal.simek@amd.com, u-boot@lists.u-boot-project.org
In-Reply-To: <ansPDn7F7PWS6vbV@nxa18884-linux-1.ap.freescale.net>
References: <ansPDn7F7PWS6vbV@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2026.10-rc3 for main
Message-Id: <178647264623.3076942.6673751833807098058.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 12:24:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786476506; x=1787081306;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hRj1//YhyuABXjjaRLBWDI8EVO+/cDA0LYcdxstxRRg=;
 b=nsElqy3WYu83AnSEF+75AiDZCWx403AMWmiIjbbYt2S4bqFAn+JZ+hF8TPmRifLLzT
 ulogdqHcNPkSW2zmWZxNUhFZ7zP1ovVUfVbZKddolS48f0Fy5+2g3AQGpkaaLaPEvvbZ
 hgM6wo+OLHGJf3ZjwwGvr07t6xdI22HY59bbs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nsElqy3W
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 11 Aug 2026 20:01:18 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.10-rc3 for main
> 
> ---------------------------------------------------------
> - Add support for vendor protocol IDs 0x81 for SCMI
> - Fix LDO selector boundaries and make the driver fail gracefully when the
> - regulators DT node is absent for TPS65219 PMIC/Regulator:
> - Fix a hotplug issue with pci_iommu_extra on Layerscape platforms for
>   PCIe Layerscape.
> - Fix a GIC LPI table corruption on LS1028A boards with 2 GiB of RAM caused
>   by an unbounded TF-A DRAM bank loop and an integer underflow when
>   gd->arch.resv_ram is inadvertently left at zero due to empty DRAM banks.
> - Also includes a minor DT cosmetic cleanup.
> ---------------------------------------------------------
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


