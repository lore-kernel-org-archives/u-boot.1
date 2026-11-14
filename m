Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AD606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c/pTarxY;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N0/hBl+n;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M1xbZfv0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79A7481B0A;
	Sat, 14 Nov 2026 04:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsoVIlmV8MiN; Sat, 14 Nov 2026 04:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67FD681858
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629191;
	b=A2eC/ux9SItoULK5P2HnSC8f5fvnJEs0EVVM/9ZoWESh7i3zNXSabQl089x2spaCchuq
	 +IZUkEPOEbl42hmNe/fYQAId2kpzJgc+QYHe1+gIgzMZ7lNSRSb93twGN+kJwAdRAJxkY
	 nuvDGl3EaJPfCsHbFMKlnY/g/3v4Gf+gvzaTUE0S3KdkZZTOxqQk8S9+/zTXsusbrxYKv
	 l/FfVywvpmX7suDzYRo21MkVI+CJhVyYjT29q5kWsHvx7pLQQ5Vxg0hUnbZ2gjXAYi1CV
	 yaHkLI7XZmrknHbOZ/JuCWW5CwdrgeBrXUFZKsB1+V7b7zHexkkscAyopS9dWvjAMew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BwFXg5EFpVdBdZnMvA1iknYm9qluKuNX9DcQq0/dOIM=;
	b=g85vev++UcfuYmYoCrn0deSQbLrHZK1/O5q7TTWPRz9T6kQUIYFNCo1SIBYmsJx7hCCB
	 T3qAqPCWd5A3D99Mb8Ah0e6hL+o/qUj58r4pg35pdlFNTlmlkQU4QGTlXemEarJ4FTuax
	 Y76dfpYzAi/LH8D7WLdWeOKGMebLpPylN3VNdHcDPAQRg+DKiKNNhaBttD+nc4iZsmHPy
	 EHdGK/QvCOZRAIqsniZhIdd77uX9aS5qSCfilN8Rxwa+Z6g/dDofapEVLIvcts96OgWOQ
	 uesuOLTB9Ase1ktAzn2EtvnQrQfJXZFdzFt37JuQeNWNO2hud4nUJd+2BHp243mrBGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629191;
	bh=BwFXg5EFpVdBdZnMvA1iknYm9qluKuNX9DcQq0/dOIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/pTarxYkxIMJFvOKU3kuXL7YFXNmPwm3x9RSv+VuvDxTcpD0UJ2Unbn0bNMQK9Q+
	 tryfWHLYsvxALV5yjD2EBXpX0ZbI2Jc8lKz+YkZ6qFx6vU6PhYHVPrOD6A35ps2LbS
	 1csqGGC5kg3j4zejuBlFXpjNXQ3XtkgIdrrE6HfLXCTiZotrCELnu1WvrKfdUuePG7
	 BRS/S63qJ8q4hR3EdqGZ+Etsqq3jmJq+rrkowjIXvVT2csPSAzPIDbFkZeT0I6rqIB
	 CyIyWvEHllju1P7ih73Rpy8ZwEEk1NuXo9UkwP6O0dCB/az1eUajRWwluCijgyVul2
	 I0Oy+gLT6k7fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67FD681858;
	Sat, 14 Nov 2026 04:06:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA33169
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 896114025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RpX7OMRXsMZm for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8AEFF400B1
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=urvashi.sharma@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=N0/hBl+n; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M1xbZfv0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AEFF400B1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3391847FF; Sat, 14 Nov 2026 05:06:24 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883848481B
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 05:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=urvashi.sharma@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE2ppK3200586
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BwFXg5EFpVd
 BdZnMvA1iknYm9qluKuNX9DcQq0/dOIM=; b=N0/hBl+nsQbkGGzWxESjG6Cv481
 szjJVZKvZRA1WhrBkD+g41ghpHUOAOpiLUQAQvjhVL1W0FrTRRvPbbQuImNZ/Su1
 RgOwYfCQi64DPhodsbOBlVg//LaFHlaj2fwI4EPiFISfcwghqMvfZCklwMAxpk9T
 dJQNJHEdf0JYl8wQ3wKaP7Zgi8Lox/yzOGw8L2BHW4zdXHJD69Ex5kuFmN/wD//B
 IQlC7s8SueAEUZ3FTGeLyzo+Z5ddDcBVqOXNKcFVAxUkaMGLPR0X6vVJqga7BkrH
 pakDXHTS48z5FZCtG3w5h/7nDWh4+k5bp3ldgkr3pPzs72uG1LMlyo+ELmw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxf7yr4te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so2032124eec.1
 for <u-boot@lists.denx.de>; Fri, 13 Nov 2026 20:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794629170; x=1795233970; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BwFXg5EFpVdBdZnMvA1iknYm9qluKuNX9DcQq0/dOIM=;
 b=M1xbZfv0KHsMbqT+eKjgvub0EWGuECWhxw/PZ94/IPBFUfKrD2B85/g/HQn+BwsHJe
 betG/oPdxQGyPjIBJrjO9gCdaJolkkaSo8XYg/PZIWpRt3Q6/CbyuSW72xh5sQxj7L5d
 mUYSHK21fbiPLdr5WwBWRhCsDb183FGmf2vVS+BqE9E1blfiSK/+SlcamXEyYYqXoYt1
 1m5H18Xx2WT+xZNMpm3Ky3GZN40vO1x7/Y+33jdsS+j4gFNdDe48WOzB8ZGokrIPcSFH
 sXJyGa7JjHS35kL5/9FabZM15Ej0lpK1OjS/vKA9ZTCzVJmrO+bbltEuR1sC9pflC38s
 n2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794629170; x=1795233970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BwFXg5EFpVdBdZnMvA1iknYm9qluKuNX9DcQq0/dOIM=;
 b=hpwTouAg1KDb5XqdhQt39JvCH71ox27NkY3dQjZIyz9XpJrl20zdlXgAx6z1NEEED1
 nRguCXvGsTR4zF4WHBr8GB++YP9TbiG14A7v0PXLvI3MQsM1Xb8/NClwJhPi7IPL7UM/
 xFv9pOYQooZ/LsXXFpOktCVagKNNYED9zk0EnQigjlj5xexnavwHc0Sjc0tx79cab5Fh
 tEGyz3OtKlCsAj2Ab8+MDSkek/IrLEP+yh4m1FptAsHyKLpqSw6Md+MefdUGqo+bqP+K
 AI6/oflZph1UaL6ZLPTMxBIkoIb4bn6Rz/kODaBbl+p571AJ2UPGeWzcKWRB5ZxNhiLk
 qpuA==
