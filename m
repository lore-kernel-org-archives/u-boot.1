Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XastJvgw;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Phxa2nZW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fuplpjtQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F26A380F8B;
	Sun,  1 Nov 2026 10:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fd1P4qikTEdQ; Sun,  1 Nov 2026 10:40:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C03180CDE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793529656;
	b=AfQgOAvD1W0iayA7QraUOHrcm7OX5x53M9SAG1HPbQuuySdQiTo23KSNC7+FhE8iTGaH
	 eWKBWZFBivT37YYL0NIvMkEwqvg8IjF9/V4cAfRIEB6KYtd6lOmbueftXPxtFc6IfrjEK
	 kkCe6QfK6d0BAJNHJ5LD7kv55HKG0Dcu1oSlJJF7EixmBz8Ji/eQeqQ2OJIKJhoDcxq2e
	 g7oi6c8AZttwwGx/D5g/SAfI5AQAqhs4PYDyWvcHp8AvqRAn1Dc+gbWb0/8dQZ9LCHMI9
	 Wv9qHiAqVZNq6Xz7RXt+1dFutnzuzVrb+DlsDvpHgKYh0F7bCRBabPEaByuyyZoRZMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793529656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=;
	b=Ftm0G29pRUmQar1uzX00EocXgvsuXuNBncyHnh59rk0yF2w364fyJnBTxpLId3zj3N7K
	 Us1G9rAwtlBLHgUp9iukEql/Ud+0MrC22JX4Vmu/uyQX8KZawVKq6BoPRSwHSN7UUcn6V
	 U2C3z2Bj5GDULMql8vLhhk6kc49u6csrDgsr9ZG2xuHfWS2UzmcbigsIkpaOQX8t/3DDI
	 PDBrPRXdLe5CBqmFwexxl+K0bdi5BgjEj6N49yohmT1Nv0b6yjfU4/WONaw8XiseeKK9U
	 dStVPjt+2qVl+wM0XxswdrvC/7qxYahcYfl354wWbnMzDCmAXiivoaqg2Q1+2h/Zlzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793529656;
	bh=k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XastJvgwLMRSw4Kzbk3XUeYOok/kzRozp+VSM9O8z7jISJmUAFLjHx2dZtuZyqQ8n
	 /jYzM5ucwwtsWIEv611Dsqfe06x7/ORi/MfXSV9dlPURD+t1Dt70wnV1eNb5jDttRE
	 fXWf95uIFDHeWTuLeELl+iWCoGZnGSdVSjmM6sA5rpyTk0r5N17tdnAfSpo+UoUET8
	 XYDllnYsvFr1lxwgTMn59LYA6yCsOhsgzOirwsKdPdjm+0F21uesKbjyaw4M93n4ad
	 uwCgzy59sUP0hzkTiy9yXmMkVlvjJ0siH642QI1tts8HP2ZtsWvUKUZ4KMn+seRSS0
	 AoR4dl6Gjze8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C03180CDE;
	Sun,  1 Nov 2026 10:40:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 206662AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11EB74004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxEgn-H2l3vL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4E7C640042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793529654;
 b=CpY9ei4StQIuGZY9TH5hzjPsAbh7+l39331hihMESU0x/hShGiYzT0Nenza1EotXZFQ/
 ylhisIczHhBE7r1/LeOLie7w2OrLGpJ7SDzLtmTnsBiJTrSQzh1u1gtYmBlHk/hBXW0ii
 kNfkm2AOkbszuWFCYPwMNmWXOA4bElFMwNwXZw+wGt+G7+uk+ZAYIJxVzzd/5eDrzAWsj
 C3pEZcJeiPdWp7RWHiVuyvZNg3YCx8mIm8D/aO7OVmJpmwL2VcUSjhFj7Ch64HUMbYMHz
 Fbe2hTz5wZjSPlUw/bckToWUiNWoV9qj58hZ1wen5kKa8gke1iZtOjdQefo9xMV1LVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793529654;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=;
 b=KeIYTUpo8ln2K55l/L6F2FTMd3iGrIxINg8CrXVKVln5W8SZOJx6X2gndiBxBWjyZAKh
 T1KwxgDgAv/MB4cT5cfrtCO1VVI86VLLnL7aMuzcuFrdgf7ZGN3b7IEW/vMzXXRWuwzk6
 xCr3SUrl3TIqao/MEIGjdFK90o1vlvfrzpjNmAsWaohCmq3cDi8PSLZ3/vV6/P46nsftQ
 BtXB87EaumNdkzU00Uz5Yg3GUo55Cq9+cD2Kc6LefJP8Fk0fJmiitkDYGLR3gC/JElozC
 HrD4xfzShX242567VeHml/bKgoHChMCfFxvZA3DPrx5aAV9s4K0Vhww8JWjab8CkhcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Phxa2nZW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fuplpjtQ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Phxa2nZW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fuplpjtQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E7C640042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:40:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K496349730
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=; b=Phxa2nZWr3gop4+4
 lm8PdIX5K4CbjoiQB0d3o/mKAhl47TJl1hVFZ7gxakp8KmZB5FhGwkMG+RDCgvXx
 sNEADAKDjt0+rAInx7DADEVOP1dx7Fa1OWvsMxfKaDvK791nCj70gpCVTs+DnMRi
 0NMYGIVhim+j2+qwTKWP/+u70zc90OCaqjqcP6ik+iajZ/Ld1xVTgnsXwzTrc4Lt
 7yaDzawu+TzTb0Zx9DdfKxSc3EmkIGCAZTGF67GphlpPnro0IeW9qfXlPF/PzPBa
 IDrIEcrdl+nZX6rl6V7Yqx4YY/eGyqApZS7PioWmr11Df0x0QaQyLv+23FqO+vAA
 ZnByow==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkkjbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:40:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso5804577eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793529652; x=1794134452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=;
 b=fuplpjtQgj9DlMZotVa4iXz1hrbW4oootLSPwXGud5JgWnA7SaXQUnbhhwa6VpzhwJ
 0dlzMFnjcM2WtMidAH5pAJActRBBVjcpI4C/aQT0oGlAHxYAocZ+CLj3223IQCD5cDBs
 3sKclW8gih696xa/6Zc+YtXjiOJZ7EKP9qM8bwaf8+aIt6EQvTBVHENYC64VUt5YzN+e
 oyrYczRIagQzcEwTbC1W72LwVorgCJzGDvq+03JWBPHJkT3AcSwn+fFLx6uY1j1mtGoE
 Tm02LmTf+GWDkxaRnQWeIaoi/32QOL1EtWfIE5yPAGioc1uozykgnE9/+7hxv8yWYVSS
 P5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793529652; x=1794134452;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k4HPiRStK1GUeJdG06BAo4knKsXSQuN1kQ8Owl1e0AU=;
 b=GveZUpZor9F7ho7UnGWhIMP06Baa6DDIpBN1gC/GvktKiG+3NiXoUs+edfwhkcppID
 WqDgl4qj756p+/SyB2xR1ff2N/IxYQ51AKcy8R+9UdjmQ452ZZYT6wtwtlUFtet5jU8s
 +EnbrB0m/je5SGVLwJlbp5oRwVMQyx1/OR0vrDdmm3u+Y1yNJlnS62ZcBl2UbrlbrGf2
 hWkN81K4O07KttULCiarUD4OLnpTzuycDC/hBMC87OKCZ3fdxf4CfqR0iBpOoxCJWzCM
 omkXghEijoDSNeroS4115moDxX0xBpkqAdlcoEphCWsVpGHXzn5hyWxjvREPxMZufb4D
 E8oA==
