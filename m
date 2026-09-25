Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A80C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADFD581397;
	Fri, 25 Sep 2026 14:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtkD1ZqdAmhs; Fri, 25 Sep 2026 14:27:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1DFF8135A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346426;
	b=fcRtBsT5BQnObKbxSiX8gYOswm2oDRqWWXzYgZUMGIp9WdduZ5yj7Bba6B5x+NoL7bid
	 T7mGFlRAOU/vaX+ZI6XUaTbzbzfo36b44x7nLZJbB4pnQWG25QiTo0+gxUmuE9YhsYLIg
	 9Ll1rRM2x+UfqjwxLGsKQnpgmv6enhql9M07qJWFWtQg+SQlCZlIn9ocUo1lMYcN7lbQ9
	 JVSmIxHxPqnxpy1UoShKEFdzQw1MN4P/uXUm5MOwYBpsrxCo8hIWw4QIHmjx7gctbCMcF
	 0QV5MGhvbONmqtqB/mDO5CNWZX58kCYuFzUsQJ+bhrsRs2v73HqsmgbzPrxo3aUNQtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MGaoFCPeZPPDDZ8VqrAeWP+ah3ZS9l6bbHCAiOkgOHo=;
	b=YveJ0SalPXMLs4aV1mZJnLYxJHc5Vjs0SZZx+Zz+qjiPDl0+JaJ51ni3r4TKgsA/Jd6E
	 0qby9jd6wGH7WbGIsTVHHpiNVOw4nnU6mxF3jiIr+V1kXSXxCInQUqllTP00XO4KaSgVC
	 CGaAp7o5ZM+bu2suEsxObB+5DoPpprmjbkQQyb3EI7qde0mOw2HZH8p1KQ156rubiaI5Y
	 +nWWBphO5Ol7YdYPJbkqZRmVLzv2jlsFdSohYXOrwv9vTVSh8/fVW/3pqtRqvwS2qQtqE
	 x8lkpDU56YCWU891gHzpnoZnakJoifqloyY2S9f8UMr3VKKrgOoHBxbFOFYamoSUDaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346426;
	bh=MGaoFCPeZPPDDZ8VqrAeWP+ah3ZS9l6bbHCAiOkgOHo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvDMxa0fZuRMJs5hFwEUxMwotO1AncwAQkz3+o9ookGoX8LctRR3Bf36VETzV8jyZ
	 RikCqErnd9ssFt7lWxJbb65w5soDV1SdK9viuySBpeJcSfJZITDiQyHLlgzJ29/Vmw
	 HUdqPFJ0IcG+zlbZZrnDtT6qc2Wi6sqzy6Mg8qIY7hoAuzn1sxEn6V67H/t4R3BaqI
	 OEoJl1vRuTC1oZaeTHpS1Zzo5jbgUUeg9W6E1kNBsgNNBcPi691RfeCNTxZidCqdoI
	 YWdJAYD4FSBe/cD2JVIAr3Pdi2TLLM0NlWrva+MOGtCCqQ1NwBf+nW+zcDY/sXk46b
	 VFhWGF5gQ0oGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1DFF8135A;
	Fri, 25 Sep 2026 14:27:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E7D2A33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4469360C13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gPH6EYt5eDS for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 006F6608A3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341105;
 b=FCiHQWvKxzhfz+SJn/QJOQkOVE5FL6XPpzWrPOcS/S5L4MX4nV0lOLaW0hompM8bpyCA
 Ddb8C83IBVodquTn0MrVg7dSJtuq4NkBhep6OKS4m0AXyJ+CbQKoX0IbnqYc7bYxSl3Pc
 mjP7drZEg0b40avxsIVw4dn78ELqlchl+ZWQUpbG77IWL1qnRJLPI59TVKqPMsrjXhONe
 qR220+h9sXCBdSme/z75l2YC0hwYn6oqqTYfZKGt2D9quSzTttYMZyTDpMssBgd9Qb4mD
 SaGj4uB8fju+NQXHa42sYmoFbj6dUs4WvszPSR2sTC+Dj6xh41BuoJQNfMPBhSquQjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=MGaoFCPeZPPDDZ8VqrAeWP+ah3ZS9l6bbHCAiOkgOHo=;
 b=KUueuA00YYIxPsgniv8TUCj3eM5cub7f83XMltdpGt2HTxogSzFE8mPgGJdoZquvNsmE
 JDg0H67FXnIBbnKou0sr3Q1Pb0YQdm4mPmOzLbKvW0Q7wM2G2yGpLgskCiuEo6L9RnrCc
 FvdgcIQmn4ZSle9WJcTQt8hKF3g3qX9rZd6tXkz1BBHQcJIfZafPVe1ICSWkhoIqpAgon
 kvCFxBbQbFm87v8R5qPkV9mMOHi0kZRWtAeZVFr8CEJe8wXZe2NBDSK/Xfje5RgYvHo4s
 nxjRNefXWH2eGgn/fxGTBEe5K75upDejc5FEZAQooUALO0RVGkMWDgWuDF7pWEpEmcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=A6VewCXe; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=A6VewCXe
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 006F6608A3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4YYju208416; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MGaoFCPeZPPDDZ8VqrAeWP+ah3ZS9l6bbHCAiOkgOHo=; b=A6VewCXeBnw1MX9e
 ahrPJiR5i0yrh7kY70ZMSWxloequJNCvtsqctLttb96wk83Ax/Wk0/rpviD/0cGO
 HkRc28hh3px8AD0z/OSBVgQFraWI2gcDu0B09Awc9eXdYDno+btAaPTHzp5o6uIF
 dOMhcLeVH7KHm+X/y75SdwDLuv78fEnSrBDQOgWCQWm07mIAjriEQgOq9YpX9VNm
 VRxFJ280qjgH+iJs0BGrHDFEnRdwQqvevSgnTmk0OmIMi727v3XJo6kWP9geYKJu
 fO16iCd1wOloT3X/MFwoRiyoftckr/eIa1LYkFL07PKaWZ6XeYMcMtXL7p7To2jy
 G4kHcA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898uhv8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCtaHW513605; Fri, 25 Sep 2026 12:58:13 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68PCwDWi517649
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id 8AE2E5DF; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 01/12] arm: qcom: add common QCLIB SPL extension helpers
Date: Fri, 25 Sep 2026 05:57:58 -0700
Message-Id: <20260925125809.1360030-2-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXzPgQZWW8pVxr
 q/yHoto6aaCAiJ4gr/Qs1dTMdXyqVsjvkNh2e20O+1qERgJmKFiTUvIxMyKzRv30Qxkphg1M74L
 5oNunLa23XvE+EjexbHoT/TgpcIERl6VzLN+3pV1df9/jvA+pegpITjTHhfn1z5aBE/7aQ+xGUv
 mZRUSsuzBlYJWoslZfF7ysyfr9fn7paAGBjjkQMDH5zgQiWIJwgAAP4npvZQLh5Hts0xfAGDXm4
 HVrPmuBzDfpaiq6odEe67OGWJFvBNlyv3wxb+fjwOErfJo0kjDBPos/3N49cSbqKaSkXNuOqQJM
 sYIn5MeM8IjJ/vmoMdNIz+tGcUHGdWS8WOwR9NffBPNCcX7aRx/iVKimLwUFFaCqGMJ+DldR4JN
 MPV8u1V5O4FD4QbUVLAW1mPg06eo6pSzzl36CQpDDKL/9mWA30+GjQJAzYDWL6Fb/taI+M1OUhp
 vgJ5MoDbcpfw314JFig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXxFGIw6j/zjxE
 ff0yJeR8r1BE5yC5DJ9xTjXdLemvfxb8svw41Dw2BRyaBiyxXVJQ3Jx5lVBAIRJJm54ispFB0GE
 WQpY56EO5Xsz+Tn/DhhQzKo2jv/RU4E=
X-Proofpoint-GUID: F8G4wsrEmnAXOxvQvO0sLkIQA0tMu1zJ
X-Proofpoint-ORIG-GUID: F8G4wsrEmnAXOxvQvO0sLkIQA0tMu1zJ
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2F8QJI7O2KTJmeVboGYA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |  8 ++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..5aa84a3a6d1 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -27,6 +27,14 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

