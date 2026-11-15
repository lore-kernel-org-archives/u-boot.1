Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD38606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zVcSe5N8;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nit7k25A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJ+XMG/v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 327F760740;
	Sun, 15 Nov 2026 10:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tv7e34GpERrp; Sun, 15 Nov 2026 10:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B1BA6063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794739785;
	b=mt8rMMMgYisSHEb9Qjd+5+wpy53MOE5Q0Nrqb8gcaxvJTed5A7JXqDoNlDnJ5+sAvAUt
	 556Qzk3PVuTH6lmRXd72H9g73d4zP/uwR9LG3BN0E4Ecb+QTvrWnV0IXLGKgTXnl1I5Q5
	 Biy6EM7OXpBTo9zqQ/OQBQA7y2ZGUn4RYTbJ3y91CwnaTN7pL7Q0GJRuEDVJ4JX4FfA/w
	 CvRKhCpvGUy4vbPNeyO38Y5UdP9LRBGw1u+s8CRkSZNtuvmr933ve/LAnRvkk3sOI2YOU
	 LS3+3fiOHMuODcy8UvlfH1XY2St0tHDxosdhIIUuG/UDOJbef1E+D3o9pTE0CMKg+nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794739785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2wGC8AP5A6wC8ZFVm93nms1Ww3e8j8mDTEipxaB/wPs=;
	b=NCMLMXx8jfWi9bVVw3sa8ybk+xj86J9RrXsy3yqEA4Y/ba2WwPIoAnCDxLUfqir5Q8oQ
	 Jf1Bal9j7Nk9YHkhxk/vyCS91WkVvx23CMozU8Ry07ldsYktnZds7NCUI7/IeCzaYrv8e
	 fh9pSVFebH+HqdMbccluRDHBvARRkWp2HbOQ4rYGiZreZx7PnASYguxHj+viwcBxn0mIO
	 RUQigmjixXofroIlxv4NdUzARPvJbHwr+j0PCWBpf0S97DkRj8u8zZ5+umYd3Iy0CTup+
	 CSiuLqp9IVys9V0PxTXJIACkg1hA06TZV48WVNlIrvZMAPCXqC8hHi7fLY8x8Xw/eAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794739785;
	bh=2wGC8AP5A6wC8ZFVm93nms1Ww3e8j8mDTEipxaB/wPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zVcSe5N8V0nolvG9urq/DJNMUHGL+St1oCp2ptiq33MJgzHYOg2jxJ45Ja22/WUvz
	 K6cO7qVA02dJIBc3LL9weu+j0/eKEo+c4JGewC0TOGyRKJK4wuGGMigfMIPjYjqD7Y
	 OJE6uk/DFksbrwN/M+08Hyhl/QDLBL28uK4VBMfOraOcbAJURhchjZfTkqpP4RlKIa
	 +vMOeonLteper3tTt15zd3YMOn/IErfszbvzLa2g9PccHjTuwH9ZtiR6LvKDMWL7sI
	 NExWoSRI3itmjo4N0gXx3xTLpvhZ6AXlnJ2aUnHAREc45WWgyeZc5M+B1uummKjISA
	 laIS70y6NRE2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B1BA6063E;
	Sun, 15 Nov 2026 10:49:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B02870B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38A9F40079
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZS7H0ItG979 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 095BE40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nit7k25A; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jJ+XMG/v
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 095BE40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7w6WK2139781
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2wGC8AP5A6wC8ZFVm93nms1Ww3e8j8mDTEipxaB/wPs=; b=nit7k25AIHxtR9+U
 TXgZvX5peYzVZilaOmtbkL8kS1LohosfyvnPwAQevJDdxt0u/GmFvY9hy+HsriQ+
 6Nw5aJX4KRKRsSYHi97lN9kA5DmXPceUIp4LCWBlG0Yf2OkGoBnYcEVNjSWprGQC
 hE/8jAoZyeIYXJTQjOsF6T5vUrLZ+bcrEWZZEYOSt6sEFex6IiyLglueaYRZO54n
 o1WN7TFbw1W1RGbwNnN7mfQUzAmeonpkPlQHTVliwajniPOMgNZcivNG2siLhoYv
 aUMfp/QW+SW5RqdwLBN1TLzYguyu2gpCHXh/sBImbaxrKMmrdl1DbL2+EoBeHS7i
 jw9RBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjtw63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-944138ed63fso401196385a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794739779; x=1795344579;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2wGC8AP5A6wC8ZFVm93nms1Ww3e8j8mDTEipxaB/wPs=;
 b=jJ+XMG/vJQYo/CGxioWQ6EMnk3Uqgtwzctu2HzEEC85Hi6dMpYqqkCBpEPgJFxi5DT
 uK+gYdnnTwfUZ6iZFlD6IyzNWLQQe8TlfgxGGEXq54ify5L0d8JTSwXOYGp4s7LBtL3r
 l0ufh690ANADVGSCbXIgbb2ajUYMkRftQ5Drf6B6RROJ7TpFxZgo0aqBwELrCwE8DECl
 U4FQZ0sK/fV68qoNFQ+GZXA6rvRIC3gbV4nseXhGdw7/FsWrqshDAwjXc0Ng1ZFUrAjk
 J+dd4keYmRtp0tV0wrXu/zKGdgE7xgdLbgoRs/Qh4huKZMsWMZu3JljzAxMk4qHPokku
 qMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794739779; x=1795344579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2wGC8AP5A6wC8ZFVm93nms1Ww3e8j8mDTEipxaB/wPs=;
 b=E4jOlwYHtz/5RJxg/Rr7x3adG1yqgYMSpu8sQhoENkrRMxkJhSmj3hvgyNI6AV5TlQ
 UpFbp2hy4ENIR1FZuJVsQ2SpeSzWKdm7HXReh6Bm7lpRetoBd4D7i5TE31aE2BPYyBWF
 c0MCUjUVEu0j/Bv/43eggerp0v8s5YDCXEqNw8ALVnQR8Md1l4PK/M1B1FEUyyeB6+tr
 i5FzmyuXTr+1c6tg99Sa+pl1JMOYhNgRuSohUfL5pxSsWbRD2s260Jj6k/X6S4y+8tIt
 riJxerVt6+Mr06584W0tk8zR0tQLCuy+0uoNlMibGkcuWa3EA75uOQHy426Jzvj04ysk
 zO+g==
