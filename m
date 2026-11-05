Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E22606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LXeXUuuI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=md+SowR/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eGK4tOCC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB0D560886;
	Thu,  5 Nov 2026 18:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYeEtyYb270G; Thu,  5 Nov 2026 18:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38C2460833
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903224;
	b=R5e4gOcJP+X6uPQHKGllKMG2SkJRWafFivfqscmDpB5BCyiiQArrLfmQcxfLyYRpvtd+
	 U3u01D13UO9rk0bh2WkFQIN0bwwmXYLBTxm2KrnnHUptk/I65M3ybhDChDYYXy4336ipm
	 0aXs/TzVG8YA66a2IRd0AblIJ0FoZ5WAjQ0F6elanpeS/IwVSufVASKxMuHwxmoApbdYm
	 dq4e1rM394D/+oKmjTp2YPXIwPl/VXvszUaxnvDSdAYSk8qM3wzbiaDhASfAk+HvIpQ3U
	 73zizzU6OMGUmcQzO2p9kpBu1bO3iLypWyboX2Ex0McQgmnqhF6jf8PRFIj7xty29cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OUm18lzpQTXVBx48H5WNr2EYOkh3NZFuWkoeIJop2uY=;
	b=K3Fq95hOWky/4hPuXlaB47w1/R2ul84MBiBuAIvZ6OaYPiwEYH0LaSmP6CJzuNCrDFkw
	 Vml3OEV/M2X7ZpfzM5iYoNePm8DmwgivieXSUzSFBsavKtS7i+4z4nIWDEXaABnFpX7r/
	 79GkFC27XM94SoZQoZSMZHnW2XdHDN3+0vtRnu4lF8lrYRZKyCZxR+yPGPThiecdh93eO
	 +jfTKKwUku7wJOFeoq3+WJeYG05XZ7gVp7ZAbKm8Ttl93hx6r+bdpGhlMzc34DoNpQvXs
	 ocEoLTXSFr02lbTyDMZQQ44docYEa50KFawd/S3AXBC5KYuEdYrN9B4tsJC0T16oEfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903224;
	bh=OUm18lzpQTXVBx48H5WNr2EYOkh3NZFuWkoeIJop2uY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXeXUuuItoo8+kMBlAu1iU+LWd2xtuj82QhEEOus+o4bM9xZ2wIAiNdzPe8BUVzhj
	 kcS7IGnViGMdwDw8/mtnnbNlhk0010A28fx2dAp5nK0GYeQDdgcjLBAKA81sO7KJUQ
	 OM/c9xlkDUoXpa0il7sApcxg5XWyFezSDKK5a2o/PD+D6y1stNQvXRIZaLJVn5LI4K
	 v5PyljBfhFqLwJr0Q2Sg5A2RGTqrIY/2qfMo5PO0B+3HitiKHxDXX0mYkwf/T+0eo+
	 /yr/YHAbmi4bhPAZgSXK4//x/JT6nsOwJLSyLwoaXP75mbrWbZc+uTXqeeJ36XqUFD
	 Eupab3H0oR31w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38C2460833;
	Thu,  5 Nov 2026 18:27:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3351852B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24D434084E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EunVf_JQDL-l for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B1BA40847
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=md+SowR/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eGK4tOCC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B1BA40847
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeK2f2090991
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OUm18lzpQTX
 VBx48H5WNr2EYOkh3NZFuWkoeIJop2uY=; b=md+SowR/AkK4KxtNjfKlLLC9vp6
 NYgl39S1/9Nf9cgqBqrHjzvyz9WclRM8wPsC2I2v4LhOPgRsDsBDwZW4MGCuGmDt
 c0A3/yMpFDHavKR2uWcKrVW9AL/jP0VrwtNEQbdyafQoDbTaXRynEa3fnN4r3jHz
 9IoNs/Q/jRZ8dzQ7EDnn15iKi07B22q5z3w3ra7ItMkVcvnmA4HgTs4qkGvFP7US
 O3y8RbgGY5ffx/dz8+1wDbj3lXIXcygYbrgBUm+zDu2mriuVrYaaJZXXN43yDwjT
 lJNlM3iUJc4NRAa087+CbU/a138laFpEE9KlkKrPEGVCqCOUl/+NR2BNMFQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9fa9ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:27:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so469278eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903220; x=1794508020;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OUm18lzpQTXVBx48H5WNr2EYOkh3NZFuWkoeIJop2uY=;
 b=eGK4tOCC05CiGYcv6uZFMJ4/+DwgPK5xaPXCadR8QeIQbjoqZJ3UFBSOgYB8A8AbSU
 rgoiqhQyYEYm4ynMSWrORryd/+6zhspK5f2fThqvZ5Ts6e2hMO2iHI2EpCRL/Q8xzxTP
 93oJVMnhGegNz9gSCoX7XPAIuL44Cl5CeQpNWXUcL/km7FLVLonyDY27LnyBeOyIKRT0
 6Ozrzgy5U/++KDaJum0xpG5tmT07fHNZhqu17HMjaDXFhRpsqa1WjIlkZV3Y4ZL46nks
 FqNrH7HWeENscsP8QQfN5Lpe9ia8nNBUa08/CxdzUCBi7DB3zM5WKUZhkCvIouGRdfuA
 W4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903220; x=1794508020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OUm18lzpQTXVBx48H5WNr2EYOkh3NZFuWkoeIJop2uY=;
 b=MbDXGlsYn21dy84nG1uclDZngG2m4oaDcp5NloAdvxBcO+UT/aALuXTsaYzyaJxQkG
 Q/Liglm+1meXXjGlqNIL3h3zZOAklq5UEbdiykXWvfvAkALJZGH5BdzvyhQDWdorJBX3
 se+pzg5m7FvgyoL29+PGI8XM2bIuLGSNuxtVFEQlwDbHJ5c8H9TLkj8dxi9Kmw5QzQ/Z
 nJlMEE7FI8jHjEy09x1FNnAkwB+FC6QVukT0M6uVwKWbGvJiAwBNX4RrUo85LGZq6wKI
 ShslWZ27uKSw78j7oQeKJzbhmQC2g5h0rPwmSFiCABfAWqfTWjyXyWcyrd7tcGQywRoQ
 hddw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoRFAJdIkcewtbmxz2uZXVzv0NtdoxXTsK2yD6vvc1qmGXtT8zqOPlNfAal8nf2K+NpOuiF/o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9CSES81whz/6ogl6Y5xrU9sTpoDd046IptoI1ofivNL4kGQO0g
 7yS9+YyqJOeTpUsXmXTvyhMQrTMQM+qmcu2wYRFsV7HHTc6LgwowkBTv5W5wxehzBUeodL1wv7b
 pbkvW3wNWzZHE7PzY3DzZdRRRalmmqyXQ3bvfSCcvS/5HATdcUIidZyd6KilClbW3W9W0j2w=
