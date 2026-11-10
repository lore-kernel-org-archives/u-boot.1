Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7FB606A325
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XdBkWMcB;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKiSHcRu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FVH5IHOl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F43E811AB;
	Tue, 10 Nov 2026 11:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWa7jtPASX7L; Tue, 10 Nov 2026 11:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 788AD8116D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794311155;
	b=aOZWzlQQaAmgpIheKfnskzU1sduoSsndC5rnuFvWUdNVItpgDWtIDyzBbVMxTGE9DsFb
	 FAg4edMRCuawWMUkzxPbzHimMAdE9/WsOny6QDchh36AhkbaV8Ph/epW7deDWIfvbfQx0
	 bH6hS6GP2cgrLrT1dGiLQsAxQUi6gsUWEWM95Eyj9JX3yQrFRlmdKAWHyM79yD99JIeLM
	 d4zGm4NCUgOvBtwKpY0pbOEkN7yEQcCha59k1zo/yppiShQjNFu3hdVzJzRZXTOd+SQbr
	 mijZY2c1tGC1ixB/ljpVkZSnZeKxJsOfDw+OCZsXyyEvdlpsDtG2DsLCom2Nmp9f5ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794311155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cXy0fEi463C8wPipUJyJ/Q4wqP7OKt4oGOuUl/TQE5M=;
	b=V+b2ihjjEbNHa42Ktd2qjO6DWxHFLTk6FQOQA3J4HDsFOs18GpJmnFeK3j0xdWcUcfsX
	 FLUg80/RSZuCXJBkNTrFX6qedp7evZ1ZqRnaHzVfe78zvyN/gPimjY9JeuD0DI4Q1j1IS
	 sbmIpDAbxAsXd4hqpJGrbuMYmbtnU0E8Ogpz1aI+xeuP3TvJkb2jyM0nMQWnBzaxz9nBf
	 2v8SvHG6WDeE+jUOIruSHKswBNjr/iJHtMHUH4WC+1YOcEYbQ4lhEEWLQC7QkoX8IS7r+
	 38yzNBiSgLab3ek+HYdyXlyPIWTYd7s6evARADBC1aMDjPKCP89yA71daorxK0o5XlA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKiSHcRu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FVH5IHOl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794311155;
	bh=cXy0fEi463C8wPipUJyJ/Q4wqP7OKt4oGOuUl/TQE5M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XdBkWMcBf4OW8WSVwpxg+j/V0aYKI1Crjtx0jjGhYmeCN7C8JuYhtbiHDMrmUawxV
	 V1hyYQ2rfPzF7vKOfqsGWWMH/+8blxZC/8C4mxYNXSuxqx44fhbIyNnI3b/+OaJPuD
	 sRalkE7siGW2i1RG/6RwRxQV3KXVlaH/I+hRXGmtVEmqJJP/hshwX3ZEVC6R3pj+dN
	 3ux8l0V8KOMJ4v4ByHkDqnboippJ21ifCFM6uq56Nj/bCnhtUO7krHcdPLWm0heHgg
	 M4rkUlCsEkDy2HCZYmgUga08eHY+ImLG/zmSQmzDGcwwcEqcQcpkMv/8gdn7L8lcF6
	 EMaFv4TJE3Dog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 788AD8116D;
	Tue, 10 Nov 2026 11:45:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1539D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9771E8116D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMsRY4IF3QO8 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 11:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F86F81141
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKiSHcRu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVH5IHOl
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F86F81141
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9x9E4186613
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cXy0fEi463C
 8wPipUJyJ/Q4wqP7OKt4oGOuUl/TQE5M=; b=EKiSHcRuHwbqqVpMqX020Lhh55K
 zWEnmUdy3ReyA0P772D3H0rasA+SmXn+g1fDa3lNhEa+EWhowONFc/iAfAF/8QA5
 6BRZGfTM9DEgvB2/eNdJdYvThYYftp0/6x3DbESgLQJsJ67tjvk+3+9H2hCQDohp
 MizaEWYFyBACkvN65VxMgIuK2FJpON8h09vNGxSI4HRCZMgCWXdy3YcYnb4BuZca
 y+Wy4HTXVVlV0j/Z9l4iP1hQzTBVWdGXGRf6d69glyLbutQw3U/aJX8eRWmg7+Ug
 CKwLXVaqY+nwCfyCVDrhEMQ+9WnLwBF84wVAzcj3MTWHtv2DPVhzC0FCvWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgn98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36efb506f29so1723005eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794311149; x=1794915949;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cXy0fEi463C8wPipUJyJ/Q4wqP7OKt4oGOuUl/TQE5M=;
 b=FVH5IHOlRJIrE2SJco/LLzksVdvJAygkXbGAW5OPg64zLT1T/Jgac6U9OPIe3n+lN+
 AN0ySNvXWQceR9p9IkD41FtmwzZdNxvGiOqJ/XzHQ+b+fWiaa6XSDSkilRxaFaChDZ7x
 p/Vs58llMf0vFVCF5PLRI53OUzrMri78D+7LI5KEhvSCSesadHWMhvwu6XUIipTpBMOA
 UEhDCmmNzgPtPQXMUqRUXtP6uX10LRhx+SKETcYwTCwsV+JxIHKxnsKXbFHsGzKNpbrl
 czDSrwNM1Q/ZzPHGUN2uURmBTwbKpvrxriEs0+p2NC+XvUHqYc2FxEMFrnJ9hkOPvZ2J
 SdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311149; x=1794915949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cXy0fEi463C8wPipUJyJ/Q4wqP7OKt4oGOuUl/TQE5M=;
 b=h4FPJnse9rEQUklXcZXLdcK8etGNxJGoMeaIiNGxmGIX/l5XEaxw8Lf0GmylYYcpwL
 JmIEBHEeDBslLW1zG+zojooOa3PnJTLt/o4LCRKdglHSvKRdzoLV4F2FLP85Mu2ESeJp
 v70x5oC8a8A1xPhgog+6babYPXC6hukTTCi/uD406y8WlHAPPGP3jISqe5AaHCuwNcVy
 Z+2FQQCbPXaMMpx+fGfHgCqdcypteHQL2sfePgzTfzlsCKMS9PnZ7Jn2T89gYMno9/ZW
 Fiud1j/jQzCrh5JWcM7HlDPvNdVejk2OkLBEvdBcswP8YPmgVW/4IQU/92XLEu7/FVqj
 bQEg==
