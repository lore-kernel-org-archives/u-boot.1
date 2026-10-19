Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F92CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCD3580E0D;
	Mon, 19 Oct 2026 10:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fh7Ry2ozHa38; Mon, 19 Oct 2026 10:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05A5E80DC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407275;
	b=aBlt3TQwMtfajlEOuLemlE8UMXFqZszjxYE7jVeuqIGJiI5L37bXM/edN8KvA4M7qF9P
	 ZBcj2IaCGYS+sj020WZ1NfgzXX6NP6Lq5MVnWF3ZRRQJiW8Xwi1Ld9oemiwViXkfjvFwP
	 g5SAkJeVhf7d4X/U8dnKx2IGfX2vsxxzQzMsRjnXG3SOSAryofnnfyKopdcSZ/A+99Ptd
	 pB4B2G1qVR+mwZanyRlNY2udzGt7aawwLQ3k74XDd1Ty+P3Ge0jeB4iwLKSjP/0QZ6CYO
	 gAIPILKGLleeVj6iOYNjno6Eld+R0eMs6aw5Abg/J64l2YeUeDcVJ+rDtlavJwbAriA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=;
	b=qvZT1k4r6Wfgc77lPd8m4aCCIl1gJMoIaN72KNaOO7FZMWSRew937Kbvl72TM/vWrf1v
	 kSwIyBqii7yLEJlhxJUHGjx63JWpZHdDBVIzPy73IcDe0gRLkM9dOz4Sy3A3kA5XhoLQl
	 0UMKEs8X7Dv4h/Ol1Ka2rpzS62i1gi84R5AyLym8Ogk2rznAwTnOqTNR/ceN291kLC+e3
	 OXut5DTmApE7UngaUFXmf7vkcvtLqeYBdIb67uSTW+3LWhT0evGzuhNo5Curj7O/nOQrC
	 momNy2FfsBpgCnpRBM3qET1D5+2ZJ/1SGooapWBkoT0HfGDa1vR1JEuPr4+MMyNifGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407275;
	bh=JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bgp+YRYuS5SZaEawYX6/R60mIe4cPpiN0YZ/9QpmhHirxc+RKYCuuuen1vPJs2L41
	 zKI7MomYbaJ+To/+yzNBe9g21jds9lIRvDjeUsH7gBLbWBm4ErlynOSQXSo8/Dsh5r
	 w40HA9jAZcMNXPMCkRGNdr35LPrk7o55xWRLB6UjAQXHh02J0mnIrh666+rhvrBTo2
	 +POCnVDWfov+iOtHdgAdP+BS67/MhSzTiByFWMyEJi8qgQoHmhjtmdS/yPk8n5oB5v
	 2qyMoRoeKRjtg62HBOsXZvMJ5gDJ5ZbSqrEPLKmaKzhG/iSqbK7jBcUTmaGru4aFaZ
	 dzoL4aUf3GQ6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A5E80DC8;
	Mon, 19 Oct 2026 10:54:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 073141DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED46B407CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7ZUykLMO3mE for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53DEF40713
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407269;
 b=mse6M0ROUi2JxTnGJgqbpxgIdbrOqRKS/27jyKA2RXHqwTpSIKTaE+onlNIZ/zlKjd+S
 eRM3hlRBopnaE5O/RcptS61LKqQoTQ363eKl0SHJxbYjp9JbqPqYwH36vncFoffBmRDfN
 p5VcQ+BVE/U8f+xqjSZ1OL8E9xVPmO/OGkOpSUE5KeeHJ1xj25AlboH+yu+wI+trsLhgD
 mpSJhdscu13slC+wmVwVSwJ2dM6yczj7MvH5vs3MXeHQ1N92Wq6xZFEtbMa1IqS1+jw6d
 ZedZL70H3SuGxoamI4ZaQrfkb0OushegdcdnwEG9i4rmfJZgNZqeI8VFwLKQE4xQjZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407269;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=;
 b=cm9XwEjkGZN4OEj4a+5wzt5rdzCYwqQV0Bac1rDvjxRZz+tqxaODFbY6sjEPBgJmGx0S
 HFClrzjGswTIm59F2/JYslqXNr/1QW2Z63+ummPkbmHdaZLQlyGEC6C/BhWfF7IiaocqN
 aS5R4dMFPSCHJGC84ezRpil1FUP+iEp81L4JNl1A8Tk2O+JTNKRsaCHMfSYU3nQHeD4ES
 iwstafun63s3Yfxk1b2UKBLC+Z6pEwJlzewnOO2PgJYbmBaJ1d+Ws8nfVJ74KmKqphsvJ
 fU7Mt32Pege5DFuYpmRdIh/+swfsbmMrd29TCD50F9Y16OflqIh3eCqlHBLRf/A0elQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Pq5/IJkz"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eEE9GsPp; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pq5/IJkz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eEE9GsPp
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53DEF40713
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PDE92193399
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=; b=Pq5/IJkzTRwjKPfk
 0sYh6r7T7NG4ZqzNHUYx9ASWjeTiI6wc46xFCZpD3E6TtFaR/X4WC3eMTDcIKAoW
 1C/E3SAx5AdUq7LzKpjg+3S5PKbmi0ENB4FEbwd/3BNBi5baH05tF+v9c/ztXWyK
 zd6FSlHWkP/QfjadoRMTWiMoEP+6N4+TOtoRK4KKfC9DpVzHqd8vGOMcW/je78Ux
 8Ytv9y9tfbCvAIfbGz90IuIg61aIyByMezrKIruixqMP28X1lML9iNBXe+0eVSwV
 JuiUF9/mZwTQAJ3AUKyDwlqhBO1FjADB+OOC7ujbjFOS7JdyTJ/6ROs8PQxE+4KW
 q8cOcQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1abwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso5043764eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407267; x=1793012067;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=;
 b=eEE9GsPpHwAzLXhswiULrD+t9y3PFjWotCujB/BTDkE06IMQK0s7GhJIRX41Evuqle
 SYrAEkCxOHXE/YKYCgGoWO2UysYyqHvnKXTPAxJcb1ses2y3UdfNPN+insFq2/eWR0qZ
 sR8NmM4fRISNwmNkapMj1eXurxJE/SesvjgTYJaf5mjF4sT+uP6C5KCZZkoe+wir7XSp
 nhEhxEOmT73LBjCrhhELhj9c2uURmBkfq5iV+FK1N6PXD04BiLg6OJuEg+sVLH1VQa3U
 LjXYJMr5RDlVGHwlFu+Rb0CYfP/c6NmTD9y1tdzcJ/3/szRpLpFZVh0j5bAKD2xdEnjK
 /RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407267; x=1793012067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JuEg+sHUBl9t/CVJ/hce7cvlyy36lFYicGrGka8ZpGI=;
 b=V/wPlsznO1dFNg5LN8Zr7Bx+dy3pHn8D6Qt5MWCKsH4l5aCcB8I+Zq50hVykKbGYUW
 HYJrmkbS4J1RqkOofli85p2azwU14gl7Ao5TLUvj99LP46aGft/6zVHRw8noLc7u5eHK
 c8E/sqnOb5Mtw4TZ7oKXLbq2Ncent6HkD34rtTpg4sRjBE0OgfSBo7b4FUJtiNm2YzzP
 AxaKliPlx2EBLGCxzjLbdEm3DmLkqOykXFp3x9kzP7nfvSc6JLBYqF/BVzqN6Guy2GMm
 3SrbR3TltD0FCAGkDt9anv4YSHnuprVRItwrsjard1C4As61gXZX/HOShFZEwkJ+8wkn
 lhWg==
