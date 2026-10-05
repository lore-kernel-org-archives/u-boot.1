Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA08ACA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BC5F4065B;
	Mon,  5 Oct 2026 07:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjlFiKH6kukI; Mon,  5 Oct 2026 07:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E317940687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183986;
	b=XucKdJSXoXxiVERK8e9g4+DXzIAkDXnJn28U0rzkhDZNcQj6EpGHCzcp5TtJ2Bz6a5P9
	 1aH+WCAxRBQgeigYhyjEZo7NdEzhQPKtY3yqaOQC1eeAzISNpMMeWLRKmaNH/XShbrZ2G
	 1RE6YPZDyy2nS3yNn7eXlYg0D8WDkDAlNoZU5zDRT8gxnt7jngU3UvNF0K2PANILamJHH
	 w5umu7b+cARncsj4cbXii6HNMkL+nxVeYbdDuVltY4S2f7OxHev3petHxElaEJ4b24t0F
	 ZnZgiAJZsaBIuOU4DSJs0jsr8wD8OfsAjCLSkX+u2DAsEFMNn2aB2DAEhg7AyWjn6ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	b=rsw40WNsnFuNWs2glzoWKh2BseNOQlg9pdyrCN+l5nsGjSQqpZk97l7ICnM+irkbc8Q7
	 Ix6vncejWiNdHjBZ0Ezgh+hq+zm295IeIMQeXyCXK/BjM9ST62XdJ3alsLK6twthD2zgm
	 oxHKLAy2RlcWlVTjr0YUEbLXSIs1hWEZyyOei6f9uTyOuHskvR+GxHrHoqRvx0ZcWGxm9
	 QWryvEQrhfjGD+BRG5jzXGpL35iSTNd58ryCyjKdeGCNrLhcOJrpmZZdpoL8bCHUAwWJy
	 0QFKsU480WpbcWbKKyreJ3GrkmdWa+Qh+/q5I7EcWeq2uv3WDLHnc0X3Gx8eGf7RZTQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183986;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3+YeyrbcKBD79dKIwGAcEZJ2BAtrr7rgEhkeMfwZe9Cx0WLqdP7ZGdI9bzj4DLs5
	 P896EcfPOlh7id5QSR1BqWxqmel+Y9hnU5u6UgVYZNRwY3LuzMpNXypRU2lTUkE52v
	 ZxVU9S0ecIIVA2KPj4W0FGu4mh/0enWx9guxm45nPWQ/Y0sMqpuM7a4bewBx23vhWb
	 YkxzqJwPyIhVfk8xCU0pNz80v2drd3qm9E3yb4r75V9CXAjrQNAY+KnEuzK+n+wXbo
	 m516OFFTI5stUtGonlM9Cwy/ztVpvUWyzn+bphsxIDwNmD3SKo7Q18IjRXQoj9BqSY
	 wJSddbV7icofw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E317940687;
	Mon,  5 Oct 2026 07:06:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CFD21A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E84E80AAD
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftWRjCBI91p9 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E97280A80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183857;
 b=sLASiX/8zDilVNImd030mpQJl9nUNszKsc1geOvSmA0AnYc1B4NF8fsmPuNA6crF9+60
 TgfGG/b2k2zUwJ/Wf21tRkBlR70SW4Tqb8hV4NOOBLs6H4PsFSuAihtYyXddzLP1WP/6U
 rLTfkv2KFjSSSFd+bBEzTU0feEK2YVA30Kmyd0XJjbHVF0N/hzdOtABDe5ZyDpnfPYWAI
 j3FWz+CkXrOps73zFfJMb4MnwZ6Q+qx/8siqRPGB5BJpSLNEWfzNR8Cuk3qCDEidiK/xk
 7fP7S2oKjrho9yCUdBerU6VRZKTe4j7fe7pd2+zEsyoZ2MAepe/gw435SYUQzgQGt/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183857;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=oDbFfQqLuud7Bn7a6ouGD4QfeCT+ebnKhvqbwHAzJR0lKJTxnH5SKwr29bF3bA6rq9Mk
 sCjEh4uRcE28kJUPfLMXhjMEpN9tgZ5ieoasAnTRnNKPgDA6zL8Kp7pkAaF2NMEHeFy/c
 FRErqhN633fGJMazrICJgQL/unilpycw0XBLF7uq8GqjJynADq2d5AvG994l17A97DGGp
 VEV01i/GckI2W/BoMYn12otOb7kN5bPNSbJmMCDb95aX+Ii52I3QIzskmMeZu8zxYeMrW
 tlW1C0PsVdms+EH0YnPSE2xi3WsZ6yz9OB4MU36iz/lAXDIRztS1vbABP3XKM7a7RlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=G2GfKqO2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jz3AKg5t; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=G2GfKqO2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jz3AKg5t
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E97280A80
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695109pT470947
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=; b=G2GfKqO27yhNlHVG
 EtTDnY07BGhpzJr9t4xFtYr/BIVRpddcAaGFAJ2dtytrgSu9IU52Fwfv25md8xaJ
 5QpRgZr+Sq7iCNdeO+A8fIa+7/N7vT6p+RaxygaVvOb6fpMTVnukBGjsc9EVu5xl
 rn4K/0SN4aj/GE1F9O7+ChDLVVeiTyr0JSNuawi5hG2o0khjOvltkx4v6wZbDgoP
 XOxMGJc/jJdlrgy6PWLXRwtMlmyvbjz50MbWVH3IFsT43EWEpJOtu1dyPeIituUx
 LuBIBKzC70iwg3W+/prxdEaV+xB4r2V2jAZEsrfiixMmAL5dzHPc6W/FPZtksTkF
 PnVD7A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssucu3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:04:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so3748355eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183855; x=1791788655;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=Jz3AKg5tx6cTPlJetKUN0//opKnNRzwqR9yUoeO0LHqsBWiQw6Rhyhx+ZW3yS133zK
 Sh0RYKdU1XwGas1kR+tni6yRi/w/71oxpX8umAgz34iAhGH/e9aiXZdfkuaTxKhOw4X5
 eCv7me5JL1THp2FrlqLsZK5bgFwZPVFjvQ/EQuKhj0rXMKDSqSaLJbHIXfdlidiT+hoy
 6fCsuA4ah9ydeeptVtBb6eQWrBooRIy1AnsM41UXcREXZ+N2c2SFL0Mj6hZD00DzoeWC
 qTE437pU2zLisNBtWLu7aEfc9HmT65lCMiLepZNsgYMgNWunbWujwpp+1gFjvnBnpdt7
 Slvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183855; x=1791788655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=R49jS8fi5PLIc8ts0wbNylqXpsfSRMcRYpw2ZpuW6zZf5+L/K7LgPOB0FGpAqF4Y0e
 EegmkUWkxLAiV8mdjKK9yZC1CGid3Bp5ucaGwPRq6oi2uw+Uaa6TKKS8xOhb8C3Fgab8
 vkMFfD+wfPsHpd7G1M6Lx3BEp2liTe8QpwRnYyNaTL42T7R+USx9noMBeIDuzkdc/p9j
 gDnoqh/m/wpnFkSN1W80qFmvMOAcO1cWJu0ac+g1/++Ca+US9BbfhX6lReLuYVxpoMlq
 sbHkHlWmAwT7arCTHNqKCZaNS41FpLJDdTMBXvFeDXvbFCyM7i72YGKg1KLXvC18eB5X
 PDuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx97NhIXlSWAVKC+ru3kFVkf7nCVXmkbUJWsBx27DGo3Z+Qhhd1pXOLdnK3Ti2iW7b10IAtwWA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIf8f3kHrjuC01R8sCdQocbelZtvrle8SQuJoTWpyqq5K3hhSgU
 o3JvWoO/RquyMs2YYyfT6ZpuxRtMRI9mCcg5h/+IggLXe9OEOhJvjfjLf2x5V2BqKYfUBIFFrzq
 9/mx9HPJJ51Nlgh7iE6XyHJEX9suE0cgUHhyJeiSM/odXQvIekVEbxz8xd4sRotjwaQrzpwI=
