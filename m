Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F23FCA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 23:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2821839AF;
	Sat,  6 Sep 2025 01:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824E0839CC; Sat,  6 Sep 2025 01:12:15 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CAE8391E
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni217.in.jkvinge.net (ti0116a430-0444.bb.online.no
 [85.165.32.192]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 585NCACM009734
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 01:12:10 +0200
Message-ID: <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
From: Jonas Kvinge <jonaski@opensuse.org>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Date: Sat, 06 Sep 2025 01:12:10 +0200
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=85.165.32.192;
 helo=ni217.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
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

On Wed, 2025-02-05 at 10:15 +0000, Oleksii Moisieiev wrote:
> This patch series provides generic support for Raspberry PI 5 in
> U-Boot with additional hardware drivers.
> The following features were implemented:
> 1) add generic board config for Raspberry PI5 including device-tree
> files;
> 2) add support for RP1 chip with additional hardware;
> 3) add support for rp1-clock driver with dt-bindings update;
> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> 5) add clock/reset/gpio drivers;
> 6) add ethernet support in u-boot.
>=20

Is it possible to get these patches updated for the latest master
branch? I'm having trouble with at least patch 9 and 11.

Jonas
