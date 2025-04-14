Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46899C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 18:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535118082A;
	Mon, 14 Apr 2025 20:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="expVWV/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8398091A; Mon, 14 Apr 2025 20:07:46 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A071807B1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 20:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EI7S9r2225093
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 13:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744654048;
 bh=f3vpgcHanjLtKeeo1duvFLpMIGwUzE4/CGVDhvYhrdY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=expVWV/41CVlNH/Rk0UHQM9+SZuQINhOw6P/clIZRdP9p/6c7mdnLP4iEV44duXEM
 v3MxZZhP/l0FheU0eRA2DlEOCNt3qpqww440KUIiH/m5cFG7+YR6zLIwN3Z06M0qCX
 OWKQ+pWSFhLohSTeZW+IwcUFUgZhaq7mam/u0gqY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EI7SXT032158
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 13:07:28 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 13:07:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 13:07:27 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EI7Rpk018782;
 Mon, 14 Apr 2025 13:07:27 -0500
Date: Mon, 14 Apr 2025 13:07:27 -0500
From: Nishanth Menon <nm@ti.com>
To: "Francis, Neha" <n-francis@ti.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
Message-ID: <20250414180727.5d5zyenfagdc5qw2@unable>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 23:06-20250414, Francis, Neha wrote:
> On 4/3/2025 1:09 PM, Miquel Raynal wrote:
> > It is very surprising that such an uclass, specifically designed to
> > handle resources that may be shared by different devices, is not keeping
> > the count of the number of times a power domain has been
> > enabled/disabled to avoid shutting it down unexpectedly or disabling it
> > several times.
> > 
> > Doing this causes troubles on eg. i.MX8MP because disabling power
> > domains can be done in recursive loops were the same power domain
> > disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> > timings to respect and it is easy to produce a race condition that puts
> > the power domains in an unstable state, leading to ADB400 errors and
> > later crashes in Linux.
> > 
> > CI tests using power domains are slightly updated to make sure the count
> > of on/off calls is even and the results match what we *now* expect.
> > 
> > As we do not want to break existing users while stile getting
> > interesting error codes, the implementation is split between:
> > - a low-level helper reporting error codes if the requested transition
> >   could not be operated,
> > - a higher-level helper ignoring the "non error" codes, like EALREADY and
> >   EBUSY.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> 
> This commit looks to be breaking K3 platforms boot, please see "Latest Boot
> Summary" [0]. Reverting the commit fixes boot.
> 
> [0] https://lcpd.itg.ti.com/upstream/k3-boot-build/main/build-trends.html

Uggh. This link is a TI internal link. Nutshell, it is broken
between:
v2025.04-921-gcb7555e93075 : https://source.denx.de/u-boot/u-boot.git
and
v2025.04-1041-g407d68638fe3 : https://source.denx.de/u-boot/u-boot.git

Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a commit
which is this patch.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
