Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ElXRKNOD;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c82zgMeG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C77bS36U
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98CEA60789;
	Mon, 23 Nov 2026 15:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id euTBnnkZkrlg; Mon, 23 Nov 2026 15:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D84CD6078A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795448075;
	b=TEYCjhzZxGdmdjSViihvHS4Ac+u4NrpnvyBL/jKERgtUWJQuYS5THMhg+kqxa2wmLcbk
	 Wm5FuknSxsh+nemCTwtp6MzuOJQmCm/Q5/LYFBoLH8PMdK704Ev1Kh4Dqlw8GzAb6BF+g
	 0NLtI2tDO34fXq1saKvJZgGtDzg0tSTBY7iLR2lXB3ZzxZTWvctWaJ+HQNJH2/RIwAIVs
	 CdcjOeVozTm2NhUyYsCjfwC3dcnAAJsBw/zv3Y6y5PWKIRuoT2XPIg6hrM0knlnzFmrof
	 L9+iiHpgODH4ZjShoMz5FZ/dPIcbYMswkEIH76EBP5EvN/supKNgq1VthSYHeiqQbow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795448075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=543m3+xayfs1fMC8M1JuilOvud6X659TaG5nHAIr4Mo=;
	b=CiF1WAYQ9n1MR9ZXPLla7o18+E0e/qjaftCnNypnTBHxpIOwxhbYT5PRqkIGSqOsE+AI
	 K9UO9++8ecdt1ILA6sYyn+GoCNjH3OOQ8SktWgctScisv0dqbahOIva+zVdZwWrkamcwW
	 C1z3HKndhMxclAXUQTjcwA4aKhrWAgnMKOEnhdaTj8GI9naVfY3KuLYPiINgLhkfJzQ69
	 L0DhVAsZsLsZr22tmJBr4XTWfFeFvwlO2yxz254CUCopGzhMTpultiOFg3UYzEf5AUZJU
	 ugjtLEh3A6U9qWElyqSsmlKOJ4YuPiILMtU2itQi+nwR5xvw9Em6d1WbuIEQrDHGJbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795448075;
	bh=543m3+xayfs1fMC8M1JuilOvud6X659TaG5nHAIr4Mo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ElXRKNODAwl1BAvODAphDxXyONgZx4bRaikZWv0Jfol+pQmuYXmtBvCnHv3KDYyso
	 ILH1XICad7/s8/rCBGDdzdY4QlLnW0VoeWiicW3uekBF0KHTJfo1QnfeLC0zBm5aTy
	 RX+xbfjA4X8my1lSWdGxhLaW7Pga9n0oMuwoJZoRNnT6WON88EU8NJN1fcRkXVnjMA
	 LvKW8IZrZF6teIYr4KMshvW+Hw+SpQ4OKtkiYB6gxOYo16ZB0sqcAKMDxP6+qbdWoq
	 cso8tX9RiN+RNZCk6SyE5v0G3j8YKAi6utHMj6jXICrflw6L6kbCNeEYf3FBk300QH
	 TzBat85pEzVBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D84CD6078A;
	Mon, 23 Nov 2026 15:34:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86AAA759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63A43400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSGrJ4nT8xhb for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:34:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0273E4008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=gopinath.sekar@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c82zgMeG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C77bS36U
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0273E4008F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:34:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDLUHx446437
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 543m3+xayfs1fMC8M1JuilOvud6X659TaG5nHAIr4Mo=; b=c82zgMeG6yDIJcuW
 dYdrAdCaG92kMt7Y1xkcZnwdhRflogY3fIdSVUD/FM6IZV958C8gtD6/8T13MV9O
 gKwhITSZMwhb2hyO8RRaFrmeuTItWposRa0d2nkc6iBn25z3DJZmU0iwrh4H4D/V
 NfHqkoO+e4oeJmhyrVDSLmug6qYrruK51HEuUh7I4/k3t6pGo7SZTtETb64cl8Fg
 26Yx6QvmRv8WAd7K1Hun49prn8N2KfFMzbhbQjfXOm3wOuF00Bo+Aiyrn/QhoNd5
 nXD8ALI3nTg+g8E+9MymWYVlOi/jIcwvEICz/z6fAoDbko9kboeR25pkYhrxeuu6
 x4fz7g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g74237n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:34:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-339628f2bbaso342469eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795448069; x=1796052869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=543m3+xayfs1fMC8M1JuilOvud6X659TaG5nHAIr4Mo=;
 b=C77bS36UkilOouicqgeX2mH1pIDWJiLUJnVUoEIaD7rCgxpCHKNxJxWUKoetzLf0Xv
 iqTNbSx66tNdMWAqP7g9PxzcAT/5uLXiLA4t71A0mYwjqjYDQHQNiIocqKLz1DEjnAC+
 whCsAe5cBUJZBIQU53/8LxwCmxcNaakYu5ZA8m36izZWYxVtt+PkfOwcOBdyg32xlkW0
 nA74YDDpZmoxceSte0I78sRovBld7r6fjZGXcMFgysmLaPit+t8lm9HJQNoTldN42or5
 8vKazmd1pPm9Y4hhGoEJ7I6eE8ljtCfMEGpDJaRYipjqXf5T+QLY/rz6xNNlF494tCCQ
 njTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448069; x=1796052869;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=543m3+xayfs1fMC8M1JuilOvud6X659TaG5nHAIr4Mo=;
 b=VilOkZkSCWvMAvOYIfp717YdBXy0BcYNCSTICN9rGtHu//jHWGgp/mjR08Ej693gKE
 l/pp2bAPUKjo6MKYkjyrrLrDNv+OxMZ0BfeVK+qS0/VQ+X2pxeBH9fB3OLuYqfIFgqIt
 tUhqAOqBq+/t8TOVucS3/2FDNPetDt4RACCAA8QfgWtyFDalmSEG86Ja+ZYcItI6iAxG
 uutJ9rRdW8OpEzKlAFFypfX+e2p8qWPkgMde0i+vEzfQ1uv0gLSXB+LXJZFX/INeryJJ
 3xlz5vPAr5GMJzuK0StXEiVmz1b/dDXasDp9SHm2pq9y1eTc4fozYg+we7Q7iOP1OpuC
 qF7A==
