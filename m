Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC88C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3753240743;
	Thu,  6 Aug 2026 16:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcV8M1bhNBm8; Thu,  6 Aug 2026 16:13:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B15C40798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032793;
	bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KsLWxwbwie+qJLKKfUgKJAp4y4JKVpqPfJ7Ob72U97nK5yruJOLxnAVIClvVkAVWM
	 slmyLawZwlSFJ854dklriYkkqd+Cx+hcx5sOVRmk2I2xO8fEpvdfcbz2PBYJtog6Xi
	 +LIkpnU7Ip+ioyjO4yzoEK57LX/vc/AnUXM2N2QXrOHViEs3p0cYRkFY6KBRJRBJ2f
	 ohAT99GarspxYrELpO5SrOgnywdXXqTxuOI8uXRnqWzmPz8H3Vs2CF5eZF95BgRTwB
	 dnxidyna4tapR+B7/13vmQAYE5PeTDRZyF1dYXWwdl0z9RNkDdR31YCLqfaI5S8nSh
	 Bzp5O7fhLqnlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B15C40798;
	Thu,  6 Aug 2026 16:13:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B4652B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98F96402A4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGrU52OiCl1r for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:13:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A72ED400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A72ED400D8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A72ED400D8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676G6SOX2146545
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:13:10 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvwg98227-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:13:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso2819864a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032789; x=1786637589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
 b=qlOkkfvHD9Lmr6nwLWd3aTQRfA8D5BJsDftkLjMo/9JbMjPWK1uC3IT7dbquTlXPN9
 iRP3aYe6fIjFdYsFyjluDrtjCUDUS6j3WBqMKvCDF9PccYIqssRDw8FQsXDwkYe80JvK
 7b1E4wWAv71/tIIZ6O42E+kO8TMW50BPV/sWG0Cl3IvRH3yXYWCAEe+whxS7+F3Ae9xk
 PvLWT+pfe0SessmdXEd2DItRBAL4cdkGdQI26o2kpND2JDuGQBZ/kXPrdyKGIDV/Mw9m
 zT600X2P3Qb6fZ6Sn88s5M721kV2nAxxLx4IGW6Yu8mrGrHfW1xyaA/OmXNTsP6FiNU4
 hXyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOYh+BRSsIrsTowrr53fCnlAWktgn3r9Q7jczhNEj8FKxLyIVDCv9ZxYbI329sLJ4Y4szyGD8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyg4bp1ot5uCRJxrRI5aWVvjhRrUIsqKrx5t7WD+cQZQhjno8hm
 FtLMFbn5i50PvvkN7V8zNW3w+bEjvn7kvLEq7aux2+qxjMHXj96DruCGDxe9AgVnBaK67eW4EXI
 Num2RUq+CPiY9lf/feOs7abWpmZ4aCSLzGU1kxKKy1Ubwnh2j/YwD2UZxHfA2YEJz6zwyRsk=
X-Gm-Gg: AR+sD11qSQtB4Jqj/ba6J0pErqUabQlB3c3FbsfLph7whVdQ1JACDsV6RXPuKpVpuum
 3Jdo87rQaqLGTHnMdsKStanvnDQW5Dl2XPOH3apOBN4hE+B6cldF6CxO9VixacmbACvFzf9/oOU
 Q6nm6z14aEqSBkxjohUBtjPhkHXmhDwcH+jdIBjWiUEU8T8/ZY5Hp0lB8KuFwE3DWi6UIptmsUI
 +fDVgK+Pjzgd+xbdcR0Y1mhHmep0VB8ZA0VtDoUL5ZQOlWNti+GYN6/CMe1Rb5Pvk+wJ2B+io2f
 +upU9Ka9lE812ohhwTxuCK6HHbroeCvBM6QAvDGhSNg0JPBD+8N/91hJJ6AVZ7kMc/dl7Ue+CL1
 OwLIiu24qPuK1R6k/RFdJhsoIIHobgg7RylpaifrQgMUBpYzs6VHWJfLlNUJMKCwkqKezQ0KUPn
 P0rUuZDBY+M45K+TbHTSdIzWvllC5P
X-Received: by 2002:a05:6a20:da1b:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3cb85ffd847mr20856321637.37.1786032789235; 
 Thu, 06 Aug 2026 09:13:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:da1b:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3cb85ffd847mr20856247637.37.1786032788757; 
 Thu, 06 Aug 2026 09:13:08 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:13:08 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:24 +0530
