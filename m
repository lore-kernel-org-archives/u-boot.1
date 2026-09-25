Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5688EC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2527260E1C;
	Fri, 25 Sep 2026 14:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13VHGG0ZNKAA; Fri, 25 Sep 2026 14:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12AD560E19
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346440;
	b=eAnOQWBbUDx5uWRRNsQomhMTNoJcUGkJsnutL/KRzQe/M0O5wB4t/gO2THm5uwv8w/c8
	 sdAvHZXBVwyj9AtpSkTPsoqvf9/ga3FvPJ5g9YkAWNXX6cjuSBGiXA+0yAqV4/9r6DrHV
	 b6AjQ6ULGDKYF7Uv/ldgkzgY5sN+GqeoeouM82gH8wFbAi60wtjx0qZRSqYSmo4qEVeuY
	 FWJsEYAlgrZVW00fjhnrygvj6uG3iPMZ5/vMLK90o130obHOxLskiUcQIeozjrvvfH5jW
	 Yf0biiu0MYrJSF0+DL28wC9g5PyKh2lsDsr/bAoskW6NW1juFsaIcYWU0Ie8cHBy2vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a842MxeR+G1BZDAlvv9tNrN4TcFdFy59/mhwUNIorJg=;
	b=gneM/HX4EUSzyMBGRogD17KEirS65Y0z0sqdkw82vfF6ccb6yfz2Zxf1x+i91ZyDi/ke
	 MeaWvlV9yXgI62zhJnPB3H35HkVVC9RMGtkxcUmRPlC1SYD3Pao75ijO5vuVwoCdbwsJb
	 YaxLUzvYaVFGPBWI8V9Lf60eJ/Jo+dGCnWdLqJ1x7cicoEtDiinwn7ZTRrnHvI5ksj0gZ
	 xdiq/fC93p52n9QUYaJLR7zmM1t2ZL94cK++WjHe2c7RZC0zwekLN/PEeAwEKczfINZmV
	 zECum5uLfEzbKHSnX8d0j3kVjO8VFs7qLj/KqTPtCGXokudU4fwHn5U3wJEsNndgNKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346440;
	bh=a842MxeR+G1BZDAlvv9tNrN4TcFdFy59/mhwUNIorJg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeMoDPkBC1Ui6rdSoSnHddRSZ/K0ow0yhOpZbosLbabrugOOK+ZB6xxkYu5Js10xS
	 AjPFE+OJDwigvuX7bfYKbexFlmaDT+r65jCm8hwvtsZNs5qJ7A9cQl1hWftZUzOtel
	 UsQhdH+KXtvG/ogmhrswktmwhW17ajxKVh8d6xrlLQDz9nybFxShWaj1Inlb5a4mGn
	 0vH2dwStDOl0gg1xWFAmk5OtJKiVPOmqMENNR4zqY2CPSeoapZtAF17JTur4702VuW
	 f8uAGV/dayOSYvMJgY16OfvA4yt1AIEHsXaHMdQTMvSZIDuUC2ZFHkLTAQO36zNK09
	 1VntkF562yHQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12AD560E19;
	Fri, 25 Sep 2026 14:27:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 436E5E13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 317E981208
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVOBtxPj8Ekf for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 61E9D81214
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=MwVjYBFy6hXIYXyjjXeOa9xBgInVGQJUFbtUC/pc3ci3wZaLn+GSm95VH+AiP/d0tVrd
 Fx8SrUgy5C7bAhvenLwAXM5B+vUDdlj8ycy6JaC/gOHhLNDKwDD0VKJ7IdnnG1hMM8uOj
 Hx1m+wGQc335zzDBaINX5jkv/o8A38xgv5QpVDf8dM/K0X1YpZgcuJSPDmk5mpFLeRgeS
 Z3T3F8psy9PLRsWx7nuqwVHp1CYABeQJirNMK08EHp3uw7x34EcmEF+P5EM8zcKDAGToc
 GqtUfwCPrWxduLO+2h1RmB9rI8mRuSwWAMShD1m50QoZGI8IkXBm/VlnZwNTcaIjwYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=a842MxeR+G1BZDAlvv9tNrN4TcFdFy59/mhwUNIorJg=;
 b=DoSwq1snNOEtsj8VFhgYAG/p8Yk8DY/tqRwii3HFb5TqWUqnrHg7dTvucB8KJ9ZmFIeu
 Yy3jWE3MYMr6P6T3PaxxrbtiO+y73fU3A0Rw9HC661zFRjsn8nZBbXCjQBPJDJYsKlSk/
 NQloPqGcPPPz0UAwfcqCO+zupPIqq6YiWvza9NN1UQUHPctTLEyKKTvUrEaoukGjmRWrm
 KU3rPRdjSuni/6ufA7eS5Q/mW2VkLzZPXPCaxdandCDQJAu9UXzAweWfGtwgRUYRrd7mh
 5iKxIlapD9Z1c+KIH99kaJZKGKHwMxR5bxDeGTMOt4Z6TD8bU8B+GOvJRyJLDZmhffQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NNNUvYhr; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NNNUvYhr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61E9D81214
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:27 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5IjeT600037; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a842MxeR+G1
 BZDAlvv9tNrN4TcFdFy59/mhwUNIorJg=; b=NNNUvYhrThThBwAHmaiqxFYIQdL
 4tZRY+F80Yb6w32mi4Or8z3+vvlA2enwu5mQ5p5nyvTY4Qw45qcz1I6lMxqAB7+G
 80eIo0DZBJll1wb1lAfTwWlYSTCUctzsFFRqlvr171J1K6Mnyh0yxZFDLliq7pdq
 8gYjND9wrjCoF35CMmATqPQuY5f62lAtnKZXzg2FOhkn0H1ej8hfi7sgIne6TTBy
 gHu2CaVyv8pnHqbyQiO61fBTcZX9vXm67x7NpUWRoSN5eDw9l90elUqC+LSXjDad
 TarGwQsFZbWPprW3QYeI0JpxuDqj2C2ggce2OcBIX9To3zdmiKtvQE+cPWA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsce9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwEMV496548; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 68PCwDfZ496534
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id BE9CD61D; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 08/12] misc: qcom_geni: load firmware from declared storage
Date: Fri, 25 Sep 2026 05:58:05 -0700
Message-Id: <20260925125809.1360030-9-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: bJI7hqtIw8OAX3DMdSDjlprbqHSu7CWb
X-Proofpoint-ORIG-GUID: bJI7hqtIw8OAX3DMdSDjlprbqHSu7CWb
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab66fe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=HP6otEFghPAS_JqAjQUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX07uXjEcdWI+/
 p9R5ifiFCzXQ16xCv2ZN3qL584iq8xLexoCtm7HtCYNp7OqoK7Uar//lmq9SmcKdwSVGRFC/LXv
 UMtaKGsHk/Upf4/VyRztK5a/qQTaIPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX4GmnHJM5i+Xk
 EhhtMuflS8a2bh6AN/rOx9s9Oqc1iIGVmnQk5KKg445W24sroPUZ5FZgQjpWbkzam5W75y3F6ka
 rSkQdDON/OsnQht09dqnSR6v6qnUKIDQqCpD9/+HZX+/rZ3eMfZYNFBSDLYkw4635QEmngamTcM
 6qf8lMVm3TSgWxyRhfb7ogqhueXvZYEl9LYL03VlzMvGFz4JkRiO6I1WBOdKetYf5CxDLXzp+K8
 vs3j04W6q3/vmmCfL7Cqn70eZ/bJVknPmlLZQrmlBG7TOPOOG4Z1t9tQ2C9PcULoe39NyE2TmZ6
 PVm+d0cLMWGiz8DxmEILMe8dv4NSINx9k9JNj+OL3B6ZWXURtRVyUoO4Ay+R8mnZ/SslDrlZ0qe
 sJun3oDl61gc/Pas+E4RK18GZ8eDw9citfQVrXpD8yAEvzs5cZo6h/hWcZk98zM8XNu5EBhZ4Gv
 +Ujtczf19+21DOP6x7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Obtain QUP firmware storage from the wrapper DT node,
