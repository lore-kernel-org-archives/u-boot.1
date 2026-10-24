Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BA606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YDpeD0/y;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NCCEWBUm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HEIOvUBj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67B4406AB;
	Sat, 24 Oct 2026 17:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzDpg8hDzObh; Sat, 24 Oct 2026 17:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00374406AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863777;
	b=NnDMkxxUKFEn1uStp0UGZ4BeA2oGurHMLh7vd1gMBM8wPQQwhoT1CI2QyQKoi1mSgKG8
	 TfI3htzsYRlWDuLvst4lLzlnLZU20VCd0rEC+7Ph9yzu0jCVSaeIruubKjfDUIsNyesoJ
	 usTiDSMuteC0H0ybKh3nsmEeCZ9TxGnOdBd3M0X3CicypbL6Nk94xQjVgBjbfG5vnlECJ
	 14AiCsRhYD7PKuTILnAhYbf/ECXlaTElTvNUEqD3c6nElTUfKtl7rLEWcoHeimNpVSlxe
	 52WmBZaVHaIQ6hJl0S9JEoBVA9BOm/G3tstzWE/zQTMYC1iJf3OsyLcf3rCjDxyfsAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mbWgV28ZoM=;
	b=PfyKs0Msefk8lsOH8GPzdtvH2lzxiWHS3WmJ9pqoyahNZNB1Q3UnQVAuGNlao6U87kXZ
	 cBJtfqSVTrDI7H6b5nZWYIm+L4J02bdZCNxtyISsvMGSnO88LlOvGLssYrpk4dQtaYCIw
	 x7+gKxHAUOHPCCdB1crWE3j9/4CinuByAz/zIzwdiB6O9xw9SDmYY413Mqk6wg/tyFdGG
	 oM3HWgQZaxgJ1R/GY/A461kxvwmZnMXPw/DAtMMbVx3EyuMTyF95QiHXPs46vTf6+XnvQ
	 Urkj5JfqXf0WZ8QykbRf8Cxhr4g46lKYtJWAwq4wo/Qx7o/U1KrBP8aTOvQymbsQI8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863777;
	bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mbWgV28ZoM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YDpeD0/yWQgsbM/KGvlFxxR6XWyubfI6M3UXxPTAJjuGWL4B6XUt8L+mmNqrXMNlT
	 mAwEJnva+y0QANUful38xUGKrcTRt11bSj+QENxjhNLWPCIvhEKp87HqwiEFTJhufS
	 AKs6WqmN/zjm4hg1z3JA0j7UsujYjIxWaa1WlZqnIDsxblcEnaB2ZCBzcdCPCZcEI9
	 dGvWMebU475461DUr+Dp37hmKQpI6CSXYabL8OsggxFSduLv2J113iKC9xljDFyhh7
	 1DViYYH2j6knOZKWesoqrrf7BSsrcAk0EoAV4rg5bQwbl+Oe/xkI744WvGDN4yqDmJ
	 vAbEtUbcjkhrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00374406AC;
	Sat, 24 Oct 2026 17:42:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB7D3D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D46574009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Jrn_nlyiLSh for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5E7840049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863775;
 b=hXhz11e0Jwx8YXVxb8Wum4GL9swIiaKrP07qAvejq6jcIkPrU61gCk5j3DgkY+CffiH8
 tp/+DQlPsjkk7avw6SP7ub5YmjH0tb4pVBjrX0A9v7OAbPw/v3REM7BaJE6u5zbRU/XHd
 HN2Cd1gwj6rE9FiUBM8puhurcj+eC3Fc0Ix97UyEWbobkvfZzXUJejjON3K2KIo5lvTVb
 C+867aCq6lTPWjSGS7mSXXH4CUNzbeyhGRVP6utW8gVbEEAo7IVnpAcFv2NmPjdyHD6Ig
 iqCDjxLDw58OT55fzcbgbTDtHkYQ4XhBr0l1RpC8hcY/++1L261wSgVMKX100lnGKHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863775;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mbWgV28ZoM=;
 b=YgUrdgm73J7/gqG8qIBO460l+NKkYW0JZf49E2pq3KiOBPoi3WtAXi7jrFpz7lmrZ4OB
 r6UOpjsBtRXoKP+Y9ZFg12zIznLFmS72mz2J1Z7ryMdUYPoT71t8cfRNVU9UTvLDP8S1u
 Apw7NpiJt12xTFEecifqXOnd3Uj3XvOc6nNt99T8r07ZWNJhKn4cF23dvqZp61P6SdhGa
 Jj1glSqZB6jPRwvUUFz8R1yC0swMV9aLRIANx3wIJT5QFZc85fLDqlb6BHvWhiXfQtR/8
 W+CzsWT3SE7UOAapDamYaX/mrGtVPDHS2Z4/HHN/ygN8C+R8sYRtImZhirOmIC9j7TQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NCCEWBUm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HEIOvUBj; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NCCEWBUm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HEIOvUBj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5E7840049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:42:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF07pQ1563523
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mb
 WgV28ZoM=; b=NCCEWBUmndYjLT3XEeRP+AOHyhhbcR4ft0remxyaKFSRkL9uY+S
 xupG0FLYoS+aMglMkcdQ4g6JrS1xiGEcxztnyUdpGJX3xMUnNiyYs7JDkAHZCu2F
 XPYttoHFlFKfYW5Vdw0OlGLICMp3z7KTzb92cXz2n01tZlIPhvLRB5t2R81WBTzU
 wVHngPcrejCmXlR5/g70WqFnjg4hUrEjqi6wmrE4TjEfPAKGVhfBpyCJnosRuFHY
 ln/tfZZ3Nyw5IukFWsNKIg5UC5z3en/6omLsIKjFkTZNMjH5DDN3BKcWIMo3YJMU
 CtjOs64HSI4vCluWP54Akubs6o+0WjsbV3Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0ghjrx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:42:51 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1665200f4c2so2324552c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863770; x=1793468570;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mbWgV28ZoM=;
 b=HEIOvUBj9YT66zRoqb9iLogCXwhT+WLp5FdAHczKwFLGCAMMEcA+2xUFR8pf71RPoL
 ThHGCDs6AIdRY5NGQZtNC4FhgQmMly54uoWMvG8hgiyQIHIkx53FWESILQVFvQYb437h
 8M3qNwtqLOyd5UnXhdroWPBVbMHoaPDjvGftS/l7j0Gp0TTu1SoS3VratazzOij0h3BB
 1wMYeEjp0+T+hE0GWWBJ90ngUlPM8x4lf7LaVqx/BRGwOgPO68XT+yp/ZNGx3mzzZ5mN
 0h0JwI7BKVn/6zXwo3BdTxvfYo9sqfHeJe8d1KuG24i5auFmM1HAAp/895vJlcooS62M
 SA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863770; x=1793468570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyEiLNZsLhnTApo1wAYAZd+4VWAqfEUM+mbWgV28ZoM=;
 b=U0DJVEOHIFb5To1M95p0hosYhRuFNXTUgkIBKPIAIxM2wexKIQ14lxmAz+sM8c0VEc
 /PRyHIWAZF5UWZKuC+YuZTFGuzTsSjkzrgngcz9ojI/bceIwXaj8a1+6OqBByuLVdOV/
 nEL92gH7DBw5beq03yChbd7Nh6vnz1Fa/xd1MZiI6N1hV2R9yP8wl4SQ4a2r4304wkE0
 vF1APRhMYP5EakW8gegd7UCnVuKtsFL80Hmk3MOSus9kcUVX0Cwgno/yaoUY1dzL55pq
 wDM6jT3sryc4XD0oX0kR/on5GrP4iykz0nBvqlb+Ylib6tOmqKW9woEd28ySubXxHKtR
 yZxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/+vAW8BE1PvZBEF2qGJXsKuJ+jBy9CLl/TA0BPRrj6kGOwhreTwtbDc++J+L646H/RFmLwQw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIxHGzrdr/eqVkWuWbXJposEg5pbYEtE9DuT7nsCMXZdMwH5+KW
 ATO1hLVCR/P4x71Ps5XDf0UzNN615NRjZmx6BPtW+5fUYMrE2tIgD4IUelbsOSgT2aiBNslU0Hh
 W5jqUduTcXYZEkBgWzY0ljZjIoLeNNDYmj6LW9uYa2i5vQ0+SXuo630xTQkMDhKXDQ30VtszfgZ
 orDKo=
