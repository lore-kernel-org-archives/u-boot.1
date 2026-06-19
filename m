Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F77CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2175E849D1;
	Fri, 19 Jun 2026 13:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dw1e6v4L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gotEOpNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B271849E5; Fri, 19 Jun 2026 13:17:00 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB34D847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7OhtU1104952
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jNB3icaaxb6A/CztbL9qMB1R1dBg1OND3Aub01JzNPY=; b=Dw1e6v4L4UfajN24
 ErsS2437aeEWAroj048+RrAF3Ef3pmrtkSwRCCBQZZ+b3qdkhIQ1XJ1zg+4DkHBU
 5ch6HmYNK0XEFxHQPJCoQ2JIoXA/5U8FG2BjvTskDiP5+wBn22M+NHqvy4g8rc0F
 xqWNH6mDlIbEAEAl3YOhAAt5y40DK9aerRc+kYFwibKOaH6rlDbqIGyHuBd0nwoh
 1YngjKn/h+MdGYXVXIlMpru1+XetOb0vuArVeqqj5ETSvzL8vgTcEwhb4tsu+lmt
 kwUYK5VaVAcS7AdtBN13oCHmWKCvWAM4Ge3MUsYm0SZiwcBaL0EpPEWQ8y6Fcu+E
 rwNtNA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evgtmmf7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:16:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8428419982eso1927561b3a.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867815; x=1782472615; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNB3icaaxb6A/CztbL9qMB1R1dBg1OND3Aub01JzNPY=;
 b=gotEOpNT0bYFGncfy5lZj/hCmz4UQXBKoO+zRyXCW89ctpOR49jiOqlpf/I6EDOpFo
 WP/BvxCf+FdgxfNBsJpv+n7cKFPfjJ1OkxTXmeKfkVLqWqLywH7VkMgH/JRnBScE0JFn
 0G7rG9qQ/MMwW3JV9ilrG1MAqlDlf9ZOTH6yDkcHcU7/Wx1bB403FFoPgKv07dYv0Wkx
 YHmtZqhsKvROcz+0iPXyGFyXMQ4Y36eslvAGMkYO907nA8bYZVieqM6LMTcuHaTftaMb
 q6oK03Entpn2iA/BRutp/doONSKYBcI4EwMMwY2ItDMM26wNGUIkeHzCFFAhe7v9MUNj
 NEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867815; x=1782472615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNB3icaaxb6A/CztbL9qMB1R1dBg1OND3Aub01JzNPY=;
 b=nioeGU+XJyhF5OFZWzkHtiuGLBBxfKmHXgkWDrFmRn2I4VENzkFuR91KRdNnyKYzhd
 PeyqK7MtoKYwC8Rq+rOv3wJ88QMlIf2Fjxn+oHF6ShP4fjJTTlEdyfxoSQrGNB5zBWVR
 lWhzK5Z4A2No252mNa8W5TZdUCaL1KT25l/yopCWRKS8s8vE+3RdqAmFYxKXrwNwYugS
 eTGetaZC7LcDDojfcSurpl3g6n0noBHswKU8spNLQr18/bPgYw+jtmGHJ7CPXMxDqAHk
 qsklUNH23V+jFpxZJVblzJ6RH8wUyz6a9lzhJsaVONbNWzh/QHorGI+y7nG+GuJbskAM
 B4ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gq95Y57JSS2fvY+crLjJZDIVZR0XbCsJZ5wSs2olnQnXNnlkY5WrZO3Ocwm2pn63MJQg4YC8=@lists.denx.de
X-Gm-Message-State: AOJu0YxVRQ79aPDOMH/pqYHxksUeP44pofGqeszn/1akPtvOzfcXoGhg
 16+KQ1kt3LqJ89GeWGA+RJilak3oJL0mkc/fnkiH5VmKkqnOhumB5ygEarNhyMlXc3/HkOKbCkW
 rbKz/Q4k+9tEhytoIPjOlg+AaQPSqnxPn0XO0SQ7XJMmN2gyJvCt7plJa
