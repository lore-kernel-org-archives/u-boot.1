Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29AFCA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 928B540553;
	Mon, 12 Oct 2026 20:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9JRFVpjVGPo; Mon, 12 Oct 2026 20:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FB7B4054E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836725;
	b=q4TEGmoBe9ssE2LwF4JPzxNpYVYPlaD4hvNxNY0eWxsRkiEkeF1YNrws+Y1hbJgWya+y
	 HW1bhivIi0EDrbHPa1kIEy2VXxWo3izQuGQ7T4SM0Zur/ALTzG6Aog/Jsuc7Tpih/L662
	 OC31jqBelAqnE3dZJoXEKyoySPPoyaq7JBYNV9mx+w05WqljdxC0E9GMOkTT5F0FEmAuQ
	 VWOOTCCs7LOod+tWpBcEdQxEqtemeL0mdsINjwq06UluqG8LJ7rpwJgyv5WHCQY+1lQkj
	 LwZpdke7rh0n3wOgG+3tB9o9HOdr5ZAJNG0JinYRgXfGnWf364NGEKKdAS2w6hyKrUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=76PmVEFqxotWnWvmruqRaVbMlUWMxVzb5uCOWwXk/YQ=;
	b=ZiRqoLZ6wbXKvioIUcfxuh3uJi9fv7nr5CTd++ccdu8vt6QNgpzXieTsQAwgXV5H3yr7
	 5onomiE+DrCsGx0eMtbVnycs3dqpv3t/m8wQHmmltcdLK1GTbeEYSs96vpU6UNl59gM/U
	 CZ+CA5UgWMFjrSikZ2qB+zinUJINBwzEOZeAg9AcYzD5U1JdNKV+9QELlH3+3nbnwGO62
	 Tyn1UvSSQ6BTEG8zXNaexonSoop7AYaI9BOuIYKk5VGFsVuIdLWSH7Wpp9Wrq3hdgGL8i
	 I2jlwlRWkW4wlBbBv0ibgSXZce2narzZMtEsmU/SuCZTkhmS4DttFjMOf79QFfvXrYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836725;
	bh=76PmVEFqxotWnWvmruqRaVbMlUWMxVzb5uCOWwXk/YQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dXbm4du3VxFoHLZ9J/QMHmpJJFHHppygFGhauoDLpFwhQmXMtxVwNWZTWv4fiuSiP
	 nrv4R0EgGn4hl4mNxxcvRW5QHK2PPZMPpj93J92UnId17iJR2gI4VsbqA7H62KrEXV
	 BEqYk+N0Gec9imUM9axgYVW1DbkMxT/JE6TLaT1b7+8anHjrU/O0A5KOHeeHpnm5hD
	 GZTlwcopWxb7EtJKMwJsr7rT6Zk1PdVhTD9kk8drFOgO9mXw/0uDedb0ossLKtFd0j
	 /y7hxa4QaaPa9EnUxP8mgTu/Dxhvf8fdWcpeKOTXDg212L8vs8Xfy0Ct31DFMvesLs
	 ztuimMBdNzy+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FB7B4054E;
	Mon, 12 Oct 2026 20:25:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0E7731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 895E760653
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeqpUffQ8wUk for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64CF160600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836723;
 b=nEXSvcXXItRdDMNa33bOgFYROOjorBBuHyvQl3P4syn483q804B8DnMK2LbROjB2DL6T
 SOZdQXYPe5CaswmUbnyf7oa+wHb0Wb+dOkTYLXJTUWAKOSqcgPXFGeLbWG41wxatndhuX
 nCOeUqkg2YTSjmorQP54xgZa4HkXhZcevackQI+vvl3dlMaSPh23CDlyG6mTxIHPW3lA2
 nh6D+aJCxSGPbfEQl3c5QzlIWpPtunACnCfPAINHeHwUWGJhXTAW3iUaybbyo4NHcafx6
 O94Nzm+qiOyx7OCEHP7/eiDUwgTNbdyR6TOaRTqqL6CQWormDP/EstYRyyiII344Gew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836723;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=76PmVEFqxotWnWvmruqRaVbMlUWMxVzb5uCOWwXk/YQ=;
 b=hpiUjxuQwrnI3jwzbSEN01MTvY+8/ApG7B4ZP6q7A9K4xnDjCQWfUsXwoTg6Pr+okYCV
 s4mHwT100YRK0w0Jjtg1+4iJLEXEZzL+rtDvDcLJJeNY/iprlrOFLBQJDaCW9sSlu78iM
 t7UafX8FozZyUfj0x1aPISylgn9sRXEPNoKGCUkdGr8rWMjFD9VFMypxSRE6TbvOSpFsZ
 L3xqLqWjKK+0X4QLPZu9GmBesPPUEoWExFAs2xBCa0Z2g/TV+x+WA190/KyzRAu34FGkX
 KAZTYee6r4pVgOSBz34LWr+sJsM8vd88E1RLCfkCglYO8qhf0XYl6ab75lFtEInoesg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hnTs8nQp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UUndG8lA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hnTs8nQp; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UUndG8lA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64CF160600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMtAh2211070
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=76PmVEFqxotWnWvmruqRaV
 bMlUWMxVzb5uCOWwXk/YQ=; b=hnTs8nQp72utIXrrfj/EWUmV/NZ+HklK+MJKun
 nr2pj4BvbBatc9khQny1r+ZHw2A1sKf635xYy0vSS6cB7ZtWTFFAlXen4eHsGE83
 dyN6MLOLFYmdzJko4bU3aM6f+lznKOJJp3NNekUmC4vyt5Nx/JahilBeF8U02eoG
 bDPnjuZ4F3h1CYrx7zVJ07GGw4U6hANGfLkeKF20YBMmJMdDh5RG5lxCSsOT3Vut
 h4Z6PTULcOoKHtLv6P8I4RczEh+oaEeGSEZRpg+vd6hm1FDRHtJwxHS72b7goa6c
 /R51Nxh2McMXn7L+wm9+07cyNz6sSxk17+F1J7sQzIWlL66A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aerw99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so11263436d6.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836721; x=1792441521;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=76PmVEFqxotWnWvmruqRaVbMlUWMxVzb5uCOWwXk/YQ=;
 b=UUndG8lAoUuaGd5GfiQlVXaOxkChOa3pOzvPAu181TI456Pm0uZJ4kyCY/mt3MSaYr
 tCLeFnlrk/IiuWCVaOvCROqqIf7ItwRV0USyLkGe1UYuRUS1646N3sUt9mqtM52005NP
 okN53faaFdByxi0LjRBbtZ0l+Q8gNZQr2Y7Ticn9kH2lQdeqevaO1E7pR3r1ivXnJ5M3
 jxm/+NEmt2ztIdvvrDpqquQ4pa0BoanUgrhJgKe/bg77J8zrk+IRX1q+NTgndFIGVhKe
 5XhjtIAdyqKvLAiPWeFHYu+dCFQteK9DROQz5AZbAsel6ffJXO1ZQl4UJtY4xwnal7to
 +pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836721; x=1792441521;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=76PmVEFqxotWnWvmruqRaVbMlUWMxVzb5uCOWwXk/YQ=;
 b=bORDdkcnkD9//R/X7wpgzQ8frq5BHPDpe+4TCE4JtOS9VoqP+ZHuHAXIGJK4LKGxLc
 IIoFu/6IZv6vm5t4HJR0FfGX7rexPjX271pyq/9yRgelfBBc0EW9xRoJ4QUApq9n1K/k
 O57z9Xu7TOsWIGO4omEREfZFLDj/Cw6AQPRJPPm+SJjrXW4fs44w/Hk8EOIWA2JcN5u9
 spdeSwrbOHmsZ4u6o59YnMV+Et/qv1QGwXUNwqrJW/uMQO3hOZPCwRbEUvKDOV7XV4Hu
 ylly+rhkC3ZzsaYUXdk9bg8j/I2Ln1+RFQK/VwK3r1esXktpwHAtTg3h8gNNK36bIvdb
 b4hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu/N4IJLKFKaIvUSG+ideU/PTv4vfQhb+pWjlis2qHEo1recOAlINy+6rSZZN7+sN+UZv/EIM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLutu1qryeiIMRIL3XjDXbrCJpN/V41F51DE8HXSYAPAfL2CZU9
 bhS2MPofJg2h57U/UijIWlW3LWSIVqGDF5TX3qm73bxL75VwsLkWCamqyKGcmMVldnv7vGctTvZ
 VoSwLk2FM7RoXUzOMOr2DLKfpTJs4vNWhwYTQ/L6xTgBMpZnObgQsaguPGwzVSZzcgJqxWiwknu
 EA84rtFPay
