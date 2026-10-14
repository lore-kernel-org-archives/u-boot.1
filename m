Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DD5CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AE6060836;
	Wed, 14 Oct 2026 12:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0MrPWbEPwe9; Wed, 14 Oct 2026 12:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55935607EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791982300;
	b=iKeelCiS2+lrqHOcAmdVGyzB0Hry5n/j9si8qaLgyfvmnWRoiGxPthIhECrAcaZc4eJX
	 UutRT4SeiJqFZD0Cm4IgCDaFl7gZdV+F2JVmeNwrDqROTpLlb2fcJrAJ1W123yLXxTGl6
	 3aUKRnvAyS5tqYfRM1q0YqFqVFq+nBjF2c9CESTCexhNo3V4fea9UvqABIj6gN/UAmOKq
	 Lwrf8cQL2LpL1vv4HZQHTABrlAoQ0cVKad4+KCivfWddlsGBZ/BqOd3hxDzs8zNOcKlVG
	 xbAIVq/h1SfNZgqzCxggGZbWe0Cm5d7GxubnWkO1me+SjO7ZrBLaJAuRUX2Y2IzXBzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791982300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jZR+udy5cloF/kaaV03qAE2iHFgesukMOiC6NFqxxWE=;
	b=d9M9QsArUat6wBcePFyj0T6pHOavD9sSilJAW1AM8BtwGE6TGIE6ltTG69vXdS/jOBdP
	 2J/+aH8GJs67NP+Ymx5DbWeJndgPP7m8iuVC/5TJ8x/htS7TQ+W21zFEVfzvhAG/890lU
	 55LVH9o++lZEcQXraPTs2npYr55YZUBNrqQGcvFVl7BBg8tP2eMFxYe/hmG+8Zd4nKeYt
	 l5GhdYMmNTJVllBM0zeKmwA5w0ZK01AKBUwM0gq55cTz8GW7EqqljuyXbhjLvby4/lIaN
	 G4E7Ow2nl1ITkA08B2tvWsB+uwMBoVk3FLYxwtHjqkN/ik91qm9DYRziAnhnFokcySQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791982300;
	bh=jZR+udy5cloF/kaaV03qAE2iHFgesukMOiC6NFqxxWE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NR4LqyetOQp0bhY2ATOuVDU7thjAtt/L5JYxe/6JWyLzylT9ibLYhibtAI4BU456+
	 wVUIX9WxmKMzJ40WaIaCZhfRwa7GEAZQWi1fQ8SJt4JVE8eBOGVzlMDJUVggJ2xZvI
	 n0u/t6f0vmTXSgV0w6nCFSHfIij1xPReLN29xP3m01jpLUCuonzeHZ2UkSIsmy1D4R
	 oSXv19+VlVsClCHpzniEuSq64J3oEGEOHdhOK5yhpcV6br3ZRSoZlKxIkrxZW8zquL
	 w4JdTD2fzBiSYi54SeqSaNZ/b+BdJhVJtyqSBTVxPhSet2sWiRybnUDJ2MrNX3wnRW
	 BniVUV9ncCGyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55935607EF;
	Wed, 14 Oct 2026 12:51:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 224582A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13D4680C3B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N93PDY-WHgzZ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 357ED809BD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791982296;
 b=VlfI/pQy51mc4z3HT/z0w5mSJ9ta44mxmLlCfZNDPlMHodZSZzziiL/AIAKdNeCFoArv
 w3siWxyQBk+lZeZUgrQ/2D4A8WB+ZFMCtCgRR9L9VaoITkJsSHTOacpES7qCOmrberei1
 vV2uKp94kvfkJjNUW7MmZnYkA+HB7tXbKOpr/+sfEHQK6vkBHY3Zof2I0LUSGQdSwXTMf
 HVI5yEueTxhWEg7epHmmFKOj8N9s9iA+P6mnDzgQYTbLA2twrUxg3HvWR2B+q4XuXlbdp
 zoDmY6Ru+VOg7h5VCS8V/E4VbeN/76mt7XpNECtVIP/Ykf4cwyMRV203Aimo2nAiZsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791982296;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=jZR+udy5cloF/kaaV03qAE2iHFgesukMOiC6NFqxxWE=;
 b=JeVG8GaImDaesNeD5rgYop+wK1Mrd7C9qDo22PtXt0y8SIJpM7WF24tXTZzTMoMtRW42
 UaN5XUAlfET7flKMQEymydDKO63AybuvI6H0hY7GlXYDSN7TLDaRZVG+c1/Bk3MFs+wuS
 cNcVak08Hubw/BjqqOjR9dX1R0VFS2/52Loq1OT7jdlNXS4IA7LgIfJIe44+YErzT1aQa
 GtEjEvA8puVejoBWphMz1RBQ+QazCGLmzrZKXTR2YGZQ8eRK4VCt4AjgrLYyewBBovKrY
 +uX2D44hN7YfN52gTORBVVfqhww3rzGjRGgpkYDo9mmbP5AyY0eEJkhhmNQdJo+MSqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="YNKI2B/l"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OohCrig4; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YNKI2B/l; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OohCrig4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 357ED809BD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EBRQOF2516002
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jZR+udy5clo
 F/kaaV03qAE2iHFgesukMOiC6NFqxxWE=; b=YNKI2B/l/jMPk4ymsdZiNvsMw8I
 jqED5jR0TPuDSpGONpG5Mb9wC/RW6z/kkGeKb6vAmS3+OTLMTASy9xItUw5YTikm
 Tmnnd4HRvCqwWsAC0EGN2eqQPt7LTl8742HQhi7cubQR/BQd0m4amcirIC0JkFjM
 uSYTcIubi6PfR5WNC/sg2yOlYMwfr4AmczRyR9JhIdBlcMIL+5zIFWPLFh5ulHp5
 NTCgGnODrZYP6WE5lT7kCrFV9pGD1OgFU0JeKGNsxSy/3w1qqCV3qat/javw2S69
 a03AklF0tlYzubxBeb6g/1E3eEO58eMX94kjtS5AY4TI5KQGajaktutMJog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4709kjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso7830866eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791982293; x=1792587093;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jZR+udy5cloF/kaaV03qAE2iHFgesukMOiC6NFqxxWE=;
 b=OohCrig4spPLmRZ3xiHgtytw8BM7/HSDWXMtJz5DVam0/1pmvyLSd7IEHGNb+3m3sN
 tGucmA2WbpV+SCzHFKszmnTrynn7qW+F/DNrWOtfsYgRq59hmPpicC2CAwl1jPNAw7Ri
 pQ05WrnbS00gMQCAYaikX8+shXYYrM8zVNJwnAlwIjltFWCWeA6Dz44cD2uKStIaR3QD
 wehB6Q2gotl/3MeNN0NeS6TkpF1o+m2mb2fy1Gcku9rEwzWx5WAx0bR8lNTiRArmj0uH
 hInLX21Te4rOTqK1ychsgPXY4zqKHBTly8tbWKPbVwpsZuWqLbUzCon7NTVGVURHoaD9
 qe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791982293; x=1792587093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jZR+udy5cloF/kaaV03qAE2iHFgesukMOiC6NFqxxWE=;
 b=FxwLY7+FGr4byTZEF03dcv2rBGYcfmgQrPE4ByGF+qVswpHRmo1AmSkPJMYRJmvatM
 tjDn+dksFEk036VoTzX5eEcx++3mzaOVxeLAeRGDmtciMYM2/5ul9U0oVOq4lRtvwp2x
 ej2McjWIV1TK8w5S0HMTuJ4IkWHu3YL76Jc0n28dF+KLIafzSVmrIXxXGxWOgLULQnAG
 p6vAnXtMG+Yt36GfjKjPYS+bm5m0vO1ZIgf5NN56RhbPGrrcdz0HobyjLrBCnd6p41Sr
 4JJiyeZt+L1LswXefPET0L576d1VnbWEK2R20GCWJTw9G+3QnlZUyUg7zPJ3iY4EmCfQ
 ja0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBykpDRCjPaRHzZMNJyBpGfTgwPNDrl1pMob8dl0DWcfw9BqlmR9mGGkyBsMhDoiZVn9wulGo8o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI9/I9cvHw22vLayIdM3D+9Dm7n8IyR7oRz2//KLGtFLN28rqCK
 UascLOZgXPGzfa3GRkpavNmfXdZkyLT+LuKAUSXn3pgFzZVwnXKdS/++cd+M5Qh71iumWwg/aPh
 +JtcX8KLu3IVcfWQQcPIHDo++lfoz4U2HlOC8d2LtgqNqZrOOrMdkLKX6ofHMPj+OuHe+uR4=
