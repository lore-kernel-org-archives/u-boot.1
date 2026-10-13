Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139E0CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C708880DE4;
	Tue, 13 Oct 2026 11:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8cM4F5ll9KW; Tue, 13 Oct 2026 11:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82CCA80DAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889595;
	b=Ij+k5p+G4LMWJIloVJHzlDqcEtQon1/Qit0jbv2abTh1M8cFs8U9mfp0C5BK1jFto9BB
	 hQJBVozlTOLHZBEvaF2RtdmJQ1Vk2Zbx67EA79QgMVFfQKjvZMHDBUju/vSfSbN1EeBMT
	 iv4QJqVnHD25KTAuML2G2W2dLlRSinsZ2hC+HgsQo3yWBKMBMsib+LsWkTiTNoKG6QLRR
	 yUfBX9Vc02ajGyfTLveDGG3yGx2QguCmKSMoeQxbrk6Jcb8IPTtoEm6Uu2Zu723aBary8
	 jc5QqRRc9b1Bg1XypLuDjJSH30uFMrxi8rSAfnLKJkQis3tVmyJi0kfnv0vPRhpthXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gY67iFVv/W1JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=;
	b=ldZJ7AIasrc+IZ0zY73BxvvikdIppqgsy+TVux3+oZbuXEpPWX19zZ/jvDoHK5m5yhHM
	 aSzMAwoe9PLM+jCTxES46ki4x7dnUX6EkTQauyctSVkf4ox/nuCgBrQz6W+kRvu1/eA5E
	 zU1FyFpt0SdPTk8ibQmctuyFlM/z0zE9HyXl6amWrOOXwkgBeb3dWW+uf8wbd1K2WneQ4
	 NH8RTfeyTRRzhIgEQz0FB72D1E9kFA963o5PYtUrYNViM0nSPtbuihay1BmNkG332lbmL
	 vBvwWXPhYr3TNoGb49eqllrz9QjZ69qiQi+gn+U3MZWNIS/iP9+f8Jau21DzLWlHJKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889595;
	bh=gY67iFVv/W1JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=THQAL16wW0yGIUN7eRcsx2X1CFVTYbvNT51cdI6QxQFhcu9C4PGKSIWSAOmZWdeHs
	 FDEnrnqQi6ATod3S7N0CkSdHv093vki8t/0RHSDonIzCC7ldKqS+5juU0rTYncEj2t
	 e5dM+lfGlhUHWFbZZmfLwrL1MO/SHKC/Y6MZZMjuPxv9T7sdA39Xg/L+dSu9L6Gim2
	 RDDIdVpnNmhUASTclgd9NAleaJC7l/WQR5NGeGpSO036TsqHmFDq07GbiddcqFLK/d
	 2ImPw5TjJ+25qGmqZDvanXB0ivd9cU54Lnn4qu0TtX4VyAiAzYl3rmnP1MasbusmIl
	 tt1zUE33e7WQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82CCA80DAB;
	Tue, 13 Oct 2026 11:06:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0259A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B07674055A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vO7q3SuN4gxn for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FA25404F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791889591;
 b=drk6+z+PVmo11EW4l1pHPls9iRGwaY/Ko0IsGjW/M0CN5WV6rueOIdnvpBhVZutAn/bm
 ToNLTusZI5UEHeDugdFLtvu8zaS3JStvIGONiGvJ+WYJEI3LiM4yXZTUABnMEuziTGh+e
 aQFwNXWX1oY3MAXaAvx3kaT/ccg/3spgz6pH+02hLrwbiEqZk5Y95cFqD5IWTqGMYH/Ye
 s10OX6sWw01ZqsvNQ4mlFyYZqZg2NQmRT9mQp5M84P8XePAawR9bT06rZBB9g1ePa1pu3
 bkrpeysbiVNLQqNFQ5GtEnsGJLhZ5bc+V+SIBarcU1z24kdD1neuTDicv0Vy5QVjw2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889591;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=gY67iFVv/W1JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=;
 b=bYxCs0h59fIhY4+OTHAGDJi9oimV3DFVskxzP6z2FMf3TGRSCEUIQm5/G+HqVHKT9+A1
 Um6EKuHS7FwF8dtWYbU4GZSPvrVvUiaEu0CtEigOPVKte5ZN8wgnr+yO6HeaK5jBKuJ5s
 gh/tXL4W2PFqUl7NZmWdSf9cMtL4KWCP5KvUHAyDuFY4abNABjdy/tmaTZM5/OWFZg4EJ
 zmrF+dHvAd2IZ/hK221Df4L1WOC+v5WJdIw9NG5QG6lSgL19Ups+gTtV55xQG4BZqNCh+
 ZGqO1vU06IKsijuzzBpQPPbF9gJ9MtemCFyb9x3aYigE5BUgmXTG5NIMqczCa0jM5iA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cV2np1A+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C5PeuhTM; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cV2np1A+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C5PeuhTM
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FA25404F5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:30 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8cEdF922849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gY67iFVv/W1
 JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=; b=cV2np1A+ZiayM/GyInkkiogEMBn
 17QVIrOq3rNvlXQteRuiTknFYeN8DNh4k6YqIHZR2TQ8FzN6QRKt3PBfRSWJDRTY
 2JyRLBnB7ymi9SZ5N2lJ3+Md/c1yOzndSgVPnPeFVPzq4/Wr5kh7euqakz7hst9c
 dL4lm0hoHmZTJRHSYhqeHMAZY3zi2n9hIFulmO5YSn+Xa4yhnbNpHvlk+3po9+/Y
 oJySKU/pjBEEwjK6rVF5Wrwp8ziNOtlLMgjFWsBZ7woXD0UvE8L+d/9msOHruu79
 YWGVPXdtI8Jy3EuoasRqgsBrvkP/Y0q6KwfGlUdco4DqTtnjmYKtZpWL3Yg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tkpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:29 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so3010250c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889589; x=1792494389;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gY67iFVv/W1JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=;
 b=C5PeuhTM7Ngi5TWzifx/SLPLFRVMtjSe2SemG/06qVCjzlyJsQXD8NnJebP84HBPd3
 O3e3wUnNxoLBgC1LFB2fYq87KmfDPhrCFmdph2AnZLd9W1k9VNuLrBRi1PhUk5AlGhGu
 /H34aeim4n1lzEsaIeWnKhMh2CsyDXLwZlFx++6Sm724YU9K/+3MfAhHgMsbSHFIwQ3W
 sHpecSO9RjL9H0h9nmgspmq0STlAQKZgXLj8tMUF+1EdGmOkUDz1vmhTZ3XEGoxb4IPR
 6KHb2IXPV/mNv98kqpOifkTCFfubzVw6XCrKdcS1oEyf8QT+rCP2qUiK3E/bqpr1BRX+
 G6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889589; x=1792494389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gY67iFVv/W1JMZfaisQf/msCzUX1T8gTwMvW/8EpOx4=;
 b=06OhblGJ7Syth6GIfb1HlSWyksIyhhggrkY/7gEczkGzE+3g4zu22LCgMGpgRkGRuc
 k896xuHPJI0giLGbsxN4cT/6z1fek8TBiLjgfB8SjVr2pEZFWlg7Evk6p/kD+Ue9vNFX
 YKEaxcpIvsPN1lrOFvo4RqTKS4TaRfJgm8yhX41B+KwxU+P17ooSlEsm/31fYwW64j/t
 Jkmbwg+9WAVIRn7XJAgm6q3jPtMzLOj9+qm7hA0Hz4G5WupU5fSMnkfZLCf0PFXGGEZ4
 oNt5g+FcE5wVWm/LsRE00OcyTWBeRtwErRkGfKlrpomzG4NHaNmgQXTO7AmNwMLWg+si
 t6tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4lybfqwgsSjzEhhjpL3LRw1LYMFerPvfbttIlHARRP+ONdQidRzZ2h2eOUGuv3Dpc1W9eo1k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLSMOhn28/OF34IzA4tOA9QuV4N5m6B7GFIC6UyYhkDMv5BDhjB
 R5LXtFxkCHYDcdfU5kWCOwflU2x+cLC60HPs27I8w9WUN0L+m0Al309CJw5z4XEW/WN0MC/Kr8o
 fOAfw1SukwWTxlOQuHgOeC110CAwUkottn+DyPbAkEhWlkFshzyh37EKPt13tkGv31lGTSa0=
