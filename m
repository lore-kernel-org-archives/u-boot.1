Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0EECD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A71C8493A;
	Wed, 10 Jun 2026 14:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KQBd3eOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B238496E; Wed, 10 Jun 2026 14:21:48 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF1BD848BC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gb4df5nLyz9vGR;
 Wed, 10 Jun 2026 14:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOXWEsZYMDlJjuciTXR+0qcGHloqSDqAFqZX/Q52o9A=;
 b=KQBd3eOMif4McfgjNFDAy4tacbbQ8vNn0ae1pKrq1eRcSrs57MluUyNTB3hlvbXcLCibAI
 di607Sq2Uv+IYTwVF8R+J9VA2m3s/M6hHwZtQ6L/xgCCfocNT77iyClnjFOjnElQITP8FZ
 sIFRqdZkn1wUyHv3L/7m2kD7IlCDFZfjVOrU6hlRB1eMhjMjhVQkn87RNijmNuSJacDk47
 /gPlzexWH8V8DAefJEhapWqPY0Quf72tX3NHbaRa2/Zoz1VNZU23BrumNw4a2In/M+Ddek
 g9fMhl84hFB7zRsP+X8YcG02rH7AzoP/lXTkr+8z84kf0q8aV5Qwa2PhvtfGHA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Michal Simek <michal.simek@amd.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Luca Weiss <luca.weiss@fairphone.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] serial: serial_octeon_bootcmd.c: use correct Kconfig
 symbol
Date: Wed, 10 Jun 2026 14:21:24 +0200
Message-ID: <20260610122132.2674311-8-stefan.roese@mailbox.org>
In-Reply-To: <20260225071008.49435-1-heinrich.schuchardt@canonical.com>
References: <20260225071008.49435-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u1j6346z8kwdx547dd93hd1q4sb99jyf
X-MBO-RS-ID: 2fb2c577fe5c6fea751
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

On 2/25/26 08:10, Heinrich Schuchardt wrote:

> CONFIG_SYS_IS_IN_ENV does not exist.
> CONFIG_SYS_CONSOLE_IS_IN_ENV seems to be needed here.
>
> Fixes: f1054661e50f ("serial: serial_octeon_bootcmd.c: Add PCI remote console support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
