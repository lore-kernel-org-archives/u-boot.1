Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA71606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bHv6GOdm;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPYkfGve;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0R8xTvF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F598101B;
	Tue, 24 Nov 2026 15:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heUFSwFyArls; Tue, 24 Nov 2026 15:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09D2080DE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795533212;
	b=Uzqj4zfafHJpgr2DlCdX/i0kuCpVcI3QWYMRE/l+Z1Iuh1NLCkHqdGzmE4aAgrrh+dr5
	 dNfwmTKg7BILIf5Lug4QGUzsMrTMYVsnyTqJIPxWyYMC3aTNYdMRjqdU5OC/BPiP1LX2X
	 Z9AtkmBe17kcPdiHTt5cyWk0CTCUPFbArv5yFkee+R9gxGRDCXwH5C+OasLsSuUPDURtl
	 WNY6yGCwBqQVlbo6VAViDSQxHtCp8d8H9a+FcVd6xwB9psLYKpgeczZ1UOlR+4wS6yy+U
	 9P4FOtsqIoPzssK/T1W4ksB+MSBZipdVC1tRfTM2uFbHUygMTOhT22E3MaNODtfoLbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795533212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y2X/wZYEafImUYjcLYaVs1E/CKjjNJA3bWTOUC+gS6I=;
	b=W4cLrPPVyk2ec+6sXZ14cssSaKLBLU2v7oe72rLlO4snURDNLoTL9GmB+Uar0RUs24et
	 z4DbZGHhFEBuBm1BS/lMqOOtkdCU5C1Ed2XsC2PAfCFaMkup6XOBGv6sTPL4ZcZTu8yX8
	 H/1w6lGezLxsHtVwxTzDlcTESLtV46Im9NCFna3R0icbn4Y7Hd32VY9mMVVfp+o8iIAUW
	 yySfPyo3Vf66Iq6sCtABU8bi0fMhTw/ZfeZW9tTlUN7/KIvYvjWlnuYcnCpif5Rcrb1De
	 RPc8Jnh4h9yV0lcXbX01/hbEVEQl/gDSdGV40sutpNdtRhlZBhD/lpAsrVBdNcWKiMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPYkfGve;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0R8xTvF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795533212;
	bh=y2X/wZYEafImUYjcLYaVs1E/CKjjNJA3bWTOUC+gS6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHv6GOdmQTkjKgM2XOXvPRcJ5Gl0Rg3j2/jQZbVmhvJRs/F1YNRBQyTqQvaIj/D9u
	 gtJmC7SK4ov90GKBmGvCRg090aW19M8IgBXKf4rCOsQNBRmqOQ1xuoqunlXz1yo5Ss
	 xlL468IWkQtalb+fp3omojX+5r399EnVIcZazig2zYZ2x2bIo+GdshUMyZuPwy55zh
	 tRX6f3Y8SEaClIB3HRWm6E0fWRUFQMbxl2Y+ZYOemHfinl2oxuM7oOs9czGWXjdPgr
	 wpn7Fm1XOEixCqIki0psVzrOrYEm9z2WEGelvOWXFoC54+eASzk2YL+o3FRk4SM7eW
	 JegFtzggR+Ndw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09D2080DE7;
	Tue, 24 Nov 2026 15:13:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4063079D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 256B580DE7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7Wi_NgnzwNm for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55E7E80DCA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=lPYkfGve; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J0R8xTvF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55E7E80DCA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:13:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOEbvFS1236741
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y2X/wZYEafImUYjcLYaVs1E/CKjjNJA3bWTOUC+gS6I=; b=lPYkfGveme2zyhZN
 PiaM0f1h6bbvN7fCaLmoDIcyavWuI5KXiGs3NOkktMN9wRqtSEGTy0xmBLeZBJdE
 Z9xOQiteTL2aRThsQanpoFoVxpW6H/jsEWtOcjbsveYeoL8x0NH6PRj7PVmXYur/
 6aXjnDSRIdpRIA9NvgTnK7HHF+Sr46B5iheBPKfsfx0AUKSBmbRKci9G+vkhhGjB
 DMvBxsIUQTA1nW0u50wN6SdULOCZrJklG8XSijr4x8gSMcV7jI8S8hUEhot8kl/g
 z1pNOnpT/j1HhcHaTVxWD4AAWiYXyqu4Sc4J5kRtWXHWb3hAtIA627bIvzxPCvbO
 HaNtsQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb3est-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:13:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b3ad09ad82so63162977b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795533207; x=1796138007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2X/wZYEafImUYjcLYaVs1E/CKjjNJA3bWTOUC+gS6I=;
 b=J0R8xTvFs2BhmhgKKmBZFkMWovOSbVLBN4qQx9Z88lLDBZiDPo13Y5UcU94pm7E9+W
 g7ZmEwP0cYAtX2J+WNKLfpjzJKc2yqkug1VYF848f4DfMk6h+c7TsTVVRsiN6gPCTtgr
 VKg4MTQ6X4PxlzV+PMOikfLmBRmUmpPFlGBg5RaKGWibwTG5WG5PevFyHRzUGvQRMB5A
 49Y0mek0JJ7OgubPLV5PIIQmiM/uiagCyqBCAns53i7tcURD9SSQVOfyzm7C3VW/y7Yf
 9JOKJBcTduzG6oTD3dWiYwFPO213SbVpb2Ao7FDsOyRe/zADaJkqTGuo5B/ltXO2L7Jb
 FopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795533207; x=1796138007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2X/wZYEafImUYjcLYaVs1E/CKjjNJA3bWTOUC+gS6I=;
 b=hBVUHV8T3bszTx7W8Mn2PtFKgSXQUWSSwaKmD0gCigtyHTTNeUuUSdvKINxX6uYRnq
 PQJD95o3lDxWthmHhhuwHVO3IpM8bnpcXAa1sDsO0eyIPxDxR+MTWOKJmZ//AhvBbpIm
 +sQ/i69TCyVSQfog3idRSZ/dsWoEK1OJ3HaGyTZGpoTi7FLv59GIAXEx5GXZvunTKH4k
 D9UTGP3OiboqRAhC3aIXzFvY3dSNTxmBTsmutYqhvylg4cZPn9JoZ0cIlLVFKb5CA/ii
 n4JBvJWdoEsIJXLFy88NCfBpKl+Zwgu+3JsDIihsiRlFcbIkELFoEgTxnwB1z4KaXd/C
 BdzA==
