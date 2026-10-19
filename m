Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DEBCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4ACD40808;
	Mon, 19 Oct 2026 10:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDoZp72JBvP0; Mon, 19 Oct 2026 10:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2891540779
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407281;
	b=RCnd6KQCvPeCh3chiFG15J+ej1PSnY9nPNqjteNrVV1b5UVV0mAoKR2cdb1gk4xiBLGD
	 ANrvYHAUvyUPeNX1Rt7d7TynqWI6iE+gRE2qDWG4+9k41MP3Os1U2YpsqM1U6BiS0eDrT
	 yoKwZOB/QlZ0CDXDlNd4RVGuaFqTfqV5cAFnl+VuHNu3alLZksIYYEKhoXC+8MmKQt4r7
	 fSh67R7XQS5Y17r/ReeiDv1O+XNzruc0IQ5rBTsomg5VgAi3X9eAfDN+nJBBSRVhdSLCQ
	 8JICGngNIji/Rt+wk7sfZ5z7FVK/0cxjmUdD3wdmiRQscBjjxxB/E1J8R7f6azD5cmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407281;
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
	bh=CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=;
	b=AF24y6cNmqGDHQcuHIk1qhqf0xOox/Wq6tuU63DxuNrcXoN4ZEphP4/QvFjvF1PSUTvc
	 Pd33Nww+nNNVvP2kbCqDdtvZhKIEnCO3yxbCPLI7hX4ICBJEOyznRpTcPEd/nBNlkPR5u
	 Eh2XrpnRcjnWV3W4mLyOOcuuDaV8otuMmUsbldhlRJRkt1g5CrwMqfxFw2e1d7H4r5yVY
	 KnNWY6bKP/a9kEQcAYuWtjkHAFAfk6lhFWdqJpS0xd4qAnYTmk5l+wL9S0qMfSfpN1Q7W
	 MMSoIZX/0AgqdBAX7YbXlYKZyNuBkmWw0YzQHZ+VCExV5RVEmDoV9AocE4cGzKUIPRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407281;
	bh=CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXqXDcXUj7Zov1vI3zbw8Q3BXpCH0dm9ejb0WCdpFhYMeJtng1lPZ+wRaAm8SOZG5
	 RiywVSmf2FgtWZrxTbOqCobqEM9xbWzRtoniHn45k6KgPV2L+5hkPl6jusL2y8TV5/
	 dA9CAvmesKhUJ2mltVoiYv1NamWuQQhlaS1kwU/Y3Z60/2UDh2L8Y7/O4pBTLjfRbd
	 Kz61MrOu/T8z118RfAaFrMBSLUzmNB3lt7o3JdT7QbO1gDo8q77WZVW0FtQ1oBAsA3
	 HA00Lt/sdv1SY3yf6yvGk5V/zJnaRnp2cDqvR4Mr01TX6klOybUrK/KOASOV2yAnKy
	 XeRopTVlrCxuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2891540779;
	Mon, 19 Oct 2026 10:54:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C24A1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D9A281082
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_pX3KdVIZ2m for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A446C81080
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407278;
 b=hL55DKUI2pwSJdqnaIY/g40tNOpTEiv5IARBX0sSizX6ZPvzx2bKfpNET7XTLKn13tfd
 OObG1FxlvaJs0zw0evVKKi8z3n5a3gjC2i33TffTAc/zKV7tkRlqW3ubHNlOtiWixVpi0
 h7x3IbqZ5PfQt1DFikRnnpnSOk/RaYPKI4JX6gy/8hO3oPN1hsjVRvy4Xgp1dYG8cwgeC
 x6FFVoW2bSWtnUFFIeROc9Szo3L0k+H5AU8VKtyaQjEt9K+UneeBR/0x4Codq64yQMiQF
 xB0HVsVBx9g2dt0VdG+iZc1qfN3FgDhjqYZhMP/Gk2bowUilSnJS22z4y1vmoYRrWcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407278;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=;
 b=Lp1SW/2R1Eq1Bxh1mZFj/dGhfBrP67m9RTOVSXuZEjPqjJSK4IcosfB8EX0bExwEcbEM
 KI5jLwxrkC0t+/OoxkZ7pPHCF8Qqej7ETWGmPhhflsfsgT7pY5ljBYUKf8r+7Zl0JW1Hu
 wUjifFn1SJ+/D6UvK5o/Ca2c+lJgMuBR2hIDnyqjblmGNEviDQMBAD3zISHVZkjakY4di
 E+l6nSV7QAWQwkAnilskQhyHztkGn/WVgqkG25zztBEVBaSJMeJojdRisBKrwbLTBEZUl
 vARDbe3rYo8Jbt0WWqNMkRoq6nZmruyH6anL54TnGNXQpQiPNZHen7l/LAXLrTspldg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=acLP5M8P; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VzrsZdWA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=acLP5M8P; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VzrsZdWA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A446C81080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8YrgX2688933
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=; b=acLP5M8PCA/XvUKM
 8n7pN8pScNKrddESNXMIiEadtJBjbY8rBZk/wUURU7M+tXTMJsi4zTCFgidJq/B2
 b0X66BvNH5XyZGHZ6dzZybLQNv3X8Wq1WyeUy30AeuofaTkdo7D3ZgL8CTdoACn7
 u1w0DVbJcSV6CkM02tW1qWXUrriDrIeREeA9tEg7ydnIcc24+G3zXqo0n34jrv/H
 exkNRg/lKMgiagV6nPc+Oz/EDMsLOjTtNINP+dce4kaRaGm2wYdqk+gh4iyrKjhk
 Wblc/TZ6jYV1rcZcLa1fRDwPjVO6W9IRY05wLZa2oo+7hICQvFP5k/Z+uxOz7+iZ
 ROgtkQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn0h4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4271431eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407276; x=1793012076;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=;
 b=VzrsZdWAWhRkV9rj5wpt/6x/2E3cB7UDyfHkA+KuEQMyqoqUeQoVNqzlnNGvqf1bJT
 QYCejd0j7fr2PVS3zm+W+tzChfhC9MGrFmsfXFueWf+E+pkBS9783iM4jm+VC5ZEY16l
 HFD91ILJ5HLq9h2HFg9jWstL7/ZDgln8+pAVi9fpYQlMdkGbYSb+Z4+rdFqZlDxGxvkR
 L4abZ/mzDUXkmomPPvz8PjaY8xVOvwIg4MMVowYLFfvBSe/RmugzIj1ZSx2+MCUYMae/
 /mxZ6q6lYaPhrLbhNO/kgm8Ft6nDMUX5/9IX3wqHdUhNtb9gCLLi8kH/Ti9sHRhw1Y4W
 DEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407276; x=1793012076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCxuv6tCvuN+ly1xDuFdJhmOGcxQaq9RidxSKolBkTE=;
 b=zWbsKIWrajNX9GKUSfjwYARyLNljMiRN2GnPdsmmY6QJvMAkW5FQCEzWcpt+zKXsiD
 NxAvAX93+O6xTFbbuOyRQas08MevkdweKB7iitcP+fKjw97UZMaHVcbnAFdXqEAVrA0e
 C2AEoualZywcFDJaCKSjkbKpLYyANSccwKzH3VnD3kB9JcdtAzh3mEc+4phFs6dBJ8jg
 HG4VdwThzl54gMOGQHb5OEW6TF5UZ+36+VSn4RWQOndfuWBtTmybiNvhSFXXxaavfqfz
 jvVk2ncP7uESORHIP3LPdWT8/u6ZtugT8xIrrf1SN/gRXouairW0I7NSOBRI4mzH1s9h
 RXhw==
