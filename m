Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C0606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kM/tL7cO;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MEp86B0M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gmhb63A8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD07360716;
	Sun, 15 Nov 2026 05:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLMcGNpwmUlU; Sun, 15 Nov 2026 05:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00AC960703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719110;
	b=NJ17iD2Hvj3rJ/2/cESyfyp8F53ATzlfBr+JP99T90sXkqq19qD7/OykV0wTtawU6nqc
	 iHwIZx3UMfM/vBtzYMgm+yhiQGXC5U+BqOkkabiQoD3yu7++5B+SG6B0eeUF1B1Ml/jgB
	 hOH42yqAC/xlfo4K70ehKFCqP+oL22TPcKJepEloPTs83Ya7COzx+qhYYn7I+z1lpW8A+
	 kovjw6Hkd2k9IiSeylQXyj5CP7xwRHps7AucTOpY+juAgB9ZM3HNRhoaysm9a2wIo3tq6
	 pxO0yO3Q1oGCF0/25jCH3MyxAz9SWE3SX6fS23E8Hcx4Xl7/07IJMncBvRN4I13BMrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5DDuoSbxXHY+cl8Dc2t1Nhbkk1MjEpY6HeB1f4ICqVE=;
	b=HU4g/31eGdcYi6ycOQvzqjweAeCd+Dq7BjoFMBEtnLIn0OUIXMYxkK685zqUfKGwu93x
	 6VpQR22sqXo+gVsQDvsZdZYfbtnLwe8hgu3Pv15JIa3+C6GxUwpVsJMxD1lJBBec208Kf
	 FavNfnWL7GOI5UCHAIcfiSPCfl7vI9G0o/9h1jNL8tRRaqxYcpKjRPT9vdVBZz0bg6nhl
	 n+V940MmnsHfDZa4LlOi89yCDxadvVD67af7LsLx1tNAPKAgrgARoLPHaamubrkUjHD1j
	 HeMV1K+rm4uqth43bgtL6llxIByABzIZOAfzbqiix45s2b4cRQVjR6GbhJFdoozNgDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MEp86B0M;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gmhb63A8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719110;
	bh=5DDuoSbxXHY+cl8Dc2t1Nhbkk1MjEpY6HeB1f4ICqVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kM/tL7cOT5C0nDnrpCzqdpodacfDHqLY22jTIY+YSyNgn8whWHLslNPpDcQ1L3dV1
	 KGR6LXai4T6tqmg4SWlp+0Ga4MRPMImDrGcw0Cp9O7w7PbBMyYHNi0X6NrMK/PDM0L
	 3fvuvxTCMukgCS8whcg+9S71VC03Pqk5cwjDEuYk2Z2l+IqtBtj1FAyZwm4LIaNDoi
	 lcsHjxzjMxSxADpF2DJ1Yt29WKTLDAU1omb5p5qH9JTFAo5CHV72hi2JMD8mM169in
	 7JyoSF90GVH22F6RVxu6FlyV15/Ki0+1mPyW2epgiKfEei6AHloV6f4QpuM40wH65U
	 ZUTQk8zY9Q3dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00AC960703;
	Sun, 15 Nov 2026 05:05:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B258B28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A472060703
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xocw5QuhaZTK for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E10CA606CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MEp86B0M; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gmhb63A8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E10CA606CE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4ST5s2718141
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5DDuoSbxXHY+cl8Dc2t1Nhbkk1MjEpY6HeB1f4ICqVE=; b=MEp86B0MRPHLnzZL
 LM7PJvWBjeeqhnk0/Sw/UrHDNlHweanKeFxnI43lzmVymfhdrTAWQBzpODNI6CI2
 lSKu9wFzP2d8xSU2EIswey9V/vHGup1vOwrnjDxzC6xOa8+31wck72kqslDpCiuh
 ESrddO3DEWwPN6Z048hnlUIu7D+CgBTift0Bjdmiht0MwpLjzU8PgrE8xlpTRwkW
 ze33k3heEnf0okP7SV3YjwkR8hwKLOJWkK8oSJBuwwZaS0n5KroFEgfYmG05isXJ
 umRizE5ILPsIXOYFW1wmj8at+dTk5t1bWS2/OWwQv20yImko2uBWpqBi3GK8GJ/6
 2LrBIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdta0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36efb506f29so43535eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719106; x=1795323906;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5DDuoSbxXHY+cl8Dc2t1Nhbkk1MjEpY6HeB1f4ICqVE=;
 b=Gmhb63A8GU2a4++0YuEw/Mi8Vkg6Pqe067XYcvbm+W6QCUb18ME/mUaH11lel/ABl2
 AIcLLUaIDLGPWZKHSJtIZJnbaI11z2uW8y5mN/jd583/EmJyfAZC+PFGExBi7VEGgPgr
 b2qCuNQF1+HTUGLUGb0Hb9U7L213HXTdNq2Sy06s3zMopo/iSLDqoH/4KvULfzdJzhCY
 r2d++0VmqSYEbvcrCcKdL8WfoJbA0HDXA6Q/BCyxBFEjKKLhcnBWRRj7D+MQhNy/o1s2
 vkaM4sUN2USTi+FsZgwzmFF8RRTTVrg1UXfAzm17/bq5Obl8bOx+Bnwv/eGvepI+O/cQ
 959A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719106; x=1795323906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5DDuoSbxXHY+cl8Dc2t1Nhbkk1MjEpY6HeB1f4ICqVE=;
 b=VA97PLXbOsDsczteBdRg08S9CMpGliu6F9E6WDNLFrQAL7InDF+fe71oF7wJA2mf34
 qr+gTb9PpVMXixCLKWw1dEdS6v6LEYzu2G1TgMC15occHr/bQN8PueyfxGUjFuk2NZ5T
 crWQ517eD/uZlLt9ZeOK4Jh58+NP7mCd7hjct5fM8Lq8CFPKEhZKB5TEW1mgL+k580UD
 xK9QxOnv/3LjledfMa8hscUxyzeAEj5oyYfn+vAgptgZJSZocIOeRNK8gE9r/1VGsR55
 Cpdqnrtp4ugUYrKboCyvaCYM/E4RJSvqXXvjQflSfVX9VBMG0tStXQNdSJBTquXvGxAv
 vkFA==
