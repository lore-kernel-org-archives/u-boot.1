Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE46C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3CB580ECC;
	Thu, 17 Sep 2026 07:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D71MCpuhXKc4; Thu, 17 Sep 2026 07:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E470680ECD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629334;
	b=sVH+13vDyjEL0pNoJ6rdG/7wb73aHPeSX/q/jVim9+KLwjuthZT52fzZ507iJ6jJC0mM
	 TfV+prbkPqWl+sFRNeZ35S643QuOg9RnfLgE72pHCKFoq///NEVYMgULybYu9pqbVgAcE
	 I/8O9JDWWPmfl60ulwCJd5e9mn2tZC3WcUwK9zTQ/rdEjF/BNNvwpghmgWWqRrGMKzJ7W
	 Se0SzHCQFeNZVTf+qj1KdSIxxFccdVxkclCBDeV4IMd7IK514cB6G8C4ult3iyHqBtQlu
	 vbKhutcC6uskNuEfWmtW1YFrxlxfXoFyp1GGsya6msHXFHMP2kQziH1gtCLqB/CMpIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	b=jj3WCcieC8knpFMlKANDYLTgxj41Ko39rED1McZovbZ8Nst1jqO3yFj3Cx5jqoTVNpGC
	 Pdn9rdGHheU1e4whijCHT7jhF5rGF/9WxSow35OToqdQNrYVRvxZhq3cDig2LiALiiWb2
	 u+e7cXLVw5X36erK14ytENG+rreo16P7Jqz0fHbuzlVZWnPtmLQ/pJutJBWt5DzIDeMeV
	 tUHXfWFGpvTH4w+/ue0RFOB98ZEqKJGpLa35grb1HfRwxpy/SPl7MgJd5FY6oIXI2+nu0
	 AswsEAPRr+LMsr+tqMtG+PT7zd/3+xNqwKwBp9Ofk/esUp10S0HNdEjoHQib9+ZkkDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789629334;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NrJvNE/rhJ+6s/Dt1KsmLUEjByJeRtDZhs4+rjYq6s3Am71xc0xSgnOndloJmJUym
	 vgm1T99hfles36T7DaKDU3BGstw6G75m8x9q1zu72vZ9Lh/FCiNDqSt8YDaQHRFgNa
	 tGqVW3PLfFb4cB85836PF9AT40izerg+ZAyeDL/uvLR369oGkqz/5mV62zgBS9s6GG
	 kb3v8W5HmKWrL3bAxFrzy0Ks41zWsTzWHIAz6Z2Ohr7eN2hnbvkRcdx2Tp39d64lcj
	 Qg99IrbRqoDgCSYOVF5yjGyIK4J7u77FrvF6b+MBkYuxM1tYcexE54ZaALU7zyG2Pc
	 R1k9BfVYTAS/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E470680ECD;
	Thu, 17 Sep 2026 07:15:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A26637A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80109400AD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH0ffhH7PhUF for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:15:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A93664005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629331;
 b=m555IXC/uAbXPW4M7URTPO1Rb/hdwq94zGxmFjK4olsPi+oNRwZq2iOSG81E0BNk5dMa
 qnAQfEjIOkkQIiLtdk21AjLKbVjXEL4CeCnY0IkCIXgx59EUCRC7lA6UL5fA5wLIoi+O0
 UR+6H63NS47KqUsHH/noG16J5HW1gyvbKbVJ0SMA/ZSqYsuu745OFDyqP7TRQjONYrdT8
 iaPjDC+n/thEFzXTYG0XughCmaKtixzFuuvXFvkAw7qEwN9Oa6+QRNAXiCF0CElp2iown
 xWvVP58mfl+ncAm2GGtgCqmrPfcj5XXn+OxauQNj2gp7b3v8Czvw4u64T7Uafh4OjDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629331;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=ZbK66Mfu+pTN5rQ8gV3auymuMNGpBPKYd/fuDSAvH6eDGutPv1AQFNAF+w/glusfVlOx
 I/3KHkh8Ie/znBUwzIO7cTpYPF0FkfFmQ52NmmsSvr8zaPBmsY6a7crdzwQFTV/Xbxiu1
 bxsNboDTKHTNgk7lLJ0Ly71p6SyI+xrqGxZPWGEzqQ0KWCKLXG/f3E3aQm9r28E/h0KNX
 m8y3kFltWmYMHcpygSn2T3oxd9gChR1vQVHzEzWK+ZbZJMingKMHQ9nvKFQkf5Qwf6ecp
 9AbwvXbqed+zWXPpOojFWh2YmAFhpNDreCJdw2d/EKTBaO6IEOM9TDVzuIMsdED2d6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IcLGWdYU; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EOe+9poL; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IcLGWdYU; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EOe+9poL
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A93664005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60kZf663574
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=; b=IcLGWdYUZZ9RVqzL
 ptkj7tXWdNCv0IcaxJIGxCAE7g27zjLNHASu8Yva40j82f6rC1W+3FnkDLlv1fPB
 p+u5+qPECpM8mLOWbnJYSRvqgwKy1cxQMBoI9dWKIgX1g9WaXqTP7D4/UKyvOxo+
 tL4hDF6StXfeReAtYPBIM/MhS8m8p85LNsBqYzFfOckmTf7/VCdrXJWyPayfiSHD
 rUkfOaGibkbwGIvgXvZ6a4KF/lwxixaMZTiR7/48GlhNjHzlhwjghnUK0To9JZhr
 Se7P3UHvrMuT8uVzdEja0UkgrcV2NXTwVW/qFDoYM0xTPdP7Pd4NGoiC0A3yNaDD
 oduEaA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga2tdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:29 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6c2549d0cbaso1026359eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789629329; x=1790234129;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=EOe+9poLI2OmUWMbR8mAw+R0tJbU8QfSMsqeCzsbN20b1qUMDelKfLkuAIc+cYOzML
 jdt9d1Y1swtyRhF72LMcWg2OFPDlFoqSqGlOjyUbLk4zmSIZQu9OG9kL3aPogfIPpBUe
 JMdlhK+u7vYoQYa9I89dBRfISONsScz16uh6g+zHk0XVxAic1K4/WpRpp5SbjS2LJh62
 iEZDS3b4g6XfoOSlKFSlVMUpCSFWS1xDUCk1CUbj50RmgosxKYkjXuKCjOykAmRoUv8s
 HBdkBPggv0dPpBADPyP3LXb5fCUNNvhGMYLJMfGNWzsS5V/A6KFuTCdmG75I5l36dZYL
 HzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629329; x=1790234129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=Ejx7TEAr2ePtIZyVx+yPfDphLDbxQGrazR5YjviytInFfB6XqqWODKTVIYyqurAu/K
 tZNViKxZ8mFzJr6LQ1qEpjlhoUf6U28H9SCguzGr2boFK3egwQpAvuVft4z/mceKC4Ot
 0XffyBij1ZiB1tDIMKj7Yvrm7zqPWhQGdwDVUvA816vh9WJNLmGk0UbZ3Z4f7boUKNTN
 IvU6JiJPDoMF1q0uf9hMN1Y4I138PcjKuKu/k4tCcK/oH7jXuISABM8Cyo88EDrMlWUS
 H8t15YSBrn2PvP1rf99obTYrk7RwCV2CYdMG6MvQrmXHIMEaZfykQQUs1fFhWuwHsFqy
 6oJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwoofJfn7k2ZqeQ+nWZSBjXHjkMbJvV8tSVsB+jgwTh6feRnCEDHeuSzUH7rJQ04r+2wCytjo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kxtrpKoJivMmN+9xSwFugKAchLnLC1j/0Xt93ILVcjShC9n1Ji
 M3rgmobL0pZA0cN8IbPf5Zuc8HlYUOmfkescUabf2muYld4Le+/F9KFLNu3rL1JrQ98DhOtgFOz
 e93dmaFlOiOZ7kOT3L7Vf2YlISC6mCJdymhPXGzG4vsEQo8nxxep/wezPVLHOM4v2z5dzL/b8CV
 Gag2k=
