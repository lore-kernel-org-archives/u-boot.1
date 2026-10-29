Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GKwhlNEA;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lQCaGX5U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PIRSnGz0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99351606F2;
	Thu, 29 Oct 2026 15:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_uxMoSie1WC; Thu, 29 Oct 2026 15:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8895B606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793288708;
	b=IcF66L+wVpQHPTaDtJ/NjtFIGFaMGmE9DdLOg+9YcFk7ECuoN0UD3qmkUfzb/7HtJEa4
	 QNxCRowIXn7Q/FN/kQwCUM13DTSlG03e9QJCgjIf4AsNEQZEq61hZCXrCDu4tDSZGNya0
	 iGByLU685q3JZCeAip/PMJDvAFzdTn8q0bNeSOYpaXWOCq2OpDH7OOtf0iHybaTfoSvqM
	 hUPaMojmkg+5iaZNMpwJsEmObJRVSAjzdiW6xleWrKMdR39nf+cpT9PBMB4ZPzPYa8lfN
	 e9ES9owX60KtCYliePLrIRbSe233YfvKPuL/Sal0emjzpJpsC2JZzabVCJXEtdhRQOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793288708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=;
	b=bQHWFQJX9XgTWpIgR9nYBoX807RfhqzHV5ybP8lrShohN9dtoPRG+DkdiSXv1Lo6cbrR
	 im1NSKBkOVVeezNOCHYB9H6E3nKsXm/fWZeoXb6IbnQccYmUizn5xzBR/DUrygUKQUKeg
	 JNXcWP0jCO00XvPCQnsDq+8ESAcQVPlJh9RArZk0ooa913SBQKsf2EuzX8cprdFb0z/p8
	 a45Ih2Q5EuK5CmVJ2qUZGEQXKlRizgDz6B1247TmMrkXv2ZrVmORVBW6cFL/v1HK/CzLh
	 oszMBgJvg27BtxXRIf/MNrgnV4ov+8EUXvd5tptwYtLxMkVgYtvbIqR4XbigfAdhuKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793288708;
	bh=FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GKwhlNEAS5AMxSs4gwYS+eeWN1aprwZv4wUE3rYWZzZLpuMOSUZCtOxyu6S0EiCka
	 vSAEopsn3ANeIVtgWOznl4NJnImGJnpbjGyH0BUVxQ2CRCOHsW8HNmRVR5NKcybnn7
	 Z3axaRdYzy0RLHNCzX2DedO4VYL3d4MYXomxJkuULejielp0qLumDWcOyfJdshpVMq
	 FTpH59V5T0aktamL3kVBcVbswB+rq7tCSoUYklKXM+qpg8ywv1s5QJfL6up4qXayMq
	 Jvkzn5D8kIVsfL8zqG10TcDZPZcMKPL2DHpJV429CaSizQLhFeqkfyeJ4PqRbPx5pd
	 2QjNuzoh0qJYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8895B606C4;
	Thu, 29 Oct 2026 15:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23355972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08E71405F0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aaRM_u--VsY1 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 810564051D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793288706;
 b=i/ha3yvOyg9uWJL54LU/8BM2AJJKXfOhbOEHYcq71w31GzvMXM7FXM2L5M2/PiJnGPEA
 s10ugTj7umv5U6vjfDmckZ/+EXeS5TVruo4a2iUxQfwJdjWG1HXRSw14NfCn+YeCxGkDP
 6RgQv0FC0iKoN0aLKh+SqLTaaakYJDF9FNr/g1NmNajLF0xHzN7hP0cRkzluC+pf883xc
 1xIqx70X8/m7DeO55qmY58BHRD2jp3WjUKKk8OadEYdFFP4RVZMNYe1IlCme0giPDRzYw
 34EbrncfDt6Ac2qogVIgis1q6z2hIeKeojnbCIaejOo3r43NVU0M07DjvYHIBYllAew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793288706;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=;
 b=PT0LUcqa8cLlP/c3fIVU0dPDeNJyl9uP3jrusQH7CA0oNJPikAYGBdfq6vkaYV4Y8mBy
 iwesHLEWxUppk5VxjdXVGTXsogQG4TyxzuZ+is1muBv/Fk88GtEX04Walp74s9rz2SYdO
 XU2j3yP5QNcXzrjh17F2s813QnoKimV5YysnEKsKXg02gLo10wAnjnMtsjR/kjbtuC6A3
 RELDh+UOJYt3GDTl6hlC1LF9DREvFxoR0dpyAJc9WxXxcfnCJkb7CDqEbyTcpncmWWNv2
 u26GRueZb2Mf0JvzdUzUzHq0/DQlaH1lnMf6zPu67LaQDRJTHeopLW27v0Ks0ebtmHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lQCaGX5U; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PIRSnGz0; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=lQCaGX5U; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PIRSnGz0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 810564051D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCdw1H3943681
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=; b=lQCaGX5UGHLBBypH
 j/XvQ1cUbpnKcB+nLWG7dXKVkj0P6j97da8qHOUKQR8t/weSkrVFanvDtx902+Wp
 dBhSMEjrRDGX5zXvvobyVwBJEDE/9/88a8alo39lh/lluXg3XnWg6ojPwnpn16oP
 IT1Fr/VofBqT4luouWoUzp4UAOyDsoM2yrUqg1n9xNHZsbp8s9lUMPltQPZ5YdaQ
 r+z2hxdTNZbnTYIQqF6+xajMpjHGTSeKadhiafNJRqaXUdJ9YWBfgYU4C3Y54/AN
 GXzIha4p7hs/AYWSgiZBnQ142/uMQadBnbaT1MOVMpvJu1xEEaYQHMj9XH36Gtkt
 eHmwHg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fhbme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so488994685a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793288702; x=1793893502;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=;
 b=PIRSnGz0QUNN3v6bDdtW2h9QG6Qjl9Pa8jbjAZfICKLosxawyVzTlg7D7x3pC+aZue
 5USCIR1e0I4Q0kFtkIfik9p09MHR9jF0F/i4lLfr3YNxVIzlXR/ReudO9tSBt/+pepzw
 DnxMgX60qoivfDZbqdJNaYuuC17mE3NlpOkQQy1O55cXirrTTb3YAnKipmG19XH88+5I
 rB/nV+3pRQuAUfq6hZhO8RDRnjfdle9AT43bnaYjLv7uHRBtxcFC2EWphVZKOJbNrsch
 8iPa5JCpv9OaHx366hhfTWRtz1XALN55SVsy3+wp2u6jDZVdtvhVsViurxgxFAZ9G94O
 kBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288702; x=1793893502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FnDk/3RKPffzx3zMw1a+6NofozFOKZvyTESF5IBywPQ=;
 b=uzh8qGq7RXkbWoEyciopHSTzXPOtKNbrXvrrI9nauZGgmSJlT4WFpdUcE6RGblu/2S
 rk44aHi6stjUIKTr3bH5bLLa6p/hTTtdK+3zz0E44+TMp3pP+OfTSB0nsW/xT+OMo7mK
 jD2ETA3NYRBro0q5zL9VUTWUWQLlznFWPQZiITktnpfQrN0QIb5nJeua/EnKRcx5o5oP
 YY5seqjXIAntdRMItntiNu6tw7H7iOhBwheaIZgn3WDFWYkgv/2+0DlABJaDzdGLJrV3
 KKbJ1aWk769qM948vSHOC/ceDLx7O51ewafEJUwjLRpYW61fqAk0zghSIlQaeW9cNofj
 rjSw==
