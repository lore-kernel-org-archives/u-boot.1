Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45D1CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A86C80DB2;
	Sun, 11 Oct 2026 14:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNsLjkQ3Uh-L; Sun, 11 Oct 2026 14:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BA84809BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729740;
	b=tKcDg0yj5o6y1mdBzpjU2raZ5x/L0j/PfaUp1YwmYU2NxHSnSSixpF8iEtylt9VoCOJw
	 LgTOnJyE5E/LMeP0aglmcWpFP7lRnHk2pLFYJjxvqqRzo8JgpXImn4SYMUYKZ/dFc2B9x
	 XIOjjjcdG55lxKjTW7iXVFW7a8hzVUUc1fMkXH97r1KjnykewFgdyP2oUYjFELhuNRO/B
	 iNJ05gM5m+eDGhgYRiTCgevFsN6OMYr925SgIkfl8KOx1k/ghSnDm0+a4wNAdnM+YJLhB
	 CMdSKgV6gBYiR8si5GBkIAEtN5wt1o9qyqSs7ukyqV9x5j7CHitDGOE6xGatJn8bSpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
	b=QDnxrTe5XIAv1tNA5TFOyVd43/GJpdslfzVaIEJjgG3X1lTGRMqpa0f4GJ5ULPx3zzt3
	 VAtmBAxFCX9k2bZE50LUtTXEyUEjpBnp1xVNDXtwn0pdjuuHqNn04TrKlm393aOzR9p+L
	 EGWj/F4n2EV3WKeKfktv2iUHJ1dhyVFsfpy6z/lSqLeYeXI5HP9/DWw5jElVC6GVjoeZX
	 q5iuMEmoaIgWuFJkA1joU/UKcm7gfJz1qC3lIBXnsbGYS6GlVU5VX5FK6bj7nhVuOtetX
	 JB1grR0NxkUcMprrCI8P6KQWfXg7odTf116KERoWNbX5a9I7yn4koNt66k3Id3YveSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729740;
	bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lryv/5MGthe526OhPVsREJJE6KHIDypKTPEZgmCTh9K51laVp/f6Nr8rqgCfu+DVo
	 U+ap9jy/7SXlu5mXvWfQWNL0Bd3qPLDssRS6BVYTCPMhUl95/3UKjpY2iacFquyrhB
	 xtQM66FFyVac/u2EeoGMPW5U2Q4MvHibQ9JE9rZHu61jOWp6n9fvWpVxFiiPMX57ZA
	 Hn25ORZ10IEUrasvy74M4ztkEFbXtkE73HaM6xRAxSPKOprhH8YIAVIeJQvGJYH8+Z
	 Q3Ovl8iGNfdyHKe4ILglkCueufCKJz7YEMHDgDtOy5adRS/YFnNlygaP4fWK+d0/sU
	 LUNHSWxhz0PLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BA84809BB;
	Sun, 11 Oct 2026 14:42:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 921AD75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 781CD40071
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WwMRtcYduKm for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D3BF4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729737;
 b=XQAB0s5SBUH/GCofcKXWenQ0eavDSLTaGUjzYP8oSG0rHKOI0huwPUXoFbC2diWNECVJ
 DaF/srO1qs+AOGAipZWjUJasq89JJ3cAxwDJHjDZsmqWUL9Y5t8vsKIBrCWFY8eUhbeTZ
 O8kp325fCwpi3d8FlybhI66Tc+TCUwD960mUdodmbYj3iAiXN6L6vXnpWMCfp3Ur0W0of
 nZR3bP2QKI5tMB1FJOIQ/1nwgyKV1Sr02lRCtkoLH9W76HlFWxahxOfw5LKBEmP8Nliji
 4bPidG3ZSIBrnmgaPEaprN/K4U5UvR0p9KigW5RFREHTWdt/anYnCM1wft6Etynv/lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729737;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=MMbJew7MBYgNb/ac0iAmJm3Cuxy4aoHQ4IqhbLhXLtbIQdY9S6eUj8cPcGZxWPHbDEkK
 amg+UVfLc5gAJZ4hTKhkZIquOKjkVdys2DBQ8GrG+/U47pn8wat/P+rBIfYHbR7qQw5CU
 rQoQLbzwGcb1wJN8bChkIa/2pNSg476tuduvYEAyvYECcx7a2ix3R6ZZl0997VZ+llxp2
 bKGKEBku5NvYAyuEU4biHp7JAdJRmGQWujY1AirxT9jtvceAh2piBtKUaZMoLuquTz9BO
 Xvb57ST8aKXQk5r55EbVzXfyWqoMHtiB3mVOaxacUZpvoUdWrlGa2aDBAQ/XhvT9Jjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=buC62MaO; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AWIQF4To; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=buC62MaO; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AWIQF4To
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D3BF4002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85QsG1513236
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=; b=buC62MaOvTpaYp7j
 MeebDa82ySJtY46oeYvjw7/QaiZyHV3N547xiBruYIasUIY1KzGXwtK5mN/qVpsy
 1FKh0999ai+MXrrSXc8moFKTrNhWm0jze3jV/n/+R6djDanjk5FU4pKRpObANAxZ
 Ul7RMINmc1TuIZfgltvmEVUn0INa+9ouX6gfmVzBNtq4ib+BEy0OTZG3d1p8qczG
 uMcvUQEDvb0ywXpfWXeyKf8WvR8qNLwgjDQDF76cE5ZRRcybjlJ6ajsnUpmM/5FD
 aqbjuzETfVU6Srrpv5R7WAQVDVgNPfvovdS3tEXBNKAYxVp0kbg4AsFajWQWu/NW
 T1soXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjk38j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc359d9easo205974285a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729735; x=1792334535;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=AWIQF4ToOvUYFBuL1hnBejeFpXtL87iLNK5pAawRbuuCf7dHuZ6qdNXQtZMdelzNqV
 Z1MxlbyoCYaRLY/4pePCa7hliw8l6IFffjgQj5ZLMTMmhhW0zS0WbCmPjZvmisGQSSPS
 7cGirQ4841vjJvOkIrxE1g6r3cyVTUyQxn5H2d1Z9cPyOx4fQ0j6ht63VL5e0X5isC8U
 6UkBPKIwzJyUQz8Ht1d2lKnj7uzm2qXA9Jd/7I0MmKk1eZHA7ASj5M20qlB764BP3J09
 tUqLWt/5qW6/4ohBGD52FU4Sa2aZ+sZAWElvZXsM6NaFWefKIIHstmT7dypbCP7OJ3Ql
 4TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729735; x=1792334535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNpAFo6Z0BZ5d5PQKvDEW66FoSlsUbgDfDWzrVmQzR8=;
 b=AYQsLgdHrbEgE+LBuIBdZYdqrc3WNlOR/7rZ5Em2uRRYt1hYJ3PXCdOz6N5dSvNfBm
 gJu99YJ694JotVOeYrSxoN/bZoBx97oq7u+IrevPe4ecP9VVVDHEOWU9XReF9hUYRE42
 tyc6CZ1g6UO9jADfUL/bvSfT9PJo6TllpSOVRdWe9Fy1nDumO5yyje0qxM3HUZep+x13
 0Cqx3+bYYKGIJkG9kQOjBn6lD09ceYRXhaJHC4ad5Peq68FOqF2O3scRnOCkiID2R+Da
 1ADJudpekrNHTAry0TJ1tJsaOFMtZ2ujQv/2ZKc9+D/OSJpf2YIOTlXokDIb4tWkrtiF
 +sPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWZH+A9tFuM/AcxX3v+zz9tiiGOabw+MIvByT2sQMqpt6OZnVRuMrUiQ/qXRqNRt08Fg81nw8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJI+v39AqTc7mPz8HQ230Ai4SnITqJZSobj91PpL6bPocvWvXOQ
 VkpW/vEoWzGuVRWUQLOqlh4O5GYo4Dt1s2af6qpalZ0dpii29kI2707x++N/R40JgfNDFSiGQZi
 Vh3hZpaurjpAe7VbpK5pfageBb9qteQ+pPXN6igRm7+977vT36DXQ7eDpTjHPxMOboT3RygohNm
 X+O1Wx7A==