initialize the selected MMC device, and load the QUPFW GPT
partition before probing serial-engine children. Enable
wrapper clocks before register access and release dynamic
firmware after all consumers have loaded it.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 98 ++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index f3133f85885..f77afd5bb6f 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "GENI-SE: " fmt
 
 #include <blk.h>
+#include <clk.h>
 #include <part.h>
 #include <dm/device.h>
 #include <dm/read.h>
@@ -17,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <mmc.h>
 #include <misc.h>
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
@@ -34,6 +36,7 @@ struct qup_se_rsc {
 };
 
 struct geni_se_plat {
+	struct clk_bulk clks;
 	bool need_firmware_load;
 	bool is_mini_core;
 };
@@ -446,14 +449,30 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
  * We need to determine if firmware loading is necessary. Best way to do that is to check the FW
  * revision of each QUP and see if it has already been loaded.
  */
-static int geni_se_of_to_plat(struct udevice *dev)
+static int geni_se_probe(struct udevice *dev)
 {
 	ofnode child;
 	struct resource res;
 	u32 proto;
+	int ret;
 	struct geni_se_plat *plat = dev_get_plat(dev);
 
+	/* Enable the wrapper clocks before accessing serial-engine registers. */
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret) {
+		dev_err(dev, "failed to get wrapper clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable wrapper clocks: %d\n", ret);
+		clk_release_bulk(&plat->clks);
+		return ret;
+	}
+
 	plat->need_firmware_load = false;
