Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YfgT3AgH;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZb14y+b;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZGeWng5X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 557B7608B9;
	Thu, 26 Nov 2026 06:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WcBLWZ2_FtoO; Thu, 26 Nov 2026 06:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ED64B60740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795674053;
	b=OzZoWwDaCHqINE1KGApPkVolmwQvrG9ptC57MCAtuoX7um9Q7AknNHyrwPoc0y3etxnL
	 mRkPUTBEWvFAlZVG1PALbcSAT40LjV2E+3ys8Qe66ZcNXfkjY3SzIWTdv4txpMZdCa3mf
	 Ikb3BVHWDM6ZgF8eDH/m65wrR+DCVFPFcvuKbAwZQBoJXoOnjQzFXEy3/gzEXg8M+U4yg
	 E1nEGuphdxLttoExsxguPSqLofSGb6fLaESjDBHZ+yxBS6tCwmIWVg1C0hJ6SvBREx+QJ
	 2GtEBR3NNN9OyGUJzFW/0S/RiIJEHHhmsGiSLQ2E56XTOORci/7nwS+rJDk+LXceweQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CZvrz3BmE3+PqtejgF/lZ0y1vjG+ynnM5nfsu9y4DuA=;
	b=ie9zhVDXRqxgeFW2x34VAOnP7NmDyAcIOs93TK38fp2J1/LkiZqb+2d98XF8NaWpuOyG
	 Q4pck2GT/9oPnWI001h13f/tw50mMWQh/EMJSmOZ9uV4n2sqo+Rl3aE7jCUNeygKFURTw
	 G00juHOzn+e/0KqhJlFNKUTjuPUthQDheAIuHM16Xl58hOhqo5IGYvNsks+zSFyl3Gg9K
	 wHubruzR4/mAHiEqZjmaQL7ffmXGqEPse8H0sF144j9xCdzUbaaM7Dcbv86ABwnWDMMXR
	 VsxtE22YJJXYgtA6dCa4NFKKyXpEaD1+E+E+yJTbXGllMYJ1bUHJuIxFaAtfcY2W3bQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795674053;
	bh=CZvrz3BmE3+PqtejgF/lZ0y1vjG+ynnM5nfsu9y4DuA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YfgT3AgHqC5DMoR4SlIMlutxAk/NeGLCD3bvTOCajUADB3QKxFb3+HogyZsI2lxaR
	 /Awvvajl3rliCqcIshFjuvEnx/vV+qA8J4MLVxrZSGsRmoSD8WhG6CIiMOVdZDyFYi
	 IQKHk//m8iYZnelQWs4L+vROUONa+sBmdFM9pIB+WU16spTt3Mm24HGRs6pYHyUCsK
	 JAwtc+ZMhgcSLhmHdOVwqBFQ7jkzIzW2PEZnoK4/a6LCiEaOCG4yPHzgvx0/KlbHS3
	 XECbCIFUDCT7fA+H3BfJbi09xNxfPhmk5hQTrhgG6XFvKK8NEcLzfqQ7r4yihIZ/HX
	 Kmod8aeof6bjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED64B60740;
	Thu, 26 Nov 2026 06:20:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3CC122B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A09C4405B1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EulhDVyf2i2w for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0661040597
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pZb14y+b; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZGeWng5X
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0661040597
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:20:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ69dYr2749521
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=CZvrz3BmE3+PqtejgF/lZ0y1vjG+ynnM5nf
 su9y4DuA=; b=pZb14y+bOrUs4AFFocLYxDFrFVV07JdfKimfdVFDHcEexj75jMU
 2+lj7bBTy3fPwDdHcF8bMuVulvvl1uUeVU139ce9d8V8QUbegkRHn7v2URatVqjF
 c4FPJPw7DjO5C51UuZwHsbZDAFOin7y8yWF9AfShL35meLjihwqy30CgwOMR705I
 RVX7OxA06eMDKhXkWkr5aobdC8JUY1OiQnLr8Oa2eKucCnQScOTTkLXBPjE/E+TN
 fnQMwAU+PjkOY7tXVDSX6SiPDdZJCZmE/91+EKjwqRuWmn5a1LUXAqEWvWP+Owq0
 /tLA+tWCkUWSwtbIkjVlPOJgxcVBj7ezcFA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rg14n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:20:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386ad819860so3637254eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674047; x=1796278847;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CZvrz3BmE3+PqtejgF/lZ0y1vjG+ynnM5nfsu9y4DuA=;
 b=ZGeWng5X/NvVNUXNsOQmiWb0dQ6OSNaCmx9VL+XFgu8gydzS5AYZGmyOPrt7gtucuS
 O4cKFbDIfSM/YhAo3YnfsuG4TQVCpfhV9UpAcXcNb3O/1aSSbiAMh6l/6kKprj3UoUNa
 kCW2j/ovrpwypjf2fQ5BPvMHu7jnkGwN2Qe0HL0pC07waWs+1LEKxORyHVfeuC9HpWyi
 bjTPFykQwEn6+sE5TkO5E7ZWq7pqzI3HTILZ+l2jTbsTEAi9ol5sOSfSe5udOJ+MO7ZJ
 ex6NHADWz0GngmVAtRkFlvbQkBYQLJV5ZMjA2fXzYcLIRtNb7GTX+g6vTdMgaTTWZIxd
 b6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674047; x=1796278847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CZvrz3BmE3+PqtejgF/lZ0y1vjG+ynnM5nfsu9y4DuA=;
 b=2Vg8ZMipZuEE+HC7nQ84GhZ0T/kcd1QEFHlfs5HWDl9jGwKU/F9NfriXuqofDVbOde
 vsrEQTcKVdPQbDlKF8g3mKW8tZfwSKZJ8DfhlIU0G/A1KYuFK9NBtRe0JV6A/9hziiRk
 Lqa/ImQidKrblZTvmxSWVB6VQhlthRfcAY4NhY79tuE2wwvhfDiVK2NQwYjP9xJEECcP
 D8Hpidia9g8ZQfRfwxBroSk7zpdvjAMbJxGMo+cI7Ym4L8VOctY1cZ6cDGH8dmePUqwN
 yc9O29RX7o8YqH5C98qk3YAJ0/xfcpMNV1pL4tlkz7s0VO5QwCamVE08lhfi6gYa/Rsg
 KuYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEElsrNulsWTUzBv2d6NKK2DVDYguetYBwvtglFqdxKvWjPyZnzyfMeiSFOBL3kIiaBTrEljl8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9VBqrInGr/fD01j3098HQ5YLtLF+O6DzlP7iTVr3wAPgM0qYb3
 tHWZ835TC62wZS8daRduAoW+FP5M1B3J7j0WSMegpih51MnU+FdHEWKy68CxHglJUN7eW22vIqG
 2iQqC5PS1d9jbxgDvdixEGrjdkgdB2gpIU/1wvYaWHZPxvNOVN7CVNsgp00UTFizph+IlLa4=
