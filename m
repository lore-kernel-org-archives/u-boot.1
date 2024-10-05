Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A45CFB421
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F0D88D36;
	Sat,  5 Oct 2024 18:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728147093;
	bh=1CfsrESq0i+GZTzXxZ4aOU1Ctfniw5YiRIeDvCkKcIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAeIa/bRuZSJceK/E638H6wHPrfUqYFj+ipI/VsRTtFTys4ujBcVFIor1gQ++98+o
	 9NMw6JQFRnbI3IEURJzDHeDISVikpl3m0lZGRODFfx1LI7XkfKJDhDNGNnd5yniwin
	 yrAJPqd2TEUDuIYQ/UBmAaB7ABN10j/mnif3qawT1x53+uGsz/RdzDHTNKUbkuO5YA
	 DPBHXfwszBBUI+fS+bISxsHKZN77K/9ZTr7QA3ybMpJZsmPdh60Kv7VfDU4hm8FuCn
	 gvBqDMg05m1NS9EBG1A52gGFPWZGHJr+36SZY+eMaE4QmtlbVHEALPClsRd0VYohGL
	 WdAM701GL8EbQ==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A17488CC1;
 Sat,  5 Oct 2024 18:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728147092;
 bh=1CfsrESq0i+GZTzXxZ4aOU1Ctfniw5YiRIeDvCkKcIY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=zO6smVvuwlzVy1uVlkOQAFAfqu2EQKSCwMTUmn17wrHbZj7RuL/hMzCX4mpq6v1JU
 OGa8g2r1pRjx6MZwatYpPCpht4GIsp6snXZwfDl47IndfzrsiOhGv1jhyuwKZDzEJe
 JE4pbt9UvQ+R/cNAiKzcnCShogvGUKkYPZyYt4RJ1YPrH1R8YQ5ld1JS3nbPnuHjrI
 voXmV9hcwi+hWQ1z3LJljMnydrmyzwySmkNaVBo0VNLGEq3aK0vLFC+4Rcd35rFcg5
 RMF3mJ2RsWhU1v1B2KmntO+NmY7BRe16+Gs9tbmk20r2YNMMUtgg/KJWgRkCEpvaxN
 h4P7LcJLZI7ag==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 05 Oct 2024 13:51:32 -0300
From: Fabio Estevam <festevam@denx.de>
To: Stefan Roese <sr@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, jh80.chung@samsung.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] da9063: Add watchdog support
In-Reply-To: <fa3f9053-0f40-402d-bf59-18398a9318f6@denx.de>
References: <20240917135550.3164425-1-festevam@gmail.com>
 <3ec25b5a-2c9b-46fe-a9b9-0b99f72d83a9@denx.de>
 <5293f5a0d44059960aa2d5e8b114456f@denx.de>
 <fa3f9053-0f40-402d-bf59-18398a9318f6@denx.de>
Message-ID: <a0e0fd38e4596321d4c227c356f8c6b5@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

Hi Stefan,

On 04/10/2024 09:43, Stefan Roese wrote:

> Sure, please pull it in if this makes sense for you.

Applied to u-boot-imx/next, thanks.