X-Gm-Gg: AYBFou0/8lkTkt7jTYfurxFOalpPa49cHgA8M196Ppj0+O+dB2CjpgMj43139u4jueO
 SdyAOTBQPh1P6ZlPL7Etq7sl+zoAHRyvsb78q9i6gGYjr1Il06zrOtH1AmLBPJMsiFaFRdqIhfZ
 YD3uZsBIekhLyBbTiDTLPf77sIujk6hcODbtEKzOElDrSw3asKKUTfVpAsRvQM/SVmMkH9C5cGJ
 04XnTtFunciRVEiYtKDBwA+HFzax3DjBzXoWa7D0gmWEeqdbT3SG3eyXxizMXPvggeXwZ2VuO8j
 uy2g/UGCIs6Lf7tB1+IsyF95drRpSbtrY3K+YZ6cwvBUovLyv03Eire+lt7H7izi9FM9vg8DfST
 j59WuC9EhWqYMOZt51sPBIxxFOyCtG7SossmaTgbLqA9A72nKnOXkwlezfSZu4nVVi6gFPbCigz
 daoK7qJdX3Yc+1RA1zsw==
X-Received: by 2002:a05:701b:231b:b0:165:55e2:2d69 with SMTP id
 a92af1059eb24-16a640fcc35mr18765815c88.46.1791889589026; 
 Tue, 13 Oct 2026 04:06:29 -0700 (PDT)
