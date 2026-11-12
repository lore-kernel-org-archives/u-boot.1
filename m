Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40935606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZmBHpNCi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KfKOc0IF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bj9s4KBA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04D538131B;
	Thu, 12 Nov 2026 07:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5SxiaMTVrVA; Thu, 12 Nov 2026 07:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BC4681468
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794469416;
	b=AeA9p36UwU5GXXTn0G0RxjP0qQX4gWGT+6VYE0dGAvdVwq1BMcJBRDN+2CChjodr4jMM
	 YUnflDnQfEf0t/lYXJ0qTN6NAVHAeBshlfvQUt13U4PKG0BUobZ/IepjoezaSmv6Xc8rw
	 qoBknFBGLnRUD662rxaUoxI1KuSYzuskCyr6A6FIMj1S/3U/xKbyLNUh0IMVHoaOXmb8/
	 LkRBZj0IvlrSQfhLQcED5TKBTHCx8bGrGacfgT8N+uUfjp4Mv75QZcQKzNlTmJw02DB5/
	 7EWH6gfcJJnR4mlu9Gmn5fC+T5JBRMucf6hNok89rqsszSBR48mGkvXVuaTjg/bzfCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794469416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hXd/yqqLGZ3VclXe+eWVaCpqtg6g6C0t3pKfMqGNfM8=;
	b=W1Citpp2+RiuMUxO4Dfdu6/Pj0jUCzwHy3eQwHIFqorqVTDd3hAiK6BKmINa06ezvusP
	 IOr6z1aN/uexlAp1NYEeFvxK0RiyuEnGvXHCKKaFmObxyj1UYYskuCN7guZXF0aoVY2D8
	 /0VqED0FSf3OchYkcPmYpIadg8naKo2mJC01Z/DrwWHC5kmx1gdze3SklNqAM2jY33npJ
	 wN4tzWxwGMCDvMhOKGcSGHVXgi/yg9+79UqSKdIe8/gQ3ilfZvMsWTeI/SOE4TZD+KhGq
	 dPXVQcxhHsfQvNMjiPH2LQoLVVyDIS61w+zdXsOcLE3penFpmlnEdbJdGRIPPlqKreA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794469416;
	bh=hXd/yqqLGZ3VclXe+eWVaCpqtg6g6C0t3pKfMqGNfM8=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZmBHpNCiaKmEswBY9vfiZZZGsAriXAZIE/0Pvpw2DIUM/0MABDTukmvTcc9+N4xMF
	 n4kI+eW2Y7Q+cDoulYLI6BZxuf5V8gjruWwBVAjJIYpMibL4m0Byb5D+Rjx4sfuCJ9
	 0YbORukELsyAOLEQluVzUnFBvGPRFDkIg6THHMMXZ/VpT1kdFc1VWHDpfO48t6zSU6
	 Y9bvKmj7OSxHGHt9rTi+YB72JwSJt+n/2qebWhlpe7DVhPecY/JHuFvkS7WYqsyciF
	 SKlfjlPcfSew3fJ1cwFLGNAK+PZ+cSYiyWOdS8TZvuV3f0kpKtULVKGHOa4p+eQzHM
	 w31NiYx73Bz+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BC4681468;
	Thu, 12 Nov 2026 07:43:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD92A1399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B342460887
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqUeBueheAhf for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 07:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B4F260642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KfKOc0IF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bj9s4KBA
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B4F260642
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:43:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZcGH903659
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hXd/yqqLGZ3VclXe+eWVaCpq
 tg6g6C0t3pKfMqGNfM8=; b=KfKOc0IF2ZbPMHtqXZ8FgqjbIYT4B9ArbQykFK6i
 n0cTp5B1vPt64Bt1fL/rf9Qe6VI6voQJjH++q3CBxmwzp7u7zse0AA60qW/GPBLQ
 SNF7QI9Wnm3psVb35ta4RMqXiCuxkDzdcwqV4egJgv/rh0rZSmb2aSO7yEpXuxXM
 JHM63VcqbLnd+BLYaqIwcEQMTikc7DOQD8NhCH2uIpqQnLO2r/Mj3ZClGknMGGDr
 hLfDuSwE3hOUC0ZPSjWTasuQzeGQEzqgYa6DJDEQJiLU7GvAHjGatI9d0tS7pZFb
 bN+FJRS72aeA9ID3BWQY+rLlEX9Rt8+uF/xhMSKL2Oe1BQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1ubj0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:43:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-944138ed63fso712253885a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794469411; x=1795074211;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hXd/yqqLGZ3VclXe+eWVaCpqtg6g6C0t3pKfMqGNfM8=;
 b=bj9s4KBA/h6aa6evIRvj7UEorI11Mv9KN+BjFF0WalM/dnao0jI7/341YwBGs4TpVS
 HgYlU7DOl1iHXWbwUFyiRBDL9Xzkd1N6pQmJrF7uQ4ZyeT52uR7qPSaJVTFVLXhQ6Z13
 X89OI4Mngax2ntOEX984ULrOvmcQ03xZ9Plx4tkXjY/FKt5AdIp1353YosDqVAyJaIly
 gtrZPVrX+B06fSR8eL5XRu5YBih5U8c/xIY90Bt83WKM5TF7wq9HCflyur57OkMDNERv
 GoYxb+Vko0G3df6gdCeBG7zQGRCYuxIhuZbO29X0C0NnKJ+8TZayUk1kmwK7q/liXyLz
 ss3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469411; x=1795074211;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hXd/yqqLGZ3VclXe+eWVaCpqtg6g6C0t3pKfMqGNfM8=;
 b=banbRjiSXqZMULN4aYgW0Im7gC8LB8njscipxhqY3r3fxcor7lFcw8bqmn3XEwP6fS
 ZlGolyMXvQtRCkYxj+r5Lax/W6nfT65Nn3cXE6aSYolI1t8dn/VOgNZvrBOrHe+jAn/g
 AXFCVenILcQuYt4CxqZP1aYPnBN1CB+XmdZ2AUKGOW87+qUzII2U0yQs/WJDbaIWzUjk
 VslU40lGEaSgFq8iMZSuKXdLdbmcPjxBUzNAgO5skdJ3ft6zflSCc7wuZObVV6LeaZRq
 Gsm7e24fIY/+HR5QEjc+lk1DXO8yMbCqavbe9KxmFrWmRarqLJSj+Pft/cNAdLrTRW8d
 rFcw==
