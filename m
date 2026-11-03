Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBE606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cPbkHbhk;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eDTYpLow;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cZhVt2gh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 281DB6077D;
	Tue,  3 Nov 2026 13:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCboeradAmYm; Tue,  3 Nov 2026 13:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EB97607B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713465;
	b=swlA3aGkvaEE1/Rl/FTwRnWw023w+9NgYOCete/nvZKMsYqofhGG5zQrg4psVNWoNVfD
	 Xf9nIpQPX3UTxUz+bgIY/LM9O7eYjUpXmITpR9O3BYRBKaXgFePCXYHr4oD0ONS6K7dqV
	 I+zYnKh4qLN0LTz237Bx6XK0CWmADnjsu0sBGu6lok9JKSsT45Ulg12atupFPs8vcE19z
	 i5vrjx1V24TJs7P7JO/+iKDWNxcZC+TXBO6NswqQZcOv4rkolX/vKMNAtYkBIzThdNXPe
	 coUUkzZy7OwKuoz8AwNAfc056oT2LvPVMyMm+Gtze3GcMVj4HH6cUZ0xABUxDO1ED7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	b=NUaup0ZhCSHEPSB5Y3Bl1hADrFLh6WmJsyfIeRuTraZW/MjRyJVh7u8ndYGhsDPuTgal
	 +yMBuhy6m6TS2Snp7/4u8Su5dNI21jgNFrV+c5h86ltORJ9/QtGypl6pABVf8mOfNjIkE
	 XdnpjeIB8lDoyxfR7LYv3Wg1wBhM+mTbN1yCksO3YRCmGxdRpesgreEJhmirPzmmcU0ZE
	 FlSvkwtmIprvamGGdcP/KisXrDuS2k+uCMWBuZBSCNkMcANpEmoUonoe4ZibGiBL8yUbM
	 goUO8h7CVLq3PSK81l/jv0vCVc+xTzc1dDPRjitRQVasOrgxRyDkdxiWCzwmjSuS/Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713465;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPbkHbhkyhCnk2rGi/CdhcMrO5AuOs1KzJ7pGyFOtisp0UqJ4ReXa1gaTW87joZE/
	 X957RMEh30yazvTYGssHbPYTjseylO6ZY00xLK2eRAJ5qkCLqGdTO/BM1IoCD9BRF6
	 wf3wbwoI2ohyo+wIJoGD8Pjn4tMX1Nu5mKfYtHxEa1c5L7in7C2xXIbs5Et89LcGSp
	 yRkYmbk1zYKFoTGLLrcdktRD1RFaeEETrKYVsXzuempbM6H5Uq2rZ8b8FnP9XiNR6C
	 0vIzWiENg2QeUlWrO+PgBF1IhgT3vWFU6cLp+Vpo8cumRBOI2n6m7Fmd3I2ArRHb7y
	 UR3SS58B7fgww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EB97607B3;
	Tue,  3 Nov 2026 13:44:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69AB64BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A8DF80C88
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_ODkn9R0d4I for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B880B80BCF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713462;
 b=sqs/BDZgpbqDNOnAzLsesL2weo4B+YW0Ma1ffbk/C8v4sp6NRXVvANWQOkS1NCCJCchO
 C1k8ydJcVe6zNoaws9+ww+nAz7GnrXXJXBk9mSmL+zIz5/bQyM9ROuWspQH/s/NCs1ju1
 Sm3qLz7q4uoJY86X9WKqUXWWOReWublzYTscLJK/cRehRTTeydj8vXlDp6Idc7xUdLK47
 UXeUyzKB8w/FB8s0NBncMIbUGn0lBpV3eib2V3SfdNVX2pc+eD/txcdlIzJnYNIt1ADIm
 YvLjaoCN/A72HlXKdbHux0g3Z/mHBQWLiD9e61Vi6ZAhZWA5j1rEnIqXj56eSReTH8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713462;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=J/rsfzk+8sym7p9bwDnIfS6LpLhmH74FwDOD30PAMd2cdFaLEJT91s9Csjo1dabkVSom
 TDn0GVzoU25o+/1SIIwv+o4EXj/OkRBlfvNdKfR7jsmuM6FybIauDtvLcxst3YTl/j9wu
 ER3y3kWURV/KckJmF3D0gFEp7VGAvvI0Dd/B/eMB+PvDCUOGy2s72aTjmccOz8Sj34Ss8
 9lcTA8h2SANE06PQbuyf5FRi3mOLbnnrisl3Vj8S/t9mVD/zgUnpygtRNFyEZOmPTb6Pk
 yMKsLY+jywq8eIaXj8vOWS3JZ3DlCO5jQu5pDFZN8iPTGoXp/6m6eZepPcBPfzE2QRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eDTYpLow; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cZhVt2gh; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=eDTYpLow; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cZhVt2gh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B880B80BCF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZhhL2449941
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EAbXaIYHumc
 IwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=; b=eDTYpLowjrp0idBIpqW05FYbKzj
 wyxBnSqcxAkicxCqPWrG2wE1XU8ej7fnQZcnLbwGzmw/iIYktr6M+TO053gT3IE4
 /v6OoQXyRWxf/HW5ogdMqkyatWFA3CI/4ppwyrqApar8iMwOjD3pes3ro/qPifop
 EzyKTzHG11yI/iB39m/2rP+W/AVgxbM7iowq7xnHjPwgwdEwQM+yT9El3s7kSbvz
 7taTkoxqusyZ2GhzRo3rP+RzlDIyISfBkal2cS4gtB37Rjdi5HlWntMo7sKN+Wi/
 Rz/JuP5dOuE7EFrzw7+NZYe+98hWfX88pOksY+rTHpBlX8fSfw5NxHlbKPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yct8d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36c9e87d262so125110eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713460; x=1794318260;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=cZhVt2ghixwROiUOWBGea/krjJUJv1TD/IGkomvmEHvo1y1m8fXG2Y/U5CSCu6DE9o
 NhKmOIlNcBtc2j1wv07+HB2zv/Mz3RSk9mrsiZwG6gWL6URHoI08nFlnKcn2fOsS4ezl
 DGARdbDGbAnvRunWHe0niOp8+L0bu3q1uzya2Zy+DVxtjTlS2jZ5eCuQBukJD/jFhn2T
 odCKD8aY3rUxGO8hVK8qpEPkrCIhcAfS7wpXtVwkEErMy+N1X1LOqxa3UzKENe6aZ4iu
 1bWZc7ifAzN+exyV4gWkYmJfPtk15DtzfMRUGIv2rOk+p8cRTSdjBtAmsHYg/H0iltTB
 9ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713460; x=1794318260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=hAyse69XCSQ/2tBGN+ePBaQMITqBDkOb991P0C2Utb8+qYzTZpCoiawtoU6l/d0IPz
 Mn5o2fDg60h3HShroYgRcbpcchFAyJcXcIP7aNp+Tv8zfu1ZYbboN8bd6s2NoPB9NG7I
 w69sjkSQeAmqdBPNB+hCXj+Fvj81wYzubQFa/QNSh4hS+Oq7DkM17H4omJKZRXhk83jj
 GSR44JsWMdGD2iOYAKz1/VlQFY62zk5qJZfJ9UV2xVb4dkfH4H49qAzRm6Gfw5t/eJxa
 yh3CMUrWLoI8uQe1biNOOZJ+3YnVNhqNxOBLHWRhSKpEsh/kXOAq9OOrKfQCUSG6A560
 Mn3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvpVvhaIGaJpDJHwMmtiYDNOOTfeNonELaUy5YOMlGW+xTnjISZ9FSjQVJMAn7WqRcNe87+2E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ECxj9k3DB3SusIRMly20vHyHAx53BxJ4WGunBolStVm8lqTS/
 oZDi0ITsxCnxqDs3cT2eG/mREBlOQBhpV4GWhgJTEszvFhfTYGBIlMusZ4bHRXlrho4P2Q0Kx18
 8RqxCDdaIMoPbt/V6dGe2NXQecr5JVfGwJSkMpVYd/xKkLxP/c9QgKQRrneo0bvitCNAosrk=
