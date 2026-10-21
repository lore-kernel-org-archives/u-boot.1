Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D9607D928
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UAnVFs6E;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n53bITXK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TVzi9A9t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 716306081D;
	Wed, 21 Oct 2026 16:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HL0CwhEbnOE8; Wed, 21 Oct 2026 16:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5393F605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599223;
	b=ph38CIlbknO2FVW/UYTOMM0Ankxig2n5b4YhjnUAonJFByRstv6Z7ajcz9fvb928zRkT
	 J8dbRevvFeK4l0pyXtCGHF7t2C3OqFBt98DtnCtSOnTHQwBwmVut/30KX9+beGOqGus99
	 2Vuz5PTDZi0an0AmrueMh1SuEM6AfGQmNcHIlL5Z+fJACyQuS3kuWt08qMZrgevqnZYLw
	 F9CJtflaXEYJoqYpXEXHjuueS8GfVFnG6tmTO5TQ2DUf94X8epLxprQvF4OrgybWA3ZRv
	 bnCScS/AGey06JmTGX0QvdcPoUrsY/gss3Nm3BBt808f3ixu5ZCs2sDdIu8TNAm7iRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bc+JDKFOdFYX7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=;
	b=nn6nZLAaaUwdnJUmBKSd/zGdoSwYAlOZYhtpVY98p7mGWpDZolmvMGTSWmjD9ZYIlMOD
	 lu9G444qaRA0v/0cS6EK4sJoMMvqGzBHgUblRYrxwMxkSLImpIBUm2Rw/Qam05Z3qSNLr
	 RKI3lm5N1yG1HHlxHhEyvEfGpPpzYD/6zGTBjtscLH8mCVynfs4LEhMK0vjRaoLiPhfh2
	 CJW1UcfyM7U+l5PvePvTynKGGzcwNl4NFTYd9gCahpRuJdjzz/f9w+sdJNbBvmxDYs5yK
	 TwHTdoGO2EkexcKsyrivvwDAIyXab1OQhH2pqnz7nQc654+soNJw+09LoIewTVwZNVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n53bITXK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TVzi9A9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599223;
	bh=Bc+JDKFOdFYX7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UAnVFs6EiYhjfU783NMNCGEHtOSDBUy++E+yNOnOYFZPvYBZKwM8BNrl5OIWnNSia
	 jeH2ueVmUWZG7RyTTyB/p9h/zcsSzmY+EO+Ifktr7iAfTHJ4mVPSlKviuyNP2ZJbbs
	 m69ru0uHgP/L2ucb7DzfeT6srGzDMzXfsmCblpe3cu+gGb8WHrTxC7eIP1JPSmAfqK
	 +Z+9tIikRVdNLHRN3wGDROpGdz0iB6gEFgs2RCrwXnyj6svzMriCjFgt32rdh01dfm
	 HT6oAUbur1K8B6zIoHqyD8FAoOG50y6uvrsY6jhGZ7dCxA0y0xhK2CD0tXJTPGItg/
	 bQ/rooMosqlSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5393F605EA;
	Wed, 21 Oct 2026 16:13:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B2211E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D2C060844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EU8rCi0Pnncp for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 574D46079B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599220;
 b=p1Xsh1V8/CiA0/VSmMSc/+lam6nzdOwBkx1tZYkrLWELh2u2FhgunXeTK9W/DZMGefaJ
 x5m36gIMJnllA0YWAFZYZvsgEyj0pf95WeFEeVfHSfAKs7m53kW9rlmDU0PVvRVOxnMYU
 GQ1PtEDQA7ta7l+YnMmzMPuQYClBIsK1OVGhnoZrCvwLxNPBaNv2kR/oPc5fabWU/E8uS
 ivFMWF1K28NjLzzW0qkoQgBcq2ugKezjHeJdwasJQT67dcpQcQwS43Shpitm/EbwaaXrs
 HNUgc6gj9gJt4VEcGeXU4guUYnumXsDbdriPlHyo5TDMWRQTynLbqKWSdDmcn3mQCiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599220;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Bc+JDKFOdFYX7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=;
 b=m1j9XMMnF8S8ZLaXdzdw9lWxDH72cku11TegAGOoZsevoucXc/7B2OlcbIVgiPeudsR4
 sclIm+K4TwGBU9DmJYTqSj4Wl0czZMj9MM6hhHQxZo+CAWnnDAsBHl2olXCX6ZrcZcYuE
 J/CNJYrCXiHvp90glL4oyR24FayeIk4uaol1BETV8SNFjA8dbsxKx+4z030scAkvnnD2I
 V42tpw5eFqH+FCrvT3QIpcWz04X3yC847k0lXZuWPGVSVo5uww9AtXGwll3o80hcd4joK
 xChqzuwIsjTVvh3Ux3d2/QtaGZURdX1syMoPvi1v28+6wuRPXR3J+gwtEV577lt3/bg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=n53bITXK; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TVzi9A9t; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=n53bITXK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TVzi9A9t
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 574D46079B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU2MU1481163
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bc+JDKFOdFY
 X7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=; b=n53bITXK9MDAPCyHi9E89Hx+stS
 VKBsxarS2nWMt85cCxMqJ0TuNcZSbF8n7KEeH0Ll6RAjixLvgjZ6KSActyfq7xxG
 Jz0ozPO+kyNHzoIp56Kq89ySlFH7ulLygAWaPv5qKrhN23wr5C60w1UnLnyl3Gpw
 0QyJSVUqyaQtp2AUWiqlaRS085neJokSasZ/8AykmpBXrOUhQSn7erG0Hoj/YHI3
 WtuDQkOx9YzD1NXP6aoFkFBxF/ASfzePDhQoXFapCX7JcfMyNt/53kmWdu9c3dvR
 09mYkXIumcd6Ebx1d66bME79cGCyplJ3g5cbDLURUhKZS3HIXcxjB5OQLzg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs044j6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so2922758c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599217; x=1793204017;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bc+JDKFOdFYX7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=;
 b=TVzi9A9tvPuikBxgDCR3fjwzZsvSy1GIUv6xG2jlORfv+ITmZ4YZJlfHwz5ntp9sAM
 CbZ+leogkXFLOhSyU3jpevzuknErjIzPP1YZ1cM9XVbeITz5QkIlwuMO6cDonPqtMXX8
 3j9oJRR1wn2Yt85Pwkg+f/5X51NuQqm4OeCnAsmZ7vpFzpKmoPvf5lASJFAYapE5oksn
 7J7gGSyNlb8UV69rQUGr6hHkdZAVrXy+CEJOyXX9niRt4o+Jqi6Ib4I6/42rDGPw5DXP
 L+s38bObFdZYWN8lvwnJstaiprfJWeWZS0uomB0nzh7WsoIz4UtIuWmbmBU2xtIhlJQ6
 cDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599217; x=1793204017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Bc+JDKFOdFYX7q93lVNPc4tQ7PLVaM0LseZ8JpcNXvw=;
 b=wJOB8qBhq0X90jJVhr3XStWKSKO1AhvmhPPzMjd95Dmwq8IQFF+jAsq2vs3bwljag/
 sDti+W1ETS80oELXCSsl17vF4iHbUVkgq52W0/on37jsf1Q0UuY+hg30DBVY9fh2NOXs
 gQ/hizgq7qGQst07GqU5t+y7wYLveFFWFMeGgNQYVmRrNwzZotwpFyO9z8JsgrPd6VKp
 EnKZ7YmW6TMd0RV+K+L8Cgf/0yQBqke892xjBElUMRD1adgPxsCJ7eQh3QYXhD5+koLI
 n0SObvuqO4tW9skl59+LbFnydlIzpHBkyavTmP7543qkT8SKoJqxq+ad0fSJO3DVe6ac
 zFvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx10+5r20U/5O+quzJ0tepfrKbMV3KZOk5W81+QV89wVPPcRMOEuNDaQmdyBqEe/W51AeBdixE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8PMQNvmdt2qzD3ppwq3Dwvzf5oiPnud+FK1WmBydBQVDbq/MJ
 cB6UygoLR2TeUDVeDq1ZYXaiixjTPlSiATUwrdUFA/okR9uL4rZe+Ue1t7V3TzqlA7wgFgkT4Fj
 ec9Xmz8Zy3umCmXNBi05vGPQM9p0QAgkoZTH9f1vsYr2vq+SYTFKFshkNopNK3r86aeXtA6k=
