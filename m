Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDC606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=04DzhTWX;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UrLuHEaK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UlaRjTTW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A58581271;
	Thu, 22 Oct 2026 19:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpI7l3LzE9EX; Thu, 22 Oct 2026 19:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FF1081283
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695900;
	b=QuEbO53alJxdxvymLmjdhF9KiEVLDmMObqCPRSfdnOQkEKxcemNSFO1HfybDObmHsY9t
	 o5alWwTB6XzJnRY5LMSzUPKq9zzSI81ihMzOC7vtJDMP8dTixGXcJjfSuS3nbjV3UrElz
	 s+W9nBK9VYLNXDoODdy8b+ZY3IpaYwY3ROzMqs/fOU2fGsCFbJXUUf3YneAWDvAul/ybw
	 3hIr+a9XgTtMVMhd9vmq1vzI4HPgfoXqDJj32WjS1OuKMJWE8QdZEBsktcXZ2W+WkmBY+
	 1fJvl9D3zUDIWgYVgqY3bMkRY2Gvv2bk6vOhU/IyQO0FY2x6VCqmi6lU8VvOA92c3zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	b=Bsfcv/COspN//bTSqTGXCAXXs56J3HC18F4LTwaenYoTd77VIuUdxK64Q+41gn18PAdo
	 /nRLV/C0tUgbVu4/DUqgXlOPPj1hGohP1omlqU22XWGw/K4DYHdKrKfInhhH3W6WBD25I
	 8ea8chbiQodVoTIfv6C0EkjSwg79m3d0MRG3K+4zpIamppwMu3XiuW+I7cUh3ziAeTSoh
	 M0QBxcUEbDBiSZks6PqVsTJFOMhNmTIm6GB5QRJv+8ir8PLguXaECvlUQA9VbMkvBEzdh
	 KsL5ZZEiTQ3Kmoy2f3dzy4vrVILaQunNx4JTUtBLrdJGnyaM2CWcAM3yLKQ/bMPN3sg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UrLuHEaK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UlaRjTTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695900;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=04DzhTWXTFB5877J9DX7wt2FUH/2fPYa+cNh+CboMX7elEV7CdStca2vfmTSm2F3F
	 ueD1oNZlvz0IbbkEll9OfQrw2MgBqWHnurUZ34NlLrOatYcdFkoOn65EQVr/LpR3dq
	 vyyIkBC1HLUmHh4uKCgO5S1HiQrTQTGMvTCWzBwcz4WUvmb3d9cecDDSou6PS+lp10
	 4J4DkxUNgU7sXO0Yokp9cIQ1tXKxVPbtpggiatXpvijBnCDk4Y8Lb/8R0Q8X75xBmY
	 cueeG99IPoh0xSoklQ/y/haUwddeUw9a/4CsrhLdDxEMKugoMDhw7eXjLEEfSM780e
	 I6mvH3wmCDR+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FF1081283;
	Thu, 22 Oct 2026 19:05:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A5843A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BA578120B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I2CaiIvS5qWa for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84BAD8116F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695895;
 b=PjPqRs3x65c8vVSZwNty6M9PvUxdRxAFV5BatIqz5F0o7fAz2tW1M4F5RoYvNyLxLI5q
 7/w09pJXKEXLlmbL1XYocDZUFu3B3OqHCpFYB1hUMTAvUtfb21SiSscrGA8YnYa0ir8qy
 E0lwKRDcA4BnvwcBJSENeuUk8lOdKBgbDaxKQ19h043lMTMOZ+bCUpOWkuxrObeC01QaM
 nXnPlI6JfUrsb+dukFX/TwQ3eJavXABCVhf+CRn2uIzX6YSE2iGHX8pCOmm/E+JpC3/tK
 Di07N8WkLbaHtIzMvG4X26zW3LKvD+ErwuVwb+oCc+C6m5GxaiJ4b2rJORvl1pq7Phw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695895;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=RzwbsO9OYNI9YlWZFTwAvz4Q4g+IbgNAE4w7sUoCBZEopI8aWVrorlW9iR234soMYFEo
 fyGiGKcQ00ZiiTH8cm0ywAlPJ/RMZCb/VXeGpCQfOpncVtoz4HaLVYCNlHZJ14Rc4+iKm
 0SHB6cSEx34S9xpLAPZuFhIHHkSgGTWABj7mb4cXEy5DObAjScUxHHX30bArcqTuRyln4
 zClbEHtau8vFknktkHI2W37IZ+CL+PPMvD5i9t69Eq3cfJADshzUwK8Qt/eXNbIN8SNYn
 EhpI8V+918VdcaeMZ5ZGWB6ritSt4qHA9IvlRAiSZU0eIjQMjlZHPkhxWjqEXUUOIYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UrLuHEaK; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UlaRjTTW; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UrLuHEaK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UlaRjTTW
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84BAD8116F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtTm8387597
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=; b=UrLuHEaKkPhw/yxo
 7sf7l4A8v2Lt3iEaigCxFXb6S6LhYim2QlrLHXjaGkuSzVxEFar0VGGJEKVp09sS
 FBjB44kKRmR3AOC/4GRhEWS7VBX1tXTFRa+Yh77/tHeL8DgQ1rkggRwN0fyy5Sre
 +bIP0TpgTH6iQLFuhkU23icBag2LuT+/jINxXx7HfhmpL33FZE+prM/eXY3nSLDG
 3ROCqxJuCqJ7RRi3Lk3YOPe/0CBFRLBFkO2iySZkxaeTfWvaeJsP50ffnoEGWzRE
 i5o5J5Aq9YFQ6XWps20RaFFm+yOM9YFGearVkUqpKOXVGLpju2xnqeZ+pMMyF7W+
 7wG7Ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq46wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so11736985a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695893; x=1793300693;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=UlaRjTTWHPYp9dXoDlgdzKzor6PmIoFYIxT/e5DntIGneDfYZKBmaYdINmz14oBJSW
 QqfHXVTyDl2TxF1rNcb7IYfkUYtLZfpUYxHj+jY/GQvKcdlpzCCI7ou17ZIVoN8gPHLV
 7BXzA4Kga6FC1qEcnwgBm66kIAx+Go1Ts9fO8mK6ow7I4EMw9mmBSoM0GAFx0B6aRJYV
 zrrrzouVNNcIv9x4Me44d4NJkv+ybCCx8OGJDkkPJUUPRPNjjrLOdJ6+ANp2ZjbJeFqc
 dIWbfnPTexcrKvNnS7vHKIPUfcAiv0bLIYeFOPPJMZ8aS+bKj8bVYobBeJxZGkdH2knS
 oF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695893; x=1793300693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=JWNqStbU2rfv+1vctF9rbsfnJO2atwnuop5Lpbfg99vC3vfAsbP2fB823mxSCsYKxr
 CgBHLCgALHPGF/C/CzqiHapL8WC9z8Q8tL9hmot685ixU127t7JY0KvbtF9GV5Je3Ccl
 HY3kOjzPnr7u7i2bQ8E8wdFvihbUYMY6aBNbX7m52HniCBsaYrkcEbcCX2WJu9DprYG7
 x2dtyad24We1tbl6+q2xGxKo3Y43/NwIQE7EOlfpPDoL+B9jk831b2MPUu0NVfHr+WgC
 36mlpupSjQw9vhrz8dO5rwnc3xeW7sOIfE9DgSPqbNR1AaV9UhEZVxGio2QtPsgl1RDt
 pPfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoHlxE+t8Rno+IU1H4NFq5GJg6E0Y8y7H5b1AdHmOjilEXdCF/ttaSKLDCFvZTehDPJt6piho=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+qTJGJtm11HJz4W1dvvqiOUrfgCk5Pj/91Co4AeoHmybPq3aJ
 y/7B1YJsbY5xE80jKsm/MZp8lZk8gPJwkrz5ej/Q9W8DyIizjiqzNAfTMvZ5rjWAF7dy2H1n/QC
 CJfiDESXT1vyFpAlxmyxCQ4Q8uFugKnZBJWLHdsvT6F8w/pn69W+A/wFTvllNkPsUI4SE8+qOyB
 RZBtE=
