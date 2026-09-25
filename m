Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F9C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C5C081330;
	Fri, 25 Sep 2026 14:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJG07KmGlZmq; Fri, 25 Sep 2026 14:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D29568132B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346400;
	b=KI0LokQwhzmdGJYrOXr1sPL1k4vnhxM9lyDCtifjpYD/K/Y65kHPIrAHq08dTt5GNpx0
	 hgbMQwGArDUhlaU+L8nSaN7TkW12at7Qed1fIYHBv9UsRtlODg/AP+dyZkTbYrlkkNKuH
	 XFKf7ijmeWjx10eQet0/JmCXi50tpm2bZrssdSaVyt2BD9Jpv26cLbhAhiziEnKzskYgS
	 kA7vk5dy9xC1r8cZGszPvkAanaoxd2H7ICGfXhKtIrLQalYZwmQROQQ05m3JP16mwoJA7
	 tFGz9KQgq0eI2khyazsSC2AE+fQbZ5MHw5z4odbTA9UY1BQ5m3a4D4eKPNWMSYFrHug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gwd/eVrwsuUgoWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=;
	b=eqWzG0cFsiCs0gY8qolmRLoQNCvTqF5ZEiUaQBAGGZo3DeBl5jToI37xLnc/JGKd7AJS
	 6JmTsebVeXhqStX+epndX00m2XoeBHM6yKDdF/N1tX19hNQubpHUJnKFJr8/nKl/VE6AR
	 fwJc4ErtbnUozShcTeRKAwdV9zFrQhOmf7hR5O545kXSFivJDUYAIUoHy+ujs1hDD0Yfk
	 x93Um2npQaUMeJRg5ti15v3mnS0LeInwlk3Y7LxCTnpyn0sj+sugr2hHhC9QpDDPc2zlt
	 LK/NgP3VSrQldk3IMdq6px+woWpm9QVw+D4L59PgraW4pegFWb43E/H+DAW0b2/PgfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346400;
	bh=gwd/eVrwsuUgoWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WeJMNEX+uBDOyCiawK9vxu9zQ9sOVB9C4VJWljpdN1z4TnrcUfNNWH//GjUhzRk3i
	 OwuUS7i9QHCh8ETGiHKQvzTfo2hLO4t42XJyOl7GifyQcLUmxnaiyXQKD0jI/kWNH0
	 x6meEG+3vb/b5j/k8K2ZXDJYef39LaK+hA0yAaGKeiHRSD7Fed4lNSfFauFDVp3+fa
	 yj5+nKalvSWnvKWL8RaeOVXc0JE4ABIn2+LJO1chzOTbTgo27M3AAZOr5tMZ6jz0Cq
	 2DOtUG+UzorNTbCEtwVMYyxpnXch/4jnN6LsCly5stUzEGgTHua7CFJ8ufUNr/crij
	 4mDA6mL/Pze4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D29568132B;
	Fri, 25 Sep 2026 14:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E6F30334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7F7C40185
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57qnInAY4oOo for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2064A40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343498;
 b=fgHmCZMro4g/MT7IFTpFFC2HCiGRxlIiPIBfhBcEqXSZQYjO1GjbofBZjJQE8HzEGmhN
 7Y+rMf4ThNVCGilzqdqURw+TEA1fUuvZ2SzKe4QguFt470c2HpaM4SvRrsk1ELpQoiuRl
 XRO2zSifibCiL6RHjTZWO6FsNNdGDlZM6CDccM65oGVmmDRGYrUPLLSo7HIsMCoPo/H4V
 S4e9h1OAfIMt1lub/MTM0EQZg8A2ahNa8Ffv/WmndP7MHWm+itditzG8V+/8VYcPtXBOw
 KZGIZ9zceJWH+wHbQpN+3XAI3oRerFVCfM73cz+kw3z6M+EmurakutOU4kLxnUM7WgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343498;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=gwd/eVrwsuUgoWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=;
 b=Gtk8SS9BiBwW6f86Pz8u3e3zFvcjDXYn1/EXQ9ks2WquqZ0hr1IBegYlja99dUlZj1XX
 xTteMd1IQNFeLJEneLQISxG3HbZeBh3OFXoF0bDIL7TsatAozI737D0Vrw6D1WUw7dqLk
 qyBBlCMlD8d4pbNWTycERcfO0IGperR065ESse9MuwpHo7JZoSt5PSnC7fBsNkSLoXvQX
 /ZtVEoZbnSz5nDM4zCGffI5ubPDtbXciC+CjoPRmsx2MPfc0D4h/9zk1n0SlYeHev6r4L
 BOoHeYpQBUkeyrv6pTXmg3P4VuCcCWdEwG5VLLrDbawF7cpLZrcrWgGDS/N7n6vQ6JA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nFINsB8E; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hJhmj5Dh; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nFINsB8E; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hJhmj5Dh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2064A40042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:17 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PA4EP1609181
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gwd/eVrwsuU
 goWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=; b=nFINsB8EW+UC5bzkvIBwbNhyIma
 u+gqqXlib6h1mVEfVmX9T+v7SODFzUYc6hNo9kEldeqyVoUCLcIqsA7PT5ZtO/6D
 vjgoRe3ahcV+spjCLu+P6hKt6kK+MzFp2VBHFMvt7RoYXKOqElfFq+IgTLypy/8l
 JbcVulJBsDr0I1XrzzEGNdyUhuIlU+SwsTFxp+V7c28vc49VD5MEKqofbtoTjyKU
 KNiTkn/5KfuGIb5IIWDWwCpaQN0tvRg7INwFa+pDeU7WlN3sZ+pWqwC57GWu7DhK
 /+94pefADwhC/AXUcivv21yjJO21QdI6E8lWPJdV6M6OHqywEhKwpT5youg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnrmns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:15 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso1140333c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343495; x=1790948295;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gwd/eVrwsuUgoWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=;
 b=hJhmj5DhdAfmfgohFtc7QUU46TOkfCFsEBj41K3YXrP/pwMh4xs1CpfCvCEjMPWs6e
 dGoCDhzwEzVDywjSO86K+vTy4r54n8PERfkCrvQsGBEmq6CKSLt7EZWvllQmM4EX4oPQ
 3m2dWOaoAJ8E6gU5J7U3X4J7tpv9gAtQ5nyApo1woQPx/X4sQj0COqIc+WNZrZG+kfZE
 6OfXkK2y0btpMWW7auh1+s4H4V1jAZOoheal63dSqDxQSjwKa+Nybk7LytPMSwHbjKvI
 NwNiy5KyHiEF81ph3nXQhD2D3lKaw23eAPTkZTMLSRb7FVy9ZePdHtWeZSA+aleq6ubQ
 d8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343495; x=1790948295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gwd/eVrwsuUgoWKdfBaMHoJ9Q5PavYcyq3LVI680fSs=;
 b=ANeR1iZozEf1CTeLnj7sWYRVJMG/s7xcPFLXcgZMQt3RktwXPAI3biP/idasCSkt5B
 b69EuACgCqMk1ur9HrZNJpiSRfClD8i3dyHKDuzhtKPqWfB7llkEzKfUrWT17shUFsW9
 4Zj+ezIPj0J5zsi7U8HucUWRi28wjXZd6IMmtSHni1grU/oRjTKbC40+r0hcgHwcCV6u
 I4vPg634wtonSosEFK3tI4tbO/kMXubDf/nd9F+5R2yK21KTFnTF6W8zJ6luuJEc0I8T
 27raO7BLJJoKCCn5oz6SQC53B35bfs6IYOhpJ5jY5vyQWaznOLMWbCndlG5UB5MV/E5l
 xUfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbw0rjV0L51ATpdJowCNcqJVGM92azCskWbph0HLgRrcXatGCu6BUXvAn9WLpoPKtu2nF0p2g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhFCb1plTZIPp2FdHjwbaGUKSWty1S2V3coNQBNntQK5EHisb1
 qrUhMtoZ8psrvZyGCl7oYHO9RhF+u7SUSl3LjoJfG97P6Ip246g0Z1Vz30whYZfCuSyjTrhN7oX
 Yvfl8rmBxFcgOrGVNWlQ4bv/j9ccX8h9h0Hi5TA5LqYrXQRfKh5XK477B8Vx+cTPOyR85qeM=
