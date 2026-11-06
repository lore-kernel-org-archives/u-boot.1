Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CE606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dZcTkwn1;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ftMDKKJQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KVIJTs57
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A879B8101D;
	Fri,  6 Nov 2026 06:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6v_9MpRc0XW; Fri,  6 Nov 2026 06:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA44A81028
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945562;
	b=bAwcAqMehObdykHW8bJ+QwUJ50uOTVu+8QHzyBI2JIGy7Z6Ks1KSpNYCYWbqy+czHojN
	 43B0KYY0hlUwGns0Als8gKp8ro1wb1pRZg89RoBHhhKd31bv62svTUwnnzKOxAOO9ixbv
	 q9RrMCHdJpdK8XLKXYSPnYquKDOZO6QkWcQTjDXHMLsOyy6usmRMcZ4LQc8M6utEljyf+
	 Do1hCRDHbql3O4pR132Ybu07M4H0j0hZxsdTHJONcJ/tx8Jy+NglzufABNSaojTVwQFzZ
	 bc+xiNOcM5QO2bDTp/bt6Vo9llvG9Bnx5A4bzhadbQfsJWaVVAmoNSsABUJCWwxHUFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/Hubv+ujFBPhWzNm1dokJnOFLmFV3mkmdP5PLeAsiBw=;
	b=M+o5YHxDnAbok2CI+8+mBNl6WmmCZovNEaWAl1PPMi+KUgokQxAQRo+UR0sG+/XltUxS
	 AM+FYJ3uapY5/u33UUSlTr/X7Go7zLXiH311y5A8pvjlcOmY/VIysQlLaW3XjHkJiUYfB
	 Otbs3W8C8ObPQWZ2jTg65B3XZP63bO+0TLCT4SpHeHoj0gq72nSzkFuR3YQMRyazjyfgw
	 /as1MDLLq/u3SJMAjbDYuRuh8+kXKBiHVntXb45ovgC/pCVs5sJPoj0PBkl8+IjFhXV51
	 Z3z+8qmaNs2Bw9TfeYsV+QZxAgAv/F8MebqOAkrafiaLzqPx7jXV+gjIOm9KzdKP/0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ftMDKKJQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KVIJTs57;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945562;
	bh=/Hubv+ujFBPhWzNm1dokJnOFLmFV3mkmdP5PLeAsiBw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZcTkwn1zw0Am9DHqzuMexdlnm5nbpzIXjJj98y9ZhJC1etnef9uC2iY53iJyiu5u
	 hdEikWMSOQsQo7nYUvbnAP3bmlwwd/Xw+aEtLw4GmEwwzdll0jQvPGjHkFsl8hNrLY
	 /NxMA4T2WlvOcizSIzqoPCjRAdZkI47qxIkwbHxqpdux+Bp/e+6cZQrG+LGbd5k9o3
	 xH7kxf/ED4ctzLNaDMld1fYszri9UGCM7KV0/OvXqf7s7q50JdnuqJdlY2DWdsMYFj
	 Z6FLB3npNRrhEmVoj/9BeXEEvTVCQYFuTZRib3JRPg9aMbcsgETRL5ZZ8kWJ/LZL3i
	 tWl7XFgGyh6Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA44A81028;
	Fri,  6 Nov 2026 06:12:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E1902E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5066181028
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5l6cqyeQ7CS for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB35081021
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ftMDKKJQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KVIJTs57
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB35081021
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6406Sg1867126
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/Hubv+ujFBP
 hWzNm1dokJnOFLmFV3mkmdP5PLeAsiBw=; b=ftMDKKJQEGEKbPU3MdG1mOd9Vpe
 PaUoPxDl5GaUb+KhojuAk9gDAefEEN8Q4xsH4CYY6GgBx30lIF47PpgYMjXbQT4h
 74hQEGGkkBFJnPBIXemgMkshlhNNbOqjh9EvN3RHCgoKQkbCHjQ7L7DUnoHLONcb
 5NHuVVInAorV9xEhmpA1WxQZgjMDruRw+AhwgriWR4UaRoZHl/rlB/hbb82l4nZZ
 9vAy+gUGOENIIdZr3ap4gucuNK47MNo0fmz/X8957dHb4ZsFyx2YcqIyeLjnYP+t
 XyrVwriPVgBHI0drB+yuI6sLYVdGXQYugCUT7hBM6m7UaWz/UKrxPYa1s+Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p997rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:12:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so617462eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945558; x=1794550358;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/Hubv+ujFBPhWzNm1dokJnOFLmFV3mkmdP5PLeAsiBw=;
 b=KVIJTs57WsF6zqAKpG9OCH4Uc10QaisK8A3ZHmTxrRshyRkfR0JGRecUMnKsOParhE
 PJr/BhCiMpe7IynDgr5Mwgc4SQm8qScREo0FX2Jb6otFyoqXYFJbJown2YGWTtRoFrB2
 rYmeYcbQECUoJz0t8FxOUOCPxpzr8plP+LbgQfnWpQTSCVzCPGlIdPb/zSlBb+Q8k30l
 zA+yApmxli3eIJ/MOjeOETMWccEdMogGlg+uXrtULjz7OAdmDoaMiH6yrbsRnhu6e4nh
 LYVI8FElX6oo2eByRoxYYRhZWbbTc/QuLLXyqK86EcWhqmfYTJtW+tjdYKqkznxBaAB7
 CoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945558; x=1794550358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Hubv+ujFBPhWzNm1dokJnOFLmFV3mkmdP5PLeAsiBw=;
 b=sIXFb8DgiOz07KbQX7F6teNJKhlSs1W4czYPYUCRdMsfwFYqN0Flh3m5HjJ9XECJgS
 AKHUQdaXMX4qSK9xrMqSUwPeVyVWUu2dOVKz1RYKzXvi0+R1S4/ZyE2rbReq56/a7rkY
 CF6I5fZvQxBjt7C+2mUq7fTC12u/efjg0gnOHkTO0v2Rs0d/esoSzWp/nQLekvMTCyVw
 08eJX/Oq/QLFFwG78BDWA/fO1PuoTPIcNQBaSVJchCKa3Onaf1Rpz5H5KluEfc3bNHfV
 Fqs8OiE75ViTjjn42s59JUv93s4nO7IdeOMf2UnMfu+5cY2i37Qk6qx6acyJhOQ7+SO1
 0rJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYVKwA/NwpNYmCrhgWvaeZwrLxwrOBk60dGHuBHVpDjpmvM2dZt1EaOacJ9bxdYQHBvHnfvA4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+2JN7E1lPQ/IbUB5XHPCMuGwJydQbZjL7DAKIM8q61sFJymlJm
 BrXWvN0jkdq1f4ovlhgtlxinW0AWqmSW+PBsNdAgw0rzJ2bqoQQJhaLG9eE0hMd5FvHiL4vnT5j
 LUEY8f7CBxfYtRpUt4PJ+mTf2COdgApZdLGA8yLHUTiDwlQMPQT+O3q+uZOHA/OVOI1Bbz5g=