X-Gm-Gg: AYBFou1pwaAHUHYM5u3/ZmtRu0ilbRGHqbIq+5kXOug64QkeHSTzEXZNJoJl0fouKNl
 mZOAu79aKr5prwesMOx9Ag/U7Bivg9GkrQUVB/G5PutRE+he7jyCvQ/031nL+wH8iOiUEpgMzL2
 x+ljpm/ztiF3Vuw2kYt9xbVfcDqeJZ4lblKfxTtAGH9guhGeXHWYCdxzsr5wTby++qOzKEpQahY
 k41G0UVrdNSE8dxjzyl2Hjt4D9gYt3aiNvNLmSUYpXXqzI/52hQlrZQSx2dc3KztTTsw2CSGReg
 AHegonD3k6aPk9nUxyu1UIKcC3VA3+CNiC7AsH/Uxtc0d04vM2sJrm+kmwvVXBNssKgRLvOfibH
 UxQIUiAWIYl3GYMhJNVYiOGHskRuQlDPNG6Eu5ALnPcqzQ8LApwVOhwJQE9Cw5L+p2/AJkdiwg+
 UP+eyljDfQEds/Ia1aQns35EbPwenk8n59s2Ev5CW+YEwhqfZWFUIXlhogLsJJ+uUWe6oA
