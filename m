Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B92CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21997407D0;
	Mon, 19 Oct 2026 10:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wp1SmCFDaogi; Mon, 19 Oct 2026 10:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 890D040791
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407269;
	b=VdtRCQVxT4Rn/cZY9hKGrowp1EZ7DdfrMy8bOPJpHZRcWAZjXo8U7YYRaW0PdRAxCOSG
	 Wd8VBm4Kypd+WSjeBF8kAfOFK99p/7rAfDrP+3H0vmueyF4XQ2DShMIzU9qrl6M5tr1go
	 BwGED/obomKO31L0m2tzuVJVl3P+qxW0mldSqTqVXbAYDPuyJtk8WuVU+Nv1s/P+OXNi/
	 KerBt0uhMgE88m+GPBSCBlSc7LaRNl+vyGLRUjdWGnrgspBmp/GL0dEb5QXrtX5gQDH+2
	 LldqluzbhAr4f8GWDaliczlQaDmLuLHfLxAxEvgSCpZyvvrHHTZcabiYDdhBB7Ti6KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=;
	b=drjYCVI2m6lo/gBTNRiRiprkrTnOmh+a50mlETkLxnU6hS4tmIu0irucRIDGFh8stoiK
	 wHQL4VywWIoOtoValzQOwwfUgpWmsut7KRtxHV8gkRu2sL+t0RguvYIRudjf7pHC/TgaT
	 owuiJU3oUap1XraRWdAIlYXsIOo/eliedYmJ1C/bO8zFatSDruLGQtvcrCUfvmlL/suqn
	 KES2sp6bqdGjVzrF6IDMoXsYajDApsRvjQ6QmTJkIaOimAwVv17F/pCdYldU9kB/x4fOF
	 bN+i6+5D/J5PRrbXQmPup0RbH4jUnStHQ+r7u2k70eHNMdY07Z6hjPDsXJTLZCJchtg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407269;
	bh=WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yPizULrRA8n2LQ747VzGy9PhHeZacGC4JFO8xZqEvxdrpH55W1Yyi7BOxyL/vZ492
	 eOpeAFrfGQP+O5WkwvbA3P3xV0mvUHTEp6Kc1nUUMY1PAt1qXXo6qBY96xTAZniQKZ
	 dAiHMJz+RIc/Nri7Tk93A02Zm69dmo0m/egzg624tRBfeUhZnht0FGTTteF+m2Lr33
	 BTIKisFj0ubj5p9FvsCqSTnCfVo25WOtUtXoM+Lix5WneRoHUtHGnsBz/o8ervCb6X
	 WUrpwURFHQWZvbIR2XEvHu7rCm+WYa3gjrkiMy66M7bocPkJ9I2IFIIhf4oIEuYC9h
	 9yyUJM+KgjsOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 890D040791;
	Mon, 19 Oct 2026 10:54:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBAD81E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1FD940080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjWIkeeexWtv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6785F40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407266;
 b=tftPHP0LkW6driKTvGjaocf8iHjaThm5liuzDPZTU9hWMufqEz6dTxaGdIYQdoK+5DSt
 RRkj2oHwiNHZGNTW3/gpSq1pk6QUjImup3URwkmnHccQglw4jaD/1QBbcsjZf83dS3BzK
 Ka/7HmPfvFZGHdBWKItEgajlhdf9MXxFTohnmHw86i5dGkDrAflKU75MZVd6rP5va4MkP
 tTb8bTyLfeuLFE5nNiWfr5Y3ikAD1Jp3sImupXbFgEQCnosSnQ0MIIOL2pn/G74KWN2pj
 uW2nsl2jjtkQE62oqolR9d2Ju+B5CXiUhuIYBHPO+FOeloIQ1prPyhbRYY6tU7cr42A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407266;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=;
 b=Z/N/fI5rMIHnop8zwRzvK7tF/MWz8xTlK69+svE2BxdlzJLDIJL8yVajZS8ynXgeL2f5
 UzGdbcAA/vqRB33lq5lwwPeYSsj4bllAwe5n6JIJlo60LMO27+VQ1APo2MdcMjltRxt+F
 I+vituKNskXT1AZdhQk+xeLnk6re+L+Efj+GF8HBQ3pOW6O0JUU4qdtbw2sJFyHE16bnb
 30MzA+6qOP0edcYeS72EZzQOuKX/GWeX8qI87Jn20OC+rbasG11ueKd98rAz3L5+HTOuR
 pIAcVVNL5QnAD89WzhSfVq7Ijsgy80CFXWLAAjnND/4ii+qomrxhzg4H6GHjFnsUVTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kdUqunO4; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="daP/z93x"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kdUqunO4; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=daP/z93x
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6785F40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P1Bu2042098
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=; b=kdUqunO4l3ZQ/hkf
 rrADb692Iao7yjj5uklNLyoBeB2oXPQw7VXyYhure4B2IJ6l8xCJdKjCyUsS0VH2
 6QIhiLmBv7jN8BZCAz/1uUsDSUm2Ap7Q1hp02Lej/N3mgck9CLvobVq0DQNmEX7/
 r6OBnGWTOuMs8w1NQFmvGrEIfG+pxdSyUqTpzn/GQYdkopmSW9twu5QrwvPYFqEx
 ORuHbRq4Rg5ydkq2BDilI2bREJjLajzkpn0Q82rJ5LuFipthxe/EFyEIqswPGWX+
 9q8BLfpbsGqJIi5jD3RDX0d1zSwATJFbyz+jflQhxl6hybBgWX4G7YMT+bNLv9ws
 BVveHw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur2bug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso5043554eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407264; x=1793012064;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=;
 b=daP/z93xxkLJeYJd38c01YQF2t2n7qvmdJcMLnRP84DY2Osx3/mF+CByk/UyuDDndX
 Rh7Zv5oeN7PSRqwN7SPq5ySFk0dzK4+MWsbZJhvpoOS0RTvKWP5wxIjevJ4RjV9HmSZK
 OGizcRmUsQJ5Ho1leUM3qIyvtT2jKdpenICziElRVPe48nT/DS+cXpHbLWBQAiNpHrmV
 KKEHEZW3ssclekdnxQJNKFQehYCkKHwB25PA6AkI9dWOYBvDFX6+Ru5dfOi3Mb6Qaeua
 NzAaFE8wueiLACbGMSCishK5be6t9Q28rKaXp/iJFU03FjPfMQUs9wiARJZta4EmGnF5
 qtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407264; x=1793012064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WZ0D8HJ5BPrYUpKMkf9t+8x2Axnmnsu9Rodw0iSm+JI=;
 b=0LoRCVb6QR/Jyy43GYX0EdWvBVnS9U17p2cGfLt8F0B5fpXgY/8byuo3+qQ5aClG1q
 ok+IHsG/tF3wdOjA8CbgFPJdLF6MJ8ih9CUYHW+/ryWyWy1eKTg7xrm3nccfFAKzgSUj
 e1mdPR7QGUXyl7fsrNZNl6PrpgJG9ZXmDWwzg1B64RSQplChsUmtY64rRI671lTWFFRa
 w+xqdIYUmYsbUZTEL572YudElwB+dzcpUwB+iMLtMQ0jIl93/YlxbOVSjHJNieWmF15h
 9D+7r+LzeUhxJ/d+Yq6aBi5Exwg1qyIhhUJV7ReRwXduzxn+6X/PdJW5w8pdtoTPC2iw
 L6OQ==
