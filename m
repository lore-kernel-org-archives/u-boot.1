Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7C4CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7619460729;
	Tue, 13 Oct 2026 05:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IFtf04D4bDk; Tue, 13 Oct 2026 05:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B17046066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869584;
	b=tU0orG41KET4dlYusbOJxpKMrWOX5/5enOKsxDD2tS93HJaABq3nMQWN85Ad6sTq2uMo
	 zbpnVmegUGtr6kzgcaLA426VbkUjksAMTQHmQaGdWqgdjRVYOYhvJNHOs5gjLNFJFf9Gw
	 X9BHoejXL1bYaUpkKfpFydrkNOStE8/SFql4RIL3YeGqk43zP9f1cofq8Wb7Uf0NrjmfM
	 2QU4z7WEsfb88uo+LVKlqpjb5wekpBbGN5Yqrplx7di1UarJRCiTh+LsLgZ9Zx4WHO16a
	 awSnPpJQRUVtenHNwMdyDm7r4Ljs8s72yk0UPC/1HUlKDYYcZsAksN0vn88KgmQLwig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	b=YfZpgngEoK6PFdBfjLtgxCHiunvwSlSHiU+9DtFJNBUuxLqFo66KKxlhLV8NFJPhZpvv
	 EGIs5Ksxbt5S5CagNnXwKOubnXSY1Df+/CGZNajPk6EiodMP0noIG+bjbpo3OS49ma3RP
	 2M8bG9brWBAsOzNUfqfZDB4vfCrvhGRJESdbDHGqu8kKfmcV46zYGDsuElTJAGMMN90UF
	 RDSfEsHwZ/Nqlw5jex3vHCIWWEkzjciGtSVlHZ7iABsdWGppnUQdREItTxFbOyx4ZdO8/
	 H48cuF91MAKQhSCQKhWAiyDPjpVHUF5LGr/esZewag2jKNldQKsMfYV7o1M4zwrcLbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869584;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNwHgAb5i8dsfXGx+hPmRq6Bum81oI6dTznlOZV2ZL9XKoIEiypBfLw5j3c8XfDCd
	 2EdRGvEOTMKBANDZye3fHXUqqWUtPy1LdWQxXKSs0LDL1PY9d/TiDRu0/p6kua6JZY
	 Fl4MVAofAOG9Yyo+1FpdyzeReFnd6lS8XaPVPB2o832fyFYYFQ7ogWDTogWBG4nm0q
	 ta1/YfCgmhDnuA3miAUPD5i5oT5WB/mgPwK9vljtOp/+vUw1dVgN8hwqsy3s3jdBOL
	 +k+TSHQk5jDibgebeBiVAXBmy2LJn1uBB4e3qWOoM1WgJAH6ljWVT4AjB0/GDrmrrq
	 FopboNUyC/6MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B17046066F;
	Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25A47DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 173228098B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLEu5FMq4FdR for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B5BC80898
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869581;
 b=nmikkMtjsMaE1vJk4qj0KXbrl45ajUBEml2tRneRKWJR7jcklbKmzscvydJ3F7H/RRNm
 c6W/eFk0m4YUoC+++x02hdc4QvuoJg7+5AZJty/7QZDV6L9XWMXwbt/tiWZt9ljRW0x9J
 P0kNqzxIYOADbE4ZCss5LirUuLcCFaKedfLBWwwCvDRwO5ri2zmRpH8pjodlpLB672qt7
 LTV0Q7deTEXDHcU/Xw2hb1nrMcurHQSQORqh7MbHdChpxNsHxMtASeqJLTnRefv3qNlgI
 4cLr4U5+Ik83akDXpzK3JQmhA1BN+J3DI0AmrsRJBVgeah3aqGAp/AHusif9Mm4AlMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869581;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=aYJnsXX3HZs/q0WdnZSSRDHBakiUF7B64oQo88jIcRtPA5pcnS61KHTBVs8Y8mi0PtBh
 W1nu/p1oHP6FJCtxuBca5CEQutj+x8oashilY4C2Ey8C6ZMW1C8fyc49pjrO7pK6ZuwCG
 YDuUvt0BVHctTLAITytN9mA0KOlhMrc+l4raHawwuyP4NBSWWd23HVC1pAeRxr9nR795U
 CyeV0gk7J+4fipLxPlODEeSfJ1STR9lT3ui6PSja3YoIuHvfp6BUZ8xtMp19X81fdvm8e
 s+WfR+R1DwKnyhtNPyG/vwhur5eZ/kKtSkDdui3/sUeEGfUbvpUauv6w+a1q8oaAImw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ryn4bBlk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="FIGm+rP/"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Ryn4bBlk; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FIGm+rP/
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B5BC80898
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20kQq922923
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dw0YQ9AdyH0
 093F4CAXrS1D6HzWf0L9XIPmFuwc7410=; b=Ryn4bBlkG2/1MT97wHl8NZFDqzu
 5ys+aZPrirYwE1ql8SBdCiFajT0wSQK6blxpLJ6l5fxzYTiSmaxqdJA9NDsmlG81
 ukS8l6g3Z9dtmb8SDw+og5Jx6a3XxLayM1nhXXBRkIoN4urA/QXZwQ2qHPebIJfW
 2sKFDUzm1P67DCfiL+5mLsOH5ev/50LCnc/shyLr3MRgiDh1rRJQxv8+dvZkch5D
 jMcoMnoT8Gr7HlKL2SJk8J3erLFHxVKeRRl7x/cd0Rrr6Jc6kk7rjQEfZQ/OsIxi
 P0FcARvRWkqBrZx09OEQVNevL6yV0v+mfCiRPWDBMm4f7hnASt1dVLqQ+TA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1s7q6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so7358674eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869579; x=1792474379;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=FIGm+rP/y0G/6LXFbQiKwoJd0pYFbkjCi0E9o6YuNFMzFVGz9zCfwhulmCwwbmSxpJ
 +m3z850NGfmLoN8pAYRC9x/QsmkL2yTIhQra7/rvlXx5InRrmPApUE/nNl6/iUUPDr/r
 jw2X4VTlIBkMhLVTcBDAV9q/UY37eUUdNoGlUCYi3SS3HnnSPPuGIt3Z45AouhHNFpOU
 egEos/PJ2/PHahPy/3nEyyniUdBuw12vbm7BflkpZb9xWcttuNrkVONVttQYPqqtwj5l
 BEkH6EfdAngJrs7x7jLwFxPN626doJ5hZaMwpDr82VMKWu0MEdFMTJXIKWH2x7xlEjlm
 Dc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869579; x=1792474379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=zS192+ZHiOsUqPC9xd3s8ux7/NRzqO94dOkOmp7VL9g5n+dUHqqELXCf4K8v7lzTlD
 QSijWwp6s3MHa1ped/1UO5M17q4KOhd9ydWqTVd3sqc4rqOjdvdIwJtda6oOwpCiY/iK
 +LIxnOh5H4bKPpHRCEgT2QlDWEsha60939igFpe39yAthGRv6PoXunccidYJOpjgPn+V
 UQ1M8iMrDIp6aze1Ql1Tc6lm8cSK7XjVzHkwqV9QNeUQMZ2JKfu6afryTpMdx/YN8CLR
 MKjR9hJ5cWRY0w9wTvvHDR8uP6WtbXZKqH55c2kMh4rzNaR5a+1DoFqXiP7PSOrhW+t7
 JGHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXqC/UwP3qPYOfBC3S8cIy8f4DQZRTAF9+iX8wTcr57GThgjvsRY/H4DAlHwluyvt1W76pD4s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKvxWc8am04T0eJVndK/wcFM6e84oLBy7I86s2r5j5zP7Fvg9++
 ZA/8A9hd9U15CcDsny2fNKucbyf8RxF7k517oXeADmouGkaNY7XKVewGC0uf0XEr2JIz+oNAplP
 gSVTuQ+e195zPGRfmnjfveMWYnWJmiM8R+nn/4WvOkmz5cW2in+P2FLPtwqkny2gC1YFG9t8=
