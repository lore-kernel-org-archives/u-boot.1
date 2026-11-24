Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C70606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1PSSHtir;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oIpUhSSc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kkmhTBAx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A76480F48;
	Tue, 24 Nov 2026 06:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37jmrWBXRMzF; Tue, 24 Nov 2026 06:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5793D80EBE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503165;
	b=ieJH6SIf/YiqYbMEUGPYshxxeGUX1n/EUO0cvHXHUT+9EtyXIZvKCYl7HxNRqgaNNt+p
	 AIcSS5qbZnz0kysXRkeUviRbMSVo2xCuejyH/cYa/CXvWKmdxqv0IPo3+dOZFaQg8auvA
	 NOjkL66bJR5HaAF0ufnAii305fK/fHRlvg54NyGbssW1Ctuo1IDimZxdnrNHiYOddnLvc
	 6kpIgNQoTALwBgWTO84JWLoTHlCPS7gnIxeqJ/aarnDvcus70xq5hHlvubd/xLYP7c3En
	 i6axR0Z65tD2d0wrigkhUhGhBI47fRua2joXAWC7YmJMGkwqjX51fQIG2+pr6ZD5yjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QLr6ss/OJyMx0pVBw740A3HyV+wzJeO4IbDS52UPDK8=;
	b=YnzcLOipwmKQJrTdJd2y/rP/UssrM+JWQXh2NE0rjdFdXgNYH6MacD/KToxNwyAzJcxV
	 PyZ1QhEjrNjvorWlxQ2rVJG1q20FKMT9jOgy0NQeQqNG6Xxo93TX2G58J9BV1e6tlSAwc
	 kRZ1Men2XBvvl7ktZe/5kPT2Xcgv06aK65ZZeeFTIXUjT8MXxJUroJrEhXyooIgGZ6kNr
	 mTwULW4wEAdN+xF4LJ9U/47MT8pB7iblx2Z70/fMC4xDjl0HPU3pIEpmviyG4vZGqXdQl
	 vkZ5SyfN6juD3AvUurO6Jr5wOCWn8XI4J7ODb76mTRjHwykBPVSR2j8FRiol7VffhIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503165;
	bh=QLr6ss/OJyMx0pVBw740A3HyV+wzJeO4IbDS52UPDK8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1PSSHtirTMqa+eGfmLTqmUmy3ocY0FlMtdX6etoCOxcv8G9+DWWazUQl7nIch25l2
	 xB+BXxBwLvU1u/FCqws4YrHwQWdbx5wmlAnjH6GclSGEaGlA1GcFZSi0zY+5+qVp+M
	 2cNTZixLOW9giWr3XAqMRuG/cPMdXeTg08/X8XsHhdjgRLL+w6Anke9okwHNKAQmsV
	 jGx1wepspYWPIOmrNvLDT0uZiT9QQkQe0NSvwgTryo2Dgedjx8Fx2s6YTTu+sxrObc
	 utGVq5r62Nux6LokUm+VXuz10PtIg7kvHxKnpUoodH5f+1Uiu4W2yJg089rUbW0VBx
	 MXaeTwFLrHVog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5793D80EBE;
	Tue, 24 Nov 2026 06:52:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F652FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA5D406E5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiiDsJlAb1Hc for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF2B94059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oIpUhSSc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kkmhTBAx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF2B94059B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:52:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2l82f016828
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QLr6ss/OJyMx0pVBw740A3HyV+wzJeO4IbDS52UPDK8=; b=oIpUhSScoLnIEJXA
 HWZy9ng1ntqKncJ9/npiraLBgJmfHIy3cGKs8WZX4RaSdIgi7pfY8Np8uT39RCvS
 hF2/gqR/o0hpaUfNsRgG+6Bl9k1frORhunsGHqijeVHCSCCbWmlqk5fb49OiCF3U
 nERvqu7nWwCe66Ll/z6gdgraPDXi8YWjRwx+rt9+igHND0fMNVTSZClmkAcMp006
 LO2YP1YaOT+sefKF4OPbB+udlR99yDUj+7Oq+A1ccGXW/tYhUWb68Vh0ku10we22
 e2sCkQ7xZCRxur1VL0u2fAmsgjkUkec+ReYQEw1nO2mdUar/p99Y/uO2Nf0iUj4S
 xCxIXg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4u9ntc69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:52:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso5883992eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795503161; x=1796107961;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLr6ss/OJyMx0pVBw740A3HyV+wzJeO4IbDS52UPDK8=;
 b=kkmhTBAxzI1PIwB/BtG+jx7Fg3qy0kk3YnUrnJzmfhqWef+pscIrSizjsiXTKMyl0L
 lCafrJFpWFQUo1A6gr0gBtgiO8onlGCNWr6e2kA3Ow5f4ixnuemUyNjHVLrPx8XSLWSN
 2uyGnWX/kfLD44Gpe5YzUztCttqaqz2372pZ7Nxa+dLB+MN3X3gvjxW54dKjLXc5dB7b
 UGsU3yvBRz5gWwrhdYnMnnrrM2iIMSqe9ecIngiRtO1flbAIFz2WaqS/NsHph2+vZPXZ
 Q4zau59diMcuGYFqvYYYsyJpeRaCurPX8w0I/Bv5bHhrOYgWWPJV0HXQP5fcy+79iy+r
 lTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503161; x=1796107961;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLr6ss/OJyMx0pVBw740A3HyV+wzJeO4IbDS52UPDK8=;
 b=cSv4BYKSo1QcPjEmBLRN2ONR/bXejMvcUqLBqwJtnWkhe9Vs5SnFYWTjZCvunuHMk3
 OQjNR3JYuvKUsJwzq26D3QompSXGgMXUtUvkF1UXSC+43w9fXWFf+SF0d1KveQ6Zo0Fg
 NRJwIHQq6z7hePDUUAicR4ejf5yVirvMtjAAliKMl/0h0Fl38V0MyKAP+13DRuzfhYEy
 i5OtsAfpTFO+KBGUcTaZ+uX4PMxoVH1lmtGqFvTBMfZ4RicuDzytWNf0Loa+3hHUqsfv
 LdP0PSkO2w5XlxYVjdSBm5/6YQk28VUKAWEp27PeC0v2Zns32JCWNQ3+xoKZXt+LY1k+
 kE/A==