X-Gm-Message-State: APuU4Z+xAfgfQiTlFb8gK5PKMeDq0EJ538LvQnB6Kzs3h4vqkmBP9o/R
 s44SQUF2tR97zcusyBGIF3T1ZGVQa6D80MHx+fmGZCD5v/R33+wAg/eIVyNZS9mgXELGlIPM4q7
 1w0VrdWEuc26qvJacyj0W6j25Wgzy1E6vUk0OBNoHkO3Aw9JupzF58/WdeMrroj1f
X-Gm-Gg: AYBFou1eVSk0ufRIoGxtuzRmQfrUC5abOeSaTjRB4tg/XqfFTB4QBpA67y3q6Vwfjpo
 DPhl1v60kI9VkO8ola560C/boJ0jZJ3HOlR8f6NV3WKQY9IOZ1RJWXs3pR0cFWar9cXNm6nLNrj
 PmpIsx9CEuXhQMoZErdW81qercrtYKRbJL3MfP5fARpvNCPIwJ7hGoO32R+oFROv2fdzSP1qjme
 y7ydobzMrOerLOa42TJBSe5UMKFkUWnVnL423fdINybX56pRR+vLlwREOfMADuVwjM9TLgyLy+r
 hpBDT7kvu9utoMfouf1y5N5zq2gFrtbzz/yOegGQWDTZKFkIFtHiR3sloum+vlk/aN6WPRDJQgj
 ttUBggOfC7eYNlQTHuNlWUA5OWKoJ+CHs6BWa3TkVorEZC0llkJMy/0Z5X8PLcPsOahbTm2+1Zf
 vnxMryfIJhqx6qRfdXQdAef++BiOqs4Q==
X-Received: by 2002:a05:7300:c386:b0:36d:e4c8:8f04 with SMTP id
 5a478bee46e88-37967506f25mr4402970eec.17.1794629169543; 
 Fri, 13 Nov 2026 20:06:09 -0800 (PST)
X-Received: by 2002:a05:7300:c386:b0:36d:e4c8:8f04 with SMTP id
 5a478bee46e88-37967506f25mr4402938eec.17.1794629168793; 
 Fri, 13 Nov 2026 20:06:08 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm11536621eec.16.2026.11.13.20.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:06:08 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org,
 trini@konsulko.com, digant.shah@oss.qualcomm.com
