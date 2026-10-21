Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B014606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uleRUsSg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DiLxVU7K;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bYcwkL8m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCDCC607A8;
	Wed, 21 Oct 2026 06:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mzWF_An4c49H; Wed, 21 Oct 2026 06:58:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C61A6074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565887;
	b=OpLEEPY19yUfpyO0CxYUhcAfbPUq/3q3DDo7p4EXx15z3bMc+LgoBOgrQwnmI21PNN1X
	 TjdObrTLy27wth+7PI6hxeuWMPYAt2sclAMG7qWL0bbyq9T4llaxGevzs6ffGhKMVtyJ5
	 vcSXohDiQQUMTbp2VjZyWRcXEM4Iig6NxhpU0Y6PY/UnhclMygp6Hgr8EMJSoHEWXwABC
	 oyXee3PA8VlDl7KWPACk6q7m9AdiyFEmKacIuzeM8fn56h9+ZRcqtX4TFLgkQfKaZhufM
	 AK52FMLx/NsW5+qjCyjGwlKR16AJH7WN8Dp3Zg3B3egjpB9czyKgiyGtMcemgWeUycA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uOyCYcArIdvDblRIjC85Nd4cVxUmXZPm5B4vjOQeh0E=;
	b=PECs2XFyj55PK86at1kvDZAx8Tr8ODNU8TooeNq75QHLwz+53zu3XSCMtsJISuiPT+Wq
	 SzMvRsv6mfr10D60/hy3+NVY2r+3Ti/1f8+OtbfQqkv03k9rIdgxlbmp/Y9p65YEP6j7U
	 No/vWlrCSHabEQUux7TAn9w9XOsax9MwAFSVPslxnImUi1g8jwX5x7eFMdwjYAei5WV4T
	 6GBfkOxa4ez5CTk8Cp6CmAQaDa2OlYyZlCQKIoXodNJcI4PxL9AekE2u37nbtdVYR3toD
	 muJ8xEiJVJ8fvm3Koj7AhwL3V4N97B1ej0SQOZZidDUbXXeZAdXxwlmPcIUD/DZPkhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565887;
	bh=uOyCYcArIdvDblRIjC85Nd4cVxUmXZPm5B4vjOQeh0E=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uleRUsSgUxFxfHpkDMsLU8+7xlG15fTED0rOr1DjONpYa50rDxe8abTMr1pLt+7ED
	 5v4PHfFGWHyrs571sGj1xsm0oWkuTxRopB5HlmOjJ3zuOnJMi0hW1VR8uRplnB4vdO
	 3LpcTSNFeCvfXAWFKqch67bO2Eyi3HAhZQMGHVsRca1Iq27iOUtvw4PXYnBx+xkF+R
	 Zym5tTzQuaJOm6DQxpaYGT4wSbIEGgcEUwW9dsg9tTlLtJCAVV5Ssg45n70w8569Pe
	 V/xdx6L1cGJBXqmqI36NZIwtU6qNlbTUS/0FnwIQHvqYhUvsgxh0ci3MhbwfZ9hVIt
	 c7xeuL1nooD7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C61A6074D;
	Wed, 21 Oct 2026 06:58:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6EF4995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8BC340077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GPJ7W-xVrOA2 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C5FF540060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565884;
 b=AvHYL9H7d0fbUlZhuQLDpQSP4C4cT4q4GzJHQ77huWo+0dsB5faN57RCFPpSHDg4+57Z
 RFx2GZYsah++H5yw3C5ABtDhD/RQbWAlrRRN6lV26Ffjz4AW+jyX+IqnffzmD4y89CKOj
 807VnVoXksHPlGr6QhjlKvx5FPaH/kq+MYtdA3YeyS7QRm+13HxKJzo0n2nM6IqDiU+YG
 yw9uQFTnSiSOXiuOk2Y2tL/xxGcAssZ3j6EOKJGCO82dr7y6oC4BahC0bDnT6ct0PVCZN
 QuzVHM1qlXBOVC45QuffoD7HWbiJVu43JnJzUEhaRtMJ4so3r2GbHLljEHnSPziCkAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565884;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uOyCYcArIdvDblRIjC85Nd4cVxUmXZPm5B4vjOQeh0E=;
 b=Rc/EDM+jWk9pjVhiq9to7BHhMCEsikZdmIg8WpmUQjKi6tNipZ2zFDR3JEOXcbSzLfW+
 Nt/gZ8p3ZVpXg9macYqsmLU8qmUBKluaZeyL//xSQo2xJVOJe1m4u8IhiSgmLkZMD+QOB
 0vpCFMn6CmI2DUIWIZ64teGSY5V1V7ttNWC9jzPvxaZsh39FFS4Uks4St8hCt8daKEJ3u
 cwYy4r+E3CnORjNB3j2QaoudLgf4PP06/8MsTqOAcZPWp/azFE/Z5WoMu2W/xoD6iVCVv
 8OjsoGqsN03TDAalzCgckciTWtCZrTFYcJUZhidyyuCGp2QtR4mjwcwn3msQkV7F0oA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DiLxVU7K; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bYcwkL8m; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DiLxVU7K; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bYcwkL8m
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5FF540060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:58:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j2ES3355908
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uOyCYcArIdvDblRIjC85Nd
 4cVxUmXZPm5B4vjOQeh0E=; b=DiLxVU7KfbVAuv3dGEQqnHesNJ3Tjud+NwEz5U
 Gx/nxp2161D2ASOIiI92gCB2lw6BhLvEMxaJw89Lg3RMuYGTpfWhnr2Z/LglUrke
 9dKzWJfKz0BCHjj96sjINR9oGVyQK84UxRTnVwewehjqcsmUqAd4EeuX5EIu3pz4
 lk3mFhVWw3y+2XKrXzIJnvVoiPpIGZqj5eMy++uQREBBdIjZycKlu/6WXTq9+8Qh
 W+3UFjoPHoZkInjxleNz/iqASJUSO44Mw3ZE4tu3TdljY3USCi8a5d88eH0dyPQk
 GtqJ5ItBOLdrWB/M//pCWbPEAqlfNv9ybA5L++u8q/f+ElPg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0jdwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:58:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so748223eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565883; x=1793170683;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uOyCYcArIdvDblRIjC85Nd4cVxUmXZPm5B4vjOQeh0E=;
 b=bYcwkL8mpPNjRXPBrVK5OAev+/q4taR60F9po5p0Ps8/9ETQwjaLcG7z83ngS9VidC
 DWjka4T1Zj1mSN8tn2ML1mYMa/FWtuQMOzoYZQegc1pQJDBfafIdvyjn6RX9qUdhAe01
 bxNMbcomDmKWmVfkF2nmfjlpD+mNVYYEcoTUXnd5qxQP9NgqJ8GGm26S044uVZ5bPrRh
 JMtkogkWoZkt21VivnHR3g18iNP4aPXtgCOWWBL/J6wOWVdtIuuzkT71FmHQIOXEAxwo
 s0lY+fB8D7+x7mPMlxKL+xz1WHvwSKIzVeWTFaKLl2ow+Vi5+rTKen0Akfaxhfuzyjqj
 zIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565883; x=1793170683;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uOyCYcArIdvDblRIjC85Nd4cVxUmXZPm5B4vjOQeh0E=;
 b=aBZnZQ87S1RPcVrfbiX0UWSs/orrwubfkos8+Ku7oK8h+ki/eo6Y/V7q4/78aDTO/E
 b5zgJUfGyAgaVy9+Ks1zvIDJT5QO1JS3N7m7PsJIHhGUsf6U/3GrX4cnRcNGOIMtoc/g
 xahXGB0zasCbkJFwJrP8Ag5GEgSWnjCoZnvYURiaApN24DXWWJDDUyICSNQwr6PNJO/h
 JTjz54pqAO08ZJEV41hEafRrOSeOfrIdh7scAlP+T/F8G8ApXdKKWHW94xdkZIHzam7i
 YzD9L7KUQEUj2gfUG3/vH4X/zFB/CydrSqkIT/Am4MNVUalG1E+l25gDpNpLoQb6BBcy
 SLOA==
