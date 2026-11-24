Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3E606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kWnFTMVU;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sp01gxDu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CJ1NUcuj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8184C4082B;
	Tue, 24 Nov 2026 15:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fy7h6cDYJd_i; Tue, 24 Nov 2026 15:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9902F40649
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795533100;
	b=LBcdCMIHDpMpvAYN4ldGJaVDtHw+yqDBPnLPbYIUGpCXvvqZ1vixqZRmVPNB8BwjONr1
	 PRrV7P1OLAVll6BiWfw8La+tjlnrd/yhWJK4fryo09qCMSzNekjO9w+cWnfwdzm10gxxK
	 SB1o/RvXkoz4yKJZxwjW+0fY7BRQy88kCIcRwONFsU5E+gPmbHidPDd8AXGtFGyK7VAkV
	 xNbtpFUkOozazKNq264NkozsCRj1IDguBSP0xNbZX2q2nCrD+S3w006MGzfZtgctonx77
	 e1KbHFdDkaXTeDAsjVWBDVcOQ6DRag6TuiZppMnR0vC8cwSFbnbXds82ZL1jGl72W4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795533100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1A+N2zBzs+ylD7EHOjqc0vkSpbtUIrMN7w+5QDoGxS8=;
	b=iqvnCO91lfhkojlpANn/caC5QwLR6ZuesqzhzHZyQcz+2jAUKOeIUp885X4IGBtYXKaF
	 SG3eXRRKH6N/YjaFsi2lsRhP/O1Azt4ExLZYt9Rg8kS5jBy2Wct2dT4/zj+7jspXBrfFG
	 Pykhj9RVfWx/865EuOvPJOdHDGfuhnjzDUYYe8gVv98KjHXmlYC84RMZbVPm5dX53E3xg
	 8lYT08iHsgW1S602QUmsQlHOlofO1CJ/chV2BHFqt0n9pKgihPGxfzmbyKFEFgm089A9M
	 d9zFU55lKAuegmE0LTMNwa6W4slGp70rCMDxY+5sbsz+/YzskhSnwDA1PrB/bIsoAQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795533100;
	bh=1A+N2zBzs+ylD7EHOjqc0vkSpbtUIrMN7w+5QDoGxS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kWnFTMVUiucPuQ8GwBtWwrYt0JMCk7f1zg5u9fp5Miw9VwBTewK3TuLqALblLfNfv
	 o85YkW93kb4wl87cxSWEQOBybdWe7HenEfQ2O41OUjZ85v/1CSuKaYF+VB4nidXElY
	 MrnP2cIy4nEREdfWld8d4lKnAy40uqFazqqnojaVDWitaHD/jTQrq1phuHKTGgAkTI
	 AIwUe0OBEegI/R0dWFI52wSivlxx8OTZMmsah9pGPyGpBBl8sTGVStN9SObpFfH5zC
	 oSXbN/s2okrwsokQIx4jS1Z3rgvouL9Ib6q3Q5xGW8lLdCT4A5SZmT9MwO84CEA+24
	 WvahGTp1vpoYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9902F40649;
	Tue, 24 Nov 2026 15:11:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E63C79D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FBA860850
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wfaa747agi2N for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54A18606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sp01gxDu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CJ1NUcuj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54A18606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:11:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOEcBFV1121342
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1A+N2zBzs+ylD7EHOjqc0vkSpbtUIrMN7w+5QDoGxS8=; b=Sp01gxDupAg7tg/7
 K5JhmScgyOceOQdJQm7whhpxeb1KSp25OAL6sbD48R3tF6XpBdPWqIwFUvFBQJR/
 5zMMEhVRr+O1BsOrwszzhZpiQjtC10GsmPM6FFGHXm9PhcVDPmBB/CbGtAn5//RV
 pBxXcJF+Y9jXpYllUPu8hIoB+0/U2OikV/ILRGz6FWTMhZJfTyfrX6KqRQ+/4Nny
 MN17te1LpKogI+bv0tAU3J0+iVnk7ZtydQwisMDf3T0ll+C7mJ/WBjQx5iDpGgJ+
 Tz3jmSnbe32Spxqaans4nXdtAKzWPlUES6RpZeKiYMcZawI+uUOASPjRFmF7VWLc
 dpavMQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpjdut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:11:36 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b502255651so63841387b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795533096; x=1796137896;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1A+N2zBzs+ylD7EHOjqc0vkSpbtUIrMN7w+5QDoGxS8=;
 b=CJ1NUcujGmJE6bPFjuE0hpOLZ3TEK9eiXs3Bn+uYPMtb/eAU4JBB4R+qrL9Ew9DWAp
 rFKp9yS23R0Uk7ow9GlA330lbD3PluxDhc8ipt9xnDR7xV2tCjtyW2TVZOUmlE0p9adb
 Xt02nem68Px5N/SOY/LaxaacpM6Du+58IyY9wh3xBG3idADpzv2yx6JGcv3Ia5yWDkIS
 3oj/YWvAWmbtUxw7Kn0UKRXSSW16rmfzChxRAams6KCgG1QkvJIdmUBLHOTU7dhfigr5
 ecmTHqK76dxokIBjVoBqBqm/gkfej6zTyTg+GHRFKit6+cSPRRxn85YjrXuTFnTvg4CA
 I/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795533096; x=1796137896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1A+N2zBzs+ylD7EHOjqc0vkSpbtUIrMN7w+5QDoGxS8=;
 b=K+2rZv1HsKyzECn75f5iT+2hPSIY0NYbTaV6AMvatdE5/cCq/O6tOjzthzdK8KWJUb
 u+2XApMc7gQQ1I88+hIGbYDT91AGHf37dVgQHsB74YUMCXYDJKkTunPsbKbln+KsbCaI
 ZlMSZc10Ku1EScCcIKSZlO14jjFwpYFWDeQWsXuZUTPgtsD5P5DA+oq3TxRW6M3/Mnz+
 fiwwByLFPZa/AQUdteYqfR0xPFsqb0nU9P4soywZj9aEn83GMmjb2UWfi3/mkXfT7fDV
 3t/n5FdaDlKhnkYwfrOI0/gToRz+9W654YiY2hS0jX3moplbdL7xyasNw0w+kug0XNTU
 c8pg==
