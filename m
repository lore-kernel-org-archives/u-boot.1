Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF3CA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3434240A28;
	Wed, 30 Sep 2026 06:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fYsn3GRpViML; Wed, 30 Sep 2026 06:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72EFE40A6A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750132;
	b=CdW6TjXgCFKEkIp8r1CxfGqHjPrwp5Cuf3tQbE2yNm5se/g5ZZxA7kqVjioJxDJTi2WW
	 rn8nPkFsj7/nLnGs1mUZ6XASI87G1WtSvdr/3ZV8vvRx82f9efxWQwpSnhdl1FpBE8cuR
	 NfSv6tPzcrtOpGnlFQQF5y8EgXkmlyfk6Vwn8O46HujWdIWVczzSU1V+m/lHMOApL5QDs
	 K6UOorXxnBdTqOdjRFId9XTYZ+9kwg3SA2/VNaYzDqkyCARYdwkDs+pdmcLDu6LKjRzJe
	 a3RdgaFNYZTwbGFbGKscRRasaUhiFoxWqHUSYHNsaFUch0syYv20WEQhoNMcng+MEzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
	b=YgHlKSBciBfDElNoCazwQbqfoeg3k90fF4SE39u+s1F1muZtTtaKaFnv2asUel8ZBhBT
	 F6zN1uB3pVhCVofVfVN26jJRgX+Ld/SmN2BQhRO5FpHpi8cfv88Dc39SX5jDp7vqyooF6
	 o9Q7VBSpd+HhV3xM371xqAEsULCmNYPItSsKknX4s9Ji8C8yVEVQ/goU4ZUKGbQcfLVNP
	 IO927kcSpboh9UvEA11O+pBp/J9mjs32t01F6ErR4Ov4trGMDdCaHqEe5WZEjd5GULtii
	 /njEMxUOJGPLnLJv7LQzLDrIRhrazfsiNE+s5vj8eBiNcfMC3p6onnEsJN+fyuFmG9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750132;
	bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4EgDSwlqPz7R35lV1iX/AU3WybuSboc6w6Gqxl2u1YcSdpiQY+B0+CNEJZZQFYQE
	 9ew0JHGXdyp9PTp/QYbw8z9Z/ZRHZzGS0OYDMS+o3nzJcDJVodn/iz8vXsCzVtxCfg
	 sf5OexWKVfj/9yqXpA+k4HZZr5NWgYI3Y8MKQzsC12CRpAt0c/lX8VquQ0srdSoE5M
	 /5urYCLf2qP0GA0Fo+UjcCEQY41y3k73heEpCaAp6aOo+3DQTHYZdd1eUAMCoRQqNv
	 DpM/VZWJ/DYardUiqzRsd0k2bJcpbJXVIqCuxGhVAd+2i5Ct1pJrhUdwE4MAIg950m
	 gz0MYzBmXfh0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72EFE40A6A;
	Wed, 30 Sep 2026 06:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46B3C2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A08181083
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0TsOFrDyVcPO for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4AA0A81065
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750118;
 b=qPcciOJpXWkGgjWfainxfgy423QUeGYEdxhyw4b5MvvY2jh6sOTiJZVBIkdE0qy78g3y
 Q/ZXeE20lo/4CrP9pZQ2KDToNPZXGYT4XPQS45sd5nRlCgkoTLuAvYNOilukfT1wF8y8T
 HZ1jDdMXq8EQmsUPh867ohUlL4c5r1tZuxDtJDLkLpL7vAvc/Mj5F+vvfSohb05+KCYHY
 zLWdqGoBcWH+D1ciN6uvK6+ngslFQowwNTMDkO7HnhgdifI4r+nvzEJEfYkTGo2ehNYbC
 rsMS2MqtrCJby455GxHZA61DaU/bYjaeJqMczAEjvhD8rVee2xDrXDmNmMLayJMNjhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750118;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=JPsqs5F08AlJopapxaEt07iOk//cpUj2+TOV9K5SNTDEP/dhOGEyVRFjopSSF2somQvh
 BPiiCG4l6IhK9+H4V+Gz/9c21FNaS+5JFSla3JzBDow2f0GaCTTinWkHQGymZejL1MYq/
 aRMJjSlVjHrebVsxPt/kdSMQX8Y4DmqsmDjUDayTrGjLl3+7DlEQTk3FxxIuE+xGsgBVW
 zNxWo7vhbRIjw5IVhuJM04CbiFFxKxIhjqOBiiPrArjOKHFtxtp/GArmV1IlzIG0V7qyq
 NOdXE2WHRX+hlRwhVlTeGrOYKnsq2TenTZ7RT/CmxqrDOdFERPArlIe8N0X2tQ4Siug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=l95QrPbk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FOXU4VbV; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=l95QrPbk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FOXU4VbV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AA0A81065
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U69Duc484475
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7b8tiny3sVC
 BL0ytncknXXZTGIx3H4GG7lffy1M6NUY=; b=l95QrPbkaLxmDnowxlyHSE4YCPJ
 9f0aP9/UyWK2HFgQ3PS9qUtce7Ygxnv4vecIc9K4C+OX1vIck18LM8EeKKQ+1Ixz
 bgEAnFEelQqR+RFVSOy2OQmCrmkAu8YaL/zNQ/hd5aQ03q+W4I9jp1UkxMf/H0L5
 tFQLCENXWEyhXVSo0BFAJxuQqf3vbzyRpbzqGrPmKdrewcVPon4CNXlr4xc72D+f
 GucuDTz6aydj0MbyKVdiZJXs3Gx7GX8FiA+x6vW2wSjzgBNUQpBRXJsfeIZgPcEW
 tdYL/SDR9AH287TxVqkgaxJswrDxDbOQKZzcjQTsnvGlfG0WU5eVmTldsAA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx45y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so19077130eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750117; x=1791354917;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=FOXU4VbVyVzZpLLfzbnRFHDIU7v95QHT9GtNNDZku9A9OR9B42M4iCJUU2fXhZCs5x
 j98joTHuxD9lNBxj2X/OVq5n0wnJEad2bqUU/po1ED8+I0emw/85iXwrKOElQWdRpUbg
 ZZkJ60ur+YRp6bcyH5I3UkUaDPiY0rUIjt5Y1zRyeyPZSSMO7mrFQ+3PkQsqKmuZC5HS
 gR3+o5sNuHUT2Qcl3EvEurifR7kBugBXzVCEVwHNn4bu0FB9RgSa7lOPj+/EJp7ePQV+
 +ouutT4K0vCqBzSINiipHqVqP/FPWaao9856t0sbFWsZ43QXoNCGZwoMdNxTl2fRczjN
 brtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750117; x=1791354917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7b8tiny3sVCBL0ytncknXXZTGIx3H4GG7lffy1M6NUY=;
 b=iQn/yJhMVJZasMS2ulQEa7xr9V4BC71e/xNZ8dEHx71kYGSGpQdRWlc9KbVt3qOnDJ
 ZI60+IPNVkx4scgEdxdUwdXaTxuDI9OPqC0GhSHThOLq2p5XbyrVwN2AuP5zQal0JS5D
 NlHdACDClDMZGoDmfU3IgkNrMvK1en3+0dtlIdnF5NZJm7d8aYAPzeznGdQLVNe27nHf
 zuMqJKd+ykT77LAfH5et4cEK0FSy0BvIx6rkICwcT558TlPAWbWE9XHEnhpWH6JN8oU9
 y9g1d3adnaQ+VVigFeSNrMnKaY9NpntNlDaO610XERStvupM9/g4Xshx81tdgheGWAlK
 EjxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhgIBX1f6vY1sR2weSPEFWKdLw8J/xLxWYYEgqYjbCrZ29OghoElsTFcRElQgjNfstY138AHU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mT0/KknpBow+jzDkoSsGOJWfcvwEpgygD8CPua8nlUEnVSUkwm
 IuVUi0sbOjLLWhRihEIrMjru9VlaLD8/6dxqcEb0pe3F1emYOxYdZYyYzR9CmCbcSB4DSuNjDa1
 L8GNqdbGdvGLbbHLZwtvRWtFdo3Gro4yFnq7gUWK8lQ1GG0fN83/eKwUd4G7ecTmET35mBW0=
