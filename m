Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF67CA9ED6
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E99916062D;
	Mon, 12 Oct 2026 05:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nerKgPCZYgNV; Mon, 12 Oct 2026 05:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 854C660626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783336;
	b=tA7IfKSm/C/uG1+f8ptGky1Mhi2PHQ1CAQjkBhrZbbaoR0kW7t6jFqgXVcLQ6A6fTY/h
	 NRvuvjO9mGwBJ8Yj4aKzce+jPlR9UXaZv0xoxUOjhGRTqFOC5wVZvqnIKyD5H+P2MQlP9
	 xF1AHKMVLi0VUpTxFH996Sy2MhbTNy8RMhRjZaUmcya5K3PvQXoBdgbpgEq0rPp9PayqS
	 pXaX//xlt1cTiPpnpkS0cg8bXoBBbmYVoXN50h9STEDDdJsGUxsZT1HA0ZPe+SRwk+6P2
	 AlTMLpBC+67z+WPtljZLhibWkVfdEHttVKmZmWN1yqW9nqADahZOPx4DxyXZgdT8uwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	b=nZGjJPuQumPIfKB7YuU7paRql7IWonkFXXfV9KS5K/g/Edyz7I30pp+8e24Z5OyNUDrW
	 kqQpjDG/lZbMyGTyWAiWK2put10WspsnsF7n8aitXLHORcntK8EADTtIXbh1HENoAi0Nw
	 537Dpr9mjpLZmujSFqcD9UP8g/6+0jFb6vDQTt/mGOcGkA7KOulnb88kzwe+wV/uU7brl
	 DbrwEGO2TlicEV0Xnc91VlnbpfJYGHvom3UOLI2fXZsPsnp9hgG8LRqCJWY26l59n4bIA
	 pIJdufEIKCxq5JIeTWl6woBzKsTzgitCCbUPbtIt2iFTAe5FOcx/r2aF9+l1YilaGNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783336;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOo59bvp5+BcX+ywH+Na9pJ+YL410kCS1sSU59DiI/ccxdGa52ZDIiKGLtd8xQgdo
	 /PMegYo1OXXlRAsuzOUBb7frldKiegjhRacw6A3ydHK/DVgsFWHMFmTG4jcGNJvJ3z
	 h0ekza9el+FOAbaVyneSBGFj/DRVTkfE+fXxLZOxl+zmtJjyWD0hk/+EPbj4EA7zAy
	 GkjmtG6dS/rheM8FP6QRJol5dhOdpLb0CgrJTuMpd7topkse2I4f3cd3vJWXGV5Ikm
	 Y6y6UyjnGrA3DTJ6tOWsI7+ZB1Q8pBcnbIwRD9A8b4ZW4nUstBOTif7BN8MSi/2MDG
	 gInLJyFczdbxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 854C660626;
	Mon, 12 Oct 2026 05:35:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED29F9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE960405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tihVi_uXiPDn for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4EAB405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783313;
 b=ca46RGfy3CXApd0L7LhsZlwTp8XMddNmNtXnVAF/MeXg1ERlI7V4nZ+3pYxo6FxqF1rD
 bBtGHf1gS7bpEPDiJwWGZARMBgQTl+943d/Kh/zSzHU7KNy4NS1yilzTvDnHK22vntF57
 zH7Dpytyr8oyAGG0h/W/73lwZYFJdctV++2AWYzcnMk6co3QyPNzI0IwsJ1Plo5vRBr/V
 Hp2uJuuxhoO2aOqmRiiB/+mX0SDxNLwuV5ODeJLaDx3d3B23GeiO0ZhqptzeRvW+Nvuc/
 2z+iXzUkdUxEhnXn60BQIW+cT5inscVIJRBuggcZfpp9QegQxMa85Iir/2ntK51ScgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783313;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=BkhuARRnX4SL7Ny8V5KyqUqzvdgOXytsHtc9miK034GGPFlKIN4z+VcWnPPhawdrOYx8
 rM+wvLBVU7xotYfde6alVEJU459bpvALFSn/+AbjjTwthf5MABue+Uvt7eXPPe9hU6wQw
 EDCrAclxxkAKZG+yI3+OT5LJebO86lk8n4Q3iL3d/OK8N4FjR0u/urq3THprKOV1sktQO
 KS62Q7dPXJbnLmoeW29BaiSUrNTf7FlE5NBtiiQGWWgl92vd42km0YVZ6LJjYY3TjEoXb
 wB5I96DN2GpriOnidPAX28eItpSnmxy8mbRsw42JFZ1YuuAkqEnHkf/mabddt98tqXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PxU+0uPa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="aCQ+X/zy"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxU+0uPa; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aCQ+X/zy
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4EAB405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C56OVL1003103
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ru8XYGxifVL
 sFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=; b=PxU+0uPaGAtKKyQEMFsVWvQ4iey
 QQ7F1the2TsvgrsjH8FNo2/C4lIsW+fICkwYpj+x52b9mkJ4WI2owBe3+27Jrdu5
 tWN3nMWI596WFN4iFGO/JgvQFydVgZjkyDDznlR450tXv++PAbYbkQ2Wlzxh2INb
 ysmxl9rmKKwiGofATqpcZI0sZC6AxAkcRI4BysAOn3s2z2uKPMVu5fkinFJrnDzU
 pYIkz1KiKC0HDANjRTdRcwE2h0VDJkXx7pR2SSV+SslA/79qh2zLts0xb5qlipYB
 EqYmDYs2tQ2bLV1EjBnDQLXuEPjThXlgmFh5+LVNu/eFTNJ4aFtvRFQ/rkg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkgamn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a0c25def6so1537751eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783310; x=1792388110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=aCQ+X/zymsKUU1Pejdsq3U8XCG0n0IBWT8CXKB9CFmZ1ZuLCWRiSPbXo6Xn9bd3F2R
 Z2P2LNidBu+zyYzo6wiIL5TMapIENRvwfCcrMnCwC+EyHjzNriclZxkcj06IehSqxl6g
 qAKGJsTMYp8O8XywLKHYd1P3v6IsCkoPWEwsJ0mVjDopVMUtefyt8ec+kcaCE2pslpaC
 JMntUZH4pMYC1Vfg5kISJlM8cctcfDVIH61nQkTALx7gbs1qoI9uwslGuTWwaOeQ7TDa
 W8TLP2Kcg8nfi5kzZz8uwmBXdbUiyWmjcgmq9/r4zCPLAOLzbODfqHhx+zInup3Z6QBY
 vsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783310; x=1792388110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=FLjsq8cHJs9cmoBhYVtEn5uPVJV2y6zsjEQJOe4bu2otK67hXA8a5OQ0W+ztbPTd69
 7njwI/Eg2LBQk2k5s/EMyt3Oh56ERG4kVfmsojSYyvbJZoemaR1Eja/YgiHkD8eQbUQ2
 UFU9VmWIvygiS/ygFs51lAbTFojaz9U8aEKIvpaF8hIyP6PWOUonzPJTY2QnHFOGCq9V
 FMa2vHoVTX1hwsivyHGqe+vADZOzzlzY9DOqAAnMosaRezjGjmd3ujTZtJZFmX7VLqK/
 4UQY19D6FUQX6QkXw9cD4TdU2PvxeQe0YdJX3bLEkfXEwOSnYPvvtO1NeGmUaYNUwcLY
 D6bA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7W9OLOAnSnvQ6fM8Pjb5/R3K/+qykyOHxmS3VMdeQ47u8RDU8xpu5NBl1HGX61aaHnG9813E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCujQLzpTYPEXu33wC6tqf34UBDuw52vwgpPVQf30u6K5iBF8i
 Hqg+XS5cNohiy0ShgkSwJ8VzJ2Iaw6hcHEVz2FGkev+lSmHM1UNeRnFt2QlYe1Vhj5BOihlmbtS
 6ivLvfGhDraQbh1nFQ8AVP0xYhzFTqmun4U3QDMbpPq2xRg+DFCZzDaVAxcdmEEoh3akegjs=
