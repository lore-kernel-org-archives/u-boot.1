Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893A606A321
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wTdY/k8Q;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZxGPsjsO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e+820KCz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 841C160A40;
	Wed, 21 Oct 2026 12:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XRocKVbGj3p; Wed, 21 Oct 2026 12:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3550060803
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587025;
	b=ZGBtnbzbVFMBRQ/LIlKfBPcWYy2+FwXsCwDs4ISfMAOMIb5aLWsuu/VIWh1R+8PwEbMt
	 JiQ/R4JE6gMlau/Els2IjAqtWuQmoiKpsrgXec9OSRQ/RbSH0IdYN+cslwqYbQpDo/d0L
	 it3IvPcd6LyDyu38FtSlAiJgj59AmMuQ6GRdJ0q8bhfT6Ujok+Sm+FiIDQ6G6TqmH75SO
	 R+jnMY6ga4jrFd3FYQlX0uowPtoYHAv50/IPriSFqMxI2Jbkq8DIUpKafnApTIdlLrpQg
	 fSP6J1aIfsHnF77SZdfW5F708xokXuQve0miStNtTntzcg4gdZHeJKqwA2acyj+3fFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=soue8QZYNMkEa4OEOEilEua5inagdbfRbAMQHfm/ytw=;
	b=dTxEAq7/CVp96s5xEsEEccdUNbNyQXNVynRmnEOBr+YGUmnaBQqrTNBYBkHNkLEJoV8+
	 2Y8f6e7I4S0qnGbKu08UgshrXNSGxK7t4KdhJhBgqdjN3SVFKdZSdmYn9lYR1caPz6Rly
	 gC+8InGY3VpXi86f8rvKt/csDiTtx8CgLM3Ca3PdqxvgTa1kiI0YeWGUK/GXy60ss+dqC
	 Q4z/3SuWK0aljhUA9+7TsELua3befnHyepx43gMipvAJs5LoHTp9mOUi0pEQUWwkAtRO+
	 8ikj2ahTbIFeiOSkv5rULAXPvyVLCmMdrlVtObmq+iqC5dzdYfoD4+phPV6CDNGeeUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587025;
	bh=soue8QZYNMkEa4OEOEilEua5inagdbfRbAMQHfm/ytw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTdY/k8QW1x+xLkEqY3B1riztiXmlXlNyKY56whUwFQaeEOFU8jel81YG1lOcBiCc
	 6/7pufW/KoxDlAcrY9MxAG9uRALTEUOPZZrq195zSNh1rUaZdfTYbtPnkg1C71ZPX9
	 oJ/S5zKHQuzHhf1GhuVmwfTHrHw1tEK8xvy06RIk619CTh1pTTUSp4AkJI9xRMB2w4
	 FxPvxfFT/auy6RkXG9JU2oQWe7pWXXRckt8Szle87ur5sdn4PTOhLscRp31/2dNGi2
	 FyuyKzS1Cf4iNzIZ8d8UQr9d4UB9MKmkY6012sPDrtH9BvPGQpX2e4jYIcVi8ZNKal
	 SVM/sp5D5aXmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3550060803;
	Wed, 21 Oct 2026 12:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D2DB930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1300A810DD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xZ3PcPLJVdm for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56598810C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587023;
 b=K5bDkzyA/AvSUULlZN71Lz9xnYJKBV8dr2bMl4pf/ZJ9Tqn8kzFsmsZvkPVMYN/Sw5VP
 ykBYaxaAOq23P/A3oQy//Lk/uIuGxwSnbNAV32YnuLDRHgTg/LYN6jnr6O334QgX//8bX
 HNGYg+BT8ghXQTTyQF8gLPAu6cbvBe3eSUV/qAdKJRRvajTKQvZU3AA6/SB6JdrVz4VGz
 MCNNdRQa02h1oL2r7Tp+ETI8ZYQb3I2zlUx3NfyaSLcV4ibYJOAprb77K6zOk3jDx9WNa
 Sr81AgnYU0RtjRAeQ2pzuAQX2PWHEXDai9Jf6y/f3pPNPVVhgjWlo34KfP2FHLzkXbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587023;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=soue8QZYNMkEa4OEOEilEua5inagdbfRbAMQHfm/ytw=;
 b=mT32mlF7BGMxoMIn7I22FuJaqDiE+q5k8OpPa1C3RH3r55bhR86436YQlSTLyIZHb8n7
 fCzeXSRCFQvcY17tYovFpMJ/L+1ulq8Rk2pc/SMs9APlbJluK6bvSlwB7e6lB7qRLojSH
 B57rWSiCDdUKwlyvqaiwUuusH5LGPTNYbltcFgpPFiDPnVflqZrJlrP0LYrirrNp9Cnto
 v9Usy1PwfzpckS9cq7/x5/MUJ8ZPNfac5+B/qmSGQuCHj6nMt5PLjqB+zP+Kvqbc8DAEu
 0QMI55We7SZTs1zMnPXsX2stnGYOqibkS6nR3B8RuPZXF/9cezvfxQy2UZ7UTdhlXCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZxGPsjsO; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e+820KCz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZxGPsjsO; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e+820KCz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56598810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg3qg3224847
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=soue8QZYNMk
 Ea4OEOEilEua5inagdbfRbAMQHfm/ytw=; b=ZxGPsjsOs39ZDXI57RkKjaZQ0Vv
 N6Jl2qXmb37r0crQsJKPteHmmGHwZrlMHASzbQzERjgRmPZYM8qO4wbSn80Mrz/I
 2ZGtnw0AK5URWDVcsfHy8yxHz7ortpGReVDX/1uMMBFoSiLsy0QZG8wXo4zbBSq4
 8N8p3MBaN0JPczJFiF5sCL7bwyDycn4ihLRpimNKOfKmQg8Xy6GVXcVVx23GHHAN
 0FwOVmAPrDThEQaKJY7Y14l4EDQn/YWdJ94Nw60CETN0ka7UI/ON48Pj5Sm7/hwv
 w57QLboVCb/V3MiaQ2wpEk4/9M0/TFCWEFqdZ6XKh6qur7u27vH8Arrsgnw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy792ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14373747468so573362c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587021; x=1793191821;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=soue8QZYNMkEa4OEOEilEua5inagdbfRbAMQHfm/ytw=;
 b=e+820KCzdE+J88x7wMsh90sNa3VxpShDxrvcUooPOMZ8D21XKizk6mF5nJFZbC7cwZ
 tbZJvub9FlLlvBaDP7oji3JnG9icga6jjNdm1iVwVxC64cdKJVnxQqJndC6stEatbaHx
 jJYQKwwIJQlJobwmoRh+9AbsAqu6Gkn2BoHmi8muNqrLegyMw9gH1Kw3j0/dnc4ODGMo
 CCWvYAzx0AvGBvbhcfquHTcDkNFzkJJYS3pmhpUWLlZD+ttUhmv8FB02yJetcc2Wttxf
 oR6E/ZxViWRr3z93Jr0z+jUoWNPzBWxWp4cqeq/5LPyA7fMy9TquKOtIKjiTB8y5zA12
 83NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587021; x=1793191821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=soue8QZYNMkEa4OEOEilEua5inagdbfRbAMQHfm/ytw=;
 b=m+NA4cHweg2ZftOyNE/Tc5IzlVXF8QAhtAV/mUdcI1rKsjEI9nfwjmBmUmwzn4mL3G
 qSUpdmVmEPfrGk7Gon8nJd8cwl9X6ymT8lIoIco6ZOlhJhExBSy65htDc8wIkS3Injhh
 DmmhHqHt0RrXJSh4kyin6wUdp08p29XZDm7tL47SSBnzGqAQBHZohnt2QP6p5vJKpxBi
 IXa1vvbrB/CBgTPvIdlAesvW9hWo3SBkvvtAEGga3x8xqfpcu7ymPFIYaEMHgNsnaNRS
 kJLX0V5/GmBqTQeKNnVNa/Ot9yzDa8gIdhT4ks2+nKYO+C0seKvPoPn/W+n/COznZqxO
 SXsA==
