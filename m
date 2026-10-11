Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB1FCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C7CD80F4C;
	Sun, 11 Oct 2026 10:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofwP9LrHM8wX; Sun, 11 Oct 2026 10:24:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51D1D80EDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791714256;
	b=J/s4Lu+2y8KYnZdzluwfKrBTe5JqCgGmqdqKdImwuNHqmlTTTxxJnEpCWMJA4ZxjXdmk
	 YSgUR0WktS7yPHbxALevmKzL7jarJc+qL3CudzfezjLFIBp3JMD6rjskTEjZiCl2iTvmK
	 WGPg/UHa2JScsBttgv+uGRR4OJe7qvnUdMZh9uVhsoC1L4SbQMuvmiYALb4V0qoMtU6wP
	 mdCXT+AgXIMdNnD9Q5TJY9Y+kqsHu7Ql8K8pNxZ30tHqVx96c7Ul944lQNk5vaK73aZNx
	 dhtq1Qur0eL5LthI8rUTCRl1OByaK7ww9xIi6vhyJ4Y7Lrk8Zw/V1dd7/Tai61H+i7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791714256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=;
	b=Hlo+rDasbQPGbTgOqjfmEkvvnY+B0E7UJoE2SmJuzPyM7CYC5LsTRNEN6UONvZOM9Z57
	 TeAU2smUmNG4iX/Ihj2PZZlTZyTbSLtWRUVIXumiSAv9fNqOmNPz16KFAkGpa3cQmhpZX
	 l7OHPygTCLrBtEfrlbbbgdFUO4ABz6xskrCKg/9h/7hHHNNNCBPw+TghtXHc35oqQBYUE
	 bEBobiggboOcEhpv1GAdv4niaU5AteyylrzGrP7rwLhAl6LW45Y1FRJFmAPfdf1hD/FSf
	 1cdBZQcR/N92nWkHnGD2gemtbB3JM/YrITINbvPXncVzKBIJFYrv6BN7ZGDzGtHNGWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OUvxAzon;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ArJ0d74r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791714256;
	bh=rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyhRQOIJdIqaWS3OfFJeM//gje7eCDlTGOajrHPI32WOQKHCSIj87YwK172srJQgq
	 biwv3sg0cMWZPO7wC7uoSsabTG7kpCKBb8LJUkO98AoNuYsdpn8LhwRohBcbZclJGc
	 a3FOUp0Rk8stzqVkNqzyYs5bELDMN0zcpvSpPWyV5w7wILquVNJoonjIdxsA56UMBJ
	 1+ReRhhbaWtA/v9JudDqumhsD4PXvJc2nWLZRhFkqk+bB/kuQ963oryQ9oaMF2VJuG
	 I3CT1d1gpSkhORAgg/Js4HJyRjAg6afNDHUbZOCZbRgQIlyLcZ/TI5oAW3DTwCOrhQ
	 +SppP7eF35vRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D1D80EDF;
	Sun, 11 Oct 2026 10:24:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFF96235
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2FFE80DF5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYcxJPVBMtlo for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6EC7580EDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791714254;
 b=RGxbjuOCYWuPjCs07kSR5ZCmhALpisbzaDBq7jzwa80WKjpchFOLuJTTxoWyogd7cCqg
 Gv7aye/b+Ceh2PITrOcG2UzctMd1FOngl152rxi0SA3yIZrvggOBJwgc78/wOy0GLomXD
 j4XM4jnrMzFdgUSgzhJJLf1PLBpstfADcdA72MTKuSh5Fb4pzlt91X7ISEdGT8KqkIHRe
 A9Izz1SPgM1g/QdE7D0wolE+m7LCTDokg7IebDFq9f7NbtGTWBNTRU31Ih1LntZkHjMjh
 1YWa4xi5l8JP5QQ15AJHBjGMyT0EcqLHmaKOiJvPsBaD3VXChPsGfD4igDJC39UFLIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791714254;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=;
 b=gALkGDrDsCKhNSe67Mkcd0fueWHfxIBLjqDdniqJjb8LQJ6JRLcfdQF/VNCXyp/n19Y6
 Yh4bFTXv0ASyALSmKXKCOxDTiuUj6rpIxAlK0db+FqiNRQG8nCy2G8lq2uUtEGvDyZcHf
 dQa21MfTHuwfVy8QRXE4wXHbNRPbmzB5P7O+GaRS7UPIy6l5oJd13TNlIMO3NZkDndCKd
 7JzPpCp39ZDNyBrADcsn0kwcAMxZvnQuCYCW22lAwNvuDZtgLu+Wyw6BeoJlaU9nsdjwS
 SzyQ8XrdVOt0a6IzP+lzVDQaVlHrG/ks3CnGdd3EfMPojKeuF4woU2s0eAZAh05hUVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OUvxAzon; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ArJ0d74r; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OUvxAzon; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ArJ0d74r
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EC7580EDF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:24:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85Hvb1512952
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=; b=OUvxAzonsHwHe+NC
 fbGUANbmZBvUXJcjHWDKHwmRlqxb7T0+L3qDKl/GOxloQevq/nPyteiS9JsH8K1U
 Hv1mSV0F4SP+AWY8VQ1xKlkNQ0n2sXDALYVxg5u2RxgNA5OBkkLotH77YUIsJ4pr
 /RDnxCZ3Sbnb1btlUx2JR1Gzfsk30jLec7gp9GZA2AUEwTLwlda92ua4y1CgpWzq
 MhkpnLhDvHe6T6SeAnFLrhhf2ooZvwjcdcvjnmWbL6PnY1Ycc48T68uNSK1hDehL
 HyIMycNUPH9eAQdcb4v17foflQtU3Z3zc+ErORI8RhKbjfhxY4hHlMp6mDUi9Auy
 tzTf6A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjjq7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:24:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so1468913c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791714250; x=1792319050;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=;
 b=ArJ0d74rKiVt2CrmM1luu3yFXDy2hXvw0XUnaijG3hcAI+EXtGnhSLFVflqrFZy8Om
 bfcgLKOmThpxkkXVxOrmWGcNu/eZxS2VsvDWZD34/8Do7hUHFhKEMlJJgd7RwArdZJyY
 6IIbPz8ohEmOYN2thBdKoiNQZjtncxnPM8Jy1e78oYdnun5Zn0dkL2efjC26zEtKyZYu
 gCEJVBogM/18bKWtxFdEl0C4/zxXDMFRwsUu1jO5Ira4WYJwq1xP0HGV98YJKKw0Sy19
 vZBC6hkV4DXa8sT/FJvWRW5SEUI/qKp00l+jsrAMxrGKRSboaJYQ8YUAsx8ji7sZzW1y
 hlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791714250; x=1792319050;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rczGhrMzVAiw4e7dsrVvoL43vaxXhaMw6BzegyvReWY=;
 b=2nv3/u3nZp4WQjpEoPjvLGBufNUw8qe+QFr15pCuDe48k9VldW0VDap4jI9v7DpTpY
 72ZvIy9WcIGxCg50VzCd+ED81pgORBnV78h+g7uYEBUZ9qgMNE6B8ixpqEnXgp03nJ9U
 8FJx9t+g7Lm7s3ijjWDorF0LQK+AoE8YV8XAyu7B8JWE/FnB5ReGGMOGhU7WVrKQkZ6+
 ISt4LDUGK6v0SszTPt/p2YAmYqijxAACmOU45U8TeL2Hc4qiGbneoDqGgZLv+yCNbN/L
 rMFLrCvege1lDATChuv4kSwDu7TIb1y/Y0JsRU+lilQNbTvwAuimWSPQuk4Umeng9xBo
 i+6g==
