Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF8606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zOsNJBZC;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OlORUaye;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DHVf1E20
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 694ED6088E;
	Thu,  5 Nov 2026 18:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6yqdR6Pb8Nd; Thu,  5 Nov 2026 18:26:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EB8A6085F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903206;
	b=AXM+ZLUNJygUWjOgvxs5P3qi2PJxVOWMWbipHXE5W7SWx+roE4s1rvl1RXlpDfPvIGJJ
	 0XSUnkSIV4lvCwcVUIJALE+yq8Ghwm6FuKUcU+1xnjKq+uFLYnbjnwHdNtH0cEujnkYh8
	 XdbdfFD6laQMsbABbW7dZkWx/XqYKM5H0MKNUMUZceNTkcFdTzZwOmzPK01DIqjl/bc7x
	 EbmsQnag2PLyB492mPcbf71Q709xIsp47ctxunF4HshsWmExDyw78RElIJNOsARDx9ayQ
	 yShAPgs6BXbbV4qO/PFTZ24yoKkVzzVoMml1UXN6v1vc+qNmWmgcC2uAdMHhh/LyOiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903206;
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
	bh=GYOVnYYlbCOkWTbxjKKI5Z8bHiilws6OffaX/48+zxg=;
	b=RDvdOIt5HR/xodKlUTm6EkUd9HkHOBVMUd1RGyH6K6UdBzeRwHxEsjMhVonxxSlNRF1Y
	 +bIQDaE/cQkqOnlunObqt2L5wBXdGrlM/5/xM5w6hWqel28/3+eZXb+sp8+F16myeTsb5
	 0p4X0g6V9DQ/MpGtcZ9ikbVdyVw5EHWJKUnbH+E4uENyVIw3IlaQlQUbkZkZzvMLV61/O
	 oIte756/pCPoRXuxJmOSBDqViBs9JX9I+uxTYCfRWUgGh67KkS23KGfuqBhyNommFv6+F
	 7OGDyi+KNQ4SPn+QJB6xsYSX/skvuYg0YVMaJJGjBWCdSUfFjVPtsXTlm+b7EkkByQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903206;
	bh=GYOVnYYlbCOkWTbxjKKI5Z8bHiilws6OffaX/48+zxg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zOsNJBZCVH+isFYvW+gDMIg9601JAAZcdlZnw9WpQErIuoK1pgBbhZC6Bst25y4oi
	 kKGIG+y3rs1ySIzOk7U9ed3gu9KlfC2Pq0+aB+34RQZ+qMe0jvX7C98hv1rCTfx8eY
	 U0SUIcegiZkh857apcZYNxR/ckwlEGDywHGAqUNZcP13CWxbhK/m3JY8Cp8bovVKYx
	 FtgJJDgNJ78+Ply8Ycc1qEzr0mTrUS2o+gQnpe08T/Erl18WcU0MpThRZ4Oabsnp27
	 iYNPjBZmIqVNPDUsi9kPTjTxxVrwB+8++ylLMBYunqWuD43k3mVkZLVs0l963ks7ax
	 oHBULhdBoVDuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EB8A6085F;
	Thu,  5 Nov 2026 18:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8851131F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79C02811B5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7jIlcM-_jYr for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84972811B2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OlORUaye; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DHVf1E20
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84972811B2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQJF4075321
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GYOVnYYlbCO
 kWTbxjKKI5Z8bHiilws6OffaX/48+zxg=; b=OlORUayeMTRYBZK2vQ9uUBNR30l
 NJM1Pt+2/CVqJOKnazhkFVMdy6KQO1l11ijU6gWLtb0oC3endwF+h0N875FhowAI
 NXHDDbj8luuRqYVXztXhlSsF78OBh1uIQb1Vfw16W6RLWXGEStqJ8jrVFCyLPhJp
 EO7Dw1arN0qL9mNwaVhctxzbE1CMC8ujAbXQXDj/Pm1QDv0EzyWcHifx03j5AEl2
 44fZuWd1HGdH6WM9UUwDvP5sYByI+iLeSyNYr0wdRVp1Q6h3RdE9LdNq8uMdDKZI
 TOrO/aUIekuu19j+sq3j3Nn5T79tts7OfNJbEWg1FZXfKMol7Fv61W/O03w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdsyut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36cec75d8caso1091382eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903203; x=1794508003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GYOVnYYlbCOkWTbxjKKI5Z8bHiilws6OffaX/48+zxg=;
 b=DHVf1E20QHgs5LwHM7FFxTfkKLJT87MR3R/OnTeT6dWqVBd8ZXlFeerm2w1u2h+Zgi
 sslcjpFZRIO89VsB/InpwpM7qmYGLoiuWyFjKkLO8grIEVl9UngKusLCm97vl20vlxfk
 jrIPcoTpK1hUOYhDkJlIsB7Ri6uPLEBLQKM1BWoaBYOa6d5u4aci10x96nz5JtQCyR5l
 J7b5KoF6LBhdnA6dwk4HIDXt5bvZ/oxPSvdJXIF1q7BMUQmSOVmG03JTj7Xueck5lnkZ
 chj74rq/UpRE56nUPqfMRGgdwokkjaRKIAGf5feLh3IDlu6rQ1lUcoSkjh18m1SjDR0m
 tA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903203; x=1794508003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GYOVnYYlbCOkWTbxjKKI5Z8bHiilws6OffaX/48+zxg=;
 b=cUTMU9pBaQhKvNEK78NIQbqYUc5QDCZoUb4BiPoa7C98O5EslTvyAi80UhJQ4jTXy0
 dBWyR5Athqj0K7hXfrWwliEDde6jxLzTRUUFHoIRObF1RH7pSoZWv4Qgz0plV94+2SyI
 QgvF4rNWAq8A48USz/gIEBP1PMMUAQBqo5IgYI5bRnrFi30bB4ldH68bT1Xe0gErlmwf
 55Ti0kfzTWjphnJ6H8/F9z5eWLmwvOCRYXw8KC23S6wrDm8nfP0A8oiIpE7OI4euTyKw
 PcGMPb5XPjG9uwRNMk803PDTIkWeEaU12En1sLc9+JtzYwtVy8nEFZGC47z9H74sHjq5
 M+lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIOVDAG78SC4ecK2RxfBgs2Eb3tpm/T2c2RclAcGyzdgO6M+dvg7bIfX6F8agD6385GyhevtY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9aoPRCJG+0NZTRl+iuzowVMwlWkl7xBeh3RlxMR0v/0+q04PiT
 YusFPSoGvtJ4OsbM+ogsQYdUh6qj2QWH87B0hccT6ygjiI0Pkph43Xi+Qb/gf8jslN5lO8hfnx1
 jv62zX4a/Oz0KHlDxigw5rYSkAMC/4J6zfsNk50APN0zj3JkN2WvcD8TeKSHYoGm/JodJlWk=
