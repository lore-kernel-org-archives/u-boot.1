Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C4606A33C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J1G9HLv/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fy/1WW19;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j/0oN1h5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 842C880DA1;
	Wed,  4 Nov 2026 16:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QWER4GazSrq; Wed,  4 Nov 2026 16:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B18D480D30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810248;
	b=YvW9/JHRt/so3yM/JEN+tvP+WNzJ5/HR8ipCs1VfgaPwwZ4SlHWMiXyr+0ZpAv1jVhDP
	 trhoPfD2yAb7xN7Yp5exitZjiTn8R/SaACBub0fKlFAy/uxB4fHR3aAGjU45xhzhOSGwr
	 mWnbQCApcKA9Rw7NwvUxDvRzltnWYVApiD+VwsByikidychNqxSdonKpyeD/UofdFfH9v
	 QfXnG0OjbRE7j4bZtH5Pl+joFJrh08iUjV0r5T2KJCkcafqS1yGBf/JLDtBXXjniThi8b
	 1S5/y+1OoLAEmqgiYMPmODcvrkNMradVVdZAIdUfOMiz6ywrM2svraRAw8J/V5joFqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JPDHQzIeCldsMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=;
	b=GlBa5+EEBIg/kYy+ycaec4GCjjgmCNU8c9VmqJuH6W135NiO/Nm/hvzHaJMzSW/OpeFB
	 iSIuQOb3RVLO2Kjn0YrYjQXlXm2+ZFNx3Ffh6IZxBHrxFvRbIfJBFHu4ae2+0ie+l4NZm
	 7h78Hht3KY9t5HQZnDQ5OTP/wqakiP6uIVGIjmzNlaVV0R+N4jBO76vdgtgmEVBhGjFO5
	 hawBEYr5GMuk14lIdXGcACvNxKBSt2bK/l+oh7GJ96FE1I3Cr8rWq+qnj2zZjFDKWZO0T
	 I5b4bgGHk1HBg0p/k8nW0bKaW8qAkomDhXdlztToUlOrQWZZool4R321OkjLjtAhbrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810248;
	bh=JPDHQzIeCldsMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J1G9HLv/UVnQ6o+LI/OV0SY1zxtksYh0MILMjhubRRf00hxBpwExuXrsxGxGuPlZu
	 UFZDnJq/x3LYng2tZQ+F6xYLvgkX6XklwDGlmKFJYaS7FMBdEF2QxvF5qC6f+saoUS
	 8Pu0s/s0yqJJzaOmf/T9jVj1+Hxh9XQI2DMf6lb7XUDvMJ9A9yCjZdKPedenQUvIhF
	 I07raXrybLYfWJrTGMA5pK00Unz2+QjwqxrnIFlysk6KuMzQgw/AHjB/6CPAH0JGan
	 PjrwFJA9s4GLAaQ19DSCIHTjqFn/OXiChT4+IvUWZR089UxjM57bW1IhMT+qkQpnPK
	 ziehZMkQ9TSZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B18D480D30;
	Wed,  4 Nov 2026 16:37:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A88A534D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EA6C60697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gmdm9zA7kAzm for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA902606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808286;
 b=dQYJuLLtPjLyWOzYbxMNGOxejwYh5rZjPr3bzqymyjAa5VumUb8876gQdmVT2Z1PEC7I
 83yIdRVilDX8aIOgfMf214CTGoTf6I9nVTJIgm5U6la7zhjQNguPsVnBzM6WLz42nW7HY
 nm2BjG3ExAvUPZ+RzpQbqCbi4I49mdioc6x0mDRF8Ct3Rmru7vRV1ds4z6GqYh0nkVI/h
 Ytx+ZEEIo+HCcxldNCKncrCn3wiPjca/Ri7nqoQefOFFO/fWcHPeGpuOS/G1WFaqq5T6U
 I1q7mkQ8vo6f/2WVE+YIY6WJZwaOa8duzkTyqFEEjdzTKD1LB1UexxPZsFCTcyJ4fpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808286;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JPDHQzIeCldsMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=;
 b=OxpVtzdXJ6XHNztSG1D3uTLN8jdJzlBYZ5uPdDFO1Mf8zpQQP1RUIBw9HBeKpYkLIypL
 3B9dzRuAlJWR8wuXTTbytPaq6vyocjZBFngqLQG8tZBZUrQqEwKBn65+F3wRlzdO3RH2P
 +rh6YY0MDsJhyLFkqnFyte73UphjdzuWzOjOvw5tRNEsopwsacU/zHCTKa0CRTt+8tEea
 34gcFfdiroPPkmsZ17e+CN0wW8IweYFDWXh7jt6Q90PZIOZcmwE/uWlYH2cVdDaMPgyOb
 gS8R0WVx2jZqeSraehKfoHrCLZ6Bon+S/CJV+oA/N0orYAPrna+hKQWbl14gfYQ3Wpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="fy/1WW19"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="j/0oN1h5"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=fy/1WW19; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j/0oN1h5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA902606B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Finm43272803
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JPDHQzIeCld
 sMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=; b=fy/1WW19QocnL6XwtiQUJji+znq
 xc+Xa6kkttobCsOBohqPfX3clTJkfSHE0/9/Q+1PNmXt/nlp9WWU5ORXBq5SprEB
 Kc6fcwzqRKLO+9Rkb0BM/J2CqQaJLnv8b+c8Bi+EXqMsUvUf37yULCcIeZAk6zZF
 pokTaAFw0sSNVGnYjNBtW6yFohiS/Lp69C3gxatMf9cHmk3zK8AEw2UfXnEd6f5s
 z55/1wKQcPn/VQhOPVphEZpy3uxzbrULL/Q9/3VA1LcDxNKGkAnrfRtN3zWarybx
 V1tesE2GTa7gyYNXZ9Rtgzkzh4VMnav3nFFI2KRKv+kAzGYzaDj+78REgsw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngdjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36d2a94abf7so396024eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808284; x=1794413084;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JPDHQzIeCldsMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=;
 b=j/0oN1h5/Nx3ey+quHQdvGS1c0xaKvJkHXrq87z4y8dHOF5wzzeVHTt4U/nHW5NpU3
 uIWyp0xgCthIy9giZvFiaKNrcMwVx9jplDkJzgr/p92fUNQq2ZD9j6JtxoU4ILBiD09U
 NwSz+y1Kbuk9xqmke/uHUj1xZ7I9iobyuklbI8KotWjEF1Oo75UGJ9xPBhoovgJrsFh/
 wZ73zbaXi1TNdeFlb3UzmElQTaVvfd/khgQkGk9BzAVClu4KB7B07/lRzpQ//aKzvoct
 wWoOX2v0jxSkaBKo1Fam5tAd/DNUgiOs9LNgEc4sgiJC5K4xlKTycecW4cXDwEBbDXtU
 +seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808284; x=1794413084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JPDHQzIeCldsMTirDVFXwIBgNh2UiM5vh+EHNVJGoPU=;
 b=i2atDt4UaCIPCyP8skgTckkLGeGopYjY/XBSMHlmvCt6hur2r5jQIFoeRRIlzQbEVZ
 hFH10qQMRdOz6KgvJmMgeXSV4TIOr1HEPFnlSdw/wH0jcwFQ//JmII8x4B99I86DOQOe
 fXujAe5jjDYP56mZdoMBm1P8DG8Yn0akzYXra7U+Df1nmwVs2h2h4wwXnJy+QcHws5pq
 V9a64b0Rhyd3FBSr7cASfd7tf8zCmaoYlgzAuBXsN4vLE3/wTpzHE6jeVPa9n/FRWUai
 7HpryqkO4xh3RdjTmYTUyzpdt1U3pq0Yi8ZNuYO2HchqrIiNWdvLj176GygrCJCLOe71
 nMkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5fm94P9ZCGtbwzWrK9U+ynHVdl4aRQPHCKS6hjjcPgGWxTTDV9vEpF0aMSMHshTAZ9IGeqnc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/DHA0Dimu+AcXK98J33FweghNHuBXeew2nJklqUGVeL/kTBw+p
 MxxKYPiPySCUFbZaKl+EH0qV3GpqD06BUBESO1s/Mu+GJBj+4UTkelVohkGlAmdAncXI9jiLQsv
 XjPeRL4XoPRb718gIr3wZnUY+1REhmlN8OjX/o4NhFMO1gVDeLFXjOlKYZjEqz2WPL4Y0iVA=
