Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B20606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YOWsUiUt;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HYN4AQ4V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RF7V1ztB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E4854062C;
	Mon, 16 Nov 2026 06:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBrBSLV9WRi8; Mon, 16 Nov 2026 06:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FC11405BF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794810594;
	b=W6WOA54eOKwD2pG+ZjY4wM7/7kpAS0geVuIP43/xLWNsTabCVSZ7XuqN7Rz9/Q/6wbsg
	 XSC+42ys4wlmaf1dUfe8sol1pqXdRRntZTvhnbpgcxB0Vf9RAYh3osFAbgWgTlnKvAxxH
	 1i3C0SvpB+czGI4sia/j1Hjq04OUYx2QueQ6NVd3yrFTXgQK6/S3ck9eh5RrBm3eizMgL
	 5l7rrdLHCAh9848Zev77VubQBnL8++Lh8g3CcOCiMBFQHZLjY0NbGaNffMTA0G83BITir
	 ++h++4j7b33YK4zvtE2xuOGti5DSEbaTKREMzp79UD+hbacmyU1pyUi1RfjHAWEn1dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1VSEjzja96/bwIscsBz/T8fMXaatYtAPy0l7koWqWWo=;
	b=RuAAczW0O91tl7SuACwrp+DyASjIgQjG+W3YGrnhWS7kiR8p74mq4kVq3YmOQOOw2obb
	 SX7+v7bEXXamde9RZJZWAZcyRcayAyOTYlNtDg7OpAilTYPE3A/RgIYgfiHB581Dlpohy
	 msmSJL9IweYQUmy+GNtyz4azv+7eerPe8uUVk+/Vyi0zmrfE/YidbOaJNn8E72GYXQe7V
	 IEqwnCwr8JqIWMcW+J2renBQLbmwW5uKLvF7qRyHV90bj7gnr3rsPBtJL6+eAB2KqwmIV
	 x3iFo3Q3cilmvChx1O8+RHybKtu7J9oH+mtoZa0fFKbAH07vQB+v8ZjJSYCrk+rpArg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794810594;
	bh=1VSEjzja96/bwIscsBz/T8fMXaatYtAPy0l7koWqWWo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YOWsUiUtkdVue+C9gdOY3N+U/qtFIJVPsa6cLiwE/Ua/ixkZk2+GwsOiXt1FfqSUy
	 o+0CWwx/LeTsq/6RairBmEHWJTYxciq934tsmYlynoysLY4gmxfoVztHuswN1XUtIc
	 EBkCuwNIYguGzoXckgs1UvvQ/x4SsTaBhfpXtpMOFNMozjhfsiUoU6BkLbwR2oVajg
	 IlYBQeJys+VZ7TJZ6O0wYlJ2wxKkyWb5uiNRtzMadOY7FKlkkXyIaAxBpmt/Ktb4Wz
	 PuSCsDhiX87ZII+IVAJufPjXJkYPKZVW5uidM2SuyTUEmb4tH4Bc9GrWohw+BvtUEF
	 orDXckeRbIJCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FC11405BF;
	Mon, 16 Nov 2026 06:29:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3911B28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F1F680DF7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCk5KTRnwh2R for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 06:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B578380DE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HYN4AQ4V; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RF7V1ztB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B578380DE9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG5LVDF1585492
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1VSEjzja96/bwIscsBz/T8fMXaatYtAPy0l
 7koWqWWo=; b=HYN4AQ4VR5+WF8RVS+BUEkef2MXW25HExpA7RIiSnAR2kkNF3Uk
 1JFecHgp3S4yk6jUTZCoja7RNONNfapzDtLt0H6pqEaOmhFfH5lSeFdhaBdEcRlG
 ayr9n8ymMZsw1DL0WfTE7adpG/7gMyuMVvFbUFTGATnLX5BsP+22cBjQ4sFH+zL5
 segE/4bF9qa+yMEDC0W1eN8ndEtDFD1RUaDSudZ/+jUFzRobyI1bcnanvBzlrQPf
 9ny/B3FlofZF6D8MRqSsbaTBxKafqAgs8myzFjl/OnTDKMra4rIZce9UO4fSbAHF
 wkAEcxp1mfAaSRogufoI/km/zb86jpvyM2A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdw2m2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4576039eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794810590; x=1795415390;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1VSEjzja96/bwIscsBz/T8fMXaatYtAPy0l7koWqWWo=;
 b=RF7V1ztB3Q8JgJVNUKHgKGV+WmQjZo6iDjUH38fwk6gNQCIFyHWHLQL3rK33M7gAaS
 OFXNTlm8d2UZ73qskYNnmyErVPBaB0vfpxlQEglggiM9ceA2+MD+BnZZb4Ti4A9iLwJY
 CVHRVT9h720MYn7QgsGPtXban2TteX9SMqN0+bzxPFvHKuxnMni6VC1mq0AjT2pUqve1
 ZgkEx+B3VhK15JVXj4OmC8o6Ss9ReXxopUBTrMcK7s+ZZCPkU/D8DaDakLMfGwnWZrTe
 YNhvga3XBa1rd9HP261FpWjo5ps3Gdh9oYNuH/14Ny8yn5d89CEKXczV6E+F7MN8K183
 DqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794810590; x=1795415390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1VSEjzja96/bwIscsBz/T8fMXaatYtAPy0l7koWqWWo=;
 b=M1NdDq3ie5sdxfUl4EdPu3FIj3/hZ0r9sQEIswZskAEQC+Xf9fWZBQBsKIM6nhX+SU
 lmsPJfjB4GXwvLp0619PVrBfHAWi2vuhkmCZOkQuJR0+kuMtq77ne1enwyd6wcpUkJx/
 qVDxQhsvhNHKt8BTdHMhhOjORWZ/GCw5Cj/GwnqfqF/YRg+GtwvV8D7fB+FeL5vEN+g3
 sCz0IsXbKSv4BO2XKWGZ9gwj0iFeKYXQssqgNnkNYR++CMK0Lp82aKt/Cl+qGxlQzdn1
 FpoY6EQnIWBHSGFYiMxY5zzKOwZCdjqPyfXw3aMg7neTRXgsnmMABIYjL/GJ1ogLLkM5
 kUKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHQTVHf9VSJTjqDGO99GkQsQusUPieyQ5clbUt40RZXhZiWOOfHEBmaBXwPqQf+KlAWPeaT2S0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9du28AQzR1fxtFWlkHZP/sEq1+t/vsxnUGI2O1hXuLHpUkh8fe
 kexBjxzP961BVO9WsI7NfLmZPySThOnAqWT9tvA1yNyXdLJ7S9DRf1LnfJxEmLWPNUbkIn1iz2/
 i5sWlszjxO6ljAH+BG8j/ECvYTcGnIkHCGhHYDpJ+ji+MV24pIwFGkh9wYCRj2J/VKf5hvno=
