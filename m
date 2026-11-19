Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DA606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p84tE76h;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hjeb7abo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6C809il
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D727E60AC3;
	Thu, 19 Nov 2026 06:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVcWvTuYQGwj; Thu, 19 Nov 2026 06:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E915760B86
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068600;
	b=MYU6V4Dfens8CaVUGjLOllGk2qdGcEn4KOXFPxIDh/gfKiWgYytjOnwKFMy41e/gifaP
	 kb9EDwo0uEXUY7VO4IVw6CkbwiGPiXG/40J8h0IMIqx2kUlQTmdR48r4wFZ4KZLzki8AY
	 Ba2gYpAG5eeWCfX/WquKCfEI8fnKecmTy/8D6ShGt58n+e4L9mLbid9q/LazxWiMHDmMw
	 yhgKeSXXfgF9+ZgBlAuMKHUHMs6SRAEnhjIf6vhvB2+0qrekXVLJgnw1WONBqGSSXW3Td
	 CcaZtcxMpW0fm7xIDM203SYND2RzogW/Wyvonvjlv3kVTlDYwMWwvGu9+82gW/H38cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nWXVfrzCmtanH/JbpIO/GhcWMPJdDY57ctQjrrjGuKs=;
	b=V7EwvbECGuD/qeMF9GEK2IsO370CfigRRgi9gSGGvgpkE1eFMvL9LQvM3ZdBProl4sQ3
	 iwJq5inP2oFODoDrkYOKQkaHhJR42Z1PltP/GtR3T4rV7SFnRKiwOLNu6humQWcxSKTEn
	 zMwxv9KbamOfH7xOYintyIHzt1RKCs13M6lYL34Z4BLlpGYEEnLX3flJ6KnRJQQ/qx0Or
	 bzb9uts9h3FQE4+PjXjdhQZVW4EPi5oV2zRiMs48n3FWRnDakkw6MORcqEd+Ohqg3WHNP
	 7SzKI7icXLT7SpIDDbyPKlPE5qTUq1J2V8wS/5uY7vfkYHC++TlhnTfSW0x+LecOhMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068600;
	bh=nWXVfrzCmtanH/JbpIO/GhcWMPJdDY57ctQjrrjGuKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p84tE76hEMGSRMIGaiU4ea74QQF0ByCN4N9+kwkEzjTYqbJwfR3tJnk+LVW75V2fr
	 7qGJxsh4WYLvwNAv5DX6qObsOwDinuDmwBNz+6bHxrsPiksHGTFZr6dxEdTu0Jo52t
	 kCN7CWv/1FRCLnXSDPYniUsfDnSEpKU/qlpt4frQCVeHTuJpa+ZvmYkKJ0er9jJgdR
	 XxSSbx/JCXtSgsA59FxTw/1tJchtYPWYy64OhGXD5uSmY7RDwktdFr1Hsxy5xyhYAC
	 tn6M+YTXfwdv24No8irMP+B8sz5zXUKA6ulz/5POmr6wIltR7qRjM8KCROYtZhJj3L
	 vF99v2JKYO4bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E915760B86;
	Thu, 19 Nov 2026 06:09:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 162551C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07E9940080
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eIZnDjiOXNhs for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1449540072
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hjeb7abo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L6C809il
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1449540072
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1Aqh2935166
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nWXVfrzCmtanH/JbpIO/GhcWMPJdDY57ctQjrrjGuKs=; b=Hjeb7abonZ6t9YIr
 aA3v1sh67npxcBVyOEiOhBkLq2iDH2eoFByWA8aHsX1VUk838YCMZMWzAWMCYVAh
 0lGGOQSWv/Lmi20AfxaBP3+2231Q66Nv6jdQk1sFrEj1gmxUU8YWsj2YJcVGetcg
 lXejVvK81Z2dD8tYWL6x5+3ui5kwgmCg8rG7w1omBEecFAnGAZFY900HbYO9KUUN
 3IRhNdj7GMissgZKyfnwf4Tmr16IuLqNdSpc21jZj3zwNPvgmxlgkKkmjWvOZHtw
 WGN8OANWhGXkQw4zr5lHkN8d5Ug78SZdplpD62QzjulwasnjYPLX61gNA24T1Wcb
 tUuXLw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcs6d9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso217362eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068594; x=1795673394;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nWXVfrzCmtanH/JbpIO/GhcWMPJdDY57ctQjrrjGuKs=;
 b=L6C809il7BmR+720JNZwz6NF7oaxnK+1Xp66rcmk7c5JCTqFk3XS2TsqYni4TwWiHS
 tl1GpqnHBSzh2vJMosCkQseDNoYAm2ZAd0RduKKjRwFa0THEYuOu6AOBFfIkdsR8tQxk
 M5k4OFtG+TI/JWG9VNjjYDSxvjBZ75v47MqosYk0HIXkG2X8sPbxMDCbEMpCTO6grg8C
 gaUyBqW/1AvJCuarmE9EAXtvttqpovyJjaUWX7cdu122c+cJJ3euojCITh1NfQqglTBQ
 8p/9CJS+CD9VGSjo2VdStKC3jdI0phrQolWHr3/Vorn4mAylmg8zSeEcRH9XPMwFEcTb
 FnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068594; x=1795673394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWXVfrzCmtanH/JbpIO/GhcWMPJdDY57ctQjrrjGuKs=;
 b=bz/iy2TjbVKQ+uq2qbg0hS4+5P27L3Wi28IaWfnYunwfaJ5IAPfirbDEUFfW/oiOkU
 ZcMJd5ac4wnV60Js+7Cx4d+x1Jy8Mh5R3WhMRm1xGcw+Fgw9CiDcuUpipn+NIRw6Fu+x
 ZWzHCwZSXJCcU5WWTYa0Wqfq+unuH3m12QPupvx5+dQ1zktiFdHqJcdJZHTF7MY/7ikS
 sIFJWjta/kcL7wxMgBZxacifGZmpQnYf2JFPDntezgP72a2xzSF0SbBctb++OELUpCYS
 R7iokixG9QkpVkrXGr3dL5+KJIycQpac9F2688IMWAIVJgqHv0Da5XaGI31FUdrKVKfu
 ttMA==
