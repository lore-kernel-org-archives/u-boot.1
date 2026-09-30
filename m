Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91016CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 08:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1CF140A3F;
	Wed, 30 Sep 2026 08:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfjyKPno4O55; Wed, 30 Sep 2026 08:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D3CF40832
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790757233;
	b=JZTpoE5kjN/qw76VMCEyNxb1+rP5lLHRZXxjrAFLcbfctF6q8lSx8Tk3oSm3Kwxnyft4
	 kheQAvoxoWc6hXCqRQp7Gnu7sn26khYdQTHKt5BJw2MOn2juJmFffwa7HwU8S6uis5QDw
	 ouCsjRJFIjwmfKgejXnFgtfknRcUbDksb4kCTgWteyaHiYiCYGzJqBQ1TVy7YopoGxWXY
	 lrwrPNd3j9F/I9DcM++clD9D5zyylpu6+xdFdNNS1F4+L5+Gg+IR0PYxsmuZYDjF2wDnA
	 HwuShXA2CGKFJMGVqGFNZg5iJzJisicfxLiulbTlz5esp4KSPwergsNOEyxaCf55PNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790757233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid68DZXYyI=;
	b=LK8NgBgHE//Bw8ySpAFYjHaXqN7HNMGNZ8Cn5TtTJvTkCiHbbLgpVysuwdbQWwGcIkYB
	 FkFMit8AeizsK0qTXUk00Z/43fGqKDhZOrNZeVoe5wXNKuUm7VegPwfvJvl6r5KvZzN2p
	 CRgnpzasBcoPYT1WwxV29/YmpPsv6MA/gXSZnfnr3mKgH7oz0E1b4R5+y7dZHITtgrWSx
	 aoV75755Wa2bQGhNHOLknZStjxdCRJWcsCw1Z7uPJPKmDlk4H/s/P+Fve0dv/JHS8THNu
	 hDk/m6iK3v8AzCL5ZTAyqWgsxIFgICe1KcWkQ5vogfDKehkzwEmS9p/WBjZ//lEa0xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790757233;
	bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid68DZXYyI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vGZf+sufjCtXf31ZWR1fKhlBudxfspoM5mdEBKY4m33HmSWCJ9M3eg0ZE/ygY554B
	 7SsuW83eClObzdBWnlnIoCTmScXMawyFo+Z3SbZG4kyWjfktpiyx0NDhCUhdPYuTzG
	 25D/rfkRF8gwGvoN6aWn43s1kQnIYhiyPa6LLex1jHGkwkduaQTrL0AUFgkE6wHz5b
	 pv27VjHTT69XSdje6Hi3dgGEnDDAtJoUPLzSdX9bzVhWIWMIZ2dbd0w2nzgL4qxZSo
	 KC0KSsJVYeGpuFOKVENxWpOFnK2voBmR6kfsiDDBtNkhSh66vaP1XISoW0JmXk6nbv
	 gjwqfIjRpKS9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3CF40832;
	Wed, 30 Sep 2026 08:33:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA031282
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC11C60814
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndZQ5nQTgESI for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 08:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CAA32607BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790757231;
 b=eBoOpYGX6VVKYaX6ewsS6TejaDnYDSzwbMopoS5Idp3Qr0I18iMYa8nmoHGdGhPcWVoo
 +8m9eUbFpFc5paOOHlRar94tx4Mu0aK7drnhqjUSb+meDztIvbXgXm2Udb15KithfqsM8
 w5GwhazF1MrYC528bq2CnvfC5TK8jW9aEKNTTfFj0Zb0cR1gwd7rFub13jhyUnEfHCjEH
 Qjz3CwjEmYS8MrYtP5c3kEOP3jGYzecVl2kZSZ2SUdLq85Ddn05faXgDAbMfJeymgxfqi
 ZP//+7AeTnfxpVK5OQI0P0YdD6IZmhACNGp/7EpV6utsTG72vwjt+pG3EWQR+mZNM1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790757231;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid68DZXYyI=;
 b=saF1m28zna5M/gDJqIweQLy+pv0hAuDcA1bX9oWOA350ENnt8Vt5iiFldKU2MuRGXWWA
 6omaIsqmCCrF8xO6Qoh+6kPFlJHitxa5OZJlAG+BIUnOZhe//QF7QyryEmyLSHcpoRQCq
 biLgHnf+oiyAjramxwOLQ1A8xXSkiGxXKzcbTR+u7nE6t1tpIsG0SC58vuCBidLYCwJnC
 puGMd6dyAFFY9FV5mDSA0LVE5zVLMcEy2Ag7pEnuWBcLuzZyMssI3s5x1yvXaH0vx4dDe
 6dZCOQOKEAlF4H9aeR6DW6IxkJQLkxN3JSwTQKSqG5+9/x5iWblDoHWhJBIMTyvNGYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UwYsfogI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dAb1XzWG; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UwYsfogI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dAb1XzWG
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAA32607BB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dcPK2667086
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid
 68DZXYyI=; b=UwYsfogIxwA2fOlXgCwmk8O5SQDz138/8rqKmvFBvpN5AMWfdrn
 lkrSFZOqJXyTQXyA8vbRcPrcv9KTVx+fhmDpy4wc0Po1NVJSzZuePwvHNjH39yl7
 7v7lN7PAYRwjR1ye96FgNAa+li6I/T66TXFNuKxLF589se8yHGihVbR+U8CFl1Gk
 ps7HVYwmCen5z3Ecm0FDxHFb2zcqBiuTJPHufs0B2VDmGVUIXRhe/cfAYHSeMfRl
 ATbeh4lRsZD3/hNEO4lKLml65LOystjodb2QL7lnPNrlf7eYwiYvUVNpCvQQrw7F
 UUsOj7AuL9iAi2JETJc88Yt3+LWLelevGRA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27g9py-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-313d1015161so2053063eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790757228; x=1791362028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid68DZXYyI=;
 b=dAb1XzWGafyj87+L9qj7GVd1kK1JxlPZDPWhAbU/YxTvEl+p1NgcCBhua+9H0JIoos
 ky39+Y1B7Wy95+EEw2MAOCR6aF3CAGXMWzku0jrbhshBRIaRHPEmo1BvuvyzWVGJjalp
 5DeQjEeebPnmgbpZ/87jhf1d0ZkDcqadCMlqjbx8JvRWgy7DgrV1o6nO05nyDtrSDtPa
 SfgkZLC0ZifMkEKdLjqjN0sH10YveTR1xA/Rbt9ERuTCMgjA36qrEaU+SwFNbUI69wE7
 FCvA9xmGsupqyEjpbEQpnc3IC/6whnnjCYKn74XivOAZosyT0n6TE7xVok2oHeL8zb5O
 P5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790757228; x=1791362028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NYqYyUEj2ugBcREsoJt54o7PeCOkwt0mLid68DZXYyI=;
 b=cwXYL005vy8CR9QA7qqCr6JzpDoLpsbS3iseDHd5Iu/vR3i+La3/XhV/HOCITUDwHr
 l19Ca4905sZBmaBf5IKpzBDRDjniGc2v/7eyomnZ9rwwzG4o6WrIf7hhDv05/WGJodTq
 GhyYvPU6jml8r3yu9anRqIjgbte3VneQntJJENfYwhD2HZFeFFgBpjL7KO2OuVVj4604
 T+KGcpmju3iI/hgU5ySa5hghuOeL/gwiN7EFwNhyohEBgxKuvVkv28UUbELdCKXW74sY
 epyommvPM+WdEefkK7rDC2FD+Uq4I732Sl78SDyALOBtF2stAHWUYoJuar0DXebuf4kh
 GH3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvr2z+L2N5wLdSRxogQ5mv6zGDMlUfbG6wXnvRdDrrI7t+X3LnKdpSs4zILLXJeNzec4fpcoQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLs3D5qGS33xqRuVsAaUqbQsjf5rIAHJzJELORmK1raOxq0mEGb
 zpv7KvMGdcPaIy0Jpa+N2PiI1aPli64WqNXxfzWXXuylxAnz6b+KxF0R5Hi/e852tTImmzDaxtf
 3mgNv9ZkaP1jZUDjomya9UtNnIsp/wKO68RRbFukPmNWd1SK1fOpYZh5yguyex9Pn3f+PxaCEb8
 pRUCY=
