Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD4606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nJ7Ok/ul;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lG1qdcxj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UBtw77zZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16BC181488;
	Fri, 23 Oct 2026 15:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQfpA2-JIjYk; Fri, 23 Oct 2026 15:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2BE681463
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768329;
	b=nPjYFnp0AOzjCsiiaiepf63DS3mVUmUkzHBtCitl7BHuGSYMOlekeNyCVw7Z88ZbhMMf
	 4KHJTQzEVbWJKFEY+JDfdfPtpPXuRYHbhhonKmZCZHfDQ0IiVZJspxJrd4ZaJbpXDylqj
	 vjq6hbF91VFpi/5/mvl/scKO3b50dtt9jqlKN2a+lJDiI5rAth0LFLfylr0GU9/qwerRd
	 Vjp1w85D/AbXIuUeyHKdDht+GDdPfi2CZM9L/N+yPvqFBfwr/aN+JfakBtwWCgT+Z0bdz
	 kJnq5NeBGhhkVebS9jNHt+wKT2tYAqJ8+3bzCIeiMFPBk+3FUE85f7APKGfYaRzwQmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=;
	b=HDPeUbaZS8j0Nbnd1dgMDrTGwTT9JVyNCYFVMrd7/DqOyzxxA3IcW7ytEj7EmUWUVMy2
	 iIX+MM/7xJXRvJEo1U7WtW4XMusbLUPWCg5kKv8KPWYuUrHcYYO1akddTIPjZyQpuB/71
	 GcSeV+xqbRZ73qUdQj6J01cQdX9QN7QLoIWJMZJiyGZEVy73qF1R8M+Vrju/7VvfHDsGL
	 E08fxYYfATc3JGt1J3kq7p/i93YVZFVCzqBMEVzaNbqVBA7c4D1d2f3SfRTAydPNg01C/
	 OOXLeLo4ABs4IGogN5RnseSiz9/BFbFykXTQHtanJdT0V7sAGB7YT1zclAMsdqAxEMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768329;
	bh=qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJ7Ok/ulgt8w4mWVquYT2d3wgPpN+hfWsXrYbrvsONIG6tkwda/DpFgK8z3qIoaYP
	 kA1WPSYycqVGXbux2GongXT36/WBGWtXajb4dDVrXYDSbTPk7vKMWN10Vw6Y7RO016
	 bjEE9Bv98YPTnR746qnquvLXz6Q5DOujYk1c9hDFdot1vr1uC5ApAfZIojjWaSlToP
	 Yc07/q4Jk5Q1pCWwdUI0hafdL2hExlSZCxKCyELEeKeKsnDnkftfumMpHWkVTeLbey
	 WE2w/EP4+UeIuJ8MIur0pe14T0cQiu15nxgmb/L6625eO+f492N/dcpdSuxOciQ69N
	 TxLrqOoKrmYEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2BE681463;
	Fri, 23 Oct 2026 15:12:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73FB53C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71A14401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o17Kki7zWj7u for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4FF8C401D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768321;
 b=SIiEd1DYcTVv8ryAycy0P04vY4aIdtDB3hUIUzNwM0MZGGFtcrVPNO0sz8+9bIOKtz2k
 ei0eAqfqxCeoy4jwS+imI4Yl8DIpxfwFba6f1GS97QbB9iU3vR7dX5xXafPI+r6s41Ap0
 c6LEkolyeUQvn+bgk+fJTjiAnYg9DczXITWHqQyz1ob+vGYpzV7vhL22Fcip5Qv+UAdlm
 /9JBTY5taH8n1T0VLLjdXcSmfDViLrxGvhcty4XsYGduvKqKywGx8u2lORpD2gXLDM4eX
 GJTC/VsnmyRG9vefol0u2ke3nKlQtQO5Wy08BMh0o47IVOZa7wUWg4iY6P+UxUWYRwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768321;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=;
 b=rdmING1vcDkbgrGAItGZnFRNb0/Q7qO3djdEJdygdGMcqFKKiH4VJurFGWj2sdnKk0w3
 utHan9ufbxH5GHWjwzOyou0pV1MmPntuJcUgCU7tGLQvFMGO24wTb30MT2ZqKKPzFZp5L
 Y/DareR1nXEuB0xHp5vjPcXtoFTRuYRFl8yfM7lQOujrqK3KXktBcUAxuodrsQSNxW9NC
 74DBdYv+FsHETxjoH5g/cIY1Jjnjtb8bPLPhiF5TvpAlh53P5BC3HD42rIGuUOtQzC0Ez
 ca6UDfrUxSH7veXqJS+WdpE1VadHF0mLgBxCM6QtnF/HChfq2gLpkPIww770fS3hflA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lG1qdcxj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UBtw77zZ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lG1qdcxj; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UBtw77zZ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FF8C401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6AfG2999833
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=; b=lG1qdcxjZCfobUNh
 zxaIcgXLuPiFAC9IE4V2ZWsqdhqm7vt73qFPdyteJW2IOT+bKdSZtdZ09psULc+F
 v9cAvxA9H4thjXl3dshT7pEB9LnoejRgquaimchcghUyw2x9udXTshzYmldSHXvH
 dxR86IBpdhOUqD/yhEuracqv0aJeAiwo41+JEYcCUA85v0QZBaeq6fQ1U9RWbdOu
 jBZrNf8/7zRpwKGKJL2uyBO0fEh7ksssy9V+DHXilV7v0h0UdODGgckPEjB4/Bey
 zUkSoZ6shPjjiilmKyu40Lo/6xExI4uiykUsLb6ToWdsuHNyBcLe8bhiveLH6q74
 UvHomA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0mxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso413243085a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768315; x=1793373115;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=;
 b=UBtw77zZzOREVSd/qnQN5aQp0NDMI78OA4at64W39GYzd0QL3tJIr5uisJQkTkCFd3
 Mh3dgv9YhjgOAcCl+zo3bP0uihOK05NmF+vxgFrakf0gOAFG6cLiu/7HftXhxu1ZMzAi
 X60QpVDeMgEN0wvzu4mO6P8L/QAz5J4UYVyJ1mZkmW4idBAoo1JBFhawh4IdZbVcj15P
 BInd1RmZgFd4XbnAnPxg9bROhmVWwsjH5HLFKAOvoddBIasMB/luyBquwCHjMsfr3EvH
 jqlwzrOvtYXevwL4QVFM9at4FQiXfU4UZtuoAgs36pcRsEslXjtvuBbHH2eNT2RerFCl
 Z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768315; x=1793373115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qxwZpiBu14KzvXIn5/+H58WfQHjbOgkkrWjLlLiWSY8=;
 b=GIJMSIYORGgOgnkGUo8a2iO5ODf6rMw/pHAcZHLGOyFbVnNNzg48ZgrZNUNoI3SnbA
 XtI4k0PyaYYbJ9ofZrnQ0Ct+/YukAKgo9c40tzuBZO6y9SdvxzlZYZKYzJB/8wPBvuEP
 LVhWO8xCXhnm6StXlk8ZMbOgZan9pb0Sn8pPWGUGTJKWaMQT873kTi7iciY9j7UW5nq/
 CZKrvSLQbhT2k3ZDh3QqGWvaAx2Nd5grXsfY9/2kDzC1P1VikmluPbUrus15fpTvleHl
 +Iv2YeNYL2q+wAl1ez7mTIse3tr2/7SdVLjM3or/fd5nNkSIcC5Lg9GRNTyWJVklw8Z7
 pwRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbBqAfbzDmja0ZPnpxG0jjJ/lmaPK6YRZMuU44zjaNLz5VAuxmPxdDs8N4jsHUC4MGydPu6Dc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbzU4dRNfayLNeoSmdzwdxQHYJJHfE50C0Vpi4JbjQXzVnsCLP
 6iPpknQ5iXOQM7gfb1kWUPDHFOP0kTqtPAFEhnnSTnVm/rja6zYGucZat1JLP1LNXgC6CEpNtFF
 aIcA3VIwNoh0Z6RerDlFlOifTvwUCbnqXgLcR7RunyKpfJ0lYpliV/UAvquBHpyYQiCD/hOU=
