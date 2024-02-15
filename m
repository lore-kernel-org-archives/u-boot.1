Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1634C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297A087DA7;
	Thu, 15 Feb 2024 18:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="JGFeysTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD64287D80; Thu, 15 Feb 2024 18:00:12 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2261B87DFD
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 18:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1708016404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtEi9jeXzT5ZJs2U3tQ0rjCer5QIVTr2H7pfbnc6tmg=;
 b=JGFeysTloioq47il8WALQlUms6PIdwu7vl2FgTAVrZso20FhNadYVeh2Di/gXS5X3uG80S
 yWl0x4IIx20SHpUwOYAlCOl7+NamA0+Wu4g+urAaWS/P6UzFUnpaVodMdG+bMQbeyg4lHb
 Fr8Pdb+gd7NXBVUGiUcI0cIaSplMaUnVX38ZYr1184UjhN3qy5qfvGGFlzkVfTbXGjbiAl
 RT9HVHGBhcKrCiecB+2k0ZFQfcRELgC1ixxVrZ+rw1LfeadctFGW7PwVDGSTfxa95bLKrK
 3r9N10jV6QCqZMQltjy4Cha2uCBGe7ZbG7WCi0Ne3921ebn70f1vejvQl4j9RQ==
Date: Thu, 15 Feb 2024 18:00:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Frieder Schrempf
 <frieder@fris.de>, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Bruce Suen <bruce_suen@163.com>, Dhruva
 Gole <d-gole@ti.com>, Jim Liu <jim.t90615@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Neal Frager <neal.frager@amd.com>, Nishanth Menon
 <nm@ti.com>, Ricardo Pardini <ricardo@pardini.net>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
In-Reply-To: <dd662626-279e-4a71-b964-1553cb27c7ff@kontron.de>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215165054.4ddc8846@donnerap.manchester.arm.com>
 <dd662626-279e-4a71-b964-1553cb27c7ff@kontron.de>
Message-ID: <ff8065162ff216ab43b14c2b6db24853@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Frieder,

On 2024-02-15 17:56, Frieder Schrempf wrote:
> On 15.02.24 17:50, Andre Przywara wrote:
>> On Thu, 15 Feb 2024 14:35:19 +0100
>> Frieder Schrempf <frieder@fris.de> wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> 
>>> The datasheet can be found here:
>>> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
>>> 
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>>> ---
>>> Changes in v3:
>>> * none
>> 
>> Why do you resend then? Also v4 seems unchanged? Did you adjust the 
>> people
>> in CC:? If you want to notify more people, please just reply to your 
>> own
>> patch.
> 
> This is part of a patch series and there are changes in other patches
> within the series. The usual workflow is to send the whole series again
> even if not all patches changed. At least that's what I've always been
> doing and so far no one complained. If there's a better way, please let
> me know.

Perhaps having a cover letter would make it easier to see what
changed in each version of the series.  Just my two cents.
