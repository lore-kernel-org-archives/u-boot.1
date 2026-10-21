Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F3606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gw7mE0NG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TlNU651H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GVegyool
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30C0460809;
	Wed, 21 Oct 2026 12:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsSe9xptdH7J; Wed, 21 Oct 2026 12:50:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E49260A94
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587047;
	b=d3nqYyQY75n9clHq4HpS2DXy6XFJBfZWt5mufBIhSwID2InVFjfXLF8dawUAvVt+3/I0
	 6EyV8iiyeRbhM5413eMXclZSJFpB7FO2OWQNdrw8IALQAI9y2tqqNioG6Dz00DioL3L8m
	 xWtpnkw5xUojnoOFqtMOsXkmYtj72Qrtix6OTu3jHFdRQAGmVoYAapNXayhwgL2FvqhkH
	 uqETF1SYjVCzr/Nrb0fHpQ50T5V6sShBFHwX0MX9GFnaNKvsZPM7fVacwvrE51QOvzz0n
	 cSkcYmU6/OHDfsLq8Oh28wmpb1RedJlJ9IHWTl/RObeEwBYmeEoioSw0rOm4p1+SYaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MNIw/FiwN4vQbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=;
	b=L3esBSpAgCc39fHXa802VzrPMATfOAMARgd+j2Et9bv64YI/6qMRvRdfEgM4gM7wlxNj
	 Sk/en9rYGZfNEd6K5CMVX5StvUOubYnPER95IQTTBgLQ5YXP3pNOwDxoXHgl1Glgbbyzc
	 qfNDBfg+W3D72QlU1yiN7zH0qXSGpjcOsSpibZq2YqY0N3NHZognckspRhP+9QsJ7SpKe
	 /15md/Lv83In+RN7Ak0YIB9aXF03WP1o60M9P1SvRZsiCdQFQ6OwfeQM+hbKQtti5/r+u
	 4hVk8XFnaZ/nNkEKFpGHyA/a1/wHoUAuO1Lt8BRXsss5T+W3kP5gj5f7oP3+weB8WWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587047;
	bh=MNIw/FiwN4vQbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gw7mE0NGgj3eUs67oTFu4+fCF6cd3JlZ0udQQQM4AKDgvdZSkoBX1GMD/vuZOGnQ6
	 LzljtFO9iObvYZPnOi4Hthktpdxeb+zwSq4yrRfwrHurpNW88G+FNc6GOvixa9Do5f
	 BPcJNtEIf4ByUMqzyd/SBFkz+Dl548+CfOVXftyjhHMDapsBXtTPHqDtcgnh5+enCR
	 Cw2OQNH311QGL7ZvYKtTDF+78eG0pfT0UZxm7AsSz4MXfooIg5eYCHiHIsVvDHLsel
	 vy6VJeVkuNE2hYGVQzl3bNF5UgD8rC8kdkDJiwrvP+yMHB1jmvePcp+JoxkwZedV/f
	 d8LG2HTh2o5Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E49260A94;
	Wed, 21 Oct 2026 12:50:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B16B123A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A30BE40399
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63E9YXHY1jwY for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D78D8403A6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587046;
 b=V5IQk/nXgmWzV2SkZ0ik0cdebdqtre0KCSSwLohtzUfMphfpYm3WIF7rJLLQrhvrWgIV
 2A3xOS7CVfT76oJiBgsu87GC8GMb4aPyasxu7AYsmD4S7snllVfvHT38HnNxUoftlTypY
 1vzgEdm8cR+Pba+Ou25TEYhmvvfgArrVjL2bIO2unIaJZJTEqmTRHlvutmI9ShmOu+9jM
 yWvpcDVfDlROB/JIjOeDKTpxrpT3Nbu1Cs9A++2oF83fAzifzAwwvA0ZCHiMpPf5m57B2
 rNW9qRFLeEvmR4i7po1BWnJBurXOaUisSnu73VRaACnamFbzPThdfWUrMWJBuC/bvsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587046;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MNIw/FiwN4vQbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=;
 b=O2K1XqBpgBtH02X/bp27Yti157wdGwsFaG5CD7vZhMXet3olVsCjr+bPLrQHM51wpMBc
 P4T0wnckfuBFfsj3DqM+tlfAWP7XMIqw9fnXiXf5+3vpMdU+SSQa0AGtpSNyNsUugCTmZ
 lixl5gHRwCJ+OkDH/BQRmkjJCbHZkKbSPdJp1JBLvh+DWYdTzk4R9LN1xbr1VVfaBAz7M
 l/Bn9di+oN/9O1pUkTAqcbgAr6O9JWAM8HjGQcrz+8msdjMvOmdCGsrLoi/Y+TUtx+4Wq
 aCQqHY9XKkIlsGNhdKhHeFZiYuu0GaSPHY/ihTpkiYs0IEYHvYLny11ctCH3A1EYuqw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TlNU651H; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVegyool; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TlNU651H; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVegyool
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D78D8403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg7kK3658160
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MNIw/FiwN4v
 QbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=; b=TlNU651HENocWZOvy0TcnLOLW8o
 uAuE/o1stQ54i/baVjCxvWfVXU/wU0RysXVKb73a0tKIgXV7mYQtHHp/6b97DUND
 0kIdt05WbL09C+w/2XPFyU6GgBkw5p56QUeLzjgry0rcIyYqtt1IiIxCiZGpZvdn
 V5X0CWk+/oYNOVEWf2vDu0jn5Pmk4y90kdkBL5GPn/BcrPKre3Ng0sMAjImOjCwU
 kI1VhV6bJ7gX2hQ0WnLNbvKOuyCO2PrL96uFRpzti1dNgK+tHyCeeJIlqoAY1exm
 wHz7HX9N4jvGFsq9XxhadXCcB+tfMjRaHviOpXoV96Cj5vwn1Io7cFBcEQg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9brjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so1653973eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587043; x=1793191843;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MNIw/FiwN4vQbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=;
 b=GVegyool3wbtfoOkhLBGJ+hQ9TWwCSv8VsEwqWz8ptTzNoLbqxRgusit8GZIi42GCg
 pg2D6gx41Rf+2YRRMzd0N1/4lruAJwQMaP6KuWK6Wq1cESCwId9uRps3O1iqJT9OKX99
 ZAohwjd+uBePvn9SJ/cBBjcXlArfSeG4pambY6ByXwYoL/zNRytiSRt84zIDojqvGZDO
 kQNyMUS4GBL8f7in9uRQKYux2eb8HHW/vJyzwyeh2mwx0XDyJiGFIPZxiCsnxJCuMDtz
 m4/JggxF8AbqEZZvCXF64w1QbNLkyB5bFekHumGFDHKRAIBTM0ykv6+A8xljZXhzcz5a
 s4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587043; x=1793191843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MNIw/FiwN4vQbhWldeyK9+VtZeVdpj0j5t2jHpIMrsg=;
 b=MvZsWSrbFsOzFSvXjupsKG4jeRy48u/hlboKU1B3V2eUGz4zg0IIYTFSvM9l2X8Wor
 xVbTCCa6+7xCbiBWPSYCu7MZF+rDNwH4Feb7T4FFRutnuTP0C/PwviivOxz4Hpgfyant
 gnT67QtdwvhXBt91ltbnOrFgM/AxpbT6RYgUDO73Ie2V6IUK9W38UDPsfr+fujJNbuyu
 FbXZ8FAkxzFCT0p1A+pAin/CvjaQXBucS/Pair78TSK4EdYEsYKp3lMCROho7zEwMG24
 Z8IF40g6LlyH3gHi48VZEGN3OCjHEkgVvko/VHJf33LpsK7gegBxaezF1By5AnNU17rf
 VfAA==
