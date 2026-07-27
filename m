Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8153AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E35680E65;
	Mon, 27 Jul 2026 15:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZtFO34gmnc_g; Mon, 27 Jul 2026 15:56:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9939780E70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167814;
	bh=2kOfelmHtbFO1J/aRRa9vmpGS+aqRP154DeuIRIYBqg=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tXGeg8T2xFzBk8WAyNfqY+q56RtbNpguuGH0zeA277V/zKF9hm022KY5vwQ8PPFjj
	 lfzQtofNnvKbgOuXNI2EiXGJID7WJtY2pdnIZ4056V1JIp3mtNRXgs1kQkXUSu4ymn
	 zKz+99Y/XiM4RIRkKWceWI4BCyJcDR4J+z8AFjkI3YzQdvLWnmn22J08VjdaMlh/92
	 Q1wrfFbMA829+8P00XSKeTEUI/Q6kZ/rDB5iDRNHeRI8b8cSA6jfWAXvgG/H9zTJsT
	 5JU8S8aY21IUE0diPEALgC3kS+Wt2deWOQ5mrMeKMb2BQQ3zhaQ34uxoo6OeysKVa9
	 4d9laETOYTgrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9939780E70;
	Mon, 27 Jul 2026 15:56:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4442350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C624E80E65
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7S4byEGYqR8L for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C9EF780E72
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9EF780E72
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9EF780E72
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RFu6ts179510
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:51 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkg060-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2043666a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167811; x=1785772611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2kOfelmHtbFO1J/aRRa9vmpGS+aqRP154DeuIRIYBqg=;
 b=NvEKv37gdaRQEySXpQAP4ZvYS6WnbUjHRw6LcDsBJXr8YWSH114m/NbJrKJKoMaax/
 9AzLM32/Oa/A6LLbqxJGkucraT3aG73vmGLvlMwNaI90mkJRqOp4k4z3E/dAxY84pgf/
 HwFtaY8ljlTSy8jal/hFzTHY0SA04wItxx3IpjI6RK10VAswdc/5+ixW0nxzeaQo/SbJ
 BF0JgKuqC5/eOMBItMYH/aCKtU7/vlweDCtkJnKz1qT2ILXX7ilFlxW6cZtk4gkUSUJA
 ZzoCTcqqWcLoomQoNf6TYRpHSneyMs+HYm3cRpZpy0Ih/txfd2j+ZtplZGog1TNPw59x
 0fcg==
X-Gm-Message-State: AOJu0Yxsm88snWWeh252CiASmuIuP1l/Gh2hPu425w1ZNmZ1BO+u4O1t
 SVvvW/KNxeSlwHoIdt6FKfKVRqlbfTvwkskekddDJIQ4uAi385KBniXtZX0MMUi9fcBVAQCT4AQ
 WXYRCMGlnUGZHzq0h/5hUNKZTYtHUy3RA2HFJpbx7sxVeOtOZ8DO0+kTVHRZ//zMv0pDVfP+wl4
 M8yVo=
X-Gm-Gg: AR+sD111nG+yyn/rZVgMf8IVIi+AgO5I07iV8jZfEWc3+dBb2Duao0JtFUCfzJldB7Z
 vv1kV+Y9BRlYzTa14Hx5+V1K7P/He9CtgTfXpJpIsJBZZlzK/9rgeptaLrQ8VO02lqCecMPkQak
 W4b21fcDRSLYdEJMMWUzwZ4txFnbfRdvcl7OOlN0zFQirSDbxPVwWv1sAT2mEzcx9WMQMbLRT9/
 YfWTJkrEKigLXKQHF+/XzZoK9qthlbvTzwrGJpA/haibnli2x1Ke4G974yh9ptbO6bwQmTlMExx
 6wXxIshEyXIIjW5Em762y0hGeafzVgAZHC/cPWliJXjkNfX0nIAcYc2CK8y9l5KPWMi6PmVT0lA
 uFoLqdgPNL/CT2XhVWdJcuFiIeWNsbgNxobP03MvhnI07l8pYQvq5ChFrz8amC9Ur873USHqDs8
 ymVI4u6QDeZ9FdJr4Uz4yRZpyy87ZQ
