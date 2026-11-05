Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3577606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jjTkehYA;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJhrxSWp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RFengZd7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908BA60859;
	Thu,  5 Nov 2026 18:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOdF8AQF-UP6; Thu,  5 Nov 2026 18:27:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E613C60865
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903260;
	b=GdLSq8IylLZzbUYWMQ5R8ghOYiXTCfcQAT3Ri0RoBn9qvkpWFJ2s7AnWR0HsUYq5NxtR
	 EB9VuVEiks7DOuDmIQ+wCEoHndsLkna/7G14RDJWNTK1dQD/qnRSOjxpuq48aVS9bPZor
	 E5w7SrmcQcygeBGaQQa26b6QZTX8QuaW/Dk8RjFC1PNzBTY9qOtUX6bPXyVyqrmoJzGn3
	 q5O3p9CBmCfFOObFotKaZARkrExqQp3/OxUKKWcQJ6jGRxFCtrtONO+YuCYByYrnkJ7KM
	 v06PHaADGnqgMjCoChzWIgSaF6yK2AJUR6PNWpJCGzdVIOYXf7qUm/3O/Y6K1zVXOyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1gS72jEu64cxe6v9dm+sQRu+Mdf4pnFibIKCZJwZ4QA=;
	b=oT4xoXI4FGn4h1aglPwzlnU9njaPgQpOnN1O08UIhUHPYH3+Jefs6fLhqSRJGRSRBtMn
	 Sx5Dp79kWxzRROGeNjtRztmwJr5KuIPjsZ/y7Z+2HH2TTjUPdzNj8BjekzbpmR0wsIhcE
	 puZLAF8LUDv7R7aXCGqK5hUdmu08yrrDMrOTNmb5UGmFW0/hET428L6pv5ePsAX5MQWoE
	 P2jXRTo6wkHU/Sepg6SpcEybkQDAa2GiSdV5MAzeCvyuvJZrf0ldGTuPQvuSIbXZk9/AD
	 dDI5+8pej2MB/Yn6rzQhXiaN469MVYwQ2ZYBgMF/UxK3G6RhUp5vhrdEf6kPlmsa5xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJhrxSWp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RFengZd7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903260;
	bh=1gS72jEu64cxe6v9dm+sQRu+Mdf4pnFibIKCZJwZ4QA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjTkehYAEqkUa4BF3o1pPBvdZ3CGrVf2OQA78YcnAOgawQA/ttdQQXQzLGUqi2Uw6
	 kDUu3h0V7FFrLeZbrT3BdUvFN3WJgdOzJDsN55iCaQbcpNK2ycAKEpYCNf1cxa17Md
	 SRaVysRBh7SM1r0dJ6cD8WTCRe4JeXdhLCl/S0flS1LVpZPme7AGk2C/Zn2VUR5j4i
	 SlG2o/3r0R4CN2AhGZ1tFpLOkO9MUMWOQ1BMqCxmGmnftvrLy6bTutCCqAYRwyutCA
	 C7FrDHKloVKazhEuDA0zla/3GlEIZdN6OdPzRFrazJ8ScsGx62xGlNg2T/xctBiRHQ
	 3zBje8yS1xKug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E613C60865;
	Thu,  5 Nov 2026 18:27:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B08FE52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9659B60859
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQEHorjKZb2D for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F28D6085B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJhrxSWp; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RFengZd7
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F28D6085B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQq64075330
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1gS72jEu64c
 xe6v9dm+sQRu+Mdf4pnFibIKCZJwZ4QA=; b=iJhrxSWpeoR9ukspuKUf2K6ycYN
 nIyKPC0LHNfzIRzxImKrk5QyNkwM8czcYNNCc5CRjR3Om4R7Tjipp/YuV5CijuMY
 eFCpakkIcJBVREWklDxohgCIVPJbU1Z1OoHigMStLJDW812DLFAw1KI80PIsN2AB
 JLU90HnR2bNHVawKahScP9xwfmLYVNja4T/W/NOajtq6L3cDWhiPkYGWldV99efw
 nu29sRp3LjlCRP4XKUWLhU5VjlYIZa89KLlIN/W6JwZWQWV3lUmQpece60QtQaBG
 FsUIGtmy49VKXrpuUIzHSDb64m1xvLVaLlWcuaN1vKDRzUWG3xQdqIPBnDA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdsyys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:27:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36d2a94abf7so514293eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903256; x=1794508056;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1gS72jEu64cxe6v9dm+sQRu+Mdf4pnFibIKCZJwZ4QA=;
 b=RFengZd7wZsqzzYvRhm3gGAC8waD+0SQdWz5m/xdPG89tj2e6Isgrcgvo3ESalNuPm
 qnA0njgAUhqdVl2GPOBVRx2qTnInvG+dybsFBCFQLl2SAc9DLfPyEmU+ll2xgJJTbUes
 wxQaQtIRO214hyUny5gvboh5p0ZNmC1fvrDXQs2hAAIgZ5YKczZVhpW9vbiuPT1dTaJk
 jXj/UnsJ7x/+hpk0aUD/IsTLHmque0v6Oq1cUtyf6Afq2BAQ43fF8T9LMFnqTNZ9GTZS
 cpCJZ+mIIiVsaydz6wjZ3rG+W638apWYPQZJ4RO8WXA6qrg4hfbZ+3NgT0aG/VdiQi+j
 irHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903256; x=1794508056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1gS72jEu64cxe6v9dm+sQRu+Mdf4pnFibIKCZJwZ4QA=;
 b=donRMW2Csip0p6KZGnA/TCxMtibFAhfx1LX1DggMdGamMiQaxBs/B11bd4Ll59TWzo
 A+HKPy/CLoR8cQHTYuCnuet6c6vVvg2q0I3fKDJLvKgc7Nsw3sL4lFhOeJrWi+zjkfq9
 oW8rU7T2cDXRo0BkNvgKT4T6LmnBcNQwdsAshLtXNXR+fjGsPGQEjLpwYT4Fx8oaHwto
 YomC51gUtXslpygbfrNMK6duW8ZYBUJ4AI8mfIQHRaTT6s9O8jJWo4yq7KhPhW935M+q
 +zznYDfYmUy5jha1LEE1pRrbfWNGrieoKdX/FROpGFJo3tj5wcYOO1VrZHOIT1QrfCSc
 eWJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfr76/YZ0P/DRneiYCGLVNxKWMkST+9FhM49yuhvrOUj4EhuCD+XVLi5tPgfWmIcVRZSY+sLA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8v5OpQwLlmZnuv6fHWxrjyQF/4Rn62inU8YzGes9PIyIvlTla4
 qIkEeey1ol4ZKsFxu92iypdWFtkzWgn3GtiwZPhYfslomprYL91fSxP5nJ44z7BWYQRj6N/77UD
 EeeCUjEpRnkXvO3/eWXlNq040Oom84HVBg3SuMqBVmbZD2P5+GLQWWbFdM0l9KV0pB67giI8=
