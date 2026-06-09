Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD274CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B368467E;
	Tue,  9 Jun 2026 12:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IliAbs8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815C98484F; Tue,  9 Jun 2026 12:52:27 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5962F839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gZQj33fwfz9tw3;
 Tue,  9 Jun 2026 12:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBEYbNZhfbLociXXjX3qtSyuiEjCjaTcO29F100/+Oo=;
 b=IliAbs8cZWobAJyhDoql9cRlN80jHJKxibkNH+Q+1BnkvBCgsf1Zf0O83hO6IrN5mA089M
 maDHqKKBaR0wBXJcmvCChfTtJ/YjEoKYyD/SJyaK3+IYXoaEBMYobFESpKR5SuPtHM0MSb
 uMTxvvhRFXUyYAx3EaExc5tngkkxTKTD9rEbwAEdXFrqqxXh0ewnpu8Ry2pdX8s+CWbe9r
 Bj+7pyG+H6yCxzPslSBxSxGMgh23ZFD9CfNX97QmLgU8sYwm6CR1kS0aACZECG1hOMjzRM
 1G9somWo9bCydPRquG0AKMKUEaNSBrC0aT91Z6IGmHpulmxX5bV6haPKlTdSfA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
Date: Tue,  9 Jun 2026 12:52:14 +0200
Message-ID: <20260609105219.1172564-5-stefan.roese@mailbox.org>
In-Reply-To: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
References: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ambc1yc4s1mh1grn6qqkwmeeosr5ykhp
X-MBO-RS-ID: eef19149a5dbd576d54
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

On 5/4/26 12:36, Juuso Rinta wrote:

> The OcteonTX watchdog driver currently matches arm,sbsa-gwdt.
> On systems with multiple watchdog devices this can be ambiguous since
> arm,sbsa-gwdt is a generic SBSA binding.
>
> Replace the SBSA match with SoC-specific Marvell compatibles
> marvell,cn10624-wdt and marvell,cn9670-wdt.
>
> These compatibles align with the upstream Linux device tree binding:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
>
> Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
