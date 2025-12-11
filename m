Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FDDD41D6A
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAD28389A;
	Thu, 11 Dec 2025 17:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="CePeQE4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CAA839DE; Thu, 11 Dec 2025 17:30:35 +0100 (CET)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3BD830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 11 Dec 2025 16:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765470628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1Eh4qZoFLssrsRpeUBaY9MUELW0UbJ/FSCDrggX3I8=;
 b=CePeQE4aEDPjg2hdu/uoP/UBS/p7oOwQMFSOcnRp4ueg+k34AsSkhVSll4syucQmZnel1W
 DJsuC6ahm8MasZ9mW2ZFwl+BByZM+4aJnEDnvomYe6mVOQPJ2eD1X6GQwzkoFG8bDlPkZR
 Gmqo1QLSXkwPQMsRbi4gaoXswLfBDaUwuwv3EQXW02jJDzrRJBzDziH+XwCFc274+tVRW8
 fcPtnHd6lzeqzh9+lKq+9zDgS+9Wa7oBl/YIBTBgX5XoDZOs5wquLAmbFmhPqp/sdIHy86
 JC+7UTpXluNXZwtue7hrbBcolXCAph0rP1lsPzW7st9+EQrB0f/8qtaKQqn8uQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
Message-ID: <t745um.2alld5fym9h3f@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hello,

Superseded by v4: https://lore.kernel.org/u-boot/20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org/T/

Thanks for all your reviews!

Best regards,
Ferass
