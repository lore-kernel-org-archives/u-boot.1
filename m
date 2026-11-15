Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90ED606A33A
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DIiVBBMZ;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a9scThMy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PMQS/a+L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 990E46073D;
	Sun, 15 Nov 2026 06:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8AjAON1_tkj; Sun, 15 Nov 2026 06:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC143606E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724002;
	b=sb9NdB2wIt6xmFED6jANR+CbeUnIZEUdAMw7RaJDg0h/YLCJCmHe6EYkNsFQZi3KZuMO
	 MC1dtExY6J40Mwcj/nW9xgNUsDzVBWw2JuCKmA1YnrgbufIq6WwqaRgXmdVh5ehjR/Teb
	 +Q2FIEKKmKxSF3rdKwJTTLnwfu6faQvNBaIRDGS/LG/9SCYJhoV7/Hb8iDKVNfC8yMsAG
	 IJRHWvxO7W1QicODzSBO3I6+robKXP+mAOhzICqjwKcv4QLS+YCGB1dWomCYVduNFqF27
	 afRu0KI1wg+HgzBBk63RmWGwpFprZsyF/MdjE3ym1MJJKvfcLEN6TpYtOs4QvFcgWxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
	b=jmOmPJvR/Cb4pMNoxbiTkZudmqfUYlZVJ6LuWw7+jdnBM9NChl29kzR+nxl3wRKH0ZKO
	 VYX03BkhmCReVB+kEC1OIpmNVt93cVZDKZHlm28XnUmMs5RxsMVmpeAq4bO1Q3hFZ9jUd
	 zeSyxK4bLcP+GXqHf23XzBwpuhoAGPHaBFtz5Yoc7QgRstg4K1V6rxtxWkhaQoHEQdpoE
	 xJM7Dqtf7GWSzWLE7hv9WhdYPj1zOUbFkOOcovOWiA8aOcPyGNzVUZCY7TVRLei84CTL7
	 7VLrm9zJNy99Ya60WeVfkY+EOYA2DUOKFFi1DIdyLj6bQtSG4iIsDlUkNUAJa6+BGwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724002;
	bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIiVBBMZwRTn1wJZDEX2urOf8VRV8Tt7bY7NPF8tjWXP1lS3CdqYeJPnu4ot1NUJN
	 r8lW6AgU06vK00zfwyrhdI4iLupsCpC7GpswQr4vduRZquigJLq25gl9xiN+PBBv4L
	 6SxL3KrcqV6vYBYnjHEhpi4m6d2l+vwJSm538GtAF6qChddocyuGMe3o9+ip0Tz18j
	 VMcvh4JCzeVmXPkUwy6G8WjowofIV+OHJ8HHUAo8IcFr9+NN0lCrbRePcnCSJ/dBIU
	 yx5wwnumHGE19P3yFLNq2JYEjdSJ6S27E4HeTAARRao4Zeo/EeIulbLJtnu5y/gO4K
	 LmXqoa+wI6plw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC143606E3;
	Sun, 15 Nov 2026 06:26:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F65F28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82096406DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEKSIhbSetJG for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE71D406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=a9scThMy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PMQS/a+L
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE71D406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:39 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4RwlB4006390
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=; b=a9scThMy+EAh9q4l
 fPpIQ15B4XdJM5UjhWniLD3rePVlAs6Q+LkXMHSSD+mae0nlXNiIjNYtn4KWtumY
 VK3inDkhrUOeSU868MDLx53B/1C9hMrA1h9uHMTvWEt2HrGm5/GcKtFKmkrVaVrT
 IqxZ7R4r4HANWbMmdD/JFmsD217wKtgBcZegMjNufw+7xcXD3EHe51Xv7b3B+5/c
 YTjQxbBrP6cPC/enV7hkDQHB2bX6d3cV/Ee9FB7Cq+znAZFM2J064ZgIyUuDNGhX
 fA7NddEZTyzQSbgOov+jRrn0UnW0w3We7q15oMLnBWGasYomzbacTNc8R4//RMX1
 MNsrMg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj42f6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:38 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14373747468so232635c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794723997; x=1795328797;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
 b=PMQS/a+Lw975mcgGKvoJKDou0aGGumn7n1Q6CE2hMyWjnGhgxz0TkSwuzTcrUJJW6i
 n44Z2chlIt85QLgZydFH+AKz5Rq3U2lxySRgWDXVFAz1BOp7GIcI8ovLdCZg+qHKiLHE
 wwIyURVFPM9qTaXeGndZ28cKg7x3NIpXi9O6Dj4PVPhn1p7YJL/qtb7gsRRjCLidjZOT
 nafuII09KQuqgzZiqinVX43snk6M2yKS+nmAUjeSI1a2Z54SeK/D+Ag6DJbmX0ojTWmF
 DouCxx98CUwa5MgmHV2VesPfkdvBCmF8odqZhhsONF/lGTB6B6YjlGqQqbLuRfhiFCij
 c8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723997; x=1795328797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
 b=BY9yW9Wj12mCqUpibAIx1TbCYM/mo8xn5ssEccjI1DR/07IHGQx15IOLnYgikoPmat
 7LCOD7cek8CxHDFzDfAKqinWNHo1zM3XpQzgEGFDW63cXCmR0hs0M8jsPHW8RxXFTSYH
 jGdTEZSCuUzB+JZPR9VEyD6Ke4HKUMaYY93BYAaWxm3Kkbt2nsgLU1MHEl5lbeA2d7iE
 O7miPNlr0cJ4iofEbZtKfVJIl0JnA3DkbJc/w4qOaaxaT8PUMRXCKE+YZLHs1tq3kRaV
 xBrvzJ4eaHKEHEwmeY0ZoOjGaytiiihq9WZpuKzNs0XwPCRy9+Prr6m9E9eUv9MG4dYN
 O8og==
