Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71277C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1853A81326;
	Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBfjS_I2PXTW; Fri, 18 Sep 2026 20:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2643B812FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762016;
	b=NRgZp9cww5TPSa4NtxzjL6jK+vAk0214IarqenMsXk71ovwXBfcx5KW0FMjB8zwz8hZV
	 cBjVuNCx8KtiKKNM+xKgw/XbcfcFJJCgyhdaIoxwiYQSvuqNKT7x14e8pFP9cezmStRhV
	 am1yc/0fDuEHobWY8yKa+CMXoyNV5ofqQHugoFXTOBktrAT90b66DkqtCiwUnxsIh+5Jd
	 OWpW+lLmo2teeTTK+sBtTc8A2JOmpGHKVezCL4t2vFsx+WvE+cXSHLdDfE+QQMRaP0fNS
	 mI7zHnVHQxRtvd2YTSsbjRZYYmzNwvlwvyae8ukmsdKvaqNO/5Te4voGskm0XBN1hYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbiH9Ae/LWk=;
	b=p3qifooocVRG+Ka1eklCr3iXVu5MCu8JD5IhBjgish9ROUsDYG8D1H/Tt95vnczJzDiq
	 MLU58Vq6Qeg8k1mrmsQMIHYOOWGiWcgeCzD+IaJnsil+ICMbRh/Yr9+ow6E4N3PQy6RnR
	 1ic/y14spbbw3O+WRZ1fd0HHqCXEmzU0trpBqQoYZ1aPv/xluCK1KjBT88abxceGvbpeh
	 iUQxz7REnIgNTt5VsQ+jPMMp7K7Jlg0DOcAJHUaS/sW3x2P7b/PiDoKyU8bhI7T/pJXLj
	 Wz+3i4jFd92NoIhSE08N0Yed/AooQuSWs6c2bFBo2ZjnbAxAPMrqmARGqLO9YRN6b1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762016;
	bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbiH9Ae/LWk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L6smNN4JldsqPC1AykyhQUlQQZUDo9Zmbs7R6Zfvs8EuQIYlMGVZmIODr1YnJfmc3
	 AolSP4q8E1aHg67l7NJmUJ88yvB7COXuRNxMIcd0LMDhHnuYGNm3BZ9ePxvVGbFKOM
	 1yiyf7IKa5YdkW8IABff2sw1iCcOGSdfoKx1+2mEH2VdcdqtqjfIMOljT9vtOZePsf
	 BA8YYA+X3OgiaYl017VKeQVQYQ+EbgDNoMCK1sg21RvzSqS9XKbIIRYroqnai1KN6Z
	 eVLdsOpnHvQTda6JJjtiKsgoIazeLSF5XSeePBV/S0BMU6f5+KGdD3O6QoN7uaPCl0
	 lniyDdd5vYKcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2643B812FB;
	Fri, 18 Sep 2026 20:06:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A53EC13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ACFF400F8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NR89o3p38pR5 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 465774006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762013;
 b=odV61RCwauDAm/QiM9mBTtbBk86NFk5Vg+GnhcguZdxI8lJNM5cA8pN+q1ddYkbNp8or
 cTMOuFCLTGmUsXoy4O/0XBKovwChTyGq1KCTJqD2weq+lZzHSREGX+I1XoEhG9sY5BKDy
 Vz+3eOSObmSGMA7SvMOHNT3M4QIYbebc+pOnyA3MeMwww57BgmaJVHf0ntzwIE65Hbgm5
 FWQVPflFMlDj4RhS3BvqN91PUS6bWLOgutAVJOK2jf+augalU6R810qPrFjNKRdOSbdpF
 HDtvUocb0wkx3C5WqZPB71rfsOKFbeNG3GqFGoA4wavxvY8Ge2hL+GEj9jGBJ6spPbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762013;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbiH9Ae/LWk=;
 b=YolwRwwACnZdQlkoa+Cg4YGhoOFMnLW0z001eOzhwEwDFFPhUdYDNYeFeLSLoCyxv4rk
 SYhBfqGXVL55u2RkPCQ+JlimsMXWlUu0aC0htsSo9dGLFYDjvPLzZREGx45j532ZE0eWc
 ul7o9Rs6uVon+uK7K8l5bGHN329KCyfMFNw6y9PNKwPl1rw+gmPOQvNj/8nEcQN9P5ISA
 cnwsco9ylZZpvoRrH5qDIjTaNUWuGoAYaZWpHUjFFxaYQ2oM7IjrDqtXbEs73wyXAuEnJ
 SqcYg0tEJZBKOxkZO/M3tKe1B3W9e5JmHxFRc7jlOGHgaAwO+VhMCll3oMYBpRNrpXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="P3/9P6qb"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ifklVJ+x; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=P3/9P6qb; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ifklVJ+x
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 465774006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGo21S1483049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbi
 H9Ae/LWk=; b=P3/9P6qbJlFpC8QY0ecg6MPnMOVcEm7Qa/0Y2aYldbtRK4/6N0W
 yTTAOPBYtVzKrrzETyJuU08NMYiRFyjSz85U5zZPYwf7/kBsvXP+dKnQW/0KrDgW
 Zo7+WH/vXronJK2dWV4jd0dHt6f0YfpHkOe0znfsOF2vCXmwjuI983OR96TAmpur
 KlS0dtx+87qK1iZyojOyRrtwspT1V45xBEsQup/ZMlYqXQGoY8gGl8KL6LO6x1Dl
 6LCU6PzSysZUlbz+hMERg3etsDEhiz2KjS4LEz1iSQqGel8FwsVMyFcVrhZ8UWVu
 Qjwog7ao9kQ8vZpBTznGDUodaWLICoNSHnA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs7jk9be3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90e8dd8be81so12935836d6.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762007; x=1790366807;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbiH9Ae/LWk=;
 b=ifklVJ+x24H36ih0EkqAhMRxLFEZtbAKBTPhhEgGDS/nKtEUd6tobp9F4dvYlcvKTB
 SvIZesiPsvj0KT0DLQBraStMCKDLlotN8QxHMrR6cdv01OiIfacEj+xdPU90r2T0NNOM
 AJM5uOyQ/w2NRO+qwaxrFfFK5avWz1oK5QPIgECQfCK5J8XlwuEklhp3ZnXFI2L7/f2Z
 T2DWu30XvQsq/pbLx9SRHAbMlox6RU9v3YsnI1oSywBKNgdTpLPbwkPJBykHzQwU7Sny
 Wh9od8+extMeNEGOAqi3TDAKKypt+7m6etOcCAq4/4qrrw36maK4qcedz2bvRclWwUtN
 rDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762007; x=1790366807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7ZPAMT7M0y7rjDIofe8OgkSfacWVBQGbbiH9Ae/LWk=;
 b=bIgbZn4hHPtk4YfRtUXDuHXDmttH8hLlSTAZpSaAOmi4uHVkMl1k5+FnGpXV5PxAzv
 TVTmkZ3J3tJkNOx6UxemxVO32T6naZJGcwDRgQ5j7tjBvgKW7sZdNvhud0NRHfwteqlc
 14bANQSXZJTETtbUzmjX7ECihjycXjEq+FCsWX+o5T2FPgOHWgNwcbRxAPsRCa+9dVnb
 IvGv6A8GbEcyw9mlxKwUlr8NBsTlU52hJM4G4EqN1BFngzo3HE/XMdBIggtq71o6eIlH
 mnu5DtmbWXWQXt30J185obxCe1YwTgddyh0k3LJjFHqF8PdNA7FOGPBdo1uUDPGGU7QP
 mYeg==
