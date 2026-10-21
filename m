Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417B606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UF9J0chF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i5XbRh/R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CN565jzx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972FF608AA;
	Wed, 21 Oct 2026 12:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXXOe4C35k4z; Wed, 21 Oct 2026 12:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6983060852
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587370;
	b=hgZHp9vxBUavLMaxVIt2ghuMFu0CzZO9Ts5o/dcmeho07bVrE0l5J6YQO35e2fNorXXC
	 xSbpVaSWZ+SVdgQWBCvvKLyhByS++22FapYp7TfPlBEENHsGmSl313t3qFIaoHDgfiie7
	 hLpDzKHJI/NVpV+W5ywNnoph17rG2nuczaCIotqjQjH4FDuTg8z+aMxLHYX4zJRLbrQ09
	 H90YGqjYrJVPFoS5treZCZsTn9lnvk+3LCim00Glb9jdtQlsyM5XpAROKn6jVaX6a5CeI
	 gd265mj2sn2iwrRUetud4u4s47EWHoKqAISwevgdE33kKdfTq1+0kN+mD6Ngg9tA99w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=;
	b=WhLtUEhcYiwCx7Q8Aijhr8soOzzcZS6s+HrAaVEK19bIko1kNQnryZpfP+HzqWd0txbx
	 tkFZk8WjjXq4eG5HuiAPhvJ8r9dJpmhFw0C3Ru+jLGcz3gfyPDrXBnbiHrsygimuKuc/x
	 JMDKPVQMizOt5p1d3Fx+h44+VrK/oOHOOGv13k624noYFzaJuo6WatI95uDqIwEH6AqZ2
	 gFIsRTLheubF8tqIzaug3pP0d4/G7oIlJTLtC31So9eRW45WdgDaJn5rklU806za3sT53
	 MWEj5w3ZhUJPVVSU+S04BX82RlZHZP+FIAlVVYvHhFT+o//Lcvu6vvjThShVlzX2ZxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587370;
	bh=fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UF9J0chFD2QTlguFdaHnN2lIwzlir+X1OtxSTu74bwpZY8WVYuk8FvwN00VYOA2I3
	 G6KQFaPX3OvcA6Dyh5HSVSrW9fLTyyCJ/mzTx+bGHpmKvxlEYBZMoGs7PQ85dA24sy
	 ztqNV5WMLE0APgRB2ZApJ36hjnWjxMcloVPIHusG0byKXcXwO3x4RcuX2UQ80+rpxz
	 pBcCAgUZIsTfcIndOdK5mi2Rcys6g1mpZEpQD4nRrFrh/LiakPqv6omWTVJst4N5rb
	 MgqwGTXE19qWJ4XXjgMzcAyn3mRgnwfZAdCghLMpAWEli/cowGqGieN9c6ORXYstaU
	 /JSYaPX9hNZAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6983060852;
	Wed, 21 Oct 2026 12:56:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E0F45765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2932810A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ND1tZc-oCl_G for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98D6280E0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587367;
 b=kU4JTCEV04xVMSQwvK39EvcYH7zvo5ZmRdkyAYjmq5M4dwsTIacg0G2Lm0ommLFJu4MC
 9ZsPfosd8zDyMOroQlipzLpQI/skEtCYXx114QIKOoPFp6yHqe/toJNU21zB+nvIgohtZ
 qjNLYsHcVb2+uHsaY6uCFhXFikYp1FbUzfzH3HXu46VbGWkTQQ0YT5G8z8ohzR0KacFw4
 hcm3Ze9qBsTkZU2Srinqml6SHMogGJXzqDmjvpsLgHV/am070feapF4rwog0pl6DXCDuH
 jieS4yA77LFXPntn1g6Ro3fJKUE8m5QTaNTYUd60SAnlRz7HLTlhDzdJf7sjyenW7Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587367;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=;
 b=Zn6Uy9WTqcYxU3AbeavjveoMkj8VGFcLqCWXmb/aX/2DPx4Z3+M7N59nxZ3hV9G5zDV+
 AET5ZJuJzfnELmt9aS5jq8qC43vvq6XjW2qEwQu9wuxNCQv5P9W0A5D4ZQ8V5nNvPquxg
 P6/TvTTPAN4zWOFBOJ5h01ckm1zx3hDIgV6gpD9ZusbCHjbtNXTgpX/G5e2CvcPs2TnuU
 63jVWNfu3Uztu7ljBxJz0baZSgwmu/KZysa5RjCCLidSGNH1AfU9Mt+TuA3YOgbZ7mO0/
 i8ixK4x7WWUYxcZxGTA4FeHigY/N9UpptSUQzzYfAAV7tlnghH4TSejq5tdUZHZskNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="i5XbRh/R"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CN565jzx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=i5XbRh/R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CN565jzx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98D6280E0F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:56:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg9Yd1054282
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=; b=i5XbRh/RWlILGRpk
 YeexJpNf8M5aXIe6ZOw6+uiUCcuKTCpeANfgiVSw8eclOX6Qfl+Um2Efro2l4No5
 iK2D+TjkFtccjVEPwOeesr+7QjSM892OD1DBdLrwmamc+rhncg72icsUeOD9CUAg
 vlSBUwsjMkMuOtGY1IvO5JaD9ZeSUXo9QvuoVzcKZel50xJ+6DIepG2ds+d0ddou
 PRfTVRrBjf5V66/6qJMaE1d3kYFgcSOzCCohcpitqqhhnJVRLvL3FIjlmpULDNrg
 QoKTmF1zEv/IMgu/2hPJsgAV33wm9BKQ9S2RX+gnMPyjB6pAChZ+mELYEJcZvxuX
 xRspPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajkxnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:56:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1327120eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587364; x=1793192164;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=;
 b=CN565jzxJLgsJTtkqtoBPJpK0K96DdIIz6U5EA5c1N5yvp5Yh6QDTf5tsrMbxrXZxs
 qaEdetM0ec9v5GoHmgOFAGPAZr+SwFQEHjYS+tKuS9n2s3+nxcffOIjR4MANjxVHJHcf
 FdDfMhJpEjCkSZVklZeiqnSmlSf3Ghc2s2troCEiSDT9AnlysWEdAZrbPoGXuyRCGpFI
 diWg5jM4ZZuY85uoB7tMYjm8ikvI8zZkoAqfyJNvNQmWK8u8N9Ja1bQOMPcQrfmFubXx
 K9j9UjFWDZ0LS6x/++wihQiG3STi4o3pe56ckKg25Y8PgfuwGV1on5LmRKhp1aR9SBhG
 4GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587364; x=1793192164;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fqH/Ei+tEvOna+xymyWFKWW6EidMzJBXRRKT6TWbgHg=;
 b=GCpqI2DtTQxPYvLonjj7HRU+Uls8yaT17CgiPGvXs8aRKHKDzyj3hnxeww6PCSikIn
 DPrETlt72gH4WLsnC/r7abxzvD45mKQMmUTqG0W0RS4MDLRqxyZANteH62976vqIimry
 r6Tasqggx35Xhm33aSeCnAbWtlOaPu9KwD1ISTm6k5VfhIsRhekNWacBgx9l6s6iqNY2
 8Fw/tiuaR43Vrg8iFdQB6VNKAexYDx0BlW+s/Y25LD/nWcBcP0LbsIjhK6FvaItBHXIF
 4aBAkstFCd35MH4TatU66p1yXJ6+BRrl+NBSffvFhagen7bVEkfe/tgWUBL8Y97RWoyq
 RHNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb7QpKJqzhgmF3LH9y6oy498EnxyFBnaY94tT13GevE9rucjgZ8e1DWnirl1MoWWij2LgA20Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKti7sAJ+DPXHFhWngrYIoQrz2Nb4HNsTqQ3LLBWxa/pCrzWgTi
 DE98uvM02p844nz5l18ui+oRpBkVLRIzWekDTsxc0qaF/UkkWKUCa1uUxKlqvUKMOp06siydun2
 0uQ5fX15gUnz9Vrmr4YZlto2/iW3kjNVqJwfia9Q6gGwZ73duHLwFgJg+o5/3RNH3vprd48E=