X-Gm-Gg: AYBFou30e6nLhXYRNdo0zqtFkflGOg0c4Dbi2sne/kq+L+Kx2cxV81IowHw2Ak/eKsb
 aC5NPYJ+bSYxAV3Q+XcLr9kMZXqsjYvLIKIPbFhAh2HzkMW1t2pNvj0BKFmpBluQ3FmSaPzDQKI
 kQEVKS6hELMG15jdoXWdXL0FKFvDTNsdERJPVCgZaUg12lsVn5k9MOqvYTgkdvE1AkRBrloJxX7
 ml0tPdDh79nZyiNHrBk+Zq37Un1XW6BV5SqXe1xKqTIpbmlfKD8vJdkxBoj4ytxO9UoxicRTDx+
 PrbmEHgJZgeVHPZuWjkENG36wro7GpK871iq00dtlfqrIuVRiaUZZb9HIXo/EwNs64zJKvFlYBy
 0UcOdwXuF0v30xB5QFAL+oS1LsaUQ6GE8g73JGr7pgT6P
X-Received: by 2002:a05:620a:271a:b0:93e:48fc:aa85 with SMTP id
 af79cd13be357-93ebd2598c1mr1190232385a.43.1791729735492; 
 Sun, 11 Oct 2026 07:42:15 -0700 (PDT)