X-Gm-Gg: AZFdTZe7YFOWxLb/BoOANdQ8IHBG3PoiTH1wszk3bl7SBBsQcLcqs3/QYLZ7rUb1BCN
 TM1tqiLRlXnANXeYvZ7EZeAt5G8K2pzO4RmY3wTwycbKOTqhgOCVI82mZMLD+fZAbiEbWczx61p
 hOVbDqDcaSCPwIQfigCttISmWwPZZXI3luRDf3Xo4cpIaoDXE+r9USDQC52h8m7tvpFi3Arhycd
 GmY+azPP6tk47Edu2e5QgviaBPvQPmETtIuLIMhse+CftjLSBq9ZUMfpjy9RXEcZqEVlCwFtKzZ
 XEic5/kgDXq4+swtebWu+B1OcKEMRrB7bXlVeH+DCf5Ts7Ao6vQibF8pemglPwU7LTCwaO2mDEj
 RJEKKQsAsoi1O61rVFwnCaaZWmhFwgMyOnwLoPe+3Pbcys/hC+TvjesQiOHK6hExAbrNReBx1rT
 FDanWKBldkJdzFh9t9ojH773Z1tGkDNrHI9YAFeTJ2mYycbHR1u9FdtIW/XEmztnqNkOU=
X-Received: by 2002:a05:7301:1601:b0:386:c990:c5a with SMTP id
 5a478bee46e88-386c9900e99mr5804964eec.40.1795674047000; 
 Wed, 25 Nov 2026 22:20:47 -0800 (PST)
