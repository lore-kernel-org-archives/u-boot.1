Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F63C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 09:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D0482A8D;
	Tue, 20 May 2025 11:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Qm+mnbzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF6A82AF6; Tue, 20 May 2025 11:06:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E71829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 11:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7LXG8025244;
 Tue, 20 May 2025 09:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oXPyVbK4VmT0nL/J70GR9VS1
 8weN1YBUgPBXV2gSqQ0=; b=Qm+mnbzP2rdb2F7g8W7jKryyrhFr0s5edy7T3ynw
 MVj/RDugVlsjDWkQJyvjx+1+7p5V7AvoyaTzb/PGoY8+TZI2/pWDgo1Bj9gpwTr/
 Ybei+jeIU+iwF6tK6XHzwnfA/t5lOajiq04bRB6NYpCk1bNigNGoqz6mtRmJ3rvN
 LmfvlZUXOnxia2XygQ+dWs/rwvyRwhjNj5tnNoUq7xqyvGH7yf07uJHksi/xq2FZ
 Nc1H1jYI5tgnAWcAiorx916/gxvw+w5/G3Ug6f1zCKtDoBWg3EBWmMB0alMtovyf
 U8B68tIJpCF78su6sstzg7iOqGTeqbPFhXrhWeT0aqdplw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjnyq745-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 09:06:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54K95x4O029601
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 09:05:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 May 2025 02:05:56 -0700
Date: Tue, 20 May 2025 14:35:53 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Tom Rini <trini@konsulko.com>
CC: <marek.vasut+renesas@mailbox.org>, <sjg@chromium.org>,
 <di.gerasimov@gmail.com>, <quic_vkarunam@quicinc.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] cmd: Flush destination buffer only if it is available
Message-ID: <20250520090553.ynmzfryhpjjctp2t@hu-varada-blr.qualcomm.com>
References: <20250519064935.3832233-1-quic_varada@quicinc.com>
 <20250519141905.GO100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250519141905.GO100073@bill-the-cat>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3NCBTYWx0ZWRfX6FDUyeTLRoCT
 v4sG5ve1JeQ0Cnbyxd7U4s33E9goUdVKAxg1gQ+iynL3gEQZT1xKTJjPevoL0lSRHpdzVQ8kWOX
 kw2unNkB7+XbpxpwFpCjxQnfseUPzCeqXDm2aQUmZJbFdThAcwv1AZjCNuDeQfxbLZRSwpgWK0a
 +3QL36x2L5ySsOEgK/GLjWOTsN3MFAGZFQCROqkd+LMMFCN9Du3+JLM33sg70mbYUCBbqZyVTXv
 nSl9KZwoXX1oAKylD3JmqZ2bqiFsQf3mEcSSSPhiPep7Ow/g11TY1l4QNO5Dl0gtaU+XWW8l8JE
 rBVbXu3TbYWyagsEhkRPcA6Q8ssFAVqFfYeVw4AvjBVrgoEEanIYIOLL3jWcqX6fsYOiZxIwiWh
 kvp1jh7UzB/wcSrglXgPsmueWgMizd3UXqqp7/SvhxkygCtq+zt+Z05dGMWETQYuA/kWcNEy
X-Authority-Analysis: v=2.4 cv=Z9XsHGRA c=1 sm=1 tr=0 ts=682c45f8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=vhswRE8HQ3A33jNlT5cA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zHOeWDFNYT2u1AUr7FNdjos13AZUvWU2
X-Proofpoint-ORIG-GUID: zHOeWDFNYT2u1AUr7FNdjos13AZUvWU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=336 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200074
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

On Mon, May 19, 2025 at 08:19:05AM -0600, Tom Rini wrote:
> On Mon, May 19, 2025 at 12:19:34PM +0530, Varadarajan Narayanan wrote:
>
> > From: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
> >
> > There are code paths in do_imgextract(), where 'dest' could be zero.
> > Hence, avoid cache flush of 'dest' doesn't point to any data buffer.
> >
> > Signed-off-by: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  cmd/ximg.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/cmd/ximg.c b/cmd/ximg.c
> > index 29d7c3279b3..8907b579d4c 100644
> > --- a/cmd/ximg.c
> > +++ b/cmd/ximg.c
> > @@ -265,7 +265,8 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >  		puts("OK\n");
> >  	}
> >
> > -	flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> > +	if (dest)
> > +		flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> >
> >  	env_set_hex("fileaddr", data);
> >  	env_set_hex("filesize", len);
> >
> > base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
>
> A memory base of 0x0 is valid and not that uncommon, is there more going
> on here that lead to this patch?

Facing an abort if it 0x0 (arm64 based SoC).

Thanks
Varada
