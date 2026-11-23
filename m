Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16467606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=03K7Puv+;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gZ9Nl4Xd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlXywLPy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7401A80D85;
	Mon, 23 Nov 2026 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdDcu1xgXYgX; Mon, 23 Nov 2026 08:47:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A68980D7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795423671;
	b=ArpEK+a8zDqo1fpcsjckyQAHdNELAL/lz7WdXaSGprfRerQ/SZrJMVpJBbCsD343KOhK
	 2xceKT7GmOg7/4gqbNOXOz9RnuyCXFVq2ROk0SjjRV1e82pKe9fNYWcG7FGUfrScvWxaO
	 9WzbOSX7sUrjc8GMJOCUrTXsC1eWJFPi447WJwuOZRytuUwVEmrm2/uKkXTOSmyHiEfaV
	 yWYT2F+Zlqhn1LzVj0a3zzLXxOuQC9iJ1ma4i1pLFg0UopwEApazgdb5/GPphhdmMfzQ8
	 ay1+ABo6ovXqyr7mer8nV/Gg8nwVY8DwhwrggEOdruHj77rxyWfQZesbRGo6AzI14cQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795423671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DpduOjuTKOs+fFRn4PHeDbEwF1YKu/YYY9s4yWXcJTw=;
	b=mcpblRKPno4asN7+F4fGhKLVqdiD9n0P2Cj/Tss8JonFeu5Lb3ZjEpYC8zcPzMBMz447
	 /je/UOTj1wrPecktC9kD/aV519PZNYxaQv5hJnsZ9WX2dnfRBQ+E3HXoT5RJ0bcTzPYGq
	 sud6QbE02usjyuIrmQM/uBp+Rzxz7rKd11RaeNRH8u2tOJbOTa6EqA5CTHefWlROLJ2up
	 A3cjqA5u8IJBctpQNagrLC//L+dF1hKgrjpJgjI3WRVMvirvvT/UxcXFY0PqsNUPwGurH
	 dSN0XDRe2xO8PP+XLdRECEHtZ3N7HPWPucCMl5rqJCkr+hEpr18KYEohz5s4ajaE6nQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795423671;
	bh=DpduOjuTKOs+fFRn4PHeDbEwF1YKu/YYY9s4yWXcJTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03K7Puv+zcqBG7FA2vE44+iCOPpdsgUWQLivTDC5+wD5Hi8psBnzkVty2I0GexLwe
	 8ccGzWM6L+ZVYPtvYXZaBTWKsdgmLq2Ey8WEK+/32hSsllDE7N1IteN8h7NpPmZgWK
	 QDkSupJ664alMdQ7l/UMZSbY6q7m446A+Q0uqNPwwi5s215YhzveuX0BtOuv5flitR
	 vR3X8mz02v4tD+UdSm8TAeT0ImugqsQk2IXzOehR1cUlUJ3Nl8nR/FtBDP2C5+1p/p
	 qrmaorV3S547E44+41klTfXwQSZTlyWVGVhH4+nOqvAhWygg72kT/rUUqIcUracIpk
	 S2eBPo9+vDc/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A68980D7B;
	Mon, 23 Nov 2026 08:47:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3202499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D498540063
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f93re8cwryDI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 488784005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gZ9Nl4Xd; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AlXywLPy
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 488784005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:47:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN6998x1011264
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DpduOjuTKOs+fFRn4PHeDbEwF1YKu/YYY9s4yWXcJTw=; b=gZ9Nl4Xdx1y8JNzo
 4hayXMJVELodxtyx7cOlDBhUEnrNvgGkgC/VnxkQL2bdPPjfpPNl3N42HDoudl8a
 ux5BQZO/9X1i3viB81vB7APXnbwkaddvsVX5kpg0q4BO/7YETIQgv38obkvaHaPM
 SQRKchW3uKq6+4odLjBDhhsHHtIlDBXdT0b8/UJxT6F3vdvbtY4wmmwMZ5bHFaRH
 +u0VH8Dk6OgnCZbvEkhqJklOqwoAnXiA5siqXB+YH7U8NJeENwyPvGbthSAEi2cG
 jw1U4lqO7SJK2ec2pAYYyqWsLsy5Jee9Au2pHnHaMhMYIH1A7hJPcfTevRsR8c8P
 x+bA+w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyh0hea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:47:46 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b4fc2d32caso43208147b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795423665; x=1796028465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DpduOjuTKOs+fFRn4PHeDbEwF1YKu/YYY9s4yWXcJTw=;
 b=AlXywLPylNyvXJaMTwSnvbS3DPyoU2QJCnHFgCYpY5HBbcu7uipBjl4jNjHP6or5qi
 SvHjgNeyvN1F2h/5piJuNKPZtfOlkg3FLakvszynLi4ZcvuaE3iGvzpj3PKRG0fuKi2s
 t+rLCmVdscCasELnQUE7On4N7tl3olrnOTj+RV9CnrRnvx5DuEaFWUSh3M/DBQixj7QK
 4CQOXuLwGCrER5IAo9LqGfu+oS06gnR7oH3PZas8nTb3yhGTtKQRimCwOkPEg6Sk1MCC
 SdbnnaxJJP3hGlBIpe/nOPHAPLtAUqUER7d8lQ1sx+4W6bxCzAv8twgujb5yXxpjnlQ3
 r8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423665; x=1796028465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DpduOjuTKOs+fFRn4PHeDbEwF1YKu/YYY9s4yWXcJTw=;
 b=pMjN15BBYKHkJ+Dw5oHJw7bOQn+KTZksdr6WLjJ79XAVJP0IFbyaDgpgIe17aE5Cb9
 Qnq/7FLN8y3MUYjrvsEd/t9mT/vnrIn65Y7ixiu4rjtpAbwzV6WKgOFMZYliqtWBxbbQ
 3gKWJeLybqimu+O+JESXQ/QGujf7x7u+mTc0L14UwfsylirH7+fwxUI1jPwMgsyjBe94
 v2kinB/zlCxLDoUqF5Tr/e2/leMDmflDlAsju9kphMo1wYKHO4R2yI/0p22rRGhWGPb1
 hJ2RRw3cCsV1apoEANEnE9lQEUtB88oqDqEp3IZZahzq7CUCgWQIMoMNjfnF+QGMUA/A
 3pXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHwz406fK1QZFEdjj1XAZx/gzFZwxnyTEfspSBPxPUygYIc7ZjKQl/EG+6hKaCy3X0jlOAMqP8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/7U33iJyOu+lIyBQVaVjGGDt3E/MMF3x0TzTfr8ERMiEzn8/73
 Xx4sST/y/qcPUToECXReYtF5DIaJCG0BfC2xXjunu9ddfXUBdlaThfeAtJFVMw4WamSSF2DgiVY
 JQp0zGzOK1JR/TcbK7kkDxRiKujUlgdh3coKSOTO1MkKzPLm/A7Km2LG5gStqGNS9V0dCqvCQJh
 VBs+aGCHxN2Vc08dcczQuttcB55NfQqOIliJu4FQKsZZ+YMA==
