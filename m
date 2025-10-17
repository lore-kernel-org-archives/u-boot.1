Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4E5CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 03:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8B583775;
	Fri, 17 Oct 2025 05:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l8MkcQ9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD26837E2; Fri, 17 Oct 2025 05:59:06 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC07A836C1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 05:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H3x0Rl174314;
 Thu, 16 Oct 2025 22:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760673540;
 bh=ksviL59Ada78ERwC6Jh83g+wUENdNYj0B8BGS8iZi9g=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=l8MkcQ9vQlffy7mFtMe+V4nlh+IpUzJ31QziPeZehxZU0YigCPuLMTeM2wKJVoKcT
 HXzgsTnoQ0f5WngnCEpx/Vo20axZj94pjnkqWqT50JUXCQ760U2bceatup08GfJVrh
 2TU0a+DtPj4w4XmE6emNEhT+Urre4qOSbn9dfaYI=
Received: from DFLE209.ent.ti.com (dfle209.ent.ti.com [10.64.6.67])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H3x0sB2103730
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Oct 2025 22:59:00 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 22:59:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 22:59:00 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H3wx0T646887;
 Thu, 16 Oct 2025 22:59:00 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Oct 2025 09:28:58 +0530
Message-ID: <DDKAOHK5MOPF.26P0O31MCY1DV@ti.com>
CC: <vigneshr@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, 
 <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: Re: [PATCH v1] env: Kconfig: disable external env in secure os boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251009123435.960225-1-anshuld@ti.com>
 <176065245424.262817.8921064566527287297.b4-ty@konsulko.com>
In-Reply-To: <176065245424.262817.8921064566527287297.b4-ty@konsulko.com>
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

On Fri Oct 17, 2025 at 3:37 AM IST, Tom Rini wrote:
> On Thu, 09 Oct 2025 18:04:34 +0530, Anshul Dalal wrote:
>
>> Falcon mode uses falcon_image_file from the env during mmc fs boot, but
>> external env can be compromised. Therefore disable access to external
>> env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.
>>=20
>>=20
>
> Applied to u-boot/master, thanks!
>
> [1/1] env: Kconfig: disable external env in secure os boot
>       commit: 1e470ddd0743bbd1f229421e11e9ad2093f7fd20

Hi Tom,

Unfortunately the patch this depends on[1] has not been merged yet.
Essentially as master stands now, we are disabling env based on
SPL_OS_BOOT_SECURE even though that config isn't defined anywhere.

I'm working on addressing your comments[2] on my last series disabling
fallback in falcon mode and will duly post a revision, in the meantime
could we just merge the [1/7] of that series and I'll remove it form the
rest of the series in the revision?

[1]:
  [PATCH -next v3 1/7] spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol:
   - https://lore.kernel.org/u-boot/20251006101057.4172248-2-anshuld@ti.com=
/
[2]: https://lore.kernel.org/u-boot/20251015195943.GA710760@bill-the-cat/

Regards,
Anshul
