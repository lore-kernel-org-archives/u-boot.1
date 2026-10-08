Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82F5CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98F65811F1;
	Thu,  8 Oct 2026 10:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeR8Izeoz23e; Thu,  8 Oct 2026 10:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D849D8107D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455605;
	b=ZijIyBZQSRMRn9xe0+EV+vduF/h8EGNMtER3odjHK9P3i7vl2LXzVlKSAa9Ro0eRq6uQ
	 GD0uth0ijLdGgXrDNcPw6O2T8PIycmxk4LRnlj2zuXduF+hN2AkSDpyR4hsQ3zI6pQJIr
	 dhwkX9y07ISlciFCBTn7Zl6YZrS4Iq/fTgci/WoGyjhUwSuNiz0/TtB8M2PYrDZy2B3dv
	 FtKy/Og4Ctp9XLX/UbtXa91AkS9StrMmGtzcWLr3X0kgblTMqN8IhUGWTutLVzVdYRBfg
	 AJl/UCboRkjliFLbMXkkTxfx4yUkebyJOg7vvtLnX2FyHzvLhfwXCVmrrl2XuEghhTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1EVx2gloFw=;
	b=O74YHqD/EWU/Z5PegZTKLoQTaFybU0scZ8wzUf26YkSWz9poalCnBYkqAh90dE0lE2lg
	 3OdKxfzoua0GVS9h0tgJgt6ncMdzSEUMz2iSH7K4owzamqrPZlon8mNVs+7m0sGGYJgun
	 gXZt1DXwmi4ihUyCo6OAGVCwKvP9PdEGP6bkIUTDhzAyVdireK8SXSaNiHpNoMklQ2tKG
	 irWxA87g9XzQso8CDmGxnYtUaFT9CW9FZA7YU9Rlthie8LcDr0dIw5cJFsg1kJ5+5DMAF
	 ZYdArM3NRZROXFvl8mM2QsQ/8i//6+vF5ZHMNBiROAQY2fcxIEWLggx0YNMM3dEpaEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455605;
	bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1EVx2gloFw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YWgZITZ1S86A1znq7L+jlv4IbI14P46sTwxygop1JdkL6RWSMNuY+GRSQ6pC4EXKk
	 QlvKTNVk9kiQkhEm85QUtiCdBr0SS77aA4j7Im95r/KHb9pITWaMqBcYtLYib4MXKS
	 sYU9ALREy8aA9CIF7ue4V4xoXePG9P4vwMa5Mr9RRe0j3fKRQRw19jvEpwEOc4Y8YD
	 nroDyfMRph4PKkTqcjYo5c0ZxHlJ7YxKKgTJxWsP76cD7uVY2qJUhJ60ZVNwoVKR/y
	 Xgrn6WtiynlsvT5HWzdzscGqbvbYQMhbnpg6yWNvqDDmSTPwMb6ESOz49hTgOKscpW
	 hZ/pu/xmEtH9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D849D8107D;
	Thu,  8 Oct 2026 10:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 706E12AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5211E40427
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0aOnpmeQiLtS for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A7A3340050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791455602;
 b=VJu0/gTUct+sMbxN5a61ttpGdQwBhbRepi1JZklBPPdFtQM+BX5RoMDT7Cig+SRIYpf7
 KZWVf3WEoyMn7cctmOliy4YELquj2gjePHR9VrRYdZchyKWWYw5AbnX+rETd1YDRTFvCS
 vIEA2jDzJioeMT21xShcy9WDWQaLNplXXpSE0ahkY5+elLn7eQGDKAJYuQhzqqboPLlw5
 3RcNn586i7PUOBjTtnLMa4RJXGJ5Xpdz/+vte41Azjj6ZQ42JNIyn+lx6Bx5pMuPZzqMJ
 dXt4sDpyjgYeBHzPUywi7hNG0NbHQ0KIgKkdF+iUEQrR02TCOnKiDWh0+Rzu8V51+PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455602;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1EVx2gloFw=;
 b=mxnPKchDD4XOTeix82xrRuL8Ag+6HTeNdFXR1TS+31F6ALLOw19sWxBHVcRdXIcZXB4V
 0Z9ZiKVIocF3CDNDWeoi+6GBnW8VR15dqO5jnHn5D+tN9K+KnuIqcaeDVXHWxUSrkg68z
 MzcwJIX+bpd6yzL+Xx4pxdtNqr08JQhNQdJ19JcYA5FlKnb9RYpiCurlHSse6q7Dql5hc
 Hd7U2Q7LAe+ayxNiqYJabY+XkhYrdD0rQJpDc+5MCE+MDcvTS4D7SlT5UKoSnTiXZ+if/
 gU/z3wbJ+EK05k5UmLAuc44ogUFIesiDEcubYBXHc3Y3Y1qpmsEIt5hKHFEU37HrfMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nmLaD0lp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PDcif+n3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nmLaD0lp; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PDcif+n3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7A3340050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KAmk1574584
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 10:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1E
 Vx2gloFw=; b=nmLaD0lpmdE4teiz9dWmWUHyuMkjZzWF3+3sgceIVsP724SEex1
 AEvRFZ+zh8Y3bZOr4sCOXpNn6YbmLYfxxKHTFxSrB6ODSEn7O8chu7Lc0j8oVYfo
 pwgvyP7sQrfdd7MrBovSJb8Ed++ep+pEELFAKALKVEEqdqic29+9MeYUHu/+WwTB
 PR/psLiSMy1hRimgHs1sGVnH885n4VSkuuWvZn7AlD5Pp3CWEcsTVr5lL9Aih611
 fvI/3k2MgycX74oqmsUw1KfwgUYSTTmal7gJbYjg0x8TBTtyC9+GCb/WWhJMkCDn
 6oNVb+VQjmkJsnj6UAXYd+aeZvAUkPpJ+tw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe52gk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 10:33:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so8869969eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791455601; x=1792060401;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1EVx2gloFw=;
 b=PDcif+n30TGO//1m9mpSdJdpkX6pt6++gEvim4LAKRAHzwxKP98droIQCZT2j2RYNS
 PjoUmGfkRWtntdl+aoAVSHEhcJIYSUhU61dq8fU2nU2vAxUhnTZ39qGsYiaTXybuG7uX
 7yp/FCLfezn/nxeQiQWhEANP7Mu3BRPz+dPkmiN5UmYL1D+cxhQ3awwH1KmKP1XWAGeD
 DO1nfVoJcFGEbc/pRV9fLjiixdahk8E3dX6e5zNs8BcCzDDztBOSYGPzy1o4q6zPV0PX
 UgixqOuEJIPoTSBhQ4JzNly4/eP2iffpjOUpv9yI/XGFme/2YoJ4siLT1uVrAkJImzow
 G+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455601; x=1792060401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cgz4hVesSFWPwm3cY25cnUP49nqXikR5N1EVx2gloFw=;
 b=Sc9Js8pTD7gMFQ81xRD9tKGknI9KAkVJu03TTZ8F33Eje1HGbClCGA/CGPmO8Aa2Yl
 ryH7/fQILjZO8aMwmUN/ei/eBU80tJi6T1cEQcwpHpWim/YpTLPA/+QcKOmUR99HnNb9
 VfanudnHvVzS/QSyjNP6jRAQyD2QLswOgkFSDevYeIfRjlcE6rZ0m7zFMSY7kPkRwJNL
 6knFjyTwXGYhaq9HXcUSkRMwZ2u5Cuf50HL/Vx+6BmvBtdwH6+8ja5tIxLWzZBnDjhdQ
 kR2z1xgjUUyi3x+OiH90/dwfjHs2EicXKAJsnYSZGxFPw2uRGlOGprciA8wp6aoKxOp0
 LaWw==
