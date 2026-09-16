Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B953C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 08:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1393607C1;
	Wed, 16 Sep 2026 08:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9EPmAaF0DaV; Wed, 16 Sep 2026 08:55:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 85E0F607CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789548922;
	b=UXbIfCqcG8u5QE1GFkAy6hbmtytc42a9zadyhsG/tPSAXF4NT0EIK368wBiwIqaaOrRi
	 qRM33TJdMF5Q3i139cMlKIejYPTB8d7D8YBPZ30uBmr+QFl/qJcNV33e43sZQokNcT5eQ
	 QZS6V+LuFJO7MZ47rvVhsWXGuaKhb/JrB3ZT+nqDWCEz4y2glqaCzhpA0DEbMw/JH2ZqZ
	 Gh8Cf6YpjzsD7/X79KPtPOBH99RxZOuK/zbcb72MgyGWwx5FysW65yTJjGLboqd6byYHb
	 4zx0Cuu03nSQWTDvuJQRkpwy4MtC8w2WxxvIXqKC+SJrSLC9df8WqpJly2ELnoBmctA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789548922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wly5gm7PhjrzZj+hbzwzPTsClTSzCy9nR1s6XumRcsw=;
	b=Mm79C7CvE3WYDPaak/JEk2d1xtSwaJfiFrZsJIwf9/+IecjtgZG61R20HQ0m5u0OvlyG
	 wIz+cToF+CHa7mbq5XH6Qzog8cxRPTOFsBI6+NdxjCEexZo67cncTEBjxWBVFPxtdP554
	 vysO+5nIY1kRRVqPPZh+s055kqq6gPf1Ut7Sau+Dcr+MnbtLes/KfsS0GSTknZrFQ0SQv
	 0Dx8EyZg9DjsIsecono/5qonX3pYx1vGjPX8/WdQjzid4yplwL07VwCaLNaH+tk/YOXPL
	 eRcADEWIUd7jc2y5E4vfJrpH9aUNWhr/bGnnUf7gPoskmpiZq/SSeLh92Tq3MMA7+UA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789548922;
	bh=Wly5gm7PhjrzZj+hbzwzPTsClTSzCy9nR1s6XumRcsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qN19P5DuJFJ5YERrF2SMxp8lKCf3kao4cHo94p3rTmstuLFx7Hf+/ehQUOk41cnrX
	 TenigtAN2cckgPlJeWACaYgPby1dblEEvhibXPuqAkIhfxvhA9SpBtLGMrhMEtsjjZ
	 iKuZIBKMwfqRc9ZEsz0NuYWZY4Hnijyb1LjGPeYbDND39flEsuTk/FQOTyrBQ1f3Hd
	 XhcJ9nE8tdaEaxXF1eKDHMQfe4u0KcRNA/JhUBbfN9Ir/eHkgaj8TkB2BtYgHXikXX
	 SWFpOOtfz69IHT+TPbRepAzndq1Th3k8K/i4bvKYq65V1JNavlZivGvcdOhQXCgaFF
	 g26Xds476OR9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85E0F607CE;
	Wed, 16 Sep 2026 08:55:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4294C279
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 282244026E
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybc91b6ilzWT for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 08:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CC27D4016D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789548919;
 b=S1gC0xO9+rxu2JGFBvyj+WB21Hi/0iP4BBpl9ynxmqlHlEXPjslfcVRIYDYMXwN6i8dL
 8v0i8SqQZ/fnGlBfE3LsEKgGjG23AxEBEHdk6xdgiPy6GIThluMtCN8ZoDtgGqFNo/u8d
 V3wfLGv+zJq7NFyQo8Xs8uYZNfvV5TfHbhpnYa4imV2zAbBlLy+BOM8yDLgYK46suClXa
 qZ1su+mLDx1Ut0AEKAMCrObBFyYouU7zPit+Lhw37HHxxuLsjdCpOT5sWc8q2zAIgo9vV
 +II0skgBnqa3FtEv5QMz/zdGEh5rvb3swIQXVNbvza5vNMEy7B71Bv4RO99iMCWpJhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789548919;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Wly5gm7PhjrzZj+hbzwzPTsClTSzCy9nR1s6XumRcsw=;
 b=Dntg5btKq/09ZNqecTTuSnPONmnIlNl0/xesfQRry060uyBSPBv7EYL7sGclEerBXr3e
 LpdZcrL/HmZRPkfS+WWC4dUvx6sLs90rlOYdjfQOypeGd+emjojoIKQQpe7lC6gFG515t
 hM3ZEZ9xwMeRLzuqgHRKfuVc0Bkzerndm6CYvRiO56gfHIP0SRx3yRyaZapveS0Q1s5sv
 SCFWNRefpfJI5rS0YITxtAgnDfPyjzjQ1JemDv753OMs0XTSdd+1EGxhopeyLYnExmg6m
 Pn2VEuYn4speBJ/CAjOhwHMBEFxd2CaooCYsts5f02CaTpyQhevH68UGQBmUMpvMFqA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=BEP1i0ey; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=BEP1i0ey
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC27D4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:55:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 647AD4E40703;
 Wed, 16 Sep 2026 08:55:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2F8ED60337;
 Wed, 16 Sep 2026 08:55:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 312E411C7AFE2; 
 Wed, 16 Sep 2026 10:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789548914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Wly5gm7PhjrzZj+hbzwzPTsClTSzCy9nR1s6XumRcsw=;
 b=BEP1i0eyecC9Zp1I2XnYe6591UpbUeWPb/Kj9sC+AsQoeJhrmc03l3IpqgEwinzNSs5zLs
 xe/XuNupDVpbkHp1zta6DnDcCymIgiN7hQxRGuz1JuRdFmH4ZmCu2SHi35LThmNk4F24d2
 s+vJbf9itQP5DX9sZ7oUpjl9QE7xPUsEc2QioSpqRM7UbaiJjWX2xvfgYWm0P/AEand0oP
 GzeptLjeEApFVK12vTFUAC2feFcf9Ixa2i9TPxc2SWjKa22ebPEv6ammfi77dHxi70fT5L
 xpwBdkg8o+1Gemz+NIqzPmgdYM/YP0DVrCkFNYUPoz61SFi1/ldf6a8oeUmQzQ==
