Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D606A320
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XCbQpqmN;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ESajvqI0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hG+XSlAs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FC6781586;
	Fri, 23 Oct 2026 17:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYaeFA1jGvFo; Fri, 23 Oct 2026 17:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 705A681544
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777497;
	b=KCCp1LNHfgF5bAlpmekp0g+7H0R1E+Bte+k/yhae4km1z8FhUBD82V55Oibza9nBlJiP
	 X3Jp3tZj+FRjPUKT9vIUHRtDBMCQpMwlGRVvY4OvCKv/ZSQkAaLxrmDHzvvb1fvCYN9uO
	 jtclJQnBAvzlh+GAeCLmy2BonoT17/0O3q+h9VojL1vtwqfL8Yml2La0ArBymsO8Z59gO
	 Uxii3ihCoY4Rztu1vvuTL9MIWVt4G7oIMrqAPOgh10G4fAIvoHj/AASscFffqpwae0FdY
	 aeoEjg2Z9vLgBOvxFY46frP5BMkiiYM6l+yjvihj3Hf/x8GmVWtQfZspRTFAZ55hV3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=;
	b=tRWSV5Bvv6d6JtKmDi9e9D69jTt7BNPq0APNH7WosJ3k6lFXMmgwATb00XGdPIqXzUcC
	 XqWVGIx1RBj4pwH/TU+TroUxR4eVirWMvP4wq1jkst20ftBJeGPp1UkDi89GduvmR16iV
	 ppoXTBUi4NVO//Qble7SjZX5pIsqt26DV0ZJwqHouALAbmwSGco71TQ5ssLuQesCoauFU
	 QRnyD+oP+bCyiqsw5rteh9iTerLpQXsFMMIJL+Fh2Ykcz+ZPSGVyVWjPRb8eVfS1pknCU
	 d6W6j4VW0p3BEQQva65mFPa+GGrILw+GbiEFiklol81nc96/89rQsUu98E3gLtTj3aQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777497;
	bh=KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XCbQpqmNcUVbm2oTDU4V6rZ/Kqd56lGuLzpGwlcPa/+is76P7jKvad/9eZfRaUn4g
	 4zCRt8DRgdGt6MPMKDSF3VAP8G1HipsOaUbtOZDxVvvj17vEz0MdRkWgH/0fmglFsq
	 HoCxU0nbNqmIVkNv2zRs5d7Nlef3/JEPRJlNHjmCVHFGegCjdbZZZi57aIysbnkbNi
	 AG5Dbbuz6DY/yPW9/+zB2Frdd1XXN7Sk2tuR5c1YDkMmCiac/7EQ2vinJ3ZeJKOBIZ
	 5rugkAskfpthzc9JDrHvDQUEuVBXOdplze47DYwt/os5gj8iLLsOkLSOJkm8jUzjfu
	 1s5tebMiq3nUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 705A681544;
	Fri, 23 Oct 2026 17:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7126235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C49A3401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tntonk97T6Fr for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 69FFE40059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777492;
 b=s6HZhgW+J5jLihWgfmwXEV9Ok/1l3qqKhiYAAymaK0FCDGrt8Jk9g5stWdTc3Hr1jLYR
 MUNIiADT/NWrt0icQ7t/C4Cg99roWAT+p2dfyZTLLSrJOrfgZLP2UYkq3SF07SJrSi1ph
 ERKE0b3IcYxfktlnQmA2AtdhyX8wnmjSnc8vEEWWpXxHp8Xk4XSQsfXHn5Q8rZjohRYLI
 /BasWVY5VePBGR7Q74Py9V15IlWZ/F4PvcjG4qi1Q+tyScEHnOF8GwIfJ5GqN3S9OstRp
 uXsMKR8LGrX2iN9PWNw1bY/AxwqXhWIRkTu3XsbWeF78JjiO4hcONdq/xTxW82MQcog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777492;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=;
 b=cMw6pPyqx0uiAoQLW/sqFPXhqxBLSNHn/pnqV/aY7eT0u9hJ0q7nhzLrSEt86z3Cf4gC
 yMEsdEUtGnbe5F20KpAKrxPpmDABNbdXsesodn9DVBZMJajMcg5J43xRaX1EfRO8mULk6
 l5UdQRFYkNnFqjGeVSOibmHEFfvaBJFYIGwomJL/keM5dhn4nRa3nvtZXH56diAy1qxdD
 3JcyGSTinHnOBZBYy2mPwUa4riXEh//ls1cMtp++ogYF0Lq5AaQvfpzcq7ajCftBBqQxB
 IB2YKg4Giz+Vlw8sGA+oOk4HWqvNoDpx1haWcI3p+lu6DRympc4wtGUnKKRRD8nMa8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ESajvqI0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hG+XSlAs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ESajvqI0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hG+XSlAs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69FFE40059
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2p9N3228246
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=; b=ESajvqI0oMgcATvm
 d6sFry7HotC70pTTGxB2tj9Ws5+7M3myeJWLq/f96OPnCl4kn4hjU4Izt74SDnxe
 Sle68/qCYq1b+RHAFa3fwnLMbU5ZPjotKGA0wbPPpI+9DyYcqFqVUCJGGoZlZG8a
 Pz5af8msVjshVhMtkRzipnBoegZd7IY7RfdcQewdZ0HBCjfS9dFOdsCQBF7/b+96
 o8H51kHLWbJv5kNCRTLcb3ZTz07nD3qeoP0YrVwfA06NP910r5DEH76X0vPIU3rs
 x+mo2kfjF3BpZnkCiKTF2rXbCBo3yd/yjD1Kn9J2lotcylt2qUVQ29lhEVK+KnQL
 nZQz3Q==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart0cwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:49 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b162ae7aa1so3701207b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777489; x=1793382289;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=;
 b=hG+XSlAsLjLHkypc0rFtP4do40r3uznVzcCbpiGmXhog5SfU0r91ux5O35Hg8SOeAG
 ed7Uqj58/EviM3cgxJ/b8qeZvVQGdMCJ/Q46FUYvS5TE+ampd5U+vM+23AayPmFZiu8D
 7d+QdTkaLZOlI8JCqkfo2X73kzaTLEArN764ZqqmWwt0WJQv5SIgrd0Bo06g84J6a9Ms
 sxtS08y/tqjyZVRBqHNSXQtcbMugbGN8AVBm4ZdoKo6uAj0kc5dwLn6lfPesa5GIjqEc
 +V7MSUAaHVumDzo4JyoG7//aQ58+UNYHcTRJLGQ3YXOsj7+DUQmY8dQBr8ouVsXAtTFN
 yo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777489; x=1793382289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KbAv5yLGQIO0T7BcwAiYZoHfSBvbP9m/29rcT2hdrRs=;
 b=ko2ruClIr2L6QCzQSQDlIV9ePhIKq2hyWzj4N8sOFLHQh9cyA9nf4u50kfgVPv0Ue5
 A0LEGBMRlxlwq2rOOl4CW/CO/a0A7IISLIMasDBHOy6b9Skck4kKZ/chertzlrADnCW9
 Ylxv+HKyfFy94MkpSSJJcUB4dFQMvA4DNaljMX5a7VRw86GWrD3y2bbLeH7VZHMSWwYk
 rPPl98phR597HvFqDk3yUxf1KcgBo4iPjU7updyombQbSC2hxStrlY2zx7V7QvNORwzb
 VqcBRKE6rycEkUi3KBxsfFCvwMWPn9eR/8ly2MXIv0iBUyXForzNWCwzcP6OlZ2H4B2Z
 lKsg==
