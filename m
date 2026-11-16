Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319760A2627
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=drz9UAX2;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pyUAJwEE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=imu1rTzN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D933180E04;
	Mon, 16 Nov 2026 06:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aGtcYDWbQ2G; Mon, 16 Nov 2026 06:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36BF580DF7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794810599;
	b=dtXohJePsPHba3Og/Th6UtW0dhNQ4MUTHW6B+23X8KModjNQoEBTRqkzakfUXvJQm7pC
	 x80x6k847ByeysHRwxKRheQFs8PV5W5ev6HUp1djXajLiMymB6GhS/uS/53rkJlYZXHH4
	 0zEvmVcUGJohEWWU4dCkkP1qZsdJXVa0kA6ilTjVljyMc5fhQ6oL4QC/f1jqzatVXKvRl
	 n41F0d1II6KimP/4Z1BDjWKtcFa1CrR4X3nKInJpKCIAp7mcE1D/G2Ly9Eq7s6ejsyrWr
	 yFVaLWitz2BLatJMis1c2ZsC25yNFg7nZ9p2WXRtMcY0ZPyIad0wnG4JD4P5xWsaLOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sdE/3lWzgqpH0npl6ZQW/w7kKUEHyT0Sw5VL/hBW7MI=;
	b=P1MZttMxOl5P4sQKYJlw8plwPvi1X97JMV7eD+96TxZZG2h6rU5D2bTqJ9m2ifLnxAsT
	 UijWbCuZeWqVBAwo/TLufqrFJwMJb6kPadRxGijNsLJD4X/Bdr9X5wRh0srfiGFH5u0hl
	 qHtFT/Dw63VTGy3U4CD7nb40YRjrtH7oQRWQuv6Gh+HKqvDWo5Up0gqsIlAHUI7KWtBhF
	 LoQ4v9jCdeVeXHqrFbRJ2jXL5O64LA/EcszSzbdePJUd1Oe4iZLUfccZnp8y3ZBy67v7N
	 9rAEdDb4LhT3WTYiO9+cP127xMvtfPyi6KUE4S1GEIdpGvL5HokZy3JEsPFfqDmJz1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794810599;
	bh=sdE/3lWzgqpH0npl6ZQW/w7kKUEHyT0Sw5VL/hBW7MI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drz9UAX2it/SkTsqiYwuFATLiLQvJZGZjCQ8lZl+7+K6bGSmHw28tPYShiQFxnUqr
	 6XI4PeyuSu+gcW99NS7sw1SVftTfMFWWHebb16/Yhvp8nlQSC826d76zZ6qtCpciPr
	 GCx9B9NGNbeuw7tgg0wGiihQB4DxKntcRJrD2Dx1tmHIMq0/l3rgcujIcePQXq/Q3P
	 KX1nGEGUEHUGPfn2hNEY5ipfT/uzehawGDRcYdx0YjDN7O5j+PO9/0Nlit8MWX2XFi
	 Rwq5LLKQLTRYPDv5jm+kEZT6S49YJtXrqmnoXNQnvP0uwWMrHHWF5JM5S6t1iVmbkW
	 FlOTjnhQj+SHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36BF580DF7;
	Mon, 16 Nov 2026 06:29:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC153D7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE16F4006F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OScCKFcLtEa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 06:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E2BF40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pyUAJwEE; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=imu1rTzN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E2BF40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG5Miwp2233583
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sdE/3lWzgqp
 H0npl6ZQW/w7kKUEHyT0Sw5VL/hBW7MI=; b=pyUAJwEElTzeQLEMDazMwOoWv6d
 36qiKvd30APlGnSLGr0swZAtsG1ugcmP/3RWNwgaMrr1af8EmJJCA9vY/N/h+c5X
 DvA1OHgaJ0dT3hQGRgn0bQf0f2r8xbTTblNcfR7NCzVvBYA0CQECcHLOppAr1gmu
 kPPvip3RjvUEvR7e8HGRhvGDo2dkLDDzb0E6y6PI5H/Jop5A0HSzWwEHsml6h4u2
 gZyY8wd00+B/9HIfO7I4gOJqoNdhKUr0WNUPfufWjkRQGdz2Cp9MTRux7Bd9y1Iu
 U218GySfhj6lIj1JZX/KQsgjlB9zdRl6l2GMEFXGjV2CW6x6jATQFBDi0kA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8w16k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a3451ea93so3198924eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794810594; x=1795415394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sdE/3lWzgqpH0npl6ZQW/w7kKUEHyT0Sw5VL/hBW7MI=;
 b=imu1rTzNxqTgZbl5umeAUDfJwHJr9ZGCyD6PFcnsxJaX6r5BzIWE6Zm5h67/KUzh90
 MDJMr54jSppDD0ag7zAKLHS6DtaJQ5Ecloljpr5Frpn0+IJkJA0gudGMj9xNmSS6N9CO
 HDhuni9mvzBlaSmzuAvoxIhMSECuXp14PlPRbb+dV3xWpwjJknzuT3eNcY1JGNMDDKph
 BhQcqFWeIBYCixLd4hirxhG9RtMvDPzvOEFVD3w4L3CSZMK9kKU71TdESOhZ5qmgHDbq
 6hEvffY5wH7rT1SPuU9HUW6IvCCSvLoac95gkaVacp1RUfic0nHAxKNKG5AQ19g/OVpN
 btVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794810594; x=1795415394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sdE/3lWzgqpH0npl6ZQW/w7kKUEHyT0Sw5VL/hBW7MI=;
 b=nmLPJZUrrvM1fVPf+r74nsWDWXEs79EqLK11mDBOlpdo3qKcOLRP7GlEieyHaUd32l
 ImSUNiC7NewlL0br9lMN8fIK+rJt6KdudYjP5IL2FUBBmfd2wExWAHlg2y57Y367Dl4C
 srmzu/4zOY0I3XPiZPgZrM8NLJsWrWqb1Qwh3QYuD37DKhfKAfauD5ElGmk8yVNCCJgX
 F6SVwlSYJz5IIPS+g+9Rw8JqRvZk1p3TVvjB/r319FH5medvkP0ynOol0hNN/5ibaJ02
 v6cqe+WEFMGpQcloz4B7Vwc9tnnVfET5nNttyWo474UUdden2zCRltA9uVlO76Me+yzt
 LYqw==
