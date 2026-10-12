Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E60ACA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0709D80CD8;
	Mon, 12 Oct 2026 05:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVvZuoQKiCHR; Mon, 12 Oct 2026 05:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1068E80D1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783333;
	b=BIo3DsGyUn9AhKJg0gsQEPH9y4DSnZxIW4YVYBy8E96bVlOwpukUO0EBbwu3hI9P0c9L
	 9GzR3gEoD7Da7tvWk7i6nEeQm+YKDcfU79G/CPNRGRw+RsNqyEePgLKBUNSSVGfsB/xqt
	 AQPeaQWl8joK+j0IBdn4G5Q3iI5A0iwKjYvO8rKocZdQ9bRYA6eX1DUCDCP4GX0zSNVVx
	 SWkOKqI54P8jcUcsYcRdW7VRa/40lyd4/U9wAsLi2m+fZ2MYGA3mlZvJ6Fj/eBxxI7tCz
	 6XtqUHghHLB9TOqXh1kNHBChfI/9C72d4o1+7Jo5MRKGF1fSgBRLKXGON6OrJLP7nGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	b=nfA7cEbzKhYX/e2NgYrcI9XUIdtT1bC0EfWIfWnfOu0cbs1j7/Hk8cfoDe7x3fHeRHar
	 qS/JH2kC4VuXld9r+IbdHdniihVdfQBseXjlrUy+oFQbOqQxZLB7R57XiOIqDBEgVp0hA
	 SV96ZejBU2/QzNmEULz9SHI6RBrnm+8DDZDjdEPhJlmap9m7xesati2po5g8sjDRpUQQm
	 HRaB9XWMI5+v9uQ8uzryii3fODVzScXr0zVVw+npXIgvxB2IrBcxSNqZhR7HrnHhlZUa7
	 kr1ik8C8fLZPTpesCJXYkA/DFZOVZg5J5gpm9ZurT6TjWX0u8k6Su6jCi33JW0OADnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783333;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Du7w0h6GRcvV1aTTF+LhW8h8atp9D1gEIWXhWYwQzSRKiOXjAXDdUYw93whzQ3Ls7
	 YGwdYMfdjXETVDHGB408ZHDF3XEeh8cdgzdV8yZLJtTr0DFpwljPMWS+iplvldHpFd
	 ruzC+IgtzOEBqem/3z4Qkc+TyX/ICie+rqbQVUQ5DsEBi+mmzodRNljTwIZ397KaCo
	 0YTONOqeTlw88ZjOGBlmtndXAs4IJsn5+8cVsYp04WI+n8anhVSrvqiGU15kkSpmkA
	 EBXlmHW6fwjHHyFiYSZuesbjZ+2/xFtQLs0pl3yIxZyyDCiU1UXY5R8idbhkcInvRm
	 qaRYWcY7wf/6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1068E80D1A;
	Mon, 12 Oct 2026 05:35:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3148C1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16FFE606EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i66P1y0B3xpo for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A31060719
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783311;
 b=IxEenEAeX3KKNoHUc2Bpfvk5SIlVlRS2+EqAIGsVjA3dk+v/aIdSYgwZA8oFgzrBA45s
 q5BUX3GnMU/bBZJiNoqP6J0o6a/1rfXnl85a/6T3l19Djv+/GVssIZp2ZHgP0hBgwZfnP
 jzVAzM6rrC4m7Y7eSJdoTIbKMNZlHMgb2tWHhjBAKZifujryvA7lhHKd3Hk72SxJ1A99e
 E4y5mkEqplaAusD1D2JA7Z8TJJfiwdy7wyNHHyoa0wQuF/wdUdb5xYZBe8V2DhC1nFl9Y
 vEC44TBPKJzCMXTN4xLnpY52LdWJSDwm6j3KWu98lV5+KO60H0N6EbpQs8TK08Kuo6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783311;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=nrxoGWuSsfRiAVEjQ8OxzHOH5McFs9NDOIJuG9sMNi/aJNWzAIrrmRpSQCQoTtpgrVnZ
 YVak2g6MQOZXh8JBNuvnwaFIf5d8BAB9o+Q4+sd84LLC21SIz7Fl+BEHC8f60V3PeD+W9
 cs0Vx5G+EkvcHT4at2sfScCg7hu8BKTmwDmpZz6PMAl0B0dXpauiVmCuI1kBwqDNukvip
 QSBKbVHniLX6uHQZW+rc6GFnOhdYRZ734hjmfLPPylAGSivmR4dPSFDnDl9EVs27b/YcC
 l25MhtxCFhED5myqp66CL9+AFk035meLCs6aBxPGcA0Wf/+BlrAgws2gYHA3SIVH/gA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ENLPi3qt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dP3waHrs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ENLPi3qt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dP3waHrs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A31060719
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55kNW1856967
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6yrV3JbZef4
 GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=; b=ENLPi3qtNuMUoJsuwlgEFpa5jmP
 kjCRZJq0wNo5UOkWBdgpiNAdnCaTNRf5umVIlU996AlNhnEOkYQpaidaJT4JJ+up
 zxLQfYFkFsdDhMJviEVctceWkgkyI/yDynMT4Vx1gZi7czk82OT0J50PJHZX16Xn
 YUXG61Px+vTfEA31sRl9cX+6Ca6fPpA4LDL2QJm71w2Ab4504e1ZK3XsoB/BtXvr
 Rz4e0Vkm+yom1Stp/CZwNG0p5mia+sX+amXup3vsX+Obr+n9C1JBegTmuzJF9q0o
 7d/vaqDTXxRKZqvo0tigq64Ii8yuDnPpMeQ1xMDEODe0V3zPeRS4d5F3Bcw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxn0ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359d11365bfso2735739eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783308; x=1792388108;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=dP3waHrsjv8AbBtWUeRoUiq26DeLBH8sVADJ5yAcKDHaMHy0xSANuzi+u9bZriNGk5
 XfECg5Htbv4hEBTU2aUHGlY9wPGatQ5CAnN3kspXQaBr+o+bRLslv1r9zsz4YoCurg9N
 QkDxUTjy4kY6iMO+HNCqIYLMm2FJw4LNCeMRKBx7d6gp6zFTR6NdEBAipJ6D0GPNb0em
 hI4rmHcM+p1ezXXuegnEo8gM6weJSugcGdh8E+ZwetnAXrThxmC7jyNQMZaab+FApCg9
 7v2TfIbRGx45d9MKRg3rHWSjb4Fepp5gEGxhgXNH81TrPUk6QaOWnRob/I9upxXwTpRt
 KIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783308; x=1792388108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=P6o8TrRcfn0iiegEO3dE2NH3qvQ1XlJoAyPRx5lDKRF3fW5GJCq58jsXFg75TMAMYd
 R3vQG/sToeaPK/UiBSrsw12+DPwhXbvSlfCIcwavYJwN4yhRCjn3UJ7+DlrusvTqRJ4L
 WXoWtaN+0yQ2VnWDMQDyVIJ85Uvai735e9t2R/nkk6kAKUMbbwBaB+BbmRNHgbH5rE3K
 Gfwsfvr1QQoYvSsHN034wgu2Wx8xlnT45SxkA+gs51XNK1nuNB+DpYBNT6hIA5BbR6AE
 5lW3/W15v9gGJCvi0qpc7BgVyffIHzvZ3hMHyApzVSqXzBweeK2M/MCnI/it6KWsc8ah
 Jjpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzD7LiaWwHEmZsO/Rf1kCLBSP/kI9qAoFtDfyJKLXowm3gSfpKC8ARMGs7UFcTUPNmEYVx7deo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKPKTxu0J+ZymKDe9C/9mbVgJ6OygqX6RfZkF1BqMXWMxmUo+i
 yyoeD4CBzFbd1yVBH0w2/bgRUe2kE/c5oYQrEUnvyruRD6Y53dpW8gbfdK+TUV2+jZZMrPM8oHh
 GxYR8UyNrohVukkYVlrSWvC0sJ5zYPihYYoC74/DWjVpzeVwOb7y/qQM6apwxxdpu4b6xgJ4=
