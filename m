Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50853606A337
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CN0vpPfS;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RLgciZWm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGUylZYp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2851A40636;
	Tue, 20 Oct 2026 16:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hreDeeJER40; Tue, 20 Oct 2026 16:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21E9D4081C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514838;
	b=AIgzVMcMZZWOQ8U4eTDRr7w9HHoSsVRsgdYLre50JXiShoTezhkPo8MFl/VWSE3zPRUO
	 Pv4W6rPjmp6K1Fcuery1cDTOxYVSKcsW9cZgN4WwYOBk+XgFdmQnyo6PEXXQWOd+AN/Gc
	 2RW2P/b7vvW0GzRLaTnANxk0Q+3UajGaTi5eMvzd0PoBPiZs2Cef9V3QSN8SVT3ChF78N
	 w8BpBFe+YU3IHWx8P9zYn1I/ybm+EiuG75k3E6FtlPHiv9wiL3Nu3b2r7xDDPDuK1qnpG
	 yS7OJLtee2F4g9fxFG7H7fy87bQ8Jo5X3wQTYOTm4AmzSn4mOqsRcqt62POVsASVm7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=;
	b=mZJxDdCrie0cBrNU+lg2CrciffbfwIX51Ts9IjeItgoebtowjaq4b8jnxF6rK3Y6jTd1
	 wifW078PK3VvwbC2zIxib20raIXCpVv10tPaNnJEiez49leBE6zCq7XUqUUNjHW1Ag/U8
	 sfXfThjl8LTWRCJvpYFOniGIpa3Z0uL3Hxn9TBmZ78HEDfPdpCubEYU2jAS5wCq41RwZL
	 zqOKcEIHvCqvu9EuPcj25wMMLHhSeVHD+wxTlVOjFtawaBmoq0VOkH4THZrSD6BMaQAKX
	 ryAs8WDCQDmrH5rBl1risPBKyiAdf+kH4BXzOT25mNNZ54CGPcRZme72iwNQ4iLYwDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514838;
	bh=HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CN0vpPfSQJbAC1tdfmolliAsgTbCN9zTG7CkhHpvS0GlVXAxji+z1YGuHZ65x3LgE
	 4PZTA0sfi8Uvsr8LTqQHSk0zwinrYF1irZ66dfNg3iTMMrsyhIE5fXvAxLHNqLFT9u
	 QH0UMBnmW5F55owCdFPbwctDOTLnWl92fwirf4IN+NWdweE1I9GYpHCuKvlLo2c66O
	 lO8brqsG+E3YIjvbpilRGWYZF3KjJELeLAQO14vgzAx1RaZfG8PGpe92GoQK+IG+i4
	 aGxkZ0jW2fEp+BAZb/Hia1ZJz+FMc0VaHnMBDqYDQFfmKCDRNxvg6It8wmuNX8+5mW
	 pWFTtx3shzvgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E9D4081C;
	Tue, 20 Oct 2026 16:47:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66CC8769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 644A181132
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X16gxYPp9aPc for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C75381111
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514835;
 b=ro9F1CnPqLJEzDqTEWCNZ1TGi2JrVOvSf9L5JePst3pvBu+cSfC4dv+Z+8/TvlZG/mW/
 chOd+H6xPgtH2C0OG3WKrlq4K+YT80MGaUpIEUJzYASya2/MVfRiVph08Iu5yj82O+Cdl
 /I670ydiy6Gru0Q/X94tj2XnlmXoj1ax7YIMQvsvoxeqnZzoGiWsNKAAK4CGv41zGwdRB
 xmm9hMskWpIOUtpbuvjBaTklde/QmfHH5TR1jWEdyDkZ3hqx6uY8up/kgr+GE8quYy8zL
 kb2AagXSHhawxSMDiGrKicremrQCRWGGtopuUuCSH0mAeLSK+drQaNimbVNQyNcRSFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514835;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=;
 b=A21u25v4/tZTv2ndzkzPmM57+7Kyu6Dz5sBjqgqLAmuSWZAU/x9I51BypilUb4YPPJbV
 GL+Lz42e1DDjMGLZwRjtOrHB3fS2hkSwYOozs3E5ig2j2b2Aj9YHsUGBjSVhv/TiZ4Wgh
 OIM53Ps9JRndfVNukHrGMkXZluKihf5vvmJONaov9JjkjEaG3BcFKMKnsgqUZKxH1Yl2z
 LDEoMI0Vq2/RDtmFAPBHyJ4h7UuqI/l3a4bfvS4P/NCJiFcuHmVM0qsZrt6JfqngjEtLn
 vPUQKHg4T6RtFA20jg/GQM1Ir7Ex7Y3l6P1C19Rg8gpL+pZ7Kn9OXc1h3beIczbn/PQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RLgciZWm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PGUylZYp; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RLgciZWm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PGUylZYp
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C75381111
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDALJV2214674
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=; b=RLgciZWmaiNDoAXk
 HqfwTF3S3+izmwimNpfpoCJMBHiit9YLbeyXwcdb4wXyr9nszBdplNxeKS/YBK7V
 Xa4dyN9jmqObJN43Yqj9f9U3fXSpEMudlI8hHipeNuzqcUfBoAi309e7Eaudd25n
 x79+MveZ1PR4z7LyuNXIKOS+jO596QUdCqWp2XaQHQ7oSp3BIqhtx0YBrFwGG6U2
 LgWmZVCWL0AlKxXi5WFooBjarOB4xq+Qvs5JMdJbeGbnZN9N/1lLB/Fh9HEDNewo
 k70p3vZzsrw5eDledvxhoEcMgW9wIUZA038ZJKzt+ucmndgctFXZmpRPZWwVaRfH
 MgyDtQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nudm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so5663576eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514833; x=1793119633;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=;
 b=PGUylZYpoBSN7PgneeX/0xFTPbFmwFatl1JGyPv/hjRHvfvWV0w0eC9yK7xL1Dyjow
 WVasQBr63zmlehZJc1Cb+q+KKYH94B7T532R3NHqTpfJSMZeIDi6MH6OD+DtEVIbrbUA
 7+/akcAlOP7FHyT4wzS9zp6GNYn80v6eWO7K/mQ0AupNU7rpe53ncWvgdVpvSDGVfhE9
 djOkiDVJMWdV9JZczmdzriBdRTvmz4EH4C8JwcPa+JMRzv/TcV2c0SiPqtYORueX+AUS
 CMQmWVR/zod+fBF6QD/EylaKbu3BFB5sS4dZlNEbG+DfoHyna7wqGdCgyhk9gMpqTJtX
 ezLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514833; x=1793119633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HELydj0ibAZ/6wTDzNzDL0ynMUT8+oLeFYtd/XNW/H0=;
 b=cIbBFyEaPutu7CaikbA1UiPyMvlkl4DfbkM+/JXdfOppkEBOicDIn1Zr13WYtG5Ar7
 jVhD1vbnhOgZ77GXjcVCzwFGh3QtRRKtbXp7BfLEwH7qk66hcVK+39VZI1aeArOje+ra
 wvbnU6nebmiaJiOxFeMOLuT+74zIh8hp745c6YsvSi4oORj7x1PSEesLH21op+N/4Qc4
 aLXWgDA3jEK8lZHJK0GYN9dN5W8Visny6UFZCgVOYIUCS04Wu8V/QoiaL7mScO17GZo5
 /tFOs9KTVuaCb2jQfBS97YldauHE13gdk3iS5zzXpRXocCp/7LALPw0hqgDlKqxsRIbY
 0CIg==