X-Gm-Gg: AYBFou2SXqIXXjyxTD2x5NYxjOL4y+X/XqZxofhq1NKklg+LU6c4gZxqwuTTnQkh2We
 ok31ezLkRWvt/pb9A6+DX2uUHodhJeWd//RQU+hMqkTJiaLHCwd4D6+iOrneiNRoWKVsC8X7lYm
 ZXRgt8zy/7Wkvk6heBSWSpt3tthF2SecOhCI3WYzoYwnGCxrVNcxxSx5bRJCq7tefw3uSpm7QQH
 oJ1fxyACQyrFo/g0a02eaR/8b4LhnZcmrTxCQ8Bm3VFPkGuSdLN3X/F3mxyIcRAA5A8yHXPO6Uj
 68LgHqk2MY4VAEJbtjxsgPm6u0xT1as/bhS9UQquSx7CnL7aRviJbUbWRJDCwai0SKR+vEXxo8N
 B7eHg01uKVdvn/Ah2G2JC05O3ZlGNTFXXF2TOiIcdQ3+saFVStxmYvprrX6E27pXGLsid2r0taY
 1L2+mEaHk7wN/rkTY=
X-Received: by 2002:a05:7300:e9cd:10b0:33c:1fc9:3c17 with SMTP id
 5a478bee46e88-34cdcbb2b62mr1203205eec.36.1790757227751; 
 Wed, 30 Sep 2026 01:33:47 -0700 (PDT)
