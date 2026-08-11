Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15B9C5AD55
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 430CD80ECF;
	Tue, 11 Aug 2026 05:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-YTVbRpzCys; Tue, 11 Aug 2026 05:19:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 042C080EB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425559;
	bh=CEB8rUnGjAE9JpA/mDPCK5X9XqscSRuSSlmuWQ6H354=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=klkA387EjRygZE8+vSh3M+lITtJkfOGjHOCQ7oqHcaHbi3MReR/5AyqIe1Lx3yliF
	 OwgtQ2Rw7tw5AO8vuULmHpnoJeEDS3FFxy+483aLwD97FpgzxPgYcAUlGxpsF9FDle
	 NdKWf2DdPGcTHjKK7hSAon0S1i2i8E1tIPG1sxyI9yamU80cGoUhEWURQmomC8BhUg
	 6dSyg28EGfgLn40IsJHzVXkKv1VVdlfmTzFGmvx2QWd8nvkQdZ4h5aHmdLPzyRC+t+
	 aZoDBJFnEkS6EiiHPPoDqsVyIeeYmizUruTcuJ/RDHcL517PD7ANnXDZ+YjJbCJNY3
	 IvLMbp14GNf6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 042C080EB3;
	Tue, 11 Aug 2026 05:19:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48F59282
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AEE560634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9Vo2LaC6jEF for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30E2060629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30E2060629
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30E2060629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMt3NU3314270
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:15 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyftccm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso3401436a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425554; x=1787030354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEB8rUnGjAE9JpA/mDPCK5X9XqscSRuSSlmuWQ6H354=;
 b=CMwxt0Cz9xGUFjSGMvWxVwQ+VdQfvh1XaKPCoVcozMWLIqfGIqQOxmkYnbD0UWfkrG
 h96GXGEV3MNk9Xu8EeydM4k8bpz79gvNfLD7cmXyBIR7vqjpkZ22e0a7UYZrPloA6hp7
 O5IxZ1VRK07232KjS5W3rXjZk+5xqCRqfqg+fvAJJY0VGRt/XE9pL7ZAGVLZXg2nLT6u
 nK89uxQAto9kArCH8tf9hJTZPKvTOeF4gNyZF5pkDmtwNE4VbDi+9R/WMphhRxl9yUMT
 mfYjkKu//seonD2NZM5JX/scRguHaLM9vyg+FlYfM662SKdCjP4c/0aK9chUTin0++9H
 GB/A==
X-Gm-Message-State: AOJu0YyqIUF4aaQk2DAXox0s3FeAmgXSoUeyakmj00LkkHM7I4AhD6+C
 sKrDW6/EpIPEqOzPtNswx36KlH9nrWSDR4vT0YT1RYKUjnde0tyBaTOWIIm9IYvJ8/f3xbuUq1o
 bk+MwUAXNOe+N0yhZCO7GsEqo1ACrXc/nXZxIK6wM+IYdtVcUFmUK5v3Fr7CMlzBEad/8FXY=
X-Gm-Gg: AR+sD1147yNCgKulnMfWB74m63AhzEM7nH+U8beGKWc0mqwdMJt9e1b3HQLOdx4PbOb
 5LS6DhaqTMmXdhKrfUkwUdeBudx3tPSaY8zUmw74XV/xd8+f5J43B+LVJlOVo9Pzqj7D7eD6jfq
 gh+GGcuHpHwv6bMU0nrFf56qAm3XxqxFqOjbz9hFYXPu41vj1LZy+qX9MEMLT5IkixshcUdm+LC
 MtNZLphnO5u064p0OpYtXdqO+sutSBgunRuJ3WFwVVHNXGWTLK7e2bCMqgiYwS9eYS6x2JdzUup
 VdAnmWgyjUKL919iFTHEJQfhdVSUUdzHzcMRTByDwLPatq2rOm3V1eFYDHlY20gPzoqxpkIront
 jJ2eQI7CsZNIEYTrVWikBR/9po8TfNnLzmc8LaBRqeR0XWnaxQzEHeBQep8qjdhkNrbsYfbemve
 j6nMKozzqwfrl3uF69Q17NtTDLnzq+
X-Received: by 2002:a17:90b:1d8e:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-392ec3a9ca1mr686344a91.8.1786425553766; 
 Mon, 10 Aug 2026 22:19:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8e:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-392ec3a9ca1mr686319a91.8.1786425553253; 
 Mon, 10 Aug 2026 22:19:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:12 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:36 +0530
