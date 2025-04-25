Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3AFC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 09:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E0C181F45;
	Fri, 25 Apr 2025 11:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IGFWUCnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB56881F4D; Fri, 25 Apr 2025 11:50:03 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1245681F0D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53P9nhD52141389
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 04:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745574583;
 bh=nkco9AoI+8Ek0BI85mzxxM6shu2UsgF2e4sXiZ4Z3Ko=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IGFWUCnvbvlToxatM6kqLHV4EqNgv9Llw/A5zL9F5aTOuQAskYhJtsoF36lrBDMqe
 HUb61oCz4CCdHsKNNZzjPfu4bC6/2KwzeZge3pjhULKnpgX1jld9EIXWMQDX6aeXJC
 +4SZPCUAR2Rhh84lLr7yN4+vE2Hk5067Mhp50dik=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53P9nhcg056777
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 04:49:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 04:49:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 04:49:43 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53P9neEQ111756;
 Fri, 25 Apr 2025 04:49:40 -0500
Message-ID: <e6857778-a543-4aff-83d2-1b91eb21bdf2@ti.com>
Date: Fri, 25 Apr 2025 15:19:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power-domain: Add support for refcounting (again)
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>,
 Samuel Holland <samuel.holland@sifive.com>, Wadim Egorov
 <w.egorov@phytec.de>, Heiko Schocher <hs@denx.de>, Fabio Estevam
 <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Miquel

On 25/04/25 12:19, Miquel Raynal wrote:
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
> 
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
> 
> Some drivers implement their own mechanism for that, but it is probably
> best to add this feature in the uclass and share the common code across
> drivers. In order to avoid breaking existing drivers, refcounting is
> only enabled if the number of subdomains a device node supports is
> explicitly set in the probe function. ->xlate() callbacks will return
> the power domain ID which is then being used as the array index to reach
> the correct refcounter.
> 
> As we do not want to break existing users while stile getting
> interesting error codes, the implementation is split between:
> - a low-level helper reporting error codes if the requested transition
>   could not be operated,
> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>   EBUSY.
> 
> CI tests using power domains are slightly updated to make sure the count
> of on/off calls is even and the results match what we *now* expect. They
> are also extended to test the low-level functions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/sandbox/include/asm/power-domain.h          |  2 +
>  drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
>  drivers/power/domain/power-domain-uclass.c       | 90 ++++++++++++++++++++++--
>  drivers/power/domain/sandbox-power-domain-test.c | 15 ++++
>  drivers/power/domain/sandbox-power-domain.c      |  4 ++
>  include/power-domain.h                           | 69 +++++++++++++++---
>  test/dm/power-domain.c                           | 11 ++-
>  7 files changed, 177 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/sandbox/include/asm/power-domain.h b/arch/sandbox/include/asm/power-domain.h
> index 4d5e861dbce2b6434ac9bcffe5fc8f704d32e62d..3b0717f8fa06f1c0493fe6ee758e2e72ff77141e 100644
> --- a/arch/sandbox/include/asm/power-domain.h
> +++ b/arch/sandbox/include/asm/power-domain.h
> @@ -13,6 +13,8 @@ int sandbox_power_domain_query(struct udevice *dev, unsigned long id);
>  int sandbox_power_domain_test_get(struct udevice *dev);
>  int sandbox_power_domain_test_on(struct udevice *dev);
>  int sandbox_power_domain_test_off(struct udevice *dev);
> +int sandbox_power_domain_test_on_ll(struct udevice *dev);
> +int sandbox_power_domain_test_off_ll(struct udevice *dev);
>  int sandbox_power_domain_test_free(struct udevice *dev);
>  
>  #endif
> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> index 96c2922b067e2886b3fa963bcd7e396f4569a569..9f253b0fd40f703a5ec11d34c197423d27ad8b01 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> @@ -163,4 +163,5 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
>  	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
>  	.remove = sandbox_scmi_devices_remove,
>  	.probe = sandbox_scmi_devices_probe,
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
[...]

Thanks for working on this quickly, I've booted it on j784s4-evm and
works fine! And I am good with this approach using subdomains.

Tested-by: Neha Malcom Francis <n-francis@ti.com>
(on j784s4-evm)

-- 
Thanking You
Neha Malcom Francis