X-Forwarded-Encrypted: i=1;
 AL+hErEoOmDIC6hGHYs39avdrc5o48sDkUfr6zU8xUxzktclclO+ByHaR74XZ2I0yJSBICCJinZqQyA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/+GP2VrNq4PJ6+4pUtJcX1UrK5w8nI16A7VI0/+uWSPKmS/P0d
 jdpi/4c3hVP+58QORkR5HIKXB04Qz7UpMKFYV24N8FdpfF7g9yQQifIvcQGhu/m0DJVPrxCSlGm
 VnJtup97rFScXWGvEIlk0c9ntgOYS5ZdZWLizZn6t4AaRvJW+5fZbd4yuu9uULdwsFyi+NMs=
X-Gm-Gg: AYBFou052yhlii+425gw/Px7sLbsYuTdqbTcaCWumEAHzK3sg26t2lRX9VX0DBzQ8BK
 eLi5ityZxR5Vm9WRjpw9pSgAx+64gdAwkHFWA5xeQ2HrsgU6y8bGEmvMeBM/Kusq1tskx+I+YDM
 l7P2TiN7g34/QCkEhyDOXP+1m5JQrR1oQnnMWL60QF84D/kkeGSEPKGPYIFYHs+yqInKo3i3FIK
 efY+MkN1/853ybaJovbif95YyPZ6ptCrkMmXAAd7wM6vKs6CxoEA3U3A5akbjVJfSHl0VsspCKq
 gjZ+9Ml8ZeiunRO/qucbHN6Pfh36kdhoRiWeSvuYIvtgRWy1sYij8WXnAyhiHyr6oEMIAAc9Kjj
 wUhEXxHom+UUVtOz+WoOIPBdXuL0DjnGXdsU9KbBhMIo1XBMYgbG2ykRBmR5TnTA1Y3p5rvQ3lt
 Ak8cB6ExetA+rI
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id
 af79cd13be357-9494bd2cae9mr1193456085a.81.1794739778722; 
 Sun, 15 Nov 2026 02:49:38 -0800 (PST)
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id
 af79cd13be357-9494bd2cae9mr1193453185a.81.1794739778276; 
 Sun, 15 Nov 2026 02:49:38 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c24e7714sm3099358a12.28.2026.11.15.02.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 02:49:37 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:49:25 +0100
Subject: [PATCH 1/2] misc: qcom_geni: use the minicore settings only on
 all-minicore wrappers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-geni-mixed-minicore-v1-1-bce20aa8f4cf@oss.qualcomm.com>
