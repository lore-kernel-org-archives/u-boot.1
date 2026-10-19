Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DB0CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E7C240755;
	Mon, 19 Oct 2026 10:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30jzOoxKbXlb; Mon, 19 Oct 2026 10:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E7BB406CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407095;
	b=Wa37soEpTb6gdHwmDZsJbXFnUJxNVD+6Klu2Y51TdtlkgQFRAGoWLD/A6FLwMsMujDrN
	 /vQ4CS9h/Pslnon+Vl8RS/gny5R4O5ewHd9RoSIwOxJTMTIcddsAh+zkce1Lyh2jV3/Z7
	 nnnOVpO80vDYtSp9Jlc701TdjNCAwAzIko4L0KzOdpMj6XlyJbjyadC1/CyNEFX9FfW5R
	 WBg1YS604wfaq1WDMcd26VgfwsklockEMv0XV3rT+4WmzI4FckDQCc0dGkuUQb6+LX1hQ
	 upcj+l8FKmHmOkxY0cIs/8w2wUffYnkLfIoNSusle6RALdeW8T7kNGAKdH/w5nBASBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=;
	b=YodTFegEjoQzpyEdxoKEpVzwmHen6jSXXETaqOmvFZHY1rqhPUuMtB4qpggtSvWVWAed
	 ZzrJlteCpAOjVlggcJzGmzuEeFU58EB2OqHEb+9I8na8iJx7IO7N3KS4zk+AKqYRASZxD
	 KodRmVXTeZp/HlzBNewXKaXtO5T0P5obi4STx2by1cLVPBVi2CPPBJeqGmi1ul12C4QHX
	 h9K5qZ7T3A62KVWHyPc4j1c0CPeCaAOOXYaaTB4tzKysjZtajEVoHRvG4+sJjoigRt5f/
	 8E3lSY9R8zker/3Qmy7Q0445AZ0fT+gdlK4qEg4+ZCH8FaR2tSZCVI2Jh/kn7vtBPNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407095;
	bh=MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SMyNgIKG/dqUg23JGcDt6tl/BGhGEYu0qVDJADQNUVgEZzMNg/Dg2WeXkc+9uesca
	 usLlHJmwDYE7+Tda1MDbnfgPTYvaxKfryv0iTxx/gcIn8CGfLMPFr7EchzvCIX0+1w
	 4Lhn7g5wlSZwfbTE7M+mp7Xb/wB35N8UmzQ6EyDazXIZtXfUYfHza6vf+mbw8AePH6
	 nL0hXGHXgTKZmiSzTvSpaXkyV6eTAS2pEZNmD+j4y/Qul9fGhKx5diumXv0WbmZNDV
	 Fi6GeqD4ZJ9q0/ja1cYH1DR+afuQXjvMIKLsc81/XVkXrmO/JSizlarNe37fgj5/y1
	 fotSq49T12J+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E7BB406CA;
	Mon, 19 Oct 2026 10:51:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54836D7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B37440080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4UZQMc15H6r for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62155400B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407093;
 b=eYuqmPio7tjcdMQ2TeOGf3QJNK+fyrn6Wp3cLRB8f58MOF3ADfHubwQuzT1zwipCXnXU
 3FIFXGgkTWh4Dh3NgSvjbCCqYGaplRe/fHFiYiTwLyWZi86yoEEASVYy0VujrMjCQ9AIG
 /48rj9/0zpUpOaOiSPVy1nO7A39/EV40hAhAgI349sk6rPKVhkGXdHOaSWvSKxLE5C8QT
 1M5xJwebkow1piYJBUBZkCCIUjN0YeLQXorLfbwTYrppY8E6juwWtRdRxhav7sdeqYdou
 9y6xE74dB3nWFjQDeDMZn004mU0ilz0bsyM3TEyhLstAZ9DaaFPghYIpMy/CigJKR9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407093;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=;
 b=GZVyaeKNPoJpeyRIcLaffie8vOavWySQ5Y6BBq2MiJdH6QDpkKThRaMOy/kLcUpX7Xe1
 xLw/AtRSB315aB3j0QSSc0ZAhUnTfGSr+dxd83uX1G3DcMWbSJ9AIlux2Eud+m/9/Cgmo
 EqeimaH6iro3fu3rVHMesUGIQGtB/YYqrLGDn45UkVPPE82i+h20Ffk2zvtM1f7BX8Xof
 f/zOEkFc59u1AVFh49smFiNyxPLncLE05ettHfXmUxPVZXhjSBKGjwB6YYsQb7SyEQZ6Y
 8KW41ES+l1+CvDwd3XUkUym70rUt4VdwiI3QRa27GiOQusgePb217CBe0z/o0QjQ10w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BaGFvewV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fea2qYai; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BaGFvewV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fea2qYai
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62155400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P4kJ724618
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=; b=BaGFvewVP1TEgSas
 E4Tee6axSXoHlBWUP+fBBLNyjsR9SCg70rYzApIILE31C/t5yfCOCaiEw/IPiKZv
 slIz34LO32t4d9R879eGa/smKisqiZInHXQKS0l5xGV3rUoLhk1NTaLGej3ufflf
 ICiOQkCkOEhg+ZV9vO3D+dun6nuhvT+uaQFG3Ynh1y9RgSTh1KAcVdhwg9HqYZMP
 OSiM6tXzyRI1umNQwRjLS1WvbmC3/sxsDPZ6GAU8bBmLg1TBhvBK8UH3PB6PeMeX
 4pliHGDqJiLa1jNogx+NryWiJxhAnunbX/mVm+R6vRw6mZM+x2gfhMhRjIew6sDm
 LQI6VA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gp54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso5423738eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407091; x=1793011891;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=;
 b=Fea2qYai60y830D2C22+jaY0EuQd6NS5WyLoHQoc0aRFuhK8gIWAnh0y0AmoT+DrUD
 eb31d/EyenriAW0N10A/I8eQIiWO3vthkTyzbsCgZHyuA9wpgnF5y9bSM5Gsos7QFo4P
 4tBqTdbq+Vc8Lp4drUzprzYwzdLq9c8N6p14LlL3OvMyOTESWF/0uQY0Mpk8Ak/taEfX
 4asQFTj/FjTpNReq6nUH1euPMQdQyAfxfXv/CVs8s/8Cxp9Z8a6h7Iz/xCp9fWZDkoVH
 4S6MHAuEwX6QQnSVronbyApZiG+C1ZmfidVGqPQmoKLpNs7jwr/YpF41RdZppOa2Rh5r
 +SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407091; x=1793011891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGSvVn1A8Zl+dPauj7vuemW4BGVOsUtyWEAfes9U0BI=;
 b=L4vWug+b6h/4QflgcvkqAJ9GwOjRauYH7irYVNxeIkZFGjRs38DS3Z2xXgD0RRialw
 w+7pf3NTrZ1tAPNuo34VORGHL0yDtymnzoNLE5Poj/lL70/TuFCsfd7/wS0QthOar9vz
 uRjFSb/xXhoEQye1h4K8DfQRYTIUeqBAyITOlz55WYuyHK5RszxmJPLyk8ChXIBeKWhw
 llfBdkhrWAgBzUxhmcJXpVNCGhdfBt0KOLSB2e/q4lpARnYJrsXlQPG38iQvT8YIzABi
 MNbfMwRm4riOl515E1MEmJj8sLdEaE0s1JMPHSt33mkkRNRF/EOj0hFk+ds6mEqik4l3
 lgcQ==
