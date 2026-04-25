Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D85FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2360984528;
	Sat, 25 Apr 2026 20:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=zeromips.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=zeromips.org header.i=@zeromips.org header.b="gtg59DRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66738442A; Sat, 25 Apr 2026 19:30:56 +0200 (CEST)
Received: from mailproxy04.manitu.net (mailproxy04.manitu.net [217.11.48.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99649843FB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=zeromips.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dirk@zeromips.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeromips.org;
 s=manitu-webhosting; t=1777138255;
 bh=QnDqVCLDgy9Novx6OjOinkeT+Q57VwzhVPV9EyW9JMU=;
 h=Date:From:To:Subject;
 b=gtg59DRYAhm/bmk7tbLzCo9E31A/2wpRHanmPeYxRRvmU+O0qpl7axln24vWIfb8F
 NzHQWXrN9wSO5K6eMPQWPuPSjnn93GKwMtoQBkIA5N/dIo8QABQ44RpvhdX4OIJCAU
 jDC2B9/Ah0llfdQI6BTYJo650iq/e/48/vec5MraoKbWFGcRsGc2ABTVuMemSvfOp+
 FMrFjU8ejh7HYiG3K3bNSbwF2lqObEUKlt+sR5+/3ZgLOAZp4qu6fjf9eEtDKdbB97
 L4yyhPF7WYNOrak5MV/0JTgRAfQxDiMAVSRXiKIiLiX9zPga/hep5ItlK+DHfbhtYQ
 cuM5XabuqRbXQ==
Date: Sat, 25 Apr 2026 19:30:52 +0200
From: Dirk Eibach <dirk@zeromips.org>
To: u-boot@lists.denx.de
Subject: Nuvoton MA35D1
Message-ID: <943427A6-35D6-4EA5-8B94-B54DF8C055E3@zeromips.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

is anybody aware of efforts to support Nuvoton MA35D1 in mainline U-Boot?

Cheers
Dirk