X-Forwarded-Encrypted: i=1;
 AKwUvByh0U/8oxUL+Hv9Zruy84Fm4YhoWc4NxjiSZBLgfVf8a90tI93cAwY1eWpGsblsgRWpnoo2sDg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJMB5z17N/idALVK7boGcoWVt7sbkjC8T7Hzi3qEtt11vxARsl+
 mPNIG/nPn9mQb7EzNl7762TwV7COG6potee2xgvHRYZCUE0Fs9DzS/IbSVDrCR5mkf6W4keTXwu
 JsEb2hUpr5jnQN08TANqMo/n6pfli6U0vEsWzZA9qFz4r8DON+/gP2GcTdjVa1++Rbq9Mn/ixV/
 aksmQ=
X-Gm-Gg: AYBFou1SEK8rU6khoXLuTnJgBJs0kFXdQ6sgHsd9HyWS1nrOxjVD8O0eQX7ozEJtcB1
 GuSSSu4g6EtGAh5DbMGN3NQya4q+pg+BtCTVYYn3W588tH6wk4DQe2ZQCA41TEu6Nd07/HFh6sB
 Fcn0w2lgEjt8x0GErR1y5bVXftBGZXP9SK2jLI7tXLywP82vPdo3cDAJBazaliVhRFjinUm68yi
 jarfcvjZAj6fTSs+8ls1eRbFP8T4hrl8xl/cri97rcNuq0KFOXG4EtXLF/RKqAiO+GPul/E3tTV
 0mq7zIbcT1PON6Pr9XoJNJR2aapFc5NKO9SIa3JYxO9vSn1PNhTXnr4bt5dJUBl10///+n49msh
 fsl2kDL+VX5vAg9nLFsZS1Ii27fGuwMSp6Q==