X-Gm-Gg: AYBFou3Nt5j0fOs8gKVITilqepT9uimLge+ybZg8iY6N1/FxyYaiHSAhD+rJLJr2gg2
 GN7nWhavs0RerNnpQ07vCHoXZA+27gAWb2X+xWdKBchPGkJWoQ7zb1deIvtVSSVYxT4h/kb/yIS
 qBTpMa0KwpbHP/otphOeA1uydqGttXg4Viu96THVkzmfA3gCYS1rsjmLhoZ4BeFhUeoJPHCPL7A
 VWduFffeysg/ER/t+m4kjWSvHXSgzjgU6sR+nwZ4WDdsMMOR+r8wihpkoURL9PvLSElkghcrYJN
 nLQPAr3O3qfUiaKRwJOJXkJ4XpmyFK+4cnXRBX0HtxE20bEBjnytQSh4kWOuS8nKonkU/T8dRs1
 WSHrkjTXrP4Gq9KPjqDc44vkAkXi6skWfl6/VF0r7RMoyX4s=
X-Received: by 2002:a05:693c:6390:10b0:35b:be15:a5e with SMTP id
 5a478bee46e88-35bbe15106cmr3647690eec.41.1791869579215; 
 Mon, 12 Oct 2026 22:32:59 -0700 (PDT)
