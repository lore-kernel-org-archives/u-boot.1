Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929F4CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56A4C40A34;
	Wed, 30 Sep 2026 06:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izMSeLiXMGmN; Wed, 30 Sep 2026 06:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73AE4408B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750130;
	b=pnYizUH2W8MDsxj+vF5+TcMu6qE/Cq3VAk81STmBVJujqxsEXvIjd1FHGDa6iDsrWNvk
	 rHxQW+lk+eENBDLCPYGHsywlTPglcIggoHnMzd+VaWOIPibSxv11Nk+/L/8w2bfybyY2K
	 RvI33wWQB8k/akiY8qsen+0gwviop/vhlQjbO6lez4s5mxKnga1FGet76EHrLljWT8lpd
	 GtBltOVGYwpd8xsoBf58f2Tp20vJT/JcZgenLysI+3yjhyPbBuceALhi/rB130tbPbQlE
	 qm79+sWWrlsit0Kp8zfiaxvT+JCUQgDAPcbNxKk/PUXa0LHTk+sHThc+mfhFBmq//NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1AuUnEf79jfJ53JPFWeNn30YO2lZAqQxW6wvukgCBdo=;
	b=cjg8RNUhwx748XnheEYzgake0XFbfnRjCD178GEtUEgbX0+JIfi8ZCcX6ZVRjYP7ia2i
	 BrvtQqXqGjs0+JOCyWSg6ZdKuqNcFUVNTx28AI+Ggl/Z9A9/TPDJy2FzW9w9iTsqXHIYv
	 UWLAF02K0BMa9o3EmvOLjblo7Ff4WelPXBMiSK2HSvciuTkiDkV3AgDOkIAZi0BaSRNkG
	 GxshQV9EMtUdyxllVAMpOD2YY63d891K2uvHxht0PQwHKoW5jaAd2uffczsnrSGSi/n4U
	 Z36j527W2P6aSkdDJJkyzOzdIN4PIJM+DkhtLoG7Lruelzb7V5fpQSGnwPalZ62/7nw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJahXlDc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzFhmJaJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750130;
	bh=1AuUnEf79jfJ53JPFWeNn30YO2lZAqQxW6wvukgCBdo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UTw6MuAQvpbnXd+5jNE3IF/EIA/cgLOWIUtjjYXUY35hFU4h43W3u6LGTpkaRf6Vn
	 mWsuImjDNfmNkP3OTPUfuO6NUEI7OLSLM7TRZogF5/KanD2ITC7yevvDwasacUI8Ch
	 g3PFRq0GqW8wtT+/6vJjU8R33vld9S4eiGRUjbrTIa8DfLLCr8ji2CgZcO9HqW6vz3
	 WZwFUgoiVqMI7fHramrjzyjP288AdQzU1YdFRQp9f+Sm669CztEBUPLobDPyzf4x5G
	 5L5M1hmSyVBQmDJxyACXLGWaJBdx8zYPlHJc0NvjHYNtWBHWGzvpJHdC/2P9KmbRqH
	 KnfFBmQij9BNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73AE4408B7;
	Wed, 30 Sep 2026 06:35:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60DBA33B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46C1840A2D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JQOtZCoWOIeM for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84B1F408EA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750117;
 b=FcdFqeWuWITdhPL7v70PLeXQbPBfrD9uKnNPQi2+m+uPSjxhH86Og7eq2eXx1k9t4P7s
 WA390ZBOiZH2Fn6pLYyLPj6KignqqZmxqdhu02uQ5aG3LS1Gw9JdNsRe6b+zcU/2Q0wSM
 RN90QQasYlaIwW6CdkfdY3aADdy1mRaJrAm1fB6LdzMFCRt8x1wv9/L+PBZHjXd/tvqBP
 invm/7OEe0EjjIaTaokRrPV+DmAoxFR3A8hPpPG00Xi+dSbNnY5fLWt/10AtPqEMhM4mR
 Y1eC+1AXAwawqyLosqXWMx/Vc7e/ypoFa2Lx1teiTMaHgUYYlka09l7ufVQLDKyozVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750117;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1AuUnEf79jfJ53JPFWeNn30YO2lZAqQxW6wvukgCBdo=;
 b=gXXEUbp3OCey2ALJaw1XaySOoUi5IYXK5erIgytM9aGeMzSQ9i7STwPcbMPK79IYWWf9
 c5Ja5xY2q97K3x7JT5ZotjZeub+FWVODO+2m4mj9mbSei3hyX56wNJyj8oV6vP4S1Iz56
 bB2zrK3w4s5Iw8mqZv0pirtEsyrnG2SoXQQoqKlhjORp2yS/bS/YP0+fJs6WhP3dUAoWQ
 3qwPx8PMcz6ehDPSykFiT6VvkqZaEsyrmMEnPeDaRsf7hB7DUsU4nhBWYbScGox4LLHdu
 yZQQZ4Dy7C8jSGcbaauB3SwGmSnlFci45IPseVnYNNgOPh2pHRVIMx0RbBTGbb9rJeg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CJahXlDc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QzFhmJaJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJahXlDc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QzFhmJaJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84B1F408EA
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U5k65I2968999
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1AuUnEf79jf
 J53JPFWeNn30YO2lZAqQxW6wvukgCBdo=; b=CJahXlDc0f8IvHuv7qEzOvp+qcl
 hkoH0l2eQqNWvIfBZe4koXMB5n4WgZLAqJWLO2mVPZkSooW1gr0ptTS3UxqC3w0h
 JfBXtE4nEkQpDe9YbdsRt9OxXnuSuB8tMt3osxepeyunVSCmhF/K93L8zYx76KmR
 1pCjrXY6Z41rl6UJ6CvXGAVVZEwT5ML9aHZbLzpT17kkDVPP8/ZMaaShOclMac6Y
 kJV6XkKmX/4Dwpyjx1pyjGOJEWOOwZ6r64IiKDpJbHMAxJIYSj50+IILwIG92hy2
 6VHRdZjswo+L9j0DTL8U07PphmT4wd52QQyVgaP7nB6ujHfsHylOEsF7D3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfaa37t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so19077085eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750116; x=1791354916;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1AuUnEf79jfJ53JPFWeNn30YO2lZAqQxW6wvukgCBdo=;
 b=QzFhmJaJ7O2at5ZgFSFTtyVULRdyZSOkEEmRkqEiOrMTQMUQQrPzxULp90kW+KF2id
 /oyvpuomZwXrUxGbBS828p2iR6H0DU5eNmis+HIC8VW7LkIgeFYKW72m0e7OjQplloJQ
 8EfDe9RHnJCL4pfDEQ16nekhHH9QkW4xzw4/YXc7d8ls7jEhBjIwA21Hahku71TleFWq
 Y5mk0T+gC5UWsFSHzt9Mqv27NW/klWu6GgLhRfSZrt5HvSMOY9vx7I7zVnHq/8pl61L7
 9+CxMlW1nkE0PY2M+KBdMDnMj36WfE6tg9wc3GeC7kE85d/vwcojnWL5lXAYt41ZQbf2
 3BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750116; x=1791354916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1AuUnEf79jfJ53JPFWeNn30YO2lZAqQxW6wvukgCBdo=;
 b=nFzh0nJRipwWTb6duLE+udKc8c2pP9swi2luN5Ym+qs21LEIQepDCwG4MmICcNTz1+
 y7BDyrFSEqYSPl/Yh2wLV7RAFYYtsS8b4Q6sk1zNWyc63jbdUjdqBDw0gNuxpXXHwInz
 QfUmn1L9DyHdH9E+MaiTV+0mL5EQI8V+IZuusn2HPIEJ9NguoCR6vBwRf91KvAPANnfw
 PFoAxD8ou5ShlV0A+pynfZTrWEbFBQegXQwcGrc8dDgJBCerww1TVTikHqcBhOxcwDXb
 rHu+SlaI4kygaLMezqcarzaE3INarnCld5dwLyU7IlkANeX7jaAtdnOECCgq7MMsHGjR
 VlmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydINvAzTSiQnhEbs9Xv0Jyvw8Zxi/O6mKIrwRn7qkxl/rZWrr61KEsAPGONGBV9oX0vlfBp2g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIPazC7kjs0hgcRrb8jVa5vfu3S/c5Sk5vbdY41/NP4VqALl88o
 lT4w3aHBmqXITRxLSlEzd3TBWRk5IWfPainR+SnV6POriu8SYkZgcgzmzVR56Jih/xqj5RboWlC
 sJLlylmUlJpjmyFIIC04XGmuNTsNqZboZvI1E53RZedLdjFb6D2VwIyrNjBWVo/4UwXpLWks=