X-Gm-Message-State: AFq9FYJnVtLaIsbWmhWYKht8KSnI85WRHPKwYn/Y3FF/tDmg2iAqLnPp
 N1ZFvhNG64mmuimgSfHO9Aa0uAKkHD/RpC0FaBoSVL0vun3VT4H5UbbfXtWasEz9G7B9OpEoxs7
 8NWRR6CuvlWZy5AdXquoqNqEmwGPhSv975pyL4Y33Og5D0YnheT5FvKiUJ8yvs53Yyf9WDr4=
X-Gm-Gg: AYBFou3gFTLMhzm/nsGFdFWq2DzWS9wiV6zxxK5blp62najdXd8LlhPIIeM+hfO9DaW
 ehSmjEuqzf/NVKQzCViqrJJEP2V1IS07imMxLvLuJNYUo933fLY1sFrfMVRrOWsduOtadbv9Q5P
 wFEPWUjXZu3Ff200HZnVLkBF1s4pAdjMGZmnLqRDzsWOFQp99NL/gOz4vyhkcpxASyuk8P9sObd
 wDtgCiUwZU4Nw9Va5NzaQoBRaacEzhL+ahQVm88AyuAedy/aR5rDDpDop0+etNXB0hOgGptfkC4
 IhS+JQS1t/Ap1CVdR5bvJpKEqO87drCRwuLbTkD1lQPV1hCy8lwEPutwtSFMxtnUOvma9oo0yR6
 OHPhpvgHch+9qHELOzLeI69U0c9o86Nw305D+bf/jEFx8kVKZyvClWQOmiVGvnYMmqArSglZ4vj
 p9UdsrQ1UZiFhsupVsXEnPUdPdWqoV
