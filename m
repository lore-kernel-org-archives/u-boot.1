Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9782FC61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 803BB40A1F;
	Fri, 28 Aug 2026 20:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPl45OwzJfeC; Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787948956;
	bh=DNfMPrj3SfthuYcXxpfn3e8hkn4gv4u0DVqWneweCw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mqp+iotCWwoK1F9KCitOFvR3mH1Tgq5vX7KhnoB/DRAvrXH8G/UNMEiFOLFU8ewX0
	 9ORY+hycozDpUVcCw9svwT7haX6hhMe/TDCfAic29zBpN0o7UgVued7j9bz/aactee
	 DB63oitOGEJV4hyUGJG6D3vP+kpK0G3VSEgg7uiF671uNgMjCa0vjq76rChkKebFF+
	 jzmVzMuEA9r/7yUrcxZrpZ0D2472eR36IzUCXd5s9vEj1FskHzQXHsHBJmup2kZG4E
	 vIT5xpbmv/Lad9gFIT7m+9tOHsi/lD34c6X41qOU0e0y3fnpqGyQPf4rkNsIwFW4yO
	 DdNPNmsr8QM9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E36E4085C;
	Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E34D7355
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5819606E3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pb3y3eIbnrnA for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 20:29:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bf8YSW1b
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DBEA606B6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:13 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4b190cdc9feso1419403b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787948952; x=1788553752;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DNfMPrj3SfthuYcXxpfn3e8hkn4gv4u0DVqWneweCw0=;
 b=Bf8YSW1bsUFYmsm77eEwBNunIm7dxKu8va3kCbNJHzqoKhaz6sOoKR0q4BTqNbiYCT
 pqAgKSULT8fxAnBIsdp/QkLSr3GjGbz5JBrf0HOVojOxqyxrUotVE9P3h8kM5iWTRjAP
 Ac3ww6FzFhMB7PYPcEFIvBC+lnkEtMamXJQSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787948952; x=1788553752;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNfMPrj3SfthuYcXxpfn3e8hkn4gv4u0DVqWneweCw0=;
 b=hsDX40EZOyW/ztS99JEFd52xKC9p3rhyZJm4rLVAUPiusGXecSWdKjV+sRJubF06Qv
 D6gUO01BEvzuDpZ+EY1qRdsjbXx9W2mwo7Y0j5VWQsNNklFO18lg490jvcpq2EgzdROy
 7qj/ovbfdjJYynnQgH3tOPQ+QMEfcDqgGcPfkmJtm0WEY0+OiHZROmRTvJeR/F6tJELG
 XIr8f3KMHEEym18z8ananz1RXagfRRfVzKV7nAGGWUhjlHVKaR0PvGX5YBP/ymOcC802
 Wu5Pj+pnTkGMoEYrhA7paHR9FnzeiD1bcYxvqgJyShu5xJ6T+zLb1+yjTt9NYSCCfpL5
 5mDA==
X-Gm-Message-State: AFuF++mI6zs3jaOV4U1E/JE9U1cej1tJtUHSuqgaOzp+MlbTyouRzA0Y
 cnXSzwt3tW+Y5wekFIBlOT6ZiDOWQG+/xRxyE04TYNbjGKtpiLykUNGDIrJym/DYCwY=
X-Gm-Gg: AR+sD101ZGuT5W0Wfa2CwDLnHJxsjaWwZbKPNoOj2aJEzSquw9Vn9ei44H+hXLsphSr
 bsDIQM+iYM8nzpjguXvOO/OESvhCvwx3R2bSBmnpSRqhN3cfw4TXn4lle7xB0X2L7bR3UX+iH1q
 LM58YnBbncH/ZY0LCLHhX9jXhIbJHMeWS0BzWqU4kRqxPGGlIz3cN2H6UrF8l6bqCN7VrQpnwdl
 J6ylKAXrtSfZnWHAVUpw1TyoLRQX+XzLsjKeEF2aL+IZkIgf6ZG/eThaZm/7aQgZoM/3Eq0DwHB
 LfoMLGIXz/wExCzk/bQ4JUBsoM8n4FRm2VPCB+Sa+/9lkvbKwZi0ECvGcfuISswdsPt/cLugHkV
 RzzANXvOhL567+AllSdO/fBb4ZlxXSSRoJ7/5qRk6WfyFX1ESO3BYgqYmYUQlI1reF4wU21vbas
 K0v3EeEaabrXbNw2QUUHDmLDIcKIjfWXg69BH83dVdNCfjmDNgZ1PwFLJ1cb3j9lFl+sJqBsBmm
 7NlOYecCdljQkC0M4MxjgDNarLeR3XbI4iSgzsNpDUvUDKu2sDKmwvd9nEK/+UUB/P0peTFDebj
 p3xxSXoyu+Ot7Qi7ILM=
X-Received: by 2002:a05:6808:3305:b0:495:c607:b13d with SMTP id
 5614622812f47-4b397faca9bmr10889389b6e.2.1787948952440; 
 Fri, 28 Aug 2026 13:29:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995b83sm2100578b6e.12.2026.08.28.13.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:29:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Piyush Paliwal <piyushthepal@gmail.com>
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 eric.kilmer@trailofbits.com
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
References: <20260612075424.83462-1-piyushthepal@gmail.com>
Subject: Re: [PATCH 0/2] fs/squashfs: fix two out-of-bounds reads on
 crafted images
Message-Id: <178794895103.264202.5615249819494155816.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 14:29:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 12 Jun 2026 13:24:22 +0530, Piyush Paliwal wrote:

> Two independent out-of-bounds reads in the SquashFS driver, both reachable
> by pointing U-Boot at an attacker-supplied image (e.g. ls/load on a crafted
> USB/SD/netboot rootfs). Either one crashes the bootloader (DoS); patch 2 can
> also copy adjacent heap memory into the loaded file (information disclosure).
> 
>   1/2 sqfs_find_inode()/sqfs_inode_size() walk the decompressed inode table
>       using on-disk sizes with no check that the cursor stays inside the
>       buffer -> wild read / SEGV, e.g. from a simple "ls".
>   2/2 sqfs_read_nest() uses the on-disk fragment offset as an unbounded
>       source index into the fragment block -> out-of-bounds heap read when
>       loading a fragment-backed file.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] fs/squashfs: bound the inode table walk in sqfs_find_inode()
      commit: 73ada2f433a99fb2f443bb76268f5ab023b11868
[2/2] fs/squashfs: bound fragment offset/size in sqfs_read_nest()
      commit: 923f05ed3e231c51f259bee6e2ac823bdaf1c566
-- 
Tom


