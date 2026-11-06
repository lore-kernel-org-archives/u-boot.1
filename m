Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E3606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FkLTjIDJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jpxV9nQI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aeagxpnw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC1A3409C5;
	Fri,  6 Nov 2026 22:56:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHV7Y9yZbWnv; Fri,  6 Nov 2026 22:56:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 867C8409AA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794005805;
	b=KfYedGiwT7zJ5yiZdPdYrs0lFxA8MXJnNEf1QNA5Xlw2Dkd2EVXZbsldhsZ4FU20ElL4
	 CS5CA7775YsJgW4sjpi9KlOr7U3SetgGBEld8fTdUwLHbTGthaAq2kYGCsMArH6fR4dCW
	 xoeSMcLKXMLXHg6RoTob1XF9jb/RR3Z1ch5eis4YLvfIlqg8wmqTtnHoT+/6ucHFX88Bu
	 O3uhYu+e4vcVL6DSkRybIZ0LIyeftvoOce33f7I585B76uIXjlMihfCJffdEvaT3RwrZP
	 alAN7C5InxuvJwydkDdbu0rvnPwGNqE99KrOBudpcxFrcaLu1dZ+x/+wNN+MH5SpeRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794005805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5jK+NWwwGuBKecqW+iz0EWcqKdg+oHctRxwXBNSMMXc=;
	b=FHL6yPLvQ6IpoTn0vA9NHM8vwYhGlnLsI+11KD982IP6oNPLbQAr1E4fRSPYXI4SA6Xx
	 DjJ8yQd56e0umwlzslYVqgOb8uH53Vu8O3byZjzKPRLxZwL5foyROh3FQrTbAD/Immy3f
	 e8EI2VYbtK7SZJoQS5vrHMDCYuLw+YdKwIq5h00ck0J+fBk2E6zFkLpTsZnJnHjhHa5ny
	 3tWonjfv5M62euGl1NW8g/X5yNHQtDGDYc8KBrks0QxuGl1afmVN9+TaHNR2Ny9/rELkS
	 FqXQsWUMn4RVUo3EV6P0SeqYwtpANMwWLt0N4Bzll1RPNbUZXJx4rxnNsIqK/cMPS9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jpxV9nQI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aeagxpnw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794005805;
	bh=5jK+NWwwGuBKecqW+iz0EWcqKdg+oHctRxwXBNSMMXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkLTjIDJ0w2enwQ6ppTpoyV3Mx2uoyH3A/MKvUMPh06yWpTpIAM7kprAPvSrrpeYu
	 xoYKk3G0ZTIPWEKADvsX6usevRZ4mIT+PI6zfhTo6vPGWZcDNeeBneeUf+ZzhEm/be
	 D8ALYv85qsdrZYiaDYzydF40pijroQ04ceY6EjMKdu3pG786zKWD0XSUyCGnYizk+X
	 xqNrZSmO05U2sXOb8uVisJxq28xfAdA5Niibcpob1vVXPYzEunWQKM8Yz8LqCIm+6S
	 fezc8xDTJHJgizIMcfoitgkBpIsPT763ePwKha61KzWgJRM/T8xTHj9JCQPE4mSmfL
	 b9TQJ0WSGkyEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867C8409AA;
	Fri,  6 Nov 2026 22:56:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A91C11C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A78C409C1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flVwzDqYUg06 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 22:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B1F64096D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jpxV9nQI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Aeagxpnw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B1F64096D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:56:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoRaP1105095
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 22:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5jK+NWwwGuBKecqW+iz0EWcqKdg+oHctRxwXBNSMMXc=; b=jpxV9nQI96gnwnzT
 Zm+GMY47Pq6APRtZ3mADcCQsjLRsENWGxzY4cl6gs3VStDq6rAGdhiXvD9bytZQS
 oi6B0c0iKcltOHjThsTQmO3j2B55IGRK7pDIoLo/TtosXWw416d0tEHmVAEwUz9+
 l0PsuQJ3/KgM36T88aYKDUWUhvItZD8dpT5LMlTSnsVRvW/W0O/V7atoX8zOE0sv
 kppH0AnkCZlVCL8NP8lu7SNCXBIkvvMj6c4t6YVlVxwFuZslSjjeb9TMmeDrSnI2
 pfFZuNp3C3fec2JpX27U5fkk1gq2XIHALmTi+mNKAd7TItbKwBNx9kCCvtKUCYmz
 FpXV/w==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wh5dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 22:56:40 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b3030bd581so14396997b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794005800; x=1794610600;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5jK+NWwwGuBKecqW+iz0EWcqKdg+oHctRxwXBNSMMXc=;
 b=Aeagxpnwf1XOG3UXOnKVtVUuZOf+W6gFc8v/eC8kEk4+m1abZSv7mdV7tihMDnCXvj
 89AKvw4vMzlWWITedIgDnndje4QQgwFIpg6ScaTo1BkeFYKxpLO/6+OgoXktC03QFlf5
 7al7lkPlogIlZmYWLc+7de7R9xd8BVe0D2MZygg6FzCkCVeDFG0BHzRB9RNp1wF1y7xm
 lhpNkCcjxzj2FvwtJOtxQbZztRdaFCpJIZV09OqrZSkrX/ey2wSmjJRgJWLFXQS1hwtc
 QZDBdVpGeyR9zo4WRB/pXZ4Gnym+mHiYO5xaQwBLPC+xxxqp5hemXbnK2anbaOxnf42F
 n51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794005800; x=1794610600;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5jK+NWwwGuBKecqW+iz0EWcqKdg+oHctRxwXBNSMMXc=;
 b=0yAl3hHbP5qfwpaDG498Ew8FFT+TV/9O7T//5jhiI8LzA9xgaKS2pZ/LlP5vMcGvcA
 XI+5JCnXre0BWbcJghIK5V/AvjKLwQW7qEbqBbmL/mTBP09ErYvXEwwLWSAhV8yTlglS
 CSW6S8cVyPPPXNS9qE7K5v4Z5XftMaaSrlwN+FGxdcVXbrCcz/tHgbdDzlkMdEnqx0Z2
 sFcGn658oTezsFyybajfBtmYNAJeywI7nl/ZhtAmwfTiU0IgRru99fD0f/Mja/sbq+Qp
 P3WD1HKsD6FToQJ8vZp1qQyuTJNQBq8c3msBOVdIPGcXZxKD6AHRbDRhsiGfy/HhTHZ/
 VtMw==
