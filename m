Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85241606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DnEFrhxC;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZOB+26tf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CigHC2my
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FA9680FFD;
	Sun, 15 Nov 2026 11:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RTRNcxdKA5KN; Sun, 15 Nov 2026 11:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82E6A80F30
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794741610;
	b=fR313INmR3u8/pSoA4V0Rtz8m1NXAEPVlRVzrbAywZCKgXqOjtQO85eYD4fseWxV/uyb
	 uxaKpuEpGddo5BpCpVCI4tk4tlR9RebzHvrVxJj2tNhuKKLl1gRSzNSzuVwmordpC85lK
	 iSDy4MxqvdO35Hr0b4PzeySlkt4TgKbx6OkNVKoVTY2V6TfoUA2iPEV12oEoQ4jaqF4wo
	 PE5nrSkj7CSVQQPrhcBPzhmnEeTu6o69PTGjTphENJOCfBroUjuIQimuhQdsPTFaRqwRO
	 EzWcWs3jqDNdvOWmpVgrz+2asPBHturbzB+4xjsWr1e+mEgJZ1arnNWRPtecm+CLoJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794741610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NSysrtPjJXF1QtgTwpeHOSj3Vod+jEE9fy2YMBlD6Kc=;
	b=WE4BlQAZsCSPkjUGncnZFLPuNKTkRkQELLhxitxRsiAd8yhOjVPWb1VtIz8+jld1EDWG
	 mPVLkhy1GZyfdWKS+JVCqAB20ctbaK4pRBq9bSmkVsZXU4r/0cx7qBMSJPSZoMgxAKrI5
	 mSPfx1trcWcz8G5Y/TnMLifrxBwYHUDGBrRhozT5RH+IUDf8N9NyTpmgJ4ZmsTSQhOZYL
	 AobwX15K31J9Ftto5SmGC2hXKeYq2O5O/1tW+anOoJ0fuX2wpyy0WG6KtHEBl3xUHD305
	 1cxhSChBZmQ8erdx6x8p3kN04EPbp/KOYyzkt+1A4YWILeQasFV/J4ZNWdVPfrfIOkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794741610;
	bh=NSysrtPjJXF1QtgTwpeHOSj3Vod+jEE9fy2YMBlD6Kc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnEFrhxCVfgHfUJm+abg0tvXdXI+WJjuOOdLQ0zeYpef8oUrNuvaKJyzKVH34JHO3
	 gk/KtE/1F4+z2EAvYTLcpmlrvYMfKiiBIadM6IaCZSgHEt3DLXjztmUBzRU3E9O8Ju
	 AIx3cid68yoF2tWNQ5AhdxJOST+7dtn0ndPfghgN4ql/O9NyNwcTa4i5nlX/JutgKE
	 32wJt7F0KQz5WDER8GbYawhRsTr6lVFbvkuoMKbCirwlQ2l7HG9nn4BuMGP2TbQCRV
	 tqy6D553t3qV79YKwo4zk51jti35WfY/K1hYWtDrJ4PhCgeCjAmQUlsEHHaCtFJaz/
	 rHT2O5tCmUPZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82E6A80F30;
	Sun, 15 Nov 2026 11:20:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 715582E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DADF40068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HfiszbvP_Unw for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5FE6040061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZOB+26tf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CigHC2my
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FE6040061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:20:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7wFiY1195813
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NSysrtPjJXF1QtgTwpeHOSj3Vod+jEE9fy2YMBlD6Kc=; b=ZOB+26tfihL8iwWK
 9bpLbkmx2QdiwCZaANFAXX1GXxApKLuxrirdcd5LAqLSv4SwYyUSDoztiBSczofU
 NI6Bt+vn+z9dqtV2gbO81L0f60lCUg1P+Dmgft14bg71e4PEN07G8T1WUouaLCNM
 LlG8W+ZLVV5CoK/auFtJDxAiluo6eTAcqp5rqkPEZ6Eqq6/t15QeBIMpetRuFUiv
 1o98XTjdq0jzqcgiyXDHbE5iRRWfsgttXe3KISs88EESHzYVnRWYPhIyQ8sSdFSk
 Ki7+gtRSSWWNFTxrJ6RTVM+PNgfbDf9Bp/WQy3NdIC2w2yzw1XEwafI7+cxeHGFc
 6EK0sQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhju11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:20:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37549877380so3442925eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794741604; x=1795346404;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NSysrtPjJXF1QtgTwpeHOSj3Vod+jEE9fy2YMBlD6Kc=;
 b=CigHC2myadkrvMYpODy33zi7nr2+Isa3H4O0iTxdaunx8M5g3E9uPsTC8U26ekZNyR
 uY2I8cS2Qptbgn25Gkl0oTQJGVxlF/l6Gf9ekkZu+KIsdM/TnPVMZgcY/E5bk9g9Ibv1
 fi5oeysvT+oo4vIeSO+mdELZHT5iRvsekZXrxgGbcf77irR5yWQzcSBKXFM/utnsKVTH
 lZDLAiPQJsmkSQAo1Xbrw8X5LsEd7SQ9BFawFOpQYOxslvsiXC5HMCDYMhWiJj2OuQgc
 kKVYBO+srxFF68Xu+Buu8Pe19/dWq7co5DIuBWU28lkxsnFyKntvm8+fkJZ5j3cagpFV
 F8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741604; x=1795346404;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NSysrtPjJXF1QtgTwpeHOSj3Vod+jEE9fy2YMBlD6Kc=;
 b=ZvC0wGAQJ6WUQk3+qOuWACJ9xMuI6K1OOjYJSYDFpzfXZ6mZQ/m5A8Y2UZD3kufSkk
 WeEB/Dbp5eAtzF+NyZGgbh4CqFdq4Hn+nHGraFeLMNFIHwiqN0Vc2A78Zy5/JVeLbRHM
 HvBeXg3FXmWAHVDhU5A1Sqao/pLqTKfX5qYvgSw966sKzSrzY0q2oO1bQsLLZVpS/rq5
 GtdnBUs+SiVnNpnDgjvzMWSoWrg+1itP+eu4BF0BEDkaAFM9Nf59sXtNlF7Ci3VfjL1C
 2aAX0f5K/y8TEjxMrn2QEK2u8mkjPFiQnf8udRSgxq1jdS89+f/neH3eR3z4Uaziyg5j
 PuFw==