X-Gm-Gg: AYBFou0X1YIBW65hVcWgoIl00sXc0E68SAVtP7rp76/1EkM8TfN8SpKbsrxXCkJ792A
 Axysft2MjtInpOVMMi6gqhraf3QrYmNoaCSLMuqFSW4wureNQeGZYUuBWVgaiXI3K1xu/OZobBW
 iod2Yd5bFzfnHyFi+l+5bGWpRkHwNgO8Kb0DhrMONXgMbCoRVx2MpCP4fOYJWHOTbr8XMrXzzcB
 7TCNSwfqfBn7WKRq/zhPCSX4YLFFO/xa+kOhQcT0CWa/kWMoS7NYvF+GYg8rT8WlBpQ+w6NdLqT
 ZOO3JxOe9qLz79LiLWBLAAIvsxdED8VR/DR0dVRmmPC0/1gPYOVAOOU/U8rbThbWGUW5GzFZDO4
 SY1yVywu3lvRcwkrtkhT84MqA+tUq7k4IhuNiuU1UqWg1A5QY
X-Received: by 2002:a05:7301:430a:b0:351:7444:8bfd with SMTP id
 5a478bee46e88-3537e13815emr11370995eec.39.1791783308114; 
 Sun, 11 Oct 2026 22:35:08 -0700 (PDT)
