Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD2C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091FF84704;
	Fri, 26 Jun 2026 16:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="plg1H3MX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DB28496E; Fri, 26 Jun 2026 16:47:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 339708460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E07C91D34;
 Fri, 26 Jun 2026 07:47:28 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.Arm.com [10.34.111.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA513F905;
 Fri, 26 Jun 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782485253; bh=fso4I64apdPMDsFSzSVUMGeXU7/5mU8PMgEa5RglLgc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=plg1H3MX2b/71dDxhHwu0G+508D5rpt7vKdNsk+8FmswdnAKwh98R1MZKfuBeuXCH
 nFm3TlOMar/9L2oV/3Jl+4bAL2hIrL62Nvg+bduphyJ4Hm4v0MmgPqz/oCMqt6ysS2
 nCuiopNnnNs5NYYY1ufWhxl1oFqBfdtEc5id83b8=
Date: Fri, 26 Jun 2026 16:47:30 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] lib/efi_selftest: test block io revision
Message-ID: <aj6RAmTMTCIUw2rC@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
 <20260624-rev-v2-1-68beb809891a@arm.com>
 <f7900ff1-e515-4cba-963b-84d2d6c89ad5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7900ff1-e515-4cba-963b-84d2d6c89ad5@gmx.de>
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

Hi Heinrich,

Thank you for your review; I will send a v3 to address all your feedbacks.

Best regards,
Vincent.