X-Gm-Message-State: APuU4Z8kckU3YENUvTJs9o7knsmC5WjXTRCd30Lz5zZUzlwTtbBWsacD
 NVyFZrWBV4s8aoUNLIppVYYUs0jswhpllQmghQ7jI1EwGwUT8nsIFb13upkJbyd0aUPCe7NjgK6
 CJXss+K+VBBUjJOMlvI3JLMA4nePf+X1ZQHb45YHoGcDdLgciPGOFcSUP4AhsVENUJfew2gw=
X-Gm-Gg: AYBFou3+8MCRJ08dJgr23RmYrLE0gHuSXjec+emJR7umUAlfjktoKPJVSz1Zd9hD5OK
 eJnlUMrpp6KB+tCD36N4gp/AEPePbavSV0XQn2McYgmemz5uZpx/y9bqieUdXVRZ/nL9L+sNxI1
 WXEGMS54Y/onjVAcRhSyQNm9AgprFvQn72g+388+rXZJro0N2zZ5xKthkClJA+2KSac47GZjCJL
 k/oH7sbIj7/Qklk5rsWX0RInY5vkdUliBUw83dVt0At2OyBPI8E6Osv4iJElPnVCX3tav3caF71
 ZEpEPF5sBNF866wl9i4jpY2mJqzzC0yDN41RRtgtKgyNJ1Y7MqBQ0AOZCe3N3ZHDMJywauiLANV
 /ZDG2CU6+8HBFCkSkh73qkPRGYMLDDhHWZAKeotWip06fkIgzVo5uq6OwPyvDLGGT00wIAk1Egs
 teUOznp9Ew
