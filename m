Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B6CC531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE64980EA1;
	Mon, 27 Jul 2026 15:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kO8pOpbDKWNF; Mon, 27 Jul 2026 15:56:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 092B280E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167818;
	bh=hvGPY5iCXDzFmZHa5i+JdNfm00nt1AmhA+tCQNUwGHQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V6gsf1QBa88Ysl64FlijjsWkuFkPW6dsQKI5mxpRF/mlMb+tPR4Yh0aI7bDMux5sN
	 ECHjfZi0LbjNPZm1ZJiz20H1js9w3bBrGlv31h7rU/JQhTH6HaBtqmvkcQ+I5pscfF
	 sUlxy3JtiuNNXofnBKFbG7pjVsDqsa6ZPyEPIz0HYO5EoG7Dum7Sbk5apmYj36Ebkj
	 RAmxUzUySITpulz37LgRIyDUY7JKaExvFS4Bxf+lYZgo2TPYEQFpwbU7Xj7jTN6pBt
	 gn9X7bRQH/wzZD/WyS4qNasfqf4cWpVaE7sbt1VwthRJ8PDb5G0ceS8xINdlJPrGTI
	 /oF+JqC+UriVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092B280E7B;
	Mon, 27 Jul 2026 15:56:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9F84C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C30D5605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 204VzXmgu2aD for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B008060712
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B008060712
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B008060712
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlhFe033222
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:55 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61p7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso3926789a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167814; x=1785772614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hvGPY5iCXDzFmZHa5i+JdNfm00nt1AmhA+tCQNUwGHQ=;
 b=RSCVz8HRjvXFBeewpRz1iCQ8iKIMEFGKeB56qIwsaWAH+4PHwvBMGsJ3jMdVslw4Jb
 4zEBLvjtrf5cZqfaUvs+yNGuJit1cLPhmWiC5QrAngSd41WcGx7NEMht+kYoa/wxZf4W
 C8xMPmwUW0C7zakRfLeEEFX8fT9QNcHPJiQZCdSY4I9w0X+90u/CHEvwlPtrZA9xZSDD
 IgD18g5+75xpjbS+tNdgzH+KXsDkRlGmZz3pdv+fLe9KLdPlvr/tvcAl5wbr9VcfBwwc
 NxlD9mJDLsM7EyhSVMLZt3ChfCGQe7b35ahjL7uGBiDjtufSobOj8tXJHhptlFeEWYl0
 xLsQ==
X-Gm-Message-State: AOJu0YznlcqxUW2Br0TqKSUygIBSZp3rWlRuD1PWVnGSS7S8tJzLY7TF
 PkkXBL5GeuzbSLIIbT28u4kzwBphydsr16cFIHDKSFrjQ69vTtpgZnfb36yW/P4Qrvt7Ifi2kbk
 dnec9tSqmeIM18Ru6amiJsqhUy1e4eneWXzTDiuZkb1ced67CXe6K/zVy8n42pSBYqK2D80o=
X-Gm-Gg: AR+sD13JENyU6q48PfjD4OVA6s6I1lUM0cg1pdvLEvUCR9dqinFh6phbU5r6ICj7001
 1DoHDIa8llaqCFYleqiyEA67e3pZpN+7dqUQZGz9WD5ojnkkkCrE24IxzlFU0zSUYsGz0Y4VGHv
 6puqjTl52tWU1mEm/wPn96JTgl8kqEBDr+NVfUNJZRQBQaEayCavtlZABUt6zinaVXgPWn5ZKwI
 pA6Kafan5VSrp6SMB3BrTuOlziXA+KfiTCyYpm5zRmdEy/U64IjPltVo2+llwXcp8e4ERgSG1Jz
 gSuZEDwmPMG52EJ7Li8g3BNJwhL47yZRTP/A5BRiSYwEbmVvk0m2q/86fOt4Pfb41RkgW6yEkEx
 d5g3btE2QMhbV96vyXnd3Nle/C/Wln4ZDmDJ6ImDEPufu5J1oLYevHtkQcQTS6Pnzdynd1QX3Z5
 xn3NRj0rdsrmiy4PLbyyXfsY6Nlstj
X-Received: by 2002:a05:6a21:7d06:b0:3c1:c6e:9360 with SMTP id
 adf61e73a8af0-3c67dab4b26mr9004387637.32.1785167814380; 
 Mon, 27 Jul 2026 08:56:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d06:b0:3c1:c6e:9360 with SMTP id
 adf61e73a8af0-3c67dab4b26mr9004357637.32.1785167813855; 
 Mon, 27 Jul 2026 08:56:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:53 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:05 +0530
Subject: [PATCH 7/8] test: capsule: Generate capsules through config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-7-5b162866b092@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167782; l=2338;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=zMv2bLj5Ag8VQXbKju5M5vE0IdYKN21LoR41btIHV1U=;
 b=xYAYO3kggkvSDlGoTaC34HiO8ZvK9BGbr9O6BcAU4Di/l46gw+DphIzZXPZcq2BD4+O8fAmiF
 ujfsKPYdoioAwMNwTh8jTRJsN5RILk4yKaYjMuGb3VNsnwlXcz0bs/Z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677fc7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=7XaatbYWdfnGYf2S7LwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX3OwRIUFK8Rsx
 BLZehpMEljZaaWsZ6uogTX0OgbIgJFPMsM5l/vxLFkUwYk+Bpy/NcY88cDZ6TgqbKEegcE/qN2e
 DfLK9Y2kLfdegMj6HrSDemZJxrFSnuU=
