Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0s9T768H;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GmwKZI5n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h5E22tHg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B96F608AC;
	Wed, 21 Oct 2026 12:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOVTwX7uGA46; Wed, 21 Oct 2026 12:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2D6860A8D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587042;
	b=XdAjeHrjRGDqj/hHyXAioK9DiaHBOGmRkBYgOr78t9ctutCDpECtCQmYtdCqRF60JuNT
	 kznfQ9L4QH9JN2EWIjQb3/dE8waFiNLzyaDANfwS0ONq7cypEh4G7ANiVtHTsx10ARhE3
	 CS76PYstSii5OwCWeV5HFitDPhAvSKWqBMeEW5o2OrYqZQAv8G3DGQIt21BvdcD0qeJzk
	 YCTIpXY/MmyBbIMxTcXXmY2trXGKfJrYIHffW1OgfS6ycNM1YRRkD2WetN/nlXMKOtA/e
	 CynzdZcqzxO5tWmKQLhTWCGBxoTlgBOK0WMyj9ubV39JSuP80VGCCAqlnVDwQ9LPfgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kxsrOmm9dx2o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=;
	b=lAlvaek+aaXpb2z8TCycjiwLN9f/pBRrrL3Pi8MPQuz+eLFN29HriNzmNKT9U6Zv0lPX
	 hhcxgoXDzF1XohKN5rrNiVwMQW6B5Tc/AYUCIJy6nWvKQPRl908i94PWu7p4hvxnmFCh2
	 5hNYw6urVEVVzEGeXwVh/u+LGAC93TxFCDqu+UV6RqYUk99is9CH5aBaOa+5DqklLhMA3
	 Ria+rkuIeQSlvN7n26wy97nJ/VUdtjMMnlD+bHsVEoBQ+mSY1WZS/KVR6YNnDXzLo2Q90
	 UYAu0yZX++G2CH9SKEApPDtbDvs3MnBp4eRrM0CnjhOLqwoHw9FUw5yzMFTNbcMCkFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GmwKZI5n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h5E22tHg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587042;
	bh=kxsrOmm9dx2o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0s9T768HZ5W5zreAXaJEBCi/eUTeFuvAVv5CUiPM8Wuk8NRghm+Mqv4CmWDEtE6Fa
	 bL1zXHOQGyVzw/JQ+l5xbPyyNCiuFonAcqzdTHw/hWxCxxiP+HF+qiN84OE/Sn4Ha1
	 I2IjswQLY2DiqvZKY7Z8JPq7wBBhymlRCUZ9OymhFyZ+n7aLuXhK7YRoHUrXr2VAQJ
	 H+aBIUU75TL9hS5kaQxr1Wuep8eVfkTnHSNce0nWlHC7KnFKyVQ76Hpv25kq+yJQsV
	 3jjxEDG8VHCPUVWKTbPJIA2TVYHE59sWXWLZoff3sXfJeIeXAEr7+cBBcx/t78TM8S
	 NSVJ2uGos552A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2D6860A8D;
	Wed, 21 Oct 2026 12:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 440653AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3565160A8D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2qzR3KxIe7r for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8280760AC5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587040;
 b=ij5PkbI8CADAgV2R6DoGhL559DvERrEOsF6yRDWoWMBRAXvaHj3x2IjVLDbqPtwjJjYQ
 uAtO1Ewr9pbQY8WJQhREBWJWiPto1lLrHtsapJb3q7i5FUIonvPph4gnmGYUcdZWOqsm9
 +cJQTxrN3TfapmiQPuaDJWMz61TByupBtKU5Z0Lh668VOagGgQ5+UzaWj0z538tOryLsn
 41H9k9yT6XdUjrYJ752WXAlsojL4jC+u9v9Jm/SscDAGV682D6FBB+QSEvXkASMoO+eBr
 3wmoi8bIcKm/qjr3MxAMo9tKL2Muw1OP377jn2exjnNtaZgMQFkFlt0oYpOzSy+l9rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587040;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=kxsrOmm9dx2o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=;
 b=TQ8KRNf0dlVVor03W09rdyTlOuyXo/i9ib9hY+sqx4BAxoHzqKLchtFW54OdVlgzX+Vw
 G3tUkM8Pp9rgpywGxhRudhWDKJiw1UX/bqhpuOnMiCQPosJGEjsEA5g0Xqr0lOv2RgO/O
 7yJBYwc4mQZdoRTeVJA7Hz7Mzqi82rpiQwSSfxjIsUA0fndWKzr/jJJsVfzkF7vwu6/1B
 knSvrKavYPk7ybYXMyRqgqu5wwpwJDl4mWindMA42GytUfZxqkU7Hq9xp4pc+gkGwirea
 NNT/415dFPpvPrcjobKX7+HjMgLEUb0A95cw1fG85IIWT7qvYYlGtReeKfaZQnH0GlQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GmwKZI5n; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h5E22tHg; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GmwKZI5n; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h5E22tHg
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8280760AC5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg3v21599904
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kxsrOmm9dx2
 o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=; b=GmwKZI5nyrscaB19p38+m1oMVUA
 pRhJFpoZ73GW4XTsn2V5+AVJjHKF7/vDdk2bfegtO+2KYuOkUT+pFZ/Fqkcc5Zh9
 NldIcp0tkR7oLb2iaLqA+ccWri/f6Vrw8o1rvFckv+BxJK3ikNT0EIMih/fx1yOZ
 YmianjZJVlOVJ2ZU8VpyST9Y/MlK2rHTmo/Jie6V6kVruxVsIYyH34HUhnSy/YSz
 7cllQpey2T8U+z4E28cuAFXsveK3Giyv0odzuHGJz0nYcgdLImD2FtO615vbszLW
 qq1bAubZWxODCS70UIcEEUWhYJ8z05qUoUOJWE05XaWp/QXZ6o+Sk1CVqug==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhugfwj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-155a75f91e1so977166c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587039; x=1793191839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kxsrOmm9dx2o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=;
 b=h5E22tHgUlzPQHfJT7iqApDVWAF9OROutgcR9EG9PdaUXqc77n5Mww9ri4DQgLQFkv
 cbPBCGgVGukjX52hd2HH8/PxSnJhCkanzXMlovGZhJToJRXT++tywNpWDQxzLjt9myEz
 ap2pE42yVmGPZqEIe830VqrvQze9VWW3DzMwAq/smFG4uV5H9Rb3B5kgMbjxFv7fBxuJ
 cK3dk0UD201GT4xRXXQAvcML4m8zs1wp9wVC3NqN/k6R+B7ybkdUO95GR1EKRrfpRuHO
 +Lw0AcRo/adBHoBgfytFXAtTb6ZmMLkr4eubQJPx29vSx9rqjUxs8aool1zqO8Xjj9V3
 Z8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587039; x=1793191839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kxsrOmm9dx2o0w1NmQ3LLW32p+S4KiZqW8xXP2/lAVk=;
 b=EhURuOqpU6NfFSwxNIxa5KGPd1u6Yx13J6T8sTG2aRWkeNVbodcjgrLOoVPodaUztG
 OuyFCOxltWP+TqPzcw5FUEN1qvdyDGxDUrO5gSawapwfP29Jb1iP+a9NCGR8sIUV6Y5N
 DH0B+PJcL0DY1dxQZr/0nmLK/kSdDbhHKkVoskfialmC0TiD260PSWaaOAGAQ4iW6A6t
 WndXJ6m7J9yAg6aqAKOYdMzeqv/GChfCANyAK73NgcaxY2HgjZZApIUTZNytr0LSsAli
 f9JlTcbqcelIVPIqWZ39fg0LFup8w1gCM9d1YpOkanmAb2J6KgEUP9vM1RQ8JmLvfzAm
 nHPA==
