Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB653606D826
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q+eITmM5;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HB27y/Fg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZSkSuklx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A16654084A;
	Wed,  4 Nov 2026 16:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpEj9pMdiDyp; Wed,  4 Nov 2026 16:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7959B4083E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810246;
	b=Dmc51Yh0VU3t9kdaPqc6DKEDbFz6qXm3dN/96m6XuVOn+yrVsUAb7wd9VFK4i83bO6Mq
	 pGEFEswrjsKlQp9Zn6/eurBfiO3D2Wk/wkii1HYA2Bkcjk28finuhPOdCzoo6WdRVsVQU
	 PsidwMMNru4pRHNIVnU+DP8RmV3YlWG/ti6D/B53Q1hWiVUCovgr9K/jMAbvkFfmsSVrP
	 NsaFDPI9s+9vaxVpXtHB/car6c/CcaXq5uC+nUi/gwlBO71+fba1mb9kbEClmZ6yw4Ir1
	 UcYZVNX1py8zsVfTlHwPJXeD+eSbPyfmMn4TNhmacsyJEh+b+mm49CHlb9vRxv+5u9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hqEhm7lr/5ira4xosJOUvSgK5QgEsN+yiefOfhM6l7s=;
	b=UdxhUmiZribUJMJPjK2j+39lL0f6GMTMWzib+/dKdzBrTwLXba7EmNNUcRJyHa0TJink
	 al3R7x/WCTupHEBGSpbzWcXDrCjsYWLJaHvLtpBSSjkPKAgPL4LahBrSozIDAYglBaY8T
	 YyVWfLySsPaGu/C4ZbWdNqhKhQ9Av38A/N49L4HEsQQ6HLJ8pafzzecE3crHaBLfYElyQ
	 Vhaltd18P5NBzm+PR7iU/xEOIQc11KM46fN1hDc8Q1tm7JhevkkWDERD5yhupY0McHT5T
	 /c8n4qbDpWWe51mjrCjWX7u7oAxF/dpKKHe70AaJU2+YNMXjvFkBQsesdL9uYizI8CQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810246;
	bh=hqEhm7lr/5ira4xosJOUvSgK5QgEsN+yiefOfhM6l7s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+eITmM5AIrbiqY8TyW8U84ZY7e9kJmH4sAWfcuGP/fybdN+oXqeyi9MpYZ11A8fa
	 gkfnvgbDQS6Q56ddqrRC9ZVLxVUr+oL91Hd3BoQS2MRlgmdK3xuzEPNasAqHaMHXA/
	 GRJyXWpydqAIUPC0xX9u+PKYqN+SubSiiwsxJyb4EZEiyZRGS0RVvIjarC521pT2YF
	 /2Y5m0XTtLYjwPc/qwqgAsqtMSNc5/cM6d2L9lBU2pA/2NuGc+mFGFsElb/CSYMHn0
	 QxvLvlqy//mG+PrW7xV40yjtcjKpI28kEcYWVXIqw9zy+FQOhkK3XOlXBLi7+xZhbO
	 D1FGCZAb2rqkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7959B4083E;
	Wed,  4 Nov 2026 16:37:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A1D4341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B98A40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdh3DW9_I3Dj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 97CC440062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808274;
 b=mc6fxPoD/qqOexJpKdaXKMtG1t3vl74bqT1x7nsIp5bW6+Jrk6F5kTWBh4HPYp0FTzaD
 lTvI0fWD10G9ZXY+ufmdHEmmE/1mxwA375n+g1Bb6IcYk9fWGIa5BwedS/LYuQ2P+X2RO
 b7ZSeL4ZeA6c8HDp+LrGQUoctxzEtGfOKmVrKzPo6FF5LpLX9i7QhaDOUO9Yl2vWD/9u9
 X6b2pNA9jYhK1uTT0u6jXhMbmAWXNSRynh1hlp1Eay87lJy/AwfviwGYbltZQawjN+Ntn
 AZr5ldLvAvPiNdTgPs0CSRLMxE7cu8pCWQ/vdYXwiNyv9izovOQHQKdvSkdkSpw+7tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808274;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=hqEhm7lr/5ira4xosJOUvSgK5QgEsN+yiefOfhM6l7s=;
 b=jdhK/WqN8HuV6tBdurDKb9OpuHKi/19+xVa7rdsa0/6DAswSyYjNiM7LI3lk33tJDtYt
 /gAoWTNMGaLt3oQ6Db1UnR1HmH47VvqJupbVUxJQjXOYo0MKbONhVzsa2PEEJr7uM55vS
 igSVtsjL1llubugVo9g4J5cwkwxd7a0vauZsZgMDBOigVjCAGzg3HYC2RN/wXsJ+jd82e
 5Fw3Mm6t3FcTGKnllrBvPI5j9yXODJsao+ChkO7uUDMJ+hOXffRoAd8GHZsZhXpXLLC3Q
 nQAZOqX+bzVjIoKSaUf+gaBBpLltgcaj832TCxtzP7ALEUI2P8mZFWk/Go+ExdDKpRA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="HB27y/Fg"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZSkSuklx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HB27y/Fg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZSkSuklx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97CC440062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjEQE2828894
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hqEhm7lr/5i
 ra4xosJOUvSgK5QgEsN+yiefOfhM6l7s=; b=HB27y/FgBStkqeJSs+JnstaWr/W
 GmukED9PMC7nkQ7dRfS7pSYOC0Vydae5joovFfcSjcdyuDGouHFWhshJiY6rF1Y5
 mlj21ezAzRAlyUQB68ysYWWKaCDKAvIEi9z5PeRdvMI/BU45KZHD9vsQEgPv3pLb
 7LKaEwBtcE5Nl7LxVPWo1bjXInvuRW7LDzLYocvU/P7SpRBrj6VZThydAP7AXvYL
 4m/QoKp9QGle04NrR/UFS+l38+ByU0M4c6JJLM4rQqCajMtor3KKmN69pAFj5XW2
 DaP7+8aKh0JOqWkKOTfaAbMMrlqWbwt9vdw66fw357CuwgPTVrqR18TiM8g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284sgku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:31 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1059985c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808270; x=1794413070;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hqEhm7lr/5ira4xosJOUvSgK5QgEsN+yiefOfhM6l7s=;
 b=ZSkSuklxMulYeXPseo5B/qOklkUWHidNWL2gelPuzAB+XRDjIDmi3cZvncL8K2C0wD
 V8lz8M8Nx1AA/U8BiaVxk5qYOldpiAldxzZOO8X4hPS9ZAve7CjvWmkq1VxC1nWL1i9E
 fve6a7g3WvhBdh1N/Kb5QB98yO3oiod1ewcHz1ViD0EnB5kTWlW95mZUnl9m/pJNT4cI
 6YkcHy9uRQGPHHID0bIQWR78AlEDddo9GtPMxlb9CRYhX4uPgTp3ncFiT2auiMjz3oOx
 WzBlaZLUKGioicLl1J1h8DJ/xMux+4oEa8avpO1P3dnSWr8VIXZdzJXbFQlQr/L7ggIR
 0TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808270; x=1794413070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hqEhm7lr/5ira4xosJOUvSgK5QgEsN+yiefOfhM6l7s=;
 b=KPCNO4c9VuiOxfBdPatbXrrOgxUvtoaneMAX53sIzipZxW4s+fVlGtR9DfXFXJMrqz
 EQK9NbNbnUXe2IfksjYPYWXjjk8WnX/T/YA8KXjr89omyrN62lopxLE9dyLQkQOa8Tjn
 K1ycfDxs9eC+i5sX1FqbzEiJXbM8OGt1WNC0MOvH3IpUBEoo8rBZoV8FOMyqQD0pKJA4
 OS9bDX9Qrr1sEbHM0kcq/weULZQ6o8a6aNzUpDXFSzFqmXbgJyThegNG0Fovi1JMBtFm
 6cSCeQ3NLZMVamaRJ0m9+BINo65LO7S7rajyuNGcvVwe6yfzvbDhcNU5Oj0VpcGiX3EV
 uiSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6Ymcpk0E/g4JjSo9qtk94TTyct3+47iMznOREa2j45K/rtXaoxC9qr4hvuxHmXOBsmMSmwBY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8kjBJbs9n2FawPKP+klUtmDzcCc6Of3D6N4gNf7np5fxIb/fVP
 GcQ90VErkyPhWr2Qz11/lAlCZsqgKvJ1P6gn6imSN7qor96GoTcIaSlXqBvBIPzAGVNLN8kGHbW
 XJQsPsxBS3KEbnMkkxQs3GzxCX1YDxFucUNZIbUUYBb8tO/20kdDXR4GASHDQEVpLFjKr++s=