X-Gm-Gg: AYBFou20xkaP+e6vfU4hMgdwD09J7JztLs3JhXktgtpALBqF3Ix3235UzV2VxdhJgUU
 f0IMbJ1b91HsOwyBhSeucBpTIeMt5cAvRj3ouEY104BEj9bT3Hp4966VcLUk1AuF0DgM3wAoeXJ
 KqAF3zztW87+aczVAH8ZsX+5jJoJrkSGFGhXOAhYicNNo72VpYzGug3CD6QcNAiLaAjnkfVZINp
 RcsgsZLumMJFRdH4pyj/j9slfg/1XErAtiFJXqFi/IWZdZ8kwsk+GgoNfpZSl4SId5E/XWc2NWy
 4b/qo7v8gZ/86DqxU2rpQZMIz/fOcB4t7qbWHNGogzxr3BJ2ZqouL3+ax9mv77iG/KjX7weAVdS
 gK00PoibGAHY/wpKEnMZTWLwrnfj0bOTSIeruT+4lGPnU
X-Received: by 2002:a05:7301:4549:b0:366:5ba9:9752 with SMTP id
 5a478bee46e88-3674de50c39mr2844279eec.25.1792587364295; 
 Wed, 21 Oct 2026 05:56:04 -0700 (PDT)