X-Received: by 2002:a05:701b:231b:b0:165:55e2:2d69 with SMTP id
 a92af1059eb24-16a640fcc35mr18765766c88.46.1791889588354; 
 Tue, 13 Oct 2026 04:06:28 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm37460642c88.3.2026.10.13.04.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:06:27 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v5 3/3] configs: qcom_qcs9100: Enable Gunyah exit support
Date: Tue, 13 Oct 2026 16:35:25 +0530
Message-Id: <20261013110525.2465737-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace10b5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=u-SOsaVsrQWS628QcVcA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: fsFBo6KPoodTSO66I6C1AOvB0CsF_gBA
X-Proofpoint-ORIG-GUID: fsFBo6KPoodTSO66I6C1AOvB0CsF_gBA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX8JD5MBx/8B42
 5C6vGX557FEhvvVILFj3g+EbQZHYhO9R2+eqVbjZGLr33clJfSxks+65s4/Asn1srvzzxVhvTKN
 GAipteCZ02cxQjLfGJxNDzYEShMN3as=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfXwVujJPA+nPcR
 wXGj2H++twytgEPyHE+yttikjos6N2XYYOyAPhKXDHdaVTdaplD7JLxrkhlYldtjQQrNIysUEPa
 qMmW4q+RmcAzXlg9ceaS99GfEkBSJiRjnZtyUZLbPZ8SnUwPY/7ziWh6orPM7GO9TW0swvU29X4
 CR7v0zm4aKQcg/Iu6rJ4Q2GJiiHsN6eBFr+RTzxqAHLPQqla3KzoY6ZypiiFrLGFs8JjQ/Jq2rs
 WSZboHXQX0Dln1G9kOTuqBzSjNwmqOMrwCMlaZ5o7zFsPX3P+pNC2tZbUby4dsfW5Edw4fz5Ffv
 d0dHwhi3FRqe5EUQ/Oc43PsHcqKNc/3GIvvuSUx+3djfDKW5D8PsWJqsoJosMA5Nrx6AIJYPIEZ
 Y2l6b32Qo6ItInzFCForiBBzTyJ6H9yrkfh5StLAe7ltHoST4KRe0gXVRHjhrKhXd/6rMOY3J9e
 +tEdem+emApdB9wfSxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130044
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Include exit-gunyah.config fragment to enable early hypervisor exit
on QCS9100 platform, allowing U-Boot to run at EL2.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_qcs9100_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 1cc04cb96bd..342f128726d 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -4,6 +4,7 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
+#include "board/qualcomm/exit-gunyah.config"
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-- 
2.34.1