X-Gm-Gg: AYBFou0l2oznhOxA02Ms0Q16hXe6QMC+csd0m/eg6iGBI3FAi2WgoAfXllOSSeti+Kg
 dRmoo9f07Gbq/FiAGcZBfufb68h3M4ow0xO4LXAM2oayGSgW91HekwwhUR2jVZW72txEiSFqjBP
 jjuqWiKeYrmNH8/Xdru1TLugNrFGYDENHh7IvnnJu+P/q55hQIOweOA6BBP25rI+i/EtIHH5Zxc
 lJCNS+BpF+SXxk7au2jIkqwR02tc6jyRKln0M/f7bxMX+PlPangzGm/kf5JxEYOV1kf0XlCGtB3
 zlVG5jbqC6Q1WIuVkZuTvD2g3Qqj1XpgrWsoZv6jR7riIz31lUerCfGu87RYVTdezb9SFW9w+45
 zgSaOIG6mUObhKohrYe4OzWxJW+LPxOcQVoQo64d2XN0j5Yk=
X-Received: by 2002:a05:620a:880d:b0:93e:53db:d59e with SMTP id
 af79cd13be357-93f627233d0mr864685585a.23.1792768315208; 
 Fri, 23 Oct 2026 08:11:55 -0700 (PDT)
