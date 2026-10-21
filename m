Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C57606A33A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wGQeVliu;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MImKJOnz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C90wOGGv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48D5A60EBC;
	Wed, 21 Oct 2026 16:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNh1BC0Xc4j0; Wed, 21 Oct 2026 16:19:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A35D660DB9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599563;
	b=VKBtYLPv7co2UhhvaqSRrMQQbvK+98jSaQyB3jrrjz1IKojq7elRLFL1Ej5jDOutTlDu
	 AgeYo6rhwM4CzG1UVWtxBaqjzcgNHl5jxFAqyZztRARNafjlL7x5fi/UG3+zCx57b3YWf
	 JiE+kdTzVkwPfJDkiV6lMXfqSUOfX8BZqsOcjTtknzeTpyBv0xTPiumH7SX/jNzBaGlxe
	 Bht5Va2ti6WYfsXYd2lJ+sG1oRXhufJKJo+oW5gRm0UzesINBooTiLLqZbkFlJsMBG26Y
	 Ssb/+UNEnfFLUBlvAe0vRWmWoWK4xeSVZxfbhSsIGBPIKTp3DETnH/ByTjQQ8x5k+EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
	b=N7YnNn+XzGH/TrbwL6dwJjJ7m1rOb8a9S780U3QZF0g5zi2i37WhjAUugzlzCmR8vS0K
	 +v4zf+kapU10ID2H9RSZscyNSq5vr1k3ZolW6U1z37bwc444n5x+fF3cDvH6j+fxurKBA
	 VdBLDALWmGTzXaLcrIGmfKsC3t9KqJHtaYPZQ4cz+SQW3NRIDaKnSE+r57VV5B4OMYtd/
	 jBa/AKgDlv6a8k7od0FOug7xpVczcZCl8ePaNu6OtUahYVel5Qy7oQwy7TBbQV6SnPjgN
	 lomEGdkhhzUEPkR1F9ewTExuHbuO1kHMyCCKPkvaweaLzZTtXvWzUBeHawKZugkAPpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599563;
	bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wGQeVliuJKun9bQckdWIzz8Sg6cK9iPlX6pCU3qZhHhNbPJ9+W3/FApQTCTKyn1EY
	 +fhHVp2R2nofFD1F9SUFE2FzRUSHqlrDFe1FMQfI1fDFNYDM6wlYVl8omSPW8eCMnu
	 goD7AWoN72hx7EVuvuIpelFFMROZi7446utw8CobIReEkYZooPcVBq06LYWMxQrED7
	 m5ApbGH5xXObjRWC2X8Gr9OeAQLRh32Ml+FUN1JMEz6SFIjstcJyRqJhepxKhNNf4l
	 cG32jqmqzm6RcvkpJ3dIH16630rDJAWfxiMkWpiU+qmIiIJmol4A/WBMEwBLg/n9kC
	 nyXGRsxPChDpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A35D660DB9;
	Wed, 21 Oct 2026 16:19:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E563356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24E664039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4iuY4GXnMQJv for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E1B4840077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599561;
 b=X7L6vJT5+6jeY8Lc/wPeESpkV2MuV1ybw1VMPUGAIiiampGSLwAmOofNFdPR85vqhvNY
 SA7h52A1IsPxGG+GOfm8XRgCjmnxsiHjefg1nM02RxXDZV2k5Tg6SOfNOSTBnJpQYtQbd
 0RWaL2dVjBd18ih5WMQMwvTd2gWXqtwO3m2g+aGQrsa3ByGiWov77612HENFLF218U3+5
 CpZNq5ktTlBW8GbVGNxuQqBCjSm0eQuS2J8vKJ4goy762sGcHBcZoEvzwrYLHjitM80Zr
 yTwYZ7HIgfEb7iIGmTelZmvGjDq2adgMiLbSGgH5SUtP5AVGc/AuF4xgbuSlUmNJXpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599561;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=OZGsQuU8CBsXpP+uBSkBKb7gKZQnNJ/WBmkImu0+OyH+S3M3gYHmzCyk8GWEtTJAiGqW
 GCKJsD+dIXd4gLNIXgyiaFFFYpDAO2rUnjmjRSxO1ZGGYE+VcEQ05k4dSdYtuW5yB5IX9
 sxTDUgvxLlJpIR7b7fmOtkoHqk3b+9MiLEPM/QkTla0P9LJUoUoWYA/DD0N6YC2tkPXbX
 n4Q/YO44DMusvyhWbPL2K9PsUxmUq4Vbkay9VkhGlWUFqkw/uC3pev/RdyEejIGKLwG0R
 eWdCsHPyue55YiRuIexx1dtzNdrhDh68L3d9+yxOZ8g/xWNMO1a791NqOUbExuyOdVA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MImKJOnz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C90wOGGv; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MImKJOnz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C90wOGGv
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1B4840077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG3P0T900379
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=; b=MImKJOnzc9dJpTBX
 QkS+bk3kZGKFa+M4NNLwV3Q5aw7XwxZwabBocCw3w9KBYjhLkuXorj2mvon6GH9G
 YLgG9sK99KhLIdTwlIqm4MlVcNfM7lquN5gcE8yeCU++CncY2T+gS+jFOJyD6mSO
 eArMaTmpy4EeHdZvPjQCsX9+f9i0aVwLVSXIkMj4VNqppg83cj+mBEtdBEwMAeVw
 bUD78RgHskVG17u100QnlKd8KEFq7bLYsA1OJlZ5BDtJwk9/to/d87imiAGaJZko
 Dtc0OkTiSstq8Cxu818PAVP7zVSIluBuEtdmjQIp5RoTGw5y+9/xt/EGy1GdGFMs
 3bwtZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2g2k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so1549574eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599557; x=1793204357;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=C90wOGGvQ2tNE8e2cYId7ZBKICvAwgIYyXJOsHaw7PJABzn0eVFo7mNI5AiRgqdpwr
 fFzW0NFCohZwm6D8FVPfxpWLT46PF33SkheaqlAwXCjueXgGJ+XA8Dnu24/NzFVVYtdW
 VN19ZmNRwxXvWo3bz2LpTJ0pkpyh5f+ZIP3k0PuqrY1o3lMaIrQ2RuZwE5GwFfCOaYuO
 CKdFeN65eqL3ASyaGL7klfmwZKugeLZ7kxPy67DXkxBRth6x8Ge8hhBdrk4jrsIByC+9
 awUrr4krF7YntXnlvkG90sk7nW6h4/At8Cm17JneWf5Nx+WQFyHVZZaHfxTfocB8Wn7G
 NmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599557; x=1793204357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=TJtpNaXZjRdBeimMwSj870BvZzlHRzNONQokt+HF+UAc5PrTbTKmlevpzRQmyRotbk
 fOYYVdHXlJE/Eqc4mx4D1yg80FBubTEjihUyGh6swGSmj52Po8mgeQiVwb/Fz+Qw4Laq
 wSVq6ASIrT0dERoREzn39Alvowu9tgQG4GV3bxH1rQzq2rkpg/mFYApOuO643u+guva2
 jaruCYXzg6+67D0F6ujQmxI4S6HGSYMyn1TpagZzQknF1Y3nediX0MHqrUgUx7RSA98Y
 DQmbeumVXl65P3nJslCQfUfivj7b+uPNAdBwSs+VGrxjQwJeCqowx4hcfq3JWPlEw3kh
 EPiA==