X-Gm-Message-State: AFq9FYLE4mQKVDM9QnnJ1BhVQaXSoKrJd9sT8z0u9qFC1kPyqFpczjfT
 fBMiBscJB696Fb3YlEV7wmRaeJSFCfR+rAPt1cVUOGZ5uwLG0au+SYBd3eWB/7Vd0LR/reTkShJ
 XYxxdUoCLuzEPmkJrl9ec6vYaaTcEFNkKpkAtzvpB4wpDfkEfWp1GU5VpUuYKG5up4LC/hp4hOI
 4CvV4tgA==
X-Gm-Gg: AYBFou2SdLtnS2J7ARwz4hm8l3kzkVqkxirPqeT2uRu/E6xHjLxoy+OJusvz2M+PJGf
 jCUMF1LAuE74ArwlLvgsGAb0c9BIcjpYJc/8VQRofSZcsGgQPl6we44oApNmfD0YMBP+C3qSFt4
 59hzSf5m6u3q35hfDko18NlBYU1+MNJ3DOAk1JJgT8/FvwFLIBG/VBkaEtvuuxLmYITuN4lrQKN
 icxuwc4cEpsHw+Yl/K9vY61UsMmK7mfSqhBvEwxJTniil+9MftYj2WGGU0xHKSmNcnqOVl8FKDc
 FAKeH2RoaHn8f5qM4BUXWXWht3i52ar/kN2+Oxc4umSpP09AJu3t5G9/Cvf+Pv57VxTt0QowJT0
 SiMeC1+g7aM4jLwbNIj3PDo7PVb7QOoC6aBs7vPHBPS7fO4yKd71x70EGrx2MMK2t/OTrb/FMvN
 nrNFUzPfgKfk68