X-Received: by 2002:a05:7022:1508:b0:143:7001:7645 with SMTP id
 a92af1059eb24-185151be2e3mr11635831c88.47.1792407091109; 
 Mon, 19 Oct 2026 03:51:31 -0700 (PDT)
X-Received: by 2002:a05:7022:1508:b0:143:7001:7645 with SMTP id
 a92af1059eb24-185151be2e3mr11635784c88.47.1792407090530; 
 Mon, 19 Oct 2026 03:51:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:51:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:19:04 +0530
Subject: [PATCH v4 9/9] spl: ufs: add partition-based U-Boot loading
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-9-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=6733;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=h+M/zFUw4ugA4XGIIYemeEIzcDYKsUK50AljcKT7Q7I=;
 b=XDJyelrb3oHOvrkY1UrGPGVvV8UrGfRH780I4xN/Ioqb38aDXzbOrgA7mec6w+d8IWQVBD2SV
 833pUPuCUMrDc9zdJo5T99k9J/m3wTRss5o0X06ViXv0HJ6lP3WAZJv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXwdVWge5MG9jX
 GqAapn4w61Yl2B9viGJ+vl0076w0GZHcTwCdzllLjUHV8XNQ7vEFJWVbGVlgZn4tnZ69W6b6qw4
 faHjq2wy56gQgHMlqI5cPqyfpglFG3M=
X-Proofpoint-ORIG-GUID: oxyunyODMPfECS9a0A7r7Bb-We3pIyss
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5f634 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KL21IebutpBlNCngNpcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX5JMkLuJUgoJ/
 zJe6lNch65xhtnx8Cgo1+Co3Z13rXdBi6HT3fqpHTiHvk4K8VrmReWoSRBpJo/BurZsOQS34cTi
 yHMk0Ev7e+tg+LP42S8lWRXxQMayygR4xG/XOe1KY97o/ki/2/K9p9pEEQngAIGi4aTmjPjJRwq
 91RiV9r1/2FsKbCWxWsoRmqgzeXN8ct80PMqG13Htp+qcyzbXTYfxa19ejiM9VuNe8KfAW3U2t/
 s4/jX4NA76iPeukiGw82lc5OH5trmY4Cf64v/fo4sRoogxh/eJMpbunhctFctlMBSfrtCPmu6tW
 fJNZA05XSyu4nDk8nWmb7lkSw+bSTiW4NBW1Ye+EvrKNzQpdjZbuSUloEAbXUJo/44IJRJ5k9pi
 TJQAVpnFqRz26BjX+hUssB8XwtvswgP6o+TVMNX9jQtBO3kGHeG8y57ETJQvEWs0fuubNmF6OjG
 x2ZOmHptEvy7+oTDwaQ==
X-Proofpoint-GUID: oxyunyODMPfECS9a0A7r7Bb-We3pIyss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Refactor spl_ufs.c to support loading U-Boot either from a raw
sector offset or from a named/numbered partition, controlled by
the Kconfig choice introduced in the previous commit.

The monolithic spl_ufs_load_image() is split into helper functions:
ufs_load_image_raw_sector() handles sector-based loading, and
ufs_load_image_raw_partition() resolves the target sector by looking
up a partition name first, falling back to partition number. A new
exported spl_ufs_load() function drives the boot-mode switch and
can be reused by other callers. A weak spl_ufs_boot_mode() hook
allows board code to override the default raw boot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes

Changes in v3:
- Renamed h_spl_load_read to spl_ufs_load_read
- Simplified partition selection logic in ufs_load_image_raw_partition

