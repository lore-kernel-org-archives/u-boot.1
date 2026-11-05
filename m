Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9D606A332
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s9Qccisl;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TPK8OrJD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IP0ebSP3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDF42406FC;
	Thu,  5 Nov 2026 18:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lq6OVi0CKY1o; Thu,  5 Nov 2026 18:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7C41406DD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903202;
	b=OtYBd4h4N8r5jigfyYCT+rFWt9UpKGzLz8DwsW/2m+W3kcUNiMM/y8z44cjiaMVevH6k
	 t8gllfYgEm6GtIKOfJGUMmXU95wXg44oTbgan0lPVQF1tgWyFDsO/7f2eOo4RoAj3kRvp
	 wtK1ftv7z+VNSv/hOKgkv23OUrU/wxePorZmCCxx3ChnuyUwm97XUsj69OZrfsac+vHiu
	 wCeWV60m1nHK0ozjHOlGwUBh5du7FfeGcQz4C+/0dsb51aramvwXKhQrvE/0vgpX2sv3Y
	 swDcwpOqpKN68kMkqsXoho2LMF6RfWkjYOZDl2XPFjyJTEr5PwQGRuXtNyq9RpLmerw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903202;
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
	bh=UNCiF+6h6QRlWt2j6i3/m2Wwh33WwpkFsDGfvbpSGN4=;
	b=kH9daatCpfGBlEUJ+0nC92tEQsPGGFBRSZE8EMLCcJ9MI9PkZFtrhA3sWvlWev/ebuu3
	 g+FqnfXPI+nHskRC5PlqHNvfVGvEd0l82JC40RHBwXbCGVQ6ZVGju5BkJFCv2WSMf5N2n
	 hVE7f/Fw5Q77bDLWLQYPAh9Qav8lITJcYhnsjrA/bhqHioXV+mFRWIRcDj1oLNpqpCOxg
	 UpXx1glM9+Axm7xKqlCR7kp+Io2dL+y1+rOgf+cFMaoM54k4yJax+4C9NigThS9LOYlXh
	 kYCUcXik/WACemZtAKaWKeyLrrYDRF6EbKcvk1Daz7nuDbiIUkA8Pm4M7MaPibtbjqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903201;
	bh=UNCiF+6h6QRlWt2j6i3/m2Wwh33WwpkFsDGfvbpSGN4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9Qccisl6WTQSpICy9TFVUrQg2H6WNJVpLtQeevBWmRgoAkolN56XmJixIbbN4E2x
	 bQjIo7Ex0Stjk2963CqTKbdOGFJxrE7/V5GZok/N2ArOeHKT+8AfN0bE+YGm1YzmkI
	 /8XA6cHfTp9FZi1HiW2uDmrnR8Z9gw619oYjIdbOKgXgFelrhUALbpY5KhIcvgsoTq
	 EvTzpFOjUdP+5aMlmjGUcTJU724eGQQcPES8oTtfyKlPhyeweyBptef4wS5uTvdfdL
	 gEW749NPvGZaklAKKRpXTEU5jpJxOh+M8z/FbrVaPkR3Hy2cRjz5oMMDAVm4E7XSvq
	 PORMKYoctRNtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7C41406DD;
	Thu,  5 Nov 2026 18:26:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED5DC31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF2CB400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puWZGnz0jylq for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE23340012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TPK8OrJD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IP0ebSP3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE23340012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQUI4075337
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UNCiF+6h6QR
 lWt2j6i3/m2Wwh33WwpkFsDGfvbpSGN4=; b=TPK8OrJDQW2mzJXqKcoOrVp2Xhu
 OCaMKQ7HYlJcX7kwj7e0ro3M0NGR8czPFt/bCNqoF4Q7MrrcFL8LW2SeBHOs5mac
 p+oYGg+IcJAfEAvJcp8OB7UM7h/bCIUiNQ3ChQHJsVD4FNoghojM09R5mWX3dLbL
 MfvthqX8kzQvXDJaxMQaBT3pZS+cWA83sJFcba1muOkQObe9+gcwVIdx+HzHA3ox
 iYbTAPkSb6DxIgimOKTqWObfcaB4mRjIj0jbNf36dqhNkxxqBnMBjywLJuvyE8WR
 Q0aEmcWECNVOAXfxKwQ9bwx8FP1ybsVKh1ym54ntlwdeUSuw/POdZy39oEQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdsyu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so4124396eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903197; x=1794507997;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UNCiF+6h6QRlWt2j6i3/m2Wwh33WwpkFsDGfvbpSGN4=;
 b=IP0ebSP3BZ5nJijnf2JB+7Cc8BhdmmOVDzc56R9gRtlaG2W0tctLNaJ+dxsaPKZ7Vz
 kubl5tj/3RYn3KMT2O2IrX5vxzHiOQ2vWK7NlNodBEXYNNNIFW9fJs6vUQ9VEIDO/kVe
 yjpNT+O060v7lvWoEVsMRKSxXOuMx6C73SSNeKQGLoyoMuVMNfk1oID8XuG4ePNbVM5s
 zsv+5VH3DKu7F3bjolazswftzYy680fuOKgdBlZ3XAWDm6h+wa7Bmy1jGAyyRHfwOo2J
 hUcrsJTPi7wdGCkCbaQxCWb9dvrHUC+OD8qEzadCz+oICTEzYhgUfK22KIgFeN6Lp6Xu
 +2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903197; x=1794507997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UNCiF+6h6QRlWt2j6i3/m2Wwh33WwpkFsDGfvbpSGN4=;
 b=z1uQe8g3WKzAp0xgmKsi0198AoH3JDegjs7W5to1P6jzbPcV9r6S+5RaP8vTD/QxGf
 wqLuXUQ3GQkHm0D7W4/fUJ/iLex8gIUKNe2TBYB5m0fN5dujDmJtzWWC/GavWBdKcE0w
 CztH23O2KcxU1XVJZFsmWyVNSE264LWbCyI7vaImJHHqGVrKmCWQG3d7ysm0yDHmTgkK
 N2hEMjnZ+vJ0AutljOVhCWymSeBX3ajoKpw05NFCev6Gxfw7vhudWbQYuRpNAmZv0iXg
 jvJqPeiajw4cEw74DQcFh0yKWGIVXj1a8G4iIipvt3wIP5upWs8L/FTAhzMJQcv7olNj
 ZF3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3rigmxnfnnCzjXUuyJ3gZwtieXCtvU2iLyoBpfRq1sMRGOxE8GTxaB2MHTeYZURxUadUhmBU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+QZJ/Vr8FQPR/v3/ZBMHyZTFuKII0DW7AIqLqIVg/jtZfYnyKi
 8yetzHo9gI7D/b34CSASDBuUL1P7KNw+0m9ZkqaVykA2ND7hV01c4871KjpAc/4w0Xgy8FWfnmm
 WBD6LIfjy5Q+ixuPTAI2RjGLHhx3bF9vBA2lq852DyeGmMOiO+STqBvE5kEC4CtE8bvrU9uyJXo
 rUqKA=
