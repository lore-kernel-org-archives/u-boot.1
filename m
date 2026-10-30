Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D2606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zntIjs6n;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjyBblEI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Um4vH8fk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAEAF60AA0;
	Fri, 30 Oct 2026 05:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FDTjUNCnF8t; Fri, 30 Oct 2026 05:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC69060A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793339377;
	b=lmR/cGTksRGNTun/jFUuzs1PfiehA3xKX3WAqE7C4gQxiZWuvw2QGkjuIe6/itfp6lKP
	 FgC+WBVyKPfdAaj1pNMJOMQyIxohQrZxqITc1phBtpwWC9kKLu9I6Ah0LuQTuxJ35SJw7
	 bvqnVYxx3wrkCVXBB4nqlP+TXsdn/vUZvViJFXTfCZZVn0nbwxZAT82xd9qjiDbxLy47d
	 h4sy9YUGcQBjQhCGVdl4xJxEVgeAYOWteY/tDPso06KU2LAlJ787NFtKF6wj+ilLHAOVn
	 n2Rwgt4G7TI0ADvOJjD1t8E4SYhpeIj5PWs8XZVcTQDhVTFkUC/sAna/zpPRbVgdo6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793339377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=;
	b=MC2mOt+cMl3gfH0ZtClEwFtcz4Ho+A6fgdGISqyAA7SgDVtBqKOLkn9VinvmJAsj0hBD
	 h3Jnkr6+Phh1u+Csi6G5sMx2nNNbr/tEWvVlf5jjtqBu7Q5Axc00LtCeseOtgbqMHj5Lb
	 GQNnHQozNWvhRUvCl6+NayGL+5PnfqbnQDM9RZaedTBDlnk+7wz/TO5eG2HVkq8uoCDrd
	 aDYGeDeuhVVRHvZw7nvunP2zI2A4MNrwevZqKby/0xXK2EbksxKAKP7C5syjKU2L9a1c5
	 aQ4IlkMTvPvVYad9cTebRGvkyjtGU/Z93EETLGj8YTmpiKRRi8eoqYTa5vC+zxf/bHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjyBblEI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Um4vH8fk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793339377;
	bh=Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zntIjs6nSJM8QEaTMCbVoPik2qbF/xwI0lY2pQCXCo56pEC+DG+EV6k4GSoR3trdh
	 WQlADGraE2cHIWIG5H+U3HOwY7laP0/DT/ee8g2iNAhSjseLD1J7jXGLAjClYaKL4b
	 n4XVxp1DJOi3/6mYEOplT+nBv4XdLUU1IdV9ga9tZD65kNqcTGkdRnhZJ/gqZwR+wz
	 eZLWZWdqtK5Ia4KN0+ya8J8HAp5u6p9X4CKFGuSdadCUe3fIAWsNpOmD+oeyfq8ZTt
	 FXwsbHerb8UvAqFpW6KjGlSaHGIP1wZongbbvglPEAZ7YMVDoUZe0oHXjnbcokkQQX
	 zbw5mTtX+ZpDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC69060A70;
	Fri, 30 Oct 2026 05:49:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E19C51DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C764F60A70
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88Q-cI-4EcVh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:49:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69D4960667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793339375;
 b=NCDLObwpcQC+jTbPRfGOV/LsnxbB2K+uJ3rNHaDKx/QCkin61eGbYXTgxrPfWDCxxkLL
 B8FTcGsY26lMqFtmjlK0OL8R6i+gyPkjmCpPTFJad1dCDcewMVwQRfly2RR1fFC0G33dJ
 HZdjeVUX0+rvldc9i61ZsQia8RPv/KhjYa6pwlU2oLS2dZajbPYSvFB51Vew+u0a7Ky7v
 ZYMFRzUmEcR+J8YCFj29LA1H/KwA0zWClD62oRGfzfOXqXhRoMVJDTt6fyHFlGDURLxuh
 akrgsy7lgoK1cd0vo59OluSNMONZX0rfb/+HPsn1NFD9YR00JYqeUwrg4B4wb6E4ovw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793339375;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=;
 b=ZyFiWWPSEQ7MM+7OtsVQjI1U2nozDOocZeA4YlQgnju30KwjGRWOx/V8t4D7v87c1oCk
 0an1MuhIkeZ2VZXywsI7bJVY/r9MCaCXf1Xsy9SfqXo9Ok3WlTeyEPfUbpV+mhdXsDfkq
 KO+sOp811jtsWGy/gSKhJOPSotha2NojBFlelClpiUeqKOkVgnHXBSCjZTCYPFhOP7qt/
 vGY279Hv5dvwZOl/Iz/zaSOHjg+psmWGSUwuCfTuQ7clRKTlCRnPWBrZnt/6gislLYX96
 zcc1gn86FjaHxJm/o64NQVcx98nP/u2PZWC+gdTLGkYHielLAspP2KBUiFJobGU6byg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jjyBblEI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Um4vH8fk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jjyBblEI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Um4vH8fk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69D4960667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5FJqa3312796
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=; b=jjyBblEIkkYahScX
 WcljZOzC1KW0J4lcUjO2prapq9+EE+hDnQboTyiifR+2A/Uvc1QAvEHhaIH2HtGP
 ++CXs7bNi6L3NRNDcUtm2L2yXGmdozpE1y6iZFFU6OHujvvA706Oy10/yCXk1z2E
 urgOtSPdyVLhPnSto/rR9QGKpzVt2jgSAQ+/CVZ7YdyxUYJbqFlpTBRLcjfOOkCt
 4dnhh6ymKbOf+WPe4It9j2XyBqzLlzVV61Y0aU7tF87z6uiekPXnFok1My97tusm
 BOfF3EdzqXVay/nd08wF2HwT/oh7rAtOLzUNlzYzUwfJytXU2FB1AzHvuURR0q2C
 46ICMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rhfdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so561629eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793339373; x=1793944173;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=;
 b=Um4vH8fk8ehGvA5mYdKMZwi40X/e6BE/CuSRwXHvvZQahoLFsZ0Y6PU1fNLsGGxK16
 3sgmEw1ndX0LxFrMrZQ868NjsImw/QBSXqDRzrHnEGnUrvW2f+kudgZQhvJFKoznUYfu
 MZgxuNniI0f7Nd01oJBAUcgfOAt6EX6n6NjPA+CATOSVin+hKJUZ3s05iLApYD77uurd
 BytTvhLMz91jcGEArdOlwWckrcYREeYavVpdqjFpXAIKmFByfcQJqo9reA/Wlv13Bi/5
 etloSPdcERqG91Dr4MyIs9RnYAaCiFdg4IhKNR/eC8IiL+MrOYDGHPlj68kDXssiM/ol
 rB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793339373; x=1793944173;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y1jmlrYcgoPMNOfzsLTu+6/TsRAo1wZpsio/FtT5kQs=;
 b=dRdWitUqGgub3P04VxVExSPidnVvD04O8Rhq+cEXc5DjOe/EqUd7qj+5Gvu+s4UUzn
 gk+gDinNZwWs6+kNcwFDPVAHlVAXJOhJafdbgyPu3riH4I4zosWP5aK8dQpzVsYkDRA6
 V2U+JOK0PmBXW139sezmOwJeG7D9qvTsyHpJctkv94v1XHz1VxtifbKSC+Rd39bqeESk
 /sutPuRArovj7sUijX/MIZJy41VmLF96LRz938643xx2ZiX5ODl6rABE7w9aYg0p4F11
 Kef8XNzhq4yjnJyoYK23vU0FUbA6eN8iQ7yC3dJpu50s79pE4TIH3JHk8ZFlwFvgT8v1
 oy6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByfZwGJ1n0iDOnp1GTXL06cHdGjprV/7Ju/2hCpkAaMBYMCjz/b5BF2qgpLd4qhTl/PM17nqpA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjos9VjOUSvFWsAc/SVAT1S4Hsaw9FpP0d1UPXW60B384oVTHV
 25RetdrMhb+n1uqGQn2b2Tv12W2oikz2bLiy4QkRwOShVN6oHiUBMMUAKLLYy/2ftlJ9xq//elI
 YeEhKcjb9Zpmg7Dy/i4bQ/bRJlMfp3VL/49kbp28DmHT0fJUIVfB/Q18sVa07qNJWooWt7co=