X-Gm-Message-State: AFq9FYIpHdn5fXE105Cdmqy4KiRxL004vp6t8KgxBum7ncgCEthtGxyC
 nr/gpOtdNfu30NaSqm5N1LwLRkKcdrHlCtbpa3s2BAs1GVGbr7SQzV2HI7eIcfbNT4p9QFkXQZg
 QaY1GvKr8IEZ2UKdK+NGL9iFZNVkE9b05hEzwYov40c+Yf9HMdIjzePDtBvqdYoOmD3/mmbA=
X-Gm-Gg: AYBFou27X6W2ad9JVPu8cfqKP0x3gvxXu0MVGaB95OuYdZ76TVzoFX/tq8AYtNItWGi
 2Dv46UU6V2kyj3oOX42vKq1sO/Q+V76kl5UEHUp/nbj4FFUFtBYmNUz/jM4WSNfJajqk1KUELFZ
 eBVIyALd0tWgE5aqKbjZBdx4YgWwW2wi+f2eqzkIE3aRg2lajgX6vKnl98xT6aLHwAgqY8dn5wA
 pTJdpcr/ixlAmR9nDOqfh4YWhO1pvWb349MgCCgxUU3UYxZE0HT7L19it5lbO/7zdLfXJWMTfTV
 QqAMyZc+nof538rqraJP7pwxiJPWaSqKpWb8agrGpNt/ytSyctVJG51lGXP3aj2GOawBJxL/5ZT
 9kmUi/avUnXcjpAzah7uaKM5zar/OEcQmuUpb/O5R9iNqw/cPQk+5oJFt7XrWpSrt9wpNcNk3qd
 lCcBs007VcAcZPqQH0t1Nq7D4bGeCI