X-Received: by 2002:a05:7301:1601:b0:386:c990:c5a with SMTP id
 5a478bee46e88-386c9900e99mr5804931eec.40.1795674046365; 
 Wed, 25 Nov 2026 22:20:46 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm67296139eec.24.2026.11.25.22.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:20:45 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, marek.vasut+usb@mailbox.org, bmeng.cn@gmail.com,
 iwamatsu@nigauri.org, neil.armstrong@linaro.org, jbx6244@gmail.com,
 aswin.murugan@oss.qualcomm.com, senthilkumar.l@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] usb: host: load Renesas xHCI firmware from a build-time
 supplied file
Date: Thu, 26 Nov 2026 11:50:31 +0530
Message-Id: <20261126062031.3858066-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX/h7Y41Zs2F2X
 5lntVx+AJnVgdF0gylDiCaj4evyUbNmYIUKqy6ThxzrDSteBR+8w/c0F1xDjG9Y3L//M1XcbwSl
 4vw9FE33CJvFLedsAUaFh5BgBTE1aZ3vRoJsOBshFu1rDVxTUdGvWSXiGK7myhik2co+IuGQiDV
 6FFtcYdc/XMezwuwr3cXJexAIdr38TuaFd5Om1Eyej2cv2LvApxrZW4WpkWw5JgpSa9WO4b6H7M
 bzspOzutqoj9kbGAUeIVmffoAkX9Z/44uGbFzancLMAHBKuic/yFjZsQuXWeK2Y4pmL0fbQ6y1i
 mm/9j/kHxqErPi4TA6CF7y4yUfBdYJeCLRFY6wC0K7wJZm7jr0+yZzSsPWuX7eEtg193xBa71j2
 nMODSxssXpd1ryP6jmckJcN/ySTnrVaPZv/GZqIA469JNMZp9L5wv4JQJNkt9EC8DohuMX5PsFm
 N8ooHowk8yt9TPVKTSw==
X-Proofpoint-GUID: 5_5G1qzJcL0D7LefjaaYI5RohlA2KZrB
X-Proofpoint-ORIG-GUID: 5_5G1qzJcL0D7LefjaaYI5RohlA2KZrB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXwojdtAU9sLjh
 OPeqBImQ6Y0fdSkmZfW4eFUeMSJBsPEzcstvSWC7hWbUvGL8sFFAB15yydTLdJZxZWM1Hguf09b
 YYszd45b8FczrNt0d8Ao5YmHw+PTAWk=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b07cfc0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VYaVabd9Pe3BLzqaYe0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

The Renesas uPD720201/uPD720202 PCIe-to-USB3 host controller requires
firmware to be downloaded over PCI configuration space before it can
operate as an xHCI host controller.

Add support for supplying the firmware at build time through the
USB_XHCI_PCI_RENESAS_FW_FILE Kconfig option. The firmware image is
linked into the U-Boot binary using .incbin and exposed through linker
symbols for consumption by the xHCI driver.

This ensures the firmware is available before PCI/USB initialization,
without requiring runtime access to network or storage. On platforms
such as QCM6490, where the onboard Ethernet interface is connected
through this controller, the firmware must be available before network
initialization, enabling network boot use cases.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/usb/host/Kconfig                    |  24 ++
 drivers/usb/host/Makefile                   |   7 +
 drivers/usb/host/xhci-pci-renesas-fw-seed.S |  16 +
 drivers/usb/host/xhci-pci-renesas.c         | 374 ++++++++++++++++++++
 include/pci_ids.h                           |   2 +
 5 files changed, 423 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-renesas-fw-seed.S
 create mode 100644 drivers/usb/host/xhci-pci-renesas.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6bbed9cb513..9c638fc09c3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -102,6 +102,30 @@ config USB_XHCI_PCI
 	help
 	  Enables support for the PCI-based xHCI controller.
 
