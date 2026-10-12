Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAE3CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE6B60707;
	Mon, 12 Oct 2026 17:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rr72sHl95aH8; Mon, 12 Oct 2026 17:08:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29556606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824903;
	b=funBKTIIe4KkRLTaOlqEPHmiaS3XY2e9GlH6VJA12e6NL7QwMX99J8rLTRjVpPxPJZUN
	 HPyaNflWR30JLZG0WdUndjgtsprvVn2nzw4VYN8jfzYVnGUy6Nq9ZTSGOlIbbatHJANJp
	 FZzbiK++/LMF5vCJf+RRhopI8NiZBsiVZOQIeewvY1I3xBVKu4MnOvelDzEHw9evFdZKE
	 vUCJAGSNaW7jdSKXKQoI8+WyTrdj5IXjQt21rRrHVrRH1beVMgaXobYzM83UuIXTRxoXH
	 3Gi5tDnj7T+A0sCNGr0mExO7NFEqtOkDmRWKmwG2ufjd48rrEWiKegmOX2PfVycXaMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MPnGqlMAFdkhn66UKuwJEx5oguuUVnU77hlxNkq/INw=;
	b=GLeesvqlm6iaokh1QClyMNwVLjU1a+gedSoOJS5S22rWwkDAvlFWCIT2iN2Y/R1LN2GQ
	 N3rqabrVOZRkZVk8ZWyVV7/aTKA9zLAIxhrgDe7PX4NZmw1VwIyeFx2jZvXXu7E/aUVJV
	 CeGsnhusH+H3f+zFbF/wKrAkHoKInSWDOb8j2QqmJVfKeaxYmYOmmWy1JGHSpJy+6X1OU
	 ANZ8lEIxIdoL2ivMKXdbh2cRRVrk7YvrGndEQpHgqgp+36uYPyclIlouBWsc4M568uakx
	 tVaGAkAyjZaCFf8kC+C/SQhn3lhe5GfL/7fDTxaiJc6v/V+QWZHnlFQ1j1pg3X95D+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824903;
	bh=MPnGqlMAFdkhn66UKuwJEx5oguuUVnU77hlxNkq/INw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MxqRTikJapUtPiRORXgvNczlxPI0zKLmKaYMIMQfIzU3At9hhcqxLKhGcZ/81fw5C
	 GVBsj+AdZq8L39GCQQfXzV9GuZWLiP5E1B1vzwYlIIDAZ3PqwnOwbaXEXkjnfzYSFk
	 1X1q+bV4UQlLuw4wKUslVvCSBH7xzb09j/oJZKzGfOh3LYjIiPAJW5ymKZaDQ+8dUS
	 4ZJ2qE6lVEcVQTyi3KhIkpiU6N40qWw1gXmpGcLoPNj8Ece9Ia2BtZeo1lUi/x6u6s
	 znXdynJkroGEc7/yWV27zZKMvH+DKtepR5bEfeRNI98lxHxzEMXKf2bBy5Z/OND8oC
	 vJNJu0zF1Wwzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29556606A7;
	Mon, 12 Oct 2026 17:08:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3DC7105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5A5A80DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SG34r-bVpRv for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C59BE80DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824900;
 b=MrFAQLEMS1XxpriMIVNcHEX5Kwun80DlgIk+Cbh+Yz/C22dNof9cBnlvyma51QztKW7i
 qa9gxJPGa1aAha2f5FSv75mRdg3AFOULOOXKKe9c2z95UgTgMLF+mIZio7DQNjp/OSpz+
 nEdR2gWGvl0yZ1/H1yQVxTjtXm9fpshCctzvyxtxBNxz2/7ZwMf8w18FSOZbQkXOUvQf/
 14UiBOVRD2D+KP6qFGrrZFMBU35MUz4NE1B4sZtkfPXMP2gEhbnRDqRJ0ub0z+SYmYAAM
 nYq9Yoii6orZBtYsvOU2MFoRBf2qcvazdUjQfF/bfw4DjmD1a/8rAjuvJeF51LsNC1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824900;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MPnGqlMAFdkhn66UKuwJEx5oguuUVnU77hlxNkq/INw=;
 b=Vf5dCJUaDfzaG5qQif8BjjJB7ho6trPhMv5MXX3wtqAqK62x61puC66EQs+xLQkfct2O
 NCP3qfiVFtrxwS/9pkHZRVDUUji1L8lGFTSRnf5oRIygBunfJ3877GN9rs5TWzJ9mhDVk
 jzEVyT+AcTSNvmHaux/HSBXoX3TrvXE442ClNFBv0SJVR7nJNaP7JKB3WPm60BrRCn4rI
 xf2rWTSJl4UNVew3DL0Q06VWqa49c4SDsVmD02idNW53O7tF5Evh4ddHQdW2YJ1z85vxb
 9rg03yqbDnjhNTWiPra9yGD3Zrt7Jjf2efqYFVmeSDnnTOsOPzESmOxFwC8sbmgQWgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CS2VWnnC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X301IDu4; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CS2VWnnC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X301IDu4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C59BE80DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFf0uh2175322
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MPnGqlMAFdk
 hn66UKuwJEx5oguuUVnU77hlxNkq/INw=; b=CS2VWnnChQFak221T0cC/TtrSF6
 P+F2ph0sln/uqRFJHQYGz3t4xCq8CxZdg8pL/jXrCX6UUwGoDJkVG1FK1KcNXpne
 PyiKKn2NM+1YqReSjTvR5DY9dtE/8L6tRyUxITQzII9Byz9xyWM15fi+VyZTErP7
 elvZEGmkAGrdX2ZzcKvorRHPm8fps4mmHq18JCCDsYMzFnl0nIaaB6ppijhSM4JJ
 mJDhWiwZt9Ab3MIXHjnEG+w1I5Cglq4wO/0e24q7TS40UHiV1DilPO+9tndVJx/M
 qL1O/n21VuNIx8Tk/f8PD6byMsGgxtJISjK7IpfoAANi3bGfHLgVQHecW3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc1xuw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5215100eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824899; x=1792429699;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MPnGqlMAFdkhn66UKuwJEx5oguuUVnU77hlxNkq/INw=;
 b=X301IDu4YMVqfXSMjEWglqq7S8yqX7mfRuCx6eR2hkgb8LJFFM6vOsAjOI/sKzNwqR
 4MTGyGDfE1t921H5M/TI9xk/3TXWULunCDD5JibBh1YfsbW4P7IyJ2lPNOk2npVGt7p1
 MRkzNi6z1B6gnlIbLYYAXuufwUuc1oHCeCyAhopc3UTuRO34FdqZkWafAKVLI1zdjgJJ
 vG6y8AZkPzUPyeWgHWDirA/gLPyGjEFi3gD9ZZk5Znm6gOKPHdhDK+fcnaiHJhWR3uio
 a5qiUx7foY9JhsizT9HRETKDCjVlu9Q3cOjB+Wl1zrLB7MGHdqeP6ubLJVRq0dUwXOxn
 8otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824899; x=1792429699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MPnGqlMAFdkhn66UKuwJEx5oguuUVnU77hlxNkq/INw=;
 b=Y9MoqB6zV1vJ1tGOxEXSvXgk0QO2fc+D5vZbrSIdKApX1HeI1hG0DnhsTV77aLWIz3
 L9z+RDxz5IuiMIhDLbqd4MyMYiWuXkd6QxN2SYH3USLow68TvDvgUTxurbyZED/AJ3z6
 W5jRKDUXsFjwKhOXC/YPsOQWcennumDKCIYZIcl0f8QV3MX/ZQBpN6Rl+5ShuF2DJnz1
 t3Hg+Dd85OdJ/9B/Oe+jj4vbSW/wCnhjjg084hQqJbfES7g5c60x7OFP4giC6Gdg9lE2
 DXZBGsi+uiWG9oG2Ot8zk5L/+GnsHU+GtYAloohFYzMRzIFRnKpiO9KBXWhNjB1+hOsh
 KP0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSk7CPp/+oMSsoLjRSsa2G/3m4uV7jVM986ArmX5FdT57SgueT87BtjOsMzq7+3v9zSzsKdBc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLa6prXoZd+vcT97bRa9+EbgaXrhsK64+QJOtD58MFz1OTkahLx
 RJ5wgNivmljxULhZKEX5zoEaqdKyJSqX9TBXRhSTFDsYetSOlHLHnzmOcw7dVGsQB/QqsmvUOC3
 Q0jIarvVFA1FQaeuF3S7sYbzOc7nNmU2Tcn7iX3l1C7A5eszZEaSq14Gj/Vzadh+dI4Qginvbbh
 wPa9s=