X-Received: by 2002:a05:693c:6390:10b0:35b:be15:a5e with SMTP id
 5a478bee46e88-35bbe15106cmr3647640eec.41.1791869578524; 
 Mon, 12 Oct 2026 22:32:58 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:32:58 -0700 (PDT)
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
Subject: [PATCH v2 02/13] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Mon, 12 Oct 2026 22:32:33 -0700
Message-Id: <20261013053244.2954876-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdc28c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6lju1O6RD8AOoBC9Ya0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: C6sbA5fy9QaPEDMUSXA2qXzrhgG_x7hL
X-Proofpoint-ORIG-GUID: C6sbA5fy9QaPEDMUSXA2qXzrhgG_x7hL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX4wceJGR+JgDt
 lqz52cNN9MTEzX/VHV+ma2gSpcui81TkqEFsadQwLdp69cZorcaKXb+9q6AHZjUJ4Vj1/K39PgX
 GB6uRqQ+60IUVmofJotD2wjtnCgrXcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXw+kZvgTR23Om
 Z+76YiiNeE2c9eby0w4o4QXcdbjmFmcW2AAOuAifGV1QWpfl5seSr/UxX1yfSecAxuUUniyujhI
 0DqleHCWeVYhx89fqsIvIS8pqdLSkw535yuiSjnkjMHPN9cCGRRLa/MCszbCPsd9S/BNFrF8iyj
 leDTRtvFZVGqfRylseMC0FdsVZq1DvtgPzK0NYZ0Hqe6Ib/lVQ/NVdoOQWCOrvUrGxqGcby3rQw
 7O3UwX9tJx/BKoA2yMEpkh3ic/HQQhTWnJlaapxo/GI2uxsSnUiBN5F6i/Njbvv6hbSwlJeR+6b
 vs40QML7y5X7NaTDq6zh2a1X294H1iaWF6f5eD8SQJs4nYuSgzofQWmy0acrl2bVwhEe8Ld0zy3
 KWU4TDr4FekT/W8a/U5nPEef4/3wE2EAC0WNEtKTx7l0f+gEvRNJiBNpe0qFpVbOfaOjBwSDUsD
 V/HOftcQTeSEdrgFujw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
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

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index bb12e93853d..ac0103631ad 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -116,6 +116,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-- 
2.34.1

