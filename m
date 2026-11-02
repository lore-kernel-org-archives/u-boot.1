Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14222606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o4DCIlb7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1eS4QP3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I32XlDXh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB8F56071C;
	Mon,  2 Nov 2026 05:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sZOW4rulSYj; Mon,  2 Nov 2026 05:49:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8BAC606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598599;
	b=exB+zNu7elb3jbrA0uaOqF9WBkDowM2VbjeLn5LpoVFVy5EDZYw8/PTzsYVWdFYoFkDX
	 mmEXC96BPcYdtt6Ms4h6KjHUwe0AhMydsPz3s5wp0idADXaZMSi+SV6592XKI8sa6+79o
	 sy5QH0q1YVlavtYoszLV9BN3zDItVFIT3E5J+/ySzS72TWsoeG4LkmTszwo1fXPnxFCe9
	 1ELCBX8R58as4bFTszzTrZI/7wssiA0q8HXCC6a0l43qqwZ4yq0hE4ONQpJG9C4pSF449
	 XGmwGUhu49MwJZfGP6ISgxbZ9rIx/3GYeKPoh1P847gMea54WLGK3f++oipfNo8SkUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	b=JIgzQIVuFF2KN1k+CEu+BtFInOXbPgg9eSDuJ+xx40xBCL4FGW3n9WouKtsI69TRrX4d
	 JR2GjnrvXqlRDCIUwu9Ydqyv0K5GKSzloHhth4UznbDLGupjVOCux7f4z2TlTkvhW4Uys
	 NQ07devsRB2+dVlyggxTNMJHp+3nY8mJgrrzNPKwUVgPlN/ReSv3UxTjRnU/xUbcyqfsh
	 8egR+UN+bOlJJuP40f8S5j/X6/K/uP1QeDMKwe3gxG0VM5diHcwA2IZHlmVQiEeBWdkHR
	 aUcEmpNmJLxjA6YFavW/anHU8XgOqi52/3QbK2SmIBdlx9vu39F3gHcDk7OKtSkyImg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598598;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4DCIlb7iERnTBbn2l4cHTmqAn9bDq+1GjeIPgmLMbEsFdWwtT8yxTjFGn/lY3nIP
	 aLPz8zZJHEWOmfLTxpHlahyVZzHneBe7nto413MK/6WEq8iz4UvTnGbh2L7BNV3eyO
	 UM6xoOoT+7mFp2t+nhKzUfcHAvNZ/KGJ7UD8pqPkm9wdnpffp1dSXVHqdi1xifeIzd
	 2YtoYSSFZxIryh7enhenmL1v4RIKVCKuYLNc4fTBV8Xt9LCtTk/A1/wUGrHseCgwDO
	 vzHC51GnkJcgfWG1INzI/mRreljrtkjxy0MyPe7yizFzBTKy6LzVoJtVXox5gEuieT
	 ABm8gBdEaT+Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8BAC606B6;
	Mon,  2 Nov 2026 05:49:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 530DB2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 449FB80DF0
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdOW_bGZdzF5 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A44180DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598596;
 b=SjkKrwIVxRFHpHQs4KT3YzRuR2++E4QTZIrd23ydsaFFWKP4VU85UxeG/YhDUWswMpWF
 ameMC/DPq558GXXhdSsg22kdD8MPqrmqo4fJOl54g2O0EO1R1X/Yh3ZcXVJrV8ASE0T5Y
 /3uFrWXPqWbErM3her2C9RzhO5UQHYS4Am1BrH5s6KGy3V/E5XGaqXJwCAWatXzh/c6E7
 c1DVanOWp3PBZemv5ucH9nfVqBTxqIIbY92ozrUZvlLzWxVX6NPhaB9Q/uILv836cCuiY
 /mMlvOCU5Wz4BExcwAv1cdTfz9g7y18v6jzKOtsQiS8bMLHrcmkqF9rNGk+GjPfFX5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598596;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=FbajgT2GgNq3EfoAXKE1KO1FMrAfXkIxz9a/X/57JGKnlI8Ce0Xtt9zQ9KtqNg3nE35+
 LeFEc5lkEGMJuxm7zoPcZS345yOPewzX44wfUHVsg77WgiqyWp5E5OvpoZVwWdhEo/XzF
 6L1Zil0BWioGExBGsGywoR97gXwdwkDumuhWrWkcgA5mZAuTuMq/fv9e9jM1IRQvJtxVW
 F2vQeuX9y28VIpxt+/KVEugPKPG19SjL+ycR7dOoqmHDxLBmly8bT7VlRYCil/nCF5DW5
 ZTqjUtG+/E1mUmQIndJqv/avIHyK0BQeY96u+c7jUH/8141W2G523eB8TZx4nLpvQrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=m1eS4QP3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I32XlDXh; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=m1eS4QP3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I32XlDXh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A44180DEE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vOPT2745609
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=; b=m1eS4QP3FPK+i+JM
 BFU3GJmoWk3pzwbG6OzdOdkuXObshhKlg8xmagsMjqFFVV0nUuNtQ1vGyYjxkc5b
 srj6VzgAV4Pnzcs3cIS5hv841mYKcWGMhmsbFidMXR7E1tS/BJUyl1fIERO08eTv
 ji6n/4U29e6UoJuJ4XIDrNCdiZ/2YlZABWZ4/JYYQpDps/IhsSSV//UPERINYcrF
 KsyETqUD9j3MDJ2jeguzuvDt2XGYtVH8Un4yV7BBKdwkXZ7Ui8FdgQ7i9HdMW3a9
 FG//jf/Bl0RQA3OJVo0BMfcr7q8mBOm8xSTKGWuqtW1uT3gE2j3lASWXBxPy3slL
 JqPA7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dudavj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so4427063eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598594; x=1794203394;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=I32XlDXhdJAdEuiDhuDy/pnlBrmo5+717rtaNuyJ54oj2zw4g8JQtk4xnZHvHiHX07
 oqX2sHnT8LxRExSUhFqxjjTmsPLmBZPjYufAIIPluB2kwI6YdulnCpGCzHfYp8Poogiu
 2bP3ObM2jDuhkkbJj6AmB0xJFtVLTkGLpscBa4ftJ/lRnhjmhekRkobm3dag0rlnBlI0
 HL86R6eX5BdmjuNiD5SDFAMnZQRptQpAD/ocUc9oiSPrNoCdtTzLkDEOV3c2ggSkOIUx
 vjiY6i2kNxPpB/WuUnly07QBso8G5acU3WSfSMDLYKm4GTVOKUW9EzQq9Hs6JPxGM10s
 V4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598594; x=1794203394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=Yd964eGNQQfiAyPpFTNnUo4Ld39VPGrxX3m7fesHoMdxoOlI5eIGYqKkCBbx5ntywz
 mlt0SK24wpsWVdQT/eX7F4UxJgG5YnI9VsS2gAgw4W0cHKM/VRxy1cH+xdoRAEJDGrqg
 Eynq3t3jl44jgCLKrUGDvcpOfhSDJD3ILxaEcfhxttXMRo3abP3TbAZJyc0BxqjLmWnJ
 xvuQEDheV9GLviEuGTosKYNygUgG86bP7Z2keuT3M8Tay4uOiXMJuAFumIGgWoMwgooG
 6RA4CMXKrqe5VmtejZQ9J+fBWgPVYo2mjiM16Dwa7h6LkshhS0jh+WtNFNa6nGhiWSyh
 CAdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBysEqASl3CdVcju3yJdWA3JfUIur+x0v7WYYuLMM9csYplC2CqHyZKxVuKVSFzwGrbjOfsV/W4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ6gUL952kr/6NuEPinEszMOFIYP9ClNvgWiZYR9tC4wCMrMu8Z
 KWgboFGzI98PuvyeTqYUwqQ7de7RPj7TtYq3bw2rRabhVirmgADk8fOpGpVI10/aIbOs6f2hT1R
 cpbSFzRqPWeu7koREF173xqScyq5uden6sWl1ln7oRYtAN0LcXKU7ZRagTOMCRjwUI1LHATM=
