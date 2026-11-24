Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B3606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sF3bEueK;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RUQVQhHT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cWJhIaUn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2873405ED;
	Tue, 24 Nov 2026 09:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWJo8ZhxBP0g; Tue, 24 Nov 2026 09:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBB314066F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795512711;
	b=TObSBt5LhfLux402saRYnK7ddojTg3E3ZAKkbwPvMA5ZYfdbn+RlAYS8Ifub6ki37gFG
	 H3iSATSbduu8cH/A7TJRxZk0bJN+75nT/1vnETV7Y2lCM4fIe0ZqTkDJyId69OpS8NvDA
	 OIuvwTxiA7sqfhKE0tW4hS7jMkGOnsNBhP4LVZOx0HCYzOOLEPF0LIZ+cAXwni/S7cj+1
	 zWez3XR5ngusNp3cE9PNcGf5xxp6yN6mLj5ux1tolJHxerWL5EFyi6g1skkXJBTsXpgzz
	 8nuEFBF6pb9/fmwbvRUtQA42AA3aHtYp3JF/ARxsYxg6FtXmaUtwSn7Tx0nLNJVOO+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795512711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kLH1LFXpkIe4MF3ustcq0MoVxS+czaT+8KHgXhqP/Ik=;
	b=rBh3Xf7k8OPYE09auoV/GZtXA0SndJljo9NoGmXbWnTtaTTocVspPaVCUQvN0SvZgD/J
	 GLBPxJy6nPryKYM+B8HQvuZbg2qMvv3dCmh8L2Qv4TjKCCZFFiTfcB/pA0EwIdNQGR3o/
	 QAUDe6VsYVwiKtG9L2J6rdi4CHGsnoT/s5wpz01fMbzvc99rUZtWG+eF+spudYLeUWEw5
	 MUAsDzauclGIn5SOih9bCkhdzpLkXW0pCFxlyM2F1Py7MppwlJIAFKJ9T1YfaqJ/8P2TS
	 pdIhMowH7zhMTHwx6CoSxN4+LBbEMVPbCLrae/9xgTLF7icfpKbAqpiI93eCetH2jZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795512711;
	bh=kLH1LFXpkIe4MF3ustcq0MoVxS+czaT+8KHgXhqP/Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sF3bEueKXbWnbPbRWxlc6IHeEKQJ2XC3h5IzvUK0RkaZqPPWJ5AKU0MTuScpDBNhb
	 3orRtsIdMAJ/4c5/actIB23nBrxPnFqk75oGbnC1NFmKkn9nwt1RvhMljSIOcpUPDO
	 B/ZznA+Vzu1/YsGJZ9o92et4zzca9u1yb4TdDZT7Al8EyIB+gE+wTloe4Ie4/MiG0X
	 7F0IRv9NYb7+Lx5vHE+XCN1/7m5fj6IapAE//fIey/5MMeFRc6gC96Ng4gIJLg7B6n
	 Lzv2RlDY+C98Bc7zMOKK2t3mWulDNwZGgV8sgc1Fx2yEB/OgwpeExez4uNUrLngxRu
	 z3VKPMxDBwqNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBB314066F;
	Tue, 24 Nov 2026 09:31:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF2C5715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E38FC605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rpr6YghSZ1yD for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61087605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RUQVQhHT; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cWJhIaUn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61087605E9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:31:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO87jgP901980
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kLH1LFXpkIe4MF3ustcq0MoVxS+czaT+8KHgXhqP/Ik=; b=RUQVQhHTfvMs1V6d
 awlEmqoRlZlI3i4V/fTcC2OEgqU2tvJdmUubMhSfMsAjfMef30lytnDb/BeJ7KJP
 T14uMRJEn74K4XXrdZZQG3ckmZ2DO/mM299LVnY4J+thNc816c03xEcYdhYTfnJY
 VkMpjUHkMPdvXXGdQqUDpaIFwnN8xIWTzWgVxv4pw0taXvOLzfJfXpcl7lJN9g/H
 UTfhZNl4z4DND27JDZ/Ax7VmVpkZKTF1W0CvUUFT+M10k60Qu/pSAJLTymmc4l8T
 0C+b/swwr3gToojNMgFeoqDSzVVj6NGc6QvXluF9vMul25GA/dOzGIDXBZ2my+xO
 kz4hVg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6stgq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:31:47 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b51464f007so56475157b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795512706; x=1796117506;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kLH1LFXpkIe4MF3ustcq0MoVxS+czaT+8KHgXhqP/Ik=;
 b=cWJhIaUnMewaT9Dl7wMaqTeEzMYI/hbUXXhvbsHmrfHdEAqro1DkzSlxm500H4U+ep
 1mKR99bFvOWsWe43qPxp8aST8eekry6tJq2HW44e/xr6zJqC5XZpEhXp0NgQ+c+51CqY
 ZwjX9v86WtycvpMKJVst39bhgLRo0ZhWg8/XvlyTBFLBd2Q3q2ZVCFrmSjdcImmwNXNj
 pmfPV/JkCP2wh4ThSWRvbTm6xjrNOXERqJDFZxSYyGYzz/kH/VTxtNPpIVwXM0dzV+TH
 9Xt+Thfd5B4erw1dKcjoR6R6eD7BWwZkBJR/xbbKZ+MzRayCm0l8CuZLBwbt+0BZwZpc
 UfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795512706; x=1796117506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kLH1LFXpkIe4MF3ustcq0MoVxS+czaT+8KHgXhqP/Ik=;
 b=ENGyejTdMMd+DyGD1WiaGkZgsb+o6kBSPglYWQaz4rqTNbp7vJAvCHgFDJm5JqdlpR
 4cWFA8HkpPvBzWznW58/2Zket3vZnaMGHFfL9YyN0uzxZ8hjjOxNlJ1ogseipf4QRdzL
 vH2nXDWPVc0MLqKNeARxxoByu9m8DCkmUy8w+bqnv8Cmzattf6BmkcCxM0SdKd0/p4TB
 DrEzs8Iq+rdUUahrX4E7dExH1BmqAEcPtWJzJtHH1So6QCBV9ol6XShk7IjfZMpTQA1I
 XsG7W0XEHiHSDe3xA/ByTKdjxznHmQhyUezaby1BXoeA37cBVW693RMM+kRoExxwWYvv
 81kQ==