X-Forwarded-Encrypted: i=1;
 AL+hErHilklGvXOOZ0ZlUf0nIQXWtmwiqYGXQVU/fW7+g5F3OP28bEAfRTAcfz72pZadt5gqLtnnwPQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+UsaToJvyODTmNyyc77VAVzpchKqLQIbKOFeeTibbuQVWGEyAW
 AH9bAbkJZ7yqOHls0L5/grGT7gAECZg0AKk8hVv6IDs/GXZ0DFnMDoznTsUj7H/ZsP7Js4n/Tzf
 zT4Fg/ju+QLB9T3/+QkBJItVok7f5draW6mDQAaeteSPzEfbSC7at9a158M2/tiChL8R9ny4=
X-Gm-Gg: AYBFou3NuO/lw29/ZNKG4PlSayG6xUzyRx5m1DI4YTB8k2llu8Qw2m+2N7LyRGQgkTE
 rbHz0IPFXHf1HBOO7ccoKLhorm/yHrTMGF7cmZ0zhl8FEq6NXGFhfumMx8q+IHZunzr8W1hVBGu
 kwS9rzkbifq6fShRwlzN7l25wNbai14K4f6nxFowxKdvDr0jqWRKjMoPggR8s6+fJ5gMLMITLSG
 G4gATXl9ftDBxdFmLaAxVucc89y+3I+rxZqY6+21nL5xSq7JVLgrrOpzzp9JiXdPBsybIgoFiLA
 EHMM2slOEl9Z42AUXksaQ2XgmA3Ff17nSttQ2dFdx6YLt2OUF3906BLtyspaQVCPDkLQL64hngp
 dXhcJPZ13DsCEmGu+1i6pNF3Vs2eMf+8i9fg8+xjlpieQaBYvjsdoG6EePAllweQSU/PM5M7Wsi
 0BGtwGEUg=
X-Received: by 2002:a05:701b:4211:20b0:1ae:4ead:8cef with SMTP id
 a92af1059eb24-1b50312b3bdmr7615126c88.30.1794741603677; 
 Sun, 15 Nov 2026 03:20:03 -0800 (PST)
X-Received: by 2002:a05:701b:4211:20b0:1ae:4ead:8cef with SMTP id
 a92af1059eb24-1b50312b3bdmr7615102c88.30.1794741603088; 
 Sun, 15 Nov 2026 03:20:03 -0800 (PST)
