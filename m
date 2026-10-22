Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4E606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fuHt3Wxp;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eX74YxSN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g5EIkHGa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3094608FD;
	Thu, 22 Oct 2026 22:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chLW4omXClxY; Thu, 22 Oct 2026 22:00:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A848608F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706438;
	b=buR1M2U7woX+rKSP11sXnYnP8iBV4CIEO0+RbGuC3Wy19QPd0RA19YNOLzp8K9Nam8OK
	 GTmqNu6rVIu0zs1jxbEobpwLpezoLQjMVMAqNA+DsB5z5Xcp3jGw098AR4BdgIZQJXVi9
	 t0opY9uZhuMGXr3zsTGAMDuJOyXK4Rjh99aacxpOu2RMfNhPDLMA5dB53IthuvKTn1gPS
	 UhVDsrZcBFxMgvFT3gpbUztow/3vmVSTl3s0bDuKbWTlcTkYfXVT3CF5OUz4VmqQuseCi
	 D7P3NrBpmWW3+v9/EucQw2Rt93y4zfMKRD+S7pwVRlciZSO1aax5KjdLiq0zuuayDVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=;
	b=ratT+K6tt5VuUmxO7axeVKhB80uZnSQTjkdgV5kuPym6RN3PZK9ze5o86YodAVUU7LBz
	 IPd+EvGz8zxDzzr/tIcloYPZewlqBrQzbFqcYvZc2TeUxOysYUNpqtOeVgr/mb41wkBFR
	 tGg6vKdKjldogyN2pHuHCKa+dDi2ZujWhtspQh+4mXL6E4bTMI0R6FqR/IwQikKVBuuN/
	 U6YN2g8e+c+BGj11X//pAvwziUMsIAep3sVa0koekpouZlvCmBWMt26+hyf/e1WFEFU7Y
	 5Oi0o364kHdRH7HkByuuoSF1AhZ/rVk/InZSPgoVvXHEbeik1NS0nbi2MhmgvtPW8vw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706438;
	bh=feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fuHt3WxpibcMnpVhSVxWDxBZI/X9f3J6WVaB2GdDm9sC8yI59RGPkyeHb8Zs7Id4H
	 ai2V6kt/JqO1zKw2/DyWrDpzhPxl39vRgqWrofswaYoUF7MoFttsCus0t6AMGDEcp4
	 3A0o6lQcoFTOlmTg4vTYyRu8KL5Gg9AfWsidLv4m1kZx0NOa3l8Y1W8cU/BRHhaNRd
	 RG0E0Ks8ijaemPEie4sr39IIES09UtUsXH1Bjoj/8uXkzJDd8POjPuGUg297aK+9zw
	 oAKZWJjXrh/rB84mh8OAMMQrbKSLHo5zFAMKYtFVITShwdOibz84Rg25ssFGPqQszV
	 Li3QgwsBV6crw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A848608F5;
	Thu, 22 Oct 2026 22:00:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B1E095C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CFB640270
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kagwRWTvBcAx for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 813DB4040D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706436;
 b=C3thc9mLnUDH2kWVGgKZc7VezzbifbqsSQZZCj8PSYNM0GO07tqroyXfNS2oLfEclH1t
 XKJtsTOyCQbPpDoGdfaHoOMg1JZCzVAuNUGpFxRpmToW0HwS3E+AYMnAah0McWgIYCsxE
 CXlmy5JX9SqUHwj3hVTKx8DSEoVrUrxNo84XCHCdtDbRMy7gjNoy3GpKR/GcBqUXNwbEb
 Zz6BYUKavPFFJZHYLR3av9quFOokbOB5OyYrN/mqJa/yuQIHBryrlO9BFmYxmCd1/tcBe
 kGusD3UHgdjmKHbTsMVl70vsRwNoJhkm7Tjm9HGF2XDZWwx8wX2bz3UV6+lpzl2wTww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706436;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=;
 b=o7pI8Wxi2HO1RQKlAmusldnHudKs0HSQ8/HBC52t4yy00/NzIIt/p/NDoilrVdurWV+B
 bhuj3foHKj4EiVvh/5tQTJyR7brQPRrVoDd/SGwaGErkkNYaGIL7jfTL7ilpCs0hNGWL6
 J6YA9igg9VsYDOqcxwY5TGXh30nOC7p1LBdfYGUDZ9NwOEZ8TKiaeJHkfFTajFNdbjpko
 oGkmpAwBKXkK4rDNpoWqR7b4DMa3TwdKmPrxT+45ODAP/46TN75AqIC5FVq627s+Khfjz
 lbcfR3iLyJA2Nufb4t/Wv4ZcVdWAVr4mTDbe6P6HzCkJygZSk0sqDW/GqPq76CIC6eA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eX74YxSN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=g5EIkHGa; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=eX74YxSN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=g5EIkHGa
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 813DB4040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtmET388899
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=; b=eX74YxSNbTCFUz2a
 Qzvv0AHwZ1aYrDfXvem1rymGK9VDi6Kwh6/rtHr4cMr6xLR/vVDf8exYNd3lqjN7
 xyUibrrj4XBVy66lOdJGUJaS6FmUZr9o5qakqxiky//vIvgIO6E2LDx7dN82/RPr
 XJkVqF0dlYqoh9uo7XCmKib7rLIfHShiZKw4bqiXybDg2c0v38Ab0Vtfg1KsyEkG
 f2RFpoepKyO5FV3JbpgbqzzXQ59nHV2EBKpuPLfEEI8H8pixgM+QITFVJnlg8abh
 EENLrMvUaFSmOX+2G+5ScCeUOpler8ZUmpeKk/3njzusVhyYjYF/fYz2hGh6t7Od
 xSlsWA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:33 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6798c43a3bfso607664d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706433; x=1793311233;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=;
 b=g5EIkHGarDR66H95FRHYd3z/6IPMTleZQ0lRqe9arxZbrq4IVQ1JNoTsQBmOZDGC1V
 kkxoKfVn8nGU23YZkt1NyStnvGj5UiPtc9ainhuSICBO+dDfUMo2WBbXctEt/auxpOKA
 WYi0fFtB24Azeif0Wr+PmCL7DN9v9YTRZ8P0J69EEs0KsZnVNC6jMZvoqizR4DN0iwHq
 vGv2MJPXf/jCi1zuP0K7LRJHk5zb1WRIuRrvgq7gusm76IPXkJxya0M6d/8wed15Hduc
 lQaU/77KCSkr3HS7fbdd+aj7/QifbH63lWWaddNxP0fem2ZK9SERF6Z7YZN7X0/C7SzV
 l1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706433; x=1793311233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=feXyRBfQbqZV4qUVwVTRdL1abwv7UuBtb71VZfyAbVE=;
 b=TqHEGjH1fRjbN3He2qQAyyo7vQt4483fjMXMoqFWHdhOpetSEo+mQBKEde53Yt1TuW
 hORKCDehDydPONGtFlS7hBMVeT4PQYtjrNAM6fGD5zQIQebRu8asnBKUoGvtu59j8e1E
 o/L04G/aZ924ctE0klBACkWfjDR+ibrgtTycOjvi4X8o4/Yodgd8WBumf0UdZzgKD1Rj
 KjxEKGIFaE7vxRsiOoMRfutGI+pjXscNE2IIwZRQwwlBG4ezcyukC5AKWuKUkt0qLJkn
 l9TzVWlO2/UPgBGN74wIw750NkR7QkMa/jPiNmM2BRplelXyBtrbZkqDsagDZVUc3rMp
 C5gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtOyCf9T6iOxw1sYEQs4tK/mFLXYxYTAdPPPPIwQPBv4DbdOGOtzaM69OrpgPECe1vU7iooLM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ6OQ+85I3ejvoVkACeDbp2OerY+udNngd2lEwql1+Qd2rpq0gD
 vJVf/kqoHqckanyyFD+1pH6Oe6OnecOo4eN8WWyP7vM+QvNzP8SD+umisvBWYE+2x9uc5tIoGvj
 hFrmrp+wZQcgcE9FXTRxF72YYIFJLyOeVUSO2L1wHBpcyLq+G4uucUad8SKITd4OUlnl+K+I=