X-Gm-Message-State: APuU4Z/Of8LIUviMU9tzmqgsCmhzxYZ0SC/RwG5s4hLQU4RLztTEGySE
 EA1o13879YzwpVXhaVU8iS2OI18wFx+xn7PA+C1Z7/oLE99rqbESyx/xouPS8FlaXGamAuqwz6M
 5pro18f3cWf1s+g5Euz3C+BdlJrejIs698NCiUH1oDssvvm+CKMn1taZI/nYk03LRNurGV2X4uh
 2XOXjlOd9017HQR9JfTWsCp7iJ4Q8IJw4CvQWG/EQtAAoXNw==
X-Gm-Gg: AZFdTZcNSHvuhPJ8DDehXaTf2Gd4fB/Q/QqNs7OY/6UDT5Mn37tEXmPAIjNvNk8prtN
 u2PyDN5xbFk4maRGWACeUKn9/7cO2PaDYKZFtNmQTNKwPB/VdBWNGPOryX4bZlke8ZWjgbhatU2
 jdRgU6Qz7kkphhq8BhL+f3GsBV36e2ewplzZpZ14dskZyMsxlY7Vzj3y8=
X-Received: by 2002:a05:690c:442:b0:8b3:392:dc1c with SMTP id
 00721157ae682-8b5204ab299mr51578797b3.36.1795512706029; 
 Tue, 24 Nov 2026 01:31:46 -0800 (PST)
X-Received: by 2002:a05:690c:442:b0:8b3:392:dc1c with SMTP id
 00721157ae682-8b5204ab299mr51578747b3.36.1795512705549; Tue, 24 Nov 2026
 01:31:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123223805.GQ3176972@bill-the-cat>
