Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38668606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SYtP5uJ7;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZcPttuqt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ARqSt3gu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB21E60AD0;
	Thu, 19 Nov 2026 06:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0B_Q2-3HGY7; Thu, 19 Nov 2026 06:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1F8B60A52
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068581;
	b=T7FRW+11t7VLihZjmP8DO8EPcGum1VNlfjVNknzLrukqxTFJuG3oI5WJVOdKaMlJl45d
	 zb2SpH4DnV5Quu3r9XJJ4sCPWH9pPY7EANfYsiTEtHPd9AgkrxzqVbn6ftlrHkCzD5ScV
	 KNja2bwHQn2maGilXSwoJWlQS8xCEiyXDno/p1qmNT20anW7hyYEY6MreiEhezpEcxsmY
	 v8z2bWVLP1fF6bPVPvxS03fruV5XYAxeXvdBl6ZQ3YOxHvYk+fFjegpMmDDuswwosq0OY
	 ndTLsEgtYs2hOHojhnDvEty7RuR25sHfj0744jmjugtLFP6whPCp3RwIcpz/HXCnz/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pLAQdckKdx8R5g6FRlK8EEMsG6CiXA/1F12Ppy6kdT0=;
	b=sW7TXT/DxE+bMURcHtachXFgPkkCG+XaUt1ZsXprGd5rybJlzdkSi869kM0WTx/RH15u
	 zx7Ef7cNlsAq/Cwid7/qZ8zyaQizpTzZr42N2Q+zyxSB37LWM5szX0Mz0jJRJ8SxUj4jl
	 UG3j6hPgAH4TeDM5kZNnu+xkxcoMVqLbClLd3+TOsw2XiYieU2dfQFwWS3dxEIuQ9swrB
	 vFx3vw4lgu1sGreJgWGZogcV0a9FJfaoqX3fna9ByH1iXeK8mgTt81gfb7UGyJhsK1gCu
	 mxo9DJVaZu+2D+dULvXYExPmzf4pxkQfN9tbRAeVfOyCSzJPaeK7l+2Zhwxcn6NROLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068581;
	bh=pLAQdckKdx8R5g6FRlK8EEMsG6CiXA/1F12Ppy6kdT0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SYtP5uJ7tjTVw4HBUmN66bMIq/UjbuNDXeXaKbP26jsQUozSRWKJAfxkbCFaJKEa1
	 XSIielKEZ8aUg2XCyE3jrYX4ZB4WyJLn9HAhW3ggxtY8a/M56gbaLNnXJTeTWFKSuV
	 Qmnek9T2C7QuzbGXWK8SnkY4rGI290YpArJof9c+y5R12bxuAS3l6Mh3PcPcEAmLt5
	 G3VWyrRbP+WBdR73BeRacse2cvh8iZDj0/RthVg3FDK4COVPVO9NZYjvShDJYnk3Qf
	 LHbJpkfQup4+/Tp8Xnx8GGxNpIzwQc3G7FL52tNzdahlf8Z+WaG2pDSCo1mbtT1B4/
	 yEmnoBL7j/Kig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1F8B60A52;
	Thu, 19 Nov 2026 06:09:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A031C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABB7C40185
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4ShAqN-sm8F for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:09:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7E94D4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZcPttuqt; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ARqSt3gu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E94D4009E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1B1ll1444715
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pLAQdckKdx8R5g6FRlK8EE
 MsG6CiXA/1F12Ppy6kdT0=; b=ZcPttuqtY0j2He7HSIqy/0uv4LSfjDlTIm2aQ7
 +vqpAS8JZFY+pjDuqpjNSpiJ7eq+ABaG4Z71th9vAIGG/ny7NsTUlOpdh0N6WL4c
 ALfuwoNszmYUtFU51/9pmoksU5mQOXHCA0C0NeGP4kJ8UeXsgnIyCuCc+lGLz6WU
 tmvnlgkwKjK8HtNBtPkVv7LLimE3edA56fkYduYtEB2ZPV/TJk/jU8sWDGHExzmh
 MU2WTbtbVFiTqpdUViPkFuzCvWyfioupmfPfyGHtWpiG1KeYXsvVv41+4TvjoNSp
 Y0kRJ48EqB+C7/5rpT2VF5rUCOyOb3CmFufR0jlSn7L5U1aw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qudmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38131260a5dso4908555eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068576; x=1795673376;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pLAQdckKdx8R5g6FRlK8EEMsG6CiXA/1F12Ppy6kdT0=;
 b=ARqSt3guhGpuxyR7x6L+8MmT2pMdfTengps73bEtctLwk9D2+9C+S85/cKFnbq1/+A
 O99mKWigVox0QQa6wlPG3BvkUrVHQWqJEOPbx3cngQvoEpJcnbdYkBGbOk++fewBlyWP
 a1cTHFWuhpzTGk3zbR1BrnDpnPk7i4eyM2d0SpjoK3FAkYjSHqBzAsUgz15Y4QNZZwFY
 zNBvWvHr5mZ3YIBa4FUxwhSv1TZXHpnIMo7zeyVGx2qfK8ZRi2o+/6sRaYQVdloQI5Om
 j3VaIifvubQjvPBc/De7gU33glsprnXORM9nQZZjjtNzrP1H03uHwcKIRq+5WLGmBcMj
 1RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068576; x=1795673376;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pLAQdckKdx8R5g6FRlK8EEMsG6CiXA/1F12Ppy6kdT0=;
 b=tYxXkZeCJ1qoQJCifkuDeVRRyoPPO9T+KCHEZA4Y7bI9eDXIvzXHByy4DTrTqcd9zH
 nHLquJeLOuZQu5OTbpR6MespnrSYMcT9kQFkpN5EoW+22ikZSvq0AhP7aBpK6z8Dwg3c
 gWNtCbTxhuYS2Mf0JTyVBYSIXb9AmClhsYF4tA9H4akV+SEoIsem3nUxTIBAmdxU5IVA
 97YmrO64NMqUnBmb5VM+D5HqCpuRdbFnFEfauy0Qb5qcxRRsPpzExCTf4zKY/Z6pWAVg
 Zc4TnYyzaaDReIbPk6vxfCNdDCjeRSKhtS950lYCUIWcIjwyjvZZbUfMG7nP81VC88PT
 pZ1A==