X-Gm-Gg: AYBFou1GG8O9WSuAwYdwoAPkLBXcnvHfP/eX/+6EHkUymx2amEKLpl7K26TYr7abmvd
 eKYBy6rYsyzMBHakd1cODExh9r0F5SYrRaBXxZTJ39AcF/XpB6EGMMkjLndvX1tiRjRu+Gcx8cy
 Iu0SoB4XM250RckJAnXw3CLIl97y8nJoi5TANbQMfe2MnG1SEVVyVSy0D+4V5hzseb0FhW9Y0vz
 F4jPDwxxcQ+5QEnHVh66NcXTziZ+1BCfOf6RKSARw5a31IjmQ/RINJ0AYtOLMZLwCaxu7I6MtO6
 CkK26LAgLDHqQ+4lQ5LVG7uwLAihw1notlWpLy2u4F51jEA1QyIGzMyfzokwWxDJqs6NiEcjLrv
 AsTN4JExeQON/F5Xt2BKyQAVCMa2B/BmXXt66VaHVEfiW/dJYIjsC8jMojOyMlk9hCYu+mktlBo
 0HIGRkR0BI8anje+kwSQkOK8Sf0ss2mGRMdopPyheC+R4tZtCPdqRTVmKMHxLj5fUMtYjq
X-Received: by 2002:a05:7022:7f19:b0:195:8fa1:b447 with SMTP id
 a92af1059eb24-1b24f4bb728mr4504604c88.12.1793903256412; 
 Thu, 05 Nov 2026 10:27:36 -0800 (PST)
X-Received: by 2002:a05:7022:7f19:b0:195:8fa1:b447 with SMTP id
 a92af1059eb24-1b24f4bb728mr4504560c88.12.1793903255655; 
 Thu, 05 Nov 2026 10:27:35 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:27:35 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 12/13] configs: qcom: add debug UART config fragment for
 nord
Date: Thu,  5 Nov 2026 23:56:13 +0530
Message-Id: <20261105182614.2405482-13-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aecca99 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=4AHoDOw_PNBSLbfWOjoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: YEbgSre8S7fgknqSottLjsmS3yykR62r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXweBKcfz6XPrS
 KIgXmRveQdbJe8hv2RqCJk6Z4Vlrzmh5gkJgawODAhDgQdQIxgOonzRhPvxhI6FjiGS1Cob/Wui
 sIQfA0+VzHvOvf0z//11jA50V4o2178=
X-Proofpoint-GUID: YEbgSre8S7fgknqSottLjsmS3yykR62r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX9G9ntIn8q/kv
 Spl7RehbqOJ67iCoSpgrwMWn6UqqvHl3Rk0aYRDzd8ddbmoIg6RO6JqQ+oeXUerb+VtNKQKY+Wf
 KE7ifGVooc+iYeCt1CHh6tAFZ2XGsEtGn5FCxznKRF53tNIu0pG9xEvMskrwv/4cLd7SWEJHHru
 V05CYTR8KfXZk6etPFJBLYy5TT++/vR12F1AWE/MX2PBQunyQg98ff91SS+B+m7UYpkYxnIbw0w
 HfMyzKR3VEdeFngnbgK89D2nfDK8wXZaDGdWpzMJKx5fYgtk2OGU/QD4QGsE9mRBWqOXqgLLIfb
 SDKsg+bNgV7+rsoRjf+1WPzt04mIcRAL5GpaCweXz9JfqCpx3+h2dFTsjVHgkuq15pKObUZ9Xm1
 8snFxd7xU8knCnUo2W3E5oWvOxS4EKgsSVM/l7TbsXqRrHKipBTmpXW92BxtzDmssQzG+OYsdPB
 ++4ZyfSbE1rZFdsBUag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050073
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

Enable early debug UART support for Nord

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/debug-nord.config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/qualcomm/debug-nord.config

diff --git a/board/qualcomm/debug-nord.config b/board/qualcomm/debug-nord.config
new file mode 100644
index 00000000000..10011e338d8
--- /dev/null
+++ b/board/qualcomm/debug-nord.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x884000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
-- 
2.34.1

