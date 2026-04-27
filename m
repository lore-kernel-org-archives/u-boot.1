Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E977DFF8865
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 06:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FCD80433;
	Mon, 27 Apr 2026 08:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iHEMIAgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3545383693; Mon, 27 Apr 2026 08:59:55 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9DA80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 19003418B7;
 Mon, 27 Apr 2026 06:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08437C2BCB4;
 Mon, 27 Apr 2026 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777273191;
 bh=d71TfqubBNvmtfu8Y9TnvT2sAfitYc7Kh8Wp/9a2pZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iHEMIAgZwu8LcGEguHo2o5jyrS9fDXgkV6A7VO52lmBabZ/UP8KBq59mxbJea8K9q
 INPJE3gjmPpJvN8aLp5Bo5XQmnPdM+NwAPf2n0okAAWldkMANPxt6Stthr3Bh7H0dt
 Wx+0bqLsZn/cwQ/XC58hpYv1xxN7YA61uDWJMJ4B5VwQTM50GgElMMapP9/hG7tNzb
 ZiyTrtSMJrWfQZ28L1+gAxgwE9vDc4YmA8k1AsoCi7JOxXCEWTCUhTyAnz6bi8zdbH
 cnaiGLbEb0vIzuxONv4PxOWOm8E1tlXl09IFTwk0sttDHjv8MVwAlpKideb1NtH/ga
 X/nhV6XCmBKbA==
Date: Mon, 27 Apr 2026 12:29:43 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, neil.armstrong@linaro.org,
 Ajit Singh <blfizzyy@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PULL] Please pull casey/qcom-main-13Apr2026
Message-ID: <ae8JX1O7PGJaFSX8@sumit-xelite>
References: <20260419030602.2470577-1-casey.connolly@linaro.org>
 <20260419154026.GV41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419154026.GV41863@bill-the-cat>
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

Hi Casey,

On Sun, Apr 19, 2026 at 09:40:26AM -0600, Tom Rini wrote:
> On Sun, Apr 19, 2026 at 05:03:16AM +0200, Casey Connolly wrote:
> 
> > Hi Tom,
> > 
> > Various Qualcomm additions this cycle:
> > * USB superspeed support for 1 platform
> > * Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
> > * Improved support for booting with OP-TEE on supported platforms
> > * Initial basic power domain support
> > 
> > Notably there is a generic change to the device core, missing power
> > domains will no longer cause a device to fail probe and instead will
> > just print a warning. This shouldn't affect any existing platforms.
> 
> Unfortunately I get a fail to build in CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/1428016
> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c: In function 'qmp_combo_com_init':
> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c:288:35: error: unused variable 'cfg' [-Werro
> r=unused-variable]
> +(qcm6490)   288 |         const struct qmp_phy_cfg *cfg = qmp->cfg;
> +(qcm6490)       |                                   ^~~
> +(qcm6490) cc1: all warnings being treated as errors
> +(qcm6490) make[4]: *** [scripts/Makefile.build:271: drivers/phy/qcom/phy-qcom-qmp-combo.o] E
> rror 1
> +(qcm6490) make[3]: *** [scripts/Makefile.build:492: drivers/phy/qcom] Error 2
> +(qcm6490) make[2]: *** [scripts/Makefile.build:492: drivers/phy] Error 2
> +(qcm6490) make[1]: *** [Makefile:2205: drivers] Error 2

Do you plan to re-send this PR with updated USB super speed patch-set
from Balaji here [1] which should take care of this CI issue?

Since the v2026.04-rc1 is going to be tagged today, we really don't want
to miss this merge window again for all these pending features to be
merged.

[1] https://lore.kernel.org/all/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/

-Sumit