X-Gm-Message-State: AFq9FYIHqcqlTlWN4Ts/IUHcJbon2+aJFP1jCMY5D3o0IV7TklCjxvXu
 CZqsXjyoEa18mE7e+i+qlRTpOW5dRkEgGikXPBjHHBJkVLY6PjE+PvOhZQqHaLZl++m6opFaNpr
 dBlExNYCv8a/UXzRcqqqRMM77BQCB/zMykduAW1ecR8VFADQWe1Jl5SHQroBTxKZSLof1AErWuK
 l46l8=
X-Gm-Gg: AYBFou2gyw1qy4QN7AM85PyEn9JQyYRrkV2LO/WXpT5CPBdhD3MhoNnAC3radboQ8K1
 lZ5tadVUHVJg9GJ9O/UOA32JkJACMJSa//er8DEzQZtNg11agSJZP8zpVSKOVneTjZiqBWsE3my
 8P6kmb2Tdql5Q2rXMduYFDQOIu3F9WWcV+LzhStUlHeY+nDBOdaUIU0mH33dqDrEYN06UcIRFHd
 Nd0KT+7v7QnQSHDSdefqYwrEUTD/fpMv3aDk606QhrCqlREm0zH7tRcjstQ7TE6Lr2TekXAhsMb
 O5B0kshITT+Ayj2fNVIt05RN6H/9WlZWjWtju+kthX4Vm0WdICAhpHS3mM9EUES/RRqMRiS/4e9
 5xU6sKdR1P4JpWUGtTOSmcAMyMK6Zj+leFlKAptsYL1LWlZQGO9j8XIpxN6FmYcdPw30pSCbCR8
 hikPWOTiUH5JJtXer0/cTAmg6NWnopWeAvQ8o=