Subject: [RFC PATCH 1/3] blk: add scatter-gather read support
Date: Fri, 13 Nov 2026 20:05:53 -0800
Message-Id: <33eae57ccc3fe5d92f35daacd4273b039fbbf138.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
References: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX/P2sHZjYgau3
 5bLwIx8wiM9jv8ZQLEEQevOmyWVPYySTAyccPmtgHiPjvtZT+AAgpVve0h/X4IZwX/shUQQBrLg
 A5tJqVVC9ttpx207upnvhPC8yRvn8qI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX+qqHAuxc76a/
 jvNwY7XMb4/2IdkP+WdXyKhceCqdoZ0KwAWXY1tu5LldNyIv52aO749GXNlMbXyUVzfPbS1g1XF
 ujt0olq/Cu1xS1eJF4wgdVuxfd+rRVwPDjGbx+A9hUAzhaVYwTK/0nq3RV8hl02v8cOQ8Mc7afY
 v5iSzftT4lO+jOnHq8bKT4OR1p79yZojoIaKiBprwbrk5sNAr3vpe386z5drspPV/Rl4cLzBGAP
 EuORcEVunl6ZjqD59EPPlD8fjkNq429DJ0k4ofq25BO56wXpVuemUFD4IP7zf+Q4hai2oNC/QD2
 hShWLRVNVJHbhnFMDkL2SCHDoZZYgTfPgH7ZpQyecddYZpFcJC9rLPWweWWmL4ntCFksX52W0Lw
 BkCUvaya5UPFmj/WPr4w+H0F1cdTrwfCcDJ+CuuerJ7JNCocy7HXO8SRV0699GWMtib4HekPF6i
 BBiJT2eOBBldkr3SJAQ==
X-Authority-Analysis: v=2.4 cv=HLVWhYtv c=1 sm=1 tr=0 ts=6af7de32 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=k1EWUMBCEO-BbWFXQrUA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: F01MZl9gSzFsRmn8MpGJbBM02mYuEfbG
X-Proofpoint-ORIG-GUID: F01MZl9gSzFsRmn8MpGJbBM02mYuEfbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140016
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

Reading a contiguous range of blocks into several separate buffers
currently requires one read request per buffer, since the block uclass
has no way to pass a list of destination addresses to a driver.

Add an optional read_sg() block operation which takes a list of
destination buffers, described by struct blk_sg_list, and a
blk_read_sg() wrapper to drive it. The wrapper checks that every entry
is a non-zero multiple of the block size and that the lengths add up
to the requested block count, so drivers can rely on the list being
sane.

Drivers which do not implement read_sg(), or which reject a list with
-ENOSYS or -EOPNOTSUPP, fall back to one blk_read() per buffer.

The feature is guarded by CONFIG_BLK_SCATTER_GATHER_READ.

Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
---
 drivers/block/Kconfig      | 10 +++++
 drivers/block/blk-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++
 include/blk.h              | 61 +++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index adf338ab00c..93844f5017a 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -82,6 +82,16 @@ config BLKMAP
             boundary. A common example is a filesystem image embedded in an FIT
             image.
 
+config BLK_SCATTER_GATHER_READ
+	bool "Support scatter-gather reads on block devices"
+	depends on BLK
+	help
+	  Add blk_read_sg(), which reads a contiguous range of blocks into a
+	  list of separate buffers. Each buffer length must be a multiple of
+	  the block size. Drivers which implement the read_sg() operation can
+	  read the whole list with a single request, otherwise each buffer is
+	  read separately.
+
 config SPL_BLOCK_CACHE
 	bool "Use block device cache in SPL"
 	depends on SPL_BLK
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 73c24fd9176..024727431aa 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -467,6 +467,73 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
 	return blks_read;
 }
 
+#if IS_ENABLED(CONFIG_BLK_SCATTER_GATHER_READ)
+static long blk_read_sg_fallback(struct udevice *dev, lbaint_t start,
+				 struct blk_sg_list *sgl)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(dev);
+	lbaint_t blkcnt;
+	unsigned int i;
+	long ret;
+
+	for (i = 0; i < sgl->count; i++) {
+		blkcnt = sgl->entries[i].len / desc->blksz;
+		ret = blk_read(dev, start, blkcnt, sgl->entries[i].addr);
+		if (ret != blkcnt)
+			return ret < 0 ? ret : -EIO;
+		start += blkcnt;
+	}
+
+	return 0;
+}
+
+long blk_read_sg(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+		 struct blk_sg_list *sgl)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(dev);
+	const struct blk_ops *ops = blk_get_ops(dev);
+	struct blk_sg_entry *ent;
+	lbaint_t cnt = 0;
+	unsigned int i;
+	long ret;
+
+	if (!blkcnt)
+		return 0;
+	if (!sgl || !sgl->count)
+		return -EINVAL;
+
+	for (i = 0; i < sgl->count; i++) {
+		ent = &sgl->entries[i];
+		if (!ent->len || ent->len % desc->blksz)
+			return -EINVAL;
+		cnt += ent->len / desc->blksz;
+	}
+	if (cnt != blkcnt)
+		return -EINVAL;
+
+	if (ops->read_sg) {
+		ulong blks_read = ops->read_sg(dev, start, blkcnt, sgl);
+
+		if (blks_read == blkcnt)
+			return blkcnt;
+
+		if (!IS_ERR_VALUE(blks_read))
+			return -EIO;
+
+		ret = blks_read;
+		if (ret != -ENOSYS && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	/* Fall back to one read per buffer */
+	ret = blk_read_sg_fallback(dev, start, sgl);
+	if (ret)
+		return ret;
+
+	return blkcnt;
+}
+#endif	/* CONFIG_BLK_SCATTER_GATHER_READ */
+
 long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
 	       const void *buf)
 {
@@ -520,6 +587,14 @@ ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
 	return blk_read(desc->bdev, start, blkcnt, buffer);
 }
 
