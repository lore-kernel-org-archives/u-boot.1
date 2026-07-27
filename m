Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F5EC531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 717F340779;
	Mon, 27 Jul 2026 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mwmSzCRqs5hA; Mon, 27 Jul 2026 15:56:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 807554071C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167810;
	bh=OCdfiCRZHP6Qxv58qRc+RzPs0XjsrS8iahoH1xyLSK4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cjPrlXw551En/lldpwayMSQdYQHSGcHZWALfrHrxXoRgechIPSV/VRaAOu3LiT5g0
	 NWC6WtmdUZkmjLJ3F2gFpL9v2Yy5G222Epu2VDpZraOoHbY93Fn17uRgFGzkfbYUie
	 p1k4lmGTl2drfpiTnuAOzYIlaHgMaFUm2GzeapRlXnM1lF0oZkE3Y7oz/GpXN6B1QG
	 bMZK63qxkR95CLf0wUqy8vNcGR5iTd7YMNLFoitgEQJsaBvLMtzTH+yfHDwssDQBVY
	 DRMZ3o1Yaeu7kuri2t2xjWw0PSFPMoVUrqNnlv0y0hV4oceg6jXLTZtmLIyTcdH4f8
	 Jwz4m1isC7BlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 807554071C;
	Mon, 27 Jul 2026 15:56:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1512969
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF97B60716
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UATpF7OG41lh for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 047FE605CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 047FE605CB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 047FE605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlrMZ033611
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:47 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61p6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so3561851a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167807; x=1785772607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OCdfiCRZHP6Qxv58qRc+RzPs0XjsrS8iahoH1xyLSK4=;
 b=irg9umo3+E0/1wLrgO10ryEurrBUbb136JPfGIUQpdLuXcKS4IVEEl4I8yhuM8TrhO
 c4xTJqos7H9lqmU339ITi1DHkxqMfcQaawTHKr/L3igKBBttwmx2sr3aJFgH3i3dJHUL
 AYPyOaPC5l4PzzeGdc1Ej7VuBVz9+sKzvfvcb0YFR5ou4TSnr9XLuS2BP1GF1UzQeaEN
 xkdeRDhPLvv9bw6CEiYqv2Dkdu7iRuP9XOFh6czYWFt6cBpCh38/VjGpMCFb+iVhIpqJ
 9mjhZAs+ywpbnIuJL+9OrvRO+GKPUBWS5Alsf4CfcoABaJTGsEizlhSFT+wsUlrRd+h/
 NIBw==
X-Gm-Message-State: AOJu0YyidNFDZBV25nZ7lCvFnRCwIT/0yXzsukqHziY7BxP9JBo2kFW7
 8+xNCgVQ131mugy+mrkMuvtzmL5PFWDvx+tzhlJ1sPFgv28Bhf/t1AsmWr+YKSAJGaj7R6yfG7D
 JlDOrYdni8iq2hWowwFmUwo7vnXMBWdgU5klclpzMiSfUozfLAszjWkKvNwq69+mL/4v6yTY=
X-Gm-Gg: AR+sD12utVubIIpqcUreg54NKcTpnhoxtcWrSlsM1Jpd4FZcCJENDPWzHDFyo9HonAh
 aYzrJ8RXGhD7TSIilTeobVj+W50fLMQoVCD57w1Eq35KgPGSxKrhdbjHHNOFMHXrOykfwVdlzoL
 R8IhZsva8WW5T6PvgKPVp4cu80nuA7ZXg6cHSLVVF64agU1xa1KVmjpuDG8E9shvyDkn67rYs7Q
 bjcRjgL46iA5x5nwUKc9FDdcCyydQTNJXgyRW0iuX2UQKSG8zr7Euec9ykFeqMaoJJS+BfEGXdr
 mQbiE8ccDrjboSGLjblFLsz6aPbk2oNH+kF81VE8oSpDnha2p8kvFlBk/MR/7JIfGaGoqzk+ul8
 PqNAZyCsHJnEkBbCXHx+8udNCbdUnd6iktKA/saGIsh9i7zGOozoOLhQ4bgaVnDgodhlqQdcxC7
 YPg42DeMoXnZjhWgoUvwCnC+Pu4IBA
