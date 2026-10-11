Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419ACCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06AA680D73;
	Sun, 11 Oct 2026 14:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r285h4QQN4GX; Sun, 11 Oct 2026 14:39:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4649080E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729581;
	b=sWwoDL7UVW0QugY3385nM+KkpDDHie7ftFzDlu130ltzlDpJTMgn5p9wqohRxH3s6+vK
	 M7B1FrqG3of5VP0n7wAsR2ib/vzn1KNwIC8HG1Ham0uah/3TZAe+CpG+kydjEQl3pB2li
	 ebFyYDhxa4+Z7Z6elRRZgZ473ERyS4h1NmuI+pHd33acFn7x6bpGQMCnN3YjBwU85TuxL
	 OufYsnd5XZRINGZlnCWpkrimOnzl8yT55tfx++ue6yOUSJr6DAuzMI3tcWLu47SjFgNir
	 LQFE6ITiFr5McyeuWDxr3D6756CKpCZS6LJcOpvCoPlHgrCoKTUCqtRCVy+RpBAz55A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IIAajS9jf+NKB4dAHLDgcWIT5JahTsCG5lSxKbZZdBU=;
	b=Xza/+xeGpJ8Y5fkTeTBPlHZHVBCYpOWB3v8Pvl2TmYnIY4P9AwdY88Rbjyu62Ea0DJNL
	 6PHOpeth8uRTegHkyE+qSYhL8M8u7ZQLC0ZpVKXpgKojkKCo6xwuhHtIgWHRFNNFxyJDb
	 4NeTHDjdbmhT3vy22mmJGfZ8zZklkxNkTqVXrCaSlBcYhbebEH0wLoAN7a/AQ8EwQvZGk
	 N70/AFJuDuakvVArToCsUD504vVxvaIBbpcxbDBxA3cgQef6e0wGbQFlvIji9MaelTdte
	 80L2qbatRYSgGyL8rNMDtcpvJoTXCd5MTm6dvi9M5J7LkvdZ0pG6N1be6+XEY2+6bzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729581;
	bh=IIAajS9jf+NKB4dAHLDgcWIT5JahTsCG5lSxKbZZdBU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FiZkPxvTaSKgemYnRTbv1doTkRz4uXZWq+ifCbhoiylVnTeR5Mu3EIn9Ny+GTfCn+
	 ndW9eZy/jHj2BPCPC2fd/lArkaXhIlAZutw++RoyeHeSCwIfu96f6oexHzyfYEpaWZ
	 DoDznQ9ejsNM8kQCeCIgrAbvVxZ3tECipqepb+fu7SCuQ4nkYxvj/eoB3mozp4qpDy
	 1lAjKMdNOuCAhk7s1TJqsuKcXwg/6MMZN1VD1TzNT06VzTFNjKi/lxLdQhCgKAXzz7
	 Q6fJfsieMTqgu/TcnOs3ZwFasafPDRAD9nKNTGi1rtscD9w746IKLHA+HqLRjN7gB/
	 6CI493yk0MK1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4649080E0D;
	Sun, 11 Oct 2026 14:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CB6D1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2D7160616
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHqSzD_wtdlB for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D16760612
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724377;
 b=oz2bOeQlXLQ+sVBo0mEJ4u66rNYjGbZAGAi1RldJUNdF5Xb6dCOJ2foMifwKYaJUYUyJ
 YYnRtWnH+agoRw10q7P35tEFWubbqBU4qRfrY6FDsBiiDvJ5gn/9IHtELtH+WePv2z3hB
 IVw1YLV8Ms1+hzpIaMMzfV4MxQuPLY1CZmaE187LEF54j/Z8RjyUB0YMnuu7O+rZECZra
 bEjdT0YnZjtZRLXGi/0ZFxD6xBNBt1mkW5SD59o0uqGGhsr/L1lrQ2k/b2AOn+qdlnZxV
 Ijg+jLfx0UFPRTD/GLiOOjTWZ1iKbIO6EHzdeHwmi56GYrUVYbaK/CAodrpplWnu3fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724377;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IIAajS9jf+NKB4dAHLDgcWIT5JahTsCG5lSxKbZZdBU=;
 b=SgIq2vtiWeDhBgyZx87+fDELuZX/KSAHGvGaxWKyLpfP2VVzPlLVYLF8ndTfCy5o1aXY
 ZCl53XPqFDOMo2BTu1Jt0+P1utymyjpMGre+X9pflLLAkrUmJwn930dX18rhZ1stKqUwi
 n+GkDoYE9ciYrrEcsVSkdvhst0lW8s3RlhlEho7WrCG0iAzwxpP+4hoEx4GtXtIyLTssl
 WF17iiFnBZ5RbBn078LhugrgAJTdNDqWZgLCuVQZ4uYmeb5GEvnNPqac8f9fh3QieJYU8
 cwNwDUGfG3sSyqXLdyJ2UjghCPPnoEX8w00wsSouylvpABB8bryAX/fQ7nk2b3qWVTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=e8U9PRD6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VpVjehEH; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=e8U9PRD6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VpVjehEH
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D16760612
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:12:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85SIZ2793740
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=IIAajS9jf+NKB4dAHLDgcW
 IT5JahTsCG5lSxKbZZdBU=; b=e8U9PRD67KiDdj2MndP1Ww30okeRHQVZRyptbk
 f0xekAW2vrYGVTRAjKj/4eLJWWRG4loK81wugUSDF3jHF7ZqmqX7JUPm2WJe3uzQ
 rgDEfXwisQj3uHYuSim+sMW0yqW7RtBEEBfRm773NLQe11M0k7TEocpw8rUOB39J
 G5+hKBAlj7jlfGwlBsaFhw2u6EjICs8EqXWwSHudKjWAEFhkV2Rad4mJ720kKLm9
 HN+w8TU7MES4IpwuGTKow3kiftuwt1qBiNgxDMPd4pvpyTBK6LlvTJ3mAcK9mE8Z
 fZlSIFX5uq6tztkpiyzL1frV950CRIn7UhcKNuIVc5OH7JYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqmuf4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:12:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-534f3fe0236so25379121cf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791724374; x=1792329174;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IIAajS9jf+NKB4dAHLDgcWIT5JahTsCG5lSxKbZZdBU=;
 b=VpVjehEHQCDmPtoqQIgUR5EtVjexi29rw6DCzxyZaXuMJMtD0OCfhWaye6cooQVVqI
 /MV5oYT9iPPHhQLjIqnFxRWmnqPrc4IRaX95lpKL2iNXwaWEnV/51RPZWP6X+16rkHL6
 Mxu7qZrURkm6l/Pdyv8/CD62ISALQ2ZMtKTSOl/v8o2wG+DgEmQ/WT/v59sb3SKpQYt1
 SomCbiWiev1azFLPPc+nTFt83hPWHx57fZs6wtwndGwadO3QTaWzLbltO+U2cyk4NYCc
 61HltwstYQuxWpE3uSPvGgfP+kk/0vx8sFQ8+IdqW26JFzb+awXuYg2DX0G0VE2tFLGd
 UYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791724374; x=1792329174;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IIAajS9jf+NKB4dAHLDgcWIT5JahTsCG5lSxKbZZdBU=;
 b=ccYjnQpC+pduFW9Y8E139pSrcLAiWAyWAGh5NibqeIyH6zG7cwGG53JZ+IGrHwtmp0
 18wE9xtw1cj2UhV77l1aPgaw6eyMr+x6YwdzUYynQiG+HtNvQVLun+mCPtsnc5Kuz2C9
 AnitNzMwPAe+0gpvimShIvw35L/TEXZ1Uzm7K2pEb1SikN/yKhAeBhuXsn4rPciKrOLV
 eUBEmamL5sw/kvS+KF3USTEesMbTWS/4SclmAwdIpityUACsmcUz74+dxhIuR/ZLjpft
 FGsy/CVO57/hlAsjsATKKTbOlpRDiyNbP6UvCKfN/SpQ8qZtE53rXwEDErfM1K0ffd24
 XdaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTCU27TDmVvFI+9CHAEGUwamyoMMzlLiY/r8jNhcnS0wp07/90CooWmBkFYjcCCVh0TFYbWB4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJ2Hf/EzNmqEXX+Cz1VATtxyoKvfvmOihAmI1oZVeiDtJjU6PB
 nnmlMTfqIXY4e3gqI6+16LUg12QbId0LqB6lrm89Q+5U9+KqkSvJ0KdULZ8fELct6fY8Xw/yBDi
 pXPAn0dbxuEp4hlWss2FLWBeDrQgaoyanMMqD1TZHSYl5tDyu5wmRDaBEYq6ii8tN/yTrD2c=