X-Gm-Gg: AYBFou0QVNMif5gcvBVdnj68OTF/21nSOsXtyxnp15PKA6LOJ6+XeisiR7p3+cbXZZd
 Wjp/BZX+uqKImqqN6+vmTp8qasg1MXLkI0JRMT9qYxbyt+WBpFTExXwdvvgCjpU6bUq5Lyaj8PF
 J5hDmxdUNeUQ5Ld4x0JytDJVBv96xAn/WmC01M8ii/qdJylRA7oSXYpDanOm/TkjJ7M6fGWHgX0
 X3Z7TZnfSUr4vEdgeRM0GJakL1Jq0p2HawvhucysTxbO0sibbZT/8Stg4JnJeC983/DbLHNkV0N
 uSXb5MZ/rRxltgYCjdgTyGqQnW2dDbeZVyI0PhWP5JUHwRxSMSMlBLkMKAe0ouYlToaTTjATzrM
 zaSspK7W8Ws3pAErIvF/plT8TAykbZJRdg89Y0/sMtjDjVSaHIDclWl0+GqtaSzyL/0cCkW3dma
 3kOoyXAqQ3XXw/zps5Ihloik78uj+kz19VHdwDL/uLwpiPTwwCuPrQefBlwtATL4l6ao+9r1Mo8
 Qd8jA==
X-Received: by 2002:a05:701b:4287:20b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1ac5d889488mr13739784c88.17.1793598593437; 
 Sun, 01 Nov 2026 21:49:53 -0800 (PST)
X-Received: by 2002:a05:701b:4287:20b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1ac5d889488mr13739762c88.17.1793598592865; 
 Sun, 01 Nov 2026 21:49:52 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:52 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:39 +0530
