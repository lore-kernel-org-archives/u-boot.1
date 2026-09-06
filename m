Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326F7C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4CC880DCC;
	Sun,  6 Sep 2026 12:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PP5aippK9aa; Sun,  6 Sep 2026 12:18:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BCCA80C3D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697095;
	b=JOX1yap9KlhM9zrIHDZhd7aQrFuc/oOsup+BTkb2oIdPBuaZ63a6OAIVqnmK1TKw2fmg
	 3LLWtTSOiSSx+W8Ds5/UKZLRru81llbwt/b6lbRIatt+wDQfDupwuI3V3BwBWARL1nUNZ
	 1sjYbkU7u7CP0525PQ3MTwGvRfA5g+2RbzJYsYgKR/cviOLU8GPtFYPZlo+kQcT8ZXGFq
	 84MopPtE6gXHLc2SLliL8zmvTuYx/1okHdTr6I8Nmv1a/NKkJRlGbLwO8IYSCYEMyy86o
	 zQs8SagYZfjhjTWp0mK3IppjXzj+NVU3v4hwQpyZTS1Hr0512HRCpfyDEu/jUoNwfyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QV422WywenATUHs7qm546ueKFvd6cJuey3BSUyd7P1U=;
	b=ZG+yWbQpItUM+E69p/nRQfyopYbqCISuctEkf/dCPaY1QrmJwipZ2urr2tpBGsE6Oscp
	 P9P3o5w68rF1Ja8KQ+eqnH/5VKtiq4Tsk0CV/P6DcsVl8p7hOgd45eEdmSyJLT5tKXV7K
	 9fiEj3qv1gYuqbHzS4VkydGNPEMSpCRfNM8UbPH+cqX7N9BnGVYMesuoKWB5kd1JoQGsa
	 xXN+FVmv7Vk0SNc3lGvxc/P3m/cAIRRhIQ5qJyLpvIbunQTEIdotSr7ctAIVOLGXy0xCZ
	 7retxwzV/buA3uaWgPI8zq7BORqLqIbpmWya+UIza84w46nl+7XrcbBnWBXaQrVD66A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697095;
	bh=QV422WywenATUHs7qm546ueKFvd6cJuey3BSUyd7P1U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCUC7pmR+JPrU6S2tgr0Ygd14Yr3Tp3hc3LnrycghcsZzjo7PyOZmo/pP6F2x/jbe
	 apuw/mxNzNnZ9W0C5cCr6bZivzts114blVT1JcmU2wSUkZs8jj4KUi6W1id1S4yF/5
	 VCj36oFz2IVAEjyzyqTB2kracFbpXiFhWL+UFBupArvESrYJtH54LmJPHES75YcPpz
	 8ZbuG2p39mFvXlHD/Z7kjuDcAFKr3CnPnQkMxEWhWGGC3LpqcMUcvLSYH9iH7kURK4
	 BnNCHqWC/OTbZgDJ+OU7AU+P42cX1EzF2HVlezyuAFCYqUKUJlShcEjkR8yDcccGhC
	 vsaPFr6C5x9/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BCCA80C3D;
	Sun,  6 Sep 2026 12:18:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22920230
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14E1D40068
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_0wCKz2v5Fz for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 091CF4000B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697093;
 b=i4SJSvoMubLK8sM32DBNxrvEmWjcaxKqFwUM0/7jTvLQBOtrg7UeR/vxQit8HTj8YIC/
 ryQz6qrQpB6kVq4vF9oWKiJlixOXjNDzCq/9YlCD4BjHWR/TdBHsjjLu/Iekz4J/Jg00w
 CcOGsbhxaB5Tw1R57HRsEdxxnugbZu2S0ZOUfu/vY0411FV3gO9PWEkbo7eiPIMSyike9
 /+xhYWriq1pUrsVnvCsN1j7TzE3XD6SXXW/TsUdhhIuenmglaSBIIBbebUTfW+zbNKalQ
 KmgUhgvfyc+h1zkR58mV/UFXP+mYKsSgFWAzyYTdo6dKu10ec432es35BPbUO7jtbLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697093;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=QV422WywenATUHs7qm546ueKFvd6cJuey3BSUyd7P1U=;
 b=bZLaj9Am/wch2QWP47W+ezXwj1E+sQsAicnq/csaDjT1Xhdjysr61JfhOjurEbhFQrSw
 yzWGLBHKRcbq2TBO0FP+GQeo4HMUNBWNEJMX2LpH3PETASGiroT5rFGhQc6weQaiVsfrv
 qqenBbgV9lx1Vr3pqDy5dQT0TgVFlKnxzt8RsWqNktwKmn35Qd2DwCzB0JXz/bGVtb6+7
 aY2Vtl4EgWhB2+tQw89kJdYq1fCtjhyoXKEJzFwIo2fMYW9liRtZrugtx/aSBOgBhGYcK
 acQK1eCklcNLpyNIHOH9lQmZCAEVjXACPbH7pWIE1ZhoTBtFkQ6zb3xKfQwa0NuPZpw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZyVeHiwd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fyl10l5z; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZyVeHiwd; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fyl10l5z
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 091CF4000B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685NxZhT345160
 for <u-boot@lists.u-boot-project.org>; Sun, 6 Sep 2026 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QV422WywenA
 TUHs7qm546ueKFvd6cJuey3BSUyd7P1U=; b=ZyVeHiwdinD4up/v4F9QSLSDHfs
 1QOBQezbOfyeGnT00gsjbP97Dd+Dmj76WDs3bLAy83+ARrNn/XHkGR2Sy/2QDwfr
 iNdQvcGSbnkzy4wq6XDbCAqw77ux6IJ/o22mVcEIarsvLjwEkMkFiLKwUhspg25i
 /v+Wfi5p0vkP5iW7qnvmAkrbbh0kYzpmHRfFHzLlpY30ECzTqfr+b9RqFcsa0sYr
 qS5UZpG4EnZ+FhzeC0hkXlV7xTgJjDXZuvbpYXDf+vxfyjBNVqZGIHIhmQSRLlmC
 hIBeaI3aAqQt6keoncfpfGPK/vui5/9/bf73Xcg6UXo8nSTg5w7wiL3Vu4g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s3jtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 12:18:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso4458299a91.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788697091; x=1789301891;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QV422WywenATUHs7qm546ueKFvd6cJuey3BSUyd7P1U=;
 b=Fyl10l5zLFfz9XFgRAtUSqblaVBSZ4+/pHBDP4mN8rdoFbl+La9fvqGq1TfrpGWOGV
 NB0LJzkHjTwzoLNJtbpUux9LJp6UCrCf39o8Np2fRz90hkO9x61erfTpQ943Z2u1CcDs
 oatoalArdyPuLrO3y7DvA1j3ZhSuOAShSjbGEqzEMigCpB+TS4IjakuGflKj0uWlxn0M
 kOAwdHYB214BFe6Io2kBvMsLUEZX9Y0xM98ynssYM845pykYSe4DhhPSVkW3TB9s5kNV
 pU0qwwBQHZEokIMePSAukkv6VNk2oNXq6ABnDXjSXzfSrcv+MxHRYvHwcNzyUxZP6/nZ
 it/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788697091; x=1789301891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QV422WywenATUHs7qm546ueKFvd6cJuey3BSUyd7P1U=;
 b=R4gQ7fFB869UJ/kOaCHnTdXMAAjGVMMJqlouMu4Ws9b0kKRXj0NChG+6jmRbJ0/JGf
 c9vmlRuz65lStKinI/y2VvplhldhXS86AF4X+NDV/YUBV1v+3Xtv/wr+CDLBuS1BLiCN
 TPYHd8nhQQKTOsns0Vg0t1Q99RHWJR1fGNtMrdVvCA0p2sVHlTrFSUHw2Fa2e4CWh/o7
 OfFCbBe+4BkpbINUBbsFnemXHEzfx9uRv0KUoM9dVm7QZCouNUV4TYkCmkaR9vDuVAkW
 1+qk8mp0FjDmaaH7qLNMjR1LUWebZhbuMwoIE9cMeH56Yqm8xBJQwFOe7/1rbfVidA46
 w7nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB/0XwU11w30hmhJCZJXID4wqXiG2eY8QRA/c4985cZmAHCV2dgiR+sV2xlY8yizbrOwKnMoU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ln+2mTiSn45LOY6xgBLq4TkUghM4HrQHeF+s+jHJ8NX5hoV054
 LJs+CQddnwCnKfHO7bTMrpbknmwQ6DtOXcaiCydJ57cb0oFSlcvl0o7PMZ5ZMYyfgnrG6WcX2fy
 orOcW8LI+B36uqXwXRN4U3tezDKp3qZtvP98lS9AgDcI4gpqddcrLlCWakWj34syH7Mpq1to=
