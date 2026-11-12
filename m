Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1AyrhgtF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oKpeWHq2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcP0Bb6j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A0F840ABE;
	Thu, 12 Nov 2026 06:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id joYDt5W596ay; Thu, 12 Nov 2026 06:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0E52409E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794466051;
	b=MMCMWv3tMTtwBeVlIxufnK9RltWYVR6Es+buFjBAKu3iXV2V9NNtqSCDfVGWw0i0Xxuh
	 kAyMILQCdVt2q4W5fwoSm8X1B5fLi8InwN4LmDbAwwu7h8PVvwtM9+UFf+Jc5hAseICDl
	 0cAHBhHEEuFGdf2hxfdEIyvYClXbtZN1m6Yke6jn36xf/sd3vC7qh84vLrL/lqafE7oyu
	 /Xq8ht5JiIMU3Eey/FJcI5XGOBVtKsWWgc3pb+AjdCa1WdkA1D1pMytSzrkXikWeJcKSr
	 TBotyc+7JIsckPqxwNKEfkFa2T+nAW+b+DNwv3TBdY6Yt1PaeQD0xBQLNJLsZcVbQOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bSIPfAzghnfRT/P4b/SP9lRFlkUFjn67PUiujaV23Kk=;
	b=cJv5F5hxGw4GENUR6+svSTwOEltb2QVg+VWQnRrNA1iKOuFbljXVr15m9AwAxHfB0u1D
	 1Tp4Lf9HjjnFQaenoXN4PuZPZI2vwtxH3s+9ILkvlIth76SPWTPayYoTCNSYzSfCbKUTw
	 D0CGLMIwaYBpSkukbWFWL3aDGRe+OBekawuH7y5rspU9cq9gIAYoqoaBS53FkV2jnOj4s
	 AQz0Rz2l5+TVwMptD0EFuW6/WW/rTeAXjEZyJtF4+XkpIvc/RU2RB5jMA65Q/6+RBl0Yn
	 zle+TiRErYTSfWxS0BuLF88Tw56Mo1w6mVSSLcyDiG4RNm1jv/LWMfudK9vWX3iwzPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oKpeWHq2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcP0Bb6j;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794466051;
	bh=bSIPfAzghnfRT/P4b/SP9lRFlkUFjn67PUiujaV23Kk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1AyrhgtFHyvDyMAou0UaExY0LcC7YYHm11kfVjiKrEyvmzxzdZ7HagpmSGZWCqbM8
	 A7a3dmFfP5HmzBpmtXK7OcasINkmX2uVVo/8YijzOzcMcyIVW3gFVi6hti3DbLIEhl
	 IclbWeWNdeqF00rX5QEUKGH5ivqRSRlTKOPH7xm26NaWZU6XwWn8I4FRfRlLsv6dxB
	 5+HBG/MAUz5FjYjS8MFcxTVtVChu7CQQ9HJB0tSKb1sCs/Pksz7/GL/zYaFhrel89O
	 VUhokNZrP46BRoWyZE5f8uHCC3SxLmjBIiOCFDfFHG6ugBUJTO6XiMqfv9c1hWFg3K
	 3Wo+BXxTwDoig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0E52409E6;
	Thu, 12 Nov 2026 06:47:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B350570B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A478440A30
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVHgeXMZSkF3 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A804409E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oKpeWHq2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dcP0Bb6j
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A804409E6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:47:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZO584092378
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bSIPfAzghnfRT/P4b/SP9lRFlkUFjn67PUiujaV23Kk=; b=oKpeWHq268ekarsn
 e0c/FZmYrAo6CMoz+pirvjGkB9VxXrmIIZGehrxj6QSDwjSgBuvvse9e9QpRmuX8
 1VvlG9+2Kpi01rOI/YpSRLgzP00EHtvYOJ8gUN77r8s20xySzCAn31UO5CSHwSbB
 vZKP0xk625LC4WKlNn9afOAP2GFU+0XeF0hygHE5JrEE0jKWjmYYYRHbil2Nlzb3
 0+kVbYoY0jK+VVHQbOiQP6h1kJmtFOMpQGlYA2pzOboSKE2ABKeNx815UzU0mxJp
 sg1rVgfo/QL7kCrptb7hJeK/MaiVoMqyLwg4vN1cvo6CcVij1BiyWOwkrLGf9Al8
 Bhmvpg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8hk2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:47:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a2af4c8cbaso3070046c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794466047; x=1795070847;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bSIPfAzghnfRT/P4b/SP9lRFlkUFjn67PUiujaV23Kk=;
 b=dcP0Bb6jre7dudfFkMdghb++0UCOh7v7V8B9JUHHva+GZswQ2C88MW3GNfUKy3F6XD
 VAZEwt47wfVjuRsHBzFpiwBM4szJGuNBrP2LZBgR44MfLZOJ/4yZAKWchHQRcZ87+LNw
 0qRz+k65XcW05ooivKLK227AroGrdriO/O9huET1Fbo52YwGel70sq/XGm7iCg9S59Iz
 W8J8EwaCVTxMKTnSqnAgTF6zuVN8SSn+6iUryWJnuCGwQYZYlfjvPUcpRU6g/OjrN9DI
 JkL/+AAh0yCqo0r5u6C4bavjjfbhop4ntPwRyT8ArdX2DPTJ50DmDLGeUoQoqLP1n6Cf
 eFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794466047; x=1795070847;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bSIPfAzghnfRT/P4b/SP9lRFlkUFjn67PUiujaV23Kk=;
 b=tWyvfrsdvsMdkNQ9e3MScdYUOTtbDKJVKQertcv5VsFSCBY+ozCgudonUhp2DwE86X
 //PKjGUufNZRcXwmpBBpsHSN/Qkrl0yr929HxTxFiNBCeZYteKAS3fCpsnLb6Tkw4rZo
 BwDILZiwFsFmlHtR2lgI4To1rfeCsjYvkEc9cAkQcJJ/OvLgTfZqGzwWGKxMc2fHLhc8
 w1MWh8zGNy3CB86gLLC6TvrFHE/cf8WG7ezTs1GshEJwpyaCkIngqaADFKzIUPAKdFBf
 59G7w1uUsxdL41D8Bi1051qxSBVv7GVDK7Ya3KLu7+i1SvxX61nrYXRbccG50Jj4xUod
 Bxpg==
