Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99ABC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78B7D407FC;
	Thu, 23 Jul 2026 08:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1PVWDgnMz43; Thu, 23 Jul 2026 08:38:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C73B407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784795926;
	bh=k0acL32mxG/FnYB9BsrOG1z0gTA68zZEAJaZkZn8O88=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vhoEllU5IuKlLGPhX/UM8SxQCPij4pf0+HoMNWN8xh9JY1KwCKgwNiw0Ogcs23z7f
	 QymyCwcsdr2Hi6o4i6t8NqQoLgbSZJlp9OElJsrE2jT44etlS8lL08P81bdD/JaJ/m
	 etm2G+u/WEwInOw1nw0h1sMMq2hDG9pxLzS7fJfWLSkVVKOv9BTCYXf+EdYoHoFPQq
	 eUVqcb8F5FOZUFw2nF/fWRE0fdL7t4UIFEenyCYfsEgnsDBueyGuQ2fpmo/clh1UA9
	 4PVj6XZQFddZxjox11to2oRqlQJ2KOdtWjch5vinuxDYzAxhGLzVkFACmqum+lq1Hd
	 pYCo0Pwl4iE3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C73B407FF;
	Thu, 23 Jul 2026 08:38:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23E18786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09C3280E16
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4sXoddzvHP6M for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:38:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB7DB80DCD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB7DB80DCD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB7DB80DCD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:38:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BelI3372289
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:38:42 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qgbx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:38:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb5cc1e13f8so601199a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795921; x=1785400721;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k0acL32mxG/FnYB9BsrOG1z0gTA68zZEAJaZkZn8O88=;
 b=LVfNXpW7t2NhPeR8+lUAeWY6nGaWgpviwRkTGPy1ifZD24JlF7yA001OTabyFIlJzh
 //mzbH4djLijni/QpCTwquHepr9NBTe3twZNFzWynKKwUUqEaG4+CwlNguEajMzdvKbc
 U2eeX2wBHqaKlFvPSlpdBc4wHzjNWVBiwdp698IHOxk1D/QjgL+UJXYmP/A6A6KAJ5sy
 di2nV3cighJnqng5MV2RSpyEopOR06/7LZKKwLurJos3Go19DQbtkLtrvH78yewqCYwX
 mx/Opr56q9N3FXtEWvE5q7Rl5X1IQ+rto6VIp9EKAARjJsGVZ0CW7E8u4Lwwh0lO5fde
 llkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp30UW2N7/tKR7RkHLCEKPw78I7hC5K2zSQ2T86DF9wQjx1dW46rkwyk4+hZliItAgSneaDW/I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzmK4M409SM74F1Av+bqDtwqKY2ZlaF5Q9CpjkAzUJjfFNrCchO
 hM9QfATr8inXj1l42LvabMo/bFy2dGYnDFlpEWIbksW/w3ji5h45kCLF6ZF4s8P3zMujD4tdswt
 UYoNkLXZTHYX9patEom0UhjvHNh3uTSQXcvSEAoSFmHgwxlAr3p5cNEK18MIUIxUdB/IL3q8=
X-Gm-Gg: AR+sD10x+1CKLqUdP/sqq05Kj8qO3jUMmGxdyoe0O4aD2NX6sapNKpRU6pQnwWQNqNG
 ECo6m6H7hVRvoftHUP06eus5pCg9gOB/7hr4fqQl+g4lXPPSxbUzyIqXsaBULyr+KKywZe/I1Y4
 SXoKGxSrDTxx7fRL0Tma+Abla/jTDH39UYWslxW+kTxwQr9uFcQs2p882VRe+821uqltFveleCv
 BqUZ6z4fb4+0r7MUrlTOlyTXpQe7Qc3A/mk9AF6emzlkvbU8iOkTWzLShz5o2KxRGNITiY4upty
 nYig2t1AenP/DLDh1iaaVtrh7A5OHW4GCHhcxpJDkZlP+dxTbUvWFpuf4DqBSe4cYE2oBS7aHKe
 qCN743NdhSG7M3+upA4BEezRU4qG/3kY0PQ72tGkjBAjXG+w16f3y/5whKBx7mYagjmSCrvsFIW
 2hXr65KE6AFDpRGzI/4DNY3BT7KyIMsA==