X-Received: by 2002:a05:701b:450f:20b0:191:ac4:55a7 with SMTP id
 a92af1059eb24-1910ac455f1mr1757323c88.23.1792587020215; 
 Wed, 21 Oct 2026 05:50:20 -0700 (PDT)
X-Received: by 2002:a05:701b:450f:20b0:191:ac4:55a7 with SMTP id
 a92af1059eb24-1910ac455f1mr1757275c88.23.1792587019520; 
 Wed, 21 Oct 2026 05:50:19 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:19 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 2/7] clk: qcom: ipq5424: Add GENI I2C clocks
Date: Wed, 21 Oct 2026 18:19:58 +0530
Message-Id: <20261021125003.2948090-3-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: clbe23K9UaNNbOFsdpmM2aiMm-C5vdO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX0x25FjWmlNjt
 /FYMub0NHRkOmKkLOKLRLd9+GIDtGWcpYyhy5FI6+HQK1I7T3U6hfrwiNoJ4h2n4T16Vw1MYPhJ
 5sWZ06fnbW1t9b2P686qJCXJmHWcjiKAD9vyA9Q4gkAfVePN5vCC3CxUYjxY9YeL4Tyzt4y+6FA
 cKiT+qxPAJcd9wtnSUIQ99ixcDoaqT7gbyqy/4RrZeQPJEuNFKm+yptHzrJHaVjT4NhB/qNGGCm
 WQO98PTcbr+SlWELCh6rVeR3Z0nYsKq8yfsDKm5gaWwINoT+ZbHzJ449B/ftxsob3CjJdvJ9v+Y
 MfIqfs04630lIAtTmPDeq77SOPQTjDNwwSNdutrv2gaDHISyibzueCP0xrjMs/OgPcq4wMFJnQh
 qEa+/oz92p6UTs2+GaLjVyRSLEkOWgcWEWKlD0urAcNnN5aGgFgWukSjhsFbvF2TVaG/5eIjJg5
 z42b7l1uXikrz2UAyCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXyeemRz7AQb01
 +iPTg6T8wxBtSBFxE0fJgsJhPOgRUW/jv0/MfxAjXl9myqoE+WamRfgcScVoWQDc8zvw8vdNOjx
 EkKjaAqTUW3UudIkTR6MwCEtCYlSrkA=
