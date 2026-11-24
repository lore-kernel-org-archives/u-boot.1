Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF38606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sH9z/cgj;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jog5VKzx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VTfrBJQI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38047407E4;
	Tue, 24 Nov 2026 09:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmGBfhmSoPA2; Tue, 24 Nov 2026 09:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AAA44079D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795511001;
	b=l5qsclO/1CBZUlyLKXTI/fiYoTo4MrtaZaozWcGBmK+u/scxyAPx+PAgVUc9+ncpDW5t
	 tMcVXv/cRn4GPwaQ8cSNGqMsmw8nKWBcQLrtuUPkGLaemSDs7YJ+kd4QZUDMUMBCF0VdQ
	 uNHBiaJWlrbkvZDO4TxwC0yyMM7c6otaiEnmkj6m7S6ZYmz/uuvMTQn1dKe5JfbXy4xG2
	 Nrv+O6XZvpd2UVgR+SRFvXF7jsbOMLSoKJo1UjhcZILQrVV0xq2k/RNidS4wYc6VZ6Mlc
	 BaK49irC0Euc9ds6Lin+NuqXx+ajnv2PmfnFhXsh6teyh2kOQAtrnz71RFXOLmvtSrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795511001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NY+AF7WvlpAraxlmLvtGe0fP+P0u0eEv0YMA3a2t9q0=;
	b=tbjKKh6a1FJC521T9yw4taZc4z+2nCbPvofDsLxXeX+vakkujtqyaBLzRk/5SaxyzXav
	 r3YV+kZa3VNOet2FjXkP4m1QB9KKKBjmWsrQkG0f7abetydn9hUjWDIlXdTp0tSSqw/PZ
	 7v+ShgE8Z5FQE63GOLtDZvKawwmQJ+IkpWzZ2f0CgLzE2Ky4E4IJ1kZOEL7SQ3Tsl9Y4t
	 RfVzxjA2Hq4INnqF43aq39AmgaarbTe6LCvdC+iy0V1uH7GjeLxsP8AbgsE+BlrhNbPTj
	 i5U2W1REVz7bObOmWJi1wCIIv66jh0tpld9LMxkLK1gabnIRaH0zleKBWRu1K0WDCxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jog5VKzx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VTfrBJQI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795511001;
	bh=NY+AF7WvlpAraxlmLvtGe0fP+P0u0eEv0YMA3a2t9q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sH9z/cgjBaMg08nMazClCZFi18jtUf1P/jqUtVZwRRIcrDRAFLqxmzvEMGIYkETyW
	 aTzlxCvTTep2k+nL3oF/IIcFDvXfiW6DiXHCxRYvYLuQtYxWzWeewTpxU1LXnvOUWn
	 8MafdsMSSj8oMkxKP/StnexRJ26PcQIEPArTYoJTM0+71qR27cMXhcajwnCKDbgzU7
	 Xh5x1Bc431kyNXYROOsNh9bsS7j7Zt2W5wYvsBCdjyWb17e7TSVlLlTLROygkfrj3B
	 pgRBLbmRPZJpSpn/URxw+hJQsWbAgcPjwhgv8lgfs5FzD4eBJfG9fVkMq2vjqKG56C
	 7BDOXyVNiAfoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AAA44079D;
	Tue, 24 Nov 2026 09:03:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E70D311
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B8B84079D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9k1ibBN_fYu for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7962740799
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jog5VKzx; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VTfrBJQI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7962740799
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8Kr1b196967
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NY+AF7WvlpA
 raxlmLvtGe0fP+P0u0eEv0YMA3a2t9q0=; b=Jog5VKzxRL3fffI3CWIAtMXRwbR
 Ica5rK9cVWC6Phy4apHw4z9ye17XZxpvv9YeXnudDWzszA0xwzhO5Gcr3LYupXFv
 EKcT2qJa60saZKHSzoz40IofD1+IGEzLfXzqD69ZESIQefXK+pd7nNZbWxTVL6fh
 UQ8Kh9hTuE2c68XNG2GQP78pgVdeN77UKByBAO4Ri1M7A19HtiBnq7YPWyMZHmp/
 /ArQzJ5QJWAON8DIhHwCL/f20JN3zAwDxWtZ5J7vknZbkFwzQIjwnP6oVVU5Hxf2
 UpmMna48gzfOhIk4Nw+clGLHhQZqM1odnWEdLIVi6/NfTq4YyruneWBZbXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukrasjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so4786276eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795510998; x=1796115798;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NY+AF7WvlpAraxlmLvtGe0fP+P0u0eEv0YMA3a2t9q0=;
 b=VTfrBJQItzf4K98rGXI8wp6rymM2xoBTbeBRH1bydUTJYAao2YFOWRuwl3+xv4/rbZ
 3bgWlnecbsGe746YG+mcBH7ouDPTyQ1rKyspHEOlL328lOxFCZa1lkeRB/QCGfFd33ff
 wCWjG0nnDEfQYP9elH6k/cd8pM35gpd3W34PAvbaVupwecwwjWNzPAwNPdf3DgkBo6W6
 P3eC9EpTd5CA/GWuNS+vrehNraXZ9DKe8dKU2CEyzIfHtJwRMNWfO0Vi4jNptIJ7aPmF
 deaBpbWveDSETOcEWtBEbCL9LfAYAlpVJZ9xxC4MwWpX9yjUSIKevUsihDLrSCcWeCtc
 jASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510998; x=1796115798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NY+AF7WvlpAraxlmLvtGe0fP+P0u0eEv0YMA3a2t9q0=;
 b=MxO+sG8jc4uw5qCpH6KwsfVNzatFhBvPxtl9syPMkf7XWYJfiXZaXqxUCTIf1ztrZo
 Z3edn821Sa0ZKPVvVE/baF0xtZhpBgBWGeschJkn+IoO2yawTujpfAGJ0f5hwZRvYghM
 aUYu0K391+MIPK6nP/blOZ1YBnP0jY5255zCtzKroZv5OZvTqJKz0CfOJikajdkcgvIX
 0ZccND/px4CJoJ9hGwVNvaiFRGhIoAd89vyPWoRgHV6xgRX0TTFV7efNNB5g+suFg88o
 IgDzMLel771GbQL0R+iYq5ldtDCONP2ddJ4KCxgHt7f0NH1icWNBUFIISIbDYMoRoGT0
 PJNg==
