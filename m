Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E426ACA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7361C80EC7;
	Fri,  9 Oct 2026 01:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIrPF0HONPNg; Fri,  9 Oct 2026 01:32:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9526680EAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791509553;
	b=oman0FeQTVCrjb69D8cc98HtNBB27kR54JcUzvIVj3/M9iXUzqsMa49yHDmMxRb1nqO6
	 SbqnN/ppdlKf0vmvBR6jqBRSU4L8d3Gv44A3akbJ8spThdpNhtevJmtVNyH2XmxVU2UOH
	 YIH9en0U+K5WTa80rOI2s8lL+aberqQQ6ttfVlpSN3lhSc8rwpBHVh4qg5GwKhCXkw/Ip
	 IA8+ydK913/WeBkGvrDmDIaEmlzajjuHvk5F8CQEalVZlTlkvlEbd0lT2xXIFI0rlHvLW
	 Jd9NetZv1uDfdRqj08XhkzmqWbEtRd1VaDBGA8O6YIgGpaReb5bJXXBWbEQp0UGZyyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791509553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OzIlbjIaQG4JkfAXVHHLwMNFg78IwLkNQC5cwGoMrJI=;
	b=WmeFosN01hyr8CP9qz34BQ8znR7BSzBiPbu/7z/Mli6hXW8bm2VI/fwrekPXh7uMzfbc
	 rcQs8fPJFVbO5NdSBp2Cf1emeKaVlWM5UwhzUkdHzPdWtARGbVAuhdDvdqv+XiqVYe8l9
	 NYdZsIzQLl/sMDW8KJNbrdIh7nv3my/M6qVJLkZ/NdTjrMD6jM1bsvHKgYxVcCYgsS8FN
	 fEK7lAl0rxCZNHewhosCPZoytsq1eojZ6PwLXt2li8lFRPhg5npFCD5SndoEtGeTJGC3g
	 WyV/Vxp5EZpOnruJrf6Mie0J5bvxfF+j1BF7Z9gkEdGFwEcS0XrwaL0mbHdpznJwgXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="bQV/vIot";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="CRk/hlhN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791509553;
	bh=OzIlbjIaQG4JkfAXVHHLwMNFg78IwLkNQC5cwGoMrJI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tR/N4ZIieUCckA9l/XQie8gaBWHI9aaVAIw1TP7F12UKw6pvpwaculm9CwZ8m5cQZ
	 CI1gI7dyXIGuoLZlOGZumwUS++N3Q34xHwguanJq/h6ISSOSZ02CbrhO6sLG8CgYV2
	 x/67rYpMa9pgePYPspaIIv/3odEx4aqw7jRfaEMVhIBMaBBHsmEApIWTexrIVyyUV8
	 Z4pWHQWygfbTfPxHe7Mm5WH3LsXc9KtZDkTtpftbIp+X3szKwHm2k7k5eSsaYO2u0D
	 jbYalFH/heERPD7cWhHLT1sYmBFkPjXfiUNmkch/PN6Q7JMj6o7zYXT6rp34/b6UFd
	 xjDxMrRxTZbnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9526680EAA;
	Fri,  9 Oct 2026 01:32:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5620E1A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C08B80E95
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccLtQLTmtxxj for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC14A80E53
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791509551;
 b=V2ENXLZQqPc0KuP3U4X+8LXxz8/cJqc2zGkVEwI9xWsH1yUWd8X+6CT9FVxyjlUbC74H
 JRzpZcmkY6/aw3Cmrbm8/SDIu4oPhlz1x20HepWwBnDumMsw6OxNBzyUMG+bpaxPBALoG
 VqMfv5JOc8fIyDQrfWlP26kzLqEHT7LtydDY9gCTX86Nn1KKeGwj3tyjVYGlH6bbf5ydq
 DRLgT5NjEy5jT64hbQWs3xaQp0dWS9/ve/rBuzWHxAdOP+oFY7zk9Pgif+n9mlEaVdERT
 pd3uiDkcf/t13ZAOda7kNEdxCPdZ/bzpXlorUcVDRif1bAJYgNxFUWR1nFIWHw8W+iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791509551;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=OzIlbjIaQG4JkfAXVHHLwMNFg78IwLkNQC5cwGoMrJI=;
 b=hM6MJN+7PB/QClF38Ovk8Y9eZwsJJpDl8NJAORf7aze2abn9BZZ0+ZEKNpjqElBmZ1d1
 tnCCQnTFO0Em8IhVVpOTEyiiVxXjKKEStW5KXsd4r74swOd8R2tcMCFk/YWyK99yy2/03
 2r/7LV3vicjCFTIOhdZvSIb9U8PmT2T4e/79Y+nsOk6+AXglzNsSjNjuTiE34z8dFdQRG
 zl07B2eLsD17hpP5QHGDTwaTyCixpepn4c0M6/4dpeR8C+FbLLcnNwWO9xGZf4UantP3U
 XUNaDLNPE5tlJajcIG5F1uwYOBMJscY6Zqel9d/M6fP5voZyOtwjjT5Rl/lA4v9TKzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="bQV/vIot"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="CRk/hlhN"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=bQV/vIot; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CRk/hlhN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC14A80E53
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PTAQ3578615
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 01:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OzIlbjIaQG4JkfAXVHHLwM
 NFg78IwLkNQC5cwGoMrJI=; b=bQV/vIotS4kOlHEDdL2Fd6bnZcdYFWJ5vaJbDj
 ffVsfvVvQeWDbeLpwM/WiCPFaiSDs7s3tbxgWbqr8QlouowREfTd6APY60B48BeG
 /bhc4fNkNUNIxJeE4MwJooheNjKRc/lk1eW/kN4a8VUXDnppkrZYa8Qb3KtdEjDJ
 EQwR48sF7qn49Fgi/c/NeVgjxqVzecDXrLEeIhbWfzFhlE3wNEmAlSyW5QR7/rNt
 DkZK92hUO5yZyQEVShUCKhMzsBHhM5BEICU3zGBuh/jYmOcUo2ZLJBTYGQqHV3hW
 7OU/27UGcAJB4anwaZoeYGyozNP/hbkXlcQtSm0JMOEMcnBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk1bm2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:32:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so11890578eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 18:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791509549; x=1792114349;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OzIlbjIaQG4JkfAXVHHLwMNFg78IwLkNQC5cwGoMrJI=;
 b=CRk/hlhNDRAT1rQjYytW26UWOD0727BQbqGkyLcmbBYaxA6xR76IO0F0VDgyUny8ty
 Jw7yukTrpIf7qL2CbVdI/0CVxHT5vGo+0ZCF70ZgixcgqPyMX/UYcFCcJPAcIhYblxPK
 RtvBkVWSy67jujiglFU1FKaQni9C278FdmcwS3PYhqbrhhA1+UtA6/kyYyarpGq/itWn
 lgErZ6VX5PvB+jMSdbP0EOiiKrE+zE2g+9r/TTuNRpuV/w+efHEDubIi6gXYjz2h91Eu
 u9P29kDBp0Bp1Pow1y2bQJ3XBO0nhEijzF/ry19iGc1QPvFFcPx7hLmyXlRJT7I3uKRL
 aYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791509549; x=1792114349;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OzIlbjIaQG4JkfAXVHHLwMNFg78IwLkNQC5cwGoMrJI=;
 b=YHQsO2zc1p9t3usBl+h0tjdFzhOxkqUTP5SwM/EnY0cP7rrg8bv/Gtfnq28BCueNVf
 Spztn5bbbK81Biu6Y7R66pwqbqjYTBkNh4BLZ7fc2F/I5uY6J3dN5SbxS6aCTKrG9OhX
 eBj3o4YXMoqfrKXAu25/dswoGm4SKFQ+EXEh9jlEKiPZEoluIHURHGH66VJr5piXUj++
 xorIAZDSc9EW7tsd8hGtXfLBCTpO5NXFJjjKtv1xkylx3c7MKQcwo4ysZnwiAskIkrEP
 UdFcA+hKVEc0NwqxnL+DpmH5IWps/lW/hJp/LHLekQKB75uTb0O6P+7++Z3FcZyxdAwZ
 ofbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwA8iNcUJ6xI6IiUZtj/jCXxmAZnGfISyYIMg8JYPn1gPdlDC/zyZCPohnDo6wFuIJ8wSOi9G0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWnq7q+2aLuygz+94raF9KB/UEzTQySxYVLh83mD5m0E/xHAR6
 ZSMGVikTNJWwTW89+VPIy6LdIYaU/w10abfg+WCF6GL567Ne6sNvq5Os4BBiWNa8UhRf3l/eZNN
 GT8wdtDMscLcSs1jhz9z6dciwyhzh5lcP7mSOmNdEiv/gNPM924XlKPDemL2GX8ZIpziWBVfXvL
 H1W1Se6g==
