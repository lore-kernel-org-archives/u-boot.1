Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC84606A5D1
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DsPsWDEO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nv5YfuGK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QvF8Aw3C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 445D640A24;
	Fri, 23 Oct 2026 15:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2Z6-qgEVASp; Fri, 23 Oct 2026 15:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6273140A26
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768331;
	b=sydQSQLw+L4SXVq7r3usf+XfjmCTb7OWLNSa++eNLbKFcfGsOuRv1/PIWi9V6138PZLX
	 y1dmVDT6/Q7SkuwORNfI4v3fFwH5AXiwoc1WIjVSkrN14oT8phyV0SBQUV1k2z2mErsub
	 5D1CVOGyOts/+bqpi4Z8HorKKj7MNsumSqT9IGSZF9DEJv5e0EwActpG6sM4cvOGvVPIX
	 2LB1wcJdZedACG8y0JTCja13hd+/OlvR9aubT2C+5V9acKiF7jthny2Vacnyeqbeim7q6
	 wH+sP/TQezxwGYIE3yUb1eJO1xj99yu71xOUODLEdFUSqmbb8g5UGDAvaDtDVwJTHqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
	b=IqLTm9l3rSyvGkwWNnTG+vGLY0sO1FpnL/xL6zUla0rH9B7Xx4raXpDUeKadUOzlC2Xt
	 S1aBdiGBtZC5c6eGZvYDh8aPvPM0nn4Kym4MKHTqUvHKEHTfC2M6CjO1nHfz+wkVViVCo
	 eK6r5zR02bgl+QqmUWu//h3ldRLsUW5TWjJqRUWu74+WJrXry9O8y+AjHBAJOcPk7O0MZ
	 CFA3SJqEXpggPlAch+8kCSa0X5/e4YN+Bc5dvWE2tjsusqZNn0VskVts2boL/8NiFzZXX
	 +pbAgDpEOeRZYUxhU04cDI8kWkL2TDGF7H2PwHaQ63eCjyHcis40eKlY1Ls4b4ZYIeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768331;
	bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DsPsWDEOYxMupQqOedgTS1gLR0XKGbCKeHMQl1zRGffZoTup0j/6IzOxFP/qw9l9k
	 4Ag4A9oq8Wg+xWmWo4fu/dqnMyVTLa8R+ihUhGehmGkoRacy+W9JXJcq3f/ryT4i5P
	 Imk5fmJeM3QrWTLGNjFnMhHYihQ9XS8FbEsnzCBKLfWy9K4fpLxpfewLsRwCYWpB3N
	 2voWvPQyruCVue722wOfnTo9F0nAscg61AIPPszsB9Fh4yA16VuwAwLLwdQ7/EHw8F
	 8c2/EX1lCtLt73YhW3txzDXV+EG+GDEpVrB7QUz2tYoyx9OZ9Zo6pqk9PgtKQq9UYa
	 zQgEMxgdmAwlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6273140A26;
	Fri, 23 Oct 2026 15:12:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBA3D3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D195860648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KLPVnd8NMf7M for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:12:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB13760628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768323;
 b=IEEov7L/PVY68VRRrumg2Kbufgk1bbmMv770JL0jDbhhdKwAIv6KeEyUzkRfB5PyNhdn
 UkJCUan7FoIEGlHDLVL2arLjBLrIggBoFe5xfzEHIQwFG9bfR7CVG7mo+2wHbcBwHE37R
 WqeygR7UZwxRcDC970QvRZIELUv5gOWx25Z1cqALWDurZ1AHrOWsXC5o9Ww3+44fWjLUM
 nSRQuYo3yNl8digWYZgim1j3wOrJS3HX0ymLIoZtoaMcsDAna/bK+DNdmYcwVjXsJmB9P
 BkSgnYajNqj6dn0zXwFAA0kQhAeIz5TmcEDHeNpT93iI+NL0gOaBcPecwHuo8PRX9QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768323;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=g+y0HVgqwrVZP+sB+8FYPNf2YwYZs9wC7amBJ7tG/WEMVsXMLiz5QeHjr26BpNhS62Bh
 4jpqbndzuutceJPzvemOkwMsFOpKjRWn+r2zyLqSbzugL9Q4AOrALbeW521H7eNF3u7yS
 ESGe3cSAmSvKvMNCwp3pl5FnIuqaRLnQLRA2Jm06vMBYGociSkfDx2ipPE1y4+YN9h3B1
 cGeC3pRHu7MvOivjxkh1bkXJRehfY0LsUHh6jnlPCbVbNdinfT1n741OiEhRuyIT7m9NK
 pAYAqHRGBP2kYdcQh1pETrJzmXEuAL8rTABrBHZgftRZqvQnuxP5D0V+MMl/zENSVeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Nv5YfuGK; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QvF8Aw3C; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nv5YfuGK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QvF8Aw3C
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB13760628
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6ATG2974544
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=; b=Nv5YfuGKYSB75sTH
 0iyQ9Zu0+NXHrSJCs5hRdvz3sZy6izVi2S1rmWM6+fzUw3U1Y7crGnSu5KhFiMaV
 ZxIJhW2JzCtkrPUdk4hM8T9yxhi7R2X6Lr8gmiGAoBHdJJf5Ac0zflkGwfzPo8T3
 DFqX/XABfw1VqaVjgIaGKA5ejYw4RjWPktJOH0x8b+3YYwcR4h5MJmHFO0s7JA3P
 lqrHzHh4aA8GTPh05KpcWCITKLOI9eMfrjVgarSM5/A1k4haNdk1RiBzjA/y7WV3
 w8B1PVBYORuBXk1rbBwEv/lwG44ibvqeL1ujWFMswPmh3eXznpJjt+CUOCJpI18W
 Kt4Scw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4r2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso125098785a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768319; x=1793373119;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=QvF8Aw3CyZwbfaewcvjOmPSZ+4lsJ5UvbOEAh88Q8t/IFK37/y9iEgyFJjHK6neQvj
 1L1IldDIQD/j2s3pYYSNF7lipKhoaWz2BjYP4/UC8wfX1PtVu9cKcXuVsktd/79vzpoa
 PvuchibC7/RZ+8haC334RI3Rmv/jvAyMnklorCxjl5EnOVvmgjnBfx+StwCDVmzKrqXi
 Ddg+NgYOXNqTIo3up1WnGQv+2/ow+zDKDbPIRnfChYsjaYxrWATon3pNGwNA+1K8iuA7
 cPCsA5s8QEqFkRBd3CP1E+m9se/Se0yzFN0xy+zJZ2606IQe+JEDvbT1luAy2oFyT33h
 Q3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768319; x=1793373119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=Yd+nhsgaxCbXvOR3WdyKcbKzfxc3CwvqiUjAKEaJ3owO9UdaqnvUuio0LGEVyvmLyl
 uPVj1SM0XisVGwLH6dOts9C3/4ntaZOr64HC21hY4gXi9grmnsXHnBYcEih0UJ1/0oY6
 3VgMi/7EmeYHSgTTHKDTwhWreNsAtG8BKQvNq58AMU+zhYUhi/m0s/UkI2UfStvpb4o/
 dAAW5LfjwykAzdvWUnNMlPYvogWrnAEh9MeUbNdG09liiwRfxeHq9EnBrxSscFXgaLUQ
 nJ/sIG/vujvgSchqSZHhMqY5Z8taFvpP4FdcHwSM7Uu9pL85eKMSTRLbUV8cNm4CbhwB
 bk2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq4V9/4N0ynJIbjP4+GbVEO+4ahUh+nzc9U6rGvcFFXWN2n+a8M3KDdnm1OaEHpD8yzHaqQjo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZJrfHDVPQKsn47U5YdM9I13h5PQrC9Ql9d9c84l7Yv5hMU4Ow
 KgStWn8iE7F/XdtlCaAgYGNCKXkjtuY3kepi0PZjsg60JIoB4TkNZYwKT70UkbQfflNQPkBeWH/
 O1FDxGoYnAmwb0a17Y/zKPsc9CYlmbunREE92N3mlxkr4sy88KK/Ml9nu9rLm5JELFeEeK24=
