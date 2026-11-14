Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24921606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p3MygslS;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pQLHu2EM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1S4pzXm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB86460D80;
	Sat, 14 Nov 2026 04:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L54OfFlNHn27; Sat, 14 Nov 2026 04:06:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F002F606F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629194;
	b=rdWVXuGGiy5TP+hWf9sNE7D1vssR1A7LyQ80jN3Ku6kHZEFrNnmPvaRZrH0igDhCOeCd
	 sMDYVm6A+zUQyE3M0D8tKNgEgoSXmjtUjO5d7BnizTQPP3C2nmlhGLArR/gXZANGr5fBS
	 HpOrc/fYtCNh+wySVykhEik0jfywRSfPLFSZOAkGH5Cjjfkx/sewnDuWu0t6DYxfb4BMx
	 YcHoYSXWObU+iXlj/FV+ddFjy1B6iiUnCHXcmjHdWofF6IAhsZqqzHO+I7wLRu1J1ti70
	 gufKrkuuen4KSPnn8R1ucw8cczs8+k80mXvkDAALB8Z8JNXPAS6C/uZq+3g7zNUQy9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bo523rw5V8bCLRWs4eA8MHcBm0tbMHKSHJySEgdFsec=;
	b=kyxnEX8XNzZif33Ai/whywY1gAV8nO/77oeOG88kozm75JH+To7plympy3SYTnxMjjuO
	 GzDN0bxR5wShlHue9KND7QDxkuEkWKUDJDVtsPC2o7Wj/6E1Sg8KlQyPCVhX/c6iyOXaz
	 BphSmIFdtctp4i39kytVV68zH0nMdBVtshZXWejOt7inFPsbYO8rHTVS3jVtSwa2+qvGs
	 vXXhk0ucQJtMtdjZJ1LJCxzs0neIq2MEpgvZ00d3chOOLQgs8qE0k0oHdCVlawSg5uzl9
	 MNNjHv6QVAfy0kAjtWRp8CehIWhwrQ5z6JcuHP6li8wxjyi1B3/vtqKRn5GDCf8HzNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=fail smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pQLHu2EM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1S4pzXm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629194;
	bh=bo523rw5V8bCLRWs4eA8MHcBm0tbMHKSHJySEgdFsec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3MygslSl8Vsy5a2SRVfiMW2SHMtVElfQTj/GUzh7l7BoM9pb53qdlWc/LTWHmLGn
	 nxSR7gRpnv9WxvBKToqGqgDDEW6G7/mIC7NKJR8uDqXkRXzZ2N3rshL5MYTlvU895H
	 L3qBUaavNfIth7CVyFM+sC9VT4SBDZrBxiuyvdM/ZXxregIcnT57lPSbHBdZ15ZleD
	 ctQ8o4AXH+1Gk9IbcUNJFrg7lbzlpRI6ZKRXgEVMF0bZ73TXkIEWJvWVY0KeItovbb
	 S3PAjsSPUpAyNGAIXiUZskPn6Ao5BgtUFuDvLpnAX7Bz67qjikERbpJ+RvjUIAzUDI
	 4drK0FAskK2Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F002F606F1;
	Sat, 14 Nov 2026 04:06:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E94C81A6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB1D3606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRePnBu4kIFp for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D6100606E2
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=urvashi.sharma@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pQLHu2EM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J1S4pzXm
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6100606E2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9491847FF; Sat, 14 Nov 2026 05:06:28 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD1D84822
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 05:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=urvashi.sharma@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE2Xhto2440108
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bo523rw5V8b
 CLRWs4eA8MHcBm0tbMHKSHJySEgdFsec=; b=pQLHu2EM1Ors4gA/99hNcFkja81
 WEduNL1MNO9EuGbzcFjZDpVtEostD4xtyxfXl1KAChowjZFDLxu6Lt5iNxIi4+6f
 JaYFd+h1NBvkRqGbZ0Xa3YbHNGGxaqAG79K0lOBXSC8hifLlcTSGRUeuP3E6mYtv
 MLO33jg6u3aHdxCKER7y2WkRCfY0hfOr1Hczi66CiHqvbtCNht0nRhsSKB9zdN79
 2hsway6+i9dvxgYFHnPBH43HOPL58BwQ/QzV7HXsdZTeQg5SgUBkf7ZKWpXWBKIZ
 5RPF+htKeDxHfUA+4njXxLVCS4NnTrl/KGrg4iioUy4n0fN4WOlIGCd7o9A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxeyfr6a4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so2001790eec.0
 for <u-boot@lists.denx.de>; Fri, 13 Nov 2026 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794629174; x=1795233974; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bo523rw5V8bCLRWs4eA8MHcBm0tbMHKSHJySEgdFsec=;
 b=J1S4pzXmwsk6VGdMNxxnRePc94uloBR90rIoGcu/XdSvQVyVmqIwRdl8FQLja/tNgU
 EoQT2ArJzle/NDI87XNb75nQ4SYP52Js+nzuGj7X0WEk8leWDh4456kZMQX8qNSmQ4F5
 3QcrTHpwHiOPam7g9lMI2Mymhhah2hyCcEo3k+kRVNRVHKNZaEAZX56t1Q/iWmXB5QyQ
 4nDiHtSGzfukoVgdZPs8Ks3PfhBxlhMfYZUpchbfi51uF9BNUfDBf3iLLv1IjV6XM6Q/
 HodLcfA0g13nGUVhowLHsGqPk/YYZn4zm1cqQY79dnIfVySxuCQFchnB9xvAqeeMFeXy
 2h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794629174; x=1795233974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bo523rw5V8bCLRWs4eA8MHcBm0tbMHKSHJySEgdFsec=;
 b=Ik7WqA8AM4YWyM3J65LtQovtTbb0HLFB4FiEv6pgY5fiEIQsihQtNT2apl9GkBmDVX
 xXtB/RaObqNGedrs8vykTsWI8s/hVSID/O9fxQRpNHkPy/HhZPsE+qqwNr1EA+DHyaWk
 JIRSc4mdWFRSMK7Xed4pT/jSSZ/L8ucG+f/gjI4V4DPwn8B8v6AQv+TCUDb7FlyNcHSQ
 t6RCTfAoE6MUj6R9FMhfNR4q8M7G6Q7ccDFaIAz93CUQZJthZrC2LmP0aY6AoN34ftU4
 0Xtj0mb6pZuJ81We5+XFeVzuTWIQ+Owa0wsVvJZ+WBYrlXxj1O08Rb71PdifsXP7yRlt
 YCxQ==
