Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BB1C5AD55
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A70580F42;
	Tue, 11 Aug 2026 05:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4G6BF-8Qog-i; Tue, 11 Aug 2026 05:19:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 195EA80EC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425563;
	bh=10JebPI6ln9QUiYwuqknRm+7NIzhmAPrPvv8W+5Hbvc=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GzxwN8uCGJDhEDyIyfTqlVdeCe3ilrdU4Uqt6RM7LYzH1ISrAIfXlUEO2FvsnyC10
	 ufeDzWpKfADJYpQ3JNR4Z6blsvrOJhQlRVrAfPrfSfybGNdX5PJkDbx1GQE8Umm7e0
	 ZPoYRKVquazk0men26WFPsZ7LYrPYRst0n59vC577y4eeMcnOKreJHD/0m8pGJ+ISW
	 OaXKBTcPa8Nm/2nLAb8iW/+Hvsvu2V2ncMmgdLn2d91uHbEoRjX5FZelfhvWpuSPir
	 cgwoyk9xZsHWQ7JIMKVHJzZJfgwtHRieZXveWRFeQYc2Sr3x907g9DcZ3b9FPxkyFd
	 M/PO1xH5lihnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 195EA80EC8;
	Tue, 11 Aug 2026 05:19:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 517D8345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37BDF60634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J76OaSAxfCI9 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 69ED060629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69ED060629
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69ED060629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpwad3047714
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:20 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk22ghs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so772042a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425560; x=1787030360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=10JebPI6ln9QUiYwuqknRm+7NIzhmAPrPvv8W+5Hbvc=;
 b=LaODeUhbkAAGD145cLsEF6iQr9HBpBDyhpCByGBzXFOCrec58Q66GsGozMCCRyR/Cr
 VM2d8vc/MN7Hja1Z41DEig41xuPirqz8vjSA9jnpGLv2v4IhSGjBxWXzFWcYddtmpJNg
 LCRTUS98f3u/h01YExoVxl+ZVWmzp79FtgZAAk3ytPjhKdn7mi6T3Uvh5PIs/K5aLFRs
 mCT3hY7eyTWhErmIVPMO9uTx+KL9Q20D4cj78EN9rgxoB7i8IkiMY3KiC9M1ed9C3zzK
 9LqHoKZ2UIDxrofi4aBdN0BN7L9UViSVkl4dn2ryDWYBOs/8n3N4zSEGCtPPvJ0ea2cX
 G4eg==
X-Gm-Message-State: AOJu0YxabZgnFb8ePEeeFSMYskcZ3flLET9H0FXwcwWc4rKdVA1Wj7+s
 hvSjEbaN26QZ8lWDRaXv2dXSDGMGXsWgRTLyEVK2bDYKw0OaeZnfv6trkkRxdBqF3j/daam09dk
 qZLM6d9ucRnP6u0efPjxLt29gKwU4N/HTut8A1m+Ry96xry+sdGwbKrLPN5KvOly3xxmTbtM=
X-Gm-Gg: AR+sD13eIrsf+/XA9QUl/U/47Z62dU1bZfER12K8clKa1ahEAzCwZ7Roa9WkLkaH7le
 mT7TkHbGBpH8Xm45+AHuNhhG+iJnymUdBJaI7TxsFC869V0SOX7Q+qLa0lFufT3N9nNb+t/rOKO
 V54L6ZYapWEucXij2vANfbchqf7RDVPfbDelDr6QL0ZDuQ7KD5EZk+Rxa5eDkJ3Kil7o4rd8qPV
 NmCVfNV5rDeLO8iTN4AhiiMpNOTPU8R7b4uJbWVLhbVxGCGlupICIxUg4AUx0oMO4LM6aqGsvOm
 XbklaaQwaSNI5C5J74mg1CevOBySUT0BTTEe81li2BE/NV/vsQ1GMLoSNFkwV9FoBKBi2c0uJpZ
 CznJLBwxqBF5QNVgrV0v6zLTjd4fXFkra4SDr8u34NgsyfZNloIMLJSebw6LScz1z4osRGwm7Rv
 Tf9v3lJ+KksscaP76Lp/nZbeKvdL/o
X-Received: by 2002:a05:6a21:710c:b0:3c4:397a:69aa with SMTP id
 adf61e73a8af0-3cc2bacc5b2mr1220982637.31.1786425559775; 
 Mon, 10 Aug 2026 22:19:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:710c:b0:3c4:397a:69aa with SMTP id
 adf61e73a8af0-3cc2bacc5b2mr1220949637.31.1786425559324; 
 Mon, 10 Aug 2026 22:19:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:18 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:37 +0530
