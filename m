Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABCC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A2787E26;
	Wed, 14 Feb 2024 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=reposit.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mailprotect.be header.i=@mailprotect.be header.b="dh5mjX0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 891C487DF3; Wed, 14 Feb 2024 12:07:07 +0100 (CET)
Received: from out002.mailprotect.be (out002.mailprotect.be [83.217.72.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB2887DE6
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=reposit.be
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=spamsink@reposit.be
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:Subject:
 From:To:MIME-Version:Date:Message-ID:reply-to:sender:cc:bcc:in-reply-to:
 references; bh=s2VA7/8CAm8sY90S6t7n20u2BLsNRfgMN6EQ2yY8+kk=; b=dh5mjX0YuZYIVr
 B/vNxXvrLapsH18f7wRJ6/xlHr4tww3DyEbA/mDgi5feePKS7ITHFNnoHZFC9OqB/KSNMMM/0P8n5
 y2Ldolxvla9RMX7gDWoZl1raDwdAs4foivHz/z6mfjdSM++VIGpvIDrDN2tuIJs4v7wHVPFnO0k5p
 4ey/z64nCi+tUJMwYEUR+BXwVO7lkIoXI0E6wBwC6eCN3JYpfi6kbU2BfDVyRznd052dYAcxfkjbI
 BUN72wT50b4ebJJYayD1oLlG0zHBDCHX8gh0F/pBlSsPraxDeriFJrSM9IRMexEw9TUP0W5y46jvF
 qXZJYt78B9mR1BZrxQbA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
 by com-mpt-out002.mailprotect.be with esmtp (Exim 4.92)
 (envelope-from <spamsink@reposit.be>) id 1raD6J-00EnsX-G2
 for u-boot@lists.denx.de; Wed, 14 Feb 2024 12:06:52 +0100
Received: from [192.168.1.76] (host81-157-10-143.range81-157.btcentralplus.com
 [81.157.10.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 18FF9C00B5
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:06:51 +0100 (CET)
Message-ID: <eb9a091f-9f8e-401a-bd71-a9a3511a21b0@reposit.be>
Date: Wed, 14 Feb 2024 11:06:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: spamsink <spamsink@reposit.be>
Subject: How To Move Root Partition From eMMC to SSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be;
 auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9C+lX49wzKuu+fwZtIrQRIPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5x4wC90Yk0QFU2gbxptqJ4B54dC4kjiE7gKZmgIc1sDr5Jm
 rQtsDjVbbrJuWV2M+6arAP5R/Cae/ZemygD++WnmSxIRXVMlFuiz/acFNeeXt8QYiTpLCsrpI++d
 V3X+sU/z4wiOJN2t32kiKQ9BM1X47eibU04JcTWQKv3WukWvpAOpGxzbGQcYwg5X1bHm9UwM4xIi
 XRR3ynoyoca++B06gnlHOlhWnpMpiZGPvNEMh2hfj9whi8KpGkNMaaLS9DIcqbdy+7WYS7ujrPXH
 qhox0HpT3S2SFmqVvJUoDpLg17fDQD9rTYKpWUjzugBu3bT93D7ELi2IS29UXckX14BTLmsJGGG4
 zaE8z0regZWEmsDT9ZG0CmXc0v4tKHsUSjuO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gzIzJvw9qxD5zQLggp7fQfdHwZdrLrPMu08YNUTiQ69BIK/1NH5THMtlYvyHAYGOGqz2oidVuoQM
 okQutY3pHcCHFzboKDhGx0chVC6Uo5u4n3/KWfbq3t5NmLSY+EPGe2Z04axdCHI0laytOhuDj57o
 R3GWp9x3h1XKW6BJmYeGzzt+DXr8CK8an+ENS9RuzHKXFavGbcISl1ukdIaYXR4c4UteuEWGL4uk
 AgP8rQMRCNzTZvmOQVChs+18gxFkqdZVmoJEXiApImRe7ZZpOObpfj5sSQhb3cc4IkKXIhy+nQrj
 z4c4GigPSJgMsoNdiy/xH9LyY999F9Hm166WDIsMdNlNLSa8f5xLFtnfqQdjDlXGb9ueGtUrKYC6
 2QQl/4ErWMddmgnZiYJZW8Mx5OI4XjD8YIRbIyMCDTapG1wvP3+m/xDwzcJD3WpfpflqIsw4Oh2L
 kwsmIC+tUiJAU2Er8l1a+B3b8WJsR0wzQmfGh2gsrFnWkSEVyhXwWjx2Pi8/3bImoUNQxaBiRh+E
 LzQHfvAIIq3mhMeBOPt+aoVQZCXluMXV6vXk0yaNYekQfeM0IzWKRsu4i7omKI43ueU=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
X-Mailman-Approved-At: Wed, 14 Feb 2024 13:42:37 +0100
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

I am running the NanoPi R6C.  The device is not capable of booting from 
the SSD, the next best thing is to load the root filesystem from the SSD.

Using rockchip's repos, I compile from source the images to boot 1) from 
the microSD card and 2) from eMMC.  I install to the eMMC.  Then, so as 
not to mount any partitions from eMMC, I boot from the microSD card, and 
I clone the root partition from the eMMC (/dev/mmcblk2p8) to the SSD 
(/dev/nvme0n1p1).

I boot from the eMMC, the output of "cat /proc/cmdline" is:

storagemedia=emmc androidboot.storagemedia=emmc androidboot.mode=normal 
androidboot.dtbo_idx=0 androidboot.verifiedbootstate=orange 
earlycon=uart8250,mmio32,0xfeb50000 console=ttyFIQ0 coherent_pool=1m 
irqchip.gicv3_pseudo_nmi=0 rw root=/dev/mmcblk2p8 rootfstype=ext4 
rootflags=discard data=/dev/mmcblk2p9 consoleblank=0 
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1 
androidboot.fwver=uboot-a83a7263ef-01/09/2024

How do I change "root=/dev/mmcblk2p8" to "root=/dev/nvme0n1p1"?

I connect to the serial port and get to the U-Boot monitor.  I examine 
the variables.  "bootcmd" runs "bootrkp" which boots the system.  
"bootrkp" ignores "bootargs", I confirm this by deleting "bootargs" 
before running "bootrkp", the system boots up as before with no change 
in behavior.  "bootrkp" is implemented in file "cmd/bootrkp.c".  That 
code emits the equivalent of:

setenv bootm-no-reloc y
booti 0x400000 0xa200000:0x7b2bc0 0x8300000

Can I tell U-Boot to load the root partition from /dev/nvme0n1p1, either 
by entering commands at the monitor, or by modifying the source code of 
U-Boot, or through any other means?

Regards,
Eric