X-Gm-Message-State: APuU4Z8uEdNhrAzZg/RSTEaEH1rHsZBzLSFTY+hEBImboryH/0kTXre4
 mOrZNQCKCWn3BkDEMU5TwP4EeywjlM3Udu+Zh6msth5Bp0ZI06WI29FUkMgfwFh7+8zgSub/Vl3
 9IEe0C6OofwTYH2lBXaClMfcyrYoJynGSzSCxh9i7cDaNP04FKPSp1Y5hWYpOeRDsDxHPU0w=
X-Gm-Gg: AYBFou2ew1zp8rZDNqYdzRNr8FgHZIVyHLfXMHhsBpPqm800SXdqmNV+3Oo+0uCy3wF
 1I9VT0P1zBqiHquwRN8+nsCcigPjsEh9m2VOcpiI4uH1s7hwVuODi+Q+2vjfpmRyjnEDpPhApJU
 D8rhc1iGEkFB4PRM1knOijH0TDciOLItFZmex3NxUqFl9wYpw3i7wxDoy6RcCXp+FuhxFI4/jqu
 rhy0XcZlPdTkBrd19tlVxeuUCEgdhY4bb6/B3ZocAIw3qeXwYxZnhl3CtVrQaAz8UW4KgE9ZnMw
 DjyrL2UabA+IfsYGRGt1UiMu2iU50t7UUP2eI7JuBv0iyComcX/cbpaC2ay0GPJwVMSk5iD5rvj
 kRQsQ5BzqostnG4FZh76yP0EN6xtDL5Ya6goK8Mn5Au7mjJeS9ubO4YHQEZNWXS87RzWRO75XFV
 KLLf0MldGPPrCpRKfZQiHZxoJfJC+vggJJh4smHpTMIdtmqS81VcpPELR8Ulg6WpbYh+dYMiKik
 slv
X-Received: by 2002:a05:7300:8b:b0:377:5cb:a534 with SMTP id
 5a478bee46e88-37965da9681mr7447461eec.17.1794719106115; 
 Sat, 14 Nov 2026 21:05:06 -0800 (PST)
X-Received: by 2002:a05:7300:8b:b0:377:5cb:a534 with SMTP id
 5a478bee46e88-37965da9681mr7447438eec.17.1794719105595; 
 Sat, 14 Nov 2026 21:05:05 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:05:05 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:43 +0530
Subject: [PATCH v2 5/6] test: capsule: Generate capsules through config
 file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-5-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=3918;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8uKGUbSNYLK7UlnplrTzIorI2CddHW5aQ5oeMdJhdkw=;
 b=RZqnbay6Q9VEphhLiJ4vI43ee1oSGR0HRRynLpny+D0BnF3FVvOiUG4qrdyZL+L1NXt28PxTv
 hiRlW+JbLWBCxRqSv3MhiPKSvK2i5Tfg4dQGbAA+Mhu5vLZnZJbEEIW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af93d82 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FmvQW2tdfGN2xf_TGMMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfXxMCg6eIVA54V
 xc5MwWOGuk/wIj4t4dn6rXJXa08DmR9XA8tN7mV9lvbsqFJRl8MCSlNGlMHDFVLvqTtE55WzZNs
 udm6DPv+lTBvNPJZFQ+C8jDUS74UXAs=
