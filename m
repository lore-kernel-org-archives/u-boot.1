Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06171FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE308394E;
	Mon,  4 May 2026 19:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="cS4nO8Bl";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="SiJMU3UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5149583FEC; Mon,  4 May 2026 19:32:43 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4400B80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-mkbj.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777915960; 
 b=fQMu2mc7lbDaFq6Mxy3Xjy/dbwzp85FQnEcxjfTewruaYjp75sz+YKRZCdIhAvwtCqQZLhP+ar
 tVlRJgUiKyUnwhxCLALdYMSQxmE8e3etwv705CbVri3T7hPp6j9UWp/fCy6WgwY9QKWGBtCzCX
 UqU/NTNakMotK5fQVMLxjDRjwFO+eSn8akSXAvmN25BtqK4HY+SnuByVYIEu3H0A4XyYdoXZwH
 AdW4b57XCCsz+d9pCNS7x/jy8O1z4Kfpp/iQvRmReGCVnfZVgPoA0mWfOxsR7Dt2ke0bluu4+Q
 C2Z+QeEtJmgcZx2Q1horgwC2Sz0mb9aQ3g6pwpTEg54mGA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-mkbj.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-mkbj.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777915960; 
 bh=NlAMNd1XF/YxzzYrphZruXKyrPJ34F/qzqHTDtHJD8Y=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=PFKwC0AVD61xZuaMwQESzHY9wAAYBU4UOQt/eSEUO2V8vhWlynt/neAJhMQazIX02CiCk9PqLW
 e1Fm+xhyI4M04pDJW3fInHTLAhPLpVIOwCuzsZP+UQ7oQy0YJDdNH/LLq+NP/7iI2YzLUreUWB
 bei4/xyk63Dcvo99q2Odf5BQ+RBFjMwNHBCb5yTiwEkSjdzLqXmsG7d6TinEzX/X2WEpS5+DxV
 GU9SeQytvL4RAPjJ8+VgszjLOh3cDcpZXcb3xRQ48Glj5H2rL3E+sZ7QG82qucg0o3xwRObwEC
 AeN3C8vgui7Xixxx9dy79uuTBYJcztRYH+Uidc6aM4CuGA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=1xgqm70tKJDEXmuqOQ3EotiyvPERbjwqJtJ9lBNrh8c=; b=cS4nO8Bl+QK7IsLZBSpkxCZQ8C
 oamfWR5jmHMAN7/+27M5hM/dmgKSEJ5bKIXUQfbmngrYaKEstg3h+njWqamihQ1BsDjaweI88DY+e
 6ltXKICqOjyDaFMnp8OOCNh4uiuwoRs+T74oerAOARMkGXHk1wKh3X2f33LZpIHpmkcI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-mkbj.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wJx9o-00000001Gg3-1eUW
 for u-boot@lists.denx.de; Mon, 04 May 2026 17:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=1xgqm70tKJDEXmuqOQ3EotiyvPERbjwqJtJ9lBNrh8c=; b=SiJMU3UKiDpBGJtgMPPXJ3aH2P
 f8cg4KwEp2vVmGsSkLtBNyKKKNIP4h/9oTt++NOW1O5rXzpsErn0jji/lvTHXWsf5jSvDPn7wT+nX
 doFSkAytNGN+AIm3L9MJ+uIPtn4dJhXFjGexzzRbvz2HTvMGE/wyVCgfiW34oWoEatJM=;
Received: from [95.248.129.24] (port=60501 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wJx9h-000000004zF-0p43; Mon, 04 May 2026 17:32:29 +0000
Date: Mon, 4 May 2026 19:32:27 +0200
From: Francesco Valla <francesco@valla.it>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [0/5] Enhance the SPL FIT "full" loading logic
Message-ID: <afjXxuXB0gBAcCJr@bywater>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <CAFLszTjGTXHbOej36kJdC28Ri0EgPv_0URi5vCm_y4yUYyznzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjGTXHbOej36kJdC28Ri0EgPv_0URi5vCm_y4yUYyznzw@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 239604790b69b801c68441650ad67c09
X-AntiAbuse: ID - 239604790b69b801c68441650ad67c09
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wJx9o-00000001Gg3-1eUW-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-mkbj.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Simon,

thank you very much for the review!

On Mon, May 04, 2026 at 06:07:59AM -0600, Simon Glass wrote:
> Hi Francesco,
> 
> On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> 
> > this patch set tries to align the behavior of the SPL FIT 'full' boot
> > flow (i.e., the one obtained enabling SPL_LOAD_FIT_FULL) to the one
> > happening in U-Boot proper through the bootm command.
> 
> Please update doc/usage/spl.rst (and the falcon-boot section) to
> mention the newly-supported pieces, i.e. kernel decompression,
> post-processing, ft_board_setup()/ft_system_setup() and the ramdisk.
> 

Ok, will do.

> Please also extend the existing FIT/SPL tests (test/image, or the
> pytests under test/py) to cover the new code paths. At minimum a
> sandbox_spl test for the ramdisk fixup and ft_*_setup() invocation
> would give us some coverage. Let me know if I can help with that.
> 

I'll try to add full tests, and chime in if something is not clear.

> Regards,
> Simon

Regards,
Francesco