X-Gm-Gg: AYBFou0zA6CB8oo92uIT7V4MBhD4Xm5Enpg8QXM3uGRmrJq73OWA60wDlXQV7GZGqqt
 5qOxrbw1vU+YQbP5hJYpUBTg6CkW0gHN66B59s1p2MsGyDt5peKxafP7LCaRjGjfPs8nq+vpfhm
 UyaAAJ7nelniupPHo7JgXqO9RdQqjq0cWKhlAvmZ5KxbmkM05zdQBtyUneqBwDfZhI1LqULHkg0
 z6NlGM6rcbiK5Ou4OlG295THL+KdrBoEuv/UT0Mdsg1qR0Nn1SSYB4511Fgp7h4BSVzHOUFZo58
 mfc4ccTEdKwKhGIRnXXxIXJyU2N8xZ0kj8lG683Nuvluu4yu9TdpWuVSJr6mV1mKntTdsK4Ai3D
 LDmlUW/hE/CNQrQOzqCDv5/ZM8xgedTTyx8MISRl8VtH/
X-Received: by 2002:a05:620a:6cc3:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-93ef4f405e9mr155737985a.39.1791836720472; 
 Mon, 12 Oct 2026 13:25:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc3:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-93ef4f405e9mr155733785a.39.1791836719826; 
 Mon, 12 Oct 2026 13:25:19 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:15 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v2 0/5] avb: device lock state, root key provisioning and
 in-place verification