X-Gm-Message-State: AFq9FYKPO1dt5g3Yp7om1avau3rMQYieDVYcW84p9viqW2woeIMqBIyR
 FQzYhZqR51vPsK+twhlP5P40cLxnTotbcEftR+pAMnEjsIZ1FoB0tPsPW43EifssjAue9z6CMo9
 CaMkl74BZVJSxwlh5CeQUQfVbxbHnpQK1Ss8FCGOEUCzQwjicPPBhPr5x25Pp5fAguraFTig=
X-Gm-Gg: AYBFou07/pAENq6uPdHmgbq51Jy1lBuLdrfqLK5gcocGcwDrx29GxKyI/eT4NQPmXqS
 Zf3SQjWueD36Ru/HC4/0dr+cys83IGLvjTpmSFC9Bl+7amMfbM+eW7RNMtlv+AJfZGByGICEHcg
 1kf6bHaXipwI9MPof7puZZJOqmkEjHyobJLej5+/N4cmjutCqsYAuEd3bNU+FXjtiQOq4qaRvTT
 we/Mj5nGjv/dRXi06MGaEcGc43XVN3LyIC3eEMkd7I9fSQUWes3aXg2uj9RtBE9W5SaCoZTxWkT
 fqJmLGhCFe5UQhWQOSist+XiGt+9BZa/cn1+6IKB8+PdEExaGcNXwFePWyzGrXCKPzELcM6yuzN
 ItwiDvrHbxnkYHc7rEZFAZ6uMDmF8WlEU2FvwDtUB8cALa88G17h54W/5XzLk3Qd7xIx+IxaW5R
 6QFCkyZqb9EpFQZl2NRFrfVMuxvNw=
X-Received: by 2002:a05:693c:638d:10b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3675201400emr3357691eec.30.1792599556994; 
 Wed, 21 Oct 2026 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:10b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3675201400emr3357638eec.30.1792599556171; 
 Wed, 21 Oct 2026 09:19:16 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:19:15 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:27 +0530
