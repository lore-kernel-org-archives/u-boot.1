Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D88BCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 09:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F4883DE0;
	Tue,  2 Dec 2025 10:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0DE83E21; Tue,  2 Dec 2025 10:25:26 +0100 (CET)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B26883CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 10:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 5C0BBBD79;
 Tue,  2 Dec 2025 10:25:23 +0100 (CET)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025120210252253-69346 ;
 Tue, 2 Dec 2025 10:25:22 +0100 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.96])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025120210252305-18537 ;
 Tue, 2 Dec 2025 10:25:23 +0100 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@at.abb.com>,
 "Abbarapu Venkatesh Yadav" <venkyada@qti.qualcomm.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>,
 "Christopher Obbard" <christopher.obbard@linaro.org>,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "=?ISO-8859-2?Q?Duje_Mihanovi=E6?=" <duje@dujemihanovic.xyz>,
 "Greg Malysa" <malysagreg@gmail.com>, "Heiko Schocher" <hs@nabladev.com>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "No generic patch CC mail please" <noreply@example.com>,
 "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Stefan Roese" <stefan.roese@mailbox.org>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Sumit Garg" <sumit.garg@kernel.org>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] Change email addresses for B&R Industrial Automation
Date: Tue, 2 Dec 2025 10:24:58 +0100
Message-ID: <20251202092513.71879-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 12/02/2025 10:25:23 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 12/02/2025 10:25:23 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 12/02/2025 10:25:22 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 12/02/2025 10:25:23 AM,
 Serialize complete at 12/02/2025 10:25:23 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

B&R Industrial Automation has been acquired by ABB in 2017, and this
will be reflected in our email addresses beginning from December 2025.

The email addresses change as follows:
 @br-automation.com -> @<country-code>.abb.com

The existing email addresses will be valid until December 2026.

Add entries for Bernhard Messerklinger and myself to .mailmap, and
update the MAINTAINERS files.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Signed-off-by: Wolfgang Wallner <wolfgang.wallner@at.abb.com>

---

 .mailmap                       | 2 ++
 board/BuR/brppt1/MAINTAINERS   | 2 +-
 board/BuR/brppt2/MAINTAINERS   | 2 +-
 board/BuR/brsmarc1/MAINTAINERS | 2 +-
 board/BuR/brxre1/MAINTAINERS   | 2 +-
 board/BuR/zynq/MAINTAINERS     | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 145e9ea26e4..04daa274ef3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -28,6 +28,7 @@ Anurag Kumar Vulisha <AnuragKumar.Vulisha@amd.com> <anura=
g.kumar.vulisha@xilinx.
 Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com> <appan=
a.durga.rao@xilinx.com>
 Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
+Bernhard Messerklinger <bernhard.messerklinger@at.abb.com> <bernhard.messe=
rklinger@br-automation.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xil=
inx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <b=
hargava.sreekantappa-gayathri@xilinx.com>
@@ -156,6 +157,7 @@ Wolfgang Denk <wd@denx.de> <wd@pollux.(none)>
 Wolfgang Denk <wd@denx.de> <wd@pollux.denx.de>
 Wolfgang Denk <wd@denx.de> <wd@xpert.denx.de>
 Wolfgang Denk <wd@denx.de> <wdenk>
+Wolfgang Wallner <wolfgang.wallner@at.abb.com> <wolfgang.wallner@br-automa=
tion.com>
 York Sun <york.sun@nxp.com>
 York Sun <yorksun@freescale.com>
 =C5=81ukasz Majewski <l.majewski@samsung.com>
diff --git a/board/BuR/brppt1/MAINTAINERS b/board/BuR/brppt1/MAINTAINERS
index a974a97c157..b24d7eb9ad5 100644
--- a/board/BuR/brppt1/MAINTAINERS
+++ b/board/BuR/brppt1/MAINTAINERS
@@ -1,5 +1,5 @@
 BRPPT1 BOARD
-M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+M:	Wolfgang Wallner <wolfgang.wallner@at.abb.com>
 S:	Maintained
 F:	board/BuR/brppt1/
 F:	board/BuR/common/
diff --git a/board/BuR/brppt2/MAINTAINERS b/board/BuR/brppt2/MAINTAINERS
index bfeaa571a82..2ab54a909c5 100644
--- a/board/BuR/brppt2/MAINTAINERS
+++ b/board/BuR/brppt2/MAINTAINERS
@@ -1,5 +1,5 @@
 BUR=5FPPT2 BOARD
-M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+M:	Wolfgang Wallner <wolfgang.wallner@at.abb.com>
 S:	Maintained
 F:	board/BuR/brppt2/
 F:	board/BuR/common/
diff --git a/board/BuR/brsmarc1/MAINTAINERS b/board/BuR/brsmarc1/MAINTAINERS
index 7421f61fc43..f2754582b59 100644
--- a/board/BuR/brsmarc1/MAINTAINERS
+++ b/board/BuR/brsmarc1/MAINTAINERS
@@ -1,5 +1,5 @@
 BRSMARC1 BOARD
-M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+M:	Wolfgang Wallner <wolfgang.wallner@at.abb.com>
 S:	Maintained
 F:	board/BuR/brsmarc1/
 F:	board/BuR/common/
diff --git a/board/BuR/brxre1/MAINTAINERS b/board/BuR/brxre1/MAINTAINERS
index f826a44b6ac..b424ddca6ca 100644
--- a/board/BuR/brxre1/MAINTAINERS
+++ b/board/BuR/brxre1/MAINTAINERS
@@ -1,5 +1,5 @@
 BRXRE1 BOARD
-M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+M:	Wolfgang Wallner <wolfgang.wallner@at.abb.com>
 S:	Maintained
 F:	board/BuR/brxre1/
 F:	board/BuR/common/
diff --git a/board/BuR/zynq/MAINTAINERS b/board/BuR/zynq/MAINTAINERS
index d655cae58d4..e2b04980403 100644
--- a/board/BuR/zynq/MAINTAINERS
+++ b/board/BuR/zynq/MAINTAINERS
@@ -1,5 +1,5 @@
 ZYNQ BOARD
-M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+M:	Wolfgang Wallner <wolfgang.wallner@at.abb.com>
 S:	Maintained
 F:	board/BuR/zynq/
 F:	board/BuR/common/
--=20
2.52.0

base-commit: c6ee44b5573a90b0a3a36cf858954e04439ae632
branch: us/abb=5Fmail
