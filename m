Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F1CDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6348E86EF3;
	Sat, 14 Oct 2023 03:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHD6e0Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6CC86F40; Sat, 14 Oct 2023 00:07:52 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D4B86F62
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=maz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 720DACE3298;
 Fri, 13 Oct 2023 22:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB42CC433C8;
 Fri, 13 Oct 2023 22:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697234653;
 bh=9+QMDwVGbGuovGj/Xd0/vzCQ8WsYpT+1dSJKf03l14I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cHD6e0EqxYtSxfoCr+LrpJLxH28vCikAnWNO1XcFyaxiK80RvYGJ0St+FqjN+tuU8
 nh7jv0DZhVTJwp8DtQlMFLth3TYJezM+T/Y7JVoKWVMF7zl4pOeK+eI9bqgPpAS8DT
 +5g+raDxc7toPX8+4Dn6J2u6zmECXtTbzeVNcEUeGHb/xg8e4QX/sK4fr+ttjLiCoo
 UsQRQFJdK+C2z/BX9r/N49ChaHou7ho4pFEbjjcqhfVdT+HmNV9TH/CDWLuUfpYiR5
 DYtbMnmQ0Duzrg9Muqbw5dD4JTj/okxTUjbUz+S4R+m81Z7gia5KwJcQaCshFtJRvM
 syJbDlRbNnEAw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1qrQGR-0040h7-7V;
 Fri, 13 Oct 2023 23:04:11 +0100
MIME-Version: 1.0
Date: Fri, 13 Oct 2023 23:04:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Chris Packham <judge.packham@gmail.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] arm64: Use FEAT_HAFDBS to track dirty pages when
 available
In-Reply-To: <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
References: <20230317162253.1049446-1-paul.liu@linaro.org>
 <20230317162253.1049446-2-paul.liu@linaro.org>
 <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.14
Message-ID: <fac6ef1747ec318787f90a6d0c81163b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: judge.packham@gmail.com, paul.liu@linaro.org,
 u-boot@lists.denx.de, trini@konsulko.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

On 2023-10-13 03:40, Chris Packham wrote:
> Hi Marc, Paul,
> 
> On Sat, Mar 18, 2023 at 5:23 AM Ying-Chun Liu (PaulLiu)
> <paul.liu@linaro.org> wrote:
>> 
>> From: Marc Zyngier <maz@kernel.org>
>> 
>> Some recent arm64 cores have a facility that allows the page
>> table walker to track the dirty state of a page. This makes it
>> really efficient to perform CMOs by VA as we only need to look
>> at dirty pages.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> [ Paul: pick from the Android tree. Rebase to the upstream ]
>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Link: 
>> https://android.googlesource.com/platform/external/u-boot/+/3c433724e6f830a6b2edd5ec3d4a504794887263
> 
> I think this may have caused a regression for the Marvell AC5X
> board(s). I found that v2023.07 locked up at boot but v2023.01 was
> fine. The lockup seemed to be in the 'Net:' init probably just as the
> mvneta driver was being initialised.
> 
> A git bisect led me to this change although for this specific change
> instead of the lockup I get a crash so maybe I'm actually hitting a
> different issue.
> 
> Any thoughts as to why this may have caused problems?

Not really. What CPUs does this platform have? What is the offending
driver doing to trigger the issue? Can you provide some level of
tracing?

         M.
-- 
Jazz is not dead. It just smells funny...
