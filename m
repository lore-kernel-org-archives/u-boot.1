Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A9606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MmMByebu;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdXqsWMf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xqlu7aUC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 077DA607CB;
	Wed, 21 Oct 2026 06:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8arGzf0caAd; Wed, 21 Oct 2026 06:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D2126078A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565015;
	b=mRLn+AhmdUCby0rg5qxF0dLe+9xUXpaQ7aXtTYB5mg8syf1I9BdQlXDE5i3siD7LqL+A
	 lANaP56V8jJR1f8EzxAwcMk7qMrfN8HZ6t/3skW7u+iVCxas1bYYV/Gom+q4ZFKqYqhEN
	 j8dFiSaFiIhJ1TcZg64+nPnOq8toy80ywRVx9fqqEaNpK4GBsFlqIPMBDtMouXX9B2SCm
	 qjNgGKq0bdEsmnRJejAevG8VQ+4nKgPh/jGWpbGNz1S23SbpC/JPEP8UsrHMzzviElpD4
	 KaK/b0Icsc3jkAh2tVhLrSLnz0wYsTtvLs05MO4HAEaAgdstrh9qozkynbkdvPsgVCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=;
	b=V151qFF+rxb7f11REw7WX3ncm/xYnrzSp3n9fokR/PGZjTkLGc3zPVdgIJzxoBTRveor
	 P4+lFk14CGsxWUt//X4Ow3NRQ4LMEry8ykLGJmfBK/l91P1T1SK+PJdEYjn1PVpEcUzGD
	 MsdyUU88mw7v+HtBKQdKfP8Y/PJkLgAL1cMiFdkmo3SYFyIH+9l++RfFGA2xqmL0vTCrG
	 p/H3Zy0XwPEoMnSJGQBxrkd2BmY0M8+Ez08bJtxmaSJv3EzI8cJJGLgcRgnIS6KpCNRQ9
	 hnLg6yy0hSaqXAZQbfWmQiS6ElCHhbV/Mj+iXGpDtoZnRRZudEJfjyrZvG9zHSsrT4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdXqsWMf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xqlu7aUC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565015;
	bh=whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MmMByebu7+qhH+3vqTOv8mD1PhECtFFugTn5mZPeorb7u31quAqzyoDpCYYihOUkW
	 24F9pL7s/fCbBH4a2PIZqt8AYld/8J1FS9MThEEZsEXNfKXSpOEgb2/EUqtF0V1c91
	 qMUG9quA9Wf99QRmffkm96JnrfYsIQHfy4bCxZk+YAqFBNApH4sgs+XsLTCj595pWk
	 UGDGTko4gVxGLz0U188j0WJ/JIS6YhaT24dgiAukur7LuwrC3JbI0RGqQuwsqAjodz
	 yj+4+GE+JzfLqQGbpT4WrAWsMThUylziyH5Y+2ZAGyMIFWutdS/c43IrgNr6UU1n8U
	 Lqs0nkax5xQng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D2126078A;
	Wed, 21 Oct 2026 06:43:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77BE73A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D7D36078A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqMCt5NQa8ez for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0E46606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565011;
 b=cO1Py+GZqI12McpJzAS6c+cdNceNJdh01a7ZhIDpMBNSdXG8Sq2HSPWG0LkSUKEiexmM
 C7BPSOVBrXzh7uLYpimilVCqbeO3GeBRFnpUhnnLzjRwUir0PlGkf9U2qOGe/7IGi/cBh
 P/hIUU8znC3mJoYwnFpHIBO82qiC5bYcpWXvwfWtXKvITHXK5oqSTS6IZrHoWKKfDJnTk
 urqkW8t6pasB6skIk06P+/8qjJzT/xYdd3H1s1J3bbw0pIiecb8EY5BLlHGNSHawTyBhM
 ydIobOHOPTDL/f58cV9G6RPDlOjPfxVnr/pt0wIDQs33Fg4bBmrxdOq+G5scJBzlK7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565011;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=;
 b=rPiXXPlgZBAc3EJJlLNJOaw1ngXj1PYoYLaweZ5K+thRtAL1JJVZM/YIGjd5S1C8kg6i
 qqHa5Hk6X1wgm+i1LnkvfNbfqDhjfeubudEgOJkgyrJjijuhoTXYJJdheNTUjh4KqQbK2
 qsmY/ilis0SeLnWzveMw2+weaaW8k2BTi14KiTuR6LnrhuMltUr51yYoKIhO+SGRdNucq
 g/Q+k+f+N8PaddpIUHSgvxNd4vQhmsEjQoxSeIcObLHwbsO6ilcbvCmK99CeDdCJbPAoN
 EkJRhDL9ldiMQNpi6n0nPQD5amrxJtUDc4hRHoieYsXnTlpT8ZZqAIprywh+CwSu+Bg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bdXqsWMf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Xqlu7aUC; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdXqsWMf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Xqlu7aUC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0E46606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j5qN3018875
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=; b=bdXqsWMfm7sc/D0K
 8+/fDBV94frm0MRtUexuJ3dCHvli6kIThDiLbOVyskLHOqVWfZjQuopEYCJPlCTt
 Bp0pfnkXoprI6rEGPI90AvsIO2fLaIhR3qO3ZNoyGm/wJy3e7oO0ixNC8Z1yEkv7
 R0G3/aWN1vSRlOp3NC1QaaHkCCLDedJAwH/82ngRfDVJ2UwnBlB9NDGamaIuzKt4
 55AYR7A8B1SO3cR3WryVGJSU8rdjK3e87fmKCI2p04qdAl5Lg4IvokRy6SUkAR9L
 ommnVSF7/xqPrlMmDddG8l/tiNgozfkoeV5/RZNEcSuhQ7QxC3kmkSyeQsKQTAON
 95YXUg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd2s1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so1007048eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565010; x=1793169810;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=;
 b=Xqlu7aUCHQnr89fmh36ePBGUPLC5Pp9JYrJmBemPufh1Vx+NFpHVREB6gKFneA4zDx
 h2Iqy3eelipG3Qz4cvnKbVfaFbi6FX4chl+eufVdaZE+5PSFU+nkjSCrKizLlLakyHjL
 OTL8Rwan9FKjfUQM7E3x/NtyxEc24K+YvKBte8eqyGxiwGk0Ycme85ms7MpO44tMuqJC
 sxGLR6zTWxPOx361Gz51ksJIuwcbc4g94EmCRP6H+oXZdwbLP0Etj2p9GFrirCrAVHWR
 56r5+15OHr6jAWb0UKNiiECkGlAAEjDZAfPPstYNaCi67dJCMn29xTxVF779EsvE1jCn
 cRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565010; x=1793169810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whETN+9KKv1oGsG1VRl6/6I+rwgSW4sSh3o4F8j3IKM=;
 b=BGmdDh8DrQH8rmQdoYBrOTl0nwxFtVlwzhCIAOXOi7dUesqCFcu3C6/s8Ug5KWo0/q
 hISjpmCDmhO+E22RgDgYRw6jjcltYViNc0rLIHZF2mWOSYzqfv7DWVwZnhwfZAYHm2W3
 iigGfflDDSAFyRkFugDQrKio7aWQHo2abg6expkLCnwGeGQ4JVCLDfsg+OleMTCABWH+
 k6AwWYTM4ew+tlGjyXCAdlxzSkQCc7UvSG7BvR8wpV3hgfFCLKZmW5/j7ByUhTJ6+Z/r
 tBHzaXySqZd57ZbKYAV8AEhaLeUuSkgvz8FpSwrOvCAHPcfTXsqmGI1x1bNFjUSubQZN
 OcYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgaJE/0AhHoLNkaIWaMRWmOQ3Q+uSjcDlL3xCUXVu/BTsf34mfsWV8kBaEdZZYo3g5Y4hm+Mg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIhJnGYgPdLkpg6683voX+rbfwe+L5i6TEjheX3ODxJlLueiIq0
 pQdrLHIPBPIUCluxrk2j/+DmoG3WXzeM/10+A3HsF4mjEVcWuMWuulUd3FZBd8nVCxco4ldqiJU
 3scgKU3vAz5YB4J3CiGi83j57R598VT+JsV/Elu+entHX3noSFLdRx32qd6bliTXSb5Gas/s=