X-Gm-Gg: AYBFou2mfaeLsVcnnG+1gOwBDrNKP90MOsGwG1EPVAMlzr+sUtRoOkxsXgoAxuiQGOz
 krB7CLnA0K/4NlUypQuzgDdWvJohtg+795RV7lmXTeRue/o1q4kKA933OpbdDKMs4fdDIFAY4h8
 gGQMA6lBxGfAFp69QAl/gujyYQqlKQnet1P5DLRu1jyhw4PbAnyAu7R2RFFhR+w4T/p4EzpzC4v
 YcAAd7t34z8AX369G3attPtFXGJcVjz5dyn6wYu2vZH5fU1V2gYPHZpLk/nCpGCZkI5i7XkXfnp
 D9r30REu1urPgzOgw4shEPm2AFFEBb+QZNbjJNiasS608PmMHCcvqAZlUKnk6RpV3uFjSyr22Nv
 tFMRa70CS6mV536FPz/XVKjchJWDvglhb3tG6R054nkcikwum/gKzwllOUoHtJxlmnVirm1vXUE
 bC7Q==
X-Received: by 2002:a05:7301:4242:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-36a42219d4fmr2181410eec.5.1793339372669; 
 Thu, 29 Oct 2026 22:49:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4242:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-36a42219d4fmr2181376eec.5.1793339372108; 
 Thu, 29 Oct 2026 22:49:32 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm3861505eec.28.2026.10.29.22.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 22:49:31 -0700 (PDT)
