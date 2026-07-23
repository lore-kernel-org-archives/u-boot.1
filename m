Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B71C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19E5240744;
	Thu, 23 Jul 2026 08:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWjXNv8SDXhS; Thu, 23 Jul 2026 08:36:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35DFB407EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784795761;
	bh=WkRA+mWhXHL4rmb1Uho6y4HAR9G+cmozATkGat7ZBDg=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KyjpPOcptpT9xz3eUlLZEU1rm5o6Gq+SYL2WDyzn73KUy4Htle172qApB59etMF+3
	 mnoJ2w92JjI3klKIR+RhSFOyjxzS5eaeUPO5hQhHGYdHUH/WfBvA9bcOXCYoLMXJs2
	 cGNGs2yG2HRz+9rvswA8/VHx+HcTSUmPYyKZ2v49P1WvZ2SPK9z68yMX7jjFoJs/ZR
	 X0fYb4EFpWklisdGVg5e8Wfv9UObaY5zUrVpC001A73fxnW/EEjjpZkwYzTcmr9WSq
	 Q0j2JG2rGqZ5YZCeHumQIoF+JyVl8X2iKcQWOdsLWDl9LJpfIAEVwCn3CtYLBimTig
	 InRsw7v6qrvZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35DFB407EE;
	Thu, 23 Jul 2026 08:36:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D29786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A98D8407EE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bAsiAUzkWTO for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:35:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9632340744
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9632340744
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9632340744
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BgMN3285912
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:58 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm147px-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:35:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso808184a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795757; x=1785400557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkRA+mWhXHL4rmb1Uho6y4HAR9G+cmozATkGat7ZBDg=;
 b=n1fBKmGwvbHibTxf3Seq505GiSmuC83S+79b75hpaiUlm0GzVsgiR/x5e5rGvQMIe8
 wTtJbYW6WQTdxOJVP57LNyrRQjBWLCIujvP8Jd3sRgLCQUVDCXkpnCuoI6T66gPuBGCC
 rF2+3nE8KSO3kfQTBT6xkqMH9jya1FlfcybXiXs2xso7/mMeigeIjOav8EKK/TqlS8/w
 qN+618OAEBTaE8AtS1pgnhFcOn5PAZmuszJ0JmgAnDwd8VAFHllvrmuqiYzatgaiVB4X
 jt3eV+WJygodeqxzqx+IQuOmKJmeRHtjjXH0xbirarYSos5b6iAffxHx3kORTVEtoyKV
 wzHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNzlBlWLRAQowwdwFF38orB04J9UFusJIpj1jrQeyK7FNZmvH4ckiMcowyhj5KxVLvDiYG3Sk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz6yZwns5Gt1qnvrui78gBmOaP4ktS8m2xrGoqCuI/df82y0rmI
 xTDP66QLxeJHwQ6nikxS/PoEn/nAOVLjQp1d/ztMUHqoA8qlYfYhoq+HyjvanlPrYCXuqYT1ico
 SnYgtbLCJjQ9Ycw16g64tmA6eK/q2JRa/6Zo0qysPyUyz6qPnvgY71uWJJ/KYWq1ZGLYE5cI=
X-Gm-Gg: AR+sD10Ha45TsnimhYfOZudCBHDHzmpyNOt7WSW02WknLaxaFzSVQQtuoBuid/FNHjA
 1KPPA7ny4ZhJ06dTK2roSpkDK2PWDDAXaiDCPoPRLxStKC+gQR1j2tvDQMRs3NU0WGwSgpySGD7
 SohlcPKsBNgyFJAPI7ZKp+4c0RfgdBhLOBenD/ZxXgnb+A+ejbOfCfauF+1jNljsIc/w92+DQo5
 Z8Solm6s4c95oxQMjCnngl6Q+lkRdad4OAq3BLkKXyFq37k+Ajk4xHQOw3LXHsKJB+rrmn9GA9L
 yoT3At0C4KLc3znrM9mzr9twLYHXygIpVH3Q+SbslI7agi5nEYXuvZdUGT1zFr/NP8+bwyMIN8A
 wKqF8+NKj25wM80NZbk3ePsNZnmOfe74ZiJ5pKJkpHEX+6zZaYZxlGohHfLS8HG7SWJo5L6YL6d
 2jDyyVAQkp6S4T+Kup56vgCi/xPX+tkA==