X-Gm-Gg: AZFdTZe9i4qZEPNf5mWEt7YHhD/lNsl6l4Bbu59hb5TrqenTR7Sfsdtdb+D4tiZaChl
 iM+HlKmsBRj3tsnmzhDG5LfQ6PURWi5eT8jBwRHdcvLSQsfc2Odjxo2sx4KIt5iKzASFHkQX4Zx
 0MMNMij3zKMPOVzrX2Q5hsJ3Z3qln0TtLBEQ0XI4+yXgJ2LHYRgW7icXU=
X-Received: by 2002:a05:690c:630f:b0:8b4:dfc2:be60 with SMTP id
 00721157ae682-8b520528bc4mr37248917b3.107.1795423664781; 
 Mon, 23 Nov 2026 00:47:44 -0800 (PST)
X-Received: by 2002:a05:690c:630f:b0:8b4:dfc2:be60 with SMTP id
 00721157ae682-8b520528bc4mr37248777b3.107.1795423664285; Mon, 23 Nov 2026
 00:47:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
 <awCou-Ra_Rldo9N5@linaro.org>
In-Reply-To: <awCou-Ra_Rldo9N5@linaro.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:47:32 +0100
X-Gm-Features: Aa3M54pEcKHHen5Ag8LlSwN3EWBKKuVcg7_bCLZOHW7NBk-Kim0cXv0I4llTjQA
Message-ID: <CAPzfCAZik7_3hBzyMuZ76JG2WjOGTaaRLSec21HLYHWEDk_TEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NM1AaE6g c=1 sm=1 tr=0 ts=6b03fdb2 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=7dGBj0FaR_FGNNHQhq4A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXxm8DlE7jbZC0
 3/L3jl5MDwA8KpQE9d5I2zKJArUgnqbYcn66zYEZpeqqDGNR9Beozx3KBHswAa9NMMHQ7Y4Qkve
 z2LblfzcVtgjCpN2d7wMiDabKwLh7Wo=
