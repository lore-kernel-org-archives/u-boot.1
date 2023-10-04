Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD181E7B604
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4578753C;
	Wed,  4 Oct 2023 14:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A0vtYge2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C158753D; Wed,  4 Oct 2023 14:32:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46EC8753B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394CWFTS039498;
 Wed, 4 Oct 2023 07:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696422735;
 bh=sZE1Fgrxo7lNW65/VQ5CSX36ly2mVcwymrKjeh27w84=;
 h=From:Subject:Date:To:CC;
 b=A0vtYge28jmng1vj7ov9mOaqFcVrwI5voUYKSwdiX4IwPFjdOFbevIqlpWhSQArSw
 JNY8lluiq4OvTeLnNy8S2mrs0LKRwNiiOWnUeJJozIB8abQXslsnwYS9wBzmCLzP5l
 BHeOH6YddeOoBAIXZPm7MrFi8f2wcvZ2eRtXnLaw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394CWFcj082470
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 07:32:15 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 07:32:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 07:32:15 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394CWBJl010622;
 Wed, 4 Oct 2023 07:32:12 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/6] ATF and OP-TEE Firewalling for K3 devices.
Date: Wed, 4 Oct 2023 18:01:29 +0530
Message-ID: <20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFbHWUC/22OwQ6CMAxAf4Xs7MzYAMGT/2E8dKNAExhkQ8QQ/
 t2BifHA8bV5fV2YR0fo2TVamMOJPPU2gDpFzDRga+RUBmZSSCUuMuGabAeWV+TwBW1LtuZZiqb
 UUqERwIKowSPXDqxpNvU5+NEhdNziPG77wWFF8x69PwI35MfevfcfpnibfnOFSI9yU8wFV3mRp
 FLoqsrhNtLZ9B3bbk3yz5fZoS+Dr2MQeYImU0n589d1/QDlSAPpEQEAAA==
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696422731; l=2526;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=uHa1md//+4eOIRq/tEluzS1mglkXXRjd2SZdJ2QOPc0=;
 b=1SDmJ2TKndU6t2srOiWfQXfdRExf5WDFpr+8OOmatXupb4FYAI8V4SJkVP76MG+FvZxZ6akQz
 iVYvX1nIVG8DlqAcGdefBHZI64/a7ouRSt3HGGdtcAGGGWkUpRZLvtG
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

K3 devices have firewalls that are used to prevent illegal accesses to
memory regions that are deemed secure. The series prevents the illegal
accesses to ATF and OP-TEE regions that are present in different K3
devices. 

AM62X, AM62AX and AM64X are currently in hold due to some firewall
configurations that our System Controller (TIFS) needs to handle. 
The devices that are not configured with the firewalling nodes will not
be affected and can continue to work fine until the firewall nodes are
added so will be a non-blocking merge. 

Test Logs: https://gist.github.com/manorit2001/c929e6ccab03f55b3828896fbd04184b

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:

* Andrew
- Fix tabs and spaces

* Simon
- Remove parantheses wherever suggested
- Take the ideas for GetHexOctet and remove the patch
- Add Reviewed-by

- Align the commit messages for all the commits
- Fix comment styling
- Remove am62x also as it has some dhcp failure with firewalls likely
  due to TIFS configurations
- Rename 311_ti_secure_firewall.dts to 319_ti_secure_firewall.dts after
  rebase.
- Migrate to non-RFC version
- Link to v2: https://serenity.dal.design.ti.com/lore/linux-patch-review/20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com

---
Manorit Chawdhry (6):
      binman: ti-secure: Add support for firewalling entities
      binman: ftest: Add test for ti-secure firewall node
      binman: k3: Add k3-security.h and include it in k3-binman.dtsi
      binman: j721e: Add firewall configurations
      binman: j721s2: Add firewall configurations
      binman: j7200: Add firewall configurations

 arch/arm/dts/k3-binman.dtsi                  |   2 +
 arch/arm/dts/k3-j7200-binman.dtsi            | 143 ++++++++++++++++++
 arch/arm/dts/k3-j721e-binman.dtsi            | 187 ++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi           | 208 +++++++++++++++++++++++++++
 arch/arm/dts/k3-security.h                   |  58 ++++++++
 tools/binman/btool/openssl.py                |  16 ++-
 tools/binman/etype/ti_secure.py              |  85 +++++++++++
 tools/binman/etype/x509_cert.py              |   3 +-
 tools/binman/ftest.py                        |  12 ++
 tools/binman/test/319_ti_secure_firewall.dts |  28 ++++
 10 files changed, 739 insertions(+), 3 deletions(-)
---
base-commit: b05a184379631d13c4a49e423aa1324dc1ae6158
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