X-Gm-Gg: AYBFou1CwKtznVoEG24ijn+kYJzuUfyLWPtM5wQamuNi33ID3E5YtXcgLkuzvAWQtqr
 YfKevqtOEuqJXj835q5KhhAMO+HhRrP4wmzeTyZVBaqsjnU8Lq/dx3sRbX0uzVFH7/Mm1rbfcSv
 ehAFNXlqaku4wSFxNsQfJON/4lUvLfFQxckqY7MKkA6QKTgKtXww61ypsYHe5bNSPRaqrvJdUrR
 DzwLY9ZluYSwPBf1AoTbSgNJszCdX//p3hJSa5A7rs3L6cPMuDESJB3+40Zb3qsHmCNN452PEX7
 HSQ51AgunUGY1DE5Sv+wacgh554wqgdK1ZMMNFYNI1qsRSCw4rRZPoQuF15zJ9/QEoniteaZlA3
 zjK5dD5ofHhhtw5/RlfUI2LK0KwWlHwXHozLxdPhFuxBXCcw4AJJP8XBNiXGHFk11z15YFl0dUF
 Icv360Kdf9K5QWeDTvYAjqvEWhZn4hPWlpRGSqHmF+DxC9HtZ4vDJo/kA0qL5U1u9n+5gW