X-Received: by 2002:a05:620a:1728:b0:93f:3576:d43c with SMTP id
 af79cd13be357-94408a7f9f9mr1028939785a.19.1793288702226; 
 Thu, 29 Oct 2026 08:45:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1728:b0:93f:3576:d43c with SMTP id
 af79cd13be357-94408a7f9f9mr1028931385a.19.1793288701510; 
 Thu, 29 Oct 2026 08:45:01 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b496022e91sm2814338a12.12.2026.10.29.08.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:45:00 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:44:50 +0100
Subject: [PATCH v4 1/2] optee: rpmb: select the RPMB partition per request
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX9+QBoapGw5UL
 cymmOesD+1VnzIU5QN1ZOJBF3wCoSi5mAmCXDe0jLnSXd88Vpxcc8AEfZ/Pz8SPE1FgrfCxPiJI
 Du832ru/NxOMEGHpqKp8czRgcJYJhHozhNoKRIZ3035OiEQkavfn6PzANlyY3zU3yNa+F1Jhyzx
 /FEq8I4WpGVfvnn3o5NYipQuW6cTh/t+Rwo4mrnF6IMplcMeRaKIqPdE/vmS1/tqw0R1UV+FygB
 Xxd0N3Y1JCXA47VCMjGV8xV3FXfAX0eH3SZKgQuAO0XQPfehbOA+NKydoYfQM4ddEV8QVGJg2aW
 frPKbb1djkhfyTryEjxWZkQFgikjVQJh8L+ulPqRQpsj5qcBuLLybtwxG/JsHo3UmdgqgBpwQuv
 25AeJZbDjYHzf8pRRFqe6PszcIMJkmtRWYIhC8VPdgQJzZ3YpJ+qF/xJURflX92jS49s7Uv8rg1
 qgC7bXqjSUfv8ybjqVA==
X-Proofpoint-GUID: hNhX0ZFNnFO3VF23L8gtRz6vbyDT9up6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXzS+ZsTVYAAVw
 rEYItc7F9IYwJrcPyS+Ud3KZuUANxDMom4Z74ZHUyw9a+hapNDAb+7L/b16DWKeKsQkPTomsY+f
 tH5xMS02gjvjeT14Cy5YyIhfnG2AC7k=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae369ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zL1JONcZbJ0eZN6WwLkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: hNhX0ZFNnFO3VF23L8gtRz6vbyDT9up6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290061
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

The supplicant switched the eMMC to the RPMB hardware partition when the
device was first used and only switched back when the OP-TEE session was
released. Between two RPMB requests other users of the same device switch
it back to the user area: libavb does so for every partition read while
verifying a chain, and the Android bootmeth reads boot/vendor_boot right
after verification.

