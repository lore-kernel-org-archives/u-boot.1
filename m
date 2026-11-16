Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D43606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SHOhXeJO;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HAyMCCj5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXpGOKB+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3116D80E81;
	Mon, 16 Nov 2026 13:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nno3bgMLaw0s; Mon, 16 Nov 2026 13:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 886FC80EB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834140;
	b=M635HRupzAwtb8Pu100l2p8lXmEi+c8kLct/R4TFqa4PInumYfiSSfPmqOCt5Du4tCVk
	 Gt0HKfcnE3JzkEngdzTf8QcUNuz2cdv2/KQe6Rrijs6TQ5hhWReSsrXDNNV+ClhMUmkX+
	 iq+D0D8hmaHtqv44l7p0ySfKVeXx2G/OrWo2RGWaN57bx4lzRHhd6S/xdV/49hmHpxFeW
	 zAx2lwY+0v/YYaZcCVJxd6sfH6hRD9hLfCp951Tt59tClO3wqx3YG5PKjDXzkwxmNB6Bw
	 ZPmTOdVzZ8bzD6EdjCTl0KVYw2ipBZJw0n+0aUiISxhyNA3sFtuiDq7ugpyUwb3ysRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a688rtCkyZC92PHmySHGyYxHWYgCd5rQVHlS4RArVmQ=;
	b=aNQQZ8vn+HIP6yRW2BM3zwB1v35MnjmI20r3LvHYD1NievqDew6vCufwyII2kjfCi922
	 edujxFfOe4sFBDlD8/JDRTSVbmxYOaR6aiWWyA5wd8JEzmJF0ONFqKBYwx1xin8bZtDqQ
	 CAZaVhscARir5Pmh4yLxfZ8k7HncD+H/ctro3UKcZvL5PAUUeHun5d57khg17YNsBlrC6
	 0OS6rHuQB3wHgyh2il2IWz5r751s5pf7a6GwEW9C4Q8ZyL4HwqkTU95cehJqhfD8C+CLh
	 y1kQS3gfdB/4airufoServdJ9S04ZfEtqCBzd/wy8D6JPpMr61Tbz/s9B7GdHTA9FbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834140;
	bh=a688rtCkyZC92PHmySHGyYxHWYgCd5rQVHlS4RArVmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHOhXeJOCKuPNQOErTALdM4AYQ9f7CDPcuQfET776pBDsYvmB3FbYklg55JHuxD65
	 7b43lJyH5khY7iX2o6c4l9u/l/cbNke1E6R4ge3SQm2MUmQku/1a5Nm7rfvY5MpKu7
	 qMuVpCec6xO76WyaVm6jf1vFMOmrYzR3rXwFx4KndUD+NIs0IlBFLaBBioe1ZtqxP6
	 bBnQoDh86QeqLIA20kopCQGu+YMI3OLC25h/IEIQ9NBypmaYeV3JWsIO3jE1jU3TpE
	 sLX54r9+oiIQZYAHtFx0XhPma0waJGxQUPyswsXfKyqmQFBFab8rSM/5cOFBcKYYeQ
	 DoeBmbt3sUm0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 886FC80EB3;
	Mon, 16 Nov 2026 13:02:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A16A28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 506554008C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFycKZ4fl5QN for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:07:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62B0B40012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HAyMCCj5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bXpGOKB+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62B0B40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4R3kn472458
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a688rtCkyZC92PHmySHGyYxHWYgCd5rQVHlS4RArVmQ=; b=HAyMCCj5TIPNsEV7
 3SEFaobo0wbEmwPTDW33p9pa80ZyirHs3vQ1Cw/cz8cjCcFyeUiuRVerVfBVEurT
 AX0h6eJpZvDBlDiD6E94GZAAAFG2P4OQz8w4Vw+3AL8gJn38EGAtI00cDdORnVOj
 u/+l5P83PlpurD2/UqYA8v5pzk3+7f1/IwYneCc5QmLKfbSwN18QVSw0AG5eZrqN
 tDSCIIjirk7O8ctrRnFPOggL4cZYrAEUgjFNyAH+/m1cP0QJS12H6Dg3TWKZz9+5
 A8w4ZMn9xfnzLEq53D6s7ED1f/w+/6cGPprBeCNV8p6X/y91vyN437gejqJNIyl1
 Ut18XA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjvwc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-77f133855b9so82309137.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794805676; x=1795410476;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a688rtCkyZC92PHmySHGyYxHWYgCd5rQVHlS4RArVmQ=;
 b=bXpGOKB+Hu9fOOK60wGXEGxE8xXk/CsioaX8WdXAxHbDdyHAqeYHS/LCJ1cZLzod8V
 9zEfiPNnIWJDJyT2ZdUWdbkx4xz4fo0Z6pV4NQWQQ99sALtmdNTHRPZbsfvYqAnrEq9Y
 gVHQ77jI8GLoG7C4iilYCiux9wWo1IPam0XhK/y/zCcjG8AtqXRT1/IW/XA/gbwPUl2U
 wzaJsaEhV3Gt/kN5T9fMTFu3xzPvX+wXUqRsyMVNnKIMhdGhgHONtfPAULRc97MWRa7E
 pkQXzxZJSZ9U6lTxzow9EZR/oYeOgjGFJbNS6kdzqqn332ydGn63novKpmmCZPl4paZL
 +T3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794805676; x=1795410476;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a688rtCkyZC92PHmySHGyYxHWYgCd5rQVHlS4RArVmQ=;
 b=HgaUVqKaZQnZnbTljPv9obXifsLBAHbcha4o1KS9VEa2BFSooxVdAjrVBj1Dw47woh
 RQo8/mrdU+i8EPVgJK1+quiuPNEROyvQGHJpjwEqQPXiI+3W0DPOTUlFRaa8RP1mqxXf
 UyDHMeg7cJ+WbQ0G9e4dCBJB3FXmsfcRqhkj9enxIn+rgXrldLuxuuGxyflNzXDfd3Vt
 YnDp+pf4CVilTUxF9u/khAtUVGum/2kWDRZPYC45UOLthLnU2TExhLSUAN3i2m/0p5yO
 6/E2/E9zdbCgp38hpvgIRfYWcpVNVm4kq5D9pXbHl/3iUMLb8MulL1Wsq0HKZHDlkCOK
 u4rw==