X-Received: by 2002:a05:693c:69c3:b0:369:d84e:eba5 with SMTP id
 5a478bee46e88-36a424020dfmr9991091eec.11.1793529651716; 
 Sun, 01 Nov 2026 02:40:51 -0800 (PST)
X-Received: by 2002:a05:693c:69c3:b0:369:d84e:eba5 with SMTP id
 5a478bee46e88-36a424020dfmr9991045eec.11.1793529651127; 
 Sun, 01 Nov 2026 02:40:51 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm30761819eec.22.2026.11.01.02.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:40:50 -0800 (PST)
Message-ID: <df45aef5-5172-4d85-82e6-331b5594eb5a@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 16:10:44 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] doc: qualcomm: Add snagboot mode documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
 <20261021175256.GF3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021175256.GF3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DjjxMJRhptWqAoiOo1p7Duu_bvLulNTL
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae71734 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=BOZe2ROyF-bS_ukP968A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfX3GKOpzm/CzG8
 Qt9SSiJnmcAtNBPOIJQWAOz7Y+8cemIPaet2wphvPhhpPz8xNBKd4LcuNRsXgGaQZxxEmMa04n8
 T/1iJIs/TxtdTNEHTzkIPZbhdkoyk5c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfX28FKZIn4TuKx
 qNTE0tglcp/3EF9vPEXqvhHPMhwWODJNdAWzPyDp3zdS52ZLV0vdgtwBZWq/4NR8AEqZpc6vPfu
 kzjKaAgycIv1AcwHDuAfRAhRigs2w2MsLRiD7Nf1P6t9x3WAGj4Mf36LrybXn1/xD9auaI7R+iF
 hAvhQsxbCYlNvk4MttCXg5wxKGIEh329vEkuXUBw2AysQyD3pbHVnryaATiUBO94+GHu4NDk4ii
 qeEZWcaZWQyxGs9b0OU7bdye/mNUnQN1/z9jkT6oDczVXT/Waimo92Z0eesqq/524I2LmeS3KTP
 +hNbZ4WFb6TT4ZZ/1luyeNLQYYxucSuyPKcsnrvezWCsQs1rdWIclFi19zrWCMFlV5r/aXjBUdR
 2kC3Ej6clSSVDNCfM3PV77nouJSandm3/Js4tAXxwHYzfgLnsx9YShaDUPwu+Nb2KxoZNTkFEb0
 1jMcdapjFsaD159vLhw==
X-Proofpoint-ORIG-GUID: DjjxMJRhptWqAoiOo1p7Duu_bvLulNTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010042
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

Hi Tom,

On 10/21/2026 11:22 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:27PM +0530, Balaji Selvanathan wrote:
>
>> Document how to build and sign U-Boot for snagboot mode on Qualcomm
>> platforms, using Lemans-EVK as the example, and how to add a snagboot
>> defconfig for another board using the qcom-snagboot.config fragment.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> [snip]
>> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
>> new file mode 100644
>> index 00000000000..716d88b2ba2
>> --- /dev/null
>> +++ b/doc/board/qualcomm/snagboot.rst
>> @@ -0,0 +1,80 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Snagboot Mode for Qualcomm Platforms
>> +=====================================
> The second line is too long, which means you didn't run this through CI
> or build docs with warnings-as-errors, as CI does.

Corrected this.

Regards,

Balaji

>