X-Gm-Gg: AYBFou3RqiBcnZ5NKgp2kaTiPxtBWCTIidHw0BpSVMX4v+vER26UKuaWZN053G3pj0c
 PdlCsv/EGH5ykG2j4QxgowfdeAHx+ci++r4rMwbZ4qAMjC6Nc3eplvbuuBx2YG8k9xy8/do801h
 WULWuu3TnMk91kVHKy/lE9kvmHCrqXK5KeapQTLGSFxqfIvWvYTTCsWbQ4X5ba64Xnls2/ScR7w
 Z/dmXirVAlwQJPE3mEQ8zAX5M5LePcOmgp3reDaYsr2/8Paq6tlRyhmctazMFYgwpOAY1kDNnHo
 GqQNwHY0dS5cVITNddf/sv4/QBaEs0ZqamOFFBx90+vOvJ/JAYqUrnzns1gjsaeIak+9EaMrdHD
 H/npm85kBvxZ8YMikhLH+CNPIQMX59LLqyAsybmf39AGo
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9dc3 with SMTP id
 af79cd13be357-93ec12ca03emr970600585a.67.1791724373909; 
 Sun, 11 Oct 2026 06:12:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9dc3 with SMTP id
 af79cd13be357-93ec12ca03emr970595385a.67.1791724373378; 
 Sun, 11 Oct 2026 06:12:53 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31b956019esm326762166b.54.2026.10.11.06.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:12:52 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 15:12:23 +0200