X-Gm-Gg: AYBFou0BXtkEwP3NCF7dK2kc68yN3z6aWz/Unt3NCG6WNsB8qHolg+v0Oj02mS1lV8M
 eWvAC9HLjXfBHsdYZSnoj991NKhsQrTtpVLByqefYwbhZbUYbjGh02kHYcddaOoMStlhAI8rnjz
 a8n0I01PPQ5Vyb6HzfiVHum9g0VMg7Q7/zRanrUL3FHwZR43yLCcIMKKyTJq+67qZmLYJACmfc1
 ypn2lNySNIlb/yY52lg4qAHkb7Fv99/iJBYcTL/L1oDINYr1a/HWHU7w7RxGQlhbD3rfGfuP80f
 9ak4UBizYyOKlRrMJAt5A7YeF7i0LqbsZoPP6lVPf0mHwoAdwCJEk6t5YHxfElWLWTdmSUQuNA5
 5LDaX2FmdVewSLcq2sW/3zngv7WBzr+lTQJswrxV1T72TkXw7AvHfEvRrhgKc
X-Received: by 2002:a05:690e:408d:b0:677:b5fd:6dfc with SMTP id
 956f58d0204a3-67a35b60232mr218380d50.66.1792706433198; 
 Thu, 22 Oct 2026 15:00:33 -0700 (PDT)
