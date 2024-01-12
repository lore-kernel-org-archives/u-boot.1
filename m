Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407ACC4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA58B87937;
	Fri, 12 Jan 2024 14:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Msgyqxi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675B4879BD; Fri, 12 Jan 2024 14:19:22 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8C187937
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CDJDSb026671;
 Fri, 12 Jan 2024 07:19:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705065553;
 bh=nGqeO22nO/CbocrLKWsMGLSMLAMJo1US9jDm2FqHzhA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Msgyqxi7hb6bqJJXt6cUiQSIYYr91vB9qmpcta/+F0eDm4GIigiyVMiWpR767cSDx
 nc5HfaG99j10sxjgnHJINDcOeODXUK6wWYvXFpeKonHbj6CKCP87SRO0W+gyU9D2Ad
 3tAzh1bMY/lyl8KH9ehOmQyoKx6dnBaNYw1CgYlQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CDJDuu063525
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 07:19:13 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 07:19:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 07:19:13 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CDJDEe069423;
 Fri, 12 Jan 2024 07:19:13 -0600
Date: Fri, 12 Jan 2024 07:19:13 -0600
From: Nishanth Menon <nm@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, Martyn Welch <martyn.welch@collabora.com>, "Roger
 Quadros" <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Dave Gerlach
 <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20240112131913.s6tc7wqgvjmflxpy@lyrically>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
 <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 14:09-20240112, Sjoerd Simons wrote:
[...]

> > > diff --git a/configs/am62x_evm_a53_defconfig
> > > b/configs/am62x_evm_a53_defconfig
> > > index aa96c1b3125..f335eb11e63 100644
> > > --- a/configs/am62x_evm_a53_defconfig
> > > +++ b/configs/am62x_evm_a53_defconfig
> > 
> > Should we make the a53 also a defconfig fragment allowing reuse
> > across
> > multiple boards?
> 
> Pros and cons. having all the various options (USB boot, ETH boot, misc
> other) as fragments would allow easier re-use but make it more
> complicated for the end-user to get a "full-featured" u-boot. 
> 
> My personal preference, as i'm coming with a distribution background,
> is to always enable as much as possible in a default build to allow
> maximum flexibility for end-users; Those that need
> space/performance/whatever optimisation can always do custom builds.
> 
> It would be great if we could have a level of indirection here where by
> default a set of fragments get included such that it's invisible to the
> end-user that the underlying config is actually quite modular. But I
> don't think that's currently possible, hence preferring a fat defconfig
> such that the user/distro can just do `make am62x_evm_a53_defconfig`
> (and similar for beagleplay)
> 

I understand, but I am looking to reduce duplication between boards
and making it easier for new board devs to be able to pick the feature
group they need - almost all am62x users who desire dfu on a53 will
need the same options enabled. This also keeps the default u-boot foot
print lower to allow for emmc boot0 partition limitations if any (I
removed that dependency on beagle by using uda, but other platforms
still keep u-boot in emmc boot0 and depending on the part and TEE
binary size, the available space can be constraining)

I am starting to wonder if
https://lore.kernel.org/u-boot/20231101170519.39627-1-afd@ti.com/
will help us here.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