X-Gm-Message-State: APuU4Z8DoQbzYjXEeXQ3bvywZWX9bNE0mgEEoeB38j9cQfDSr6na0U1G
 6aK33i7DgghY7dTRRWSeyiJElmuXe0LoEMN3u9S7lHMVbTL7QCqn/3jEGT2bbGxOfvHVSRiW9Yu
 ZKVKMZTA5v6NNGPaYK2eZ96ULncJjhGPjSxDdHDFFc5wr3MkgreUGf5wIWmVIJmcS
X-Gm-Gg: AYBFou0u6PM2zXU0aTmmJjrKRHMFJvxy73/YbVbuOmOJAuYmgp6WkW6DF4ZgOlNsxt8
 z8yVQYodqmvaxkawiKLs4qI0cezjLwWAmglzwFwkBGe0Xuw3pyg10AleK3ByaMZ9Pb8YtMgplsJ
 jjJRUAO6hChgLDtYlVlUHIWEZ+vDGnz3d1luR3lJb5d/wo93GZ0grZ3ZVBO4KSZGkvz/sDLtMZP
 05gv9VPeTIL+aJhxGU1/nw81METAswnk3t2sh8DkXB27KVnkAiCDEcUOQayYRmFptq7MiORZcX2
 tBcKI57CYWFKZwcErx7h2vuDE8aJP7tfy8AIiWneKnEgGo2gDb9WPgE0221MjmCfHZfQtX7nZeo
 orJA24BoWxYulk8E9ajGXB5/K3QYiQb88W7XuHF8b+RB5xVKLn6QwXGI5SKqOLydUEu9ZjRj13y
 rHg63LxhzBv+/kAXHyu9CjhvvPhqmsAA==