X-Gm-Message-State: APuU4Z90geydpyWhJyynR9HpzpS8pYM0fxnUf7ELoiOpbS088OLjs11Q
 sXsxrj5O5JRi/r8pefrNv1ttaDkWR05gTCrLe32j8T4bnwgcPf9WQSbJ4y+GvEzXql+bCO5kbfj
 V/Ft54PPey1kEN6fQYOYHIlpB2tzB555uPxm2e/eEPFHAghlffDoxPQpm+kVj6k949jbHTlF4L9
 RObgrzeAwnQUCHLsDTj9MVbPrSb3ZFZuM4LyAVNANAnTZwVg==
X-Gm-Gg: AYBFou01WBaH7o9e7nEHyiiD58FXFTKwixBQuyKXsVp8qDyxGSimSZLZ++LATLrZf8p
 D5XDfk14N7raQcHIzSFgP4r0rfRNqbEK2u4CmFdyOnADbwDzDnUtD5C7/JK3vQ+d8mI4e4nYwcB
 ZcXvRNVhe8D2uuM1A/fM6uu/gf8oBJPA3Eqy8SZ8f+Bt6+BrIinTWHUt0=
X-Received: by 2002:a05:690c:c1c2:b0:8ab:422f:a8a3 with SMTP id
 00721157ae682-8b341b30203mr15123207b3.104.1794005799651; 
 Fri, 06 Nov 2026 14:56:39 -0800 (PST)
X-Received: by 2002:a05:690c:c1c2:b0:8ab:422f:a8a3 with SMTP id
 00721157ae682-8b341b30203mr15122917b3.104.1794005799135; Fri, 06 Nov 2026
 14:56:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <dabc31e4-3e1e-4b3b-9e2b-f69a7ebe52a7@linaro.org>