X-Forwarded-Encrypted: i=1;
 AL+hErHpTaHeqBOC0gDEQzcEjunGis1aaLTI3PIXIg17jUkjcqIbCAPGitMkJGqJiK1pATYT4R+7zTU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/prz9hCjRQPgyiyaUisxwnTipMrDoawhJoCg4ovEB8Halt1hAC
 eCpKIc+LMYmvb8qUe/7v0dw2xnOG9GYtRrK+puwj86F8kZHf3SlZkFEg5PGh64xY9aeYWP6J5Bt
 VzPAAZ7J0uhsTQ5861fXfE1ClWcxsu76cCMBJxWjSaJmCPWd35OFB+v1AY4gnv4j5JeQYhoqp9Z
 uch1mMnxH3zUHfPwnrPfqBEXqhzfQDrjHGeun6SXiNHJifBQ==
X-Gm-Gg: AZFdTZfFNMfTyp2EnrySTu7HgnqltRirIhHos3g6di2Rgo7r5J7+6obQuomIdv5odld
 FcWnsIs2xP/1oY5IYfaQP8QO2zTzxngDg6vwdP/TkVZo2r3BT352jKc7GflOrmTGfxqEQYn2gZE
 F7UuaNB6MjQsfE8bpNLM+QJBRChLj5p9cu2skFm8YT03JKpr6vba7WDT8=