X-Gm-Gg: AYBFou1FK4Qy7IUTE6LJhbjl7P9AE4tVa83mbX6cihwEjDYA6uMe9/9dr4vuOunNN3X
 i3aoVlnQ6Hvg+K40F+EiZQ3UvAeR8f+on8GewIVM9loa3LV1UZW5oQVKj64DfxwV+SOYjPSWpK8
 SURYIjBkO2845C9CSBiDWbwiOSE84KxucVQzcHp/x3Nrkgh18qg6W+Hpau8KSdYrYV9hCQ9ly0+
 +uOjQmuHE8rNbZEb09Daprh6D1HqotF/Su2njPQw1gmBzVs12mypkoqmTzR/FoWXdC+gnuTjb+X
 2GLDX7CUnmDJ05Rj2zDWsQiAwxM/41A/XAJLP8yEz9Qf5E8TXfq32HwLzEuNCcobWRU0+UU4btj
 4S1Y6LMcnzyELRU85SED4VEM2bjKEkIj67u2mb2HDYpio2Cw3573YNiCxXawk2g0qCVN9wGhNFf
 1JvCr0XiGvU6iwxy8TGxfT2pjC7RJIxgX7mSSLpb6NCWqtOCy3OtbZTOoViejbmEFEYyY=
X-Received: by 2002:a05:7300:8248:b0:36c:a084:30a4 with SMTP id
 5a478bee46e88-37966960b23mr9797670eec.21.1794810589629; 
 Sun, 15 Nov 2026 22:29:49 -0800 (PST)