X-Forwarded-Encrypted: i=1;
 AL+hErEi98aoAL2wUATx7SifvT7SrWR1WXt7vU0HCKdb/nzZ+T7CJt+POPnMzu3+sukziflNa8zMy7c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/NhnlwmX2N2VMvo3QB646y/oPPTlTs6zMl5Vw0L2/o+HlpK+qp
 trZGe29kfipIn7GgblzY/wSnZOJL3GoN0N9XGCb8fPnRvgsJuikgSK26DXz5dvr5STaXjRMhbxw
 gmNKg9oz+30QLueJdU7g85ClJ/Ml8H5GUNlE032Hxr4cyplSYKitGngK/enzHbV8u8hLcYw0=
X-Gm-Gg: AYBFou1pF4mhlB8BSYYm8PbMmrHIgJM5MSlC8FuUEFFYiK2QIvrVG80CpJoeYaY1H4+
 G/IPnhHOL8bKJ4Bu3lO505AczcLcYcgj2J5V6bFHuOdUsS5iuxnzDhAa5dRGwJ/tNrcVCk3xH+r
 20vShdU8xSDUYJ0QQA6cEKIGP9ZBQ1IlxB2Rox7ssBZEAHCp1K48phZZhQBFTZrlWu58SJvTIcB
 eAAEQHV2LFH8lkRTvQUctft88WbrVH13Q+hUMhYQYNSsQ3yFiOM943g77YSAw3ljwmNaHXx/Pud
 MqOvwOnrEDmh8EoqrqbG1d9aMbUwOfFTlsunuEnnaalj/yD3xv84r5DkPKuQ/GqzctaV17WVtX/
 n7mEJ+zsyavPm9iKj51ZRctoaX1X3fE6iwezodv0yQEcOKIFNimEL5ifk6/oCYSBQelv6y1VqXe
 EVf3143sdjs8Yv7rdq7qQmPfk7Doq+xJVJ01T6JIMtasQvWaCi4YdygZ4W9yDBlJLpGo16
X-Received: by 2002:a05:7301:488d:b0:369:f3b8:2c54 with SMTP id
 5a478bee46e88-3751fc3a4b4mr2728293eec.30.1794311149188; 
 Tue, 10 Nov 2026 03:45:49 -0800 (PST)
X-Received: by 2002:a05:7301:488d:b0:369:f3b8:2c54 with SMTP id
 5a478bee46e88-3751fc3a4b4mr2728266eec.30.1794311148560; 
 Tue, 10 Nov 2026 03:45:48 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm11828890eec.16.2026.11.10.03.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:45:48 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 4/4] configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
Date: Tue, 10 Nov 2026 17:15:20 +0530
Message-Id: <20261110114520.229480-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pJZYp_t38hsdFuUAw7P6rbCYVoVHY-fJ
X-Proofpoint-ORIG-GUID: pJZYp_t38hsdFuUAw7P6rbCYVoVHY-fJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfXwxI9ksvQpEVu
 X/vKQvxcrbgNmy/GzUOU9QsYDEVEKkoeBw0evjS0K5xU7WH4TtEWhu9BhC8VRGr+jLwnRzOkSf7
 rQcJGhzx3cJvPYvJXM56p15FZvyWIM4=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af303ed cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1Uuata2qBsvT0W_XkCkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfXwrjsZP3fn8Pl
 3lUyBJZ27MPXC2gi5mD+XvMDNSPs1hD31Sm20fZGxyqOboJNHWUDEsrfvtvWMVZ86eV6SrCCYs0
 MckT58vAilPX1Q64eFAfldYhoWls9xcc/pi+EBzPqJ9NjHYNYE/ns0CJcEv0JoteB/P8emNaecw
 ZIAk8Mtw+FGmOrrjkdwY7zVJvgp+pIQ07nBxMZx8ZOLmcBpboH1eZ1APaka06fSqimA+7VzXRGb
 LHrTP29OzGSRhmA6XYslcz/kcSEMnrNMYhVvlOGHz79F+HbzvokPsTJ3HlAHnaTzjyGHki9EeRV
 1dwdhpE/A4RJT+wfUfDsNWRS8/ATRLgCFcJvHVuyglBINUaqVGjGN3uU0YYZy/Vk3W5k+JVlZHl
 JnHs0U1pFiUGNloV9pm3/2AZe6a+C4yP+WAqn1mytZT04YEuNzwx4qicsHYlQ9t1cJiurTM4O8R
 8bNwA/+abj7piqkLixg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100046
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

Enable CONFIG_MMC_HS400_SUPPORT in qcom_defconfig to support
HS400 tuning and DLL calibration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..a66b38bf7fb 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -101,6 +101,7 @@ CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=16384
+CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
-- 
2.34.1