X-Received: by 2002:a05:7301:430a:b0:351:7444:8bfd with SMTP id
 5a478bee46e88-3537e13815emr11370944eec.39.1791783307471; 
 Sun, 11 Oct 2026 22:35:07 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:07 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 11/13] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Sun, 11 Oct 2026 22:34:50 -0700
Message-Id: <20261012053452.1567885-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UOMHQbGoix-EA-hmn6XIi24L2nuZPuPT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX1J8KPMKnv4pS
 aNDsWs15zl8sHVrMW+5IjI3IufGT4qz78WSf6FTh/+eG3Rvdo2uWR7KX3Pz0rTkzcapbpIE6P5T
 b1OKhkzc5X/FmDZ1GMC9fPnBICAl9gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX+CqusbIipkd2
 GiyNfXzXwJW8g9IDvYgSuWZfUjrNHkWaUKOeEU4lWd5alruwhU5s10Oxer55NQtrHtTh+/YDAaP
 vJnTzq0de1gLoRwvRshQ3uijJnI6UfgexV4OdPmLh+JFS/XianFQPfGJH6wfv3IM2ok5BF9wg5w
 Wg2Y3LJtkIgfQ407yXgV276G8eDJEjV1RTEQ0KW57h8BeBRxTVKIgv23WpLdtsDquanZHBrwXC+
 v3aZRHcGrqkbtTlHkLyCHgwgA873q5Z4S7pJ+dSfvFKfG+ZPPHv4c0oyQwpspXIlPdfgfnnrDhw
 Zq5SCE4woD88ZSalQVnZg9VJOQ5IVjOi4RCmEqAsITwFNoTn3FhcwUQqfeBkqmhNiTXPJbOuCVf
 1SP17Si5NZoqu//lIw0R21KtvnTwgSt1Bky01tG0qIeXZkq+u0Q9a1ijgbb/vlWIPOTu1EYhrHe
 2isPxeavs9vqlkWsRUg==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acc718d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=v_ZaApmAW4vm0h-ULSsA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: UOMHQbGoix-EA-hmn6XIi24L2nuZPuPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 3 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5718b66cde1..b4fb05eec09 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -66,6 +66,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
-- 
2.34.1