X-Forwarded-Encrypted: i=1;
 AL+hErEoLz/l8fkmbRhf3qg3ehh/G3UE96OCPXN5ZMK6qf/JnZlimpbEiV+YQ6kaehU2gn6RHK81b/8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+T0VhUpKp6m4SI9d3MpJ1RZBTVCOnKuEnKzMnBvfoQGzJBfkcA
 ZR+i4sItpv0kZM92dHZR68e9ptHxHdBHdRXmMuD3cCvUeSAAB3MOCZhCUaXsL9F2gK/0j7WzKJT
 BYXmb2uRfhiw5NxhgRyapbCSH+eOTbHmlVExL2nUfzFOoFMaYGnzqDC2VabcrbiiM/eaqO2DWgN
 h8/ekJiAcD
X-Gm-Gg: AYBFou3wfrjUdhpMcVKGgcqMOoGWRhTeayYPPT78dA/UlROdwrEDY63scxOG7T2VnK1
 qVoUgwH/R8naxkH8E7IxnBUhHkKJGHu1iv+hAHdD6qAFZfvEeQ7IQYjqNE7RCZ0RH+30zdfJWE6
 oeBtfrfyKgtk/QauD+FT+iLzePmWIzWmUx6lczjL6p7LHYtfVSGM4+mQ+8/xQfPTKPabk1wLjeq
 8clvaK5EmBeAHzQjW07GRlBfR5PxSo54GnUcOfWVolYJRgR8/L+EygdpsO3sifn9kr418mXl85b
 L6xHXnaG+s8i/t/qZ6KnSDju+uLAMzsuaMOa3o8pXxh9NSwv4bbtNcDJHZmnUszFwmKrLD0ri6n
 HYVkY6mO20mSkpl1Xf1uEIx7i32mqmucGxVocNHDA/2ihdAJxAdbr89TfsSi3mnhdZAwh/f1/GD
 OscpNMMdLt0Mk=
X-Received: by 2002:a05:701b:450e:10b0:143:5cb4:30 with SMTP id
 a92af1059eb24-1b3c0246c92mr4222800c88.3.1794466046563; 
 Wed, 11 Nov 2026 22:47:26 -0800 (PST)
X-Received: by 2002:a05:701b:450e:10b0:143:5cb4:30 with SMTP id
 a92af1059eb24-1b3c0246c92mr4222779c88.3.1794466045860; 
 Wed, 11 Nov 2026 22:47:25 -0800 (PST)
Received: from [10.151.41.168] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890e04sm22471126c88.2.2026.11.11.22.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 22:47:25 -0800 (PST)
Message-ID: <a04ca18b-1ab5-4db6-a5ce-1fbbbdfa5917@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 12:17:21 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reboot-mode: update env from every reboot-mode device on
 boot
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261020-reboot-mode-env-update-all-devices-v1-1-62f428488321@oss.qualcomm.com>
 <01c106ef-a383-4e8c-8046-a9a56cf32815@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <01c106ef-a383-4e8c-8046-a9a56cf32815@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfX+CMPxGkScbSX
 sB5KEpOXCstmHoH74STpCK2ygim5e47xY+H0JmqJTLFu3hD0tqkjBytJMMZLhjAxMmHNHjkVn2q
 CXG2tSUQKJ50Nx4nsk8ru8NJODbu2/c=
