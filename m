Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D586C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CE186432;
	Wed, 23 Aug 2023 22:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c4YB3mx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E41A8645D; Wed, 23 Aug 2023 22:55:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BEA58620C
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5992061321;
 Wed, 23 Aug 2023 20:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A399C433C8;
 Wed, 23 Aug 2023 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692824109;
 bh=dTfs08wC0hNkMR56iCEDc37HqLUCFPpc3uviwkwe28M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c4YB3mx0wmEYhEErPwWRnAtCzqgTSpSiDjk5Ytcih/D3WLZOwUWpFZtXWZ0I8EBuG
 0AEtBGzpq2/dCWfpvr8i7Gu8WYjlFnMRxEtW9/+0GJrRZoGfubg22s58MC2eaVPq3N
 VwTRvrFindOF/fKweMX3EPzaePLd+xrYTSjM5EVHUdwxW9vzkixh2x0BsRrcSrtQ4X
 GcERxs+31H2/uk8/sRf/WWOAfYficxPd9BxkL1EZEy+1Kc76cWq/2TlHerMm8NLARS
 adPhf46bxR2TwXlmFDQs3p7IfGuChBEVRO3w1VRgUEKKz+exIOGisiohUKi/BUzeuP
 2iOPAt5ne++gA==
Received: by pali.im (Postfix)
 id A13DD7F5; Wed, 23 Aug 2023 22:55:06 +0200 (CEST)
Date: Wed, 23 Aug 2023 22:55:06 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230823205506.oboh4hxdxdi4oalj@pali>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
 <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
 <20230823203526.domqjv74ttdwfo73@pali>
 <bbdab138-2499-ad95-d4a8-dfada7e72651@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbdab138-2499-ad95-d4a8-dfada7e72651@denx.de>
User-Agent: NeoMutt/20180716
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

On Wednesday 23 August 2023 22:46:13 Marek Vasut wrote:
> On 8/23/23 22:35, Pali Rohár wrote:
> > On Wednesday 23 August 2023 22:32:18 Heinrich Schuchardt wrote:
> > > Looking at the MAINTAINER file it seems that POWERPC should be set to
> > > orphaned.
> > 
> > And this is only just because of your fault folks here, as you have been
> > completely ignoring any my patches for improving this situation here and
> > finally after more than year of my reminders more of you wrote me
> > officially that would ignore any changes from me.
> > So go and complain to somebody else, not me.
> 
> Why not pick up the PPC maintainership yourself ? You are qualified enough I
> think.

I'm not sure if you cannot read or understand above written text, but I
will repeat it once again and the last time specially for you: I'm not
going to send any changes, improvements or fixes to any people anymore
who either implicitly or explicitly wrote that will ignore me or my
contributions.

> There is a whole thread on frustration about getting patches reviewed and
> upstream here too:
> 
> https://lore.kernel.org/all/20230816180808.GB2919664@perftesting/