+	plat->is_mini_core = false;
 
 	dev_for_each_subnode(child, dev) {
 		if (!ofnode_is_enabled(child))
@@ -476,32 +495,63 @@ static int geni_se_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int geni_se_remove(struct udevice *dev)
+{
+	struct geni_se_plat *plat = dev_get_plat(dev);
+
+	return clk_release_bulk(&plat->clks);
+}
+
 #define QUPFW_PART_TYPE_GUID "21d1219f-2ed1-4ab4-930a-41a16ae75f7f"
 
-static int find_qupfw_part(struct udevice **blk_dev, struct disk_partition *part_info)
+static int find_qupfw_part(struct udevice *blk_dev,
+			   struct disk_partition *part_info)
 {
 	struct blk_desc *desc;
 	int ret, partnum;
 
-	uclass_foreach_dev_probe(UCLASS_BLK, *blk_dev) {
-		if (device_get_uclass_id(*blk_dev) != UCLASS_BLK)
-			continue;
+	desc = dev_get_uclass_plat(blk_dev);
+	if (!desc)
+		return -ENODEV;
 
-		desc = dev_get_uclass_plat(*blk_dev);
-		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
-			continue;
-		for (partnum = 1;; partnum++) {
-			ret = part_get_info(desc, partnum, part_info);
-			if (ret)
-				break;
-			if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
-				return 0;
-		}
+	part_init(desc);
+	if (desc->part_type == PART_TYPE_UNKNOWN)
+		return -ENOENT;
+
+	for (partnum = 1;; partnum++) {
+		ret = part_get_info(desc, partnum, part_info);
+		if (ret)
+			break;
+		if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
+			return 0;
 	}
 
 	return -ENOENT;
 }
 
+static int get_qupfw_blkdev(struct udevice *geni_wrapper,
+			    struct udevice **blk_dev)
+{
+	struct udevice *mmc_dev;
+	struct mmc *mmc;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MMC, geni_wrapper,
+					   "u-boot,qupfw-storage", &mmc_dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(mmc_dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret)
+		return ret;
+
+	return blk_get_from_parent(mmc_dev, blk_dev);
+}
+
 static int probe_children_load_firmware(struct udevice *dev)
 {
 	struct geni_se_plat *plat;
@@ -558,6 +608,7 @@ static int qcom_geni_fw_initialise(void)
 	void *fw_buf;
 	size_t fw_size = MAX_FW_BUF_SIZE;
 	struct geni_se_plat *plat;
+	bool is_mini_core;
 
 	/* Find the first GENI SE wrapper that needs fw loading */
 	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
@@ -575,12 +626,19 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
-	if (plat->is_mini_core) {
+	is_mini_core = plat->is_mini_core;
+	if (is_mini_core) {
 		fw_buf = qup_mini_cores;
 		goto mini_core;
 	}
 
-	ret = find_qupfw_part(&blk_dev, &part_info);
+	ret = get_qupfw_blkdev(geni_wrapper, &blk_dev);
+	if (ret) {
+		pr_err("QUP firmware storage device not found: %d\n", ret);
+		return 0;
+	}
+
+	ret = find_qupfw_part(blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
 		return 0;
@@ -623,6 +681,9 @@ mini_core:
 		}
 	}
 
+	if (!is_mini_core)
+		free(fw_buf);
+
 	return 0;
 }
 
@@ -637,7 +698,8 @@ U_BOOT_DRIVER(geni_se_qup) = {
 	.name = "geni-se-qup",
 	.id = UCLASS_MISC,
 	.of_match = geni_ids,
-	.of_to_plat = geni_se_of_to_plat,
+	.probe = geni_se_probe,
+	.remove = geni_se_remove,
 	.plat_auto = sizeof(struct geni_se_plat),
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
-- 
2.34.1

