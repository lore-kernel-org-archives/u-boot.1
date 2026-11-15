Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F75606A32F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R5/OOEmS;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aYbgJ3DK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UN2f0faD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67EA860709;
	Sun, 15 Nov 2026 06:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XemB32b8Livf; Sun, 15 Nov 2026 06:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A50D6064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794723988;
	b=bbeoQ+6Ztz6Sihc1Ay8ao4am48kgZj2AjL4wkFV3V4QBaWnuFVpF1OFWcgJMJBFAZf0p
	 ZcfMOIk6KZI5tY8FDUfAe8G6Fb9FyWZ6kBEL2QPfqfoNe1GYtpyaIJpVtOZLFEJgI3WOX
	 zl8tnLzgdeSu4ZPKzmzEZF97hbiRcioiAeHEg91zmojjHPUBneUpgrlGTaPNogKt1/JVn
	 DWq75vdyIX0F5cuFFajllZaAFUk0t/uyVv67dM9sLi4rxhnRjeXQm4qgaqCcorGHJW1Oj
	 PGRYBBA5VW4VmCFR5HCdTSfLEYJE+lXYNiqvdoXWuQ2z/HMyr9tFK3uNyp9P67/7s1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794723988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=INCuNZ9qzEQNZG73Muj52crRpeDqQPt95LZKV5tAFbc=;
	b=I56jXw7N85FqPt5QskKYQ6jC2veAFjxSk78ek42WjMICwFQ4OdOCxz52DMe6vVm0CxGt
	 R3SFAvxIQnSclFSI/bcdPyI9rwl64XIjmASM8WoVnh015uDXYPIH+FkkAfsPmFaJmEfMJ
	 NJc6DCjTAvqnXNXq3ptd70UQXJaIlC8BrwXyt+u9J9jdG2wkKX2ya7tzwDfuDphKh5VW9
	 V/j4ZTnjNR/9zVzjReEPRAUz59aaiQbKPurzX6+IYx5OcmImuQtuhuwpBxV1EcoWgYCyb
	 M7lXvrDynvxPm7kwvB9wVXCN+G6xtblm9sH0Ecu/AsoY6vkvFL398Vgqm8RJNpZxCAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794723988;
	bh=INCuNZ9qzEQNZG73Muj52crRpeDqQPt95LZKV5tAFbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5/OOEmSHzJtgQaYGMUtsjIusGu+NsU4FfZRBUT8JXMKZDQfsRiZEQTtZCl/RrqLw
	 5Wn44PnZsbSZqtAITzQVv7CUOXzt+2l3W1oXekal3zI2KKyStCcw4KRYJ8P//AqFRG
	 7wxJmtIlPDn9q/BFonlnvP7wHDvvkYwKSYvLe9BFBOZjD/nVZjGKIvsGZ0KSl0Mc3w
	 dbKAr+Z7z5PhMc/eDdNo87TE0Ey+lxPvqLYT2kNzHXHMO7u9mN0O0DNXwJl11T7Lmi
	 CEQ9FitLRjIq2TLRVD0PAUDoosercL1D3MMyU6wMJ18EFa3Y7tuvmY/s9MZiUUCRpX
	 xQzIyk68txZ0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A50D6064C;
	Sun, 15 Nov 2026 06:26:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E6542E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 043AE406DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_Ow_SkDM2zt for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2AF0406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aYbgJ3DK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UN2f0faD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2AF0406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S6NY1232071
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 INCuNZ9qzEQNZG73Muj52crRpeDqQPt95LZKV5tAFbc=; b=aYbgJ3DK69bzW3QO
 tXl44GG+lz7A3F9keYZwCiQe2LmwdZLn3OOHGRKdLABfA7OSCgz4I/oI/m/U+oWh
 mvXtP8DAQ88Jasr95ICX8dNwPUVVmrNPi60wMQnOs0IiwVGLBioiedAqfFsTuiVz
 ZsTwREJAeMgUwA3U53gHuSe51r2/KnHOeNgq7jwfZ1s2XNbfCbBx5XQAEk0/K7xA
 PWRLI9KGBSDs0uLWaW2+65KBwPDvdxUSrznSsSAN8nIQ2gMXGiMu+yZpvF2E2uZ2
 QM9NjDBJbZ3Tpn3ydusL5UXh8IYeJXBRtLiCTPVYa87/USNV1QMF3GN7XjKxmfvo
 Pf6cAg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwabh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so888101c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794723984; x=1795328784;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=INCuNZ9qzEQNZG73Muj52crRpeDqQPt95LZKV5tAFbc=;
 b=UN2f0faDwByd8BEtn1sR7NTQ7g9YrdQVlWdrhyumUOVtNbCyQUHMztt8vylciLzSPx
 DJXjUhXw6TtC0uKJvu7+3pgpz+X7iK7V8zBNSzWCpcBLzv5vTV1UdO1G9uxv12SB44lS
 fzaaScNiwMqL5zgZ8I0BlfTxe6AmPJXOeGS1tm0n2JkRxQ7nDvVRbhPB/Dph2CFjxvq0
 411ugneD2LFhmZeUTcrOxFh8Ya1Qd+/gkIrD42GCiIkL2G0pOEXDRpjeWvpp/Ptru3FW
 fcaRJONoorWWQfj1XJ0vU9n2pDXqJ1OMhdBagC0DgZAl3C3tk7qyh+RlglljzU0yufb6
 FXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723984; x=1795328784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=INCuNZ9qzEQNZG73Muj52crRpeDqQPt95LZKV5tAFbc=;
 b=ol4/r8Dy4JsRXlqunZ/QuCn/PsNZevXJs1sNIcHR4TpqofN5+ngh9p5ch26Dq9SV8b
 JoQBfqu0GAQtvMqBP7F6WheMMXZSH9Vt5Q7qEQPA3tYPuaDjPxO6xv4UrSJAApYioreG
 mDe2GzN1u4ButveAbx7loAgfU42xRCl0c2g7AVXuUSaEzrP1m0bUcYWUVob7h9Pm8Bvx
 UlFMDoxSnDFveLv5+0NlBYLju6FlffvDeULmNIjNCwLWyC67xeBLqS2zr/cOBIr5aLYW
 983ad7rnP7r1tIWhZmArGQD0YaP3XuC7BW0VhDx4+mlwjzznnP85/JcrQflHL5QpSETy
 N6Ww==
