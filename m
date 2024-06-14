Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9442C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FA0889BE;
	Fri, 14 Jun 2024 13:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8981880F5; Fri, 14 Jun 2024 13:51:20 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B6C88261
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni227.in.jkvinge.net (ti0116a430-0342.bb.online.no
 [85.165.32.90]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 45EBpBj2017488
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:51:11 +0200
Message-ID: <e807c90eebd0f5756de613b4773d39aec71bb064.camel@opensuse.org>
Subject: Re: silent u-boot not working
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Fri, 14 Jun 2024 13:51:11 +0200
In-Reply-To: <CAOMZO5B3krB1vyibGNYej9nrPMkOXh1+P05Boqd2Vsr1E5nmcg@mail.gmail.com>
References: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
 <ca425556-fdbd-457e-8713-5176f925cce7@seco.com>
 <fad372cd45b13bd15fb07c10c66802b0a03b4f25.camel@opensuse.org>
 <CAOMZO5B3krB1vyibGNYej9nrPMkOXh1+P05Boqd2Vsr1E5nmcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: 85.165.32.90 is whitelisted)
 receiver=eclipse.jkvinge.net; client-ip=85.165.32.90;
 helo=ni227.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
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

On Fri, 2024-06-14 at 07:52 -0300, Fabio Estevam wrote:
> Hi Jonas,
>=20
> On Fri, Jun 14, 2024 at 7:49=E2=80=AFAM Jonas Kvinge <jonaski@opensuse.or=
g>
> wrote:
>=20
> > Where do I find CONFIG_EXTRA_ENV_SETTINGS? Is it an option in make
> > menuconfig, or do I need to edit the header file
> > include/configs/rpi.h?
>=20
> In recent U-Boot versions, this option has been renamed to
> CFG_EXTRA_ENV_SETTINGS.
>=20
> It is located at include/configs/<board>.h
>=20

Thanks, that was helpful. I finally was able to silence the boot text
by adding the following in include/configs/rpi.h:

#define CFG_EXTRA_ENV_SETTINGS "silent=3Dy\0"

The u-boot logo in the upper right corner is still showing, is it
possible to disable that too?

Jonas