X-Gm-Gg: AYBFou3hK//3EWx18mbCwdjv3yh3NbjNCLt8NBAog3+iRTMAHztM8SK6NRrjGuPUBgQ
 TU4vrP6beSUjNVKCpmbE0qEIC2XgjYLkbqZkFu7kEuAbs2jzllHBxZnhnErA75huW1TBdNiwKIC
 +5Mom7JH9AzQm7N5RU9D5Md+06+zyQkE3R/3m/q1wOONa57JhCX1yeD1WtKDuufBVydXvWQauFm
 Emg5GlwA1f8wQLpqXIlgV9vMEZy+sPdu+UTfy4ka425k6UzcJCdPpShR6+poykvVzUxq3rh2Fj/
 lQWQ78ZvCoDUU1QT1Gn9DGEaj+QldhPRXASVcqQg0w464qYU1uB7TALVsv5ikSqo+hAOoyD58S4
 voaDkqPvHxYuF92dG4SIsrB2BIh5+sBnFJDvJ8tBTiqXLzsaec6TkJqt6b2txnrT33iJ5bfZF0I
 BYGyp7QAanIIUkUXKlQh8=
X-Received: by 2002:a05:7022:7f14:b0:16e:c820:b20d with SMTP id
 a92af1059eb24-19929009cfamr3437047c88.5.1792863770179; 
 Sat, 24 Oct 2026 10:42:50 -0700 (PDT)
