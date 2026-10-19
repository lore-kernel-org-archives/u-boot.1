Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B273CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DCE560762;
	Mon, 19 Oct 2026 10:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smhH6MvJxMf3; Mon, 19 Oct 2026 10:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 62D5460748
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407054;
	b=mLBuw+kMt+xAR90E8KJiM/GO0avdvY0IHC6av95UwAdYs6gA0wpkOVDzyqTvCBUArxYA
	 s4U3FJEqxb+n/y09ppH19UFrBOuvxopDcyT1TQi/rIl/V4iLkCXkZiLOf1FSHdftjWUfG
	 QvCqsZ50qLNkU5TZPdw1vAjku1OlQvHGk5v3wF3fjCMTEpIVwOLQD9tMcOIRtJmSXl4nM
	 LaXM64tgwZl7W0pcyjQBEq+Y3bUyPMFP1Xu0/T4xR1vaGrdS9OSw1FruH0+Ppkffb2vpd
	 KxH/sxDgq8d5ucHf3GfmaCY3wYeVbKBUKRxHDB+WOEjJh6YOmqI5usV7zrGXSdnMRYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=;
	b=Lj4uUnHWpDCVyXz9lTDZtBwXeRhbe5K/PIb+hwT6beAA+cXbcJ5ogV9AI7R/ZT3S5H1O
	 rgdHh7Um514OiupGhZbYxmH+M8FeOGucPvD406itWPf+TDcjXtbQV6ROSWfzvurdV3o72
	 WOb/SeBpuKCzx93xOqakBDpoufVamjLpoFywpTMHXU8nhBvtbUzlYSyZ0Q50hBADrWI8P
	 0bLK4Znh2yd8gCkPwdssazr+Nw5mjam4eSGV7UdvKObA8PvVjBK7YlTLBJIsNqY8sYBHS
	 KpA7OMTRozIPl3CX+MMtiYwoF9CZNPCAn4Kc+IRmVuYaxodCzK5CO7PDg/u8asSn8aQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kxv3RMWM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UB8qbxsY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407054;
	bh=7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=demM/cOzI99e0bgZ4MfhWCO1HWcTDxVPMYqpsYgBKEQt7xs1VjkToFmTORj0KV+bR
	 CEC5miO91RIu1nnVl7ZiffdxXmL7BAoFdHzgpOTVL7sUz8ef2Z5wRGs9qGc/yzvp16
	 +0hn7Y+6RUcwvpW0qlQgUrnyqbbU31doXJpp91QpGXSVhribA9LfxjWvKHPs7fODLw
	 NOX3UH4/lyg1FO/MdeNSB3rxu/5CJyQM62LaV8Jk8OQfLDDyF/4LzYld8DWyu52FbD
	 Di1vBhTyy6/VDW3Y04PTtmrUkEdUd5xrnkus33KH1OCfn+BGI5bpiELlEkkHQ1QvDL
	 YCl5jRkMxYy7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62D5460748;
	Mon, 19 Oct 2026 10:50:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90757263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7622760740
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Qk3LP2Rs_Fa for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C116760748
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407053;
 b=dpv1CWftFj0S2zmLtLv2fvOKJMMBRR4itO/Cfzcp6r+/RLqkNDnz+Vn2VbENdNINXz29
 WQYwrzUiBGbcaNI6eeYa0+zkf4jMlzry0rHWYXXASNMUIohH0qaJ95144ah9G5MCI9l/7
 WN4S2806/LC3hKECWLdo2xasismNmMY5v3WdEvxQlW5tHmzsCKtMP6zvf6qXbqh0YJP/v
 XYpz3M44dbtMFCKVGzMtCzdWQ7Kxx9DekVwcKnsntd8wxpkJCdvrFibBxgH+PQtgbFTem
 SccveOE72sJTTw8HlBs8Ycoa6k21333EtWNRsTXusP7WTcbtQiseVAicuYreB6+kZWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407053;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=;
 b=qLoruv7WGMVDdJS4ponIZb+gZdm0snSUFz4UjqnU4COcVKJdxIaJLMqBaHjbfNMRlV4j
 zWmq2vadubG67WY+5SAWeuOmSDCp3IgOhkveBGnB/zQhPan41a/dTs2xW3od9hwmG3LB/
 6mRwvRDHtk9UGqMq+2agwnSwTT5D9k+n8nBDxgX7+Svi/178YUnEhy1U2V7pFsYHx4IvK
 +1C/4MkxwHbPYIiGEXdvL0FeZ2cmgKK4E7WhQEOOKJrbp/URCuwNpFNzikzCUXiimPXPF
 2dAVJSjmeakCqDSH6Q/qMZyngBJuVYU8jLldDzx9xv+DaSr8kVxe8s2KXAFO83EAQgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Kxv3RMWM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UB8qbxsY; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kxv3RMWM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UB8qbxsY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C116760748
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8YofB2688910
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=; b=Kxv3RMWMAptKLLYO
 /p6wH5/MB5CVYgW/mPakMuJf9YQAdWKdNioUR1hE1bqCoxm+sfSW9ZFmaOP/0QB2
 N3l0eQW7mn854e6NOtuQ/qfF9G+k8peeLr2ScQ3i3iC97dlZ1gKpcgqI/8L3/EI2
 /4eWQEWy19qFyG4T1d94JLZdtVV8b0BXteh2WsRMRFpcDJ+YOS2aNmY4h5BxJlN/
 kwIq/adkxOzXl+/jKK0tv9JK2rptse2JRgr4RtLFT3pyklGkxJyrP4L4t3V/ytzJ
 mBAIzW7SPaj9tFp+AokKQVOXhH6+xd+cwwbcr3a0XMlL/SLHvpK6b9itl3Dz9/ws
 Y2oLhw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn0gpq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso5030252eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407050; x=1793011850;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=;
 b=UB8qbxsYzGBcPQxnjPGvRENOXSdkWSYUdq9d1g5KVPpxqLLUrMRAjLtFXPK8rURLQC
 QGkKUyhshCQSIn1zHsBaN3YWK6a3xQL13wBexNpRgS5rIX0QEhmOOgbXfcuZLBhmoEev
 l7EqxellNiWQ+GIpXMDcW1BcMko+D6cHh/O0asTnudi6VwrOzw2FWBcuj7K5CeDZRcBZ
 dFibrmT1vuv+ubnZVDeTKSqEOPx0s+b+7f0cr5ZGtWX/VQFaawfHxgZOuWd9JBKi4uiT
 2AbDuGwQ/ptV7vkvQDRjJpUXE8VeoZSwELyjBDqzJruQg9nLWrnlbQEEfp45w+XGIG1u
 M93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407050; x=1793011850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Xq43MgxuUB3FQaiROi3Nyaa/1+fmo9dN3zbk7enzi4=;
 b=ba36fqcWGDIW7J4hALup6pdCi4dVWo8aoFIXn7t3Y0++SfhEryz2Jze56qJkBKLlOb
 znB96YFyRHa/4r88kp2n5gxCCHGvFnPlOrq/oNLn7+Kf4xR9WiPFt0VE+PQ7LMsyy42p
 tDK+SV418+/ShFXibkha65x4SiAl5OhhUUY9BeywX9oyE+sUD9imlincvkhIiqiLTgmj
 SgPMUGl1pO+pXMJWmCnBus43ZYX72QLLVbx8r9iaGb24WRaeLETlvFjTSDY+ripwLUEp
 BltRmxYwZKvVbg59ZgfrPDzYWbgyDN9Oqaq5xPPvSewe5DiSnnyqK0vtPfqDTIJ2zfAR
 3xOw==
