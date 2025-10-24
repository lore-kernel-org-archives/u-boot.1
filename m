Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE882CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB415838E3;
	Fri, 24 Oct 2025 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=schwermer.no
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA15F83621; Fri, 24 Oct 2025 11:23:03 +0200 (CEST)
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C898334F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 11:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=schwermer.no
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=u-boot@schwermer.no
Message-ID: <bfe7ac62-0d01-45b5-9226-e1d425565d50@schwermer.no>
Date: Fri, 24 Oct 2025 11:23:00 +0200
MIME-Version: 1.0
Content-Language: en-US
To: U-Boot-Denx <u-boot@lists.denx.de>
From: Sven <u-boot@schwermer.no>
Subject: mx6ull: init_bandgap regression
Cc: dario.binacchi@amarulasolutions.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sbabic@nabladev.com, Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, martyn.welch@collabora.com,
 parthitce@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Hi,

We make an i.MX6ULL-based board that is built around the Phytec PCL063 
SoM. We have noticed a regression between v2022.01 (good) and v2022.04 
(bad). We have also found the following tags to be bad: v2022.07, 
v2023.01, v2024.01. We have bisected this and found the culprit to be 
c1af358c ("imx: mx6ull: fix REFTOP_VBGADJ setting"). This code still 
appears to be unchanged on upstream master.

These are the symptoms: Very few of the thousands of devices that we 
manufacture (< 1%) fail to decompress a large XZ archive once in Linux 
userspace. We have not found any form of memory testing or other load 
that reproduces this issue. Reverting the offending patch fixes this 
behavior on the affected devices.

Perhaps the NXP folks could chime in on the intended behavior. And the 
mismatch between commit message and comments mentioned in the offending 
patch.

Best regards,
Sven