X-Received: by 2002:a05:6a21:700a:b0:3c3:98d3:c20a with SMTP id
 adf61e73a8af0-3c67e06200fmr8428379637.47.1785167806592; 
 Mon, 27 Jul 2026 08:56:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:700a:b0:3c3:98d3:c20a with SMTP id
 adf61e73a8af0-3c67e06200fmr8428336637.47.1785167806002; 
 Mon, 27 Jul 2026 08:56:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:45 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:03 +0530
Subject: [PATCH 5/8] doc: Document capsule generation through a config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-5-5b162866b092@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167782; l=4850;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7HXzBIP+7lAsQmZq87M5qi2Ct1q1SZ2AQJUipMhJ8JU=;
 b=SBcOft5rFQq1yzY47ql4Pdyr1AxDxjrcFzEwlvjz19fBY8BuWHNUV8q86XGVa5ADHxTljnEiH
 Pv885sUFvyLCdJ76sT0IRKtcwp8jEUVI346y0TYQ1TqVLRjpiOyUGF9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677fbf cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=tCXVPq91QBTfjZ_MHFoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX3LUgoXo7rZah
 IUGRduMD9MhfUZMf+ezaKcNL4GNe45XbqT6ySbbiX2CNFPIg4uhDrZhPj8jiO2eudn7Cr5qnkyZ
 V/kh0dB8lVg7P4SdZjLlyEA3zq3Ss88=
X-Proofpoint-ORIG-GUID: qyt08snJQtM5IFDkqiFNZ2bOLU6SZn_w
X-Proofpoint-GUID: qyt08snJQtM5IFDkqiFNZ2bOLU6SZn_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX2/Dimi3A70Xy
 7gXFTtyooml56RUw8who69FQsEMTqqASaYM/WLUv3tyd1FuRHAEgpnsqPOmYIneziL5d/3Shb/Q
 nlcLe5d1gIOVhNiv4MQcoJPuhikdzynCw0GzaTyI4uLcHvIAd7Brlg4KLz1yHmn0juf7Ir23YCE
 CFpcnDWNMfdWThNu3iUZOyzykvdVItvGBWEbN5c/tHAz0zBQcPoo8GLYwswFjLQrV0u0skKGKhR
 rtFo4Js2wvwLxER62Ln9tOrmQ1fHkQXGP7pD/Q9MVaoiz/pP94zie+y31DKiST2V7zTjoJfERyJ
 /dlS22ft0ZOYJRcX+iB5tKaG1UhGUaEB+D8hn5+E9eD7ODlyA5fhvQfEB4NwqqYZnAX42LqGosQ
 ow1k86Qa+1CgfF81r+Bsfq20Esr79zhbqUPmIsCmO0CmygmSfA+erYRYVcrTSNyS9SrbxdcBZpT
 VjU32/AnFb2djKk7E8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270149
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OCdfiCRZHP6Qxv58qRc+RzPs0XjsrS8iahoH1xyLSK4=; b=oC7SwB11buEv4cCo
 og99mj5b9JgJ0TXd4q+YewKl7I2K7x+CUvwv2PotIXJ7GMk0dwvD8Kwfciy/rMMU
 8EdcL0bw5zE//Tl0SamOhW57arOANYVdePuhRBSMbQXtYTnwrUWYAIDxm4XhpTC3
 KfKTHkqk4FTuQ5d8HyPiuoKn3Isr66ji7cY6zzmHt+1MpUmyiUW6SnHqSrds9juv
 +IyaYNPi1Sfs4hF0VUwnPcN3/lO/GApRwqXAqJcpiE3fOyE5Q+JwAYTresftSHRV
 oRIIEVG96pZF9ViR0klWn9zF6PdvgZod25pLEBCYSnzId4CPnI4WMt2NffQs7y+D
 cS17UA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167807; x=1785772607;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OCdfiCRZHP6Qxv58qRc+RzPs0XjsrS8iahoH1xyLSK4=;
 b=WyAWxOFJrW+GWcSYl09X4RykDC2FcwKUp+dGH6iMbF3VWMCBEIT/O4J31OyjNHGwVn
 LintjCcFSVxl1VeLia9b1Y4EuN9Q1LkRlpVoeIdvDD2PMHTszSgLO68B1AIBBgGI36tr
 urI5RN6/P+8+U0XiZKZMuMjpntOGlqk8gQvbPWvoJS4wbuSMm1BK0cDrYex5PtZCwspJ
 v7BIx2H3oBn3bQOK5I6raBA75O2drocJvu7tBMZZ58IXD8u6UNNgqIDpLcmND02nh2vF
 ovjnvnL0O886hYuwbT6Xm5dQRr4p0St/BKySVCIfVxfeS5CeCSP6Fm+wn+zMN5bYY4rh
 NPRw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oC7SwB11; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WyAWxOFJ
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

