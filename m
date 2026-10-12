Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15B0CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8C2C4054F;
	Mon, 12 Oct 2026 19:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRpt04Na8lw1; Mon, 12 Oct 2026 19:57:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFBAC40537
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791835021;
	b=hilMsIxF8lxRxzUlZXAn+fZXoaOMhMhI0cEpXiPxqKah1FMCMb4YO6zn0ICIo6x6nggm
	 AX+c8XecUdNojyg4eAYrupHtLvG59Hux/c/ORFm8FN/KD3bgSP75qoNC2JesD8DAdk/b6
	 P0gmVlTAxpFGTdGzl+l0WMSt0K8prp75A4g9VOjsrCsDB4olbjhMUUZ8+sGfVy+uLxs7P
	 JPvBtccgzNF7myffoeXTCEaCYnLW9b1SWAdoFvNynfpNepee1Rj97evnKMzfY/ttNBPlJ
	 2wGx/0Jga30Gy/0BztXgs9Nuxzqtvp32OBN3rQpLnsMV7Vznb7y6kKM42CIE7i9ptKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791835021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tkFihelmOIOs2k7sajxJpJAgK3I0E6v9CR+cD5X95Ds=;
	b=hXrk65POJsXapPzsb2sj+Ao5Bjddd2PAYnrFCdTzs/LK9ueQl+qaR093iYMSMBA7gZn+
	 9n8JTJnDUIn0NXELQB3t8q70legsZeicJOGJJ8Y5mk0rgLruLknZHixFpi8M2kw/lU6uH
	 sXqmb6zKv8PW3kZ0XvcrNLa4e71t4/TPuLfbMkp28D7l+YFEbug5Mq+tNu5aXmrO5sSJo
	 9VbCOjQHlyAfdjPOchT5PICiMIuCGH+eBAYqpELe8VxlENXC4qNuGWQnwZ4gVH890NvFy
	 RmnKugDW4h9IfK9ANg/qx7OBye/CcMx9FmNUEfj3qq7RKBTFLji1S9/AX+EH3O+IplA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791835021;
	bh=tkFihelmOIOs2k7sajxJpJAgK3I0E6v9CR+cD5X95Ds=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=buBbid7/AgStS9uuzIiQxZZIBMLmDuyTzj5SUP/R6h5/tUGpiAzdiyYRqKkJ4iNYn
	 9SgKERWmTimPhtsL4wWNHz641Ryg8UPgXug9pw9ViW3AV7lPOdUBLX7FGWmwD1/+2Y
	 Q7iBSbXH/Pjg0HBnv0xhM8qHF6zQeb4BcSW+j/7TeGhADMfemjEPU+lDhVtFpxLbF7
	 W4U3xXFkrkkm5nb7vT41AbVAzygSGzOx1jKe4zRXf4yT6XyCadQn2Rpukrn7P1bKbk
	 Ch4z+X7MRQcwQw52FYuF5IiXJZaOsGg7tehPWC50tRTu7ihq28RnUh1xpQdzcm8Btv
	 dgim8V9OhjzEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFBAC40537;
	Mon, 12 Oct 2026 19:57:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86CDB2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D287400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIv68qE57PPu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 53D794002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791835018;
 b=Lfdc1zvyV4tUD3wgx0LLbuRiTjboR8ABtyAtqNr5QRksplSp4wio9NFxGjJyywsQfPJw
 DUgAj+g1U2BJScZBiz5HGT35x8YkT3wLMVQaiLba8tCBRShAckbSPFnulY+6WHEyCh58f
 4OrVhqT1qIZJcMeGgMeZNZKB5NUb8Gy8ZrCMtEo25rNULgtlUc5Trz9M96qucRvBIwmED
 sLtH9RLmxUTwvYzjekjNsmsWiq7VrX14QCt1PEH7TDmPLigJz+GbcL3zkT7bbll95CGqr
 9qAB1XF0guo60VAaAWDmHKVEYiABSIakd8InU2+vNJ+byCok5HGisBq6hjyK0k6a9Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791835018;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=tkFihelmOIOs2k7sajxJpJAgK3I0E6v9CR+cD5X95Ds=;
 b=lkXPIxWJzFyei+poBy1ceBGNNvgpVix/qcvCuinfiVP4/est+DRfyPXiBkZjSUf9rYaU
 +pXNlMvFk0IpmqGmgtELuz2Tj6OyLzBPE6bCRxFB+v/Vt/DLifu2hAtqvKY5qGixY6Vs5
 VUDddFXHHPQtaYsAP1Ye+dZpv9YW40TXGy3fyfoKROfufhgXGCTRyQbgvGm515X7rDGth
 KGmz22G/0vN/SEYyQlTF6CuQNWSyrFchb6MDA7xEeSC1n65er6QWe+mY35oDdjq+qN6Ke
 wp4Kn6IcLiL3436xJNihNL6zzM0sz9Twbcp2rSl+jSnlTRXDQhDzCbN5Xj88d1669lg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AIJwIjCt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RM+3uDqx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=AIJwIjCt; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RM+3uDqx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53D794002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJNVu52912120
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tkFihelmOIOs2k7sajxJpJ
 AgK3I0E6v9CR+cD5X95Ds=; b=AIJwIjCt+mNoup2vIfC/NyplfX9sBJ0ZQQIHaq
 QFgyWmg2sXkERiuG8EpcZYdgDJZ/tSnHSNY95IWTpbPFeClkxV3H34jiijQhsMLa
 HVwnqCoR4sIbk5Z59Z+P2ZcEjj+SGKcq+O7RE7wTkRqy+kDdGMuULcI0faye/KK7
 ZDP3YW+cEz3eZpfq9eQZV391M5sx/UwOxgeIJ4rgFYbx63c5Ghb0/Vy37Vjuwn6Y
 M6itdSuGs3xSqlCuyktyr53H7AJbzuIzc9DKmz652GjEggNbIzs3O+oeZjQomP0t
 Y+6JxTN1BohNTJwE8LxA2zDmgnEUYLe1vfnhFKB3fYzqXHgQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w0kt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b529a8610so52213546d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791835015; x=1792439815;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tkFihelmOIOs2k7sajxJpJAgK3I0E6v9CR+cD5X95Ds=;
 b=RM+3uDqxwLY1fIBb3qRx/0g9UwxH5VDFP7/pB83f4I2DMQg5WSZrj/Y1plGJxT2D0K
 sotMSP6qGBLRoIZZjB76tvAH2jPfdjutBjUm1W/gom9GJmtZQ5LK28gmy9W9joK4/FZo
 EyiqMOIsiiZYd9v4BEa+eOuWI9mioSeY+PQc3GfNFhOHI7h8LL42GHxqmP1jyf95kfRi
 k3ox5/Z9yctL+0S00eA+adINYga6x3o6f0rw4xWOCr6kVEUbNRx2hr4K72rkWW0+s7PK
 Jq6Y2LholKPWyWmv9dxZsoHn4Nv+46Me8mbybdlQwbH2p0d1/LLn1KBM1DZMFNfChLaK
 qEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835015; x=1792439815;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tkFihelmOIOs2k7sajxJpJAgK3I0E6v9CR+cD5X95Ds=;
 b=C6VL/j0Fj3qbqhkwL7N8vHzyXWcDVYcUG7EjatgF/PpV4TQNQjDn4o9AEdR0tR+7qH
 ouCTct/8oMdks+pxYTnl6TVenOahuXpqzF/OO4y5u4nnsBWD/ozc+6Eud39G+olIGxXS
 n1x13Yz1JjuC8Z95ae+uieVFCHJgWn07V2JggxLHW0EXZ7t3u3CTI4vBr7AWhInjoR1E
 q2wFXTnIha+fCpWGcIPJZIFH9aqdn5v4ksx607ryo6RGchr0/or4FJBGxv/qjCjFKUbq
 3dOlR7XRR9Xtbj3n9PHVfzzcnN25jvsAwm+oipEYd4fiYqvaUGPkuIl44DHnhgPiZRUf
 1bJw==
