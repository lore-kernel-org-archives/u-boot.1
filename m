Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87E606A32E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PlRiRW2E;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kt/syqXQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bJTphyH3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C853813EC;
	Fri, 23 Oct 2026 15:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EK-lwQYBTQZd; Fri, 23 Oct 2026 15:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CE2C813D5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768324;
	b=k4GV72nwMoil5UbxohoA9mqpJ5flmggH6wqyT4ksMXXVSoSLVqzBou4uuqm/92J2uenp
	 DOTLHW0J9HgUhLm9ZXVPbcgVst3to9bTGG0BndB1Y4fuYJOcX0t9PI8FAWEMqymxQvjOi
	 TTa/WINz/vQN/t2/FUAPq58dU9Hy0kaqSQggmd7h751sKTpZ1JTCbsL/wOge5vse+yspV
	 g4CB6JOCmB9yThMvzngBRh8xuvi8zp4mh8+F1g1MsX61rqJZGV1YUgEF5/LTDYMnF0gad
	 kln3rmkTKeS+J2lNIy9ftRPXVG1M0wb74NkwEEaShKZ/4g2KeyY6SwI1JF5ciCsBeeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	b=pG9SwvvjF19yiBZB3d64s4iOgAa9eV0J+LFOsZs/lpsqPLc6Yyx2wN+8jgBD5RRqWYbp
	 tj9Y/3/uftKZVk/mtZvHFX/kqnFMIs3UrmWSklJ3liEsaZ38Nig7dlgEe0vAniwZOw1bo
	 q0cqMhhh7OJeeHIm5ymIZMRYhht5C9ALIvktatbgOlOgfbjW8s/G+kAJBEExRos2BX8FQ
	 OSaeG7JKJcYIvbtXOqVvUNrX9Mds6i4p/VVNQbD/K/iljtyrcHhVgkqRaH1RFFlTblO23
	 EluNoRrTcl4TwwoEB7kArNnhpHcrfxSk09MHnRK0ClGS+/v1CjAdcI0i9uFIWX5KFfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768324;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PlRiRW2EWacEM1SFnRyf0rQJpkQRGnwMXeuhilDv5Ay03mLUdECGyKOxyjXfmlRcS
	 /4WcFKD1vBZ10U0lzFat064kKebZNKjJ7PIiN6RUy6LSKZYYxuCt5k0/CE/mgIPhn9
	 Y3NvuuvqWoQ+reAsh8QyK24PXYLiTqUFeU0oWguS2+HrbuU3hZXmDynZAZIUQpWcMu
	 aMboXC7ZR1QPsKa+nySOAusfb/9pKbjXAnbV1WcQbo5Op6w/gtLYWcZzolq2Lw0GqV
	 hgScN5Gytd2jDPPjgZ1KRzGd334BxRne3jhtSL75uGIbcaK98j5SrvJEx/tcbe8EJ5
	 xb1gC9My8nesg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CE2C813D5;
	Fri, 23 Oct 2026 15:12:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E40CC12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C656B4097D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wc_yypzDD3qe for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E228E409D5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768321;
 b=COR95r5eqihg3dDkUVTdgPlSLOIag7jAffa9jcXadUC17IUOHdw5BsoLOP+IUYcl+Et9
 eoewCCMToyRCebDUcBUUvPKS+sN1mrf93NZHLgS3Czu3/WWJSY1DL3qycUYVvI+TgObq+
 2LohcseYrwJgSLvcc7ClNO7rY7ck8RkUqlmvGFce/FHaayjjpYPuo7L4gycMSIb1hz7HN
 Rxa+zMWv5bGu6/2MxR992OW3aa6hv/zwAWE6adboDpdr8eiyRb2vauK3Y7DOAWZxpEvKp
 +k1sISwwFuqUZAmEEBgzRRNfFJ8c3mOTDJi+bQh7Vr680NmziuH+J60Iib3hMN2q9OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768321;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=haAi5AjqZaPHFpJAFluEitqSMpIgjHfyU1F+4ZTSNGoHh4DgF+FASALuJz3lokl7ehuP
 4zCSfHQL6dNHwauCF3lX1eyZVifHKKTK0//4mPQC6yZek+ATm9qRySFokqopU1gOEpikG
 mDFlA8X60ycOCAq2iCBbnu50GTQnqZmj41nwJL7DxtJTX9rEogrlBNfcDm2oeYcnqejWC
 MNuI4jbrspG+X+acZD9EPBVdr/j2puIlepS2D16Zm1QFkdd/ly3SJTb03c8Fa/Qs7ZkWB
 a+FVt5l/C7TmGTAlD5dOLDSRzeqxqM2aUpHXgfD0vkE5soz2R9pu2Q6v1KzPJBU7cKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="kt/syqXQ"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bJTphyH3; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kt/syqXQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bJTphyH3
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E228E409D5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Dde1955148
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=; b=kt/syqXQ02JmIj4O
 6lzbs9Q37NRxxV2fnSU3sdfEqOhEMJTe0CtZjMQjcxUDwb8fo6RGCwXClIBAEXJI
 N1Cl2zaCsX2fXV2RoI6KZaNa2F5HjzvUROZkY51x+UxtoL73noLwQawawMhRPpAV
 XDFh4ucOHtMDZhnKgg3vsKXKXJlw1xeVzQPOcs8fWrljx1GDITZm5elCYWXUGfvi
 /y/6475sXg9W5AIjzK3Rm/QyEsdx0wQPivW+daOzIUfoKe92rdVmvrlLVhrrtPtJ
 p7aEYVhPnDNmnMgmT7ImQGl6izb+9oCSep6CTw/ktIe6Ywhm0SK9gCKANcFXF8wu
 6pmQiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbm9jv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf6c528aso156933685a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768313; x=1793373113;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=bJTphyH39vSudAVkA5N7niF3mU1sXbvSi0X68HTdSTn8XMy8MOrdv5mW73/qcBElY7
 O3Az6idXGuCGL12LPrQreTeaS2giYm7NPbGxJ+yBgqfWQWSi3Ze5lUCe9W8OlpRBw4Nl
 0yMJykscRuy+s6I/TFPVDpfZtyh8mkVhrbkpWEF6AyzGXoojUqLw9ZLaUhD9nBq/qC/c
 X3ooXqlSsae6VzxQM+025MXwSgo/beZs7+iUqwtQY+9i0bv8FZAVXb17LxzNJGoBl8Cc
 9gvjoFBZZoV8mfDH3HYXSHbXP6nLO7WK70WtrvyPOWGs6ukXl7QdS/dA0mrqgHZKZ0j/
 e8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768313; x=1793373113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=vPXL1Rm127dwyIuQqzXubLWf+D0i+Qv1HXYQPc9pu7JRzN672Wc4SXIyPrm2VShXNo
 YnVKhTaCSChE/ZA8ShlK++7EflIcJpAY6T2LGeq4IifGsPZaIaWCQHRRwNcyAVKDEt19
 WGBjQbOUnl0eXkVRRv6DYy/Vt/24Tremxc7jOth5BRWzM96ibuYMdrN9e/L3bSlmkIzV
 x832jkWsHJIF95KUdaT1+n57cQTkwsl2b2/+wc0A56uC8tB7WINtSm7O6wv14or2HWTa
 538nLbVioT+NYF4ImhdUgFodrgWG4xfrp9/RRVPNEQF7BjNUnm2A5mvD2XX87NYgnxVK
 q/KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5wyOF40p1Y31CO/2Tpv+QtPXWTtVltqHkzMBFrqiLcmaqZe6y8UqkQfpV2Ki+SEHKGPu21MI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYImKQwY5wNr4aD3plcdxQbLsoY6PnWgijOAP2W1aZKrkFM8sYll
 doxy++6LtknAKv3AVIBCkBHqF+EutF/GZ90usQ2E5obI2SliP+GNX2lMvE1RLqhZB2LPNbs9VwK
 ZjFRqy1snk5N5imFdeep2FRVw8/IEeMBGtiBH54CdNfAOLtDxDfm+55nLJfDfUTBAj1FkZ/A=
