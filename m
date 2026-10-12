Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C691CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00F5C4056A;
	Mon, 12 Oct 2026 20:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqJ1Fe_N_qDK; Mon, 12 Oct 2026 20:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2159440565
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836731;
	b=HO5BiBcX7CNxn4OVItGSn86CXqvkKMLtbmsKXzXc7HinOxinT2pKysIoEpANstLw+T+b
	 ePhI1+W9X1PwVRf7BRLZvAk7iYDJPeuMptnrTK7TA3kSKEKraQXxIIjIcg2q0Ttf+vz3k
	 6676UFzVEwGVDqV+z/pZhd/24gOu3ljE8rAudMlDyQUx/t8M/IoJSJx7f4MsZYucPd0hR
	 D8Cpi8HlLY+mxYQ/wZ8jGrszocAzCdCHm0eNeHknG5vIW5skpt/dWPrGQtH4qM9u6A49N
	 O6F5Iqj61tSB7Wjakc6ASwKFaLxBQm2uI8tp7Vphvh7zW7o7VsmHRKj48p080dG3UdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
	b=j7mnOU8wpeWtHslC6OnEypJa5Bw70kKaqjlObvAc3F54kgI/pmCeZFDwctwYtHEdxVLb
	 2CuyGqJ5WbF1+myCvpZrNCmk2FCQQG+1iJohk3dFlI0ZMdhSqD6OwwaNQOcUf3NZc5EIR
	 BCdaWpFY1P+q1OmgwG26bHRaDAVo3TkQZ3+WT25X5Csel31unqMLL7TeZU4dZEc/hTKLW
	 sSX3dSvf5DoglxeVah8IYEY+nMSiC70QX2RFsp8wgJYqbESZhYs/RXOxtnqPY4tdjHRsC
	 rzInkyWVFkSbkWH3l6IfNJh0j198GWz4WNyCvnq8vNY5Bhqubi8jwRuw1MAsw+XpSKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836731;
	bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lBY3crW6R1fNQPZpeifwo5AUOSpPaA5KMBhWofuCsH8tfmmvM1YAYqMpDfQOKQYZU
	 b7PofXNGmranG9rW1kCnUdc3ICEtkK5KQxHqqnzgbiobp/BAQfuuRN0VgHa+v7V9Zu
	 t19JsnU2ryCIakD99qtK3RBNPIR619nChN7ilhd3aEg07iJr1W6AHnmEGg1fnRU5O/
	 hacWdsuyYmvxOEc3/AxfK9ZiKrhN5YyiyeugKMF05LhB+2HVV6FRaKSftOdR0p5BaI
	 dtgkRC2ybjuhaXyc5JGsd26jhpC6TpFO3c6LJIu4OUvsSlqwrfbCoaRQVaUSbAROFj
	 ihQYkv1t3bhwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2159440565;
	Mon, 12 Oct 2026 20:25:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 820452A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 685FE80AF5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1etFO-kiBB-A for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 864F480962
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836728;
 b=PCPgQ0AEoPLExIilo8JO6EMG8KbPgkaHnQKvZ881oMsjkGxSBUdVEmF5S/UXqgTr0TEz
 qH1UAWyGHpXJT/LnpYQpy5DYHE3KapB1OM/tFdrmk9SqEypMZ5Ursm2CackkogmIwnKOI
 9wl8SRQ/xlimdBc+sKho2vLa1B9CSLKrGxt2rhvzj1/BCReyq+DEOaEJnQUS1OFgSJgSd
 UBRCJk2HZ8G4wOW7TUOEj1xbofviT67Ph8gcgh+uKk+q4nxQDo0jy4L9LmQDDEbADcW4B
 N36/5TqIxhlALJREma8dou+sgTOgrYkjX/CUU4jB8gsxelaRhS+/ESYLys+tHWCe63A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=WFTi+WYoSQbaBlD8yNQ52ck16gF+p/mvHKbKy4jxJpxXHH1rMmUnhlKbNtxG/7KWDo2s
 GqLBzLfv2iZ7JgONKL7ke5fOCBpqUHG4eKOeAyyGaDHVX6tG3ecRZ7iO3hq/xfVe/lWU2
 bLp2feUNOu/9dDp4m8EhDg2vdUQ/jl29FH4dzqHr+7JwLtodkDyvCc0mGjXwXoZNq+CYT
 hoZPUcL/1tObRZ3HBvxm/8khxoNrqiUuKsRROrOShGqvTfxvg4M1MyDMn05s0bdRVZtnj
 iZhfOplunm/Qc941HDhRSv6LnZygr+Dt0UKDgJUB9SkSoi9moE3osNYWBXw1WsrGpfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IvI5iMkV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Px5TH5Tv; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IvI5iMkV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Px5TH5Tv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 864F480962
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJN2Jk3258397
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=; b=IvI5iMkVXFsTTM5J
 4vEEfUSrkmYQpwSJOKPBcRWtjemLUNLQLl1Pvt2PBdSCwfr30hau9jXI/YWdMszM
 9/C+rJSqalZSmpA5ta4GKAYOH/z/C0QBcg6luq8rzMe6Qt3U4Aa5BSO7I5ndaRKi
 pq34uk7K+lQGDCV4Z6A8t1w1LG40HpetZmkCHw5CC/52GC/9qLesOryxjI56VxgB
 hznAip0xmCU7Cv0OwIkRSRa9gj65GDQT5IbmDqUhi4N91jQtX1UHXD/nrHdshlKS
 R0btO0CeEtY7BdW67A9GUcIgeM4Q7wgs6L/owt4kb1Si0gvGFY8+Dj0T4KMzn8zG
 D4LzpQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq3ayk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ae8e7e546so467506185a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836727; x=1792441527;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=Px5TH5TvO41LKRquo/gtVt1quNWVNE49UZgG+izTDJUpERBUeuL8PKjJ0M9aDQQWhG
 7It4Z3TBk5T20JDMzZ0IPrSho/hCmkcj1m8NUbPF6RkoouhC+vWKL6WdWOyrClNX9spA
 zZNRLXQ6YzvvNxZbdvr3UkD86RxAvsoG6yqOdV6Gp4cPQYxRoBTcfjlYSQgQ1hWRwUL1
 q4Ywj/Nze3abREVOb46vm6Susik9GOwZ5JwuSf1bxRZTGerzuTpxQetFS3v1EijU0dXn
 BS6J3WBg+lHIsBiE8hhLUKYPC2MbAAVfkQRiRYB+9s2L/eRwCifbbOUMijNOt8JBwaDT
 Zrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836727; x=1792441527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=bSInTbH1mrbKzAIDkvKn5t+kGMzR5nKgkJofjFpzDuhDK3EnqvsalG69y+sg0YZw2x
 a13ACx8nb53tGx/ZTDuTefyuRx87QEPjROJ9BcPhhiIBzV671ReYwHgoOaIyEGJewUaV
 weoXafhlc5QFGC+to4OwNmGUj6BfWGrQGhOZVJJRuXB3G3r0uUvvFEjlsgwxdmkXOaYJ
 Bkpce11FlXXDq9cmLn2G1pV21jCHXQV2tjfYE1JxDydk8qw3jLosVN7J2nCe8j/6FKOk
 OSKK6AHDzz0LjDMV1FW1BavrThS8dhQpH13YsUF6aXmtjdTeVCzhpaLD8P1wqWvr8mIS
 mAoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXfy9gaIsjHJ4nnt6Fe5ahSgeuA3wsfWZNpzsjkB0/GpWWOSfvnScYHnFkNtVfhycrrU0sqrQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+W3eADk8XxxUOMYiid9tkmq3KbFYR4Th6aaJOrv3Lc+N2ZeGv
 BPGp7L894zr42wH6jCNEH/b78FDrkirgOwMWeaGvYQE31X60HprljkOhJXEs9A7q2YvAgZur0pq
 bPR3paoskmMpmIik4el90Qe129j2OzhzlLeG+Ht/UTTbVzX+qKNdsZjTxa76zfpM3ahr5o8McCN
 zyEA4NnDWH