Subject: [PATCH] mmc: sdhci: do not time out a command that has completed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPjfU2NSHXqWUkMSxbiFRslEE8
 e7V9vEfhm8jQWYIPaqNMhYWHtMR+lJRGFx6Q3F3NDV10+paazVPUjJcVDEGK90Q2BaOGOdivVE
 3oDfO3E3rAx3GlNHz+vOfr3/L7D8I5UTPh3cC5bNLYTinDmm9JqyF9v0LGSLGZp0AAAA=
X-Change-ID: 20261011-upstream-mmc_sdhci_timeout_b4-3eef4a4546bc
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX9+A9qmdXBK3b
 vTqZ2ApA/t9MwT3+jpxvxfRJzNvGg+Pdc9wAE13FToURAJHEkcYx5jzuoO17UixwTznZYE6IcxZ
 MqXQhTK2pSOHTMIIHQtwhj8GAMYFDnA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX9hIYDeP+WoeM
 TJow2FqjOcWgPpGjVsso2bHkhcQCgxsGd7TtgwfnLO3O4IPaz2CcJZbHdOdi3bI/okOSGeHUMyN
 2A3gAuzZWEtUufdyOfNZCXLusdPS/veA91fBFXqndMe9EpmPyq22kAWL7INTtCjwinfygPmnswt
 oDL2l30J5ScEGoy/ySZBv27R63Bs+Lk+ryKhyl24vmqeP42jM8+63bRm7QfAodee4qGcXuA2HIz
 i1HYwZJSiXKcTYyIJuLioyXX+Iw7yKXvA1rIjnbzxB8oYgGGJ+13QNBy/3g7voXnzWezj8dq/Ne
 M6eLshOS21dZ6XGjO1QUoLiV5B1YN3VZpBLBbOwSyxGhCMpN9gO29xbOdU7q0CCfCGzW7Qb7bjH
 lbfUJYWzsS+pEr5CObnujhCXZWUelhnSZKenTseG+i9Sl2c3l/jdhZFhSFFYk2HSOgFuJGU+pXR
 fWUAELYzhZrIDtvAEaw==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6acb8b56 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=xEOYyC6cwIeBg0oB:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vs58gPI7GTLAhJWceQMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Cs4ieL3Bdwh4KkA5AMg5pEIqz-IhFip2
X-Proofpoint-GUID: Cs4ieL3Bdwh4KkA5AMg5pEIqz-IhFip2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110052
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

sdhci_send_command() polls the interrupt status and gives up after
SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
the status it has just read. When a single status read takes longer than
the timeout, the command is reported as timed out although the response
and transfer-complete bits are already set, and the caller aborts an
otherwise successful transfer.

This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
runs in a timer callback while holding the big QEMU lock, so U-Boot's next
MMIO read blocks for seconds and the subsequent command appears to have
timed out ("Timeout for status update: 00000003 00000001").

Check for completion first and only then for the timeout.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mmc/sdhci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 962a99cd05a..916c7434bbc 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -306,6 +306,16 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 		if (stat & SDHCI_INT_ERROR)
 			break;
 
+		/*
+		 * Check completion before the timeout: the status read itself
+		 * may have taken longer than SDHCI_READ_STATUS_TIMEOUT (for
+		 * example when an emulated controller performs a long DMA
+		 * transfer while holding the guest's MMIO path), and a command
+		 * that has completed must not be reported as timed out.
+		 */
+		if ((stat & mask) == mask)
+			break;
+
 		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
 		    cmd->resp_type & MMC_RSP_BUSY && !data) {
 			unsigned int state =

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-mmc_sdhci_timeout_b4-3eef4a4546bc

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

