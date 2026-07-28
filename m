Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34070C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F03E660A4E;
	Tue, 28 Jul 2026 21:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Tu6Ni2VlTHz; Tue, 28 Jul 2026 21:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51F6560A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275830;
	bh=pD1RvWHVGuWwRs+DaKSecUSHQeZouCu0mHmWfy+iuvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ow45BAyAOdvEKJtBS/PFRUlZRKMHtkdRKWSLN2jCLEMpaJVOZU69ns47yMKCh3JeJ
	 z5jJWT8lupAyXVtf2XgG4Bx9uO8gsn5og6tJfCmYQS26m6GOvundV4ddaXSlbvaLDm
	 CY4FYUOxkZ/92l7/uj12ZDyaqaRTH7FVf/Igq7Wm5t2LqZAH38lrdmCuCHW6C9gWm9
	 kwLiWbP7pHdoOLiY17MWCqH1inMrILkwpTw5UnmttRgSysAZ6fXm8kgu1mahuIzDr1
	 QI7RtpAt/xnxujnrpYz9u6ecuHCo+tx9O3a2WMC3AyNRd/dczoINEmgsjKqhDUCiaG
	 GFzarlcUnq32g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51F6560A7B;
	Tue, 28 Jul 2026 21:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 683642E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 568C98146D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHEbhOy7GHxW for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C76C8144E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C76C8144E
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C76C8144E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so224615a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275810; x=1785880610;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pD1RvWHVGuWwRs+DaKSecUSHQeZouCu0mHmWfy+iuvw=;
 b=HavtRTrh/626pDIOB2Da2A+vTkJsxBf/c+l4St661r+c00CIS7elNbyA4ALhOm1NsO
 0at+Nun8es0bZAAZsCDlgt1Cxebc/oddHza5ULiL0PZfCpN/WBpHBxhuDPlZXyd4+1aa
 QcWiWvuGvybBoJNdUPsEAdNiCrdSx565DwEw6OmBO+PZyMTgfe+yK0jM7O6KxBIwRlLE
 cUZ7BnSgPPGnlGe/BIK2jCz7tKEobmRUD90xCcHtqmG3uva2mJKQYX/mz28WQx4O+BJb
 mwb9hG+fIdS6t/v19QDybOH5a9TAbyx5ygl7Ocg5zJOblkqTdXlovpzaTZPrwIiApkGD
 7Mvg==
X-Gm-Message-State: AOJu0YzIlDHKdQ8cVvbZJBRWLiFVeFFaoP9Y4FHLHGoAYvLZZKAEtK/R
 Ffz/sxaXYWX4+ZYHb2YCe1vzv0zb+8dt9vCfSAZhLgoMMO8qtsfKlHdZhuc0NBcfLyE=
X-Gm-Gg: AR+sD10VlGWPXZm6OEv++R4yLxdXZdYudLV9M/ZQ/VThanaadb8y7ka2lCyFryuqEu+
 TL9xxRgEQq0VAHA7g6m/r2zF0gQCkjj7Nl8n+aEpFl44xUnQxXNrfHc/9AAsyz2yBNMPhmz0JWl
 PcxnLUhUCdjDMEKTXGyNeXVHVIXinAoqs5dUXm7oRUfeCvz/WUk/36eFAdib1bGlnfl3oAPfgtc
 RISXNUt/j1rOLPH5k2iM7TyfutklXNl2dfaqyhpr5XcyX0ePNmQmnpENIHnhGSQ6c7Tuk6xqCV3
 2szqlA61NFtZaLb2nYWcwqxA2aYQl6mmiiVAitxBg7Ps6BsLlJLyFiuZfNZJmttCN0Fzfx1uX5y
 Ux3tb4cS1G/IklZ9P/ApiSj0pQjguNtWVOuTDhEnkwe5Caut/e+SwzA8aAV64wTa8xHvuWAKyQF
 FluWtdeL2SIA1MaopTBUsSt94HLAAePQtNtXUt/87A1INLAokkws2xINzDFXr4bz8Go906IojkX
 X6M1Q41vSN2G8mX6caR1KJwbYU9t8WL5aV6zgkIqOV36QEec7fFN6lkvH2FjuCOI1QGzccqT59E
 CI9E2vFu
X-Received: by 2002:a05:6830:498f:b0:7dc:c749:ade3 with SMTP id
 46e09a7af769-7efff07ba9dmr2528020a34.3.1785275810063; 
 Tue, 28 Jul 2026 14:56:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Bin Liu <b-liu@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20260716143751.1680929-1-b-liu@ti.com>
References: <20260716143751.1680929-1-b-liu@ti.com>
Subject: Re: [PATCH] Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC
Message-Id: <178527580941.1742553.2834298508093051510.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275810; x=1785880610;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pD1RvWHVGuWwRs+DaKSecUSHQeZouCu0mHmWfy+iuvw=;
 b=jB6gb+ndrU290nlAFxUEktVw5RoqiXPLtHMo/c/qkqZMDKWBPt++2Lt5iqlkXog0D8
 kGYCbWQekBqjzRR9JgfEWvCRrXMEOyzSOsmkdmdx0yimvfzKmx4foFDJgdPqCFIK2yjt
 MNtsatelALcBHakcSRvaZdz7VBvB10/nOddYM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jB6gb+nd
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

On Thu, 16 Jul 2026 09:37:51 -0500, Bin Liu wrote:

> Commit f43f71012254 ("ram: k3-ddrss: Add support for a partial inline
> ECC region") uses ofnode_get_addr_size() to read memory address and
> size from devicetree using type fdt_addr_t and fdt_size_t.  However
> these data types are 32bit if CONFIG_FDT_64BIT is not defined on ARMv7
> build.
> 
> So enable CONFIG_FDT_64BIT to retrieve correct 64bit memory address and
> size from devicetree.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC
      commit: 1ca41edced1a7213a9d737c1ced772b91181e9ad
-- 
Tom


