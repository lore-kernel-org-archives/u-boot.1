Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608A6C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 11:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D994382A0A;
	Mon, 16 Jun 2025 13:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="igdWZls4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BDB82B18; Mon, 16 Jun 2025 13:29:41 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8384581760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 13:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82620602e9=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GBBdxC024543;
 Mon, 16 Jun 2025 13:29:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 v5GyFzQceapKCSm5ibFdyTZdfkUgywizYmwANcC6TE0=; b=igdWZls4dafi5SKm
 5UKBx5nkw3cGQU8WeGL9Pns+2fCEE41f9OSB01f67F68FSvefrW/bM52dK2Byxs5
 EY4yNHNGqUhJFE5f69RoEaaUMvgMYmcPMK5sCdKi7ULNLhgr448R6jRZygZUD9XB
 AXaxZpkG2+6Y9xDCONYWaAJB+0qx0+OMqX8m66+Di8dm7/oohz8QQl80rk4hsb20
 9DsZnp+LndkKmqAgLbG6uh0wtBNcsq8RwqvcOJrCp5BJZ1jvVj5+cZlfx0T4ape+
 2lDrRJQkm4BwEaEXj08q3yJHO7FGfoLBzBA5WP/Cq2yuisxXGTo+HW3wg4LZ4GY5
 1wLkpA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47afw1gy38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:29:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8FA7F4004A;
 Mon, 16 Jun 2025 13:28:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4791AAFAC4E;
 Mon, 16 Jun 2025 13:27:57 +0200 (CEST)
Received: from localhost (10.48.86.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 13:27:57 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <caleb.connolly@linaro.org>, <jerome.forissier@linaro.org>,
 <patrice.chotard@foss.st.com>, <ilias.apalodimas@linaro.org>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 3/3] test/py: tests: gpt: add test_gpt_write_part_type
Date: Mon, 16 Jun 2025 13:27:49 +0200
Message-ID: <20250616132553.v4.3.Iba2791fee8410d60ed4d60a7850521e29ba23a57@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616112749.17311-1-patrick.delaunay@foss.st.com>
References: <20250616112749.17311-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
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

Add sandbox test on gpt command with partition type for known type.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 test/py/tests/test_gpt.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index cfc8f1319a9b..e6d8792ac1fc 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -330,6 +330,33 @@ def test_gpt_write(state_disk_image, ubman):
     output = ubman.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_part')
+@pytest.mark.buildconfigspec('partition_type_guid')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_write_part_type(state_disk_image, ubman):
+    """Test the gpt command with part type uuid."""
+
+    output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
+    assert 'Writing GPT: success!' in output
+    output = ubman.run_command('part list host 0')
+    assert '1\t0x00000022\t0x00000821\t"part1"' in output
+    assert 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7' in output
+    assert '(data)' in output
+    assert '2\t0x00000822\t0x00000c21\t"part2"' in output
+    assert 'c12a7328-f81f-11d2-ba4b-00a0c93ec93b' in output
+    assert '(EFI System Partition)' in output
+    assert '3\t0x00000c22\t0x00000ca1\t"part3"' in output
+    assert '3de21764-95bd-54bd-a5c3-4abe786f38a8' in output
+    assert '(u-boot-env)' in output
+    assert '4\t0x00000ca2\t0x00000d21\t"part4"' in output
+    assert 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7' in output
+    assert '(375a56f7-d6c9-4e81-b5f0-09d41ca89efe)' in output
+    assert '5\t0x00000d22\t0x00001fde\t"part5"' in output
+    assert '0fc63daf-8483-4772-8e79-3d69d8477de4' in output
+    assert '(linux)' in output
+
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_gpt_rename')
 @pytest.mark.buildconfigspec('cmd_part')
-- 
2.25.1