X-Gm-Gg: AYBFou1VDeHyz8qL9ixsuvYdnFPIBiGjxaOBHbGLl0Oco80HQXkjCMSdUYj6chKaJjG
 V8Co+bUI/+u6yBi0bhlvvA9QysR5+lsifBTZPnyqr6QquchEhC2nRz7DmfueKC9LRjuwKD65EvC
 w6nVlS7BsDNhlCwsUuelY6Mv6cj2NPw6U2Y7WAMTvP6rRG6SOzLPtai9C/jtqo1+kb12bbsNaew
 dZw/4W6USpAf+bTweAwp6xteNwH4sb25QWnjjEZuGdR1UH19E5vrOC4E8HElMxPTWBL9WaYD5cE
 t4cUiWFhMXgt8Goabo0BlPksZusVpDWxuSbSWgx2zLVCspIBbALNZ23wc/VfrfBoSBrT980mbxl
 BRxlW7UbVm0NqYGWRwhqda2KyklFwYn+B9PT4FvTVwiMGcyTW
X-Received: by 2002:a05:693c:69cc:b0:34c:1bc7:bcb with SMTP id
 5a478bee46e88-3537e0369afmr12189753eec.22.1791783310252; 
 Sun, 11 Oct 2026 22:35:10 -0700 (PDT)