X-Gm-Gg: AYBFou0XQEs7mf26JKB01Hs7JA3KkuD8Z5DSwj2u92weokh35EzqfnuCQbP4oFOhIAB
 vZOYLBecV+gpEGW/6Udo67BE+PKtdPePwz8DqCIaHLJbKVOysJCf78gdPOV5hsLV/HqI7fzZ+JP
 sIImAlc+Pytmk1+oN9hrjvZ0fSCH4E5Saui1EghEDH9E1+hIqF1RWI52qDV+XM7OCGMN+/0qr38
 sRXeIECL2xsYbG0f882aPWvLxRz/rVnkiqfQ9I69S1OwIL1ktD3RFd7UI+VkS9A7yMckg0jWC9r
 ksN7w6yneC5aiLeVSp3Wnkekvq444AP9RgdmShaqSVlNJQvxgrxRNOqVRDTt0v/xRSrt3EEkbdM
 FVAyg1YX4sZCbBgJjNRvOmhpJ4SYSAlhgRkH3/Nb0kNF9/wBUlsHmfJQnOkyh9m1U77+7E4OSfs
 f8J8VAk3qU8mcwcse0/9coExtzxRQFRMtTeCw0P7uFf5VaENXe6Unz/oGv1mVJGN+Wmw==
X-Received: by 2002:a05:701b:450f:10b0:1b2:4da6:bb64 with SMTP id
 a92af1059eb24-1b24da6bbadmr833132c88.6.1793808283645; 
 Wed, 04 Nov 2026 08:04:43 -0800 (PST)
