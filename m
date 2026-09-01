Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A185C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 04:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1358E60603;
	Wed,  2 Sep 2026 04:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NofY09TiFW3m; Wed,  2 Sep 2026 04:21:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788322856;
	bh=5qv+JZAnY2h+/6XyTBJd2C5AXsAuAhuOwFtXV4DP72A=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJQW6DHpp4nf+/PiHRFwgKhaaBLtKVsIXgOFPNafht6VKxAjz6ACL0neEXAOcT3m+
	 3+2wSCthWxPRILEZlSpBMJctbC+6d984Fb5TQQQhFmqt3cNbKwq8kE+GTPfDIGxlEM
	 A3Vv/JaaNjtZJKBxxn1ltmrSKZAlJ37lAD3LSS5DPaMQu/ViFrKpibBCapsvYRnzqM
	 H47n3Y5+Jhrvtnj0fjNEHdgS38QRWp0jzcU973NUlPObSP86Pf8wjeWvnFiGjFkfQ4
	 kdRrHMURvVCv/FPC929PEFL7O1T1qoXB+EDbrdzWmON+27rKJo0LUo27Li/t+u9CL2
	 NIV4VIDT11Shg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F17606C4;
	Wed,  2 Sep 2026 04:20:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F38C127
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 514D840641
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66VzzTMRbZiM for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:58:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MeCvG/Vb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fj9gn2+k
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 646074063E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgHki2110433
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 19:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5qv+JZAnY2h
 +/6XyTBJd2C5AXsAuAhuOwFtXV4DP72A=; b=MeCvG/VbJjHA58gVQzmCmaNwiom
 V/paJFJrHWiJR8Wnsmrh85enCCvUFmatGEulTS39pydyR2SZimaQI6tOeAQkQUyX
 Wv/1PGp+1AnzvkFOEF+McIk+WJPxAT8lSQRmi3ywkrPgSviTDPCyd1pKHh53/r1J
 /u2AwZMsVoLIAwP/3w8RKI2PvxwcwyRF2UwlET+ok8mflgFNJsFihkTSnZMdJHt7
 WzGYpjfGM2c5+cVZ0hZ5T9EGitypCkm+wkqAIK6x8jtDYHTKkpGqDuV1JixBVmrF
 BXLF1lVBAUSrYSSHna6dw7Y1v/BS9TqNWxD6RLQNmhH8jlRxuxQwitFrmaQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cgj5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 19:58:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so370065a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788292720; x=1788897520;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5qv+JZAnY2h+/6XyTBJd2C5AXsAuAhuOwFtXV4DP72A=;
 b=fj9gn2+kd+u4ZyU7FJld26udJQaJRQu/3dXDaYCYXoT+uOSp2XmdzwZEnmCG+qofb7
 /An6akiWdoy3MMDiccW3H8CkijgEFaRzo4ZzJOnQ8ihJ6HAso0Gdie8YbpkHCucP6nh5
 SD6zjNX1Xq0t68AOI1XtwiM4aEeluB/f7JzK+wYNeJ3oubGit6Dhaqfq/uhhVY05ML3r
 Ek12l3KSvmfY/IJgBpJhLdb/PVDGtea4l/wWTMLwnp8W+QtiiyjcjsjlnDHkXNdgesLX
 egs6l7k+aXsg/X3tiWz7rvpxlAa6kY22cAdeKzHBPBf0RM6b9rFpzFK5+mfpVxBdRzvT
 yMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292720; x=1788897520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5qv+JZAnY2h+/6XyTBJd2C5AXsAuAhuOwFtXV4DP72A=;
 b=rKlHdVf3vJoPfzEjJf1FJmHGT2QmqyDV4b1tak/t4Bcg7gbuKBqFaEe2n0gbRni8RR
 85dCWogPyEPeMs2DFQIab3z67JWF4ysoxPRvTFdUiHY7mbAkFuq6aAXpi1laflyoyAEv
 dkhGIVNhcuxKS3S/gWkmBal5nGeYTGDFS+Dp0ZHNnpI6LwNLog2rvprPn3p8SZbaGo8O
 UKn6/l7d96N6a5XI581BKOknjnj28hRQeVr4tnTKBTWua1hKgyLYxSygrZ3VHyk2H7Al
 kNHB8KGEUGKUbBJTrJ89EeQfGwTfzbf5JSBK/jlskm9FiATYsRpDd/HXXjPppdET/lDJ
 d5WQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwps3FWA2vfeb8yzngqxiyYMGJlLsG1hLCjWhqgS3jrw8DEIwI37QnkUwquO8ZRICwmAB8wAfI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++manXHZvcLv0HJaDB3cK6+BLfp+y/6GkoZjXrYk8OBWaJVB+HdZ
 HVTfubP3cRntQK4D6ezKHlRf1GvbMwSdGzSRfYCSCut99sEwDjOG/bznB/G2ZL+ODNzor0INrcA
 QzewZ9QrTmhoqF7ggbw1xyDjMnRwji7LOYByiR7k04lp4DeZu72q2uvXKSrABuoX1EqNc8Nk=