X-Gm-Message-State: AFq9FYLmcts1vpFX9Ss6+KVErqXBUUZgXZ3VTWum2A7cM2Hw33n2JMTF
 Ngrrpr74uVjt4SzIqOUdKHZ6EkdNCBH8uemKp7d7/K3AivsTIhVZE/MTyDB9mpeskddu+akEfx5
 /qSH+vXmPAN0Xmp2ZjzTpf62DYmS+tC+8yodP51VXWHm13ghbzaLPi7bffr6YjHnNP1tLr5k=
X-Gm-Gg: AYBFou0wvGjB0nXEbJruOULQIrBY964V986tutXjbUF604ZOXzNeSipucI2/1GX5pDZ
 B/YSiqbRvG1zubUr/OSMp+2SDynOLhw49c0n/+vxJEi+NjVmXMAJz3U+PaY1xj1Qtj6tAwWMXB7
 F5XOEuSEUWhDF/AGVsUfkxV84YFB5lXTFZEk6uEAP/C2c0UUIMRfy6ml64nVkwSsXN+WpAimiSg
 cnSrUUPkmyzANiETDekIwew76pXx/ok7I6YBbtEtMfpCfiS2jJYSTCfn6WikJJyRHckeMCsJsBO
 2b5fzRQQwTStAeTdJQNYQ1BwGyPih6XXslhn8Swx3F10G7OgW266SlqmLi8sE7KbO+A7XIrcI7s
 VTawwRLpCGVi3TZpwv0qX/JNHJgdH6CGUJmv5eA13Qn+U
