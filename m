Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B36606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GVvmBYxx;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLvEJcpR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fP9iZ+SV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B64E40733;
	Sun, 15 Nov 2026 11:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zMotMxKb2nbG; Sun, 15 Nov 2026 11:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE80D4072E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794743495;
	b=SyxOtAXr7zpdwpxxvGHVdtf23nEQQ7gL5gT8fXNmO58dKpeVqmdJU+ifBJj1WC6iaWUv
	 Vd8909pSCq4ttoxda8OShwvNHpaV6POl50I5ORNHHVFqZxg+ZoXcyQmIWjFiQ3q2l4R/T
	 3rgZafW0h0svL6UZyGYZgz6XFF6BE9mSjoelIReNYkMlbd1jxoTIuEUUcxrVIned8UoRI
	 ZuOS9YE8tPHnNNM4ZzlQFeEuJKh7ECE7qGSPMJ+MGZt5b7/H4W8Oh0aZiQ+d8mv0dVgje
	 HDy9PS39HrGqnbkM1t7qRpe8BrfpAhFVG/GG2cik92v1huiQqOVz3FXAvat0ZnN0PxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794743495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QlkL3cAlOaTWRrSVPEOEUbpMjNx9gGSCem8Mmgs7vB4=;
	b=fXN/YsYAeRxdKqyRAXj/e+6s8bjgZ99IFo1FQreNthZJNwHofirTnUO20xF7UZcv1Rmy
	 6LwvJpOC5RYT/byZ5lpu75FPcC5mthLSmDp5NsvxVE4ZYXB4vpmJaCn+1QAD+UVAcjJBc
	 VS9ExB8/GwVq1jc1Doj2vIaEeIAbxbbQmz2FSfgfdCGpK1+vGi0H539jcxNVVDP1kBDOb
	 8bcV/Gg43IzDBKZekV1dAA8HHaF+MToZ4ZVUjNGK8i2dxPLNsymn2DwcEwNDP6xxOpiuG
	 UN6O0IkkFOW1F1coRz5FhCqVcCKJpxE7RaT06jix7a92BYjhsBAhkbyShJW8bBJ5DpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794743495;
	bh=QlkL3cAlOaTWRrSVPEOEUbpMjNx9gGSCem8Mmgs7vB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVvmBYxxK4ioyIR3FWOFX8Xr/26hYmnNU94OamlVJ3oUXkItLgFuxISHXcaa0X1eE
	 CUhHLaESxczonjJZLK05f42z/mexqVuZsFqjd4PFtmAFxTCFE0l72Og2lFFLR4whqJ
	 UzTIQSSAokZc2lWZojuqJAQMpjQ0spo1jfpcXNmh1hq6s+vGq0rijK5ZTsLgp11PuM
	 bB2nnbO20v2Wxxz8vMua8h5hqFsFM+dP5wb1FqNkvVSFCHob0i7QU5po7Q/ylBH5h3
	 To/y/7msvUHCtVMYBYBuU+vMUxCWuWL/vO4u7yiIUKS5D3Vj/ngiGKH1uKAd03qGyv
	 S5JslmyVFyrRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE80D4072E;
	Sun, 15 Nov 2026 11:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A4CB70B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C7860628
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhI2jua_rL5A for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3A226061B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLvEJcpR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fP9iZ+SV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3A226061B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFBm6k0699740
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QlkL3cAlOaTWRrSVPEOEUbpMjNx9gGSCem8Mmgs7vB4=; b=FLvEJcpRg+M7lJgb
 1iwaf5FHMyfn3BUtWdWzlht2pgxTPohyOpZjQxhWnmqCddvCRdqKy0XW/ZeOxiCm
 UreUZrTYOeoXv131JFXRuJOeXu1xzucgi0hJ2sL+Zf70FZNQgffIj5uxzwvTulXQ
 KfW06vX1GKDHXPO7nZmgmFzUqcnKJndLcdTEiEZWcbtwLvT2AlE41V4QxzCWKKGf
 /odxoYOUSiQKy4zP+ZVdf6avHKKhiMFEQwABDMhpBMCeN+2/z5e+Ny4yZoTVEFeS
 cghgCatXqkMS2j6BLaSBz/QNwutO9hcK+wDfvYgxYn4SY7e/N0UUl2F5ZLpG3PPu
 VF+O4A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj42w75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961511b61so288590885a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794743490; x=1795348290;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QlkL3cAlOaTWRrSVPEOEUbpMjNx9gGSCem8Mmgs7vB4=;
 b=fP9iZ+SVjnaHWSzdWywd3BlB1FJARFr/sWOEVVTgrA7mI6u1F3TqSf8e2IdLLuBlDe
 dkes1v4xBWsR/WI7S6d1ZVRvxvOtY7+ehhdoBjnZYNj4oShbU5yB34NdAJP3ePK7VWC9
 LFgqzbcJ/DM4lRMZTvNj1rseWULhAtAZ4K6zSr9wtL24cBAkWZl6FltvzK4jUPnG30X6
 PuGrbrYXMc2hfZso+c/zIwoduEbpHG57fi5eMncYuJvaySVO1JIc9GBC/gOca+VHbUDF
 bCDHZ2ObCMnEk3Vwlet437w1c4nQ7cYtzEPlt4/T3bLPVtXpc8o5gLgZVUUWUd3N0ojA
 ehdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794743490; x=1795348290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlkL3cAlOaTWRrSVPEOEUbpMjNx9gGSCem8Mmgs7vB4=;
 b=jKasHp2MnxzkJWy2YBEhI/yiaQu+8B1goYFDUh27xGArsoSUWSVKsvGmu+dM8TitMJ
 cLq/GpP/6VEP2z9q1nOWn1FBdXeixGXPwbKdjHsB4Sye7iYbW99szOHSxrsvSjoEGDzj
 BEq1RvTl1JhYArzXNXUu9A0PvqyMzDNlsEqY0AaEJ9CmaBeuMlcplp61OK8y/9Yb71jj
 qQGdMhCz4GrVUXVNDErPNy1CIx4HHejXBzPF+oXJXaXAkD34UsD3GQPNDOOFDcJ+caVY
 vNM+XTeAcaPrkgPOtqbUQnKATVESzPKrNyjW1+JxeyBFeqI+y+5hsdFPpTVPcPICQQzd
 dP5w==