X-Gm-Message-State: APuU4Z8LAeY9M+HXwL/g0FKzp8tKTKoyqJid07Zqi3E6OIgTZnzasATs
 0yohBZUA8nTOEsUwdl5TjAD7cd5R/xvEazhjjjt91uM8DJeFJoYoNPZ3Viwej2tUJhSzdKh2jBZ
 9B90EBrzNDIUzlM/GvFtFxmEph9MxRW5bL2YuV2ZOY1NuwZ65W0IGlIY1CSg3L2xqJGeCgl0=
X-Gm-Gg: AZFdTZe7JDNuErt/9XEWyK5NSkcbEGSu7cCMtcqpVx9Maw+m7XGQ2FBkQuwMDdtsVI8
 1Ho3FAo3JC4D6LCayHQkyqTJsYj+T5+gJhzhd1qDapbDpIbGVGHIpemwkf0hu7waOUIggFN86PH
 lKxoq/fxKwVo0duH2x3z0Pk7gUUtpNxNsJDUoERrHEU7VEdNnjV/127Jrkya31veqmwLIDG4EF5
 aAMw1Ohu8VMsX4BuHenc5eQqkaKYXjkqqKI1X6tjU/BqGEdKaSZhh0+N3B60/VvNfkQtF1DEpxy
 Qt2lwvSXdMOfhu+eTO2c4+1GyV1/syUbta/QG6yZbTza10IXrjDISY2h2hNe4Cf8MDNid7I9Ud+
 5qBFMLi6OzvfGybD4jS5t1IxvsIdDEvlhEPMBi4r2XPykCYhbekUKQ+zfjOq/CjoibZkiis5oP9
 BjRRLfJIFBk5sxCpbNAulX6o7hWRgny/o+L2HY+RE1LLzkUMqjEcmRqumoNkrTc+uU9LUODtr6/
 tSF7g==
X-Received: by 2002:a05:7300:f408:b0:36a:12c1:3adb with SMTP id
 5a478bee46e88-3828026b8acmr4743781eec.20.1795068593967; 
 Wed, 18 Nov 2026 22:09:53 -0800 (PST)
X-Received: by 2002:a05:7300:f408:b0:36a:12c1:3adb with SMTP id
 5a478bee46e88-3828026b8acmr4743749eec.20.1795068593260; 
 Wed, 18 Nov 2026 22:09:53 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:09:53 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:39:18 +0530
Subject: [PATCH 3/5] usb: tcpm: Add helpers to start a port from a USB
 controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-qcom-pmic-typec-v1-3-d197e6d7da5a@oss.qualcomm.com>