X-Gm-Gg: AYBFou2Pa6g20QSAv2KG4aQBeKgvsfpqsUl9G/hxtEJyM4f8+N9drsxQDo3j7no5m0W
 loxzByx7uw5nzCWcYArPq0922TjcTPmtqp3WsQr69ycPrpQA2qtU/KV3F7ypscRb7Y4t/XMDpFu
 /62iLSDHKI9g0Dh8UO3yY0qAju3+Z0yePGCsae5rKvFJZwkE91evpX46LJ/PGwEN1/6NWeYyCPp
 eE6CFae2hEewRYIFRdn9OyOfA4HgAU51ktSzWUE+LBvd7bI0f4HXIfPOArbN7IgDfDXQ4D5pxWV
 bFx/QcLF6QaQ9DL9NTlxSg3pYTBoZ69ACP2ByrQgL0JKZUkLGVxFHs0vys1zL2r3mgcMO2MrnXe
 tdoMSYQXTN2JX0Z61garXz4CXUyeWV2f4gBAAAClL52UgkrJ5bOg3cmqSktezGC4DYMwLUj2M0X
 imvtvIT4rmCiMXfPUwntojReOZ0QZn
X-Received: by 2002:a05:7301:624a:b0:35c:fc90:f6f8 with SMTP id
 5a478bee46e88-3674eb319bfmr2885616eec.33.1792565009696; 
 Tue, 20 Oct 2026 23:43:29 -0700 (PDT)