X-Gm-Gg: AYBFou0VGPqXiM+odMRqIcjWq7CMyUk5OqxIKsUt5EMsTqfSovAKAAoY9Kg4Istf5La
 +z2aQEdEspgAzvtbXmeWlE7NkqCtyDvWTRdCfJejJYJOQB8glAdaI71sWGUuc71RFN7ApwfDIt3
 XwVteXxq+SQKHfLTEpZjW62BWAftIXlA+1gIVV1O0MDawFfTJJ1r8e7oObbTBFNP1UlN0lztl6U
 d0IbRUZceHG658W9s+FeOaMDCMGdPv/wM8gu2YHv9FS+/TO9YaUVa2luZUzyVG8YGVDA/XqmSEq
 aTQZjiQmWuCXdLPOJl8vKEUuC6r4dsjcuBhzu43ARIGkZF3Qk+xmoyYvBW05GugXJdsTAQWiZ2X
 9Zfky79pRG4HYIkXMg1YtH3oUgIxxONycsC7FFMxuzb53i7o=
X-Received: by 2002:a05:620a:1a0e:b0:93f:2236:a61 with SMTP id
 af79cd13be357-93f6f9ca079mr473563785a.61.1792768318777; 
 Fri, 23 Oct 2026 08:11:58 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:93f:2236:a61 with SMTP id
 af79cd13be357-93f6f9ca079mr473558685a.61.1792768318212; 
 Fri, 23 Oct 2026 08:11:58 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:57 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:11:44 +0200