X-Received: by 2002:a05:7301:782:b0:376:bb3d:5af4 with SMTP id
 5a478bee46e88-37965f9ca89mr3528074eec.10.1794629173840; 
 Fri, 13 Nov 2026 20:06:13 -0800 (PST)
X-Received: by 2002:a05:7301:782:b0:376:bb3d:5af4 with SMTP id
 5a478bee46e88-37965f9ca89mr3528045eec.10.1794629173234; 
 Fri, 13 Nov 2026 20:06:13 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm11536621eec.16.2026.11.13.20.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:06:12 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org,
 trini@konsulko.com, digant.shah@oss.qualcomm.com
Subject: [RFC PATCH 2/3] scsi: add scatter-gather read support
Date: Fri, 13 Nov 2026 20:05:54 -0800
Message-Id: <fd5b136678173ebd7c7998f9c701cc7609c856e9.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
References: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX+s4yZT5I6ViJ
 KCV/6mqtzs8gkRJKO+p+HUWl6PkIsxs0EnpBc4e+MEzOBReyxI5vwHdys6yHiXzNGmRoBo5PX/G
 cv3uj745wNw1g9HZ/VEpf28eTWJziPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX/jVkaWZrfbSN
 PjeyXSFM5kRDbSfRK03qF8C+/CCFsH7kYAHo6V1UBD8C8pi3GqmCu37KGpMDouIv5zhEf2hjMMQ
 PnWJIXy9imIF7EO2XVN4tuVynzMhw0JhVOok8PqWwUBMr28pZxmdUkOYW55xh8ngyxMoTvC7e3X
 MyyAi9MpWiVX2L84JREbJ3u/dRr7+wDB0LlDJpKBvx7/Gub/R8dhvXU0iUIcd+BlRjyq9YwLTcA
 mKHueNgkzbNaNzNhDUaox0xIyt90/XVdoJMNfkYqI8fJpOheBXjdVGdJ7qs+vwqFmiHgIka+IgB
 KeaFPAT+yod9l85zexEw8l4zEIMnDbY6YslDwJWqTv0U5XOn0mHdor8QoNYyl+ekDSAE/mjG2VI
 xBbRon1vJJAooAjHiyT/CApo6Ro6W1Vjqtb+44GAsFO8r2pBlFwF5THa/bmmkGZsOD4WiXVj6ST
 ApE5XDm0epBGmmfDbtw==
X-Proofpoint-GUID: IRE54vpwKJFS5vMZlt7ADWF3l8d6mJNM
X-Authority-Analysis: v=2.4 cv=SLPXx+vH c=1 sm=1 tr=0 ts=6af7de36 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hgz93KCdH4gNym2xaPUA:9 a=O8hF6Hzn-FEA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: IRE54vpwKJFS5vMZlt7ADWF3l8d6mJNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140016
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the block uclass read_sg() operation for SCSI devices, so a
list of destination buffers can be filled by a single READ command
rather than one command per buffer.

struct scsi_cmd gains an sgl member which is used in place of pdata
when set, leaving the existing single-buffer path untouched. Whether a
controller can handle such a request is not something the SCSI layer
can tell on its own, so struct scsi_plat gains an sg_supported flag
for the parent driver to set; scsi_read_sg() returns -ENOSYS when it
is clear and the block uclass then falls back to single reads.

The request is also rejected with -EOPNOTSUPP when it exceeds the
controller limit from max_bytes_per_req, or when the block count does
not fit the 16-bit transfer length of READ(10) and READ(16) is not
available.

Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 include/scsi.h      |  6 +++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d749921..39c6456e863 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -232,6 +232,61 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	return blkcnt;
 }
 
