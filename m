Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C585CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 08:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767C18323A;
	Mon,  6 Oct 2025 10:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JIB48wh8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MXDxfYy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DD283327; Mon,  6 Oct 2025 10:18:26 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EF1807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 10:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cgBwl25ddz9sjY;
 Mon,  6 Oct 2025 10:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759738695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZOFdg/gzg9vCWiXHPCtiR9jXuRrqCdGnkat7xUWFk4=;
 b=JIB48wh82uhbtJN2/fBXTclJIN9eV3x2LP1te6BQYYf7oeMfqo/21t4YYAtmrmv/brpkyC
 kvt8gCpvXMxJAU0tvfBLfwEE0nTCG56OnlNhRDwT616zThGPLoWshZ3Wq85pFKsNuproCY
 PiVGLwI0e2AysuxC8yqPxtTY9JHTNhYu2A2G8NjRHtLQMHoRhZ36CwewKL5mbNMKick14X
 4Aa1cXYzJ9oRloXDTI3fkej8FmPjjcJlqoaNkTqnCCtq3JU6bJrVEfPWppAVc5zkJmXzGY
 Bwp5KHbNmzXqPk/1/AlE8acS5hQyYWMG2/XbEuL5NoTXomSZaOa5xpWNwZ7HDw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MXDxfYy0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <4fa8531c-e6c2-4a3a-b284-86c5bdd94530@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759738689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZOFdg/gzg9vCWiXHPCtiR9jXuRrqCdGnkat7xUWFk4=;
 b=MXDxfYy0duqnsh0WpDq3tCOr4GaLUKOqTOzLonlXGS+kb809ZMcrqUDSpDBB9vBLvwAdfh
 BsqyqmjKJFcCecYeQbrN2AzEhFCZCLWpl4igCVyPOyEnfHYf14SoclOb9NWKxZ5W7OaPJC
 byGwfu7pvzH/k5lI758KdVwpCjDDWvnRf2OgQ2jqe27nGi9UlVGJT3x83sgmZ32LXIO5Ua
 fUKRAlxLHefym/Atu9iZb4DOxJqQSWZ6tP89J0F2i0AWiZkRyJBJ/0EcjjsvDAkV/X+mu8
 W/9dP9ciGnE27AHX6yogG3n2tvJD9l+pEuqNyx2DHn1eF/fBRS2+DyjWjHBWOA==
Date: Mon, 6 Oct 2025 10:18:02 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v1, 1/1] net: phy: add paged PHY register accessors
To: "Lucien.Jheng" <lucienzx159@gmail.com>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006044405.30376-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251006044405.30376-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8fe9t594suhnkt53apybtd7s79h79dh7
X-MBO-RS-ID: 8939ee9f5bfdec3bbd7
X-Rspamd-Queue-Id: 4cgBwl25ddz9sjY
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

On 10/6/25 6:44 AM, Lucien.Jheng wrote:
> Synchronize paged PHY helpers with Linux v4.16.

Why such an old version , current LTS is 6.12 ?

> linux commit
> COMMIT 78ffc4acceff48522b92d8fbf8f4a0ffe78838b2
> TITLE: net-phy-add-paged-phy-register-accessors.patch

Please use the standard abbreviated format with 12+ letters SHA and 
commit subject -- example: e37de002fac3 ("Prepare v2025.07")

[...]