X-Gm-Gg: AYBFou3AkaCu1V2NQOqg5ZDFbIldIe3xwOPKMvg28qH3hV+bH5HNxqWzhN9H6D+uS8b
 LPR6sY47Zs/sdu8iuvBhSaEeVVY39kZ/IyLsgdZM0i4/axxOdn7Hvn0z4MLwuk1Zs4o7J/wTo1I
 X+OjuR7pRJ+1SACqMSKJHp679NdDTdp5VvflIe91e1TtXXQ1flVAOpdngW0q2MBM99XzoqmppeD
 2i+1ScOCedrd2uojewyLMFTnXWblMygQM6j1sUYO8Je87lzJ9+CBnBCrRictr7Svo5BoOJVUTxy
 kh4m5NriI84YatF6Dv9Lkr3QDZLu66CDXQ/xzlk8/suYVS8nRLsSao1FcJkN8Ha3AGwYw6TYeOu
 oQlCp1bUpZ6OqckYpgQxI3GKEb3xj+/u3c6PzOrsXwKgb3xeiVOVeDPCfEiNFtgcAE3dIUeRhIq
 gjIgE3dCuLxYgBfN4gOayjMOcmD8FakJFYQYCEmDYnUcyEm3ZbpPXY5MzSplZU8AY7UoeN
X-Received: by 2002:a05:693c:68cd:b0:36f:64e9:f1c4 with SMTP id
 5a478bee46e88-36f64e9f5c8mr178094eec.6.1793903219644; 
 Thu, 05 Nov 2026 10:26:59 -0800 (PST)
X-Received: by 2002:a05:693c:68cd:b0:36f:64e9:f1c4 with SMTP id
 5a478bee46e88-36f64e9f5c8mr178053eec.6.1793903218941; 
 Thu, 05 Nov 2026 10:26:58 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:58 -0800 (PST)
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
Subject: [PATCH v4 06/13] configs: qcom_defconfig: enable nord clock drivers
Date: Thu,  5 Nov 2026 23:56:07 +0530
Message-Id: <20261105182614.2405482-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX9+QhpwxrAAjK
 tp2uT9Ju7SJBMMaG16XJW5/VllouGHuRCzJqH9/Zemt+ZliTI8YX6VmFxlZRs6D3v65yh/ytFLo
 A22YXYaZ/Xm7cUXUgMgflqzuV93sl/lIa4duEupQsraEfEFpJH0GkWjH6wD5dJ17cSEk2xvLr5v
 lXnHhtWuE37vL22X6En8TSarBDtlxAscuHsjg3MM0GHld9noCqy8pAzvSnNprrDz/Vm0Hux2k3z
 qzrKovzkq7qcLcO0I6Q9xIqUkV36i4hZ6+c7HyBwxm7uUNB7Lt0gTpN7nqj8MWGj2DZOPM4btrp
 Oe+1BT7DHNF3ru5GpLuE7AG8P33ER8EqjfTCytT3Kx/fkgU1fcN26975lB2qMlJFdVR2yjSeJsa
 G5I8qeEYCl90sQjwoTXoE6lGqIPQGo7mLMuHHlEDDLZFClk29cOLFBiz0zW3m6/Naf3gVVfHFfF
 WgXnZowKFQyd+8v+oDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX/7dNBTEXKmFN
 gl+uuf6TTBxUpSavloaSaSvA9zhcWKobp+pV/pLH5kn3YMhsUhKMy10XGZcx0CzZns5byFwB3aB
 fG0fD7Fe/sbsN8ouAstBUSw9eT3UjPc=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aecca74 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ujKt_GTpXtF7ANkCTFUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: eLh3h6NRd9Iqj0GGLRvhqEo-agRVrEB6
X-Proofpoint-GUID: eLh3h6NRd9Iqj0GGLRvhqEo-agRVrEB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
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

Enable the GCC, NEGCC, SEGCC, NWGCC and TCSRCC clock controller
drivers in qcom_defconfig so support for the nord platform is built
as part of the shared Qualcomm target configuration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..ba6fd0b1fe6 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -57,6 +57,7 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_MILOS=y
+CONFIG_CLK_QCOM_NORD=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y
-- 
2.34.1