X-Forwarded-Encrypted: i=1;
 AL+hErGNVHBJi0J7skLn8RMmhvRcsfd9vx70Yo0X/WZz2SuDvWIEytSxT0cqioxE8jpnFhJiJRUAvbY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/AU0qVZ0kOgJjoOBlqbUrINBFAG6j4TqAK090RgVfmI0jjqIVN
 8WlPv7l0N4BUG4gdU19iysIrKXU805IYOtK0tteLCkMPZm//+5YGgSQeJDqPdH28BQdcwl2U/OK
 KfwWlaSi8xQwZbpwvyYTfXF42VgKp2qMM6j4I0mVK2R1PXzteenblMuzkAKzgTEHbi/ATQzs39v
 tFeYqdwA==
X-Gm-Gg: AZFdTZdzovm4AwXbi/QH6NIZM1PB/6900mpumqdb/HMqJRavL//ZYpSI/FVJGy2DgKQ
 xDypYnV2aDD72TqMq9vMlumEWNYhiWDmp+5yO4rOg2V5UvMIyhJPNHvITiWIzBSgN9NjXsm3nO8
 mq8hWS0p4kZ4gAdpt0hJ664xpASC1wRKAkFGCScZqwK/DSgJzrK3ktIKCTR7iZKJzzPwHcPft2s
 ZoWaXaFosILTtyPscSft8xI6UdFfe4qz667q+fsa90XtatdO85tcfQFwm9xhX8ytWxDbuJhtaqq
 9cWN9dOS4difUVYN2e3K6qr8kiDOY7moWf+0vlca5Gxh5BHlO9HZYTOEVGiSvzSWtjUy8dGfZ/K
 hH9TvEbPCYCLLgyHWhjNyXSYMkhsAlzkd6/ufcqNK+cfTRPrtuIwh2gkz6dmh/6fbpSM9HU8oVO
 oXXgxBStttxuNgew==
X-Received: by 2002:a05:7300:ff49:b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-38570c30013mr12095423eec.30.1795503160699; 
 Mon, 23 Nov 2026 22:52:40 -0800 (PST)