X-Gm-Message-State: APuU4Z9f9k+7i8d54J+2/5Ffyc2I60rWgxmWfycEZJdxIkrzOC1jba9v
 Fcqs2eJZM7pJMaohjw4xPZhqciCJDtFPiFVEj1olAfBh8KL3X1GbWRlYCwsLBBifsx3tPur6Pr0
 KqYmOJE8JAjRpL/45JmXKGKkiS2f+OdsMXQ2nSPYBngOteh/Vlpp3jzG90cCSc9IH9UevAG3a4D
 0/Gfxmq4FciWLAxlWXbPAXx2aS8hF8MbGe2Cjood0369txXA==
X-Gm-Gg: AYBFou3zG5cfV+bxfqZX99Az0671ONYTmqjRTCpnbdhDJijtG2URT1OVcZYOmuFnIzt
 TZaarYhD6KSIAxYFl6Y2Hvz73sb5drfQWZN+mfF5crquVLdrhUQlUVVOhSjc5/mZImcOFQIgc/8
 eNkBOKMKzqt8EM83xBrqP0xvjWgNUF+eO/S7ctTomoQGZHZPtAouGelIQIr+M=
X-Received: by 2002:a05:6102:8547:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d64d4104b4mr2604173137.1.1794805675747; 
 Sun, 15 Nov 2026 21:07:55 -0800 (PST)
