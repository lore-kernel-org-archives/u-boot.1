Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DBCC54E49
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A99874B1;
	Fri, 23 Feb 2024 12:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11D786FC9; Fri, 23 Feb 2024 12:42:24 +0100 (CET)
Received: from 18.mo561.mail-out.ovh.net (18.mo561.mail-out.ovh.net
 [87.98.172.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD00878AA
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.2.21])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4Th7R04xjXz1HPg
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 11:42:20 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-s5cdf (unknown [10.108.54.88])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2A6931FEA5;
 Fri, 23 Feb 2024 11:42:20 +0000 (UTC)
Received: from armadeus.com ([37.59.142.97])
 by ghost-submission-6684bf9d7b-s5cdf with ESMTPSA
 id 0235ApyE2GVStQMAFMw4Mg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 23 Feb 2024 11:42:20 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0026d300160-2fa9-465f-8d01-60e3bf3ba254,
 BC4D5BFA97CC3CA13122104BDCDC28DE7890766D)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH v3 1/1] Makefile: pass -undef option to cmd_gen_envp
Date: Fri, 23 Feb 2024 12:42:06 +0100
Message-ID: <20240223114206.21720-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9555512510106430443
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnheptdevkeeuhfdtvdevkeegffegveduleehvdetkeegtdekjeefhfettdfggedviefgnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
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

Without the '-undef' option, the 'linux' string in .env files is
replaced with the string '1 '.
For example, in the board/armadeus/opos6uldev/opos6uldev.env file,

kernelimg=opos6ul-linux.bin

becomes

kernelimg=opos6ul-1 .bin

in the include/generated/env.in file.

That's because 'linux' is a System-specific Predefined Macros. [1]

Pass the '-undef' option to fix this issue.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/cpp/System-specific-Predefined-Macros.html

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v3:
 - use -undef instead of ansi. With -undef, there is no need to modify
   iot2050.env and smegw01.env files anymore.

Changes for v2:
 - explain the change of iot2050.env and smegw01.env in the commit log

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3b5db90df6f9..63b006e0e0f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1804,7 +1804,8 @@ ENV_FILE := $(if $(ENV_SOURCE_FILE),$(ENV_FILE_CFG),$(wildcard $(ENV_FILE_BOARD)
 quiet_cmd_gen_envp = ENVP    $@
       cmd_gen_envp = \
 	if [ -s "$(ENV_FILE)" ]; then \
-		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -D__ASSEMBLY__ \
+		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -undef \
+			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
-- 
2.43.0

