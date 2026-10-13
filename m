Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726C2CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CE7780C86;
	Tue, 13 Oct 2026 05:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teer41QaNYtm; Tue, 13 Oct 2026 05:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79B2080C8A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869602;
	b=FtVfOVAm7mfbrz9dqWn6+H5Y95oIJjJpKxypOYQ5d/FSwsZpd6fFfatZ6+k/TPKPzf3E
	 xRreQ9A1R2caIK0OOJa+EZSTg0NkLcxh6Egjxor26ke3tokaNGIK1TgsICoGxf2awl1JL
	 ituLl1DgUAuusfaTvpmnya0bDYkSKBHvkOWsRgHy2M0i+qeipr23bmqoe0QuH8mq5y0nc
	 CQslQgi8bsKvz9FVycKjWJxWvmxoZzJ12yUnbPMYQh/VT9K9kn6T+inE8Q3+CDUcT6vxf
	 KCaqZIwcp/WyQXuTeqSSBfMXkH6dHC0uzHS5wP5Ig9ps/15L3o4eUfb7OSJXd0FE2cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	b=nacB2tQHHFbpepwS7wS7RNevVnDuaFAdVyGGVm5qiHn92nKxffFKADJr3sOa7vQCG9lc
	 d0rEylN6P1itGEPmtLN1T15304adHtmII1zDZio5PUqmmu2leQaQo3FZSo7mhQUGIBW01
	 5+NRjFgDZGOy7A3vBvX3MSTyHHs8w9CzpiC7YIt8EBNDgY/M+VjvB9kCDs7ELZ9g4RWNo
	 W+XjE4fvj2KWnww1C0/EMYxiuADEtGSPYfEtVwcYO+TnM+IYvNd4S89V9QiZL1vhek2DM
	 +tP8lxc2JEq7Ku8/pcRjaZZoPeJFmqWDV62BKFJYZw4vbfKNUNw80gYgc8J9xUfOh2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869602;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jaW1y/wVfaBfteidHXkVMJtD77PWE79fD7XlnSrhHcKcJm4rE4ANAiC2jcOEy1Wim
	 bp4aSSYF9tuab+umho480XZc8VFyRTS2ilOOfzYluk/aHZacu6o+AhAm/MT/6PDZlC
	 w9VMebjhmUDOFB0XbfjPw7t6HizUvjX+Vn4+H0sxKYVnwagqIRfBnfyNP/+EOT1jMd
	 MClwRQRnCPl45erTAhP9cpqceeDJx6qHWdAlBKltwnY9X2youEgoaY6qQH/4a8ANRQ
	 Cb2KTowoAc/urwVTebe3fyyEfL11tmQq0MJTs8DkINdteGQw/t6x8/nWZwyuaP9xq2
	 6kqme+8qR0NOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B2080C8A;
	Tue, 13 Oct 2026 05:33:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2FE4DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AE3A6075F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6GqLEwCGZXo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A419C60743
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869595;
 b=W1Loyqg291M2UXhmRKtrK15GD4G+x3Wr+Do+Bp7uKtOhrNWYec3IesV8Cl8Axluez8yU
 ah5jqfJPD5fo9sWv+0lCKjvChUt+RL1t1MATeKu3OWq5CNeJb3oNq7XT9jmeL5qfEh4rD
 /FzfOLIRy+EtklZE7kSyphUO56GVU0R4VOUuFnHgQPRpR8BTU3Z5I+Dr47JgNC3H6HHmY
 kYfmkm6ArzOy9eYDtf1o99lS9Pgtp4Oil3jbJDWiYeO+ZIbANDCK6klLvEQj1INFn6jhz
 g/FyXJX2Pk3R+8UxfTrMqxPPHqkVSHGDcn83xnBH6jrmew5/XO2kkPJUYVq1YDJ527g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869595;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=k7Lsz33JIvQgwed2iYEVBD0LFb0f4pPxNulAF360XKIdVBRUjJkbHUEdNftffbzrDpeD
 o4TEQ1p9BnyIdT/2Ns2eJBKSLb69vz2hCN0g965mT870tu8hR61qB6pfoaQ948L8iT9Hz
 Wq5s/e7doGLB2TCYi+WzFhKto8UeLe7xFoP92cSNl4sol1Rmb+YtxZ+7auuNBjXewjOSU
 tYiX0ixwFDIradRf1YI0p8JSLZlZdMeEu3OM4M5+auNJdtem69iULsTZ5N5Y1ENDJ4XBo
 FDREfQI5Yx5ck1CPGtTeJZQeEEcIBPT55dERnnoqWaOJJtvYW1BUUB5TnfDtC9rLUdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=juJHGWA9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d+vZVwhY; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=juJHGWA9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d+vZVwhY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A419C60743
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20w5f3907983
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0lxLpCVJYJ
 Jhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=; b=juJHGWA9U1c3iWXMeFeFBIwY8Dz
 fH7bDi9B0dCIb30sCLOQmUN5zYEgvinf9GbXYzAl+PBH7iw9fIl+AQCyAax+qiG+
 rV+QXsYhhj1LXA4Tj94cOm/Qi0oWrgvHkyhb2Yi4UwXSUVo+kZXsOGeV99SWjgJH
 9XDI1M4nisWPY8jOL1sHDTIFB0+hOlNVHPoA4zzLXydg/je+tq7L2IMgfRroD3ha
 fF2QdHn0/4J8/HWGYEe2u3OWMLW06Y7uUVM+1mDHFUN69TGJnZ7OBTx2UpeVckv5
 ElcrJKgEuvHK5R713hRzIWFtLBuvgvJ4TqVB035H3jsVF495A4C56HEPUUQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqstd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5284204eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869593; x=1792474393;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=d+vZVwhYVlNk6c8GV56+G8cAI4RN9WwYl+R3K1dof43jxEiI9Z5Sw3oS3hixF/857u
 786GmFqIucF5dLaje5dcZeFOtoSyTBx7T8xIILd2DOV5IdO74PJAjzp77fIUF975N0Kh
 XBiqENGcBczqBIm2mazXvO55L8OhysUCBDUYNksNws/JtyetfJ7Gy1+lmckYWHLV8TI5
 yZi6A5fIWautS4BLhCSI5hJTBnhfP2hotJN55WLATpM0+j/KCYxjH+cqHaXWxQ8HrRmp
 7jaKiq9HVID8bkHM0F2P7Tzp117CPXcX+ibXGHMSjDgp6x/DeO/gOHgFHZdNGYwx3d5Z
 Y/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869593; x=1792474393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=HtNFB3sqZLMXMwRwADfF75/A/Mx15FsmOlbBEpg/j4shtYVu+ZjIc+LCsKFKBKFRqW
 JeGIVXuTCCeAi0qmTt/YjJit/AdUvNxmiP0CiQFJiwOmurYcRhPMuSYvcdUXsnGo2P7M
 cuWqGUPgd3rxpbgY8eKkGCV/kSMk6tMvoYZ+ergdeeA2o8ztE0BRXS35YDFC143FM/FJ
 uAWcf25m7ZaeeCbRB5oMtwX9rek8pUFGoIKR2Zdz9F9VSPl8zuxKN7/CkOT5XOllRKXI
 6IHXqO/Dl7cJUpur5TmX7tI2Y1rNI6sefI48/W5Qx7gkcR94zipWQucquVtlktfBMBJR
 4WfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5hXbAyOMEz4SNGcUAiXTksLZPuNVxTNsHzlXMAlMsF2Uix6+l24H98jIIFyAIAUh31czOXqU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ+iQyZSYwMNNdd81F/K3Jd8ds3pPAGg59mCtOjVGd/hP1F3Chw
 sjCs2sToTqjztM7Uo3XQgP0gnw0d4CgzCtUhTqeAWuwH9cAnM4Oe6+5Uohd9uxAhXMNX9ouTkMb
 D+PeCbUkydn/+jn5CTXxUKgTQ0h4xVqaRJWpXc7YLjHFyBJA9cLOBweX+DJ+4HUSYTgEpM6A=