X-Received: by 2002:a05:7301:7305:b0:35c:dd03:55d2 with SMTP id
 5a478bee46e88-361a2a3ec54mr9282542eec.26.1792407267254; 
 Mon, 19 Oct 2026 03:54:27 -0700 (PDT)
X-Received: by 2002:a05:7301:7305:b0:35c:dd03:55d2 with SMTP id
 5a478bee46e88-361a2a3ec54mr9282522eec.26.1792407266690; 
 Mon, 19 Oct 2026 03:54:26 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:23:58 +0530
Subject: [PATCH 4/6] power: pmic: use $(PHASE_) macro for Qualcomm PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-4-2d8f7a1e6730@oss.qualcomm.com>
References: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
In-Reply-To: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=899;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=qVwoJjbYbhuh78MlnRl07+Q2R/zQ+dNNqRdq4kQUvWs=;
 b=JRN2vgSv/45pyk2AHziv9JspGSj69Qfl+1rnea7shrd06ZCKErH+xIGXf29vU/oc4cVkI80BG
 acLiOiP9/LRD1+Qs9eAk6qMUwydj2Q4cVQgykknN/qNkSCFIHzKX77f
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXwhQxzcPYNhSu
 SBw3E1Iq0Yn75ySHqqi6zi40xZZZ2XMZuZhwmH71YGav/QLje9sgdbKp1SCeUO4/0swDI9iZ6Fa
 6Nd5I+ttnxvzDKLpCA2sid7Iw5xXews=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5f6e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KdN3sr_vzAT0zjfjiTEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX/oTeHbkTLnkM
 O+rsBW0AXNIMsuiFVta68xg+bpoS9NwXX4GVvuvX3x8e6VjDuZF2g7jGnx++GlHstGfDKgW8xrk
 RssU9ytbLgzjaHELUnGg1CclT5VcRnj3LZWxtWiggLt3tXit5SppH5yQCzmFgIDxsrvGWaVr4uG
 E6eK56ZL8IBVqPSCQD3mqo0pSgMXFw6UphMcC9xKJpXu+01SjHDsw1HK50fPpMViAZxvB6f2gkC
 n5sglrO1XNAK+wzDmiobl7UrvO5cBRUXdL53qEWTJkxFmVYW7OD4GYM1nzxz2AdhUJBQMwW1YT8
 Vtz4A7gzxn+AHIcChnwpa+FdHwLS1ovY2+zl4bAy9Obnq7RyYYfJAvShERbofpRz+I3tMMkqwdJ
 6j3sUJAWTqpx8hjXVGC9JjdkjS9GMp/H1pnBGRbttLkoxuD1tmjoZ+c9JSQVdS+R+zkyv0cZEid
 I/WxKX+W3nhDaMuaHUA==
X-Proofpoint-ORIG-GUID: UkX_LZkpCNWOKbajpH3VMc188ynfx5_f
X-Proofpoint-GUID: UkX_LZkpCNWOKbajpH3VMc188ynfx5_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
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

Update the PMIC Makefile to use the $(PHASE_) macro for pmic_qcom.o so
the driver can be built in SPL.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/power/pmic/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index da9b810de90..14d46673453 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_PMIC_ACT8846) += act8846.o
 obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
 obj-$(CONFIG_$(PHASE_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
-obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
+obj-$(CONFIG_$(PHASE_)PMIC_QCOM) += pmic_qcom.o
 obj-$(CONFIG_$(PHASE_)PMIC_RK8XX) += rk8xx.o
 obj-$(CONFIG_$(PHASE_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o

-- 
2.34.1