X-Gm-Gg: AYBFou2zwtyzY5f7r+H6Rq30mustkTsub+j93ks17ZkMO/NndU1JInM98UyLZIvaqfD
 JZU5cWDJ27S/cve6oS2//8lN0H0tcOjj4z+923SAv1XpAdovhtMWuchUK1WvllL3KXo98ESP5vV
 9Pab0BUbpJckKNhsA7GcL0tCvonzpgzUBSUj9DgVBeXksrzyJMe6S2R5B0ZZv2QF9ASs3nh1nMJ
 dMIRh9m/0GeSF03eIKENjH3k8gXno4M1MKbOX8j4WUdSdPSzUIc9XEDEokar00kvmLhb+c2fEVM
 m0JMABpM0UvIjwSBobk+jRtvx0XYQYgPbD+JX5taLH7qQvPTxepx/84lhJN8CSJzby2mt4WcbkD
 BxNnD6lyNtrfD1iQckw6ed3nGdUSZyNRK7kFeo49HEc5a4Sw=
X-Received: by 2002:a05:7022:f519:b0:144:edc5:32d9 with SMTP id
 a92af1059eb24-146ce67ee3amr250225c88.7.1790343494888; 
 Fri, 25 Sep 2026 06:38:14 -0700 (PDT)
X-Received: by 2002:a05:7022:f519:b0:144:edc5:32d9 with SMTP id
 a92af1059eb24-146ce67ee3amr250186c88.7.1790343493898; 
 Fri, 25 Sep 2026 06:38:13 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:13 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 05/12] arm: dts: shikra: retain QUP firmware dependencies