X-Gm-Message-State: AFq9FYKOCtnVHiycd+o6+fJ3aetpYJniic6cUY7Zn+0IIQ8YPi7BWwVi
 k5Qq5e6hBulGOzFNWC6aYl+A+Z4a39RIGS5wmP3iRyhCGiyq5RDg8LQgYs8hycoPeCsb6h0Z5tj
 GZ1uxg9mI2douPVQMckdhDY2E/R/szR5gJOiaSFqKKXjZ6QdSFVGUuh828aNyA2shcsWLIyg=
X-Gm-Gg: AYBFou0JitAPIEhbTB+I9YO8Lq0EEcrWQdrkWKZg/QW08d3iAdOZJAyxHdNqtxWHdFy
 9AFGeti/UJFw0nBTLU/Uoa2X5j9kj9fPwE4gFZUzSdn7X6IRgtldDz1/NASjBxe6hjgjQDiile4
 V1Cgvttb6FoGs7pAYBWTNK7cQtqmdQl15gLevkI+WN/joLp3aUrven4PiH0mSI5hVAX1gSFm87W
 ci0ht5N6NzNfxjdpbcQvuo0rIcsE1h3EouVqtsPywxAkzG4xz0K7AkbbGeuMIjaq80AQsECtVMH
 LfDtUUPLy06xPEb0Pg0BruY46dJAGmQdIP1mOsCPmAedngRTswhvaev3RC/EP1pG/noTrm8vBUi
 lthiHUmY8iUXjvIqfppVQA7sd/QaGEUsYuYcZn8B5k6PnRpYbhi5TTJKPB+PPIf1xF1lE9vS4SZ
 iYTcptjgs40rm6gSgA3Wj5qrAnDsgG
