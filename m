Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CF606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kW1H+qUM;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iPiC+o/c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rh3/flv4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81FB7605E9;
	Tue,  3 Nov 2026 09:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AJt51uv17kZ; Tue,  3 Nov 2026 09:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8CE560670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698513;
	b=ClV3b/fNPdrtNsIrYbUr/TLmAOt2681xTxCtDNI6W9rZ8W+DJTIfMZ71vZvUIZjeP9C4
	 Ir+dxp+DAp1tScRDWhZoVtRAX8ehv35JKL1RKQKYMryyTVhp3qc/8WC7MEX2hCsa/laAG
	 YJiFORqtx7x5qfFfysa9P87j/fKmLogoeYL5hGVkifRQLz15vb/laQlT9Sk4//6uCZdOy
	 luwbUUjSwOq+wAHMCkcrtNprZ0iia9Gm4gM6bZgjO/eu5fPrbIBECMXDTTLwgvW5omOaI
	 u+GYBN+IeAbzI/z7lpveV3EK9lZIII52UP3ShoOMHPlLCUfRXTw149AUld/+Lm1OTrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793698513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0oAGlHVvmGYbIykPRn43k3zHQxLEQtqy9RkQQkS1rGY=;
	b=SezzvCEWQMcfLdsEbukXJtErnudGoBjFYdCdbJlLiCmM6mxdc+HVogPej47xWamnhRjk
	 Jpn+C16Nxe6GgEYNhO5iHnp7SuDf+bX2HCEbjUsqakPKKDCIP6zvS5jpX3tDPK6xqY7hh
	 40Y6nA68e4p7ghowAaKivrXwRcTSqaleBi7ODOQRsERqsj1OtPNrJz3Lbi7ay3IRk+G0I
	 8vnV/GFFRkIAJYd/CaNtqVbwicBOlrnyMes/y9twviq9WbTgjUFLLyGEk6DAN1VIhnKHT
	 Jd2EWp4zZAgxj14VNtJVUJJmKykR4jFs8CqmbA0FbVTEAey5sOt9SB9D/AO4qONLi/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793698513;
	bh=0oAGlHVvmGYbIykPRn43k3zHQxLEQtqy9RkQQkS1rGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kW1H+qUMpjgOf9gQuwahKYRzvSPNYZGIt3dSR3gBO9409M+PSz6zEDQ4GlHOi185X
	 NWiIQtnY64tPjIPKSVTz0m8JfA8nEbcbh91bZJkQdPdbkJ0c778U9Ho7btNXe26k8Y
	 E5ZvaYQxFK9YdiD8Ta0ZYnjWpKmyilyyM8YM3jQc0Dl1R3hbXYcNWBO/4TDHwf3OV0
	 p9jC5412k4sTq609WWSf+9nsd06/7t1qiQPi8QL2DYqUhw0JkkrcxcReG7mw2/k+VR
	 wcC43rv5lysNA9lnMBhFHWrJP9SrAkSlabfV/u5t1EtaS9XV9x2dPAJvxmotaPTZ7J
	 TsTTOx2FRG4aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8CE560670;
	Tue,  3 Nov 2026 09:35:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B02FA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 300D280D6F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Abl6_Xb9tbrD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C43F280D81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793698511;
 b=VLXVxkrb4uqrZ1ybKeuOzSb4ZJ9fzXdJnxTZ6iqxKrMAx6r9K+U5SNDl8GBan3oOwOvS
 +RXsKNujbKQszq3EX6alEfQKo++O+D3R/9WZx6rgydpqzVuJCl/ewQ7GnSCIx/fh5G7fC
 MooOhmRcpIldbwKjEhdKEjKPLEQa2OjbhybW1vUyXoxl0azbOlN5wi3jsV4ctL3PMHq4J
 qmOxKYxLvyQ9i3RZa5TFjJeI09ObjLy3na5IBU7WU3HTJWIR7MzbU3e9aXuMQDLgc+VAJ
 W62jn/120UODO25jB2eqGrSz7OMB2qQXhSOoUbpG33iYL0KTV9f1ohu5UvggwQXeqtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698511;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=0oAGlHVvmGYbIykPRn43k3zHQxLEQtqy9RkQQkS1rGY=;
 b=nN/R28MUJ8ajuEOsFGfoBI7Ngz6jmJN9G+Q5PhmcUK0e94dk6Cti/p168siIXlLy5mOA
 movbpF1qHMuQWejihIrKdu3k6z89iGOQ0uVGpJoeja5hHuW6GsIJi3U+cWwxpu9jxmufG
 d6+5cNQC6etnfa9/A+z9hjj5dB8cpc7iNc3+MnlbhMt16tjdu0DBfmWWMY2p0deBelO2/
 zjIUi+hzvVknewRgeW70o+FXhiPvwTSI413/QCClJnG6x3YvSDMTAQOEMSI6ydkY2TeDq
 SIcL/I/iWAysEHn+u2Xm0lgX1SYfd1d8JC+mNt0V7eoCu/jaFwDRfKjc3sKLu+oavsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="iPiC+o/c"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Rh3/flv4"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iPiC+o/c; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rh3/flv4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C43F280D81
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:35:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A383sf31434270
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 09:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0oAGlHVvmGYbIykPRn43k3zH
 QxLEQtqy9RkQQkS1rGY=; b=iPiC+o/cBetQxiPt/ubK63iBRn3L45u4qDqxFa/V
 B5jJq1PjjKx7BfttpZ4hYJUhalsGix3LaaNppYFo8APbNsUMxsKCcWW5N/BogLBC
 eW0k6QjJTjucZgNg8MtzGeipZJPJxbJBrN0zxkgnltxB1a0goCu5DCa4JtP4LslQ
 E9wT4II1Pl9HhrrMykmkeg8Zhm+LdkUh8nGSfzVCLFOxKAIxkhIseHJj+wypGumi
 BoTOGvXtLbDlvRenXEmI8i+RdCT8n8J0xYRETVntiWgGrpRZGYu0wuZ/klNRbSK1
 cRCwvDeYeLVOJgOFeMmk9hnUkWzU6CjblL0XaS9ms5kwjg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acjewb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 09:35:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36998507c13so5251480eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793698507; x=1794303307;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0oAGlHVvmGYbIykPRn43k3zHQxLEQtqy9RkQQkS1rGY=;
 b=Rh3/flv4BoNvs+QonfEPa4TqiRA42P8L9QHX3NE8TTiQAGeSVQRqH2dHuMMNesmowb
 2ia8iSeB1FUEmcqENPken+Tfa5lV+OXfNy2Z+ANmYQF1P4iMgQc2SUhQa1egh0/2UFH0
 a1X7fToXRHj4FI99W9jc1OE4ehvd9vbeSYDkcfflh82O6a6mmzZqsk+XAExT9Q87h/sc
 ++6uCg7zfCI5KNfzcs+J5QijFZUIk3LIqqz2Tss0gFqS+xEStyqoVFMoMt+v3HnQVyVm
 UvxYLxoLMouOyzEJmJY+QFEpFuWN4mtsCn7NUmANqW6+E3EDAzAfXb5NppRFcyP+77KJ
 cINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793698507; x=1794303307;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0oAGlHVvmGYbIykPRn43k3zHQxLEQtqy9RkQQkS1rGY=;
 b=CLpkUqKGUGfyGSZhtHajrXx/nI79P1/6H/h7KKhNGebsAX82Q5CB7M+j45rZzYk7lO
 EUfcDyK30/uU0k6J9L5JdEhKEjTzwXzG5IvLwv70hbCDb8Z/vA+oE6FQwenhJjlQ83D8
 rrejy6rzRe83PoRh9nJ0yR0tDFUghGUL7KFibfII/Hu0z7rbsDEKUb4xas6AhFwhpoqF
 ep1xFBkCFyRO7cylHq9RGpDo1vAbMGK8Lu80fJi+j14BshdnFPaLuU+Ihurz8XVQBOt8
 J0kapz25f0YsB4HPjfAwqCSWt8yfxZ2++7BgygPopu2a1ecsBJVWdtmVzJDsjQQAG5zp
 WeQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ28S5e1AUqFSYv6gKuuyzJDma5LIPxsIgsj8hJCjOg/SeMhKbAXSVe8dTFR1G7h5hHUExme0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90s7EH7KSsV1BsR8YW91FjT42UAjrkfvY37YYf9cx97qCYWQaU
 x3uEQdntb4hhQzje9zPzA7DXBT+LLI1wTgrDArP5oRYPG7LJcgCzTkfTH3jeNH94Qq7++FWFu8a
 hNhWd7fXe/LYLYold3ZdLRhSzIKN4pyPtLWzcS47HcX2OKNcfYTY4XQoVy2tIU1kkpNezs30=