X-Gm-Gg: AYBFou25T13BCham35j7pU2ki7wRErEMJpvNql0UmKfy1VR0f/R7tLnbZ12NdqyNCVm
 nJpuYjy8wIVKWK1k/gSF8wNsaY7i/OM9jvLcELH9VboC7Khea9m+tbVcpd433uRdrwKgrH3RhP8
 wwcBIu0j+qwpK27z5FApMNZ6hriE37WDlhaaLjNqvshOHbIgCOFmtH+Xr9HjduZgtDWx9shZaT1
 JIvCZ/jw2hzyGD0a9qiqDmGvKb+8wJnO9YEDtUXAmRzOcVhsAZD7udPW3QSG9qhnR7QMyfwNUgW
 kloK9ImZQTPAEVeJ52kYYMLctMtNiOHWjXOntM8WeIGe94INu1NK57yjcTAaRwz87Wyqm2XtFSe
 Aj+pVJSXUAY/Qsf85wEL74eoPucPXGXJDORfRrEr0PQ2bo8gm+UIJFqhu7bST85vjNbQMwoxame
 wjoKMJZaHOH/tX0S1cglg=
X-Received: by 2002:a05:7022:60a:b0:152:3812:496a with SMTP id
 a92af1059eb24-190a97f54b3mr4237503c88.43.1792599216354; 
 Wed, 21 Oct 2026 09:13:36 -0700 (PDT)
