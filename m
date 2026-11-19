Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE360A261F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yfW52jzF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C7DE407F6;
	Thu, 19 Nov 2026 09:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUCKgIBKMsbF; Thu, 19 Nov 2026 09:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A3E54059B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795079968;
	b=TJ3mfWG2UHThu7IMaEyRKGIrw4YE/o/o8HSgr5GswC+IzI0tO3jM42V1LD1aauiuehaI
	 42laUOwjggEbOH34LGh+m2SbXS3iSAWIsoPtgJBzofekCvRbdNRfCIkwoOCdBKNjQeHK0
	 49yfrT5oFzQvxd/thW8iWyO7Unf4nS2MZnvvACoba9UGnKvNA6DyLf0yQxdzhMMFo96K4
	 OKF8260OaZs7MDn3z05E/WaXnbgP/R4P8EX6Cse2XculEjwUzbYIsKmx70yOEzMoVbdVw
	 H6ej3VpX2lUm8s4++Il9LDU5WX2Sn05QaoVFzs0aG1pKditHiqAivQD8gTp4I4BWWxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795079968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6R8adZBlqEE+HqJDQO5en1J6dZAA8RzuPYkzYKENJek=;
	b=e79hgRKWES2ZmpLPOHo6Vu9yvjS1M6ob5JNmDNYrfGp+hjxlp3CyZEL/3+0NwYsNP8Ly
	 oMO6nzEiOnXcdzecBvEcRCQAsqFVuBEouVRqkCL256S+MSjvNz2o7TCx1sbL1lV0AKDUh
	 eFtq78s9nAe6gn9o5XVHGVIAK4INnKA0i7csDKtaoii3PshF3JKohzRFzbh6hyzOF4vsU
	 068BVpJcrgwdDW3/N4Rx3aQd0RM7B8Z65FjeqjHvCHsR/DxuEHMDVtO7rf1HXVPyqrVzn
	 cSjTo6PH/WbbrfFCYdh77fC+75EvEcCMCJ8NrZz336dH/xr/9PRe9anEXAmvEsez5eA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795079968;
	bh=6R8adZBlqEE+HqJDQO5en1J6dZAA8RzuPYkzYKENJek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfW52jzFEbgq8dT6zmlLMXGdQzexFsf/AHEc/TtMEKGzICbKVAX83iBvPDKHRIXNR
	 KRb/wmus53Zf/Ky6fuqxOP/UfL8k9FIsY4QRzKPB9E7AvXUjUPjCMw/2qq8iCj/wTA
	 q30/mtccJC+gyMAI+nOmRlCcTtsOTQDyyBtlu0NlZnu7hmaqcfa0K61dQjmP7CmMAz
	 AIyXnztrA5oT5OhVejNTa9qIdZBbhSMXpsvKo5Q2of9AY8qt5eI3xlzORizJ2xINd1
	 1TGRzdeVF55Q9aDN7FQ3VxotpwJiKzrsHzpEWP0JjpD365Gbz2y6wHM4p9H6sXROpG
	 OwihD0qcfgFpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A3E54059B;
	Thu, 19 Nov 2026 09:19:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C07EA32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A0D1404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRB1EFiHRgkE for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 860F0404E2
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 860F0404E2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:22 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1795079889tf2cbcefc
X-QQ-Originating-IP: LJsEPM8rwmv9OPewWO2CQujW9oY7tMl4sn6oxR91Gb0=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 17:18:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15179292592208647333
EX-QQ-RecipientCnt: 11
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: [PATCH v2 2/3] binman: Accept RUSTSBI as an alias for OPENSBI
Date: Thu, 19 Nov 2026 17:18:41 +0800
Message-ID: <D5BE1F0AB7875B8C+20261119091842.3062208-3-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119091842.3062208-1-luojia@rustsbi.com>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M1pdnhBjj5cjt0ow4xN3ksNr1kWTA8ueMpr6aifa7EQychvzJZaVa9O9
 wPeKYkaG6rHYk4eH2uzQVIVHIhdDR9A/2Wo89vZr0T2O8tUzNWFHVdWcJcAi5E7JindTeAg
 p9lmtUhvXU7pZ67Zg667CwPSjRxyss6dXun2ZsLTGGikBTlAWvL+9zMMb6u0sBbhmxpaJve
 leLXug46h8D1UHLeYRsR8dhQ+G/DbutaURO9350tvPY0CVZam2TMvQ3mwzkjO9estyV56wd
 CVG2YYSLgNQ225uITvLWGB7qFpUQyJ0EFArXliy9OP19I7YquQp7DNBZk33ixECUOFE9mde
 +k2zxkN6vi8hYfKx6mMQ0MRgX+L/UF2qR7kF5xaik+xcoZOPcpY23bzWMx1cqOlTQhpjb/k
 iSEwPEAERMKFSiYNI4X/ZXVdln0d5mXWzy1KIgLlh86LNq4DwbdF3D8dB5/ReC5nZWgL/9L
 4lL5Jzm0i6NPTkwzrmyJbBiR6Sqab5igtlzdDVTD/nR/SuZmsrlQl78aQuim/Cziu7hPwj5
 MISzO6CtckS1ikxEJrGkfTIvBmyUKcPwQUvNOgIGJ0K+5QFz2Beu4bMY7nDQzaAGfvVHgM9
 66KfviApk++BZIu6gD+5cdD1Uu/rdlbOBG3X9j97v+Rqe7qNTHag5B4ajzr4nrL9yiAYiHz
 OMclzhk4bw2zmpe6OnxXlENIWeAdq7+gu1WNLKyCXRSz9fsA2c6wIDgz7dyWWVTAa16FYNb
 RuGgj6aJsqj5oiD+8BBR2Jn3PYYaXxDSWMymxvDL9ye5OK3KXeQZAcJkONmibwmFBNtCeef
 RrkOJnaKsQHsVHaML2ImjzgBeXq83hBQ+H15tp3F/ZDfhigOTddtpgFoCbx3wdloUgXDYNb
 0QPZd/yOavcsOR8XQoymslUygNX80LWhzSIUqmJryidhJ+cwr0DDxdqQqzfAT5sQyJusaX7
 G7O3MkfXHSdd9HiUS3vI9CaiLnvqHRQhW6y+12jw8IXFQf4DKUs6bGNjjMJmF7vJAuTrtOu
 QWHA+sD0xMclEPw2sY6eeBevZXQQmVuMEGz20GTXbXIWI314t+6552tdmM8A9/X//zARSjo
 w==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RustSBI Prototyper dynamic firmware accepts the FW_DYNAMIC handoff