X-Gm-Gg: AYBFou3DsTHqOnFUyLagUgXLgx046T8LuQCNpOFKcQF43fmaxTAQdqkHchFGhsOuhG5
 zBZA+KwZdUqu7GI38xejM3/s8CSg6ljsY/0dBBXodqZKhn0O78CwaTkhhLjPFcgzUxhPy9LadbA
 1/ITU5MOW5bY3vg+U4KzpdeZbcqJhDtaeDJ5fDEJD92pMDiNPV/2duQIZ8De13coEyZ5osc2E+v
 JyRXPJCmrZSsaxN+OViPp/N1CE1XAqdEOUp3Lg5ftIlqd7LFhH/KWVkthPMMzGqcJuui/TbYEqh
 7+TR8v3tAT8C8a9p+4vP8T3BP8yyZm5me0eHfXPD0yY8E4fkRzaheAumnZOSciSNgz1ASn6SdsN
 D98Ey2zmszA0lU4t50xzBaDwfYtmB14MkOKrEJk2XKP0b
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id
 af79cd13be357-93ebd24ecabmr1938750285a.42.1791836726395; 
 Mon, 12 Oct 2026 13:25:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id
 af79cd13be357-93ebd24ecabmr1938746485a.42.1791836725791; 
 Mon, 12 Oct 2026 13:25:25 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:24 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:25:04 +0200