Subject: [PATCH 1/8] reboot-mode: parse up to 3 magic cells per mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-1-2e15adc156a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=3854;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WxQo5kkncHeCwbo0OD6u4Gd+LTcnFC4aWZjfGt0KvtE=;
 b=Zn/TrZCmjXSTlIU4/qZ27CcP0hzBKmozJjuQzWihQNdk0BmMYvFuh3yWKMX1X6PLQps9oXJLp
 tYJkK1+mmHFBvCjeIgBuk/sYi+zFELkxBWvijGQdvvnbG8XQNASp++p
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: cqqn_RELCou53sjhekrOq-Tbzwp4xMEf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX+qJdMMsnyH/P
 aPR9b4IImxNDlbnWZXoaqzls8eIfwqZQMtLGmqBk+0SaMIwoOriUF9zzIvvzBLQ7yPIrIR9kBWt
 qO/P5x0+ScbkElOyO4XmqePobw9lQI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXy08QiWc68AkE
 Afmof2xJhlme2EJ7FRGRAOpS8R048ziTdzAkNawFL407IoWnPNOVHnGwKFwTCwiDWPIZYV6ur4z
 F3mPm2RgBKkEsZ89yqUQXwXbszDKaRstbacUNWYuZD/T6U2a4lV2aYuMu+cMVTmE/s2fIJWgg9b
 tNPkIfDJW+Cq8wki9I18ew5ARDWIf4+Kv7RjBmD6EIMWTCeYgipsZ5Hqr2xSnAQcamymptaBb4H
 mQKiuxiUsLU3JnjCR8B3cxmVXx5FJjZWBE+DkDZQpCDTkaqLpTifdsZFtPA98Ia3oF65vd8Cx3j
 Kdol2ys79tPIpbePv6P6BRBVaPcIveWeFSoMgihLAhp1hC15yJNOum3KimYUf6XeVymrQ6gJGKi
 ahIN1Zyw4axHbh2tFL2rHSwzNdl7RQWwPfWMlidA77laraO33y1C1ghVnPnO3M7O1y9GsR07Wg2
 VWdop0SEcz5WOFArGdg==
X-Proofpoint-GUID: cqqn_RELCou53sjhekrOq-Tbzwp4xMEf
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7ab0d2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GESHroN6_YRezIVDoYEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CEB8rUnGjAE9JpA/mDPCK5X9XqscSRuSSlmuWQ6H354=; b=C632EMD/UnYnmq0D
 zj8xj0dKIC9VRjmKta8B7Kw9UZCvmT8eEaEN2SrxQXEMzjDV33UdPg0hRW/khLw9
 DftbOAV3+DKhuYByrp268OUYfheXqerRdMau5S7l4PjKVJu6aPbSTuyblyvCmsJt
 Yo30ZkF4LFYk5ItaFmF3Ypx9nEMDinQ6eV/uEn2nRrqbQBny6SP+vvAXQ1jO0k5P
 8hPuaBNwYS7bwRTX4g00VlFLnVyXj0fhFp9Ldx+yIb2FM2yXUMh0ac0Dn/RTxorE
 nLqnzihl3CjyNktxfbCqY2bG7iBpjnXUC3P7+wtKK3GncarRRH017BY949V4QCd7
 xQv5ug==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425554; x=1787030354;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CEB8rUnGjAE9JpA/mDPCK5X9XqscSRuSSlmuWQ6H354=;
 b=MIFbAsjxGm8ImrAwqLQiOdnRpl+S5gCXZMFjJ3xcxKCf+Zkr2Bca0Jgj/A2kDrp3pi
 2UKDTiBRMOlUe/ddVwWMnXkKgMncqo4oTfMt/R6jVfgh7A/ntX+o5tIIKkxjOnZwStLA
 /uY1dIWtOt1W8MxOGuCPHPe9h5TyVLzwSkk2/MnYO4QiJi7Olhfh6jEkjnHspkPXiLPi
 Aj+eUSCkXhvhQE0EQpCk4Nhy7f2pMGnegEAN2o32ekgdAlAiSfSSAben4Tagb1Pm6PaW
 AqgH8131RCJI5k4zcLt/IWTt7M9bZ44K2Rd4wiuHFlLAaTQz1/dbQkVF6wC3pmcEKIVw
 DCvw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=C632EMD/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MIFbAsjx
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