X-Gm-Gg: AYBFou2wInobU2SdrXYOsti9a6X6dAQXD7+DToiBTDlhTt6HRj0O5f66yHTKBTJx6eL
 JzOvBIwcFZ3x2FUusdL1VmDHUBKI48bJtwD7vsicTUpI2UsFdn5kX+WIB80xeRDTZczt4lBZl2p
 OhuE5DOk6VWjTQfTCzs/ca4nQDmcIPeaux91PFMgmkjUNhsSfb3EQ4zBNBMtDMZ4iAcEcGz1TUO
 SwSK05zoXPdOmUWUb1Ko0YtMHYIKNNRUjN7QgG2PcymDOGk84EGUwJ09gRj3qFi58YQYg8iHn0e
 IFnMB1gOTKLXHxdFLY6l7fAlcZgwkhWwrkP/d24PdsI92d52myNbAkUcrzEWGVZtxIm6PwvGyIG
 WbTo7bYCHjuScmxMFXgBbr0y2ng0WCN5iT2r0uDWt9/i3WR8fOTO1HQpDzoHA81rg5UGMU3f5fU
 EEZfeFAm3OmQahT9Lzg6gZjuG15fkPAdAuEgUDI09eFSXeH32Y05LTk61UXBlpaQhU7Ng=
X-Received: by 2002:a05:7301:fd06:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36f758318dcmr1949496eec.23.1793945557805; 
 Thu, 05 Nov 2026 22:12:37 -0800 (PST)
X-Received: by 2002:a05:7301:fd06:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36f758318dcmr1949468eec.23.1793945557266; 
 Thu, 05 Nov 2026 22:12:37 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa5afffasm3608039eec.25.2026.11.05.22.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:12:36 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, jbx6244@gmail.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, naveen.osdev@gmail.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v2 2/2] serial: msm_geni: Fix clock enable on error pointer
Date: Fri,  6 Nov 2026 11:42:02 +0530
Message-Id: <20261106061202.3049194-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
References: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gFicZLk-g2JuBol2CbwNTMBAEFbqRVZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX7nSCnpco1/G9
 wAMxCgk7L/dLXWhOsRzoqpRfTFJ5OG5vzD9GwLOEBUUBwHy5QUcDbDr3YBCcFarUohZVcq33pGz
 GU0thFLPD3Hf//MjWzVz4nxHqDqoqy/IvJ3BcHdqxM8JxG+93ByljJXQ/ZHxIT6UDiSpGRSAvh6
 A8WVAL+T20+Bbs20k2NelSltWm557rN0sXJVW14DcqsQK52Ymjjzf6ZmDdkziZ7ETYLMKvxu7YB
 kGzvvQ7pxmFr/ZvIIgRHKOfVvzwVM3KGpmWhsSeglmOiS9O8cHTW/xNKIQ3sh0qPyM3aMRuesCZ
 HQX1psvmFfLp1L2L4gmP638Awts2CszvESFGH+mRcxdtQAyZEnI+lEywB/1MHD0izy6j6xptSpj
 s5KOyqc/i6ItbUpDssPfbyDUvrq6UB1nXyccJ/3RUfvZ6f3GNiwF2YH1tWh8Zq465PdIOO5xRjZ
 n7+lCVTOEAbLWwPkdJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX1dYLmuNOGOHo
 CBm5Y3hCWfsni88K17Ai43a6y36x58KI2NBVSzd0vZ0Jfr51ZnQ3EJer10jd2X0K6aODq1ZrTTm
 dR9Dsa2MCp+ZIsj7P67t1jO2ww56rlc=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed6fd6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=enwCI8h027-K9Gn1bSsA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gFicZLk-g2JuBol2CbwNTMBAEFbqRVZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
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

When CONFIG_SKIP_EARLY_DM is enabled and no clock driver is available
during early serial init, devm_clk_get_optional() returns an error
pointer. The original code attempted to enable this error pointer,
causing a crash.

Fix by checking for both error pointers and NULL before calling
clk_enable(), using IS_ERR_OR_NULL() to handle all cases properly.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 30dab2c0cb8..94c37183855 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -571,7 +571,8 @@ static int msm_serial_probe(struct udevice *dev)
 		priv->se = clk;
 
 	/* Try enable clock */
-	clk_enable(clk);
+	if (!IS_ERR_OR_NULL(clk))
+		clk_enable(clk);
 
 	/* Check if firmware loading is needed (BT UART) */
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
-- 
2.34.1

