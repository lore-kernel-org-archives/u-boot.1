Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gq8q7kFL;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJpzSq2l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8oFAel6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A8DB40761;
	Sat, 24 Oct 2026 17:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iMzS3mR3-r9H; Sat, 24 Oct 2026 17:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EC5440763
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863490;
	b=XbNXd2b2Fx0BuvoaEjcvU1R7ErsdlVxwz2bafAFaynh/4isigc3eJoGCwU/+0t8Q16IC
	 x5U8HQMU0J00x/pftQBxlONqzlkMckZdGopXePMTSHTqX3sQGigp+c6m17Kz+rx+DX1CZ
	 YNd/NJgIkZBxyv4IXc5QWqo0jjAT+ETj6BTzEaySGgTdFHQQ37U5U48nHLk7B/tJUTths
	 ZBAoE7FGeWD3Ge/ocEv2vgeYQ3W8/rERPnW45mq855ZU2TtbaYkgt1eQK88+aEIg5p3xz
	 qzsJew+DtyqYc1Sftl5PRExxoFZWRS1CYnkwE9xVXutpow14lKwbIbEKCGlj88NGf+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29YhhvOgns=;
	b=VhxLCKKElmHSwhCIkIIZXQSGC/8EYi4mq9jRqOjThvjY51KpGantfOkuPDKJoe+QZ/hB
	 IPT1VOeGie0ru+lNEHZ2ZrGNex9ADDZDfmhitaI5eGLlpGyvPfu4uWSjbreTWoS1zuxzU
	 8nZixmvSgMJjJfS/c3VMXQ06WcrnE/aE/Go6lXOBDBeXS5UxHkypRLU14ugKyGsWygiuH
	 fe+OElU/fuAp9nGWdnAyvVB61xIAXUwI7b12QvJix74QezbjJErr+YZ7Nzdvu/nW9d2S1
	 Ujo7Xmk4NlMIOAqFsIKYyb0n81DCT2LI2cJ4JFS+9ffTJ58cYjfC8+sJ0rTiQg1KYTQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863490;
	bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29YhhvOgns=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gq8q7kFLH9Yb8YopqCj2t+fuZWgArOvmhnNXtg7G7ELpfNUeHJFY2fNhpbGmd4MQM
	 CvMVeP9DXbYZ6OQyDqdToXYcScRov7S9+2LBoVRkZivbFWgu57EzXu29ehzAm+GNL0
	 kdtWmtg2itw/J6jLibm6DPXIRhrFS3L94JL4IlIss7Kr88shWGwTaagREWWwn/uaSd
	 wnudLmKKrrJeW47U9+Eq2gUPo+HP55F7lbtGYqaNj04gNPjClgazT0exMVDnUOJSRE
	 Rk1/CkNunyWi3vjaswRL6/sLslWzLqZ1TD4ceY60dZogpQ2VbkYaJo6SsygGTiAjKS
	 zHUwrwnp4fC9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EC5440763;
	Sat, 24 Oct 2026 17:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC6F4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 027BA60640
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qf5JCg-a_BJP for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:38:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B1976062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863488;
 b=glV9H4WfFS1SVixdDj2LRQIfm6nptF18+8EeTMnS3Dp/nJ1FHo9x5mik2vVnCQcP54jq
 QwdGhHY5MQnyNp5ed98I1Tt2umH2i0VnNJT7lL7XVcRStyq1stp6FXDjrmUvZFQr/qff/
 TiQoCYpM+YuCFZ18F+vzJDgvqy5XHJxOmY+mgGtMW7oM5uApxudqfxRA5YWppioXYdtVu
 0CZ3GhSE+KS0vFm6VPCyz89EZUdfUVtrjQNikm4jYWxTyMzSVLLDzfKaDnH3gXEOe1h7B
 6o1sAiEamL+K3FTa9lVCVpZzbhsR6GSX2U9o7BmV0FPfmkI61p/QiS+lr3EtuvL+lkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863488;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29YhhvOgns=;
 b=DDS4Mvy2CwTzw+vf6xGss85tKRT4hlR7r0B0UO7ntrXpOVeJl/7f8zmii2g12rSu2j2f
 aYUuSoZglHLQTKwvI7CLvFwjylE9JUm/3zxgZP3m7dzvh4vocKrQj0WHDaEA1LhhvRhbE
 o898Iu+Dcfn7d3V6GHt3cMz+RbrZBn/FBr0PONJXaOJu1nRzPhivJmVXhxmgCiDy1ekU1
 gSK6xAXR08zOHrxc/9vkIyvck1RBShZxOKN1fnrHgNuysXrhWrnhlB5q27XsgjRdL/qtq
 0+pip6tL6yB+ooOjCg2Q2tR/Df8hD7ThCMCcnb201oQL3EuPPTO4aDNJp41RE6lNFxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hJpzSq2l; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O8oFAel6; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hJpzSq2l; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O8oFAel6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B1976062C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF01fD2370853
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29
 YhhvOgns=; b=hJpzSq2l92ikjwo30dzBtnGzKpCjExafkE0jt9ekruSys5XsuPw
 iMQLWGQVC8Q3wR40NP9cb98zxckHXAxKjvPSWgSntCfUTkvsE3p278m46ESZyHT6
 PvKj+FMWGPrX79HlhMOJqg81/gdbeW2v7TQiKWIKYG1qPJ3pkXUDlTf5gD66V5bH
 Sxi+N4IQlShpKATar/42/N6S4PYazR/dO3GVM9zp91X9AwRg3Pqe/DiXSrdULlx5
 EX2u0ye6FxSuoAPjBbV3NUEYDMeyxtq6B+6UZaFwS5Rg70qg4/7T+Cr6sAhLwUgb
 vHRY9gaU+gnxtuFRvHJGa7oVMIMFZmNTZ3g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hk6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-17dc865c94cso1986491c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863484; x=1793468284;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29YhhvOgns=;
 b=O8oFAel6apFZcd9RKsG/qXWauB8kuZn/Lx67IQbXrUM4RDZ329DvT9Ds4ElQgzb91r
 VncUQ102gQEqrdA1CkFe0U/I3//DwHlH9BCD5Tgsic5eqAQeRib+M5Www+g+AnWERzU6
 GkkzINW39218G6Gf5MPgYLg/BIIyAohckDHdLL5xah4241rG9PGtFVBbIVR3FlqN9JhL
 ZsG1iVON3mvhbWIVcPT7wvYGtcjI4UFrdcn26uAxwgmxsyeEHDXw4vbmtAMbwHuFclIu
 in/Sz5waILrfC8YcZaREmJ563bFfN3P2vfFs65I4U42Mrv/8xjfZA8yhUkA9L5LFhqJP
 NlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863484; x=1793468284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c84Zm/xKML4lfv8CbEIvntlGTNvXOVqOu29YhhvOgns=;
 b=fAthrNT8cMRgf06MS4d2mncuUHGAdmDiMUaR7H/QsJYTbYrjHOe/nUTLW8MPn4jKli
 1bVP6bOnsP9V/Qwmh2NgESgrN63+JmyiWupcB1SY8iNBWVaAI6c5Rss0w5T+GNE3vaHB
 kE79Chi/QqqBB2Umx9qJONyjEB+FVAnCIGhEkckFt2BGD7ibpGRBP4T0Ml+2TeZ3DuT7
 dYDdWZhgzJ/IpNIJzgjflNOxOeXjlv7bRO45+XN4hXGGIqdcje7hhHoq0GlOTcEv82nr
 xQglLFmGhV9rvufi/tVrxdEpATaQBrlyBu9gh/37JtHQ+/WgF6ONAG9D6CV+Pr13evnp
 E/vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOArDEcOaRfgKpJUhHS+q7VEsaIoXahFqzEOfCBRmZ1aF1w5HUudnK4SnDL0sja7cR4i/5ba0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKmhdL6Vs5tISe5469fMxcr4c0KCSJF3RFF9g5ZUkXrY1D8/24
 TLbD/h56K+PzBzVuKopiUZfuKvAnNUK2MleQDs1hFgfz7lNhenIdKgAIIHdNbE/Opt9olWYEs2N
 PN9FeBKg7scMGko/uHSc38rJeTvw+naESFn/x3PnZWJybUPruI8eOhkvDwKCheBPLptgWTiA=