X-Received: by 2002:a05:6300:6708:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3c67da72a28mr8837887637.22.1785167810466; 
 Mon, 27 Jul 2026 08:56:50 -0700 (PDT)
X-Received: by 2002:a05:6300:6708:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3c67da72a28mr8837846637.22.1785167809900; 
 Mon, 27 Jul 2026 08:56:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:04 +0530
Subject: [PATCH 6/8] sandbox: capsule: Add a config file for generating
 capsules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-6-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167782; l=4638;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=9Nmpu1rd2Jk9XO5E/OiZiu434+/4kSLqE1pVZb6WFZM=;
 b=cGutbLigw5dVardeXldjyhneQDLD9aFulVZSUxXrDCVW35Q/fGV2xRXDT0vlhcOLVFWNJQWBU
 GJVStOy3vEwALOFvMz4hE/19paH5AMM2eDj/PtBv0QVfOFE20DM+pki
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: _t0qA1-XTepg9i7t4LnoDr5c77tsm7Se
X-Proofpoint-GUID: _t0qA1-XTepg9i7t4LnoDr5c77tsm7Se
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a677fc3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hVFtLThziIPPOTj0udsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX6DGbkcVDlyMU
 qvoaYhSoLmV8SmlPYZhvPCtnCmSHHPL47AQ8b2yHJRK/fuA1GvpJTIFyf+QNPOEYHvT1gRGC4BX
 Z215Xv7RXOqVveXxCxvzv1pyUBlk7G19LQBm3fYEnZny4X6y4iqkZUfTNWl96N1M+xs+X/p8Pb0
 +3zO5Q8Oo2YYMHT+ZubUH+T4O96ucU0gjg7wuOzXmmts8263FBLADMaTzwVVcLIcT7fbGnPFXnj
 pxrLH/Uc+Sl3i15Tpw5hYZKKJ03sPzFVAIeIxQ0YM7kPp9a2TM2nM1zxSJ6sMtwVeWmp+f4jOAi
 Y92RagA7um4wz2qbEE6t9BcPI/Hb4ZFvA5j1yRhUFTUKZVIDTDhCBFTQ92zEIJ6cJ4lS0K9g87y
 /NlhfpYOiQIimViF9toTekj0HcMil1if7cu9dClztHudy3rRo/i3RotrbT4Dc4Dd2RVSxNapDaj
 Jg7IMUGU7jlZeBU87bA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX0DSJwCFx1Bzy
 MzSkFQn0o7svvHEMC1CTYqmzlDcZoBA0PmfPevQp8IPGwa7qsBPcZjsXcct9EvYZ9KWU24LgDkW
 nukZrJqrvs6U3BFlz5v5rrFrbCYsh/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2kOfelmHtbFO1J/aRRa9vmpGS+aqRP154DeuIRIYBqg=; b=JVU/GhDBtDmS9s/m
 qSFUs9arvm4Lj7do1Tv8pK5sSmD/dwizP8Krae+IwxKihqWOJ0+KhZAvy8iulgPT
 n4WayIc6G0nhldkktqZC/PRuRUzcw49Eq+VG3teuqXXzemM77a+jGxYNJl9EToHA
 Nx4UHkkJoZH2Ag1JZR7bLErYoqI63j/OYcyu46nDv0OvgOt/K+Zf0G1zRGpw6f1a
 r0Lh+XIPeerjYda3MaW7ONfolsABi1V9priLHfnRoj5on6Sz+aZbWlq4XipCA7cT
 TKyR1MzLrb6/Zx2M5vZRb9vn6MdTxdAL/DZI7HYHFLASmpovNrgmPEVb4IHfFmBg
 et4w6Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167811; x=1785772611;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2kOfelmHtbFO1J/aRRa9vmpGS+aqRP154DeuIRIYBqg=;
 b=JXVq9O1JiE5Brznp7gsGdI+Hbg7si4Rf1V+HOPrdxwVmZ9TsNicJkSosJykK6xUujz
 llGas419RgIjaTw56UN3tGIXXbol42mBGSX53kUyEcM9syq8nE8cKrTNq+92kSCuGcwO
 aL9MwnCFbPBJWIQGwTQQLJ9BdJOE2dm5JnrICrB2D/IIC0sW0PJ8s/FlMhERPyq79KyM
 vE37CVHhJHIrSS/+UGOa2tzqa7x8d5rl6wU6LyV+9TC2EM5vVQji7t0Ta43uikMAzEdj
 ah2PpPOrRbS1OkAoMtLCQjV5JoojUcKxZ0C/HQUQaY8Dk/6AYJkkZmznxDd+rhkrzt6j
 0i5g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JVU/GhDB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JXVq9O1J
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