X-Received: by 2002:a05:620a:880d:b0:93e:53db:d59e with SMTP id
 af79cd13be357-93f627233d0mr864680385a.23.1792768314442; 
 Fri, 23 Oct 2026 08:11:54 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:53 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:11:42 +0200
Subject: [PATCH v5 3/5] avb: verify the boot images in the buffers they are
 booted from
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-3-6453a6f63028@oss.qualcomm.com>
References: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX0ACMQP8K4zeL
 CzX7EgxIfZ9rOhPUu67/ums+0fYzgPUWKGqB8URqHXUpYjYdi9SrNSyg+Ha8F5l1eGKx44MO4Bh
 H711RrHlXTAA19FViuQUUKKw9ZOC04AuMurD2QnDCxmktUPSl+K54F3QiMP8V58TgnwEYs98kfb
 HEpRKLr3cKhTXBqO5066wLaMmhvXvDi46LVApudgnvjzVlU5xN1ZSQbtAKUAz0j2HW1RihhMj5z
 GlVYA5X42tASmu4w70yurQIR+NYH9sxOUfKHYNtm3Rmgg7SbTEsgM4KCJz1KKGy3/kb0txTH0mX
 9GMghIl5wYjQEBtBZuXZx40CJ7GaWd5PIZi9Vf1whlkzkXd6XZATUMQbknyRRhTZZM3DI+Gt35y
 JYMeS3k1DkPvule3GOjqi1r5i6InoTDWM4x9p0gGS4lThv2lTJHGSymLR3WeZeZT6Nf/XiqPdAB
 bsx4tbg2fZ4leOwlPhA==
X-Proofpoint-GUID: 0sU_pijI-u5LHayyboRsDDXN9SwX2F_7
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb793f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=qJaU2Z4SIW9asTuPRKsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 0sU_pijI-u5LHayyboRsDDXN9SwX2F_7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX90VQe4WhaPbp
 X39GFNuMmSlgb380oRhak0+M6CeydluboPOusxWA4Igb8qzyR1/OLvX1YHAACfmACk+TIUxy64N
 llhQAZTa7vM+YjkgjEr/+4ta7XoT6SE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bootmeth_android let libavb read boot and vendor_boot into its own buffers,