X-Forwarded-Encrypted: i=1;
 AL+hErFmx8BehpMgRtyrrYxJrk8TYDvxkzf4x+OSWjHTFJBm/B1eE1cpVNTekUxwml1U6TyyBqxYooE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ce82IZgsi48lbsv3k6fe6entpHCOirY83WX3oP8+djqiWgDSZ
 NogPVNBzE1HMjTAUthxrcEcHt44GLmyOfyisZDC/kVdPFZc+PlsodHSng58A5SHVB9xetnSWWKj
 QsmtBxemC+r2VT3OB4f9VbGgDei/TREOGpsNbIVy6X9I5RINhVVoRSJpuuB3QD+gGrdwCUBw=
X-Gm-Gg: AYBFou3M9sNJJUMHKxHUI9YazFFz8sn199G9eNjJn8pGybEeWeY+HvV7nOlSJWgmkcx
 pMKW+TVdrjfZrAEXrL9zyrjZNPLFZmwatibd8cqKNI5cHonxL6FKyKgzyzkQT9+7rKn3rihq4T+
 HMb6DneKrvi9s5YsuTKDpMVymjUzlbxBz+vC0iaj8DMS2grHEt3u52Ya+GeTC8C4r7J7vFTWOtb
 JA1BLbC7A+LqXC4UUkFXSGaYnVGztXC9Wyb8Rb/bBr7n6rqnDEao5X6OD9ORxtIayA1xRHYwQz9
 NAEBjgcjb21Ho763poDYMzHfvRXJ6s+ea4p/wUeiUUpRzdjTPJjlXSAjl+++F2NqQuY+7xFHVrO
 waNvW47ILZtB1W/PstXJV5DJnZJ2RRWpUFq2f6uT6O8apQiTgsK0dTEFu98YAMi6OU2eYfJCxRp
 OjBa41yRiLqgBa
X-Received: by 2002:a05:620a:2a06:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-9494bba04cbmr1281643285a.56.1794743489632; 
 Sun, 15 Nov 2026 03:51:29 -0800 (PST)
X-Received: by 2002:a05:620a:2a06:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-9494bba04cbmr1281641985a.56.1794743489220; 
 Sun, 15 Nov 2026 03:51:29 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b3dbaesm299969066b.32.2026.11.15.03.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:51:28 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 12:51:18 +0100