X-Gm-Gg: AYBFou3I7bbU8ZK/mJ/hqN0bp+QdsLo/AEHYl+TLtao/7G8v5QcKG4XvV09U2WMaIWw
 S8VV20icaSPDrNmlv07S5lf4VkEmNUlZPItMRZ6M8Mshsm2MGEAWzIafNJm0oeUPHhVZLkvd64r
 dElOZqIyU9ZXSLZKfyLLT9vWeivYk89K6ihy17w3O1yqAW17xbrLBgOFEKibKlOFjZOJCA6SATv
 YsNxRI2t8EsHIplJbQTNAKm3pUAnJn/LyiIkjo+3LW3wKI4twVD87kdpPHCQf77sYFjJhN+kxqo
 J08QHgIX5RBHqjRN4Kbwii4/3LJsZWVoTVM5lIcOrNUflNDuflE1w0BAW3jMFcz1bjpwjOP6sRF
 iOmvydukApG3EvlBkdAGVtslkaTZz9DMIM9tVOoZwxVVFQ0qVJ9Wm8tmwz2Nf8hvqm0Er1NWV9s
 cecHQwGfa3LntSzqgWMff2+/8pEfu3daiY/8RlUSYJiON7uWvhTcLcGSLFm/1RJrc3nJaZlgYnz
 lrB
