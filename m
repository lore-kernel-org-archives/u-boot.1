Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAD4CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94E814069D;
	Mon,  5 Oct 2026 07:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0SeVPZ4XIuV; Mon,  5 Oct 2026 07:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3816E40665
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183930;
	b=mQzZ6iGYEYXK1/09gepXvAxeb0CBsS6WRlmU1MjoTMtXDJ+U9bNV41+nepYpN+M0tW/Z
	 nKGx4liq2ncoVDAr7tkdeX8NpTo+txFo886OQSFM1A307Hl3SlY9YKMe23/jycjxJKwEw
	 JtrrGaMJV0uFGepmqHq/xQkHXctLwfMkkDPH03bbOz2ByT6tpy8TK21jrFL/YbDhWbfau
	 85GAQIHa1sCF0MWeVltIj8/GLBGkYNtJyTfjTZsdam2bduRDRmZshz39LXo3o4q/lconJ
	 iDmF7iJkTNHp7lBmDG3RAELrdfNFIjtMyk9LOd3FpVGNRDUJO5KQgRLovnFFZ07Go7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	b=Gb3Wqnmqkbf2nOqzKSv+JpCH5X24NUzxQ7B3gIShD7lyrftJ8UQjw2idukH9ddGLXdEd
	 FDyCtHN3HYM8jHmgMc0gHzkDCEOppq+wdA8EdwG2ElZjnxy015YsWM7XtwBPMAim3AIWP
	 h7PxM87V7vRhdWxfWCIv6CBLEMJKPRDLDOuzPdsv/SnOFttFe3u1ePXD/95TIoNxTWd+1
	 hbrDbCQAUJlF5AYTRtH9Wuk1bGGwqrXSdEx4ruDU7hJgdhCdUOBAMWZXe9qI6J1i9axwV
	 031HWTxZh2wp8eGt6tE0skxQCijowywJGDW7xoRvkHaLhyaeBj7C9v/s9zy1WSjga6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183930;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLK8WX4MSGaaGw/VYOPFKAwm2+AWJY7CxS0qOV0qdIenkhPEMFHvaEWom2aRJ3iDJ
	 Sof+dLRmy4lpXrL3KuwwSUX3pXR7+fZwVlU6xCkwNBVRr6sFCK+JdDmk7pPNhMxert
	 bTLGgJZpcbdxg5FgUVvSTFhZIckj+YTgSnc87FXx34IBcKLJ6qKn4cPRr2gwEZmkt7
	 h0gDsBW0ngzRGNx0x7KyGkWkxXMetqJ9ozAw4m/5WH76CkDzrDaUFZSi51do0wCEIN
	 p0LKMVApGCeD2Wn/phOoGlvwTEcztT5PeQvBSlpySGfT/BUNQ+gdFkxQCf7J85Gz/a
	 1cvf18OuauDtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3816E40665;
	Mon,  5 Oct 2026 07:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50B3932F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35800808A2
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QN_Q2KqAK2aC for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6460680839
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183819;
 b=UoIc8MExeu5t6R34Tqu5xGidvUaCWehWMpnKEijLvGN/KyPAiq1k+R2dgCQ0UwZpQR7F
 dIxk2tf2FJ01u2HVSS1pFAUdkUtrL7TzKYQwK+5D9zaRf+7QVGOzkHbLFa9Ku8SLbxZyE
 E0KfeGx9PuMJF31ctWKM098CgZfsNTThcQH4l16qOgFUUuGicOSvmh+aBAeJXywgTqQLl
 8yuj9Ln5Oa6whgtXF9TeGk1eppgACOdGiBQBsZcIEQBrxo0FUH7cm6hqGOZdkpTomjJ2X
 K21EGuUAmw0o/Rw8TWbK8aZp9CxKd/Inn00+baTr+/DbBmJ06Pw8qoJMTQ4h+nYljVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183819;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=n5A8yAEJztlqUDgLol6uvUUMQiNQMo7A4mFy9XHfAT/FArIlXv/4QRpK6gRa+DR2GqSs
 FbRcxeH/ymr6TNiXMUIkRL7EznslgDium99fiGuxcE7u7l1CoOdwF+YF/o3zCKKDeRAp6
 jCkM4XqqQPb9SN/l2iwAw2auRvgs0FGxm9YcS+cLqyxb7Vkr7PNXcSwBIkEiFXZIchnEl
 aQmrpXF12DW/FrAGEFKz0DcJEz+OwCPa97j7XvoUAvsfsTDXB2ipG3qnJ0y7gCGaKqaev
 fHj5NyUbc0gIvSWUCaoKCtmHanE54udaV0zu88yTQWnLJjiQGjy1IWhlSDa+q7yHHxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MueiXZMu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h2GVXJ3C; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MueiXZMu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h2GVXJ3C
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6460680839
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103lO1464827
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=; b=MueiXZMu6gHA1XIz
 cOIB4I+uC/VGg2VscPW+7fj0V66hXwg/CUNroWd/L5VPHuOkoDslaoEa78cSAcvF
 qdXz/4V04cV1Sp/MN2YtUSbOnZIYsWKqBnqzw1sBoN213LLE66xsAOjW4FjZGeA9
 nOZ/+iPxUNWtjyynLMx0ptrOlClgiNuW+6gNv6oGQukT12KdyLfkyhh7wCHtkccQ
 mm6FwT4/UavtVv16vWLIKQX41d0idfyvJqYbMmK72SJ3jjSY71bocEcLUFcrQYoX
 6hBop4/4KJKVdneTfGdtQAUdMeIN2BFTKpzCryaB5/dZoCkHAC8fKSPLz8jW01x/
 lQDXkQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssmsfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so2890189eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183818; x=1791788618;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=h2GVXJ3CMRzZvtQCaeq2kl8cBo910cw15lsDhmoeKaOsFY5f7OYvUc2eJVVBHbZ8Kh
 wrp+1hcZoTntIna7xTV6a1qEFPyEpoPdMN8cHUtVOdqwqw193kFkaDDLNuUqcF9trn7e
 lBJNpq2DsLz4zpCleVzFfsggi9FVtNN6k8LV6HyBq6uX3LgLH5oW53k52GqHQ7N7rdun
 IfTFQ1CWtvHDXxCzqnGR5YA/YUQRDc2HSb98eZT2WOqa14DFAS4TGSBF62d53WbduBnp
 +YfNr2fW8bKWUZZr7ycpeMj6QljJRfZJduqQVXgSfGU6UJ/by5SpKoBb9KqnAygMicNb
 /TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183818; x=1791788618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=KcCdRjuN/6fFwX5sCSCGdKzU67myBN6NpshgosbE/j8yb2eL/cA2tftwrR7uuGTkQW
 kskS/c4kgWpTrKbj8FvWzd5IYRnzlrEl8fGdrbAPXd76JgvwXY+UG3+diSuePfyFNp5F
 SzccRPtoZud96tmXoePybHdQI8mZUyiH97bAh7bUwRFnfyXHB2vkm5HNfZW1+nkYmMWd
 tHUizxU2FofnlT86RqUL/xSuyRJU5EGDyCNeK3w/PMjfCiYYz8n5bgdovaZH1p1vPapZ
 G/mnmRGIArnzVYWBB7CNBe+mwpf9//S2Qct0Rt52QHeLgFwIBTScs9HmPCHZLN/8JOfB
 NVVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQfby1RX8n1zgQzwn8iZ915UNnS5aKlmeP/LZkLWVQxj2FLGWTjB+fpjaRg4FBxxlsVQxQ288=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIl+KD3cjTRD6vTwtj8eOlGLYTyLgRrj/kMKp7pc++GL0qZgUwE
 pGOZZPUYmEf5yxtGEkYgCoT7t1uNhgKLzJ6spmF8HpsdUyMw/eM8m0gfaE7o/tUhQfG8UMssPbo
 Y9NOGWXKqaogORLYKLcSZIV/k9c4sx+A3bCdMH9TVf3v/lIQnHv8JU2Kc75YMqphudRRvGKo=
