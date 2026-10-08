Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA31CA600F
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1D4C81247;
	Thu,  8 Oct 2026 09:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sS3RbmlUb1of; Thu,  8 Oct 2026 09:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72E648124D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452981;
	b=cSN8oRb2w20mQhEn4CipeRWZDpLg48UyVJLcMzn/Ed374chhWDSaYDk1GxO6Ec17PRtF
	 G+rPzen2DgKlg+kaBY0FceItvvfwQNRbXKeOtz+UbpRwHwFWGUszhusYZB4cJv0ryQbRt
	 qHrM3VW8u2Hhc5U8VRNMNl+rlP0gXfhz7nLX4UuXuhu7c7TCvWGDVstX8yhOqXVuaTC9V
	 uLsa0q4qX8SVSxXWxAU4prHcbIyswRNmfXEnyflQ4WxDIpl6z0v6JitF6t/8BgT5hY0BV
	 QJZMJX/kMiZX7zj4kdi4fc+X6ot2ng0F+Kw2W5++o5GCfzIdNVjVU3jFfKxAhzNHAgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	b=YsbnwZYOGzBrauQKg6V2FEBxuiCAfr6Wzd0e19V25z5bS9k3L1rnyTdizPs3BurD5XxV
	 nuAaSKHYMaOUBAoRgyxBv0iq7ZpmcaeQOYiGS5lcQYTNVDJjlldmaFD+gk3zzwZIjwt5u
	 kqNYCLl6Co2J+TDihqTElkxTOYVCbkCN4MUewSc3thvmm3I/mJ/9yGRSFxiL8G2kyTSiR
	 2icXZzYlLLVTIFNP5qQyGOS/pYv+zG0iO2KXp1mpHLx9ZC+YoTqQo3DGgV/ssrCu28+YK
	 nFBKMbsgvKra3ssY+l1mcrUGAHrlgrVECB0e7I2EszODuX0olSv7q+jnVCSZ59DxsYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452981;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRwW855Iyel5CqQ99K3swQAbttV5rJsF4BRy0Z2+L9+Y/AaYu46dKlB52bvxXuthe
	 y307yvu+46POD4lZdW3wwg31ohItgY34X1bQa1f+SkNTw5luMyy6HVKuBSs8cJL8cX
	 hNX5LgznwIBH5vcwBN00TSQbv5Ni67QNox7uSAZ6d2B9ZrLjki1zqAGWP5krWGrCWN
	 umghKe2xkUtcMb5QwGt/C/uMo/gbtMT3qA42EZmWh25MrAbNVCI9CHXubAgvVwy7Wq
	 H9jhKISLdc41VjhE+74Qb5WAaAVQ8LwkfhqbWV31X6O++nSxHYjjOeGzrbk0IOtCK+
	 TmWpiZinkTiFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72E648124D;
	Thu,  8 Oct 2026 09:49:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89BC52AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CF6060861
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RewD1TYti1Ar for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D115060819
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452970;
 b=UMjsptW75c/wKtbx8pDBcUAKIjD80M+ppe6B8dudL73R6HNuaUNrc/qSktR5erghhOI8
 z3FToPI6YW5V5qJ3IlmjGKoWLGWmy20FY8Pc6tNmVW9T3s96GeIlhNM8cR8Nbcz/jmoh9
 4O9abc/Cn8TXKuELR1T70EpuOzaXS5Rj/egSBaKD4Zjftz2NBLxJ56CXvY75pTT/L8aG2
 HD6uflLMjTIgrU13OJGYHaesjEBkFdpusW2uCJVI/635ow6ApfcX8dbr9nWP2ql/CMpAM
 Ma6WoRZ3ekmgya1vw+Oyj9oIShTLJZedQ9tY49Yqn8MIGTEZzgeLRD/arI1yLev7AhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452970;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=rmRr9FGHvh7D/xUzf6f4qoo2MYte3J0vQ06XOsr7NeLYM6bB20MdsibqEuCzjCrL3LkZ
 J7a5DCHkIXtJg3GqwoQrVqGW2IjLx0vVelTV63uKr0eNVMnBGjNNegY8hJGHCOUQEo/Vc
 my54py7Q4HS0/7cez+bbyUPFgngJze/cEjXDPPGFgmWQ2h8J5X6BTXvD88i/o4pE3LqFs
 7bOeflg0A2LAidwe8tFNFLbxgCGyAt0nXiRfpGhFo4lsSeBm33QJ4wWfCNhIUhBTTTE1J
 sKENuDTeDDnSYGljNkuaNbxVpkc2npHTS7IeBIFd0+9CSQrNaSBiQrh9Cwa4HN7xWXA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=el+Y3HsP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M6ogq7BC; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=el+Y3HsP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M6ogq7BC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D115060819
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K5Nw1341820
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=doWJbh7Fqia
 lYmi81CmpvlL5mjRVCir1a9mrILO97bc=; b=el+Y3HsPD/f5Ix3wySZFB7P2sFG
 f8MOfvkW5m+7/3gq5FhMgqyKWWLFMtBYVTAu3IQoPrqq7alVLlzKMqYWgc45+cJx
 IkMrnXI3ctHDBJV7gCVs8LQI17XhF3c2/Q0UjaNywP9+GbQE28PM2RzM7HhBqfGy
 3DW52Rdg7fe8ZBO3OW/qttOZrxQBkHThcXIFZZcOXCN4gz55drhP2/1LWl5c36h0
 X1JupGaPU6ILj5r3ztjxrF4z6xfwigWu1ckQKPJ3UPqLFGuv668ci+4d5ZZ96JQI
 YFARv0djkV5aD0NAD43WtnDca/AGRV0R+0doafAgfRbmYpNPCwwSOEClAkQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2t9xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:30 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1665200f4c2so648487c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452970; x=1792057770;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=M6ogq7BCUB8G7YVPiDGItHkvmaG5OdeQwNDl4rfAG8rEH0VbPol0t2CC3t58Am08bP
 ex30qfi6BZLtHIv3Nr191eDFscfnn76a2Tlo2Ik/hQ7Om++eu7m9nZtFmbmcaBaBHp7L
 JL1cfklojlZpg+cwGz5FdTgrcIBWhnrnZUtn6NpkpxI7WK7kCwvoxeUr+G3+D5mQCZzb
 QR/XsDkn/wECPpIr2bzLvFtW07TjuvjpHsceu79/weIQ4ffwJyQ7pUixiD2yTZgGc51c
 uofwK2xKYN3vC0m5FoSMxzzKmnv3JHqiTn5ZitMyjuXPCvaHSbMAKFWtGCCneOVsv/LJ
 re9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452970; x=1792057770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=e3Gh5AJGO5BWrdZQkY5twDV0esYt/0t7bZQ1M7Q/vstBwDNU1gnGwq+4HwQFIBtAxA
 kdShNBMGQ88ygQ+383NrKWVIZft4uKEhYnO5UPeGcEcIz6fRAjSiuTm9YN2sZCM2/Oq5
 BY69l6Y2903omNK29lAl8Mat/ABC95wCUjYwEtr4L2DpgGHXw9KE9fi3gnam5XXLrfDq
 D/p5RwCN1b1gToBObHbdt7z23g5gyABElBStBBF1AQIitlFIw9JfkUoV7UwS/q+SfMr2
 16a0FtSTKMqy7vtt9N43Zeg/SN/vKnY570NgO15caTBoj7l8aaMDmugH23UAG3D3OOhr
 8tOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSpMuf1QNnabTtRLuAcy+qPV3qf0swpJgaSbyMYij1KiPvGH6W1AIAYxjAW8x4Vg0nBofzjWM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kKwbjvsGdaQNmDi2ORToNvJzhhQMCFuhkyt6QPZ4UxszJiMQih
 Hba7YDlVGW480f5elSy/HC4d0mLp+fBAxGkcfe8GUuhoVG6Z+X8EHHWX60N/zyztNrko+cFMGq6
 uP/1+80O+a+UJk6HrBBkePUBj0z4ypylD25nWj8pvyLELKTaZtZelvSb1sJG+v52u3acKhi0=