X-Forwarded-Encrypted: i=1;
 AKwUvByr2DvtufXWtT5AURhuhaf7260QxejWNBI2bNXh6zfbq8PsYoN8hQ2xKpdR83+fmebm9dymtCw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lvxaeSO/w/HMu7R4s1b6gxnEmTKi8qG5g5id1dNX5me+6/3TEt
 t2TRY0UhQ0gRZVfndDZKlAmv6Drq1SDEE3RoBOJ9p/cWnVdmBbd7aNwl4gSe0jbvkVQGSlri0sZ
 JMrgh+f1qCNzVXmKZ4WjOM46vaK9xpi0QNj4RuWwZqIEToiNg1QbubP/CGZTX1wbPC9F18EA=
X-Gm-Gg: AYBFou3tdo3wylmapqVzhb5IXYqVAp4nkDNTFmdUQ2rGpgVpOEFiBgr/N4rFzuJYhY1
 x0rMk/g0p8v6PWvJpJrVCY7znmp/g0LmzHFgaGik2h4DHXDuJmbUG+qWZgmdrFglV2a6T91i3H+
 9rET4McgWmVVweCx+IuaE0FmJRv88nAzwEQB2L3YsIznONXvYoqh+kW8TNihYYb2emPg0dNWWMZ
 bzGwCzciTDeZsRDw6dANyXQzi6/ECfqJoOzDB4KIHm+w+ddLx1EdX4FW9Z1UGZvY7s08wzBlxdf
 drbZZeoWqp9EfXo0fSoLyLK4QHp0+OWYpPbeXCheMVIAoWGYCEZg9iuX0/r8euq32kqKh/aEmhb
 RonY/iCo/0mtxUJvLm/aEzb+fygWCTc+/Ixxgj/i+PPY1UsPAy+7t2L4bdmYJmoFifR38pMywIn
 /4407GUBw7oYC60ByBWwQ=