In-Reply-To: <dabc31e4-3e1e-4b3b-9e2b-f69a7ebe52a7@linaro.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 23:56:28 +0100
X-Gm-Features: AclHuK9gxe0kxU_O6r7M6DNPxEoKupVdqO-rqRveeDj141Al0e5RGx3PQ3Smkd4
Message-ID: <CAPzfCAYacKZODn2aVBuEWLPw_iM=bbCkh3m8mEazRRg+C3yNvw@mail.gmail.com>
Subject: Re: [PATCH 00/14] Qualcomm Firehose flashing protocol support
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fJXMkrYqJPhyL5T1PBlRRypkVn0TzlHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MSBTYWx0ZWRfX/J5AyP4//lOL
 OemSRNW++8XStDX6RJ5s0STwS16XRoOcFocT7DgDafQ3YW9r6fp1pd06bjzGHRmK4VSt05tG2Xs
 i5BpElR+/PAd5ErMRcuV8sZxLWR31ks8KvErIXyQmdD5wrJvs2WRGfP+pIsMO+WmPS5DUvydxky
 AoPHPNUCuGp3wBPkEiSPYDfXfTSmvJyMZD0SU3DeTWH4IYO5/mz8L1iZuCce01XSk5EBGV80Ag0
 p5D4fVWM5HY9t9BeTAsUvH/VIQAQW/hkrdCwPaEaFrOy9npIRuWF5owa4fDOsnhhfOyod31t6R2
 W9U7jecL+KTQDA6bdqjR3iwfChAJZlsiL5TORIkl1XjW4NYoFBRe63w2c/RfrKP40NyC93f2sT4
 VddbfaMQkJPhaKNRPlt1kCks4MkV98hiRFMZeA5mIVHvOQBle5f0tXHMBEVv50AupC3rWriIC6q
 Hk6Kmc7UxGwpm24TqOQ==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee5b28 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8 a=KKAkSRfTAAAA:8
 a=v4DW-DKEq6BF-ljz71kA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MSBTYWx0ZWRfX53V0gNYqMJku
 VKMUJQhiupp7aD4b6iKUNTLlziFkutR7nirImeuYivCn9scChctsszDuwvoOiV3Q6mLFYUKPuX0
 r/fcIx2YiF6VMP74ldk/sfEnFqk/EaU=
X-Proofpoint-GUID: fJXMkrYqJPhyL5T1PBlRRypkVn0TzlHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060091
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Casey,

On Fri, Nov 6, 2026 at 5:56=E2=80=AFPM Casey Connolly <casey.connolly@linar=
o.org> wrote:
>
> Hi Igor,
>
> On 06/11/2026 10:42, Igor Opaniuk wrote:
> > This series adds a "firehose" command that serves a block device to a
> > such tools as QDL [1]. Firehose is the protocol used to
> > flash Qualcomm boards in EDL mode. With this, a board running U-Boot ca=
n
> > be reflashed with the same toolset used for flashing any
> > Snapdragon-based device.
> >
> > As discussed on the RFC [2], only the subset of the protocol needed
> > for flashing is implemented, and the XML parser accepts only the subset
> > Firehose uses:
> >
> > - configure, program, read, erase, patch, power (reset) and nop
> > - physical partition 0 only
> > - sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
> > - no VIP, UFS provisioning, getsha256digest or getstorageinfo
> >
> > Btw, work is ongoing to make the Firehose and Sahara specs public and
> > community driven, so soon there will it will be available and used
> > as a reference for host and device implementations alike.
>
> This is definitely an important point, is this implementation meant to
> be compliant to a spec or to the existing tools? In either case, I think
> there should be at least a high level specification either in the docs
> or at a stable link we can reference.

That's the plan. We're finishing the move of QDL to the Qualcomm
gh organisation. Once that's done I plan to start the legal approval
process for the Firehose and Sahara specs, which are expected to
be published in the same repo (of course, if the legal thing works out).

>
> My other main concern here is maintainance, I'm happy to take these and
> future firehose patches through the qcom tree, but I'd like to delegate
> some responsibility for this. Could we get a new entry in MAINTAINERS
> for firehose support so it's clear who will be reviewing and testing
> patches?

Sure. In v2 I'll add a MAINTAINERS entry for Firehose with myself as
a reviewer (I co-maintain QDL already, so happy to help here as well).

As for the custodian tree: Mattijs already has a lot on his plate with
the AVB and A/B patches I've been sending him over the past month, and
according to patchwork this series has been delegated to him as well.
So I'll leave it to you and Mattijs to decide which tree suits Firehose
best, as more Firehose-related series will follow.

>
> Somewhat a related note, is there a particular reason why one of the
> many other protocols (dfu, uuu) aren't acceptable? Is it just a matter
> of keeping compatibility or being too difficult of a pill for Qualcomm
> to swallow?
>
> Your RFC explains why fastboot isn't acceptable, and I agree that
> fastboot is not really meant for this, but it would be good to at least
> pretend to consider dfu/uuu and offer some justification to not just use
> them?

TBH, my goal is to support the existing ecosystem. Within
Qualcomm alone there are three in-house tools doing the same job (QDL,
PCAT and QIL), plus the tools ODMs and OEMs build themselves +
tooling that generate the rawprogram/patch XML files (like qcom-ptool)
and the meta-qcom Yocto layer, which puts all these pieces together.
Given how tightly all of this is tied together, I really doubt we can
move everything to a different protocol smoothly and without breaking
the existing provisioning workflows, whether DFU, fastboot, uuu
or something else will be used.