X-Gm-Message-State: AFq9FYI4eJV4ZnE431fBpSW2+tkev4GfuLEQeDPlkXPoWnxzo5ZNx2XN
 S4bpLSXE3zOZ4iGv3fw8rjPlhADjPN6lrwkfrPFnb1rQpXLwzC3if5O1MIo0KkKx4glHQnCIiAG
 8SfXPipvKSsHjqu4vLPtvi+90EVJNOJXZt8OycY1RtWpn/aSux+3WCusFSiHE22MNk5bNhXE=
X-Gm-Gg: AYBFou2krsWQtfwH6uKFFN8QJZdw2SLofdOSl9+VZY1vAaQ46X4l+/aAQnBeUXnvExg
 rkORXbyAutKD5RloOa1pMvMrQV+zoDrfR74RWnuN8fjX735IB1Mpc4A1wC2htJ1i9Ckb/te0AKE
 RouFyMyuYPicPxi3ufRrv4c8png2vpM/ynGoHb84bXenHWJt2UgAj/sdRIWEQlYu7HcIJaHuTvv
 VSTxGa0KmQjbAQ1UXXVe38wVtaLkT/d+o8LMNPfJSyoXy1w0+1uzCDJPSXgwgk2P+2yKsoGdP0A
 kUVN5ykoXaNA+M31YUBI3Bp26wyfTVIyWWYGWq4yO4u9WenWFfAMkqSYq62alh/Q2Lv/Oj5zkT4
 GC4T9GqVZvOROz2mfYyhGEA+/fOwAogNvX5/knS/hOYvOBuZnkwZM3gGR0VP6sobtg8Pxjcns/n
 Y54A1Qpxfoe2ZEvHeChXlbwTd79rs=