X-Gm-Gg: AYBFou2zSaCmrviaE05UZGyA4im2vwE6sxlIExD/pReMVcZ2achsexAOzKuXVh94xAi
 leRMt38JKBmczJrRzP8awqGSaDm1IffI6u5dpzL6aw9szWBnKjx0nuUmLNCa/ks22azTK28LTjt
 eiQXH07IHVDx1s4fbVpNCqZyIMy4EhFKdADdJbd3RKGQL+NxnYaZpsbiXT89+Uj3SfUY34B17Fb
 l/PH+pENt202JdEChA94+JqHpxAyBMPh+NPceD8dgEhm8RIiVie98oF9M4daHCPkgtRCNEJXTmG
 O7xkYqN1enmZigftfVH3Y3I8RdAoPNAXCVcWeOYWQIRyaaQiK34vKu5bCWTlinMBfc7r8MFyQiU
 4X645XRlVt3mc63qSwl3tb89lGGzmz+kwdoLjA/IjnlCd8xeVVZ2lwJaOwYUq/7A9QxAXxSRFPe
 FIYGXeHXhTU2W0gTiiva4jfngwt4LL
X-Received: by 2002:a05:7301:d60d:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34f219897c6mr11847444eec.32.1791183854212; 
 Mon, 05 Oct 2026 00:04:14 -0700 (PDT)