X-Gm-Message-State: APuU4Z+0+puBhkLM3V9DlA/mAcDn9SF8gqgeG29hsAdaDSTLSe2v0mGb
 IBN1M8gyZSxYkAyrJNeCvD+5DX4ACydu0Z8ylt40yy6xBe6bXdRR5oqWcFwpgAvaWDqOfs+A20N
 SXnwUr1hlHMb30e30U3buraNoa7G5LV1Yo5KAUeYYDxJufoUpxy4UpeHEihOkmhhAzMgP/+OW3Z
 wJcyBjNrgSnd6IzpeuJ+7OVVTe6svIdTQeh/rEaDn5JAPMSA==
X-Gm-Gg: AZFdTZchTO4SYDpciUWPROrDY2v34Eg0Ri/3rDCtKg4TkYcde+Y6wmjjZda+6DFPTCt
 H0Ygo+uzaMHExYn1dO6MlYltgQ48LpY5izyPne0XVcdoEE71Ucz42cCoX1l03TxBCShIRAwETII
 mxuTfYQ648lwYfUY0lOoevmzJaxH4585Y57Id8CbgLLloGKKtYLLTT5vM=
X-Received: by 2002:a05:690c:6b0b:b0:8b4:c90d:cf8c with SMTP id
 00721157ae682-8b52051dd28mr51508327b3.69.1795533095485; 
 Tue, 24 Nov 2026 07:11:35 -0800 (PST)
X-Received: by 2002:a05:690c:6b0b:b0:8b4:c90d:cf8c with SMTP id
 00721157ae682-8b52051dd28mr51507817b3.69.1795533094779; Tue, 24 Nov 2026
 07:11:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-1-9177277458f9@oss.qualcomm.com>
 <179501661321.306911.17120967959562497081.b4-review@b4>