X-Gm-Message-State: AFq9FYLdfblvescI11AkeM8Vsa8GCZUImzxMtTwCaW/8bH4nPg3Fc9SS
 wgwiEn2g/NYEEDzWKy7bPvgvnw8lQljGpWez253J1rmTRq8wRHNr5xAh2k9fax8zPwwrZCual46
 095FzaF4N9213o7EZagFweF0oZSvMKgUpikNEt3aVRM5eq9299eN8CQy20VaYEtz7VrJ7lBI=
X-Gm-Gg: AYBFou3xbJcMor3kpktOHpBRoAPKsVCDD8+fpZ5Lq1Pd/JZee0vFKZh3d5hHHARIXfQ
 KvlbFQ4SbbfmJpJ4DWU6DGGgZvR7m8Xwb+FkI8FQctskHcKzfS/84VD8JSshi6H7RaIAbB8IyH1
 pY5HnOQIU8cngdPd7Y/2Dz5FfeC99iXoX7PeaoGk205Jo+cNvpa7y71Z1rA7eOJKxe2apgC7bt0
 qjOpD/1YcUABgdWhqeIVF5zxxjVfZtL8FYdGaYbXqnjHPr7l0oLDmF6nLVCHuETmrPHi46fE5bJ
 sIAb+/5BNuePLEMlHPwX1neLM1yt1y7DjMeJOPr2dJW9fR54JHgB5Wwx/xiv0v5b1+Cd+dVbxak
 /bZSRQjjEHJoZX+4F7AF5t8Z/pPa7ZvT2t4m+Eq9DmyAmMUbbszqv7eXDRO8ubmy8XVBbX1iL+x
 ftXTvxphJ9usKoWQoeJvOkCnRPHCEt
