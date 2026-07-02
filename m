Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433D1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CAC84CCF;
	Thu,  2 Jul 2026 11:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="OnYncwD6";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="lOYQRraM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE5784CB3; Thu,  2 Jul 2026 10:42:48 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA6F84C7E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 107A82238B2;
 Thu,  2 Jul 2026 10:42:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id F0745223F68;
 Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr F0745223F68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1782981766;
 bh=s2ged1Ri1dtYUibq1QKVIp4NxdtGymcdaoM8whLprew=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=OnYncwD6MIS8c5xXebDwwMtX5QeXkUV14iocqNqK/vk7I+/eA1uX3/9AhoiOQj6f7
 lZKxt61f2wwIzbhGfYVpDPyf01DGxOrtffnjf2egnZNDYX7v362X7OwmA5mBhGLqyP
 YmogG0UjmLQ+Pq7+8rzecCNr6Gydk3rucR3uKxZA=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Xs6gwTHyDRul; Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id D127E2238B2;
 Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id C29EE6E0A0D;
 Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id AF8D26E0A37;
 Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 AF8D26E0A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1782981765;
 bh=s2ged1Ri1dtYUibq1QKVIp4NxdtGymcdaoM8whLprew=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=lOYQRraMXZF5YHnDB0fIQ64icOxwx+XBpQJTjETahzmvz5+IAf/WZqgzprp88rAnY
 FLpLtH6Jw+s/wK8y7Jrph1hBqqbsBsSUeGgEGGl9URCSz62/VD01UnJ1SAWI0APEI9
 QeuodCRpXIMnhyTA7IIhBFEpHEb3vBiWcBnxVE1M=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id L2RulOKSXlnM; Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (231.168.185.81.rev.sfr.net [81.185.168.231])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id 2A6F46E0A0D;
 Thu,  2 Jul 2026 10:42:45 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, lukma@denx.de,
 Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>
Subject: Ping on Fix TI AM64X ERHPWM
Date: Thu,  2 Jul 2026 08:41:57 +0000
Message-ID: <20260702084157.540063-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:46 +0200
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

From: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>

Hi all,

Just a friendly ping on a patch series.

I would appreciate any feedback, comments, or review when time permits.

The series is available here:
https://www.mail-archive.com/u-boot@lists.denx.de/msg578094.html

Thanks for your time and consideration.

Best regards,
Theodore

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
