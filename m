Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4885CC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A27B407F3;
	Tue, 21 Jul 2026 14:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wqxm-8G1_nEg; Tue, 21 Jul 2026 14:56:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDC8440743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645773;
	bh=zWosINztmmtHpK+n+9wAn2FVEzd0dD2T78B9orVRa/0=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=neiotGaMvC2PDrr7OW3MHXh6O6pEnPR0WB4+AWJudRi+n3wY6s/3HoWkOKPbzNh6d
	 Ijpf9RfVFRUD6fmye5qtlFWTdHhj8KFOld1r18FPX5+0dknuOiavvVDvzYDqr1P79f
	 tDATq8fW4WEAi9J38lM8DaOZHVsFjPwElDPAq8swLE5pO5qBpT2cvPaBlOjYr/F9ej
	 xfMxMOna89Uah5HP7vTKi/neDwjx+pLR/d05u3b5Ce5oT8BOqkdv+OXHkAJsSmL3ie
	 uapmrDY32QJ+pKiZBxeAMhBPAZgi7SKOuVv8a9/KKIwJckIyTrDsN/VwtJpTO93xqh
	 1KeLqAzq34okg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDC8440743;
	Tue, 21 Jul 2026 14:56:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9249B109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7851A4071F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2RdUTwZJZD4P for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:56:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 377F040660
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 377F040660
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 377F040660
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:56:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB21846A4; Tue, 21 Jul 2026 16:56:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E69B803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:56:07 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg35t1938920
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:56:05 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bs8hgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:56:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso166932521cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645764; x=1785250564;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zWosINztmmtHpK+n+9wAn2FVEzd0dD2T78B9orVRa/0=;
 b=DO1pKE1sBVW/dcXsaLDfirOkffjJn38vqa7yUKN509RH2LH37p1K10Lb0KtRdN5VxN
 yMR5jHLFE2rWG0LDONCNwezcg0igINde8A67qeRQJ6pkftiwKNYmjUMnHDf9yhA6HTFk
 RNsZRqftzFEKZU3BxKptLSPXXVpWG+6JBgJi8Hupe4Kd+NrxWxyBu6madWWgPzj2ustx
 uFLpzDhvB9zijHHS3EkceF1yVKqeQWFMN68LtwqYjKQPFhAZA7rmHoblmGm4DBeYGUSf
 rD5WTSNsCGSWop6Bk54wZRBtwnbDCzw66YfUsdchlKR35zvq5p+sVJAEw9VPLlQ4ICuq
 MMTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR4nfGWsxJ1QncyVEV6UAvRi/Ea4wrFJxPBKH+OZ0HHfwJS6K9D3fzDCbJyVHKHg90lIZj81I=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf4WqaAfk2sI1zvntAYiM60BqEOUIrvu4XUOdubK4FBO5IXRBL
 0AajAKSEazIIewnHimG9NjiFuI+omPUgsVmESGO/C1QbS4gqFfG1/aU0ZrcS7hfKM/P4hqM8LiK
 D3cYcWQGYCt8fRD9DtCbb99au4l4AzI1EQ7E9LIxogmJe4q2Jfd1KZZAP
X-Gm-Gg: AfdE7cm62UtAmGnX7hg50y9qiZaKvETemv3eELvZpsQFz/LA7N1/81PShD7PlG+5OBA
 cdMyPAafDkJZijC48zVrFQdl10U0rHhsCs8NzDff2ZvZjANO38cxKXvhjCT30NAjswc5pxNvjUG
 jNKZWW0ODk+GuSIjNvPmNfSScMI9hIAu5tXqfVjvT+qrnHu5SdMLOCuKlGXKkYiAjO9zp8Uhdez
 qEnHM4tfuelYh57gYtbnCi5yBBiAJpWGEHHqq4zuAG6uJQF42JI+A+Qcik+QJBCfLbrJz7qHVvL
 kszDM5kbvlEKfHXu5YY+t1/Chq7T9gSRiY0TOhbRjgMI25AKNUZSW1ZcMle32nXWPtrdSi9Uk3/
 5GhSM4ZgCdbnfx1qg7+VjgDIYlliKqEzyuko=
X-Received: by 2002:a05:622a:24e:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-5213f66b3bemr181948141cf.56.1784645763714; 
 Tue, 21 Jul 2026 07:56:03 -0700 (PDT)
X-Received: by 2002:a05:622a:24e:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-5213f66b3bemr181947441cf.56.1784645762813; 
 Tue, 21 Jul 2026 07:56:02 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653d38dbsm69464005e9.15.2026.07.21.07.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:56:02 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 21 Jul 2026 16:56:00 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: Re: [PATCH v1 1/7] ufs: decode string descriptors as UTF-16 big-endian
Message-ID: <al-IgLQ97rQpHDGA@trex>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-2-jorge.ramirez@oss.qualcomm.com>
 <72878f7a-81f1-4216-8eb3-6b41160068fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72878f7a-81f1-4216-8eb3-6b41160068fe@linaro.org>
