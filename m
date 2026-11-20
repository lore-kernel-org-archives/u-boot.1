Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50F606A33D
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jGNvdxmm;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gNwRYwHL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gkaldb42
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 465F4607BE;
	Fri, 20 Nov 2026 13:21:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ykOysfbSOgf; Fri, 20 Nov 2026 13:21:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 595AA60767
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180888;
	b=SbycEkY4l10GoNg9MbB7/QvtM2MTLQnqHPUa/mhPQXSCDoVrWvCCjGuURBV3dfCgizoK
	 9a4AY1IE5nscxtCkc0awx0kXmCDxbbWq0hPsdSR31lZsL/zwJ6wF5SAoJ3akb+f/KS6Z0
	 6Il/VSmM5ASTf3xf69g+7R7LzhSwL2fzsrdub1veOoG6P3o4/sZmX4NMccgCZGxhuJixb
	 TmB/P0PvptbXs/lZ24A1706O+EgyDkYh5JeWxkpPNqVG+0I6+mhB9TbMNzvEzyRNEBDrT
	 lGgc/BpivpatSIk4dH7VCCgG1GSpsVI7B7u0iy8W2Wrwpr6xlDZxxK8WHJLcRlSmuQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lZdp3NX1+CXF3WMqnC490qk/q/scnQvACMjlK1hhA3c=;
	b=QS+n5KIU1b2ZUxVI4MM2C/HRwuahTqbFGcpo63sKQPpILvzCJh3WWYXr7foHATtzFqQC
	 jIM+BqWCPP5EimfQJYwHg14oezPSXCoG9PMR4FbN/Jdg9SjpV5qf+hrFhdlM2SgtppKxq
	 r8qoLsrs+tYiTUBs2CKHfPztVw0DOtKdl6gHWlzUmvOkP26Q1gg8h5nnAgavVA7S3qvs7
	 ajQPRAlAslBNAmeg8lulazPBg7NT9wPYX5BvT7nf2QqbreMRSO8Gx8OHbbOKBR6+WVbxL
	 3i4EYrsCKIgSApteHMOGNHaHXscSmJl6Vwk/1h30ZGuzNQ8eaL9N+AoCBjUnlUovpJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180888;
	bh=lZdp3NX1+CXF3WMqnC490qk/q/scnQvACMjlK1hhA3c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGNvdxmmPUTboW5JpApc9H1Q5LixJauBhE9GU+1WqM1hlsIMlB9397fYngtrTlfVn
	 PxH2G3Ell8yz3Wt2WJU8WI0yuXvv/7b0EWUelp7ucInxgi7t17+zHSL6RCtm3xXT3H
	 mqtFF8/hVJBWLLom1UUDHcn5wYrEVM2Q/SnSKX+awRMSFvRbDPRDZVQbaUn9TREaIs
	 fN+kteYsp3Ja8Ndjwj9P7TCMBYOGEpRzHi0FfTFx1/uCVQtEHod/HrEqUqmbgINOES
	 gK6MHcs6+9OMLVGNRo+4LllrFLPUe35wh5jE5koPDQNIV3VsckYUSyjvz9jAiFDJVA
	 Ut1YWXPkBk5bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595AA60767;
	Fri, 20 Nov 2026 13:21:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 61A73E52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53C0440A28
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brCGMXiifN6O for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 10:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C05FD40A25
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gNwRYwHL; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gkaldb42
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C05FD40A25
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7eq3P144444
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lZdp3NX1+CX
 F3WMqnC490qk/q/scnQvACMjlK1hhA3c=; b=gNwRYwHLpdG3DuetsbnCFmnELtQ
 subunj5h8NQICa64ospTPGBLQ4dXMKVFwgO66DUO9kBx7ul6YLRRr4ZUUdSjoc+4
 y2pBChLlokOL3lvOhJnIToVbsnfOBFuZt23658xQPBRXtC8HChtUpfXrr+qZthUX
 f3TFCKkjbtGnhCPY1bU91L6UwUzpjoyfi4KV1aP04Jbp21MpexNvf2bJm3ZGTEL4
 axo35KsZcsn9lHqddMWSeHpr+JuHXPb9o798tQSZ33fwkzn/pWPG7BGfPP/gxH8q
 EpZ6r8802R1DX23JsX3ffYeAfNjw2UGWuq101ReOWvae3Hozp6w7xOi3Idg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbh94y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1724297c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 02:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795170291; x=1795775091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lZdp3NX1+CXF3WMqnC490qk/q/scnQvACMjlK1hhA3c=;
 b=Gkaldb42uA3Oj3REC1P0FPHR3iWnc8J1YtmA7zEX6DuJ2WHJKmVnlEU9YTp36k1Fd8
 aq7plsZvQBORY8VwMTkZt5MkL1ZkrNSTrsHcyKvX6N2poJh7tBVNuB3TeUZHVYcpdHrX
 1tN/93LkH+EupxC+x2kQv//QbqcvLSVmXM2QeuGt7hcp+enuQ6u2fE74TvRNwXb26EvU
 R0hG91K8aRXdQ6rexl2OCO4IYsuKgbl9s3zl0vQvdvGTlp2wx1iV+GPCHWpbPlaqlRWw
 KMzMIbIRtsGPhNy88mucHH03aO2yTrp5xLpFocGVaiHfFfy6dHtGe1RyHs5Mrrz7fPg9
 7gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795170291; x=1795775091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lZdp3NX1+CXF3WMqnC490qk/q/scnQvACMjlK1hhA3c=;
 b=2HEHEmO7JJJFJGelrT97LzzYpemb2z+K/74IoFFttNMuFD9WEaHsqDh4Ic3mVloWAu
 K2AAH9kcf/YuuefgHq506F8GfVHkDs2eEdVOTLb42bE7KN+bY36Y//eeH6kydhl/5/P0
 VKH2xkmK+Hb9HAmiAt0lTuhQVwR11MxkrDKszrUfINNhXhkNZ8bNRE7nWNAM0smJFVZh
 TM4DttDgsBomeIgDe028mm+RdSN0nLnn9SRT2672t+7PT/bKYCWkc0z41eDvHfP4T+0N
 SXSVk2rGfiqynKwcfs5sGra/1eHg22biYPfSdxUWZn9OrZTB2LU8MUolzwgJbZ8zcMDN
 nPMg==