X-Received: by 2002:a05:701b:4642:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-185118edf50mr13641282c88.10.1792514832418; 
 Tue, 20 Oct 2026 09:47:12 -0700 (PDT)
X-Received: by 2002:a05:701b:4642:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-185118edf50mr13641214c88.10.1792514831228; 
 Tue, 20 Oct 2026 09:47:11 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:23 +0530
Subject: [PATCH v2 4/8] cmd: reset: dispatch named reset modes via the
 reboot-mode framework
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-4-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=4009;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=cw2G2t74quEz250lq3q1F1QgPJA792jnopLi2sPsxHA=;
 b=0c5e/QMkh6xC3gL5qHE2oR9ipOXewksDCELIRiKjsD9Sn8nhZV4dtdIrwd9cs9h7Tf90VYHbt
 tfRUGoSX06cDQjXl6nbPPnmdblhEPW4Rgf20Luxr+c7yyN/r+Gzos96
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX9Av3FtWE51nD
 f8MmYhYNVOau8gCTm/PfhpFz+1UcYJeZKRH7kNdcns8UoL/1ukOq+az/PANCsXGJrHSa7GSuHxh
 mFDbqJTT0lPpACU6dFPsx7Wd07+xmHE=
X-Proofpoint-GUID: sFNbKO3fL5I8WJwocgCmkvjc3HryFCml
X-Proofpoint-ORIG-GUID: sFNbKO3fL5I8WJwocgCmkvjc3HryFCml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX2U5sECZIms2T
 xR/iQaabTworL6zeXbWwKiaxthceI8IpAR3PY7L8yfSrS0UAroMqfwt+wQwAxEGxezqePjdDELY
 tf9ursoy6tYToPrZMGaA5wuMeZNINdmCmTjZGBpMyiGdpMJZ4QYD+Dsz58Jm2lUxI4h5twMdFh5
 Zeb03zwZ7w3AnjPzq36r8KOpeE03oNcgy/PU2kJ/OPTri38jHryn/hPZQsRBQvn1ntcdenTyl/1
 eAWtGrwSDTQPcntzSDxaBC+p4i3OnQOEe2msvvWJ1TQzWxKkj6U6bsBc8kvqS7RG2vWCFIjpPAi
 DHdtt2Q/E3jCvHSL0ecMTgtJsTrFo/1nS1xtnNEhCSgmD7ATb9P8m8iPq7bMv3wRoT+DHIOE899
 VlQH/mSimRSWDO3z7Q2n40xyvJ/7aMK1/7uWwH6hoo9Egz3Oh2FYxUr5peNhxjqwVovOW3UBl3k
 YV+U0jjqYdRCiUh22rw==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad79b11 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=txAGUK5VChYEglbCteAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
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