X-Gm-Gg: AYBFou3/CdVuZcW7f45RmKm+9C1uCb6ymewb34rqeoelcluXEYOXT+XefUZor8PzX6I
 UQdHaHHC9k6Yur/ulbbJvUKq/hMkYUSII601B+eY0/okvWZ/F9iYrApCnf1WBHEj6n/lKhpYow5
 9J/fRG/lCJKVu/qk98YkNex5/9vGMKG3gkouLKI9fnVcAYUq+PWkDaYDmMADFIagNvsnij8/yJB
 CZbzD+oAw9wBDhg6T9NtIFdfLk2bTyQuqP5a4urXyGdQCz13Rt3bzUlVsh/sfxQ2h/YoaPSkOkr
 iVWdG6tJoh1yFyLUpExqo75AcAJGwAbHFC/ILXjoMztrlP8nvrn1PRREKqNFPoXXBouyt8wzc4A
 W/zt6yzSvr9jS1yD3F37JIbXK7Dss6dTu2bdP4vra4FF/Ngqm907wASnS394MztoHiD81ikf/DF
 kFqkMLU1BJDMdg1FG118lUqHM9sXvSaS5OeSO4FSD9PiVUTA1jlnDDu09ednrrMcINOGaN
X-Received: by 2002:a05:7300:8256:b0:364:377c:cabe with SMTP id
 5a478bee46e88-36de743540dmr3860150eec.24.1793903202416; 
 Thu, 05 Nov 2026 10:26:42 -0800 (PST)