Message-ID: <feeb7c68-3800-424a-9904-c76c5c00967e@bootlin.com>
Date: Wed, 16 Sep 2026 10:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-16-richard.genoud@bootlin.com>
 <989dd99c-c988-46bc-8833-8a6f3d651684@ti.com>
 <b5556ad4-dce0-445d-bbc5-bc6f27a52abb@bootlin.com>
 <e93b8a5a-8b64-4806-980d-ea4a0e580d94@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <e93b8a5a-8b64-4806-980d-ea4a0e580d94@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 15/09/2026 à 17:57, Kumar, Udit a écrit :
> 
> 
> On 9/15/2026 7:29 PM, Richard GENOUD wrote:
>>>> +        k3_ddrss_lpddr4_exit_low_power(dev, &regs);
>>>> +
>>>> +        do_resume();
>>>
>>> could you check, if caches can be enabled before do_resume() call
>> I've tested that on j7200 and j784s4, and it fails at resume:
>> U-Boot SPL 2026.10-rc2-00046-g31003eca655b-dirty (Sep 15 2026 - 15:52:55
>> +0200)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.12--v11.02.12 (Fancy Rat)')
>> Initialized 4 DRAM controllers
>> Skipping authentication on GP device
>> Starting ATF on ARM64 core...
>>
> 
> You need to flush caches before starting DM
I did that and it failed in the same way.
I dug more in the PDK, and I found that at startup, it does unconditionally:
__attribute__((section(".startupCode"))) static void _enable_cache(void)
{
     CSL_armR5StartupCacheEnableAllCache( CSL_CACHE_DISABLE );      /* Disable I/D caches */
     CSL_armR5StartupCacheEnableForceWrThru( CSL_CACHE_DISABLE );   /* Disable force write-thru */
     CSL_armR5StartupCacheInvalidateAllCache();     /* Invalidate I/D caches */
     CSL_armR5StartupCacheEnableAllCache( CSL_CACHE_ENABLE );      /* Enable I/D caches */
}


Whereas for the mcu_plus / J722s, the case with caches enabled is dealt
with in:

     enabled = CacheP_getEnabled();

     /* disable the caches if anything is currently enabled */
     if (enabled!=0U) {
         CacheP_disable((uint32_t)CacheP_TYPE_ALL);
     }

     /* set DLFO, this is not needed on SOC AM64x and later SOCs */
     /* CacheP_setDLFO(); */

     if (gCacheConfig.enable!=0U) {
          CacheP_configForceWrThru(gCacheConfig.enableForceWrThru);

         /*
          * CacheP_enable() code will invalidate the L1D and L1P caches.
          * Therefore, no need to explicitly invalidate the cache here.
          */
         CacheP_enable((uint32_t)CacheP_TYPE_ALL);
     }



> 
>> [   82.967460] Enabling non-boot CPUs ...
>> ERROR:   Timeout waiting for thread RX_SECURE_TRANSPORT_CHANNEL_ID to fill
>> ERROR:   Thread RX_SECURE_TRANSPORT_CHANNEL_ID verification failed (-60)
>> ERROR:   Message receive failed (-60)
>> ERROR:   Failed to get response (-60)
>> ERROR:   Transfer send failed (-60)
>> ERROR:   Request to start core failed: -60
>> [   83.998938] psci: failed to boot CPU1 (-22)
>> [   84.003168] CPU1: failed to boot: -22
>> [   84.006989] Error taking CPU1 up: -22
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