X-Gm-Message-State: APuU4Z8FF2NB/H4RaTGUuNNUfu2B2Ddz/MWPisRclNrCo+6lq516+w8Z
 +dVCu3XGab+0vuUtwlTptho774t9rjim0UPXIrCsV+10mHnfYSahuQAaDZ0l1BaG8gH9HfE62Hi
 jAywGS+c6UxKDVglyPt2wWM8u8nxMmxhmQNJkTITPGOKbEM61EgPM9uUUgVjYfFubPvHBJaU=
X-Gm-Gg: AYBFou0GQWhsU0V+8N81rNYNzU6sSXCgLohv0kL5YWMZs4WrC4Yai1xQA7+eNXaQUFS
 iqm/BaS0qfGCUOJbPlgKtWsaZqGDh68KCqKyRiMMT7JWSuapg5dPE9tBKSBnmIZD666MNXOY7EM
 +MBdh2lfucKF29ACQC8B9HMT6i8Wg7la1nhQTQ6nDgK1z523HK88+YQnj1ezVCtsRIJvAc4gN0L
 i5zAw/AhfQo+a+Fisx1R+baeqNwJDikSiVyMthfq9td1zwLkVIiZxBkLWdEDtEpyqFePsMThxmK
 P1JMZiS4rvkGwvhvHlRO7qsKms/mcdBDQ7RMkccfuFzub2hn42Hmm4A7kb+zAneNHLI9mxQYfgt
 sTd0NnwQHFx9oT/OwYXMl6uz4J4QHj/SBPLyTNB6tSu2+eRkar202wZZT8LFmANJR/JPkxdyzo4
 o1NWbvTzGGqb5mZ+QSuWpHjpSJlzzAHymyAWQWQr4cq7ORrbH0b6xGW2MPGQvsTjjiJ91OuIkhe
 GuT
X-Received: by 2002:a05:7022:295:10b0:1b2:4188:840b with SMTP id
 a92af1059eb24-1b50313a5bdmr6975478c88.25.1794723983832; 
 Sat, 14 Nov 2026 22:26:23 -0800 (PST)
X-Received: by 2002:a05:7022:295:10b0:1b2:4188:840b with SMTP id
 a92af1059eb24-1b50313a5bdmr6975461c88.25.1794723983334; 
 Sat, 14 Nov 2026 22:26:23 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:22 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:03 +0530