X-Gm-Message-State: AFq9FYJvmXaHqsWvsJ95xEUxjIv8K4VG4XwHA/TInLVAt6Tu+F22Lpha
 6EP74NKzS1YKyDmZfEN8fKL+SjSPCx5OzahXpyQK+FZ8dLxkBX+EuKdpfXvkmDcPepKCtGsIrrm
 2MuFpkDVQMP942qX5wrjELB0p5oKfi7ZbJZTsSi0P9ARgWzBcTnMeSaftZeQDCe5HCEfQS0lmV+
 jaQ9s=
X-Gm-Gg: AYBFou15z2RbcaWJP41qwV5u42bsD+mM+kcDujWHqjtceIkIsPdUnSA2LkJw600l+gM
 6YydI5qBpQJ3dU9ztqU/lyT0NR/hLJVZg6T4w1Wg6ZQC9/B4ogbgsXNwQW8Ji0xalbLHapxuWjh
 JsoE2zBeELfbd30EQ2VMg9bTVuCuTvhe6xpvyr7VGzISOqRaafwzpOKBiDlEjmyLdQFYALoJr5c
 ospvklWvMhSERQ8hK96B7Cjoc5neiSybQKM+OlBLIZspY3tor1COo1CBV/DSjhG1r4qnc5ObMnq
 EyTJMqjBKlFrssQ8zw0S5u8fhjc0mwErXvP5abAg9ZKfeTBR8o2qrU/CwlmXqRg/HiNLL3thlep
 ngHWr3BjzQxacuzAIKQWwrBoXnOOoalDQUr9oyts58kHTG6w0T1piqyHNB9IEtgC3aMxCJbrUXP
 +BrOhhtRPssUC81et2NFIBCyPucs11F5jjzxc=