X-Gm-Gg: AYBFou3n8TjNrc2zojBIrJRCwGFMd4w77qu3geX9GxlOIAYrERE9hlTmRkVM59U2mmx
 9+7qJxBw1ScP+jswVNN/eauZU1DDGSV19mwmmTbuo1EbzBgEVc2hM9m6Ujz/kmjetIJ/UK0TGFP
 YgOzTnjcmFBbjigy99uv9xLk+vcNjbqOA3mGnrZrRiNO8FGwVRR77MoQ22xcXvGC9VEIIYKbhOJ
 TTBwi46ieq+aPaZS+r0QGuPxkFpLwCKvBlC1wxKoRIizBWM9IGwuOaUYTtdTcWY2M45OAYK0USp
 BnEmZtBFEQ4UElIJGEIQ91Tp2kBedutuDtaLNjW+licjSPX1H5/Fokrj994p5SVqHguDNER1Rd/
 IzDBQDVNJ0y+c1ZQU1cRhotwjec7u60KQkAi4fA6lXZrU/53RQ2Uk+NioJu1Fi33e1SmENoD4/m
 Qtf5eY+a5MSaSX/jSW8w==
X-Received: by 2002:a05:693c:83dc:20b0:359:2433:2717 with SMTP id
 5a478bee46e88-359243328f6mr8669718eec.20.1791824898681; 
 Mon, 12 Oct 2026 10:08:18 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:20b0:359:2433:2717 with SMTP id
 5a478bee46e88-359243328f6mr8669647eec.20.1791824897174; 
 Mon, 12 Oct 2026 10:08:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:16 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 2/5] mach-snapdragon: Add hardware detection helper