X-Gm-Message-State: AFq9FYL8E8qnmTVKvae9yWbKIo1XLWwAh38VQDtnCa155iygxR9vrPip
 ilWCzGLGGnyJUMKJQnvIzbUOSZws1fSKCVEZjW3ZAfK8jZ2MITvaPoboMCm+1eWBq+phXcnMCeF
 pa/H0KuQ+q1OKTuLGY/hoBDK0oqB4u2st2I/8zXn758aHqIVtkdMpjUheB0Ed7VtlsV9gg9TpmG
 wIVbQ=
X-Gm-Gg: AYBFou3DfAE7IGIzS50D4nhHkiiywwHOZp7CmNOKjpKJAU6/jYkbVO/nm7UDNroUdb7
 05BsliFIwrgmQvBb+KCGUWiDH0RHvXH/ogPd+g3b7uSSD7lIAPYj0hDIClnvXWkRPFWhxIxQ3bz
 kWHaYnYPHS3b/+Lh2y4a0E6je6nQuDyQDGmDTCd1t8RYOhwfPrMjQ36cAEg0YMGJwPqvEEq2JnM
 ePSaxLeCQPF6i8gGWwEwUJkoYSpU9CqRSVUMrUXPuM+/Ty9qz2vRigwRsYQbmSpYKUoMvo0/Ip6
 uSCbrfLIaIz36ks58sY15As1TAhQ50IOo5NPNescEyLhwox5QR537k8gNpiQb7EOm8fbl6peL8A
 0Js8vlAmXLTvLdoJXk7jD7Ce9fU00weUQOoXnz3HfwCjMecs0WZmhqaEARNKHMzb+jtfsEOpSr4
 nfukgpDkqUyhI4xKClU9BTPZSNwpVN