X-Received: by 2002:a05:7300:fb02:b0:358:5bc0:4f08 with SMTP id
 5a478bee46e88-36a425f611cmr16923381eec.37.1793698507225; 
 Tue, 03 Nov 2026 01:35:07 -0800 (PST)
X-Received: by 2002:a05:7300:fb02:b0:358:5bc0:4f08 with SMTP id
 5a478bee46e88-36a425f611cmr16923338eec.37.1793698506448; 
 Tue, 03 Nov 2026 01:35:06 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af4e6sm38583030eec.4.2026.11.03.01.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:35:05 -0800 (PST)
Date: Tue, 3 Nov 2026 15:04:54 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
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
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 02/15] mach-snapdragon: Kconfig: Auto select
 options based on configs
Message-ID: <aumqvpOI3ACR8pbt@hu-varada-blr.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-2-224d421c6201@oss.qualcomm.com>
 <20261102145415.GT3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102145415.GT3309461@bill-the-cat>
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9aacc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HY96L91N-IWQQNI159kA:9 a=aBA_d7iIrTI_lnin:21
 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXzbREnhCbU7BT
 jRY8P4C4xQWyHG/8zqIKMbSqcvbb3TgHcLHJZBuUghmNNiFqLWjY8YmlAmkzlRe5AreEsRONgLy
 dgW+ySReYtuUfVYPKwAohfI8SYOJkaSR8d81vgsW4R3o0Aef4gayGxIbWKWtfFKi11RYHTE5dDO
 8i15RkDYHpS8tUYRr7m9UBIzYgueZV7TqaY3wxL8zB0bWkvCORlvDJ2XWwtVL4Ulc4CqrCcTEbf
 9EcuOVjv18Tgu03Lfjj5HTMpBMWV0+0gG2xdC3ebxPhfYK4oRmfDnaxvylnkQvksIiRX/Onwx+d
 SxwxU9dFR7offb/tb38K340hDQsibQUrHqRvULTDvyL63PYVn7D1DiZLz9AV5jJgxYMO29hcUu0
 9PaBrMKv+U7rTLt5IJmxE3mU857s7Y7FmrEb2Wx1jASk3+M0dz1YPTRKlFxlHazrB1h9jYl+4v4
 K9gXdc5nHREU4I5HhaQ==