X-Gm-Gg: AYBFou0zs+F812fCYwSMbmvVXENhBjnJoRbAnhWEuoq8KmeNsUhcwLee6C5vTAVjijd
 sBVTZR2eXRJkaHrlN8WVOjDWGeibot/HlOLr6XpDYDLj7pmVPdpJJrR3tdpkJHgQlioRzwO0tio
 x5DM2HBKV24yTjEeGWaymZ6zlYWuxNdpngLdzcUQp7PuZhokgUO8f2xQWHICS4hX46V0oNL9Z4p
 NKWe+2n4L6x9wbPpv0HIXccEPx3ojWOSoad52Z8uPMLQ2VUrNAzVeXes8bX/E8sAngnDHZMIuKg
 2M8pSce6cunc1tCqDQOzvjY/Jmkfz8hKJurKQg+q9upzhWRQIptJdlt1qlrbSJb9uQSy5Fa6ZS7
 PwPmSzKHdvH8M4saXYECsfn+Rb0DS2FfJWfHt8KGuMQbQNocZbIfLMyqbfl0=
X-Received: by 2002:a05:693c:66cc:10b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34ce1a002femr759670eec.41.1790750115898; 
 Tue, 29 Sep 2026 23:35:15 -0700 (PDT)
X-Received: by 2002:a05:693c:66cc:10b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34ce1a002femr759635eec.41.1790750115326; 
 Tue, 29 Sep 2026 23:35:15 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:14 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 10/12] board: qualcomm: shikra: prepare QUP firmware in SPL