X-Gm-Gg: AYBFou1J6Rd08s1v80HgsmeFzP+DqKjaBUmP+v6evuq9ThVIIDi/+cxXP3NhOuaMeMA
 6LFWSEKiXUBEJZD3hTQ13G67q1shmy9o5JYdVNKiN93OxV14E0FSrNekPKBhmbSOQLHka1FOjWA
 02oiqWTQ49Rizuhqx06c8eQubE4kJCj8gqPaiCNa3rJ/2hXU+hVn3ROzL2ayOaDeySmKCsW1LNq
 1IdfMvjj14bLNbG4dtDPdXeVhiVtOIBgVmlfLXUVpo/8jzMniQXntSG60ymMr8rYqCrAo7wz3Cz
 peAW4WMBAaMV3q8n6NDKHU0gnOqFXkmTfS1dfSqt8w0FuIgmQte0V3xgxAQMRkgEDsrd2stddHg
 9bUCr5wQylFBvaXnILeEfIV6lDdIEr2oAEdE8as4UYk5DwmdX9ojUr/boFY05XeZwRO6xHVUKxB
 huFu8udMB4Ckt28S7k8uI/4eYyErAK
X-Received: by 2002:a05:7301:6207:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-3537df5970cmr800013eec.12.1791509548921; 
 Thu, 08 Oct 2026 18:32:28 -0700 (PDT)