The reboot-mode framework currently stores a single u32 magic value per
mode and parses exactly one cell from each "mode-*" device tree property.
That is sufficient for the existing backing-store users (nvmem, gpio,
rtc), but a PSCI SYSTEM_RESET2 vendor reset is described by up to three
32-bit cells: <reset_type[, cookie_hi[, cookie_lo]]>, matching the
reboot-mode binding for the psci "reboot-mode" subnode.

Restructure struct reboot_mode_mode to hold an array of up to
REBOOT_MODE_MAX_MAGIC (3) cells plus a cell count, and make
dm_reboot_mode_pre_probe() length-aware so it reads 1 to 3 cells from
each property. dm_reboot_mode_update() now matches the backing-store
value against magic[0].

Existing single-cell modes (e.g. nvmem "mode-bootloader = <0x02>") parse
to magic[0] = 0x02, count = 1 and keep matching exactly as before, so
there is no functional change for current users.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/reboot-mode/reboot-mode-uclass.c | 28 ++++++++++++++++++++++------
 include/reboot-mode/reboot-mode.h        |  8 +++++++-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 7cbe02eb4ed..80aabf54750 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -30,7 +30,7 @@ int dm_reboot_mode_update(struct udevice *dev)
 		dev_get_uclass_plat(dev);
 
 	for (i = 0; i < plat_data->count; i++) {
-		if (plat_data->modes[i].mode_id == rebootmode) {
+		if (plat_data->modes[i].magic[0] == rebootmode) {
 			ret = env_set(plat_data->env_variable,
 				      plat_data->modes[i].mode_name);
 			if (ret) {
@@ -68,6 +68,7 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	struct ofprop property;
 	const u32 *propvalue;
 	const char *propname;
+	int len, cells, i;
 
 	plat_data->env_variable = dev_read_string(dev, "u-boot,env-variable");
 	if (!plat_data->env_variable)
@@ -93,19 +94,34 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	struct reboot_mode_mode *next = plat_data->modes;
 
 	dev_for_each_property(property, dev) {
-		propvalue = dev_read_prop_by_prop(&property, &propname, NULL);
+		propvalue = dev_read_prop_by_prop(&property, &propname, &len);
 		if (!propvalue) {
 			dev_err(dev, "Could not get the value for property %s\n",
 				propname);
 			return -EINVAL;
 		}
 
-		if (!strncmp(propname, mode_prefix, mode_prefix_len)) {
-			next->mode_name = &propname[mode_prefix_len];
-			next->mode_id = fdt32_to_cpu(*propvalue);
+		if (strncmp(propname, mode_prefix, mode_prefix_len))
+			continue;
 
-			next++;
+		/*
+		 * A mode may carry 1 to REBOOT_MODE_MAX_MAGIC 32-bit cells.
+		 * Cells beyond the maximum are ignored.
+		 */
+		cells = len / sizeof(u32);
+		if (cells < 1) {
+			dev_err(dev, "Mode %s has no magic value\n", propname);
+			return -EINVAL;
 		}
+		if (cells > REBOOT_MODE_MAX_MAGIC)
+			cells = REBOOT_MODE_MAX_MAGIC;
+
+		next->mode_name = &propname[mode_prefix_len];
+		next->count = cells;
+		for (i = 0; i < cells; i++)
+			next->magic[i] = fdt32_to_cpu(propvalue[i]);
+
+		next++;
 	}
 #else
 	if (!plat_data->env_variable)
diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
index 5fbd7c801af..54a8c09650e 100644
--- a/include/reboot-mode/reboot-mode.h
+++ b/include/reboot-mode/reboot-mode.h
@@ -9,9 +9,15 @@
 #include <asm/types.h>
 #include <dm/device.h>
 
+/*
+ * Maximum number of 32-bit magic cells a reboot mode may carry.
+ */
+#define REBOOT_MODE_MAX_MAGIC	3
+
 struct reboot_mode_mode {
 	const char *mode_name;
-	u32 mode_id;
+	u32 magic[REBOOT_MODE_MAX_MAGIC];
+	u8 count;
 };
 
 struct reboot_mode_uclass_platdata {

-- 
2.34.1