X-Received: by 2002:a05:701b:2806:b0:151:2e62:fe6d with SMTP id
 a92af1059eb24-16a5bf3f985mr9534884c88.22.1791714250554; 
 Sun, 11 Oct 2026 03:24:10 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:151:2e62:fe6d with SMTP id
 a92af1059eb24-16a5bf3f985mr9534861c88.22.1791714249933; 
 Sun, 11 Oct 2026 03:24:09 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.24.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm19160323c88.4.2026.10.11.03.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 03:24:09 -0700 (PDT)
Message-ID: <51331c05-ccd3-4d57-9473-7d79203acf01@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 15:54:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: Rename qcs9100 defconfig to lemans defconfig
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 quic_varada@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0MSBTYWx0ZWRfX20HZo/ujYLZX
 f3otfauc78evhoKJ0edhFhZqVrxcCKp/WL6QOP7iQpMUcE4U/Br9Xk9hsOgkMHN611GpSjzJIW5
 icKDzmxAF4W38tceat0iKt3cxCHQFt7by2IdM+SvAaasmKyvZ4OV39TAF474DPt6EuhrCWFd4Oj
 vIP8y/B7jFvYvyI9nZuDpuF1H/NpWYuTSwgtaOzBWnMvOKy7zpg9WrLD+a27ks65WZhjIaMS2qr
 L/+bFSJ9q+/D+anSXoJ9HAK0uO2GgsaOEpgXOYbiWzwZKrX6E5GY87wlmVhe7G4ZYSFV4R+zBZX
 tkugdbXa66ftSak2uSW+vlE5QB4h6lCdv5ClxsiIInZUYGgLSp0cBS/EPkq2DfZR31XYH9x1pwR
 92R00+5O4qIBnuY49TxPcc7UPqcD+GigZiwBVRY9W5Hpps7puFvkBGOAh3ROoFJNxzQrkZ/E5Zv
 6cfwS/rufbETXOeVbtg==
X-Proofpoint-ORIG-GUID: GW1FPHj1xEc86y0UI7LHmx_R0KY_qBwK
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acb63cb cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=pwXowC3vr/RyD1rplAmAbg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ooB5F5pOVlu2jGBBEj0A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: GW1FPHj1xEc86y0UI7LHmx_R0KY_qBwK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0MSBTYWx0ZWRfX9ZSz1Y/uxGOL
 fc9qjZAMNZBKO30fi61COt0Rbckni2aqOQkzQHqJHofGVIOTYds57pih1EKkLO0JSZXWlJUkwGZ
 hWB6joq8oP99RPX6bnQdWTAvZBud5VQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110041
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

Hi Aswin,

On 10/9/2026 5:29 PM, Aswin Murugan wrote:
> Lemans EVK is an open evaluation board based on the QCS9100 SoC and
> serves as the default reference platform for the QCS9100 family.
>
> The existing qcom_qcs9100_defconfig currently targets the
> qcs9100-ride-r3 board. Rename it to qcom_lemans_defconfig and update
> it to select the lemans-evk device tree instead.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Change in v2:
> 	Updated the commit msg
>
> Link to v1 - https://lore.kernel.org/u-boot/20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com/
> ---
>   configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>   rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)
>
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_lemans_defconfig
> similarity index 91%
> rename from configs/qcom_qcs9100_defconfig
> rename to configs/qcom_lemans_defconfig
> index 1cc04cb96bd..1710e317fc0 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_lemans_defconfig
> @@ -9,7 +9,7 @@
>   CONFIG_TEXT_BASE=0xaf000000
>   CONFIG_QCOM_GENERATE_MBN=y
>   CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
> -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
>   CONFIG_ENV_IS_IN_SCSI=y
>   CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>   # CONFIG_ENV_IS_DEFAULT is not set
