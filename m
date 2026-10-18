Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E11BCCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD22360741;
	Sun, 18 Oct 2026 20:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5snrwCaUDnV9; Sun, 18 Oct 2026 20:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7317760726
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356687;
	b=sFJX9aEtDFED/rD+i02fOe1J+sTHatvWiGZPrXviWPZSbWI3Tkvq0r48YUb76SR5P13s
	 8JGZc+TwwVVFSD7ff9w8CMBcMcSwUtBqmr26cF19Iwqeg00Yqwnwe/j/gujUyETeUVKBB
	 9yLbkZ27BDeNr441ub8xITmSEbKRFd2DkQ2o6RxLZdly2xq3RzGTTH0HMY36rjskqEY7/
	 izSwYqFcO0eUIp2JCXO4sfZ3XeNHgQ+ts75t3oskzSWvWJQNF9UrG3GMcqPGLuCVRoa8+
	 paUnFt57pjGQuzqiGaWQlpphfcQxpuXNqAIA1uwRUC0EA6Oy7KFU7Y2faxBB+LZAEjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=o8qsXZ42VrXM0VYViLFoW0LKmFtPsQk/C729iH0z8m0=;
	b=lr5DKXZm883cvOsh5Q7TiQPf7EYzSGHKvu4lsPEXVngy/RoA7kbJ7PowXPhP/7Z3cMX/
	 x5BOcjNlf9XIBhx5gZLoTKiCd+mSH4rXXbYkADfEDo9DQj1Kcwu7zZqnZ9G1QznbeqwDO
	 5mM05Arqs1mu0JPes39WvzIis4YdvuqJGmon3MIt34OB+Pgt1ng4rdVuR9AjKWbvlmnh+
	 ByE+qQqN6JyK0D0dVOKjgHrcSU96As9+3mzZcsPywfz7PXzTB2XwgR6tZvZE9xDpc0q+u
	 1IzjAI7Gg9L3ssjWJGNvogUfIuv5TSIXUCfqVsE4p3x73UYiSIll142+LyYe51OloTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eDEagz0l;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wxe5cB38;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356687;
	bh=o8qsXZ42VrXM0VYViLFoW0LKmFtPsQk/C729iH0z8m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ar8B0kXZ+yD0QpzbOlz2eYX/D2azZzioK/PcxNsfWzpdZwB+VZ+EQ5zkWoSeY5X+O
	 0mevmr/Y5MFDbIHBxR9pZCdZlqE8Pn8T3VBgX3AQ6xHhIjiNha06NMzDOCnDO489dy
	 3L4OhDZkgplK3cZ9WF6daau5aCVl1fGjxM4wDrxuySvq7SBVfHSJJtYkq74GlU/4D6
	 80RhOUTVThkq01nRX9hewUe4eDxShep5Kcs6izjDdzS4TExtu8lt1DEaZ0ORHEUJH2
	 8rgxsBQOhnx8ceWS9EgjFUq5iRxrKMS0EHqWRZYeNdOLzwkbDkMy3d83m5Jc+l9Up8
	 4Itp9Oecz/jbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7317760726;
	Sun, 18 Oct 2026 20:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44C761AB
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3726E60714
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svK15aJzMGAg for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E67D260638
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356678;
 b=UhWV+f7fGcCOSfR6iMuPQ/Tk4nuEnQSFIsVOt80Eb5oMBSC2SjHvOeIYB0rlYe8xVyH0
 nHwkYoVb15mDRvWWvNbJjsVUzPvsig8xwOeuZk0LYu4aOXvmas6xnPiTa/5yNkGVUsM0B
 l66F9N1WmUcIEeSDC7MkWrtIBlVDST8MrqqY9bvyh9IC14+BBVFK4yCbro2cP12zAJQ8h
 OihJiPm0P7XXhKfSGqJRg7Y5yHlq0lsja9xgaZQn8mGHJA7FAKkL9Ef1cPo5TSxmIQMNT
 SM4C+LLkePqg7VZ74z5L5tSXEIzVX6mvgxaDdvMSeU7xtqxEWRmzmCPUdN0FourBIOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356678;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=o8qsXZ42VrXM0VYViLFoW0LKmFtPsQk/C729iH0z8m0=;
 b=SSnxroFGp2uV3qJ67srGxBw1TKLvZfuTEd0RIeQPd9AVA1H0VCJonOu6Bhd3Ssa6VTgk
 vQ4youOljD24HYT4vFtGZ39LyMISyBWHelsfGJbdABYO+/vbz6A+sr7eAkMrR1eOWpkZS
 q/QonPqGlM/9cwz25G/x9G4K8U0Znh+Y/N4nFHi95P1X04zuLueXyaNZC5kPeoVZNuemq
 cwgiNQDrbrlsErjZ+u1cDphAFBKq3zxWvLybYl0R/bGn6Jg1x40ooVomJWhXrWWvWQOai
 uoYnQhT1yQzGj4iUSpOjVXiTDZ/PdDaIGxnQdFlErqUjH3B11c99moUF7F49g72zglA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eDEagz0l; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wxe5cB38; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=eDEagz0l; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wxe5cB38
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E67D260638
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:17 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKCott1717153
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o8qsXZ42VrX
 M0VYViLFoW0LKmFtPsQk/C729iH0z8m0=; b=eDEagz0lrVqydISFOWM3dajI9g0
 h2Bm/OUkFlHqqoWj+kS4axAva+gs3kvh1WwuDkNv1oReQ3hBgb/i7IU182eEp+Fb
 vp206tpEmGCVZj65+drmnxzOcwgiMT8HeSiLaSqDsYEFebGjHToKSRLnKUdh0ete
 06amj56CCk1ANlSpoUoEUYL3z2Hl72tiUONH6UyX+QoAxvtYL0Sdi4VFeMFkN5IK
 fecm1SDZ5zYiXqmZeSvodFVPr5MGnNN+0JdeFDpvD8eORda0nmJgjpiBAGDdEjVi
 qiucSXEFLZ4XlihO+icZGB48fktJ+r+njTUwuNZBo3UWusMRBlgNjsiPqtA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys41fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so385414085a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356676; x=1792961476;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o8qsXZ42VrXM0VYViLFoW0LKmFtPsQk/C729iH0z8m0=;
 b=Wxe5cB38Nxu7j7gx8PD7H6Yp92WecoOu/1VJAJ/pQhYy/E5u0Yg8sYVqQpoJT/csQB
 ExHH6mKxrZHNNW15AZdk2OQKud5EbfQEMjiWf9fxxOY5Kf1B6SC0gbGN/5nM80bEpLL0
 SWNdr4D8eQ5gv/zJ2a6MIVU/eG5L5TQXZ9dT+PFjz7GcBIK0Ub45GA8U8vT3BubNTad+
 5dOULc7H+aA9xEl7fZ9E6RABzHga0oKWdIg1hCZvMJ9LPPA031YfhpjBmOHpoPesldzR
 mmU5L+Lls20C/l5Zhad9kXFUkKoNp4n4ub7RcN7NoUbajl3ReMxWrBtNKgGbKsmBXYhM
 xFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356676; x=1792961476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o8qsXZ42VrXM0VYViLFoW0LKmFtPsQk/C729iH0z8m0=;
 b=ooxwlcYLnS7BSSvY6X+Ds+zZ4Fuj1OAh049sW9+lVWQ70jxEYiNzFaIqP09gWmHLWT
 pqz0wGVsrJaFTZOSChGuqAaLWOhOOz2fhGK3T54WyyAc6aJRiBuCLSuftOFzutqdooPK
 XmE/AdVe1Jgc2F00u9sA2SwmogzGhjbmgIsnS5qSwTQB1LqqhoyaZ2BFSNK2erYhs9K2
 yvDu50j6XbNzVlVq9UL+3MWMQYKIG4fd1jCYmIjbrXEZPOj5gksLaCTYNl+zfElfMtbb
 1FZLzSw5/pSoM2sZ/etezYZOu4MH9onINTDXYAeW3GbhweRqC2EPGjlKHaLdHeMhsvEU
 X6KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk8487JHQ0xaey+xAQrJ6uAI3M0JpSDUX0nEAAJn36yn+yKnsniie5tsUTTa20o3l0BTSzGSI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJRyzAhz7GvotPS1GePEzM4h4OB40V4W6fixNLe7TG7gb/LiwQJ
 oopNDbATVnF7wSc1WsdtyQQTHhvjCQtnTpMqHF7oNNBy4UYZJfqYQ+QVXzbMOvIf2paZ92FNqNr
 CHQBrCfaHTGUSKZeuWmYeXutAeyyRiZVtsEfwmyRVsPYLduH4GgWMBUy7Os5wO5UsthKJdbE=