Date: Tue, 29 Sep 2026 23:34:47 -0700
Message-Id: <20260930063449.3251317-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX4T6lHNmJBjL6
 UUZsHpbcLAxzg6BogE6IjuLMVongIE33Im7bUljRszqPxos2C7hwwAeSe88jmDibXunUEqk6hjK
 jcy524ndegT/BpJ6FUjh7tdPVIJ8HrwO9/90n/44jpExee1IurbKBaR4NOwnE6zdECC+nFgs/c6
 DrlCtzExts/MmNr/PG6exJ83KzJjcW5L13eb895AFaJe99TyLHKNnnXg4y/sUFEwUyi6On4e7hK
 WmF4OGICXAeXsPU1e8HwMmaKlfJOgXOcUXjL2FI9tMPSWLCgFHrR2JOvl0nbEp4hyhbbdV00djF
 4B+hvKseCGbOOk5zNfGUAIzMum0qtvhQLsBDUgwHitEud3wym/vM/31GInLV0EWh3eo/dGAOrhd
 0nQ8a7NKE29yGTFNaYg88CuroLIoVYzL3qbvqtciXCmJfA6TfwrroFez8xdwxlIc7PhIRJGr11I
 j/yRmp5efYT7Sa55UhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX402WCuX+5EkM
 qo8XHTQOxJYQvfe06V+KDxYFwEWFxwxc0q4mfE59CfaKlcvxKfx4gVaCvVOTPTFAnf5knecD2xu
 VTIvhvcL7OLB/NIdpcN/449DQbeMqg8=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcada4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=nMXrJebM6ccVpyDcoNQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: zP3s3vWouPXi_5i9qsiK1R0wY4DuXIjY
X-Proofpoint-ORIG-GUID: zP3s3vWouPXi_5i9qsiK1R0wY4DuXIjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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

Prepare QUP firmware support before serial-engine children
are probed during SPL initialization.

Enable QUP wrapper clocks before firmware detection.
Initialize the boot MMC before the last-stage init event.

This makes QUP firmware available from the boot medium.
Release the dynamic firmware buffer after children are
probed so SPL can reserve memory for the MMU page table.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 118 +++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 9bab677cce5..1a385877dd5 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
+#include <mmc.h>
 #include <part.h>
 #include <spl.h>
 
@@ -148,6 +150,109 @@ enum {
 };
 
 #if defined(CONFIG_SPL_BUILD)
+/**
+ * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
+ *
+ * Enable wrapper clocks before detecting the QUP firmware state.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_qup_clocks(void)
+{
+	struct clk_bulk clks;
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		ret = clk_get_bulk(dev, &clks);
+		if (ret)
+			return ret;
+
+		ret = clk_enable_bulk(&clks);
+		if (ret)
+			clk_release_bulk(&clks);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * shikra_prepare_boot_mmc() - Initialize the boot MMC device.
+ *
+ * Make the boot MMC device available before loading QUP firmware.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_boot_mmc(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	u8 boot_device_cfg;
+	int seq, ret;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		seq = 0;
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		seq = 1;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	return mmc_init(mmc);
+}
+
+/**
+ * shikra_release_qupfw() - Free the QUP firmware buffer.
+ *
+ * Free the dynamic QUPFW buffer before allocating the MMU table.
+ */
+static void shikra_release_qupfw(void)
+{
+#if !IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	struct uclass *uc;
+	struct udevice *dev;
+	void *fw;
+
+	if (uclass_get(UCLASS_MISC, &uc))
+		return;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		fw = dev_get_priv(dev);
+		if (fw)
+			free(fw);
+		return;
+	}
+#endif
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret = 0;
@@ -162,7 +267,20 @@ void board_init_f(ulong dummy)
 		goto fail;
 	}
 
+	ret = shikra_prepare_qup_clocks();
+	if (ret) {
+		pr_debug("failed to prepare QUP clocks (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = shikra_prepare_boot_mmc();
+	if (ret) {
+		pr_debug("failed to prepare boot MMC (%d)\n", ret);
+		goto fail;
+	}
+
 	event_notify_null(EVT_LAST_STAGE_INIT);
+	shikra_release_qupfw();
 
 	preloader_console_init();
 
-- 
2.34.1

