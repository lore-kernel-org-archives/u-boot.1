Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED8CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 11:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E9186E77;
	Fri, 13 Oct 2023 13:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697196989;
	bh=fGNeTr8TpjuRikZRaiAKPfEvw9EK5MIg3j5srS6bkUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XfZL7RrnRq4Z7kM7BYCcn/6EFIW8JtdtPBv/+NrZDU+5lA95qeeYzWljCz01jVQfl
	 6yoHHjQp8BfCISY1VFeOq2Pcvk9SoUqs24uPZpio9JkCmBGA/N3hglShJ+d+pZs9Ry
	 fFm98GnMs2yWOzcrWVdqf6POKjCq/1k288+kqhnEfs+0GcxFsEVYgFy+iwMIerkNzR
	 cGOwuPOb6bt+k7c1kkXACLUdeeV/6m0jqtkuXBakEUhaO7Kprv+kuDJttDmq5AtEdC
	 TvTmRwlCFnw74SBCQQHDTbG9tofGPNPHsthMEY4VKEnO0rgOPVZGauyjLnzIa4xr4U
	 IIJRuKUEqot+Q==
Received: from eryximachos.home (unknown
 [IPv6:2a01:cb18:989:a700:7e7a:91ff:feeb:a1bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7CCBB86E73;
 Fri, 13 Oct 2023 13:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697196988;
 bh=fGNeTr8TpjuRikZRaiAKPfEvw9EK5MIg3j5srS6bkUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rj2wCLSecSSHMU05nE+x/QQMgUYKBvYmj6M94tK1Qs+RPn2rh7IVDHD6mwJdCBB4m
 4jCNB4ls+dEMUxzrp9lMw0/5vLyLJRUwSkmsb3IVqPmU74Fslc/0I9gNrvwekYxRoh
 j7pfepkCBIifSdf1l0gIpRjKVstccTrBqULG2BDr8InfdLyIKLWV+SeOCZWpEi+LFS
 sKcCrbvscPk6AHofXvaV9qQjx4ZM7XGDMr+Bht/1POwzQyJ89nIoHwM88EV40TWHPz
 R2+YNj6L8GCvaGbMMxT1zNblTD2ycRxJ3+1va+dc2WEYD1tAOk7gsj7SZGMPLGD1Yz
 lJXABu4zNHXsg==
Date: Fri, 13 Oct 2023 13:35:00 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH 1/2] bootcount: Remove legacy I2C driver
Message-ID: <ZSkrZIwVLeLe3S8Q@eryximachos.home>
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-2-pro@denx.de>
 <bf6e57d4-2dd7-5515-6ba0-c7e49447a579@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6e57d4-2dd7-5515-6ba0-c7e49447a579@denx.de>
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

Hi Heiko,

Thank you for reviewing.

On Fri, Oct 13, 2023 at 01:21:41PM +0200, Heiko Schocher wrote:
> [...]
>
> Hmm.. I find some boards in mainline which still use this driver:
> 
> u-boot  [master] $ grep -lr BOOTCOUNT_I2C .
> ./configs/sandbox_defconfig
> ./configs/mx53ppd_defconfig
> ./configs/ge_bx50v3_defconfig
> [...]
> 
> So your remove patch will break them ... okay sandbox should be
> easy to convert to your DM approach patch from this series.
> 


$ git grep -r BOOTCOUNT_I2C
configs/ge_bx50v3_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
configs/mx53ppd_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
configs/sandbox_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y

Those boards use CONFIG_DM_BOOTCOUNT_I2C_EEPROM, which is not touched by
this removal, is it?

Best regards,
Philip


> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