Date: Fri, 25 Sep 2026 06:37:59 -0700
Message-Id: <20260925133806.1403713-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8NaicuNL-PdulATcNxc1YauzdzJXg1Ba
X-Proofpoint-GUID: 8NaicuNL-PdulATcNxc1YauzdzJXg1Ba
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXzTpBi+b9AWPk
 OtRW9nwQYVen/9WWyZo4z1B9QulEIiDl3OJbjdTf1Yw1YepEQFCOBSEDJ1g1apJ/6Wy5TKgvg0A
 TN6TBWs9CERxPyCloB53p+hzdQjAgBI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX1ERNKNez7+Bu
 9ANUD+wJDxHI3Oe+NfPqwvBgKuzNo6s51a8oMrtFg23uFXxmMBH5CUbaIhjS9xZwhd9Yo0TzDJL
 1VkJ5KroaJtjoNAZ4pSJ0WX7ljl3eFEtKdOGLj5MxFgP/7IRujr8odlLM9KXSp3P5mBQdPnhyg0
 NsqfmWq1KjmNNurCg78YwgAwCFRo3CYiUyGwGU8/90oy/jHL0BLHtIC14Ly4mWjXyIy6E0cAPkL
 LgzuzUynn14TIODDlNZKGM+vnBB1QByYglstvujgBBfRiOroJOHgUoeGTJbbTZuYaApiPhbkbmb
 h/edgRLWxbpG44euJDQdZ1eN/TjqXDjvWx/ooS7gxBQZ9TQ8CTQkW4gBMHJ9zPRxPZk+MWIX8UO
 j5WvlTUcLRYOKqOHTdL67Un8+j+PKVolU/30WoX7FIt/vFjJGS/ezl3xRCYriJwxalyLTJseAum
 zdopMCet/SrujgRZ2FQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab67947 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=2C0Fo42jjqOf0kNrVtIA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Keep QUP, storage, console, pinctrl, clock, power-domain,
and RPM dependencies in the SPL device tree. Describe SDHC1
as the QUP firmware storage device.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index 056268a009d..12519649c20 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -25,3 +25,46 @@
 &{/soc@0/sram@c11e000} {
 	compatible = "qcom,shikra-imem", "syscon", "simple-mfd";
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
+	u-boot,qupfw-storage = <&sdhc_1>;
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

