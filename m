Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57482C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63C587FF2;
	Tue, 27 Feb 2024 16:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KEOjMSUn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r+IVeUnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4567B87F73; Tue, 27 Feb 2024 16:56:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C70687FEE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tkht21wV1z9sWm;
 Tue, 27 Feb 2024 16:56:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYQjyohYoyjU8Vl4lhC8CwNEFoBlFVNvwyL2GjMSYWM=;
 b=KEOjMSUn6pzwHDpWr4toHVG3s9q0m8rizzs0MBS2ra0cETdNwo33JoPjvvUw7fZB/bT5Uk
 O996WdIlwjrCaonC5hBd/sArEfugzf1TYOCsjj7LCw5k81q+pu59pHVZOXNgTYhHrjCklz
 DFsf7Ts1zT4yviB6Dgg/6s9dq2Xj+9p2J2XlhH80i19Tsh/UsVr+wVweq99tlIYV7fxbrB
 kD3KAyfp0BkeeX4Ofqf+zRPRb7GkTQYZ8vs/Q5JLgQ6Acc74iRxYOXpUeJB9vTaNntaKP0
 yIN+cfkXNt+ztNs1JAM7Q7SyIjJsGcsw5V05LmS5GDPBxA2Y9nu6pZIxzihNSg==
Message-ID: <d88cef64-e656-42a4-9d2e-d1f314b6be4d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYQjyohYoyjU8Vl4lhC8CwNEFoBlFVNvwyL2GjMSYWM=;
 b=r+IVeUnOCr4WzkxENTdE+3Dm4+9J/yHIHpB8013LwZ30y8DLPtvwMkf+tWg4cBQL8hTyQv
 9/z3W9zlCUSR2F0CFLeT7v11Zv+vUqG1MG+t1t3077EYicYDbokRCzIS8FXKnmSfZnolxA
 MlllgbNiTEvvNzGZv3Ny09d0/jbIuCoz5k4xkuo+JewcbJPFRCtWqiKpRPM39+JywXydqR
 DDNaOErk8aLCU9BLx7CR15hQyOG14Eo3GbJXtym3DCEhcBx9Dcck5cSSUL8l7T4f9pSviD
 yekb7Ikr/P73a7x8xsdw0x0gPTk+OutuuaIw8F8Nd7FeS1lGjZNH8NkUR9ldNw==
Date: Tue, 27 Feb 2024 16:56:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/7] pmic: raa215300: Bind sysreset driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-7-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hqaw79wdrnz94rqeaw15uch3x3sf4uij
X-MBO-RS-ID: e0687b0c3ce3d3bdb6e
X-Rspamd-Queue-Id: 4Tkht21wV1z9sWm
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> If SYSRESET support is enabled for the RAA215300 PMIC, we need to bind
> the raa215300_sysreset driver as a child device of the PMIC.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