X-Gm-Gg: AYBFou25ycum8UKa3GVh8quGbhs8+GkcpQHKU2l1bjdBHoa3w5RSo0cFmm7pqIYEdFY
 /KAfIRf5rSqKLMnQ2Cfx+Tq/PBGfanNvmcI0J6nrUbG1x0FXp9sjd1HYdnD5D94HJN8+WXbbiaP
 IoU6xyrrdZ8nDn5afdXldrKLbrgVMAaO1UnLB/UWz/IPo6KLbxSKJi4+HLaoLLRokj03xCiyxK5
 ELjs5NL99ZiNhzfxhnfPkU7y5OLPlsCf8kZ2BI1saEVD+l7cF/luvqDz0BeeOjfP1aM/h6ZRfyX
 3HpE3OGXhoasPjsUhnnQIhfw9ceSHy6iFEQeEm2GDfYLh8ioTDjGrxGdaki8yVpavx1Cl/q6HzM
 yI/r8lFEQ7ef2uThMePF8G7PhdxYku45i0JDwoe8xu9QGVB+pFXQ4oWucrs5H3HjukUfpzXkllP
 BxMmYTBDQWzpCSRROnzRg=
X-Received: by 2002:a05:7022:38d:b0:147:8a40:cdf3 with SMTP id
 a92af1059eb24-199363a12fcmr4152152c88.24.1792863483965; 
 Sat, 24 Oct 2026 10:38:03 -0700 (PDT)
