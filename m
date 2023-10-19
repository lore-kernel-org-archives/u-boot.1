Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0257DCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE128749C;
	Thu, 19 Oct 2023 17:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729748;
	bh=gTuCD7oriDbgIsoQXJRWqvmOtOWYvZ+75u6IZGsvw+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PqXwpr9Rg0ADoSO/TcTM4Ih4aQrdMTpXEFGJkxePbEcsdd7bmZiSyY0othW6TQ11w
	 DIBSkjjNFnib4ybiMdqPKXN0Rjqug3WAPU+cvLLerdq1/HY00LVsgM5lkqUcmhSBju
	 2/pfnu2gCvujL1GSE5XPyCfPG1wX5uP8SxTzy7O5vPNb6ZmX/axd8atISBh7x/esWW
	 6RigaKR+aUd22/tlxt9u+C3C5EB1naKqD7F9LOLNO20Jh+fAEksi+gNrEfG9UcEJDc
	 F0orBOxUXXvOzdCj8V7K/pBN4yPVd+74rL9myMecrZ5zhlD9NnzGvQlMm+pxqnAYDu
	 aSc4Yq4jX7cFg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ED70C8745A;
 Thu, 19 Oct 2023 17:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729745;
 bh=gTuCD7oriDbgIsoQXJRWqvmOtOWYvZ+75u6IZGsvw+4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t56FNDR4V2Paf/sjhIp3g/M7RfXBINcUxw1txRz3cw/1UpFODCP1OwpXl+LY0wfBx
 REAhcfFuBte77Cr6X2fYd6zozpy2zb9tkk/KPtVF8AKTq7Blh6Yufp8RIb9sh895zu
 VkE2U8v++cFUqEV5bseuGNc4mc2ZzcLo5GPpNDtqDeR0zDMHzpSgxKXZbHwR/v1IrY
 mymyBh15P/AnWlRqRLnjNgXMGmEsWtYySxeyHUtcj43aQEVyqHQgN8JiecetRpPTx/
 u9uAJTqViLG5Q5xz1zE21claLaYknH4li2VTK3NOPyV8Ssj1tB5qlVMVrc7tjlYZNo
 NWuiOFdKx9I+w==
Message-ID: <268197af-2084-4165-af3f-a26c483c95c5@denx.de>
Date: Thu, 19 Oct 2023 15:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] led: led_gpio: use led_bind_generic() helper
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-5-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-5-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/19/23 11:58, Rasmus Villemoes wrote:

Commit message is missing.