X-Gm-Gg: AYBFou1Fz7dBHp1AExYgVonmmM5zdnf3/1+2/v5yYqQ/UAysFfEpQaOGWbqo5h3vrpP
 XIurulLHILkeC5kOlzGBoZBoA8mDqauL7K5nT7iLsDC/GjyW9E9GK3aJw4G8ROtJs3sQ2KxQSZs
 PN/gV4bZf1k+E1BSnUHP7kPRpWqkOei/zRHI8juReoWDcR/NnlQYvn9UHqflRwDoIGGn+MLSf4O
 8Akk+ymjK9FzmDgWN2D9rwh8wsFKkhYkKw1LlLDcO+GwwipcMlK6w+akJM1LUvTspbdAG4WKKd3
 ExxUiIc+xu8RCIPRfPwEcJjU3QyJYnF0WWMMlQxwITcNPHdK2+ZnI9lsktUYFiNcAF/8A4XX3NX
 hqhFLDRLOlECZerdATk5uTbLNwhR0wOe6Oa9+LofJvq7V79IWLikOveA9+7bFaUtBtwQHSX9g1g
 /sHJdBhJoOkcCzIK6Iy7bTGCZKTfR1aA==
X-Received: by 2002:a05:6820:4b0e:b0:6c4:5fed:753d with SMTP id
 006d021491bc7-6c7d44e8071mr5118635eaf.45.1789629329192; 
 Thu, 17 Sep 2026 00:15:29 -0700 (PDT)