X-Proofpoint-GUID: hdTWJ33TOVSQ_4mCQLu22trwmJiNQwXD
X-Proofpoint-ORIG-GUID: hdTWJ33TOVSQ_4mCQLu22trwmJiNQwXD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXxDlwiuULbtn7
 AUpCvKgngqN3oOniiV8y3xq5RVVjA9cBAGjIYpjUN5F9BMp7wbPtM1ZsOWiEnIeXfHRVy3eEqVm
 1AcsrEigbOz2v+QFAlxE5wBFcARrJWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:54:15AM -0600, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 11:18:34AM +0530, Varadarajan Narayanan wrote:
>
> > The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to
> > support SPL") auto selects options that may not be applicable to all
> > platforms. This results in warning messages during make xxx_defconfig
> > and/or waiting for user input for on/off or values for certain configs.
> > So auto select options based on the enabled configs in xxx_defconfig.
> >
> > Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to support SPL")
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  arch/arm/Kconfig | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index f307340e3aa..51d60ef65fe 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
> >  	select SPMI
> >  	select BOARD_LATE_INIT
> >  	select OF_BOARD
> > -	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> > -	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> > +	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
> > +	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
>
> What's the error these two trip up?

Will remove these. Earlier, without these got some error. Not getting any
error on recent tree.

> >  	select SYSRESET
> >  	select SYSRESET_PSCI if !SPL
> >  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> > @@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
> >  	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
> >  	select SPL_DM if SPL
> >  	select SPL_DM_GPIO if SPL
> > -	select SPL_DM_PMIC if SPL
> > -	select SPL_DM_USB_GADGET if SPL
> > +	select SPL_DM_PMIC if SPL && DM_PMIC
> > +	select SPL_DM_USB_GADGET if SPL && USB
>
> You're allowed to have SPL_X && !X. Presumably some drivers are missing
> SPL_X options, I know I've seen other series go by adding them.

Ok.

>
> >  	select SPL_ENV_SUPPORT if SPL
> >  	select SPL_EVENT if SPL
> >  	select SPL_GPIO if SPL
> > -	select SPL_HAS_BSS_LINKER_SECTION if SPL
> > +	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
>
> How are you tripping this one?

  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
.config:219:warning: symbol value '' invalid for SPL_BSS_START_ADDR

[...]
*
* Restart config...
*
*
* SPL configuration options
*
Support SPL based upon the common SPL framework (SPL_FRAMEWORK) [Y/n/?] y
Maximum size of SPL image (SPL_SIZE_LIMIT) [0x0] 0x0
Maximum size of the SPL image, excluding BSS (SPL_MAX_SIZE) [0x3D000] 0x3D000
Offset to which the SPL should be padded before appending the SPL payload (SPL_PAD_TO) [0x3D000] 0x3D000
Use a specific address for the BSS via the linker script (SPL_HAS_BSS_LINKER_SECTION) [Y/?] y
  Link address for the BSS within the SPL binary (SPL_BSS_START_ADDR) [] (NEW)

> This is the kind of change which (a) should be its own series and (b)
> either N commits, or 1 commit that spells out each of the incorrect
> conditions.

Ok, will post this as a separate series.

Thanks
Varada