X-Received: by 2002:a05:7300:ff49:b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-38570c30013mr12095405eec.30.1795503160137; 
 Mon, 23 Nov 2026 22:52:40 -0800 (PST)
Received: from [10.218.31.195] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm46376310eec.24.2026.11.23.22.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 22:52:39 -0800 (PST)
Message-ID: <0ad7e3d2-a959-4ea2-abdd-2016268a2ee8@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 12:22:36 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: dwc_eth_qos: support 2.5Gbps link speed
To: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
 <20261121063919.3313168-3-mmanikan@qti.qualcomm.com>
 <125233e1-41d4-4052-b832-d340fe8aca43@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
In-Reply-To: <125233e1-41d4-4052-b832-d340fe8aca43@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNyBTYWx0ZWRfX44t4S3NjqZNF
 YeKL1AoVupADbDs5wTDSimspWfooT2OeuGVJPVse3opyymVQI5djkQamRYPQx/B7+6YEx4+XUl0
 rY3AkrhLTgaqcRLIXP+3kKcltuuYdjx03KRzYZIA8qOOWsUK2K0JqIBvP/GpIHIgsELeyYBqZZG
 ALnV0pFJhZutrU/mkR4UflX05APc9ZDPLjSZVAAz2lcfJSR/jxhIbj8PrfI9zfxEce6C2Tvt7oG
 dfKjJGE/sVbODt1DGPYqTUifjus8hRenFPutb2vvAV7wJrrCqnn2WyiEaKMM4WuBNd0Rb4HlV9G
 q8Rc6J2w/bc/MrGnAAt5i0YXdLGeHBAPRpclnsM3O1M2ybLgvgVBuUqhydL5O4Fd1o0zn6gjGU/
 WdMUiAuqVQeH3v22ECSfAVxGKm+5Klaf1jzxw/zF/sLjT/+m1kGs9r+0ZUlDPx2B8J2011oQ8l/
 LIeQ4C853SXy7Qy5k8w==
X-Proofpoint-GUID: wnwQvxWP_bEelQYYxH-S7NCPsrbZ6DCL
X-Authority-Analysis: v=2.4 cv=f4ndl+yM c=1 sm=1 tr=0 ts=6b053439 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=P3xhLHcwaEQxxf0w9uIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: wnwQvxWP_bEelQYYxH-S7NCPsrbZ6DCL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNyBTYWx0ZWRfXxBGuElNZZG9B
 UVnOp6BFo4nWUEDv+v3lJ394TUE+aQdoiPbu87f+PPVBsLWjv8ehL5op8/5oFYSL3LSE29g2nQc
 K3iFx1Ad1XmRlkghwaCV1k3+ZQsGSM4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240027
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



On 23-11-2026 21:12, Gopinath Sekar wrote:
> Hi Manikanta,
> 
> On 11/21/2026 12:09 PM, Manikanta Mylavarapu wrote:
>> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
>>
>> The MAC port-select and fast-Ethernet speed bits use the GMII encoding
>> for both 1Gbps and 2.5Gbps operation.
>>
>> Handle SPEED_2500 in the generic link-adjustment path and leave the
>> platform callback responsible for configuring its clocks, wrapper and
>> SerDes.
>>
>> Signed-off-by: Manikanta Mylavarapu
>> <manikanta.mylavarapu@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - No code changes.
>>
>>   drivers/net/dwc_eth_qos.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>> index 6f158202124..de06bb46151 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -557,6 +557,10 @@ static int eqos_adjust_link(struct udevice *dev)
>>       }
>>         switch (eqos->phy->speed) {
>> +    case SPEED_2500:
>> +        en_calibration = true;
>> +        ret = eqos_set_gmii_speed(dev);
>> +        break;
> 
> Since both case statement are doing same functionality can we write
> 
> case SPEED_2500:
> 
> case SPEED_1000:
>     en_calibration = true;
>      ret = eqos_set_gmii_speed(dev);
> 
> 

Hi Gopi,
Thank you for reviewing the patch.

I will incorporate the suggested changes and submit a new patchset.

Thanks & Regards,
Manikanta.
