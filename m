Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818B606A31A
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a7Bz/eCL;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CqxxIC9I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5cpU+IC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 611A981089;
	Sun, 15 Nov 2026 11:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K25gOva08zQR; Sun, 15 Nov 2026 11:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1986281064
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794743501;
	b=kpCDDcdzb0eqzqxqQSLyMNIpSWRwkOZTNSKQpNXB8RVrL4VQZ6w7MWH7RpSqmAC44r63
	 AVtZJ6loC8eT6ZfceW0H5dE94sYCgnPRKrgCmAFfzu79gz1rxIyFsvmOlO3wF22oMuYUf
	 egXJ6w5shN+DaP2Sr1Q/K7CfFY15U04vBhLZFIyYiUiFlY+9kdGtSdS9AE1HXwlu7iX2E
	 JAPi93UYY6da40XN7QQ/+tjKQB+g30iGUlteT8VTiW3evPv6ZbxPqnRawoXOg12PeRPhP
	 EVwKDElSw2O969XYqMxV6s2k32GKx5p2/s1ll/05OUi5RBoO8psPT99qw2Cl6sttbCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794743501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TKSAbn2yFnMzINlRmCigKpQVIjPr720Fd9DWlabf1Hk=;
	b=VSRugDaMpmaI2lUx6/+8B0VoJMvgUoSwVtrbM2rtjgbqbiO+XFSt+DfAwuPS7osvmkkW
	 FypDoqhHUupl/WYg5xTcSP0QXE1a513Z0YT9GqKP8w4m5g5mpg5tTTk1ymsIBOBBrTdfS
	 v75Emvx/VWD5nuw4+YOkestin1EOXlMEe9NeXzozwdJzmcKfRnotYnoi3K3OBlGDl0TJl
	 3hEZKm0b8jHoTp1rPrTymL+3yYKsjYcjsF4vy1lw3WrDE1Dux3DU8VJw2Jf6Jk/RVOHHH
	 8cwXpxr8s9OZmTsV7G0jxc/ANkdzJy9jOLSS6Qcl3eXKAR5gNK7tPJfU7Yy+y7WXrHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CqxxIC9I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5cpU+IC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794743501;
	bh=TKSAbn2yFnMzINlRmCigKpQVIjPr720Fd9DWlabf1Hk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7Bz/eCL+3B/Z11Pc5m5JL1mHkosdVCApwxA8sknu+BCBWwxxHgQa3Ho/fNzzNaie
	 Il6yKbn1+JBna1IodX8WK4qKWrfno/nQSo/efvrHRKUnw2tB4UbR+x+DsTc3GM80ih
	 yH+mt96UVx3DXN6WwxKcnkp5nBwBiJFQyJSGRWMn8wOWo99oaijXshIRNO0pYz0e7S
	 CIJA6w1EjShDSAsJ/EoQifwPKFppclkB+zxkbHzLluD2sOTZ6erieBvEraDQSHPlkt
	 P+xgcXrJZY5VnKtPpORRaxbq1253OrzYZXg78gCM7Sb6wveCg46tf3Cfv1vN0cwRTJ
	 QrK9PzTNe4mRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1986281064;
	Sun, 15 Nov 2026 11:51:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 595E970B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AC068105B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSiZRRCagt3o for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2F6181064
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CqxxIC9I; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I5cpU+IC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2F6181064
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFBlxG62802570
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TKSAbn2yFnMzINlRmCigKpQVIjPr720Fd9DWlabf1Hk=; b=CqxxIC9IizJ1zRYu
 n+LZ58ArtcE/Oe/jUSYAAyojO19VCrD/xlaXpyRbWzNVC8XZiig5/spjHUThAttp
 1YCD0GAmqcD3sPYfyQg4l3YaubEcpTbkS2v8QhhJRDXeRVbCI+bYeAmoBhBVOvy6
 CObJUwPrnkNBEfuWqem6eO79WVr3YeRoe6KTnsyy4VNWH8EvJQSM7MG1/1KQZNBS
 n6sQRjswmUmhogjug+LwXo49LjKGs3xp6m2dWwi9I3IwpSIq3XPE7X/Yqu0+E+Bn
 LmP0avlD43BtcIwvQKiCOJa1O/v4vRB0qC2G2Jv0DTwSGrxUSRhMWmhgxZcEBKnV
 BKKUOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqjwxc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9496ff065bcso48075485a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794743492; x=1795348292;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKSAbn2yFnMzINlRmCigKpQVIjPr720Fd9DWlabf1Hk=;
 b=I5cpU+ICPEfxWrHWV3yHqgwcN0vp4hWZObCm0G4WaPy2UUezzdrAqU9b+M3QkqQj8K
 IP/DPaKPQcgyIpLEDHYemqiidiJwFadZCLE3n0rxt3TmpKjU2lGD7Zzcl/6J1pq3PNrt
 dYOuBV3wNIh87PM1wvT1blvCMFhguJKCqkhWFRlP0dOrrb/tsJ1r3GIN1eU2WKktlju4
 DkunhGvC+4jCtmKsPrsUQlUeemcriqFzoa3SD1zIjrAU7dePgJf6Xq8/JfRfDG2qOkJI
 i64XPbRiGtlkWmUmvstBcyNDVBT8fd+3NU64mbUHGUDRihJyy+LVuh//p41BYvkYuOLE
 U24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794743492; x=1795348292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TKSAbn2yFnMzINlRmCigKpQVIjPr720Fd9DWlabf1Hk=;
 b=JtPpfL704AYa2t88q9+UqfLdiq7YDCyFZdJec0FZMroIT9pGmav2U5ShxvBQjHi5SD
 3io4s6qdtCURrq4Y5TKqTNwXzsV9EYawFQ/Rr7U50b8Xz2+TcTa+2IH+2TXV7f1aVwpg
 u4w2aDseubiephGz5cu0nzcJ3jDlycJBUmdYuWrszy03vdw1BzCXEnQhdnVAKpG98Smz
 xjLQpGGAR8m1/XkdRvlnDTjD7QXHpYFsGpt6Et9ygZUlgGWjoeyxsj7IbLI2xY8yXYSX
 J4D/m4/e43l4Aersy0henkEgaJnUGKPMee5WIF7BrSLXOxmBkxlYkzqsfJALUtaJhz0M
 WtQg==
