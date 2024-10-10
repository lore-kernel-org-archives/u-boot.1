Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90EACF07BA
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 07:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC4F89170;
	Thu, 10 Oct 2024 09:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lx4EGBbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B0A891D1; Thu, 10 Oct 2024 09:31:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DBD89152
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 09:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6B9515C5943
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EBDC4CEC5
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728545466;
 bh=Houwmksx6DNWP3H4fHi5X1M+QfinC3f3WHrO7iB2/LQ=;
 h=Date:From:To:Subject:From;
 b=Lx4EGBbwg8/u6EKdPap3DPRktVgnoUSQ7oUDCoDtCEsov+D2cph5EEyllrn2P+qCw
 UIWfiBmqWrUgYxnezwCV3/31dm/C1C3234K97vGxOP49GPfAoe9W59ivtHc69s/+/7
 W3V+RXtnEHmD2Uiti8/8vDqt9MOmKUzH6+QQbQT/PNzZubSlmqYCgKQU/0grnU8MJ8
 JyxRrea/uXr2lt53WTYpOJTqPO3BgDfF7ygsX5YVRJx8gDUjOUZX4EWEpOQqCWAyOA
 Ni8ZvFLEiVbWnVSEY7T8PXG51cxFlyeciVh1GDIiNDFKjP3933jhM83hrkdc4Hq1GA
 yMv99T1tf0W2w==
Date: Thu, 10 Oct 2024 09:31:02 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: u-boot@lists.denx.de
Subject: device that supports both usb host & usb device modes?
Message-ID: <up3oe2ackjkjzugqypzcjzmqs4lgktbhn677lorwmztfwqkki6@s4z5orfn5ca7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi all,

I am searching for HW that supports both USB host & USB device/gadget
mode, on the same USB port, capable of switching between these modes
at runtime.

Preferably supported in upstream kernel.

Has anyone done this for example with Raspberry Pi?

Thanks.

Marek