X-Gm-Gg: AYBFou3Ov5xAuxWcc8lU9LsLk2c1h/ruiosDh0s8Z6jeayYvtaBKUgNUzyXoPLOvMvf
 n0PzZ6yOmE0Tz6V2g9eF6Jn8rA0hk9j7BDKpn8sz+juGayX0BvPk9GtzPsE4ETCpmmFxfkR6GXV
 BI4bMzZZPB98ovdVNPbdaRd1x3QLq4sf94p0iyMlgtAZ8wlE0jop1syXxtAjWGEGBHUTWy84tpw
 CNYqPw1KoGyysu4dWYGAp5oMuq9EEVYjcKlvl5s/R48NyYzhtMD4ZolAMP8sLqrZCIQtCR+kIkJ
 QHFiYrjD/9SSRkYVeBii4numxYpw0VoNVGOYyTsos4iUDv/+HMEJnDJ6zYunnUpGsxoqnISU6cM
 iw/Ud4sRn4gmkqIp/iF8B1oWqQSUujYVMVGddRymP/cFg5DFKe/XniA7157EUKGlDlJvlkNyntd
 24kbj4bldIXtqU1QPm4CSYd+3UHsAJ
X-Received: by 2002:a05:693c:88dc:10b0:33b:e264:362a with SMTP id
 5a478bee46e88-351113c0c4emr8781313eec.13.1791183817453; 
 Mon, 05 Oct 2026 00:03:37 -0700 (PDT)
X-Received: by 2002:a05:693c:88dc:10b0:33b:e264:362a with SMTP id
 5a478bee46e88-351113c0c4emr8781275eec.13.1791183816876; 
 Mon, 05 Oct 2026 00:03:36 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:36 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:23 +0530