Message-ID: <973b6e64-91c4-4335-9d38-9d1ad0cac5c9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:19:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qcom: spl: enable CDT for shikra
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
 <20261023140054.GE3596691@bill-the-cat>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <20261023140054.GE3596691@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EFcFq7YxZlzqNT6QTGQliI399i-5TUv0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMiBTYWx0ZWRfXzSlce6C2Puje
 strLwgZVZNwLOIbLHh3Hq2X17zFFbZS9nECOhRwB10G7DsYjH3IA2VxZkxTrls/gY3+TUJQqvxH
 qIx0jIcpx85MNnqtRWh/jeg0N7eYt2I=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae42fed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GjJZ8e-57JDaOtgGyBYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMiBTYWx0ZWRfX6ZoSjhdX/fqf
 r5Vg2CqQ0nJ7a9cfclTX3DvyVqPyZi9StBtbbB6DPyBvSRfifdScn+ofqq8PrijNUT0gns65J7Y
 UYhUaYaKme/cWhPPugwY5ubDlsgOQSGn3UOhyTdt8tyCKeOSbKTZUKDdxYzPaS8uUUURhB3IvGx
 lJrbr6HlEg2kwVQ7m4CGtrOhLTJAGXfdXLe68QgGOBk+gDorChi3M5WUxbf84dYLDebdT4nnYvr
 muhuUz2yourYhSdekgnU4l25YOjmOiH277E7lSTVbAxJxg56CU8ZBL5fG9exK13usLJHQhl6S5w
 0A6Vts3XZvGvW/eqk24S5qaInOb+I8K+zy2DVRSnQpvWxrKnxjdCwDT6lrGztvJ1MF0QdnOSoHX
 rkjtzvFCHcuxgfWzQ6M1x6JMdxYNiyhuxpDFu0hxM4vE4USoPwPZqaWeKUZnlXsjThGvPJZykP5
 Vkmgax0XnApHuggd74w==
X-Proofpoint-GUID: EFcFq7YxZlzqNT6QTGQliI399i-5TUv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300022
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/23/2026 7:30 PM, Tom Rini wrote:

> On Fri, Oct 23, 2026 at 01:40:17AM -0700, Abhilash V wrote:
>
>> Add support for loading the Config/Chip Data Table (CDT) from eMMC
>> during the Shikra SPL boot flow and registering it with QCLIB via
>> the interface table.
>>
>> Depends on:
>>
>>   - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/
>>
>> KR Sowmiya (2):
>>    cdt: enable CDT for Shikra SPL
>>    mach-snapdragon: Kconfig: add CDT configs
>>
>>   arch/arm/mach-snapdragon/Kconfig            |  47 +++++++++
>>   arch/arm/mach-snapdragon/board_spl.c        | 103 ++++++++++++++++++++
>>   arch/arm/mach-snapdragon/include/mach/spl.h |   1 +
>>   arch/arm/mach-snapdragon/qclib.c            |   8 ++
>>   board/qualcomm/shikra/spl-shikra.c          |  11 +++
>>   5 files changed, 170 insertions(+)
> This should be one patch, not two. Being two makes it harder to review
> if the Kconfig portion was done correctly or not given how the dummy /
> fallback code is written.

Addressed this comment in v3: 
https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/


Regards,
Abhilash V