Subject: [PATCH v5 1/8] disk: Add partition lookup by type GUID functionality
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-1-79e76209457b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=3333;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=saXddjQvq+Mw+lZmpZgdXE+CtVswWy6kP2Xk3vunRos=;
 b=PS7dsnXL9Ieignw3jN+JWoVhSSl8Nu+9XGe/8/JMluoGwvRIIIEUecSOs8gfHtaf5KAlXIyvI
 Q0UiPNgeKAeDEx+ggfvdZKrgdPlf5z1fJ/zX9UwlsLOvV2USLiNKyVs
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfXx/TfqZbu1IHU
 R/ust0ps9K3GRJ/Om9eGJ9vYn3sQnaM9gVjHiYW6oFUjoWIrFU4qXqEHomzD7F7UrdnmL6O5Kwp
 zUjB9fGQI6QnzXUS4Mi/v80kFZzS5ZsllXlgG3v9R6LgUVbMtlTTyQdbGSmKnYcigY4NFnOVv5h
 bfgJEu3avy/YB1+Uo6uhGp1u3CHY85PJvqCh/JZWctLcGGcXZLeo7nNzA/umuCTarQn0FeT1fnx
 NlDFu0vWhfPuhgDf/uCx1ef2rZqIyZqXB48mekGAQO1K/YNE+K3GB3HX/QrJrRzcE8o+/adgjmh
 VpUR9PxfLVNTg92bo+RfFQHWaPd42bDHko68HsAtlTuNTn7IgysWutJk8ZvP3a6V3FOqKQSwL/y
 0BL7r779zjHkbebu0UpVrdqva9XTwRr3EeQNhx/ZblcQJ0MElb9rs3E4QWuXJaAY5ghYy91568p
 6wBIFXpYI+7Qa3nv00A==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af95090 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=njE6j2fD9wNKUyOOxzIA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: JpLgsKN1GoXPgfKW47ylW_nQoXfVCgDr
X-Proofpoint-ORIG-GUID: JpLgsKN1GoXPgfKW47ylW_nQoXfVCgDr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX2jU11p3Sjj6N
 tY5KEcJ8RWHQEEWMNHIUKFWkO7awX4yvhYHdeTC6vn92CcfA/mOxZqKAbVMPladdunyEUUcAAlc
 4yWpuEt3kZW1sAwUiatMni2cvoRtKpw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce part_get_info_by_type_guid() function to enable partition
lookup using partition type GUID. This complements the existing UUID
lookup functionality and provides more flexible partition discovery
mechanisms.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Use IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) instead of
  CONFIG_IS_ENABLED()

Changes in v4:
- No changes

Changes in v3:
- Addressed minor corrections in part_get_info_by_type_guid function

Changes in v2:
- No changes
---
 disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index f80dacc5ed8..a91dd2a73a3 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -738,6 +738,43 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	return -ENOENT;
 }
 
+int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
+			       struct disk_partition *info)
+{
+	struct part_driver *part_drv;
+	int ret;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		return -ENOENT;
+
+	part_drv = part_driver_lookup_type(desc);
+	if (!part_drv)
+		return -ENOENT;
+
+	for (i = 1; i <= part_drv->max_entries; i++) {
+		ret = part_driver_get_info(part_drv, desc, i, info);
+		if (ret) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
+			/*
+			 * Partition with this index can't be obtained, but
+			 * further partitions might be, so keep checking.
+			 */
+			continue;
+		}
+
+		if (!strncasecmp(type_guid, disk_partition_type_guid(info),
+				 UUID_STR_LEN)) {
+			/* matched */
+			return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /**
  * Get partition info from device number and partition name.
  *
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..a5c00ec39ec 100644
--- a/include/part.h
+++ b/include/part.h
@@ -330,6 +330,20 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 			  struct disk_partition *info);
 
+/**
+ * part_get_info_by_type_guid() - Search for a partition by type GUID
+ *                                among all available registered partitions
+ *
+ * @desc:	block device descriptor
+ * @type_guid:	the specified partition type GUID
+ * @info:	the disk partition info
+ *
+ * Return: the partition number on match (starting on 1), -ENOENT on no match,
+ * otherwise error
+ */
+int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
+			       struct disk_partition *info);
+
 /**
  * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
  *					    and part name, or dev number and
@@ -407,6 +421,13 @@ static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	return -ENOENT;
 }
 
+static inline int part_get_info_by_type_guid(struct blk_desc *desc,
+					     const char *type_guid,
+					     struct disk_partition *info)
+{
+	return -ENOENT;
+}
+
 static inline int
 part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 				     const char *dev_part_str,

-- 
2.34.1