Subject: [PATCH 7/7] configs: qcom_qcs8300: Switch to monaco-evk DT and
 enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-7-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=779;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=65vXpYdHa8nCXtebg/bwjCZq6MXkdl1RqQBK55oB+2k=;
 b=fhVnNaCS1IWZi3TbTqr+2yN3As7fjbg3YcnfJ0NjY6zdF7tcLWBEGY6aoh4pCnF5D5UtnESOB
 MWwCD/wtWfuBZEsKeC3L3XmH5NRkHmQY6Pq8siDOCeQ8nls+a/QdggF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX0T2bxrleARmN
 /PtVAwAjZzdM3J2aJqAddByUNxViKBGFe3bD3omf3HG4AJqIVv4asTiNSdL+zYdxYZXUEu+hCBl
 vTOsBtEaX0hXhKiEPIzqJfxgOg2i9nA=
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a74b296 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=p8VvgLCOea7M2xW4:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uNq1Cg9DbGaxvhqkZz4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: EOU9qRL7FtpV4nKkytIJdSPJJ4vDzyrr
X-Proofpoint-GUID: EOU9qRL7FtpV4nKkytIJdSPJJ4vDzyrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX78pl306VntqO
 58kBELkGe3YGoPOWT6iZt+AMKqu2+a42A2yyeMYRMAx7jajIaF6m7Hv3w0p2mByQ9CU9tQ1tSv1
 26s6RVRL4fYkFYpbccG+kZH6nCdDrPdkCnfRjHxHmLppoJjjnC1t4jNnQbxiYNJUyRSbCEbMhGY
 BdeM/YcFHdSJscz9s8NTUXcmtfImDzCisKAURRA42KcHotw8JAdrPzCDYZaKm77MOlhlgv1rGl6
 VpvL/ktGUAwNXsr8zCokwP+RyWk7Fk92eOiN1gDxStlUlTr5LI3PUmyXBmLZng0DD+0QMmzE9Jk
 oL16sq/trF7hfzBWYMIfEZ844ewUHPihGGF1YKwkIjMG/JpCeeCe4lv3bBLh7hLj7icmLWhfpT4
 zDFe6jrQfzDCYZ3W4hkt9T/Ap3FpXUqtYf+0XAfT6ooXLuSyBridN4ayKUuTxr1ksoG7u9B0UdH
 b1QqMhjt+vq5BixzA5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=; b=QzQcO5Jzsndb+uZW
 QGknG0J1CqOp/sNo6uyFrKcKMvL/2hSyJmTglDRZSu5o7tfbtMSycQrKKe/l/Vpw
 uzlxOlGfbiRDFR3GoCOh0zt+uOGYKy1OWNmSA1Da4BVqrUkeijnZlCb4yv8GabRJ
 lNTS/cIXROgags1VqjztBaAR8LHTrTEGJtbIud0iD20WhHwSHB7an0gQYFhTOR5t
 B1lqgWnlp1LUYrEz/61ll3sbdW02YBi+biRnSjxgQkEznaDnRlT73Pm/BO9VnFAX
 puRDk9JgRUOWuBvCoisM+JMU3yqIefW6sY+njYxYJ428TKcRsxpUjmUzdOkuccQ3
 sip3aA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032789; x=1786637589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
 b=XZbe6n0JlITxOBm8cILvc9jTQ6PSKwJYZOa99Q6wIcmmyseHK8p/U40rtKW+LXZb7a
 MX7eZvWeAgzhU7njzt++NtT1711VPlKtU6n91IXxEiCo1XMxCeKMkGD+dKI+Qj10F1gp
 7ArP0mtzBfZ7W4dJPbVbi3y0E+qN7Un2fuwiFNGlqL8Fk8Db5R+8aoKjYNO236aYK2dH
 CipGCtRf1um7ziEXjDci0o++XIoiyL0tnw5LAVYOX65K9LYuaiOio3OHoBZ0duap+dI0
 DxVYo+HDoghSJ0JIU3KTNPDL6hpKjes9XqXhhJ+2ozntDjbHegz0bvZopQheAJQ6xMlv
 h0nQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzQcO5Jz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XZbe6n0J
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

Point qcom_qcs8300_defconfig at the monaco-evk device tree and
turn on required drivers.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs8300_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 5fffcddc16e..c8c4ccb9ab2 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -18,4 +18,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"
+CONFIG_PINCTRL_QCOM_QCS8300=y
+CONFIG_INTERCONNECT_QCOM_QCS8300=y
+
+CONFIG_WATCHDOG_AUTOSTART=y

-- 
2.34.1