X-Gm-Message-State: APuU4Z9oUuE2RA7ZSNQgYuKFACur7f80drGAWKjRAC308vLujzo7o5mS
 ot3A62m0CSOGMJmXFGqYW0JYJOI7H47itDmDpA7dSKv0tZbQtTlqav9DdChfuTaZTO8iR5bGY6Z
 e+zzWfghq27eNC2onCN+0r5zw7ZNHid8U2Jj7uMzjBFE2OTyESJ0Y5l/M36YVYbJhIxfAoqb18m
 6MqHs=
X-Gm-Gg: AZFdTZd0j+hU5HImu2+sT0RjzYguSY4kgdiZaz5KICAteeRMUMw3tA9f6uYGqTlFifX
 99itAAVozDJ31s3HJLID8xs8JKbB8L40HUZ/Ufi6vIzWe1A+fT1L7kIkIOG3poaPTxjBdEoM24i
 fL/JA1C/pPwOlh3f2Pg9IOgpVTiHjTlV9qn02Kn/9A0OFT0UJOWFU6iVkCE7oCw5iuJOlVxlBXk
 KqBg4SB7uF5aPHAMPR9gqABNcsD7EfBOTDE/LZxV9Q+F6du89ZIMFAEs89PtnU4DKtMvdJYZIvi
 A5UF2MSTBowdgdhtmmUjA1vxvh/2QIXpZ2LwwZLUoKQVx3UYoRIpH1bK/Q/0hwuG4znLeA2Bjna
 pLhlSVT3IJLE3vVK+KZ92bsuUf/qqklPwsYVcTFj4EDfNZLGRWr/ZqBs6g/Qg+T0nNCHwhmAjk8
 GEkP4x5Q==