X-Gm-Gg: AYBFou0LPNk96Oq/W54f7B1CX11O4ssLC+0uEKaiDm+BeLSIlbTgUQvBWnvr8jtzjJw
 Msy9GTiaSKDdUdxApbuWCxSzEfO1bsRznECV5qPWH4FpX+FIR1HKoA9K3slcAUhDQThd9Uk5V+j
 KewQzgCxPmoOFm3N+5U+wZzXvws0F9cQrRZdv0WiRS+vMLA0iYAHHg+h5UPIxxp0Ct4BPKqoqZS
 4cllVVO0Uo859np0eBhW2zBNyhjdNDKyuloKUhUqPNShGvtri3rka4LuwMMw6Whf79LdannIrMc
 S3VgHytgX+8eeCeENJbMvs/b3waLaZ2j67EUK1D0NiHstVWNnvIOI8SKMoHwStd6Nd+GfgZ584H
 CA6RReiFwjHbClEz8gmXzwLPtPKe8Y9xdkx+NwBHnePv03M/ZoaRMDV94kSbPDUyVGJ7BgTw3JT
 TTGpwPC9Y7LKfSYrDs
X-Received: by 2002:a17:90b:3b86:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-39ae83eaa16mr726783a91.15.1788292719675; 
 Tue, 01 Sep 2026 12:58:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3b86:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-39ae83eaa16mr726710a91.15.1788292719255; 
 Tue, 01 Sep 2026 12:58:39 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb4854csm726433c88.15.2026.09.01.12.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:58:38 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 sumit.dhami@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 2/3] arm: dts: qcom: Configure Lemans PS_HOLD reset
Date: Wed,  2 Sep 2026 01:27:47 +0530
Message-ID: <20260901195748.1192630-3-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a972e70 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=UJPxi1aDyaN00a8EuTAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: o5nCaBKQROKQCsSS82b19kAfWm_iFU-A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX64miUgAIkDDL
 40fsqVelKHqgSH7ZQnrRXZ/fJpZBrTGjLM48roO+AqoTQb3go/gnY9MWu2wmxb8u1xAI6chBGau
 w/7MRWQ7VEM9JFrlGvclz9HOzBt1hFo=
X-Proofpoint-GUID: o5nCaBKQROKQCsSS82b19kAfWm_iFU-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX/heG2Yfz1/fJ
 5R1cWDXpW6UfZue4M4ood/3ekrC3CBuwCe0P4ZFVxHICQvh/zsbmAIUzQBgTV7HeSu1Y3DVaGqn
 jlXWzzRru92P6gHt3/xL+fbrudly/H4vu6vHhAL86vdmvJT7KnGb+88e8VhzcPIAURl3iNQxLDO
 KZ6R4HSuzVUlfSPa2I4loPjtxy1hrumpfdxMiO4lYbJpiExzupPeYzJ4qvfN8JevrRAMtTpk3YN
 Ob55+vgp7hOAm+JD8V9/sVMDjVxIeCLBQyTF5He04hrRGYnFfLyhWaWr4/rDHyAya3j59jYZLg2
 kQmlx2u4EJm2BVazjHPSG+nnbZs3iW59fupru0IohE0LQn+dWiUJTdVR7nL34771K5HKyb228qm
 CM0MDDP616msYWDzfkbRPFcS+60dh+82bjaMbH1JTfOvRLmxqZvnxdP7UompIwBRObq/tSe7Tsw
 nuQ4uTBpdIMEy2MwhLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010175
X-Mailman-Approved-At: Wed, 02 Sep 2026 04:20:49 +0000
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

Add the Qualcomm PS_HOLD sysreset node for the Lemans EVK.

Link the reset driver to the PMIC PON peripheral and provide the PBS
PS_HOLD control register offsets required to configure warm and hard
resets before deasserting MPM_PS_HOLD.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index fd4eaa2fec8..0e676bf4b55 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -64,3 +64,15 @@
 		mode-edl = <0x80000000 0x00000001>;
 	};
 };
+
+&soc {
+	restart@c264000 {
+		compatible = "qcom,pshold";
+		reg = <0x0 0x0c264000 0x0 0x4>;
+		qcom,pon = <&pmm8654au_0_pon>;
+		qcom,pbs-pshold-sw-ctl = <0x52>;
+		qcom,pbs-pshold-reset-ctl2 = <0x53>;
+
+		bootph-all;
+	};
+};
-- 
2.55.0

