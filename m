Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A6E91291
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 08:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F2D8341A;
	Thu,  5 Feb 2026 09:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="B+3rJk09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0B583AA7; Thu,  5 Feb 2026 09:46:28 +0100 (CET)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0A683015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 09:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1770281182; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n1ZDFzrIflHlFYyRo0DsIzdg+sB3a+xaAvToIU3lLbjC82VFo76gnCBEHgF/5dQavVpBLvVuiaG9MOunamF6p571XqX0rwHccTqabOc9sHf7hUX42yIZY8aM+/4Vwg70l61C6wEZiq1uB6y3425u9mfi9vuyK7jBQPq+8hJgVZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770281182;
 h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=atFcDAH+3nxazbMuVIT/Bam2gpN750nO9GxW4ViDo1Q=; 
 b=eslRfNiPVxPI5JyUgnuDOL6nWhLmuQ8M+jbV0zPS2JCHpNFcsLsAc5oKRKdt/7bxKLtgFRaa4wogSWWaWmYDQoKwk27uABT3haYaYMgwanu3HF3uvZ+yAOGEZdzh0/IfBypwpgWCvZRA7QUkZHqR4Ts1vbvi3Ccxz/ghqFvAJs0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770281182; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To:Cc;
 bh=atFcDAH+3nxazbMuVIT/Bam2gpN750nO9GxW4ViDo1Q=;
 b=B+3rJk09EH7QzOGTnk8NUzNGfrvItb6EeomfOmTeZE2kbfqYllzcHP5+tuExxOmV
 9pxNnd8DIIuYOTX2Gmkavz10/FvqII+lRQWl4kvthPV35TISA2XsgPFNntZ/WQ8cZXY
 Sji2iCrh3MjLzHUs2k3G6ITNT/axmOLwDDQDb1jE=
Received: by mx.zohomail.com with SMTPS id 1770281171607658.5496684713969;
 Thu, 5 Feb 2026 00:46:11 -0800 (PST)
Date: Thu, 5 Feb 2026 08:46:00 +0000
From: Yao Zi <me@ziyao.cc>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH RESEND 14/14] treewide: Clean up DECLARE_GLOBAL_DATA_PTR
 usage
Message-ID: <aYRX6nyav7tZ5prW@pie>
References: <20260203114702.1867224-1-peng.fan@oss.nxp.com>
 <20260203114702.1867224-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203114702.1867224-2-peng.fan@oss.nxp.com>
X-ZohoMailClient: External
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

On Tue, Feb 03, 2026 at 07:47:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Remove DECLARE_GLOBAL_DATA_PTR from files where gd is not used, and
> drop the unnecessary inclusion of asm/global_data.h.
> 
> Headers should be included directly by the files that need them,
> rather than indirectly via global_data.h.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

For TH1520 changes,

Acked-by: Yao Zi <me@ziyao.cc>

Thanks for the clean up!

Regards,
Yao Zi
