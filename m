Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C0C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 14:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AE380F4C;
	Sat,  8 Mar 2025 15:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="eZnxJqpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345B1809A5; Sat,  8 Mar 2025 15:19:44 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC3080050
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 15:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8B36E25B88;
 Sat,  8 Mar 2025 15:19:41 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1IDv3w2C4e6; Sat,  8 Mar 2025 15:19:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741443581; bh=JpVohEXp4eneLP7WpxbZ/uD4x4xXMpJhTLN71h/eZlU=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=eZnxJqpe88uYDdRgfaegq/fVuyR1d8XiTtGvzpK1el+08dIJHkwPPiZsoDESXTbGb
 dVNtFRWQRDofZJFGd2YjZ2MzrZl9g+4vUDGZl+3YbII8FQ+9TfXklIL+pMCMqcAW3Q
 iN9bMiDMaGSHCh0+IfJcR+gEBG2GsDDArVBoLSTPpOwD/UIPzrw8CH6c52qdMtGtoz
 PgCoCuyiGRQRHPd5pKZvYSVE+J4igbysI/BuoYECiZ9nQK3vYKJKspj6s9PS8yXtgx
 A4ziVM9Di7GRu8gfZNHttrWJaNESkohZksBOHKw+nXT9MEgbs3KAakkPPFsZkV7Y7u
 a+4B/JnOBLhDg==
Date: Sat, 8 Mar 2025 14:19:26 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ali Tariq <alitariq4589@gmail.com>, u-boot@lists.denx.de
Subject: Re: Building separate SPL with U-boot
Message-ID: <Z8xR7q3o2rUakJAo@pie>
References: <CALDOrMFBp0WVRPtXvT5mtjdw06QMZTQw9rEo38NB0o=LkT1prA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALDOrMFBp0WVRPtXvT5mtjdw06QMZTQw9rEo38NB0o=LkT1prA@mail.gmail.com>
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

On Sat, Mar 08, 2025 at 03:07:19PM +0500, Ali Tariq wrote:
> Hello everyone,
> 
> I am trying to build a separate SPL for u-boot (which would produce a file
> named FSBL.bin - first stage boot loader after the build) for testing
> purposes. I am using bananapi-f3_defconfig as the config file.

iirc U-Boot support for bananapi-f3 is really in an early stage and I
don't think U-Boot SPL has been ported to the platform.

> But I want to know how to produce a separate SPL for any SoC or board.
> 
> Is there a specific reason why the separate SPL is not built?
> 
> Regards,
> Ali

Best regards,
Yao Zi