X-Gm-Message-State: AFuF++kW22Zwx4GOrdQZ0hYQs9djIWmrlzz0SkGOy1TnBryYGhC+l4Ob
 Uw7VSpcTG8zp+Zu8EFNa92wyJwWp9C1XvZ3KaC4XIBibN37UgPzuqQSgbIHyPoz9DeRp/YjyGTG
 MsDAPno9uPB6JnuE7Qw6nzTfBM8NkkbpWGjSk2mN4pbV9PNJBJORR7N+Z+IupPBzLdBRMcIc=
X-Gm-Gg: AYBFou1Tyq3sF+Xrd90Fc9M7UOqAtnK+Sz845F3mNiB7/yhPhjC2sEEl5KjhQnZkDDp
 1Ihce8RAtaE1qxvCl0xWyAw6fNOt7RXyCColi8/dQkn1aZ8RHYXa9j23FYHYgEAxM3d6pvCj+MH
 h021F8Y/Ql6h0hvJSmaFeg6++zkP9TY0X4mSjMSGnR5BZi1x09RvvH6OiD1fWHWmeQeoYVDqNDp
 KcEELDrsKo7FSmn8/u+3D1V8qim2H4VIX3pRooHMTD2FFSpMK1+/0GvYXH5ewFz7x4wKSzdUp0d
 Amoti2IH1A0anEgcrZqat0Uzf06QS8biz+ArJEhwna4bTXVrASN41kIz0GMXI8qeOU3PC4jJZg2
 zugX4tkBOkGg9z2RrhyBXJxu35Qgh6cBWgvGN92gS5JUAUc8=