X-Received: by 2002:a05:6a21:6e96:b0:3c4:46ca:3348 with SMTP id
 adf61e73a8af0-3c44b2484f4mr2118430637.73.1784795757382; 
 Thu, 23 Jul 2026 01:35:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e96:b0:3c4:46ca:3348 with SMTP id
 adf61e73a8af0-3c44b2484f4mr2118399637.73.1784795756949; 
 Thu, 23 Jul 2026 01:35:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm18757149eec.27.2026.07.23.01.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:35:56 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:05:49 +0530
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] clk: qcom: sc7280: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
Message-ID: <amHSZT5+FMkWSGp/@hu-varada-blr.qualcomm.com>
References: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
 <20260723-clk_gate-v1-2-9549cad4d097@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-clk_gate-v1-2-9549cad4d097@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX3bzRQ6tHqb8l
 /9OjJMf8/IBfVaNtilWJKcYhxnDSWOWfjmP/0O9b+GXiXttIY3SpeqhYN0L2kdmMZNPS0kVxzQa
 hgV+z+6tC2bNRRxq580huJMmMyZ624A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX7w0FtKByc5tZ
 Ik5XGiVIh97ZYZLpTrVkTx3jyLKxppgYCWc7URPnfbLxsKP/w1nK8WVS/Sye+Nxw/lWG3oe++l8
 gJhPucRg8YN7X0MfBgKjMXmqJ4jUbKpeSCChR3HHBwqeQAC7dblIQXgQarxOKQRJk2NRh6jfzLK
 rEBTRR41EENHpZ0vYd1zefvm6ibbf0CAzGwq+MNriFWUdisMnBwsYGq8PWx0RA4oG7KQUFXFeoP
 HBcIyI4YPBgIwUOhJkVwGBAE/i7ZKGE8id3JIVqGw+NFjCX61x23kM9YB8KMsOmDxgBVisO/Une
 FWU9RwSgJlVU0b4LKbe1D+TzVPbJZu2M7Xg0Uj9rgQNKo3vik52zSyWN1hJalu/+VwHo2junyTU
 T2q/juxUkI1DRHL6lqBzBKCudVstnMTET6mDaqGh7drGMcTda3URRWBnY84TldpReQQM6fMDtq+
 o+yBv8f6AZG0NkX2Y+w==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a61d26e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IdOtJQl2682e3q17SusA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 5WgG8vn1tP5aBM6robQTssGRpKuAU7FA
X-Proofpoint-ORIG-GUID: 5WgG8vn1tP5aBM6robQTssGRpKuAU7FA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230085
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WkRA+mWhXHL4rmb1Uho6y4HA
 R9G+cmozATkGat7ZBDg=; b=NGdgL0tqbQfb7Q4qReVs0Kbzgoox0VgCrErntk4F
 wgnCXx5m+387u429ndraUA1NeC8m98BSkCgKrqz7WkfuNTurEA4crhE77s8Wau4Y
 IUoPiyed1yf6l+2dJEVditYVHd+lpw8LuQz0ASdplu0SEe9gnM5dIJeIaXjQ70zf
 MkZEeEz/l37e1P8OTDKzCS9TemP60nZwHafpK3TM5kb+eOT7ucI5vspUWwy86D0j
 XzTSneXdLqvf5RDrxWqQGwfSJ9jxQqZ0fKSTXOAaBkh0jeovwlQH3NoXIDvrNSwJ
 Ndo0dYye2KySatY5ASANGp+fpbx8UJ9oA/JdddNGLX6NGg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795757; x=1785400557;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WkRA+mWhXHL4rmb1Uho6y4HAR9G+cmozATkGat7ZBDg=;
 b=LWnSKe2JJZH8HrujMkTixals+r74egfmEL90OvvbxiFZ5h+dKLKRLoS5oclXk2B6LR
 1oOkVzmBtAaeGI/HyXWIqk//i4yubkSfF1RLjhRPLl5Z3uS1FsF9xrRfYw8orO8uJ0As
 3UHnS7lj5UeCOsNeKx298eHd2wu0e+Vk3BzDkyZvcpoB2+nlb2a4/9gZ6QTQCHLK/DaQ
 ruYSga8SkUKD2ukXEbPHWHVRZ45fSBXOlwIotgk5b2Yw5Xoztb+p0JJO/j0C7faPP+Qb
 GKy7/hqBydF9JyobdryPtT5MxZ8G3GlYD5l22tcs0EWeqtIn3lfxhhjhDPAk3wJ/oT7k
 WJBg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NGdgL0tq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LWnSKe2J
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 12:09:47PM +0530, Balaji Selvanathan via U-Boot wrote:
> Convert the USB3, UFS PHY, and SDCC gate clocks in
> the sc7280 gate clock table from GATE_CLK() to GATE_CLK_POLLED(), so
> their enable status is polled against the per-clock CBCR register
> instead of assuming the enable write completed immediately.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