X-Forwarded-Encrypted: i=1;
 AL+hErEI3XigneeIunmyPqTVNgIOURHUCxsXfjjgAIFT+C4CZBTsGbQEhVqNaENBrbh/TikbQPTw8Fw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+w9glIU4PArbnyzBY2/V7kacxYn96OVBxBfFqrQWvAzFKymIBL
 NS8TQTQI1UVoNWl07LdQ3t1fFOW49Vr5Vsmblr1RC5ozithwIEoiVNXmG44F/TwMSKp3hP1chVK
 FgEyDf3HMxh0DLaVPu4B199Ue9BB9OfVS+7YqOI7WNiGRkWkpOm0qNas9JFhZI9TcaZVnVp4=
X-Gm-Gg: AYBFou3b6mwEbT9aKv4Jez413BB6eON+I9iv/X0gkYWLxqTLiWdMuY8jpk+KI6/L7kt
 Hm/lBcqC2x9xogvHxuqjccGK3NLVHPCqYGDHhxiXuKWoo+V9mSfIWxX7+Y4SNOkfeGH3XCkq61p
 Aonl2yddouibSgSy876CeAGESznQ+4TU118OzGWMuYkadYp2Cg+HqJuxfhMr/ZzCDBKTEKaDoKY
 /w/2GSCrVRd4h/9gDyYrxm6pIJUe6KLStTICI7evda2SlUa8OXR/6B2+9tPaAbORRQQD3vMqErc
 8s/F+UmriACNoEHWtd8H6B5B+cQ0WJmubZc0f8fsfvbd4ZRW9/4RbuehMwoc4EROodn6Pwij/bP
 R2n3qVtSVyA2LR9oQ5SrMFeTD58JgYJo53i2fH33eahX/zc+ml4FzMyeCUC96iCFnZc4bu2HeD4
 ykWg==