Date: Mon, 12 Oct 2026 22:37:51 +0530
Message-Id: <20261012170754.1606314-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX9laRHueFkFlE
 7BiMo6MPvsQUb0mJ7BwUDwrkqjZOLXRcq5eyiKtrNGggtO0Gb2UQ1fAay9Jt9PTC1YHmE7Qwz4c
 aupici9K/h8iPcoFrRxatMsmR+LCn1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfXzddNGiI8RIlX
 D+hALeoc6qp0XcxwC0rTnUP3AQDB7CWbulRvBqPR6z7lHbozesxqzz9jKHM2mSA5Ptah85nX5Og
 BC3cQjgu/0dEcf4F4JvvgrEJ7498sPo84Y28Tho9zPQKitG8jW/uO7psnC8khxg6qgseSJpRimE
 GLGX75MeI4Ip5vrpCs68WC0RWP/bbzrgbhvG36bEjD4N8+vL6k02be8DzPZSpApevkvpMLYoScZ
 3TCh9BaPS8DnSxN2iuE/QzvpY5CPS7aJMKY3QGIyZlGZp/dCBPcwoenI/Sp07IwXEntVdhj9E6g
 xR6mD7iCjRN0bf2kHQ6eYWpPvhmAw/sKG5Svkpvi9BwGRRW8PPVGz6PrlmUT3QLLRtJK8btZRoT
 uPzdcYNRAcxj9RLV+oD6PORmz6ufT/+u20zUSnetuzPJqM0TmidXy0TOd4vCyQnM9ZckXx5I2sm
 r89rdFHaep5FSRj3okA==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acd1403 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1VxDqnHFAAAA:8
 a=EUspDBNiAAAA:8 a=c7FPpqzS4i-k0sXx9q4A:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: 8zlqFdwViylXAPFEuaQs2p93xhFDd417
X-Proofpoint-GUID: 8zlqFdwViylXAPFEuaQs2p93xhFDd417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

Add qcom_hwdetect, a helper that aggregates hardware parameters
(chip ID, chip version, board version, platform, subtype, OEM
variant, foundry ID, DDR size type, storage type) from SMEM, TCSR,
and IMEM into a single struct qcom_hw_params. This is intended for
consumption by FIT multi-DTB selection and other subsystems that
need a unified view of hardware identification data.

Depends on the qcom,hwinfo driver for IMEM/TCSR register access.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig         |   8 ++
 arch/arm/mach-snapdragon/Makefile        |   1 +
 arch/arm/mach-snapdragon/qcom_hwdetect.c | 167 +++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_hwdetect.h |  52 +++++++
 4 files changed, 228 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..5911e76dc1e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,14 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_HWDETECT