Subject: [PATCH 2/8] reboot-mode: add trigger op and request/list helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-2-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=4927;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0rQHaPKBmQM0cys3tkGKHu+DtGoGoh+DNhp7lt5fBFo=;
 b=4UbQudoNnOlkLohk8AwYBGIDeGxhwU2dDacIXtmvN45d4/zt9vqoYeY4DcJ73BdnMlV2GT1oZ
 HzpD88ezzogAyQKxyvbR1IZP78wZf+/g9U6Scp/LuacQLkGwOclAms5
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXzn57KS4gAIY8
 Y/uq2sjBJpqVv1Dxjq6UFjA2WoFPp8GOqxDfW7ag8XI/toDGS8NeYs8cTpJ0dy8AAP+vqSf36HD
 jisJa6xz3qSC8iDnLPk1nP3jFBgn84Q=
X-Proofpoint-GUID: RPVFpeQxiuaX62U3WilU0JOzH7Ln2Z0n
X-Proofpoint-ORIG-GUID: RPVFpeQxiuaX62U3WilU0JOzH7Ln2Z0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX/WvhVjbSgAIf
 rrOh/MbUHHROumgPOO7GzMZWg74H7xAnNQnhAYE0ujMfHdEVvWiQLUJes5KnDguN2ceopjDBuUI
 FosnGReBLRUkWVqPLuNuHSFLgGEB0xhMLhQMdnoqbyZjq2S2VdYEhN8nVaeO06bs8LyhGEVEwf4
 envnzE8qViE6kA/wmZUrKWIWehtnFjWABYPQW5OmtcPTsJLr9ykrMnlojng0hzgWB7v0xPfIcUi
 pv2u2qqqisCnoxXsXd7twTxYQTbPQ6vGn3Y2teJRO2mULu78mzYL+TbWt1Ec8ye/xmIrRvmh6UC
 edDVTe5Qe/L9+sK60ezcNwNCh9oUxtMNJIZV8Qco5Sy1T4e3Qoxn9oUng4rTqZ6yMqjsWzFAwsu
 RTauvybI8EQsDMkaHoi1jY/qdNw6hHS+gMPrgWwiU5VSWzbneVLMtHvMDRfQRTJUNw2C+PdoLNh
 X30H+8KXFmSORJqc64w==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7ab0d8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wfIYZ1SAQPJO3eOegYYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 10JebPI6ln9QUiYwuqknRm+7NIzhmAPrPvv8W+5Hbvc=; b=R4EwVi3fdi8fZQHt
 MJOApqbgJJ3O+nf26tCpfdMetGmN7y2BEylw4U95mbl4PwwRR08VbwTtemqxurjL
 Ryw1x2O0b7JktQwajAokk+I0l4+8Sx5AU06CQYJXetSg7Og8LKFjZn14x67xVloB
 U54e+FrKnhsmvnQDHoxZ2ep8A+sgCQSRjVCQf3s9/I07fVMN1FmITPSEzRHhpRd2
 mmr2H1wTMylKrbPYpZl8UzZcgsBkgK3W2G4IJU/kZsEnrPH7Qfgp+RUceRLpwABj
 XMs0ubzZAzesN79Pa1BXqhbuu2jJqB4/133vMDzPAqFrBZ+AG6x5MOLaZAIU0KXL
 DjfOPQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425560; x=1787030360;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=10JebPI6ln9QUiYwuqknRm+7NIzhmAPrPvv8W+5Hbvc=;
 b=AGZadUVYcu1uZdQqFx8mztO3TdFxLI+2r6MyKBb409ALPZVyQmhNG0wZiqtk35pzx3
 pJgrC/7G/o80S4/5St0jNenapc6RAe9kLnbWnBDtneksJRXGAeYY6ETPOn+4Q6e3RM9p
 K9ow/Rf6RAuCqNsipeKXivDfUOY8lKsWq5j+6cufCupyBKKyjjRwUuuBAhqvarSDjYD2
 wuoFJ4CwG3IiYOnweUTd0AuvvacT3YajlJJtCXlwF/1pa6bRWWCy257IgBkabN0EK8Iq
 qFA+uE9hQInhdACJQ3Crg7Ausa6YV0wVFNuhY9UIxJsTEVMqRDQF+aTBVrflL3tR5WB/
 l/iA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=R4EwVi3f; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AGZadUVY
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The reboot-mode framework so far only reads a value from a backing store
on boot (get/set) and maps it to an environment variable. Triggering a
reset into a specific mode on demand - e.g. rebooting a Qualcomm SoC into
EDL via a PSCI SYSTEM_RESET2 vendor reset - needs a different approach.