+#if IS_ENABLED(CONFIG_BLK_SCATTER_GATHER_READ)
+ulong blk_dread_sg(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
+		   struct blk_sg_list *sgl)
+{
+	return blk_read_sg(desc->bdev, start, blkcnt, sgl);
+}
+#endif	/* CONFIG_BLK_SCATTER_GATHER_READ */
+
 ulong blk_dwrite(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
 		 const void *buffer)
 {
diff --git a/include/blk.h b/include/blk.h
index 8d1b70cabd3..d5176077300 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -199,6 +199,28 @@ static inline void blkcache_free(void) {}
 
 struct udevice;
 
+/**
+ * struct blk_sg_entry - destination buffer for a scatter-gather read
+ *
+ * @addr: Destination buffer address
+ * @len: Buffer length in bytes, a multiple of the block size
+ */
+struct blk_sg_entry {
+	void *addr;
+	size_t len;
+};
+
+/**
+ * struct blk_sg_list - list of scatter-gather buffers, filled in order
+ *
+ * @entries: Array of buffers
+ * @count: Number of entries in @entries
+ */
+struct blk_sg_list {
+	struct blk_sg_entry *entries;
+	unsigned int count;
+};
+
 /* Operations on block devices */
 struct blk_ops {
 	/**
@@ -214,6 +236,25 @@ struct blk_ops {
 	unsigned long (*read)(struct udevice *dev, lbaint_t start,
 			      lbaint_t blkcnt, void *buffer);
 
+#if IS_ENABLED(CONFIG_BLK_SCATTER_GATHER_READ)
+	/**
+	 * read_sg() - read from a block device into scatter-gather buffers
+	 *
+	 * This optional callback reads into the whole list with a single
+	 * request. If it is not provided, or returns -ENOSYS or -EOPNOTSUPP,
+	 * each buffer is read separately with read().
+	 *
+	 * @dev:	Device to read from
+	 * @start:	Start block number to read (0=first)
+	 * @blkcnt:	Number of blocks to read
+	 * @sgl:	List of buffers to read into
+	 * @return number of blocks read, or -ve error number (see the
+	 * IS_ERR_VALUE() macro
+	 */
+	unsigned long (*read_sg)(struct udevice *dev, lbaint_t start,
+				 lbaint_t blkcnt, struct blk_sg_list *sgl);
+#endif	/* CONFIG_BLK_SCATTER_GATHER_READ */
+
 	/**
 	 * write() - write to a block device
 	 *
@@ -287,6 +328,8 @@ struct blk_ops {
  */
 unsigned long blk_dread(struct blk_desc *block_dev, lbaint_t start,
 			lbaint_t blkcnt, void *buffer);
+unsigned long blk_dread_sg(struct blk_desc *block_dev, lbaint_t start,
+			   lbaint_t blkcnt, struct blk_sg_list *sgl);
 unsigned long blk_dwrite(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt, const void *buffer);
 unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
@@ -307,6 +350,24 @@ unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
 long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
 	      void *buffer);
 
+/**
+ * blk_read_sg() - Read from a block device into scatter-gather buffers
+ *
+ * Each buffer length must be a multiple of the block size and the lengths
+ * must add up to @blkcnt. If the driver cannot read into the buffers
+ * directly, each buffer is read separately using blk_read().
+ *
+ * @dev: Device to read from
+ * @start: Start block for the read
+ * @blkcnt: Number of blocks to read
+ * @sgl: List of buffers to read into
+ * @return @blkcnt on success, or -ve on error (-EINVAL if the list is
+ * invalid, -EIO if the device read only part of the data). This never
+ * returns 0 unless @blkcnt is 0
+ */
+long blk_read_sg(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
+		 struct blk_sg_list *sgl);
+
 /**
  * blk_write() - Write to a block device
  *
-- 
2.34.1