X-Gm-Message-State: AFq9FYLs5G/+rU/1F4G0tX9eiqkNBcX9uryEot60xHSOcP8MNHG7GjMO
 w8gROBwkzIkOtNC1KF/Np1pFnUjJwpbsb1DYvVY+MH9fp4icJfJ8d49UTYs8NMlvaAEIb5uS2PJ
 bByPnFJDfvghiiVuobjC+bCmap9bkYbIPa98JbWp+MXyQV4XfqDHWTioTwtdO0BBQN9n8mSs=
X-Gm-Gg: AYBFou26of9yECrN9ET1s4aGAjVweLolhQQbhYmih51aDCpkYPU2q0YPgQwh0JK9lQh
 0gBkcDiaQoeTrrvZs6SA8luCs34U8QSc2qy/NJwa3f02EsVjucYVhng9R2u+3J3WDL7QV43s/gQ
 dArt0/eCXxFCQZ9X6HLjyUxLYXhvb7cLh5eZ0ebWkRy/DHqdnUsjo5tWCKYctYsU0el0ahckIvg
 vJTZ41CtSUAoh5Qx2htfRFLfu8DlQbsS+tSzMRvme0rFv1TtCYax+YLjZhud4YejJanmzzUPPwW
 sYKxa+c1MOnxPPrTJnvpW3rQV1DcMQ5dSmYY1L/WLIX3pdd4cw/wo9ogX0cKqxmW5NjlUwugsyV
 1iD4/4zFEznUdrImCFwt2CErPd/InZuKj7CVreZNJyMuqUqIPR8wnGMcWDn4RsGMNWjpwZ+xa96
 UPmiq7e5Nh05YCkfgH1rxPhVCDpBgy