Subject: [PATCH 1/4] mailbox: add the Qualcomm APCS IPC driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-rpm-glink-v1-1-6255beacc93b@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX4lpCza09U3gf
 F5BewVPygRc4HngmHwaKjoxrs3/dtnutxDi/wJIQQmsx6W3xBJJyaXM4TYrJWDgCgR1UKn0Q/d4
 9oiKeY4WcWvyIMLrbLA9Kp+Gq67RDMWh3bfsxIzezh89d8V2aSjRR9QtbHgrsQbUC2FkWJLU2Jt
 yS0W25PgnjFolhFqO1uQMaiAjOzpOBG+by2bgsxk7BGjV+UHKaV5DuMfyjAy/G2eOM0ElWaVDW8
 gBqEWz0jI2ee5OPhC1iW5FR1lmY5mniwp+cc/zJqmBKpWji9uhY77rQvTGK/CmIYLJa/Kud9EyG
 t74p1D7mQhUkA+AVAbvygPNxTiIQAT3ZQ7U8IRjR0eHau1wj/ljqtx8YcSaWP7vAe0BDcrS04yj
 DJaJjx+z8BllB44hnVWOZDktVilRwyT3ACgF9Kncq4w4SLE1o/kWwZVzCaK6VD734Hfo/2p/W+d
 UFOj+AxlCxC6e3s59ZA==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af99cc2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7oDPXYFqXr8hgPhy5tgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: WVziRzfneiNJgkmi0aOmAHwiI47zr41W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX+lHu/Janv8Qx
 3fw8c6nIRjms8WE0bAcpZeFRO9OB2uTUO/ALZWu7noTJpl57XO8Jercv3dGro8dSFugcx+qRVu1
 vt5utNdJtGsLyWihUwtcP4F6t7kB9YQ=
X-Proofpoint-ORIG-GUID: WVziRzfneiNJgkmi0aOmAHwiI47zr41W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
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

The APCS IPC register is a write-only doorbell with one bit per remote
processor. Add a mailbox driver for it, with the register offset per
compatible as in Linux: 8 for QCM2290 and the
qcom,msm8994-apcs-kpss-global fallback, 12 for the SDM845 APSS shared
block.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mailbox/Kconfig                 |  8 ++++
 drivers/mailbox/Makefile                |  1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 68 +++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 1d9e284cfd1..63d4d5d4ee9 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -38,6 +38,14 @@ config MPFS_MBOX
 	  Enable support for the mailboxes that provide a communication
 	  channel with the system controller integrated on PolarFire SoC.
 
+config QCOM_APCS_IPC
+	bool "Qualcomm APCS IPC mailbox"
+	depends on DM_MAILBOX && ARCH_SNAPDRAGON
+	help
+	  Enable the APCS IPC doorbell, which the application processors
+	  use to interrupt the RPM and the other remote processors on
+	  Qualcomm SoCs.
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index b3a36691497..7daf6eaba14 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
 obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_MPFS_MBOX) += mpfs-mbox.o
+obj-$(CONFIG_QCOM_APCS_IPC) += qcom-apcs-ipc-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
new file mode 100644
index 00000000000..acff66a7403
--- /dev/null
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm APCS IPC mailbox: a write-only doorbell register in the APCS
+ * global (or APSS shared) block, one bit per remote processor and channel.
+ *
+ * Based on the Linux qcom-apcs-ipc-mailbox driver:
+ * Copyright (c) 2017, Linaro Ltd
+ */
+
+#include <dm.h>
+#include <mailbox-uclass.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+struct qcom_apcs_ipc {
+	void __iomem *reg;
+};
+
+static int qcom_apcs_ipc_request(struct mbox_chan *chan)
+{
+	return chan->id < 32 ? 0 : -EINVAL;
+}
+
+static int qcom_apcs_ipc_send(struct mbox_chan *chan, const void *data)
+{
+	struct qcom_apcs_ipc *apcs = dev_get_priv(chan->dev);
+
+	writel(BIT(chan->id), apcs->reg);
+
+	return 0;
+}
+
+static int qcom_apcs_ipc_probe(struct udevice *dev)
+{
+	struct qcom_apcs_ipc *apcs = dev_get_priv(dev);
+	fdt_addr_t base;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	apcs->reg = (void __iomem *)(base + dev_get_driver_data(dev));
+
+	return 0;
+}
+
+static const struct mbox_ops qcom_apcs_ipc_ops = {
+	.request = qcom_apcs_ipc_request,
+	.send = qcom_apcs_ipc_send,
+};
+
+/* .data is the offset of the IPC register in the block */
+static const struct udevice_id qcom_apcs_ipc_ids[] = {
+	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = 8 },
+	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = 8 },
+	{ .compatible = "qcom,sdm845-apss-shared", .data = 12 },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_apcs_ipc) = {
+	.name = "qcom_apcs_ipc",
+	.id = UCLASS_MAILBOX,
+	.of_match = qcom_apcs_ipc_ids,
+	.probe = qcom_apcs_ipc_probe,
+	.priv_auto = sizeof(struct qcom_apcs_ipc),
+	.ops = &qcom_apcs_ipc_ops,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.53.0