X-Received: by 2002:a05:620a:199b:b0:93c:ba44:673d with SMTP id
 af79cd13be357-947aff95577mr885098885a.23.1794469411409; 
 Wed, 11 Nov 2026 23:43:31 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:93c:ba44:673d with SMTP id
 af79cd13be357-947aff95577mr885094685a.23.1794469410915; 
 Wed, 11 Nov 2026 23:43:30 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498361f674fsm15362522f8f.33.2026.11.11.23.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:43:30 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 12 Nov 2026 08:43:28 +0100
To: Carlo Caione <ccaione@baylibre.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 2/7] ufs: rpmb: stop the model string at its NUL terminator
Message-ID: <avVuIAS7CNosHgXB@trex>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-2-701a62dfa034@baylibre.com>
 <avVgZyWj1qwekTVJ@trex> <avVk7_noolHp0olO@macbook>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avVk7_noolHp0olO@macbook>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfXyhIXTZg1Tws9
 76a/cVQDNyvoUaxoZQeyHLcALuOjRhC2BiWaBPgYCkfkBitw9+UIDc8VI0MLHw7xPPx+q8WZ7XW
 OXJJWvouJjiYSygITND23i8fbCchF+w=
X-Proofpoint-GUID: NmxGLuqK9Se9LX2BlxB5OSa2wHgQtc5d
X-Proofpoint-ORIG-GUID: NmxGLuqK9Se9LX2BlxB5OSa2wHgQtc5d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfXw+HsCd2L9E8S
 wLOA+NmQpYcnhtjhoTDqiFApwxyAeNi2rh5ppC9vqZu/bRsvSIDLb+HfhwML5/OcHxWVcdXctV2
 7IXb+nJjlyGlyW5589130CqgsBohbKJNi/Jm3ExW7AMTzk3jzXAi0l7tTf3LGe+R4jimnG2R55s
 51Om48Rp049eT9judogx6y9IN5rn2qLHF408MhymZt2RRMzuqZ6BItq4k9heomi4aTCq/E99nhq
 CBMT66x2Os2zCb85eWULTCw6YgP6vH5SoiJMPDgXqgUSngYInYyc5NOJA/jFpRz7aRNluvgX6U6
 l97D4niZZEIaRVRar9v+vfkzD5oN5785qk+OG93JGrkJQimt1k32VdMi8Q0AzVgCcQaG2G6wSux
 BylXRuee179zu1fZO3Fy/15md8Cbli714IMx5tabuXE3Yo/VO2T+bhfyYg4V4WSoflvxn3zytnH
 lH7SEYicRIwMM3XQaEA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af56e24 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Qdnlg_FFGurEjTlF3l0A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120030
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 12/11/26 08:07:36, Carlo Caione wrote:
> On Thu, Nov 12, 2026 at 07:44:55 +0100, Jorge Ramirez wrote:
> 
> Hi Jorge,
> 
> > > diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> > > index 508eb74d976..8b61760f071 100644
> > > --- a/drivers/ufs/ufs-rpmb.c
> > > +++ b/drivers/ufs/ufs-rpmb.c
> > > @@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
> > >  	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
> > >  		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
> > >  
> > > +		if (!c)
> > > +			break;
> > >  		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
> > >  	}
> > >  	out[n] = '\0';
> > 
> > 
> > have you tested this with Linux - RMPB access from u-boot and linux to confirm?
> > AFAIR (plus the tests that I run) the code should match.
> 
> Yes, I did on a Genio 720 with a SK hynix HN8T05DJHVX105 UFS device.
> 
> The problem was that the device model descriptor contains two trailing
> UTF-16 NULs. Linux's utf16s_to_utf8s() stops at the first NUL, while the
> original U-Boot helper converts both to spaces:
> 
>   Original U-Boot: HN8T05DJHVX105<space><space>
>   Linux/patched:  HN8T05DJHVX105


ah sure. I see. 

it was just that I remembered an issue I had to work around (cache not
being invalidated on the descriptor on u-boot) so I remembered testing a
similar kind of check but for the wrong reasons.

looks good, thanks!

> 
> --
> Carlo Caione