+config USB_XHCI_PCI_RENESAS
+	bool "Renesas uPD720201/uPD720202 PCIe xHCI controller support"
+	depends on USB_XHCI_PCI
+	help
+	  Enables firmware download and xHCI bring-up support for the
+	  Renesas uPD720201/uPD720202 PCIe-to-USB3 host controller. This
+	  chip requires a firmware image to be downloaded over PCI
+	  configuration space before it functions as a standard xHCI
+	  controller.
+
+if USB_XHCI_PCI_RENESAS
+
+config USB_XHCI_PCI_RENESAS_FW_FILE
+	string "File with the Renesas uPD720201/uPD720202 firmware image"
+	depends on !COMPILE_TEST
+	default "renesas_usb_fw.mem"
+	help
+	  File with the Renesas uPD720201/uPD720202 firmware image, obtained
+	  separately. This file is linked into the U-Boot binary at build
+	  time. If a relative file path is used, it is relative to the
+	  source directory.
+
+endif
+
 config USB_XHCI_RCAR
 	bool "Renesas R-Car USB 3.0 support"
 	default y
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 9cac53f07c7..ec00ae333ba 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -53,8 +53,15 @@ obj-$(CONFIG_USB_XHCI_MVEBU) += xhci-mvebu.o
 obj-$(CONFIG_USB_XHCI_GENERIC) += xhci-generic.o
 obj-$(CONFIG_USB_XHCI_OMAP) += xhci-omap.o
 obj-$(CONFIG_USB_XHCI_PCI) += xhci-pci.o
+obj-$(CONFIG_USB_XHCI_PCI_RENESAS) += xhci-pci-renesas.o xhci-pci-renesas-fw-seed.o
 obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
 obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o
 
