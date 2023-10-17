Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A7CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8547286F25;
	Tue, 17 Oct 2023 21:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NH4CJbRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEDB86F26; Tue, 17 Oct 2023 21:22:21 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297A886F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 3F32A120004;
 Tue, 17 Oct 2023 22:22:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3F32A120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1697570538;
 bh=ZcYwkmTnvyCivN00HeKhDff5T3P/9DZ+LZaQw/EZsKQ=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=NH4CJbRy5IFOx9xdbKek+D14l5+oBZTHIK8h74PqTpCLMwM38edSu0NWB46zJEs/z
 k9JvfSi3SdjaaxFNjdRrook0SXPjkpTSlAjQlkAonegFNv4UJ8euWuZTFt7WnNuxle
 kAIzbj5EfkXpeWVagdpALUzWl+FB2ZNIWTl7OGhDeWujONTrXEIOfRD8xAmbx4c9GG
 pSsJWUOQKS0keiMSehJhVpQz/znZYgzjmd+36Q4c2ZDuI3Yo4JruWCUVEj7WKSlQUR
 I1kh04/yReGdjzsZlzXL1Sy5G905A7jq/QJ5JT1M81hwA307kcHNRDwXDbJ+BLamwD
 37/C/fQYJNgig==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Oct 2023 22:22:17 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 17 Oct
 2023 22:22:16 +0300
Date: Tue, 17 Oct 2023 22:22:15 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Simon Glass <sjg@chromium.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <prusovigor@gmail.com>,
 <kernel@sberdevices.ru>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/2] mtd: spinand: rework detect procedure for
 different READ_ID operation
Message-ID: <20231017192215.txwy7xkb3ax57yj6@pc>
References: <20231004150704.49945-1-ivprusov@salutedevices.com>
 <20231004150704.49945-2-ivprusov@salutedevices.com>
 <cd1bc5f7-b8b1-41ec-ac0e-849ef3eece73@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd1bc5f7-b8b1-41ec-ac0e-849ef3eece73@kontron.de>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180688 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540
 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1; 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; source.denx.de:7.1.1;
 patchwork.ozlabs.org:7.1.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/17 18:29:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/17 18:29:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/17 18:30:00 #22213411
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi Frieder,

On Mon, Oct 09, 2023 at 10:23:53AM +0200, Frieder Schrempf wrote:
> On 04.10.23 17:07, Igor Prusov wrote:
> > Adaptation of Linux commit f1541773af49.
> > 
> > Currently there are 3 different variants of read_id implementation:
> > 1. opcode only. Found in GD5FxGQ4xF.
> > 2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
> > 3. opcode + 1 dummy byte. Found in other currently supported chips.
> > 
> > Original implementation was for variant 1 and let detect function
> > of chips with variant 2 and 3 to ignore the first byte. This isn't
> > robust:
> > 
> > 1. For chips of variant 2, if SPI master doesn't keep MOSI low
> > during read, chip will get a random id offset, and the entire id
> > buffer will shift by that offset, causing detect failure.
> > 
> > 2. For chips of variant 1, if it happens to get a devid that equals
> > to manufacture id of variant 2 or 3 chips, it'll get incorrectly
> > detected.
> > 
> > This patch reworks detect procedure to address problems above. New
> > logic do detection for all variants separatedly, in 1-2-3 order.
> > Since all current detect methods do exactly the same id matching
> > procedure, unify them into core.c and remove detect method from
> > manufacture_ops.
> > 
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> 
> An adaptation of this patch was already sent long ago [1] and Dario also
> picked it up in nand-next [2]. Though it looks like this was never
> merged upstream as there wasn't any pull request sent to Tom, right?

Thanks for pointing this out, looks like this rework made it to
upstream, so I'll drop it in v2.

> Dario, as you already seem to have rebased nand-next recently, can you
> please sent the changes to Tom for picking them up? As the merge window
> is open at the moment it would be good to get it done soon. Thanks!
> 
> [1]
> https://patchwork.ozlabs.org/project/uboot/patch/20230110115843.391630-1-frieder@fris.de/
> [2]
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-next/

-- 
Best Regards,
Igor Prusov