X-Gm-Message-State: AFq9FYJ5aonHIb5loGxa6TAXB4qz/BbHT2JdZd5xCwzutBBfz8q3sRVa
 yAo4Ur9Y1kRdlT2tUrpvUfiSXq40bpsdPKVFmMDhRQXZwbMTeWyTdfPOqCLT3nkQGFy0Fvm6qtV
 wEXIOhcObTRqYESISwAOMoS9zHRHiJ4moC4SBVhE2q8h5kPoNRmtMJxx/Pww4+d4chv1Atko=
X-Gm-Gg: AYBFou0DJ2rADIctNCjyE3tzbHmvc7gEa1bpc/iU2zqPpuo7Fba63ZDHDInsl5bt+Fh
 z3HLR/0QEI1mrwJt4ezEEIWjCjwBJlLpZ9U6O5Y8RjhjKswB/Ug/N6GOQLt6qBLdRn6U0VvC/Fv
 A/ny23XiQEwT1jkeHtA7Uj5ZTmPSwyk066TZ5cZDOndzsrlW3C9ADg+bWsacHxwX880dtFq5F93
 PYAQaDFXoPpqeKZOrpvScXOmVxUNSK8cfJT/TfJCTYpzpd2qdclhcjfIFuDIcZ5tjkeGJcUmt5+
 2X3k7l/X93xNDJKHvmhwDttRUrgNIu0xj4njgrxd5lC2xoFh0gbSJochj+jIVzoXsqnspMSVi03
 syi8ia8k2BXdHqu3PQq/1Y/XmhaIyIw52fjqDwaEgfBHOW/+UVBV2wv0fCr27