+TMP_RENESAS_XHCI_FW := $(subst $\",,$(CONFIG_USB_XHCI_PCI_RENESAS_FW_FILE))
+RENESAS_XHCI_FW_SEED_FILE := $(if $(filter /% ,$(TMP_RENESAS_XHCI_FW)) \
+  ,$(TMP_RENESAS_XHCI_FW),$(srctree)/$(TMP_RENESAS_XHCI_FW))
+AFLAGS_xhci-pci-renesas-fw-seed.o := -DRENESAS_XHCI_FW_SEED_FILE=\"$(RENESAS_XHCI_FW_SEED_FILE)\"
+$(obj)/xhci-pci-renesas-fw-seed.o: $(RENESAS_XHCI_FW_SEED_FILE)
+
 # designware
 obj-$(CONFIG_USB_DWC2) += dwc2.o
diff --git a/drivers/usb/host/xhci-pci-renesas-fw-seed.S b/drivers/usb/host/xhci-pci-renesas-fw-seed.S
new file mode 100644
index 00000000000..bfeb73a0506
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-renesas-fw-seed.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Renesas uPD720201/uPD720202 xHCI controller firmware, linked in from a
+ * file supplied at build time via CONFIG_USB_XHCI_PCI_RENESAS_FW_FILE.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. All rights reserved.
+ */
+
+.section .rodata.renesas_xhci_fw.init,"a"
+.balign 16
+.global __renesas_xhci_fw_begin
+__renesas_xhci_fw_begin:
+.incbin RENESAS_XHCI_FW_SEED_FILE
+.global __renesas_xhci_fw_end
+__renesas_xhci_fw_end:
+.balign 16
diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
new file mode 100644
index 00000000000..5ed859a353e
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Renesas uPD720201/uPD720202 PCIe xHCI controller driver.
+ *
+ * This controller has no firmware in ROM; a firmware image must be
+ * downloaded over PCI configuration space before the device behaves as a
+ * standard xHCI host controller. Ported from the Linux kernel driver
+ * xhci-pci-renesas.c
+ *
+ * The firmware image is supplied at build time via
+ * CONFIG_USB_XHCI_PCI_RENESAS_FW_FILE and linked directly into the
+ * U-Boot binary by xhci-pci-renesas-fw-seed.S, since on boards where
+ * Ethernet is itself a USB-attached device behind this controller,
+ * USB must already be functional before any storage or network path
+ * exists to load firmware from at runtime.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. All rights reserved.
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <init.h>
+#include <log.h>
+#include <pci.h>
+#include <pci_ids.h>
+#include <reset.h>
+#include <time.h>
+#include <usb.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <usb/xhci.h>
+
+extern char __renesas_xhci_fw_begin[];
+extern char __renesas_xhci_fw_end[];
+
+#define RENESAS_FW_VERSION		0x6c
+#define RENESAS_FW_VERSION_FIELD	GENMASK(23, 7)
+#define RENESAS_FW_VERSION_OFFSET	8
+
+#define RENESAS_FW_STATUS		0xf4
+#define RENESAS_FW_STATUS_DOWNLOAD_ENABLE	BIT(0)
+#define RENESAS_FW_STATUS_LOCK			BIT(1)
+#define RENESAS_FW_STATUS_RESULT		GENMASK(6, 4)
+#define RENESAS_FW_STATUS_INVALID		0
+#define RENESAS_FW_STATUS_SUCCESS		BIT(4)
+#define RENESAS_FW_STATUS_ERROR		BIT(5)
+
+#define RENESAS_FW_STATUS_MSB		0xf5
+#define RENESAS_FW_STATUS_SET_DATA0	BIT(0)
+#define RENESAS_FW_STATUS_SET_DATA1	BIT(1)
+
+#define RENESAS_DATA0			0xf8
+#define RENESAS_DATA1			0xfc
+
+/* Firmware header, per Renesas datasheet R19UH0078EJ0500 Rev.5.00 6.3 */
+#define RENESAS_FW_MIN_SIZE		0x1000
+#define RENESAS_FW_MAX_SIZE		0x10000
+#define RENESAS_FW_MAGIC		0x55aa
+
+#define RENESAS_RETRY			50000	/* * 10us ~= 500ms */
+#define RENESAS_DELAY_US		10
+
+struct xhci_pci_renesas_plat {
+	struct reset_ctl reset;
+};
+
+/*
+ * renesas_fw_verify() - sanity-check the embedded firmware header
+ *
+ * @data: firmware image, treated as an array of 32-bit little-endian words
+ * @size: firmware image size in bytes
+ */
+static int renesas_fw_verify(const u32 *data, size_t size)
+{
+	const u8 *fw_data = (const u8 *)data;
+	u16 fw_version_pointer;
+
+	if (size < RENESAS_FW_MIN_SIZE || size >= RENESAS_FW_MAX_SIZE) {
+		log_err("renesas xhci: bad firmware size %zu\n", size);
+		return -EINVAL;
+	}
+
+	if (get_unaligned_le16(fw_data) != RENESAS_FW_MAGIC) {
+		log_err("renesas xhci: bad firmware magic\n");
+		return -EINVAL;
+	}
+
+	fw_version_pointer = get_unaligned_le16(fw_data + 4);
+	if (fw_version_pointer + 2 >= size) {
+		log_err("renesas xhci: bad firmware version pointer\n");
+		return -EINVAL;
+	}
+
+	log_err("renesas xhci: firmware version %02x.%02x\n",
+		fw_data[fw_version_pointer + 1], fw_data[fw_version_pointer]);
+
+	return 0;
+}
+
+/*
+ * renesas_fw_check_running() - check whether firmware is already loaded
+ *
+ * Return: 0 if firmware is already loaded and running, 1 if firmware needs
+ * to be downloaded, or a negative error code on unrecoverable failure.
+ */
+static int renesas_fw_check_running(struct udevice *dev)
+{
+	u8 fw_status;
+	int ret;
+
+	ret = dm_pci_read_config8(dev, RENESAS_FW_STATUS, &fw_status);
+	if (ret)
+		return ret;
+
+	if (fw_status & RENESAS_FW_STATUS_LOCK) {
+		if (fw_status & RENESAS_FW_STATUS_SUCCESS)
+			return 0;
+
+		dev_err(dev, "renesas xhci: firmware lock set without success\n");
+		return -EIO;
+	}
+
+	if (fw_status & RENESAS_FW_STATUS_DOWNLOAD_ENABLE) {
+		dev_err(dev, "renesas xhci: firmware download left enabled\n");
+		return -EIO;
+	}
+
+	switch (fw_status & RENESAS_FW_STATUS_RESULT) {
+	case RENESAS_FW_STATUS_INVALID:
+		return 1;
+	case RENESAS_FW_STATUS_SUCCESS:
+		return 0;
+	case RENESAS_FW_STATUS_ERROR:
+		return -ENODEV;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * renesas_fw_download_word() - transfer a single 32-bit firmware word
+ *
+ * @step: word index into the firmware image; even steps go to DATA0, odd
+ * steps go to DATA1, per the controller's 64-bit "row" mailbox layout.
+ */
+static int renesas_fw_download_word(struct udevice *dev, u32 word, size_t step)
+{
+	bool data1 = step & 1;
+	u8 status_bit = data1 ? RENESAS_FW_STATUS_SET_DATA1 :
+				 RENESAS_FW_STATUS_SET_DATA0;
+	u8 fw_status;
+	int ret, i;
+
+	for (i = 0; i < RENESAS_RETRY; i++) {
+		ret = dm_pci_read_config8(dev, RENESAS_FW_STATUS_MSB, &fw_status);
+		if (ret)
+			return ret;
+		if (!(fw_status & status_bit))
+			break;
+		udelay(RENESAS_DELAY_US);
+	}
+	if (i == RENESAS_RETRY)
+		return -ETIMEDOUT;
+
+	ret = dm_pci_write_config32(dev, data1 ? RENESAS_DATA1 : RENESAS_DATA0,
+				    word);
+	if (ret)
+		return ret;
+	udelay(100);
+
+	return dm_pci_write_config8(dev, RENESAS_FW_STATUS_MSB, status_bit);
+}
+
+/*
+ * renesas_fw_download() - download firmware into the controller's internal
+ * RAM over PCI configuration space
+ */
+static int renesas_fw_download(struct udevice *dev, const u32 *fw_data,
+			       size_t fw_size)
+{
+	u8 fw_status;
+	int ret, i;
+	size_t words = fw_size / 4;
+
+	ret = dm_pci_write_config8(dev, RENESAS_FW_STATUS,
+				   RENESAS_FW_STATUS_DOWNLOAD_ENABLE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < words; i++) {
+		ret = renesas_fw_download_word(dev, fw_data[i], i);
+		if (ret) {
+			dev_err(dev, "renesas xhci: download failed at word %d/%zu (%d)\n",
+				i, words, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < RENESAS_RETRY; i++) {
+		ret = dm_pci_read_config8(dev, RENESAS_FW_STATUS_MSB, &fw_status);
+		if (ret)
+			return ret;
+		if (!(fw_status & (RENESAS_FW_STATUS_SET_DATA0 |
+				    RENESAS_FW_STATUS_SET_DATA1)))
+			break;
+		udelay(RENESAS_DELAY_US);
+	}
+	if (i == RENESAS_RETRY)
+		dev_warn(dev, "renesas xhci: timeout waiting for final word ack\n");
+
+	ret = dm_pci_write_config8(dev, RENESAS_FW_STATUS, 0);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < RENESAS_RETRY; i++) {
+		ret = dm_pci_read_config8(dev, RENESAS_FW_STATUS, &fw_status);
+		if (ret)
+			return ret;
+		if (fw_status & RENESAS_FW_STATUS_SUCCESS)
+			break;
+		if (fw_status & RENESAS_FW_STATUS_ERROR) {
+			dev_err(dev, "renesas xhci: firmware download error\n");
+			return -EIO;
+		}
+		udelay(RENESAS_DELAY_US);
+	}
+	if (i == RENESAS_RETRY) {
+		dev_err(dev, "renesas xhci: timeout waiting for download result\n");
+		return -ETIMEDOUT;
+	}
+
+	log_err("renesas xhci: firmware download succeeded\n");
+	return 0;
+}
+
+static int renesas_xhci_check_request_fw(struct udevice *dev)
+{
+	size_t fw_size = __renesas_xhci_fw_end - __renesas_xhci_fw_begin;
+	const u32 *fw_data = (const u32 *)__renesas_xhci_fw_begin;
+	int ret;
+
+	ret = renesas_fw_check_running(dev);
+	if (ret <= 0)
+		return ret;
+
+	ret = renesas_fw_verify(fw_data, fw_size);
+	if (ret)
+		return ret;
+
+	log_err("renesas xhci: firmware not running, downloading\n");
+	return renesas_fw_download(dev, fw_data, fw_size);
+}
+
+static int xhci_pci_renesas_init(struct udevice *dev,
+				 struct xhci_hccr **ret_hccr,
+				 struct xhci_hcor **ret_hcor)
+{
+	struct xhci_hccr *hccr;
+	struct xhci_hcor *hcor;
+	u32 cmd;
+
+	hccr = (struct xhci_hccr *)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0,
+						   0, PCI_REGION_TYPE,
+						   PCI_REGION_MEM);
+	if (!hccr) {
+		dev_err(dev, "renesas xhci: cannot map PCI mem bar\n");
+		return -EIO;
+	}
+
+	hcor = (struct xhci_hcor *)((uintptr_t)hccr +
+			HC_LENGTH(xhci_readl(&hccr->cr_capbase)));
+
+	log_err("renesas xhci: hccr %p hcor %p\n", hccr, hcor);
+
+	*ret_hccr = hccr;
+	*ret_hcor = hcor;
+
+	dm_pci_read_config32(dev, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_MASTER;
+	dm_pci_write_config32(dev, PCI_COMMAND, cmd);
+
+	return 0;
+}
+
+static int xhci_pci_renesas_probe(struct udevice *dev)
+{
+	struct xhci_pci_renesas_plat *plat = dev_get_plat(dev);
+	struct xhci_ctrl *ctrl = dev_get_priv(dev);
+	struct xhci_hccr *hccr;
+	struct xhci_hcor *hcor;
+	int ret;
+
+	ret = reset_get_by_index(dev, 0, &plat->reset);
+	if (ret && ret != -ENOENT && ret != -ENOTSUPP) {
+		dev_err(dev, "renesas xhci: failed to get reset\n");
+		return ret;
+	}
+
+	if (reset_valid(&plat->reset)) {
+		ret = reset_assert(&plat->reset);
+		if (ret)
+			goto err_reset;
+
+		ret = reset_deassert(&plat->reset);
+		if (ret)
+			goto err_reset;
+	}
+
+	ret = renesas_xhci_check_request_fw(dev);
+	if (ret) {
+		dev_err(dev, "renesas xhci: firmware bring-up failed (%d)\n", ret);
+		goto err_reset;
+	}
+
+	/*
+	 * Settle time between firmware-download-success and first MMIO/xHCI
+	 * touch. The Renesas on-chip CPU needs time to finish booting into
+	 * xHCI mode after FW_STATUS reports SUCCESS.
+	 */
+	mdelay(100);
+
+	ret = xhci_pci_renesas_init(dev, &hccr, &hcor);
+	if (ret)
+		goto err_reset;
+
+	ret = xhci_register(dev, hccr, hcor);
+	if (ret)
+		goto err_reset;
+
+	return 0;
+
+err_reset:
+	if (reset_valid(&plat->reset))
+		reset_free(&plat->reset);
+
+	return ret;
+}
+
+static int xhci_pci_renesas_remove(struct udevice *dev)
+{
+	struct xhci_pci_renesas_plat *plat = dev_get_plat(dev);
+
+	xhci_deregister(dev);
+	if (reset_valid(&plat->reset))
+		reset_free(&plat->reset);
+
+	return 0;
+}
+
+/*
+ * pci_find_and_bind_driver() binds the first alphabetically-sorted driver
+ * whose pci_device_id table matches. The uPD720201 reports a standard xHCI
+ * class code even before firmware loads, matching generic xhci-pci.c's
+ * wildcard too, so "renesas_xhci_pci" relies on sorting before "xhci_pci" -
+ * do not rename without re-verifying bind order on hardware.
+ */
+U_BOOT_DRIVER(renesas_xhci_pci) = {
+	.name	= "renesas_xhci_pci",
+	.id	= UCLASS_USB,
+	.probe = xhci_pci_renesas_probe,
+	.remove	= xhci_pci_renesas_remove,
+	.ops	= &xhci_usb_ops,
+	.plat_auto	= sizeof(struct xhci_pci_renesas_plat),
+	.priv_auto	= sizeof(struct xhci_ctrl),
+	.flags	= DM_FLAG_OS_PREPARE | DM_FLAG_ALLOC_PRIV_DMA,
+};
+
+static struct pci_device_id xhci_pci_renesas_supported[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_UPD720201) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_UPD720202) },
+	{},
+};
+
+U_BOOT_PCI_DEVICE(renesas_xhci_pci, xhci_pci_renesas_supported);
diff --git a/include/pci_ids.h b/include/pci_ids.h
index cfff275daba..3ccb76fc3ff 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2443,6 +2443,8 @@
 #define PCI_DEVICE_ID_RENESAS_SH7763	0x0004
 #define PCI_DEVICE_ID_RENESAS_SH7785	0x0007
 #define PCI_DEVICE_ID_RENESAS_SH7786	0x0010
+#define PCI_DEVICE_ID_RENESAS_UPD720201	0x0014
+#define PCI_DEVICE_ID_RENESAS_UPD720202	0x0015
 
 #define PCI_VENDOR_ID_SOLARFLARE	0x1924
 #define PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0	0x0703
-- 
2.34.1

