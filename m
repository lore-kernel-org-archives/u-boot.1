Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237D606A566
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VdUw22zU;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p25aUy4Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJR6D9Qj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D2F460EA9;
	Wed, 21 Oct 2026 16:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bloAmUZLahis; Wed, 21 Oct 2026 16:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5047F60B3A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599553;
	b=LLZwneLPWuyQ4a2Wq7RUJEKvF7xwsP1WtLJKh7pbC11/YtmtGmBWwP7zhv0brVN/h1IE
	 aL0D1IWfD+hLvHPbkMBR4uBpu5orevCyEQnzW7N3vnk91wv0MZis105GNA+T4lSym3vyN
	 c+78Ejlm1JGCKzL0d4wT+HazxiboILWKGa3MT0v1OmP/XRYhTbrHDAgFuU4twNr186VWY
	 M3Re0Ef2TsY+d9Ma0oKMFOuLQdEy28LcdFOaUq5KGnvyPjzd6siil1jQORv5bYUCpiRpg
	 /vJVCFUPw2wowxJXsMDJSC99ET8h6PopdLeUYrx0u2ZoJnURuOuKpyL4yc1B0fOFI1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	b=F0XItD+pG981A+LQOT5bscvrQIHzNYDL+T55Nu6tI/zcHYuVWrt7OCHrsIBEE3UETxDy
	 w+x1FXjaK29TkmbWyAt77qTcklajRBcEDJq1bI25/UfgAYlBqfhqeP0XE11ZqyIhzngUE
	 7WbPi1Nj+3b8C6vMiZJt5l8t5oDULyCIdvpBU1s6WEk4VHZXkUzWUk6eWanK6XgL5y8t3
	 6D7hmjDSC5Z8YrT4DrA0PlIw0k9pHA8AKvYcYTkZ3Kw6kx0gCMR2wiOE6zWn9hd46EILV
	 X9klPfD2mjulqPvY/tcE3Evl+OWNlj7UHlmIaGr9iYz5Yg7Rss1lt7+wyFDq8t+IWcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599553;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdUw22zUhyltCVpwK1IcsAVsncPj0GeD85sXp06FSmaxbHxOZfZcQSeEyZ1PWf8zt
	 tbT2wiSxAB1FFImGvrHUYmqhtf4Ic2it2kYQVTqypRWc+LJ6CdbHuygBrG5oWeFxu8
	 98/14Chr2OvD6t1yZYmnEJReXHos+70iO7hc8N8z31h+W+jwjiB9hYl9bc244nrole
	 z0FdimkpXnnLpsIEuzdGeAz/e/hMTIWCJAiYJQ5AbnA0SvTx5jcJ66KcjAxvDt29WG
	 U6XhI799a1H5JGtoCNZb3EzZRnXa1RbQJTKDKt7fiJnBgv/DS3LBEgIoBMVApCpCJf
	 GLMy424pHqDYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5047F60B3A;
	Wed, 21 Oct 2026 16:19:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63C131AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49CB981237
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGaoZfazNIRv for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2923F811EF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599550;
 b=tGoY7N1Kru8pUX8PnGVzxbWegKALmweI3vH3gramjz12Rwy7QlQ8HmmFBORNjIDSD7mN
 xRndJA3OUSPtLomm4ZLjFGNXXm5s3uljlPo/W+lxeWnRfY5bPipzNHISgHsiN3XKfdIsC
 9LHV5Pn55SMLYZY0AwQBuef6OkRNAmIfyvD7Ul7WxhsPnv/baYHKwr4w7IFzBzoDKWfTA
 460Z0YZhefBbsfRQOt23Waw4aXMxQV5/+GIDZVaA0gb9Du8necI3FEt0+5h698HvSsre6
 Cw97/gZjsxE9NFZWEprfiw1xv3Gs0mWcQvpPpj38lyO1tC3m5SUpaR03BDYJHUiVlOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599550;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=jyCaKw5xmkE5afkWGmM0mozKpqfxCZAcnz0t53mdcFS0S1JjwDqy3Tq9bMVjTRXI8OyY
 qrVKt30QNF8U3YI5AccXgzmHJeTXWBfastGgK1mjmGJ8ylyWjL7C38JCctQVvWPVYpbjf
 d5geaFJyqhrhs+cImcs/zby0rg7fbdRRYlLSzkmw03ki5LICh63Kk5pW9k6UsI9SNG6NK
 UE5KcvqwAzflWSI9V00JtumBvFvu6+KZRUAV+AdOOATlX3am6mpq4VOxQR18VH6NJngrW
 7ElNquBcyWm/b4E8Z1QpdzWz/yWEGXaoNoDqJIEC2Wl+IVIZQsKCIoHrVpNXvbyFYXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=p25aUy4Y; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gJR6D9Qj; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=p25aUy4Y; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gJR6D9Qj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2923F811EF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU0Jd682119
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=; b=p25aUy4YgMutyBic
 Q6MfKuKMBTKCYcHvY0HyN80/F6sasnVdzfoW4Q3KpRXg1McnfzeIBH8SAFfARvW1
 m6yJ1locfl+24qFquMc2cfazfyD3IyImblSA3rl8VJmDfBzgw7v+kt4GNA2eEQrj
 LuKHCX8raBD07U7w+NUnJK7//S8g6dfMLpnbohh4YrnX80IFZj4cxNb+1E5VpAx6
 XqjAIXTdHKLbsqY2b9QIlxXgTA1dIHErtxLqbEcQbBUKuFor2dvFVWMvznGjpVSw
 zvVX1AhQQT1w+fUHCv+kUX/22/I/mP1BwK3fqrcUz2N4Ji8AO4RA99fApjx6Xiuk
 89zRlg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrt4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1681067eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599547; x=1793204347;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=gJR6D9Qj+pW6tgAkjlB0qm/Ylri4jKe62DWuCQ156outY6PT3E+O6uWQ91+n9n4w1q
 w6a5HmYHxllVGLIy/swh3c8E+zki6woW2dHw300w6xj52MGstWnp426fiRa35h5uAUwV
 BzPk3BsOmVNOb4dm+O2tcZEqhfg/wfa5xZrHIq9tDnfWSQPZQGadXlKceP8eCNXAEZG6
 xJFuUw5dCf4slZj8ozocJj/UfJHEUWUrMR2nSZmhnd8pWPguhhXSLEM0gwPJmVlJ237q
 Y/ArxT5X7D3LpZSUri0U8yFjSRTx3E4JWSM6jo7O8wIbu1i5uwH/Z0PjGTHi2OErFcae
 R43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599547; x=1793204347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=yO/ES6DNIyv8tKcRR2KwQDaN6S55ISN7yJPsOz5IE2M4R6+wEWyb7hZkFVa+QbwLve
 2n65/grlcjwj03J+SOtTTZ0R2eXQ2v4Jxq+nfnKiLjWasR9Lj54UMoAztOSWWggi8tSv
 GxKQjIjIuhpzVRag9lQh7xueYfy/iwJF76nVsKNfITwaF9zhUDV3K2+954S2qGMbG3ff
 zRs717sC+a65iBAA6w2Rnki4nJdAGyaxiy4EeU8j2r2A0UwQyg3qxAd2M/lCM0oChHGe
 vt7gqxCw9KJ5Rf7G6R/KeMt1XQIzDvoUrM15+KzUPFrpRjEJ1muvIVz/2hHgIcJ03jMe
 XNKA==
