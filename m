Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C6BCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873C184BD1;
	Fri,  8 May 2026 10:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="kQBtVXnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1905684BD1; Fri,  8 May 2026 10:33:01 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4EB84BBD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:2af:22b0:b979:5676:9880:8700])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7F0B5B00592;
 Fri,  8 May 2026 10:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778229177;
 bh=7XvZmx2NTUou+YBnUxqlHa55gqLzlmlxeISahO+j8Zw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kQBtVXnmUMoPbepu/+d7WGptdg2BRCq/DkrWSI71GYoCLwpzZ4kuAx8GMkskHoXmY
 LFV1z0AUrf3AxNplFwrbjFbQzWjDmIxyThKeOJqeKwg1Q3ubU5TwdgEJRKHyk5w9mM
 e5qG5PJb8RxL2UOiR6aRE4+O0Ub576h7j75Vtarw5zoI/Q5kDuEuNySj302vcKIua/
 Uwj3Uzr4Wx9irSt+K+ZJZXkUbQt4tJvcEICxM2zaPkpJA23OF+QIqXrXIOIAFsmskS
 w3C2F07DZ4sR//7wAm2cfikrFuhRrli3LnDGnVdGI+WuV1lY0zeOKWcoJIbL0THAce
 754wQuUtOBMlg==
Date: Fri, 8 May 2026 10:32:54 +0200
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
Message-ID: <af2ftixNofr9R9ld@L30177.local>
References: <cover.1773151972.git.vjardin@free.fr>
 <cover.1776762022.git.vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1776762022.git.vjardin@free.fr>
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

Hi,

Le 21/04/26 11:04, Vincent Jardin a écrit :
> This v2 addresses Stefan Roese's review feedback on v1:
>   https://lists.denx.de/pipermail/u-boot/2026-March/613625.html

Please, how to have a review of this serie ? I am available
to include your comments.

best regards,
  Vincent
