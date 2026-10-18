Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61229CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E1A081005;
	Sun, 18 Oct 2026 20:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q43wFvIPNsqY; Sun, 18 Oct 2026 20:51:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0635280F91
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356689;
	b=HlDB2hOlb0boJacT61gpbq2BjU2C/Gz8TA1HD/c5F4Ghyb5+uH3F6+oAw14n9bZK3MWJ
	 ngKnPUZcNtnYFXYKQ+Cgay88E+7CVr3yCnsjAdPHSZwLF7VzbOAAGB4NrhvWMm2StagTK
	 JEgPezOs248+u8U3BH0HdQ7DO76atjkmktBTN+VeJrjcUXQdHh4KeXc6XhpmqI+i0Fj2z
	 qXgVjZh1ElperzqSnsCOaZDJ4p1PbbYvYkm0NGE5lKDL12y1QSkAv4Qcsgv+V1LFG+dbm
	 YSaqti7OjpNIKRMfYZeJdbyvqpQXiNL4cmKtpOpWnSApNrThYejzvG123k0DbPGfXww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RXmA5u8an9ILt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=;
	b=mJLAHclvko2r/uhl66UQd6JxcJ4pthOzbwffg66IoGLXvZyfx8DGInxib0IhWgTx3DVC
	 DKFuCtjXEU0iThDEfJ+Sv0o+EFElF1Zn8jten5CST9G5y33PA+IzVxRI+EWn20pgaSDQi
	 Ka/nFXjkb1HRWAF2/NTwVNnS/NzLXhWiWPWKXdGHhiqhpyTMhutGzobWB62B7YNGzI1xp
	 QjSC5TyiKYRwIlPYgzqA6ZlZ87UCcnuMCzU7RscznrJd9zVULvhxHyFfjjzYz7eeb9JEX
	 pa9aXvVciA5ITXCVTr+5feVReD5nSSb3O0Z2iQRwdEDYn7y08WQfaqwqsPYwkP73vKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356689;
	bh=RXmA5u8an9ILt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pyLjDAUkJXDAXNsGc5acZ95rr3+hJsmtjeCVHlMBsuhIPPGpXyvvdhanJSJTc8thM
	 GIjpyZmTIq4fpaAovh8KPG8GI98CCvemXR1u49DuknCRNrX0ZwVleI6heMQ1Z0Liy3
	 nUZZ/T1BpNkmE0aMNM0E1DVnIv2NRete9mif7xJjuI+EYecxzz3TZ2TM1J+Wne995y
	 3OxmLDub7BqanUGrdlqyd5EqI90RYqHMFekW3F+lBxbPyD7AfFrLrgeAnsZLfYJy8X
	 3UVj9TkofRZhj2RQcSelse/07syjfEcbosiGMEx84dm2hU6WI2guf24XCZ6eQFXlIs
	 lU4Mzz5VxTmHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0635280F91;
	Sun, 18 Oct 2026 20:51:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C231AB
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09D7040049
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjbvDBNAAnoW for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0024940068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356680;
 b=OYaHux/yPZV7Gp4t9psD28gYTP5EmrydcJbHUU+p+EFvR91BxzlkoXTS+LeO97zh1yHg
 XmSPGPIrG6qP4gjim8G0DP2T3KO+5bidjO+F/NB17+1ICp7eMFVa/s3GzeB8Qt88ocp7d
 jeq7TyVBMCjnBzhMXD6iLrRP0ve+fkCPP0Q433g8tVgrfP67Br1moVUAfLkY7P/f9BscB
 ajDzgnvLEHRGpnNECQK1JrOMT5z8FTocrG6U4Kc4pS0LPUDzKn4l75PrQhwy3g8Og4tW4
 I6MBaIlJjNHLbgzsjMJWzBcujtCo2Zyf61rCD7j8qs5PciG5k1KDmJCMnHM1MApbd5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356680;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RXmA5u8an9ILt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=;
 b=enROTwnnlyC/R48t3T0fWGgUsLuw7Ul5GtUmX7AoLBL6y/1mICzFdpgMxB3+b3lt+NBU
 QhQD7n7v8egcb7RUrTjHxmj7/rYQGCzvWPrsd51v3KY6k1JMesjrkvdPTrcDuQ2fB9ftJ
 uUrC6JT8L4YMKaP/+VFJqsQNppfXcKiy2nbPkli0B13ZVLSgX2D8DIDssh4p/nuSqHWN+
 n+MnxuGPDiWG2dxUgYLAWA+9DFUlZk04b01ox5hInbmBto6BVYfhWxPJs5q3WZtjH2xzg
 NBd1/7Prt68Ahd93oWb3SkJfVWFIE/VsJ/7DKPjsHrYlWR4ptKinxbYwmO1QxD5qUVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Gx5R4NiR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=edvKrvL2; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gx5R4NiR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=edvKrvL2
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0024940068
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKCSHD651689
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RXmA5u8an9I
 Lt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=; b=Gx5R4NiRPFlROYemWsfaX6DvOXy
 Y1r3hdWdVJaolEJvo2+9f7mldOt2eId7navfaJ8XXDttLtxZSP/bHX3SqcOjDdlj
 O7jSbQSIBQFRUP0K0CW/zCog/54QPF0xcHS2F/qYZhGdOMJJydzGGZxODfxH5vO2
 4W6GCYIQckeTuWwmXmSCISoxZqDW0rl1qpryGqFO87KWBrHo5Bf1Trd6CnZMPe66
 xGo70/a+sXBk2NbS14pnBIe1rDzT5RAfOlLhpcY0+5kQm3oU3bHw+bClZpWX3Zbt
 rtQSdNw09r5YsODmfssbuYflYTEFL9fVS1mXjCERt3n1xwotb7kj9OMgh9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc13uuw6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ce7a85f04so322542485a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356678; x=1792961478;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXmA5u8an9ILt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=;
 b=edvKrvL2Q5uY23ggHb48eEVyla674dItmEQsFtVhEoRdlHsCb+wxhGXjOIYeywR5Yv
 nIc2B24awEC7oXNfFuDwKPRJHyB2qDkCquEoyQmcem0os2sjHo3xRC9x3UoF0Z+lAFHm
 Z9mwcF5ip6EkvcOy4sGspf1xwFtH7NlsAjtS7hidxpcrgXgmkeCEuupMzjU/gvEU+BLW
 ejJ/9A/27ySx00at8ZIRQwUEqiGJHsZAGX2AcTAg/OSqxZAsa4a2QgB+KsJX9QDlepzv
 eY+/tYec+55ffdgSx+QYK76JEu84fNeNjhDIT5SXm5yzXH14qtspvdSrzjsXx3Jz0qQx
 tPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356678; x=1792961478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXmA5u8an9ILt4L45cqrUAcXDLFiWnMb/wYB2NWlsfM=;
 b=FPtcQhXB9ZETDetK4DSw1JIvWVqfAbz5lOH0BKC9fH38HJ9Wrvnn72ehAmmFtnBXSQ
 Cc9zbsn12jXUQodEfibTikexjuVFn30fFnNdhB69DHLWwg7HnrE0ZOtHeV9oRkLzs7qZ
 qaV2lTwwgrbanZTJpDa0tiYM242TbGM2WHJ2DX/KYWy/nMZ5LZL8kDoCaOWsigjQzzxA
 jl1TOsmX/WVzO7JT9ha1K7fQqk0I7XR6mhhz8nyCIG0138SmreTITrHpPxvuToPc8Tpb
 Af2wTU/De7IYshLTzzpNgscrDSs07HP0pm8mXN+Q/ncRb5cDWAOi5NuPYZSlYqruPVda
 MnGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxLVQxD0CKbx1D5o3XugYwSHyTWSvtag1asYZS78ZIrtR4uBUOdpBo0KaOsux5X3e2h91NrbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL4W5628y83NiIj7Rm5oUVFVdhR4RlVLXi6qPvpeAosedF+6jzm
 smZjA2EPcS8e5lCWNfy+P+41D5J1f89XE+bSEpnnAZdyLMOBy5Co3CPVv635KF3GdpkSZevAz0E
 XmUesGr6RqZg9Uze6ySmMgJfcyDoIWbwZzb8HbRZN6pa9goOYy/3Jdr/4JJor+6obKzoo1OQ=
