Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0869AC3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 09:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4B2831D6;
	Fri, 23 May 2025 11:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MGBm+G99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A120831E1; Fri, 23 May 2025 11:13:40 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207098310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=72381bbdd8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N8226m005155;
 Fri, 23 May 2025 11:13:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 v5GyFzQceapKCSm5ibFdyTZdfkUgywizYmwANcC6TE0=; b=MGBm+G99d6FKA8eS
 DCCma5o11s0+EO9LuqRKTmN+vJmmDvpWfTW3mEhhCAMDD0zNuaZ/5yqJk/sDHJv5
 HKTCmuEIcW5fFzyXKTAPhugvmEVFCRtz3i0hpyLs7Ks9n3ScHVCZSd4RfRAvJUhD
 nxj6gkS03yGEu7elpCZ7+tuHdwgTvNqZlLQUkfZAPmWWgTlz8pkgkE0c0LoRx4a1
 Sb5J11UNe8i8d4ruF+MLnPjCbzf7heWyw2VjKFmavoiYC2X6/hJkdWSrWIWKy/WX
 19FnKiWGZTwmCmZtxKs7ZIsmg70okpXwSEAOc/Ev6S+7SMDNBZEjvemotyRFXHHn
 h3GAaQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfad1v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:13:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6B80F4002D;
 Fri, 23 May 2025 11:12:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3A08AC2933;
 Fri, 23 May 2025 11:11:51 +0200 (CEST)
Received: from localhost (10.48.86.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:11:51 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <caleb.connolly@linaro.org>, <jerome.forissier@linaro.org>,
 <ilias.apalodimas@linaro.org>, <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 3/3] test/py: tests: gpt: add test_gpt_write_part_type
Date: Fri, 23 May 2025 11:11:40 +0200
Message-ID: <20250523111100.v2.3.Iba2791fee8410d60ed4d60a7850521e29ba23a57@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
References: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
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

