Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E6CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 472FC40919;
	Fri,  9 Oct 2026 13:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEmOcLfzmblH; Fri,  9 Oct 2026 13:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7830A4093C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791553331;
	b=P9MVYdkNnPlRhuH7V5umcw8Qdop7yTOXtr9riLj/TSZElNwE2LzcLXukEAZixy+3BHyf
	 AvS7RVI8WcOtQGvSGfNQuxpWX1c+ADEfVkP40y6X4H0TXrMpoXUS8bo8oWdv5y5Hso0Yh
	 SXQP8khxf6lDxxwCyqNsCxmchyoYCQjJnQM5jj9/2FzSciDPGJklhp/Om8alCGKxxdEw5
	 pQM7VK4Y5OkVeVZqNzJ6pz8QjzsTQhV5uj0uevL59jdgLDl9uedsTlgLMCIUIwT2S7+rT
	 EGJ4hhEGrRg6F4RS4dC53uIl1dN4FV7ZsQzmMAajiXjfs0jbk7KG3Vjlnp+ggb9wIlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iACUAr42PDXHpzsqb8EWz1WWWxDo4ODFmeWaRTW/YjY=;
	b=ivOPNiVe8LVFR3MPsgRGNUJ/iE4xr4zgV+0vwZDJMzE0R2+NA53Hs+UP7zQwb3rlEOxt
	 eJQletLDrkcsUZFyivCghTGIvYz4kEaDSoWAf0PyJEPhQ2SWwh8qKyiICGzzioVFTetVw
	 4GAKc3bjCLb+WqrFZgx6daDo6cjSVC4VzOy+sYFF46J+SN+SfN3+Nu3FWiU9PslX3XQTu
	 KxTO9ILmGxj8pIPUfcjdonuHWUVS6u+67KffnCBHi+3P7yx9zutDlJD92j1NqdAiEaWYv
	 xOw3YMF29rruCRsgzEhh5epmDjBfD+wCpbr3E1H1yfzNzosi9HmSKmjH4dLGzH8B9eg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791553331;
	bh=iACUAr42PDXHpzsqb8EWz1WWWxDo4ODFmeWaRTW/YjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jWZ07dL4SUMiGq23vnXYV6K9jOiWIi8wV8WJ1xJUdTzjyFTtEjaf84KjvXEL2toCM
	 NGGZV9qRrLAuRI2N/ywzqUtmuklVPQ+a+Mv4lgh0WkbdlpFNYfk1XUbrnRSP12LTCF
	 DoHsiEqbHBDErbBGHVdxw6ssW931aDB2AxZmCcAyIXKcljF7iqeKEYwMT+GqlpAXvD
	 XBo/+IdIj3kX22Nt4eiQfmbIOFiB5TS2ImSKrfh3jmf+RDyk/LjU48olgGl18z0UWo
	 bRewf9m/nGBAVLKRg6qB6LOh95+Ai9/JiMskP/JF2mKTb64YhNWNpglfOTeTMclNkZ
	 q2R/dwUsP+cDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7830A4093C;
	Fri,  9 Oct 2026 13:42:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8787F1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D3B6400B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYOq-8hshp48 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:11:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F290540061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791547862;
 b=hqqjvBMw6M+chGwu6I0su0a4e9/k/y6P/zrMDstCnkUGYBP5yXf075ZkHPmEmUTiDkd+
 qMi33QDyWd7mnzuiTOV5wGyxl7r9NLbVzXCCFctRqURMAABy23ILWhax1GSGFu4dr6lGz
 ExPYqzzWFy96uYdhXJQRE5O73s2MVPgfpuUP8c2wTZJZnR455MXrDRlNXW5uESeem7wY2
 gCmmwiE+lmfdd0D1UxhYPjBow/RG+W/85qek5qkGtezPvn5kwS0JQCJr7O+xlgPhFFI1c
 1cgqEoNQS7pRf/FkB90JZVKqZj/gCftIwl5j75wBjmlNJ9qQeSRTMs48qHHm1f7I5/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791547862;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=iACUAr42PDXHpzsqb8EWz1WWWxDo4ODFmeWaRTW/YjY=;
 b=LXT5iYVH3ZCYf5dv7AVBgV3MZTKRc6qMSkuOUC2SmpBu+dTagH4ex5MHV0zpY7wrmbpK
 RVG0imZDTt70L4KWiq86Qzy/6fAc3rP28eh/SHyqRsPWWVOzn4DSVWMEws7TD3vwRQyEb
 OG+EidSXO5CiIGUiH8KQI0c21PZTfY92AftgYn20J8mYCUNAvpx5tAKJjbDV3AS1T1jKf
 bR7A4tYxENyfJ/Y9wmQJWZF8Azq3awZ3YPxo5HKfjVgVQGL/fdTAyWYpTBeSbOvmLdTbq
 hkQsAw+6NvCtzBACAvju3flmIdKuB32KxbQU1/gfn8g/qkjOEWhdxqkAlqivFsrnVvg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="hdg4v/lU"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RyHhbQsl; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hdg4v/lU; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RyHhbQsl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F290540061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:10:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KLhL1747012
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iACUAr42PDXHpzsqb8EWz1WW
 WxDo4ODFmeWaRTW/YjY=; b=hdg4v/lUEM8223JtUF1J8jc5SVsCI04I7ljZE2Nu
 G2kKnHn9Wa/m+W3uL0OLqw0jnbS7XSlUrxgFWc3tokgM7vJCM9ai4945MUButR0f
 Qnca0v0W7Nch13sDaeZTDof3hox6NjMca5u1DZK+608d9arCwkYZ3MsdEROTLeBg
 Y5aHfGXnRHCDusPGPjOP6gfWYDlbXRjQyLVg5nYB2mr8+/rzY41QgKUC4eMxIam1
 Y3pzgCpxBuW6PObMIoiN6Int7z9cjgt8A22T+xNYxiU+zwxYqsZXBBoZQmTzI3Mk
 OwqFy9ObPGH694mc8c/yCGsRc8ZMmdy+k4zJ3Q2+9mfIoQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvbrhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:10:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1384911885a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791547854; x=1792152654;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iACUAr42PDXHpzsqb8EWz1WWWxDo4ODFmeWaRTW/YjY=;
 b=RyHhbQslQJI378Ip+cSE5lknNQdttaJ3mkG1giYiUdw4TxPw1YdoDlziLLU+XIhj53
 K7ANYj4vmBGudxTOsrAkStpOPZWum1nBpvp16WWKUNZgOFPJu9BVplf5KizaYrxzGxtw
 Gu8khopi5umEDS9X5c4QtDu6kVBcFJBMM1ogkusJarUpiLNgbEOz/1EFlYW93OBNeour
 beC6RG1vooCbMS0YktUc4bMt2IV2vgWgXrsy9OLjEtVRRKqRnBXic+fLHDWifZouMFwK
 WVdOBdUrjnUGBkq34TjITcubiP3YDwrhRG2EC2kQBhyMEWvB/flg0U7v+TPGcLfb82UX
 e69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791547854; x=1792152654;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iACUAr42PDXHpzsqb8EWz1WWWxDo4ODFmeWaRTW/YjY=;
 b=s0tDwFiv2yPxSJtPV/zu6/cK2lob3VeiHcR7BPmWGbZ4VKLlMg1eguox2RIGpm/Ksq
 l2CKdRUZ98MmHo4rcE39F5FKmemNHo2z6zkHn7U97WtGHMhEmhe7ytvH7qFWnkz86R9/
 ExX30CY0HgIxQfr4m/PFVEd8B9BOWKGD6SYNY2djNkpmH9nhMax8b6zhBWYePOqMybMF
 wVrRn/zM1ADCnIwvZkU3ehsYkshvlOVPU3JUv6Ngcl6mLqO0YJvHm6TNh8TabZajdfCk
 Sk1hNxPMef6WbXzTm8TH7ke1QlctrxX0KZHHqh9HtSSBZ33DW0R7cce2v3ZPI1VdzU+q
 aDxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkdmwQYPzFbDbxHNaitbWk70m+8awr1h9DgmiFhLiLgcRSOfg1v2HR4AHuJbOkz5NCBCkf4ww=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nf1tLi+YWLTnAo1l2R9xbrhfNhInMckMkT9vIeXaoLGQUSwvR5
 6/+xUGrEA1XuiUN+69vgv3YN+y3I1f9tmcSuIpkT/TX7OtVlc98hwGyhRWJdyZ7BGabWJRq2oDl
 +SjfsndQKvcc3tBSu7SNKiMgnfEetFORH3sqK9HITc4krqlMfBcPAt+UGlkQeV36O7AA9SlM=
