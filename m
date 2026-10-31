Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6D606A330
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k9/oDy3+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o9pMVKtO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cREMV0B0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD3C780BF3;
	Sat, 31 Oct 2026 15:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5RHh-EtxRac; Sat, 31 Oct 2026 15:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F328B80BFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793458997;
	b=AlLUO6LDKjsPZGdiyMEzrnKNaAxSAA7ktPiltGkMjrkgqanM54Y7n2ymVnd4e0i3nsuw
	 q1xLZ/dlH6GZRMyphadL6bVcPc4iJ61dZ08R+XZlVujiSVPlrb5m/uy+xumamzXFp7xZZ
	 Yo4M3qtjdDkCfPm/YnBnxXlIfxj2Jnb7rfaLkHtefIDv8RA3KCatEZRBsPaYzN9wqc/Uc
	 dp7dOT/oWkMM4v01xNuzAKW4ricCghlOvu9OV6U09jZ5ajfhykcEEETB9BR0W0puUoaF2
	 gBrZWyUSsK/GHJmV/eDOnSSgf/Pbkix6PhQY4/0+xO5hVL7Wy7Db7zLqVZq9eKMYh5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793458997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=;
	b=hDQxDvsE0MR4DkazeylhyOO5nX1tXd0M7X51RxQK8woBBo5ZDcoPp048/oUCLhrJBioo
	 qGuAmI9coUtZlTAWrDR/MOITyLIvNlXzS0ViC3olUgISlGEat0GxXMQwRQsMsQkZ1H0/w
	 c3lLcWkGYhirzoHBrJgYUvqkqYacYIWsqF+twCCVCa5Dai+tiS2fHrQoNWuP1eP6yzcSr
	 15frtKdCe7hSGnt9VgqeT8ZySql545IIU+qgQQN78O4uwW7vgUpaLihtnA3hiB2sE2QgJ
	 uNj4nHSJiL2nIyPxTL3jmeKlnue9mc6EvtvtU7SMhiwCpz+yCYxnWIe8pawRvL833ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793458997;
	bh=HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k9/oDy3+Mj8qpkOXKnCte55kSePBajOxmnil+Fz1VkJlEzShtodUGxitobD94D0mN
	 f1qt556XjjyhATqu98yf08IzQa3yqtWrtQ22qPK0nVtOqOJrMBdltdW11XGBjrCc8h
	 ab2ENRfnbYlrXQERT2mxULm50VMOGy476+Y7O8H0U/5youkeDOpAvTb57/zazaGESG
	 esTiWEkLzf8/TutBvJDRNZoLc5lCSCQX+mqiPKPa9N5fO8DJyfViIjdaxPKJJiJ3O8
	 iVqYhXBSSW2AGS1FmqS2Ull3RMKVlFl5kY5LWJdxn69SMOzo9zfsx4lvCodimVYA5k
	 D85oIyV54Crng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F328B80BFB;
	Sat, 31 Oct 2026 15:03:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0AB5476
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0C0F4043F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKNOOv0rvF-D for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 15:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85BCF404DC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793458995;
 b=H8MUv/zyHvvzHb/ExbxQN+LH16wo8Brj2iWgFpH5VNTnnunQ/JZR+yv7X2NTa4nU93g5
 JPSFb3lXIj+0ApPNEIJzOtGwMa7NOUxp43JihAZi0q46AB7pWCC77B+DukT9DMp0/w9oJ
 Lhc7RKydeKE+Bz7daaMMhRP2msEO2wxf6SnqHCFL+KogWeijAhazTSzNsJMKuEbBw+EvH
 OLWbhqQMwl1GWu3IW1H6jHR6tCFuAbzOWPVmKWcL4RdScRkTjn4LtkJ0lS1yGlpjaXqAS
 jpos+yYZpvU6M2dHfm6sQfLKYmREEsM4hnUdNruLWS9Db49+soxALHv+cx00+S4scew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793458995;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=;
 b=h/UZnRsdrkzD3VLxdRsrvRSE6P2fGi8HDfuIJXdDXtq6AKHWViRPKbeqN3Rf3hQlRMxV
 IKiuCktfUnO7233lDBWLKAdAOGa/QevF7ahEzTvUU4oNcohPRScGxARNNg6LTw04eays6
 9RLOd/DZ4YTVPzZVqnMWe0Pw0rW2mcz5ubrrRrqVZCp8P/uLklJ/odQ23sRhFm6C9i3wf
 +YB7QhiZ02cAUeJMQi/6dXvd4tEcPatbmcrOBk48BA5hvyvn2osRqD+6Ei216cJMzA7nM
 dv3+F2QwK5VY/EUDjgiednJ2rSJoj09MuvhUOUq7mQ09pl1La8pmum6zFaM+dcFQeBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=o9pMVKtO; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cREMV0B0; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o9pMVKtO; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cREMV0B0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85BCF404DC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:03:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VCxxqx2787798
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=; b=o9pMVKtOWQoHWMjp
 b9wokxT9VTFNBeg2ObBm+DMqeOL//WsemvhaauTed4BwanNqUgO/aHJ28VCL3hps
 J06jT2cCyQMfCHlSN7GYbM/QFW+2UKJAjroyKsNxKPkt80CuZAXmp6yhnktEGI5M
 kXSDX68DMtVZgTN0HOK+OWJtWgdIiVBqYOlqhtEfWQ65/WWGVPO/8KXS0bXgn16h
 jbcln42MT35VX1yqtkuEH/GCeg6TNEHOxgzJwwC9lDnnb+8ZGjZ9oqE8QfYS9dSg
 cH0XjnxMDRxPfWPbugUxQLXaC36ISkIDS3EcR0QzAEtftlDqNeBnbWyOOWSjEUxu
 wbLVwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7wxhd4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 15:03:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so3211280eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793458991; x=1794063791;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=;
 b=cREMV0B0omB66J0OdqMPxe9FwJl9CBgXh6uaMA1Rp8rAcNv+7holcrg718e7vGnHGz
 CxoEZ2kX5VTQzBKw0dnwA7+hNATWJHj1LSByrgkCpAs5o+4eCjDPGgDz3bfH3k5/O4ED
 0AXOBCqlRuc59NqiuDHumSJsKUEsA1WgETZ3nHYmqZ5PJrIF2DHOCHSE0aK130JOfRfX
 wu41JPb3t+DK7n2uH40WPblT3X7pGfckZ3Gykp3ffrzuJNdE17gbdjb2l7ZvGkJGIUCZ
 eJZgIFI+ro9dXuM8a8m5lm7D/q7/hLTByVGVvx1vWSYrcvmGUYUqJzp3aZHhBYVZEVVR
 854g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458991; x=1794063791;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYzlhAJGg9/vLSy859XP3acGYPSooVlBfwQlW7yh/z0=;
 b=eUt/q8SI8Gvm7a3ScdDDTeyrTAB8PN3XR7FiS/b0QGOm9za8N77ApmDRDQM8Xskn+d
 FpIeZhARA14IcfvW84qZ/IOU1RebjjtgVdAdhafZuim5laqBofSVarjejt7Cvh14XiCM
 5lVa5iKBKqDSmwpujOUbNbs83jhNBeJseptCWeZgAathjeKYgtgaCIU0MUtCpfPhopW3
 /JrBdw8IQHAKN20ZhMcbnPQjBkTM8rPpvOTQnSotZYWjlm6Dwp4DcN9OEgjxX6wSUFo1
 7uG6GhAUS6Di0B5LHKXN0bTZTg1KQMZxq+JAoHY7LvAHIqWMcC0hO0Jf6AytolEpcFbu
 gepg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7ahc5e+XDNsw+hw+A7NDnSOj+Y1L/JClKveiiPI/AboAtVmBmVCSoY6TmEBtdU5PpGdCm0go=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI5s9GMCh34HC9DP9uq6GLWDm36IZzhHDmhaGlu1pmU94Vx/m3i
 f5NDTQUIsd1GNFUPnwgjlXR9+EreDNRBjCcojiqOYZ+DBetagiNe8KXDRY+9YCDPacyDPta9fZ5
 hEniSHFiLJroHYJ54iZAnR/N5Pj8fwhbbpait1Ee2MLF9KCIpGl/ihFTnOJK2DJFlDR6CCG8=