hash them and free them, and then read both partitions again to boot them.
The bytes that were verified and the bytes that were booted were therefore
two separate reads of the storage device, which an attacker able to
interpose the device can tell apart (reported on the list as a TOCTOU
issue). It also read every image twice.

Load boot and vendor_boot first and hand the buffers to libavb through
AvbOps.get_preloaded_partition(), so the hashes are computed over the
memory that bootm consumes afterwards. If a hash descriptor covers more
bytes than the boot image header announced, the tail is read into the same
buffer, bounded by the partition size; a descriptor larger than the buffer
fails verification.

boot is always loaded before verification runs and vendor_boot exists from
boot image header version 3 on, so the preloaded buffers are registered on
those facts rather than on the recorded addresses, which do not have a
defined value for a header version 2 image since the bootmeth private data
is not zeroed. Allocate it with calloc() for the same reason.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootmeth_android.c | 73 +++++++++++++++++++++++++++++++++++++--------
 common/avb_verify.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h    | 36 ++++++++++++++++++++++
 3 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ae05c084883..6f7e232d2c3 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -48,6 +48,11 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
+	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	ulong boot_addr;
+	ulong boot_part_size;
+	ulong vendor_boot_addr;
+	ulong vendor_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -235,7 +240,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("bcb read", ret);
 
-	priv = malloc(sizeof(struct android_priv));
+	priv = calloc(1, sizeof(struct android_priv));
 	if (!priv)
 		return log_msg_ret("buf", -ENOMEM);
 
@@ -353,7 +358,8 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong image_size, ulong addr)
+				  const char slot[2], ulong image_size, ulong addr,
+				  ulong *part_size)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
@@ -396,6 +402,9 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
+	if (part_size)
+		*part_size = (ulong)partition.size * desc->blksz;
+
 	return 0;
 }
 
@@ -440,6 +449,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
+	char partname[PART_NAME_LEN];
 	bool unlocked = false;
 	int ret;
 
@@ -450,6 +460,33 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (priv->slot)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
+	/*
+	 * Hand libavb the buffers boot and vendor_boot were loaded into by
+	 * boot_android_normal(), so the bytes it hashes are the bytes that get
+	 * booted and the partitions are read only once. vendor_boot exists from
+	 * boot image header version 3 on.
+	 */
+	snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
+	ret = avb_ops_add_preloaded(avb_ops, partname,
+				    map_sysmem(priv->boot_addr, 0),
+				    priv->boot_img_size, priv->boot_part_size);
+	if (ret) {
+		ret = log_msg_ret("avb preload boot", ret);
+		goto out;
+	}
+	if (priv->header_version >= 3) {
+		snprintf(partname, sizeof(partname), "vendor_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->vendor_boot_addr, 0),
+					    priv->vendor_boot_img_size,
+					    priv->vendor_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload vendor_boot", ret);
+			goto out;
+		}
+	}
+
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
 		ret = log_msg_ret("avb lock", -EIO);
@@ -566,6 +603,26 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
+	/*
+	 * Load the images first and verify them in place: libavb hashes these
+	 * buffers (see run_avb_verification()), so a storage device that
+	 * returns different data on a second read cannot slip past the check.
+	 */
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr, &priv->boot_part_size);
+	if (ret < 0)
+		return log_msg_ret("read boot", ret);
+	priv->boot_addr = loadaddr;
+
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr,
+					     &priv->vendor_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		priv->vendor_boot_addr = vloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -575,18 +632,8 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
-				     loadaddr);
-	if (ret < 0)
-		return log_msg_ret("read boot", ret);
-
-	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
-					     priv->vendor_boot_img_size, vloadaddr);
-		if (ret < 0)
-			return log_msg_ret("read vendor_boot", ret);
+	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
-	}
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 7b60be4da7a..92f4f82df48 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1103,6 +1103,84 @@ AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
 }
 #endif
 
