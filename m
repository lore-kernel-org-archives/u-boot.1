Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE0BCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0509884825;
	Mon,  8 Jun 2026 16:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="csRRC0Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A338684841; Mon,  8 Jun 2026 16:36:17 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046288466E
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1780929369; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W4lefC/3jHX9oIzBYYYf6+jEVa9ywJoYI2egvqhedH00plnOce6BQil/D2G6fZ4mUB7GP6qVmJNcBoTTiuVskH4T/aFXCQ4nzqOf3A+XPwcvLYJWabEx6EGS5Hr6+UlAGa28QQpFhENaGLyVItJXeANBO2KMu7pIhF+Kue2ijt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780929369;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TJJ7xUTObfB0cGw9LdFwmCIAOd4CFQz9ZWkQbc51WdU=; 
 b=HR46NF1QSRKVQRtB7s6UI7LCOcWuLKRIjxijfDfHM6p0CWUvmCqEaVxlLu6zV/7uDBm4ks+KwGinh3XB/vAJdZbV6/Df4WB8h/KBgwHFZZoYzI1zZZPDwNsjorEoy/GXqeAWeX6WB0eWenpJ/pyRC4sYnJaMcoSwvwwcTou/Bmw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780929369; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=TJJ7xUTObfB0cGw9LdFwmCIAOd4CFQz9ZWkQbc51WdU=;
 b=csRRC0Lof7Ev1WKavOEjKW8aiHZyce+4NyikTY2TqIpBKqC2Q8s+X3PiDjPqOQCw
 YZ4CQMgk63PESAtaOEb9BIxNyLP/j17WeRpdi05QKLkPeWRbdyK5uXeFicAF/8Ti55v
 vW+wiTGQkbBIC9FqLYjRwDeUuGwVa4/0frJgSoKE=
Received: by mx.zohomail.com with SMTPS id 1780929366122144.85635788859543;
 Mon, 8 Jun 2026 07:36:06 -0700 (PDT)
Date: Mon, 8 Jun 2026 14:35:46 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, <git@amd.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>,
 "Randolph Sheng-Kai Lin" <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, "Tom Rini" <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 1/2] riscv: Make RISCV_ACLINT visible
Message-ID: <aibTQkqO0V5ykrJg@pie>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
X-ZohoMailClient: External
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

On Fri, May 15, 2026 at 02:47:52PM +0200, Michal Simek wrote:
> A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block.
> 
> Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
> prompts.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - don't enable it default because it is breaking some boards
> 
> Changes in v2:
> - Make symbols visible and disable them per platform basis
> 
>  arch/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Yao Zi <me@ziyao.cc>