X-Gm-Gg: AYBFou1ZoSbf13Bm0tx6EMLEa1w9H5omy4SuTm5CM+jHr7tsjIi6ktHWixNAKpTN4hO
 TJAKIy2cIlndXsMu+dWFa5IrV6BHriLxqrRmX3LLp3sYYDpSZFFsVgFU3R2XRRrmIxd/jPEG+6Q
 xxZn9wtSKACdR61n3mBvxQCbC+O5Tsv+XWwWFt4RWpg5R9TZpb+uo2h/3e1e+GLSOhjXuicTxR5
 YOn3v8Ic29C0/XdEXh/KXPOVSOoSTwgxnFKXfOueIXK5XL9lL3uXw9MRfpUZMhBeKynU5AMDwqP
 P0L9aAPbYUrzj2i3shZZYl1eZy1kUxpJeYaYQtCbfyjmabwDSa6LQ4UXQ7PfPErxtp2zBdCjAPX
 wfTfClALZtIC+QqpyuiTZXup2igLs38K2cnveuOfSiYbYNzw=
X-Received: by 2002:a05:7300:4628:b0:34d:2c1a:9892 with SMTP id
 5a478bee46e88-3537e2773e4mr21242354eec.40.1791982293298; 
 Wed, 14 Oct 2026 05:51:33 -0700 (PDT)