X-Received: by 2002:a05:7300:fd12:b0:351:8cde:a29a with SMTP id
 5a478bee46e88-3518cdeb06fmr1789275eec.41.1791455600492; 
 Thu, 08 Oct 2026 03:33:20 -0700 (PDT)
X-Received: by 2002:a05:7300:fd12:b0:351:8cde:a29a with SMTP id
 5a478bee46e88-3518cdeb06fmr1789235eec.41.1791455599918; 
 Thu, 08 Oct 2026 03:33:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351735e316fsm11973836eec.11.2026.10.08.03.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:33:19 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1] Revert "configs: qcs615/qcs9100: Enable watchdog
 autostart"
Date: Thu,  8 Oct 2026 16:03:08 +0530
Message-Id: <20261008103308.707564-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8m1ZGadMZFIOdakTu4FayF8vg59Rt6dB
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac77171 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=pmjaIY_BoWR4lm-OTTMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX2xENbrhxKosS
 5w3Y1gAPAixZ842wcnMz4w4YzhY4S20QIr+Gg202l+/bdaazVZw2Imh6Jm7WUtkbr9vD/YO5OYz
 mxzGZJgmELorNC8jVOHcsICUOSk1H0A=
X-Proofpoint-GUID: 8m1ZGadMZFIOdakTu4FayF8vg59Rt6dB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX8VQtGjVJJTWq
 W+4EbuPg2Re4Xpj2bhYj1ARzAb02YYIUSQKVjkvHO40BOEneQEoKEZaobJX+tEynk+iu+V6Qaew
 rcF1ksJrd579Z72ol1Urj7970+O7j9Ds5/n5REPpT5bXFSszWcKOn/tujNbLV+t/o3AzFcIDC1H
 TMuTM+1Wxxg3YKQQbY3eyS8DmL3/Htc7mvmjy0nCZg+81vMqX3+YLd9/msshi3oZ1nRsdFIFGh2
 FypvVS6sB6Ol4hD7T+u5b7KOytAASVpMsDH5d8AD+62POPJmc3HFWJiepB8W+vHKaLeNiLv40Kp
 +ZFAk5ZeJ/hmnSFdMxW0LuEBnsGR5K9DVK8HkbTCVYbq8CT/Y7pe4x2FoZ3P2je5URp5BVuFhvf
 cedlx0JYe5SJn0Xr4tSjQ2meC/2/L0q1+CyWQXM6HFS1KZcATkIDEiDjgLnW/hXDvYtt5EORfNN
 fbYG8pzkeDRxYq7n+kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080041
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

This reverts commit a50e32bae6abc8d86d4fa6fff9a1c8f5c88baa4f.

The watchdog is not required during normal U-Boot operation on
these platforms and can be enabled by users if needed.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig  | 2 --
 configs/qcom_qcs9100_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index ccc3bf24ab1..f4760703c94 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,5 +22,3 @@ CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
-
-CONFIG_WATCHDOG_AUTOSTART=y
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 1cc04cb96bd..84b2b9a1bd1 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -14,5 +14,3 @@ CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
-
-CONFIG_WATCHDOG_AUTOSTART=y
-- 
2.34.1