X-Received: by 2002:a05:620a:4089:b0:93e:4e96:47e9 with SMTP id
 af79cd13be357-93ebd1b737bmr1767846185a.18.1791835014869; 
 Mon, 12 Oct 2026 12:56:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4089:b0:93e:4e96:47e9 with SMTP id
 af79cd13be357-93ebd1b737bmr1767843485a.18.1791835014393; 
 Mon, 12 Oct 2026 12:56:54 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3bbe2sm489178266b.27.2026.10.12.12.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:56:53 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v2 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
Date: Mon, 12 Oct 2026 21:56:42 +0200
Message-Id: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBREr2JYFwNobO3KezTGAH4rTRHKR9PGe
 PeiPUA3k7xkZt5KEIIBJNdsJQEWg8ZNCcQpI3qU0x2o6RMTwUTFGed09hgDSEudjwBd8FZ1qqT
 DcKlkCbJmRU3S2AcYzPs4vrU/xlk9QMf9bW+MBqMLn8O88L33V7JwyuhZVwX0WpaqFo1DzF+zf
 GpnbZ6CtNu2fQFcaHSD1QAAAA==
X-Change-ID: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: QYOdTvavmATqPCouR9E4wTnEqi3am54c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfX7iZ1I7Ws9jwo
 YKTptqSccm2R/OkdUMveMNXaGYxPhWNdv8AP0qkoVZ5SvgmChWeRRI5U1qABgdME5/JZfvbAMfl
 9HzFcsrSiB/pAeFk20FI+n4kfTp5LOCFWv0dXrYxgU64AjaBIGzju3dVeqJeRt3sSGkaDS7gxxT
 wR/GDpnrXj27ipFpRrx0uAdzYSFmLgjXPXShI5Ko+8CT23GhmTHfydgJT2Yn2jQ/CBGhEPEERav
 6ClbFd5h2++mkkO304AFOTGtpAVeBylVvhLoG60sSh+twyjLnvivMV8f0XL4Rifu0TPXSbAhQLZ
 t5cUYXnD3Khfy/PEOCOU8zqcVy2jJwiwJI0tqFHWJssmUZRWI+8UR2slLfTmZ7f50xY+4jUb1Fp
 QwjJxJrIsn6D4rH2mxa1tZ+EmdOgPH/l8lZYpI6b21OUtjQtlcLIzNlUHgIwrmvm/QWp/1sLW0n
 keqhe40tGWxe54zV7SQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfX8YVVhm62cfH5
 Wt2stdm/sbTr3aPcVAwwuAxslugYhUU9B+8nWA0SbV3ew7Lo4XBWPyfruZovU89MSraW+fHf9Lj
 OYapIemgruTrUcFd7pfckqAIB3KI6HY=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acd3b87 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=52kzTPwna7FOPIafxoEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: QYOdTvavmATqPCouR9E4wTnEqi3am54c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120079
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

When U-Boot serves OP-TEE's RPMB requests itself (CONFIG_SUPPORT_EMMC_RPMB,
drivers/tee/optee/rpmb.c), two problems show up as soon as a TA uses RPMB
secure storage while other code is using the same eMMC. Both were found
running the OP-TEE AVB TA from the Android bootmeth on QEMU virt with
QEMU's eMMC/RPMB model, but neither is specific to QEMU.

The first patch makes the supplicant select the RPMB hardware partition
around every data request and restore the previously selected partition
afterwards. It used to switch to RPMB on first use and switch back only
when the OP-TEE session was released, so between two RPMB requests other
users of the device (libavb reading partitions, the bootmeth loading
boot images) switched the eMMC back to the user area, and the next RPMB
frames were routed to whatever partition was selected at the time,
ending in status timeouts and I/O errors.

The second patch stops optee_rpmb_available() from announcing the RPMB
device while a supplicant RPC is being serviced. When the first eMMC
initialisation is triggered by an RPMB request, OP-TEE is blocked in that
RPC holding its RPMB mutex; the announcement opens a nested session and
OP-TEE's second thread spins on the mutex forever, since U-Boot has no
notification support to put it to sleep.

Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
writes rollback indexes and the lock state while libavb verifies a
vbmeta chain, and a TA call that is the first eMMC access after reset
no longer hangs.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v2:
- track the supplicant request inside optee_suppl_cmd() instead of
  handle_rpc(), and use a local variable for the private data in
  optee_rpmb_available() (Jan Kiszka)
- explain in the commit message of patch 2 how the hang is triggered,
  which TAs reproduce it, and why Linux does not need the check
- Link to v1: https://patch.msgid.link/20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com

---
Igor Opaniuk (2):
      optee: rpmb: select the RPMB partition per request
      optee: do not announce RPMB from within a supplicant RPC

 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 72 ++++++++++++++++++++++++++++-----------
 drivers/tee/optee/supplicant.c    |  4 +++
 3 files changed, 58 insertions(+), 20 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