X-Received: by 2002:a05:6820:4b0e:b0:6c4:5fed:753d with SMTP id
 006d021491bc7-6c7d44e8071mr5118606eaf.45.1789629328672; 
 Thu, 17 Sep 2026 00:15:28 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm12175810c88.8.2026.09.17.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:15:28 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:45:09 +0530
Subject: [PATCH v3 3/4] tools: qcom: mkmbn: Add support for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ipq5210-v3-3-d11dc3e8b16e@oss.qualcomm.com>
References: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
In-Reply-To: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: dwFcjSe3cXynbyLNF4rSbVgP-7vxGS9t
X-Proofpoint-GUID: dwFcjSe3cXynbyLNF4rSbVgP-7vxGS9t
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfXyhGU0btEy0Jn
 ER1M2Vrl5lDrbKOWgsCDAspW80AhPMHO9FgR/7TKrhSVjkYAdsPORnKrTVP8zsUkHYOuag4ln9o
 sQ7U5C/QIGy8OSNPYM8mjlMAZN8ZUNQ=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aab9391 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yH3UP6-NtsxmdlPH3hAA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX910IpWWeq49T
 sDEHSgFx4c7FCvIc0UkAarZH07nXZD4Pi5nPxvYD3dpp6YNgANTErQUickG0P9Wpaou48lA95X+
 nE/jaqu0ufngQHA8QMW6t56hSPbCXky0t+Zr5sa73pS8TWZ6b+92CUse2Qxp10ZAWzV1qdYbddK
 jVLIpnV2E67edksrVXulq3rzcA/OGMwNoSj0/nO0lgfERqAgK9hECFCj196l9Bkq5fuFtfB/oCx
 4JySC1Qictwh2IhKHEzmREXOodPjfxu353/x9uLvRd4bXedg4vJtEooRnNmsgv2jI2egUe8uTvB
 gxDJcHN2x+zwFFFNRlaV3Pz5S6JMmIBk6YqO3ebsjeMoxDNuqP4Yb7cnCKjgKCNyFFljC0p/96p
 vXVEYDra3KUwezWyB9oGMQLJE3h3b+3Qrt2ZtHabZIqlL5U6Mqr0XmzzOYXs70CrGP5FUBMH6eJ
 2gWqBVfdc+rQgblpuOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170096
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the U-Boot Proper/SPL load address and
  drop it from MbnData
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
  Enable the mkmbn script to pad the image to 4K.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..dd61ffd98e8 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..da4d45b600a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -56,42 +58,40 @@ class SwId(Enum):
 class MbnData:
 
     # sw_id 0x9 is aboot/uefi, the most common
-    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
-        self.loadaddr = loadaddr
+    def __init__(self, version: int, sw_id: SwId = SwId.aboot):
         self.version = version
         self.sw_id = sw_id
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
-    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
-    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
-    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
-    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,qcm6490\0": MbnData(6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq9574\0": MbnData(6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
-    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,apq8016\0": MbnData(3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(3, SwId.aboot),
 }
 
 parser = argparse.ArgumentParser(
@@ -100,6 +100,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,10 +152,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
-log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
 
-elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
-elf.ehdr.e_entry = mbn.loadaddr
+log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")
+
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
+elf.phdrs.append(Phdr.from_bin(data, args.load))
+elf.ehdr.e_entry = args.load
 elf.update()
 
 # QLI boards use v6 sw_id is "aboot"

-- 
2.34.1