X-Forwarded-Encrypted: i=1;
 AL+hErELiXUgFFbidX7Re7TMMhSa4ImDEP6cUAYpMxgttQBs8uFtqkGrRAsq1jVpUtUHB+z+NS4Ss+M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8nYJZvy/kghHdQlIgQ7cBSRsAE15NC56+5wOCuoQkL7MlGKGsw
 /6GyuvYaFSKZIE5+L2xtHu+QCltqSBBIgw4z40QF7p+mZlN6hS1YRjzU1BcJf7818yHub69hFQA
 IYxGuHw7H8yLI6WKiMRRnqZBM95WQIZYlCklwDqf351wv/iyn1nPHaCb/wtJv0OinNG9qe/k=
X-Gm-Gg: AZFdTZe/SGE0CyI28DIm4JnbTcELX65pXeOA+b+/RWq9nuMCB7dbs5/rwoemG/xzge2
 b1ajNx+0+bNGY8oB4K2eAT0VBYF7U3XADsxpmAp6DdD9IaiXYxE4lOsXCQe/LFxsQD8egBW0/bT
 q5IPpDOJIlRYC0hPzH+fxny21alVdNsLA6fw0rnacBNjwkdLvQhGaFtKP3Fc1qqp+Xxj+JLV/9x
 py6ngl75QitzwAawrZawPWkOUuWk6u8wa+ajljJDFEjML1DZ5qt9d+838yzjYoEB7rDg5TvnQXJ
 cORQ459g60ocV5z1KJQlUzg5OU1UzCHeJAxdmGR22GINX25bL2XHpVy0BuhfPphfv2223ZCRmlT
 qQrzWcZzG4fq2NPRYkzEsXGpdUaMCaAbihpRUPypv8wrn81/i8iaXeHJMM9uK87+7MAgssIdlW9
 zP
X-Received: by 2002:a05:7300:d589:b0:386:9ff1:7f7d with SMTP id
 5a478bee46e88-3869ff18213mr10776001eec.4.1795510997870; 
 Tue, 24 Nov 2026 01:03:17 -0800 (PST)
X-Received: by 2002:a05:7300:d589:b0:386:9ff1:7f7d with SMTP id
 5a478bee46e88-3869ff18213mr10775958eec.4.1795510997264; 
 Tue, 24 Nov 2026 01:03:17 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm46429154eec.14.2026.11.24.01.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:03:16 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, royzah@gmail.com,
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com,
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v3 5/5] clk: qcom: sa8775p: add SGMI reference clock
Date: Tue, 24 Nov 2026 14:32:10 +0530
Message-Id: <20261124090210.2560500-6-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
References: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX/kWTv9Clijdr
 dX3ruPb9okpIQc43Vmvt0ufE/LB7dqJrujuNxJywd0D/gTOMhD5fill73/7AadQfb+axkFVCvZi
 83+FMUVHsy76kESO3N9nRUcjBb4+5mI=
X-Proofpoint-ORIG-GUID: W5yx-LyEp-bm1HIqvzu3NVMBUuy2nhTv
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b0552d6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=WdjrKUAYfTe7CgnA5E8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX1BKRpk/PkC05
 9Cyd6IJ0yZ9dpliGzY6C/kE3aZyIVprehNifEWu6cTi4OBvPG0mjer9Q2SFgQEjI1PdrjEB+p+a
 GornX88qKQw8rp4DcivV9XmrRDVcLgjRYbt4xZ2fezJPGcXoYHq8PiKGs3rj+tW5/N986j+xy1C
 8qPpk4LGgiaef6sdBFrEtGABCr77wrK6kUY4C1/qnjk0g5P6t8dZNxIyLwGvYBNNX1/tSjbfy8B
 grd258dC2D3SXOknH/pE598+RijAy2e3PVFH+QuC34Jx98OjNY0iqPqejtpu/vaSitzuXYcvMjY
 WWHJlLu53mTetCBxVzCRPYCNcGEdDtOfkdfPOMw8MI6HfXGsp3vz4XfTbTwK3wL3azWt49FpJaZ
 WQAptqd1NiASGThmkXzLj6JmAL9Kc6EszSgaVoPf6p5Wl1sckCyoHbybVu0KcOaycwD57rz9nui
 v2e2W2Y0n8KHyjdSaIQ==
X-Proofpoint-GUID: W5yx-LyEp-bm1HIqvzu3NVMBUuy2nhTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The SA8775P DWMAC SGMII SerDes consumes GCC_SGMI_CLKREF_EN as its
reference clock.

Add the SGMI clock reference gate so the SerDes PHY driver can enable its
"sgmi_ref" clock during power-on.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v3:
- No code changes.

 drivers/clk/qcom/clock-sa8775p.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index fd495b73635..65f8bd42a15 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -227,8 +227,9 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
 	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
 
-	/* EDP reference clock (used by UFS PHY) */
+	/* Reference clocks */
 	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x9c034, BIT(0)),
 
 	/* SDCC1 clocks */
 	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
-- 
2.34.1