X-Gm-Gg: AYBFou15wA3HdBs6eot+BTuQHJOA1T5M9IDapH4AIIb0WQj8owbMGXzFyOEiDYAWBw5
 yI9j1DcpYbR6x0JRigLH45Q4cwfuTpZljiImvXybnc2JYJPruDJH4M0mEMCu2xRgL/iJnTFFCZh
 ckQgajM5Rkl4KcEgBwn9uE0h/zv5/ZSHrSHo+6qHZYeOpC7xgG4wy97hbQZTOcbtA/NyIiNos7T
 lxu7ax0WrPrRo1N5VIlCSlzjva4kfU6DVslCRgWA7HReTpKEgQnIGIK9gTpS2mgCxO1Sau1OgMS
 Y/adHuKPiNIap5y8SBd4Vn6yqA0E98y5B9Yk96cfUnuz54RgyZiZAgG9aJCEqVWExf/hlhj9YEI
 5VhxhYjhNILD3MQs=
X-Received: by 2002:a05:620a:4395:b0:93c:b3aa:4290 with SMTP id
 af79cd13be357-93ebd20e63cmr240217285a.23.1791547853736; 
 Fri, 09 Oct 2026 05:10:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4395:b0:93c:b3aa:4290 with SMTP id
 af79cd13be357-93ebd20e63cmr240211185a.23.1791547853123; 
 Fri, 09 Oct 2026 05:10:53 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm80466945e9.4.2026.10.09.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:10:52 -0700 (PDT)