X-Received: by 2002:a05:6102:8547:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d64d4104b4mr2604163137.1.1794805675171; Sun, 15 Nov 2026
 21:07:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113-rpmi_v4-v5-3-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-3-6787318ad186@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:37:44 +0530
X-Gm-Features: Aa3M54r0kJ7uwZdVUocgL_BSa5eDTFFsr-PuLEduLbaVCv0R2bkvD6UmNeQxDJw
Message-ID: <CAPxK-6eV6hhcrBUmRfRpc6Qf0Gx_7pAygfe1miG4n6MFMDbrNQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] firmware: rpmi: add support for shared memory
 transport
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX7AUtKv2EAJCX
 hy4wSq/eirZsZMk3pqUArT9V8QTzCZBr1zKGQwqI93pYt60ASHxASYsk8vfBQSISd22lMCAIk0J
 ZFsaBxlTu64YoiaoKzqa7ZdxMYoIbfGo6nWHFzuVHb1oeW2TsO31vR8ywwKFJMTmXyp1jvuXOVe
 hXaI7EqgeDWP++WTD00NYMZHJjwhkAUQq5h9Bh+Zxilp2sdWwXdYuI6x/Jc37pulWr8edzdtcJM
 C+CTDkoitpxvYj/q+hT9yZ6Rl9bwjoQRTWgCaqRz92L/oiDUXv9LuFeN5vwCR+r5fUjIKmf6Vom
 nLz4eT3kZG8jwY6/fYipY4m8fMUQs51tJmhu/7bujYF7lrXx1Ei9DrHNmdBT1Zkegf7ByimhmEB
 Z+ANArksudeMWefXP4GeuNIMWEFyFJuSSVFrDkbqzbQYs6uacK6wGnY4bPkXXPl0GGiyaBZENcW
 O7Ng6lW7wklVWA6cr8A==