X-Received: by 2002:a05:690c:f0d:b0:8b4:ca74:6f6b with SMTP id
 00721157ae682-8b5204ab28dmr58459867b3.36.1795533206743; 
 Tue, 24 Nov 2026 07:13:26 -0800 (PST)
X-Received: by 2002:a05:690c:f0d:b0:8b4:ca74:6f6b with SMTP id
 00721157ae682-8b5204ab28dmr58459697b3.36.1795533206018; Tue, 24 Nov 2026
 07:13:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
 <179501661323.306911.11688771039281338221.b4-review@b4>
 <179503824009.2286122.6686071496349320129.b4-reply@b4>
 <xhkdbpkw1p6pu.fsf@mkorpers-koolstof.csb>
In-Reply-To: <xhkdbpkw1p6pu.fsf@mkorpers-koolstof.csb>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 16:13:13 +0100
X-Gm-Features: Aa3M54rbUoF5Cr2XvPEVNMy4QLHhzVTu-7cSKfk6PhJrjrlPFTrzvFtdZ19gywI
Message-ID: <CAPzfCAYvJ4Ei8rxN=VtK3hVwG4HA2f7Cji-chgRbq1Ze8W8J7Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] test: avb: test verification of preloaded partitions
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b05a997 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8
 a=KiRXLvIaMGz-wb0bs3wA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: b4MMv1uxlMwiE8yw2yVFWDMVTvXaiics
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfXwgdc2JKvzl1n
 mVBgoRZrOZDncRq1wicndoDjv68kdATIU7tT54cqKyfOKtKqlKgAcQoXPQ3L8qjImMuqgfwMXLV
 tIlKMBBH+aTNSR2+vM2H/SwMN54NDPA=
X-Proofpoint-GUID: b4MMv1uxlMwiE8yw2yVFWDMVTvXaiics
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX3mpGSyakqEcS
 nV/WM/2YeQb8JmiUTvTqzgnXU5FcIWJXdyxqNHdojgnqC84Hpylklhf+5RSVcqALu6Aeyu7dioJ
 Vv2R0gNmVJpMkrFbqHbnJv4HN97iGTMv9XcWj+jQRldQW49r+f1KvlOjjUI39dueoIMBvtRuUQD
 /yhSIATr0FT42I7wann4wml2kijtx/5iVPP/TCqXkloZMUkClAv3vbd5nx0y8jO6Y+HmCSdl21b
 fLGSh6eOZx1Ys1y17+dINS75ibCgGTKCpI6mZnBqu93kjkrVRgaRyqDwiasheXV1GLp72FXgzOr
 OXcb08P+DrGDViK5g2r0bph5XSEJEmSnVz/uYEuMHNFGYaW1m3S4eTsglV9p0blyol1gyOJyMq/
 TPeEhgC9fXiKxrmGjsBgdc2dC8c1oK6Qr6RvhgICYAZXojiG1iIlbONfJlqa62yn6lQNbB/ZoxK
 24EbmBbfC2njUsqXquw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240059
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs, Guillaume,

On Thu, Nov 19, 2026 at 9:26=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> On Wed, Nov 18, 2026 at 22:44, Guillaume La Roque <glaroque@baylibre.com>=
 wrote:
>
> > On 2026-11-18 16:43:33+01:00, Mattijs Korpershoek wrote:
> > Hi,
> >
> >> Hi Igor,
> >> thank you for the patch.
> >>
> >> > The Android bootmeth hands libavb the buffers it boots from, so that=
 the
> >> > bytes it verifies are the bytes it boots. Check that libavb hashes t=
he
> >> > buffer rather than a fresh read of the partition, that a tail the bo=
ot
> >> > image header did not announce is read into the same buffer, and that=
 a