X-Gm-Gg: AYBFou14lieRnuPKy9JZc4E1Nk4HaLD6xB69rtmz7+OetQxqhlLGo+CpX9+IAGQxyk1
 hwXem/6p9I5Oee1tLgnRFI7XlgasqqEsDiXptt5aCpiLFsnLnxu+tbtXck1h9rEqmKelewsUlcw
 WxqyRUedLju9Sk1YLZmLx+HT+ZToWrBdVio537GWQnb4ahx7bpFV1N8mIDJkXCJ1JQZ5pqmoNa/
 7U60Bgwniccq+k7Dje+VtHDB+U6aChB5B+muJnRtHvEMfa0fVLJ3sIIsWl8ig84SqMzVP8QxU+L
 eqKEVQ/qQd6jv5bH+m84oKxB4nDJrMZmTZRlt64LeCttnt9EmMXZ7akbTO88r1RB7fFQeK2FG5q
 6e/sbqT07+oxo2teI2z7eADQyP92sBgkQdS8MaYe+gfApufhI+pKT7DGAqtzJCdWtbDV5zHWJEI
 Xg1MRUrot2KV8Mcl+YFeg=
X-Received: by 2002:a17:90b:2ccd:b0:398:9c00:29f0 with SMTP id
 98e67ed59e1d1-39b2628fc25mr28264090a91.24.1788697091362; 
 Sun, 06 Sep 2026 05:18:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccd:b0:398:9c00:29f0 with SMTP id
 98e67ed59e1d1-39b2628fc25mr28264038a91.24.1788697090882; 
 Sun, 06 Sep 2026 05:18:10 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm11768639c88.8.2026.09.06.05.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:18:10 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/4] configs: qcom: disable malloc pool zero-init on boot