X-Received: by 2002:a05:7301:624a:b0:35c:fc90:f6f8 with SMTP id
 5a478bee46e88-3674eb319bfmr2885536eec.33.1792565008701; 
 Tue, 20 Oct 2026 23:43:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:13:11 +0530
Subject: [PATCH v4 2/5] clk: qcom: qcs8300: Extend GCC clock driver to full
 gate/RCG coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-monaco-v4-2-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=27756;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=HpHuB0PTnOBFo9opbURrdvzGWk3iCf3sRifrcVC0rVs=;
 b=nftq7WnVX0h/v5IysKxOYVMVoafDNGDzitSXWiW+235mrTC1jXg4WNnkH+wNbx+PXrcH5hhDN
 AtD2t12fl5ZBgnk9zNr1/vXf7sJfE+9dtNhQks2PxN5Vkrn7fhEo3se
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfXw2ckgwxo5hnx
 VveBbladj8mgM/FLfdf7AvP2Cmrb2Trf3RnUgEQ8fvwj9plqic5ara2p3LkDRU7GdlxfUextpAa
 MZ5MHyKzNtG3qQPOJqpGvCvkN7nfZgLgapqvNZo7x3Ej8LqGodMfuVch29L7tkiaAR9QzHy5bFO
 /MGrvEfJoXdlT3/UEQyGy96RzcP1mUzNJTn2B4+CGdXlqrSaD3AqrqO0t56LE37scGwnaQVNUkC
 IiElT7kON9iFmGpU1vjs7cE2h7b4ARJLemVwCwaQYSJv2hSSpBFdU5Ha3AiNscbnF+JkRtATHw9
 wn3On+0E4J5uUiUGUTcc0Y12ys9blMUH2ZdFj8VwZI1U/dij6aytBhM85NS/EgI5jTZUACH7PxA
 6IO464ducoysyGoU7XUx0W0f5MXHVnJZIme94tQ/qWkONkUMxhkgIZMtmfXHPpGsXrDSBLWsY4M
 w9+3oyAydPeWupH0HwQ==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad85f12 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8KRvGpLnRcE-MBQpGOYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: q5btPa3Dmue4mg72QFhcger87vnnDD6I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX2eajr/49uiW/
 PIPzBvjB6Sv5e/bctn5uSEYFKjFQD1PH2a0mFgmNDhX/XHalM5vQo67zPvP5ZKtxCg/Gv2IYdEJ
 nUq0vRl1BqtVG16PMx7oiz4ESuNM4O0=