X-Proofpoint-ORIG-GUID: jNKe4YW-KyZW5YDOQf4uQRKJx40-M1Bk
X-Proofpoint-GUID: jNKe4YW-KyZW5YDOQf4uQRKJx40-M1Bk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX0BRC5GAcxDCO
 D2rlWOgGmefhMkhz7gCen6jiKn7/aPvf2ycFzP34LTjOxhQb4jq3Gq3uHnVQzHduirEHtjwrVcl
 ZUDYE6OsYr//IXZ13gAEB17CIxU8oFM=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afa8fac cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8
 a=0CjJnxMWMwjMeDG4vOEA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160020
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:02:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 1:13=E2=80=AFAM Charles Perry
<charles.perry@microchip.com> wrote:
>
> Add support for transport of RPMI messages over shared memory as
> described in the RPMI spec [1]. This uses two or four ring buffers
> composed of a fixed number of "slots" to pass messages between the AP
> and the PuC. U-Boot is the Application processor (AP) and sends messages
> through the a2p-req queue and receives response though the p2a-ack
> queue. There is no support for platform microcontroller (PuC) initiated
> requests nor notifications.
>
> This transport can be used in M or S mode U-Boot, but in the S-mode
> case, one must make sure that the supervisor software isn't already
> using the AP side of the shared memory.
>
> [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 2)
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v5: (from Subrahmanya review)
>  - Access the head and tail via readl/writel and data slots with
>    memcpy_[to/from]io. The memory region used for the shared queues might
>    not be normal memory and should be read/write to using IO accessor.
>  - Match the service_id and servicegroup_id in addition to the token in
>    rpmi_smq_rx()
>  - Reject responses with -EIO if the size exceeds the slot_size length
>  - Make sure the slot-size is a power of two
>
> Changes in v4:
>  - Fix the default value of the doorbell from 0 to 1
>
> Changes in v3: None
>
> Changes in v2: (from Yao Zi review)
>  - Reorder headers
>  - Don't null check pointers before free()
> ---
>  drivers/firmware/rpmi/Kconfig      |   8 +
>  drivers/firmware/rpmi/Makefile     |   1 +
>  drivers/firmware/rpmi/rpmi-shmem.c | 496 +++++++++++++++++++++++++++++++=
++++++
>  include/rpmi_proto.h               |  23 ++
>  4 files changed, 528 insertions(+)
>
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 708d931263ff..421a1fa9deba 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -16,3 +16,11 @@ config RPMI_SBI_MPXY
>           (MPXY) extension of the supervisor binary interface (SBI). The
>           specification for the MPXY extension is available at:
>           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> +
> +config RPMI_SHMEM
> +       bool "RPMI over shared memory transport"
> +       depends on RPMI_FIRMWARE
> +       help
> +         Enable support for transport of RPMI messages over shared memor=
y as
> +         described in chapter 2 of the RPMI specification, available at:
> +         https://github.com/riscv-non-isa/riscv-rpmi
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index 4976176f07df..87ef3623a93a 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -2,3 +2,4 @@ obj-y   +=3D rpmi-uclass.o
>  ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
>  obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
>  endif
> +obj-$(CONFIG_RPMI_SHMEM) +=3D rpmi-shmem.o
> diff --git a/drivers/firmware/rpmi/rpmi-shmem.c b/drivers/firmware/rpmi/r=
pmi-shmem.c
> new file mode 100644
> index 000000000000..f07912a56846
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-shmem.c
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/io.h>
> +#include <asm/types.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/log2.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <rpmi-uclass.h>
> +
> +#define RPMI_SLOT_SIZE_MIN 64
> +
> +enum rpmi_queue_idx {
> +       RPMI_QUEUE_IDX_A2P_REQ =3D 0,
> +       RPMI_QUEUE_IDX_P2A_ACK =3D 1,
> +       RPMI_QUEUE_IDX_P2A_REQ =3D 2,
> +       RPMI_QUEUE_IDX_A2P_ACK =3D 3,
> +       RPMI_QUEUE_IDX_MAX_COUNT =3D 4,
> +       RPMI_A2P_DOORBELL =3D 5,
> +};
> +
> +struct shmem_queue {
> +       u32 num_slot;
> +       __le32 *headptr;
> +       __le32 *tailptr;
> +       void *buffer;
> +};
> +
> +struct rpmi_shmem {
> +       struct udevice *dev;
> +       struct shmem_queue a2p_req;
> +       struct shmem_queue p2a_ack;
> +       int slot_size;
> +       int rx_timeout_ms;
> +       u32 token;
> +       void *doorbell;
> +       u32 doorbell_value;
> +       u32 spec_version;
> +       u32 impl_version;
> +       u32 impl_id;
> +};
> +
> +struct rpmi_shmem_chan_priv {
> +       struct rpmi_shmem *priv;
> +       u32 servicegroup_id;
> +       u32 servicegroup_version;
> +};
> +
> +static int rpmi_shmem_queue_idx(const char *name)
> +{
> +       static const struct {
> +               int id;
> +               const char *name;
> +       } id_names[] =3D {
> +               { RPMI_QUEUE_IDX_A2P_REQ, "a2p-req" },
> +               { RPMI_QUEUE_IDX_P2A_ACK, "p2a-ack" },
> +               { RPMI_QUEUE_IDX_P2A_REQ, "p2a-req" },
> +               { RPMI_QUEUE_IDX_A2P_ACK, "a2p-ack" },
> +               { RPMI_A2P_DOORBELL, "a2p-doorbell" },
> +       };
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(id_names); i++) {
> +               if (strcmp(name, id_names[i].name) =3D=3D 0)
> +                       return id_names[i].id;
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static u32 rpmi_read_head(struct shmem_queue *qctx)
> +{
> +       return le32_to_cpu(readl(qctx->headptr));
> +}
> +
> +static u32 rpmi_read_tail(struct shmem_queue *qctx)
> +{
> +       return le32_to_cpu(readl(qctx->tailptr));
> +}
> +
> +static void rpmi_write_head(struct shmem_queue *qctx, u32 val)
> +{
> +       writel(cpu_to_le32(val), qctx->headptr);
> +}
> +
> +static void rpmi_write_tail(struct shmem_queue *qctx, u32 val)
> +{
> +       writel(cpu_to_le32(val), qctx->tailptr);
> +}
> +
> +static bool rpmi_smq_queue_full(struct shmem_queue *qctx)
> +{
> +       return ((rpmi_read_tail(qctx) + 1) % qctx->num_slot =3D=3D
> +               rpmi_read_head(qctx));
> +}
> +
> +/* 31                                            0
> + * +---------------------+-----------------------+
> + * | FLAGS | SERVICE_ID  |   SERVICEGROUP_ID     |
> + * +---------------------+-----------------------+
> + * |        TOKEN        |     DATA LENGTH       |
> + * +---------------------+-----------------------+
> + * |                 DATA/PAYLOAD                |
> + * +---------------------------------------------+
> + */
> +struct rpmi_message_header {
> +       __le16 servicegroup_id;
> +       u8 service_id;
> +       u8 flags;
> +       __le16 datalen;
> +       __le16 token;
> +} __packed;
> +
> +static int rpmi_smq_rx(struct rpmi_shmem *priv, struct shmem_queue *qctx=
,
> +                      u32 service_group_id, u32 service_id, u16 token,
> +                      void *response, unsigned long max_response_len,
> +                      unsigned long *out_response_len)
> +{
> +       struct rpmi_message_header *msg;
> +       u32 dlen, headidx, tailidx;
> +       int rxretry =3D 0;
> +       void *src;
> +
> +       headidx =3D rpmi_read_head(qctx);
> +
> +       /* Wait for the Rx message with matching token, discard any other
> +        * messages received in the mean time
> +        */
> +       while (true) {
> +               tailidx =3D rpmi_read_tail(qctx);
> +
> +               if (headidx !=3D tailidx) {
> +                       msg =3D (void *)qctx->buffer +
> +                             (headidx * priv->slot_size);
> +                       if ((le16_to_cpu(msg->token) =3D=3D token) &&
> +                           (le16_to_cpu(msg->servicegroup_id) =3D=3D
> +                            service_group_id) &&
> +                           (msg->service_id =3D=3D service_id))
> +                               break;
> +
> +                       headidx =3D (headidx + 1) % qctx->num_slot;
> +               }
> +
> +               mdelay(1);
> +               rxretry +=3D 1;
> +               if (rxretry > priv->rx_timeout_ms)
> +                       return -ETIMEDOUT;
> +       }
> +
> +       /* Extract data from the message */
> +       if (response) {
> +               dlen =3D le16_to_cpu(msg->datalen);
> +               if (dlen > priv->slot_size - sizeof(struct rpmi_message_h=
eader))
> +                       return -EIO;
> +               if (dlen > max_response_len)
> +                       dlen =3D max_response_len;
> +               if (out_response_len)
> +                       *out_response_len =3D dlen;
> +               src =3D (void *)msg + sizeof(struct rpmi_message_header);
> +               memcpy_fromio(response, src, dlen);
> +       }
> +
> +       /* Update the head index */
> +       headidx =3D (headidx + 1) % qctx->num_slot;
> +       rpmi_write_head(qctx, headidx);
> +
> +       return 0;
> +}
> +
> +static int rpmi_smq_tx(struct rpmi_shmem *priv, struct shmem_queue *qctx=
,
> +                      u32 service_group_id, u32 service_id,
> +                      enum rpmi_message_type type, u16 token,
> +                      const void *request, unsigned long request_len)
> +{
> +       struct rpmi_message_header header =3D { 0 };
> +       u32 tailidx;
> +       void *dst;
> +
> +       /* Tx sanity checks */
> +       if (request_len >
> +           (priv->slot_size - sizeof(struct rpmi_message_header)))
> +               return -EINVAL;
> +
> +       if (rpmi_smq_queue_full(qctx))
> +               return -ENOMEM;
> +
> +       tailidx =3D rpmi_read_tail(qctx);
> +
> +       /* Prepare the header to be written into the slot */
> +       header.servicegroup_id =3D cpu_to_le16(service_group_id);
> +       header.service_id =3D service_id;
> +       header.flags =3D type;
> +       header.datalen =3D cpu_to_le16(request_len);
> +       header.token =3D cpu_to_le16(token);
> +
> +       /* Write header into the slot */
> +       dst =3D (char *)qctx->buffer + (tailidx * priv->slot_size);
> +       memcpy_toio(dst, &header, sizeof(header));
> +       dst +=3D sizeof(header);
> +
> +       /* Write data into the slot */
> +       if (request)
> +               memcpy_toio(dst, request, request_len);
> +
> +       /* Update the tail/write index */
> +       tailidx =3D (tailidx + 1) % qctx->num_slot;
> +       rpmi_write_tail(qctx, tailidx);
> +
> +       /* Ring the RPMI doorbell if present */
> +       if (priv->doorbell)
> +               writel(priv->doorbell_value, priv->doorbell);
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_request_priv(struct rpmi_shmem *priv, u32 serviceg=
roup_id,
> +                                  u32 service_id, const void *request,
> +                                  unsigned long request_len, void *respo=
nse,
> +                                  unsigned long max_response_len,
> +                                  unsigned long *out_response_len)
> +{
> +       enum rpmi_message_type type =3D response ? RPMI_MSG_NORMAL_REQUES=
T :
> +                                                RPMI_MSG_POSTED_REQUEST;
> +       int err;
> +
> +       if (!request && request_len)
> +               return -EINVAL;
> +
> +       err =3D rpmi_smq_tx(priv, &priv->a2p_req, servicegroup_id, servic=
e_id,
> +                         type, priv->token, request, request_len);
> +       if (err) {
> +               dev_err(priv->dev, "tx failed %i\n", err);
> +               goto out;
> +       }
> +
> +       if (response) {
> +               err =3D rpmi_smq_rx(priv, &priv->p2a_ack, servicegroup_id=
,
> +                                 service_id, priv->token, response,
> +                                 max_response_len, out_response_len);
> +               if (err) {
> +                       dev_err(priv->dev, "rx failed %i\n", err);
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       priv->token++;
> +       return err;
> +}
> +
> +static int rpmi_shmem_request(struct rpmi_chan *chan, u32 service_id,
> +                             const void *request, unsigned long request_=
len,
> +                             void *response, unsigned long max_response_=
len,
> +                             unsigned long *out_response_len)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       struct rpmi_shmem_chan_priv *chan_priv =3D chan->con_priv;
> +
> +       return rpmi_shmem_request_priv(priv, chan_priv->servicegroup_id,
> +                                      service_id, request, request_len,
> +                                      response, max_response_len,
> +                                      out_response_len);
> +}
> +
> +static int rpmi_shmem_get_attr(struct rpmi_chan *chan,
> +                              enum rpmi_attribute_id id, u32 *data)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       struct rpmi_shmem_chan_priv *chan_priv =3D chan->con_priv;
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D priv->spec_version;
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D priv->slot_size - sizeof(struct rpmi_message_he=
ader);
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D chan_priv->servicegroup_id;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D chan_priv->servicegroup_version;
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D priv->impl_id;
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D priv->impl_version;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_base_service_req(struct rpmi_shmem *priv, u32 serv=
ice_id,
> +                                      const u32 *arg_in, u32 *arg_out)
> +{
> +       int len =3D 0;
> +       u32 rx[2];
> +       u32 tx[1];
> +       int ret;
> +
> +       if (arg_in) {
> +               tx[0] =3D cpu_to_le32(*arg_in);
> +               len =3D sizeof(*arg_in);
> +       }
> +
> +       ret =3D rpmi_shmem_request_priv(priv, RPMI_SRVGRP_BASE, service_i=
d, tx,
> +                                     len, rx, sizeof(rx), NULL);
> +       if (ret) {
> +               dev_err(priv->dev, "BASE service %i failed (%i)\n", servi=
ce_id,
> +                       ret);
> +               return ret;
> +       }
> +
> +       if (rx[0]) {
> +               ret =3D rpmi_to_linux_error(le32_to_cpu(rx[0]));
> +               dev_err(priv->dev, "BASE service %i returned code %i\n",
> +                       service_id, ret);
> +               return ret;
> +       }
> +
> +       if (arg_out)
> +               *arg_out =3D le32_to_cpu(rx[1]);
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_of_xlate(struct rpmi_chan *chan,
> +                              struct ofnode_phandle_args *args)
> +{
> +       if (args->args_count !=3D 1)
> +               return -EINVAL;
> +
> +       // args[0] is the servicegroup id.
> +       chan->id =3D args->args[0];
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_open(struct rpmi_chan *chan)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       u32 servicegroup_id, servicegroup_version;
> +       struct rpmi_shmem_chan_priv *chan_priv;
> +       int ret;
> +
> +       servicegroup_id =3D chan->id;
> +
> +       ret =3D rpmi_shmem_base_service_req(priv,
> +                                         RPMI_BASE_SRV_PROBE_SERVICE_GRO=
UP,
> +                                         &servicegroup_id,
> +                                         &servicegroup_version);
> +       if (ret)
> +               return ret;
> +
> +       chan_priv =3D malloc(sizeof(*chan_priv));
> +       if (!chan_priv)
> +               return -ENOMEM;
> +
> +       chan->con_priv =3D chan_priv;
> +
> +       chan_priv->priv =3D priv;
> +       chan_priv->servicegroup_id =3D servicegroup_id;
> +       chan_priv->servicegroup_version =3D servicegroup_version;
> +
> +       return 0;
> +}
> +
> +static void rpmi_shmem_close(struct rpmi_chan *chan)
> +{
> +       free(chan->con_priv);
> +}
> +
> +static int rpmi_shmem_probe(struct udevice *dev)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(dev);
> +       int i, ret, qidx, qcount, qslotcnt;
> +       struct shmem_queue *queue;
> +       u32 arg_in, arg_out;
> +       const char *qname;
> +       fdt_size_t qsize;
> +       void *start;
> +
> +       priv->dev =3D dev;
> +       priv->rx_timeout_ms =3D 20;
> +
> +       priv->slot_size =3D dev_read_u32_default(dev, "riscv,slot-size", =
0);
> +       if (priv->slot_size < RPMI_SLOT_SIZE_MIN ||
> +           !is_power_of_2(priv->slot_size))
> +               return -EINVAL;
> +
> +       priv->doorbell_value =3D
> +               dev_read_u32_default(dev, "riscv,a2p-doorbell-value", 1);
> +
> +       qcount =3D dev_read_string_count(dev, "reg-names");
> +       if (qcount < 0 || qcount > 5)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < qcount; i++) {
> +               ret =3D dev_read_string_index(dev, "reg-names", i, &qname=
);
> +               if (ret)
> +                       continue;
> +
> +               qidx =3D rpmi_shmem_queue_idx(qname);
> +               if (qidx < 0)
> +                       continue;
> +
> +               start =3D dev_read_addr_size_index_ptr(dev, i, &qsize);
> +               if (!start)
> +                       continue;
> +
> +               if (qidx =3D=3D RPMI_A2P_DOORBELL) {
> +                       priv->doorbell =3D start;
> +               } else {
> +                       qslotcnt =3D qsize / priv->slot_size;
> +                       if (qslotcnt < 4)
> +                               continue;
> +
> +                       if (qidx =3D=3D RPMI_QUEUE_IDX_A2P_REQ)
> +                               queue =3D &priv->a2p_req;
> +                       else if (qidx =3D=3D RPMI_QUEUE_IDX_P2A_ACK)
> +                               queue =3D &priv->p2a_ack;
> +                       else
> +                               continue;
> +
> +                       queue->headptr =3D start;
> +                       queue->tailptr =3D start + priv->slot_size;
> +                       queue->buffer =3D start + (2 * priv->slot_size);
> +                       queue->num_slot =3D qslotcnt - 2;
> +               }
> +       }
> +
> +       if (!priv->a2p_req.num_slot || !priv->p2a_ack.num_slot)
> +               return -EINVAL;
> +
> +       arg_in =3D RPMI_SRVGRP_BASE;
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_PROBE_SERVICE_GROUP, &arg_in, &arg_ou=
t);
> +       if (ret)
> +               return ret;
> +
> +       if (arg_out < RPMI_MKVER(1, 0))
> +               return -EINVAL;
> +
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION, NULL, &ar=
g_out);
> +       if (ret)
> +               return ret;
> +       priv->impl_version =3D arg_out;
> +
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN, NULL, &arg_ou=
t);
> +       if (ret)
> +               return ret;
> +       priv->impl_id =3D arg_out;
> +
> +       ret =3D rpmi_shmem_base_service_req(priv, RPMI_BASE_SRV_GET_SPEC_=
VERSION,
> +                                         NULL, &arg_out);
> +       if (ret)
> +               return ret;
> +       priv->spec_version =3D arg_out;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_shmem_ids[] =3D {
> +       { .compatible =3D "riscv,rpmi-shmem-mbox" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_shmem_ops =3D {
> +       .of_xlate =3D rpmi_shmem_of_xlate,
> +       .get_attr =3D rpmi_shmem_get_attr,
> +       .request =3D rpmi_shmem_request,
> +       .open =3D rpmi_shmem_open,
> +       .close =3D rpmi_shmem_close,
> +};
> +
> +U_BOOT_DRIVER(rpmi_shmem) =3D {
> +       .name =3D "rpmi-shmem",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_shmem_ids,
> +       .probe =3D rpmi_shmem_probe,
> +       .priv_auto =3D sizeof(struct rpmi_shmem),
> +       .ops =3D &rpmi_shmem_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
> index 012ae93d7317..4b557bfeedf5 100644
> --- a/include/rpmi_proto.h
> +++ b/include/rpmi_proto.h
> @@ -60,4 +60,27 @@ enum rpmi_servicegroup_id {
>         RPMI_SRVGRP_VENDOR_END          =3D 0xFFFF,
>  };
>
> +/** RPMI Base ServiceGroup Service IDs */
> +enum rpmi_base_service_id {
> +       RPMI_BASE_SRV_ENABLE_NOTIFICATION =3D 0x01,
> +       RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION =3D 0x02,
> +       RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN =3D 0x03,
> +       RPMI_BASE_SRV_GET_SPEC_VERSION =3D 0x04,
> +       RPMI_BASE_SRV_GET_PLATFORM_INFO =3D 0x05,
> +       RPMI_BASE_SRV_PROBE_SERVICE_GROUP =3D 0x06,
> +       RPMI_BASE_SRV_GET_ATTRIBUTES =3D 0x07,
> +};
> +
> +/** RPMI Messages Types */
> +enum rpmi_message_type {
> +       /* Normal request backed with ack */
> +       RPMI_MSG_NORMAL_REQUEST =3D 0x0,
> +       /* Request without any ack */
> +       RPMI_MSG_POSTED_REQUEST =3D 0x1,
> +       /* Acknowledgment for normal request message */
> +       RPMI_MSG_ACKNOWLDGEMENT =3D 0x2,
> +       /* Notification message */
> +       RPMI_MSG_NOTIFICATION =3D 0x3,
> +};
> +
>  #endif
>
> --
> 2.53.0
>
