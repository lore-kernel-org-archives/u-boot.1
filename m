Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A4DC4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554B860781;
	Wed, 22 Jul 2026 06:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OO0DALm-iQPA; Wed, 22 Jul 2026 06:11:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A1926071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700678;
	bh=xZvBui78P4X3rsBSLgc7aH4+KWGrx5XGCxIt9ypuI2Y=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=C84jFfg7rh7y3N/EkvSO85iQ26Y9MQMBBMDPca5w+bKGIlNNpOCniabjWA/VRn8Ve
	 8dfDauPvLhC/ea93H1NLYMuRkAHAkmWKngarCy59btSOd5R7OOvb80lfs1KxRn2dFn
	 d8OU/K9kUZHmTV5ELn6frbDUpxjIO/tjPH8eZL95GYFTY4ePIq7klxTYvKslfSGPSo
	 LD5Emd1J2pERon17diCWyYyMwqQxsrjlJDtxSAmyA6vms32rACn5zXxFNVj9Z0woSV
	 beabVVXpb8HnImYnCJFBPVg4I62QpqlYsPmBLmOM4KjwVTZvb4IqxTJr9+9gGHAi0y
	 KZe2ENv8iA/oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A1926071D;
	Wed, 22 Jul 2026 06:11:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 923FF42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F943400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kjb9vkhQKgYy for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:11:16 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4746940072
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4746940072
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4746940072
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:11:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F5F848BA; Wed, 22 Jul 2026 08:11:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8709C803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:11:12 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53i8o4045186
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:11:11 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6daj0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:11:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bec738909so143993831cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700670; x=1785305470;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZvBui78P4X3rsBSLgc7aH4+KWGrx5XGCxIt9ypuI2Y=;
 b=gOr6pJlm/BF7XEFV75rIujWlRLId5MtFZ2F5QodrvRPRCxcGzTKd1CFCEbIIHqTTJ+
 HfiLm6gj/Gb43PmEhrX/1SO6Xm9GBMrnDFmniVsy1lPV+7V4UftyFXNmvcRcXHtc0eWC
 OlpHb/CJzYWF6i165fCo3i0Bq6MCNbDO7qjQwFvTvkoRWkEolt9jNo/fisu9K2LRgINn
 1iywutcgEtSD1zINtFB7lrml1IUyxQ9DK1nNyx4s2bs8FyCeMEQZA/GbOIWLvUYb+zGB
 cCpg0bfUF3bhBQ4rvvQggWLqGYSDetTtC2gf1stVJ4uVDSqOy7fIuhOKv1oOL/QjtmAA
 6d7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHDfU/bpgms9ro66AnrhIp5a4rXI0qObhVBniYwxhkQYp7thTQr1Htg18joOEHSj21EfeAwvA=@lists.denx.de
X-Gm-Message-State: AOJu0YyPu4zJEdQ0ssuvnYE+z5HRi2v+hcrB4EqYQoVIKHH9Gmnbd9rB
 9ToUglp/u9J/rx3o2qfxNaMd4KlqOPLFX3OZBBNu/PXkgEEpY+GfEgqzf6bewziZO98GortKWUl
 g4cG3uOoHyhLgqLiwqp01lXzUutQTqjRLw4hy9Y6zSfbg7zscdtNEAwje
X-Gm-Gg: AR+sD10KM6Wax2jDby8QqRKIvD77FmtK+o5bRr5AezLQKEa6ctUrfhLyA9iSq3ZL02Q
 5PxV7lgE8YTcTLzetC6vGX8PMA7FgfvuaazsZltE4RaZLB+b8oZKvFM3yWfWsIUpQVN1s3OSnmT
 TAFnAvYJyVryiheLIZFzYTO4oLuN/1ebBocWrKVcvMV1NoLYSF7FtTzBn9/GJICekl/T3Q+gUAj
 fFZJvA5LqepdIL4P6WPMXYA+2HV96DzYPev0i/zcYEsB3uSU5oHSEAOeM8Slo7gfJw0GJ1cuAnM
 wAF0SXSi3kgcxlSrb7Qf33z/Ak79jaTRk/5YDQXUnJFP5Gjd9z2wov7EbMhPzotWbR3AiNaYqYN
 RdwtA4nFGSVF0GA1nNHUEdsQh9Qx3qEhmnA0=
X-Received: by 2002:a05:622a:94:b0:51c:7b12:5fec with SMTP id
 d75a77b69052e-5213f66b8c6mr201908951cf.88.1784700669880; 
 Tue, 21 Jul 2026 23:11:09 -0700 (PDT)
X-Received: by 2002:a05:622a:94:b0:51c:7b12:5fec with SMTP id
 d75a77b69052e-5213f66b8c6mr201908591cf.88.1784700669390; 
 Tue, 21 Jul 2026 23:11:09 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm2772927f8f.24.2026.07.21.23.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:11:08 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 08:11:06 +0200
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
Subject: Re: [PATCH v1 5/7] ufs: rpmb: bounce unaligned frames through a
 DMA-aligned buffer