X-Gm-Gg: AYBFou1My1pTep3NaHNhXC+Mjsk+Wc0X9HsHjDhZ+yMnAX/PGNrJBe3S1Ugaw7e3nnj
 bghArjyo2eMcnJwKyX2BgWLwH46KilP3yXtIbHyNdGHPP4SG69uj29nsv/BXeMAoWnr2JnAxHuL
 8l2NMJ19WBUKOAD37GFH9KR+USU14ovFV246DvmCx3oahzPPyhTDR7Ha8TeML/M6zbavU0zYm7L
 JuNaHTogLKSXC3V67urNEPGMX6UQGH3255ts4iTRHf/sKImWIClMbsac5fVv6j2xBwxCnbkfgs7
 1wIh0SAmJk7IZAyBlcs7QGfyHXSzwR7bi5i2vvr3I8QhH6SdPdqyOrx5O8FKRzm1WVV5jVhorMj
 5F4LzTjjd74E8+if91wFPfMS4fl3fE4MqcFIYbz1TBpNF
X-Received: by 2002:a05:620a:6006:b0:93f:5e6d:880f with SMTP id
 af79cd13be357-93f6f9fe808mr66955285a.74.1792695892932; 
 Thu, 22 Oct 2026 12:04:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6006:b0:93f:5e6d:880f with SMTP id
 af79cd13be357-93f6f9fe808mr66950985a.74.1792695892481; 
 Thu, 22 Oct 2026 12:04:52 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:51 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 21:04:43 +0200
