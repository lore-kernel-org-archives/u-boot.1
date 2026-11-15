Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A77606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XrQdbFbA;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=piOBVxfT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bv3IRYMU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 781F881121;
	Sun, 15 Nov 2026 05:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L9dfVl0ALHN9; Sun, 15 Nov 2026 05:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 940AA81107
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719114;
	b=DVwbR4gKeKNnt6kpHVfCtf3Y6Y9+3YAEj4sBIvl1FBjyh1/z/YGMGipnlBgVRXoPK/lB
	 D7peRC/Lz4t9UTJGqiIrl9UtlJGJ5LIJXPTQWg0YtVEzlenm7XL/mPJeC3ab6AXmz65r8
	 pPerNb268p8A9kcX1Rdxf/UrZcKuQ0Z34lH7boyynLd8qhUnYDCNaPxx3T0BPXm6ROeCP
	 f3DG56ZdlOJevbbN0UfHVI4sdFPsJ3nvd1myXPRFeKn00Yuq8m0RZ5zt39HdJTq7N1lxg
	 a7CNkaVjDHoH31vrFL8r8xjSL2EQebaEhHlV8PH4JS1aaxoHVX/ytxiD0FgwaEH9fFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
	b=fy/619ANy/H/kPunGisvtRsSoHjVfsqp6C+OwxHsr7nrZUvz0CzaIgTTM0Nx5GYKnv9V
	 y4a553h18GeqsFRPlvuJZZzKOEthXqSZ+Stdhm7IKdu5JbCIRgT3t9Oh24A47a4DsSxj2
	 Rmahg6Z5PTHp6c4fL7EB/1HF4dXEkcqeammJoRlLfo8IdGsyayGyATsypHoKpXTDEmSRo
	 tJ8t8B+OYtg01w7IXesgS7tKaBaRy9Sgh/+q0LO/e9kgeBfHMBVpHPmZBPOEDfTGsp4Ao
	 H0vLYAWvLoOu2ZBtF0Fhq8ObfrRkmn92G8bH9estdvIYbZV/ZzPhYGv9yAkP/y4nzwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719114;
	bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XrQdbFbAjLnmVM6bXC+vZzax1VP5Gab2aO3Tvvi5XwkOvWQVwtUKxQI62pHEhM4FA
	 5PFlajHfdH+T4tj8AgHo4IDDkiRi9/UMmtFsV/zPsy9UliPKPg+D9li1YdN/+IF+EE
	 Ddouz+sS/HrIVHSLkPyfe8lMvaYKspMOB7I7JfN2EApxoxCo5ClgrqvCrlaGs1s8UJ
	 3n+zYCooLyhsCNL6LaA9c4+Z2XMJ/PvbiixgmLbvoR0ZAFVIhwwxx6iM8LZCk1OB51
	 XrGvPY3e9WJKi26lNDeBNp5n3KkRcRNKnba4kd77JU86ajojhVmSqiAdhZ5t8HqDJo
	 0HezkqX/Dqzwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 940AA81107;
	Sun, 15 Nov 2026 05:05:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18C2F109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09CB560740
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Hbi5khDlRLd for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E9F160725
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=piOBVxfT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bv3IRYMU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E9F160725
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S1pb111827
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=; b=piOBVxfTvqF/9o2d
 oTIMt678dbDDh7dON2FYqWZUtKHFyG3525pageQyozKlYLkZ1MGqHyx9FpXoGInI
 zb9izSTE7wsZc/WMQJCIqPMIj0IFpG7PrC/3maiA0bKKojG2AJVc7KD/m2dDdq4l
 /zr5fry/vlKvUocLmEatuDopyVbYj/TSYDy5Kvn6Vbuf4P8Ava1z0hGVTJWNzgtq
 vdmciYTNq+s+crntmJlfuIz4vYBZrRimGOxRnv6VPZJeRqOdAH7jr+lVxYbj6OdB
 slNEyH5IyXmhGbrek2gI4GDOpmWEs1opsEwQyLAe2mcwjepAKWm4rtQ9Dxp0UPXJ
 l2mM8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmca8wq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2998107eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719110; x=1795323910;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
 b=Bv3IRYMUrjEMdvavICEYFebvADfmCtzjPHcEvuxrbkM0EahO4qsbsU7UDyLZ6AaAnr
 8G6KG7GVTCYDGHxIQSiIlBm4FEDrQnYNNeJkP7kxavIWFBwOu3pAdVW3WFYuPeIEo8Ly
 dHO91MO8uNj563HQcU8rNkq0L60IM4Tcafo3Oqs3w10RcVb9q78TAkhaty7QX8da8kDz
 Ph3DneOv/EAVH70gq2yXs9iZCrZ6/qPffdgLsT4NMCbQ1NtSF8OgJTWgdO7mm+QdGoRg
 m4erT1RPJ6svQfbs58dhSJx3rn6+s50n0/H2qtA1S3jKnbRm6Gu2ukY4ACruu7vxJmBO
 D2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719110; x=1795323910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g6J1Vy7BYKxbbapJM6KHTDXYr2dJ+Xb7lwhUBT/f1ls=;
 b=eMXG0lRoKKy8efK9gfQ13RjnSX5I6Ipr1Coc7CC63+lfGRuZd47p2FDDDFLg9ics8+
 /hqjAUnIyamWoZi01hjrg7QobzavuDCmQbaSGIxnLQPOT12Lv3zThqJ3W7wSwZcMDiHr
 vZgyQQLnRaW/pSPD6YnLmDiJQR00XWQqLzFK6ZKkBiAWOy4PvQcflMkXTGQTL9B5NbrS
 /AxvGcveUvE+am0T3QMuGPPpwkilEl3vxGF6z/y5v9fYb+9kQ3KzhSfhslJcfClkpvgg
 zSxKTtogVXvy9+eeFv5CAgB83WK2oGS/kWaV59EL2K62IdvXKQlvPfRZFsnLbxWDN01/
 XFeA==