Changes in v2:
- Refactored the codes in common/spl/spl_ufs.c to use helper functions
  to make the codes readable and clear
---
 common/spl/spl_ufs.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 134 insertions(+), 19 deletions(-)

diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f..dc871d0f22f 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -3,15 +3,19 @@
  * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
  */
 
+#include <dm.h>
+#include <log.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <scsi.h>
-#include <errno.h>
-#include <image.h>
+#include <part.h>
+#include <blk.h>
 #include <linux/compiler.h>
-#include <log.h>
+#include <errno.h>
 
-static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
+/* Block read callback for spl_load framework */
+static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off,
+			       ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;
 	lbaint_t sector = off >> bd->log2blksz;
@@ -20,30 +24,141 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
-static int spl_ufs_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+/* Load image from raw sector */
+static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
+				     struct spl_boot_device *bootdev,
+				     struct blk_desc *bd,
+				     unsigned long sector)
 {
-	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct spl_load_info load;
+	int ret;
+
+	debug("spl: ufs: loading from sector 0x%lx\n", sector);
+
+	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
+	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
+
+	if (ret) {
+		printf("%s: ufs block read error\n", __func__);
+		log_debug("(error=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Find and load from partition */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION
+static int ufs_load_image_raw_partition(struct spl_image_info *spl_image,
+					struct spl_boot_device *bootdev,
+					struct blk_desc *bd)
+{
+	struct disk_partition part_info;
+	int ret = -ENOENT;
+
+	/* Try partition name first if configured */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
+		debug("spl: ufs: trying partition name '%s'\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
+		ret = part_get_info_by_name(bd,
+					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+					    &part_info);
+		if (ret >= 0)
+			debug("spl: ufs: found partition '%s' at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+			      (ulong)part_info.start);
+		else
+			debug("spl: ufs: partition name not found: %d\n", ret);
+	}
+#endif
+
+	/* Fall back to partition number if name lookup failed */
+	if (ret < 0 && IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
+		debug("spl: ufs: trying partition number %d\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
+		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+				    &part_info);
+		if (ret >= 0)
+			debug("spl: ufs: found partition %d at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+			      (ulong)part_info.start);
+		else
+			debug("spl: ufs: partition number not found: %d\n", ret);
+	}
+
+	if (ret >= 0)
+		return ufs_load_image_raw_sector(spl_image, bootdev, bd,
+						 part_info.start);
+
+	puts("spl: ufs: partition error\n");
+	return ret;
+}
+#endif /* CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION */
+
+u32 __weak spl_ufs_boot_mode(const u32 boot_device)
+{
+	return UFS_MODE_RAW;
+}
+
+int spl_ufs_load(struct spl_image_info *spl_image,
+		 struct spl_boot_device *bootdev,
+		 const char *filename)
+{
+	u32 boot_mode;
+	int ret = 0;
+	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct blk_desc *bd;
-	int err;
 
-	/* try to recognize storage devices immediately */
-	scsi_scan(false);
+	log_debug("spl: ufs: devnum=%d\n", devnum);
+
+	ret = scsi_scan(false);
+	if (ret) {
+		printf("spl: ufs: scsi scan failed: %d\n", ret);
+		return ret;
+	}
+
 	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
+	if (!bd) {
+		printf("spl: ufs: could not get device %d\n", devnum);
 		return -ENODEV;
+	}
 
-	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
-	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
-	if (err) {
-		puts("spl_ufs_load_image: ufs block read error\n");
-		log_debug("(error=%d)\n", err);
-		return err;
+	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
+	ret = -EINVAL;
+
+	switch (boot_mode) {
+	case UFS_MODE_RAW:
+		debug("spl: ufs: boot mode: raw\n");
+
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_SECTOR
+		ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
+						CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
+		if (!ret)
+			return 0;
+#elif defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
+		ret = ufs_load_image_raw_partition(spl_image, bootdev, bd);
+		if (!ret)
+			return 0;
+#endif
+		break;
+	default:
+		puts("spl: ufs: wrong boot mode\n");
 	}
 
-	return 0;
+	return ret;
+}
+
+/* SPL load image entry point */
+static int spl_ufs_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	return spl_ufs_load(spl_image, bootdev,
+#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
+#else
+			    NULL);
+#endif
 }
 
 SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);

-- 
2.34.1