> >> > buffer too small for the hash descriptor fails instead of overflowin=
g.
> >>
> >> If I run this as following:
> >> $ git clean -xdf && python3 -m venv venv && . venv/bin/activate && \=
=C2=AC
> >>     pip install -r test/py/requirements.txt && pip install setuptools =
&& \
> >>     ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
> >>
> >> I see failures because mmc12.img has not been created:
> >>
> >> =3D> =3D>  ut bootstd avb_preloaded
> >> Test: bootstd_setup_for_tests: bootstd_common.c
> >> Can't map file 'mmc1.img': Invalid argument
> >>    sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> >> Test: avb_preloaded: avb.c
> >> Can't map file 'mmc12.img': Invalid argument
> >>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
> >> test/boot/avb.c:71, avb_preloaded(): desc =3D NULL: Expected non-null,=
 got NULL
> >> Test: avb_preloaded: avb.c (flat tree)
> >> Can't map file 'mmc12.img': Invalid argument
> >>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
> >> test/boot/avb.c:71, avb_preloaded(): desc =3D NULL: Expected non-null,=
 got NULL
> >> Test 'avb_preloaded' failed 2 times
> >> Tests run: 2, 4 ms, average: 2 ms, failures: 2
> >> exit not allowed from main input shell.
> >> =3D> FAILED
> >>
> >> This can be worked-around by first running other tests for example, by
> >> doing:
> >> $ ./test/py/test.py --bd sandbox --build -k avb # creates mmc12.img
> >> $ ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
> >>
> >> But I'd prefer if we can run it as standlone (otherwise we depend on t=
he
> >> test execution order which is error-prone)