X-Gm-Message-State: APuU4Z+t6W7qw0rRk3Mt62Kjj2V4YfQZbte0JLicHuEuY8tCPFPiiplJ
 9HZCr95Sxyska+e+r9pSxDMccQq+oQQuk1JxgkTALqgsbkfrjQzfNmmsYWWc3PemTKkjXc8HsNI
 2kyaqqFm9DJy19jjyrCaJR54fU6r80ZTQZ6WsNYcuUn7rBEJr2185zB4eBhCwUhRYsKdMp7o=
X-Gm-Gg: AYBFou1lparXd8/N6PYknsNQQ5lTj8G7xfWWec+mcDXtsatjihP/LTHZBXO31aYQjj7
 7Xo3VF/GO++sArxH7ZoYdYQR0GwZlgPiQB7Ip1qFHZCI9GfNzmr6SLJjQeJxhb0UhvilZ6B3+V7
 vks5FuVRtMdwlX1mo0X2yk5kZ33TveBi+3WAQ7O6LjnxDoiizZAB0Zp7+OXM+MTwRDmW6BixiUo
 0ZK4y7trPzk+t//eouZqCNDeytOFjNYA6li2exVAJrIwyt6Q5fPbAOD9GxEOXcnjuQCeCfCFMrd
 OdDGMcRcZwVes2Mr27HtUmgJSpZH0tKjNR/3Nkp9RRx6u4rHyhLZGs6IdBUgvF6W3XDoFbDC2w7
 sNKlhoKI7oeBC7NaVe93AgFQJsnwlA63H/tnxpyachHM6yFDwfbJLQPoYJf+JdCC7zCJV6QBrjE
 tdcYsIshz2kbCcZuc41BpkmZmsJfbr7+1OyQCNkx+k1cxAVYBvMFo1W/lyIlC2YObS5nlrhl7DW
 5p+
X-Received: by 2002:a05:7022:ea24:b0:1a9:e382:cedc with SMTP id
 a92af1059eb24-1b5030fb905mr7652850c88.46.1794723996957; 
 Sat, 14 Nov 2026 22:26:36 -0800 (PST)
X-Received: by 2002:a05:7022:ea24:b0:1a9:e382:cedc with SMTP id
 a92af1059eb24-1b5030fb905mr7652836c88.46.1794723996474; 
 Sat, 14 Nov 2026 22:26:36 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:36 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:05 +0530
Subject: [PATCH v5 3/8] scsi: Optimize scsi_get_blk_by_uuid() loop
 iteration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-3-79e76209457b@oss.qualcomm.com>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
In-Reply-To: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=995;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=2SDxwmcuB6aWGO+A7/rZmKS1No5fbiOofimHUns354A=;
 b=ais6Jk1jKk5jzwQHgSQtrK3/YORTvE486JfIVR1SYUEjyxSyW0Xc3qbAIdl214bRpqn6Do7bG
 YAYWIhBnUu0CnUOquCdyOD8TxQQWwXuKJ7lhtrV0xlJCz3aU7l3+FMs
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX2OE3/hpzU25T
 jByvLZpYqj4+vkBPIb9J3fFQrXcz5+xQk5LSCkqULDtE098EWFhH5++3FLoy+CmZZzUrqkTklO0
 IKKIpB4T3TlzHnm8w5Qs84G6L2nQ/jujylaBLDeIu44jtG0R72Q+TqM6MemqYuiEfxhukTCQ5Ne
 kTT0mtT8m1txsgfuEz80Yn2Gu2OSBYn87iI/ZP/YopaTVo3IxwSe+w/WLaFwmCp0u1lCN7iUegk
 7BBcFvLXWFr7+y/LFlrK1hLZp+z3xlXmhE8Wo1uxxx9dU0Tk+K56cIVRlGw9tEH+B1TqzYylhgo
 34HQK7Qfe0ABuUlbYKGJM+sy/7rDQpuwhNlMEVBgglx0cxC4HDqW9kvMBcAdjafNJzkroVvvCai
 u5lGr1grCpOs6Byi5Vzr5tmJ1SG9VLB51MwAIb+RHr33aEV629EcJHFKYnuPyLIadFp1VhpQobB
 YSPkFfMLCxSFt8JW+bA==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af9509e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=DtMCEMCe2gnqSNlAdNMA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: N6tesOzeArmHYs0M4Webd9UknwplC-Na
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX+2wmfcRG1MQg
 IRwCp+h49PYLmyKg2Fzbd9SU7/NYwkDIM/EDVE6nXKk4pA4NcPeNi31Hv4EsDLMubpZquyqOWW/
 ZfyPbn7magNCCdeZDu3fcZuyr5hJvv8=
X-Proofpoint-ORIG-GUID: N6tesOzeArmHYs0M4Webd9UknwplC-Na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150025
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

Compute blk_find_max_devnum(UCLASS_SCSI) only once instead of
on every loop iteration for better performance.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly created in v4
- Has only scsi_get_blk_by_uuid changes
---
 drivers/scsi/scsi-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index cea6d771f7c..031dc01b9de 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -30,9 +30,10 @@ int scsi_get_blk_by_uuid(const char *uuid,
 			 struct disk_partition *part_info_ptr)
 {
 	struct blk_desc *blk;
-	int i, ret;
+	int i, ret, max;
 
-	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
 		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
 		if (ret)
 			continue;

-- 
2.34.1