X-Gm-Message-State: AFq9FYIVV8JYauDU/+rvTxF5gkkwIHTn103tc+OlPpi7EeyFqqXlu9yG
 +5PXQedO0AjQkndtFmf8A6WXGNFBheHq4QHZL/emz7HDaYuXn5F51H6rMR+We3OM3wfClojbxvs
 uKO2d1lR+iDI06ckc/+vWp44kRMxXVhuvRGnn4oDT9FgBC0+IjTFL5eZQRIDgugNWOji/I3M=
X-Gm-Gg: AYBFou0oWwkFnurPorTl6LbkHW+FhpWF966DisXxnwowHlbIIy+ISHWauLDBQ9itI31
 QXY6igJw4WBHkjKsAvAE77/T/zW6jHoORwuXFWQE6N3bqSkeQjtKaOwQICEWCuc2cebl88TXuNH
 JhHqKhG3M2m4eEyfsu7QsdUTiLs+JZwKYgddpi7Hv4ZoZXZxBFnknwL1+divUTmpCQXn6ch/eAy
 HOI47WkT2Z7WwRwBaGBmh907iE03UrAGgo+cOMaIIemv5QYnqZNRhv/zuwg0sdmRHYz/nw3BjRc
 2m3EU2LkQuJm3mRdC6IPxQAALuDZadTzb8xQaSSPvcNF0VoJYFskriQb1x8lAQOyQ0ADnWOrIbY
 vufaOEJEcbqSRq3JwQo0apj6SNFLJgAY/OFgBtDwfIrP3RL6EeCIOyazB517ulqNdroAY4VNPTB
 ydNfCEtIhMbHxSt8TyUKa4gN4ZsCI=
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr3537766eec.37.1792599546646; 
 Wed, 21 Oct 2026 09:19:06 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr3537658eec.37.1792599544903; 
 Wed, 21 Oct 2026 09:19:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:19:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:25 +0530