X-Received: by 2002:a05:701b:450f:10b0:1b2:4da6:bb64 with SMTP id
 a92af1059eb24-1b24da6bbadmr833092c88.6.1793808283037; 
 Wed, 04 Nov 2026 08:04:43 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:42 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 5/6] board: qualcomm: nord: add SPL linker configuration
Date: Wed,  4 Nov 2026 21:33:57 +0530
Message-ID: <20261104160358.1131694-6-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX5pEyghVxpIJw
 iIkZMTvME9AcMxns8gXfpMJnIV4YpCsb5MiF1aFk1kyMlCmew0V9S0dr4UHcNe3diZ6Z8qikgjp
 fCNa2PQo/TA8nY90jGRVKO7+S+UuWeqMAEHzO9DgvBGPfGm2C8hzVeP8MnwVurAWWNquFuOrBXz
 CMY3qzKVgZ/GTZpoFrxDCSIWX6D4IY1B3IGam5iCyGiLWq/xIFdIehXeuY/0colgj24Zpjto0LI
 q6CCQlRdkM0GzzBXsmL69QGewUXAbT8xAW7GI/Pg0j91in5/cOSEIH4jSLrMdIijFR8yp8UnqhV
 07q4JBuHl2ejQbv++7l27rb1RqLRABIVdDdJsg/Ki2vVBnLpjc0nyv+KQJ7w3EH77zUQCO5YGg9
 5/NbGW/J6sidPfwpl4zNQSg0Rv8lzVb/2akOqIxaS0VOFPgQcYzX+A2Vn3/MEtwr3QhD28A17BF
 12m0ZSqShEbGfZrFcWg==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb579c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=dzH8Vt8ClbZXZ6MTxF0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: MBAXA802qJ8s1grvbtTAUZibCT9WLWfm
X-Proofpoint-GUID: MBAXA802qJ8s1grvbtTAUZibCT9WLWfm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX4oV2nqD8NUCH
 8encCCeBOXzyUvinQ5QSj8A0UcCbXoheLb5bZeGVtcJtgNxUNZIPFzjIy3WIfoFbaSUcLqNflIJ
 mnm77I6OihqhcdaIHwyqIOdwzLSQGUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040064
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the Nord SPL linker script and board configuration.
Use the existing SPL_REMAKE_ELF infrastructure for the
Nord-specific wrapper ELF layout and 4 KiB page alignment.

Update the top-level Makefile for the board configuration.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 Makefile                                  |  1 +
 board/qualcomm/nord/nord-spl-wrap-elf.lds | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 board/qualcomm/nord/nord-spl-wrap-elf.lds

diff --git a/Makefile b/Makefile
index 6303a0cca6a..287516e1678 100644
--- a/Makefile
+++ b/Makefile
@@ -2024,6 +2024,7 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 quiet_cmd_u-boot-spl-elf ?= LD      $@
 	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
+	$(SPL_REMAKE_ELF_LDFLAGS) \
 	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
 	-Ttext=$(CONFIG_SPL_TEXT_BASE)
 
diff --git a/board/qualcomm/nord/nord-spl-wrap-elf.lds b/board/qualcomm/nord/nord-spl-wrap-elf.lds
new file mode 100644
index 00000000000..74cc9e482b6
--- /dev/null
+++ b/board/qualcomm/nord/nord-spl-wrap-elf.lds
@@ -0,0 +1,19 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+OUTPUT_FORMAT("default")
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	.data : {
+		*(.data*)
+		. = ALIGN(0x1000);
+	} :ptype
+}
\ No newline at end of file
-- 
2.43.0