X-Gm-Gg: AYBFou2dIUT4pxEUz34ipK1ORdOEcLOq1XuwvPXfixu41JrznbSIavwKqPK4x+kUNvB
 CE8HT5wPD7oZKCL2EKpGaMuCOLxH9ie4d61fl4CczAflJBlnZE8hRdKPgWfyrhIELpYj76B5R7C
 uwNcdLiQhmp7OINfJxSJeTfO5NOXmA3ygzFxOkQcXisXixG7IX4kzG6GytcLoGbB8ITPcwNbHVh
 uubQXBs/jBPuHTcj2YF631BCV6DBaZBLHZlzPwcf/Wk2LIH0gMaPBwn3Ne/PyHL/0vDWSkTV/vV
 5JEe65bNVxK50RvAHhkRhOLZdWw4WPzVvNz4/a143f3eB5f0E5D4LRHgsMCqUzhAZ0+HBXtQqu7
 ar9OCcMvxNm/MKS933EwsdN6WTFJspJ5HldZFPmGV0DZCzlI=
X-Received: by 2002:a05:7022:e885:b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-16205513954mr6457346c88.23.1791452969478; 
 Thu, 08 Oct 2026 02:49:29 -0700 (PDT)
X-Received: by 2002:a05:7022:e885:b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-16205513954mr6457307c88.23.1791452968878; 
 Thu, 08 Oct 2026 02:49:28 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:28 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 07/13] clk: qcom: enable Shikra QUP wrapper clocks
Date: Thu,  8 Oct 2026 02:49:06 -0700
Message-Id: <20261008094912.419090-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX8dGh2NX5xgNA
 Xukfr2eYP0PqDf88GQL3Bqa9IwH6vErR+tnBo1x+SJKHuXMjKeFdewLS/jsVhtRVDdjA4fmWYIj
 V9N4ys3Kesq/o/6+X+72v9pKEMz20MI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfXxVBF9lQssUum
 DStK4mhg/cQ8KXTOqBy4UN9VGjBTcPFgKO1Ih/jErisB5BVq6w8ESdU/ZtL2ffy25dowFH5mn+o
 Cfj72t6GqzjoEVXBFNKLUEiyk6vuByqD7pk4vEwWhpGJedzBu8HNPrt4crErRYV/cbsh5ECbcCW
 tZ12IaZkSM2dbfyaQO92rPKPvno/U5lRzzfVwTDX16MHiKIgrFsuSL5aATF6rCG2ycv7ZIzOjy2
 OPc82tgsI4+jJv2PjXT3JDsIClnw+9A2BahG3uvh7kGGNWBk7OnbgOld76QrfaSguPbq6H6Tpku
 v8bZFkpXGSx+ArdvqWVRBRef9t1DRlUYrnfar0MsZd6fJp+6qX2RCc3827X5An/Jk2cuIVD18Vg
 5owcCI7i4P19AuLxTuwfNCAHbQXdNsMg2duaJqVUn8oD2A+ZvVPu6i1EhL6vSob19F6p5yurHph
 eoBm5pjrM4uschAec4w==
X-Proofpoint-ORIG-GUID: R2WkMa1aJ_2i0-SLo-bdBvmVQWHnNaBl
X-Proofpoint-GUID: R2WkMa1aJ_2i0-SLo-bdBvmVQWHnNaBl
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7672a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 94501b838fc..a74d529f4cf 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