X-Gm-Gg: AYBFou049cri3FjAI8XwmpYsX2p1/kYi2zJ+netY7NQdQpIlJ+KlpWUDKLuM2TBocAF
 BbulpdOqmSsk4N4qp6ouMxajNrxNeCHoS3r9QEha8UahScCOM8hb2I/6jnq1g/Qtteb+/L+cnjW
 4X5+iSkUhg4vPpMDTv7NEbpmLG83LY4gAQXCMdrHsuuaHxDxvgxcmCU23KjU7/uxLMoDj73auaF
 qVp6bIHbIlQWuslauwg6qxjwhkRXZaR2G6KuL+eCg2yoKWXD+d4FkV8I42asCSe2MnPPIkov2I5
 e2mSV2OO1UskqqrTACyr5yufwhiZ1rwaXNCFeRKVM9Sh8K1vyRIK4tx48SQLSdRwH/5WUukz9tJ
 aGs4Terc0ysXpLoJrHxALEZJrrh5NMX4OnpyvJqU2h2DwuqE=
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id
 a92af1059eb24-16a5dcf5a62mr16318528c88.8.1791869592977; 
 Mon, 12 Oct 2026 22:33:12 -0700 (PDT)
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id
 a92af1059eb24-16a5dcf5a62mr16318498c88.8.1791869592195; 
 Mon, 12 Oct 2026 22:33:12 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:11 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 12/13] arm: dts: shikra: retain SPL dependencies in IQS
 overlay
