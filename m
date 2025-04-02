Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7BDC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 10:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F9780FDA;
	Wed,  2 Apr 2025 12:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gCF1wiZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6EC81CF0; Wed,  2 Apr 2025 12:30:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B2080584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 12:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 532AUAD53927873
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Apr 2025 05:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743589810;
 bh=FO4io3ZllU9rkFIWAC0LIjQSkgzj/lT0ofe0Ols/1wQ=;
 h=Date:To:CC:Subject:From:References:In-Reply-To;
 b=gCF1wiZAhk5VgnzTsMOP3rWycHqWqVzL6LxSi9M9kurvqAJISzrogqNRQKkBqVjq4
 rIQwPw/lYECZzDfHykJavjGqeNf/z6ZfBPziXnBEnoQAUQP4QUadxe2dx36e4q+0Rc
 ocp7KBZx6QYF8U+XAynigv4motAJzRwwrMO2ierc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 532AUAg1010746
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 2 Apr 2025 05:30:10 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Apr 2025 05:30:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Apr 2025 05:30:10 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 532AU9rA078751;
 Wed, 2 Apr 2025 05:30:10 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 2 Apr 2025 16:00:01 +0530
Message-ID: <D8W300ZGJI6M.1COATVFQ1OTPT@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250314035505.4029331-1-anshuld@ti.com>
 <20250331230301.GA30101@bill-the-cat>
In-Reply-To: <20250331230301.GA30101@bill-the-cat>
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

On Tue Apr 1, 2025 at 4:33 AM IST, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 09:25:04AM +0530, Anshul Dalal wrote:
>
>> Using CMD_* configs from spl doesn't make logical sense. Therefore this
>> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
>> SPL_HAS_BOOT[IZ].
>>=20
>> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
>> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
>> ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> OK, so this needs to be introducing some library symbol which then both
> CMD_BOOTx and SPL_...something select.

I was thinking of chaning the Makefile with the following diff:

-obj-$(CONFIG_CMD_BOOTI) +=3D bootm.o image.o
+obj-$(CONFIG_LIB_BOOTI) +=3D image.o
 obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
-obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
+obj-$(CONFIG_LIB_BOOTZ) +=3D zimage.o
 else
 obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
-obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
-obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
 obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt.o
 endif

This would simplify the Makefile by not having duplicated configs for
image/zimage and the removed bootm.o for non-spl builds should be fine
since except for colibri_vf, all defconfigs with CMD_BOOTx already have
CMD_BOOTM enabled. And for colibri_vf, we can safely enable CMD_BOOTM?


> What we have here introduces
> failure to build on some imx8 platforms such as=20
> mx8mp_evk and then size growth on others such as imx28_xea.

The imx8mp_evk build should not fail since the patch should only effect
falcon mode. Only difference this patch makes is now image.o would not
be compiled for the spl which is not used in non falcon boot anyways.

For the imx28_xea and 3 other (imx6qdl_icore_mipi|mmc|rqs) defconfigs
that use falcon mode but don't make use of CMD_BOOTx. Their size growth
is expected since SPL_HAS_BOOTx is default y in falcon boot. To keep the
same size, the SPL_HAS_BOOTx can be explicitly disabled for those 4
configs.

For future reference is there any CI tests I can run to detect any
regressions before posting patches upstream?

Regards,
Anshul