X-Gm-Message-State: APuU4Z+9wOIuYgGxULMUD53c/+GZX2Dv19Y2/yoLOkDVEBTvFYtNBJgR
 lSCyTdeYoBOKVZ6UYIoQvDj08fHSvzwdcqpGleagnm8PmTu3JPASsHfHEdhBji8rbpHenFPtx6q
 JYEtYuFjDidRh0Plrwe0Br2cOsSsng5Asr8Nr+rxHb0h7Gwcv6gG73dYNHxs0gia0FCQuHeI=
X-Gm-Gg: AZFdTZetvx9G2wiAYAf2tBAo41gzY/IFK8ulIQyQ5WqjrMtmxGJ0I8krWBdHFmjjM2S
 hrR//YdjbrwjOSPwnrDEPGJzv9YUYvFnW8bhPwHY41BCIfV4Iu3oL5RXfI9csCCgLRZv/Ttd4xK
 7wqhFApE+8FlAGdnbmgfub2bg3vUcHkFTRVREHxjraxzEiFXtS/ISQ5i5vtHxT8fwVoT6d2nywD
 burn44NEZZrAcs98PoywlpkMBUDx6QeaEXmmuV2wiCB61HIaXrKd2Xmhe3onQnNL0eQqwfrst+m
 otoSOuYPDI9YgyyD88EoWN2cuxdm4gEpQhv8Xd7sRu4uaoYfei25tm0yoZmvczDc4j25P7OwScb
 B+4LARUJb/04ivM9msSlGWU1tQseYP2HRnk8haWTs/d+6Hy7t4jvXNH6LizwzSnL80nSGihn9Tb
 QGQCI1a6rHSO0QkfmX45E7CjZCZexPr2Un32Ggy/SCdNG3zjQ1tzMdfMinj1XVRb5YsRwBVMHAu
 TCs6w==
X-Received: by 2002:a05:7300:50ca:b0:381:7f3b:3c13 with SMTP id
 5a478bee46e88-382803787demr4754818eec.23.1795068576488; 
 Wed, 18 Nov 2026 22:09:36 -0800 (PST)
X-Received: by 2002:a05:7300:50ca:b0:381:7f3b:3c13 with SMTP id
 5a478bee46e88-382803787demr4754770eec.23.1795068575836; 
 Wed, 18 Nov 2026 22:09:35 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:09:35 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/5] usb: tcpm: Add Qualcomm PMIC Type-C port support
Date: Thu, 19 Nov 2026 11:39:15 +0530
Message-Id: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyS/moC/x3MQQ5AMBBA0avIrE3Slki5iljImDILVCtCpHfXW
 L7F/y9EDsIRuuKFwJdE2bcMXRZAy7jNjDJlg1Gm0VpbPGhf0a9CeD6eCa2aWmcqcqOtIVc+sJP
 7P/ZDSh9NmosXYQAAAA==