X-Received: by 2002:a05:7301:6497:b0:35d:8c39:b2fd with SMTP id
 5a478bee46e88-3619f1fe992mr11079741eec.1.1792407263334; 
 Mon, 19 Oct 2026 03:54:23 -0700 (PDT)
X-Received: by 2002:a05:7301:6497:b0:35d:8c39:b2fd with SMTP id
 5a478bee46e88-3619f1fe992mr11079686eec.1.1792407262209; 
 Mon, 19 Oct 2026 03:54:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:23:57 +0530
Subject: [PATCH 3/6] pinctrl: qcom: add SPL support for Qualcomm pinctrl
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-3-2d8f7a1e6730@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=17187;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=NZDKoMJ71Ysg7/d0m+MboZlG3RJCw9Ohj/6m3ii6Lk0=;
 b=nlKe9ktwAtYiJKgn3Rcr16VUb5xy/R8oS2xP/r/fQbwo/bBCqhwKDjky6z+oZKTSYwFIK6CEK
 XFLmn6mQ3ViBz1Kldv1F71p3wqIVcIJcFvSUToC2y8Oc6b8MNNAtrun
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX5YX8qrMC3NQ7
 I2VUtuehFT1VmgqdpD+LuLlIxwk94BGzGP4VCIDEYkHbl95b8+zAL28xGz+dhgJoaddwLsiA5XS
 v89/RDoW63J5A/LC39Vlalg0FHX+TrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX9IaTfstqjbts
 h/o1ddZ4UjQWOoaGoL8+IDsY3IJxcjCAwiVLXiQMfpm76A4gb7B6R7ZV+Su7iZHtJTZE6rkh8Oc
 eqRbKiTFuAe3HGcOmp6ZElNSnCuDndh7/+9txWLMa49ki9l4dYqnSzCtMGbYMsot8NcqDUWu5Fd
 hICzyShapbiZb/vPd+wBAv5Y8n71KanB04P5rr7xCmrb3YZPF6EljB/nPm8Hp0jGsadHKqqSh6R
 I1XfU64Z4bSRF/f9LNudHVmfbwhzz7MAzF00fVRqIQDEz0XzCS1NvmDM245Ru3USPE355TrlY27
 1Hdc3qF0ETGqGy5LLQk0Ki9+7yGh3RTY1rKpOZrQynYsVH4unx6AdKii+fWucPMuWcLS+bQ2Uyf
 sJmhS5sd0KM+utvabH41qaUYbHtMpaFfqQBitrx1U0BVBW8oWgV7GEFzE6Yaawv78454DNRx32P
 By/eK5S8Ga9xMA0QwGw==
X-Proofpoint-ORIG-GUID: M9aQnG6b6qyLwUoxR77tCzVOxa8Dwy6Z
X-Proofpoint-GUID: M9aQnG6b6qyLwUoxR77tCzVOxa8Dwy6Z
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5f6e0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=8ue_fi4FRw084xiksccA:9 a=-CuRuSpHYgeXv1qT:21
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
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

Add SPL_PINCTRL_QCOM and SPL_PINCTRL_QCOM_GENERIC Kconfig symbols,
along with per-SoC SPL_PINCTRL_QCOM_<SOC> entries for all existing
Qualcomm pinctrl drivers. Update the Makefile to use the $(PHASE_)
macro so pinctrl objects build for both SPL and non-SPL phases.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig  | 206 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Makefile |  50 +++++-----
 2 files changed, 231 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..c564e4e5214 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -4,6 +4,10 @@ config PINCTRL_QCOM
 	depends on PINCTRL_GENERIC
 	def_bool n
 