X-Received: by 2002:a05:701b:2718:b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-190a7381585mr2735663c88.41.1792587042889; 
 Wed, 21 Oct 2026 05:50:42 -0700 (PDT)
X-Received: by 2002:a05:701b:2718:b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-190a7381585mr2735619c88.41.1792587042256; 
 Wed, 21 Oct 2026 05:50:42 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:41 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 7/7] configs: ipq5424: Enable GENI I2C support
Date: Wed, 21 Oct 2026 18:20:03 +0530
Message-Id: <20261021125003.2948090-8-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX1AzFcUX1r8pR
 WKBam1BnDxg3ux9AJYT3AZLDWg1is7GLnCtKUGi8Kt93CiZVm7CIDTHtm9a75uQnT9z5uQ/W45M
 fu5GFYSO078huWtFcbhj4A/IkZyD6OI=
X-Proofpoint-GUID: Yl0H82wT2FUErQVAQ-pYNN0FXR1Kp_ef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXwW1+pTVz/sz3
 hJBM0rY+mLj1ssCzByzzvzPUK7TAQTHShNlKyjJMVG9/GIcmOyR2YL01LDq8wGkoeNKE/CQCCgX
 ON9WC4nNPNi873RdruTPBNYwL21Gw2ecy5zx9jfu7hN7OUx4pskR0ty2LyV7R4f3DpkYQ0tG/bO
 IxwOmoBGObtSg93jAYUOnb+nv4QAnxE9ZFxRqdgRPsjAG3Hx11GN2xU/W8YWZ4cpbti6g5z4eWN
 seN86ChG1e1iuN2O04Zgq7u58m+4/IPviFFwqw1lPJhuRYXr5VYZE4d47UPEcrPHHr15WsSxRAe
 jj+iLfcUOj/O78AD09BUiTNkGn+26+uSNog8a/RTn0yXO1J+SCsSrex4aPi/cZXPl2IXuYyzevr
 CGX9T8yzHOgVWTgvWEggIr/l8aKCxPqmSHw73ML1mDvcNho0yWmtLfLuuhT4wCW+61cgGkqxyB3
 MrRQeMHavFuU5lRYW7w==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad8b524 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=5tUTrIVEkRNh9hVj2ksA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Yl0H82wT2FUErQVAQ-pYNN0FXR1Kp_ef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
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

Enable I2C, driver-model I2C, the U-Boot I2C command, and the GENI
I2C driver for IPQ5424.

Enable GENI minicore support so the GENI serial engines can load their
minicore configurations at runtime.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 configs/qcom_ipq5424_mmc_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 6579d7e55b0..113708bdb09 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -28,10 +28,14 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
 CONFIG_MSM_GPIO=y
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_DM_I2C=y
+CONFIG_CMD_I2C=y
+CONFIG_SYS_I2C_GENI=y
 # CONFIG_INPUT is not set
 CONFIG_MISC=y
 CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
-- 
2.34.1