X-Forwarded-Encrypted: i=1;
 AL+hErFwY/HAyyWxMCwU06e3DU5Swg/wVBolCXWiXoT2/wpwwJOgzXusOxOAwyOma/sOffDpsi12qaY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lE2s4phJ6WSxIiu+JSdhIlIRb2lWh9S7VuSBbIGqBZgokvQ6w
 DCI8qKg01Ik3EA/95Fn0+S0Q/1LEsfI74wEfL6V/ojc+lzcqwtQKrVHLmhnA4qbUXh3ZSuRbtRm
 3xdyEePKC6zfErkuOHoXWqDAaBQlPj5ilyFqBF6iTXopCAYI/Ja/3vXMNIG1KnywfDx75Vc4=
X-Gm-Gg: AYBFou3/7km8f017uggWmI6iQNAvgje5OMGdKAW0F0MNj5Dbp+qzZ/FmDVe10bMu04f
 rzErUVYxd6RcxkdvfV6TwsMFgwGAbHUtzbnTXRoWJZFC9RiuXK29+QaSLBC6rihEr/mZeH2VDXK
 Csu1C0ECIHYL/3tDScAK6OuGAOpH8GG/hBSKLPhNYjlraVUQs1D2FRooPpja3MFFw2NgCH2lp+X
 chgvKqRhi4ZhWT3F/5JUWrpHxOz0GQPqLX+AWV+zQxBv5UGih/wbbUuYGkpCCTDSjIFeaxjALe6
 CLFTCBAXFo4m9rHwZt5ZS+jbzzagIzj0tDi2AaomfFCJiCQ2HkvULkl/rF/wRxw8MB0Hxlhh5RX
 USUcSINfdaPb1e/6WHKV5z6TzCoUX3irdcbli5XnHBAXYeZaoKcSBFmoJl1N2YFWdxDDk2ouTx9
 HEF2ahusrTeCDNOgeZwU9taAEKTnvFC9eYTzXXrQqHnu3JrAjb0vWyqLbn+nnoUqgKYhA=