Add a config file that drives capsule generation through the
mkeficapsule config-file parser, and enable it on the sandbox variant.
These capsules are used to test the capsule update feature on
sandbox.

Fix Test05, which had two identical blocks (same image-guid and
image-index) that would now silently merge into an unintended
2-payload capsule under the parser's new grouping-by-filename
behavior; give the second block its own index and GUID so Test05
instead demonstrates multi-payload grouping on purpose.

Add Test116 to cover a multi-payload capsule with a signed first
payload and an unsigned second payload, and Test06/Test15 to cover
the same raw-image update path (rather than the existing FIT-image
examples), with Test06 unsigned and Test15 signing each payload
independently.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/sandbox_defconfig                          |   8 ++
 .../tests/test_efi_capsule/sandbox_capsule_cfg.txt | 118 +++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..8fc3133522a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -396,6 +396,14 @@ CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_AUTHENTICATE=y
+CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
+CONFIG_EFI_CAPSULE_CFG_FILE="test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt"
+CONFIG_EFI_USE_CAPSULE_CFG_FILE=y
+CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
 CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
diff --git a/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
new file mode 100644
index 00000000000..8b8530228a6
--- /dev/null
+++ b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
@@ -0,0 +1,118 @@
+{
+	image-index: 1
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test04
+
+}
+{
+	image-index: 1
+	image-guid: 058B7D83-50D5-4C47-A195-60D86AD341C4
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+
+}
+{
+	image-index: 2
+	image-guid: B0ECDF61-24BC-4A61-A0A9-095A77279E84
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test13
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER2.key
+	pub-key-cert: SIGNER2.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test14
+}
+{
+	image-index: 1
+	fw-version: 5
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test104
+}
+{
+	image-index: 1
+	fw-version: 2
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test105
+
+}
+{
+	image-index: 1
+	fw-version: 5
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test114
+}
+{
+	image-index: 1
+	fw-version: 2
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test115
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test116
+}
+{
+	image-index: 2
+	image-guid: 339B1ED4-A9C4-4A4E-A3E4-04138A91734B
+	payload: u-boot_bin_env.itb
+	capsule: Test116
+}
+{
+	image-index: 1
+	image-guid: 985F2937-7C2E-5E9A-8A5E-8E063312964B
+	payload: u-boot.bin.new
+	capsule: Test06
+}
+{
+	image-index: 2
+	image-guid: 9E339473-C2EB-530A-A69B-0CD6BBBED40E
+	payload: u-boot.env.new
+	capsule: Test06
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 985F2937-7C2E-5E9A-8A5E-8E063312964B
+	payload: u-boot.bin.new
+	capsule: Test15
+}
+{
+	image-index: 2
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 9E339473-C2EB-530A-A69B-0CD6BBBED40E
+	payload: u-boot.env.new
+	capsule: Test15
+}

-- 
2.34.1

