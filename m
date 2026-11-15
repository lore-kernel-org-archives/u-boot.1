Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00A606A338
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j0ozHfTs;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dm3LJ9UK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qzi+NPNy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC1F60739;
	Sun, 15 Nov 2026 06:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3q0YNy_elKs; Sun, 15 Nov 2026 06:26:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2731160709
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724016;
	b=ldvh8ikSRar1lfCMosK4+JofBAPCICGAXjD5EgH6g89qn5GQlEN1P7Su1H8DU8VNfrLt
	 pvjDS9KTLRyjbCe0LtHbaUvd5LYhJyUUYG5MKooeQGum671UlORSG4AGU5kJ6S1fVByCR
	 GVs5ivfXnzhxJSkBtClq4j+NkGX7PBV98Ddbwo+q6rFbdBa/1kEbzRfK1Ik5UpspxRWCD
	 fnOmkXcT+5H5GzJU4KAceZhzglBiCS14kivZRgDb/EvYBegYRpkmlG6yEYG6UAAO8Jlo4
	 Y2QGO/RXCCdyr1swZs7CuiaOl8mJt/ihw6lRzUaMQY2l8EEROU+tApLRwOs+JpArDWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/rSPpoK2Mpx8g3ElJ3mbcrHTfbYy2is/6spOPG0yvGk=;
	b=nVd0ldqHunHXd7/uAEMkYcvoZ5TTc+jhuLg0kgPc04o6fcbUlTk3bl2IuyYtMG6euMHk
	 YKcxk6f0/4zMcc7h/F1Lqu2YGhPIDCtdkb2DIdWqUmpEIp1qkPVpcW058SVm24zfjyiT9
	 yNRRh+xHkTOEeEDUCh7OU9fps4yDlN9Wh68ZqxwGeAAYZAhN/TqG5MjOB2DL3XW6JIgZP
	 SX4m6M3D9JW6hvdYRT0ir2QmxWwOpHm20Rjs4Mg2xWeZKN+sl518Qu3CjnWIpJ8ntKV6r
	 Hp581lgK6MnoZBssRtaD512eS/IEwQPwtaWOMPOItgH2xkyMTKPYqkycdabsYPkIDeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dm3LJ9UK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qzi+NPNy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724016;
	bh=/rSPpoK2Mpx8g3ElJ3mbcrHTfbYy2is/6spOPG0yvGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0ozHfTsHClvqpdrqYx5z0rKFisUqAWcANYY7+nzsrtudz0p0Y9p5n7wKMItr9kY5
	 tds2/50SaetEUzYC5tVMckSBL+MevxHMOY0ESAK003tmkh56yNOqOReT12BV8p1QSV
	 wg62aPZVc2P+6VAxFq67JYs/jsIGeA5Moit+iFOV9jZIkU+FhRlmCieNeaI+NAIN51
	 WSjszzCVVsKICTKXNCHp8ePVNNeT7DCO8CU0nMaW/cGqog57fwwjkNCD3uLRlTAh06
	 fRdCGFLd27EE7MA8RtgaiseV3U7EN4kfOsVDSOn5iUqb7qA0yRE6yLdaUkQjaHWgTO
	 0SiWtrbqsHfVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2731160709;
	Sun, 15 Nov 2026 06:26:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4230D2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34018606C0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hf0KcPh8hzPA for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EB346071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Dm3LJ9UK; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qzi+NPNy
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EB346071D
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4SEdV3353045
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /rSPpoK2Mpx8g3ElJ3mbcrHTfbYy2is/6spOPG0yvGk=; b=Dm3LJ9UK+L2DGYDs
 vZKEvYzoAPuamH6/Qb8FI471wcEPNI78q3WbIFUpi8K0+0zhOavprjMWugIq4gH+
 io1AAVrznXwpRxaYwr1qVxibXnoztR56G+KdpLkHcpp2appFZyK3DN/967vxuEb+
 bmo3wi/2fFB2O64QNpdqW8AfWDYOBO4OYENxApKvExFqTPEAVxb3B2GgXWPqdqF5
 09PxaUzPLt4tBIv7MGPOrEGlSTavkI34vDeW5W7oQbvQ6FGHgURfUt5U8YW+SkYa
 K1EJPzJQq46H1d9At1nLXJpJzMOamr2qc1qQBLw395o/vJZ33Qt42VUM8LtM1xzb
 dvg/NA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8tbhv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so3769708eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794724011; x=1795328811;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/rSPpoK2Mpx8g3ElJ3mbcrHTfbYy2is/6spOPG0yvGk=;
 b=Qzi+NPNyvOMXgo6ZtyCtOyzcvYcKY1PN3rrcrnoSz6qtFEPs5ptJHmnS+MwoFBSXUF
 eX71IPdQUw5nMOMCeT+tTVFMnUgANI0PH0/uolgVmoHoPP3Dh7XXC4hkTvstV8KG4oBm
 Hg6440HCqfi9Y7fYl4VbFSP3HIZ6MAZnvA1+4IcVxkoGreCyf+bvNErso2UGf3/dDupa
 EnGgpRE99eCEqfiwC/xf39rZGAk0AyRWNo0Un3Hqx2/HXJ96QNAGFtX89x5YPTzDaAqg
 PehWe709VukzSG1XPsTn/GEWHx3lAHvdwIpGHeiiIEVGZF+J226E+KraLgRwFC1UUIAv
 uv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794724011; x=1795328811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/rSPpoK2Mpx8g3ElJ3mbcrHTfbYy2is/6spOPG0yvGk=;
 b=HOu2rpyZgiZ37WxEuspf2eyR9WPj/10l6zOZSwFmfSsVOEF/CxlQIIdFjYcNpbyIwi
 eZtpPnDucNcWZ+veSKqGkeVnwMo++FEX5bsW41jo4WnfmRiJHQIyMOz1T96NVCbjOkmH
 uPOQ+ITKTUJOJjbqhza7uqNKUApKOuJ35Jhk3wAELfXn9wQceAyzWCaMGfSzipPY2meQ
 Bm8QXjI2ZoSv414mqyRqZYu5K8/wSBo68dWZ1MDnxMoWYJ4j4wLQiXKPADwOCZTx/Hs8
 Xsba4WxC4LCw/YYT3/itJ0RZb9VV+bGwMrXPoWOOOqi48PELT+aBbmEhafDuO330AuNL
 vxuw==