Date: Fri, 9 Oct 2026 15:10:50 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: petr.hodina@protonmail.com
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] spmi: msm: bound the CMD_DONE poll with a timeout
Message-ID: <oajtlz57uquzjdvdoaezmmx3in6nxaruptgwgboqfcjnpeixb2@cnsvq5rgendx>
References: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
X-Proofpoint-ORIG-GUID: w0QaJolnibOU3DAFrHeMyCpRdZHmE-Jw
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8d9d2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=mSD6TI65Wdx1o1FgNLgA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX5a95ket+4YKc
 Nnj9KiPE6g5L0rDQLnXd16UcLtpxhXwh+UqIG94bUYvy9bMdG0bAg5EJIPlkFOg0apu7em13DZp
 Ayv1VKDl/Lkc0xC16pKGAZ/vAvFRk3TUsZye/gJLlqpc6ylPzq5D/EWRnZyOf9XnvM//TGb4L5k
 xax0yWo9Zy0/e2tFRovVSVdCa45918jxTJzQlJ0vS46uHugjB4HwrVZdCpsBNrHYt7mwTglX8VB
 FIigDKZjmDV2WP1UEE5IrzhO3sMB8Vtx2OMv5TkpLlms0+Sl0R+i73q+XBa2NFk2B4isqNF81DS
 ks1542K/GzdIryfS8xpgQ18/0rHKfRioKK6zJl2w3wuOg71zMHnDDKJT51XJHJefICtPEUELdr1
 tDkXWUew86wmaqh18mZo++MzKhkzKL5x4U8KndXlvylJekaDt/BdoL12mOxq0Xw3EvHhWkukpAE
 ZAnDiyiEQhYNbSBvNrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX/TUdcDO9S4Kj
 sooe0LOxfwlnfDa8DDE8AcIu6urMFDx4Az/3HoW12TgL6jb9HtHPCAOJ8c/4HiNLnCUsKYTXTXR
 1mUZyUmYzleZvoa6XYLBYZ/zqYY7ODU=
X-Proofpoint-GUID: w0QaJolnibOU3DAFrHeMyCpRdZHmE-Jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090048
X-Mailman-Approved-At: Fri, 09 Oct 2026 13:42:07 +0000
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

On 26-10-02 23:36:12, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> msm_spmi_write()/msm_spmi_read() busy-wait in inifinte loop.
> Bound the wait with readl_poll_timeout() and return -ETIMEDOUT on
> failure when the PMIC peripheral does not respond.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