Add an trigger() op to struct reboot_mode_ops. It takes the
decoded magic cells for a mode and resets the system immediately; on
success it does not return. Backing-store drivers (nvmem, gpio, rtc)
leave it NULL and are unaffected.

Add two uclass helpers built on top of it:

  - reboot_mode_request(name) looks up a mode by name across all
    UCLASS_REBOOT_MODE devices and, if the owning device can trigger,
    resets into it. Returns -ENOENT if no triggerable mode matches.

  - reboot_mode_list() enumerates every triggerable mode registered with
    the framework, so a command can present the available modes to the
    user rather than hard-coding them.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/reboot-mode/reboot-mode-uclass.c | 48 ++++++++++++++++++++++++++++++++
 include/reboot-mode/reboot-mode.h        | 40 ++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 80aabf54750..866a56ecb7b 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -54,6 +54,54 @@ int dm_reboot_mode_update(struct udevice *dev)
 	return 0;
 }
 
+int reboot_mode_request(const char *name)
+{
+	const struct reboot_mode_uclass_platdata *plat_data;
+	struct reboot_mode_ops *ops;
+	struct udevice *dev;
+	int i;
+
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
+		ops = reboot_mode_get_ops(dev);
+		if (!ops || !ops->trigger)
+			continue;
+
+		plat_data = dev_get_uclass_plat(dev);
+		for (i = 0; i < plat_data->count; i++) {
+			if (strcmp(plat_data->modes[i].mode_name, name))
+				continue;
+
+			/* Does not return on success. */
+			return ops->trigger(dev, plat_data->modes[i].magic,
+					    plat_data->modes[i].count);
+		}
+	}
+
+	return -ENOENT;
+}
+
+int reboot_mode_list(void)
+{
+	const struct reboot_mode_uclass_platdata *plat_data;
+	struct reboot_mode_ops *ops;
+	struct udevice *dev;
+	int i;
+
+	printf("Available reset modes:\n");
+
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
+		ops = reboot_mode_get_ops(dev);
+		if (!ops || !ops->trigger)
+			continue;
+
+		plat_data = dev_get_uclass_plat(dev);
+		for (i = 0; i < plat_data->count; i++)
+			printf("  %s\n", plat_data->modes[i].mode_name);
+	}
+
+	return 0;
+}
+
 int dm_reboot_mode_pre_probe(struct udevice *dev)
 {
 	struct reboot_mode_uclass_platdata *plat_data;
diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
index 54a8c09650e..67be5e4b3eb 100644
--- a/include/reboot-mode/reboot-mode.h
+++ b/include/reboot-mode/reboot-mode.h
@@ -46,6 +46,22 @@ struct reboot_mode_ops {
 	 * @rebootmode:	New reboot mode value to store
 	 */
 	int (*set)(struct udevice *dev, u32 rebootmode);
+
+	/**
+	 * trigger() - reset the system into the given mode now
+	 *
+	 * Unlike get()/set(), which persist a value for the next boot to
+	 * consume, trigger() performs the reset immediately. On success it
+	 * does not return. Drivers with a backing store (nvmem, gpio, rtc)
+	 * leave this NULL.
+	 *
+	 * @dev:	Device to trigger
+	 * @magic:	Array of @count 32-bit magic cells describing the mode
+	 * @count:	Number of valid cells in @magic (1 to
+	 *		REBOOT_MODE_MAX_MAGIC)
+	 * Return: does not return on success; -ve on error
+	 */
+	int (*trigger)(struct udevice *dev, const u32 *magic, int count);
 };
 
 /* Access the operations for a reboot mode device */
@@ -59,4 +75,28 @@ struct reboot_mode_ops {
  */
 int dm_reboot_mode_update(struct udevice *dev);
 
+/**
+ * reboot_mode_request() - reset the system into a named mode
+ *
+ * Search every UCLASS_REBOOT_MODE device for a mode named @name and, if the
+ * owning device supports triggering, reset into it. On success this does not
+ * return.
+ *
+ * @name:	Mode name (without the device tree "mode-" prefix)
+ * Return: does not return on success; -ENOENT if no device declares a
+ *	   triggerable mode called @name; other -ve on error
+ */
+int reboot_mode_request(const char *name);
+
+/**
+ * reboot_mode_list() - print all triggerable reboot modes
+ *
+ * Enumerate every UCLASS_REBOOT_MODE device and print the name of each mode
+ * that can be triggered (i.e. whose device implements the trigger op). Modes
+ * that only exist to be read from a backing store on boot are not listed.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int reboot_mode_list(void);
+
 #endif /* REBOOT_MODE_REBOOT_MODE_H__ */

-- 
2.34.1