X-Proofpoint-ORIG-GUID: hgfk4gpf1JbGkK1ka7uAw2vaZH8Q2VDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX2bkZM1954Krb
 MFfZHte+GRv5WiYYcKr0fqUfM9B6wblJ9LgiqWYN6+eDtYdeWuDu1ammSjK3rxU08VCGP2kUH+P
 kOklMo5YycvM9CQl1fRkd3ZWTp34vBVxlpPvZtW7Th869uDNszm8PZY9ZwC60Y7MAXj61eNNzw2
 Rag+m4fdp12SQ1n9iCviaxzOq0NHoRaz6IRmL+7ZsnesgXFQAJ/oOJZ6BNjnlSmXNXiDJEbaEGv
 uTh2fbDTaz3nRqvKoa9NTeAkYsANqaYC4KC/MWssldrjzX6oa4owH9+TDvtiAWcYAfHYycsO/U8
 9x0MsnvdWSyVRS2xnJFBIltGuoz4ss/30/ZAA/C7OhavzDT1CX/GD0XILIdzReEEfZxCNqDbk4B
 nC/2TJ6S5xOlhc5g/rOTdd9ZpV4t5wNm6IlE5NRMVLB4078SAt8qLOzC0acULIyxJ5gPjkdNRvc
 RYgB4tZAzGmcxsDlzOw==
X-Proofpoint-GUID: hgfk4gpf1JbGkK1ka7uAw2vaZH8Q2VDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
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

Add logic to generate capsules through a config file while testing
the EFI capsule update functionality. The sandbox variant generates
its capsules by passing sandbox_capsule_cfg.txt to mkeficapsule with
-f, after binman has built the FIT image the payloads refer to. The
sandbox_flattree variant keeps generating them through binman, so
both paths stay covered.

Co-developed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v2:
- select the config file path by board in the test setup, using a
  fixed path and a preprocessor define for the binman devicetree,
  instead of the EFI_USE_CAPSULE_CFG_FILE and EFI_CAPSULE_CFG_FILE
  Kconfig symbols, which are dropped.
- run mkeficapsule before the filesystem image is created, so the
  generated capsules end up in the image
---
 test/py/tests/test_efi_capsule/capsule_gen_binman.dts |  2 ++
 test/py/tests/test_efi_capsule/conftest.py            | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
index 1a62c260474..11889f936d0 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -54,6 +54,7 @@
 		};
 	};
 
+#if !defined(CAPSULE_GEN_FROM_CFG_FILE)
 	capsule1 {
 		filename = "Test04";
 		efi-capsule {
@@ -165,4 +166,5 @@
 			};
 		};
 	};
+#endif /* CAPSULE_GEN_FROM_CFG_FILE */
 };
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index ad0cda59ebf..601d09b7b72 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -77,16 +77,25 @@ def efi_capsule_data(request, ubman):
 
         pythonpath = os.environ.get('PYTHONPATH', '')
         os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % ubman.config.build_dir
+        # sandbox generates its capsules through the mkeficapsule config
+        # file, other variants such as sandbox_flattree use binman
+        cfg_file_gen = ubman.config.board_type == 'sandbox'
+        cpp_opts = '-DCAPSULE_GEN_FROM_CFG_FILE' if cfg_file_gen else ''
         check_call('cd %s; '
-                   'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
+                   'cc -E %s -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
                    'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
-                   % (data_dir, ubman.config.source_dir, ubman.config.source_dir), shell=True)
+                   % (data_dir, cpp_opts, ubman.config.source_dir, ubman.config.source_dir), shell=True)
         check_call('cd %s; '
                    './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
                    % (ubman.config.source_dir, ubman.config.build_dir, data_dir, data_dir, data_dir), shell=True)
         check_call('cp %s/Test* %s' % (ubman.config.build_dir, data_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
+        if cfg_file_gen:
+            cfg_file = ubman.config.source_dir + '/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt'
+            check_call('cd %s; %s/tools/mkeficapsule -f %s'
+                       % (data_dir, ubman.config.build_dir, cfg_file), shell=True)
+
         # Create a 16MiB partition as the EFI system partition in the disk
         # image
         fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,

-- 
2.34.1