used by the existing opensbi FIT entry. Let users pass its binary
with RUSTSBI= and forward it to the same binman entry. Reject builds
which specify both firmware inputs to make the choice explicit.

Exercise the opensbi entry with an alternate firmware filename and
describe the RustSBI input in the missing-blob help.

Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
Would you prefer to keep RUSTSBI= as an alias for the existing
firmware input, or use OPENSBI= for both implementations?

Changes in v2:
- Route RUSTSBI through the existing opensbi entry.
- Reject simultaneous OPENSBI and RUSTSBI inputs.
- Test the shared entry and update its missing-blob help.

 Makefile                       | 6 ++++--
 tools/binman/ftest.py          | 9 +++++++++
 tools/binman/missing-blob-help | 2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 519866b82ea..85638310395 100644
--- a/Makefile
+++ b/Makefile
@@ -1679,7 +1679,9 @@ endif
 endif
 
 quiet_cmd_binman = BINMAN  $@
-cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
+cmd_binman = $(if $(and $(strip $(OPENSBI)),$(strip $(RUSTSBI))), \
+		$(error Specify only one of OPENSBI and RUSTSBI)) \
+		$(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
@@ -1694,7 +1696,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
-		-a opensbi-path=${OPENSBI} \
+		-a opensbi-path=$(if $(strip $(RUSTSBI)),${RUSTSBI},${OPENSBI}) \
 		-a default-dt=$(default_dt) \
 		-a scp-path=$(SCP) \
 		-a rockchip-tpl-path=$(ROCKCHIP_TPL) \
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b..e8b58ce2ea8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -97,6 +97,7 @@ TEE_OS_DATA           = b'this is some tee OS data'
 TI_DM_DATA            = b'tidmtidm'
 ATF_BL2U_DATA         = b'bl2u'
 OPENSBI_DATA          = b'opensbi'
+RUSTSBI_DATA          = b'rustsbi'
 SCP_DATA              = b'scp'
 ROCKCHIP_TPL_DATA     = b'rockchip-tpl'
 TEST_FDT1_DATA        = b'fdt1'
@@ -236,6 +237,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('dm.bin', TI_DM_DATA)
         TestFunctional._MakeInputFile('bl2u.bin', ATF_BL2U_DATA)
         TestFunctional._MakeInputFile('fw_dynamic.bin', OPENSBI_DATA)
+        TestFunctional._MakeInputFile('rustsbi.bin', RUSTSBI_DATA)
         TestFunctional._MakeInputFile('scp.bin', SCP_DATA)
         TestFunctional._MakeInputFile('rockchip-tpl.bin', ROCKCHIP_TPL_DATA)
         TestFunctional._MakeInputFile('ti_unsecure.bin', TI_UNSECURE_DATA)
@@ -5059,6 +5061,13 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('fip/opensbi.dts')
         self.assertEqual(OPENSBI_DATA, data[:len(OPENSBI_DATA)])
 
+    def testPackRustSBIWithOpenSBIEntry(self):
+        """Test RustSBI firmware as input to the existing OpenSBI entry"""
+        data = self._DoReadFileDtb(
+            'fip/opensbi.dts',
+            entry_args={'opensbi-path': 'rustsbi.bin'})[0]
+        self.assertEqual(RUSTSBI_DATA, data)
+
     def testSectionsSingleThread(self):
         """Test sections without multithreading"""
         data = self._DoReadFileDtb('entry/sections.dts', threads=0)[0]
diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index 27dc620bd35..8020e6cca76 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -37,6 +37,8 @@ See the documentation for your board. The OpenSBI git repo is at
 https://github.com/riscv/opensbi.git
 You may need to build fw_dynamic.bin first and re-build u-boot with
 OPENSBI=/path/to/fw_dynamic.bin
+RustSBI Prototyper dynamic firmware can be supplied with
+RUSTSBI=/path/to/rustsbi-prototyper-dynamic.bin
 
 rockchip-tpl:
 An external TPL is required to initialize DRAM. Get the external TPL
-- 
2.53.0.windows.2