I reproduced it, will address in v2.
> >>
> >> Do you have an idea on how to fix this?
> >>
> >> Another question below
> > I reproduce the issue too, and not only on this test btw. I see it also
> > on the existing Android bootflow tests, e.g. bootflow_android_image_v2
> > (missing mmc8.img). The pytest tests in test_avb.py are fine standalone
> > thanks to the avb_device_id fixture, only the C tests run by test_ut
> > depend on test_ut_dm_init_bootstd to create the images.
>
> Yeah, I was aware that it was reproduced on the bootflow tests already.
> If that can be fixed as well it would be great, but it's not a blocker
> for this series, in my opinion.
>
> >
> > i think solution is to add some check in ut_ubman fixture in test/py/te=
sts/test_ut.py
> > to generate images if needed, today it's not the case images was done o=
nly
> > in  test_ut_dm_init_bootstd.
> >
> >
> >
> >
> >>
> >> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> >> > ---
> >> >  MAINTAINERS        |   1 +
> >> >  test/boot/Makefile |   1 +
> >> >  test/boot/avb.c    | 106 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >> >  3 files changed, 108 insertions(+)
> >> >
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index 76a06fbf7ab2..f2469e28cfb6 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -121,6 +121,7 @@ F:     common/avb_verify.c
> >> >  F:        doc/android/avb2.rst
> >> >  F:        include/avb_verify.h
> >> >  F:        lib/libavb/
> >> > +F:        test/boot/avb.c
> >> >  F:        test/py/tests/test_android/test_avb.py
> >> >
> >> >  ARC
> >> > diff --git a/test/boot/Makefile b/test/boot/Makefile
> >> > index a8803ded814a..8214151bd1bc 100644
> >> > --- a/test/boot/Makefile
> >> > +++ b/test/boot/Makefile
> >> > @@ -4,6 +4,7 @@
> >> >
> >> >  ifdef CONFIG_UT_BOOTSTD
> >> >  obj-$(CONFIG_BOOTSTD) +=3D bootdev.o bootstd_common.o bootflow.o bo=
otmeth.o
> >> > +obj-$(CONFIG_AVB_VERIFY) +=3D avb.o
> >> >  obj-$(CONFIG_FIT) +=3D image.o
> >> >
> >> >  ifdef CONFIG_VIDEO_SANDBOX_SDL
> >> > diff --git a/test/boot/avb.c b/test/boot/avb.c
> >> > new file mode 100644
> >> > index 000000000000..f2c3c58cccfc
> >> > --- /dev/null
> >> > +++ b/test/boot/avb.c
> >> > @@ -0,0 +1,106 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Tests for the AVB operations used by the Android bootmeth
> >> > + */
> >> > +
> >> > +#include <avb_verify.h>
> >> > +#include <blk.h>
> >> > +#include <dm.h>
> >> > +#include <malloc.h>
> >> > +#include <part.h>
> >> > +#include <asm/global_data.h>
> >> > +#include <dm/lists.h>
> >> > +#include <dm/ofnode.h>
> >> > +#include <test/ut.h>
> >> > +#include "bootstd_common.h"
> >> > +
> >> > +DECLARE_GLOBAL_DATA_PTR;
> >> > +
> >> > +/* mmc12.img: boot (boot image v2 with a hash footer), system, vbme=
ta */
> >> > +#define AVB_MMC_DEV       12
> >> > +
> >> > +/* Verify boot with the given preloaded buffer, return the libavb r=
esult */
> >> > +static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t siz=
e,
> >> > +                                          size_t max_size,
> >> > +                                          bool *used_buf)
> >> > +{
> >> > +  static const char *const parts[] =3D { "boot", NULL };
> >> > +  AvbSlotVerifyData *data =3D NULL;
> >> > +  AvbSlotVerifyResult res;
> >> > +  AvbOps *ops;
> >> > +
> >> > +  ops =3D avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
> >> > +  if (!ops)
> >> > +          return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> >> > +  if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
> >> > +          avb_ops_free(ops);
> >> > +          return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
> >> > +  }
> >> > +
> >> > +  res =3D avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NON=
E,
> >> > +                        AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALID=
ATE,
> >> > +                        &data);
> >> > +  *used_buf =3D data && data->num_loaded_partitions =3D=3D 1 &&
> >> > +              data->loaded_partitions[0].preloaded &&
> >> > +              data->loaded_partitions[0].data =3D=3D buf;
> >> > +  if (data)
> >> > +          avb_slot_verify_data_free(data);
> >> > +  avb_ops_free(ops);
> >> > +
> >> > +  return res;
> >> > +}
> >> > +
> >> > +/*
> >> > + * The bootmeth hands libavb the buffers it boots from, so that the=
 bytes it
> >> > + * verifies are the bytes it boots. Check that libavb hashes those =
buffers
> >> > + * rather than reading the partition again.
> >> > + */
> >> > +static int avb_preloaded(struct unit_test_state *uts)
> >> > +{
> >> > +  struct disk_partition info;
> >> > +  struct blk_desc *desc;
> >> > +  bool used_buf;
> >> > +  ofnode node;
> >> > +  size_t size;
> >> > +  u8 *buf;
> >> > +
> >> > +  node =3D ofnode_find_subnode(oftree_root(oftree_default()), "mmc1=
2");
> >> > +  ut_assert(ofnode_valid(node));
> >> > +  ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false))=
;
> >> > +  desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
> >> > +  ut_assertnonnull(desc);
> >> > +  ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
> >> > +
> >> > +  size =3D info.size * info.blksz;
> >> > +  buf =3D malloc(size);
> >> > +  ut_assertnonnull(buf);
> >> > +  ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf=
));
> >> > +
> >> > +  /* The preloaded buffer is what gets verified */
> >> > +  ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> >> > +              avb_verify_preloaded(buf, size, size, &used_buf));
> >> > +  ut_assert(used_buf);
> >> > +
> >> > +  /* A change to the buffer fails although the partition is intact =
*/
> >> > +  buf[0] ^=3D 0xff;
> >> > +  ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
> >> > +              avb_verify_preloaded(buf, size, size, &used_buf));
> >> > +
> >> > +  /*
> >> > +   * The boot image header may announce fewer bytes than the hash
> >> > +   * descriptor covers: the rest is read into the same buffer...
> >> > +   */
> >> > +  memset(buf, 0, size);
> >> > +  ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> >> > +              avb_verify_preloaded(buf, 0, size, &used_buf));
> >> > +  ut_assert(used_buf);
> >>
> >> I understand the value of testing fewer bytes than the has descriptor,
> >> but zero seems a "too special" case here.
> >>
> >> Can't we test something like 'size - a couple of bytes' ?
Agreed, will address in v2
