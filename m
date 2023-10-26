Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1C1C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AE687B70;
	Thu, 26 Oct 2023 14:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inside-m2m.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inside-m2m.de header.i=@inside-m2m.de header.b="IQlVUGtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DF087B5B; Thu, 26 Oct 2023 14:51:58 +0200 (CEST)
Received: from mail.inside-m2m.de (mail.inside-m2m.de [188.68.57.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB2F87B5B
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=inside-m2m.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=konstantin.kletschke@inside-m2m.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=inside-m2m.de;
 s=default; t=1698324683;
 bh=dDX4DG9VTuz6tIG5gR/Ivi5sis9GNjesX+7LQfubUUc=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=IQlVUGtuvwGeTzpPeghZ555NN88SSaZaUXisURq4TxztK3rgktFYlLP2UEAf/uUyr
 V8qOms2V8wN492xogNzXACCau+dnjo15YjXzXOYZYMRUIhrYYnttdGVsO/unaLXjxC
 ocOnXDBQ++9E3GRkXSMO9jwOWYAOgJtcIWDV2+Wjcnb7nYd12vYlmrCSUXk3dmdjCB
 wICKKWCo581w53ZaosrLFxScOEeH4Y6tFaqiDMDuxiO2FNu1mVyd/8IUmvyNoFcD2A
 N7/999Cxuu9s0PAn6aUxPe6R3NkTw1qO/QpiXSUXe7a7/fUd/i5ynWd5HI8FELCVDN
 NVOx73JiV0iIw==
Received: from hephaistos.inside-m2m.de
 (business-90-187-159-109.pool2.vodafone-ip.de [90.187.159.109])
 (Authenticated sender: konstantin.kletschke@inside-m2m.de)
 by mail.inside-m2m.de (Postfix) with ESMTPSA id CA761400D4
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:51:22 +0200 (CEST)
Date: Thu, 26 Oct 2023 14:51:21 +0200
From: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>
To: u-boot@lists.denx.de
Subject: Re: Starting kernel invokes "Synchronous Abort" - rk3328
Message-ID: <ZTpgyfWRSzV2pApC@hephaistos.inside-m2m.de>
References: <ZTpefOD0SYF_lkO_@hephaistos.inside-m2m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpefOD0SYF_lkO_@hephaistos.inside-m2m.de>
X-Mailman-Approved-At: Thu, 26 Oct 2023 14:56:48 +0200
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

Sorry, I pasted not the Dusun u-boot reloactaion address excerpt:

On Thu, Oct 26, 2023 at 02:41:35PM +0200, Konstantin Kletschke wrote:

> The Dusun u-boot says:

Model: Rockchip RK3328 EVB
PreSerial: 2
DRAM:  2 GiB
Sysmem: init
Relocation Offset is: 7dbed000
Using default environment


-- 
INSIDE M2M GmbH
Konstantin Kletschke
Berenbosteler Strasse 76 B
30823 Garbsen

Telefon: +49 (0) 5137 90950136
Mobil: +49 (0) 151 15256238
Fax: +49 (0) 5137 9095010

konstantin.kletschke@inside-m2m.de
http://www.inside-m2m.de 

Gesch"aftsf"uhrung: Michael Emmert, Derek Uhlig
HRB: 111204, AG Hannover