X-Gm-Gg: AYBFou16pXvFB3X5Th/C83mqIaSozIT3HbM/gVaYUaGsZaRnk8R8juK4vynnxitNbj1
 7huLMHjN8ZlT8DoPSqoyoaj9CTiewLzok/+MkL9pONZQRIUBU99bRoOE599H6GBYwUrOrhKU7mX
 8Gc8+mIhyQ7VI3SqCRXybr3eFi3rFSSgzB7VBRvJP4KCgKc4tPelI0klqRrHUJEOfksQSTTDn3V
 LkVO7IH6yYfpvbfoQtwncl6oUB94asfSBmvyncw7r+cFR5rLoeef4rXAbnJKJvQsYyMnrvgi80c
 wuhJi639lbpD1dix+8eu1y8Qi+sXz9D0FZnS7fo+0gPwMVjVVw14jWAqXpRBS3C0S99wt61SrwJ
 CW4aWAdEeb+ATjFXJnd2JmEuSWT+SdadrNrouQFJjhc3R
X-Received: by 2002:a05:620a:688e:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-93f29dd14camr956438485a.68.1792356677768; 
 Sun, 18 Oct 2026 13:51:17 -0700 (PDT)
X-Received: by 2002:a05:620a:688e:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-93f29dd14camr956435285a.68.1792356677229; 
 Sun, 18 Oct 2026 13:51:17 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:16 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 6/6] optee: implement the RPMB subsystem interface for UFS