Message-ID: <amBe-t_aaj9ex_a7@trex>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-6-jorge.ramirez@oss.qualcomm.com>
 <ca997b48-7473-4057-a358-b3e4d3dfda71@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca997b48-7473-4057-a358-b3e4d3dfda71@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX1HPZ4FKVjWpX
 rWMpgorEVL5zwrJGajPokGKBTxa6hsc03VLpLSFJm5ujL2dFFd1WJbnxZJxEtup13I4NKLA3Syc
 MjPfR5bSyrDUQmHoCg8uyZu1hdqf/rg=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a605efe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=zk8TWNMwFUZgw5RvFScA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXytmCtOCK66ec
 S7ucaFJjFUSPKim5MWSObFr8B3u8RWjwDLxSlAGJB+RligTEE3uVZ86unY7ooA/r39fcxDRB29j
 XAWeCMJQPOaI6AOzkdETM2fzGD6cLXSOlz/c3+oZVugtFkMQy01Quj+XAJPnsCL+wWoc+BlvwUw
 F0qUvZ6JND27wTefxySkncOkU1jXpVx2lWeBLngSMkdQ7WRL8rii3LLo+SyXc2x1w8VuEqmvxEf
 4JWxrLaf8kknqiBGuEYgJfs/djhM0naVrOEaOqeJkM78PadB0gVqSbANJ6nd36rkkrQ+175pEoi
 0R+nVrAuZeB2r6BcOaL81tLk3V6F6rUwDcFzU3D6HGbOKv7gsVhaL/Yhd+Exoer/ltZvjMhUdfV
 gKniJZlQH3FUh6CAxS4dPwRMsZ+/pXUZkR2/Zh6EQeGKJkQwhUOQ66DIXZxE1O+mY2KMvDFueI6
 calSHkeWo0FEmzWD2ZQ==
X-Proofpoint-GUID: tqtpfRnyxIetWnEzdqAy49Csx1qyh4bS
X-Proofpoint-ORIG-GUID: tqtpfRnyxIetWnEzdqAy49Csx1qyh4bS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xZvBui78P4X3rsBSLgc7aH4+
 KWGrx5XGCxIt9ypuI2Y=; b=kkUFwujwOpZvoV7ICEx4vLFj05EU1rMyhiJL38yr
 bI57qOK+Ti+kzyIZfaQ3uMtY8fAyurslwLxog3qPagd+Ed2ALAs1rVuaKk+z9w5e
 a1QFVegY4vnSnEnzqycAXQcHdFnSLKRJm3AZKFELIGd2RK6+lAc6O8vffeJlT6BQ
 WlnkoXkF7ahqiA5NUfBXx9Jqt6ntlAgV8FM8kLhtiRaRQyL2qrh0VgvaqTAMAnRG
 lDlyXdG+5ybM/K7PTebkVXLdLMJyD5Ihv5oD3ljWN03fTHOkY+mb9jmV6q3RtHYP
 ODjoM5IuITUo9rfVNTuLazmUSygrsU06AS1SPWzM49mqAw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700670; x=1785305470; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xZvBui78P4X3rsBSLgc7aH4+KWGrx5XGCxIt9ypuI2Y=;
 b=eEMMkHoaup+Mpr+TsgiSbQ8SVdmCQKfaUSwHCCldyiL7HjulNO1GUjsKKBG+OcROP0
 XER2OKb4qx6hU2lnmrOtlYI4Sjt5yvUVRZCMQTGRo1j6sCmzhgg+svu7YYrqIk/kkhrd
 cRB+hwE7KSuuyFbXxBeeQHeqeS06i78ZKmKa4wfqH/VrkoH+gryrG3pE5LPDVkRAacJ3
 crtQoJ362McQxtB7TWA6nl3NRM3ygEtLXLy5ELW2qC6rmKNBvGm94ZQlb695OdREJmHY
 iF7RZWw3KnPNcJEaIflmqhWA54maXzgZs2XzYC54IjJf9Plx3FLLg9ybYfddZrAiqlSA
 J47w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kkUFwujw; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eEMMkHoa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkUFwujw";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="eEMMkHoa"; 
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

On 21/07/26 09:53:49, neil.armstrong@linaro.org wrote:
> On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> > The UFS controller requires DMA buffers aligned to ARCH_DMA_MINALIGN,
> > but the RPMB supplicant may hand the transport an unaligned frame (for
> > example the status-result frame built on the stack). DMAing from an
> > unaligned address corrupts the frame and OP-TEE reports the RPMB device
> > as failed.
> 
> Same as previous, I don't see why it's not part of patch 2, and the change is fine.
> 

done on v2. thanks Neil