X-Gm-Gg: AYBFou0wgM8ejT0sJ93AhaYkzZsfIFDmBkCcWiYWS1kE0WVUmTSKa7D0zaAhOA79nVJ
 bK54YOwUz5UjwikEAqDUsOUdBu3ZSO6cWCiCx34/I3Wj4oyDf9ZgKs08JfMd2m4lNaa7XsXAvi6
 HC3YD4BGkNnFihQTmgU4KkJ++jlRODPnNcVKn5ddtjMoBjjXdO/ohvG+FsKEGOexSOwDeePdZi6
 K6ta3VxA0TY94wzwRVZ12CPg7v6fbMo+/v8L50Zf+6Ib3p9WhIjTJIbi9Bxnnm+ti8NEFGYpEsH
 nRnm5cN5xbs+e5ND+T29oVDMf1/JrgENupbQMzJ7z0/d6u4wpuFjyNSwndDSsOXvPw2BHCR8G3k
 KBeK16z4/0DZcA8tBOAO3QdMPVMg2Vtqoc6WfGNJ1kUEcH1o=
X-Received: by 2002:a05:620a:8905:b0:93f:5593:574e with SMTP id
 af79cd13be357-93f6f91df0fmr460256285a.23.1792768313249; 
 Fri, 23 Oct 2026 08:11:53 -0700 (PDT)