X-Forwarded-Encrypted: i=1;
 AL+hErHHTuOgvfrz8B5JA3DJMpmQnmVS1zcOiZcBPEnW085SzCijzq5qXttv1kkmYkUptLI8GMhk90g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kVk+y03kSYwXJ0+WwjxpI+jF95KStLtESHNWs/0/oWXGBZBYd
 JqaYK+bOEBl4j8s1wyJcJDBnu5sPgQF0pLv4otzwEgWjW3dP+mEk7ZNqXx+6/xsjqck9yOvPDev
 VEW6isRaFPW71vsFIlAsV+FM2jHSm/el4aXdqIXIJCxLMKeofb+wc9wImp3BEdd6bB/jqU8o=
X-Gm-Gg: AYBFou22jvHr+4ahFq+vixVx1PQ02u0l4JxTZxAcvaXQhDQIaP9nMsf7amH7jIIAto+
 2sgm+hMEIwvdrQBQu8mGOKuc28PcEqGSPfP58S7G0QU27x0MV+5IHmTH9KkPbJNuhehLHgX2zyH
 3szzNCDqcZ4Kgz3JqmKkrAeRw2YuQRWK5cYFsE5V6S/AlrXQRjiQlOAGb+NLFs0Cs+Ns8UJgckK
 r0MTWV8PY/fHjJ7oMhOgiLBodzbcyVV8mlQGkuZF9kmlSQE2QL60v5QEuLm7zU79+1/sNUN0t6F
 SI1DOwT1THJRNAl1VfNI26mkopkyeNV4Oevc8zWOEhXujO9tEPsoDe2XRIMtnLLDA+FoGfDzcyo
 a/E5teB1qjwFJl4XfBKmKrVv690LIq7JH1K697Zz0NDUmca6M9o/DyfgKn8TxTwz554m8jCIRCj
 MPP5lgSe3Ub3kR
X-Received: by 2002:a05:620a:2991:b0:949:6e15:e1d4 with SMTP id
 af79cd13be357-9496e15eb7cmr444626385a.56.1794743492074; 
 Sun, 15 Nov 2026 03:51:32 -0800 (PST)
X-Received: by 2002:a05:620a:2991:b0:949:6e15:e1d4 with SMTP id
 af79cd13be357-9496e15eb7cmr444624185a.56.1794743491437; 
 Sun, 15 Nov 2026 03:51:31 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b3dbaesm299969066b.32.2026.11.15.03.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:51:29 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 12:51:19 +0100
Subject: [PATCH 2/4] soc: qcom: add RPM requests over the GLINK RPM transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-rpm-glink-v1-2-6255beacc93b@oss.qualcomm.com>
References: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: MDEOp1GBaOMoMBn3Ui4xRQEHOhcnG773
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX9HRD1VoqTP1P
 VZMAZc8821CatSTfsj/pBQ6ygpeeJAHcUeLSgkz/TjkQleXWbVtKWpggNuOpO3Kdj8YzXIEGI5m
 +KdOPRfeCnceYnFornTipEVNDphl6ms96ymup4CvDAGhmMARAxhrnZSPQhfLFyFY4dIrjM//NWI
 oG/ATcrR4zDwfv39zMYfF41z0wR1tfObFWAzWJQAEXctAoq8RALNI9ZDfZyly8z35IiBHONVSRS
 7NR+CBR5Qxh2OUoVhsCMGAJB3A3TG8LNeIYzfBdZaLLE5X39wpvVKgbsO1+jc47DpqyfaWEbn/a
 FnYMzCu/4MHErHN+iTnXRKyDzqtuoqkLrSTww9mylw1EQkH84ilapgtCwkoaJ4OpLzQHqsNkgSN
 4qipVAWclbaIQ1L7JsT8dYVYNabwYQH86N0W2umbOXfoPRzAiPF8dChrbEhS9ZtnwIkPY53zS/O
 b/xrVkOLQuB+51riNQw==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af99cc5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4kWKgBmTg4NQTj_ncVEA:9 a=INik-KkDAxYrZTjn:21
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: MDEOp1GBaOMoMBn3Ui4xRQEHOhcnG773
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX3bozA3DnwmVt
 Ea4dH0oeD5S5786mKpEWCRb1hcEuexR86NWNMeIWEQWlTrNZcdQ3OoG+LeZsbtvx3WgbBqJFv2W
 3UXsz8QhbYs2BxANjK6tlfqPX6HoqqQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150046
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

