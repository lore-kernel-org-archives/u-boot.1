Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB91E64A89
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A178988B0A;
	Tue,  3 Dec 2024 14:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rohde-schwarz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794068964B; Tue,  3 Dec 2024 12:51:13 +0100 (CET)
Received: from mail02.rohde-schwarz.com (mail02.rohde-schwarz.com
 [80.246.32.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CB6895BD
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 12:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rohde-schwarz.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dominik.wernberger@rohde-schwarz.com
Received: from securemail-mu-h4.rohde-schwarz.com (10.0.19.146) by
 mail02.rohde-schwarz.com (172.21.64.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Dec 2024 12:51:10 +0100
Subject: Re: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
MIME-Version: 1.0
Received: from GMU451.rsint.net ([10.0.225.106])
 by gmu812.rsint.net (Totemo SMTP Server) with SMTP ID 1016;
 Tue, 3 Dec 2024 11:51:10 +0000 (GMT)
Received: from GMU507.rsint.net (10.0.225.39) by GMU451.rsint.net
 (10.0.225.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Dec
 2024 12:51:09 +0100
Received: from GMU503.rsint.net (10.0.225.35) by GMU507.rsint.net
 (10.0.225.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Dec
 2024 12:51:07 +0100
Received: from GMU503.rsint.net ([fe80::957e:76:e488:c60d]) by
 GMU503.rsint.net ([fe80::957e:76:e488:c60d%4]) with mapi id 15.02.1258.034;
 Tue, 3 Dec 2024 12:51:07 +0100
From: Dominik Wernberger <dominik.wernberger@rohde-schwarz.com>
To: "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>
CC: "git@amd.com" <git@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "michal.simek@amd.com" <michal.simek@amd.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "vigneshr@ti.com" <vigneshr@ti.com>
Thread-Index: AdtFZ8SiMsssq5vATxyiCrnijjyGxA==
Date: Tue, 3 Dec 2024 11:51:07 +0000
Message-ID: <db4086b015cc48f2ad9d9bfe97b338d9@rohde-schwarz.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.9.40]
X-IQAV: YES
thread-topic: Re: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
 /cr/
X-rus_sensitivity: 20
msip_labels: MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Enabled=true;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SetDate=2024-12-03T12:51:08Z;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Method=Privileged;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Name=COMPANY RESTRICTED -
 BUSINESS USE;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SiteId=74bddbd9-705c-456e-aabd-99beb719a2b2;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ActionId=6120cf0a-b2bc-438e-8b4b-106b503b180c;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ContentBits=1
X-GBS-PROC: 48HY1pXjBZudsSBH277sYfqPrDxliZ/6107gObXzVPsMTDbqXlW1AYU+jTIMw3selG1ANpPMdJnL5Yn4XAefaCUihUWS/90EGeykE8NHxF0Zd9FQEa2ofuJwDRoLX3Hf
X-GBS-PROCJOB: deTeKmIZqAPjHEpXnYgXEDT4Xqe/mES7OG9OxtiYrqL96lmQB7vdNgPZT0kFX38G
X-Mailman-Approved-At: Tue, 03 Dec 2024 14:04:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Venkatesh,

Is there any news on the status of this patch? I'm working with a Zynq 7z02=
0 system where 2 Flashes
operate in parallel QSPI mode. This patch is essential for the correct Flas=
h erase in U-Boot v2025.01-rc3.

Without this patch Flash erase fails on every second multiple of Flash eras=
e section size (FESS). Failing
means that the Flash erase is not initiated or successful. I.e., the Flash =
section is not altered.

For example, lets assume a FESS with 0x20000 (128 kiB).

sf test 00000 20000 # Works
sf test 20000 20000 # Fails
sf test 40000 20000 # Works
sf test 60000 20000 # Fails
# ...

Note that executing

sf erase 20000 20000
SF: 131072 bytes @ 0x20000 Erased: OK

shows OK even though the Flash sector were not erased.

In case you have any new/rebased patches you want me to test, I would be ha=
ppy to do so. I'm looking
forward getting this patch into mainline U-Boot.

Best Regards,

Dominik



Content provided within this e-mail including any attachments, is for the u=
se of the intended recipients and may contain Rohde & Schwarz company restr=
icted information. Any unauthorized use, disclosure, or distribution of thi=
s communication in whole or in part is strictly prohibited. If you are not =
the intended recipient, please notify the sender by reply email or by telep=
hone and delete the communication in its entirety.
