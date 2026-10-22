Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0B606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kp7IZ+mz;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2ngIKwd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fZuSlCu2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01A90608AB;
	Thu, 22 Oct 2026 22:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynztH0_rbTMI; Thu, 22 Oct 2026 22:00:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 473EB60A35
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706447;
	b=hfcSfWEAKsHJxO/1xpxMhwLWZdSA6eW0dP7k3eD2v9sxiU5lbf+YMy7ZCQYj7h8mQRrY
	 g/yv7H7ZUWozns1SAP5GFIEW366evinVhxyzCPRKy966LNk7V31Q+HDWp0TycRIEBmi2Q
	 LOSE8eg6OlJLhtuablyeFop0JW3xH3RVvvcwHRrf+hrdNhEkfbJmjRSxnw8eKyc9lHC+6
	 dQ868wXoxzgYA83RxKQnaW/Wox9iw2pQq+bbyltjqdPrM01FB8Tp0ExQI41PTPUW8SfYc
	 TG7poYkSZH8Rm/hsEL22bcWmTXKlHgjQ3ryf6RpryFe2IR4SUSeFjIz094mHXm/W0pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=;
	b=o4sfUCK2b1WVl3mDKaKoM/Ydc7hXB9J9mNF47khOvqqJ5P16vwDNN8ydwNDJsl/O+GnM
	 LNC7zUu/S2jSX9YlYSwW5qQe4KdjSbYb7G7vuHaiz8QQWKpdzxbvIK/sQMtREnduHVy//
	 v6EG7934QBTq27ZjphgNcMV4Wc5k+ixi114FWV0h6JA4YGyd3yeBbJST/zHIQwIfN0DoS
	 KZVGqFRnb1nzDbNpsB/hzQE6rO/zF1EcZWIjlaCioPt6b08cNvF2uCXqWCCLAL7aX4Q4a
	 ZrPMJvJovgextRb2RqF3B8lJjjxpk+8SxlfIM2uMuaWv4vN4906SrEfWrt8Sq4iTiQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706447;
	bh=FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kp7IZ+mz4PW/H7Tj09MIjQ+43gPoKsXbHY2lHGUUIHX+dHNkqPQrXBSnD/LbW1CLc
	 ywosz0VxzrU51GzjK8+hF7UOyGyJ6dbQc6Tmu+u7ifVGVLxYGmPU/61EMEY6L3b4Y3
	 313FqqYW4/NL4xA1MslqZBKtz56uQaDs8uKs/8SwaaZPfPzUuzdhYS2vlt81ZRF9pk
	 dPPOS+vpycGKNwxpQ2pYPQEUcDlcKUX5us5k4DelBYCQmPCot7YcBQA2mmZrvxYUce
	 rdptwSF+PPVPvvgGywB/68sqOsakoh0HYxvXemv1tNBoT/NitFi9JGZ0LLNZfKvsat
	 /QGPqknfSs5AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 473EB60A35;
	Thu, 22 Oct 2026 22:00:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7801499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B99074040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1BP5Ats2bLY for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD7F240270
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706443;
 b=ON+nO1KiQ5Q9YKgfqapvxRtf9TkBjSraD1WddZak1A12iaK1+OciasX5QxXJVhMPg3Hn
 Xv7KkECjkpb0lPLgIg1ytD/ff6z14aakM+hxxb1KstfqGmP8rzoDjY300uYuefeLg85N6
 glVUZHPsB4zbqXJtD5sA6g2pWA64nKl8rIk2iu4Ql+ZaOGMWv1yl8Prq+NexDPGPJh+4z
 ja9OrpyYFTVuASWSVKGCqGsVmvKH6GUiuG8AU5tDP6wsLj4wzTBkv+uNxRibDW+0dXh6Z
 VmfjTRBrAoVHfCQilJEDwt94LYKrV0KKEYv8KlnkOCJ7vpuXKTWoGzv2hgQVHleLS7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706443;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=;
 b=Xxf1yutmNe5V1XbqwoNxkwZ7Y4Gej/LbZGSz+CuhYyU5RCkItnTZC/6K/LP8jVee/X62
 soQXZE9ngBqSTH7CdF48trDe63yORAtS4XpvrQeNE2KfjAJhMY8lDBSTEUIOmlrlChkvW
 3e2wGyb7QJTVLzBa1fqm4nIgywrl30OhehBGcFnFHuIttuWI3i+ZJ6fhI3SdRpvijn8mV
 kR4qYHpM3zKNug+BCkUTuLeyDOR8jF8SR50sGnicDz9RnfZ5M9qvqcCdktT89vzak1OCa
 8Fchz1xFvQE/tF8OIsF+Q9pjyxT9h5VFh4EB9skBlakIyZ6zqcmzRa3fCnFWYrbmATg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=e2ngIKwd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fZuSlCu2; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2ngIKwd; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fZuSlCu2
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD7F240270
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHt283059975
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=; b=e2ngIKwd+QpZAg73
 Vw17HnA9EMMb0t1CWNOPaolsbtQ5GG/DCPoYTNF5rAQ2sF/Eb359cAmzyaOF2Vjh
 fBCEJ79wLLXg/9UHpgsTphV0TNqXVkaeQFrbNaAWAW4buC9Ak5vKN3dMd5/5JAvo
 FRJRbadA+XcUIxoThr8TvFJgcNUEp/rs8dwwupVfJ0vaxinNV32Smc0WnT9s8gFt
 7hWYSHTeESrFZj1t1Cry+KVAVQXe8z9k/fhWtw09AF4ThzdGzZsbH7iz11hhQZV0
 uKMLmWGdFiHHmPJ/z27GJNnGApqG/W50W9TtGypYwysnTufxSbnLvVUrwpblqtrO
 xpeVKw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahs4se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:41 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6790b1d37e7so653310d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706441; x=1793311241;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=;
 b=fZuSlCu2wnBSU2ainD2mD2OvQUiDNq+Tyqni9VE6WExlALgEi6R7VsziYT3+PECwAq
 W/kWzUJMpyfz5Gtk2g/0d6igJ9DWZGxT0FgUaIx2nrRnk5vkstEIKl/b3CM+D/DijKWo
 yH5+xDSYLYO999B35FH4wAUKCGS/W55hgRunCuwLjDNiUZmUFAqcO7GMaxGXcM7/JUlf
 ulFuFDUJIW3jfS1wQsy57hsjgAH/f9qsn7+guxK2uK1+Ffh/7vnYBlMyaY/pddVbeDIg
 PSNAzIOZfW1L8Nu48U+R/nhJLCrtRDW+WcBXcPO3T4hFyDeJfkj/rsLF3SMXk1oMnR3C
 5Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706441; x=1793311241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FtYo5ujAueWOsBWcXQlRu0Z+JYZBHrOy/f507PM4N/s=;
 b=GJfCr7s38QC9MCjJMzoAWgiAGzLNMyqy46YmAbBgIC2PAevMkVBxRfEDqYI6eh0Fqz
 s90mjtzBnwLvehIRHBvkQ+UUuanlnYzkaOA496RfCwmlQms7edS4h/n9zt4Bo/6GQSS9
 dRjHY8CosnrwzLYnOtFJIQ/g90soklqkkOx6evYmvRwjHIGAfs8gC0aCL2DfsdFP5RTz
 nGGIvvPIacbl5iFYYtdRV/aKyr8M0PtYAgl9B/feeUG/9oz2jiCVL4kOKSBc+fFIBNYI
 chQRzUd2Bxt/Pxwrn1xTo694gYqRK0hCki4Hd0RK/qicRobGLX95uH2Av5FNFHYNI/Ee
 d8Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8KTyH1OEo7DAMVU0XxOQ+mhlZFvKkDyfP+1DBi9CqdwfVRRjgVf0z46+v3DSEtk+xT4PzMUs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKgycTuTcoNeoVLuiYqChXoJ7kV3D+KTz509jVw5+zVtmFILk3t
 37QKv/jOpY29q0RnKIw0yPu1RL0h0VUWzcL5f7jBb5d147/L/6l2tAFy70x7m18mL9a3EW80Nws
 Z6278P5Jck0/FduHgNBcHCPx7B6HHAzNCk7+64K43tx61R3xg8Z9VhoCV4bihGKnMpB7eRN4=