X-Received: by 2002:a05:620a:271a:b0:93e:48fc:aa85 with SMTP id
 af79cd13be357-93ebd2598c1mr1190229785a.43.1791729735071; 
 Sun, 11 Oct 2026 07:42:15 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:13 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:41:57 +0200
Subject: [PATCH 2/5] cmd: avb: add lock/unlock commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-2-a45aeca54016@oss.qualcomm.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfXy5eInxMpumTm
 IWj0ZSSvYcwCqbF5qvtqD+WZThcKdKlr6h8tZdo8byZ5kgScG5P1GbdOtfFhCw1o76sp1biAC1h
 yzAJUDJpopDajL1WwB3ypLzqD3RX4QUHYMRb0cq8MPKMARLDtHqprTZhxP1zTmWZ4Hapw8Oel3c
 G87U3GliwOHa6rkGnNJ7YEENCWpPKogECsMl+ufQKOGZ/1jU8kC4oUghqYGn9W8CObZ3PX14VYl
 rzm4IN1rY/9kjqOa47ZfHyqocESGsmJAAALxj1RDzRdOcI7eAcEg3XoXCDJ7G81xTa62JSSvXyu
 QN29LtPROcM78YIiAnk33et6+22stlId2oSTBYpeCbeTxYCiQYjjJlXT3qcRcWthuNjySjdcgP/
 qe48Y/deJsImQyez5a1UUaNTIxez4Wzb/gS0SOArLR89opcCjY3pr0tLYlmXmf2B6cSiWIzFpri
 NznNtb2kaUk5bYCYaDQ==
X-Proofpoint-ORIG-GUID: TUr3CxdOCn7-BSLmVfnen_-iu00VAuMj
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acba048 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CZvO8b3GW2mycMafNwoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: TUr3CxdOCn7-BSLmVfnen_-iu00VAuMj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX5R5fzsTvm/Mk
 regHbRGBUOiTXqz1+OrEsqrKgq4oplUqRNxhTOYWKMpAFEVAWzzUnK2uFK8q8S+BoLfk6veTYZi
 A3GcxdAXiZTxNr/jR+rLwbT/IFdFnWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110058
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