X-Received: by 2002:a05:7023:d09:b0:1a4:4194:fc04 with SMTP id
 a92af1059eb24-1ac5e320bd8mr19238693c88.28.1793713459820; 
 Tue, 03 Nov 2026 05:44:19 -0800 (PST)
X-Received: by 2002:a05:7023:d09:b0:1a4:4194:fc04 with SMTP id
 a92af1059eb24-1ac5e320bd8mr19238642c88.28.1793713459085; 
 Tue, 03 Nov 2026 05:44:19 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:18 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 3/9] phy: qcom: qusb2: add Shikra PHY configuration
Date: Tue,  3 Nov 2026 19:13:45 +0530
Message-Id: <20261103134351.3532864-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9e534 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qtZHeC2-AEtKh8AW8voA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: wCcCCJTJ8L0U5sA2hUkIHaVfsYuANFel
X-Proofpoint-GUID: wCcCCJTJ8L0U5sA2hUkIHaVfsYuANFel
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXxs6HtSG82A0D
 +KFpJAN4q5wJ6K060jWIdHhlGOJ0r0RaSVMBMX2b+8/Jqel6QJ1XAN7GaE8qyMqmeggKzchoGAS
 i1X5quAp6waz/s5p4DrmRCOOP9Ck95ZEe8s4SF2aswCe3l0jtseFcXk98NaBl2UroVDoIHU31Bb
 IsKcL0LABOFop1A6s1EK/xHGck7EjdFALS9WJBLUYrZo3Az6cAPCB2+oly6vpPV+c7BCVp6NeY5
 0d/XMmqyv5a5WFU94COZ71ga4O2t6rcfq84D4MxSRP4nL+sPAcewSBZrkwL7qmFHH1G2igd2FAi
 kWOAAIGhMOlqxT8skW5G9hEYQwnkI4GTb1vHY8I4kXF49nZCAl0CqMrStC6zcONsmfXRI9u0Gi6
 cvXjNbAgAflX4of2TT6tw80/bW7aqDpPm5y2PUJZTr/UWaSVCDO1e26UZDh6BzsB5+9wYCtyUQa
 YTh2h4nPQGCeROnORQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX65YjqtFGRh8q
 TIt+Td8i8qEaa/1DowBlg5amNW5Z05k8zHTyhxy1Hhm3wNEYGvxhc3D6T+UT1TT8WM1YZ4kiPt+
 nMLwbi4+nTHiK887GIZzLpwJUqyUjpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
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

Add support for the "qcom,shikra-qusb2-phy" compatible by introducing
the required PHY configuration data and binding it to the QUSB2 PHY
driver.

This allows USB2 PHY initialization on Qualcomm Shikra platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 6278171b100..f5214bffc52 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -310,6 +310,18 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
+static const struct qusb2_phy_cfg shikra_phy_cfg = {
+	.tbl = qcs615_init_tbl,
+	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
+	.regs = ipq6018_regs_layout,
+
+	.has_pll_test = true,
+	.se_clk_scheme_default = true,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
 /**
  * struct qusb2_phy - structure holding qusb2 phy attributes
  *
@@ -505,6 +517,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qcs615-qusb2-phy",
 	  .data = (ulong)&qcs615_phy_cfg },
+	{ .compatible = "qcom,shikra-qusb2-phy",
+	  .data = (ulong)&shikra_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
-- 
2.34.1

