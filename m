Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C3CCF9F1
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 10:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE52C808AF;
	Thu, 30 Oct 2025 11:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="gW8Y1mD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AD2832AD; Thu, 30 Oct 2025 11:15:36 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F829800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 2D13322D64;
 Thu, 30 Oct 2025 11:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1761819333;
 bh=lkm8zNor2a9QtuSZGnQcChkbyXeeS10Cm+nbugvW19M=; h=From:To:Subject;
 b=gW8Y1mD3rA8bKp8EIbiRkRXWA/Z6MqWB7qLkZ0CaJwc8n5lAVmouYnW2LBHiczkYU
 NHVY6UgG3wE9FtWGHmfCcUijYogvKO4GVRsTQkWL5648C/bcQ3z5QK2OnGQf9W3at7
 6wILfTPP+QHi6mYSSZtTZNwDQOFGuK1/2nJ2wT6B54z/OUd4SbCdo5bqCKtwPBGOs4
 e/QLSKJ4RolDhJ+9spXq0l2p/VUxqP0BshRtBySY25c4/p1R80b5pZE9fLPDhPehJI
 7roX6Qn1rFaKauXrCy9G8Ll5sdTLrp3hXlt8TEsMDt5Kf83x4TXexpc/rtICxtbfdO
 KecthadHw5GTQ==
Date: Thu, 30 Oct 2025 11:15:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] toradex: verdin-am62: sync rm-cfg with SDK
 11.01.05.03 baseline
Message-ID: <20251030101529.GA29588@francesco-nb>
References: <20251028151012.126588-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028151012.126588-1-ivitro@gmail.com>
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

On Tue, Oct 28, 2025 at 03:10:11PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Update the resource management configuration (rm-cfg.yaml) to align
> with the default configuration provided in TI's AM62xx Processor SDK
> Linux version 11.01.05.03, generated using the K3 Resource Partitioning
> Tool.
> 
> This matches the configuration from board/ti/am62x/rm-cfg.yaml and the
> notable change is the sharing of MCU GPIO interrupts between DM R5 and
> A53 cores, and reservation of an additional virtual interrupt and event
> for TIFS usage.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