X-Received: by 2002:a05:693c:39c4:b0:35e:cfe7:4c5e with SMTP id
 5a478bee46e88-361a284a463mr10864347eec.41.1792407276319; 
 Mon, 19 Oct 2026 03:54:36 -0700 (PDT)
X-Received: by 2002:a05:693c:39c4:b0:35e:cfe7:4c5e with SMTP id
 5a478bee46e88-361a284a463mr10864319eec.41.1792407275832; 
 Mon, 19 Oct 2026 03:54:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:24:00 +0530
Subject: [PATCH 6/6] drivers: misc: add $(PHASE_) for QCOM_SPMI_SDAM config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-6-2d8f7a1e6730@oss.qualcomm.com>
References: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
In-Reply-To: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=882;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=PDD6CYIX17MtvbBF5ZO3IcAkFwrIGYizr/cDbi7Y/rk=;
 b=509x+TpCQGD67DLVEXC6dXBYKiQ2r59GIxvCcKYV/1vEHpJIQE/8gv9YhSYzGPLsIutPYc40c
 D2nHPne7hKQBxJzGQgGCfbZAI9xe5mNxVt6dchLgj96+j/q5E6oyort
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXyfcy0oSA/Lj5
 id6keF05nFfh83FO/ZnbKLGApUWw0zCQby6PiKWK5pzZNE+Gr7ZcFIyMFMkhyowufmuIKbTe0P0
 BOa3OS3zldVRzfg8AkbaHBqhYaQ276Y=
X-Proofpoint-GUID: e5dvrUcE_xXIKdL4tlkRoI7hOKier9Tp
X-Proofpoint-ORIG-GUID: e5dvrUcE_xXIKdL4tlkRoI7hOKier9Tp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXxVNcmY147OQg
 4aBOv3mPYEso6mJ7/y4osZBtPfXtpp3piTt46+iX4yRkUVNsGac/0ChF2nMvZHuezWo8ffDvE6E
 VS1AutKM9/C8b/Rj6OTKhLHbuCb233Q2/FbBTQuFb7bpBAjTm5S3ajy/HoK0I6whsj9RGyId7EV
 rnaRlCdMtxMMn+ZtgKdmvGHXXUGLKmR4r3CDmN1i38n675+OMdDT3EMVhHF44Aeodgnid5YbKOb
 sJYw5L5arIJkAfx+AiuhjP1gLL2bPZ5AcU/akODYQ5EgKocTmMbTd4eL6CVMMpHBVnuagqqlRNs
 QJHC8KFshsXZbGpAjaOr+NzXmNVVd3sXZlE1qf7DictLU4kCf76GhrKKfPoU7cVXltS7MuslFiw
 sMHmZO5WIK/Agc3Gnku3StITd/OYULemsZlAYP3sFbnS7vdwVAemcEVjfwrsbTUdEJtO735+8iA
 j2Oa/GLN6LPl7Yu3NjQ==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad5f6ed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LphRSaEvr-m7H0wBB18A:9 a=QEXdDO2ut3YA:10
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

Add $(PHASE_) for QCOM_SPMI_SDAM config to differentiate between
SPL and Proper build stages.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/misc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 837d73ad23f..6438a9ce6fb 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_$(PHASE_)QCOM_GENI) += qcom_geni.o
-obj-$(CONFIG_QCOM_SPMI_SDAM) += qcom-spmi-sdam.o
+obj-$(CONFIG_$(PHASE_)QCOM_SPMI_SDAM) += qcom-spmi-sdam.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o

-- 
2.34.1

