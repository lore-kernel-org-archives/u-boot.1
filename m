Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC884C9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 07:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFBB280C23;
	Mon, 28 Sep 2026 07:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ugExJKSgJ2xm; Mon, 28 Sep 2026 07:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E880B80BFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790580743;
	b=jzl4RUdPpd7fZrli7j3dISlXGaVLXS35G/G1hDi5kkQ9zMYLsFQqved78fVUoPrilVak
	 QXvm1Ga1wYBbqfiSdkDQ0aew5JCZpiD7S5RCBqX+Be2A/PDOedsAUanFLqOI41ialU+PL
	 HM0ZizfxgsvVIjhvV7BsZt4DMpBbr4JD8BLE6B6EbYqc/poNc2rwZ3SSw1qOff825Sp+b
	 UaAWdBA+1yj87o7QQHh5WrjBg00DWx80Zz+f7T9UG+tXBDie1o0bpDlDVOFLCf+OQf1MH
	 6x5VXD64vJuLowVZNx+3xMa+JqoPSPCcWVpBvuUhdDgl1ulGLc7ektHxRaMJDggDYjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790580743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
	b=hPwdYs5FX+bp3JAdsv6nf5v9k4TX4X7LvT1XMAtmdeCF4AL24oTxIe+TQ2fCoBBWN+n0
	 2iC7st/SujUCHPkWJBEQi1Z1KHhvS5d3+foEJUg8amr78snMlXsJb2W7DC7Uwckqz0BP1
	 h44JLDteYs0KscZldDqsiPgg0eQQerY2wtFxmEkud9qC6SL+hDbWyldoYuWb3orSrHKaz
	 YXPZjuSwBvM0tA7Z2JZs9JWUwn9dEKiRUuzG1zMqjMa8+Dk/relx5vLpqOGu2Bb9Pe/jy
	 5LzHRhp3X5qW9t/uDjndY5Er3oHzdJwMkSQPuPFKeq8Dza2JFujB/dOe49kngUQ/EqA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790580743;
	bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=02zJgV3nMs3sb+9fM2F0Nuxy/vzjepSKxabMG7izkAkyWQAxyH1EJhCmgzZshXqde
	 ETNe1r+ucKm8I+dtih+x9f3XRqOMalXYe+54ZcRpSK8IUfekeVc4l9G2YpHWowhNS5
	 X51B1VHM2w9MjHDRoIVgpGWJ2TvamrYRO5hW+obkFq01/u8wm+PSJkSsGyfUbj3Nu6
	 pa/NWmEv/5g8egKsq3j4peRJ84HOzekAxaO8+0a17lh2dT0Mh6iucvjEi1yyGEXTpW
	 JnhIcS6DT6RPGacYmLrSlCmDNzrI0P9//+yR3RxCbMFcsIJ7iXWw8UsdhE6FSgYs90
	 4O+4lSZ60jM4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E880B80BFF;
	Mon, 28 Sep 2026 07:32:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6F9E3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD059400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:32:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUi01HdxhF4m for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:32:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DA497400AF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790580740;
 b=If7BBISCHEDJM4K1Hke/1yXxCyiIefeDG6l6CVZZ0CCOBjdsrAyjgcD0h8EwEy1rSdC5
 Y2CQlFEciKStFvdTqCsNC5l7hT0FWUTf5X08x6N3ldc9Z3BTCZu1Rx2PrIK/qFCjQi4H9
 4s4F9ejYBbJa2RR0ghw33Yd4Jccie+0artCWoCT1CqSBONjYZPjvz9/gGoFYr5oSRzSiJ
 TvMeTZoqF0GOo/gcjHKEHdiB8RaGe8t6KNSecV0c6W6Orn7VekADDmZcCH4Uq8HknanSo
 OR6ar7m7YeGFxpXoA3baiYGOORkiaC7yA1UNsMhG8dfvo9o4RtYbK3BnfGc2HnnSl3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790580740;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
 b=j+CkXFJiNb5t1gt4s1HNBpNFTMjSYSOHi+Eb9T6J8KYsOr2L1cUx1K+bN+pCbg7xeU5J
 cre+wAiY8yzniCKlGXRP7m3jJLynQG7fzCfXoEbyOLQZ+lCrqQKAtXfTUBFnks38RDonu
 ZJzQu9nUk0xUmuhHEnJPn5EdB5VYUf1YI1XOkRCqW1twK+XiEifsImQ0Cye4vGtmL6lwA
 d9a3A5UgiUYHa7Tf+flrKrtcIUwzBr+ZTRTc75zpfAU3UwGe4aMVq5II8889VepgWxvJz
 ea5fKm6TJUl55VTPvTuWGOGnGQJV+x01XKejHKUtbuxyKGSJAySL9c9qAXtaM7aNhoA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=U2mlRIHn; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CydXV7AP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jens.wiklander@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=U2mlRIHn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CydXV7AP
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA497400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:32:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S59VfO1502177
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=; b=U2mlRIHnkQ3XRB1Z
 er4AYjsJ4wpCtV4xfv/UvPqvFYwFDCW8ZK+gnKwir2VfFzJUHRR8ZFdGFu3TVqJU
 oDiLopVweE9A5a+8cNX9nGCYP0toaLBk/SiPT5GOsOjOkxb/63Ahk5uZ/PMGluLI
 /JMXDfFlejo2JqvKODEJWQ9rzLARwFmNI3OmzYTg1dQDKBPxFmzoDBU8Weoz031n
 4VFgt/YN/eZ7PAe2lv3Qsal1swqQfbDa4ATz1wuIJEhfi5urwRInzUuuFBUTpW43
 4XmUCRFfOE9yUjfJRDlxw5AfJLtI+Dmw0gP+NWAS7c8s8wJFdg0suVZH9e5MLCez
 nG94Bg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgef6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:32:18 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8a88d53c7a6so31508537b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 00:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790580738; cv=none;
 d=google.com; s=arc-20260327;
 b=cepd2ofOI/BN3h0OyXgnDe/xq0HJwvYqG+BAvwbFTRqqHx7pN4d7L2NHjGC7pIoucl
 8y+7/QqA1mOQKvwGC4emqxOvjbR6b18vLBQDE6YoGaJiNpfBIuOrtDk/FOKpjiiB+QtO
 4Q9uvqD87upn6z0c7hrzsxcUfTN3nNF8e/ziPr2PpuRmJGYms7cmFUNGO4MHCf0opl71
 Qtwfo8hf8zujYS2EZwaD3sINBowj9ZELyJGeNnAn8s0LQeO7fTq6cHJV+2BI1a9bf6Wx
 z3mFyS0kDyiMtY4bqtOL5PDKi8gq1l0q2peNQa9bN+MZAlP32vFNU8ZiLMG5WmHj8yRw
 xJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
 fh=SAz/xMTNOE3X/mv560EORRAAEmVG1CJJ7Cew8NgDVDk=;
 b=OGuTg2wm8Vfmch5wECAZMXH0gppd0iUzfdCPctYlEKU4D4ipKAsD+PfVV1V/Hi+D2T
 F/hSqmvnL/MXYxPmvUqVyZixQjncPDs7yUeQppQO2XL6hNigjxxL2u4WE6gDJ7Z+Ry6Q
 GexS5jiTW1xqQyMPub00c6J5zA45NkhTyboZiHMIPzUfqUi5BZ+VWyBIJEmgWuD11exF
 LeIxW4eH+rF5gEskJTvNmFQx6prNvG0An6TG92gwB0tNajsL3bSN/BI/EitOV1SWHSbo
 hP2fiAz3QsDTucpB5qwk8VzYcGNk6v5PsEGKby0ecFfpcARlhDvOsqqFYlfuivITQvMp
 IYrg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790580738; x=1791185538;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
 b=CydXV7APs38M6O5quzQkdHo1m+3TEuMzUe9nvv6mk+H1J9Uf57nm7yucoy7RtZOr6x
 8H9/YX8+sabc0jM4paFTb22j6aokAUI5d3Y7Yke7KQGPwyCCYt+gyK2GOYPRoTutIBFP
 ntDrLWPu8agFwmVmwjsQcPVqrktOdtKchSmSHA+A/BXX5WNmn+LTLYmY+UjGZv+ZU1TB
 MhJsnQLrGkm1VqjuSu5vQIvQoz2PiCyA+WwTQPQqLjZvlYr76MUl+K5xPFE+q6MBY18g
 UnGbEZvE93EQs8mfXQU9ylPYhpQ8sZIzA8VE55gfNaPYDCocF71U0p28fnNIx/TFpd8l
 zeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790580738; x=1791185538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pq5L4RRh9bex9EKsIewQBSZ0vOnUwxLNoP+3aVJpDag=;
 b=k0Z2mAosrf7Ul8C9o6ZELC21odtd+bzmJxKjKkNEENG1mKYyXX4CMbFR+s2DUK1o6y
 Tfo+6Nrm475NzP1Z7rY83Ip3jDBJCzuB0TPRiIxbzNNldkPWGW02kFJXg/OmxmuVPoe+
 75Ojb2Tc1J3loWkRCfXQQe4HDKKPGKPGfczf+uR7uKvm/aDbIDFPObXUiUz6EC8gEHyH
 ybDigIWlkNhCSGgP8bdox0q1K6kZlU55d9IQW1qTAtFqqtLXMDefTXSexsm6HuDcW/cv
 JAGpDyHc0YJMJgs0SHMdKIznz0X0o0TO193MjWeQPoJTek4jKQc6wipOT3EbG6xnvUMG
 PwHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4hHq6C79NLD4EwSdI7TDClZ5I0ZwQSotoZd5+wCOp1t/m1No+hNeA9VA1BAg8bvHuSY8jd5E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJXhmn2brPL3dZkOpOZVbnB776mbK6IbSMlEtWxz6J+x8Gn7OsX
 TPlea+PIaR0hk+uC+SqeV6Wnx6Ouc0XqulISOE0tZ6p03aQwoAQ55qdTx4H0iXU+wlDzWB4GgFQ
 Q7i/bVw1FfdrWpaLVzZgLUxs1D/3s2SW/G8NkY6IVvPousYCB4jL/AkIMIGJ2Cqn8/UuN0gy9ZQ
 UbJ/pcwYlGV7nw1O2JCnmk7Hsv9NcogxbH5u4Mwzq0R0MB5g==