X-Gm-Message-State: APuU4Z/naLA/IMpQcD2fjAvWKH3suJJjpQ/aC4bGymHXOnZu3opuf3yD
 mj2cIZ+WXQwpoKi1ZrkXnwLfZ8i6W/NisSNQUbqrncBxk4QR8fcH7OTmvPXH0EVvHQ6Fyg4xx7O
 czwlKi6fuMAroX/CtwbP1GcF6fU2hutLzNrhjNuByqnLQz4e3W79rkxVMsFSsKI6cPrvaAk0=
X-Gm-Gg: AYBFou1CsL8ZZ8eomiZaFz70eArSPFpom/duYLWcmQzGFjNJ23G8O1kQmT13shnEE1i
 yW6ZRpl/0VNiirkh2omcVrf03EwYRH+RYXIFM8DCyGbohPWb4zCIE1bEbdkbKTwBr00L8dqxWfx
 cQfNfhwe/UtIqMFQ/rFCDr2MYaZDT7XQHxZQ/mj5jofyBCX76zC4j4DIqPcQCePYMDeVZpl4q6W
 IoRgIFn0uZ7tTRduS7QdD+4J0wesH6/HhcmNbvLPbyS6A1u0yAUcVaie4ETDncgHPFRVSKK3HcU
 Ovwp1yxZbG/24sjNP794bmKaT76if5EpU29yYS+O8AjB1m7J33GWSTtm9yXMXhHi1gtTIL2qane
 QExwlUCwxaXXsBVlXC22TNvAp8+DqYsUJjkGZm/13TL44W12lbviIuK6DscYFv+w/B6Ccozb8Q+
 Erz5C6bVxMPCKVl1Z56B24R/K3q3niDIeuA99lw/VD1oGF40NTaF8w+BOVB79lFeW7kqRaMiYNA
 Rng