Date: Sun, 18 Oct 2026 22:50:56 +0200
Message-ID: <20261018205101.2362593-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: csDaauCaGWkJ8Jg9MV0mw88sCU350b5x
X-Proofpoint-ORIG-GUID: csDaauCaGWkJ8Jg9MV0mw88sCU350b5x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX5x6TqsAuYEWx
 NwUJAhsXF7nPAIo8WzccO4BTAhKN6SZOHHHBRzU/T9uDd/AByyIW0nNjOHHb3iHqSTApyvvbjFP
 YXxvOn1eWaD+ZLLwT59IpsghXKlWqX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX3LLm0q5mHnfr
 dZp3M/j+AD1DTf1l7b+nA51HAF9HdEWn1FOIlbG11U3RdQxZ3KXh1vX97EFW4ueGpbSUKYa2etj
 48rzJUnLvi0TYb0Axyu8gEJkmP36zh0doWfect9O9Lj5cb5dHhhw9YqJuKaxicvDKOVr8kZZgIj
 zHUKoj4mGijvDXlHqRCBo+pgBDTmAm4D6TGsUr3gPgG4uB0jujZOV/PPc9ddi2VOERFO5COGWcw
 ltatFKdgsG+3IkEsEF/vRzKHUODI/Y3EK89ceNwHobJY8kexkX9x1dpBP522LFLqI9RjORt00SI
 GzgBSi/yLyHOZJW/t4EgHzFc3oweq2BARPmUrufg+zCwVPldzCRJ/nHo/PtxO7AXlQwus0ilP4l
 WKwD23Z+v5Pr0svnOTE2UY2wWjSwFS2o5pQ7Y7pVRYeALdD+t7JeIwSB6rSCsy89LFScgug/ubh
 +ozmzrHw23kziFOqq0w==
X-Authority-Analysis: v=2.4 cv=SKzXx+vH c=1 sm=1 tr=0 ts=6ad53146 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=4OB2SniIEselFtn8B8AA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180083
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

The legacy RPMB supplicant assumes an eMMC device and derives the key
from an eMMC-shaped device ID, so it can never reproduce the key Linux
derives for a UFS device. Secure storage on UFS-only platforms instead
needs the transport-agnostic RPMB subsystem interface, through which the
normal world describes the real RPMB device to OP-TEE.

Add a UFS backend for it so OP-TEE derives a key matching Linux and can
use RPMB secure storage on UFS. eMMC keeps using the legacy interface.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/optee/Makefile               |   1 +
 drivers/tee/optee/optee_msg_supplicant.h |   6 +
 drivers/tee/optee/optee_private.h        |  41 +++++++
 drivers/tee/optee/rpmb_ufs.c             | 141 +++++++++++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 ++
 drivers/ufs/Kconfig                      |   8 ++
 6 files changed, 206 insertions(+)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index d0c7f8dfb12..f2af10999a9 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb_ufs.o
diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
index 963cfd47824..a7b569d3e54 100644
--- a/drivers/tee/optee/optee_msg_supplicant.h
+++ b/drivers/tee/optee/optee_msg_supplicant.h
@@ -152,6 +152,12 @@
  */
 #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
 
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
+#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
+
+#define OPTEE_RPC_RPMB_UFS		1
+
 /*
  * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
  */
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index daff3e04493..5c72b280058 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -30,6 +30,17 @@
  */
 #define PTA_CMD_GET_DEVICES_RPMB	0x2
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+/**
+ * struct optee_private - OP-TEE driver private data
+ * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
+ * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ */
+struct optee_private {
+	unsigned int rpmb_next_region;
+	unsigned int rpmb_cur_region;
+};
+#else
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_mmc:		mmc device for the RPMB partition
@@ -43,6 +54,7 @@ struct optee_private {
 	int rpmb_dev_id;
 	int rpmb_original_part;
 };
+#endif
 
 struct optee_msg_arg;
 
@@ -84,6 +96,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
 }
 #endif
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg);
+#else
+static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+						    struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+						   struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+					       struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+#endif
+
 #ifdef CONFIG_DM_I2C
 /**
  * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
diff --git a/drivers/tee/optee/rpmb_ufs.c b/drivers/tee/optee/rpmb_ufs.c
new file mode 100644
index 00000000000..0c820e9595d
--- /dev/null
+++ b/drivers/tee/optee/rpmb_ufs.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <tee.h>
+#include <ufs.h>
+
+#include "optee_msg.h"
+#include "optee_msg_supplicant.h"
+#include "optee_private.h"
+
+static int optee_rpmb_get_dev(struct udevice **scsi_devp)
+{
+	struct udevice *ufs_dev, *scsi_dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_UFS, CONFIG_UFS_RPMB_CONTROLLER,
+				&ufs_dev);
+	if (ret)
+		return ret;
+
+	ret = device_get_child(ufs_dev, 0, &scsi_dev);
+	if (ret)
+		return ret;
+
+	*scsi_devp = scsi_dev;
+
+	return 0;
+}
+
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	priv->rpmb_next_region = 0;
+	priv->rpmb_cur_region = 0;
+
+	arg->params[0].u.value.a = OPTEE_MSG_RPC_SHM_TYPE_APPL;
+	arg->ret = TEE_SUCCESS;
+}
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct udevice *scsi_dev;
+	struct tee_shm *cid_shm;
+	u8 size_mult = 0;
+	u8 rel_wr = 0;
+	void *cid_buf;
+	ulong cid_size;
+	int ret;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
+	cid_size = arg->params[1].u.rmem.size;
+	if (cid_size < UFS_RPMB_CID_SIZE) {
+		arg->ret = TEE_ERROR_SHORT_BUFFER;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
+		unsigned int region = priv->rpmb_next_region++;
+
+		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
+					       &rel_wr, cid_buf);
+		if (ret < 0) {
+			arg->ret = TEE_ERROR_GENERIC;
+			return;
+		}
+		if (!ret)
+			continue;
+
+		priv->rpmb_cur_region = region;
+		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
+		arg->params[0].u.value.b = size_mult;
+		arg->params[0].u.value.c = rel_wr;
+		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
+		arg->ret = TEE_SUCCESS;
+		return;
+	}
+
+	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+}
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct tee_shm *req_shm;
+	struct tee_shm *rsp_shm;
+	struct udevice *scsi_dev;
+	void *req_buf;
+	void *rsp_buf;
+	ulong req_size;
+	ulong rsp_size;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
+	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
+	req_size = arg->params[0].u.rmem.size;
+
+	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
+	rsp_size = arg->params[1].u.rmem.size;
+
+	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
+				  req_size, rsp_buf, rsp_size))
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+	else
+		arg->ret = TEE_SUCCESS;
+}
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index 8a426f53ba8..50b780037fb 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 	case OPTEE_MSG_RPC_CMD_RPMB:
 		optee_suppl_cmd_rpmb(dev, arg);
 		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
+		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
+		optee_suppl_cmd_rpmb_probe_next(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
+		optee_suppl_cmd_rpmb_frames(dev, arg);
+		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
 		optee_suppl_cmd_i2c_transfer(arg);
 		break;
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 648b58b46e4..f174ca0841d 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -105,4 +105,12 @@ config SUPPORT_UFS_RPMB
 	  single RPMB transport, so this is mutually exclusive with the eMMC
 	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
+config UFS_RPMB_CONTROLLER
+	int "UFS controller index used for RPMB"
+	depends on SUPPORT_UFS_RPMB
+	default 0
+	help
+	  Index of the RPMB-owning UFS controller in the UCLASS_UFS device
+	  list. Leave at 0 unless the board has more than one UFS controller.
+
 endmenu
-- 
2.54.0