X-Received: by 2002:a05:7300:ea06:b0:36d:38c1:71c8 with SMTP id
 5a478bee46e88-36d38c179f4mr6261837eec.11.1793903196794; 
 Thu, 05 Nov 2026 10:26:36 -0800 (PST)
X-Received: by 2002:a05:7300:ea06:b0:36d:38c1:71c8 with SMTP id
 5a478bee46e88-36d38c179f4mr6261798eec.11.1793903196162; 
 Thu, 05 Nov 2026 10:26:36 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:35 -0800 (PST)
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
Subject: [PATCH v4 02/13] clk: qcom: add NEGCC driver for nord
Date: Thu,  5 Nov 2026 23:56:03 +0530
Message-Id: <20261105182614.2405482-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aecca5d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=XsUbWyw8Qz4yoGOgGSMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: hfGcvDWq9J6KEWiNebUklIzoDcEomL9B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX/IpywGkr+Mob
 WyTArkJNHIZBVTMomlM6B92p3h6Agzzt5S3Qod4sJuHiDCWSKOqao11g1TTZIlr8cX/1PYNHg1N
 ewhvlET/OC7R9tMn6QcVqi+INm9FCrk=
X-Proofpoint-GUID: hfGcvDWq9J6KEWiNebUklIzoDcEomL9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX6DZC+N1qQVYB
 IGa8bOm8DRoZke7rbxTnKQx2DgQa/tPgCMEr1GkvSNszRFAb6Yi78gUBS72mRMww25yTxKS5GQF
 ZLiNkgPX0wc4xGgg5vi+gyDcv9k5SODNAbMYWHnWe6/BxxC3qBrAQXIHhrUd1E8jK+p30C9YG6C
 a3ZYFeFtBzglG85Ygecc3V0LoJmUW0xkiSWx64v8Nyk2IYjIomutDlluC/Vap71qpVvXo9JciLM
 y4XX6NCt3FMPM/Pk5dmTOsT2sIfwlyr4SdL/JwNkqDIWCMizKMebju6hPM6OJoC5cdM0qgGTROw
 zW93KnwXmLWvwKIGZx1BBbflmR94WKmscRTLN9E0DTVf7KFM7fWw2Gy/iPZjNekxN/45YCTRsfc
 1sMcfAamX5ytlLQeF4HBv/ImrJclmFJ0rIpXXgXXQq/YKAV5xJeg4zXW/ku9cy+oSacM574lu+x
 zVi3e/BQHtsS8bwZ4xA==
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

Add support for the nord NE Global Clock Controller (NEGCC).

