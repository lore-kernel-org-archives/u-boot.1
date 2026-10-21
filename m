Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BF606A33A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zmbSq94I;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IX7bGpLQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TkGrxu2/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07457811DA;
	Wed, 21 Oct 2026 16:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BL9TyPCqWdHz; Wed, 21 Oct 2026 16:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25B5B8117D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599538;
	b=D3fs3naiJRgmhjkqb6ZaMlnK8yekhQb3y3rlIYYp7jAcqnWjMzHvZ/elQ25fTNxZKDzi
	 1uZvy9JkQeJGTQ2lxPkQA6Z5oIGe/m5J6t+TRAzoqE1cMcce7iMoltWPdjZXDCCvn2a0f
	 3vbj0BKQF9N41p8a2azcXWMp1KQWdZrXv2nfJn5SKonZi6+DGDKx/Aba3GadcrbcnOTmE
	 y+CegAhuVlwmKzxmUSJsLeVQD5cd51MUp/aQ8/tJLsLYJSKLkRIkq70ouLpKsyU7D9QCj
	 fAONrDnFBWJo4FbFnunNyGI+xY9tdnycKYecTV1q+IQvwPYBrcb2fbrpX3RpWnur+gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599538;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=;
	b=TQGHg8NvHNhNrrODuHjwpMJQ1hq0boLjcb9crdnaQpu3tylg+PZXVCo2BOIFvP3f5BEV
	 jdyeYXp/1wQsNlupWJDNDsC7NvHG5fpnVpjtjmwbwaWVZ704auLhqwvn0IAcHRcy1ZTTE
	 1HS0STd++i8KTrtgLMBD0ul4R5LVDZS7TlfDAcjXOG4CReLVGGStLtz+fVlfsmlqPrUoN
	 gkic91F7+wqyml+FGMgl3wgdplEQ/P/h+Frrnma1LPuEuX/ZzPkwyLEgw3wE3TMeTeyu2
	 oJSfOXZB7up1Q8v1keBXApiejl7HJ47A2EhCqSI6sWQOamQ2YQIJ+ae+TNxCGo/1sHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599538;
	bh=ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zmbSq94IUY4dE46gX2OW5u2cDWS6QZJyn7tG2BtBJ0njy1WHW4TF6O6DD4owWMm79
	 4NPKrQqdbSSzCAIeDe83meXlFaX0cgyh0C8TRdFKLRm9pu+7T2Nq+kzWN3V2+SyQpi
	 4dnukC/KTUDd+I/ggXGOj0t1wT5tOiIjYQlYaJ5M0ZcWGZTYu+GnGDFTusRdV5U6XI
	 RifJtnGJRdy3lTFH7Xchon5aGxGJ7ppNjEsrlZc7AClG6EciWXioyDY/XeIZU29nyr
	 kTzCWIQa73khrfGMnfahpUDBKsfa6SySg3+ANInG0OfqWX+Pb9o1yX5Lydp+jjJFVh
	 vaIAp4b7Nn0pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25B5B8117D;
	Wed, 21 Oct 2026 16:18:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E036C95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6A82407F0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ii5eGkA3Mer8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19000407A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599536;
 b=k1ynvvxa0Qau9bAXJ5f0eoz83rYl84PbB3c/3BcUaJTY8eZ6N/s5gNdqnRhnICk0kgFB
 4Rm6XOxnDlC6pNEz8JMA2UWzJjQdCihbQoxI5YPEI0eIya8MNSBt/nZSm1IDWpqAmuZTO
 axbXGCR7TgqVRbuFfhfhhoHkfEWYnzLo7ecHpDad1gvuet2z20yLmJG93zLTduMU1lEdO
 zKwebxM7qephYhQ6Lu0LHjUcqdiUIHudNjidEGRvDbzA3SdmI5iILzcInf7JG9+Ayxlpu
 LH2Ssf4WrFyHmAnpBYBklJhtGBmWVSFeWrZDVguGBx4o5Y0/WKTjDgjGDyifm/58zKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599536;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=;
 b=LkigzZ1ZC2ssFy5kVQlH1T6XDC0aTyAR1OmF4ajH7ztNDylLedJBmFpfzl/HzcVjVLa5
 IY1hKjr/r7SO7WXKogGPc+6j6Ofszn4qrtRx8l6020gROSdjtnP9Ooq36GCDdziv0P8tm
 kYMIqJwnHfGAiWwpkjBRoak/i63GTratL/wAeOVZXGUETDT297YQ5cVpiKTwtAXUD/JHN
 HG17CIbHHAym7ZFxW/c85FNxaYTEwAvRnRmS+2hyuqKTUMaIDO68uMHifPTv1thnUAwOL
 /T6mxTpPnk0MiLlP9QhtRz63J8rYbbUwaT+Z8jhLUD+h8wibLK/bPxKJS3w45YBAmlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IX7bGpLQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="TkGrxu2/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IX7bGpLQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TkGrxu2/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19000407A3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG4EY12149352
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=; b=IX7bGpLQf0xZzVGg
 0zbFxwtV9ywF/RA8mDcBjtAKkABDJY6BC6dmzMClcyjrXFxDX1ggpMOvBFbjlxDg
 hSwCEGv+cSdeV7qnKLnzEEyuZNPmzsk1Gpj66XPEC6fJoTLohmCB5eAf2c/zH7SQ
 kiAAoiiAJZfEFDozbUpIe4TbqGtqvSPKDOc88/goszyCJeNZlQMGB5nE2SBZ0Mel
 EAyVY24JXL7Vtw8C2x/+HtsoaDujJ/LDijtNlbxtdEW1fGOiT90dr8+Fx4GNlAEM
 cm+mzBJT3ZbbXGXdiYyKbrF/ERQvziYWSHkMRAft35f+jau0voF2O95l5NIh8bg9
 fH+O1A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke02b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1472854eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599534; x=1793204334;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=;
 b=TkGrxu2/n/5K7VPd0QfgB3YzV33tCtsk9265NQKk69E2ZPjQljdoGh2bn808He0CLz
 VzjPaJFP8M466WWrqXb68DmpJ/NrW5nOQDCrBMmM9KvejuYjZBRHxVmSIT1mOqkxDcd8
 eXDSToAnP0Z7gqQ/K4O3IksKRDKO/ufU0w8wZC0pyz7KCfdk5IdhratKyGH1Zc1j6gZI
 Ywn5wL9BECMiR32Fxy6fj+zAyLvm8Z9TmrZ4eckHdEgbXwfZh+LMDcUXbir4j/XMUVAl
 aHDlnxK3cSeb3qb0OdeSl+h/uRxxkqTo8CuTEBecpmFchqncphGemtBwMJscO/4wNVCz
 qYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599534; x=1793204334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRutayqFAS5JcizMMX7Qc0aqnNc+xwD+zfbd/RO11LA=;
 b=Ph6rS4vGHwUY9N+gZwyhnOPNAtGIdviqsnLFkvb8wa5QUiYmwtN0hmKtTBxnPlvzS4
 5dc5DX7GEzQNs/FI30EVJVzFO0pyuMI0IJoLCyBHtSQvFcAVQee8XqQyuFwRbhOQyNLn
 oDDrMVt+PHwlV922325sgYCNpHCV3JpQXa/ncqMfybMUQOI3AZiLV1gTNn9XUTW87RQl
 DIwHqsTj8jEMdc3ykjzbxr5a1H6/4l4yTdjzHXDid2vM9sP/llR/9jn2Xm/q9aDFJHkm
 IgYMJdj/C0Tgy0nOy5aKgigkbqUl5HndpplkrqnYaNERT/FTBnOZFtAzOWoN0nkIg0Cc
 PTTg==