X-Received: by 2002:a05:7023:a8b:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-1b5567ab595mr2536548c88.1.1795170291392; 
 Fri, 20 Nov 2026 02:24:51 -0800 (PST)
X-Received: by 2002:a05:7023:a8b:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-1b5567ab595mr2536528c88.1.1795170290948; 
 Fri, 20 Nov 2026 02:24:50 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm10618487c88.9.2026.11.20.02.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:24:50 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 abhilash.v@oss.qualcomm.com, kr.sowmiya@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 1/1] board: qualcomm: shikra: pass TOC FDT to BL32
Date: Fri, 20 Nov 2026 15:54:38 +0530
Message-ID: <20261120102438.1382555-2-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120102438.1382555-1-kr.sowmiya@oss.qualcomm.com>
References: <20261120102438.1382555-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX3SdrHrkjYWHM
 bL6Goc9YCRLQ55xsR74+tYI2VxNrt4eCNkInuEkUfiPdkJmUoSh13Kkpd1qffW/QT5EVfZKVo88
 HsIbOfE4mxMwFg8WAFSFW3FXNKmg9Hs/iTd+9+wCRN0Ogo3OdouB2MhhGKd9vBlEJ7Fj6VTenzP
 we35JgohdFW3nAhxQ1eMz+PL5q9fhwquWQ78UNaRS1nVMmwB+6CdBkRyjSHFpA2DxU9A9XaLOd+
 w5j4QSBs4xZHKKB9ADHTV1zxtHC0OUS8OCgUMB+H0s6UXUm0vbEThNzXsrwY1++2an1hIlR1VHs
 R1eE8PfFQWaJnvwfXkSjBA+tjsyJXNikiEhe5M5UiNmb+5evEYdvvxnh4okkj6RwgDwq7e6mNCP
 MtZ1Mr0XCTu3URdj9yadZNnEvAjVrNWm72SVwKP9fjoarIcVZOqMj6K7luzVJfrYpzCFlpy+xdm
 xki7EcL8HzDJEk/MtgA==
X-Proofpoint-GUID: EfavIBDDsTUPuaXOkfzHsZjjjffUzzPU
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b001ff4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-Ppm-3yYlK9u17jfYYIA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: EfavIBDDsTUPuaXOkfzHsZjjjffUzzPU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX4L9XyWOtXCpE
 bO1koCJr2Y59qN6bBWzvd+2RY3PMbkFxncszjwOmuIZFWYa4G1PiUz0zcpuVNtvhAin/ihZzDxW
 OPBMNI8nRTJh28BITwgYVr1R+vDA6aM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200041
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass the optional toc_fdt image address to BL32 through
arg0 when preparing the TF-A parameter list for Shikra.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..4367a5e7264 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -20,6 +20,7 @@
 #include <mmc.h>
 #include <part.h>
 #include <spl.h>
+#include <atf_common.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -477,3 +478,29 @@ u32 spl_boot_device(void)
 
 	return boot_device;
 }
+
+/**
+ * qcom_spl_board_fixup_bl31_params_v2() - Apply Shikra's BL31 parameter fixups.
+ * @bl_params: BL31 parameters populated by the Snapdragon implementation.
+ *
+ * The Snapdragon implementation handles the QCSDI-to-BL31 handoff. Shikra
+ * additionally passes the optional TOC FDT address to BL32.
+ */
+void qcom_spl_board_fixup_bl31_params_v2(struct bl_params *bl_params)
+{
+	struct bl_params_node *node;
+	u64 toc_fdt_address;
+
+	toc_fdt_address = qcom_spl_get_toc_fdt_address();
+
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL32_IMAGE_ID) {
+			if (toc_fdt_address == 0)
+				pr_debug("TOC FDT address not set, BL32 will get arg0=0\n");
+
+			node->ep_info->args.arg0 = toc_fdt_address;
+			printf("TOC FDT address passed to BL32 (arg0): 0x%lx\n",
+			       (unsigned long)node->ep_info->args.arg0);
+		}
+	}
+}
\ No newline at end of file
-- 
2.43.0