Implement the qcom,nord-negcc driver to provide clocks, resets and
power domains required by nord peripherals during initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-negcc.c | 193 ++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fe2f796c248..a9f6229a944 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-negcc.c b/drivers/clk/qcom/clock-nord-negcc.c
new file mode 100644
index 00000000000..f43e4c7d005
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-negcc.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-negcc.h>
+#include "clock-qcom.h"
+
+#define NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR		0x382a8
+#define NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR		0x2a038
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x2a050
+#define NE_GCC_USB20_MASTER_CLK_CMD_RCGR		0x31030
+#define NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR		0x31048
+
+static const struct freq_tbl ftbl_ne_gcc_qupv3_wrap2_s1_clk_src[] = {
+	F(7372800,   CFG_CLK_SRC_GPLL0, 1, 192, 15625),
+	F(14745600,  CFG_CLK_SRC_GPLL0, 1, 384, 15625),
+	F(19200000,  CFG_CLK_SRC_CXO,   1, 0,   0),
+	F(29491200,  CFG_CLK_SRC_GPLL0, 1, 768, 15625),
+	F(32000000,  CFG_CLK_SRC_GPLL0, 1, 4,   75),
+	F(48000000,  CFG_CLK_SRC_GPLL0, 1, 2,   25),
+	F(51200000,  CFG_CLK_SRC_GPLL0, 1, 32,  375),
+	F(64000000,  CFG_CLK_SRC_GPLL0, 1, 8,   75),
+	F(66666667,  CFG_CLK_SRC_GPLL0, 9, 0,   0),
+	F(75000000,  CFG_CLK_SRC_GPLL0, 8, 0,   0),
+	{ }
+};
+
+static ulong nord_negcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case NE_GCC_QUPV3_WRAP2_S1_CLK:
+		freq = qcom_find_freq(ftbl_ne_gcc_qupv3_wrap2_s1_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case NE_GCC_USB31_PRIM_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR,
+				     4, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB31_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				 1, CFG_CLK_SRC_CXO);
+		return rate;
+	case NE_GCC_USB20_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB20_MASTER_CLK_CMD_RCGR,
+				     9, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB20_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR,
+				 1, CFG_CLK_SRC_CXO);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_negcc_clks[] = {
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_UFS_PHY_AXI_CLK,  0x330f4, BIT(0),  0x330f4),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB2_AXI_CLK,     0x31068, BIT(0),  0x31068),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_PRIM_AXI_CLK, 0x2a098, BIT(0),  0x2a098),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_SEC_AXI_CLK, 0x2c098, BIT(0),  0x2c098),
+	GATE_CLK_POLLED(NE_GCC_AHB2PHY_CLK,                0x30004, BIT(0),  0x30004),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB2_AXI_CLK,          0x31064, BIT(0),  0x31064),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_PRIM_AXI_CLK,     0x2a094, BIT(0),  0x2a094),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_SEC_AXI_CLK,      0x2c094, BIT(0),  0x2c094),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_HSCNOC_GFX_CLK,       0x34014, BIT(0),  0x34014),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_SMMU_VOTE_CLK,        0x57028, BIT(0),  0x57028),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_2X_CLK,    0x57008, BIT(1),  0x38020),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_CLK,       0x57008, BIT(0),  0x3800c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_M_AHB_CLK,      0x57000, BIT(30), 0x38004),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S0_CLK,         0x57008, BIT(2),  0x3815c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S1_CLK,         0x57008, BIT(3),  0x38298),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S2_CLK,         0x57008, BIT(4),  0x383d4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S3_CLK,         0x57008, BIT(5),  0x38510),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S4_CLK,         0x57008, BIT(6),  0x3864c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S5_CLK,         0x57008, BIT(7),  0x38788),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S6_CLK,         0x57008, BIT(8),  0x388c4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S_AHB_CLK,      0x57000, BIT(31), 0x38008),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AHB_CLK,            0x33028, BIT(0),  0x33028),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AXI_CLK,            0x33018, BIT(0),  0x33018),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_ICE_CORE_CLK,       0x3307c, BIT(0),  0x3307c),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_PHY_AUX_CLK,        0x330bc, BIT(0),  0x330bc),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_UNIPRO_CORE_CLK,    0x3306c, BIT(0),  0x3306c),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_ATB_CLK,         0x2a018, BIT(0),  0x2a018),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_EUD_AHB_CLK,     0x2a02c, BIT(0),  0x2a02c),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_ATB_CLK,          0x2c018, BIT(0),  0x2c018),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_EUD_AHB_CLK,      0x2c02c, BIT(0),  0x2c02c),
+
+	GATE_CLK_POLLED(NE_GCC_FRQ_MEASURE_REF_CLK,  0x20008, BIT(0), 0x20008),
+	GATE_CLK_POLLED(NE_GCC_GP1_CLK,              0x21000, BIT(0), 0x21000),
+	GATE_CLK_POLLED(NE_GCC_GP2_CLK,              0x22000, BIT(0), 0x22000),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_CLK_SRC,      0x57000, BIT(19)),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_DIV_CLK_SRC,  0x57000, BIT(20)),
+	GATE_CLK_POLLED(NE_GCC_SDCC4_APPS_CLK,       0x18004, BIT(0), 0x18004),
+	GATE_CLK_POLLED(NE_GCC_SDCC4_AXI_CLK,        0x18014, BIT(0), 0x18014),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_0_CLK,  0x33030, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_1_CLK,  0x330d8, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_TX_SYMBOL_0_CLK,  0x3302c, BIT(0)),
+	GATE_CLK_POLLED(NE_GCC_USB20_MASTER_CLK,     0x31018, BIT(0), 0x31018),
+	GATE_CLK_POLLED(NE_GCC_USB20_MOCK_UTMI_CLK,  0x3102c, BIT(0), 0x3102c),
+	GATE_CLK_POLLED(NE_GCC_USB20_SLEEP_CLK,      0x31028, BIT(0), 0x31028),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_MASTER_CLK,    0x2a01c, BIT(0), 0x2a01c),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_MOCK_UTMI_CLK, 0x2a034, BIT(0), 0x2a034),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_SLEEP_CLK,     0x2a030, BIT(0), 0x2a030),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_MASTER_CLK,     0x2c01c, BIT(0), 0x2c01c),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_MOCK_UTMI_CLK,  0x2c034, BIT(0), 0x2c034),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_SLEEP_CLK,      0x2c030, BIT(0), 0x2c030),
+	GATE_CLK_POLLED(NE_GCC_USB3_PRIM_PHY_AUX_CLK,     0x2a06c, BIT(0), 0x2a06c),
+	GATE_CLK_POLLED(NE_GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x2a070, BIT(0), 0x2a070),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_PIPE_CLK,   0x2a074, BIT(0)),
+	GATE_CLK_POLLED(NE_GCC_USB3_SEC_PHY_AUX_CLK,      0x2c06c, BIT(0), 0x2c06c),
+	GATE_CLK_POLLED(NE_GCC_USB3_SEC_PHY_COM_AUX_CLK,  0x2c070, BIT(0), 0x2c070),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_PIPE_CLK,    0x2c074, BIT(0)),
+};
+
+static int nord_negcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_negcc_resets[] = {
+	[NE_GCC_GPU_2_BCR] = { 0x34000 },
+	[NE_GCC_QUPV3_WRAPPER_2_BCR] = { 0x38000 },
+	[NE_GCC_SDCC4_BCR] = { 0x18000 },
+	[NE_GCC_UFS_PHY_BCR] = { 0x33000 },
+	[NE_GCC_USB20_PRIM_BCR] = { 0x31000 },
+	[NE_GCC_USB31_PRIM_BCR] = { 0x2a000 },
+	[NE_GCC_USB31_SEC_BCR] = { 0x2c000 },
+	[NE_GCC_USB3_DP_PHY_PRIM_BCR] = { 0x2b008 },
+	[NE_GCC_USB3_DP_PHY_SEC_BCR] = { 0x2d008 },
+	[NE_GCC_USB3_PHY_PRIM_BCR] = { 0x2b000 },
+	[NE_GCC_USB3_PHY_SEC_BCR] = { 0x2d000 },
+	[NE_GCC_USB3PHY_PHY_PRIM_BCR] = { 0x2b004 },
+	[NE_GCC_USB3PHY_PHY_SEC_BCR] = { 0x2d004 },
+	[NE_GCC_QUSB2PHY_PRIM_BCR] = { 0x2e000 },
+};
+
+static const struct qcom_power_map nord_negcc_gdscs[] = {
+	[NE_GCC_UFS_MEM_PHY_GDSC] = { 0x32000 },
+	[NE_GCC_UFS_PHY_GDSC] = { 0x33004 },
+	[NE_GCC_USB20_PRIM_GDSC] = { 0x31004 },
+	[NE_GCC_USB31_PRIM_GDSC] = { 0x2a004 },
+	[NE_GCC_USB31_SEC_GDSC] = { 0x2c004 },
+	[NE_GCC_USB3_PHY_GDSC] = { 0x2b00c },
+	[NE_GCC_USB3_SEC_PHY_GDSC] = { 0x2d00c },
+};
+
+static struct msm_clk_data nord_negcc_data = {
+	.resets = nord_negcc_resets,
+	.num_resets = ARRAY_SIZE(nord_negcc_resets),
+	.clks = nord_negcc_clks,
+	.num_clks = ARRAY_SIZE(nord_negcc_clks),
+
+	.power_domains = nord_negcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_negcc_gdscs),
+
+	.enable = nord_negcc_enable,
+	.set_rate = nord_negcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_negcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-negcc",
+		.data = (ulong)&nord_negcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_negcc) = {
+	.name		= "gcc_nord_negcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_negcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

