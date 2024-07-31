Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E2DC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 18:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2AA8897F;
	Wed, 31 Jul 2024 20:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722451998;
	bh=YIBl9MsFybB8mpkbTeD8rhHsN92QCFyNhXIKnAHxbF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/YYjpDqTqj4IxnmdhxPU72OrojraGOKZOM30oecBnTamnmP9ltpyUw5JJ7H5wDiy
	 lyVPvFY5++u46WQKXlyhNYoGWDw48mKJRldcPcQegOIhdHb0Lx+lQ/mbs1lMMhJUWr
	 dzLEHgzVlpY/Z0UGF1TwXvVzvRUmy+Z1tCsVNdTRZ2Pmdpt9/N+f1ACWaXAr39PzNU
	 vCadLUXCiOp/UCHpg3CKKlbFMEWla+SIRAM7+XhyI65VsgG0kRJInaPQHrxCwI+XmC
	 jE1MjdREamAgRZdedd+fOqGY8JeAHoTTmpJr9utV1RZRnVWVq4sVUHqechPhCxFxro
	 B3bYlywdFHfCw==
Received: from crub (p54833c06.dip0.t-ipconnect.de [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0702D88680;
 Wed, 31 Jul 2024 20:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722451997;
 bh=YIBl9MsFybB8mpkbTeD8rhHsN92QCFyNhXIKnAHxbF0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=F3gyya1U7CCJ83AZLN10/nrs5yX+1HaPe3GdQaNBjNBwOpFq3ob1VEAVobIgkHz3R
 y8uu8sqf01jRKQUbwtc4zC0KXX4Cj6w9XhAzlw9GcONHhbpigFajp+pggW1GFv/5Cx
 6v6avPlgAMi1w07s0QJeUfiRNgVTPWLdeVc1iM0r1JoBo5jKMv5eJWdoEm7XQd5pvC
 Znd1AC+hGKLcsCUckAZ0X4b9MB5hDPMlwAAGd5VAe6Gbk3qqhmI3eMX+rt6JpNkyN9
 qhgg7OMTWpLEuFTsXA4kMop+SSkTP7aG7IvEdhl4D927XtEqX2zfC/nu6NWo9AaLu3
 po4Q3ORzKFG7A==
Date: Wed, 31 Jul 2024 20:52:53 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v4 0/5] video: Improve syncing performance with cyclic
Message-ID: <20240731205253.787c3749@crub>
In-Reply-To: <20240731144412.790317-1-sjg@chromium.org>
References: <20240731144412.790317-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 31 Jul 2024 08:44:07 -0600
Simon Glass sjg@chromium.org wrote:
...
> Simon Glass (5):
>   cyclic: Add a symbol for SPL
>   video: Move last_sync to private data
>   video: Use cyclic to handle video sync
>   sandbox: Increase cyclic CPU-time limit
>   sandbox: Drop video-sync in serial driver
> 
>  common/Kconfig                    |  9 ++++++
>  common/Makefile                   |  2 +-
>  drivers/serial/sandbox.c          |  2 --
>  drivers/video/Kconfig             | 35 +++++++++++++++++++++
>  drivers/video/video-uclass.c      | 52 +++++++++++++++++++++++++------
>  drivers/watchdog/Kconfig          |  2 ++
>  include/asm-generic/global_data.h |  2 +-
>  include/cyclic.h                  |  5 +--
>  include/video.h                   |  2 ++
>  9 files changed, 96 insertions(+), 15 deletions(-)

Applied to u-boot-video, thanks!

--
Anatolij
