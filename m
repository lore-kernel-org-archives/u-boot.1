Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C15EC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB7F8070C;
	Tue, 10 Jun 2025 09:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FGvCK1Eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B5A80C83; Tue, 10 Jun 2025 09:04:34 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C327805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EB98611BD;
 Tue, 10 Jun 2025 07:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F15FC4CEEF;
 Tue, 10 Jun 2025 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749539070;
 bh=4cLv1j90f9+V7DvtzQ0fpG1WhBo2y50l8OqpdyjJlGo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FGvCK1Egcr+mco1gTOf/EW0YEalhDcwlPA8t+/+2vbt+HzcMOUZ/VrenYq8SEHcZt
 4lVpVjZgVXwcM1UwcqJCwxn37SyjAbSSQdjj92e9bQxYq/AbuaSPP3y49BuCo7eF4X
 iLSG2mh6wpd8M4fxmp5ICpm9VcpLTw0AgqwLlVs037C5oXWz7Igtyz8tw1VxNkFv/Q
 7WP/EjyOP5/D72qI8+S3fCivGBmIVH8t2i3cmdo09y4sJ13n94dYZW8BGRXoA071kb
 n5aW7lMRI1g5aTe69KSs0dTVyoEi7qsfSv8Ti8re9jYhlJTB0r9D6XulPK6djNUQK9
 k6pJ5gz1nKRJQ==
MIME-Version: 1.0
Date: Tue, 10 Jun 2025 09:04:27 +0200
From: Michael Walle <mwalle@kernel.org>
To: Javier Viguera <javier.viguera@digi.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
In-Reply-To: <273f9e01-2362-48a7-9a22-ac7912b197fc@digi.com>
References: <20250605074610.1424953-1-mwalle@kernel.org>
 <273f9e01-2362-48a7-9a22-ac7912b197fc@digi.com>
Message-ID: <07fdd0078b39313a8dc388561369791f@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Javier,

>> According to the help text, you can set negative offsets to indicated
>> that the offset is relative to the end of the parition. But kconfig
>> doesn't let you specify negative hex values. I think this fell through
>> the cracks when converting the symbol from a '#define' to a kconfig
>> option.
> 
> Not sure with u-boot upstream master, but with a downstream NXP-based 
> tree (version v2024.04) I think it just works with something like:
> 
> ccimx91-dvk_defconfig:CONFIG_ENV_OFFSET=0xFFFFFFFFFFFFC000
> ccimx91-dvk_defconfig:CONFIG_ENV_OFFSET_REDUND=0xFFFFFFFFFFFFC000
> ccimx93-dvk_defconfig:CONFIG_ENV_OFFSET=0xFFFFFFFFFFFFC000
> ccimx93-dvk_defconfig:CONFIG_ENV_OFFSET_REDUND=0xFFFFFFFFFFFFC000

Yeah, but I wouldn't call that very user friendly if you have to
convert the offset the two's complement representation yourself.

> After all, the symbol gets translated to a signed s64 variable.

Also I've just noticed, that env/sf.c uses ulong to store ENV_OFFSET.

-michael