In-Reply-To: <179501661321.306911.17120967959562497081.b4-review@b4>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 16:11:23 +0100
X-Gm-Features: Aa3M54ooDEonP6mqjqDCNv10Fa2hrrNXHsF8ZhkN3kql_-RE_oJ2mEFi2XBzXkw
Message-ID: <CAPzfCAYg20uUQdNADtndLCM3s0H2KyvD02=rS=RBkmPR3qCzBQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] tee: sandbox: keep zero bytes in persistent values
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX+E7hPjKB2O62
 Zi6T4KZclTkUv67hnxe5GNVSu2gz1yz7GwCEc8R3PzTFeaYBsBX5JGCM7XfzB57SSlVC0VrK3sw
 ABOab60idH8dc1UzbVz4HSBF5I8qTAvorcyCINXhcTNAZBBmnmc00YSBRaLIPRmqArNG3ajh88a
 44O95XF8x3EiueKMDlHBhJ1eWLe0YQqH0Y326R1gSAteQ/DhuV+EgGuLogCTgo2InTJs0pZGpb0
 auey+MqFyrlU4SkLpcAYo9Bzq+77+4vypISZ/NcbFbVC6qMcCigLJXvyT3wtvpeHjjpit95cXUJ
 1iWZPbeyH81fPO7ZGzniUZg1HFKQazV99FufMuVq38H9jlsKvkryIvrTs2eWeakdU8TXzOBcuiV
 sRszdCO8wJNzgnM3Yow8H0vK93il9sbz8VqL/MLD3jBXjB7YhDKKbPjjP+Nhn8oop4ofDo7naZE
 wxFm38T9VCVP7fjTMwQ==
X-Proofpoint-GUID: afjlm5jUj-Wx12ctiC0f3wfyR57oCTTq
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b05a928 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kqBuprJOxN6WaHd7-14A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX/DHGM0E9GSpw
 qq/DbmwmEEcT4vvNm7TFIRW9UFGK929wr9JUXGsrWe8+HjJdO+lZck+2BLZ0u+iBD53dPJkpWzj
 HjJj4qmVmsfxBSpk3tt6VsuBMFhw0EE=
X-Proofpoint-ORIG-GUID: afjlm5jUj-Wx12ctiC0f3wfyR57oCTTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On Wed, Nov 18, 2026 at 4:43=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Igor,
>
> Thank you for the patch.
>
> > The emulated AVB TA keeps persistent values in a table of strings, so a
> > value is cut short at its first zero byte, unlike with the real TA.
> > Binary values, such as the digest of a user-provisioned root key, then
> > cannot be tested on sandbox. Store the values hex-encoded.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> >  drivers/tee/sandbox.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> > index 16e5d95616ce..92e74add3e3c 100644
> > --- a/drivers/tee/sandbox.c
> > +++ b/drivers/tee/sandbox.c
> > @@ -4,6 +4,8 @@
> >   */
> >
> >  #include <dm.h>
> > +#include <hexdump.h>
> > +#include <malloc.h>
> >  #include <sandboxtee.h>
> >  #include <tee.h>
> >  #include <tee/optee_ta_avb.h>
> > @@ -268,7 +270,8 @@ static u32 ta_avb_invoke_func(struct udevice *dev, =
u32 func, uint num_params,
> >               if (!ep)
> >                       return TEE_ERROR_ITEM_NOT_FOUND;
> >
> > -             tmp_sz =3D strlen(ep->data) + 1;
> > +             /* values are stored hex-encoded, see the write below */
> > +             tmp_sz =3D strlen(ep->data) / 2;
> >               if (value_sz < tmp_sz) {
> >                       /*
> >                        * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
> > @@ -287,7 +290,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, =
u32 func, uint num_params,
> >                       tmp_sz =3D value_sz;
>
> tmp_sz gets overriden here again. Is that not a problem?

No, that is the truncation the code already did before this patch.
tmp_sz is first the length of the stored value in bytes.

If the caller's buffer is shorter, TA_AVB_CMD_READ_PERSIST_VALUE2 returns
TEE_ERROR_SHORT_BUFFER with the needed size, and the older
TA_AVB_CMD_READ_PERSIST_VALUE cuts the value to the buffer size, which is
that second assignment. hex2bin() then converts only tmp_sz bytes, so it
can't write past the caller's buffer.

The only change in this patch is that the length now comes from the
hex-encoded string, so it is strlen() / 2.

>
> --
> Mattijs Korpershoek <mkorpershoek@kernel.org>