X-Received: by 2002:a05:701b:424d:10b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-1850c9cf427mr12217644c88.3.1792407049890; 
 Mon, 19 Oct 2026 03:50:49 -0700 (PDT)
X-Received: by 2002:a05:701b:424d:10b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-1850c9cf427mr12217610c88.3.1792407049354; 
 Mon, 19 Oct 2026 03:50:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:18:59 +0530
Subject: [PATCH v4 4/9] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-4-61432d0b258c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=2202;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=+aG8v9LNw40YhULBjZb+yI2gmdA9FoGtMNU3PZI5M1g=;
 b=Py4PKgSm0R97ZxusnE0O4ApizGXjFu9JK3KVPJz/rE1pyog+UN5sGjeCXNfPfV1AMgOFqY2Rx
 TLdpDKiN25KD3v04CojIAFHPHew7RzbHvd5FtpzpaL/G2bAdVfNBjwS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXyHM9IJEHPkeA
 thg7Fr/tIxicolYG8TXoByW+M1knw6cXmGWxiYD9lGUZGn91tTdoSZRZT+aYjRBxz84l/OH/T95
 sdfvmmK8oqc656Pcn4VRblpZp7G53Fs=
X-Proofpoint-GUID: Mfp9xlMiO_mw1jiNvd_lZvSp8Elq5H7w
X-Proofpoint-ORIG-GUID: Mfp9xlMiO_mw1jiNvd_lZvSp8Elq5H7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX0yT8kmZC6evg
 c3mV9aodHu0vgbER2EKH66Fc4lXUhTAlqUE/uIiyH/S2wbbCcxSZ64zTm3gRYgja2MVgK+kgp0V
 +CwwIzlu327yvlX7CdBP5Gdu3Mk5v0SKUX614wVaIzJLG/ueNA8yvBOzLCmtR8P3IIYxMxAyQ6u
 QBnFAghu/EZEcythsDnR8brT6KI48zkkfGM2kGTVh22w7nz7b4KCDmcT1b1CWSCYPAfcVn5HhE5
 Z1FOSbKnY+5yfDIO8gNjHo9hAJZU5hFUiwmLnzwnU4YaSo2Xh52nQgzOSGvyBeiJMIExD8I5Uhi
 H0u7WDNp/1jAj1DbsCIFvMcPvmWLYkUiBeVTKYNBUo6GhumnnVrk3uNUgQa0kNs+KOPfHQirYcI
 Uyc3I+noPDIuHyHs3yfNybfazpCKuS5T6qQ601Ktxt1unH702KwhvHwNbC61H5KHLAzzi5uI4i1
 aCJ/54RWj3ur/HWngnw==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad5f60a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=082DYYkcEjj4LLQWbG4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190043
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

Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
host controller driver to be built for SPL on Snapdragon platforms.

Switch the ufs-qcom.o Makefile rule to use the $(PHASE_) prefix
macro so that the correct config symbol (UFS_QCOM/SPL_UFS_QCOM) is
selected automatically depending on whether SPL or U-Boot proper is
being compiled.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Keep only the ufs-qcom.o $(PHASE_) switch here; the ufs-uclass.o
  switch moved to the first commit in the series
- Drop the stray trailing blank line in drivers/ufs/Makefile

Changes in v3:
- No changes in v3
---
 drivers/ufs/Kconfig  | 8 ++++++++
 drivers/ufs/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 8174a7acc5e..1d21dde250b 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -55,6 +55,14 @@ config UFS_QCOM
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.
 
+config SPL_UFS_QCOM
+	bool "Qualcomm Host Controller driver for UFS in SPL"
+	depends on SPL_UFS && ARCH_SNAPDRAGON
+	help
+	  This selects the platform driver for the UFS host controller
+	  present on Qualcomm Snapdragon SoCs for use in SPL. Enable this
+	  to use UFS as a boot device in SPL on Qualcomm platforms.
+
 config UFS_RENESAS
 	bool "Renesas R-Car S4 UFS Controller support"
 	depends on UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 7c1db11be7b..3b927fc49a3 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
-obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
+obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o

-- 
2.34.1