X-Forwarded-Encrypted: i=1;
 AL+hErFIjvZqLMmX1MagCec6TdtE1Z9OmU60Akge00OJdfi5g3soo4Sw2tqLrxIgJJjgS6TJUtDAQ8w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8jHIBXsLAxxdAhfkgiFXawdLXFtsNxmW90ROTAUe556TIOUxz
 bsdOWjA4HSIAlLHc4V/R7+JawklwBaCP7PFm80NdufFgUTwgdp+BZvT8r4qFV/nBh+hLh55dLBV
 /tTbitFs2LQhMZGlGJhMuy/MUD5J0QHXCl4mL5IXWrpvEkfDIENLR4aKRA8fFalv6gGdJRzs=
X-Gm-Gg: AYBFou21iU+xVkkjWp1QtE8k7kP6DeJfn3xsHzX+LfhyUS2aBhZzv48Pagv95k7VVwh
 KqqqxMjP3xv8UIdrRFl1RG7wzQonms7VmCMAGz9CKNcg0g4YwnqdBzt3LTp7RDkBHVLROItsLLy
 QsMsphSdLNQtpTQQyk+0yX+2zFD72EbBXtY84Xjqe1JRzyBJlTJkr0vf1sIhjgBj5WzBSDbmiBz
 6GQn+jRID4n1xdjzLecZNdNAl7YKQKNKIVVxMcNWreqU7O01lCx79u+Q9Ww75jY6iZc8BDoxyh2
 itEY1+R8Snxan6x0y56SQlU43F5y7WMEi+SmsszAgHLWK5aM0Ry5rwPUzSSvE4je7/aLblSvf3R
 Erp3XdFzJPKBjHFfzswDU0rL4FSigcvpPvTDYCA0drrDD0/XzH6+qzoj9Ju52yEWgtDp54S2cx2
 NyASFYYl0VF+goFNWeH6Xb+sy4Sx76sv3kt1+k+9L3jv/JUWC22mKCbKmG3jxIGOwUWoo=