X-Gm-Gg: AYBFou25ZeukwrC5CXoLLBfn1WROKVDh+ggx218C3VmUyeMIMgXIclLVbHkJ0/0Mck1
 GmEzP89iTa/JbjgD/m+rGCwItbAuy68aebZhQR6q/rEnlAHDc556pw7o1UYxXCEi9/ZaFsnc9SD
 rFsTzDy2YmFbj/zYsGClBljmIYouJF5JyqdOxbRJrKtUrl9pmEgTA4uOCZuYPYpLopWxlpJV90c
 nfS8dhW+z3r2ZyXMNfN9H61I607UVx/pErMkPyP+OBUG+YVb/iYneu9tmmkSUzta7XQOovAXljU
 gRtUsR8HP0tnvyVIdFa7FC4FC15LJrnkw3XcME01jl1VIm8EWbKTP9frlwaCuUqlv/6//dtonXR
 yB2gHVYsyKDRu2F4KreNP48uXoHSffHPmYwww2pve6PNiFq/wUCGh/VhdXnr/y4+htBKPxiOf1D
 UyqCvfBURFYbWgHJYwKkfHi1bMAi0Woiu9Qqk9yVBj27Xb0zUIlEK2T1yLpd9EnG8HTg==
X-Received: by 2002:a05:7022:3f0b:b0:1b1:f02b:232c with SMTP id
 a92af1059eb24-1b1f03a6a35mr15281012c88.29.1793808270293; 
 Wed, 04 Nov 2026 08:04:30 -0800 (PST)
