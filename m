Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1093C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74DAB410A3;
	Fri, 31 Jul 2026 15:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P56C0OCuj5vF; Fri, 31 Jul 2026 15:11:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 918344104C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785510698;
	bh=sd2STsQHDX/MFw2d9pCljd7Z2V8QfhMcZnKziJ+cN/k=;
	h=To:From:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfq6k6PR7Vy8Pjp6ST9CD0W6MU3f85y7RwaNM/w4N2PNrn6EAwGObl/TxeWUVWlJu
	 k5V64agmEPPu5pITVIZAUhs9OCMwT9+kyVMVz1R1XiwKALJU1qqEuNIb0byJj/r2vM
	 ol8/V9Fp6cGWkTuIsP92KhVxiBm6SmupIhlAsM1TJpjoQTaViWOsfqQii12YiukWr/
	 rD5VPKHXBELnUhXagfXry5DLYuIfDqcXQ28wOlG9Q4yASiQFq0A6spNt1QF8MUnk/o
	 lWhyQM6NifK3QtkMIaLaqd78Us5QDpGUwtK8mSkUs5sYIYxG5f1EkK6VmvxRXK5RS7
	 2IJpG3IbXJBOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 918344104C;
	Fri, 31 Jul 2026 15:11:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 744BB27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E41F40F83;
 Fri, 31 Jul 2026 15:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QH1J-W7aLfgH; Fri, 31 Jul 2026 15:10:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=gcbu-u-boot-users@m.gmane-mx.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3458340F81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3458340F81
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3458340F81
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:10:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64EE84A0F; Fri, 31 Jul 2026 17:10:44 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B49849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 17:10:42 +0200 (CEST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wposj-0002ss-Ij
 for u-boot@lists.denx.de; Fri, 31 Jul 2026 17:10:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v3 07/12] rockchip: doc: add boot medium layout text
Date: Fri, 31 Jul 2026 11:10:32 -0400
Message-ID: <jwvjyqbfbi0.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <4d7b7705-62d6-4b61-840c-ef1dd28f9435@gmail.com>
 <b18b9a88-11f5-4d77-a29a-e341695240ff@kwiboo.se>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:qJIi6AsYykM3QLNFWaSwv8hNeaQ=
In-Reply-To: <b18b9a88-11f5-4d77-a29a-e341695240ff@kwiboo.se> (message from
 Jonas Karlman <jonas@kwiboo.se> on Fri, 31 Jul 2026 10:32:03 +0200)
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 15:11:36 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=m.gmane-mx.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Jonas Karlman [2026-07-31 10:32:03] wrote:
> On 7/30/2026 3:34 PM, Johan Jonker wrote:
>> +for data. It is not possible to place these blocks randomly.
>> +
>> +* eMMC/SD card:
>> +
>> +  Rockchip uses a unified GPT partition layout for it's open source products.
>> +  With this GPT partition layout U-Boot can be compatible with other components,
>> +  like miniloader, trusted-os, arm-trusted-firmware.
>> +
>> +  There are some documents about partitions in the link below.
>> +  https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions
>
> Please drop this entire 'unified GPT partition layout' section, it is
> not something we should encourage user to use. It is legacy and nothing
> in mainline U-Boot that depends on this layout.

At the very least we should distinguish what is technically needed from
what is some arbitrary convention that's been cargo-culted.

> For mainline a more appropriate layout would be to reserve initial 0-16
> MiB of boot media for partition table and firmware, and use remaining
> freely.

[ FWIW, I'm a big fan of having a partition to hold U-Boot, rather than
  hiding it in the first few unattributed blocks.  ]


=== Stefan