X-Gm-Gg: AfdE7cnVxTz///d9mQlkYbXSZSnZU4DdsgU7Q5xIzrOf1aNQ/H/8mLDPTaPopvzTr4j
 H3FKRPDzwqCK/8h5/pQbFUAyz/Twc+dxO2iqzuRgYKQZqkJIAEsVi6Zf/B3OnxQ4QY3BlU8r6Wp
 9AxYoCgQ3Je8+wfmtQeY7lClA7kE+nMjy74JMdZm8t4amuOxurmsueJOhqIsEZdeMT53MlgLDcS
 ruGz984HT5gvVbaRO2PD1CN/kmQxdun6/nS0LurmeNWe8Nco6v3evjyI9CsZYpeeLIui43NIl9m
 HUbBzozCjYe0k62atyFF5Ioqg6YicPvdUh4EnOnLhk35+N6NtlpwZqtCqUZRrsmlo3pE01uBO2s
 5QzPiL7Ymxxi+6z5gjTUY1zn9n5LWtjBstFZqtJzMqYqUWj+j
X-Received: by 2002:a05:6a00:cc4:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-8455079e772mr3996505b3a.3.1781867815301; 
 Fri, 19 Jun 2026 04:16:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:cc4:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-8455079e772mr3996471b3a.3.1781867814873; 
 Fri, 19 Jun 2026 04:16:54 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455382586fsm2119198b3a.43.2026.06.19.04.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 04:16:54 -0700 (PDT)
Message-ID: <75c644d2-ac2b-46a5-986d-6e5557002068@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:46:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
 <tgqh8m.i5334p2b63jo@postmarketos.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <tgqh8m.i5334p2b63jo@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9XD3cmDTuCwK_r8qpsc7TJ58lwi8wZNR
X-Proofpoint-ORIG-GUID: 9XD3cmDTuCwK_r8qpsc7TJ58lwi8wZNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX8zXUDMqqFryG
 jB/EdhtqPNVSxx0SayKgsv7ZLOXIHQ25E77pRWBtbbOJ+vP2mpWHQfJH1jhsEM4deWoY1Ym7ESb
 JD0eL7B7FqYOU5RrcTpDsb45umpoM/KqYqb0IaojRnzilQ3xKTcyS/I0Y46cAt0ThTP6S4Ocd2d
 eUedRX5K92UKPW4G+DWbobsloVbcYymgp5MqLt1PmjdRV3jbCoUACPtd3fJLx1Jz5G7mcv529wp
 476VoPiXukcaA1dydpN5WJvYpY26w+EKDqLBqVCsNZKToO/XMl3A0p3LBk2ORTsUd+X0F7Mmlbs
 zVWXv7ctI15ttOQWRdoOUkHcBJEKkyUFbcADxiLRbOW4yQ8GtlcUn/UmO1Z+Tj+tXWWj8+1+wn9
 TSVDwdptl82QuASeJGXDoaJN1zqIq6oUh0IohxGo1pQ+WzUfTiuPCKHzmQY8t010CsAV/W13fiV
 JCTl59lhzHmh9kgeQGQ==
X-Authority-Analysis: v=2.4 cv=Qb9WeMbv c=1 sm=1 tr=0 ts=6a352527 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=l0xRoyPhJoKGvZmW1_8A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX0UUUO6F1ybQa
 Ppui56dNdt+2iOQeluFTlvDzstCjKKJByeKasxy/+F8ZcxWHoReKONGFQBFIncWbHo96X52abIq
 jKin25i498iFe/6nU6gJ1nZJDMwS/uc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190105
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Ferass,

On 6/16/2026 10:12 PM, Ferass El Hafidi wrote:
> Hi,
>
> On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io" 
> <casey.connolly=linaro.org@groups.io> wrote:
>> Hi Balaji,
>>
>> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>>> This series adds support for running U-Boot in snagboot mode on
>>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>
>> You didn't respond to my reply on v2 of this series.
>>>
>>> Snagboot is an open-source, scriptable flashing framework that provides
>>> an alternative to the proprietary Firehose protocol for device
>>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>>> and execute bootloaders. However, instead of using the proprietary
>>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>>> standard fastboot protocol for device flashing.
>>
>> Glad to have some more info here. Please also add a doc page with this
>> information as well as a list of supported platforms.
>>
>
> I suppose they are talking about this snagboot: 
> https://github.com/bootlin/snagboot
>
> But what's confusing me is there is no mention of any Qualcomm board,
> nor any PR to add support for it. Is that in some downstream tree
> somewhere? (to be clear I'm just someone interested in understanding
> this better, snagboot is a very cool project that already supports
> plenty of SoCs and it's great if it has or will have qcom support)

Please find v4 here: 
https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/ 
whose cover letter has more info on Snagboot Qcom.

Regards,

Balaji

>
> Best regards,
> Ferass