References: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
In-Reply-To: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Yixun Lan <dlan@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Dave Klotz <DaveWK225@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=5921;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=6+SbIAi3crsvj0vBICQzsUGin7g+LoKp5ASrgmWhPZU=;
 b=6p2GbpLvTdRdripmPk3gPEgoe84Ouh1PuJKdrh6p21JUPSGbAd0gYtsKJbIqm3XGx63CjifmD
 WkQYohj7jj6DiEuGAKLpw9kSKozlT87MyAoWCNSb5qqHXOf1w72V8sc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: _8JZZtMctZ35IgN7QW4JDcn9A3qSMQoG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfXwFOkvYyt+OFR
 lH0LqOb66P7ewL9HM+tgwewtpuu+jLP0wBoiftsqkF1itFKfTYTihSvwiDIRs4bQgoH87AjfKR3
 PvCXc/no7XqwyEDDU0+QzheTshbAvP4=
X-Proofpoint-GUID: _8JZZtMctZ35IgN7QW4JDcn9A3qSMQoG
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afe92b3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=_D_SyMcmd52LYsXw:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ue8CVL9gehzrRrc9IAkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX0bYuHsGAz2yS
 FjvI+r727fFUq3bZrDFJxLmtrjA9QIW75YZFAvYa5fnejpP8WN5GdVfEbBNHCpYm6D3vfbYvT5a
 x/i0oEGVcdrVpjn1hLKcuYMaErdlKt6DFXBq48DTf9Iqr0aSVuwkM7IyD2aVXHyg5FHR/KP6R8i
 F6KOdm4aMAJgOh/2e1tsOc+2ta72kUnF3ybJtqfesyLppf6b/NgWBRA4+D/zpzKrw52P4Gquw5i
 nu2SMnYAs6NZw3i5o/dXl3Y9B+0xBcjo/1VmXQ+PWPaUIOUGGMuS6+tRjqzh+1V7wNRQZ2VAh7F
 6fBsOBTODW8VPZofqsTnOMkWylUfkphEfzLBE6jZr3TAPo3Mvbga18raBfRDBxPhsALTzAQfkJz
 7LNa9Rc4Ir77WV12D2SpIhWi/U4W/bFj59tIqbuK1WNI5Mnf2sijSMPkz+00k+DB6MrBb/rk2Zh
 +vp7EaX/tUw+topcN+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190024
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

The TCPM core only probes sink ports by itself. A source or dual-role
port has to be run by its user, so that VBUS is turned on for an
attached device before the USB bus is scanned.

Add tcpm_get_by_usb_controller() to find the port linked to a USB
controller through the OF graph, and tcpm_poll_until_settled() to run
the state machine until the port is unattached or ready.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/tcpm/tcpm-internal.h |  4 ++++
 drivers/usb/tcpm/tcpm-uclass.c   | 18 ++++++++++++++++++
 drivers/usb/tcpm/tcpm.c          | 41 ++++++++++++++++++++++++++++++++++++++++
 include/usb/tcpm.h               | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm-internal.h b/drivers/usb/tcpm/tcpm-internal.h
index 56d02cc3745..e262e782829 100644
--- a/drivers/usb/tcpm/tcpm-internal.h
+++ b/drivers/usb/tcpm/tcpm-internal.h
@@ -57,6 +57,9 @@
 #define GENERATE_TCPM_STRING(s)		#s
 #define TCPM_POLL_EVENT_TIME_OUT	2000
 #define TYPEC_NO_PREFERRED_ROLE		(-1)