X-Received: by 2002:a05:7300:e9cd:10b0:33c:1fc9:3c17 with SMTP id
 5a478bee46e88-34cdcbb2b62mr1203184eec.36.1790757227236; 
 Wed, 30 Sep 2026 01:33:47 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf5e423fasm2580119eec.26.2026.09.30.01.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:33:46 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v1 0/2] mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
 regression
Date: Wed, 30 Sep 2026 14:03:37 +0530
Message-ID: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX9D2XD73gIfp5
 hT0p1dASsrN0QQIsP6IKEJK2i5lwMhSiQB43G4Et+/ivmccYUlICKTkrtJnviC9xVxbAn0qm7AY
 yvf38ZMQ1rUXk9cgKvGatutqTxERZDU=
X-Proofpoint-GUID: Wc8YZtgOXEm8njAVr6EeTJoIdGJl8QA-
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abcc96c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=dokz55PQ03YXZ2v2760A:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX1uWGdhvMJFhS
 oGzgamYEJ1M/yLdioQfaGT7sy4ez8WSFjgvR530ruCPYuiCMgHQ1Qh9GiFGPoCji9Zm+64yERy6
 P+CR22JfcFnsh5h3tlyW9Ef/DdvgFvZkFkKvtblmbBO98Ena4DBsVe6i8h1QYHryjARm/OkaMZe
 xNu2UWundjspxN4gf/Gz2DYOlsIzzSolJNmRSdVNmskI61UWkA7MykjVgHbHwthAvQASKoHmBNN
 i3FyhI+xifCzwH2oGLjknbQjbPC0zh4mm4p4z3QPb72mslp9yLCGzQRbHFNpA0Z3hlgu7IA27an
 eDtVBpyU0UNe9CBUu6lFmtEYizBiKEssbdFI0dmkSoYh9EN9CTD3myQKpffI4nKxT+4njaE5Va+
 nxKz8h1aAzZ1zHnQ4RI8X+MfayRVYk+iLtQP7cGueodnkY7ZWybkG6dYaYHylFyQSg75zvA+m4+
 tCl37oi1IFxfGWlZgEw==
X-Proofpoint-ORIG-GUID: Wc8YZtgOXEm8njAVr6EeTJoIdGJl8QA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300033
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

A previous commit fixes a duplicate SYS_MALLOC_LEN Kconfig entry in
"arch/arm/mach-snapdragon/Kconfig" but keeps the smaller default (0x800000)
instead of the larger one (0x10000000), and drops the larger value.
This causes fastboot to fail on large image transfers with error:
"Malloc failed for: CHUNK_TYPE_RAW"

This series reverts that commit to restore the 0x10000000 default, then
reapplies the duplicate-removal fix by removing the 0x800000 entry instead.

Sumit Singh Dhami (2):
  Revert "mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN"
  mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN

 arch/arm/mach-snapdragon/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Best Regards,
Sumit Singh Dhami