X-Gm-Gg: AYBFou0PJnVbDbdvcCaTHhtJ0jK5L7Q04qWOmetRNeuYwvrxvp7oeYkkgNmlAy1BHZG
 Kgc43rqYJZUvK6tnVL3Awg3Qt4a7vLREFUrXh5dZ8rbCmxrwWxbafwKF0hszTzN8h+JfzcUrA3L
 noiPJaX7iHE94t048dlBCZ7dvFP01aIRwxgLd7GDKH7Olt+GWCK7+cDXwIA42QPk/MDQg8iJprC
 TT6b59DdZc4s1WJGBXKAeS5Rt36RyV/q2fIzTJuvcHakZfzQgYzOvJxmgQeyd5ri40hZ4YVdqSv
 8hr4auRPFylhu7g1wYHjfxDiE7w9DWcW4lnMuAyUJszyC+fEVi0H6R6OLEHKTqm7X8T8a2QIgJb
 JcR5pNA060aBpvT5WTSD+Hc7qc68/Fxd6ceqhEgN+siTGhKB/
X-Received: by 2002:a05:7300:b187:b0:33f:358a:d0b0 with SMTP id
 5a478bee46e88-34cdfd62926mr715093eec.15.1790750116938; 
 Tue, 29 Sep 2026 23:35:16 -0700 (PDT)
