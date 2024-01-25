Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECBC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 13:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6024787559;
	Thu, 25 Jan 2024 14:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=litinow.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=litinow.com header.i=@litinow.com header.b="dMRNUfHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65034871A6; Thu, 25 Jan 2024 13:05:29 +0100 (CET)
Received: from cpanel35.fastsecurehost.com (cpanel35.fastsecurehost.com
 [217.115.119.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3442186FB2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 13:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=litinow.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mauricio.penteado@litinow.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=litinow.com
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:
 From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bulkMqnwvCMz/iQnKLiNjGT/YaMnyYJ3ca+4oPJRIgs=; b=dMRNUfHpKwpWKlbA+SosRxiJAB
 INo0husRKeiNjFSOIJjETE7gDM9zj8OGmoekl9G60QvT2QizngEdFSyWGntHOGWEu0vqDrUhcjb6p
 4X1yZzgY9KhOXrJ76vQeOpxbXBFS0RPGDRisTyzvrs2LJhaEbH6pNm+WOiq7XetyAO4CfecW1MCBU
 XXPl2OueiDqszs0eGYNcoeq/Z7kidBS+MDENHIdCut12uHpOr7bKtc2mAwDi9on73nIqf7vhPiwPP
 9BdYkj7Ce+aJTC+DMs/O2TSB/aZfPAp4yiDxnjbp+vK0NSvTEBFhoG6MpJEQcpnI2pnfmvjU6uiOE
 o0obqvbA==;
X-fastsecurehost-MailScanner-From: mauricio.penteado@litinow.com
X-fastsecurehost-MailScanner-SpamCheck: 
X-fastsecurehost-MailScanner: Found to be clean
X-fastsecurehost-MailScanner-ID: 1rSyTv-00FY2a-1v
X-fastsecurehost-MailScanner-Information: Please contact the ISP for more
 information
Received: from [::1] (port=36518 helo=cpanel35.fastsecurehost.com)
 by cpanel35.fastsecurehost.com with esmtpa (Exim 4.96.2)
 (envelope-from <mauricio.penteado@litinow.com>) id 1rSyTv-00FY2a-1v
 for u-boot@lists.denx.de; Thu, 25 Jan 2024 12:05:19 +0000
MIME-Version: 1.0
Date: Thu, 25 Jan 2024 12:05:19 +0000
From: mauricio.penteado@litinow.com
To: u-boot@lists.denx.de
Subject: U-Boot for Terasic - Cyclone 5 - DE10-standard board
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <3b518bf1d756c2510c9bf64efacbf0bc@litinow.com>
X-Sender: mauricio.penteado@litinow.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel35.fastsecurehost.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - litinow.com
X-Get-Message-Sender-Via: cpanel35.fastsecurehost.com: authenticated_id:
 mauricio.penteado@litinow.com
X-Authenticated-Sender: cpanel35.fastsecurehost.com: mauricio.penteado@litinow.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 25 Jan 2024 14:56:44 +0100
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

For some time I have been trying to understand how to build an embedded 
Linux to my terasic de10-standard board, without success.

After booting the provided Linux image that is available for download 
from the terasic website, I was able to check the following information:

U-Boot: 2013.01.01
Kernel version: 4.5
Machine model: Terasic DE1_SoC
Shall I try to build my embedded Linux using these versions of u-boot, 
kernel and machine model?

I’m asking this because I’ve already tried the most up-to-date versions 
of u-boot, kernel and already used a machine model that matches my 
board, but unfortunately I’m not able to change the “soc_system.rbf” to 
reprogram my board at booting time.

Changing the “soc_system.rbf” when using the terasic’s provided Linux 
image works pretty well.

The problem with the most updated versions are probably linked to 
changes on u-boot, which combines support for the secondary preloader 
and u-boot into one u-boot-with-spl binary.

Whatever, I wonder if I should invest some time building my embedded 
Linux using these outdated versions of u-boot, kernel and machine model 
or I will waste my time.

Could anyone help?