Subject: [PATCH RESEND v10 07/15] mach-snapdragon: spl: Load next stage FIT
 image
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-7-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae82482 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=6bbauyjUkyUOPZ0J5qkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 27kVaChRBEv31SjtL-yfNsaGy9KarUvg
X-Proofpoint-GUID: 27kVaChRBEv31SjtL-yfNsaGy9KarUvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX1knc7Ta90+DE
 ltwnXlgQq804K+tpmNSeBoUCZ49jWXMwCzakYaS1NIKy/RMhKZV/7vd/VMNHiVN3WaBIL1oE+8E
 maZivVMa5bGIp9g+GZbVFTY+86OijwmyKErASH/hEm+UESHqTXsNGlX06unx4pzddij2xGSewe+
 Hgm86DNLJ1qdcr9D5LHeNutzWz6K5iLfoxoiG7PegmcUmHcxu09gz4PB2qiTqjg+W39F/VdSo8t
 fdfFlh/xuxMZ/n9qo2eJ54Bp90Zt+2e2k72o21IaX8OawLkuijiqBfHFJW73DkdE1K74cGVvJNs
 Xv2U/C9j1fpBvSevzwh/djkVY43y8Yz6fSZKKg78GKQSO+EDDfcQ3KCAAxLPSdY9NBD0oxKVo8l
 9ohbMSBvTKzifDWsdgihOYQ5PN9nas+0Kq5RDykLrOF2lqhkmWTGv6yi8I9eC3IEZ2To2ZEMwFt
 Um5r+KkTwQxqolN57gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX/gM8Gj8kZOog
 f9KoHtTfRm59XMv6uE4MAugTRM+pH6whaFeQIg52LzQOiY92KMWoiZL2zUo1XNBiVvwEEOXsbVH
 JSzQkVvxHIXHCVEnv/C+1oFJNV+1kQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
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

Identify the boot media loader driver and load the FIT image that has the
binaries to initialize the DDR, U-Boot proper etc.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 155 ++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2445ae8b17d..2655803b31e 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -5,12 +5,15 @@
  * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
  */
 
+#include <asm/sections.h>
 #include <hang.h>
+#include <init.h>
+#include <mach/qclib.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
-int board_fdt_blob_setup(void **fdtp)
+int __weak board_fdt_blob_setup(void **fdtp)
 {
 	return -EEXIST;
 }
@@ -86,7 +89,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
@@ -120,3 +123,151 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
 	return 0;
 }
 #endif /* CONFIG_IS_ENABLED(MMC) */
+
+void qcom_spl_malloc_init_f(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return;
+	/*
+	 * Set up by crt0.S
+	 */
+	assert(gd->malloc_base);
+	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
+	gd->malloc_ptr = 0;
+
+	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+}
+
+/**
+ * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
+ * @offset:	Offset (unused, typically 0 for SPL).
+ * @size:	Size of the buffer to allocate.
+ *
+ * Return: Pointer to the allocated buffer, or NULL on failure.
+ */
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+#ifdef CONFIG_SPL_LOAD_FIT_ADDRESS
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
+ * @fit_size:	Size of the FIT image.
+ * @sectors:	Number of sectors.
+ * @bl_len:	Block length.
+ *
+ * Return: Address of the FIT image buffer.
+ */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return spl_get_load_buffer(0, sectors * bl_len);
+}
+
+/**
+ * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
+ * @boot_device: Type of boot device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_loader_pre_ddr(u8 boot_device)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info spl_image = { 0 };
+	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
+	int ret = -ENODEV, n_ents;
+
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+
+	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
+		if (boot_device != loader->boot_device)
+			continue;
+
+		ret = loader->load_image(&spl_image, &boot_dev);
+		if (!ret)
+			break;
+
+		printf("%s: Error: %d\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * board_fit_config_name_match() - Select the FIT config for the current
+ *				   boot stage.
+ * @name:	Candidate FIT config name.
+ *
+ * Generic default: match "pre-ddr" before DRAM is up, "post-ddr" after.
+ * A SoC with additional/different FIT configs should provide a strong
+ * override.
+ *
+ * Return: 0 on match, -EINVAL otherwise.
+ */
+int __weak board_fit_config_name_match(const char *name)
+{
+	if (!(gd->flags & GD_FLG_SPL_INIT)) {
+		if (!strcmp(name, "pre-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	} else {
+		if (!strcmp(name, "post-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * board_init_f() - Generic SPL entry point.
+ * @dummy:	Unused.
+ *
+ * Generic default: clear BSS, set up malloc, run early init, load the
+ * pre-DDR image and invoke QCLIB when booting from PBL, then hand off to
+ * board_init_r(). A SoC with additional bring-up steps should provide a
+ * strong override.
+ */
+void __weak board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}

-- 
2.34.1