References: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX8/YMJ3L+Ld4/
 RFau8HalUaS4UIMvGCmiCmKNEn/m88MSHTUa6ppm+k8fqvY0HEKpYL+is/swetdM+huXN0ptgt6
 MylBj9M/ZxBOtm/RjR39/k99qXRXFQwe990z3FRX4jdP0nPCLa08xJcm7I0NgzBxY38UjIo/NEu
 3eQCfT+Fl6onbZdBD4DbzEcNceRsW0GFPid3ggpoiSlINu6s+Pdi2RbTB4VKKz0Tir34wofJg4H
 hhlccK2gR+Aq9WO0im+jMqXeY7bMdC7fgd7duXSJ7O7dlOpv5mTKp/uXBFb47ioJeIPevj5Qeg0
 lkYU8Na1kSNH/qoAzMrFlnL07EhEWOy3vuUJ6NL7ifu01jVoXJ5jxxSqa/UKedcqAK9FRBmcYwl
 ZTjpe8PU7lIma4OvatLumhgTljul21RByoIVTORJ2K2oAt2A4R2jRQrUWrKEosbwheK6mLh+hFJ
 IMXNqHCTb+KzUUNxgUw==
X-Proofpoint-ORIG-GUID: LtHT2O450iKkwtuGk-7pmSyAuVElrvRj
X-Proofpoint-GUID: LtHT2O450iKkwtuGk-7pmSyAuVElrvRj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX4kvGviY3C3tG
 S1HT1YRfQ1zgvw8ZCkWuSgQ6v+qeOJUevlpAmApWlRxRVEmdUXNsR3x7On1/uzndBh6Zr7ZsbDG
 CiDd/wx9ZY7BEzUZcc/SdsFwTvYX1Kg=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af98e43 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=AX5I_u7HpfGqXeuhjPkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A QUP wrapper is treated as minicore as soon as one of its serial
engines reports GENI_USE_MINICORES, and then no engine is loaded from
the firmware partition. On QCM2290, SE0 and SE1 have program RAM while
SE2-SE5 are minicores; with CONFIG_QCOM_GENI_MINICORE=n no engine gets
firmware:

  i2c_geni i2c@4a80000: Invalid proto 255

Use the built-in settings only if every engine is a minicore and the
table is built in. Otherwise load the firmware image and skip the
program RAM copy for minicore engines, as Linux does.

Tested on the Arduino UNO Q (QRB2210): all engines are loaded, i2c probe
finds the devices, Linux uses the engines. Not tested: an all-minicore
wrapper (IPQ5210).

Fixes: 91a70d8bcf5e ("misc: qcom_geni: Add minicore support")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index 90aac714988..2b44bb492de 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -280,9 +280,15 @@ static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 		return -EINVAL;
 	}
 
-	/* Program RAM address space. */
-	for (i = 0; i < hdr->fw_size_in_items; i++)
-		writel_relaxed(fw_val_arr[i], rsc->base + SE_GENI_CFG_RAMN + i * sizeof(u32));
+	/*
+	 * Program RAM address space. A minicore engine runs the protocol on
+	 * a hardware state machine and has no program RAM, so only the
+	 * register configuration of the ELF image applies to it.
+	 */
+	if (!elf || !(readl(rsc->base + SE_HW_PARAM_2) & GENI_USE_MINICORES))
+		for (i = 0; i < hdr->fw_size_in_items; i++)
+			writel_relaxed(fw_val_arr[i],
+				       rsc->base + SE_GENI_CFG_RAMN + i * sizeof(u32));
 
 	/* Put default values on GENI's output pads. */
 	writel_relaxed(0x1, rsc->base + GENI_FORCE_DEFAULT_REG);
@@ -457,9 +463,16 @@ static int geni_se_of_to_plat(struct udevice *dev)
 	struct resource res;
 	u32 proto;
 	struct geni_se_plat *plat = dev_get_plat(dev);
+	bool all_mini_cores = true, any_se = false;
 
 	plat->need_firmware_load = false;
 
+	/*
+	 * The built-in minicore settings replace the firmware image only if
+	 * every engine of the wrapper is a minicore. A wrapper can mix both
+	 * kinds (QCM2290: SE0/SE1 have program RAM, SE2-SE5 are minicores),
+	 * and then the engines are loaded from the firmware partition.
+	 */
 	dev_for_each_subnode(child, dev) {
 		if (!ofnode_is_enabled(child))
 			continue;
@@ -474,10 +487,13 @@ static int geni_se_of_to_plat(struct udevice *dev)
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
 
-		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
-			plat->is_mini_core = true;
+		any_se = true;
+		if (!(readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES))
+			all_mini_cores = false;
 	}
 
+	plat->is_mini_core = any_se && all_mini_cores;
+
 	return 0;
 }
 
@@ -580,7 +596,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
-	if (plat->is_mini_core) {
+	if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE) && plat->is_mini_core) {
 		fw_buf = qup_mini_cores;
 		goto mini_core;
 	}

-- 
2.53.0