X-Proofpoint-ORIG-GUID: b5fWjj3AJ_VEc_8CBrWhC7KmHIHsOljy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX9CD3JZPDyZU5
 7bc4Ahssu0Ri2DHEwDtdlnVM2aGayUU4R/mz/HMg4qgVlrQLKrAWkdc86XGZEGAIzdhoE4uywW2
 XkL9iHDYxtXa2wQ3oi/JYPtxRwlu4jFaj5MQt7taMK/JbyB3m64oVrWUYoH+6ur5DdTqR7uK3lC
 wd/yTkbl5/2amLbGcVIRjPgGImyRR8/72QwyD0qsTgjBV6d1Ae7Mnwzt+Ln85E8G3y8VoNMkNeC
 0FB6srr2eawkjBMMYLBwC8eQhcKKgxpQE3aqKxsflDWcliBN8I0EAf/vNLyQTMMti27wUKoX7vj
 7YuP5vGCST+Eyml0hJEw75HuCripKiRq/TOpw5wOi1CKvJam9xOxDW0EYC+46WGxyVvSYXRXd6b
 QjJrr5w85HGfwuqIoIMuWUGPEXitHOHfFw5x4/yj4LpHPBqQN5gmOJ2vTgtVaP1/pgOlRolL5zQ
 hTX/yu/FP52muFkP6Kw==
X-Proofpoint-GUID: b5fWjj3AJ_VEc_8CBrWhC7KmHIHsOljy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX8KVaQYf/5ske
 fXznTmAdKMr7rPOdaGWTiz0D27lOO13JmKbath/ZsgGozvtfQQW8QHZqaHbFe3Nsw5VbqIjEoXc
 N14gRqmwOgHHeZaSf4RLh1A2ZzC54H0=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5f8885 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8XcA77mxbqU4SLv_yTEA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210156
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zWosINztmmtHpK+n+9wAn2FV
 Ezd0dD2T78B9orVRa/0=; b=kG/+ukhD0PLBzV+D6+TvTILTsub8Bqk0FA2MkoyI
 mFUvZukfvKMn798W2TcyN/RUWrXcAEMiNHpN5JMRS/EYOG5ar8a0dgjz8Cj/kAzo
 l7AAihhQdFONaCCNhX7tBG/mvcqQ3KkPtqPsHGErTPboLIdpfqIHjwJ7uA+ceiBa
 iVpwtUpGbMmiHPxxmb+vzw/NaoVdStfG4lsDAyqBWs1CvUf9qg2kdMbkrwkHowhS
 l5CgWB4pSqd5Gne4Tuj6mT0zh13p9enU2UriNFNzDT/pk868QqFlHU5M8Gj3MRB+
 WMSeA/5gwH8ZFmFBo0A207tsAHbffHflV/TbLj1i6S0aHA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784645764; x=1785250564; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zWosINztmmtHpK+n+9wAn2FVEzd0dD2T78B9orVRa/0=;
 b=IKQ/6UjT3SBgAweWw2LAyJc7QTj+eoTfzf5J+HlP1Wf2EpKL5cHxj+rplD7FSJi2ho
 Mnfbiuw7Oi9DR+TANeg5Gg3kvpKZYKUxLsnkqTxIzjnYYVYIWdMnuYhrIf082jNsYAj5
 zrVrTHAP5uh9KwiupiBxh+8GvS6nWmDv5PF9xW1MPfPG/+Roio8EljNtdI3PqR6GyubZ
 zcKfSb+B0ZrS7Ditg7cu+mKsXTLRiD1p/CD7KNIs/MieSHTNAU+YkKmc8GUJgLFSU8n4
 cysVNVIIpvCasFw5Ftphk3Ljh8M/eOgPkSKNMePGbyQrr4x3QEoMe93q08eCqstb8KSV
 kg6A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kG/+ukhD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IKQ/6UjT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kG/+ukhD";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="IKQ/6UjT"; 
 dkim-atps=neutral
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
From: Jorge Ramirez via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 21/07/26 09:32:43, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> > UFS string descriptors are UTF-16 big-endian (JESD220), but
> > ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
> > host-endian code units, leaving dev_desc->model blank. Byte-swap to host
> > order before decoding, matching the kernel.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/ufs/ufs-uclass.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> > index 6a51f337e47..4d10e0b11fe 100644
> > --- a/drivers/ufs/ufs-uclass.c
> > +++ b/drivers/ufs/ufs-uclass.c
> > @@ -1765,6 +1765,14 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
> >   			goto out;
> >   		}
> > +		{
> > +			u16 *ustr = (u16 *)&buf[QUERY_DESC_HDR_SIZE];
> > +			int num_chars = (desc_len - QUERY_DESC_HDR_SIZE) / 2;
> > +
> > +			for (i = 0; i < num_chars; i++)
> > +				ustr[i] = be16_to_cpu(ustr[i]);
> > +		}
> 
> 
> This block looks weird in the middle of ufshcd_read_string_desc(), move it to a new inline
> helper instead.

sure, sorry about it.