X-Proofpoint-ORIG-GUID: aIF0cz0ZuS5ntRzEQ5GTasmMGiViOqJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX5cNNTt6QZHHA
 43AWgji15ocPmoh1mwPqfiQ80R7+FYuV2GhWk9+KNI4rPQUbesdtlD6IsY+6aiuhwipEY/hY9Dd
 xHl1G3xGhMStM50P5vzfVLgEdhe8Vamk3t5ss3gtrbL6CglpTa5oUzeMuihUEBjiEXyGQLIt2Y9
 eaDhlZnnj3IDZbI9O92jR09/IWKMfy2vhBt/plVkrFGij5T6qxfNBQHTVaR5R7gvuRaWsDr+2SA
 iJUL+X3DUK0Q6p2mBOOBp4aP61HX9H71KBYsJYdqVSb3WLPnS24xU//VTKIiSRNEfqfvP6q0QRD
 KSXgTdXCj31vqVuswFuA73PEiMIZEX7gEExTRG6EwMDllHuDbKcFjI9ZZwyN3ZR2d01fEhgfZkK
 OjEP0eKvkS7rhvoZx9pZb6eRhyeyjUkWYfoZiYWqtGe06wtHdv8zpbA5BF7p7f6BbbE//hE5v8o
 QBBUOsxpGzSPnkfYzCw==
X-Proofpoint-GUID: aIF0cz0ZuS5ntRzEQ5GTasmMGiViOqJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephan,

On Fri, Nov 20, 2026 at 9:08=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Fri, Oct 30, 2026 at 02:57:00PM +0100, Igor Opaniuk wrote:
> > SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
> > after every command. msm_sdhci has set it since the driver was added
> > for APQ8016, back when it only did PIO; the commit gives no reason for
> > it, and the Linux sdhci-msm driver has no such delay.
> >
> > The delay is invisible for large reads but dominates small ones. A
> > multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
> > on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
> > about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
> > chunks, spent most of its time in udelay(). On the Arduino UNO Q,
> > reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
> > (dd if=3D/dev/sdX of=3D/dev/null bs=3D4M count=3D256):
> >
> >                      host throughput   time in eMMC reads (10.6k reads)
> >   with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
> >   without            201 MB/s           4.5 s (~0.4 ms per read)
> >
> > A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.
> >
> > Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.
> >
> > Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
> > - on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
> >   the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
> >   computes from the same blocks, and Linux boots from the eMMC;
> > - with the "qcom: Enable HS200/HS400 eMMC modes" series and the
> >   mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
> >   the ums numbers above, same CRC32 check and Linux boot.
> > Not tested on v4 controllers or on the boards that use the driver in
> > PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> > Drop the 1 ms delay msm_sdhci adds after every SD command. It costs
> > 2 ms per multi-block read, which capped ums on an Arduino UNO Q at
> > 46 MB/s; without it the same read runs at 201 MB/s.
> >
> > Testing on APQ8016/APQ8096 (PIO mode) would be welcome.
>
> Please Cc the board maintainers (me, for DB410c/APQ8016) if you are
> looking for feedback for these boards. I found this patch on the mailing
> list only by coincidence.

Sorry about that (I relied too much on get_maintaners script),
and thanks a lot for testing on three boards anyway. v2 has you and
the other board maintainers on Cc.