X-Gm-Gg: AYBFou3GJ0MyCzaC41A1xUbV5WV8vgSvWNROlxSgoxSXtYWdTQIGpKZiOhjhbqgZY7z
 ehqcZwwV+DrUOqImblYG6zphpYVYjc9E0qs5UsygRQp4+/HSJjaWDMq+RNHiFT0X+Ui7UHcbKTc
 pixMv9ak2+yq89Y1mOjWQ7A5+5w6/V0QPywJy0oi5aWJDclUuZdOBhciUEz/qNrK72mbQrFppVs
 f/m5H1pEc71WeZnG78HQ4S6OqLa5jEgAxSsOil+YoBi6Vcq2Q+WA9gAvFWS/V3D+nUfF4fzfBX4
 lXSVhq1ULas4qOQF7FIEL9Ic2fgTJOIZHx8esIi6BCKH9JTSRFCmpi5D2ETX5c8So+pn9+YEsPo
 51y3NEPFkEjU5ZGEJeASHv36rVB20Qri6hreEBDUncwQmpTUNktXNGnzontkK
X-Received: by 2002:a05:690e:1501:b0:679:af53:aa05 with SMTP id
 956f58d0204a3-67a359ebd14mr269724d50.12.1792706440742; 
 Thu, 22 Oct 2026 15:00:40 -0700 (PDT)