X-Received: by 2002:a05:620a:8905:b0:93f:5593:574e with SMTP id
 af79cd13be357-93f6f91df0fmr460251485a.23.1792768312761; 
 Fri, 23 Oct 2026 08:11:52 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:51 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:11:41 +0200
Subject: [PATCH v5 2/5] cmd: avb: add lock/unlock commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-2-6453a6f63028@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXzyj/BwgyqpHM
 iZ0Wrx5eqB8POJkLj9HZIw6g2u+Mvlgfup7CcayyMoQaI1kRQQiTyqZzhjMmZzFAwN3tHAGaBMx
 F2wcJU660+iWLxFoCiX+cZbEGk70cic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXy4BUf8zfsZyt
 M/1Zbhw4bdZc8e/ccQ3T1mJytPJqkSO8baDm1t4myJ2J1xPAxHThwmKdrvA/inBk+msG9VqqPQr
 QbkpuBxjnjjJePXZSAJpRXRZfCrWPKQ41SyAZiDyaTiKPcTUxsbFJRrkcOBVQ/KuYHs+/WuUl0i
 mpbCjPnAN3mONfb6zAgw5ppJiA1ZMvK/ytvGjDm4/HPSa42a9wq3kefvW1V6hbEXgEUndT8Rg3l
 l3PYZ8hB7S5xInSy6sKmbvVEsR+QKWKONDf4ht2ZS3oAvr56QDRzYDCsD5ZOHlpdS+2/lx97Cus
 8GNval3eADndEttUlP4ijwNkz2nLPewgY2cxrNS6PuV77qeMp2ywZKIves/0KsCcXpZ2d80n6A+
 4m9xybLQbXn1fWRSPRgdqhM3nnytCkdizFmOO8o8nk2BVUK3/fXXATmEhdlCdg5D5fnJ7x6Y7tQ
 CrFyQrRRjhM/SZgdUSw==
X-Proofpoint-ORIG-GUID: 6MLK-CLvPYE-AkwO8cDZ7aBpqAT9gvF7
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb793f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 6MLK-CLvPYE-AkwO8cDZ7aBpqAT9gvF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
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

The OP-TEE AVB TA stores the device lock state
(TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
device backed by the TA could never leave the unlocked (orange) state from
the bootloader. Add avb lock and avb unlock, which set the state through a
new avb_write_lock_state() helper. As documented by the TA, changing the
state resets all rollback indexes.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 23 +++++++++++++++++++++++
 include/avb_verify.h |  3 +++
 3 files changed, 66 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 3c13d6a2cb2..8e0ab0eff06 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -534,6 +534,41 @@ int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+#ifdef CONFIG_OPTEE_TA_AVB
+static int avb_set_lock(bool locked)
+{
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = avb_write_lock_state(avb_ops, locked);
+	if (ret != AVB_IO_RESULT_OK) {
+		printf("Failed to %s the device, err = %d\n",
+		       locked ? "lock" : "unlock", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Device %s, rollback indexes reset\n",
+	       locked ? "locked" : "unlocked");
+
+	return CMD_RET_SUCCESS;
+}
+
+int do_avb_lock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return avb_set_lock(true);
+}
+
+int do_avb_unlock(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	return avb_set_lock(false);
+}
+#endif
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -549,6 +584,8 @@ static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(lock, 1, 0, do_avb_lock, "", ""),
+	U_BOOT_CMD_MKENT(unlock, 1, 0, do_avb_unlock, "", ""),
 #endif
 };
 
@@ -592,6 +629,9 @@ U_BOOT_CMD(
 	"    and print it as hex\n"
 	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
 	"    string to persistent value <name>\n"
+	"avb lock - lock the device (verification errors stop the boot);\n"
+	"    resets all rollback indexes\n"
+	"avb unlock - unlock the device; resets all rollback indexes\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 227b2d22465..7b60be4da7a 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1080,6 +1080,29 @@ free_name:
 }
 #endif
 
+#ifdef CONFIG_OPTEE_TA_AVB
+/**
+ * avb_write_lock_state() - sets the device lock state in the AVB TA
+ *
+ * @ops: contains AvbOps handlers
+ * @locked: true to lock the device, false to unlock it
+ *
+ * Changing the lock state resets all rollback indexes in the TA.
+ *
+ * Return: AVB_IO_RESULT_OK or an AvbIOResult error
+ */
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
+{
+	struct tee_param param = {
+		.attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = locked,
+	};
+
+	return invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1,
+			   &param);
+}
+#endif
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 6dbbb39a8a3..e89bb229e02 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -45,6 +45,9 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+#ifdef CONFIG_OPTEE_TA_AVB
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
+#endif
 void avb_ops_free(AvbOps *ops);
 
 /**

-- 
2.53.0