X-Gm-Gg: AYBFou2Hj8PyidLtB02XgTkTF+iAMv1ibe4J7Cp12o7LO9pVY64G7QuMJazWU3EYIvO
 ESiZHwuq16RCX2rHhDDL8x/s6LhYetU5nQNmhy57w+u7dqdR7pf9llIscU6V7B0CSCrqZ6UU0Y2
 Jo5erd3ofVQzIN3ebPj6fzeqtz73KAT2YBeVbxRrcnprDM8uJEnQ7giCcGTIuVxiCrkkriK7q0j
 bS9W1gIimf5Veq/ur3uHBXj6IqHRbNgHYCi+zHiRulCyNtFXhyonk05ZWnKtnRELTK7dL78ovPX
 0fN9prNf7sESY4lNy0K1xUazw1k9mhXCNlrOWCbnCgH1dmWqNOvUdKvQkTU5qf8Haj3opPQIRl9
 ITofKJ8Tt+5zcZQEQSWnJXU5Bdcy36vGUw6vjMF9hP1yI
X-Received: by 2002:a05:620a:688e:b0:93e:f9ba:690f with SMTP id
 af79cd13be357-93f29dd4344mr947948085a.73.1792356675981; 
 Sun, 18 Oct 2026 13:51:15 -0700 (PDT)