X-Gm-Message-State: AFq9FYLSGWMp9EBtg2m1UudsWPrPy3ima5Efi0sF1/NmK69OnskLAAhz
 jJb+6cRaC4lK9MaszobqGnypc9fyL0Ly59yO/1pOVB2RD7/MTWSGmuRcwbzXEYgoZ4PdF9cyHnl
 dE0sgavNAGuItC0ynneEEbRy+dHOABwdGndHdUQbSvJnQWRD23maBaZ6qOoTaTTywi/4tM8I=
X-Gm-Gg: AYBFou2sZJ0Yoy2EbtGFFrNlD1k9TXvpTCvA9eEGgdfl1lQOTCbRXoBAD6q567EHitZ
 qEMGYcF21GutvvKvfF1LbSVers+yKzxNxG9oZl28oqy3vXIzGtQ77VVqVQD24ipGIoCHb7OebiF
 /SlBQg11UEBFwseB63rHsSc6MUVLCfsunrVZmu7RoYp6N0hzoIJ1TvY5nIK8pVuXbTSWGdi2/Pm
 6oHyBOOcS/vFqWuWCWFqdUae4Zka5QzXhI7AtnTBolv9OA5l82/+3hoS3wHSkSpMZX5ldtmBGfF
 lQLs3GYirUrzrbX0NA79MrXLoeb6OHUcXgfJeUOhXScWvnuihwlhVUuJBxssieo8RHI+g0x8aGa
 7u8D34vMpVZIom6fQJmObUeeMwCSFBZcHj4PRKX7qUN2M9Ek5ZNOVqpta4zIz9NgPDbyLaOPzje
 Slra/SsvGmDCdl7qaUs9F5eIx+up0=
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr3537129eec.37.1792599534308; 
 Wed, 21 Oct 2026 09:18:54 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr3537046eec.37.1792599532876; 
 Wed, 21 Oct 2026 09:18:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:23 +0530
