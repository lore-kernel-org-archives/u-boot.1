Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B44D5CCB2
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 14:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A502488F27;
	Wed, 30 Oct 2024 15:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LajDvGSd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AaP2wKHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C6288F95; Wed, 30 Oct 2024 15:24:15 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B3988EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XdqBP0Lh8z9sp5;
 Wed, 30 Oct 2024 15:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730298253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FmEDscBHGz3RWJNG8p3yF7c4SVNfyGuGB9GfZ131QI=;
 b=LajDvGSdzeBBIeSUDSedDXx6xBCWTXIDlP2C4BxJaB64Qi0Tl+BM9ZPJyKi9qJkrhqaJDC
 7q4CtEkdYAbk2I3CL8ZK35EANTR1Qk/fwjSHLaRWxqtPA7TuDwJiqZ5WUuG9/g67ookGhE
 ZfSAu7btgHcMuJbKCzhKOclsQgBsdAAA9ubfERTTJNvFdW9rf23XJkZaw9daMSauaoVd35
 jfMhAwULeBdNASzvgCyHhvESckRIylmRgf+JcHBAgJMG6G3fQKLS8s0NysVWRSWcRQ5+mc
 GU7PjZB8MEb0M7PM2Yccr6q2RSKZOYG6m3BAYIj6oyiDTNJxqdhYfn6K3cfAAw==
Message-ID: <ac1f22fa-e744-4616-aeb3-ca56860e89cb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730298251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FmEDscBHGz3RWJNG8p3yF7c4SVNfyGuGB9GfZ131QI=;
 b=AaP2wKHKCk27kOWnZsVTZBbexWtYPQopyerQunT8hjUMTREilDFtLVQK7mia/Hvl/r+mp7
 2Uc8I/eWl46hhzhU5rLlC7daj+wSReE/xBVa0Vcb4jcOCPUHukX1ugzpJHoGezznLJQaIx
 MUMpY7MZsmD2d43tPJctXRtqukH1AmTGY3i7apXmEJ6RyaGryCeg2amhspMKZ8sJFtJOIl
 Dl0k991wxYFjoYg/ZYjHequNn/gjgv6+wmNb6k+wmGtGOg1qgnCAusp0HrfozT+of1XG1S
 NBNdTVxv8Y/LJXApXcr4w+TWr//JYSWU0YBYRUPD3BzPOA0fRiGAfP4TxDLzEQ==
Date: Wed, 30 Oct 2024 15:22:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: rzg2l: Update MAINTAINERS file to match
 dts/upstream paths
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20241030103543.465-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241030103543.465-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ed61a001247c263700f
X-MBO-RS-META: 8e86rigk5u7wzbn39z9omjj7yhm3d433
X-Rspamd-Queue-Id: 4XdqBP0Lh8z9sp5
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

On 10/30/24 11:35 AM, Paul Barker wrote:
> We are now using the dts/upstream subtree for the RZ/G2L SoC family, so
> update the board MAINTAINERS file to match rz-smarc dtsi files in this
> subtree.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
