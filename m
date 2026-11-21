Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6753606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qvbKag2v;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XdIONIGv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kll8VeG7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95C4481672;
	Sat, 21 Nov 2026 06:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceKFip0puU-F; Sat, 21 Nov 2026 06:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF7D18166A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243236;
	b=VIGdxQrD3R7ZTA/GTsSKQWlmffAXn5NBTaTpIKw+tCR/T6IV3G1O2iJ3gf4RPHdqE1Gn
	 /X4FdXRQZ18DPof8EEsDTFCHi79TwfjKbfxZJbi++IUvXgSF6z1Lfi+lJIFxC/3K5y8gx
	 VMwDwqSeHzSIZa8l6ek/ds8tTDz9cW5mp3d0IJ/ZWPw+y5BaP0ri3Vumwgj4ak7NQiUS6
	 AiJrwxl7B0DAtnxc5N7rrcCxGSEUFrIxs47oidtmD3K2ql+jOHJbQ+p2cZGTnLyNhKR/y
	 jIAMhdIpog/QA6ymcxTe09JDClEiEOS4JyJ+qSErQXiVdhljdMgmuTvVLSgEhDr+Wew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=13bq8Fk0fLUBkT0mEqO5k1kspnmN6HubJN8zvVozAPc=;
	b=WTDuce1pKWgU73Ev5IKSwxwJmgTLlAbBJsGnn662DM9LPK448G+TSOZ0814b5fmcBoKc
	 s/mJAJ6Pwx8v9rO/uaXo80pLmn2RIApDOWojTu8EPBjTl/c9HTi4pGWAVXewy17tUTeKX
	 G38fFbkucay+TbLc83JeRW4WK2CHSyS8HF8vj6c9W7Ou9n8dzDDCxT+ZEZKogiEAbCAwK
	 8bd46U/IHbkKJgE77EdRFjTsYbfzA/tqqvloo4vWeXlw3hy7yes5Ai0wl8ks1GD94BYsk
	 yA9iNs8Qo7nFoRFtYvsI5I7SF7CaOWsOoMROtr0MQzlbSBWyh4hpPn2Nx/nH6OeWZNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XdIONIGv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kll8VeG7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243236;
	bh=13bq8Fk0fLUBkT0mEqO5k1kspnmN6HubJN8zvVozAPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvbKag2vv5dTPZdbxgHYO11B00Zhxow+783W6UZby0rvY5bT3uYy5ROboEBsolNaX
	 zL1XG4X3x+2j9yZEllXMkZhEfnYpb3AI2fc1tjJ1SlQaSvo4Lxslb9IVk9yFw8BvG5
	 aJSoBDVdJSE99dEBlVszTQuLs3WVdlrmE1efSxh1eDcgEjce+USezPK06eTvVIZTUz
	 d6mOsyHYUe9XFnhRlFnkTYhnh6kufQdUk+HDNUXMDW/AT5OgJ62GHT25h3sfatmu7U
	 Ni0ZwUSkBKmtUPt+H5dFih7mvcRRH+pcpFbUQtZwIUXe3RNN0Gx/5Z3///+r4U8lzE
	 9YsE/Ed0FWYwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF7D18166A;
	Sat, 21 Nov 2026 06:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57E2E971
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49A118166A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDZJZ7G_pJnH for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2EF581669
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XdIONIGv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Kll8VeG7
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2EF581669
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4C5043256442
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=13bq8Fk0fLU
 BkT0mEqO5k1kspnmN6HubJN8zvVozAPc=; b=XdIONIGvjlPb9AsGhzy8MQPXPxw
 /GkiJzQg+VL903puy5kXICU5nNssntJnRmolerQy20cS+RJNPLCR0qRlksHNzwT9
 vAU14wnL24Pl/TpN7X6aamqNoMo+te/RgyPGNgu2+WHJP8h9An5avE0m5bbaheHi
 G4D8A56rXmDotjB/Cb6XptBoGaOQbOP0/OtghP6lTeDQZVn+3nJJgIr175hnqNRe
 3hl3l54v7mKRtXqSlAvFzhcGYRiiFfKnNQTVBAXgH0tFAVo4SCL/WfZJrT0Pb7HD
 RG1/G9IE7BjaJGuBEnIU2ADqP7aR2f8KF1hIhKoNt+pWfq0D3jM8GKQHVzw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j342gg860-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3854627c1c8so2470671eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243230; x=1795848030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13bq8Fk0fLUBkT0mEqO5k1kspnmN6HubJN8zvVozAPc=;
 b=Kll8VeG73cvHigAd65TL6kF8uoG5/svTxCPROWeAL/uXkzAHeAZFvrJcHR3XlMImmX
 K1qY0qAqMRcLNDmQWgZLH94GhDZLfrG0UAlyqUA5OX4j5UWScGgC/gfnCW7Z8yP19uSk
 s6I1pKCF5OPINQRle1nDHYfcCLLk+4UT43pmAQsSUJy4HwLxJMmEmjS6gBcWTcOe5ymh
 BMhd0ZgZPNM764lg4VX2vel6rjxPPInLdZq0tdUwbZ99IO4AdrJ3gOHXTp2crqacKIjr
 Vc+WjVAKzMobq+RTeZNv0rONWXtFvLs/US2SR0bZemaIEijRkjH6G5VkwN1UVrchekLT
 pxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243230; x=1795848030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=13bq8Fk0fLUBkT0mEqO5k1kspnmN6HubJN8zvVozAPc=;
 b=RgbSwBKQS6oHiru6BABVnSgFCfXrIdsKfHcCOtmzgrBcI96sG7lxtBQ1jKchtXFQ5D
 dwZkZOFtFwYueLizTrCih4LW7gusrp7p38sGm7j06I/oJS4D05RlaN50L4zPxk4aZYh0
 9RFPsZrcw6/W0ASvjxcgCJLuMGfyBLltGCACeyCFHEpZYKlaUHagshIW3XqgPWAboSoH
 yF0kgv8ROLn45qhn1Kjokz9sB6DXRlDzAsEbdvCz+9ngDaJYAAJ0emRq43xKhpTY/odZ
 5ooo1jf4mLD7P2AtfIbUQeRK2kAZ0AN1/wvJvM2w/rJZN4IWehf1DdnVI9gQ6vkAfv0R
 t6fw==
