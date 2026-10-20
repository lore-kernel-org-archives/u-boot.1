Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3014606A324
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xcTf1aIF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pzHXWfb7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L+bRgRcB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98077408CA;
	Tue, 20 Oct 2026 16:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id odO5gLZW6LVx; Tue, 20 Oct 2026 16:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D0214081C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514829;
	b=styVSGBlQMM3abko4+keOWq1ZxCBnZmqkG0IDZuFEn4GWzLtJZq9oDl92s+/KFST5Xkd
	 LA1rB235cYli6DkbeCgBSDIZ/xzfoqHE/9lbCuMRBpPVsZb8d2ENKfzJg7bTb8c22Kf9u
	 YafNKpW4mOJi6nLUZla579gZ/YtwHpWJslr+wYCzKqpXo4Aa24DukhHvgV04HmrWvC+r4
	 I7hTOV/uBWDFQZjs6x9YucKa50ZY6+Sw9ZcMtHJwbIuOPUK5NZPqohx2MwwRptqG9voWd
	 mQrr3YE8GVBEE9wYrRwBnp4Pi/4nrlouEEBH011V0ihZSbGD76EideBvuQ0LNB2J5lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=;
	b=NmcZUx6Vv4dfgd86TkrrSvC6uGwQjfq1uxz3eGxiKeBiaznZKIHn/uhhxMyiXRY0gu0p
	 GYsatR5n15+kl8Goh/QDBMCtYTRtRWEhTyfUfoSip5SV477TusWkyfKcuxL09Py4f1245
	 g9rv8D5pvDcfEUBNi9baJ41iCQ593oQs7Qn7KtGHZ+4dVKVedHFL2cTFKt+a+zJPCwJkb
	 wCyeO6Wjwfchp3Ihvs6ohLnfdmx2WHQLtOQGhNtFo46yDRMhgkX4xKVOp3tR0cNirCxdr
	 BveZvpY6p19m8z4vpaRQWjnTpt+9OfXdekbv3Jvz4fxu7pSb1Ev00PWEeiU9xaKJUcA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514829;
	bh=kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xcTf1aIFf7uBUMsZ369KYTBGUApvdIWbj7N7EFcd8bHDo/ikOgdSn0GDMtiDwtv9F
	 uOgLogaegFlJBk3u8QKuxaGLgO/5Ott0jEbs+T2229c6N3e8NxR7SFEaCP2aCkE1/s
	 QftK1YhrvnZtaYG3NfXLH/YBDenCFI7jX+z2UArHXwx5LEFG/gA67fouQuEMSCUX+4
	 a0zLmkIdcr6b1WV6bpFCfJGyiZdbQlf+oC5ipk6V6pm3fNXkP/NUC+jNiAML7lJEH7
	 6KX8tgXex5+QHoImLrdU/DVdx9Pfx58ua7dRnizQUxKqkc9z6Rwi9pkHObIPWQw/sZ
	 DJ5Uc2m7ByJXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D0214081C;
	Tue, 20 Oct 2026 16:47:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 149E1930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0664A400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw0SncZqLYYl for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D39840060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514827;
 b=RasYn0SD4UUThpW1yrSZz5R+9v+krjAZSW6GyEZUHcBTAPNJTdpnEfp4ZwUGA4BP8CKV
 5/hTaioAAcicTi4GvDE7oh/kue1KfP055aFUlBrqQmliYpMGgryKqN7X9Ts73ABEqBCN5
 ZVhhIg33xutsx7lkZzwrUfd5ckFHoQpT6JzTxjTDy9QZlKRQrK3I/muwiVbxZRLemc/W9
 d09cPBXpFUf0+JT334NoYnC0D2vUr+3Ox/ZtLYUDhD1QAcp2OgV8uxUv04Q3HA3GsvvJ3
 /so4Lxn3oxAfp8LEZE88cCJiOjWrOsl2auzJLrV9R/VLc8dkMAtI8fCgtQwuhkhYe7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514827;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=;
 b=OwnNsRdIHu+D7y8ycSj9pkYwiTINTWSyjbHk0ziBDyAfyl/iTkZDzflz+lR6F/LmOEC0
 3MxaVFk+HWvfvmI9pY7VLIpKKi7IT1TZMzlivSrBRoNwFK+SWZfDxEoL0/3gzv/9Qj2RQ
 0BQnqQYN833vGivw7R4ixKgQXdiuFS0Kqc05wlF9eknegP2c4J1P+Fmkl/IUkgUo94oCv
 ESt4SjuM3RToJGyCTbMod9DwVuO2XarQ8NS7ZJ3ouVP6swMxW2/nC3bs3Ln/0SHq6anE7
 gPjwoaKrYHB6t93rTqnRDed3YtqCmLBPNTK661a8WCHWFdt880c1Rv5ztRBYZDG3ysQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pzHXWfb7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L+bRgRcB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pzHXWfb7; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L+bRgRcB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D39840060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:06 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAG2a1575949
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=; b=pzHXWfb7L92SZzqv
 7PazGpOeVEdmI94xdbaq5/YXd5i/JkjbmBF+mn+8cQt7w3wvFJkVfdw5N+4Ylp+X
 63eyuwNB1Hk/BYIUkacrVE7WPukSfSaLf+580KplP+aTfM2ywIYuMzK0wzPRmxTI
 7bE+nrp+e7m34kMRy9VRhyeYRC8zDtpkfsHOpVStv/pIn1SBukwKjYqGAbaiJk4K
 F72r1VLUezT70BrZkbLqWINnEiYZuNGd7nVA9LlEJKpUrY0D40tQcxAvGo0kMYJs
 3tgKf9mFpFl48wsppiILJRe+p+MczIkZzhhFJkqp0T/OW9OVZVFZ5yJAEJTzj8LR
 IhqgWQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n3fmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso5292407eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514824; x=1793119624;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=;
 b=L+bRgRcBUd/iQhOVplvGAtN5S+t1aVhhlUBQMQ+GC2XOiQsrXSGm7NtL3TPpr1T6b2
 qr+qnkDA5bDVsf8Qa5aqGcg805Cl1Xx9jT6U+28fUFyRyHOjyYep6MKrBgJ4nfFlk6Bu
 rwFeD+ZvYchq/f2ZHI0MCf089TBtE4otzA6VaTVsMQlxJMRoKBMzradZvQas3//wl3S/
 svVOqjqzxDG827n3W8o2W9zH1WfcijGeGIMhZuka92iIV9TzGP69C57bZ38HL+2bgsXt
 CfaBEK1/idadEdX+Pr0hjz3b2YOYRz8Sa4GbqwWlRyWej8p0VIjVcoFvyrrPThUiXu4s
 80iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514824; x=1793119624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kE82N9fLTEV94fSQ4L8PueMPH3rdF9o6L8ihcF9MVao=;
 b=Q3S4wL6uMpzZpKgQrK9IO9CrcFaHPUhQeHmt5zaKTke3NaXxKdlnkeB6KLq6av/zCE
 LD4Tqo3VGvNfqafxDCOGnHtM5zIvf0mkVhc4AvRvXOe7M/WSbDh0rkcJ9C6NBNmEWigx
 ckAMbmO8qunEm0MaUYzZAv+tSNKba6hs7Pmhtmo3cUYMa19qA5JhVbVObEFPLkRke2I3
 ZaJVV/OO3LKAlSfQMS/3kk2eAKv2ad0lVR3SbOcC85eR4J7tJblGX8k0S43iWl5UTGfO
 I+QwT3M47fenf1bq57a8B0T0mnWXK338zhmAB7T69vTPnKw4P2O6D6/PFFdZ52ZOr6FF
 6XqQ==