X-Received: by 2002:a05:7300:8256:b0:364:377c:cabe with SMTP id
 5a478bee46e88-36de743540dmr3860115eec.24.1793903201858; 
 Thu, 05 Nov 2026 10:26:41 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:41 -0800 (PST)
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
Subject: [PATCH v4 03/13] clk: qcom: add SEGCC driver for nord
Date: Thu,  5 Nov 2026 23:56:04 +0530
Message-Id: <20261105182614.2405482-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aecca63 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=M9R0Gdnu6LUBG55lUXQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: pL03Ub5UI7XRNkOyc0eOfu5OjhS3nT0X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX4LTV3qoWoTmi
 an0zAdfAIK8XRY23ZuO/KVVKSYIhBjyD02xHIYW/PRIQ+aJRIv3gQ/lltaR0bFg1LZLQSJZT0bX
 OeHBE0yC+hsnSFU219bXjkXpWUign80=
X-Proofpoint-GUID: pL03Ub5UI7XRNkOyc0eOfu5OjhS3nT0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXyEMEroLwN22e
 JC24pmYJC8UGN1my6fFHNF2GZKWadZL+C4XxsJDi/qFc/YZC1KqYE9mIPROZtb5AOFrMrmPWeZm
 bVVOj8UyxfQJ4tWeXcvowVSrhjpXeMex61c583jFpTjBGqoBlvllDh2XMdPsdeaZXpBXWXwZ0Bz
 pOPpLY76S+72PAFOA6fCgxUDwb+NUrD0omoNL2mn0g9/CH1vH3QdooSFdZokOm4fj8Zqb08q528
 mWMOE3AkjKnQmwEjdYJdb7oHg3TJwdox/KoMwcb5yFne6y+aUYq9tomr1uwdHDxE9PzBjwNYkaH
 DBFeUrDJ9p4TpN78DcmFCnrSeuvP3Qs26aI0WhxVBbeDILAo6Tir+/ZiMpmLqXB+kr7jpXpsV+I
 0Bw2W5OgEWMwZSE2nX4/vGWLoT6cVAUNp4Pg8zu5CLU1pfy87TPYCoW+MDISf5z8k/Rjsl/Jlhc
 WKprReDOQ82CdUFm95A==
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

Add support for the nord SE Global Clock Controller (SEGCC).

