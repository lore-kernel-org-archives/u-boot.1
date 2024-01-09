Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428EC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B561887884;
	Tue,  9 Jan 2024 13:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zoho.com header.i=lukasz.wojcik@zoho.com header.b="JtGCLYnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4686F8783F; Tue,  9 Jan 2024 09:59:29 +0100 (CET)
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com
 [136.143.184.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0898F87864
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.wojcik@zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1704790764; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j6jWi4jw1dN7xa+NOztFg2rd3VLRHKWngVrpHB0dGRmi4mwIG3/6WM8B7L6BCARwKhtr7Sx88lDHO8jlteRS3axsdnDIWIBXJBC1nZV3843Annl+tyw0iytzCO0+KT67u7e5qm9wMxQvhat4C7Y1V+axai9S3e0cDVCIEK8IelE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1704790764;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=anwoSVBaOLUmm6YXuE7j/ux7fon1cLmqlUX8E2O+CRI=; 
 b=creVHYrLY5k1r0kSSk9G/39GwK3ABPVMEiNU07oajIW7B7cTfrzwa/GItLVJtxRYmgoYcc/Vaa88AFoTVAqAC+bkx45lnm8d9zJRFn2t2tJT70txyLlbORt6OqvdliTknpI+1esdLvtIfCFp6ZC6KQJC7uw0sr9g5t8xmnZuSKI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=lukasz.wojcik@zoho.com;
 dmarc=pass header.from=<lukasz.wojcik@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704790764; 
 s=zm2022; d=zoho.com; i=lukasz.wojcik@zoho.com;
 h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=anwoSVBaOLUmm6YXuE7j/ux7fon1cLmqlUX8E2O+CRI=;
 b=JtGCLYnSbBTZMCTBxx/HgPeqKYYLZUE8Tp3y6DMX5M7+IuvcT4HuU8WkJ380/CRh
 iQCjzeO0ANeo6i7aWwHfoEOnxMNn2jEgqGfGeOMdKNGIazAEMEl7+/AKJN0pdQmSsnt
 Ksi/5zf5bYKD+dowjgrHPJqInvfuy2ejJOIGjyrc=
Received: from [192.168.1.28] (31.131.174.165 [31.131.174.165]) by
 mx.zohomail.com with SMTPS id 1704790763684949.1154581109571;
 Tue, 9 Jan 2024 00:59:23 -0800 (PST)
Message-ID: <4d7979ed-f0c2-4f0a-8a87-df4be96ee705@zoho.com>
Date: Tue, 9 Jan 2024 09:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: =?UTF-8?B?xYF1a2FzeiBXw7NqY2lr?= <lukasz.wojcik@zoho.com>
Subject: Reviving bricked device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 09 Jan 2024 13:21:09 +0100
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

Hi there,


Good day to you guys in new year. I am seeking advice on 'reviving' 
bricked device. I have recently bricked my customer's device that is 
running their own version of Uboot. Something went wrong during update. 
I already have a working version of a binary. Uboot lies in NOR flash 
chip, and the layout is as follows:

uboot        0x00000000 - 0x000dffff (size 0x000e0000, 896KB)
shmoo        0x000e0000 - 0x000effff (size 0x00010000, 64KB)
uboot-env    0x000f0000 - 0x000fffff (size 0x00010000, 64KB)


I'm not an Uboot expert, but I think 'u-boot.bin' contains environment 
variables as well (or so it seems scanning it using 'strings'). How 
should I program the chip so that it layout after the programming 
conforms to the above memory map ?


Programming the 'executable' seems easy enough, I just put it at the 
address 0x0, but how do I program environment variables at 0xf0000 ? Or 
is this portion only for new environment variables ?


I would appreciate any sort of clues and suggestions,


Best regards,

-ŁW


