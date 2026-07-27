Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7AAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 154214072F;
	Mon, 27 Jul 2026 15:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhnMPZGtDFd3; Mon, 27 Jul 2026 15:57:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F4ED405DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167823;
	bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uql76wcZ9ctOw3wtU43WFiADLtjyq4aocCTAxpNJM+/GbnspqHNGeD5XBDm53Wcm/
	 gnGhLeixQGLjaDNKBRdneJ0IoEl0RC9LBNRXeY7PJs5EVLa1r/zftiUvp05/EJ5dQS
	 iUrdMrBiRMYi5+IU27uQ4UddFgjZK9pihDmoR/VQdreh5QyskHCMK72niRxfOoZ0Kx
	 6o2KnEX3pGNBKNvMY3/VKt+Es0RZbhbJgJMgtHxKlKDmzYgCZ4vugq3aokcArrrs9J
	 IABZSbIFW5+cfe6zE964oVzKuNm0/rozK7LOmOfHkOoXO/4UUTKLXsTeY8aG7oEDzB
	 iyd8b+N9EvFgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F4ED405DC;
	Mon, 27 Jul 2026 15:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D420869
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5FC3405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Qt7KIGgg-Ac for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:57:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C0AAE40578
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0AAE40578
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0AAE40578
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:57:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlanC3905424
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:59 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4uksgr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so62896075ad.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167818; x=1785772618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
 b=geBZDo7NVu+orhK02RvAKwV9AmYt9XNKmY3hctkLrnRm38xi1XLSCEJuATAOLMAMms
 HVI5ZfBpBEflmjhEClpM8V5W7EFPslXJJRVRduwmWhtxPupMxSZc5VJcKdRNixjVN+fa
 3asZwwYVeAOoMA980KJhf19W0SciZ3XIqMfm3CFictaOX4EJZmaIT4AY3aOl5BH7QWnb
 rmQgyvPIaO3OloXXuw75qSf8BDLWetDxMnKdTHgWxl2Nf8EOiaJAR40SuozPZZ9vwRXw
 U7Uq/4PpLPCkxnL99H1ByPfvuyHMQyxRmFwlZXszo/LmQ0vfClRcI5bg93qHFS8UxH1G
 Xhgg==
X-Gm-Message-State: AOJu0Yw7UpXhP38Z/pYwsvWvpq3vQNoyPP/gr6ihJThxFUtMuRrdNSFg
 0fZ+4cH7dkUIAtuPvPYmfRG29GQGAVGa0m7swYqBQj4yj6als8H7FoRY/KpnQc4MpuMlhjA16O7
 1/95+1gxgMFBKvi2oIERPnVfIGpAjSGd98h4smIo9tiO6K3Loe2Vto1t1X1cPhyyI1xw5KSw=
X-Gm-Gg: AR+sD13iRevToq2nWqn+fJPbGhMp9xmj4xCoDwa2kQpA6mD7/TwfCsVT9SiKPqOSJ07
 9/oFqmTpzyE5t5N4MoSTUyb9bI9uUz03YK6+ktK0XNQ52xb3gE8mqzgwJryokz65pFg/jEupcQ5
 1R7mvESiHDBhglyvFw/beqYDKDI+ecS38k/RDqK+BKbtz8r7qKP4QLUpZzrTNZKLVX35MYaTmzP
 nvF+SP2vez0HoQXKxaeJ9jKaRNJH4ddj2YiZ1w6bZDexbZjc/HtTxt7CB8Cqn9we/I4DSwUdKUA
 W3AxYe3ZR8w7zTkj7yWa/63dwLNPTE+RPRs+sm+cnfWi736yRm3iComeJK2xerMFDnr91b8DGJk
 Pro37UjMuCZot7Z8/CNxomgoKBmIBYiJy3XGUGwFvs6KtZOghkwUqohHw/c5RkNGuQhevqz+3VD
 lWp3qYivdSSmBG/WBg1pzkzPf8+a0F
X-Received: by 2002:a05:6a20:a11c:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3c6c7b71a8fmr212868637.15.1785167818366; 
 Mon, 27 Jul 2026 08:56:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11c:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3c6c7b71a8fmr212840637.15.1785167817830; 
 Mon, 27 Jul 2026 08:56:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:57 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:06 +0530
Subject: [PATCH 8/8] test: capsule: Add functional test for multi-payload
 capsule update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-8-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167782; l=4874;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EUbRVdPmEKUW2evwHpiFh4GExDU/i8UMbOwliCkLtAA=;
 b=0kx3SSCe5etMyyZZK36Vqjq7XiMFQ8baOc38e7hLHTogSt7BzM8U6DCxm0gx1JsMO16eNb/PV
 ZR7atmYkGxXB0F3L+bSD1drILTCX6H+YoMqDg55HdkxzgZBYfmEoFdT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: uYFFISlygw0F_dJzQd7e2iEWccrvbTDo