Implement the qcom,nord-segcc driver to provide clocks, resets and
power domains required by nord peripherals during boot.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-segcc.c | 151 ++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index a9f6229a944..816c862932b 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-negcc.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-segcc.c b/drivers/clk/qcom/clock-nord-segcc.c
new file mode 100644
index 00000000000..3efe0285824
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-segcc.c
@@ -0,0 +1,151 @@
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
+#include <dt-bindings/clock/qcom,nord-segcc.h>
+#include "clock-qcom.h"
+
+#define SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR	0x2665c
+
+static const struct freq_tbl ftbl_se_gcc_qupv3_wrap0_s4_clk_src[] = {
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
+static ulong nord_segcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case SE_GCC_QUPV3_WRAP0_S4_CLK:
+		freq = qcom_find_freq(ftbl_se_gcc_qupv3_wrap0_s4_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_segcc_clks[] = {
+	GATE_CLK_POLLED(SE_GCC_EMAC0_AXI_CLK,           0x2401c, BIT(0),  0x2401c),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_AXI_CLK,           0x2501c, BIT(0),  0x2501c),
+	GATE_CLK_POLLED(SE_GCC_MMU_2_TCU_VOTE_CLK,      0x57040, BIT(0),  0x57040),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x57000, BIT(15), 0x26020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_CLK,    0x57000, BIT(14), 0x2600c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_M_AHB_CLK,   0x57000, BIT(12), 0x26004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S0_CLK,      0x57000, BIT(16), 0x2615c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S1_CLK,      0x57000, BIT(17), 0x26298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S2_CLK,      0x57000, BIT(18), 0x263d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S3_CLK,      0x57000, BIT(19), 0x26510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S4_CLK,      0x57000, BIT(20), 0x2664c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S5_CLK,      0x57000, BIT(21), 0x26788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S6_CLK,      0x57000, BIT(22), 0x268c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S_AHB_CLK,   0x57000, BIT(13), 0x26008),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x57000, BIT(26), 0x27020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_CLK,    0x57000, BIT(25), 0x2700c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_M_AHB_CLK,   0x57000, BIT(23), 0x27004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S0_CLK,      0x57000, BIT(27), 0x2715c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S1_CLK,      0x57000, BIT(28), 0x27298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S2_CLK,      0x57000, BIT(29), 0x273d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S3_CLK,      0x57000, BIT(30), 0x27510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S4_CLK,      0x57000, BIT(31), 0x2764c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S5_CLK,      0x57008, BIT(0),  0x27788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S6_CLK,      0x57008, BIT(1),  0x278c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S_AHB_CLK,   0x57000, BIT(24), 0x27008),
+
+	GATE_CLK_POLLED(SE_GCC_EEE_EMAC0_CLK,               0x240b4, BIT(0), 0x240b4),
+	GATE_CLK_POLLED(SE_GCC_EEE_EMAC1_CLK,               0x250b4, BIT(0), 0x250b4),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_CC_SGMIIPHY_RX_CLK,    0x24064, BIT(0), 0x24064),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_CC_SGMIIPHY_TX_CLK,    0x2405c, BIT(0), 0x2405c),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_PHY_AUX_CLK,           0x2402c, BIT(0), 0x2402c),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_PTP_CLK,               0x24048, BIT(0), 0x24048),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_RGMII_CLK,             0x24058, BIT(0), 0x24058),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_RPCS_RX_CLK,           0x240a8, BIT(0), 0x240a8),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_RPCS_TX_CLK,           0x240a4, BIT(0), 0x240a4),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_XGXS_RX_CLK,           0x240b0, BIT(0), 0x240b0),
+	GATE_CLK_POLLED(SE_GCC_EMAC0_XGXS_TX_CLK,           0x240ac, BIT(0), 0x240ac),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_CC_SGMIIPHY_RX_CLK,    0x25064, BIT(0), 0x25064),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_CC_SGMIIPHY_TX_CLK,    0x2505c, BIT(0), 0x2505c),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_PHY_AUX_CLK,           0x2502c, BIT(0), 0x2502c),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_PTP_CLK,               0x25048, BIT(0), 0x25048),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_RGMII_CLK,             0x25058, BIT(0), 0x25058),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_RPCS_RX_CLK,           0x250a8, BIT(0), 0x250a8),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_RPCS_TX_CLK,           0x250a4, BIT(0), 0x250a4),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_XGXS_RX_CLK,           0x250b0, BIT(0), 0x250b0),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_XGXS_TX_CLK,           0x250ac, BIT(0), 0x250ac),
+	GATE_CLK_POLLED(SE_GCC_FRQ_MEASURE_REF_CLK,         0x18008, BIT(0), 0x18008),
+	GATE_CLK_POLLED(SE_GCC_GP1_CLK,                     0x19000, BIT(0), 0x19000),
+	GATE_CLK_POLLED(SE_GCC_GP2_CLK,                     0x1a000, BIT(0), 0x1a000),
+};
+
+static int nord_segcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_segcc_resets[] = {
+	[SE_GCC_EMAC0_BCR] = { 0x24000 },
+	[SE_GCC_EMAC1_BCR] = { 0x25000 },
+	[SE_GCC_QUPV3_WRAPPER_0_BCR] = { 0x26000 },
+	[SE_GCC_QUPV3_WRAPPER_1_BCR] = { 0x27000 },
+};
+
+static const struct qcom_power_map nord_segcc_gdscs[] = {
+	[SE_GCC_EMAC0_GDSC] = { 0x24004 },
+	[SE_GCC_EMAC1_GDSC] = { 0x25004 },
+};
+
+static struct msm_clk_data nord_segcc_data = {
+	.resets = nord_segcc_resets,
+	.num_resets = ARRAY_SIZE(nord_segcc_resets),
+	.clks = nord_segcc_clks,
+	.num_clks = ARRAY_SIZE(nord_segcc_clks),
+
+	.power_domains = nord_segcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_segcc_gdscs),
+
+	.enable = nord_segcc_enable,
+	.set_rate = nord_segcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_segcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-segcc",
+		.data = (ulong)&nord_segcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_segcc) = {
+	.name		= "gcc_nord_segcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_segcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