The UEFI capsule can now be generated by specifying the capsule
parameters through a config file. Highlight these changes in the
documentation.

Also document that payloads sharing the same capsule filename are
automatically grouped into a single multi-payload capsule, and that
payloads in such a group can be individually signed, with an example
config demonstrating both behaviours.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 doc/develop/uefi/uefi.rst | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a9..29d3909fea6 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -318,6 +318,118 @@ Run the following command
       --guid <image GUID> \
       <capsule_file_name>
 
+Alternatively, the capsules can be generated through a config
+file. When generating the capsules through a config file, the Kconfig
+symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
+path to the config file.
+
+The config file describes the parameters that are used for generating
+one or more capsules. The parameters for a given capsule file are
+specified within curly braces, in the form of "key:value" pairs. All
+the parameters that are currently supported by the mkeficapsule tool
+can be specified through the config file.
+
+The following are some example payload parameters specified through
+the config file.
+
+.. code-block:: none
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    payload: u-boot.bin
+	    image-index: 1
+	    fw-version: 2
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    capsule: u-boot.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    fw-version: 7
+	    oemflags: 0x8000
+	    capsule: fit.capsule
+	}
+	{
+	    capsule-type: accept
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    capsule: accept.capsule
+	}
+	{
+	    capsule-type: revert
+	    capsule: revert.capsule
+	}
+
+The following are the keys that specify the capsule parameters
+
+..code-block:: none
+
+    image-guid: Image GUID
+    image-index: Image index value
+    fw-version: Image version
+    private-key: Path to the private key file used for capsule signing
+    pub-key-cert: Path to the public key crt file used for capsule signing
+    payload: Path to the capsule payload file
+    capsule: Path to the output capsule file that is generated
+    hardware-instance: Hardware Instance value
+    monotonic-count: Monotonic count value
+    capsule-type: Specifies capsule type. normal(default), accept or revert
+    oemflags: 16bit Oemflags value to be used(populated in capsule header)
+
+When generating capsules through a config file, the command would look
+like
+
+.. code-block:: console
+
+    $ mkeficapsule --cfg-file </path/to/the/config/file>
+
+Generating multi-payload capsules
+**********************************
+
+Payloads that specify the same ``capsule:`` filename in the config file
+are automatically grouped together and bundled into a single multi-payload
+capsule, instead of each producing its own separate capsule file. All the
+payloads in such a group must use ``capsule-type: normal`` (the default);
+if a group mixes normal payloads with accept or revert capsules, the tool
+falls back to generating separate capsule files for each payload, named
+``<capsule>.0``, ``<capsule>.1`` and so on, and prints a warning.
+
+Payloads in a group may individually specify ``private-key``,
+``pub-key-cert`` and ``monotonic-count`` to be signed. Each payload is
+signed independently, so a single multi-payload capsule can contain a mix
+of signed and unsigned payloads.
+
+The following example config groups two payloads into a single
+``update.capsule``, with the first payload signed and the second left
+unsigned:
+
+.. code-block:: none
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    payload: u-boot.bin
+	    image-index: 1
+	    capsule: update.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    capsule: update.capsule
+	}
+
+This generates a single ``update.capsule`` file containing both payloads.
+
+
 Capsule with firmware version
 *****************************
 

-- 
2.34.1