Subject: [PATCH v5 5/5] doc: android/avb2: document the root key
 provisioning and lock state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-5-6453a6f63028@oss.qualcomm.com>
References: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: OblmUMfVSp37rI_yVszz1fQ8NuWxR8k1
X-Proofpoint-ORIG-GUID: OblmUMfVSp37rI_yVszz1fQ8NuWxR8k1
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7941 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=DnaZGjYjaaDC2aZnHNgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX/5wY8ZugDFFi
 6+g0bVhuxfwlS9x5Oyu1LrIxgwf5QKeSxG15Iu91gsZojE+t/vNsz1pxYZzuam3R7IMSodbueij
 qTTaIAfEciXIwRXUceJS9j0tTvms5gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX4wAi//2n+PWR
 SpuWrEcozVeQrRf+BUQhEU+DAhKxKd31/3PZ7i+gzHZSTTfD3PRNp9LOEGZeJyhSWM5NTeKWQ7H
 RT3RCmYKQ1aXAnA4QCRPu4ZVouYJ1Lcm7vK48+4oK2eycuTr21KpDt4ahBo3PBp2mVrhMRkTqM+
 HFTjiqFsFwMRmqIIZSyvpNtVAxqHtRdlZ0xV/YAaozpUy17VhnFIocBgsNJrUWip1vMOeHlCfwC
 NIbhsCOxzwRkIvBamKRjJHHR3Dm3+0dF8KN0fig5WPMLrKfMzZHFRulDfKDdg43pPj/TcewQE6P
 YcITP+CUIgCxmKu5pjsbdjSmtlm5w16IKMp3PoojwriBqwWC/qluIPCGj8u3vwxQA/iQyB4ockZ
 2ZwoqVoScq/lklENn3fUJUtB+WY7X7qOpwpKyCe93UKBDLn9/7uo3NVM593SfZRVEVBpi6erZHK
 i7Ji5NOAgUotMyQVU4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059
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

Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
how to derive the SHA-256 digest of the vbmeta signing key with avbtool
and provision it into the TEE persistent value with "avb write_pvalue_hex",
the fail-closed behaviour when it is missing, and the device lock state as
seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
mandatory userdata erase).

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/android/avb2.rst | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 43d5600d2d7..b3c7617b0d3 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -85,6 +85,72 @@ Note that device lock state and rollback protection are only enforced when
 backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
 verification is advisory regardless of the root key source.
 