X-Received: by 2002:a05:7301:d60d:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34f219897c6mr11847405eec.32.1791183853673; 
 Mon, 05 Oct 2026 00:04:13 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:04:13 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:27 +0530
Subject: [PATCH RESEND v10 11/15] clk/qcom: add clock driver for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-11-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX0yAaWZ2p3hn7
 5wAnWTpOlkk/6hdwtoRij1moPQrUSRpecj8lhHnytS8MD0uBk8sWWj7QsuZ+0yyt9gPxI7eSDGy
 h3JTw3zZoWHJJmaPndGtcpooRpDO8T8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1vGvXvB1ROoB
 shzAILqPlO7MbJQRxuu3S9c+2aOAcAFbJ/g2HhrlfpfXEitvzsBGjxJQUmVKcHfTo3SAF3xZ4XJ
 IujnmCzdg8UGvMiI/sxXsO4RB122AXj2NRVO6rOcLrq0PPg9s8cYS1X+/gsUKuuHQVLUxoCbahL
 Sd/QwZV3/75kFPDU5xRX1Kql3wZXj1EKcAs0ujlaE7gBRURo/XHCYzJ0lK07j8d8BVq6YcwEjeI
 +oXDjJN2VIHLYBherClPkgjeEc/OzjYWYsQGovxc9D6lZsZwkTcOtjH3Wwg643Dn1QWOkcR5/bg
 v1HNfxgHnJeDhAh2epacETbUEP//LdXyZiw12CAXNzgDUa4ba3SIQYP+ioi8hzHcNFVdXm6pDkO
 0AtcS9xm5EgJS26Z9ti6njUqk4gdQ2jYKFIgyFJlAq4wc0T5kxyEq9INVRpUT8/qCcGpjyaqI+H
 adFaLFOJMX2ltv0zm+Q==
X-Proofpoint-GUID: DOrsPnFsFvxQjUjqQX2UtMzRrUMiedlQ
X-Proofpoint-ORIG-GUID: DOrsPnFsFvxQjUjqQX2UtMzRrUMiedlQ
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac34bef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=kETcTEvuJSViBEbj:21 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add clocks and resets for enabling U-Boot on ipq5210 based RDP platforms.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 ++++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 93 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..a142890acdd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..8934635fb48 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..cd82b238bea
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm IPQ5210
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rate;
+}
+
+static const struct gate_clk ipq5210_clks[] = {
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
+};
+
+static int ipq5210_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq5210_gcc_resets[] = {
+	[GCC_SDCC_BCR]			= {0x33000, 0},
+	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
+	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
+	[GCC_USB_BCR]			= {0x2c000, 0},
+};
+
+static struct msm_clk_data ipq5210_gcc_data = {
+	.resets = ipq5210_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
+	.clks = ipq5210_clks,
+	.num_clks = ARRAY_SIZE(ipq5210_clks),
+	.enable = ipq5210_enable,
+	.set_rate = ipq5210_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5210_of_match[] = {
+	{
+		.compatible = "qcom,ipq5210-gcc",
+		.data = (ulong)&ipq5210_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq5210) = {
+	.name		= "gcc_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5210_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