X-Gm-Gg: AYBFou0o+FjkSu8ouq0UgqmYOVwPlVPbNmNDci+NlseNxalNJyisXrzZ3Eek73Y9lSV
 vHbz7/a4/6OOP0jSPQF+DJXGpRMJLTbZVoDO7Gt6VMUL6z57+RXz6pNzgUARhE+KfuhPq82biYP
 HXdf2eGmxvho3JqkLUkWRA0npV06alURYQNukJwJm+AaxPZYg01Sv/hfs=
X-Received: by 2002:a05:690c:10d:b0:873:5ddf:d87a with SMTP id
 00721157ae682-8a648609252mr45234767b3.69.1790580737922; 
 Mon, 28 Sep 2026 00:32:17 -0700 (PDT)
X-Received: by 2002:a05:690c:10d:b0:873:5ddf:d87a with SMTP id
 00721157ae682-8a648609252mr45234547b3.69.1790580737498; Mon, 28 Sep 2026
 00:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
 <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
 <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
 <argt3LwLjENr5vZF@trux> <arg0a8HqaRxVif9L@trux>
In-Reply-To: <arg0a8HqaRxVif9L@trux>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 09:32:05 +0200
X-Gm-Features: AclHuK93-1GuQMGWDh8z95kRzJmDrZdEOwxbsBXCUVfW_CNWew76-0Sk1pda0DU
Message-ID: <CAGgiveU2Tky6tHA5fYCYcoQA=Pucxo3ktcJrSG-9yiEZZruWsg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>,
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>,
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>,
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?UTF-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 1Bxl8E-rIbl6Y0Tjo6VlNyNSChEuDby2
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba1802 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=c0RMaCu72UhGNoOGgMkA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: 1Bxl8E-rIbl6Y0Tjo6VlNyNSChEuDby2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfXwEBjM9eyEz8o
 GqV3tL6htRwi6r148c3fMLtRuYeTV6Ijboj4MZG923pIHDfV1zixSjThL+sKiFffazvsPxNJLhX
 INjMY03rrpvYx3yhA07jZISIcYgUCuTQnETH/jFZk4K6fv4ryi0fWZ8QCsAoXDC8jrNB7nznSLV
 MHeakKqZboAdKApyE9/dc9bGdQ9vks6hVZczlAmPCx4OaDFXXCuy4AiG1stqaR8BqUG0xDi0q0I
 YsgZg0xRdI3kJ6RMQaInruiY+d4pxWTMy8c+Yj+BLj7W0/QEQ4WuCTpOiPx2r47U3gceE6xkUxi
 PmIIwTeNZ07b3x01SESmdBelzLWsT1EHZRfLxLXHyAZk3hkUxyxININycH4h7T0wR9I4JGRZeuy
 zew6/ijy/hk3RovUSaNmVaObZf2Mo52HJoM4qMba6rVKTFaZ9wUA5DJLnnecQ01yK9TjKUHcx43
 PxaOXUnQ+vBqzF6ezHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfXwukMX3FzpaHO
 44Gvnv6Q+P6CCkDAk5/9fSesE50kS/r7Cdk8IpnyULOJwEJSkvGUzadrTMybsulsnHL3USs7R77
 8YVyYH0iUEFTSlJzJbtU9Xy3Sp+ICLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280029
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