X-Received: by 2002:a05:620a:688e:b0:93e:f9ba:690f with SMTP id
 af79cd13be357-93f29dd4344mr947944985a.73.1792356675508; 
 Sun, 18 Oct 2026 13:51:15 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:14 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 5/6] optee: rename rpmb.c to rpmb_emmc.c
Date: Sun, 18 Oct 2026 22:50:55 +0200
Message-ID: <20261018205101.2362593-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfXzzr7ReRDGmHh
 Ztmnu6LotvRytncEYMf5nJj/ua2st2c7L5TRRot0rYtTxt5LpFe3+8YgROQYf6rSEI0NwWjnoXS
 t7TrVii48Ma45UAyvOrpto7nueNmuIa9+PxSyqZEP7fHij74//kglFplGrqDnWZipVOFsT9PooB
 rL8NxkYxV85KHXXI26Ix6QzGFWxKVrtBavwqYl4Ii/5EzR4xunBFBK/+3UjWCrkgjHlT801NqXg
 EOj9kIV/ycfY2I5FGpXGR7k4dHK88GjPJOdNer2t1RWP7zQaxT1e7RxvhGM46COBDuLOA2ZoN7r
 ijhCxiGLgtf02MHpJkQJAyc5wciorjOdrV0J5fxH2lj5EtAh7M1i6qft2XE6eFl8szDMFl9Vcao
 jMrnMcPyPe9+KCp8XVNUlP10FstRhCYYw4qyhjey6nG61h6JoTeoXB1uj9vTW+7/Wa2yfUb3lgO
 Z64BmzoHDFv3H5zxlqQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad53145 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=LU0sxQhnb9fjQ-tQqisA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AQXzyufjnr4yWUPLoZIF4t-hTSUJAX-D
X-Proofpoint-GUID: AQXzyufjnr4yWUPLoZIF4t-hTSUJAX-D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX1ZfnOLmBbaOn
 PR0rJZuqm2HqeWYS2EH2Ccm4xmVCpCNs2zXODQS9nJcETa5i50KO8CywQ/64ZZ/DI1308H/nsaa
 IX4blehLeCSISPSYWKOZ2aBMvSlAdJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180083
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

rpmb.c implements the legacy single-command RPMB supplicant, which is
eMMC-only. Rename it to rpmb_emmc.c to make room for a UFS backend.

No functional change.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/optee/Makefile                | 2 +-
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 36ac085ef42..d0c7f8dfb12 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
+obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_emmc.c
similarity index 100%
rename from drivers/tee/optee/rpmb.c
rename to drivers/tee/optee/rpmb_emmc.c
-- 
2.54.0