X-Gm-Message-State: AFq9FYKf+xh9AQ/LMMsriXRbf7SThDQiwjaH3hXGssjXMdCA5CDSPFea
 IMrbfL5OOfwaUpxnPTcwYz0PIl2T+/lnXgX4u5OaWNrqt4DRM0Os8B/9H6FSaRgaY3Zd06JQ+z1
 SajZK4oYIuKzpLbyBfz2iCpt6Ym5ol3uIbYyTeexVcJZakZRsFzrKu0RK+bGjZCLvJMn/tTaVaY
 UUvIM=
X-Gm-Gg: AYBFou2kpnpZPRKGdn/qaEfEgz4PB2J+jLulT2ErLMdFO8U3bH0bCjTK09MEseT3CJ2
 mEwfhOQb+mQh7W0rGCEDMniPnUXg7tG1jLkbp4f1vtemQ4IzQxH7XlTo4Zy+AYMN312IAw7VLlj
 2ruY80yhkLe+1BqmWj/pBPYEN7rjgSyzgH/1PXN7XofAVX1bphmSy4qCFIqdqGXDmlWblaMDGlO
 i8Rjd9OHhYA1NJdce55IiKGmQJPgzYCLPxXruCC2AjZW4lgeIyaWFmF42m3SI2N38UmfACiI5jG
 C/HKWWWM9OLZeZ9d9CuYrq1Yga9NpXPB7QgYL8k0xC4O2s/WyC9f5wZ06uLhYyGHVvWoaAc2w76
 xzJbiJd7N53GBhPXYLwT0HgG/Q2s5jpN4JX+PtfIngoB7vTHK8ArvhhlZHmkRJZ5U6D3eahZpDn
 7jyJ6HEoo14jppuDpdoq3W7Dhsbk8xKePKu6U=
