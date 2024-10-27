Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD8D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B944C89057;
	Sun, 27 Oct 2024 17:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VVpzOuD7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KXqNv5aR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B30389057; Sun, 27 Oct 2024 17:32:06 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C49188C10
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Xc29C6GVFz9sby;
 Sun, 27 Oct 2024 17:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDW6+UewxL7gdKrRFiwM+CIwRwtCuR4W3vr4rbNk5Ac=;
 b=VVpzOuD7MUwwVDPUZScNQzukSkmzXGhjZYHuqYHwl4zz/8YzLbwz8UVPI6gLiCX/gwRJ07
 dfw92HSyNaTHPzzqvuzDfQ9N1k8fbMe8nWTV0zhm4UP+UbFeJwUCGrOp1x2jsq0/XBfdIp
 hnlG7zg5wg3KNCzZDzhouOdrdtRSGmq9mExocup9d1tK9bgj1nVmJjzQzvVXRh2fNCvNon
 /xF8R19uuEcETF3Pi3t+Dmk8bBa5I7ltaMZzic+a0BGR110kT1d9rfPbBuLqveG0Z67gw6
 AZzAaLghOe439dSD94Didsk7Cn//IHJxVRpNUQbOxq2/xKsaKfAHaKO8iVnfkQ==
Message-ID: <bd2ec192-cbc7-4410-a3c5-e3ac0aaa7b88@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDW6+UewxL7gdKrRFiwM+CIwRwtCuR4W3vr4rbNk5Ac=;
 b=KXqNv5aRN18LJARt71lu7gi+pMrFb18dgw2+2TPRX2YEgQtCrATCWx5ZQgSjky2FxwMrfI
 qRSxNvSKx5hlmy/IrHhPvuiWaCE8hF4caqmqg6CnBCCwXmuE/51i7IRkwJgJdVSRE7+XIc
 IgEwUnGIhnjcxYdgCnYQXiwiYHgCzV1sHNkbYaCWtIbpIKAr5KbIPJFqsBw0MPQJegQv+v
 ekc75qovUA5LnLciwmfAmjsCga6tfmylTHhX827/gDtvTzMRdAkWCr7qS2MyYVYxnavm5e
 4zzNXQw1n2BuX7zfjgnz9vCl5vEeqCDmRTsmqBmlPk3o0QpebYMLIJXxCiV4Lg==
Date: Sun, 27 Oct 2024 17:15:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 03/14] pinctrl: rzg2l: Support Ethernet TXC output enable
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-4-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ztn4apiu6ak5x8xkni7p9k6aexs1mpn7
X-MBO-RS-ID: 3bf54aaf52561c36d31
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> On the RZ/G2L SoC family, the direction of the Ethernet TXC/TX_CLK
> signal is selectable to support an Ethernet PHY operating in either MII
> or RGMII mode. By default, the signal is configured as an input and MII
> mode is supported. The ETH_MODE register can be modified to configure
> this signal as an output to support RGMII mode.
> 
> As this signal is be default an input, and can optionally be switched to
> an output, it maps neatly onto an `output-enable` property in the device
> tree.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Same comment as on 2/14 regarding kernel commits.

Is this something which should be configured in DT instead ?