X-Received: by 2002:a05:7301:4549:b0:366:5ba9:9752 with SMTP id
 5a478bee46e88-3674de50c39mr2844230eec.25.1792587363333; 
 Wed, 21 Oct 2026 05:56:03 -0700 (PDT)
Received: from [10.152.192.83] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ec6c3sm8703103eec.7.2026.10.21.05.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:56:02 -0700 (PDT)
Message-ID: <f9560ddc-8a6a-4fca-a838-4a1a5657bab2@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 18:25:55 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] i2c: geni: Add 32MHz clock and chip probing support
To: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
 <3780de1d-4101-4e53-a8f4-702dc72de78d@linaro.org>
Content-Language: en-US
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <3780de1d-4101-4e53-a8f4-702dc72de78d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX2y498HQIW5lu
 TEj6FhApae1lg7vxHH7hh6o1ujrhwYcmJJZcaebTrztpz5OpFeQ2AVeme7Kakwa7xP14CWE316O
 MX500o/LWc5sYCPjS6Gc0wakbzNAFIYbYbY3SDlHe8wqkhqu9q9+N7DsO5sdDobEVR1HJwxsfa/
 EbUQtDMy3nEN3KSGAJEFt+I+Ifp1MoeGGG0r2MPV76lGDijOhipNjYnJhQnncHSmvpwBNy9DX2b
 ZS4gPKqj2FBwiBFY3PRz4ylzfP/TyZatrA/nxOMv0H3B7oDWXxQMtHvPo3pLKpdSO3wITQO/5TN
 4ejaNRYcMaNxYRnnI+WR5T7MDFNpDEP0BhTOcrsn7K9uSf/0XkZ/1lymnSQuknjXNFU4Dr4kA+1
 9wGwC+YSEszrdm1nD+uc56UlcPNYqBnHMxPQL+3VRIoxL3LNiibzXdcefJPFbzdE2ANbIHtRTwU
 23LRm9Mg9Sc+xMRgu0Q==
X-Proofpoint-GUID: fDUWVNIu0oFWWfu0bNCk8gjPQf2QyUHS
X-Proofpoint-ORIG-GUID: fDUWVNIu0oFWWfu0bNCk8gjPQf2QyUHS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXy8WeIoITKX+i
 vQ4XclP78HRVFdf2QyVf0dhUQEvGETJU71AaipT69evUF2JorgGiSXeBIvn2psHXVTGrhqCBH9U
 a/zMdvNL84f6iJ5B6pH9p65muR5RZpQ=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad8b665 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=s2jHZ4EfBlJVZREwa3gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Neil Armstrong,

moved to separate commit in v2 patch set, please refer: [PATCH v2 5/7] 
i2c: geni: Add chip probing support - Gurumoorthy Santhakumar

<https://lore.kernel.org/u-boot/20261021125003.2948090-6-gurumoorthy.santhakumar@oss.qualcomm.com/>Regards,
Gurumoorthy

