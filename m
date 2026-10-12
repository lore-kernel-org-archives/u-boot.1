Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113FCCA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6329606BF;
	Mon, 12 Oct 2026 05:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXPyo4l0eJxd; Mon, 12 Oct 2026 05:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACB84606F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781260;
	b=X63K9gUO6bxfhjyr017T7KyZUoBtPF6cEqqfkLCrX3aAr4e40gU4DMzLmp29g5CJ2rLK
	 lR8irEHvCLkae5/oGtaC75Wf4ERuKApj2F1l2R+HK6BwD5H+amjeAjR9x2ZX2Z6J0Jg+/
	 rmuLT/N+37Dsj2JeJTv2H36A7RoiM5D4bqWNnhQZFia3WUPxtj8FOMn+0EnhTfMjdE/YO
	 SV3PzHbGhJZRHXc/DT96uvIyXH1UwAl/mb99S02v+V2hh+I33Aw/pfOLFEeAwU8ouhHuZ
	 qHuerPngd8v9gwO6EWC8EuN9gxl5zRO5XjRkH+acgue08MFL/0lhGAyxDzbRZnlDWWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	b=ftkLJbrK4u1BrUJ9Hqjo1n21GKd+ybvXvnQ5PxynORczM2OxBPWars4SsWZM6mxCn93q
	 1aC6kGfM+qAbKnn4DIZzU6k1nJ4cj8EV4yom4UO72lP6PgbqFbCwHlFFjnLE8CcoPfS/Q
	 WkhlUucZaQK26H41/MZ0DTyrfRv8e0NOMcl8TEdLvRqET587TYjd2Nxa7stBzhpRXBBMe
	 o82XIEz7r6xfCz5Q5IJQKh2Zb4IUQqOxze2ADxZ8RF58ORWM52sFQaPsA17Wt52/fOdrQ
	 Z41IjLgTcQtxQaF9RMPsXrd42mOQw9i9BVZiYDBQVQ4jAp8H23bXk1ZiLucuhLB927w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lvd+/d3F";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="M2c/nfNS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781260;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cfp0MzBKuIn5lwVj0fG3Okjh4XqZIW7v0jfzFGeSEiZmMkUEcCYaqBe74feV6DFkG
	 77VGaJjzEcPPdPhzSOvANX2C5R7Q+4DA5X7Lx1bTX1efeszg5DKf1xKD8FX9PM8sJr
	 wBy9r0mUCj7smw/vNsx3ks9IMgJ/pX9lIt4Q6oUxuMpix3yTE7NuYqV4RMQegLuHIN
	 wJKTqpmx3BhnqpnfOghFhvDJ/yy+9wIgAITbz6DVqNnqbhadf2YpLFYDrVLxsuPlzl
	 0CVXqH8istvpaqtpEKpz2vedqc27rpL1a/GaDQXKHDhvdTnS8K+kiy/2j496aSPveg
	 sY3WxD0meQ/zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACB84606F4;
	Mon, 12 Oct 2026 05:00:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 68CF69DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A2A3606A2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flHOJ9DvS3s7 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CF436062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781255;
 b=d4Hp7zaHdT9a2dEo6bUFSoY/LkbTAeTTfLV1a57hR9yht/8J9AVRkdVbOtmly6wQikkM
 MurhVFObn8ClXFGxzkFhIVVZqqO0YX8mUWM7TbXMviN64fb7A3Y7YzeMY9hIYC6LwVeD2
 oSjV+2yZg7owOzp0bTi6NDNqEd9UylWn4Qt8iNn7LkVtEcQF381QYC95I56SxpqPf9jwU
 R5nvf495YhoJ46gxPjV1ZJa8wEicpdglBzpoVVQS+SbQTxlbLOSHdfdaFZnwgcPFENyax
 Xvh9EEVbydTWC60rBLepipaVAWx9HanydFdy750erO1VBvd/GC5TzV7eZA5s8aU/6nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781255;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=RKXBcY/G0pf0cHH45XgQT7MnA6YvgqM6pfME7tNftMVS4NNQ9O82RBrW1Sj4unZMAIM2
 2zUtvNs30mpKkT3F9XfejtDRB4TmUH42fg7XAltosCtiTAp53p2EANR61qkFEqB+A9BqU
 zQdQvGSP7DUWyvNA9db/oOTWCFOQK13ow/VmQhXfN6GcrSQJMig0lyLgbXj/6YLMUw659
 +mTJGSgn+Fd8x6/cgTbnMi2Yb1DHFfzYi0E2sYVJI61U9TH9vV0IEFgVYsF+Rb3R9tK0t
 44I+FtsHEe+5H2SUmEbSYdOJIzES9lTI0oCxsq2QqsfUy50Dj38vAV8BlUjDxMdG5sg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Lvd+/d3F"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="M2c/nfNS"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Lvd+/d3F; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M2c/nfNS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CF436062A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lVAx3646469
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ErfdW+jlRb
 IWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=; b=Lvd+/d3FvodhF9BQSL9qYHN6x/1
 d4/1v+XnaMM5alzlZY3CIn6aDp38HA3pRZkQZLvIjW79grDdHwLuiOdL3frCXTyh
 5MpraSdWhErjNnQsk19brbrD6BMWKjwIpqU3Alno82Yv7x5QHETWE/wEtbXCn+I1
 obwXe3dQxN2S4Q5H3Tie8acXCq5I/L0yCwdoEphkzdV8hhXgb6UOual5vn4QVPSB
 Z2QyYUPrEr443qynL5lKpxUEmjeOkYAvLVQMRZG1fEY0p12k4I6smG543SqeQnOz
 Hn3ZP+cwRmzZ4MQDGZTqJEAD50jLYm2iBvlFhcg5y2ruo2dyDndUowbam7g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjmn2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1340039eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781254; x=1792386054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=M2c/nfNSZPl/ZXCO9GHU1JTQ9XexwAnso6WtZDhF0ktWloHv11G1rm/RdbeHpk1LwS
 r+BQN7XimZtompwqB0mrVLBIEgnRbhXGlZ96j8cEyVJLXmtu0Z0hV9NcU2ZB5vPWiyCp
 /EtNAZG40fV/UEWrHuwFJ3qAfZa0fmsgqJO3vCEKV30mUL7GAWqz/UTjSVscQpJBMDL9
 7zxf1AqsXUCrmTV4+T0UOVbem7XuZGeoxjWPVuFWGrZoLWzcr72R2RU9XZzvYUAa8Kcj
 rSMliw8y4A66fX2IOuUQBCNYGAksMGTM7O2XZlFYOzBQUUQtd++CR2MkTOQk2eDz/xVm
 EsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781254; x=1792386054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=q2q4Iw+skvVCoKE9ejJGDmyDGvNejZC9nzWgp6X87HXsSxgFkBYVgb6xdRkLxgdrtc
 76J02+6HgSVASyg2Rav6F3Y0quASyItKV4UzBTQgJsjVIoYUgSmzP/ijwCXStF8SJ2hu
 eBFZ83CILsWaoOiFxgkWRpATet/1OoeYdnsvDHmStTBUQKMX/tz5K6hBeuFDJ+5Xmtwh
 YRL9AFN4HWkMpZI6tP23PtjQqnO8/kD5q4wMUj2TMlm+AAMOMNAioa+qz7HMQiYIBg5x
 DTXGrT5Lf/5Z0x+7S98fTafw6uDar8ueE+02eNi5lPN1pObKPPcsWGXSTTJaAPzB5rYa
 LZjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByU5MBm3xtKZ+X/IlY9JFQGVkDFdAnAan6LhGGP+KggUIBXXSiEAIY/202ZuaXFMZ1hzHFQVhk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJwcLLXge1HfZ+qGO6aAJmR7JQveA/4Fr2jYolmI1wW1PSB0zUw
 nrVdTvACiW4e4p66SnclLtv/SoU9LWGGZsVw0e+K0HdBnJ0ukKBOSRMdNa8OC5FG7N3E9gu6FVk
 qYzMSVGwBg3cT/W287dwz7ofdT8qO23Y2E9w7oXl5gMlP9jbwghjyZuknsJ7n3Dk01enM28RFfW
 C/dI0=