X-Received: by 2002:a05:7300:b187:b0:33f:358a:d0b0 with SMTP id
 5a478bee46e88-34cdfd62926mr715034eec.15.1790750116310; 
 Tue, 29 Sep 2026 23:35:16 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:15 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 11/12] configs: qcom: add Shikra SPL defconfig
Date: Tue, 29 Sep 2026 23:34:48 -0700
Message-Id: <20260930063449.3251317-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX2I+Q9HdfkCZC
 mLltGrc8z8fKjN3FGnqwNUtx9MeVj7zy1prtmEwbILMdNQXGktR/uAoMJakHXPY3N39aMy7/9ss
 LPP8k9RYWxy38nb1d8m8O19Sq59LLiUoO9Zuz+Z6QkRGC2H49d7EiioASMlDuNF5xJYBoN9mski
 AdPVlmp3XJtKBPoMOjoQHaVkk9X+63htoLf7CUcyuq7hHmW/UO3PnhsVjWM/gRifruxT+c+ZDgm
 AmJwngx/DAtGKvHembvV/UgwNRbyWrFtox05ga3n1+Alza0j9K9Teb3R8edkjxmA+oKsmx+Evx+
 nTOYwyti3Y0iOWfSloZrBcbj3Rzu/cfdzienLRpHu+4o740c80Gqb8GsbkcGkwWZwGZClVhMdnf
 JfnEXuv4fTJ5mwTS4Dh44YOwdNB1KBVZ274GL9H+WJzZZaueCUp+6uuRUBK+XNBzznqju+4S/aN
 C1qMfOfdJFd9GTvXYBQ==
X-Proofpoint-ORIG-GUID: y4w_aId4REXf4xNqdONgoK8JovszRFwh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXygfw/6ZCzBlq
 ghOOUgkLXqE4dNx0cYXQpBGiFTUEM1T3tm69xFpCifbC5QIwbycRFwP9BXynZ7MizhGa4g2KOe9
 TRfBxuqOkoezAISFztHRqMQ1BxMQQdU=
X-Proofpoint-GUID: y4w_aId4REXf4xNqdONgoK8JovszRFwh
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abcada5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the Shikra SPL defconfig with the early serial, eMMC,
pinctrl, SMEM, QCLIB, FIT-loading, and memory-layout options
required for the SPL boot flow.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 configs/qcom_shikra_spl_defconfig | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 configs/qcom_shikra_spl_defconfig

diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
new file mode 100644
index 00000000000..7bcb3e21a15
--- /dev/null
+++ b/configs/qcom_shikra_spl_defconfig
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_DEFAULT_DEVICE_TREE="shikra-cqs-evk"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_SHIKRA=y
+CONFIG_MSM_GPIO=y
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM=y
+CONFIG_PINCTRL_QCOM_SHIKRA=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_GENERIC=y
+CONFIG_SPL_PINCTRL_QCOM=y
+CONFIG_SPL_PINCTRL_QCOM_SHIKRA=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x48000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x0C219000
+CONFIG_SPL_MAX_SIZE=0x7B800
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0C2C1800
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x0C294800
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
+CONFIG_SYS_BOARD="shikra"
-- 
2.34.1