X-Proofpoint-ORIG-GUID: uYFFISlygw0F_dJzQd7e2iEWccrvbTDo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfXwQ5XX3ztoms8
 nT6clGa6pUW3YIXfb48YMC4AHBcDHaqrNjjesHcZr4BtCpK+l/7uOm7vHlN3EzI63qH1BnAoZky
 iglGWYAYUjbcGZ+to3i/mVdgIsRl8SQ=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a677fcb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=HfRQDYTsxURDGV4gLWcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX+r17vCh4/8fm
 MCGHuAT7mI5HR+U8sqfA1kD71b+eupIC2Fvnod2HJ27WWsOODfA17zSRdyj2WBc+4WeNLEwOyq1
 diIw1yQySLi/tdW3tSiqGV0vR6TAoXQueXxkf2Mnx+W35tPqjeqclr1jbE7syPiNWKAeJPzRwXd
 pmaWdUxvfnjNQslQqm9rKp8P1AlXOkx61LrTdYFSvmyTSbowYsRbLx3Io2ylyK+HenRDqr+ivPE
 R9Uk15a3A0fc2eYztsecNTmNB8Sekw7y8n3ypno2tWPJ5vajDvpzxho5fz7yNRep7w6aFrfZHOt
 KBejqhIURKucPOjkgMrt6Bslu8wHUimfSffo2bkHkyIrzv+NAVcGmsGfQjz90m+wNjAfln+MnCH
 84MYDwyemN+8OjQimt8YnsHXjlwfD5w0EDOuRW42ktgME6mvlTODDy4NAmI+cLtD1dpGxC6hkAy
 v9vCuv4eF3NjKtAbndA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270149
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=; b=XZzIJY8qhaYUDran
 kawmSrev59Q6ic9Y/eQTLEvP6OZKwXtlC8BN4xl1UjDKh5sXz67r6mKUyWplGdUw
 wFlh7506oCUfxbmy18IWQnCpt/RK2iKWBjeBWOBEtvd09Qdjkj5QL/zjD6G7R3xX
 zEQwRFIWZsbzWhPBb8BRjwPm9W0h+ubKv/aGm46BrPZg2CozWrWWWthUvDeOg6uC
 w+QhBjhKBbSR7LV00VhZ7aMVzjfvdt95Xcyi0Z1C39CSsbKVLsZrfRO3z/JyLG9A
 tsyQxtyr6Srp0v3MYzJrYEwNKXgsX+GG8T94SIwSxS8iCp6oN3H6eB5B3QW12RDt
 qravOA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167818; x=1785772618;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
 b=fdUQ84qC8yyDPvWDrAQ0iycaky+zketdnmG6lg8jUlM66/uDE2M9ql3g1ij7Iwa8Fk
 9Hh6Yrt05IMAOY5nIdTQ2sMI7obCQPHGeAwc6oU33p2j0lW7FXzJ3z/8I/sveXLTlEaC
 6oxhzuZNhXzBKorN6C9ZeQeZNbp4QeGVOBqJcWkxaEfAr3YZoA83l3Srmv4HB41momBn
 wLcKIRbQFREjizwPK4nOAFwmlSffhQOYC18MvxQDSPHk01TMvdXUB+U/tIR1ZrKuDWJT
 G70EyBPdPF04vv0tTQ5jA5IBRGnTKkm8iSFLtNS5d9FTyXRjMATiTHGddfNOkzHzsQ/y
 jidA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XZzIJY8q; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fdUQ84qC
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

Add pytest coverage that exercises a real multi-payload capsule
update end-to-end: a single capsule file containing two raw-image
payloads is applied and both target regions (U-Boot binary and
U-Boot environment) are verified to have been updated from one
capsule apply. test_efi_capsule_fw6 covers the unsigned case and
test_efi_capsule_auth6 covers the signed case, where each payload in
the capsule is signed independently.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 .../test_efi_capsule/test_capsule_firmware_raw.py  | 36 ++++++++++++++++++++++
 .../test_capsule_firmware_signed_raw.py            | 33 ++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index b8cb483b380..a7c2ceb421f 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -238,3 +238,39 @@ class TestEfiCapsuleFirmwareRaw:
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_fw6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """ Test Case 6
+        Update U-Boot and U-Boot environment on SPI Flash using a single
+        multi-payload capsule, raw image format
+        0x100000-0x150000: U-Boot binary (but dummy)
+        0x150000-0x200000: U-Boot environment (but dummy)
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test06']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        capsule_auth = u_boot_config.buildconfig.get(
+            'config_efi_capsule_authenticate')
+
+        # reboot
+        ubman.restart_uboot(expect_reset = capsule_early)
+
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
+            verify_content(ubman, '100000', expected)
+
+            expected = 'u-boot-env:Old' if capsule_auth else 'u-boot-env:New'
+            verify_content(ubman, '150000', expected)
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index a500c499bb9..284fbf68cbe 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -190,3 +190,36 @@ class TestEfiCapsuleFirmwareSignedRaw():
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_auth6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """Test Case 6 - Update U-Boot and U-Boot environment on SPI
+        Flash using a single signed multi-payload capsule, raw image
+        format
+        0x100000-0x150000: U-Boot binary (but dummy)
+        0x150000-0x200000: U-Boot environment (but dummy)
+
+        Each payload in the multi-payload capsule is signed
+        independently. If both signatures are valid, the authentication
+        should pass and both firmware images should be updated.
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test15']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:New')
+            verify_content(ubman, '150000', 'u-boot-env:New')

-- 
2.34.1