Subject: [PATCH v9 6/8] arch: arm: dts: remove Lemans EVK override DTS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-6-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=1412;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RlBhEl/QgjRmR/ppAjn1yX+sHTrgAqgvlHLzGSElyOM=;
 b=eCPiWu9I4w9elnbCs2KEMIoT0G+STqFoQNAJd3Wz1/1Lz+rlEQJYlyP0nKS51UbtVZImedLE6
 l/RLTuOQJn2Bg9e10TWqLbn4fBJLaI7zISK3wyZ5FSJnd24XmAPEHPl
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: Vl5V-C1TEexVbWwGoxj-EeYdIHuC2TFB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXwKsOuXSNbN2b
 Pg5RoA8tzAFT57ndUoAa85z5vPXVYwFZJQhiIec6R4wn0wI8GAweWI1GvzVmDPrucBSl2St5hJM
 TmVjJ/vbmGZuWw1vsj520pNx+gbiknw=
X-Proofpoint-GUID: Vl5V-C1TEexVbWwGoxj-EeYdIHuC2TFB
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e5fc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4SgFHXcfvDxL
 vbVgqaDJD+WVKC/WrOoXy+A/ycFnc90PkxfYczRgnK/pntMkd151dVS/xinv3kTvMT9O1fSRSwc
 TJP8APOR8/MCmUr998PzGksj8cu/5s7hINmXkmtePXPAu3A6s8x+DyaZWjmJ3mFDF9T1Js0mcTC
 ae40hArYd79X5ilxouRmxxdlgzyvKwQ0SUmr9aQEbwnd+ckgT979B/S2FDeLjWqiHmozwB9fBR3
 j8SV8NwPltsYNr38l29Mhxx7ftrA9t0z8wbGbAj2saDai8/YRk3dtpCa34JDdh4btVlrHRkwYjH
 x9cRwrwpYQCRI0DIDebzb6ZDytuxxIOQiIccEHnVchx8ivwfyHVY8eU/ZBZ2B1OP2ghyGervFIG
 VTOTPTGCV2OphyCJNrB6CLnh4C10HFPAujjouDu8ykV6/sR+fG1pTvRCPF1RjYHRTzwCKZrq17O
 cgqhOAdra8HmImlIoNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