RPM-based Qualcomm SoCs (QCM2290, SM6115, ...) vote for their rails,
regulators and bus clocks through the RPM. U-Boot only stubs the RPM
nodes, so nothing can vote, and the eMMC reports "power-domain driver
not found".

Add the GLINK transport over the RPM message RAM (polled, with the
APCS IPC doorbell) and qcom_rpm_smd_write(), following Linux's
qcom_glink_rpm and smd-rpm. The link comes up only when a consumer
first needs it (qcom_rpm_smd_ready()) and the edge never fails its
probe, so SoCs without an RPM consumer in U-Boot never touch the RPM
and their clock stubs probe as before.

The RPM announces its channels once per link. If U-Boot used the link,
it sends GLINK_SSR_DO_CLEANUP for "apss" before the OS starts and waits
for the RPM to reset the FIFOs; otherwise Linux logs "Invalid open ack
packet" and never reaches the RPM.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c     |   2 +
 drivers/soc/qcom/Kconfig   |  11 +
 drivers/soc/qcom/Makefile  |   1 +
 drivers/soc/qcom/smd-rpm.c | 772 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h |  41 +++
 5 files changed, 827 insertions(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 74825f87580..7985435fb28 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -13,8 +13,10 @@
 /* NOP parent nodes to stub clocks */
 static const struct udevice_id nop_parent_ids[] = {
 	{ .compatible = "qcom,rpm-proc" },
+#if !IS_ENABLED(CONFIG_QCOM_SMD_RPM)
 	{ .compatible = "qcom,glink-rpm" },
 	{ .compatible = "qcom,glink-smd-rpm" },
+#endif
 	{ }
 };
 
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..03e7c7ffcaf 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -25,6 +25,17 @@ config QCOM_RPMH
 	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
 	  if you need to control regulators on Qualcomm platforms, say y here.
 
+config QCOM_SMD_RPM
+	bool "Qualcomm RPM requests over GLINK"
+	depends on ARCH_SNAPDRAGON && DM_MAILBOX
+	select QCOM_APCS_IPC
+	help
+	  Say y here to talk to the RPM (resource power manager) of older
+	  Qualcomm SoCs such as QCM2290, through the GLINK transport in the
+	  RPM message RAM. The RPM power domain driver sends its requests
+	  through it. The link is only used once such a driver needs it,
+	  and is handed back to the RPM before the OS boots.
+
 config QCOM_SMEM
 	bool "Qualcomm SMEM support"
 	help
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f4102f9155a..fece2caa580 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
+obj-$(CONFIG_QCOM_SMD_RPM) += smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) += smem.o
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
new file mode 100644
index 00000000000..c548f1bb183
--- /dev/null
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm RPM requests over the GLINK RPM transport.
+ *
+ * The RPM exposes two FIFOs in its message RAM, listed in a table of
+ * contents at the end of that RAM, and is interrupted through the APCS IPC
+ * doorbell. GLINK runs on top of them with a single channel,
+ * "rpm_requests", which carries the resource requests. U-Boot has no
+ * interrupts, so the receive FIFO is polled. The link is only brought up
+ * when a consumer first needs the RPM, so a board without one never touches
+ * the RPM state the boot firmware left.
+ *
+ * Based on the Linux qcom_glink_rpm, qcom_glink_native, qcom_glink_ssr and
+ * smd-rpm drivers:
+ * Copyright (c) 2016-2017, Linaro Ltd
+ * Copyright (c) 2015, Sony Mobile Communications AB.
+ * Copyright (c) 2012-2013, 2014-2017, The Linux Foundation. All rights reserved.
+ */
+
+#include <dm.h>
+#include <mailbox.h>
+#include <time.h>
+#include <asm/io.h>
+#include <asm/unaligned.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <soc/qcom/smd-rpm.h>
+
+#define RPM_TOC_SIZE			256
+#define RPM_TOC_MAGIC			0x67727430 /* grt0 */
+#define RPM_TOC_HDR_SIZE		8
+#define RPM_TOC_ENTRY_SIZE		12
+#define RPM_TX_FIFO_ID			0x61703272 /* ap2r */
+#define RPM_RX_FIFO_ID			0x72326170 /* r2ap */
+
+#define GLINK_VERSION_1			1
+
+#define GLINK_CMD_VERSION		0
+#define GLINK_CMD_VERSION_ACK		1
+#define GLINK_CMD_OPEN			2
+#define GLINK_CMD_CLOSE			3
+#define GLINK_CMD_OPEN_ACK		4
+#define GLINK_CMD_INTENT		5
+#define GLINK_CMD_RX_DONE		6
+#define GLINK_CMD_RX_INTENT_REQ		7
+#define GLINK_CMD_RX_INTENT_REQ_ACK	8
+#define GLINK_CMD_TX_DATA		9
+#define GLINK_CMD_CLOSE_ACK		11
+#define GLINK_CMD_TX_DATA_CONT		12
+#define GLINK_CMD_READ_NOTIF		13
+#define GLINK_CMD_RX_DONE_W_REUSE	14
+#define GLINK_CMD_SIGNALS		15
+
+#define GLINK_NAME_SIZE			32
+#define GLINK_INTENT_PAIR_SIZE		8
+
+#define RPM_CHANNEL_NAME		"rpm_requests"
+#define RPM_CHANNEL_LCID		1
+#define SSR_CHANNEL_NAME		"glink_ssr"
+#define SSR_CHANNEL_LCID		2
+#define GLINK_SSR_DO_CLEANUP		0
+#define GLINK_SSR_APSS			"apss"
+#define RPM_TIMEOUT_US			(5 * 1000 * 1000)
+#define RPM_RESET_TIMEOUT_US		(100 * 1000)
+/* Packets to and from the RPM may not exceed 256 bytes */
+#define RPM_MAX_MSG_SIZE		256
+
+#define RPM_SERVICE_TYPE_REQUEST	0x00716572 /* "req\0" */
+#define RPM_MSG_TYPE_ERR		0x00727265 /* "err\0" */
+#define RPM_MSG_TYPE_MSG_ID		0x2367736d /* "msg#" */
+
+struct glink_msg {
+	__le16 cmd;
+	__le16 param1;
+	__le32 param2;
+} __packed;
+
+struct glink_data_hdr {
+	struct glink_msg msg;
+	__le32 chunk_size;
+	__le32 left_size;
+} __packed;
+
+struct qcom_rpm_header {
+	__le32 service_type;
+	__le32 length;
+};
+
+struct qcom_rpm_request {
+	__le32 msg_id;
+	__le32 flags;
+	__le32 type;
+	__le32 id;
+	__le32 data_len;
+};
+
+struct glink_rpm_pipe {
+	void __iomem *tail;
+	void __iomem *head;
+	void __iomem *fifo;
+	u32 length;
+};
+
+struct glink_rpm {
+	struct glink_rpm_pipe rx;
+	struct glink_rpm_pipe tx;
+	struct mbox_chan mbox;
+	int link_err;
+	bool started;
+	u32 features;
+	u16 rcid;
+	bool remote_open;
+	bool open_acked;
+	u16 ssr_rcid;
+	bool ssr_open_acked;
+	bool msg_ready;
+	u32 msg_id;
+	u32 msg_len;
+	u8 msg[RPM_MAX_MSG_SIZE];
+};
+
+/* The message RAM only takes 32-bit accesses. */
+static u32 glink_rpm_rx_avail(struct glink_rpm_pipe *pipe)
+{
+	u32 head = readl(pipe->head);
+	u32 tail = readl(pipe->tail);
+
+	return head < tail ? pipe->length - tail + head : head - tail;
+}
+
+static void glink_rpm_rx_peek(struct glink_rpm_pipe *pipe, u32 offset,
+			      void *data, u32 count)
+{
+	u32 pos = (readl(pipe->tail) + offset) % pipe->length;
+	u8 *buf = data;
+	u32 word, n;
+
+	while (count) {
+		word = readl(pipe->fifo + pos);
+		n = min_t(u32, count, sizeof(word));
+		memcpy(buf, &word, n);
+		buf += n;
+		count -= n;
+		pos += sizeof(word);
+		if (pos >= pipe->length)
+			pos = 0;
+	}
+}
+
+static void glink_rpm_rx_advance(struct glink_rpm_pipe *pipe, u32 count)
+{
+	writel((readl(pipe->tail) + count) % pipe->length, pipe->tail);
+}
+
+static u32 glink_rpm_tx_avail(struct glink_rpm_pipe *pipe)
+{
+	u32 head = readl(pipe->head);
+	u32 tail = readl(pipe->tail);
+
+	return tail <= head ? pipe->length - head + tail : tail - head;
+}
+
+static int glink_rpm_tx(struct glink_rpm *rpm, const void *hdr, u32 hlen,
+			const void *data, u32 dlen)
+{
+	struct glink_rpm_pipe *pipe = &rpm->tx;
+	u8 buf[sizeof(struct glink_data_hdr) + RPM_MAX_MSG_SIZE];
+	u32 len = ALIGN(hlen + dlen, 8);
+	ulong start = timer_get_us();
+	u32 head, word, i;
+
+	if (len > sizeof(buf) || len >= pipe->length)
+		return -EINVAL;
+
+	memset(buf, 0, len);
+	memcpy(buf, hdr, hlen);
+	if (dlen)
+		memcpy(buf + hlen, data, dlen);
+
+	/* Never fill the FIFO completely: head == tail means empty */
+	while (glink_rpm_tx_avail(pipe) <= len) {
+		if (timer_get_us() - start > RPM_TIMEOUT_US)
+			return -ETIMEDOUT;
+		udelay(10);
+	}
+
+	head = readl(pipe->head);
+	for (i = 0; i < len; i += sizeof(word)) {
+		memcpy(&word, buf + i, sizeof(word));
+		writel(word, pipe->fifo + head);
+		head += sizeof(word);
+		if (head >= pipe->length)
+			head = 0;
+	}
+	writel(head, pipe->head);
+
+	return mbox_send(&rpm->mbox, NULL);
+}
+
+static int glink_rpm_send_cmd(struct glink_rpm *rpm, u16 cmd, u16 param1,
+			      u32 param2)
+{
+	struct glink_msg msg = {
+		.cmd = cpu_to_le16(cmd),
+		.param1 = cpu_to_le16(param1),
+		.param2 = cpu_to_le32(param2),
+	};
+
+	return glink_rpm_tx(rpm, &msg, sizeof(msg), NULL, 0);
+}
+
+static int glink_rpm_rx_data(struct udevice *dev, struct glink_rpm *rpm,
+			     u32 avail)
+{
+	struct glink_data_hdr hdr;
+	u32 chunk, left;
+	u16 cmd, rcid;
+
+	if (avail < sizeof(hdr))
+		return -EAGAIN;
+
+	glink_rpm_rx_peek(&rpm->rx, 0, &hdr, sizeof(hdr));
+	cmd = le16_to_cpu(hdr.msg.cmd);
+	rcid = le16_to_cpu(hdr.msg.param1);
+	chunk = le32_to_cpu(hdr.chunk_size);
+	left = le32_to_cpu(hdr.left_size);
+
+	if (avail < sizeof(hdr) + chunk)
+		return -EAGAIN;
+
+	if (rpm->rcid && rcid == rpm->rcid) {
+		if (cmd == GLINK_CMD_TX_DATA)
+			rpm->msg_len = 0;
+
+		if (rpm->msg_len + chunk > sizeof(rpm->msg)) {
+			dev_err(dev, "RPM message too long, dropped\n");
+			rpm->msg_len = 0;
+		} else {
+			glink_rpm_rx_peek(&rpm->rx, sizeof(hdr),
+					  rpm->msg + rpm->msg_len, chunk);
+			rpm->msg_len += chunk;
+			if (!left)
+				rpm->msg_ready = true;
+		}
+	}
+
+	glink_rpm_rx_advance(&rpm->rx, ALIGN(sizeof(hdr) + chunk, 8));
+
+	return 0;
+}
+
+/* Handle everything the RPM has sent so far */
+static int glink_rpm_rx(struct udevice *dev, struct glink_rpm *rpm)
+{
+	char name[GLINK_NAME_SIZE];
+	struct glink_msg msg;
+	u32 avail, extra, param2;
+	u16 cmd, param1;
+	int ret;
+
+	for (;;) {
+		avail = glink_rpm_rx_avail(&rpm->rx);
+		if (avail < sizeof(msg))
+			return 0;
+
+		glink_rpm_rx_peek(&rpm->rx, 0, &msg, sizeof(msg));
+		cmd = le16_to_cpu(msg.cmd);
+		param1 = le16_to_cpu(msg.param1);
+		param2 = le32_to_cpu(msg.param2);
+
+		switch (cmd) {
+		case GLINK_CMD_VERSION:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (param1 == GLINK_VERSION_1)
+				rpm->features &= param2;
+			if (param1) {
+				ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION_ACK,
+							 GLINK_VERSION_1,
+							 rpm->features);
+				if (ret)
+					return ret;
+			}
+			break;
+		case GLINK_CMD_VERSION_ACK:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (!param1 || (param1 == GLINK_VERSION_1 &&
+					param2 == rpm->features))
+				break;
+			if (param1 == GLINK_VERSION_1)
+				rpm->features &= param2;
+			ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION,
+						 GLINK_VERSION_1, rpm->features);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_OPEN:
+			/* the upper 16 bits of param2 are the priority */
+			extra = ALIGN(param2 & 0xffff, 8);
+			if (avail < sizeof(msg) + extra)
+				return 0;
+			memset(name, 0, sizeof(name));
+			glink_rpm_rx_peek(&rpm->rx, sizeof(msg), name,
+					  min_t(u32, extra, sizeof(name) - 1));
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg) + extra);
+			if (!strcmp(name, RPM_CHANNEL_NAME)) {
+				rpm->rcid = param1;
+				rpm->remote_open = true;
+			} else if (!strcmp(name, SSR_CHANNEL_NAME)) {
+				rpm->ssr_rcid = param1;
+			} else {
+				dev_dbg(dev, "ignoring channel %s\n", name);
+			}
+			break;
+		case GLINK_CMD_OPEN_ACK:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (param1 == RPM_CHANNEL_LCID)
+				rpm->open_acked = true;
+			if (param1 == SSR_CHANNEL_LCID)
+				rpm->ssr_open_acked = true;
+			break;
+		case GLINK_CMD_CLOSE:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (rpm->rcid && param1 == rpm->rcid) {
+				rpm->remote_open = false;
+				rpm->open_acked = false;
+				rpm->rcid = 0;
+				/* refuse further requests instead of timing out */
+				rpm->link_err = -ENOTCONN;
+			}
+			ret = glink_rpm_send_cmd(rpm, GLINK_CMD_CLOSE_ACK,
+						 param1, 0);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_INTENT:
+			extra = param2 * GLINK_INTENT_PAIR_SIZE;
+			if (avail < sizeof(msg) + extra)
+				return 0;
+			glink_rpm_rx_advance(&rpm->rx,
+					     ALIGN(sizeof(msg) + extra, 8));
+			break;
+		case GLINK_CMD_READ_NOTIF:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			ret = mbox_send(&rpm->mbox, NULL);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_CLOSE_ACK:
+		case GLINK_CMD_RX_DONE:
+		case GLINK_CMD_RX_DONE_W_REUSE:
+		case GLINK_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_RX_INTENT_REQ_ACK:
+		case GLINK_CMD_SIGNALS:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			break;
+		case GLINK_CMD_TX_DATA:
+		case GLINK_CMD_TX_DATA_CONT:
+			ret = glink_rpm_rx_data(dev, rpm, avail);
+			if (ret == -EAGAIN)
+				return 0;
+			break;
+		default:
+			dev_err(dev, "unhandled GLINK command %u\n", cmd);
+			return -EPROTO;
+		}
+	}
+}
+
+static int glink_rpm_wait(struct udevice *dev, struct glink_rpm *rpm,
+			  const bool *done)
+{
+	ulong start = timer_get_us();
+	int ret;
+
+	for (;;) {
+		ret = glink_rpm_rx(dev, rpm);
+		if (ret)
+			return ret;
+		if (*done)
+			return 0;
+		if (timer_get_us() - start > RPM_TIMEOUT_US)
+			return -ETIMEDOUT;
+		udelay(10);
+	}
+}
+
+static int glink_rpm_parse_toc(struct udevice *dev, struct glink_rpm *rpm,
+			       void __iomem *msg_ram, u32 size)
+{
+	void __iomem *toc = msg_ram + size - RPM_TOC_SIZE;
+	struct glink_rpm_pipe *pipe;
+	u32 count, id, offset, len, i;
+
+	if (readl(toc) != RPM_TOC_MAGIC) {
+		dev_dbg(dev, "RPM TOC has invalid magic\n");
+		return -EINVAL;
+	}
+
+	count = readl(toc + 4);
+	if (count > (RPM_TOC_SIZE - RPM_TOC_HDR_SIZE) / RPM_TOC_ENTRY_SIZE) {
+		dev_dbg(dev, "invalid number of RPM TOC entries\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < count; i++) {
+		void __iomem *entry = toc + RPM_TOC_HDR_SIZE +
+				      i * RPM_TOC_ENTRY_SIZE;
+
+		id = readl(entry);
+		offset = readl(entry + 4);
+		len = readl(entry + 8);
+
+		if (offset > size || len > size - offset) {
+			dev_dbg(dev, "RPM TOC entry with invalid size\n");
+			continue;
+		}
+
+		if (id == RPM_RX_FIFO_ID)
+			pipe = &rpm->rx;
+		else if (id == RPM_TX_FIFO_ID)
+			pipe = &rpm->tx;
+		else
+			continue;
+
+		/* tail and head indices, then the FIFO itself */
+		pipe->length = len;
+		pipe->tail = msg_ram + offset;
+		pipe->head = msg_ram + offset + 4;
+		pipe->fifo = msg_ram + offset + 8;
+	}
+
+	if (!rpm->rx.fifo || !rpm->tx.fifo) {
+		dev_dbg(dev, "RPM TOC has no rx/tx FIFO\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Only look the link up: an edge U-Boot cannot use (no message RAM, an
+ * unsupported mailbox) must not fail the probe, since the RPM clock stubs
+ * and other children sit below it. The error is reported once a consumer
+ * asks for the link.
+ */
+static int glink_rpm_probe(struct udevice *dev)
+{
+	struct glink_rpm *rpm = dev_get_priv(dev);
+	fdt_addr_t base = FDT_ADDR_T_NONE;
+	fdt_size_t size = 0;
+	ofnode node;
+	int ret;
+
+	node = ofnode_parse_phandle(dev_ofnode(dev), "qcom,rpm-msg-ram", 0);
+	if (ofnode_valid(node))
+		base = ofnode_get_addr_size_index(node, 0, &size);
+	if (base == FDT_ADDR_T_NONE || size < RPM_TOC_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = glink_rpm_parse_toc(dev, rpm, (void __iomem *)base, size);
+	if (ret)
+		goto out;
+
+	ret = mbox_get_by_index(dev, 0, &rpm->mbox);
+
+out:
+	rpm->link_err = ret;
+	if (ret)
+		dev_dbg(dev, "RPM link unusable: %d\n", ret);
+
+	return 0;
+}
+
+static const struct udevice_id glink_rpm_ids[] = {
+	{ .compatible = "qcom,glink-rpm" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_glink_rpm) = {
+	.name = "qcom_glink_rpm",
+	.id = UCLASS_NOP,
+	.of_match = glink_rpm_ids,
+	.bind = dm_scan_fdt_dev,
+	.probe = glink_rpm_probe,
+	.priv_auto = sizeof(struct glink_rpm),
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+/*
+ * Return -EAGAIN for the acknowledgment of an earlier request (one that
+ * timed out), so that the caller keeps waiting for its own.
+ */
+static int smd_rpm_parse_ack(struct udevice *dev, const u8 *data, u32 len,
+			     u32 msg_id)
+{
+	u32 type, mlen, hdr_len, off, end;
+	char err[32];
+	int status = 0;
+
+	if (len < sizeof(struct qcom_rpm_header))
+		return -EINVAL;
+
+	hdr_len = get_unaligned_le32(data + 4);
+	if (get_unaligned_le32(data) != RPM_SERVICE_TYPE_REQUEST ||
+	    hdr_len > len - sizeof(struct qcom_rpm_header)) {
+		dev_err(dev, "invalid RPM response\n");
+		return -EINVAL;
+	}
+
+	off = sizeof(struct qcom_rpm_header);
+	end = off + hdr_len;
+	while (off + 8 <= end) {
+		type = get_unaligned_le32(data + off);
+		mlen = get_unaligned_le32(data + off + 4);
+		if (mlen > end - off - 8)
+			break;
+
+		if (type == RPM_MSG_TYPE_MSG_ID && mlen >= 4 &&
+		    get_unaligned_le32(data + off + 8) != msg_id)
+			return -EAGAIN;
+
+		if (type == RPM_MSG_TYPE_ERR) {
+			memset(err, 0, sizeof(err));
+			memcpy(err, data + off + 8,
+			       min_t(u32, mlen, sizeof(err) - 1));
+			dev_dbg(dev, "RPM error: %s\n", err);
+			status = strcmp(err, "resource does not exist") ?
+				 -EIO : -ENXIO;
+		}
+
+		off = ALIGN(off + 8 + mlen, 4);
+	}
+
+	return status;
+}
+
+static int glink_rpm_send_data(struct glink_rpm *rpm, u16 lcid,
+			       const void *data, u32 len)
+{
+	struct glink_data_hdr hdr;
+
+	hdr.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
+	hdr.msg.param1 = cpu_to_le16(lcid);
+	hdr.msg.param2 = 0;
+	hdr.chunk_size = cpu_to_le32(len);
+	hdr.left_size = 0;
+
+	rpm->msg_ready = false;
+
+	return glink_rpm_tx(rpm, &hdr, sizeof(hdr), data, len);
+}
+
+/* Acknowledge the RPM's open of a channel and open our end of it */
+static int glink_rpm_open(struct udevice *edge, struct glink_rpm *rpm,
+			  u16 rcid, u16 lcid, const char *name,
+			  const bool *acked)
+{
+	struct {
+		struct glink_msg msg;
+		char name[GLINK_NAME_SIZE];
+	} req;
+	u32 name_len = strlen(name) + 1;
+	int ret;
+
+	ret = glink_rpm_send_cmd(rpm, GLINK_CMD_OPEN_ACK, rcid, 0);
+	if (ret)
+		return ret;
+
+	memset(&req, 0, sizeof(req));
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
+	req.msg.param1 = cpu_to_le16(lcid);
+	req.msg.param2 = cpu_to_le32(name_len);
+	strlcpy(req.name, name, sizeof(req.name));
+
+	ret = glink_rpm_tx(rpm, &req, ALIGN(sizeof(req.msg) + name_len, 8),
+			   NULL, 0);
+	if (ret)
+		return ret;
+
+	return glink_rpm_wait(edge, rpm, acked);
+}
+
+/* Bring the link and the rpm_requests channel up on first use */
+static int glink_rpm_connect(struct udevice *edge, struct glink_rpm *rpm)
+{
+	int ret;
+
+	if (rpm->link_err)
+		return rpm->link_err;
+	if (rpm->open_acked)
+		return 0;
+
+	if (!rpm->started) {
+		rpm->started = true;
+		writel(0, rpm->tx.head);
+		writel(0, rpm->rx.tail);
+		ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION,
+					 GLINK_VERSION_1, rpm->features);
+		if (ret)
+			goto err;
+	}
+
+	/* The RPM opens the channel once the versions are agreed on */
+	ret = glink_rpm_wait(edge, rpm, &rpm->remote_open);
+	if (ret)
+		goto err;
+
+	ret = glink_rpm_open(edge, rpm, rpm->rcid, RPM_CHANNEL_LCID,
+			     RPM_CHANNEL_NAME, &rpm->open_acked);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	rpm->link_err = ret;
+	dev_err(edge, "RPM did not open %s: %d\n", RPM_CHANNEL_NAME, ret);
+
+	return ret;
+}
+
+int qcom_rpm_smd_write(struct udevice *dev, int state, u32 type, u32 id,
+		       void *buf, size_t count)
+{
+	struct udevice *edge = dev_get_parent(dev);
+	struct glink_rpm *rpm = dev_get_priv(edge);
+	struct {
+		struct qcom_rpm_header hdr;
+		struct qcom_rpm_request req;
+		u8 payload[RPM_MAX_MSG_SIZE];
+	} pkt;
+	u32 size = sizeof(pkt.hdr) + sizeof(pkt.req) + count;
+	u32 msg_id;
+	int ret;
+
+	if (size >= RPM_MAX_MSG_SIZE)
+		return -EINVAL;
+
+	ret = glink_rpm_connect(edge, rpm);
+	if (ret)
+		return ret;
+
+	pkt.hdr.service_type = cpu_to_le32(RPM_SERVICE_TYPE_REQUEST);
+	pkt.hdr.length = cpu_to_le32(sizeof(pkt.req) + count);
+	msg_id = ++rpm->msg_id;
+	pkt.req.msg_id = cpu_to_le32(msg_id);
+	pkt.req.flags = cpu_to_le32(state);
+	pkt.req.type = cpu_to_le32(type);
+	pkt.req.id = cpu_to_le32(id);
+	pkt.req.data_len = cpu_to_le32(count);
+	memcpy(pkt.payload, buf, count);
+
+	ret = glink_rpm_send_data(rpm, RPM_CHANNEL_LCID, &pkt, size);
+	if (ret)
+		return ret;
+
+	for (;;) {
+		ret = glink_rpm_wait(edge, rpm, &rpm->msg_ready);
+		if (ret) {
+			dev_err(dev, "no RPM response: %d\n", ret);
+			return ret;
+		}
+
+		ret = smd_rpm_parse_ack(dev, rpm->msg, rpm->msg_len, msg_id);
+		if (ret != -EAGAIN)
+			return ret;
+		rpm->msg_ready = false;
+	}
+}
+
+int qcom_rpm_smd_ready(struct udevice *dev)
+{
+	struct udevice *edge = dev_get_parent(dev);
+
+	return glink_rpm_connect(edge, dev_get_priv(edge));
+}
+
+/*
+ * Hand the link over in the state the kernel expects. The RPM announces its
+ * channels once per link, and the kernel's GLINK driver waits for that
+ * announcement before it opens rpm_requests. Ask the RPM, over its glink_ssr
+ * channel as Linux does after a remote processor crash, to clean up its
+ * channels to the application processor: it then resets the whole link,
+ * FIFO indices included, and announces the channels again when the kernel
+ * connects.
+ *
+ * Linux itself never sends this for "apss": it sends DO_CLEANUP on behalf of
+ * a stopped remote processor and waits for CLEANUP_DONE. The RPM answers
+ * the "apss" cleanup by resetting the link instead, so completion is
+ * detected by all four FIFO indices reading 0. Nothing is done if U-Boot
+ * never used the link.
+ */
+static int smd_rpm_remove(struct udevice *dev)
+{
+	struct udevice *edge = dev_get_parent(dev);
+	struct glink_rpm *rpm = dev_get_priv(edge);
+	struct {
+		__le32 version;
+		__le32 command;
+		__le32 seq_num;
+		__le32 name_len;
+		char name[32];
+	} cleanup;
+	ulong start;
+	int ret;
+
+	if (!rpm->started)
+		return 0;
+
+	if (!rpm->ssr_rcid) {
+		ret = -ENOENT;
+		goto err;
+	}
+
+	ret = glink_rpm_open(edge, rpm, rpm->ssr_rcid, SSR_CHANNEL_LCID,
+			     SSR_CHANNEL_NAME, &rpm->ssr_open_acked);
+	if (ret)
+		goto err;
+
+	memset(&cleanup, 0, sizeof(cleanup));
+	cleanup.command = cpu_to_le32(GLINK_SSR_DO_CLEANUP);
+	cleanup.seq_num = cpu_to_le32(1);
+	cleanup.name_len = cpu_to_le32(strlen(GLINK_SSR_APSS));
+	strlcpy(cleanup.name, GLINK_SSR_APSS, sizeof(cleanup.name));
+
+	ret = glink_rpm_send_data(rpm, SSR_CHANNEL_LCID, &cleanup,
+				  sizeof(cleanup));
+	if (ret)
+		goto err;
+
+	/*
+	 * The RPM answers by resetting the link rather than with
+	 * cleanup_done; do not read the receive FIFO meanwhile, the reset
+	 * discards it.
+	 */
+	start = timer_get_us();
+	while (readl(rpm->tx.head) || readl(rpm->tx.tail) ||
+	       readl(rpm->rx.head) || readl(rpm->rx.tail)) {
+		if (timer_get_us() - start > RPM_RESET_TIMEOUT_US) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+		udelay(10);
+	}
+
+	return 0;
+
+err:
+	dev_err(dev, "failed to reset the RPM link, the kernel may not reach the RPM: %d\n",
+		ret);
+	return 0;
+}
+
+static const struct udevice_id smd_rpm_ids[] = {
+	{ .compatible = "qcom,glink-smd-rpm" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_smd_rpm) = {
+	.name = "qcom_smd_rpm",
+	.id = UCLASS_NOP,
+	.of_match = smd_rpm_ids,
+	.bind = dm_scan_fdt_dev,
+	.remove = smd_rpm_remove,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF | DM_FLAG_OS_PREPARE,
+};
diff --git a/include/soc/qcom/smd-rpm.h b/include/soc/qcom/smd-rpm.h
new file mode 100644
index 00000000000..10d2f188b61
--- /dev/null
+++ b/include/soc/qcom/smd-rpm.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm SMD RPM interface, after Linux include/linux/soc/qcom/smd-rpm.h.
+ */
+#ifndef __QCOM_SMD_RPM_H__
+#define __QCOM_SMD_RPM_H__
+
+#include <linux/types.h>
+
+struct udevice;
+
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
+
+/**
+ * qcom_rpm_smd_write() - send a resource request to the RPM and wait for
+ *			  its acknowledgment
+ *
+ * @rpm:	the rpm-requests device (the parent of the RPM consumers)
+ * @state:	QCOM_SMD_RPM_ACTIVE_STATE or QCOM_SMD_RPM_SLEEP_STATE
+ * @type:	resource type, e.g. "rwcx" as a little-endian u32
+ * @id:		resource id
+ * @buf:	key/length/value triplets
+ * @count:	size of @buf in bytes
+ *
+ * Return: 0 on success, -ENXIO if the RPM does not know the resource, -EIO
+ * if it rejects the request, another negative errno on failure.
+ */
+int qcom_rpm_smd_write(struct udevice *rpm, int state, u32 type, u32 id,
+		       void *buf, size_t count);
+
+/**
+ * qcom_rpm_smd_ready() - bring the link to the RPM up if it is not yet
+ *
+ * @rpm:	the rpm-requests device
+ *
+ * Return: 0 when requests can be sent, a negative errno otherwise.
+ */
+int qcom_rpm_smd_ready(struct udevice *rpm);
+
+#endif /* __QCOM_SMD_RPM_H__ */

-- 
2.53.0