Subject: [PATCH RESEND v10 07/15] mach-snapdragon: spl: Load next stage FIT
 image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-7-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXxSipNfwxef+l
 cvmeylBobxemfpvlK0O5GqYLOEXd9+3OZ+rmfgB00pQeFAIegR/MuYzZJuvHSrM3wJoduvKhaKd
 GtmcW9ysqezpLFpWGGV1emqVDj0G+M8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX2aDvGdk3A2qt
 I4uqW6vlyrGQ5kWUknVmh1EbwZ5JN2qW4f84dk+AFHZWkg8kzrzvHL4W+BWjLZapOcrngvsaZgP
 vkr3Ko9bOyxWED9754zFV+e592HhBNlnUD8wTH9nY0kyD8m7Bd1ZHL5xPgwR115uzIK47Jqc8tG
 R45Z6LFotQgpazwDCejI4mPskFfpdi+TM6ceL2OjkzbpFHBoPSuQP4Pq2JoDirZ+bE5kvlg3g6+
 JWh3eQmRQ6vylgeJ6fuD0vO9KsS5CTfj3IUW6x3LoklAxqpfgLCgWPDIV1xIRLu00A19ezNnkhy
 xZEZakWsDegJo9odkh2xPphRsZuMoC08pxCXd0JWFPF/M9wKTvVHMtYZV8EoSHoGBls4HxnQCAV
 dEF/yuSBXbm0cRFQ6n+uEAzQnqcfbpqn+rtA0ah5znQU5wTvItst5czMvprUaWxPyD1r3rQiQd3
 5zIeYhtxboHVixQdd6w==
X-Proofpoint-GUID: S3EvHDes947bxdSMlJgJo3DlrTtITPzj
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac34bca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=6bbauyjUkyUOPZ0J5qkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: S3EvHDes947bxdSMlJgJo3DlrTtITPzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Identify the boot media loader driver and load the FIT image that has the
binaries to initialize the DDR, U-Boot proper etc.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 155 ++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2445ae8b17d..2655803b31e 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -5,12 +5,15 @@
  * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
  */
 
+#include <asm/sections.h>
 #include <hang.h>
+#include <init.h>
+#include <mach/qclib.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
-int board_fdt_blob_setup(void **fdtp)
+int __weak board_fdt_blob_setup(void **fdtp)
 {
 	return -EEXIST;
 }
@@ -86,7 +89,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
@@ -120,3 +123,151 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
 	return 0;
 }
 #endif /* CONFIG_IS_ENABLED(MMC) */
+
+void qcom_spl_malloc_init_f(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return;
+	/*
+	 * Set up by crt0.S
+	 */
+	assert(gd->malloc_base);
+	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
+	gd->malloc_ptr = 0;
+
+	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+}
+
+/**
+ * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
+ * @offset:	Offset (unused, typically 0 for SPL).
+ * @size:	Size of the buffer to allocate.
+ *
+ * Return: Pointer to the allocated buffer, or NULL on failure.
+ */
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+#ifdef CONFIG_SPL_LOAD_FIT_ADDRESS
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
+ * @fit_size:	Size of the FIT image.
+ * @sectors:	Number of sectors.
+ * @bl_len:	Block length.
+ *
+ * Return: Address of the FIT image buffer.
+ */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return spl_get_load_buffer(0, sectors * bl_len);
+}
+
+/**
+ * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
+ * @boot_device: Type of boot device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_loader_pre_ddr(u8 boot_device)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info spl_image = { 0 };
+	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
+	int ret = -ENODEV, n_ents;
+
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+
+	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
+		if (boot_device != loader->boot_device)
+			continue;
+
+		ret = loader->load_image(&spl_image, &boot_dev);
+		if (!ret)
+			break;
+
+		printf("%s: Error: %d\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * board_fit_config_name_match() - Select the FIT config for the current
+ *				   boot stage.
+ * @name:	Candidate FIT config name.
+ *
+ * Generic default: match "pre-ddr" before DRAM is up, "post-ddr" after.
+ * A SoC with additional/different FIT configs should provide a strong
+ * override.
+ *
+ * Return: 0 on match, -EINVAL otherwise.
+ */
+int __weak board_fit_config_name_match(const char *name)
+{
+	if (!(gd->flags & GD_FLG_SPL_INIT)) {
+		if (!strcmp(name, "pre-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	} else {
+		if (!strcmp(name, "post-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * board_init_f() - Generic SPL entry point.
+ * @dummy:	Unused.
+ *
+ * Generic default: clear BSS, set up malloc, run early init, load the
+ * pre-DDR image and invoke QCLIB when booting from PBL, then hand off to
+ * board_init_r(). A SoC with additional bring-up steps should provide a
+ * strong override.
+ */
+void __weak board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}

-- 
2.34.1