X-Received: by 2002:a05:7022:4583:b0:186:3f0c:bd09 with SMTP id
 a92af1059eb24-190a051dd76mr4569955c88.5.1792598716964; 
 Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 1/8] clk: qcom: add GCC driver for nord
Date: Wed, 21 Oct 2026 21:34:41 +0530
Message-Id: <20261021160448.3893858-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8e4b2 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=80mdcwNe0BwfYoIDu2YA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4hUyKrG/qUYu
 xbR1w/UvRqswqGY5g09c1ZX3PEI2az9jKF5WkQJs0/k2jjClToh+clhZpx3zXugR8XEZYOLAvth
 E8s2BFTTCiNEsFUfmAyf2sryi2jMLFo1rBfFQRxI7VLutT4FDGWjXeBisytiZ2JdBrF0+fAS2We
 Dy5HQ+sCeCA0LxF1ByVz8r2UJZGweNIwbbJI58G2JC/i4oT+xLlwuWhulWvJ+IHJTKvtqg22Y2m
 b+9MdREnrsN4gYYvN29GLps95IZJtkrqZt3yhgU7Pyih5riL+kC2iHQDFMv76AdmKSJqONqWAo7
 3yB66LelmiE8fOtmzPf9CzaIbkLmJwcQqU0OjnqY3gR/GYwc3dfrr5Tqa1V2dI52Mix4hwRkr/Q
 8HQ59sDmhpcsCVwGaVgduFxvmWTGA8QIH6pXokH5WgpyLkWkB3wXk4NmU2jjVKHPGMRr8V/nT6I
 x6ZWhoVwFJLZYd2Z/rw==
X-Proofpoint-ORIG-GUID: a1qHWnUDIZMwFBxQnR0mlSikgo5ayRep
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXxLkRLrvuCg56
 ooNDXDjx0ThP/mi8F6lpBA6QStXv/aOFIjidJ70CAkxSr9rniOVPLP9XHjkq8ibdPGVf7wxjA8g
 aKmzRO2G4WT3Em5BdBQdghYI1EyQRcg=
X-Proofpoint-GUID: a1qHWnUDIZMwFBxQnR0mlSikgo5ayRep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Add support for the nord Global Clock Controller (GCC).

Implement the qcom,nord-gcc driver to provide clocks, resets and
power domains required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig          |   8 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/clock-nord-gcc.c | 165 ++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1a7957e2201..7228d5ecbf9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
 	  on the Snapdragon Milos SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_NORD
