Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB44CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 04:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DE386D56;
	Wed, 18 Oct 2023 06:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF85B86BF7; Wed, 18 Oct 2023 06:51:39 +0200 (CEST)
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de
 [134.119.228.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB10865ED
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 06:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay08.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.1)
 (envelope-from <LW@KARO-electronics.de>) id 1qsyWu-00065c-1A;
 Wed, 18 Oct 2023 06:51:36 +0200
Date: Wed, 18 Oct 2023 06:51:35 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "KuanLim.Lee" <kuanlim.lee@starfivetech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Cheehong Ang
 <cheehong.ang@starfivetech.com>, WeiLiang Lim
 <weiliang.lim@starfivetech.com>
Subject: Re: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Message-ID: <20231018065135.058b8e09@karo-electronics.de>
In-Reply-To: <34eb71bbf47348e1b8916a80cbd03cc0@EXMBX066.cuchost.com>
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
 <34eb71bbf47348e1b8916a80cbd03cc0@EXMBX066.cuchost.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

On Tue, 17 Oct 2023 04:53:40 +0000 KuanLim.Lee wrote:
> Could anyone of you help to review the patch?
>=20
Maybe you should expand the audience to include the people
listed by ./scripts/get_maintainer.pl common/spl/spl_mmc.c



Lothar Wa=C3=9Fmann