X-Received: by 2002:a05:7022:7f14:b0:151:6e80:ba7e with SMTP id
 a92af1059eb24-1909fc7c7e7mr1466165c88.4.1792565883036; 
 Tue, 20 Oct 2026 23:58:03 -0700 (PDT)
X-Received: by 2002:a05:7022:7f14:b0:151:6e80:ba7e with SMTP id
 a92af1059eb24-1909fc7c7e7mr1466141c88.4.1792565882372; 
 Tue, 20 Oct 2026 23:58:02 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903c71421asm4143450c88.16.2026.10.20.23.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:58:02 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:27:58 +0530
Subject: [PATCH] arm: dts: monaco-evk: Add qcom-hwinfo node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-monaco-hwinfo-v1-1-d28858f6913b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHVi2GoC/x3MQQqAIBBA0avIrBN0AqOuEi3ExpxFGgoViHdPW
 r7F/xUKZaYCi6iQ6ebCKXboQYALNh4kee8GVGi0Qi3PFK1LMjwcfZI4u1EbMzmPCnpzZfL8/r9
 1a+0DF9w+y18AAAA=
X-Change-ID: 20261021-monaco-hwinfo-29c31667cf20
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792565880; l=1308;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=bNvAc3Q2n/h7YhRWAZWPQ6cIYtEcMDYor+FW4axdYrc=;
 b=FXuDECyCcCtnuniYrC5kQKz7e7jEFemcoydX6c2HboRpRFcnyNmOi6voafoXqXHgQERYnODPJ
 xPavBlTdFPHCLKJcOagJrq5aeu/gy+s5GuuJkmSNCNsPylIae0OeG7e
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX7hRnYLAI2Jf2
 VJKu4QiEsOCzTIBy82Bll9tJf/JUz6MgtEnx/orvd4Z6ykJ3cslcHj6PFt/WVVtlOV5tHZuH0IC
 kTt7+gUdf+5lBm3Q1Cqbaji+iyVUTIweNtcaldMXePOYR4dsmhkem0qdhABvqy0COTI4j1ZXuUh
 uaR3nIZW8T9wGihvf3aX73WAslGBWsYA9onaa57uki7OVQqiReyPervja05z/YbpA9J+GDoViXU
 p5PcIAOVBJYs3U1UommqHI18LaZZfKkrtk+IwjBlAlrFmezi0gnoDRzX5SRK7fZ96rZaGxqS1Yd
 WbD30HkHRxcS6aIPGIGrlMLv75Wcr0h/YPaMqEQTrDzwohienwefrtV0h1tZGRuL0mcuhNYfbj1
 oJNL4669CA4Us2l6dE4Ko/L7C5qLQj+gvr/5OkuWdJlJr90Wcbc3bPvem9wAWk5JyATAoDipSsV
 oaWuRUtzJmXjVEuy3cQ==
X-Proofpoint-ORIG-GUID: 6aRM0_jcRp4Pe4_rs-mrzRn7aZiPjsMk
X-Proofpoint-GUID: 6aRM0_jcRp4Pe4_rs-mrzRn7aZiPjsMk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX0mxP5zuIUZPj
 835MbTshqP+K3rvaRwJhvFtUndILx9ZcN0GPJDVZ4Qihq/Jgmxz3CKKhfyJ7QKIwMvFjHhDBRFf
 EYEGU5tSMi2huiGleVl3cv/PSpTwCC0=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad8627b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7BkdofFX9ZrWjpKIxYAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210027
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

Add a qcom-hwinfo node in monaco-evk-u-boot.dtsi so the FIT
multi-DTB selection code can read the boot cookie from IMEM and the
HW version from TCSR on monaco-evk.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on following two series:
https://lore.kernel.org/u-boot/20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com/
https://lore.kernel.org/u-boot/20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com/
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
new file mode 100644
index 00000000000..ac44b00677c
--- /dev/null
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&sram>;
+		imem-boot-cookie-offset = <0x0>;
+
+		tcsr = <&tcsr>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
+};

---
base-commit: 2d99f2c5a342a1c50e9e859a3026076af5370602
change-id: 20261021-monaco-hwinfo-29c31667cf20

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