Subject: [PATCH v9 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-4-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=2081;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=StpiWQMhUjZGVZkV7xE8gkW5MnMtAm0LjEXeBlRaSZ0=;
 b=xNkynQR0frB+Ne5VrjIXCmKRozJhJabKDfJMS/GImY0ZJPv7gR99c7GUws454mCAwfeekNO6D
 BSeuTHkFF5vAe3Pogz5Zzs6AheemEkxKaNH9fTtR1oLPQzxOhGp4X41
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: A0-UR6BguLJBaEB0ySDB8OvSLRBM1mYq
X-Proofpoint-ORIG-GUID: A0-UR6BguLJBaEB0ySDB8OvSLRBM1mYq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX2rVYUamoMCFN
 ljlf6iz1US9cwLiGL48eu6mncuGB/oGpBmrXrfqe4kcjxlekqXgbNPSX9CXbVFDWG6WWPaJYHTw
 yqZbl3HG9uqqo7NnkyYXsBnDM2ExCMY=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad8e5ef cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ISFvD8blF_amzRDVKuIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX1SgC5OXgFFKR
 FXBvKq00Yams5Py5SXcjMDDh2S/AgS+tZ82cNJCINpsXjyap2fDoxSR4ywjy8PDcA/ok/H/5Y3/
 HBg5d1Yr3r3rGnyNKPJp41MYt+x4Hpg2qAGjSuhvxEHkU9z+xnFVJKKIrZ5/CHOdk6IjjasUVkK
 eVC9kNLFH2iC3BlR7RT/ESBF/OuP3MMQ1kXpYrTKPVH2W8VRk7EMk0gOw0dbyGX4xAuhYGE25E7
 tq8oT0CeQrgi9BarD1gWG57EaC4E1sXPwnFzdSms96vW0haYNtxyFUaTmhFZVzUCVQvnBE+4GgQ
 q+AZUrYeZxvx+J/mr6+uQt94P0UdNMLBMTr6UFmDgoRdE32J5UrOM3u8fWf7gS3g3xr1bnxNGCE
 Q+7jhdMEN9bjZYOzUHSesoUDoVtd983Y9IjQA2r3CzSrjQWsaib0Df6r13vSwGUT+JuG4NFz/Ed
 jz1c1zJI+LFWh+8mnaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.
Express the platform-specific requirements and configs that must be
selected and disabled in snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v9:
- Remove depends on !IOMMU from QCOM_SNAGBOOT_MODE

Changes in v7:
- No changes

Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..db770ad6edc 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -82,4 +82,23 @@ config BOOT0_SDM845_WORKAROUND
 
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	select ENV_IS_NOWHERE
+	depends on !ENV_IS_IN_SCSI
+	depends on !PSCI_RESET
+	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
+	depends on COUNTER_FREQUENCY != 0
+	depends on TEXT_BASE != 0
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