+	bool "Qualcomm Nord GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon Nord SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 58d8166072d..193740682aa 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-gcc.c b/drivers/clk/qcom/clock-nord-gcc.c
new file mode 100644
index 00000000000..af38b3b1daa
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-gcc.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-gcc.h>
+#include "clock-qcom.h"
+
+static const struct gate_clk nord_gcc_clks[] = {
+	GATE_CLK_POLLED(GCC_MMU_0_TCU_VOTE_CLK,      0x7d094, BIT(0),  0x7d094),
+	GATE_CLK_POLLED(GCC_PCIE_A_AUX_CLK,          0x9d008, BIT(14), 0x49058),
+	GATE_CLK_POLLED(GCC_PCIE_A_CFG_AHB_CLK,      0x9d008, BIT(13), 0x49054),
+	GATE_CLK_POLLED(GCC_PCIE_A_PHY_AUX_CLK,      0x9d010, BIT(12), 0x4d01c),
+	GATE_CLK_POLLED(GCC_PCIE_A_PHY_RCHNG_CLK,    0x9d008, BIT(16), 0x49078),
+	GATE_CLK_POLLED(GCC_PCIE_A_SLV_AXI_CLK,      0x9d008, BIT(11), 0x4902c),
+	GATE_CLK_POLLED(GCC_PCIE_A_SLV_Q2A_AXI_CLK,  0x9d008, BIT(10), 0x49024),
+	GATE_CLK_POLLED(GCC_PCIE_B_AUX_CLK,          0x9d008, BIT(23), 0x4a058),
+	GATE_CLK_POLLED(GCC_PCIE_B_CFG_AHB_CLK,      0x9d008, BIT(22), 0x4a054),
+	GATE_CLK_POLLED(GCC_PCIE_B_PHY_AUX_CLK,      0x9d010, BIT(13), 0x4e01c),
+	GATE_CLK_POLLED(GCC_PCIE_B_PHY_RCHNG_CLK,    0x9d008, BIT(25), 0x4a078),
+	GATE_CLK_POLLED(GCC_PCIE_B_SLV_AXI_CLK,      0x9d008, BIT(20), 0x4a02c),
+	GATE_CLK_POLLED(GCC_PCIE_B_SLV_Q2A_AXI_CLK,  0x9d008, BIT(19), 0x4a024),
+	GATE_CLK_POLLED(GCC_PCIE_C_AUX_CLK,          0x9d010, BIT(0),  0x4b058),
+	GATE_CLK_POLLED(GCC_PCIE_C_CFG_AHB_CLK,      0x9d008, BIT(31), 0x4b054),
+	GATE_CLK_POLLED(GCC_PCIE_C_PHY_AUX_CLK,      0x9d010, BIT(14), 0x4f01c),
+	GATE_CLK_POLLED(GCC_PCIE_C_PHY_RCHNG_CLK,    0x9d010, BIT(2),  0x4b078),
+	GATE_CLK_POLLED(GCC_PCIE_C_SLV_AXI_CLK,      0x9d008, BIT(29), 0x4b02c),
+	GATE_CLK_POLLED(GCC_PCIE_C_SLV_Q2A_AXI_CLK,  0x9d008, BIT(28), 0x4b024),
+	GATE_CLK_POLLED(GCC_PCIE_D_AUX_CLK,          0x9d010, BIT(9),  0x4c058),
+	GATE_CLK_POLLED(GCC_PCIE_D_CFG_AHB_CLK,      0x9d010, BIT(8),  0x4c054),
+	GATE_CLK_POLLED(GCC_PCIE_D_PHY_AUX_CLK,      0x9d010, BIT(16), 0x5001c),
+	GATE_CLK_POLLED(GCC_PCIE_D_PHY_RCHNG_CLK,    0x9d010, BIT(11), 0x4c078),
+	GATE_CLK_POLLED(GCC_PCIE_D_SLV_AXI_CLK,      0x9d010, BIT(6),  0x4c02c),
+	GATE_CLK_POLLED(GCC_PCIE_D_SLV_Q2A_AXI_CLK,  0x9d010, BIT(5),  0x4c024),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_CNOC_SF_QX_CLK, 0x9d010, BIT(24), 0x52040),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_M_CFG_CLK,      0x9d018, BIT(4),  0x52060),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_M_PDB_CLK,      0x9d018, BIT(8),  0x52084),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_PWRCTL_CLK,     0x9d018, BIT(7),  0x52080),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_QOSGEN_EXTREF_CLK, 0x9d010, BIT(19), 0x52074),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_SLAVE_AXI_CLK,  0x9d010, BIT(26), 0x52058),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_S_CFG_CLK,      0x9d018, BIT(5),  0x52064),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_S_PDB_CLK,       0x9d018, BIT(9),  0x5208c),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_TSCTR_CLK,      0x9d010, BIT(18), 0x52070),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_XO_CLK,         0x9d018, BIT(6),  0x52068),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK,             0x1a004, BIT(0),  0x1a004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x9d000, BIT(24), 0x23020),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK,    0x9d000, BIT(23), 0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_M_CLK,       0x9d000, BIT(22), 0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_REF_CLK, 0x9d000, BIT(26), 0x23170),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK,      0x9d000, BIT(25), 0x2315c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S_AHB_CLK,   0x9d010, BIT(15), 0x23008),
+	GATE_CLK_POLLED(GCC_SMMU_PCIE_QTC_VOTE_CLK,  0x7d0b8, BIT(0),  0x7d0b8),
+
+	GATE_CLK(GCC_BOOT_ROM_AHB_CLK,          0x1f004, BIT(0)),
+	GATE_CLK(GCC_GP1_CLK,                   0x30000, BIT(0)),
+	GATE_CLK(GCC_GP2_CLK,                   0x31000, BIT(0)),
+	GATE_CLK(GCC_PCIE_A_DTI_QTC_CLK,        0x9d008, BIT(8)),
+	GATE_CLK(GCC_PCIE_A_MSTR_AXI_CLK,       0x9d008, BIT(12)),
+	GATE_CLK(GCC_PCIE_A_PIPE_CLK,           0x9d008, BIT(15)),
+	GATE_CLK(GCC_PCIE_B_DTI_QTC_CLK,        0x9d008, BIT(17)),
+	GATE_CLK(GCC_PCIE_B_MSTR_AXI_CLK,       0x9d008, BIT(21)),
+	GATE_CLK(GCC_PCIE_B_PIPE_CLK,           0x9d008, BIT(24)),
+	GATE_CLK(GCC_PCIE_C_DTI_QTC_CLK,        0x9d008, BIT(26)),
+	GATE_CLK(GCC_PCIE_C_MSTR_AXI_CLK,       0x9d008, BIT(30)),
+	GATE_CLK(GCC_PCIE_C_PIPE_CLK,           0x9d010, BIT(1)),
+	GATE_CLK(GCC_PCIE_D_DTI_QTC_CLK,        0x9d010, BIT(3)),
+	GATE_CLK(GCC_PCIE_D_MSTR_AXI_CLK,       0x9d010, BIT(7)),
+	GATE_CLK(GCC_PCIE_D_PIPE_CLK,           0x9d010, BIT(10)),
+	GATE_CLK(GCC_PCIE_NOC_ASYNC_BRIDGE_CLK, 0x9d018, BIT(18)),
+	GATE_CLK(GCC_PCIE_NOC_MSTR_AXI_CLK,     0x9d010, BIT(25)),
+	GATE_CLK(GCC_PCIE_NOC_REFGEN_CLK,       0x52078, BIT(0)),
+	GATE_CLK(GCC_PCIE_NOC_SAFETY_CLK,       0x5207c, BIT(0)),
+	GATE_CLK(GCC_PDM2_CLK,                  0x1a00c, BIT(0)),
+	GATE_CLK(GCC_PDM_XO4_CLK,               0x1a008, BIT(0)),
+};
+
+static int nord_gcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_gcc_resets[] = {
+	[GCC_PCIE_A_BCR] = { 0x49000 },
+	[GCC_PCIE_A_LINK_DOWN_BCR] = { 0xb9000 },
+	[GCC_PCIE_A_NOCSR_COM_PHY_BCR] = { 0xb900c },
+	[GCC_PCIE_A_PHY_BCR] = { 0x4d000 },
+	[GCC_PCIE_A_PHY_CFG_AHB_BCR] = { 0xb9014 },
+	[GCC_PCIE_A_PHY_COM_BCR] = { 0xb9018 },
+	[GCC_PCIE_A_PHY_NOCSR_COM_PHY_BCR] = { 0xb9010 },
+	[GCC_PCIE_B_BCR] = { 0x4a000 },
+	[GCC_PCIE_B_LINK_DOWN_BCR] = { 0xba000 },
+	[GCC_PCIE_B_NOCSR_COM_PHY_BCR] = { 0xba008 },
+	[GCC_PCIE_B_PHY_BCR] = { 0x4e000 },
+	[GCC_PCIE_B_PHY_CFG_AHB_BCR] = { 0xba010 },
+	[GCC_PCIE_B_PHY_COM_BCR] = { 0xba014 },
+	[GCC_PCIE_B_PHY_NOCSR_COM_PHY_BCR] = { 0xba00c },
+	[GCC_PCIE_C_BCR] = { 0x4b000 },
+	[GCC_PCIE_C_LINK_DOWN_BCR] = { 0xbb07c },
+	[GCC_PCIE_C_NOCSR_COM_PHY_BCR] = { 0xbb084 },
+	[GCC_PCIE_C_PHY_BCR] = { 0x4f000 },
+	[GCC_PCIE_C_PHY_CFG_AHB_BCR] = { 0xbb08c },
+	[GCC_PCIE_C_PHY_COM_BCR] = { 0xbb090 },
+	[GCC_PCIE_C_PHY_NOCSR_COM_PHY_BCR] = { 0xbb088 },
+	[GCC_PCIE_D_BCR] = { 0x4c000 },
+	[GCC_PCIE_D_LINK_DOWN_BCR] = { 0xbc000 },
+	[GCC_PCIE_D_NOCSR_COM_PHY_BCR] = { 0xbc008 },
+	[GCC_PCIE_D_PHY_BCR] = { 0x50000 },
+	[GCC_PCIE_D_PHY_CFG_AHB_BCR] = { 0xbc010 },
+	[GCC_PCIE_D_PHY_COM_BCR] = { 0xbc014 },
+	[GCC_PCIE_D_PHY_NOCSR_COM_PHY_BCR] = { 0xbc00c },
+	[GCC_PCIE_NOC_BCR] = { 0x52000 },
+	[GCC_PDM_BCR] = { 0x1a000 },
+	[GCC_QUPV3_WRAPPER_3_BCR] = { 0x23000 },
+	[GCC_TCSR_PCIE_BCR] = { 0xb901c },
+};
+
+static const struct qcom_power_map nord_gcc_gdscs[] = {
+	[GCC_PCIE_A_GDSC] = { 0x49004 },
+	[GCC_PCIE_A_PHY_GDSC] = { 0x4d004 },
+	[GCC_PCIE_B_GDSC] = { 0x4a004 },
+	[GCC_PCIE_B_PHY_GDSC] = { 0x4e004 },
+	[GCC_PCIE_C_GDSC] = { 0x4b004 },
+	[GCC_PCIE_C_PHY_GDSC] = { 0x4f004 },
+	[GCC_PCIE_D_GDSC] = { 0x4c004 },
+	[GCC_PCIE_D_PHY_GDSC] = { 0x50004 },
+	[GCC_PCIE_NOC_GDSC] = { 0x52004 },
+};
+
+static struct msm_clk_data nord_gcc_data = {
+	.resets = nord_gcc_resets,
+	.num_resets = ARRAY_SIZE(nord_gcc_resets),
+	.clks = nord_gcc_clks,
+	.num_clks = ARRAY_SIZE(nord_gcc_clks),
+
+	.power_domains = nord_gcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_gcc_gdscs),
+
+	.enable = nord_gcc_enable,
+};
+
+static const struct udevice_id gcc_nord_of_match[] = {
+	{
+		.compatible = "qcom,nord-gcc",
+		.data = (ulong)&nord_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord) = {
+	.name		= "gcc_nord",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