X-Received: by 2002:a05:7022:7f14:b0:16e:c820:b20d with SMTP id
 a92af1059eb24-19929009cfamr3437025c88.5.1792863769596; 
 Sat, 24 Oct 2026 10:42:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5a515sm7885130c88.19.2026.10.24.10.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:42:48 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
Subject: [PATCH v2] mach-snapdragon: smem: Use available_length for RAM
 partition v2+
Date: Sat, 24 Oct 2026 23:12:34 +0530
Message-Id: <20261024174234.3530184-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OOYMR03LRAelLYZGz-rOcQdUJJuhktOQ
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adcee1b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NQbW43lCRD_eDx5gHQUA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: OOYMR03LRAelLYZGz-rOcQdUJJuhktOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX3/eIslaV9fM5
 QxBpW6Y4dR9qBI7OxGjqywtzqY7WpbFMvbgdP1b+rwnKoj2sgbbh7jfeV0MvfEygdbefttsXRmQ
 hTCDsPBcmznJYBg/hBFMvMkrtHoM7bdW+8935Yn3lDiE6D37ecf7jEzl0RAY7v0n1dl6BGaI6QM
 Qy3bEVcIwsXsvhkdCvE/qgkakVxbT8WPefPHxvleWgce+fKNOc6Ch7Hsh+Io/RCbpKrv1GliloF
 VmeMt9hz/0TewzvFVmFCgBbKjlfVJ3DKsFfBRK18j9d37jD+vNfdb6beRP8/86znmer9rZf4fs1
 h7QjyQkyPUKKb7DuYw2ScYPJeWbvIDHHs3rfz5rCPWnfNKW933/juMt8pZ2f90vnLRHO4Gk/lW6
 H9onDeJ9gGpZsWs8mJG/rB8PuXBt2fSBqH3wdq2SKBUK1QS+5vnbdCnSI4VBQmnxgI8yQ3GhPim
 sq7UL1uLQ7kI+hqkdGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX4MOdHcV9/Mtt
 J5OCltG6vutlz6C72JDEsEDpfBZhbW85F82IVrrJJB4uQJPlW+Y1tPVF64KljHXsh7Sq+FjRDiM
 cksq5J0aIdPT7YbxgN/3M0lmD23ji+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

Using length field exposes dynamic carveout regions to kernel, causing
crashes when accessing these reserved memory areas. Subsystems like
hypervisor perform runtime carveouts & records it in SMEM.

RAM partition table v2+ includes available_length field which reflects
memory available after these dynamic carveouts, while length field
represents total partition size. Switch to available_length for v2+
to exclude runtime carveout regions.

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Fixed the indentation.

Link to v1: https://lore.kernel.org/u-boot/20261012173227.1615249-1-aswin.murugan@oss.qualcomm.com/#t
---
 arch/arm/mach-snapdragon/dram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 0b97b698322..732e2bde2d2 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -70,7 +70,8 @@ int dram_init_banksize(void)
 				 (v == 1 ? ((struct ram_partition_entry_v1 *)(e))->field : \
 				  ((struct ram_partition_entry_v3 *)(e))->field))
 #define entry_start(v, e) entry_field(v, e, start_address)
-#define entry_length(v, e) entry_field(v, e, length)
+#define entry_length(v, e) (v > 1 ? ((struct ram_partition_entry_v3 *)(e))->available_length : \
+			    entry_field(v, e, length))
 #define entry_category(v, e) entry_field(v, e, partition_category)
 #define entry_domain(v, e) entry_field(v, e, partition_domain)
 #define entry_type(v, e) entry_field(v, e, partition_type)
-- 
2.34.1