In-Reply-To: <20261123223805.GQ3176972@bill-the-cat>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 10:31:34 +0100
X-Gm-Features: Aa3M54rSzI0KAfGeRJqLPtpYy1vXnbPUM92EXGYANqzTmjxyhZEA3FwFrcxW0c4
Message-ID: <CAPzfCAbS0nULr+fVHd52LdYY2CrBYV3wWkM-g+Le+pp7pWnx0A@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: B-eMIsLg-gdYWagBplgOy3Qpq-NAAdNG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNiBTYWx0ZWRfXzVhujWf+sCKv
 ydsMibC8r4pXgsX1GaJBJu0oG85WhKd8UsEU+AvPwWGSmw49v8cdkpAUEeT3L1IzRiOjDza6WlQ
 RGA8sz2TwPWhOFsWDgZrflhJ67n9WMQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNiBTYWx0ZWRfXxgBqUNqBnLhr
 8iuwfnW6KXS2aEC1cc2jrnjHx2F4P7MEAFM3+Gkmcf0anPlzbHFRMttI8YNH43CAoN5wRKfJqQB
 eK4wXeX1q8CxWSRWvmNa0bRxTB7lAVo9pK82Q0qaWkkQnUcl/Zqn6fGkF7tM3p2j3GhiKBPrUGG
 7jG3Vw+A/lVyzHqj3Eu1VxzfOZZSNMT0GLwPU6vf+z7dsrf2ol8F0JNNqH4tRKf05NQoZevgC7X
 G5jSrMIFLOv1d97uQTgbRMf6BTUx5A2VXY1JhOWz3qq1cXCmqwf5qqbEZIq9mA32xqtrmt6edGi
 Fcthgkd+ws4y+P8GGdFux3Owhxj7qynNMOZzCdvWBYIb3Y8wItDhSPuQAOOv6a7Rv0BDEMiLhcb
 LmRadhevJ0TSM1IANmKVU9d12VdA0MhDiOkG1Dbr78kSS4xVSRC+mZGw2yk3W8CW4JulzGFquPH
 X64g8ka1yem505CulNA==
X-Proofpoint-ORIG-GUID: B-eMIsLg-gdYWagBplgOy3Qpq-NAAdNG
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b055983 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=6xGJIMmgAAAA:8 a=k-42gJp3AAAA:8 a=pGLkceISAAAA:8
 a=AJ0-sOwo9pNA1uiMy5UA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=aWz6Jz32kaLdCzdWRG-w:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240036
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, Nov 23, 2026 at 11:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> Here's the report from v2027.01-rc3. Looks like the AVB update
> introduced a few issues, or at least things to investigate. Thanks!
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Nov 23, 2026 at 4:33=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 5
>    - 9 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 5 of 5 defect(s)
>
> Defect Details
>
> ** CID 662464:       Memory - illegal accesses  (UNINIT)
>
>
> _________________________________________________________________________=
____________________
> *** CID 662464:         Memory - illegal accesses  (UNINIT)
> /lib/libavb/avb_slot_verify.c: 450             in
> load_and_verify_hash_partition()
> 444
> &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
> 445         loaded_partition->digest =3D avb_calloc(digest_len);
> 446         if (loaded_partition->digest =3D=3D NULL) {
> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> 448           goto fail;
> 449         }
> >>>     CID 662464:         Memory - illegal accesses  (UNINIT)
> >>>     Using uninitialized value "digest" when calling "avb_memcpy".
> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
> 451         loaded_partition->digest_size =3D digest_len;
> 452         loaded_partition->digest_type =3D digest_type;
> 453         loaded_partition->partition_name =3D avb_strdup(found);
> 454         loaded_partition->data_size =3D image_size;
> 455         loaded_partition->data =3D image_buf;
>
> ** CID 662463:       Uninitialized variables  (UNINIT)
> /lib/libavb/avb_slot_verify.c: 452           in load_and_verify_hash_part=
ition()
>
>
> _________________________________________________________________________=
____________________
> *** CID 662463:         Uninitialized variables  (UNINIT)
> /lib/libavb/avb_slot_verify.c: 452             in
> load_and_verify_hash_partition()
> 446         if (loaded_partition->digest =3D=3D NULL) {
> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> 448           goto fail;
> 449         }
> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
> 451         loaded_partition->digest_size =3D digest_len;
> >>>     CID 662463:         Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "digest_type".
> 452         loaded_partition->digest_type =3D digest_type;
> 453         loaded_partition->partition_name =3D avb_strdup(found);
> 454         loaded_partition->data_size =3D image_size;
> 455         loaded_partition->data =3D image_buf;
> 456         loaded_partition->preloaded =3D image_preloaded;
> 457         loaded_partition->verify_result =3D ret;
>
> ** CID 662462:       Uninitialized variables  (UNINIT)
>
>
> _________________________________________________________________________=
____________________
> *** CID 662462:         Uninitialized variables  (UNINIT)
> /lib/libavb/avb_slot_verify.c: 445             in
> load_and_verify_hash_partition()
> 439           avb_error(part_name, ": Too many loaded partitions.\n");
> 440           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> 441           goto fail;
> 442         }
> 443         loaded_partition =3D
> 444
> &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
> >>>     CID 662462:         Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "digest_len" when calling "avb_calloc".
> 445         loaded_partition->digest =3D avb_calloc(digest_len);
> 446         if (loaded_partition->digest =3D=3D NULL) {
> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> 448           goto fail;
> 449         }
> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
>
> ** CID 536494:       Integer handling issues  (INTEGER_OVERFLOW)
> /include/linux/log2.h: 72           in __rounddown_pow_of_two()
>
>