X-Received: by 2002:a05:693c:69cc:b0:34c:1bc7:bcb with SMTP id
 5a478bee46e88-3537e0369afmr12189712eec.22.1791783309637; 
 Sun, 11 Oct 2026 22:35:09 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:09 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 13/13] clk: qcom: build only selected clock drivers in SPL
Date: Sun, 11 Oct 2026 22:34:52 -0700
Message-Id: <20261012053452.1567885-14-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX1CESlp2UrNLg
 xXU+51zGf0tocpx5gVta71GaWa7VcD+8AlWjKXT5iJ7759IOaxTBoxBdM97Dj9Mzw6+ngzAJoUy
 pJFuC03oDkSSOAkJ7DG2aYcTW9VuOgMYZ3DR1mBeH68i50ibY/APvKz1vRg9IoluWrWV4gwVez4
 0Xq06wAMjcQVevS1IalWwBq+xcLKvfOqSbXTZYHYJDBs9g63A4OlnZQJTmAVpf58U5EfzbHIkCe
 aRiE4agdM7uB8SZ3/HYeDruMvo/9qZphVu+uUU3iZgh9AIhRcT6WFTPd5cxxNVuvlwJwSXiZhTN
 FOFXfc7QUjFYtqIJUTeHFOA77JEPJd6swM+1exvdAb1CsFXE3fnr71LI7/KEYTPJGaTdgFM3AiX
 ExIdYfah1CJhUK3ECRTPwlH850eMRhY8qNAiOJIXRTS2+VY4aCgUPruRPqJbRqt0TjiWDI/WYbA
 63PsFqztPCQjx68O4Sw==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acc718f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1OAO5j4Zegv94xHJGxAA:9 a=yafjnGloKYvRJXMp:21 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX/HCYNtDYzYFY
 87gs4425O2RlrHGd71x9swXANTj0nxeQVmPzQQ+v8PrypSmXgOhmpGtJfrJ1kqXGcSHj8PkhcpM
 u6vkSoGsFKBMTjn8VxkATC+S60LYph8=
X-Proofpoint-ORIG-GUID: zVc2FPsEP4rNYSGQr-CC1l9zoui3t-bB
X-Proofpoint-GUID: zVc2FPsEP4rNYSGQr-CC1l9zoui3t-bB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Make Qualcomm clock-driver selection phase-aware so SPL builds only the
drivers it needs, reducing the SPL image size.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig  | 208 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/Makefile |  48 ++++-----
 2 files changed, 232 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aff3f5418a0..899f44cb8dc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -5,6 +5,11 @@ config CLK_QCOM
 	depends on CLK && DM_RESET && POWER_DOMAIN
 	def_bool n
 
+config SPL_CLK_QCOM
+	bool
+	depends on SPL_CLK && SPL_DM_RESET && SPL_POWER_DOMAIN
+	def_bool n
+
 menu "Qualcomm clock drivers"
 
 config CLK_QCOM_APQ8016
@@ -15,6 +20,14 @@ config CLK_QCOM_APQ8016
 	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8016.
+	  See the help of CLK_QCOM_APQ8016 for details.
+
 config CLK_QCOM_APQ8096
 	bool "Qualcomm APQ8096 GCC"
 	select CLK_QCOM
@@ -23,6 +36,14 @@ config CLK_QCOM_APQ8096
 	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8096.
+	  See the help of CLK_QCOM_APQ8096 for details.
+
 config CLK_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 GCC"
 	select CLK_QCOM
@@ -206,6 +227,193 @@ config CLK_QCOM_X1E80100
 	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ4019 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5210 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5424 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ9574 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_MILOS
+	bool "Qualcomm Milos GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Milos Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCM2290 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS404 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS615
+	bool "Qualcomm QCS615 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS615 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS8300 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable the Qualcomm RPMh clock driver in SPL.
+	  This provides RPMh-managed clocks needed during early boot.
+
+config SPL_CLK_QCOM_SA8775P
+	bool "Qualcomm SA8775 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SA8775P Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SDM845 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Shikra Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6115 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6125
+	bool "Qualcomm SM6125 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6125 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6350
+	bool "Qualcomm SM6350 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6350 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM7150
+	bool "Qualcomm SM7150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM7150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8250 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8550 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8650 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SC7280
+	bool "Qualcomm SC7280 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SC7280 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm X1E80100 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 8da2ff7e73e..7c4db9986d1 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,28 +3,28 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5210) += clock-ipq5210.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SHIKRA) += clock-shikra.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6125) += clock-sm6125.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_X1E80100) += clock-x1e80100.o
-- 
2.34.1

