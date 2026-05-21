Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1192CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410798480B;
	Thu, 21 May 2026 17:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="L55vNVNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F14846DE; Thu, 21 May 2026 15:54:49 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 567A0846DF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9AVtu1704036; Thu, 21 May 2026 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=G1FkH
 ub0r5FhUA+d7h8hG660M7ebSuaZCReejWqu//0=; b=L55vNVNxEBH/O6lsGi1z7
 S1im+b7K5Q/3vJDi7bva5h3COpyG/ewDWjhSEQQlJhfOU8dNkiqMIbESdDRBBSM1
 3ycRUh7egkaE1ETfdNaCDhxrwKSjw/f0nTUQGKDsbW2MGq5vVS7sFty50V15/In2
 xCSjS4Rm/ExIqE4JXLLDo3EVvbXlO6TKdSF/2hR2Y7ywTwOlfdAgmbYrRV4BHK03
 cBjQVo8CHAipzy32p7RSAn31CL6Q/6X31k9mzfBJdVcWRjw3NWwH/Ln0oXXF9EBz
 HO5QHkTNO3q5M84jQEvwaTIl7sK7fGGwe6yQzBpedAPV/KqAJrYhyN5548UJ2pRH
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsf7d046912
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:40 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqh016286;
 Thu, 21 May 2026 09:54:35 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 05/16] mach-sc5xx: Switch from tftp to wget
Date: Thu, 21 May 2026 09:53:16 -0400
Message-ID: <e10f4cbe786167a817ddc446b59e8ce666836cdc.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX0Hb2B9ZP0oPp
 A2aZxrHCiXMewzSZ1onn+d7vK/2AfxwQvwpqSf2luvsK3D2VKJQO9mFQm//s8sXjfKcxGshpDH4
 gv6Zpmv5ncuYGHE2h64kEZUP9UnanywoL2HNgeC6eAcTbPT0B+8VXpD1CMWwBDkzC8DaRxZ2djf
 0NUbZZwJnsm9q+oqL7xF8xi2t1OH9juNQ/FTIW7dM4cP4jhVBt8sHiwBGgc0Y7X/Agq4LuODI7j
 IifRsyaEzr+BmYIBY8TectLn86vx7AumnEBZ/V6izStzdT4rl5iyuhYQyWhS4gu0C8clKG6v8hJ
 H0HoppMKNaKLgwkOlaGlv00zlOlwibYCRiiXxVp2cizl0QB00AYATiyymw5YHgFjQV4DOzVezFO
 Tf2fTlXbyDg9C7OvR1YgJ11Q7mvx5Cyn1h2iBgrQKC7h3m4q1kAQxAv+hF/bOTHNggiGrRqunZE
 nJtkxhoHFbckN3IW7OQ==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0ea2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=WZrRrOjOqN63VuoxmeIA:9
X-Proofpoint-ORIG-GUID: GKd5iENOjmgXWvFIm4nbPMxmi5-gIkh3
X-Proofpoint-GUID: GKd5iENOjmgXWvFIm4nbPMxmi5-gIkh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

Switch the nfsboot and other relevant commands to use
wget instead of tftp. This also includes the addition of
the httpdstp variable for selecting the wget port.

There is no longer any automatic DHCP configuration. Before
running a command with wget, either 'dhcp' must be run or
the 'ipaddr' and 'serverip' variables must be set. Additionally,
the nfsboot command looks for the file named 'fitImage' on the
server to use to boot.

The default port is set to 8000 instead of the usual 80
to allow for use with an unprivileged web server.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 include/env/adi/adi_boot.env | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index b4b725247f7..be4d8521ac9 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -14,6 +14,7 @@
 /* Config options */
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
+httpdstp=8000
 uart_console=CONFIG_UART_CONSOLE
 #ifdef CONFIG_SC59X_64
 initrd_high=0xffffffffffffffff
@@ -26,15 +27,14 @@ adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
 ramargs=setenv bootargs ${adi_bootargs}
 
 addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off
+rootpath=/romfs
 
 /* Boot modes are selectable and should be defined in the board env before including */
 #if defined(USE_NFS)
-// rootpath is set by CONFIG_ROOTPATH
 nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfsvers=3 ${adi_bootargs}
-nfsboot=run init_ethernet;
-	tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
-	run nfsargs;
+nfsboot=run nfsargs;
 	run addip;
+	wget ${loadaddr} ${serverip}:/fitImage;
 	bootm ${loadaddr}
 #endif
 
@@ -63,8 +63,7 @@ ospiboot=run ospiargs;
 #endif
 
 #if defined(USE_RAM)
-ramboot=run init_ethernet;
-	tftp ${loadaddr} ${tfpt_dir_prefix}${imagefile};
+ramboot=wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
-- 
2.34.1