X-Received: by 2002:a05:690e:408d:b0:677:b5fd:6dfc with SMTP id
 956f58d0204a3-67a35b60232mr218362d50.66.1792706432551; 
 Thu, 22 Oct 2026 15:00:32 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a3402fc9esm367192d50.16.2026.10.22.15.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:00:32 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/5] clk: qcom: qcs8300: Extend GCC clock driver to
 full gate/RCG coverage
Date: Thu, 22 Oct 2026 18:00:29 -0400
Message-ID: <20261022220029.784352-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-b4-monaco-v4-2-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
 <20261021-b4-monaco-v4-2-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M4TbdiMwzmOVX1HeoB0koL_LcqVXPCZm
X-Proofpoint-ORIG-GUID: M4TbdiMwzmOVX1HeoB0koL_LcqVXPCZm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+avz0j5jod2R
 0RIOooyS/dD3lWoF7oZ7Iq3O5GiQ6S6SSwrzi02f2tEE42IfWQ8+hmx+SbCikvv9qDY0miaqrEw
 mIJgf7YHnhQQJH/12pPfDBb0LiAlkfg=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada8781 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=XqcMRLIbwo3LSF3b6I8A:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX11UJ1u9bXADZ
 g5wNWE2LycV/YQ1ItLA16Wfrj0EAMA37hRcOlp14LR/ublnJCgN8CK19Dhll9L5WT4dukT+lD27
 E2XbYV7OpKfNChVT+OkKqNu8Bjw916FU+GMZn55NPQ/88x0rcqAzVZa8zGvav9m8N703fVcZbCj
 TQRpICwEinIkp+oDbhOX2+Lts3dLw+cGexf5qIRUdqskzAZQa6YdCqWpbbcbdugX3ui+FlnqUCw
 pIt0BTXn7vqbgaht7Q6VMRumlfmhO6HU3Z0h0fPV6iCbNx/wrnE8ao5a2y5/8B9rDWa8Iz1KMvk
 xzK/+Q/N0bUPoJqRBgjPps6f33uuKznh+9PgPyda0/O8H7EobRCl3hnWfXVcj6FKSF3uaHXT3kn
 pbu3OEkUplGZEU0Iwk//zoRzvc8IpXnAe2ICPtJncI7aTfUvz8RJXCi9XawbR4hTi8cLQ9QHjOO
 kEGIHPFQrAm1HkWd7/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:13, Balaji Selvanathan wrote:
[...]
> -#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> -#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020

That's a bug fix (0xf0xx is the AHB2PHY broadcast space) that neither
the commit message nor the cover letter mentions. Split it out and say
what it fixes.