On 10/20/2026 2:33 PM, neil.armstrong@linaro.org wrote:
> On 10/7/26 19:41, Gurumoorthy Santhakumar wrote:
>> Add support for 32MHz GENI SE clocks through dedicated timing tables
>> selected via the qcom,geni-se-clk-32mhz DT property. Also add chip
>> probing support.
>>
>> Depends on:
>> misc: qcom_geni: Add minicore support
>> Link: 
>> https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/
>>
>> Signed-off-by: Gurumoorthy Santhakumar 
>> <gurumoorthy.santhakumar@oss.qualcomm.com>
>> ---
>>   drivers/i2c/geni_i2c.c | 76 ++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 66 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
>> index 7498cbcb41a..9edba3dd551 100644
>> --- a/drivers/i2c/geni_i2c.c
>> +++ b/drivers/i2c/geni_i2c.c
>> @@ -96,18 +96,35 @@ struct geni_i2c_priv {
>>    * clk_freq_out = t / t_cycle
>>    * source_clock = 19.2 MHz
>>    */
>> -static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
>> -    {I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
>> -    {I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
>> -    {I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
>> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>> +    {I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
>> +    {I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
>> +    {I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
>>   };
>>   -static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, 
>> unsigned int clk_freq)
>> +/* source_clock = 32 MHz */
>> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>> +    {I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
>> +    {I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
>> +    {I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
>> +};
>> +
>> +static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
>> +                unsigned int clk_freq, bool use_32mhz)
>>   {
>> -    const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
>> +    const struct geni_i2c_clk_fld *itr;
>> +    int array_size;
>>       int i;
>>   -    for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
>> +    if (use_32mhz) {
>> +        itr = geni_i2c_clk_map_32mhz;
>> +        array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
>> +    } else {
>> +        itr = geni_i2c_clk_map_19p2mhz;
>> +        array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
>> +    }
>> +
>> +    for (i = 0; i < array_size; i++, itr++) {
>>           if (itr->clk_freq_out == clk_freq) {
>>               geni->clk_fld = itr;
>>               return 0;
>> @@ -262,6 +279,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv 
>> *geni, struct i2c_msg *msg, u32
>>       return geni_i2c_fifo_rx_drain(geni, msg);
>>   }
>>   +/* Probe to see if a chip is present. */
>> +static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
>> +                   uint chip_flags)
>> +{
>> +    struct geni_i2c_priv *geni = dev_get_priv(dev);
>> +    u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
>> +    u32 status;
>> +    ulong start;
>> +
>> +    (void)chip_flags;
>> +
>> +    /* Add delay before chip detect to prevent the bus going 
>> undefined. */
>> +    mdelay(1);
>> +
>> +    qcom_geni_i2c_conf(geni);
>> +    writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
>> +    geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
>> +    writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
>> +
>> +    start = get_timer(0);
>> +    while (get_timer(start) < I2C_TIMEOUT_MS) {
>> +        status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
>> +        if (status & M_CMD_DONE_EN) {
>> +            writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
>> +            return (status & SE_I2C_ERR) ? -ENODEV : 0;
>> +        }
>> +        udelay(10);
>> +    }
>> +
>> +    return -ETIMEDOUT;
>> +}
>
> This probe_chip callback is unrelated to this change, move it to a 
> separate commit.
>
> Neil
>
>> +
>>   static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg 
>> msgs[], int num)
>>   {
>>       struct geni_i2c_priv *geni = dev_get_priv(bus);
>> @@ -468,6 +517,8 @@ static int geni_i2c_probe(struct udevice *dev)
>>       ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
>>       struct geni_i2c_priv *geni = dev_get_priv(dev);
>>       u32 proto, tx_depth, fifo_disable;
>> +    u32 clk_freq;
>> +    bool use_32mhz;
>>       int ret;
>>         geni->is_master_hub = dev_get_driver_data(dev) & 
>> GENI_I2C_IS_MASTER_HUB;
>> @@ -538,19 +589,24 @@ static int geni_i2c_probe(struct udevice *dev)
>>       geni_i2c_config_packing(geni, BITS_PER_BYTE,
>>                   PACKING_BYTES_PW, true, true, true);
>>   -    /* Setup for standard rate */
>> -    return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
>> +    clk_freq = dev_read_u32_default(dev, "clock-frequency",
>> +                    I2C_SPEED_STANDARD_RATE);
>> +    use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>> +
>> +    return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>>   }
>>     static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned 
>> int clk_freq)
>>   {
>>       struct geni_i2c_priv *geni = dev_get_priv(dev);
>> +    bool use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>>   -    return geni_i2c_clk_map_idx(geni, clk_freq);
>> +    return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>>   }
>>     static const struct dm_i2c_ops geni_i2c_ops = {
>>       .xfer        = geni_i2c_xfer,
>> +    .probe_chip    = geni_i2c_probe_chip,
>>       .set_bus_speed    = geni_i2c_set_bus_speed,
>>   };
>
