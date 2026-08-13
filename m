Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFF1C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 09:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2A8740982;
	Thu, 13 Aug 2026 09:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NkXYX05bQ16j; Thu, 13 Aug 2026 09:11:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F0A404F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786612268;
	bh=CI0MvfD4MbJmEKqK5zewQtosQI/7wsgUrEMsIYLs/9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5Gb3nbmGQDn0q+zRBzVdPTY14m38raWDOOgoJY+pP0rTleduAXtiJqw3SSGwGJFD
	 fsjVYtkObGKUYUjIZpvytwjlTVVuU0NE+9V7WLVAql0lI/1DmejxVOuzVl9dqzNXut
	 KlguFL2Gpr8wD3hzN8tjXdRWmr255HQvxA/mQJ/yfSCnpYtcIDzfF3LMGhcVwBg5Dp
	 9ZzS5zpESZ6sD2IJmeP7EeZrwyFE+7RyqRgu+3prphPUXfdrR75VM4epOVsfU3E9CG
	 mctJ0RJj1IYTsn3deSbCDMdl1dxM6PGWzTxqt7pUSZyKjxCseoD2iMnpjKIrzQoBEm
	 yXojgHGR7ZVxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99F0A404F2;
	Thu, 13 Aug 2026 09:11:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 476EC3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 399AC608B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atL7p8APhwtW for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 09:11:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5C740606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C740606C2
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C740606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:11:02 +0000 (UTC)
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
 by mail11.truemail.it (Postfix) with ESMTPA id 278FC1FBAF;
 Thu, 13 Aug 2026 11:10:58 +0200 (CEST)
Date: Thu, 13 Aug 2026 11:10:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] toradex: apalis-imx8: select QP/QM device tree from OTP
 fuse
Message-ID: <20260813091054.GA34525@francesco-nb>
References: <20260813-simplify-apalis-imx8-v1-1-7239ebeb5b38@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-simplify-apalis-imx8-v1-1-7239ebeb5b38@toradex.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dolcini.it; s=default; t=1786612258;
 bh=CI0MvfD4MbJmEKqK5zewQtosQI/7wsgUrEMsIYLs/9s=; h=From:To:Subject;
 b=f9PT17AtpgEjmQ6/x83RLW3mNzvV4LwqA1jWh0oxdghOT+qxrttWyLW9oanL3sdZZ
 iVD02iyuEBijyukN71BpW7yJYUeceTNF5Y9aDNctuTXpwomRfdO8iNhinYKk4WnpMa
 S4uaa6cGUlLu2wusjxlKwzPWKU3R23f7crkAsfF5XSglEbv2GtEfj/+yUHs7fjXUes
 GlOpuTEmfa6uRP1w4Uy9gMq3a1XqyUESikI0QkWNpWFab1eDJ6VNmK/pJUq4As1m1K
 D9PZlxnzujNu5EHeluFV9OV4cHkhdXMeaZNECtlhhWLT5K+yGWFd7z70FpfQXTsD2G
 WQuM299wUnHLg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=dolcini.it
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=f9PT17At
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Aug 13, 2026 at 10:00:31AM +0200, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> The Apalis iMX8QM and iMX8QP can be distinguished reading out the OTP
> fuse word 6. This logic is already used for memory layout selection
> and can also be reused to select the corresponding device tree.
> 
> Decouple the device tree selection from the Toradex product PID table by
> moving the OTP-based QP/QM detection into a helper function used by
> both memory layout and device tree selection.
> 
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