X-Gm-Message-State: AFq9FYJhNxqk/Jynt4v7j7jsC4C8AZKjDn2+aGNPvbh+F7qU/HTkw3iK
 laXZGjIe9J4szhbe7ae4CcfeXtY7HabYFaJZtCSAoDuRZgChtj+4kWrMA8xo77OJpn+0yg2mJPQ
 cny0BQc02xCSm9r5yoMHkMRukXmISfj/HJ9NZ71i/LE3bmXvu0ZXhpZ1WM2SoPWKDMH53QaA=
X-Gm-Gg: AYBFou1Ypt8ilmn+iiXTJtQKK3DBlsLApqMVrklM97JMZIM/bS13KIGpj8FJZ9Zqu1O
 tQeCkLmTzohJGlEsE/Oyo2AvYNkvHQz/FlwezfqZJ5COvHjmbM8Umr7ohMAshU6CGO14LCEYlif
 c3uLvfIWVe1n3llTHQEllFG7y7UT/wKxmqj3RUB7I7rKCviOyUaLWdGlENG2ZxzkHYSoWRU7ay2
 Kh0uP3ntPqL957HE/9sTOshJCxXrdOsno1VY9WSQYP7LPHYpIL0akimDEeIBKEq6o/57JTA+DHc
 c22k/3mAQi1EKBI+vzbSXopVxhZur0XnMz+HRRhLH0dUJyNECdniF+2Llq8C8YOM2pHqEAzEYhZ
 6arApJ8jQcFOyq0uJ7IPpAFPk215RZ4uacPBDLKh/k2jCzmmuHKhBZhNiNFoExrKB3prlXmJBSx
 ryb/KCOPlUbaXYjQM/cx1K3HJddDM=