X-Received: by 2002:a05:7300:85:b0:376:e950:873e with SMTP id
 5a478bee46e88-37965f9ad51mr8994104eec.12.1794810593442; 
 Sun, 15 Nov 2026 22:29:53 -0800 (PST)
X-Received: by 2002:a05:7300:85:b0:376:e950:873e with SMTP id
 5a478bee46e88-37965f9ad51mr8994081eec.12.1794810592873; 
 Sun, 15 Nov 2026 22:29:52 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f01d68sm30283963eec.17.2026.11.15.22.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 22:29:52 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 hongyang.zhao@thundersoft.com, sjg@chromium.org, visitorckw@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 1/2] configs: add generic efi_secureboot.config fragment
Date: Mon, 16 Nov 2026 11:59:40 +0530
Message-Id: <20261116062941.2829602-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116062941.2829602-1-aswin.murugan@oss.qualcomm.com>
References: <20261116062941.2829602-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6afaa2e2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=zQVTCww1vdNx5hhRfzkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfX+bS/nE7Yqg4y
 cbvUnLqrEE+JJPwmJDZ9eG+8HwTYK5CZga8qt3V/kKZrxm1v4U01xz/hvsdL5ZwTH8/48uAwQ7l
 rjqXkG2tUFKBt0VxtTkP6dw9FuaiEjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfX6Zd+X0vgaudz
 52ONyWDo8g8mXik08lr+t9cGy7b10t4Bhwn+/+ZckJeyqbh5PakkHa1wr38xcu62RG8gVu94JM8
 zHa0dyRDPl2Wvlb8sP3A3bOgU3mJgH36+8sqiMlj1tzruBadwO10tpIzx48k9apjhy9SOl8ja0Q
 AH9LBquDtPzN1wM4fdibbfHtF+N33lyKE6IPcVnhQixmbmy9Sd3PvWRPi3KKKtMgEfTfZfzhcjz
 yPSZXpBO3CUUmuq7YTDW2GCqE6VHmXoQ/IX3Q6KzEugPKl09weWQdb7jUwXdwM83h/igpYFdmRn
 V9GcJx8u96VGkN/Ga9QZwZEKK/+eQTHuz3aoXGRNM7PVJCeANyF+ZsKQFu8WyprIm4P68XBbX26
 FwdDZ9k6T8e66aJCDgwIu+u/FPWTwSSa18tFhswdgUBwbBcShq/w43dbM2G89SVa4EBTnWoygeZ
 G3avA01giOTrHS+N/pg==
X-Proofpoint-ORIG-GUID: 0HPJaBBrRvWIaarr0k6QZ-j0Be81puW7
X-Proofpoint-GUID: 0HPJaBBrRvWIaarr0k6QZ-j0Be81puW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160025
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

Add a generic configs/efi_secureboot.config fragment containing the
Kconfig options required to enable UEFI Secure Boot support

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/efi_secureboot.config | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 configs/efi_secureboot.config

diff --git a/configs/efi_secureboot.config b/configs/efi_secureboot.config
new file mode 100644
index 00000000000..088dbb9d02e
--- /dev/null
+++ b/configs/efi_secureboot.config
@@ -0,0 +1,8 @@
+# Enables EFI Secure Boot support.
+# This fragment is generic and can be applied on top of any board defconfig
+# that supports the EFI subsystem
+CONFIG_EFI_VARIABLES_PRESEED=y
+CONFIG_EFI_SECURE_BOOT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SHA512=y
+CONFIG_SHA384=y
\ No newline at end of file
-- 
2.34.1