Date: Sun,  6 Sep 2026 17:47:49 +0530
Message-Id: <20260906121751.3550628-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9d5a04 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bYrVA6HKleQzmPLfxwYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX80NdqDdIhySs
 3+M4mVbctz7ijcY5mAyEfnPitYMCRY2Bd24UDO0T+fzur399I2lP3ZMMd5Lz1Vy1Cebv9AufzyX
 1gYLEFLnkqWKuSgLhV60qWjM7wROxXU=
X-Proofpoint-GUID: -SGiPYJuhaIXgarn1R8omSfByvkj0EEX
X-Proofpoint-ORIG-GUID: -SGiPYJuhaIXgarn1R8omSfByvkj0EEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfXzKpszNtahI54
 eMKtLO/WAyij9qxfCMfFnf3zNQSNgvI9+yQ64LcTI6J91rO+JWrrGWXzJY9ZgB8jlIRHcgySiK0
 jddgh+XUCgowktPjapyoHkvFQAiyKfqtseFu5l4Y7I/azxXbUxMvW6u6Lh+Yr+B131XvrI2BLsf
 4PUqdcmFl4BYnNxm/Bkb4wDBgovl9P5QcuHOo2vJDiuJxTEOg24mTTDd0g69Cv9M5dbt4JRz1nF
 sJcQtAyn1mqhcWmYk4DAfMPHCOu6icOANbntQfjUCAJcWnZacV4vQs/5MFDt47Su51B6LBi5nOK
 CaA/gxBRYmY3HaibF2itlD41lNOs13iIPBfcPGEeHgU0RQz23hm44NrhBjmp2mMXD7HP5ULOW5Z
 WYQGp9TlcDhWRwnnMdMbHlKQFkRI1aqCq+E9u7z9mrAmev8ZmlxPF2440zi0UVapIjEVOKvT+XO
 vpHiNzlyGlrhx4U0AfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060136
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

CONFIG_SYS_MALLOC_CLEAR_ON_INIT zeroes the entire malloc pool at
init, costing measurable boot time on the 256MB pool used by Qcom
boards. Disabling it saves ~74ms on Qcom SoC bootup time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..9817068f42e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -13,6 +13,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
-- 
2.34.1