With RPMB left selected those reads hit the RPMB partition, and the next
RPMB frames were routed to whatever partition the other user left
selected, which ends in status timeouts and I/O errors (seen with
the AVB TA on QEMU's emulated eMMC).

Select the RPMB partition around every data request and restore the
previously selected partition afterwards.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/rpmb_emmc.c | 88 +++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.c
index 7ae6045511b..d4abc48f764 100644
--- a/drivers/tee/optee/rpmb_emmc.c
+++ b/drivers/tee/optee/rpmb_emmc.c
@@ -42,51 +42,55 @@ struct rpmb_dev_info {
 
 static void release_mmc(struct optee_private *priv)
 {
-	int rc;
-
 	if (!priv->rpmb_mmc)
 		return;
 
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
-				      priv->rpmb_original_part);
-	if (rc)
-		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
-		      __func__, rc);
-
 	priv->rpmb_mmc = NULL;
 }
 
+/*
+ * The RPMB hardware partition is selected for the duration of a single
+ * request only. Between two requests other users of the same eMMC, for
+ * instance libavb reading the user area while verifying a chain of
+ * partitions, switch the device back to the user area. Keeping RPMB
+ * selected across requests would make those reads, and the following RPMB
+ * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
+ * partition on every call, and restore_part() puts the previous one back
+ * once the frames have been routed.
+ */
 static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 {
 	struct mmc *mmc;
 	int rc;
 
-	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
-		return priv->rpmb_mmc;
+	if (!priv->rpmb_mmc || priv->rpmb_dev_id != dev_id) {
+		release_mmc(priv);
 
-	release_mmc(priv);
+		mmc = find_mmc_device(dev_id);
+		if (!mmc) {
+			debug("Cannot find RPMB device\n");
+			return NULL;
+		}
+		if (mmc_init(mmc)) {
+			log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n",
+			    __func__, dev_id);
+			return NULL;
+		}
+		if (!(mmc->version & MMC_VERSION_MMC)) {
+			debug("Device id %d is not an eMMC device\n", dev_id);
+			return NULL;
+		}
+		if (mmc->version < MMC_VERSION_4_41) {
+			debug("Device id %d: RPMB not supported before version 4.41\n",
+			      dev_id);
+			return NULL;
+		}
 
-	mmc = find_mmc_device(dev_id);
-	if (!mmc) {
-		debug("Cannot find RPMB device\n");
-		return NULL;
-	}
-	if (mmc_init(mmc)) {
-		log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n", __func__, dev_id);
-		return NULL;
-	}
-	if (!(mmc->version & MMC_VERSION_MMC)) {
-		debug("Device id %d is not an eMMC device\n", dev_id);
-		return NULL;
-	}
-	if (mmc->version < MMC_VERSION_4_41) {
-		debug("Device id %d: RPMB not supported before version 4.41\n",
-		      dev_id);
-		return NULL;
+		priv->rpmb_mmc = mmc;
+		priv->rpmb_dev_id = dev_id;
 	}
 
-	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
-
+	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
 	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
 	if (rc) {
 		debug("Device id %d: cannot select RPMB partition: %d\n",
@@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 		return NULL;
 	}
 
-	priv->rpmb_mmc = mmc;
-	priv->rpmb_dev_id = dev_id;
-	return mmc;
+	return priv->rpmb_mmc;
+}
+
+static void restore_part(struct optee_private *priv)
+{
+	int rc;
+
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      priv->rpmb_original_part);
+	if (rc)
+		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
+		      __func__, rc);
 }
 
 static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
@@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 {
 	struct rpmb_req *sreq = req;
 	struct mmc *mmc;
+	int rc;
 
 	if (req_size < sizeof(*sreq))
 		return TEE_ERROR_BAD_PARAMETERS;
@@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 		mmc = get_mmc(priv, sreq->dev_id);
 		if (!mmc)
 			return TEE_ERROR_ITEM_NOT_FOUND;
-		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
-					  req_size - sizeof(struct rpmb_req),
-					  rsp, rsp_size))
+		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
+					   req_size - sizeof(struct rpmb_req),
+					   rsp, rsp_size);
+		restore_part(priv);
+		if (rc)
 			return TEE_ERROR_BAD_PARAMETERS;
 		return TEE_SUCCESS;
 

-- 
2.53.0