X-Proofpoint-ORIG-GUID: fbAACLOYe8Iy_LDr0PP6FkhNSZFRTE25
X-Proofpoint-GUID: fbAACLOYe8Iy_LDr0PP6FkhNSZFRTE25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfXyPnPpjIIFpop
 o9153DZSqmWq+hHaO11RELTNxAoUFi6jIVjJmR98PUUViQ5aESqFxZbeoKgkvt3UNl38bc0NYrX
 YoD8E66Rln4Ey/ZOasxiuGpBcZW6+I6DomJlsKe7zz/GeeY7GPIwB4NsQOEUqAQgoteZ9NGNAe6
 oD58bfeNZ7iK2jE0XTjG+qb62pJl1ykUH3J1ojc3EXknUUh8dCYHZzFsKFRDmxWX+E046+hwGVa
 Ek2UkRbYxPacIBz/PlCj5UZd0S+/GqKNhVJA2HrkTf0+fPB4GSlNsWavl3iwXz8wKXFEE5S7TW/
 9AssDg8hP2U9ulcqEWlQwt+/+1966jSffKE8fsU9qYDvFNaoM/oLGfwE3swsoHrFIAGnU67RcAy
 hklxW67PtqieRO8VNlFbF7Rvsk8BkvZOTuQW6f1wt6KwXexjt3lkNKPEcyxwqpdTAObUpyFIK17
 dfn4HfPGBzA6hClrUKw==
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
 hvGPY5iCXDzFmZHa5i+JdNfm00nt1AmhA+tCQNUwGHQ=; b=FuA0HJqkto4KmRZJ
 Lkdan9L1/40ld23b89PFT7AhSd0XptPsjQlp1GjP2eyeqlsDjSGXxGfUq77U0R7w
 INrmFFWwNb8bNB6YUb7VMs02K6q3U0irEBIkPyorQc0A09nh5n9e0pQ1i7SRyf1W
 wDImQrgofiABmfTN5mBrEc4T8UL2WmoeQcUMQ5q2ESiRyiD2nEr24nZ4bY4/aC1l
 gFt1Wfotv7+ceiDwKa9XjZFejM3nYwWKclmm9SpaDvOMfKSxm6eaf31B2uik+5Zg
 2jRyCMbGs8cZ6XAIcLrSvs2qQ6+t4oo6g80MfwV0Qya/KLR36QudN/dT0YTwEWOa
 JBc0Aw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167814; x=1785772614;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hvGPY5iCXDzFmZHa5i+JdNfm00nt1AmhA+tCQNUwGHQ=;
 b=kKSEVQS2qMDPY087a1Lxyi6yS8Byu0C6yxcrBMKxNPVB35M4gjbvX3Jg/vy4ZmzLBi
 Nyeqm77zVYlBWOjPXYHoAxuEomekNg4533v6WSS9t9GEj4wnocpILKMt+vF8aDG8FEUn
 UJIDIHXBkh+dVxyVzb93TvOJ6NEYBPD3DHAEVAp8rijV57qwTurHA0q+kmI1+7g1goOL
 s7mzv1GSW+v2DiOji4UOa8jLwLNrlDlD9E0Vn4KowiiNhGEbsm2KKddlryqP7uQr6M5l
 3NHIodTntOY3yYxvtygxDEufRfsmamGyS5iIB1/+OyplHl4jrJvEkQ3nm5dLiL8XL9q/
 ljZw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FuA0HJqk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kKSEVQS2
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

From: Sughosh Ganu <sughosh.ganu@arm.com>

Add logic to generate capsules through a config file while testing
the EFI capsule update functionality, and enable this on the sandbox
variant.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 test/py/tests/test_efi_capsule/capsule_gen_binman.dts |  2 ++
 test/py/tests/test_efi_capsule/conftest.py            | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
index 1a62c260474..d1c00670647 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -54,6 +54,7 @@
 		};
 	};
 
+#if !defined(CONFIG_EFI_USE_CAPSULE_CFG_FILE)
 	capsule1 {
 		filename = "Test04";
 		efi-capsule {
@@ -165,4 +166,5 @@
 			};
 		};
 	};
+#endif /* CONFIG_EFI_USE_CAPSULE_CFG_FILE */
 };
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index ad0cda59ebf..039a3db3b70 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -93,6 +93,17 @@ def efi_capsule_data(request, ubman):
                                  'test_efi_capsule', mnt_point)
         check_call(f'dd conv=notrunc if={fsfile} of={image_path} bs=1M seek=1', shell=True)
         check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
+
+        capsule_cfg_file_gen = ubman.config.buildconfig.get('config_efi_use_capsule_cfg_file')
+        if capsule_cfg_file_gen:
+            cfg_file = ubman.config.source_dir + '/' +  ubman.config.buildconfig.get('config_efi_capsule_cfg_file')[1:-1]
+            check_call('cd %s; '
+                       '%s/tools/mkeficapsule -f %s'
+                       % (data_dir, ubman.config.build_dir, cfg_file), shell=True)
+
+        # Create a disk image with EFI system partition
+        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
+                   (mnt_point, image_path), shell=True)
         check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
                    image_path, shell=True)
         call('rm -f %s' % fsfile, shell=True)

-- 
2.34.1