As for DFU specifically, it doesn't either map well onto how Qualcomm board=
s
are flashed. In Firehose the host owns the layout: rawprogram*.xml/patch*.x=
ml
input files give the start sector, size and physical partition of every
write, so the same U-Boot binary can flash any layout the host sends.
IIRC, in DFU the layout lives on the device (dfu_alt_info), and the host ca=
n
only pick one of the alt settings defined there, so every board and
layout change would need matching device-side configuration.

DFU also has nothing like the patch command (f.g. fixing up GPT fields and =
their
CRC32 after writing), no erase, no sector values relative to the disk
size (NUM_DISK_SECTORS-N, which the backup GPT relies on), no storage
negotiation. DFU also has no equivalent for storage provisioning cmds
(for UFS LUN configuration or eMMC GP partitions).

I would like to be more optimistic, but I'm afraid we would most
likely just end up with one more protocol to support in addition to
Firehose within the existing ecosystem. So I've chosen one step at a
time approach: replacing the proprietary Firehose programmer with
an open source alternative, with minimal friction and little risk of breaki=
ng
existing flashing workflows.

Thanks!


>
> Thanks,
>
> >
> > The command usage:
> >
> > On Snapdragon SoCs the gadget enumerates as 05c6:9008, the EDL ID, sinc=
e
> > host tools like QDL only probe this VID:PID
> >
> > Usage in U-Boot:
> >
> >   =3D> firehose 0
> >   or specifying the storage
> >   =3D> firehose 0 mmc 0
> >
> > Running flashing tool on the host:
> >
> >   $ qdl --storage emmc prog_firehose_ddr.elf rawprogram0.xml patch0.xml
> >
> > The device is either given on the command line ("firehose 0 mmc 0") or
> > picked from the MemoryName of the host's configure command
> > ("firehose 0").
> >
> > QDL automatically skips Sahara when a Firehose "server" is already runn=
ing,
> > so the programmer file is not sent.
> >
> > Tested this implemnentation with qdl v2.8 on the Arduino UNO Q (QRB2210=
, eMMC):
> > - reads of flashed partitions match the images
> > - write and read back of a scratch range, with and without a device on
> >   the command line
> > - erase reads back as zeros
> > - GPT rewritten with gpt_main0.bin, gpt_backup0.bin and patch0.xml is
> >   byte-identical to the original
> > - a read of physical partition 1 is NAKed
> > - power reset from the host
> > - test/py test_firehose.py: 3 passed
> >
> > On sandbox, the ut tests dm_test_firehose_* and dm_test_cmd_firehose
> > pass. UFS and NVMe are untested (no hardware), and so is a full
> > rawprogram0.xml flash.
> >
> > [1] https://github.com/linux-msm/qdl
> > [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/638=
973.html
> >
> > ---
> > Igor Opaniuk (14):
> >       usb: gadget: add a Qualcomm Firehose function
> >       usb: gadget: firehose: add the read command
> >       usb: gadget: firehose: add the program command
> >       usb: gadget: firehose: add the erase command
> >       usb: gadget: firehose: add the patch command
> >       usb: gadget: firehose: pick the storage from MemoryName
> >       cmd: add the firehose command
> >       doc: usage: describe the firehose command
> >       mach-snapdragon: use the EDL USB IDs for Firehose
> >       configs: qcom: enable the firehose command
> >       configs: sandbox: enable the firehose command
> >       test: dm: add Firehose tests
> >       test: cmd: add a firehose command test
> >       test: py: add firehose tests with qdl
> >
> >  arch/arm/mach-snapdragon/board.c    |  23 +
> >  cmd/Kconfig                         |   9 +
> >  cmd/Makefile                        |   1 +
> >  cmd/firehose.c                      |  50 +++
> >  configs/qcom_defconfig              |   1 +
> >  configs/sandbox_defconfig           |   1 +
> >  doc/usage/cmd/firehose.rst          |  81 ++++
> >  drivers/usb/gadget/Kconfig          |   9 +
> >  drivers/usb/gadget/Makefile         |   1 +
> >  drivers/usb/gadget/f_firehose.c     | 849 ++++++++++++++++++++++++++++=
++++++++
> >  drivers/usb/gadget/firehose_parse.c | 282 ++++++++++++
> >  include/firehose.h                  | 117 +++++
> >  test/cmd/Makefile                   |   1 +
> >  test/cmd/firehose.c                 |  40 ++
> >  test/dm/Makefile                    |   1 +
> >  test/dm/firehose.c                  | 204 +++++++++
> >  test/py/tests/test_firehose.py      |  99 +++++
> >  17 files changed, 1769 insertions(+)
> > ---
> > base-commit: 709a97a05df66e394f40d249105d0baade46f107
> > change-id: 20261106-firehose-v1-af7cf3b4ce48
> >
> > Best regards,
>
> --
> // Casey (she/her)
>