X-Received: by 2002:a05:620a:440e:b0:937:2d64:57ae with SMTP id
 af79cd13be357-93bdc4a333emr551094685a.0.1789762007378; 
 Fri, 18 Sep 2026 13:06:47 -0700 (PDT)
X-Received: by 2002:a05:620a:440e:b0:937:2d64:57ae with SMTP id
 af79cd13be357-93bdc4a333emr551088985a.0.1789762006876; 
 Fri, 18 Sep 2026 13:06:46 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:45 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over UFS
Date: Fri, 18 Sep 2026 22:06:32 +0200
Message-ID: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GzzhjBadXoEnGAgSYmDMsQM9l61qL86j
X-Proofpoint-GUID: GzzhjBadXoEnGAgSYmDMsQM9l61qL86j
X-Authority-Analysis: v=2.4 cv=FeSiV5+6 c=1 sm=1 tr=0 ts=6aad99db cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=PeKjsYscoj2S2kSig-UA:9 a=O8hF6Hzn-FEA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfXw+mDuvP7Fz89
 8OOMAv1ZCKKJYXiyGO5QDjAL3QhoL8xSoPfv0OEuFozptc2j37gHOU++JmtxKEkA6iFLs0fB5TN
 k8pnNlc95ROvJRQgTeUahZgRTJn47FE3o8qilQlQM/skaoroVTLZ2E3GFTyGkwzXfZMWSBou3Xx
 4rKpSH3kt9ayjttDnCdMzhwTkziaKOQLYwShiqHqATS3JzS5ItK2HJIYlSiKATZ+DoGWxQ/KwCb
 JLOV2pgyB3JaXjtSKkuVy/1ZDsF6rzAMk/C259nOdumyq0AhBgrTePWeN8MHFtJ/IPskei+DwVZ
 39ZsBDASRu6FOQ453vOfz3iy8wOPZtEp0OTEKFW26sZ9d3WHuBjexCwjr7g09qVQw+feSPpuKv4
 EvGtpIxr56khuwMw37IOnPEgkahex60R47m1SL1jqSPN/6ULUTeU3mKJCdDw5ENWFh25rFckyQt
 D/PCj+KsJcacqevGyUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX8QSB+cmMgYm4
 gWCWIRsgIZCtVcciY6LeKzsaj9h8F4MVk6DYDfzDhSWhJDIPEaszmwIn8XToqHR4xr3OCx24nCu
 Jdh/RAkf2XDNEfCx2eVNOWPNyAhd+2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180290
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

OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
interface, which is bound to eMMC. SoCs that are UFS-only and have no
eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
secure storage from U-Boot today. This series adds that support.

