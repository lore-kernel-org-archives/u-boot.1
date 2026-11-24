Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA68606A32E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sQnOgc9p;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MNCSYlLB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RAIA8tlc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADD480E63;
	Tue, 24 Nov 2026 16:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekX4OOew_q_Y; Tue, 24 Nov 2026 16:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD92580DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538863;
	b=AQ+uARVefgSTKzUX2gMNssNrSdIMqHgswSCR6gicHusM2/AF6QzDTi+lb0nRY0L1LQSu
	 MxKjBe5XuQwK2I52IR1AN0xz/HFhUAoTCmkpkpdA7Oi0E84KBz4svfrTcUNStzZfuVeGc
	 6mXLW3LigdK1VIgiuBhaFKGD7d0OpmlEMOs063g7GZ9QUm+FwhKxsc+SZTVVtj9p4yAbQ
	 j9VfMOy1/6Mqa6ykzDVw2K79PBQ1jjM9Obgw4kobdliBG4DrTBsgeSvdZeGkGlHeKVnXj
	 HkL0K3gCA16bEtO3oH9p+Lsab47WbueJS1OH78BBd5bJ3J4OUb0DYLMhzucNpCWjoew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
	b=LpHJcFcJE3b6GINo/GOT/Ladvc+lKs53Gx7bDz48+PGydrIH/QuMw+Ecyd4wYCiiYXYd
	 RojPssMLDzCUpsXL8i5IHosi0t9ULrXOiezbSDEeBuD0puaCjIxg4wV1sCClSWEZTm+HK
	 bCoSes44JFEHjiVbEh5cbue9QicbmpEJv/HbmdR5waciFfWM7i+gj4JbjjLlbKtryAG+I
	 PxZPZ0yKsdQXSz7XVmkc/owICAYpAKuPTJhUAQdE4S3ipvbxllkPGRzg6cjlz8MQOe0q6
	 fgqDdkXK1HeA8yE76ALlJoVaILu8KpK84rpGGuYUiKft92pjhSSc2HWbM48KIMs+7fw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538863;
	bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sQnOgc9p/GXNje1FE2xG61qQ9h8CdHBxYUJByETtpyXItOj17AC+r7KLboAhSVwKy
	 iizVQheqpz/EqQlyiFnS5UOXqm4t92DT5emvfKG9gG9uTGmx4v9Ztvl+oVaJVca3Jt
	 GXA+CaeL/wibqdPUQcX4KiyCRa1VW8aIsOiZZUsqRRcfNOStHrNWtMfItPPMV2KY3w
	 necXhsS0ETq6sajNgcOPajmOY3OCM/bTmOJd2Vimxn3eFe6qc7/RPy2ngoSZY7Jrpo
	 +zFylxxvCX0y0584oBRDzA+LkyrTT1PbkorhePWdlaOztP6Jo1xXeu7n+XsKvL1Wem
	 3OQdTjGwVvpEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD92580DC5;
	Tue, 24 Nov 2026 16:47:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A976715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CE96400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73cjyrem3hhp for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A3B104018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MNCSYlLB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RAIA8tlc
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3B104018D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLMgb1184815
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XvLlN/mzfvC
 X5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=; b=MNCSYlLBrXgNVf6nSfCQr53InwI
 eS4vlwvwg5BxJBVquf/dwbASdy3gvt3UxIUX3Yv0h2oSk1Q4ktZS0y9Wwx72myP3
 UGQe9bns2x4VKcydTpLOlgYn5KuNzqRu+cN9wdLUDb0Gcpx8j88QhgJaIhMukZFA
 /Op7d6IlVN83WfnRv2KHPIVZ9fdvKHCceN9eHJxJPLKrea10h1VHKNOBUXMztjS8
 oz42M7PIlCS9dEa11qNXpoaYfbCRelV1wGMEpI/VYU4n1qLfsHT9hTQLoKcyDYbk
 NBh+MP4v8Z2pLxyvtr+Q1O3P6Mx+6EjDnjl+ieyzbl8xmwV2nzPhK2dFhaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky3rk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6544055eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538859; x=1796143659;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
 b=RAIA8tlcMjbZ/7uDZZeZ+ygrszR4YsrNHSDY2TCUgo5odEAT7QG5PeH1GLvoqQiotZ
 Qipq15H4lwuw6w/YTmhhoe7ACsRC6LGyjLjxiXElca9bo2wi+DtCW2ChVkU0t5FqFrR5
 EamHJCnjftXm4lJVSI6ixFq0xnodlMhlFm2/se+PdTyKWzicW8R9mQIEvlGo5iEBot5/
 TlZ/AMpqPV6VWJC4KQNPhSlNxdK4gSHhroXkkApNNorY5sPZVIkylrifK+iytBd/gtEb
 N3/N435fcSs5DDHSDoV+JKG5UMIX2aiUWADftzgWjWlaBocVO/qgs48XJjnnh53C/7uB
 M1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538859; x=1796143659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XvLlN/mzfvCX5gVdsa5Caed8c53dflIXGjaBHVfX4Zo=;
 b=owV/8iuiUfkJ0zU850+Wtg5d3xmiZOXfx6tdm9GR0rRK9lcI8ZvHIfinlj/Rnq5XB9
 Djm9331vIDD6ltm0H/qGo7dszPk6QRLPeRydxBsboSSFGD0rXf4nlB2bQ70QcIkTrei4
 zOcIsdVMbdX2I3a44WFafG3QiAYrjsxk17y8Y+t2+J3xrR55RIXh46XNIdpI8YqDqtAU
 luZ9qLwgGLYamxsQJ9K9yRLqOijc+pP+LQU6nTdb61ihpjJhR6kFXIRFImGQCl4o4hMG
 2Zbqz2maBv+CDSwKdvdFDJlCChZ8DHz3/CjLHfWIKhf7xhEJhns+U2HIQjOduC/LzPt/
 363Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFg09ORjAuxdTkZ8p0/au6D92lEbfLWH6juxbaIgE6eNZVHMZ3WZfbVEIPNj5HL8B80qq89w3A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8QZgWPNb8uhG9vrJmHsur5+XqblMEiWSYIarz/lm//1jL6I2Oa
 TmJgCAwh5U7TvTM/mI1QJ5uSJSdtnRyf9LP0fMy2HhZCusApVp6rRbrUWRvJZQbicbZke/aa5zi
 daT5naPE0BEAkS4KF9QRTel3T9k9yjCcz12jfed6nWvOZKjdakFtrK9wsHJOTlTcoNc6b0ig=