X-Received: by 2002:a05:6a20:160c:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3c44b04bfeamr2407442637.33.1784795921523; 
 Thu, 23 Jul 2026 01:38:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:160c:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3c44b04bfeamr2407416637.33.1784795921088; 
 Thu, 23 Jul 2026 01:38:41 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130ce035sm13757118c88.13.2026.07.23.01.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:38:40 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:08:35 +0530
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
Message-ID: <amHTC79JtCHY74o8@hu-varada-blr.qualcomm.com>
References: <20260723-lemans_emmc-v2-1-f6e679e58fe0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-lemans_emmc-v2-1-f6e679e58fe0@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NiBTYWx0ZWRfX0H1UYe/9WI5j
 ITHDJ8Byl87IIg1Cu7H1FaS2qn5NKhc3yPz5T2ycz3BeVUpn3TpBaNAKLMQ/qgzZWVIl5LRrBkQ
 v9RoMIRKcyj/vpqN6pBFNexg8Ezvs8k=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a61d312 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=qHVH4p2Nukcz2GPqPtsA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: YBvQF3VoE0JvI-Ncv55Epx2Vngd9lZvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NiBTYWx0ZWRfX/6W2zNTQbTeZ
 +QvnmmrdBvHUSIOZPWutgqLMrwVttJuH3Dd8aOlCAL4i4KxbO6DCT7e1C+EfuWP1cyymcH3GMtj
 ZH8nXdfdQXpme57LEsORL2Uw3lZCuGJXBAiIebWU6w41/FK+Rc6HF4PRfwR142AkT5h3OoyNwga
 Z3BowyoE7m1Jgqwyhj78IMOwPA9k6CCX/6hY6r6k4qxfoqpbujQhjXIzlpcEpmHm5i8yfvMAPQf
 blCkZ7Qzt7SsxPyqCPY4gnF6rQ+laLlKTBL0p35jcAEEwuGrbk3k0909FhyGfaguwkhEfAVCEcb
 bRYhpRBotRPFU/N9ECITDtqeKDSDRqhkq+5RO4OjANRlmEOVvFRjjvPH6q/gmR53lClnnH5uKYK
 jQdyt14Dn1sslg8Dkp+w+E7WXe4K3kTIGxV0TQc6nng7gLmwZsQgwPvHXklBg6VtDfht3Dsu1kd
 Xn8HeIn583XVdv706Xg==
X-Proofpoint-ORIG-GUID: YBvQF3VoE0JvI-Ncv55Epx2Vngd9lZvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230086
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k0acL32mxG/FnYB9BsrOG1z0
 gTA68zZEAJaZkZn8O88=; b=UL0IeMWC8Iw7PoC13R+t+Nrc8E7jbvY2as+fNy0f
 SnjL0wA8zYfbws1MOV7fsny/0Q4RcemfzzA8G+/9mQ67y9TKPFaXPR8kfGalaTlp
 DLgODyB18cA19JfStRkR8nSyyOitbSjz4gewx4ROG95V8fKpwVZG6bxoNgUf6iQ9
 vihyfNKXuW8yQn6wgtHIkQwkOpurjub2XxisKKho95vOMC8EqmKF2tv/xMrkGkWD
 PlWGo3Crt8uznNEeo+M/3FZXkIOE8LdUTipBkuZj6dvbY9HP/pIDet4nWhRS1jlb
 7g7OLJ6+vH/EI+ZSRY1owMwncn43wZhgX5PdjmktbiPoLg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795921; x=1785400721;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k0acL32mxG/FnYB9BsrOG1z0gTA68zZEAJaZkZn8O88=;
 b=OSeRTjK+0APUmIDiNpn0PUA2C6yU6L8x22BQY+S8GsZ/G4/pzoY7F2Am71jL9kHH6c
 2bdCqxP3n/St7ucLOOYrEhckvZBFhnx6TfMJebRnmrZvrCTtZRuUoQdTIapjMvbM+u+j
 YfHCc/Zxdb7ZNrHBB23Gm5WgjtXPCfIinih1SCBFdjEh9ZpJSsaGu2Hj1guf5zDbwKH0
 bORFHYrr2sfGQB300EKD5V7x5bs9/NCsWiJ0RpTDMwx+zPDFmrGiESptyYezYcZ8TTaV
 x2sqgqOqWHPAHqShOk/VunuzgiWOOQhNe99boIfWqWNgMP63hcSuC2aqKuyZIYyiMJwq
 TLzg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UL0IeMWC; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OSeRTjK+
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 12:37:28PM +0530, Balaji Selvanathan via U-Boot wrote:
> Add support for SDCC1 (eMMC) clock on SA8775P platform.
>
> This patch depends on this series:
> https://patchwork.ozlabs.org/project/uboot/patch/20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com/

Shouldn't this be part of change log?

-Varada
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Use GATE_CLK_POLLED instead of GATE_CLK
> ---

[...]