X-Received: by 2002:a05:7022:1701:b0:1b3:9b4d:85f3 with SMTP id
 a92af1059eb24-1b5030ffe36mr6634548c88.19.1794724010335; 
 Sat, 14 Nov 2026 22:26:50 -0800 (PST)
X-Received: by 2002:a05:7022:1701:b0:1b3:9b4d:85f3 with SMTP id
 a92af1059eb24-1b5030ffe36mr6634522c88.19.1794724009798; 
 Sat, 14 Nov 2026 22:26:49 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:49 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:07 +0530
Subject: [PATCH v5 5/8] env: scsi: Add partition type GUID support and
 choice-based selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-5-79e76209457b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=4943;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=OJ0qCTCOIdh69IkqX1pRof6Z26JtSFikuIbaWiVf7KI=;
 b=Tl4aDw3ce4wnbWZL1OItie9WOgadr0bLtiPRrV6KIxKddG6wT7r6Ruq5A3HI5Ju8Tnjm4m8m7
 n74+A9Lcq/4D4Sh986P3T9vMuwfKAjZ+GWiWk5gnvYoPRkDnCL8z6BT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af950ab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=UtjBXWsYNgS_f0zzo0EA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX3nQGH5bTdTSi
 LPTGAWn0T31atxg+EqOrAcmYHwf/bXNJigloAlIfw1PHqWDregOQ+kUnL0Do0Ob1xqO0KXYHX+l
 0ROOqUiH+eX+qB8kPXHq/wpmFhTR8dc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX0yOhYs3bORRr
 cAUqHPcezE8mszVAwQdP4fBwu1n13SuuyrpmONnRV9qxLZLuwQLzu1zPWDb+9ir1XATkLz4cxBt
 poEtMceerKhmrHKcIZZFs9yp2z0zFmQ0LVOKqiGTttMifmOcC3NjW5Ahk+/AHI90IQp0nDSPeX3
 xbDqtcnzB9X/Q7L7jygT5Mux1j7IvJrvA70r8g7j3MBiTAra+WWvacqfTkvfFgs6P1AtgRnLDzX
 wDaUlfUzRXfZVhT/Xgci/PirK8zodNitTU9Visb5WSQyEjAwVUtpaogqZPivhK9m4Ri3gXkkUDi
 /unlj0z+I7TZggddcJEi+jrAM/uBzJ0NWhZc2vUwy+QDKCR5P/3/rDss0LzfqFM4+sSmfjT1hPQ
 Flfc0PEuumq9mLnHbG8LBwXaayKcx/b4OxEC68xMQzaGzeJBY9WoCEYdAv4mENGsU7/poOJjcRD
 zQSsHSzW+YgrqKkPzAQ==
X-Proofpoint-ORIG-GUID: HmEw3UQemxPjAzlJeBgvOyuB0kNlZ9tT
X-Proofpoint-GUID: HmEw3UQemxPjAzlJeBgvOyuB0kNlZ9tT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611150025
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

Add support for locating SCSI environment partition using GPT type
GUID.

Introduce a Kconfig choice statement to select between three
mutually exclusive partition lookup methods: UUID-based (default),
type GUID-based, and hardware partition number.

Reorganize existing configs to depend on their respective choice
options. Update ENV_IS_IN_SCSI help text to document the
new configuration structure.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Expand the help text of the partition selection choice

Changes in v4:
 - Has only changes related to introducing choice configs