+Provisioning the root key digest in the TEE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+With ``AVB_ROOT_KEY_TEE`` the trusted digest is the SHA-256 of the public key
+in the AVB key format (the 1032-byte blob for a 4096-bit RSA key, the same
+encoding that vbmeta embeds), not of the PEM file. Compute it on the host from
+the private key used to sign vbmeta::
+
+   $ avbtool extract_public_key --key key.pem --output key.avbpubkey
+   $ sha256sum key.avbpubkey
+   7728e30f50bfa5cea165f473175a08803f6a8346642b5aa10913e9d9e6defef6  key.avbpubkey
+
+and store it from the U-Boot shell as the named persistent value, which the
+AVB TA keeps in RPMB-backed secure storage::
+
+   => avb init 0
+   => avb write_pvalue_hex avb.root_pub_digest 7728e30f...defef6
+   => avb read_pvalue_hex avb.root_pub_digest 32
+
+Until the value exists, ``avb verify`` and the Android bootmeth fail with
+"Public keys are not accepted"; a wrong digest is rejected the same way; the
+value persists across reboots. Provisioning is a one-time factory step and
+should happen before the device is locked; see the note above on protecting
+the value from normal-world writes.
+
+Device lock state
+-----------------
+
+The AVB TA stores the device lock state next to the rollback indexes. A
+locked device refuses to boot on any verification error and reports
+``androidboot.verifiedbootstate=green``; an unlocked device boots with
+verification errors tolerated (``orange``) and rollback protection off.
+Changing the state resets all rollback indexes in the TA.
+
+From the U-Boot shell::
+
+   => avb init 0
+   => avb lock
+   => avb unlock
+   => avb is_unlocked
+
+Over fastboot, with ``CONFIG_FASTBOOT_CMD_FLASHING``, using the standard
+Android commands::
+
+   $ fastboot flashing get_unlock_ability    # OKAY 1
+   $ fastboot flashing unlock                # erases userdata and metadata first
+   $ fastboot flashing lock                  # likewise
+   $ fastboot getvar unlocked                # yes / no
+
+As AVB requires, both transitions erase userdata (and metadata) before the
+state changes and are refused if userdata cannot be erased. On slow
+(emulated) storage the erase can take minutes; a TCP client may time out
+meanwhile, the device still completes the operation.
+
+While the device is locked, ``flash``, ``erase``, ``boot``, ``oem format``,
+``oem partconf``, ``oem bootbus``, ``oem run``, ``UCmd`` and ``ACmd`` are
+refused; ``flashing unlock`` is the only way to change its partitions.
+``get_unlock_ability`` reports Android's "OEM unlocking" developer setting
+the way PersistentDataBlockService stores it in the frp partition of the
+fastboot flash device: the SHA-256 digest in its first 32 bytes must match
+the rest of the partition and its last byte must be non-zero. ``flashing
+unlock`` is refused otherwise, so a device without an frp partition (or a
+flash back end without a partition table) can only be unlocked from the
+U-Boot shell with ``avb unlock``. Locking or unlocking a device that is
+already in that state is refused without erasing anything.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 
@@ -105,6 +171,13 @@ different testing purposes::
         <partname> by <offset> using data from <addr>
     avb read_pvalue <name> <bytes> - read a persistent value <name>
     avb write_pvalue <name> <value> - write a persistent value <name>
+    avb read_pvalue_hex <name> <bytes> - read a persistent value <name>
+        and print it as hex
+    avb write_pvalue_hex <name> <hex> - write the bytes given as a hex
+        string to persistent value <name>
+    avb lock - lock the device (verification errors stop the boot);
+        resets all rollback indexes
+    avb unlock - unlock the device; resets all rollback indexes
     avb verify [slot_suffix] - run verification process using hash data
         from vbmeta structure
         [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
@@ -146,6 +219,12 @@ OP-TEE::
    CONFIG_OPTEE_TA_AVB=y
    CONFIG_SUPPORT_EMMC_RPMB=y
 
+and, to take the root key digest from the TEE and to lock/unlock over
+fastboot::
+
+   CONFIG_AVB_ROOT_KEY_TEE=y
+   CONFIG_FASTBOOT_CMD_FLASHING=y
+
 Then add ``avb verify`` invocation to your android boot sequence of commands,
 e.g.::
 

-- 
2.53.0

