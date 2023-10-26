Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521EBC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBBB87BE8;
	Fri, 27 Oct 2023 03:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698371071;
	bh=HNEGoFs2DjYAwRLTK5OD57nZTm5dobgCOzqeloYKE/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LV9IIhj/rafNF5XHcO4SKzge00VxfYLbnE0GwkgWkCeY//h6ookc8hZkg2ung3wve
	 N2KU+T7qONAxbRiI4S+Ga6PpgX8fvmmbGBioo1DfT3NSmo8LaqbtWzzkV6lLg3TTlZ
	 eiTOCXD45YhpahpHj7mqvo/4KblQhFXznzxHKCCMvicnLfQUol7++KebtEEeANGoSx
	 f/adUHoVC4vTo+AwgEaD65UHvliyAj8+/eN/Yn0zGzN6gCbtKu1G1gRcTG/9/nOw62
	 j8Na1+qMeaEDLnWC33wb+cj5dkXK3sfsJYTPwBg9bjKj/pZlZL6CbATIooKUWJjT55
	 3cRJ6MWFlTcLA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 735E98704D;
 Fri, 27 Oct 2023 03:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698371054;
 bh=HNEGoFs2DjYAwRLTK5OD57nZTm5dobgCOzqeloYKE/k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MEWO/L+Aj3MYSsQU0MccMYuP6xQqL/jNT4A6zXFMbEMLPPVdYNLpXfcMki+guLork
 cdsd+ySVFneW52+3Xy7BJMxcRW5bT+WdYv/qzONySWayF7EPCtQczbttRmpqtm/5UO
 8LgL7pfsmGNVhomfSryZRIrkodZR6rZL/Ullg+TMnYFc1ofHJk+GQIPWneviyTR7bF
 Tm1j0KKDiW2ZTZceqhjryp2DZ/VqhHkszBkyOAktHowKz1TExPGGM33BdydEAKJa85
 EID0plLTJrt4dT5yZsbiv5a48cPUXFpOjbHmI7N1m5I3U/KHEMTR+bqKOgPwiax44Z
 LZXq//7FdqqaQ==
Message-ID: <1001e11f-71e5-4418-8d65-4e9857a08539@denx.de>
Date: Thu, 26 Oct 2023 08:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: rzg2_beacon: Disable the ability to remove
 devices
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com
References: <20231025231311.8701-1-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231025231311.8701-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/26/23 01:13, Adam Ford wrote:
> In order to save some space, disable the ability to dynamically
> remove devices.  Without this, U-Boot is too large to load without
> recompiling TF-A.

Did you enable LTO yet ?

Striping DM_REMOVE seems like a really bad idea, doesn't that break 'usb 
reset' and its removal of devices ?