+#if IS_ENABLED(CONFIG_BLK_SCATTER_GATHER_READ)
+static ulong scsi_read_sg(struct udevice *dev, lbaint_t blknr,
+			  lbaint_t blkcnt, struct blk_sg_list *sgl)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	struct udevice *bdev = dev->parent;
+	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
+	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
+	lbaint_t max_blks;
+	int ret;
+
+	if (!uc_plat->sg_supported)
+		return -ENOSYS;
+
+	if (uc_plat->max_bytes_per_req)
+		max_blks = uc_plat->max_bytes_per_req / block_dev->blksz;
+	else
+		max_blks = SCSI_MAX_BLK;
+	if (blkcnt > max_blks)
+		return -EOPNOTSUPP;
+
+	/* READ(10) only has a 16-bit transfer length */
+	if (blkcnt > SCSI_MAX_BLK &&
+	    (!IS_ENABLED(CONFIG_SYS_64BIT_LBA) || blknr <= SCSI_LBA48_READ))
+		return -EOPNOTSUPP;
+
+	/* Setup device */
+	pccb->target = block_dev->target;
+	pccb->lun = block_dev->lun;
+	pccb->pdata = NULL;
+	pccb->datalen = block_dev->blksz * blkcnt;
+	pccb->dma_dir = DMA_FROM_DEVICE;
+	pccb->sgl = sgl;
+
+	debug("\n%s: dev %d startblk " LBAF ", blkcnt " LBAF " sgcount %u\n",
+	      __func__, block_dev->devnum, blknr, blkcnt, sgl->count);
+#ifdef CONFIG_SYS_64BIT_LBA
+	if (blknr > SCSI_LBA48_READ)
+		scsi_setup_read16(pccb, blknr, blkcnt);
+	else
+#endif
+		scsi_setup_read_ext(pccb, blknr, blkcnt);
+
+	ret = scsi_exec(bdev, pccb);
+	pccb->sgl = NULL;
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			scsi_print_error(pccb);
+		return ret;
+	}
+
+	return blkcnt;
+}
+#endif	/* CONFIG_BLK_SCATTER_GATHER_READ */
+
 /*******************************************************************************
  * scsi_write
  */
@@ -675,6 +730,9 @@ int scsi_scan(bool verbose)
 
 static const struct blk_ops scsi_blk_ops = {
 	.read	= scsi_read,
+#if IS_ENABLED(CONFIG_BLK_SCATTER_GATHER_READ)
+	.read_sg	= scsi_read_sg,
+#endif	/* CONFIG_BLK_SCATTER_GATHER_READ */
 	.write	= scsi_write,
 	.erase  = scsi_erase,
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..06a44d04fdc 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -13,6 +13,8 @@
 
 struct udevice;
 
+struct blk_sg_list;
+
 /**
  * struct scsi_cmd - information about a SCSI command to be processed
  *
@@ -33,6 +35,7 @@ struct udevice;
  * @trans_bytes: tranfered bytes
  * @priv: Private value
  * @dma_dir: Direction of data structure
+ * @sgl: Scatter-gather list, used instead of @pdata when set
  */
 struct scsi_cmd {
 	unsigned char cmd[16];
@@ -54,6 +57,7 @@ struct scsi_cmd {
 
 	unsigned int priv;
 	enum dma_data_direction dma_dir;
+	struct blk_sg_list *sgl;
 };
 
 /*-----------------------------------------------------------
@@ -269,12 +273,14 @@ struct __packed scsi_write10_req {
  * @max_lun: Maximum number of logical units
  * @max_id: Maximum number of target ids
  * @max_bytes_per_req: Maximum number of bytes per read/write request
+ * @sg_supported: true if the controller supports scatter-gather reads
  */
 struct scsi_plat {
 	unsigned long base;
 	unsigned long max_lun;
 	unsigned long max_id;
 	unsigned long max_bytes_per_req;
+	bool sg_supported;
 };
 
 /* Operations for SCSI */
-- 
2.34.1