Date: Mon, 12 Oct 2026 22:32:43 -0700
Message-Id: <20261013053244.2954876-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXyWS1KubUepb7
 nqopuiHL3K6RQa4wAEnuxJppstiaaSSZPCdWZnLJnsmHUpvy84QrYx9SVCNwljjkcb3DK18Rrr8
 4e5Iia9cqKzfVbI4N4N9yi5+gIEV9nTufpSzvp/xc6nlcvgNaz3qWIsJ+4bCPVPD+Za8Cy6jY7A
 UbkqUO9h3ca0RV5Pd5D0N+KgWnZoT0VAKrFm/gO4xzZSmWxdW9ooMeGidkNokUon3Z+TbsPYjDK
 HDCEMB46JYe4Lo24KZuJgMNrR4/RtTIfUQ2WggPLg5xlb4prX2lY161yvXC+o4mM3BdKzUCVX6w
 +vKNKF4ib8MRDSUIropc6sGx6FbIMb0GmeD6cd78glY+EyHmHf1VxDVzaygKT2ZZYIIHo+acigM
 uORBvAYdlAMlYRc2ztiNLoRzGqVcLcQR3wciTW87nL31sqYthP2xysYOFzb4iPcQPePr8Vtui4G
 qzAu+O4Bc8pSgkWtgnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXwEYmd1Njjtbg
 Rn0MIfYg1+IBasFdSSYTW874O632HsurRkTmirrLH0buHde/sS3iqw5VNZDRE3rGjEa3JD0Dac5
 ug3RXmM1xpsyQhR9yAP7W8gozU0D13w=
X-Proofpoint-ORIG-GUID: VtOeXmZdZMD_IZlHiiqwEpwLd2_-E8v8
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acdc29a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=qkSexMeQyOevtdx1QFIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: VtOeXmZdZMD_IZlHiiqwEpwLd2_-E8v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

U-Boot proper uses the IQS device tree on Shikra. Retain the SPL console,
QUP firmware storage, MMC, clock, pinctrl, and power dependencies in the
same overlay.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index e807b91ef1f..a1e506f7dff 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -20,3 +20,45 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Keep the console and QUPFW storage paths in the SPL device tree. */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