Thanks for forwarding the report. I think the three AVB warnings
(662462, 662463,
and 662464) are false positives. The early success path for an
unrequested partition
leaves image_buf NULL, and partition-load failures and unsupported
hash algorithms
skip the copy.

So every path that reaches the copy has already initialized digest, digest_=
len,
and digest_type, including when verification errors are allowed.

I did spot a pre-existing issue in the same AVB block (no check for
avb_strdup(found)) though,
will send a patch soon.

Thanks,
Igor


> _________________________________________________________________________=
____________________
> *** CID 536494:         Integer handling issues  (INTEGER_OVERFLOW)
> /include/linux/log2.h: 72             in __rounddown_pow_of_two()
> 66      * __rounddown_pow_of_two() - round down to nearest power of two
> 67      * @n: value to round down
> 68      */
> 69     static inline __attribute__((const))
> 70     unsigned long __rounddown_pow_of_two(unsigned long n)
> 71     {
> >>>     CID 536494:         Integer handling issues  (INTEGER_OVERFLOW)
> >>>     Expression "fls_long(n) - 1U", where "fls_long(n)" is known to be=
 equal to 0, underflows the type of "fls_long(n) - 1U", which is type "unsi=
gned int".
> 72      return 1UL << (fls_long(n) - 1);
> 73     }
> 74
> 75     /**
> 76      * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
> 77      * @n: parameter
>
> ** CID 243627:       Integer handling issues  (BAD_SHIFT)
> /include/linux/log2.h: 72           in __rounddown_pow_of_two()
>
>
> _________________________________________________________________________=
____________________
> *** CID 243627:         Integer handling issues  (BAD_SHIFT)
> /include/linux/log2.h: 72             in __rounddown_pow_of_two()
> 66      * __rounddown_pow_of_two() - round down to nearest power of two
> 67      * @n: value to round down
> 68      */
> 69     static inline __attribute__((const))
> 70     unsigned long __rounddown_pow_of_two(unsigned long n)
> 71     {
> >>>     CID 243627:         Integer handling issues  (BAD_SHIFT)
> >>>     In expression "1UL << fls_long(n) - 1U", left shifting by more th=
an 63 bits has undefined behavior.  The shift amount, "fls_long(n) - 1U", i=
s 4294967295.
> 72      return 1UL << (fls_long(n) - 1);
> 73     }
> 74
> 75     /**
> 76      * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
> 77      * @n: parameter
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