X-Proofpoint-ORIG-GUID: clbe23K9UaNNbOFsdpmM2aiMm-C5vdO6
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8b50d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=YrG0Lj9Q1Pu9r8R-QAgA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add clock configuration for GENI I2C and support 32 MHz clock rates.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-ipq5424.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/clock-ipq5424.c
index 40823a30ead..1b6e2dc2cfd 100644
--- a/drivers/clk/qcom/clock-ipq5424.c
+++ b/drivers/clk/qcom/clock-ipq5424.c
@@ -19,12 +19,82 @@
 #include "clock-qcom.h"
 
 #define GCC_IM_SLEEP_CBCR	0x1834020u
+#define GCC_QUPV3_I2C0_CMD_RCGR		0x02018
+#define GCC_QUPV3_I2C0_DIV_CDIVR	0x02020
+#define GCC_QUPV3_I2C1_CMD_RCGR		0x03018
+#define GCC_QUPV3_I2C1_DIV_CDIVR	0x03020
+
+#define IPQ5424_I2C_RCG_DIV		24
+/* CDIV uses an n + 1 divider; a value of 1 divides the RCGR rate by 2. */
+#define IPQ5424_I2C_CDIV		1
+
+struct ipq5424_i2c_freq {
+	struct freq_tbl rcg;
+	ulong rate;
+	u32 post_div;
+};
+
+static const struct ipq5424_i2c_freq ipq5424_i2c_freq_tbl[] = {
+	{
+		.rcg = {
+			.freq = 64000000,
+			.src = CFG_CLK_SRC_GPLL0,
+			.pre_div = IPQ5424_I2C_RCG_DIV,
+		},
+		.rate = 32000000,
+		.post_div = IPQ5424_I2C_CDIV,
+	},
+	{ }
+};
+
+static const struct ipq5424_i2c_freq *ipq5424_i2c_find_freq(ulong rate)
+{
+	const struct ipq5424_i2c_freq *freq;
+
+	for (freq = ipq5424_i2c_freq_tbl; freq->rate; freq++)
+		if (freq->rate == rate)
+			return freq;
+
+	return NULL;
+}
+
+static ulong ipq5424_get_rate(struct clk *clk)
+{
+	if (clk->id == GCC_QUPV3_I2C0_CLK ||
+	    clk->id == GCC_QUPV3_I2C1_CLK)
+		return ipq5424_i2c_freq_tbl[0].rate;
+
+	return -ENOSYS;
+}
 
 static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
+	case GCC_QUPV3_I2C0_CLK:
+	case GCC_QUPV3_I2C1_CLK: {
+		const struct ipq5424_i2c_freq *freq;
+		u32 cmd_rcgr;
+		u32 post_div_reg;
+
+		freq = ipq5424_i2c_find_freq(rate);
+		if (!freq)
+			return -EINVAL;
+
+		if (clk->id == GCC_QUPV3_I2C0_CLK) {
+			cmd_rcgr = GCC_QUPV3_I2C0_CMD_RCGR;
+			post_div_reg = GCC_QUPV3_I2C0_DIV_CDIVR;
+		} else {
+			cmd_rcgr = GCC_QUPV3_I2C1_CMD_RCGR;
+			post_div_reg = GCC_QUPV3_I2C1_DIV_CDIVR;
+		}
+
+		clk_rcg_set_rate_with_post_div(priv->base, cmd_rcgr,
+					       post_div_reg, freq->rcg.pre_div,
+					       freq->post_div, freq->rcg.src);
+		return freq->rate;
+	}
 	case GCC_QUPV3_UART1_CLK:
 		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
 				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
@@ -38,6 +108,8 @@ static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk ipq5424_clks[] = {
+	GATE_CLK(GCC_QUPV3_I2C0_CLK, 0x02024, BIT(0)),
+	GATE_CLK(GCC_QUPV3_I2C1_CLK, 0x03024, BIT(0)),
 	GATE_CLK(GCC_QUPV3_UART1_CLK, 0x302c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
@@ -68,6 +140,7 @@ static struct msm_clk_data ipq5424_gcc_data = {
 
 	.enable = ipq5424_enable,
 	.set_rate = ipq5424_set_rate,
+	.get_rate = ipq5424_get_rate,
 };
 
 static const struct udevice_id gcc_ipq5424_of_match[] = {
-- 
2.34.1