>
> The fact that APQ8016/APQ8096 use PIO instead of ADMA is a relic from
> before ADMA support was introduced. ADMA works just fine in my tests on
> these boards and makes no difference for the following test results.
>
> This patch works for the eMMC, but it seems to break SD card detection
> on all QC boards I tested.
>
> DB410c (APQ8016):
>  - eMMC: works
>  - SD: broken, CMD55 response CRC error
>
> DB820c (APQ8096):
>  - eMMC: N/A
>  - SD: broken, CMD55 response CRC error
>
> RB3Gen2 (QCS6490):
>  - eMMC: N/A
>  - SD: broken, CMD55 response CRC error
>
> The symptom is that the SD card is simply silently not detected at all,
> I added some more logging to find the CMD55 response CRC error. AFAICT
> (without investigating in detail), the following happens:
>
>  1. In drivers/mmc/mmc.c sd_send_op_cond() U-Boot sends MMC_CMD_APP_CMD
>     (CMD55), followed by SD_CMD_APP_SEND_OP_COND (ACMD41).
>  2. The first CMD55 and ACMD41 succeed, cmd.response[0] is 0x00ff8000
>     so BIT(31) (OCR_BUSY) isn't set yet so it polls again with the same
>     commands after 1ms.
>  3. The second CMD55 fails immediately (too early to come from the SD
>     card with a CRC error).
>
> The CRC error seems to origin from the previous ACMD41. With
> SDHCI_QUIRK_WAIT_SEND_CMD we wait long enough after sending the previous
> command to clear the CRC error before the next command sees it.
>
> There different options to fix this:
>  - A retry of CMD55 in case of an error seems to work.
>  - Maybe we could check and clear unhandled errors in
>    sdhci_send_command() before sending another command.
>
> This extra diff that implements a retry works for example:
>
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -674,7 +674,8 @@
>                 cmd.resp_type =3D MMC_RSP_R1;
>                 cmd.cmdarg =3D 0;
>
> -               err =3D mmc_send_cmd(mmc, &cmd, NULL);
> +               err =3D mmc_send_cmd_quirks(mmc, &cmd, NULL,
> +                                         MMC_QUIRK_RETRY_APP_CMD, 3);
>
>                 if (err)
>                         return err;
>
> The real question though is why we are reliably getting this CRC error.
> It might be worth to investigate that further. I would expect you can
> reproduce this on any QC board with a SD card if you want to test this
> further.

I looked into it. The UNO Q has no SD slot, but the same thing happens
on its eMMC, only hidden -  on every mmc rescan the first CMD2 after
the last CMD1 fails on the first status read with INT_STATUS
0x00028000 and then passes on the MMC_QUIRK_RETRY_SEND_CID retry. So
the common factor is a CRC-checked command that follows an R3 response
(CMD1 here, ACMD41 in your case).

With a status trace in sdhci_send_command() (card clock 188 kHz):

1. INT_STATUS reads 0 right before the failing command, even 10 ms after
  the R3 response, so clearing unhandled errors before the next command
  would not see anything;
2. Waiting before that command does not help (50 us to 10 ms, all fail);
3. Delaying the final status clear of the R3 command itself does: 8 us
  still fails 6/6, 12 us and more pass 6/6.

So the R3 response seems to leave a latent CRC error that only a status
clear a few SD clock cycles after completion removes, and the clear
done right at completion comes too early. That is what
SDHCI_QUIRK_WAIT_SEND_CMD was hiding with its 1 ms.

In v2 I'll add a patch that waits 16 SD clock periods before the final stat=
us
clear when the response carries no CRC (CMD1 and ACMD41 only). With it
the CMD2 passes 50/50 here and is sent only once.

Unfortuantely I cannot test the SD case now. Could you try v2 on one of you=
r
boards? It does not include your CMD55 retry you shared, and if the delay
does not cover SD, I will add the retry you mentioned in v3.

>
> SDHCI_QUIRK_BROKEN_R1B on the other hand made no difference in my
> testing, I think we could drop that one (Linux does not seem to do this
> either).

I would do that as a separate patch if you don't mind once I have run an er=
ase
test here, since R1b commands then wait for the data-end interrupt.
>
> Thanks,
> Stephan

Best regards,
Igor