X-Proofpoint-GUID: 173TmEno2UjgO-aVYbQGvRrLjZ0WJVZs
X-Proofpoint-ORIG-GUID: 173TmEno2UjgO-aVYbQGvRrLjZ0WJVZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfX/FLHlf0+xSOE
 kvPOqYJb7E5MyI41u4xTEpeDTy0OhXsnnd9IKenprZopDS7U4SizYVcpsbR7cyjQULIv+/Ltmt5
 g4eT4XgAnNWbKCH6hXykd0QpFzekOadS0awRHVnD7gUE2DSQVVoZeruhS11YmuVilX/ZXkiivym
 JGDZGX77bit3aEuBDA+yBfNyuHU+Cy6riMfdtMgcxPsLbLW/qC622SDyMtB+8AS9MQFLHHNTopt
 vScqlwhUOeQly2/POhc32le8uV/wtxUz6jlbMSehE8WNNVCmvOgDEwapFGlcqWrdrCJ3SyoxibC
 vgpxgJfeuG8shEscjExajXeQkAYVKBq4zb0xtGPQ/eaSAm/35hBWal4OINx51duqVjlQeKxsL5m
 FGREV2/Xn+XfubvtC3Fa2i6lwB+5kmbrM4taXoJqayw8Lh8Yb1GEyykNafKh6SYoXawsDin3PYg
 XTN1Ne/7iynj0qBtDlg==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af560ff cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MB9wWt6Y1nSrsWrT2BsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120026
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Casey,

On 11/8/2026 10:08 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 20/10/2026 09:33, Balaji Selvanathan wrote:
>> REBOOT_MODE_ENV_UPDATE only updates the reboot-mode env variable from
>> the first reboot-mode device found at last stage init. A board can
>> register more than one reboot-mode device, and if the first one has no
>> get() op, dm_reboot_mode_update() returns -ENOSYS and the others are
>> never read.
>>
>> Iterate over every UCLASS_REBOOT_MODE device instead. Devices without a
>> get() op are skipped, so the result no longer depends on probe order.
> patch seems fine, commit message and kconfig description need rewriting.

Okay, will reword and resend.

Thanks,

Balaji

>
> Thanks,
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> This patch depends on this series: https://lore.kernel.org/u-boot/20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com/
>> ---
>>   drivers/reboot-mode/Kconfig              |  6 ++++--
>>   drivers/reboot-mode/reboot-mode-uclass.c | 15 +++++++++------
>>   2 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
>> index 35f12e1bdfc..710baf85200 100644
>> --- a/drivers/reboot-mode/Kconfig
>> +++ b/drivers/reboot-mode/Kconfig
>> @@ -44,7 +44,9 @@ config REBOOT_MODE_ENV_UPDATE
>>   	depends on DM_REBOOT_MODE
>>   	help
>>   	  When enabled, the reboot-mode uclass will automatically call
>> -	  dm_reboot_mode_update() on the first reboot-mode device at last
>> -	  stage init.
>> +	  dm_reboot_mode_update() on every reboot-mode device at last stage
>> +	  init. Devices without a get() op have no backing store to read and
>> +	  are skipped, so only devices with a get() op update the env
>> +	  variable.
>>   
>>   endmenu
>> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
>> index 976544d2810..dc8dc754c25 100644
>> --- a/drivers/reboot-mode/reboot-mode-uclass.c
>> +++ b/drivers/reboot-mode/reboot-mode-uclass.c
>> @@ -122,8 +122,9 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
>>    * stage init.
>>    *
>>    * Called via EVT_LAST_STAGE_INIT, which fires after the environment is fully
>> - * initialized.
>> - *
>> + * initialized. Every reboot-mode device is offered the chance to update the
>> + * env variable from its backing store. Devices without a get() op return
>> + * -ENOSYS and are skipped, so probe order does not matter.
>>    */
>>   static int reboot_mode_last_stage_init(void)
>>   {
>> @@ -133,11 +134,13 @@ static int reboot_mode_last_stage_init(void)
>>   	if (!CONFIG_IS_ENABLED(REBOOT_MODE_ENV_UPDATE))
>>   		return 0;
>>   
>> -	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &dev);
>> -	if (ret)
>> -		return 0;
>> +	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
>> +		ret = dm_reboot_mode_update(dev);
>> +		if (ret && ret != -ENOSYS)
>> +			dev_dbg(dev, "reboot-mode update failed: %d\n", ret);
>> +	}
>>   
>> -	return dm_reboot_mode_update(dev);
>> +	return 0;
>>   }
>>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, reboot_mode_last_stage_init);
>>   
>>
>> ---
>> base-commit: e6af0ff0a6e884320938f9c698efad3e217b4e99
>> change-id: 20261020-reboot-mode-env-update-all-devices-2bb1457e3a3c
>>
>> Best regards,