X-Gm-Gg: AZFdTZcF4/5amTGd+nvKSu3m1nfyvnWAhIf315TNRtuBCLexa+zoxZXPi51KaHBXvsK
 ZCkHOSL4esO7rFD59/PA2s5FeTW1G23YmTRxc94sut/CEjquZ1KAMZQORcgjHXxkxF05NtELh70
 sfBnAyS5KjsU/4G8iq+17yzOsD3a8CXo8/Ils/bLCi/RYlxK8Yxyy+hfK/cXgjC+Jz8anAt+dnO
 slqZ340yK3K01cKOnoPRa/MD7VJ/3t2pqnbrg5nXiq8vY4o3QkqtSgQXVn3/bBEPGBEryMD/ZoC
 xmX0579+EILidtcm7NizwNy4qjzW2q6eRQOX22G9KjYt2pP6lJHMvXyfcqTOT4xONdOIMyfcH5/
 kb9hVrc53aV8gnTd5D0RzU253woYlvVBkNL5/Y40rL00+rfSJLZ9F0xOV6624isyU5yrUEEHDS6
 FKvaJKid4YDx0whX0RUSOIfYU1XUNUL6t8yKk3XYJsiCcXCNEeo4vKQWaiIz3MJAy3Bocz
X-Received: by 2002:a05:7301:1884:b0:374:ba43:ae2e with SMTP id
 5a478bee46e88-3856f65eccamr14680437eec.14.1795538858818; 
 Tue, 24 Nov 2026 08:47:38 -0800 (PST)
X-Received: by 2002:a05:7301:1884:b0:374:ba43:ae2e with SMTP id
 5a478bee46e88-3856f65eccamr14680405eec.14.1795538858207; 
 Tue, 24 Nov 2026 08:47:38 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:37 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 5/9] qcom: smem: ignore partition entries with unsupported
 host IDs
Date: Tue, 24 Nov 2026 22:16:56 +0530
Message-Id: <20261124164700.1606518-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05bfab cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=LocVffI35S0ainJqWQMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: RnDBKmMkRCgKcCREW5w_VnhEs1waHrOu
X-Proofpoint-ORIG-GUID: RnDBKmMkRCgKcCREW5w_VnhEs1waHrOu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfXxc9UhaxtVzne
 QZXCzXbrB0SXpYAUByxES55lftFMnRe2swg3Aigs+XuXjRKYz4JKXAua43h4A9k9Ov2WIFcSV2I
 vTMw0zebnGD8pr0YS8HFMKJrhPIOZFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX1C+drUJxU24/
 uJEOzYoCCwnbc2ZhvBEC+IUS/Uzs4QSafBaYSHuSWLijS+sx2AoRqYDcx26DIDzxMR9DHXx2Xim
 yhXu7S3PU/QChGpyRpF5AhwWyCuHdvbIhCsY20RJeINK8wOQdkMScKTZjOc9pFJI/Cqpp4h3M69
 nXGY72S1vWSzo8eIwwUHh6rof2QV3qxEt/3aDtv2a2PluD/QW4mfF6/AIrC0Ar3Kg3tvMXttSpN
 loo9XTU7dWo3XaGnEEzqmQgTyNVA4y97aZ2+QaEraOEE3VLGEV6DZ6ksglb4jpPUq1gbMyIG1gD
 4Sa7znBgoWjsX7SuUCZlQpQuBME9Ph6qj/maigeTSVy7CLNl8Su9xeGkK577HAx3IciX4j87Si4
 dRoxtfyqXkumCmqqNv334ndgEOUlNS3D6VJ/7idl4ryq+WPtD9tVI6GUK2RpYk87SUn8Ywoapil
 qoADRzudoiG0AQMKewA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

Shikra and other newer Qualcomm SoCs report remote processor/host
IDs in SMEM's partition table that exceed SMEM_HOST_COUNT. The
current code treats such entries as an error and aborts partition
enumeration, preventing SMEM initialization from completing.

U-Boot does not use these remote partitions, as all current SMEM
consumers access items through QCOM_SMEM_HOST_ANY, which resolves to
the global partition. Supporting the larger host IDs by increasing
SMEM_HOST_COUNT would unnecessarily increase the size of the
statically allocated partitions[] array.

Skip partition entries with unsupported host IDs and continue
enumeration of the remaining entries.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e20523e2cec..7a5a43e1274 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -936,9 +936,10 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 		else
 			continue;
 
+		/* Skip hosts we don't track; other entries may still be valid */
 		if (remote_host >= SMEM_HOST_COUNT) {
-			log_err("bad host %u\n", remote_host);
-			return -EINVAL;
+			log_debug("skipping out-of-range host %u\n", remote_host);
+			continue;
 		}
 
 		if (smem->partitions[remote_host].virt_base) {
-- 
2.34.1