Subject: [PATCH v4 2/5] cmd: avb: add lock/unlock commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-2-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 0eZNS5420t5PYyEn01I-mmhMVc4yLwqa
X-Proofpoint-ORIG-GUID: 0eZNS5420t5PYyEn01I-mmhMVc4yLwqa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX8Rybt1j+9XgK
 IsSmcomlp95Ug6tApjpzD9a/ZvEpl2Hwdhw7TLzDKY67zfPp4IVB2megPgd4ImH+GhA3PPoC5aO
 cRuKFosg9/pO05PS895lIapev/tXocI=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada5e55 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfXwAY9cuiTYaMq
 Lnk18QeDb4ASY4+UGqI1GciNo+71KihzYIuykyVqRR94BJAk/z598wq5Rqv3jiXcmOdGWhOseUy
 zS8KoOjuLteN3z9Mk7sqVXAN7Cu1ksLTc7mpfKStP6pJeCsyFGmbaEsls+Q+ARkjkMdolmXT1YN
 Xnbm2h9chNbUqGlPrLU3pqxZJ1v+CIh0UBAcByapRIUFUptRIzauMyK04CGNfas3t/uJlm2BWe3
 7c+gaovx5X8s7wK9QjCEeggiIUTWQis8Uc1OFugIpNKgRnJbk45pVS1jP5sNtL1Z9GR6zJH7DF7
 rn+h5DWU/4y63uaJVr5dynKzV6ac42z6NSX34K72UvNi3WiJmM1ZEXl9nh6F3JtrLQ7Gx1sZ9pt
 SYaGEur1/Z4CgRRBbZRGKW/ClSC9m8/h12+eMiheMcNLWCkkUFcQp3ExKQhz+hRQ+mZShZvOIkG
 BR1R4SQcZYHzByKYzUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220075
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

The OP-TEE AVB TA stores the device lock state
(TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
device backed by the TA could never leave the unlocked (orange) state from
the bootloader. Add avb lock and avb unlock, which set the state through a
new avb_write_lock_state() helper. As documented by the TA, changing the
state resets all rollback indexes.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 23 +++++++++++++++++++++++
 include/avb_verify.h |  3 +++
 3 files changed, 66 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 3c13d6a2cb2..8e0ab0eff06 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -534,6 +534,41 @@ int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+#ifdef CONFIG_OPTEE_TA_AVB
+static int avb_set_lock(bool locked)
+{
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = avb_write_lock_state(avb_ops, locked);
+	if (ret != AVB_IO_RESULT_OK) {
+		printf("Failed to %s the device, err = %d\n",
+		       locked ? "lock" : "unlock", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Device %s, rollback indexes reset\n",
+	       locked ? "locked" : "unlocked");
+
+	return CMD_RET_SUCCESS;
+}
+
+int do_avb_lock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return avb_set_lock(true);
+}
+
+int do_avb_unlock(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	return avb_set_lock(false);
+}
+#endif
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -549,6 +584,8 @@ static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(lock, 1, 0, do_avb_lock, "", ""),
+	U_BOOT_CMD_MKENT(unlock, 1, 0, do_avb_unlock, "", ""),
 #endif
 };
 
@@ -592,6 +629,9 @@ U_BOOT_CMD(
 	"    and print it as hex\n"
 	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
 	"    string to persistent value <name>\n"
+	"avb lock - lock the device (verification errors stop the boot);\n"
+	"    resets all rollback indexes\n"
+	"avb unlock - unlock the device; resets all rollback indexes\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 227b2d22465..7b60be4da7a 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1080,6 +1080,29 @@ free_name:
 }
 #endif
 
+#ifdef CONFIG_OPTEE_TA_AVB
+/**
+ * avb_write_lock_state() - sets the device lock state in the AVB TA
+ *
+ * @ops: contains AvbOps handlers
+ * @locked: true to lock the device, false to unlock it
+ *
+ * Changing the lock state resets all rollback indexes in the TA.
+ *
+ * Return: AVB_IO_RESULT_OK or an AvbIOResult error
+ */
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
+{
+	struct tee_param param = {
+		.attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = locked,
+	};
+
+	return invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1,
+			   &param);
+}
+#endif
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 6dbbb39a8a3..e89bb229e02 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -45,6 +45,9 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+#ifdef CONFIG_OPTEE_TA_AVB
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
+#endif
 void avb_ops_free(AvbOps *ops);
 
 /**

-- 
2.53.0