Subject: [PATCH v9 8/8] doc: qualcomm: Add snagboot mode documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=4408;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=NSFKMTa3RgbxoHyOYasPS7O1VEhmTRChjKRoMhsGyzk=;
 b=Obj6weBUmPfYBM3nBDGtj85MXxhAzrSFHEPaHOgQs2nBWlqJBMmm25zDoIQv0nL3YlsE/RQkK
 KZX+Y+dXJsaArU76+Cu4DrUxakEEF+xb02xf/91B1xyf4GqzdSFQiUN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfXyhYAbAKFG6Rn
 PxfvP34Tur16Ah5hqWPhtsaNnOIdTifQN3wm7ojUBNIH6vMseKf330wUMb3RC4JUFk+DnPrUduk
 wYRFu/sZUI2TxYkykpHFtW/jlRYdey4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX0clz3l8n1+vx
 nPpA8lrGYQPCZSXiwcU2HpKJAP7JJFxWogXByzkPiY4i7eMZCPt6MPm2u0HizkZKpMzbMhr0XKV
 LzF5Msi2lKIVOj8d9Q+LksjmveyrWd30ZJwFJ9H/oAx2lBI8rWIQwyL4kgow8MG4+sXHR1Lq/jI
 OoxLgfF7H+hXmfKA05bmunaY0vy6ac6MSiIetAV9QTT8yZVBy5Mqoub+r+t0ae61Dh/MPDuxlit
 Vor2FPCqoH2qfdxEINiufWwWYaOm0GCyagAjT2Q9VBN+dhCzetTXH1jDWIeBCajHZo7CyA8cjJT
 ZG1LrsQ/7j6q/2ocwlEk21qHLNKQDwbtk7m8/9oZWCIvJe/tspykCF4VviK3r57fw5IjRY+AyBj
 oPsBGmh16ZrxCelwcWHDW9IWXMPpVTAYV6rTRG6QxdcnRVqF77BlRlqrhsPYvHg5qkeXGyL1LSk
 uQrbxRplhPEcTl/QPog==
X-Proofpoint-ORIG-GUID: Lda-6uqa_1GSXYwnsZLRtVGni1JHJ7eh
X-Proofpoint-GUID: Lda-6uqa_1GSXYwnsZLRtVGni1JHJ7eh
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad8e606 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=-mjFUTYrJJ_n1noAqFUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document how to build and sign U-Boot for snagboot mode on Qualcomm
platforms, using Lemans-EVK as the example, and how to add a snagboot
defconfig for another board using the qcom-snagboot.config fragment.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v8:
- Point to the upstream Snagboot docs instead of describing the tool
- Drop the "Why Snagboot?", architecture and EDL+Firehose comparison
  sections
- Move the build and signing steps ahead of board enablement
- Drop the list of Kconfig options selected/forbidden by
  QCOM_SNAGBOOT_MODE and the Lemans-EVK example section
- Replace the signing prerequisites list with commands to fetch
  swiv_build_utility.py and qtestsign
- Drop the "Expected result" and "Output" blocks

Changes in v7:
- Rebased on top of latest file

Changes in v5:
- Added build steps for U-Boot in Snagboot mode

Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |  1 +
 doc/board/qualcomm/snagboot.rst | 80 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..b8bc37bb384 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,4 @@ Qualcomm
    rdp
    signing
    spl
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..716d88b2ba2
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+=====================================
+
+`Snagboot`_ is a recovery and reflashing tool that can download a
+bootloader to a device in its boot ROM recovery mode and then flash
+images to it. On Qualcomm SoCs, snagrecover uses the Sahara protocol in
+EDL mode to load XBL, which initializes DDR, and then loads U-Boot into
+DDR. U-Boot enters fastboot mode and snagflash uses fastboot to flash
+the system images. See the `Snagboot documentation`_ for how to use
+the host tools.
+
+U-Boot built in snagboot mode runs directly from the address XBL loads
+it to. It must cope with the MMU left enabled by XBL, and it cannot
+rely on PSCI firmware or Command DB being set up.
+
+Currently supported platforms:
+
+* Lemans-EVK (``qcom_lemans_snagboot_defconfig``)
+
+.. _Snagboot: https://github.com/bootlin/snagboot
+.. _Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+
+Building
+--------
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
+the Lemans EVK platform::
+
+    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+    $ make O=.output qcom_lemans_snagboot_defconfig
+    $ make -j8 O=.output
+
+Additional tooling
+^^^^^^^^^^^^^^^^^^
+
+In order to generate a working image, ``swiv_build_utility.py`` and
+``qtestsign`` are needed::
+
+    $ git clone https://github.com/qualcomm-linux/boot-firmware-ci
+    $ export SWIV_BUILD="$PWD/boot-firmware-ci/tools/swiv_build_utility.py"
+    $ git clone https://github.com/msm8916-mainline/qtestsign
+    $ export QTESTSIGN="$PWD/qtestsign/qtestsign.py"
+
+``qtestsign`` requires Python 3.7+ and the ``cryptography`` module, which
+can be installed with ``pip install ./qtestsign``.
+
+Signing
+^^^^^^^
+
+Add the SWIV segment required for TZ-based signing::
+
+    $ python3 "$SWIV_BUILD" .output/u-boot-swiv.elf .output/u-boot.elf lemans
+
+Then sign the resulting ELF with test keys::
+
+    $ python3 "$QTESTSIGN" -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
+
+This generates the final ``.output/u-boot.mbn`` binary, that can then be
+used with snagboot.
+
+Board Enablement
+----------------
+
+Common snagboot settings live in the ``configs/qcom-snagboot.config``
+fragment. A platform-specific snagboot defconfig includes it on top of
+``qcom_defconfig`` and sets the platform values::
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Address where XBL loads U-Boot
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000

-- 
2.34.1