+config SPL_PINCTRL_QCOM
+	depends on SPL_PINCTRL_GENERIC
+	def_bool n
+
 menu "Qualcomm pinctrl drivers"
 
 config PINCTRL_QCOM_GENERIC
@@ -14,6 +18,16 @@ config PINCTRL_QCOM_GENERIC
 	  This is useful for generic Qualcomm defconfigs that support
 	  multiple SoCs. Individual drivers can still be disabled if needed.
 
+config SPL_PINCTRL_QCOM_GENERIC
+	bool "Enable all Qualcomm pinctrl drivers in SPL by default"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_GENERIC.
+	  Say Y here to enable all Qualcomm pinctrl drivers in SPL by default.
+	  This is useful for generic Qualcomm SPL defconfigs that support
+	  multiple SoCs. Individual SPL drivers can still be disabled if needed.
+
 config PINCTRL_QCOM_APQ8016
 	bool "Qualcomm APQ8016 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -22,6 +36,14 @@ config PINCTRL_QCOM_APQ8016
 	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
 	  Snapdragon 410 SoC, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_APQ8016
+	bool "Qualcomm APQ8016 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_APQ8016.
+	  See the help of PINCTRL_QCOM_APQ8016 for details.
+
 config PINCTRL_QCOM_APQ8096
 	bool "Qualcomm APQ8096 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -30,6 +52,14 @@ config PINCTRL_QCOM_APQ8096
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
 	  Snapdragon 820 SoC, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_APQ8096
+	bool "Qualcomm APQ8096 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_APQ8096.
+	  See the help of PINCTRL_QCOM_APQ8096 for details.
+
 config PINCTRL_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -38,6 +68,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ4019.
+	  See the help of PINCTRL_QCOM_IPQ4019 for details.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -46,6 +84,14 @@ config PINCTRL_QCOM_IPQ5424
 	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ5424.
+	  See the help of PINCTRL_QCOM_IPQ5424 for details.
+
 config PINCTRL_QCOM_IPQ9574
 	bool "Qualcomm IPQ9574 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -54,6 +100,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_IPQ9574.
+	  See the help of PINCTRL_QCOM_IPQ9574 for details.
+
 config PINCTRL_QCOM_MILOS
 	bool "Qualcomm Milos Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -62,6 +116,14 @@ config PINCTRL_QCOM_MILOS
 	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_MILOS
+	bool "Qualcomm Milos Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_MILOS.
+	  See the help of PINCTRL_QCOM_MILOS for details.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -70,6 +132,14 @@ config PINCTRL_QCOM_QCM2290
 	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_QCM2290
+	bool "Qualcomm QCM2290 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCM2290.
+	  See the help of PINCTRL_QCOM_QCM2290 for details.
+
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -78,6 +148,14 @@ config PINCTRL_QCOM_QCS404
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_QCS404
+	bool "Qualcomm QCS404 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCS404.
+	  See the help of PINCTRL_QCOM_QCS404 for details.
+
 config PINCTRL_QCOM_QCS615
 	bool "Qualcomm QCS615 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -86,6 +164,14 @@ config PINCTRL_QCOM_QCS615
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_QCS615
+	bool "Qualcomm QCS615 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_QCS615.
+	  See the help of PINCTRL_QCOM_QCS615 for details.
+
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -94,6 +180,14 @@ config PINCTRL_QCOM_SA8775P
 	  Say Y here to enable support for pinctrl on the Snapdragon SA8775P SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SA8775P
+	bool "Qualcomm SA8775P Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SA8775P.
+	  See the help of PINCTRL_QCOM_SA8775P for details.
+
 config PINCTRL_QCOM_SC7180
 	bool "Qualcomm SC7180 Pinctrl"
 	select PINCTRL_QCOM
@@ -101,6 +195,14 @@ config PINCTRL_QCOM_SC7180
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7180 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SC7180
+	bool "Qualcomm SC7180 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SC7180.
+	  See the help of PINCTRL_QCOM_SC7180 for details.
+
 config PINCTRL_QCOM_SC7280
 	bool "Qualcomm SC7280/QCM6490 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -108,6 +210,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config SPL_PINCTRL_QCOM_SC7280
+	bool "Qualcomm SC7280/QCM6490 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SC7280.
+	  See the help of PINCTRL_QCOM_SC7280 for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -116,6 +226,14 @@ config PINCTRL_QCOM_SDM670
 	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM670