+	bool "Qualcomm Hardware Detection"
+	depends on QCOM_SMEM
+	select QCOM_HWINFO
+	help
+	  Hardware parameter detection from SMEM and TCSR for
+	  DTB selection and other platform subsystems.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..6132847d7f4 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -10,6 +10,7 @@ obj-y += board_spl.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_QCOM_HWDETECT) += qcom_hwdetect.o
 endif
 
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/qcom_hwdetect.c b/arch/arm/mach-snapdragon/qcom_hwdetect.c
new file mode 100644
index 00000000000..a3a3a26556d
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_hwdetect.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Hardware Detection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Detects hardware parameters from SMEM, TCSR registers, and IMEM
+ * for use by DTB selection and other subsystems.
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <qcom_hwinfo.h>
+#include <asm/global_data.h>
+#include <dm/uclass.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
+
+#include "qcom_hwdetect.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* TCSR SOC HW Version register field masks */
+#define TCSR_MAJOR_VERSION_MASK    0x0000ff00
+#define TCSR_MAJOR_VERSION_SHIFT   8
+#define TCSR_MINOR_VERSION_MASK    0x000000ff
+#define TCSR_MINOR_VERSION_SHIFT   0
+
+/* DDR type enum */
+enum ddr_type {
+	DDRTYPE_256MB = 1,
+	DDRTYPE_512MB,
+	DDRTYPE_1024MB,
+	DDRTYPE_2048MB,
+	DDRTYPE_3072MB,
+	DDRTYPE_4096MB,
+	DDRTYPE_128MB,
+};
+
+/**
+ * qcom_get_hwinfo_dev() - Look up the qcom,hwinfo device
+ * @devp: Returns the qcom_hwinfo udevice
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_get_hwinfo_dev(struct udevice **devp)
+{
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(qcom_hwinfo),
+					  devp);
+	if (ret)
+		log_warning("qcom,hwinfo device not found/probed: %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * qcom_get_ddr_size_type() - Get DDR size type from gd->ram_size
+ * @ddr_type: Pointer to store DDR type
+ *
+ * Uses gd->ram_size which is calculated by dram.c from SMEM/FDT
+ * during early boot. Avoids redundant SMEM re-parsing.
+ *
+ * Return: 0 on success
+ */
+static int qcom_get_ddr_size_type(u32 *ddr_type)
+{
+	u64 total_ddr_size = gd->ram_size;
+
+	log_debug("Total DDR Size: 0x%llx (%llu MB)\n",
+		  total_ddr_size, total_ddr_size / SZ_1M);
+
+	*ddr_type = 0;
+	if (total_ddr_size <= SZ_128M)
+		*ddr_type = DDRTYPE_128MB;
+	else if (total_ddr_size <= SZ_256M)
+		*ddr_type = DDRTYPE_256MB;
+	else if (total_ddr_size <= SZ_512M)
+		*ddr_type = DDRTYPE_512MB;
+	else if (total_ddr_size <= SZ_1G)
+		*ddr_type = DDRTYPE_1024MB;
+	else if (total_ddr_size <= SZ_2G)
+		*ddr_type = DDRTYPE_2048MB;
+	else if (total_ddr_size <= (SZ_2G + SZ_1G))
+		*ddr_type = DDRTYPE_3072MB;
+	else if (total_ddr_size <= SZ_4G)
+		*ddr_type = DDRTYPE_4096MB;
+
+	log_debug("DDR Type: %u\n", *ddr_type);
+
+	return 0;
+}
+
+int qcom_hwdetect_get_params(struct qcom_hw_params *params)
+{
+	struct udevice *hwinfo;
+	struct socinfo *soc_info;
+	size_t size;
+	int ret;
+	u32 raw_version, reg_val, major, minor;
+
+	if (!params)
+		return -EINVAL;
+
+	memset(params, 0, sizeof(*params));
+
+	ret = qcom_get_hwinfo_dev(&hwinfo);
+	if (ret) {
+		log_err("qcom,hwinfo device not available\n");
+		return ret;
+	}
+
+	soc_info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &size);
+	if (IS_ERR_OR_NULL(soc_info)) {
+		log_err("Failed to get SOC info from SMEM\n");
+		return -ENODEV;
+	}
+
+	params->chip_id = le32_to_cpu(soc_info->id) & 0xffff;
+
+	raw_version = le32_to_cpu(soc_info->plat_ver);
+	params->board_version = (SOCINFO_MAJOR(raw_version) << 4) | SOCINFO_MINOR(raw_version);
+
+	ret = qcom_hwinfo_get_tcsr_hw_version(hwinfo, &reg_val);
+	if (ret) {
+		log_err("Failed to read TCSR HW version via qcom,hwinfo: %d\n", ret);
+		return ret;
+	}
+	major = (reg_val & TCSR_MAJOR_VERSION_MASK) >> TCSR_MAJOR_VERSION_SHIFT;
+	minor = (reg_val & TCSR_MINOR_VERSION_MASK) >> TCSR_MINOR_VERSION_SHIFT;
+	params->chip_version = (major << 4) | minor;
+
+	params->platform = le32_to_cpu(soc_info->hw_plat);
+	params->subtype = le32_to_cpu(soc_info->hw_plat_subtype);
+
+	if (le32_to_cpu(soc_info->fmt) >= 17)
+		params->oem_variant_id = le32_to_cpu(soc_info->oem_variant);
+
+	if (le32_to_cpu(soc_info->fmt) >= 9)
+		params->foundry_id = le32_to_cpu(soc_info->foundry_id);
+
+	ret = qcom_get_ddr_size_type(&params->ddr_size_type);
+	if (ret)
+		log_warning("Failed to get DDR size, defaulting to 0\n");
+
+	ret = qcom_hwinfo_get_storage_type(hwinfo, &params->storage_type);
+	if (ret) {
+		log_warning("Failed to detect storage type via qcom,hwinfo, defaulting to UFS\n");
+		params->storage_type = QCOM_HWINFO_STORAGE_UFS;
+	}
+
+	log_debug("Hardware Parameters:\n");
+	log_debug("  Chip ID: 0x%x\n", params->chip_id);
+	log_debug("  Chip Version: 0x%x\n", params->chip_version);
+	log_debug("  Board Version: 0x%x\n", params->board_version);
+	log_debug("  Platform: 0x%x\n", params->platform);
+	log_debug("  Subtype: 0x%x\n", params->subtype);
+	log_debug("  OEM Variant ID: 0x%x\n", params->oem_variant_id);
+	log_debug("  DDR Size Type: %u\n", params->ddr_size_type);
+	log_debug("  Storage Type: %u\n", params->storage_type);
+	log_debug("  Foundry ID: 0x%x\n", params->foundry_id);
+
+	return 0;
+}
diff --git a/arch/arm/mach-snapdragon/qcom_hwdetect.h b/arch/arm/mach-snapdragon/qcom_hwdetect.h
new file mode 100644
index 00000000000..cb75f565756
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_hwdetect.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm Hardware Detection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_HWDETECT_H__
+#define __QCOM_HWDETECT_H__
+
+#include <linux/types.h>
+
+/**
+ * struct qcom_hw_params - Hardware parameters
+ * @chip_id: SoC chip ID
+ * @chip_version: SoC version from TCSR
+ * @platform: Hardware platform ID
+ * @board_version: Board version
+ * @subtype: Hardware platform subtype
+ * @oem_variant_id: OEM variant ID
+ * @foundry_id: Foundry ID
+ * @softsku_id: Software SKU ID
+ * @ddr_size_type: DDR size type (0-7)
+ * @storage_type: Storage type (UFS/EMMC/NAND)
+ *
+ * Contains all hardware parameters detected from SMEM, TCSR, and IMEM.
+ */
+struct qcom_hw_params {
+	u32 chip_id;
+	u32 chip_version;
+	u32 platform;
+	u32 board_version;
+	u32 subtype;
+	u32 oem_variant_id;
+	u32 foundry_id;
+	u32 softsku_id;
+	u32 ddr_size_type;
+	u32 storage_type;
+};
+
+/**
+ * qcom_hwdetect_get_params() - Get hardware parameters
+ * @params: Pointer to store hardware parameters
+ *
+ * Detects all hardware parameters from SMEM, TCSR, and IMEM.
+ * Returns a complete structure ready for use by any subsystem.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_hwdetect_get_params(struct qcom_hw_params *params);
+
+#endif /* __QCOM_HWDETECT_H__ */
-- 
2.34.1

