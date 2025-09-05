Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2FACA1015
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6526683734;
	Fri,  5 Sep 2025 10:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368AB83807; Fri,  5 Sep 2025 10:27:55 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A75E8362A
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jlu@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1uuRnS-0005gb-MA; Fri, 05 Sep 2025 10:27:50 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1uuRnR-003rTH-1v;
 Fri, 05 Sep 2025 10:27:49 +0200
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1uuRnR-00Bt0G-1K;
 Fri, 05 Sep 2025 10:27:49 +0200
Message-ID: <30f3f0493110fac196fa2ac575dbff914c404c36.camel@pengutronix.de>
Subject: Call for Participation: Embedded & IoT micro-conference at Linux
 Plumbers 2025
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: boot-architecture@lists.linaro.org, barebox@lists.infradead.org, 
 u-boot@lists.denx.de
Cc: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, 
 stefan.schmidt@linaro.org
Date: Fri, 05 Sep 2025 10:27:49 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

We are happy to announce that the Embedded & IoT micro-conference was
again accepted for Linux Plumbers this year. Hosted in beautiful Tokyo,
Japan December 11-13.
https://lpc.events/event/19/contributions/2005/

Topics cover all things embedded and IoT. Boot time to kernel size, low
power communication, telemetry and also RTOS. Devicetree and build
system have their own MC and we can move sessions between them as needed.

As with all MC's at Plumbers we are not looking for talks, but rather
discussing current problems and working towards their solution. If your
proposal has a specific stakeholder (maintainer, developer, company)
that would be needed for a fruitful discussion, please mention it in
your submission.

The CfP is open now and will run until October 3rd. Please do not wait
until the end with your submissions as we are going to accept good
proposals even before the end, so the MC might be filled up before=20
October 3rd.

Jan & Stefan
