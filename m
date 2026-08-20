Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D7C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C081D80DA5;
	Thu, 20 Aug 2026 15:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMpyJiBNyrq8; Thu, 20 Aug 2026 15:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238154;
	bh=Inbj9kEamNRcxYiMncX3TBsMznH2MwwlMFLRC+8JTOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zVneLOoyP/jAtUngP2hsBgBNWWbj5tUu+4a7OhRd3t/r8/8ZaBqpWMlId+595ZLgL
	 kei3wNqVabMc9FeFvbxUv1LEsgjKymetC/YrEL792LxG8czy3LMLSI/2/ZbvS0MTr5
	 cBjBWRgQSVU6SWIAw2Mntx0+u9w/nELH68FaVPvWjqC/FyxNjGgzPKhpoVtJqND+6P
	 zrAGx31M9JYqmc1wn6liY71Es7nTr08zGEeHYHYbwatUtCBAGcncnyeLHL1MpOOY3w
	 jsrFWrNcSZYYlNEby9fKZMevt2rb0DK7GhvYQov4QyVtsR5t8t+G0AObzqUR7OOjMG
	 cIeu+NbFnn6Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5228880C41;
	Thu, 20 Aug 2026 15:02:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCBF940B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BADA840329
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pXFFZIJIwEsq for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:02:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=zKM9DGJP
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2BC54031A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:02:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 74DD81A1767;
 Thu, 20 Aug 2026 15:02:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 47227602B8;
 Thu, 20 Aug 2026 15:02:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CE1111C7645F; 
 Thu, 20 Aug 2026 17:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787238146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Inbj9kEamNRcxYiMncX3TBsMznH2MwwlMFLRC+8JTOk=;
 b=zKM9DGJPwYZFdw+kkT4VcCrPbedpfN4f98GLA+OPutlCeEfB+IHVtQi9XBzvjmVC4QwGQ7
 U3GMbV1m5ahIjHvRquH5tHGmKUG3wrZH+K1VVE/nq7XOuHXJqT+YFFXTtrSv9cQ1GVSX0T
 FwQe6qGrosZqKBp3mLBxsF1PvJAg7RKW76DrFPVRgPvcNmxeg39FiRytiqlLZdu5Qlbhke
 kKVxisU/KSwEopIB0wrC+fcH5tFfA2940IFDeORAQilakN1sKq4He0S4mN3sHf68f/e06L
 3mvH73kk5JP6yR7p6wleTO+nLJEFhjhYyV6JXhG2U/YAKR9zyN1ytyfsI8lDJQ==
Message-ID: <9d9ed55c-1196-4471-9bf3-688d321ff2a1@bootlin.com>
Date: Thu, 20 Aug 2026 17:02:21 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/1] tools: build mkeficapsule for
 CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 8/20/26 09:26, Heinrich Schuchardt wrote:
> Currently we build mkeficapsule by default even if we don't have EFI
> capsule support enabled. This adds a host GnuTLS build dependency.
> 
> Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y.
> 
> tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=y.
> Hence distro packages like Debian's u-boot-tools will still contain
> mkeficapsule.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