Date: Mon, 12 Oct 2026 22:25:02 +0200
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBREr2K6tqStpVFX3sMQ8ilfqQLFftpoC
 HcX8AJuZvKSyZuJEQaHxM67iQVMjpzvF1D7HbMN9Hfkrl6YKaGMFFLyONAYEDoOqSpbb59l7Le
 qNK8PoIyxR3GqNVsMQ8Cbe2/2a/FjitUD7bgq10XjaPThs90nue7+e0qSCw46B7SQayHNxRNlr
 wit9V2XLcGKeZ6/sOsc3t8AAAA=
X-Change-ID: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: DDcQeri4ENd7L23AHrEBOuj5Q5ThAjhJ
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acd4231 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=g2NrrMGdFzmtCDopep8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX5u34nYn9A/W8
 KwKeppg3s3ygN/LCVlNiG86nAhwJB0PpKkTMo7okJn4ljHwgKTNH2yHlboWFc1QDmEN5O44Yhig
 s75I+/gdxTSalnaF1Np66RjVphmPs6w=
X-Proofpoint-ORIG-GUID: DDcQeri4ENd7L23AHrEBOuj5Q5ThAjhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX+yRk9OhULfF4
 A1UPFTZCyIYDSJDdQ9f5jBivT68wiHkHHoFk4FB82yIr5WecJaxqXPnvsz4TxuUua1F/GOAa6Sn
 1q3qCpxZ/5KNu5mncTRLeESDjLcgKNG6rKEe3OidAOm6lJPi8m7L9c13emXx8hFofN1H3m1zWXF
 z7uIvab+MzhbAnBdEqpmMchJmU3EaPBwEINte9LjkmGWQx5tLV8gL64BuqpTXbvQw5hjysLV+uw
 A+OKl9+rTX+4XSbCDsJQVqDfWHYU7bDzaB0DCfzV73pBqoxO2FEjA0KBxuFWf5cYofGW3ZHYiy6
 4HsxG5Nym0jLPjw2WwXxSH2NVy7Zq1rJaIplX0b7wJex0PjtTq1urNwDK66HG64N4nW389ykdKU
 CUT7ymKhZUUT/9E7Cxyg1wcvk0x3Vnv9X/EV6lqS6BWOmAdeUx7qDh0j/V3Vq395cXlY1M82o66
 434cWfjG0OcbmWQrrsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120081
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

This series completes the device state handling of the AVB 2.0
implementation when the state is kept by the OP-TEE AVB TA, and fixes
the way the Android bootmeth hands the boot images to libavb.

Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
"avb write_pvalue_hex" provision binary persistent values such as the
SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
consumes, and "avb lock"/"avb unlock" set the lock state through a new
avb_write_lock_state() helper. Until now U-Boot could only read the
lock state, so a device backed by the TA could never leave the unlocked
(orange) state.

Patch 3 makes bootmeth_android verify the boot images in the buffers it
boots them from, via AvbOps.get_preloaded_partition(), instead of
letting libavb read, hash and free its own copies and then reading the
partitions a second time for booting. This closes the TOCTOU window
reported on the list and halves the amount of data read from storage.

Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
"unlocked" variable, so the state can be changed with the Android
fastboot tool. Both transitions erase userdata and metadata before the
state changes, as AVB requires.

Patch 5 documents the root key sources, the provisioning of the TEE
digest and the lock state in doc/android/avb2.rst.

Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
17 images: the chain boots locked (green) to sys.boot_completed, a
modified kernel is refused, "fastboot flashing unlock/lock" over
"fastboot tcp" erase the partitions and flip the state reported by
"getvar unlocked" and "avb is_unlocked", and QEMU's SD card block trace
shows every sector of boot and vendor_boot read exactly once.

The lock state is stored in RPMB by the TA; on boards where U-Boot
serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
There is no build dependency.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v2:
- fastboot: guard the flashing_lock/unlock/get_unlock_ability prototypes
  with FASTBOOT_CMD_FLASHING. They were declared unconditionally while
  their definitions sit under that option, so every configuration with
  fastboot but without the flashing commands (sandbox, sei510, ...)
  failed with "declared 'static' but never defined" under -Werror. v1
  was only build-tested on configurations that enable the option; the
  sandbox CI jobs caught it. The series is now also build-tested with
  sandbox, sandbox64 (out of tree) and the arm64/arm32 boards that
  enable AVB or fastboot flashing, and the 107-column dispatch line is
  wrapped.
- Link to v1: https://patch.msgid.link/20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com

---
Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

 boot/bootmeth_android.c       |  73 ++++++++++++++++++----
 cmd/avb.c                     | 141 ++++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c           | 103 ++++++++++++++++++++++++++++++
 doc/android/avb2.rst          |  69 +++++++++++++++++++++
 drivers/fastboot/Kconfig      |  11 ++++
 drivers/fastboot/fb_command.c | 119 +++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  34 ++++++++++
 include/avb_verify.h          |  39 ++++++++++++
 include/fastboot.h            |   3 +
 9 files changed, 580 insertions(+), 12 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

