Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE56D3CCA1
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 08:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAD683015;
	Thu, 15 Jan 2026 09:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z09C/gXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDBC83623; Thu, 15 Jan 2026 09:26:46 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C0080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 09:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EFA0B60167;
 Thu, 15 Jan 2026 08:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33134C19423;
 Thu, 15 Jan 2026 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768465602;
 bh=h0ny604bCpWAH+UUMoyXV+QLtJ75hh1MxfLf3PiU/+I=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Z09C/gXkXuCaX84eGq4m8/pk5f5G4jIPgeqU5AttOpqvjXe5jxaw7k4NIBc+nEpPx
 2V4yT91uEqD7NC1Gmjsf008xWdu5joOAyqU3upuaMxWHgtFe4bx84X+rS3wcNk8x64
 ZkheJS5/MYfDAg5MvPO/a5GVUN7ef2bKGBvF7kojpwNUFhtZrFsgqxymAFaZ2tHUBb
 jveDlViJ1uLJlymQBXkTn5e7+Iojnc3m7GHN98hrMWLL7nUsCw0HSbpkM/XmnBP2MJ
 lqZdhnvd5eg7yFUSzKeSozT1/80q5CI7uX03KzNxkFiWgvQLC4XUprZ+tUjjUsgHDQ
 aXKphDKsx83/Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] bootstd: android: Add missing free in
 android_read_bootflow
Message-Id: <176846560000.658634.6991500046277204518.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 09:26:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Wed, 14 Jan 2026 10:14:55 +0100, Francois Berder wrote:
> If strdup call fails, one needs to free priv variable.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] bootstd: android: Add missing free in android_read_bootflow
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8fa0cf5f3d7ca15e2d102d0d46a132d246793486

--
Mattijs