X-Gm-Gg: AYBFou2rZDoCzIgzhSH4m3yQCnyzUNIlAdag+kZpONdmNwlW3Q0VZiV8KF8oz4Hjxhc
 Go0xBis60PxG15VCiXLkk27CrCJ7EoK5Ce11YRXhM+bpivflYz5qKq+9Wx+kI2trQwqkbp5iFs3
 hxxu3fk/VzZpepeeQCQW2ScSlO7YyOYkEccGhFDOhJWzhq9OMGRIRpcZlzLac8w7h+i+nwykYEP
 scZsyScnV1ADLKG73HFMXVtOsqLk66OMSy3cVENvaoB5thLg0tHLcTENayj+VSby+nQdudAFIsQ
 kCbXWiaqN/7vYmpMZXuTk4rb60s0YQ7+F11oocvW2MaxdgiAMfCgzexTPQCAqiw6n/grpWwG1FL
 Dze17XDNbdSkFA14yx9g0pjcfXhVhDqYd5S1ve6xrL+Wvg0enKIxTWxiSt6ArKzKcHhE2ot3dNS
 JL9RQmxA==
X-Received: by 2002:a05:693c:83dc:10b0:365:d42a:f415 with SMTP id
 5a478bee46e88-36a423454b2mr8814961eec.12.1793458991337; 
 Sat, 31 Oct 2026 08:03:11 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:10b0:365:d42a:f415 with SMTP id
 5a478bee46e88-36a423454b2mr8814911eec.12.1793458990590; 
 Sat, 31 Oct 2026 08:03:10 -0700 (PDT)