X-Received: by 2002:a05:7301:2624:b0:385:1a45:47b3 with SMTP id
 5a478bee46e88-3856e24682amr19424238eec.1.1795448068512; 
 Mon, 23 Nov 2026 07:34:28 -0800 (PST)
X-Received: by 2002:a05:7301:2624:b0:385:1a45:47b3 with SMTP id
 5a478bee46e88-3856e24682amr19424203eec.1.1795448067619; 
 Mon, 23 Nov 2026 07:34:27 -0800 (PST)
Received: from [192.168.1.3] ([106.219.178.136])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c349csm39361780eec.22.2026.11.23.07.34.26
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:34:27 -0800 (PST)
Message-ID: <93974190-f499-4873-a7fb-b00b1c2bdc04@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 21:04:24 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] clk: qcom: sa8775p: add SGMI reference clock
To: u-boot@lists.u-boot-project.org
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
 <20261121063919.3313168-6-mmanikan@qti.qualcomm.com>
Content-Language: en-US
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
In-Reply-To: <20261121063919.3313168-6-mmanikan@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IlsF8vo5IfRJburUpjNTqH3m8zTl9UIY
X-Proofpoint-ORIG-GUID: IlsF8vo5IfRJburUpjNTqH3m8zTl9UIY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfXxvifznL2Ntrm
 HLHm8Xow9b8D+zbyqUT46Cac4Yeplem5AQpkYHrzSi8WmUIHu52dZIJsDNzlpy2VsmnZG6BcFHI
 JseCPDwfh/PBkEK3RLJJq+Dt0i4YPKM=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b045d05 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=jCNHygwvtdUFbBAtyvamYQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KNHia5jHUaitgV9_zzkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfX6F7JmEOT6gu4
 o1cWnCfqa9RVqeKR0U87sIhm9Wd3+hN92XgIsdU2bU9/p0mbouysyO4enZyZyUcbVLqi9OBmSTz
 jiCwifBf28BGA10OE4WsJta177TWpCr4fLpztoP9C2WG27t8Paw0/jz1zmvbPkX4iBx4WPE5kfH
 z8X485cbpCXXR/ItUWNth/NbOzRsk8niKEnHPtvyvwG0dSIB1zI6qQA1tn5V6pUgffjtcjmnkpI
 +de4tvSHMOzsIJpUpKclH9Ak48o5TkXiohIxhtugpD1d4HutzyxAtCJsURrxoTxNtCo1h1m5Bna
 K2I45gd5cojdpR3Kud6IXynnBog3W9pH+l7868YaX7npPlGINT+AV3UcQ3XimBD6NheDqUTDZJz
 MX/ONcWosrwkvUDcDLxXP+uIFe3SOyAG4dmH9c8BrMlkUMrtxN1H+FaxJISXfAqKAnr9LoJAQFl
 x/8zEeOXiluGDlmum1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230061
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

Hi Manikanta,

On 11/21/2026 12:09 PM, Manikanta Mylavarapu wrote:
> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
>
> The SA8775P DWMAC SGMII SerDes consumes GCC_SGMI_CLKREF_EN as its
> reference clock.
>
> Add the SGMI clock reference gate so the SerDes PHY driver can enable its
> "sgmi_ref" clock during power-on.
>
> Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
> ---
> Changes in v2:
> - No code changes.
>
>   drivers/clk/qcom/clock-sa8775p.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index fd495b73635..65f8bd42a15 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -227,8 +227,9 @@ static const struct gate_clk sa8775p_clks[] = {
>   	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
>   	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
>   
> -	/* EDP reference clock (used by UFS PHY) */
> +	/* Reference clocks */
>   	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
> +	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x9c034, BIT(0)),

Can we use GATE_CLK_POLLED? for CBCR backed register.

Thanks,

Gopinath

>   
>   	/* SDCC1 clocks */
>   	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