X-Received: by 2002:a05:7023:905:b0:143:808b:b178 with SMTP id
 a92af1059eb24-18dc13f3f22mr6541038c88.26.1792587038633; 
 Wed, 21 Oct 2026 05:50:38 -0700 (PDT)
X-Received: by 2002:a05:7023:905:b0:143:808b:b178 with SMTP id
 a92af1059eb24-18dc13f3f22mr6540997c88.26.1792587037799; 
 Wed, 21 Oct 2026 05:50:37 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:36 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 6/7] arm: dts: ipq5424-rdp466: Add GENI I2C nodes
Date: Wed, 21 Oct 2026 18:20:02 +0530
Message-Id: <20261021125003.2948090-7-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8b51f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ByYeNvto5wZOTiXbM4oA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX9DgbQvXDA4OQ
 2VZT/SjbjEWOgIaxpj8a9C9iRp0HwrXGgHmFfiESuz1+scBML1DCfqzlEfqJEnuvRisPvlQg0kK
 zqL4gUDZUb1QeYUe1B3d8h+/LocxsDw=
X-Proofpoint-GUID: BopQE-vWWLqoVOjKneWPapc4dyxw96cm
X-Proofpoint-ORIG-GUID: BopQE-vWWLqoVOjKneWPapc4dyxw96cm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX8X9tx6MBL1WC
 j5dG9seRPdh6EGCTd7BKYnZ8H+eqTfJhuBAIC3v/v8BureXqPRmPWJTBCNx6ZEF+QiaNMAprKbh
 C/rnxfaBPjc3wqI99XCIdO9Or/N20aCTbMt8NONLwmexYoaObNQqivyztqZjQFnroarzAZLFL6K
 JnwNj9KYIzm22nfaBBnGdLZv++JcdUzXOp8i15oDe1dVmQt8XgXoIpMAi8oxr8rh8ArcUKqfoOU
 aDc3m/RC46Mt2lrRvD/tzUNC50cna5a0zsXfJwjrorE1dzYqgxU6hK5QHuTLC79ODAv8UgF/SRz
 1DY61J6DDBZpM7fBeWM0E0E9aFhk/TdcSOO8b6IbIOBUC+doP43dTiwi70N+0i6Qr+47Mpga9/F
 zmcUs943GljE94TxiR2yXlvUS1YvBUEms47maooHhZAZ+9LHt3gVJaJzmZ6Up2+wHAUyQkGNkh3
 fmQ0Eo+hqq3jmNKltwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
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

Add GENI I2C0 and I2C1 nodes with 400KHz bus speed, pinmux
configuration, and 32MHz assigned clock rates.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 56677cd6f6d..1e3c56428e1 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -38,3 +38,66 @@
 		status = "okay";
 	};
 
+	&qupv3 {
+		i2c0: i2c@1a88000 {
+			compatible = "qcom,geni-i2c";
+			reg = <0x0 0x1a88000 0x0 0x4000>;
+			reg-names = "se_phys";
+			assigned-clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
+			assigned-clock-rates = <32000000>;
+			clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
+			clock-names = "se";
+			clock-frequency = <400000>;
+			pinctrl-0 = <&i2c0_pinmux>;
+			pinctrl-names = "default";
+			status = "okay";
+		};
+
+		i2c1: i2c@1a8c000 {
+			compatible = "qcom,geni-i2c";
+			reg = <0x0 0x1a8c000 0x0 0x4000>;
+			reg-names = "se_phys";
+			assigned-clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
+			assigned-clock-rates = <32000000>;
+			clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
+			clock-names = "se";
+			clock-frequency = <400000>;
+			pinctrl-0 = <&i2c1_pinmux>;
+			pinctrl-names = "default";
+			status = "okay";
+		};
+	};
+
+	&tlmm {
+		i2c0_pinmux: i2c0 {
+			i2c0_scl {
+				pins = "gpio14";
+				function = "i2c0_scl";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			i2c0_sda {
+				pins = "gpio15";
+				function = "i2c0_sda";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		i2c1_pinmux: i2c1 {
+			i2c1_scl {
+				pins = "gpio16";
+				function = "i2c1_scl";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			i2c1_sda {
+				pins = "gpio17";
+				function = "i2c1_sda";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+		};
+	};
-- 
2.34.1

