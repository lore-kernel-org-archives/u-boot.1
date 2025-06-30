Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971ECC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC4181D6A;
	Mon, 30 Jun 2025 17:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="fCKSRwxM";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="lgX3DxKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5492E81D6A; Mon, 30 Jun 2025 16:05:34 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55D68003E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 16:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=instance-europe-west4-l3dl.prod.antispam.mailspamprotection.com; s=arckey;
 t=1751292329; 
 b=k1GKQGJ1AxzLc3BJVloDcCNb1qznzHyVxdM+yt30DdAUpW6TVJQtsGNgk2HjDU3OG37pjqzQoG
 dhLZ5Beb3bOVGt7Bmyi5dkYRDmH6NUeQ7LsASm9NcI580eL6S97be8YgzhYN6kxFnu/CG+LGIm
 h6oG539AfL3oMG7vaRRjb5aUNW+h86FK1R86DestzDKO8dTNsPrnF9zlxONyPFBFa0e3whsaAs
 Yg0f+OuNdhLbM89iF1MgojkV/DO7PYk3iJindo3C0zne7Zh3rJ5khJ9U/sg+myqKwaOegEvy24
 oxOkl/UoCrDuKhqgkXZz1qTn4fLDdoFdVPnYN2cWqJopmQ==;
ARC-Authentication-Results: i=1;
 instance-europe-west4-l3dl.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=instance-europe-west4-l3dl.prod.antispam.mailspamprotection.com; s=arckey;
 t=1751292329; 
 bh=LHy2iEBt3JIFpTd3vgdnBzYYNFQUcvXoRl3E6DdwoqI=;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
 b=ycyjDmpH3QI1+meHa6YAUxHOKr0EvH9orpGIC+UW2H5kvN9tHBNVVr6qjw4CCIoW9L5NUEgkm9
 +d/A/UHhScKqG/n1z7+sVqeOkgTJ1HY3r8O/hIrvGzWFa93UJHcK533BIQg+DZEGp+UuGJSo+j
 KdPtlDRbL68EV1Wp5o7NHtPTlvL9kbeCOze3XZwDvrtHbgSGCH3Wez/eGLa2pVW0TlSun3DyDV
 T5CkTwkMs0TKIjgE1LTPAJS7AAp3m4XJML1mK3KYxVHEG/hQVtGQWHjN8SDowE0WhR1z5IAUpa
 jrUzMvrlr2HYgJoMCga3DCCUGqN3XF0jmdK26NrKBHVvSg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Reply-To:List-Unsubscribe;
 bh=g8AMxAHtntnh7rXWXZnTS4jM2/nfBYlxHFOKIHRAlXw=; b=fCKSRwxMtu7RNhzpPRCQGSsiQ5
 WkTR71gOoTSF5oOX7Cn9EcZiNRg8yC/wJB4J/1ctSAR0X5W4AG/k4h5IJQb9nKGBbe0xZTvyqJ3fG
 iRJSJ7An12w7Uo5Dooz7N1QtNWUgN2IBARZsH2ugrJMj80V/dzJRqxwKOVIq+hv67BpI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-l3dl.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1uWF8M-00000007pfm-1JSj
 for u-boot@lists.denx.de; Mon, 30 Jun 2025 14:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=g8AMxAHtntnh7rXWXZnTS4jM2/nfBYlxHFOKIHRAlXw=; b=lgX3DxKly1dbNAMbCnCBJuoudt
 SoXY2C4MRV1jFK6bQa/pyhv/lqgoVbHJWxh0vP2dnb4UnJwjfoOIZLnmTsxdBCTUkhic0X9eNd9wx
 0ZM4dKfonrZ5ZT/A9riElfZOytF/ueV6/5hjH4F/pX4X1GWFTd60koJWRWUHfykXEoSs=;
Received: from [82.60.196.243] (port=63446 helo=fedora.fritz.box)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1uWF8H-000000008mt-19GO; Mon, 30 Jun 2025 14:05:17 +0000
From: Francesco Valla <francesco@valla.it>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, trini@konsulko.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH v7 00/10] Add falcon support for am62a, 62p and 62x
Date: Mon, 30 Jun 2025 16:05:16 +0200
Message-ID: <2553134.XAFRqVoOGU@fedora.fritz.box>
In-Reply-To: <20250603142452.2707171-1-anshuld@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d1a91243a90cd143dfb57ba5e1d7a551
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1uWF8M-00000007pfm-1JSj-feedback@antispam.mailspamprotection.com
Authentication-Results: instance-europe-west4-l3dl.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-Mailman-Approved-At: Mon, 30 Jun 2025 17:00:23 +0200
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

Hi Anshul,

On Tuesday, 3 June 2025 at 16:24:40 Anshul Dalal <anshuld@ti.com> wrote:
> This patch set adds support for falcon boot on AM62a, 62p and 62x by
> bypassing A53 SPL and U-boot.
> 
> Existing Boot flow:
> R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel
> 
> Updated flow:
> R5 SPL -> ATF -> Linux Kernel
>
> ...

I tried this series on a custom device based on AM62P. While it's working
mostly fine, I noticed that PWM0 is not working after a falcon boot from
R5F, while it was working correctly after a boot through full U-Boot.

After a bit of debugging, I noticed that the epwm_tbclk0 is marked as
disabled in hardware in debugfs's clk_summary even if enabled by software:

 $ head -n 2 /sys/kernel/debug/clk/clk_summary && cat /sys/kernel/debug/clk/clk_summary | grep pwm

                                 enable  prepare  protect                                duty  hardware                            connection
   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
 clk:86:0                            0       0        0        250000000   0          0     50000      Y   23000000.pwm                    fck                      
 epwm_tbclk2                         0       0        0        0           0          0     50000      N   deviceless                      no_connection_id         
 epwm_tbclk1                         0       0        0        0           0          0     50000      N   deviceless                      no_connection_id         
 epwm_tbclk0                         1       1        0        0           0          0     50000      N   23000000.pwm                    tbclk


Reading the associated register (0x00104130) returns in fact 0x00000000,
while writing to it has no effect (and after a write the register reads
back as 0x00000000).


Do you have any idea on the reason of this behaviour? I don't think it is
directly related to the Falcon boot implementation, but probably a side
effect of it (maybe something that was enabled by A53 SPL?).

Thank you very much for the very valuable work!


Kind regards,
Francesco 