+/**
+ * get_preloaded_partition() - hand libavb a partition the caller loaded
+ *
+ * Without this callback libavb reads every requested partition into its own
+ * buffer, hashes that copy and frees it, and the bootloader then reads the
+ * partition a second time to boot it: the verified bytes and the booted bytes
+ * are different reads of the storage device. Serving the caller's buffer makes
+ * libavb hash the memory that is booted afterwards.
+ *
+ * The boot image header may describe fewer bytes than the hash descriptor
+ * covers; the missing tail is then read into the same buffer, up to its
+ * capacity, before it is handed out.
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition,
+					   size_t num_bytes, u8 **out_pointer,
+					   size_t *out_num_bytes_preloaded)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p = NULL;
+	size_t num_read = 0;
+	AvbIOResult rc;
+	int i;
+
+	*out_pointer = NULL;
+	*out_num_bytes_preloaded = 0;
+
+	for (i = 0; i < ops_data->num_preloaded; i++) {
+		if (!strcmp(ops_data->preloaded[i].name, partition)) {
+			p = &ops_data->preloaded[i];
+			break;
+		}
+	}
+	if (!p)
+		return AVB_IO_RESULT_OK; /* not preloaded, libavb reads it */
+
+	if (num_bytes > p->max_size) {
+		printf("%s: %s: %zu bytes to verify, buffer holds %zu\n",
+		       __func__, partition, num_bytes, p->max_size);
+		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
+	}
+
+	if (num_bytes > p->size) {
+		rc = read_from_partition(ops, partition, p->size,
+					 num_bytes - p->size,
+					 (u8 *)p->addr + p->size, &num_read);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (num_read != num_bytes - p->size)
+			return AVB_IO_RESULT_ERROR_IO;
+		p->size = num_bytes;
+	}
+
+	*out_pointer = p->addr;
+	*out_num_bytes_preloaded = num_bytes;
+
+	return AVB_IO_RESULT_OK;
+}
+
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p;
+
+	if (ops_data->num_preloaded >= AVB_MAX_PRELOADED)
+		return -ENOSPC;
+	if (strlen(partition) >= sizeof(p->name) || size > max_size)
+		return -EINVAL;
+
+	p = &ops_data->preloaded[ops_data->num_preloaded++];
+	strcpy(p->name, partition);
+	p->addr = addr;
+	p->size = size;
+	p->max_size = max_size;
+
+	return 0;
+}
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
@@ -1170,6 +1248,7 @@ AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index e89bb229e02..2b5b24958ae 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -23,6 +23,26 @@ enum avb_boot_state {
 	AVB_RED,
 };
 
+#define AVB_MAX_PRELOADED	4
+
+/**
+ * struct avb_preloaded - a partition already loaded into memory by the caller
+ *
+ * libavb hashes the preloaded bytes instead of reading the partition again,
+ * so what gets verified is exactly what the bootloader goes on to boot.
+ *
+ * @name: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: start of the buffer holding the partition data
+ * @size: number of bytes loaded so far
+ * @max_size: capacity of the buffer (at most the partition size)
+ */
+struct avb_preloaded {
+	char name[32];
+	void *addr;
+	size_t size;
+	size_t max_size;
+};
+
 struct AvbOpsData {
 	struct AvbOps ops;
 	enum uclass_id uclass_id;
@@ -32,6 +52,8 @@ struct AvbOpsData {
 	struct udevice *tee;
 	u32 session;
 #endif
+	struct avb_preloaded preloaded[AVB_MAX_PRELOADED];
+	int num_preloaded;
 };
 
 struct avb_blk_part {
@@ -45,6 +67,20 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+
+/**
+ * avb_ops_add_preloaded() - register a partition that is already in memory
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @partition: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: buffer holding the first @size bytes of the partition
+ * @size: bytes loaded in @addr
+ * @max_size: capacity of @addr; a hash descriptor covering more than this
+ *	fails verification instead of overflowing the buffer
+ * Return: 0 on success, -ENOSPC when no slot is left, -EINVAL on a bad name
+ */
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
 #endif

-- 
2.53.0