Changes in v3:
- Introduce a new choice config: ENV_SCSI_PART_USE_HW for
  ENV_SCSI_HW_PARTITION
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs

Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
---
 env/Kconfig | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 5df86028907..b36ab26ec07 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -322,16 +322,20 @@ config ENV_IS_IN_SCSI
 	  The size of the partition where the environment is stored in bytes. Must
 	  be a multiple of the partition block size.
 
-	  - CONFIG_ENV_SCSI_HW_PARTITION:
+	  The partition selection method is configured via a choice statement:
 
-	  Specifies which SCSI partition the environment is stored in. If not
-	  set, defaults to partition 0, the user area. Common values might be
-	  1 (first SCSI boot partition), 2 (second SCSI boot partition). Ignored
-	  if CONFIG_ENV_SCSI_PART_UUID is set to non-empty string.
+	  - ENV_SCSI_PART_USE_UUID: Use the partition's unique UUID to identify
+	    the SCSI partition for environment storage.
 
-	  - CONFIG_ENV_SCSI_PART_UUID:
+	  - ENV_SCSI_PART_USE_TYPE_GUID: Use the partition type GUID to identify
+	    the SCSI partition for environment storage. The first partition
+	    matching the specified type GUID will be used.
 
-	  UUID of the SCSI partition where the environment is stored.
+	  - ENV_SCSI_PART_USE_HW: Use the hardware device number to identify
+	    the SCSI device for environment storage. Specifies which SCSI
+	    partition the environment is stored in. If not set, defaults to
+	    partition 0, the user area. Common values might be 1 (first SCSI
+	    boot partition), 2 (second SCSI boot partition).
 
 
 config ENV_RANGE
@@ -823,9 +827,53 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+choice
+	prompt "SCSI partition selection method"
+	depends on ENV_IS_IN_SCSI
+	default ENV_SCSI_PART_USE_UUID
+	help
+	  Select the method to identify the SCSI partition for environment storage.
+	  The partition is then given by ENV_SCSI_PART_UUID, ENV_SCSI_PART_TYPE_GUID
+	  or ENV_SCSI_HW_PARTITION, depending on the method chosen.
+
+config ENV_SCSI_PART_USE_UUID
+	bool "Use partition UUID"
+	help
+	  Use the partition's unique UUID to identify the SCSI partition
+	  for environment storage.
+
+config ENV_SCSI_PART_USE_TYPE_GUID
+	bool "Use partition type GUID"
+	select PARTITION_TYPE_GUID
+	help
+	  Use the partition type GUID to identify the SCSI partition
+	  for environment storage. The first partition matching the
+	  specified type GUID will be used.
+
+config ENV_SCSI_PART_USE_HW
+	bool "Use hardware partition number"
+	help
+	  Use the hardware device number to identify the SCSI device
+	  for environment storage.
+
+endchoice
+
+config ENV_SCSI_PART_UUID
+	string "SCSI partition UUID for saving environment"
+	depends on ENV_SCSI_PART_USE_UUID
+	help
+	  UUID of the SCSI partition that you want to store the environment in.
+
+config ENV_SCSI_PART_TYPE_GUID
+	string "SCSI partition type GUID for saving environment"
+	depends on ENV_SCSI_PART_USE_TYPE_GUID
+	help
+	  Type GUID of the SCSI partition to store the environment in.
+	  Uses the first partition matching this type GUID.
+
 config ENV_SCSI_HW_PARTITION
 	string "SCSI hardware partition number"
-	depends on ENV_IS_IN_SCSI
+	depends on ENV_SCSI_PART_USE_HW
 	default "0"
 	help
 	  SCSI hardware partition device number on the platform where the
@@ -834,12 +882,6 @@ config ENV_SCSI_HW_PARTITION
 	  partition 0 or the first boot partition, which is 1 or some other defined
 	  partition.
 
-config ENV_SCSI_PART_UUID
-	string "SCSI partition UUID for saving environment"
-	depends on ENV_IS_IN_SCSI
-	help
-	  UUID of the SCSI partition that you want to store the environment in.
-
 config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	depends on !COMPILE_TEST

-- 
2.34.1