Received: from [192.168.1.10] ([106.222.221.214])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a426681aesm22538849eec.1.2026.10.31.08.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 08:03:10 -0700 (PDT)
Message-ID: <bd648ed6-77db-4c9b-95b0-346587971d39@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 20:33:04 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dK9UQYNXIdCHDDdRbgvSNGKUgBvuH-QM
X-Proofpoint-ORIG-GUID: dK9UQYNXIdCHDDdRbgvSNGKUgBvuH-QM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA1OSBTYWx0ZWRfX2QBRMMbOnCVu
 sAERWtl8PqL3mINaMrXOvJ4ZZ86CB+Rkw3I3iv79bS/hRYY7My6dZ1WiXUwAlcRBSm3eBW1tjQr
 K5Z8YMiHMNJ9c99uSyF6R5up3adst7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA1OSBTYWx0ZWRfXzs6pn3fHH/vQ
 lWFpmE0u5NsHzUZd73nFPjWVnnOpJjPO+pxCx2Lj8Tg7NPodOnwVccZWZiKbqCdTMWzGsz2QELo
 6psx/Hyu1DZiZM2eV2585Tj3nt4j3GlmVuPb58qDiVGDOCSJ7i1RH+bVfJFJRhwuz/sl0k08ugB
 NKVwVJq+qiQB2oblGKu+lt9EgAhX2UGdf0ppTShZcmBUhYbzFbfO1f+pmXgF6w48SvOngtcMB6U
 61vDuNb/4vgFRFVPzZZX1SaHviK5EPmScU46A4pbOomxGDlTymkMm0rC3ENG/lObiDFf9MunBEN
 c1n51+xIgMR2xc4qq+sPzyXyup7UL7cW9ysl7GA7dcdIPf3tJ0aU0+raS5spxFl4AGQ54lsnFxg
 EOnV6OMC1zULGa8RemaLiKdm5vWAGJuNVeJHAW7bBNVxE9jPEVzTOZa/jqUb3WSMQaMvCDJRArE
 tcZDVQU9d7f8rRxnx2A==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6ae60330 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=whQzMj8v2bmjbdO/cJWdRQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yt3rh-OW4mLIMXkGogcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310059
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/30/2026 7:27 PM, Igor Opaniuk wrote:
> SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
> after every command. msm_sdhci has set it since the driver was added
> for APQ8016, back when it only did PIO; the commit gives no reason for
> it, and the Linux sdhci-msm driver has no such delay.
>
> The delay is invisible for large reads but dominates small ones. A
> multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
> on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
> about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
> chunks, spent most of its time in udelay(). On the Arduino UNO Q,
> reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
> (dd if=/dev/sdX of=/dev/null bs=4M count=256):
>
>                       host throughput   time in eMMC reads (10.6k reads)
>    with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
>    without            201 MB/s           4.5 s (~0.4 ms per read)
>
> A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.
>
> Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.
>
> Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
> - on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
>    the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
>    computes from the same blocks, and Linux boots from the eMMC;
> - with the "qcom: Enable HS200/HS400 eMMC modes" series and the
>    mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
>    the ums numbers above, same CRC32 check and Linux boot.
> Not tested on v4 controllers or on the boards that use the driver in
> PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Drop the 1 ms delay msm_sdhci adds after every SD command. It costs
> 2 ms per multi-block read, which capped ums on an Arduino UNO Q at
> 46 MB/s; without it the same read runs at 201 MB/s.
>
> Testing on APQ8016/APQ8096 (PIO mode) would be welcome.
> ---
>   drivers/mmc/msm_sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 9cc11a5e269..ab217393a54 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -198,7 +198,7 @@ static int msm_sdc_probe(struct udevice *dev)
>   		udelay(200);
>   	}
>   
> -	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
> +	host->quirks = SDHCI_QUIRK_BROKEN_R1B;
>   
>   	host->max_clk = 0;
>   
>
> ---
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
> change-id: 20261030-msm-sdhci-wait-send-cmd-4383f2792022
>
> Best regards,

Reviewed-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

