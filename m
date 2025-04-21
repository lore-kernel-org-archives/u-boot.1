Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C86C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 23:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73AE98129F;
	Tue, 22 Apr 2025 01:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paulsajna.com header.i=@paulsajna.com header.b="g56qXCkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BAD812BC; Tue, 22 Apr 2025 01:29:23 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF7E80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 01:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@paulsajna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paulsajna.com;
 s=protonmail; t=1745278160; x=1745537360;
 bh=U3OBM4XQ6r0NId31CkuOdDrNtVTDR4tcCUFRdgHgTEI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=g56qXCkGkdHOzmU1ogFSqlDJ9eGdFbGvYudBf9n+kVeYQbE0N/G8t8O8/wV4eueKR
 /AaHzQEA+jCURrwf3XCk/a+EMa0sOs5V10RcdaGreQu9y3iIT488ZRUIyH/jZLJK++
 twi0WO/DPlQ20xMAb8vDsN84VPf1umKFtF4oBdrbbeuReJBZ+u/fB4JS8F4bXomQJX
 0r7Ksj5TGo1nd3Pw8uLzb9+ZjJLdXwIBpuG87KvJANqwxoVu2E7op4tSqQHCUcY9HO
 Ai7v1GcZWileCHWlfGJAOOgYcyDl9C5bhVh/Oxp8kC06jcrrl7fBIY679Q2WbdCpZ2
 9iPmx+iWD7Sbw==
Date: Mon, 21 Apr 2025 23:29:17 +0000
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
From: Paul Sajna <hello@paulsajna.com>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>,
 Paul Sajna <hello@paulsajna.com>
Subject: Re: [PATCH v2 0/2] watchdog: qcom: introduce qcom-wdt driver
Message-ID: <hyAGyOfR_pMcdHIMj2CuW1rBYK5oe64oHYWsaLjYKeDjWB8_2btUC6pnRQLedixSVaHAWoGTvSV1JWrMdgIloYex0C4KjZq_4nX_sbvrrtc=@paulsajna.com>
In-Reply-To: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
References: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
Feedback-ID: 29073965:user:proton
X-Pm-Message-ID: 3be7907a65aad31b8aacef4a70e0b3ebb42a346a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Sidenote: I needed to update the devicetree for judyln to use usb high-spee=
d instead of super-speed with recent changes, I noticed while testing this.=
 Otherwise it crashed. I'd like to submit that separately, but I'm not sure=
 what's best.=20

The options I see are:
1. copy my wip device tree from sdm845-mainline to the upstream folder
2. copy my wip device tree from sdm845-mainline to a u-boot-specific device=
tree
3. only change the usb in the upstream folder
4. only change the usb and make a new u-boot-specific-devicetree

Please let me know what would be the best way to proceed with this.

Thanks,
Paul Sajna

On Monday, April 21st, 2025 at 11:20 PM, Paul Sajna <hello@paulsajna.com> w=
rote:

>=20
>=20
> This patch introduces a simple watchdog driver for Qualcomm devices.
>=20
> Some devices, including one I have been spending a lot of time with,
> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
> seconds if the watchdog is not serviced.
>=20
> I have tested this patch from Casey Connolly that is over a year old and =
has
> not yet been upstreamed, and it is very useful to me. I can hardly use
> u-boot on this device without it. I have received Casey's permission to
> work on upstreaming this patch.
>=20
> This is my first contribution to U-Boot, and I am unfamiliar with
> mailing list workflows, so please be patient :)
>=20
> Signed-off-by: Paul Sajna hello@paulsajna.com
>=20
> ---
> Changes in v2:
> - Add watchdog start
> - Add watchdog reset
> - Remove stop from the probe function
> - Use dev_err instead of printf
> - Update Casey's name
> - Add myself as an author
> -
> - Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb9=
3dff8@paulsajna.com
>=20
> ---
> Casey Connolly (1):
> watchdog: qcom: introduce qcom-wdt driver
>=20
> Paul Sajna (1):
> watchdog: qcom: improve driver with more functionality
>=20
> configs/qcom_defconfig | 2 +
> drivers/watchdog/Kconfig | 7 +++
> drivers/watchdog/Makefile | 1 +
> drivers/watchdog/qcom-wdt.c | 118 +++++++++++++++++++++++++++++++++++++++=
+++++
> 4 files changed, 128 insertions(+)
> ---
> base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
>=20
> Best regards,
> --
> Paul Sajna hello@paulsajna.com