X-Received: by 2002:a05:7022:3f0b:b0:1b1:f02b:232c with SMTP id
 a92af1059eb24-1b1f03a6a35mr15280955c88.29.1793808269666; 
 Wed, 04 Nov 2026 08:04:29 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:29 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 3/6] common: spl: add FIT and BL31 progress messages
Date: Wed,  4 Nov 2026 21:33:55 +0530
Message-ID: <20261104160358.1131694-4-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb578f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9F7IiCi6-aocI7L2ojYA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 1uyfBFaUG2a199m7NmkJqcMCm2lBVIyA
X-Proofpoint-GUID: 1uyfBFaUG2a199m7NmkJqcMCm2lBVIyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX3E81vNWnF+xS
 BFM3GvYSu+Vxl6c4KihDT2g/wPEZSrMaZRAMdjMuJew29aBh9H8XCyFMOyjnaPOJYN1HESV5mFB
 RNxcTqYf5nJQU+E2gNHpLNrGoMNpnnZD/QwZCTCA6TL5InqPoZBvhPiL/K9CLkpAUbc3Dt/sHA8
 o0pDtnmtehC41lg+3b7Xoqy5rInBA/0hE7liPpv9PCpUHF7qsGMoQ4D0KkWCEZNNbQkiT8sEs8S
 B0ykZm8+4a/hahZ5r2BUC4n3lIQrX0s8bldTsrSdBrqviIP7gh5VhH8Xjt9RPOqxZR0amigHqG2
 aW1dyAcCK5MC9uBADvXpkXJ2kLtYXa1vXfJF2rqUPm5nwMsFJnH2QspEA5wrYRYbH7umX4zC7ex
 qjaHjUPBPAarP3T2FKc4Hpwj+mIS81krDlvA1TAUZRmwBRMYWyGODCJIy9lmjO2e84VhgTDZbk8
 k/BO0sowEhOh4XoVBLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfXxJXRDC3GHpgt
 Ja1fUqyFNHVm+pn5c2x55C16g+/SafLfJ0J8yYHc/oKjoD/Ms5SjnMggDzpQ4khGJjX3UWYTim+
 sqfBcVvNeDsenJtNkmcjSO1Z4jlOGzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040063
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

Print the FIT image name as it is loaded and the BL31 entry
address before handoff. This provides visibility during SPL
bring-up on Qualcomm chainloaded platforms.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 common/spl/spl_atf.c | 1 +
 common/spl/spl_fit.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index cb0604ce034..0f7d7d2a4ab 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -206,6 +206,7 @@ static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
 	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		dcache_disable();
 
+	printf("Jumping to BL31 at 0x%lx\n", bl31_entry);
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
 
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..f12eae6f307 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -267,6 +267,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	int ret;
 
 	log_debug("starting\n");
+	printf("Loading image: %s\n", fit_get_name(fit, node, NULL));
 	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
 	    xpl_get_phase(info) != IH_PHASE_NONE) {
 		enum image_phase_t phase;
-- 
2.43.0