X-Received: by 2002:a05:7022:38d:b0:147:8a40:cdf3 with SMTP id
 a92af1059eb24-199363a12fcmr4152090c88.24.1792863483336; 
 Sat, 24 Oct 2026 10:38:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm10714248c88.6.2026.10.24.10.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:38:02 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, aristo.chen@canonical.com,
 jorge.ramirez@oss.qualcomm.com, smoser@brickies.net,
 ccaione@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/4] qcom: Reduce boot time by avoiding unnecessary
 initialization and probes
Date: Sat, 24 Oct 2026 23:07:45 +0530
Message-Id: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QtBziLxOkzJtH-U8WMFoMoxs9OXrH0fo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX+rdDZabhOI/5
 aTuBl8LV43YdUcCIhc6qY/Y8EuoyyV4bJNTa3WPwR4TQ43eABpJ5dqjjbz9GIhFFY0r5JG9N7aK
 5vGpw/RjsIHK/XWvrxDMS8vfamswdcY=
X-Proofpoint-GUID: QtBziLxOkzJtH-U8WMFoMoxs9OXrH0fo
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcecfd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=5l44by1dwXB3i3AiWJEA:9
 a=vr4QvYf-bLy2KjpDp97w:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX0RINXk2nUD/5
 rQfVE/Q9ryDgwLVIdydbuDY+1swSQvXbB1xbyGeI6QuSrelFO+sYoxTtvOMac5z4FQdMadyZ7CC
 dTPuIkJTQ1OzUwbYBuoaWTf7VTgAHAKcy55rXxn28OnPHzc01kz2QJ24HkUDedGsp35W6tRuYg/
 8Mo2cdDJJ7BbkIADgGA8cmV9SMUEKgZ8pX0gQ4g+VqPKsNLhXssXHXTIjw/woDejALV+815lFoK
 7Oyu/EWexkGfivyJ2hEpjwB8uRoE3UdIa9eSKJOdggbkx/j9LH41jc8NhvJ7YRQGI4JXTvwFgs8
 61XIYvJ/R7BxpaINr719FzhbPv8UBTOGSEiehNcdYMJejEJKzw4Wh1C7Q2vQtxeLqWDi/pokSaE
 TtB5OngxU9PIdbNaTqULSg/BkHko2rEH7EqB0HVIkNsBf5nR6A6y0CVzPp/7k3USNbUyk91fqp5
 heGhqTUh/+UZxxm9TLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240070
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series contains a set of boot time optimizations for Qualcomm SoCs,
targeting unnecessary initialization and device probing paths observed
during boot.

The changes reduce time spent in memory initialization, filesystem
probing, and redundant SCSI rescans, resulting in measurable boot KPI
improvements across Qualcomm platforms.

Boot time savings observed:

  - Disable malloc pool zero-initialization: ~74 ms
  - Skip redundant SCSI rescan for capsule updates: ~34 ms
  - prioritize ESP during boot manager default-file search
    to maintain fast boot performance: ~170 ms

Combined, these optimizations save approximately 278 ms during boot on
Qualcomm SoCs while preserving existing functionality.

Changes in v3:
- Address review comment by Defer filesystem probing from partition
  enumeration to OpenVolume(), avoiding unnecessary scans on unused partitions.
- Preserve boot support from any partition and prioritize ESP during
  boot manager default-file search to maintain fast boot performance.

Link to v2: https://lore.kernel.org/u-boot/20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Address review comment by adding scsi_scan_new() to discover new SCSI
  devices without removing existing ones, improving boot-time KPI by
  avoiding unnecessary rescans and replacing the uclass_id_count()
  guard in capsule update paths.

Link to v1: https://marc.info/?l=u-boot&m=178781570076393&w=2

Aswin Murugan (4):
  efi_loader: reduce boot time by deferring filesystem probes
  configs: qcom: disable malloc pool zero-init on boot
  scsi: Add scsi_scan_new() to scan only new devices
  mach-snapdragon: rescan only newly added SCSI devices for capsule
    update

 arch/arm/mach-snapdragon/capsule_update.c |  2 +-
 configs/qcom_defconfig                    |  1 +
 drivers/scsi/scsi.c                       | 27 ++++++++++++++++++++++
 include/scsi.h                            |  8 +++++++
 lib/efi_loader/efi_bootmgr.c              | 28 +++++++++++++++++++++--
 lib/efi_loader/efi_disk.c                 | 28 ++++-------------------
 lib/efi_loader/efi_file.c                 |  5 ++++
 7 files changed, 72 insertions(+), 27 deletions(-)

-- 
2.34.1