X-Received: by 2002:a05:690e:1501:b0:679:af53:aa05 with SMTP id
 956f58d0204a3-67a359ebd14mr269697d50.12.1792706440195; 
 Thu, 22 Oct 2026 15:00:40 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a34032cb3sm373643d50.17.2026.10.22.15.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:00:39 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>
Subject: Re: [PATCH v4 5/5] configs: rename qcom_qcs8300_defconfig to
 qcom_monaco_defconfig
Date: Thu, 22 Oct 2026 18:00:36 -0400
Message-ID: <20261022220036.784522-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-b4-monaco-v4-5-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
 <20261021-b4-monaco-v4-5-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7vnYYqNCquXw
 8NK9TNH5B+CL3hSUXVmU3FtrClZG5seIGKXb3KZt30u8fvq3GvujIoAV5sfudg5z3Prcsqx/Nep
 Dw+fJoT+rshht70NCpEfWmOJ92CfB7Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/9oClcNsGcb3
 aONcYvP67qHMY3RiZrpcRWKYylQqY9SWhWa9hKd0866ItTllZHSUy7DjY9MmbYIttgRjyFJi467
 f+lbA6iFk5bAkBpr2BPzSyCE+HdWRJ8ybXGIOL2KWXFoDufAitUX6eDKpfAf6ag4jLL87E+xKBR
 E0u64Qq8du7dninDSfZFmhZPlMBhitzRyFMd3NPN6rYzuPqcGnXBSLwPDLuhzOyIFYCxDGYy5I3
 vsgRKj81cq09ckbAV6Sa/ncrx3NQmnt0huZ37r/YzIIb0dt9ZpjHfIefzB+nU9doEFQXdyMMDcT
 d7Psl9/O7MQUz6FCfjLlngr4eQXZl/18I7RjMvtGbRP3YyCz3nL2R3r134q1VyEW2028IlXu2EL
 8d1dnUPwAueYlkisFzQothh2ptPX2xDTHdpBHQxj6P1JtD2GNXtiP8+MB2hf7s5ooj+SE+30/o1
 ptTOv6exSaUJ6PKTnDw==
X-Proofpoint-GUID: jTHLLBWphJvzoTJuaQfQ-Q_iuEzZOeEL
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada8789 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=8VQD146Iif8cq9vIMHsA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-ORIG-GUID: jTHLLBWphJvzoTJuaQfQ-Q_iuEzZOeEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:13, Balaji Selvanathan wrote:
> The defconfig now builds the monaco-evk device tree rather than the
> qcs8300-ride one, so name it after the board family.

iq8.rst and dragonwing.rst still say qcom_qcs8300_defconfig, and
nothing builds qcs8300-ride any more.