X-Received: by 2002:a05:7300:8248:b0:36c:a084:30a4 with SMTP id
 5a478bee46e88-37966960b23mr9797654eec.21.1794810589066; 
 Sun, 15 Nov 2026 22:29:49 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f01d68sm30283963eec.17.2026.11.15.22.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 22:29:48 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 hongyang.zhao@thundersoft.com, sjg@chromium.org, visitorckw@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 0/2] efi: add generic Secure Boot config fragment and user
 guide
Date: Mon, 16 Nov 2026 11:59:39 +0530
Message-Id: <20261116062941.2829602-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afaa2de cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gu6fZOg2AAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=duPcS1dNSwFn_LSJ_nEA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfX/pRv8290EzmR
 s01gEJ4P8QMUQ/agtBF4p7YGOWEEBRZooVMjIUzTYaww2JlEH8AJt1bBfDVaZQzwy1PnadNbZNd
 YQmaXk2SzfqdifmcnlFWpv7cJ/9ABiE=
X-Proofpoint-ORIG-GUID: ou66wYWftO3FdwvBdzyFdPcNtmZ9qDpQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfX9TIvjqwlPGgc
 ItPSzpax4JfYSjU8yaY+sB67ZiNueHBpXyhW/2F+Py2bjCbw0f/9EVVMpU1PmmO4vcMEgsTdyKa
 2+XWSDk32oHPZcOrlUrm1mdR1fuZtdl3dPr3HLzstPYn8e97CPHOfOiRzZeFZ1q5aQg/Kge6Zdm
 4LKnb30sERZz7+khvh1lmZ7Q+UbQg4aLR+ctLz8UIt2HzyBAH2ns9dt3B1fNVroY2vBLdU4yc1d
 Xvh1CunIxhEePrM96HAzXJtjlkhsa6QDE7pC4CFzlWDIIvxwIiDCtjrPz4XVCYM+KU/u9TLpwbg
 KXI4VKe7QToDTOMEfmyea8T+Bt543lD4h5GTk6mpRjYgrS22IV/UMS6qT/+G8W44TTMWcJ27gft
 Zr6VyV2mzaZRxneGQgUFaYKAJ9zIf3CIpUeSZOfaorq6oPto2qbzWpOeB2V9pjTcsli3Sxl09VP
 gkX5S4eg4MP2VMdn9YA==
X-Proofpoint-GUID: ou66wYWftO3FdwvBdzyFdPcNtmZ9qDpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160025
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support materials for UEFI Secure Boot in U-Boot,
including a reusable configuration fragment and user documentation.

It also updates documentation indexes to make the Secure Boot guide
easier to discover.

---
Changes in v3:
1. doc: usage: efi_secureboot: simplify Secure Boot build instructions by
   passing efi_secureboot.config with the board defconfig in a single make
   invocation.

Link to v2: https://marc.info/?l=u-boot&m=178759488116579&w=2

Changes in v2:
1. The secure boot config fragment is now moved to config dir to make it
   generic for all boards.
2. Added documentation describing EFI Secure Boot enablement and usage.

Link to v1: https://lore.kernel.org/u-boot/20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (2):
  configs: add generic efi_secureboot.config fragment
  doc: usage: add EFI Secure Boot guide

 configs/efi_secureboot.config |   8 ++
 doc/board/qualcomm/index.rst  |   6 ++
 doc/usage/efi_secureboot.rst  | 174 ++++++++++++++++++++++++++++++++++
 doc/usage/index.rst           |   1 +
 4 files changed, 189 insertions(+)
 create mode 100644 configs/efi_secureboot.config
 create mode 100644 doc/usage/efi_secureboot.rst

-- 
2.34.1