X-Forwarded-Encrypted: i=1;
 AL+hErGUbil63KmK4rrhbvT/3msHr42C9zWIprTG9G0Zi9nwuXsxQE/T43aWOevr96Zzc9baEzWe9fw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9+F3QyQbowedQkuPiHU9C7Ci7y/j5LFk5JDYTMlgjCS6L2KySb
 3wIKqLIr3R7oY3ysSKxTNkE18aT5uArk75/HybTCIQUQuz759Ri36ESHA8LXT92d2BaVJ6K8CRt
 1o95wwuiFQMeIRQFVNtJrZijHu8ZTmLKdAmG45v0VJZ+nYxd96yTtyYZVqmkw7exar03wY3Q=
X-Gm-Gg: AZFdTZe1m4SzUGNCwM2ACLLmD55y/dfVUxBBWL0bhR0QyGV63m7qXwtUT7jN+48jcWX
 zQM0CRFdlptbxklALiuxTuOK8cb6FnF11bkdXh9zHDBIMY3PH5vycyid6C6wwOk/7sQxoor2jLa
 C8Ud3+IPyIsPPcCHvV9fK8MW7dLu1j45e6O13PPTV9W8yATinc7DkxIkTm3ZIzmwuT6nSLETgf0
 JnVMq0628xQFFpFJlVqDjhmnpI58nshDSHLS2bKS8FtpropCQHVzn4JWV4wbD2jwU/QtzfuIopv
 7cEnZ6ROk2aSrUymdpNft7dpbAVs3CoB5i3Sf165LVTtW7bOmmmqAnfgVUdMgqUpFbqQAvjkJPf
 jBSnFl0DV1wFCxdZE+cclgS65FnzMHkphFVwNfpGl8lFiDzlSx2vhV5va7BIdBVCKn1uCbsB1g/
 dL
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-38570b34fecmr5591537eec.41.1795243230183; 
 Fri, 20 Nov 2026 22:40:30 -0800 (PST)
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-38570b34fecmr5591499eec.41.1795243229622; 
 Fri, 20 Nov 2026 22:40:29 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:40:29 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 jbx6244@gmail.com, dlan@kernel.org, anshuld@ti.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v2 2/5] net: dwc_eth_qos: support 2.5Gbps link speed
Date: Sat, 21 Nov 2026 12:09:16 +0530
Message-Id: <20261121063919.3313168-3-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+5OUOYi c=1 sm=1 tr=0 ts=6b013cde cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=QFJn9Ik-wN-IVgwQvG8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: LPeZR9FZD6b_c2b8mEjsnzA26o78qlgC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfXwLw98DrOklNO
 JfSTf5nTojPJ6poNdOPEKxTaOC4/FvoZ2dXXKY5ZkPvlC1zGOCi0omVThLaAEZqVex7GUxWi2ih
 AZgFC3DkMCzvFYJmxwjdWw1zO/P1aFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX7e1RJA5jJAVM
 I7GV0kDkZWxaVczrFYMrm65FrhXph7NjwbkP8qI+vhy3QarwtHbTR3NnEhhzKLkR5ln1ELP2/V0
 ObDaXms2Z6EUO4IhW1nOcicTotuepBKszRXX8iDP84KHkp9fW0WxFaNRPcW09Q/jOpFHzMsCQUs
 S3pcqvBLtFak8lnAUruAQF09l51nJKefjgTPxBepCka+IS4pfgINvnzWMP7i4O7W7BHHCRS9QMq
 JdIGlE95YJeDTgTnymNUII++gZFkblmblfr51+HmVkHQP0cQmzeDfiILw5vJERZxusA99yZXk4G
 KXYIpZXRBRkqi8tQSD9ZnwQ/0SrSakeHa1Xv6r2D4mAixDQ6VHi1ccERWrFHyiQxAzLe6vR2bIr
 4h/lJZObqkI5UqXMBkbo7MN9dwM9LzttHCoqAFrYQ5LPgFJVFwPo8RQ7oJ6zEw0cZ5JRQ4RqOBa
 PyB2ff+sWFzgwUT4PVg==
X-Proofpoint-GUID: LPeZR9FZD6b_c2b8mEjsnzA26o78qlgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210026
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The MAC port-select and fast-Ethernet speed bits use the GMII encoding
for both 1Gbps and 2.5Gbps operation.

Handle SPEED_2500 in the generic link-adjustment path and leave the
platform callback responsible for configuring its clocks, wrapper and
SerDes.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v2:
- No code changes.

 drivers/net/dwc_eth_qos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 6f158202124..de06bb46151 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -557,6 +557,10 @@ static int eqos_adjust_link(struct udevice *dev)
 	}
 
 	switch (eqos->phy->speed) {
+	case SPEED_2500:
+		en_calibration = true;
+		ret = eqos_set_gmii_speed(dev);
+		break;
 	case SPEED_1000:
 		en_calibration = true;
 		ret = eqos_set_gmii_speed(dev);
-- 
2.34.1