It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
(PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
the RPMB device and reports its kind, size and CID, then carries the
signed frames. The legacy eMMC supplicant is preserved unchanged, only
renamed to rpmb_emmc.c, with the new UFS backend added as a separate
rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
single RPMB transport. The subsystem interface is UFS-only for now; eMMC
can be migrated onto it later as the legacy path is retired.

On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
device-id string the Linux kernel builds (ufshcd_create_device_id()
plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
the one Linux would use.

The first patch is a standalone UFS descriptor fix the RPMB path depends
on (UTF-16BE string decoding). A small preparatory patch surfaces the
RESPONSE UPIU sense data from ufs_scsi_exec() so the transport can retry
only on a power-on UNIT ATTENTION; the transport patch also bounces
unaligned frames through a DMA-aligned buffer for the RPMB WLUN.

Note: reading UFS descriptors reliably also requires the descriptor
data-segment cache-invalidation fix, which has already been posted and
merged separately, so this series is based on top of it.

Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
programs the RPMB key through U-Boot and reads/writes secure-storage
objects, with the derived CID matching the Linux UFS device_id ABI.

Dependencies:
Linux kernel:
 https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
Op-tee
 https://github.com/OP-TEE/optee_os/pull/7881

v5:
 - ufs: decode string descriptors: added a Fixes: tag; the EFI
   file_open() callers now pass UTF16_LITTLE_ENDIAN (UEFI CHAR16 / FAT
   paths are little-endian by origin) instead of UTF16_HOST_ENDIAN.
   UTF16_HOST_ENDIAN is kept in the enum to mirror the kernel's
   utf16s_to_utf8s().
 - ufs: new patch "surface sense data from ufs_scsi_exec()": copy the
   RESPONSE UPIU sense data into the SCSI command so callers can read the
   sense key. No current caller inspects it, so behaviour is unchanged.
 - ufs: RPMB transport: retry the SECURITY PROTOCOL only on a UNIT
   ATTENTION sense key (using the surfaced sense data) rather than on any
   error; build the status frame with put_unaligned_be16(); move
   GEOMETRY_DESC_RPMB_RW_SIZE to the per-region CID patch that first uses
   it.
 - Series is now 6 patches (was 5).

v4:
 - ufs: decode string descriptors: dropped the in-place
   ufshcd_str_desc_to_cpu() byte-swap helper; instead added an endian
   argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and decode
   with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s().
   Existing EFI callers pass UTF16_HOST_ENDIAN.
 - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
   put_unaligned_be16()/put_unaligned_be32(); drop the
   rpmb_frame_request() helper in favour of get_unaligned_be16(); move
   ufs_rpmb_read_geometry() to the patch that first uses it so it is not
   an unused static function during git bisect.
 - ufs: per-region CID/size: reject an out-of-range device-reported
   logical block size before shifting and split the size computation into
   separate statements for readability; order <u-boot/...> after
   <linux/...>; note that the serial hex encoding matches the kernel
   device-id ABI.

v3:
 - Renamed the legacy eMMC supplicant to rpmb_emmc.c (was rpmb_legacy.c)
   and kept it as a pure 100% rename: the UFS RPMB subsystem backend now
   lives in its own rpmb_ufs.c instead of being folded into rpmb.c, so
   the eMMC path is left byte-for-byte unchanged.
 - Added CONFIG_UFS_RPMB_CONTROLLER to select the RPMB-owning UFS
   controller on boards with more than one UFS controller.
 - Reworked the commit messages to lead with the motivation rather than
   the implementation detail.

v2:
 - Squashed the standalone "retry SECURITY PROTOCOL on power-on UNIT
   ATTENTION" and "bounce unaligned frames through a DMA-aligned buffer"
   patches into the UFS RPMB transport patch; the series is now 5 patches.
 - Reused the existing ufshcd_read_desc_param() (now exported) for all
   descriptor reads instead of adding a new ufshcd_read_descriptor()
   wrapper.
 - Moved the SECURITY PROTOCOL IN/OUT opcodes to the generic SCSI header
   as SCSI_SECURITY_PROTOCOL_IN/OUT instead of private UFS defines.
 - Factored the UTF-16BE string-descriptor byte-swap into a
   ufshcd_str_desc_to_cpu() helper.
 - Dropped the ufs_rpmb_get_scsi_dev() wrapper; callers now use
   uclass_get_device(UCLASS_SCSI, ...) directly.

Jorge Ramirez-Ortiz (6):
  ufs: decode string descriptors as UTF-16 big-endian
  ufs: surface sense data from ufs_scsi_exec()
  ufs: add RPMB transport over SCSI SECURITY PROTOCOL
  ufs: derive the per-region RPMB CID and size for OP-TEE
  optee: rename rpmb.c to rpmb_emmc.c
  optee: implement the RPMB subsystem interface for UFS

 drivers/tee/optee/Makefile                |   3 +-
 drivers/tee/optee/optee_msg_supplicant.h  |   8 +
 drivers/tee/optee/optee_private.h         |  41 +++
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} |   0
 drivers/tee/optee/rpmb_ufs.c              | 141 +++++++++
 drivers/tee/optee/supplicant.c            |   9 +
 drivers/ufs/Kconfig                       |  21 ++
 drivers/ufs/Makefile                      |   1 +
 drivers/ufs/ufs-rpmb.c                    | 347 ++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c                  |  38 ++-
 drivers/ufs/ufs.h                         |   7 +
 include/charset.h                         |  17 +-
 include/scsi.h                            |   2 +
 include/ufs.h                             |  10 +
 lib/charset.c                             |  15 +-
 lib/efi_loader/efi_file.c                 |   4 +-
 16 files changed, 652 insertions(+), 12 deletions(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c
 create mode 100644 drivers/ufs/ufs-rpmb.c


base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
-- 
2.54.0