X-Gm-Message-State: APuU4Z+VU+l4nfsJXt8Ucp3qESximjqXaDsoRxQHfXcpYp+Ec80ksPPD
 rTgX86/UIoiFN6v6n9kASmLSWlij2DzEx1o5tGpyZVy90XME+6JeO0rOnhbKhd7OxF4Jz+nd7at
 E9X3KUjXl3GARQrBhs5JcmKjUU98ZjWDUdOQlkM0da3t2ju0AyEZMVyvYqOp7orr9F1qPffY=
X-Gm-Gg: AYBFou0rbFEXmHHqycphIkTuVe4HTLABzhZWO/Z2tbBuFJP2M5qDXAlCxXCeNK/ELtl
 N+oHmO82h/QOkL3gdPPPCvnrziP6Jb1dyBvkshW+SOVYohJK6STSAeZYF0O3vh0fvALTevQLF8c
 HV8nCpHm+xwjurTfZqXvBlt9Y8cUf0sxcUIqmOsvNrMmh8HPLNO9cztH37nw2JTLGZVDWh6Er5p
 JwpZcBu65qW7iIE0KJu3/XGruBTz9gVR2lxfatTikoC/dLjttDe+sYtpvX5npP7tPyBmUQQ3zfd
 w73pIM7Q/kIHmUwzE3h5qn51GrNrfjKeJ+/883mTcHLgWUL/wBiNqFjWk/5ky5BacBDKhAxzt0i
 geKubDoyzRTHSRnC2iqTxb9cF/E7fwDjfQWQ0Lw/N8qVg62wxDBYsW7FRMSajrCo/GYjwlJejo/
 5sU0szLIFYU/dawfoQnsxcv0dAqYl0EjZDiDUP0arH5eBygKY0Kdoyd+YwL6bcROhg2zkJpNisA
 IPN
X-Received: by 2002:a05:693c:80da:b0:37e:9a3b:76a3 with SMTP id
 5a478bee46e88-37e9a3b7e51mr712776eec.11.1794719110141; 
 Sat, 14 Nov 2026 21:05:10 -0800 (PST)
X-Received: by 2002:a05:693c:80da:b0:37e:9a3b:76a3 with SMTP id
 5a478bee46e88-37e9a3b7e51mr712741eec.11.1794719109568; 
 Sat, 14 Nov 2026 21:05:09 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:05:09 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:44 +0530
Subject: [PATCH v2 6/6] test: capsule: Add functional test for
 multi-payload capsule update
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-6-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=4874;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EUbRVdPmEKUW2evwHpiFh4GExDU/i8UMbOwliCkLtAA=;
 b=ZJx7Q2ue6L05XXEowzE3sN1Thpj2Y/bLnODH3zGsym+12cdSCwOjkU7Dy7s8mZUwByIZrlL1J
 S3+FmrxndHUAUPuPa2vnDc1dn2JMIiKLtMe9DHl+NWv3hARNAAjOiBA
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX2t197z+eCy1o
 xdQrDKQa4ZSvjKLqQUtJPc412G0euH0mfgFQQvKNvtAxxTZNUSWCKO8tlM7vFupYoosWtlSPepy
 gGm/BmEgw/QZGmQz7xrq/9KK6B7jeow=
X-Proofpoint-ORIG-GUID: VjhLffv06Jql0IFVhcSrwjfZqsw4CX75
X-Proofpoint-GUID: VjhLffv06Jql0IFVhcSrwjfZqsw4CX75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX86gmLbePN0SH
 GKv4upK4c7zuJ304QH2/J9QCc25J9mT/czbRPjR6iKduZVApygE6snUv0SR/B4tGjUhX00+esBO
 3/c6YGGzJ5+1AXnIIpkYZCDU1O6Et2lg+7nMWXBbxDfb1lrtn50VXg4WcBen20Iw28YrwOdOdG8
 YHYZp7YhnOnibcRrcGbTsLv6PJ6PJdlpyY+u0sCulPO0RuYApiBEr19ZSHSbfHFtVxw3Lbk7g+z
 uvS0uRRaMM4To+8uq63HlcvUE6B5yRZjDF7DqIO0FyQWmD80Mt2TsobgYVfUzG8/RGopNDuegyu
 EgIdII0p78ppm2D56cjDLJ+lIowFwAu17DLu8XUDxawTh/O1zKdjivHdsaU0fRrHU1jhgJVnOnw
 hHIxt3AXWjG7hNVOAR4VC0RjIIO2OL6rIvAZwENeNrJoBbou3mKr04nMyz0jP3tVw9RFKkUHW26
 ysW7KzJEY+27bXzhGrQ==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6af93d86 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=HfRQDYTsxURDGV4gLWcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