Received: from [192.168.0.2] ([49.206.98.25]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50300e5dcsm19741372c88.0.2026.11.15.03.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 03:20:02 -0800 (PST)
Message-ID: <4477163b-709a-480a-8c83-0633fa5d4e6a@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:49:57 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tools: mkeficapsule: Enable multi-payload grouping in
 config parser
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
 <20260727-mkeficapsule-v1-3-5b162866b092@oss.qualcomm.com>
 <DKF7E76IJ7F7.11I4JWAVP3Z4Q@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <DKF7E76IJ7F7.11I4JWAVP3Z4Q@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: takSv_XCtV6gcZZnd5uVEjg8hDdLMAR4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX+4bzbdE+22Fv
 sw8N/nkM55pyjTjmA5YAQ8vA2aNluosQHpYKePxyJb+1lPCT8w5qTygU1/nG8RIcEpYakhW1iPG
 UTNLvSI8f+Gdxez0/IcFZ8zuLDz9rpY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX9DQWHWPqVeT9
 EUXlaPqUOlUDNhWCIjT6CO1grEN60+IKdHmwzvgKVgRGf4+p72ZkqIdhTJKFCT6kVozAuEkkBhg
 yWbNzTZt2Gey2R0U7ntuudEzYMEiUkS3ydcvjfTH2Wk919RLsbjNayYpJTgn/ia3qSKCsy5K/rF
 0OKTv9f2Q+xA/guTvB57/YciMoTeVE8678CtM9WJ3x//ezJpwZM4U1xBCpBQWYYs3rt6dZks2x4
 rRFdzjgKMrlJVlJJ5iTCpRUvZ6C85xw+dSh2fMKuDm0QApfH0X6W9xBUSjg/tG0ir/P1V+G6iXH
 bVFvGo+mduFmcqSdpA906pEGdDD8U4GD/8pXqC67ICj0lq5mfnAVbCbrlzwIzD5BYIKfeZJddbP
 hN5EyIm9UP5efXbpU0jGde21yr7jP0D2tFAiieU4231GERs1Ym5BxuBJ8rf2GoHcZ/T8wc/vnOC
 qic4bdoQQ7UAgnwrKVw==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af99564 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=B+jc5o7RI9DO8wW/BDIZNw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4hJXSXcejUTmsLAdLa4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: takSv_XCtV6gcZZnd5uVEjg8hDdLMAR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150044
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

Hi Ilias,

On 8/3/2026 3:02 PM, Ilias Apalodimas wrote:
> On Mon Jul 27, 2026 at 6:56 PM EEST, Balaji Selvanathan wrote:
>> Extend the config file parser to automatically group multiple payloads
>> with the same capsule filename into a single multi-payload capsule.
>>
>> The parser now operates in two phases:
>> 1. Parse all payload entries and group by capsule filename
>> 2. Generate capsules based on grouping:
>>     - Single payload: use existing generation path
>>     - Multiple normal payloads: create multi-payload capsule
>>     - Mixed/non-normal types: generate separate capsules with warning
> I think we should just remote the third option and exit with an error. We can't
> predict all the mistakes users do and correct them
Okay.
>
>> This allows users to specify multiple firmware images for the same
>> capsule file in the config, and the tool will automatically create
>> an optimized multi-payload capsule when possible.
>>
>> Example config usage:
>>    [capsule1]
>>    image-guid: <guid1>
>>    hardware-instance: 0
>>    image-index: 1
>>    payload: payload1.bin
>>    capsule: update.capsule
> Why is 'update.capsule' needed? This seems a command line option

update.capsule is just an example capsule name. Have updated it to avoid 
confusion in v2.

Please find v2 here: 
https://lore.kernel.org/u-boot/20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com/

Regards,

Balaji

>
>>    [capsule1]
>>    image-guid: <guid2>
>>    hardware-instance: 0
>>    image-index: 2
>>    payload: payload2.bin
>>    capsule: update.capsule
>>
>> This will generate a single update.capsule containing both payloads.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   tools/mkeficapsule_parse.c | 115 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
>> index 12f5f04b824..4a07006e2f8 100644
>> --- a/tools/mkeficapsule_parse.c
>> +++ b/tools/mkeficapsule_parse.c
>> @@ -299,6 +299,63 @@ static void params_dependency_check(struct efi_capsule_params *params)
>>   	}
>>   }
>>
>> +#define MAX_CAPSULE_GROUPS 32
>> +
>> +struct capsule_group {
>> +	char *capsule_filename;
>> +	struct efi_capsule_params_array params_array;
>> +};
>> +
>> +static struct capsule_group groups[MAX_CAPSULE_GROUPS];
>> +static int group_count;
>> +
>> +static struct capsule_group *find_or_create_group(const char *capsule_filename)
>> +{
>> +	int i;
>> +
>> +	/* Search for existing group */
>> +	for (i = 0; i < group_count; i++) {
>> +		if (groups[i].capsule_filename &&
>> +		    !strcmp(groups[i].capsule_filename, capsule_filename)) {
>> +			return &groups[i];
>> +		}
>> +	}
>> +
>> +	/* Create new group */
>> +	if (group_count >= MAX_CAPSULE_GROUPS) {
>> +		fprintf(stderr, "Too many capsule groups (max %d)\n",
>> +			MAX_CAPSULE_GROUPS);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	groups[group_count].capsule_filename = strdup(capsule_filename);
>> +	if (!groups[group_count].capsule_filename)
>> +		print_and_exit(MALLOC_FAIL_STR);
>> +
>> +	groups[group_count].params_array.count = 0;
>> +	return &groups[group_count++];
>> +}
>> +
>> +static void add_to_group(struct capsule_group *group,
>> +			 struct efi_capsule_params *params)
>> +{
>> +	struct efi_capsule_params *new_params;
>> +
>> +	if (group->params_array.count >= MAX_PAYLOADS_PER_CAPSULE) {
>> +		fprintf(stderr, "Too many payloads for capsule %s (max %d)\n",
>> +			group->capsule_filename, MAX_PAYLOADS_PER_CAPSULE);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* Allocate and copy params */
>> +	new_params = malloc(sizeof(struct efi_capsule_params));
>> +	if (!new_params)
>> +		print_and_exit(MALLOC_FAIL_STR);
>> +
>> +	memcpy(new_params, params, sizeof(struct efi_capsule_params));
>> +	group->params_array.params[group->params_array.count++] = new_params;
>> +}
>> +
>>   static void generate_capsule(struct efi_capsule_params *params)
>>   {
>>   	if (params->capsule != CAPSULE_NORMAL_BLOB) {
>> @@ -324,7 +381,8 @@ static void generate_capsule(struct efi_capsule_params *params)
>>    * @cfg_file: Path to the config file
>>    *
>>    * Parse the capsule parameters from the config file and use the
>> - * parameters for generating one or more capsules.
>> + * parameters for generating one or more capsules. Payloads with the
>> + * same capsule filename are grouped into a single multi-payload capsule.
>>    *
>>    * Return: None
>>    *
>> @@ -333,6 +391,8 @@ void capsule_with_cfg_file(const char *cfg_file)
>>   {
>>   	FILE *fp;
>>   	struct efi_capsule_params params = { 0 };
>> +	struct capsule_group *group;
>> +	int i;
>>
>>   	fp = fopen(cfg_file, "r");
>>   	if (!fp) {
>> @@ -343,11 +403,62 @@ void capsule_with_cfg_file(const char *cfg_file)
>>
>>   	params_start = 0;
>>   	params_end = 1;
>> +	group_count = 0;
>>
>> +	/* Phase 1: Parse all payloads and group by capsule filename */
>>   	while (parse_capsule_payload_params(fp, &params) != -1) {
>>   		params_dependency_check(&params);
>> -		generate_capsule(&params);
>> +
>> +		/* Find or create group for this capsule */
>> +		group = find_or_create_group(params.capsule_file);
>> +		add_to_group(group, &params);
>>
>>   		memset(&params, 0, sizeof(struct efi_capsule_params));
>>   	}
>> +
>> +	fclose(fp);
>> +
>> +	/* Phase 2: Generate capsules */
>> +	for (i = 0; i < group_count; i++) {
>> +		group = &groups[i];
>> +
>> +		/* Check if all payloads in group are normal blobs */
>> +		int all_normal = 1;
>> +		int j;
>> +
>> +		for (j = 0; j < group->params_array.count; j++) {
>> +			if (group->params_array.params[j]->capsule != CAPSULE_NORMAL_BLOB) {
>> +				all_normal = 0;
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (group->params_array.count == 1) {
>> +			/* Single payload - use existing function */
>> +			printf("Generating single-payload capsule: %s\n",
>> +			       group->capsule_filename);
>> +			generate_capsule(group->params_array.params[0]);
>> +		} else if (all_normal) {
>> +			/* Multiple normal payloads - use multi-payload function */
>> +			printf("Generating multi-payload capsule: %s (%d payloads)\n",
>> +			       group->capsule_filename, group->params_array.count);
>> +			if (create_multi_payload_fwbin(group->capsule_filename,
>> +						       &group->params_array) < 0) {
>> +				print_and_exit("Creating multi-payload capsule failed\n");
>> +			}
>> +		} else {
>> +			/* Mixed or non-normal capsules - generate separately */
>> +			fprintf(stderr, "Warning: Cannot combine non-normal capsules. ");
>> +			fprintf(stderr, "Generating separate capsules for %s\n",
>> +				group->capsule_filename);
>> +			for (j = 0; j < group->params_array.count; j++) {
>> +				char temp_name[256];
>> +
>> +				snprintf(temp_name, sizeof(temp_name), "%s.%d",
>> +					 group->capsule_filename, j);
>> +				group->params_array.params[j]->capsule_file = temp_name;
>> +				generate_capsule(group->params_array.params[j]);
>> +			}
>> +		}
>> +	}
>>   }
> Thanks
> /Ilias