X-Received: by 2002:a05:7300:4628:b0:34d:2c1a:9892 with SMTP id
 5a478bee46e88-3537e2773e4mr21242313eec.40.1791982292718; 
 Wed, 14 Oct 2026 05:51:32 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm59713782eec.18.2026.10.14.05.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:51:32 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/2] mach-snapdragon: Kconfig: add CDT configs
Date: Wed, 14 Oct 2026 05:51:25 -0700
Message-Id: <20261014125125.711084-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX56fhkmYTzM+e
 jNijc0yMOlFZy+CM52vwgB6w8RdI+6kSFQr+SB7KNVJipzn+VghOF04QwmylOABXaWu2mo4tx/M
 Qu+6XsbuVjdQzgNX8Wr50zGiMoamEhW5MNN7v/pvXA+innfhwctL4VJJjj3XRMwVbD0Y0OjVF8n
 UtgjzPyVlKvOqV+7fCi/v/9zLqdXeg7Za7h1IKt1eU3eDJ7NPqw2s/Dn6aKwnGhAOVaXRh6eNIH
 6x895MbYhhsXnyUwNC3/UbDAjeqgqap39jHJdxamDAOh7e2obXe/FuHuCyGGp4zJDT10ZtHPdhG
 Qxi0hvIfjyYEO9ERrIzhFcAhUhvXY5DsUdO5BU+KXRyyRhyT6ssy/vh2042RKrxXnz7XygYR2Ma
 VzX2AnPyhpLEl/CPXHPs+8iIusO3dfRGQI1u61dFIGoWyFwtH/bQjNhXnQiZ171ATfgX7L0b1Jf
 GDM0ufyLmJHcLGYskQw==
X-Proofpoint-GUID: x2gxSAhCZO1j1BvuHXD0G-pmgR7gxj5t
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acf7ad6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7dcn3ihqlgfqI9VOaiMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: x2gxSAhCZO1j1BvuHXD0G-pmgR7gxj5t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX2e9R//yRPqm5
 X5ZSSdW2z2Hq6L8YZXNUd/yAA0lhvImLp1aNNYjGA4eOtM+iCZ3tL9HyItF0jdI/SQnmZYFO0OW
 qqjspDS7q7AD326N1Of1zBEsm3SrvRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140051
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

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Added CDT related config definition as part of feature enablement.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..187a21e5a9a 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -93,6 +93,78 @@ config QCOM_XBL_SEC_ELF
 	  The image is copied to the build output as xbl_sec.elf and embedded
 	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
 
+config QCOM_SPL_CDT_SUPPORTED
+	bool "Enable CDT support in SPL"
+	depends on SPL
+	help
+	  Enable support for reading the CDT off the boot medium during
+	  SPL and staging it in IMEM, so that QCLIB can pick it up via
+	  the interface table.
+
+if QCOM_SPL_CDT_SUPPORTED
+
+choice
+	prompt "CDT partition lookup method"
+	default QCOM_SPL_CDT_USE_PARTITION_NAME
+	help
+	  Locate the CDT parition in boot media either using parition name or
+	  partition GUID.
+
+config QCOM_SPL_CDT_USE_PARTITION_NAME
+	bool "Look up the CDT partition by GPT partition name"
+	depends on SPL_PARTITIONS
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  name (CONFIG_QCOM_SPL_CDT_PARTITION_NAME).
+
+config QCOM_SPL_CDT_USE_PARTITION_GUID
+	bool "Look up the CDT partition by GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  type GUID (CONFIG_QCOM_SPL_CDT_PARTITION_GUID).
+
+endchoice
+
+config QCOM_SPL_CDT_PARTITION_NAME
+	string "CDT GPT partition name"
+	depends on QCOM_SPL_CDT_USE_PARTITION_NAME
+	default "cdt"
+	help
+	  Name of the GPT partition on the boot medium containing the CDT
+	  (Config/Chip Data Table) data.
+
+config QCOM_SPL_CDT_PARTITION_GUID
+	string "CDT GPT partition type GUID"
+	depends on QCOM_SPL_CDT_USE_PARTITION_GUID
+	help
+	  GPT partition type GUID identifying the CDT (Config/Chip Data
+	  Table) partition on the boot medium.
+
+config QCOM_SPL_CDT_MMC_PARTITION_NUM
+	int "eMMC hardware partition containing the CDT partition"
+	default 0
+	help
+	  eMMC hardware partition number (0 = default user data area) on
+	  which the CDT GPT partition is located. Ignored for non-MMC boot
+	  media.
+
+config QCOM_SPL_BOOTIMEM_CDT_BASE
+	hex "IMEM address to stage the CDT contents at"
+	help
+	  Address within BOOTIMEM where the CDT contents read from the boot
+	  medium are staged, to be consumed by QCLIB via the interface
+	  table.
+
+config QCOM_SPL_BOOTITEM_CDT_SIZE
+	hex "Maximum number of bytes to stage for the CDT"
+	default 0x200
+	help
+	  Maximum number of bytes read from the CDT partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
+
+endif # QCOM_SPL_CDT_SUPPORTED
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
-- 
2.34.1