Hi,

On Sat, Sep 26, 2026 at 11:09=E2=80=AFPM Jorge Ramirez
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> On 26/09/26 22:41:00, Jorge Ramirez wrote:
> > On 25/09/26 12:59:28, Ilias Apalodimas wrote:
> > > Thanks for the detailed analysis.
> > >
> > > I am pulling in Jens for OP-TEE and I'll have a closer look next week=
 as well.
> >
> > the concernt I read - please correct me if I am wrong - is that this co=
de affects
> > downstream projects.
> >
> > This is just not acceptable to me - downstream implementations should h=
ave been
> > posted to prevent exactly these kind issues.
> >
> > We spent  time and effort doing an implementation and sharing it with t=
he
> > community - it wouldnt be fair to us to block this merge on the basis o=
f
> > downstream projects being impacted.
> >
> >
>
> in summary and to be very clear
>
> 1- the upstream CID derivation is the u-boot/op-tee contract that
> matches mainline linux's ufshcd_create_device_id(). The contract is an
> OP-TEE-defined ABI, not a Global Platform spec.
>
> 2. Moreover CID-key is OP-TEE's own HUK-based derivation, not GP, not JED=
EC.

This follows the OP-TEE ABI. Further extensions to the OP-TEE ABI are
best discussed in an issue or pull request at
https://github.com/OP-TEE/optee_os

Cheers,
Jens