X-Change-ID: 20261118-qcom-pmic-typec-80d9f23cfa84
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Yixun Lan <dlan@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Dave Klotz <DaveWK225@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=1837;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RDbb7zdOqg5oyeJ018IM6zSdHBjS5A1SAK9xll2CFd0=;
 b=GRL3xWUD62UYGUVjk9c6uBK5NEtWxfICFLkuWx7KwIBIG6E0bZcMCRKqRL2h8qHHL+NRyZqqe
 99YxegA8juuCr4v/JhvQ6Hx+6kolnm32Ac1kxAH/ItG8M5jZyvrUUDc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: kZnzhmS2Qv0uUxypMrixkj0Fcljp6xsr
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afe92a1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1cIbViytn3wN7aDso1EA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX9tQ74kc1bGnO
 xFF2Y8l8iACGgRsuxLDtg2i54IrY4T6Tt1RElSSBibk6fEtFQwXamc/TvwgP/oG7leExvskZPJF
 8+Kf+HXYJRLUn1XfZ+H0dKO1J1MFyWM=
X-Proofpoint-GUID: kZnzhmS2Qv0uUxypMrixkj0Fcljp6xsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX4Ph9/1lcbDu1
 y3pb7JlQR6tcBJJiHBkIcudENZtBlx1W+uQ1mi2YP7YRXX69EQ164cXVhHRucYwT09dFxBemnEG
 2JiO7i3py9D6pg/sDDtxKPOhw3bJeW0pchI7mPMSPE5feC3FtNfCyMK4GD14bsMmMNuBLM0ssm9
 lpSfuBTe8uKploFRPbkqncu5jy3uTe7bXW2/wfp5WY9SUn/qazemn603StE6hsiJtQqa0vH1m1o
 S5ygEvRCdNqz64XGjdhcasr1nHfQfih1iXMuAEcnNumNi5HoLE8k6Rx96of/XpQzpX7hjSvC4OB
 eMkNL3ssWC9rukdcfQhye0ZHUF8XQJO9XHm0mGapA1CzqN7QEQgTONVUCjbBYrJuwhP++l35duf
 oOo7jt/sPAOIghJ7BSs0ItGHgrIy+lwWTTTNRA8cSwgQ371jPGcMCnEDaRIVWzFkHgMXS7VBrKZ
 1iD8bEcG6qAsKGPkt1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Type-C port on RB2 (PMI632) and Shikra (PM4125) is handled by a
block in the PMIC. In host mode, U-Boot has to turn VBUS on for an
attached device, otherwise nothing is found on the bus.

This series adds non-PD support to the TCPM (as Linux does for
"pd-disable" ports), a driver for the PMIC Type-C block, and runs the
port from the dwc3-generic host probe when the controller is linked to
a usb-c-connector through the OF graph.

Only controllers bound in host mode with a connector in the DT are
affected. 

Tested on Shikra CQS EVK with dr_mode set to "host".

Shikra also needs the PM4125 VBUS regulator patch [1].

[1] https://lore.kernel.org/r/20261116-pm4125-vbus-regulator-v1-1-a582ae58962a@oss.qualcomm.com

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Balaji Selvanathan (5):
      usb: tcpm: Support non-PD mode
      usb: tcpm: Add Qualcomm PMIC Type-C port driver
      usb: tcpm: Add helpers to start a port from a USB controller
      usb: dwc3-generic: Start the Type-C port in host mode
      configs: qcom_defconfig: Enable the PMIC Type-C port driver

 configs/qcom_defconfig             |   3 +
 drivers/usb/dwc3/dwc3-generic.c    |  22 ++
 drivers/usb/tcpm/Kconfig           |   8 +
 drivers/usb/tcpm/Makefile          |   1 +
 drivers/usb/tcpm/qcom_pmic_typec.c | 456 +++++++++++++++++++++++++++++++++++++
 drivers/usb/tcpm/tcpm-internal.h   |   7 +
 drivers/usb/tcpm/tcpm-uclass.c     |  18 ++
 drivers/usb/tcpm/tcpm.c            | 137 ++++++++---
 include/usb/tcpm.h                 |  40 ++++
 9 files changed, 661 insertions(+), 31 deletions(-)
---
base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
change-id: 20261118-qcom-pmic-typec-80d9f23cfa84

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

