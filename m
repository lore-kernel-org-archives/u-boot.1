Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29501C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 04:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6833D83297;
	Thu, 17 Jul 2025 06:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qltE4bN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E32A8329B; Thu, 17 Jul 2025 06:17:54 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEF383287
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 06:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56H4HlNW397360;
 Wed, 16 Jul 2025 23:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752725868;
 bh=0mqQVQqWdno2Da7XYXnL7rCXqdLT384zHktM1Ijb2Jk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qltE4bN5BVWl2MUOXZz6kfA9p8qlXq5OPGhzsMQaRRL7vm0+UcDHsqJzNebcsiNxV
 36OpaoxYFYkvFBBsTWwx4U6o97nbFEb3TFzfARV75I/28ZwJNkWbV2RdSW5GOdB9t8
 SvtcWjgB6HpD+fHuiv33nb8Zd4JVHhRhR+Z4R7+U=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56H4HlfJ1921488
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 23:17:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 23:17:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 23:17:47 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56H4Hk3N1223708;
 Wed, 16 Jul 2025 23:17:46 -0500
Date: Thu, 17 Jul 2025 09:47:45 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: Bryan Brattlof <bb@ti.com>, <trini@konsulko.com>,
 <rayagonda.kokatanur@broadcom.com>, <casey.connolly@linaro.org>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <j-keerthy@ti.com>
Subject: Re: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
Message-ID: <20250717041745.bcxjwlkg7y3yjojm@uda0497581-HP>
References: <20250710095922.144361-1-g-praveen@ti.com>
 <20250710141718.fx7cqeh2f2eibwkm@bryanbrattlof.com>
 <51e00bdb-374a-4e35-a230-58427aeaead7@ti.com>
 <20250711121741.jyo6gonfhoswbxvb@bryanbrattlof.com>
 <8b8a0e73-39e5-436e-8458-9bc511daa880@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b8a0e73-39e5-436e-8458-9bc511daa880@ti.com>
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

Hi Gokul,

On 18:17-20250716, Gokul Praveen wrote:
> Hi Bryan,
> 
> On 11/07/25 17:47, Bryan Brattlof wrote:
> > On July 11, 2025 thus sayeth Gokul Praveen:
> > > Hi Bryan,
> > > 
> > > On 10/07/25 19:47, Bryan Brattlof wrote:
> > > > On July 10, 2025 thus sayeth Gokul:
> > > > > From: Gokul Praveen <g-praveen@ti.com>
> > > > > 
> > > > > KASLR, or Kernel Address Space Layout Randomization, is a security
> > > > > feature in the Linux kernel that randomizes the memory location
> > > > > where the kernel is loaded during boot.
> > > > > 
> > > > > OP-TEE RNG is a Random Number Generator (RNG) component within the
> > > > > Open Portable Trusted Execution Environment (OP-TEE) which provides
> > > > > a random number to U-BOOT and U-BOOT provides this random number
> > > > > as seed value to the LINUX kernel for KASLR.
> > > > > 
> > > > > Add KASLR OPTEE RNG support across K3 devices by enabling the required
> > > > > configs.
> > > > > 
> > > > > Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> > > > > ---
> > > > > v2<==> v1
> > > > > ===========
> > > > > * Added 'if' condition for configs to avoid enabling this feature
> > > > >     in R5.
> > > > 
> > > > Works for me.
> > > > 
> > > > Reviewed-by: Bryan Brattlof <bb@ti.com>
> > > > 
> > > > > 
> > > > > Boot logs Link :
> > > > > 
> > > > > https://gist.github.com/GokulPraveen2001/44aa8c0962438c12ffc55e6ed67742e5
> > > > 
> > > > Just curious are you enabling the kaslrseed command for this build? It
> > > > looks like you're using TI's evil vendor scripts but I assumed the
> > > > kaslrseed command was disabled.
> > > 
> > > Can you elaborate more on this,Bryan?
> > > 
> > > Actually, we are not using the kaslrseed device tree property. Is that what
> > > you meant,Bryan?
> > 
> > Everything in this boot log is tagged as dirty. So I'm just trying to
> > ensure I've got everything setup correctly.
> > 
> > I was curious what you are doing to generate the line:
> > 
> >     KASLR SEED OPTEE SET SUCCESSFULLY
> > 
> > before we jump to the kernel.
> 
> I have also updated the boot logs in the gist link provided to the one
> without debug prints and without the dirty tag as well, Bryan.
> 

Thanks for the update, giving my r-by again as well as I think you did
some changes.

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> Regards
> Gokul