Teach the "reset" command to trigger the reset modes registered with the
reboot-mode framework in addition to the existing cold and warm resets:

  reset            cold reset (unchanged)
  reset -w         warm reset (unchanged)
  reset -m <mode>  reset into a mode declared in the device tree
  reset -l         list the available reset modes

For example "reset -m edl" enters Qualcomm EDL/download mode when the
psci device tree node carries a "reboot-mode" subnode with
"mode-edl = <0x80000000 0x00000001>". The command never parses the magic
values itself; it hands the mode name to reboot_mode_request(), so the
values stay in the device tree and are not hardcoded per SoC.

The handling lives in a wrapper around do_reset() in cmd/boot.c, so it
works regardless of whether the board uses the sysreset uclass or an
arch-specific do_reset(). An unknown mode prints the registered modes and
fails, rather than silently falling through to a cold reset.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Use "reset -m <mode>" instead of "reset -<mode>", so a mode name
  cannot be mistaken for several flags or clash with "-l"
- Handle the modes in a do_reset() wrapper in cmd/boot.c instead of
  sysreset-uclass.c, so the help text matches what is supported
- Print the mode list from the command rather than the uclass
- Check the mode exists before printing "resetting into", and return
  CMD_RET_FAILURE for an unknown mode
- Use IS_ENABLED() and fix the include order
---
 cmd/boot.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..487180ceebe 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -8,8 +8,12 @@
  * Misc boot support
  */
 #include <command.h>
+#include <dm.h>
 #include <net.h>
+#include <time.h>
 #include <vsprintf.h>
+#include <linux/delay.h>
+#include <reboot-mode/reboot-mode.h>
 
 #ifdef CONFIG_CMD_GO
 
@@ -56,11 +60,75 @@ U_BOOT_CMD(
 
 #endif
 
+static int reset_list_modes(void)
+{
+	const struct reboot_mode_uclass_platdata *plat_data;
+	struct reboot_mode_ops *ops;
+	struct udevice *dev;
+	int i, found = 0;
+
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
+		ops = reboot_mode_get_ops(dev);
+		if (!ops || !ops->trigger)
+			continue;
+
+		plat_data = dev_get_uclass_plat(dev);
+		for (i = 0; i < plat_data->count; i++) {
+			if (!found++)
+				printf("Available reset modes:\n");
+			printf("  %s\n", plat_data->modes[i].mode_name);
+		}
+	}
+
+	if (!found)
+		printf("No reset modes available\n");
+
+	return CMD_RET_SUCCESS;
+}
+
+static int reset_to_mode(const char *name)
+{
+	if (reboot_mode_find(name, NULL, NULL)) {
+		printf("Unknown reset mode \"%s\"\n", name);
+		reset_list_modes();
+
+		return CMD_RET_FAILURE;
+	}
+
+	printf("resetting into \"%s\" mode ...\n", name);
+	mdelay(100);
+
+	/* Does not return on success */
+	reboot_mode_request(name);
+
+	printf("Failed to reset into \"%s\" mode\n", name);
+
+	return CMD_RET_FAILURE;
+}
+
+static int do_reset_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	if (IS_ENABLED(CONFIG_DM_REBOOT_MODE) && argc > 1) {
+		if (!strcmp(argv[1], "-l") && argc == 2)
+			return reset_list_modes();
+		if (!strcmp(argv[1], "-m"))
+			return argc == 3 ? reset_to_mode(argv[2]) :
+					   CMD_RET_USAGE;
+	}
+
+	return do_reset(cmdtp, flag, argc, argv);
+}
+
 U_BOOT_CMD(
-	reset, 2, 0,	do_reset,
+	reset, 3, 0,	do_reset_cmd,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
-	"reset -w - warm reset if implemented"
+	"reset -w - warm reset if implemented\n"
+#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
+	"reset -m <mode> - reset into a mode declared in the device tree\n"
+	"reset -l - list the available reset modes\n"
+#endif
 );
 
 #ifdef CONFIG_CMD_POWEROFF

-- 
2.34.1