X-Gm-Gg: AYBFou0yx34L1OC7nBvimLcxss2Zhs8KcAmdDgy2y4trKkscP7YSt1z49gR8o6ga6tm
 pm+Fmhxt+WB+fKSoGsiKHPYJHBRN5GDLT62mCsYoaES6cgD/OSxLCb4cn8yvRhBjBXtOw10/3kR
 +X/zfbER+VglF0waTX9Utai47LYV0FYmsYOHcuogHUTEvS1dbVLqbS0jX79p04bmlT9cdXf3/VL
 XI1LojLL93NRveQSG0kh4hPSEAl8aUWIU8vLGBhwgYdhyt1/JIO73GPZaT+uKusrRUT66ErfsJS
 H1c5oEXFXyt3WTHWbrZWR/u4yM//HQg7tYU50PFssxcA1g7yjGgHSuFWBgFFaDvWLSOnVA3Buro
 5yBesGEq4RgWPYFDFTcR4BLzmFIjTabWnbxTG9+CfSvHlsqA=
X-Received: by 2002:a05:701b:2914:b0:174:7d98:fe9b with SMTP id
 a92af1059eb24-1747d99019bmr2442094c88.22.1791781253542; 
 Sun, 11 Oct 2026 22:00:53 -0700 (PDT)