X-Received: by 2002:a05:7301:6207:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-3537df5970cmr799965eec.12.1791509548140; 
 Thu, 08 Oct 2026 18:32:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm1950600eec.17.2026.10.08.18.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 18:32:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] qcom: qcs615: align storage and environment with eMMC
Date: Fri, 09 Oct 2026 07:02:22 +0530
Message-Id: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZEyGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNL3ZLEnPzi+NzcZF3jRMvkNFMD80TLRAsloPqCotS0zAqwWdGxtbU
 AZLDSsFsAAAA=
X-Change-ID: 20261009-talos_mmc-3a9cf507a9a8
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791509544; l=777;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=55vYZUEo5DoRdhppYNGCGUhmiw21PYyjbxU7FGGt11w=;
 b=Z79suvbfYRUd521k/bkyhOPX7q80eOJzxuq4FcDeldUuZ4u0+07Kgrc2ckN8v4bDdOcrP8p8E
 qj0/HsX9YaPBSr/I2GcaK19ipc8pGClOs17iK6kKTRjlin+K1rlGCjx
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac8442d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zqOvAwIqXPyTXuyXnPkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: VYToaLWFCD90Tkmek-KVAYXt38qWx4N7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX7jxJVXyO2UYV
 CPs+dvBal7yGpADqKCiAH3gDy9WV+Jv/EqlrIuFMurn+PiBz8fr88AOqoNEZnpMp80dYvzv39ya
 8jVkeQaamppHUTrjin428cbp7kIUXz8=
X-Proofpoint-ORIG-GUID: VYToaLWFCD90Tkmek-KVAYXt38qWx4N7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX8fUrSE76tk+Z
 S9dFmkeZmH8/53rLx1TSxxqQ5AhmuGVUsO3MyVS42k4iWfhmJ29eBFLwh7qWjlXq0ApgzGUdaR9
 k3cd/eUNO7nSGjmqdmXzcbN9i7kll8lDXtlmkLWSKD0qPuVuPLJyDyGjFpPK5jIowF+zw5NpuQd
 CabA5H67qxvSLxMrJckc+kvqc4MAXmqJQ9xK8IZO/hRZ2DL6gxAFUW3lnP84fvjq3ADNeTJ1RsK
 Q7RiRXVPXV8P8ifxYZi6+JXoi2QAgp3uez/VMRUAUkKAie1oKVq4zqXeNJGHp1Dz7EwJIULxVx/
 SX+02z8aCQOfdNrai3U9kYuP5c1LlDFdl7DIlOOrPDZa4PCZWRtFznZWcq27/s4+Jpt8jtMlFo1
 vil4oP+4wix7A/mmheez54jOtrfmsK9/xiV4X5jkFRQsqwWS5uTV1vTKXldrgCcGHO2uN2Sur1M
 tFUwDzUBfG2eLF/J1NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090005
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

This patch series updates the QCS615 defconfig to correctly reflect the
platform's use of eMMC-only storage.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added reviewed-by tags for all patches
- Link to v1: https://lore.kernel.org/u-boot/20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com/

---
Balaji Selvanathan (2):
      qcom: qcs615: disable SCSI and use MMC for fastboot
      qcom: qcs615: store environment in eMMC logfs partition

 configs/qcom_qcs615_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)
---
base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
change-id: 20261009-talos_mmc-3a9cf507a9a8

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