X-Received: by 2002:a05:693c:83c4:10b0:353:8103:ecae with SMTP id
 5a478bee46e88-361a23502dcmr18237858eec.23.1792514824020; 
 Tue, 20 Oct 2026 09:47:04 -0700 (PDT)
X-Received: by 2002:a05:693c:83c4:10b0:353:8103:ecae with SMTP id
 5a478bee46e88-361a23502dcmr18237800eec.23.1792514823240; 
 Tue, 20 Oct 2026 09:47:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:02 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:22 +0530
Subject: [PATCH v2 3/8] reboot-mode: add PSCI reboot-mode driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-3-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=5565;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=2C0CiirH77QjaVJTVnFRoDaOUHEjHGBdLCK9ltABOto=;
 b=ehYaDZppM2qGgF0ajcS0p7f3+WnRaG9Uu0vxvrel3LOo2CNcD98pnOaKFUvRkMRjnk7vY5QuG
 yTdYXOlviJ9AGHU2oqoBIUbMpb8M3L4wMmR7Z3ct3sAiJauIIsuAkyw
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Nb4N1UhmBWOYMALYBHHQJuAl0o-fJ61C
X-Proofpoint-ORIG-GUID: Nb4N1UhmBWOYMALYBHHQJuAl0o-fJ61C
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad79b09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6VbQ6MiErdNNtGIdj78A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX+CrB7sSHDMdB
 JnAcWPmS0UtxFWJ0kC1Kr9bPxKbQGTU31fHgVkDreUvCq6RmvQPTIn9Fuqbh7uG+TXNRdo8O5AS
 w0xByDCOvp68pgN9LP0dokI2KX+b5dARetLKx1r14kJeYCL3IY+PFR473kYqWzRUZzeVi1c2TNY
 9iXQpd/Ff42j0jylGMxqbsv1xfMwrv/g9Mw+cIyrovSxMnsX3sByJwfQPc1i5MBRigkyYH4F6f2
 hVoFnNiHpo7bQeru9C1WjarSScM+boNK2KS1pznZqQAQxLPevThZlIquSE3hX18VbszQPJT5cz0
 AOnuo9VTxk2Zk18mzASf0SMD0guCHoYMX+zpGDMfukQn5MFtm4TP2BSexHrun/m5vkDZ5/tJD7J
 CKYfI4FgldALis+1rUOLvETC2gxi+zIffNjhnrMj7jU+zfap2M4nPuPOSw4ZAVDsGjwJP3NV+Vw
 5+w1VibKBIwK2iUQtvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX9v3BvGkK+e1h
 wo0CV4tvrj5YMSf85KZRYCyXTUqAraL6DDMvSL1OUSin4/zlwtIQUvtxV6FEkg3ESSkq6HEhX+W
 1G6iPeMgCAY0NZ51XsmFAEcyNoI0npk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200066
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

Add a PSCI backend for the reboot-mode framework that triggers a
SYSTEM_RESET2 vendor-specific reset described by a "mode-*" property under
a "reboot-mode" subnode of the PSCI device tree node (for example
"mode-edl = <0x80000000 0x00000001>" to enter Qualcomm EDL/download mode).

All device tree parsing and name matching already live in the reboot-mode
uclass; this driver only turns a decoded set of magic cells into a
firmware call.

U-Boot's psci_system_reset2() client takes only a 32-bit cookie and ORs in
PSCI_RESET2_TYPE_VENDOR itself, so the trigger passes the last cell as the
cookie and rejects a 3-cell mode whose cookie_hi is non-zero rather than
silently truncating it.

psci_bind() binds the driver to the "reboot-mode" subnode when
CONFIG_REBOOT_MODE_PSCI is enabled, using device_bind_driver_to_node().

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v2:
- Make REBOOT_MODE_PSCI depend on ARM64, as psci_system_reset2() and
  psci_features() are only available there
- Use a u32 cookie taken directly from the last cell instead of building
  a 64-bit value