Subject: [PATCH v2 2/5] cmd: avb: add lock/unlock commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-2-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acd4237 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CZvO8b3GW2mycMafNwoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX3U4TYp4DNjAd
 z3apBFdfjuwfSXnBMzrUeFkGyitCJbIF8Ug2Zt1q25ilSG4JFfiUyBmlIuAvEJwnpZKK4sRe/V/
 uuy8CeGKr+HeRvi9qVJvHPYwEzt0I7M=
X-Proofpoint-GUID: 5MnIMr8V0iCSYlqX8BwuepCasTzYmqXH
X-Proofpoint-ORIG-GUID: 5MnIMr8V0iCSYlqX8BwuepCasTzYmqXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX7DtuXQIMiVN3
 OG3DfSFH8TUTN0dg1c5EFBz4NQYKKk7+JaB0pddAf7htDpoXlimQSXuXdYeqyHLx58gAEmxpqyJ
 ovpwG7Ziq6aMXHTY1cWFXv/fQnfkxG0CIuBDXc0XrLOOkesNHCMPRBtRgyXSf67V+UYysx4c5zB
 a1akt6q7V1eh8ZlcRrDFLIjnG6anf170z1pBPFGzM1gNO/Ok+ZXil8jD9XFOwFt1WA6ewlkTA9H
 o0KftPqletTkzQKtMJAODHBK03w8g+Tvs27VcaHwGUM5lcp7kD/JK8Iw0M1ch2K2KmRif4D5IhV
 ELX4Ajnv+QnM0ThroBaLxbUe6y4FO6H0JTT6ikMCXNtdSIdkE416XyqfJv1ZQdji2VI3oLYdeZm
 dlpU5tprE+TS8hAOhgdCe0LaAGC70MCt3H2/vE8lXx52JuYv6U0KojQs+oK/9HTMS1ElHWN0dnZ
 /wolk6ZrG8T/yGPTLpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120081
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

The OP-TEE AVB TA stores the device lock state
(TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
device backed by the TA could never leave the unlocked (orange) state from
the bootloader. Add avb lock and avb unlock, which set the state through a
new avb_write_lock_state() helper. As documented by the TA, changing the
state resets all rollback indexes.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 23 +++++++++++++++++++++++
 include/avb_verify.h |  3 +++
 3 files changed, 66 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 6f8df7ecb6d..5e45975d349 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -522,6 +522,41 @@ int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+#ifdef CONFIG_OPTEE_TA_AVB
+static int avb_set_lock(bool locked)
+{
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = avb_write_lock_state(avb_ops, locked);
+	if (ret != AVB_IO_RESULT_OK) {
+		printf("Failed to %s the device, err = %d\n",
+		       locked ? "lock" : "unlock", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Device %s, rollback indexes reset\n",
+	       locked ? "locked" : "unlocked");
+
+	return CMD_RET_SUCCESS;
+}
+
+int do_avb_lock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return avb_set_lock(true);
+}
+
+int do_avb_unlock(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	return avb_set_lock(false);
+}
+#endif
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -537,6 +572,8 @@ static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(lock, 1, 0, do_avb_lock, "", ""),
+	U_BOOT_CMD_MKENT(unlock, 1, 0, do_avb_unlock, "", ""),
 #endif
 };
 
@@ -579,6 +616,9 @@ U_BOOT_CMD(
 	"    and print it as hex\n"
 	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
 	"    string to persistent value <name>\n"
+	"avb lock - lock the device (verification errors stop the boot);\n"
+	"    resets all rollback indexes\n"
+	"avb unlock - unlock the device; resets all rollback indexes\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 09f1534c3cc..9231366d5fa 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1056,6 +1056,29 @@ free_name:
 }
 #endif
 
+#ifdef CONFIG_OPTEE_TA_AVB
+/**
+ * avb_write_lock_state() - sets the device lock state in the AVB TA
+ *
+ * @ops: contains AvbOps handlers
+ * @locked: true to lock the device, false to unlock it
+ *
+ * Changing the lock state resets all rollback indexes in the TA.
+ *
+ * Return: AVB_IO_RESULT_OK or an AvbIOResult error
+ */
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
+{
+	struct tee_param param = {
+		.attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = locked,
+	};
+
+	return invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1,
+			   &param);
+}
+#endif
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 66655aab871..d2136b2ce02 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -45,6 +45,9 @@ enum mmc_io_type {
 };
 
 AvbOps *avb_ops_alloc(int boot_device);
+#ifdef CONFIG_OPTEE_TA_AVB
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
+#endif
 void avb_ops_free(AvbOps *ops);
 
 /**

-- 
2.53.0