+/* Time for the port controller to report a partner after port init */
+#define TCPM_ATTACH_DETECT_TIME_MS	500
+#define TCPM_SETTLE_TIME_OUT_MS		2000
 
 enum tcpm_state {
 	FOREACH_TCPM_STATE(GENERATE_TCPM_ENUM)
@@ -91,6 +94,7 @@ struct tcpm_port {
 	bool connected;
 	bool pd_supported;
 	int poll_event_cnt;
+	unsigned long init_time;
 	enum typec_port_type port_type;
 
 	/*
diff --git a/drivers/usb/tcpm/tcpm-uclass.c b/drivers/usb/tcpm/tcpm-uclass.c
index d4fe260e0db..da2ef9d1d54 100644
--- a/drivers/usb/tcpm/tcpm-uclass.c
+++ b/drivers/usb/tcpm/tcpm-uclass.c
@@ -7,6 +7,7 @@
 
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <dm/ofnode_graph.h>
 #include <dm/uclass.h>
 #include <linux/err.h>
 #include <usb/tcpm.h>
@@ -80,6 +81,23 @@ int tcpm_get(int index, struct udevice **devp)
 	return uclass_get_device(UCLASS_TCPM, index, devp);
 }
 
+int tcpm_get_by_usb_controller(struct udevice *usb_dev, struct udevice **devp)
+{
+	ofnode node = dev_ofnode(usb_dev);
+	ofnode connector;
+
+	/* The high-speed data bus is port 0 of a USB controller */
+	connector = ofnode_graph_get_remote_node(node, 0, -1);
+	if (!ofnode_valid(connector))
+		connector = ofnode_graph_get_remote_node(node, -1, -1);
+	if (!ofnode_valid(connector) ||
+	    !ofnode_device_is_compatible(connector, "usb-c-connector"))
+		return -ENODEV;
+
+	return uclass_get_device_by_ofnode(UCLASS_TCPM,
+					  ofnode_get_parent(connector), devp);
+}
+
 static int tcpm_post_bind(struct udevice *dev)
 {
 	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 4188989b567..54b29899ee4 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2255,6 +2255,7 @@ static int tcpm_port_init(struct udevice *dev)
 	port->port_type = port->typec_type;
 
 	tcpm_init(dev);
+	port->init_time = get_timer(0);
 
 	dev_info(dev, "TCPM: init finished\n");
 
@@ -2318,3 +2319,43 @@ int tcpm_post_probe(struct udevice *dev)
 
 	return 0;
 }
+
+static bool tcpm_port_is_settled(struct tcpm_port *port)
+{
+	switch (port->state) {
+	case TOGGLING:
+	case SRC_UNATTACHED:
+	case SNK_UNATTACHED:
+	case SRC_READY:
+	case SNK_READY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int tcpm_poll_until_settled(struct udevice *dev)
+{
+	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
+	struct tcpm_port *port = dev_get_uclass_plat(dev);
+	unsigned long start = get_timer(0);
+
+	for (;;) {
+		drvops->poll_event(dev);
+		tcpm_check_and_run_delayed_work(dev);
+
+		if (tcpm_port_is_settled(port) &&
+		    get_timer(port->init_time) >= TCPM_ATTACH_DETECT_TIME_MS)
+			return 0;
+
+		if (get_timer(start) >= TCPM_SETTLE_TIME_OUT_MS)
+			break;
+
+		udelay(500);
+	}
+
+	dev_warn(dev, "TCPM: port did not settle, state %s\n",
+		 tcpm_states[port->state]);
+
+	return -ETIMEDOUT;
+}
diff --git a/include/usb/tcpm.h b/include/usb/tcpm.h
index 10f0515fe12..1c4e9f8965c 100644
--- a/include/usb/tcpm.h
+++ b/include/usb/tcpm.h
@@ -9,6 +9,7 @@
 
 #include <dm/of.h>
 #include <linux/bitops.h>
+#include <linux/errno.h>
 #include "pd.h"
 
 enum typec_orientation {
@@ -87,6 +88,45 @@ extern const char * const typec_data_role_name[];
 extern const char * const typec_cc_status_name[];
 
 int tcpm_get(int index, struct udevice **devp);
+
+#if CONFIG_IS_ENABLED(TYPEC_TCPM)
+/**
+ * tcpm_get_by_usb_controller() - get the Type-C port of a USB controller
+ * @usb_dev: USB controller device
+ * @devp: returns the Type-C port controller device, probed
+ *
+ * Follows the OF graph from the controller to its usb-c-connector node. The
+ * port controller is the parent of the connector node.
+ *
+ * Return: 0 if OK, -ENODEV if the controller is not linked to a connector,
+ * other -ve on error
+ */
+int tcpm_get_by_usb_controller(struct udevice *usb_dev, struct udevice **devp);
+
+/**
+ * tcpm_poll_until_settled() - run the port state machine until it settles
+ * @dev: Type-C port controller device
+ *
+ * Polls the port controller until the port is unattached or ready. A partner
+ * connected when this is called is attached, for example VBUS is turned on
+ * for a sink partner.
+ *
+ * Return: 0 if OK, -ETIMEDOUT if the port did not settle
+ */
+int tcpm_poll_until_settled(struct udevice *dev);
+#else
+static inline int tcpm_get_by_usb_controller(struct udevice *usb_dev,
+					     struct udevice **devp)
+{
+	return -ENODEV;
+}
+
+static inline int tcpm_poll_until_settled(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+#endif
+
 int tcpm_get_pd_rev(struct udevice *dev);
 int tcpm_get_current(struct udevice *dev);
 int tcpm_get_voltage(struct udevice *dev);

-- 
2.34.1