- Drop the unreachable return after psci_system_reset2()
- Match the trigger() prototype change (uint count)
---
 drivers/firmware/psci.c                | 16 +++++++++++
 drivers/reboot-mode/Kconfig            | 11 ++++++++
 drivers/reboot-mode/Makefile           |  1 +
 drivers/reboot-mode/reboot-mode-psci.c | 51 ++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2e3223e1c32..b3e6bea1336 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -188,6 +188,22 @@ static int psci_bind(struct udevice *dev)
 			pr_debug("PSCI System Reset was not bound.\n");
 	}
 
+	/*
+	 * Bind the reboot-mode driver to the "reboot-mode" subnode. SYSTEM_RESET2
+	 * support is checked when a mode is triggered, and a bind failure is not
+	 * fatal for PSCI, so only warn.
+	 */
+	if (CONFIG_IS_ENABLED(REBOOT_MODE_PSCI)) {
+		ofnode rm_node = ofnode_find_subnode(dev_ofnode(dev),
+						     "reboot-mode");
+
+		if (ofnode_valid(rm_node) &&
+		    device_bind_driver_to_node(dev, "reboot-mode-psci",
+					       "reboot-mode-psci", rm_node,
+					       NULL))
+			pr_warn("PSCI reboot-mode was not bound.\n");
+	}
+
 	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
 	if (IS_ENABLED(CONFIG_ARM_SMCCC_FEATURES) && device_is_compatible(dev, "arm,psci-1.0"))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 3fdb4218a8b..66d875a03e5 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -39,4 +39,15 @@ config REBOOT_MODE_NVMEM
 	  Use any kind of non-volatile memory (EEPROM, RTC, etc) to control the
 	  reboot mode.
 
+config REBOOT_MODE_PSCI
+	bool "Use PSCI SYSTEM_RESET2 vendor resets as reboot modes"
+	depends on DM_REBOOT_MODE && ARM_SMCCC && ARM64
+	help
+	  Trigger PSCI SYSTEM_RESET2 vendor-specific resets (for example
+	  rebooting a Qualcomm SoC into EDL/download mode) via the reboot-mode
+	  framework. Each reset is described by a "mode-*" property under the
+	  "reboot-mode" subnode of the psci device tree node, so the magic
+	  values are not hard-coded in the driver. The modes can then be
+	  triggered from the "reset" command by name.
+
 endmenu
diff --git a/drivers/reboot-mode/Makefile b/drivers/reboot-mode/Makefile
index 48c8ab7fe71..56c7078258b 100644
--- a/drivers/reboot-mode/Makefile
+++ b/drivers/reboot-mode/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode-uclass.o
 obj-$(CONFIG_DM_REBOOT_MODE_GPIO) += reboot-mode-gpio.o
 obj-$(CONFIG_DM_REBOOT_MODE_RTC) += reboot-mode-rtc.o
 obj-$(CONFIG_REBOOT_MODE_NVMEM) += reboot-mode-nvmem.o
+obj-$(CONFIG_REBOOT_MODE_PSCI) += reboot-mode-psci.o
diff --git a/drivers/reboot-mode/reboot-mode-psci.c b/drivers/reboot-mode/reboot-mode-psci.c
new file mode 100644
index 00000000000..a22f070c081
--- /dev/null
+++ b/drivers/reboot-mode/reboot-mode-psci.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <reboot-mode/reboot-mode.h>
+#include <asm/psci.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+
+static int psci_reboot_mode_trigger(struct udevice *dev, const u32 *magic,
+				    uint count)
+{
+	u32 reset_type = magic[0];
+	u32 cookie = 0;
+
+	if (count < 1 || count > REBOOT_MODE_MAX_MAGIC)
+		return -EINVAL;
+
+	/* psci_system_reset2() takes a 32-bit cookie; reject cookie_hi != 0 */
+	if (count == REBOOT_MODE_MAX_MAGIC && magic[1]) {
+		dev_err(dev, "64-bit reset cookie is not supported\n");
+		return -EINVAL;
+	}
+
+	/* The cookie is the last cell */
+	if (count >= 2)
+		cookie = magic[count - 1];
+
+	if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) !=
+	    ARM_PSCI_RET_SUCCESS) {
+		dev_err(dev, "SYSTEM_RESET2 is not supported by firmware\n");
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Does not return */
+	psci_system_reset2(reset_type, cookie);
+}
+
+static const struct reboot_mode_ops psci_reboot_mode_ops = {
+	.trigger = psci_reboot_mode_trigger,
+};
+
+U_BOOT_DRIVER(psci_reboot_mode) = {
+	.name = "reboot-mode-psci",
+	.id = UCLASS_REBOOT_MODE,
+	.ops = &psci_reboot_mode_ops,
+};

-- 
2.34.1