X-Received: by 2002:a05:690c:ec8:b0:8b0:a30a:7f25 with SMTP id
 00721157ae682-8b157cfbba0mr23602157b3.12.1792777488852; 
 Fri, 23 Oct 2026 10:44:48 -0700 (PDT)
X-Received: by 2002:a05:690c:ec8:b0:8b0:a30a:7f25 with SMTP id
 00721157ae682-8b157cfbba0mr23601917b3.12.1792777488389; 
 Fri, 23 Oct 2026 10:44:48 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163dbf92esm2823357b3.32.2026.10.23.10.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:44:47 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2] arm: dts: lemans-evk: Add SPI-NOR flash node
Date: Fri, 23 Oct 2026 13:44:41 -0400
Message-ID: <20261023174443.1552137-3-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com>
References: <20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX2jog1TgW0byp
 v+j2JqkfIKVCo3wKHESZgr2wgM0THY45RySuxH50tY4BMgAnemTD0lhoq6m0bTBHRv22AdyjYxW
 7woe6mbG4VNUFuXKpoEm+6xaqHRq9mLRVX5diDQX3H9dl2gprhKh1X3fyUw7Ovf7ph+ThCPMMsm
 dJZksBxKkvK4QNjAlkK7vhOCmf/GP9++cnpPTV/vAhCiP034PVCHjARV3a0ioMThQNPa3RUaOPH
 qrmaLVJsk7/h6EV91JvDRWdKUsTObfGAIaDaAFkhrJnIiAL2frufeZjOC72zcSsta9UvVVt0eBX
 l3MmPmjzsURomt5rvYixNLzBdB5KZ/7uzDoqoHDeVPj+IPWxV2+L0cplMI6d0KkTaYZbT9aq7X3
 4ZFLv47nsD3zGI5yPx2pvUYaGiqguD/lKibh1qUlAwiZusel81JLzma/KToXtChJCSV0QA/03EC
 7gDxD+GeEPGzDf31ysg==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adb9d11 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=l-lKb2_wvY8M4I3VjhEA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX+NWApOkY2/Mv
 yWZWgKx8m6Swe3XYr1eMnBfXuk629LC2qp8vgJL6GKK+zFQ2OkXYKjtfR6V546bla6Pwk7kjAyM
 Gfnhw4D01SiH64pTDPgn6PNix8rNUNc=
X-Proofpoint-ORIG-GUID: T_ZsahQkOeT7mfO-8WxNKQED8pSgJRAB
X-Proofpoint-GUID: T_ZsahQkOeT7mfO-8WxNKQED8pSgJRAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 at 11:40, Vandhiadevan Karunamoorthy wrote:
[...]
> +&qupv3_id_3 {
> +	bootph-all;
> +};

Do we want wrapper 3 bound pre-reloc on every boot, or only when booting
from SPI-NOR?

Should this go with the wrap3 clock patch and the GENI SPI driver it
needs?
