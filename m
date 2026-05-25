Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5DCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 18:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28848488A;
	Mon, 25 May 2026 20:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63802848B9; Mon, 25 May 2026 20:51:20 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC8184881
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 20:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received-SPF: pass (eclipse.jkvinge.net: 84.49.181.190 is allowlisted)
 receiver=eclipse.jkvinge.net; client-ip=84.49.181.190;
 helo=ni217.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.2 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.11; 
Received: from ni217.in.jkvinge.net (190.84-49-181.nextgentel.com
 [84.49.181.190]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPSA id
 64PIpHu0944816
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 20:51:17 +0200
Message-ID: <10af0a6535788f5000f688897f51d60cbe0c0a86.camel@opensuse.org>
Subject: Raspberry Pi 5 and GPIO TPM
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Mon, 25 May 2026 20:51:17 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
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

I'd like to get u-boot to detect the LetsTrust TPM on the GPIO on the
RPI5 at boot, is this possible now with the current available patches,
and has any of it been merged?
I see there are patches sent recently for RPI5, which patches do I
need?

Jonas