X-Proofpoint-GUID: q5btPa3Dmue4mg72QFhcger87vnnDD6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210026
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

Extend the QCS8300 GCC driver with the remaining RCGs (USB2/USB3,
UFS PHY, SDCC1, QUPv3 wrap0/wrap1/wrap3 SE clocks, GP1-5, PDM2,
EMAC0, PCIe0/1) and their gate clocks.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs8300.c | 545 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 525 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf788..cd47b384f1f 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -14,12 +14,210 @@
 #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
 #include "clock-qcom.h"
 
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define USB20_MASTER_CLK_CMD_RCGR		0x1c028
+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0x1c040
+
+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
+
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+#define SDCC1_ICE_CORE_CLK_CMD_RCGR		0x2002c
+
+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR		0x23154
+#define QUPV3_WRAP0_S1_CLK_CMD_RCGR		0x23288
+#define QUPV3_WRAP0_S2_CLK_CMD_RCGR		0x233bc
+#define QUPV3_WRAP0_S3_CLK_CMD_RCGR		0x234f0
+#define QUPV3_WRAP0_S4_CLK_CMD_RCGR		0x23624
+#define QUPV3_WRAP0_S5_CLK_CMD_RCGR		0x23758
+#define QUPV3_WRAP0_S6_CLK_CMD_RCGR		0x2388c
+#define QUPV3_WRAP0_S7_CLK_CMD_RCGR		0x239c0
+#define QUPV3_WRAP1_S0_CLK_CMD_RCGR		0x24154
+#define QUPV3_WRAP1_S1_CLK_CMD_RCGR		0x24288
+#define QUPV3_WRAP1_S2_CLK_CMD_RCGR		0x243bc
+#define QUPV3_WRAP1_S3_CLK_CMD_RCGR		0x244f0
+#define QUPV3_WRAP1_S4_CLK_CMD_RCGR		0x24624
+#define QUPV3_WRAP1_S5_CLK_CMD_RCGR		0x24758
+#define QUPV3_WRAP1_S6_CLK_CMD_RCGR		0x2488c
+#define QUPV3_WRAP1_S7_CLK_CMD_RCGR		0x249c0
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4158
+
+#define GP1_CLK_CMD_RCGR			0x70004
+#define GP2_CLK_CMD_RCGR			0x71004
+#define GP3_CLK_CMD_RCGR			0x62004
+#define GP4_CLK_CMD_RCGR			0x1e004
+#define GP5_CLK_CMD_RCGR			0x1f004
+
+#define PDM2_CLK_CMD_RCGR			0x3f010
+
+#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
+#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
+#define EMAC0_RGMII_CLK_CMD_RCGR		0xb6048
+
+#define PCIE_0_AUX_CLK_CMD_RCGR			0xa9078
+#define PCIE_0_PHY_RCHNG_CLK_CMD_RCGR		0xa9054
+#define PCIE_1_AUX_CLK_CMD_RCGR			0x77078
+#define PCIE_1_PHY_RCHNG_CLK_CMD_RCGR		0x77054
+
+#define CFG_CLK_SRC_GPLL4_UFS_ICE_CORE		(3 << 8)
+#define CFG_CLK_SRC_GPLL7_EMAC0			(2 << 8)
+
+static struct pll_vote_clk gpll4_vote_clk = {
+	.status = 0x4000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(4),
+};
+
+static struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(7),
+};
+
+static struct pll_vote_clk gpll9_vote_clk = {
+	.status = 0x9000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(9),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s2_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_gp_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_rgmii_clk_src[] = {
+	F(5000000, CFG_CLK_SRC_GPLL0_EVEN, 10, 1, 6),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7_EMAC0, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(201600000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 4, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
 
 static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n",
@@ -31,28 +229,315 @@ static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
 	case GCC_USB30_PRIM_MASTER_CLK:
-		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
+		return freq->freq;
+	case GCC_USB20_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
+	case GCC_UFS_PHY_AXI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_ICE_CORE_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll9_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC1_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, SDCC1_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_GP1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP1_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP3_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP4_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP5_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PDM2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pdm2_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PDM2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_EMAC0_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_EMAC0_PTP_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_EMAC0_RGMII_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_rgmii_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_RGMII_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_0_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_0_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_0_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_0_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PCIE_1_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_1_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_1_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
 	default:
 		return 0;
 	}
 }
 
 static const struct gate_clk qcs8300_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
+	GATE_CLK_POLLED(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, BIT(28), 0x8e200),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
+	GATE_CLK_POLLED(GCC_AGGRE_USB2_PRIM_AXI_CLK, 0x1c05c, BIT(0), 0x1c05c),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
+	GATE_CLK_POLLED(GCC_AHB2PHY0_CLK, 0x76004, BIT(0), 0x76004),
+	GATE_CLK_POLLED(GCC_AHB2PHY2_CLK, 0x76008, BIT(0), 0x76008),
+	GATE_CLK_POLLED(GCC_AHB2PHY3_CLK, 0x7600c, BIT(0), 0x7600c),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x4b000, BIT(10), 0x44004),
+	GATE_CLK(GCC_CAMERA_HF_AXI_CLK, 0x32010, BIT(0)),
+	GATE_CLK(GCC_CAMERA_SF_AXI_CLK, 0x32018, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMERA_THROTTLE_XO_CLK, 0x32024, BIT(0), 0x32024),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x1c060, BIT(0), 0x1c060),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
+	GATE_CLK_POLLED(GCC_DDRSS_GPU_AXI_CLK, 0x7d164, BIT(0), 0x7d164),
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x33010, BIT(0), 0x33010),
+	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xb6044, BIT(0), 0xb6044),
+	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x70000, BIT(0), 0x70000),
+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x71000, BIT(0), 0x71000),
+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x62000, BIT(0), 0x62000),
+	GATE_CLK_POLLED(GCC_GP4_CLK, 0x1e000, BIT(0), 0x1e000),
+	GATE_CLK_POLLED(GCC_GP5_CLK, 0x1f000, BIT(0), 0x1f000),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x4b000, BIT(15)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x4b000, BIT(16)),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CENTER_PIPELINE_CLK, 0x7d160, BIT(0), 0x7d160),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x7d010, BIT(0), 0x7d010),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x7d01c, BIT(0)),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_AHB_CLK, 0x7d008, BIT(0), 0x7d008),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_CLK, 0x7d014, BIT(0), 0x7d014),
+	GATE_CLK_POLLED(GCC_PCIE_0_AUX_CLK, 0x4b010, BIT(16), 0xa9038),
+	GATE_CLK_POLLED(GCC_PCIE_0_CFG_AHB_CLK, 0x4b010, BIT(12), 0xa902c),
+	GATE_CLK_POLLED(GCC_PCIE_0_MSTR_AXI_CLK, 0x4b010, BIT(11), 0xa9024),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_AUX_CLK, 0x4b010, BIT(13), 0xa9030),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_RCHNG_CLK, 0x4b010, BIT(15), 0xa9050),
+	GATE_CLK(GCC_PCIE_0_PIPE_CLK, 0x4b010, BIT(14)),
+	GATE_CLK(GCC_PCIE_0_PIPEDIV2_CLK, 0x4b018, BIT(22)),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_AXI_CLK, 0x4b010, BIT(10), 0xa901c),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_Q2A_AXI_CLK, 0x4b018, BIT(12), 0xa9018),
+	GATE_CLK_POLLED(GCC_PCIE_1_AUX_CLK, 0x4b000, BIT(31), 0x77038),
+	GATE_CLK_POLLED(GCC_PCIE_1_CFG_AHB_CLK, 0x4b008, BIT(2), 0x7702c),
+	GATE_CLK_POLLED(GCC_PCIE_1_MSTR_AXI_CLK, 0x4b008, BIT(1), 0x77024),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_AUX_CLK, 0x4b008, BIT(3), 0x77030),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_RCHNG_CLK, 0x4b000, BIT(22), 0x77050),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x4b008, BIT(4)),
+	GATE_CLK(GCC_PCIE_1_PIPEDIV2_CLK, 0x4b018, BIT(16)),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_AXI_CLK, 0x4b008, BIT(0), 0x7701c),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x4b008, BIT(5), 0x77018),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x9746c, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CFG_CLK, 0x4b020, BIT(15), 0xb2034),
+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x3f00c, BIT(0), 0x3f00c),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x3f004, BIT(0), 0x3f004),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x3f008, BIT(0), 0x3f008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x32008, BIT(0), 0x32008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x3200c, BIT(0), 0x3200c),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x33008, BIT(0), 0x33008),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_ROT_AHB_CLK, 0x3300c, BIT(0), 0x3300c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x34008, BIT(0), 0x34008),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x3400c, BIT(0), 0x3400c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCPU_AHB_CLK, 0x34010, BIT(0), 0x34010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9), 0x23018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8), 0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10), 0x2314c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11), 0x23280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12), 0x233b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13), 0x234e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14), 0x2361c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15), 0x23750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16), 0x23884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17), 0x239b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18), 0x24018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19), 0x2400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22), 0x2414c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23), 0x24280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24), 0x243b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25), 0x244e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26), 0x2461c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27), 0x24750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27), 0x24884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28), 0x249b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24), 0xc4018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23), 0xc400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26), 0xc4284),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25), 0xc4150),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6), 0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7), 0x23008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20), 0x24004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21), 0x24008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27), 0xc4004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20), 0xc4008),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x20044, BIT(0), 0x20044),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x97034, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0x1c018, BIT(0), 0x1c018),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0x1c024, BIT(0), 0x1c024),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0x1c020, BIT(0), 0x1c020),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
+	GATE_CLK(GCC_USB_CLKREF_EN, 0x97468, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x34014, BIT(0), 0x34014),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI1_CLK, 0x3401c, BIT(0), 0x3401c),
 };
 
 static int qcs8300_enable(struct clk *clk)
@@ -74,11 +559,27 @@ static int qcs8300_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP0_S0_CLK ... GCC_QUPV3_WRAP0_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP1_S0_CLK ... GCC_QUPV3_WRAP1_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_2X_CLK);
+		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map qcs8300_gcc_resets[] = {
@@ -112,8 +613,12 @@ static const struct qcom_reset_map qcs8300_gcc_resets[] = {
 };
 
 static const struct qcom_power_map qcs8300_gdscs[] = {
+	[GCC_EMAC0_GDSC] = { 0xb6004 },
+	[GCC_PCIE_0_GDSC] = { 0xa9004 },
+	[GCC_PCIE_1_GDSC] = { 0x77004 },
 	[GCC_UFS_PHY_GDSC] = { 0x83004 },
-	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
+	[GCC_USB20_PRIM_GDSC] = { 0x1c004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1b004 },
 };
 
 static struct msm_clk_data qcs8300_gcc_data = {

-- 
2.34.1

