Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DB9EA7188
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 04:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C761B83B99;
	Sun, 19 Apr 2026 06:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=firemail.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=firemail.cc header.i=@firemail.cc header.b="WEZPPE0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B05D841C2; Sat, 18 Apr 2026 22:01:58 +0200 (CEST)
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CD6839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 22:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=firemail.cc
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mitochondriummulticast@firemail.cc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
 t=1776542514; bh=bilexOYai3hseJEDo6XPK3B4/Br+yQmmyVVnJfkerDM=;
 h=Date:To:From:Subject:From;
 b=WEZPPE0ojHxphrF/Fz27XbdLHmpWpQtyMbgfw0MOI3BTfATvsjlUf8SaYJ3AZawTK
 mS0/BbmfcOsQtuL782F2uCE/wToOr34ew9gpWmUEpQuzJosINd010ekRH0NDdLXR/k
 Kntu7ZoiYyKkB2qHvu8HMcMocSuILDoCYuFWSywdisPbl2sHaeVTeOG6lwU/4MJjUs
 70uR6SR8Iwb+en/G7SUtP/a7wHJkvie+QypZvQjyKnbCDCJz7pyEj/+P2BV7jWF+Re
 QCt1gDC1hqVpz1mwhAKFYdn5TNFV7W7qZub5txW+hOECH6CVc9PHqnNxfUFBxNjcbm
 pw/NoWeSJZEBA==
Message-ID: <555f8a58-0fdb-49fd-b6cf-ac013546ac30@firemail.cc>
Date: Sat, 18 Apr 2026 22:01:13 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Content-Language: en-US
To: u-boot@lists.denx.de
From: mitochondriummulticast <mitochondriummulticast@firemail.cc>
Subject: About LUKS in U-Boot
X-Mailman-Approved-At: Sun, 19 Apr 2026 06:45:18 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

I would like to confirm support of LUKSv2 in U-Boot.

What exact options have to be enabled in the '.config' file for it to 
work properly(I use arm64 board)?

Is there any* hardware* specific thing that could pose a constrain when 
it comes to Linux + LUKS setup up with the boot-loader, to be more 
clear; would any board that uses U-Boot support LUKS ?