+	bool "Qualcomm SDM670 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM670.
+	  See the help of PINCTRL_QCOM_SDM670 for details.
+
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -124,6 +242,14 @@ config PINCTRL_QCOM_SDM660
 	  Say Y here to enable support for pinctrl on the Snapdragon 630/636/660
 	  SoCs, as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM660
+	bool "Qualcomm SDM630/660 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM660.
+	  See the help of PINCTRL_QCOM_SDM660 for details.
+
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -132,6 +258,14 @@ config PINCTRL_QCOM_SDM845
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SDM845
+	bool "Qualcomm SDM845 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SDM845.
+	  See the help of PINCTRL_QCOM_SDM845 for details.
+
 config PINCTRL_QCOM_SM6115
 	bool "Qualcomm SM6115 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -140,6 +274,14 @@ config PINCTRL_QCOM_SM6115
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM6115
+	bool "Qualcomm SM6115 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM6115.
+	  See the help of PINCTRL_QCOM_SM6115 for details.
+
 config PINCTRL_QCOM_SM6125
 	bool "Qualcomm SM6125 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -148,6 +290,14 @@ config PINCTRL_QCOM_SM6125
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6125 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM6125
+	bool "Qualcomm SM6125 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM6125.
+	  See the help of PINCTRL_QCOM_SM6125 for details.
+
 config PINCTRL_QCOM_SM6350
 	bool "Qualcomm SM6350 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -155,6 +305,14 @@ config PINCTRL_QCOM_SM6350
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
 
+config SPL_PINCTRL_QCOM_SM6350
+	bool "Qualcomm SM6350 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM6350.
+	  See the help of PINCTRL_QCOM_SM6350 for details.
+
 config PINCTRL_QCOM_SM7150
 	bool "Qualcomm SM7150 GCC"
 	default y if PINCTRL_QCOM_GENERIC
@@ -163,6 +321,14 @@ config PINCTRL_QCOM_SM7150
 	  Say Y here to enable support for pinctrl on the Snapdragon SM7150 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM7150
+	bool "Qualcomm SM7150 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM7150.
+	  See the help of PINCTRL_QCOM_SM7150 for details.
+
 config PINCTRL_QCOM_SM8150
 	bool "Qualcomm SM8150 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -171,6 +337,14 @@ config PINCTRL_QCOM_SM8150
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8150
+	bool "Qualcomm SM8150 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8150.
+	  See the help of PINCTRL_QCOM_SM8150 for details.
+
 config PINCTRL_QCOM_SM8250
 	bool "Qualcomm SM8250 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -179,6 +353,14 @@ config PINCTRL_QCOM_SM8250
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8250
+	bool "Qualcomm SM8250 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8250.
+	  See the help of PINCTRL_QCOM_SM8250 for details.
+
 config PINCTRL_QCOM_SM8550
 	bool "Qualcomm SM8550 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -187,6 +369,14 @@ config PINCTRL_QCOM_SM8550
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8550
+	bool "Qualcomm SM8550 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8550.
+	  See the help of PINCTRL_QCOM_SM8550 for details.
+
 config PINCTRL_QCOM_SM8650
 	bool "Qualcomm SM8650 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -195,6 +385,14 @@ config PINCTRL_QCOM_SM8650
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SM8650
+	bool "Qualcomm SM8650 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SM8650.
+	  See the help of PINCTRL_QCOM_SM8650 for details.
+
 config PINCTRL_QCOM_X1E80100
 	bool "Qualcomm X1E80100 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -203,6 +401,14 @@ config PINCTRL_QCOM_X1E80100
 	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_X1E80100
+	bool "Qualcomm X1E80100 Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_X1E80100.
+	  See the help of PINCTRL_QCOM_X1E80100 for details.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..a3d6f8bc5f6 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -2,28 +2,28 @@
 #
 # Copyright (c) 2023 Linaro Ltd.
 
-obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
-obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
-obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
-obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
-obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
-obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
-obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
-obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
-obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
-obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
-obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
-obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
-obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
-obj-$(CONFIG_PINCTRL_QCOM_SM6125) += pinctrl-sm6125.o
-obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
-obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
-obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
-obj-$(CONFIG_PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM) += pinctrl-qcom.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_MILOS) += pinctrl-milos.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM6125) += pinctrl-sm6125.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o

-- 
2.34.1