X-Received: by 2002:a05:701b:2914:b0:174:7d98:fe9b with SMTP id
 a92af1059eb24-1747d99019bmr2442068c88.22.1791781252967; 
 Sun, 11 Oct 2026 22:00:52 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm24317909c88.4.2026.10.11.22.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:00:52 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v5 1/3] arm: dts: shikra: enable SPL SD card boot
Date: Sun, 11 Oct 2026 22:00:37 -0700
Message-Id: <20261012050039.1527083-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
References: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX3W8/4SU/oJTk
 gjzq5CdHwKopknpoYmZoO1H+Sa1liLML+QUrdtA1FubLnPk1Bej+q8a5ean9TbKDr7baAG1lkIy
 UjAd6JOgsFBf/xy/6PlBlBnMc1YBE1lwO2oUh/q7QbSD0nzsbuhePncjm9781zgKtkOuTdpJL2z
 Vqmx7SfldPtZP/eCcyzvS9w4Kio1WjYrwcqzYI8/+Dm89Yp0MwtAnvz4VXZQ0nUWTedUN8alBsG
 7mDFN/JjBiu/bbTfOY7lk4rN+o3Ztp67Qy53I1/2KW0veiamcYDF7eNZXwaxZhRp+ZKgBtmshwx
 Hqd9sqQz2ya8zphAjFmJ9HO4vuUxdcNTYutP3RV+6TEofTM2SowusOy8eGrj+EgpX2eRyCh/04p
 AOzeEGgmjF/qOCUfS0MDBneGSCr+c8xLKLyzxKp4V0vAIdbi6TnRYJBlu08ml9SAKjI9Dh9hOyD
 w7XRnU9+yET0fifiFYw==
X-Proofpoint-ORIG-GUID: lgo9LmuS7i1fussVQGphTmMY1f0Jbacn
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc6986 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=kLX-VyqmV7a6tMBdCCUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: lgo9LmuS7i1fussVQGphTmMY1f0Jbacn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX16L0OkBHNIcg
 UY+bMxY+WDUWlK/OeBbUwK3Kb+B1LaZKHLxsoaxQKIx1kPlZfNFb8GIrQk61QU7TQMPnvj7VnLP
 9pxJN3Fpa1uGNR+R2d+CzUcrvXqqAeI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120019
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

Enable SDHC2 on the CQS EVK and retain its pinctrl
and regulator dependencies in the SPL device tree.

Add the MMC sequence-1 alias and describe the removable
SD slot with its supplies, reset, and 100 MHz limit.

Do not add cd-gpios. SPL selects the boot source from PBL
state and handles the selected SD device in board code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e8831da6aa7..8e2ae723938 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -48,6 +48,25 @@
 	bootph-all;
 };
 
+&sdc2_default {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_sleep {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_card_det_n { bootph-all; };
+&sdhc_2 { bootph-all; };
+&pm4125_l18 { bootph-all; };
+&pm4125_l22 { bootph-all; };
+
 &qupv3_0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/shikra-cqs-evk.dts b/arch/arm/dts/shikra-cqs-evk.dts
index b3f19a64d7a..23f416e6fe1 100644
--- a/arch/arm/dts/shikra-cqs-evk.dts
+++ b/arch/arm/dts/shikra-cqs-evk.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
 		serial0 = &uart0;
 	};
 
@@ -38,3 +39,16 @@
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	resets = <&gcc GCC_SDCC2_BCR>;
+	vmmc-supply = <&pm4125_l22>;
+	vqmmc-supply = <&pm4125_l18>;
+	max-frequency = <100000000>;
+	no-sdio;
+	no-mmc;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
-- 
2.34.1

