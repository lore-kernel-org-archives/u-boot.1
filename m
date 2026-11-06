Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF1606D80A
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LsAQ4mFg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XUIg4eO2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=STBC6taQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D202811FF;
	Fri,  6 Nov 2026 10:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id npEgpceJyJgD; Fri,  6 Nov 2026 10:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E412C811F2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793959903;
	b=JOmGTxgMo7qznsDmGKZPtsYevjp3lKpAXP9aymrfNpgIlFNkKhFPVKkFKLGOqSCtZ+30
	 RW2Sgi6qeIXo7suYkMoE3ACc3uK2h/QRvQ7fI6XQ6+Ddsi+z7ehbdwF9czs8KvpyGLjnw
	 PpIwIG8im7QtXVgZumF+dhJ6qVFi+DksTy7MNd88GSeNzfF0coqPx2lJ4DbgrBHmtZLbD
	 bEfoerIVjShh7yTuE1hC9C7vRymn6oSeYzLRQRnoBfu3UCn43TUYDeFmEMOifhhDtq0Yy
	 luQEPm0ghbMTqr4/tpYLfxvXbO45y6U2hWMMFNw/366aYFNqOqSzbqIsS/w7VYiAWIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793959903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qQbFD5idzNO6EoW1g0+U7SDYDDcoB+7aCce2ZVE3x7k=;
	b=dhBVWeokNMmTxsIvKeq0chsIIqWBpFduAOOYrLvE8SpT5st5S2moFKXD3oDPZlWhUL/A
	 ZFjgfmhmArN4FMT09el/1DOMcs994YcSzTi3TB1xujVBoIEI9SAxW5V77mpHzEFCQvjiq
	 Ex/aHhNu+WCWiXUOI+PHSQVc/6tPq8g2IQUltq+JXEqIRXRGQ1V6YVrY+spB2WQxbC2rz
	 2Mkl4bzfjaStW0DZN79gw0ojaGNk3/QbXs5v+isE2NXU6n1XISsVD106NFhjq5BNWOsak
	 0oGZW1AWsZtfECtyiF6uJNi6ddWA9W5gPcDHMYGFpIJ3XMetlNNo+k29af54pi7jhvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XUIg4eO2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=STBC6taQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793959903;
	bh=qQbFD5idzNO6EoW1g0+U7SDYDDcoB+7aCce2ZVE3x7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LsAQ4mFgHVe4SGpck64COFWKrzAImWShkVK9FzHdCPYtA2G+AgW59H7N8ielSMbGs
	 72I+CKI4VcrqCyyEXiHvJEe1r70olIlEhURyD1/vArzvDiHNhJA8B2uJYcVZJFcmN7
	 NLt5NjwDzMWYcu8mjFaf+oE9WtJq7B9Lmr9BDZFP+e4UfA8iMhS46vJcdH1D7VB9C9
	 9wE8NjYgbWmpJmoeYO7Dl559SQ47jS0aEH0LdTUvKPulYYCai7Pn8I16ncUE7pxRQo
	 gsty9q7KVIhVT8Nanp5AbPueEsnvTwBcUNBxgbklEVNbVklxc+BD3d/n7iiQoCWZco
	 yDVP5hYoyHzrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E412C811F2;
	Fri,  6 Nov 2026 10:11:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B7111E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8886A811F8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txWhgSeqf1HE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 10:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C311811DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XUIg4eO2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=STBC6taQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C311811DF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:11:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RT2G2730721
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 10:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qQbFD5idzNO6EoW1g0+U7SDYDDcoB+7aCce2ZVE3x7k=; b=XUIg4eO2KzEVQujT
 SplsOsfpes+t+N79KsRIPbDm3hxyoJEmgmHR5znO1g+bhrvtJhrPuVUIi0+BQBV/
 TR8IfSZdfkpsCuwdBLN9zBOzWybImhzbOGF2brJmv0/qMGcjxJtRSU82/V3UJ5RD
 RqxUHFOOSD2Mz3fY56bw7xbNhW7zk+vr6ls8PjeywkwQld/9x89omAXIunOgIVuB
 aUPQDR5mOvXqd/8ae3v9WQm3WGdCXbU9dc/sfmaGpQLf7IFkLoSo9D18k2Z2y9qY
 NyzPjAHpHyfnpHF9cTBPzyhQeHIPQ6LCXlUiczKP+0/+7KuEb6/Z41hMyjeqADpu
 anwv+w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9j8sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:11:39 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67c0ff91f4cso819139d50.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793959898; x=1794564698;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qQbFD5idzNO6EoW1g0+U7SDYDDcoB+7aCce2ZVE3x7k=;
 b=STBC6taQOaNbQhbrlC1BUIHXJ6hdmDDLTLsx2ype3l7d483NSHieHncUnjixYM9z/I
 AKUNkkWwkiS0stMnFZ9vQoguVpvtG4g4rhSEpHzypSTDvK7YVKZO9V8AeH38Zu0qXkA9
 y84sFT5vpnA/sAFLh5V9KLb7w3SkuopWJPaqG6rIXCpLyU67vST201HaQaeAJJaSJtCt
 C96M9de2gjSD1YeZbXF0bcYK8oI1L4dW9WbDDUBCUu4PESsWey4tPPez5aOcNjYAVnSX
 aR6Z8FIoUPX8f33emL1DxpG0d+eN3lpDXZtB/uKovAyYaAXI/mkiMGBxpsVnDeUSdCdO
 Ab4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793959898; x=1794564698;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQbFD5idzNO6EoW1g0+U7SDYDDcoB+7aCce2ZVE3x7k=;
 b=zNdWnmGoP9o+/aGw+quhrvGzHaCGZIlFNTnVZvfmEzAJPZdwSp73aXsxAqGI/D1d6d
 qfEorkRF2RiF9oHiOTTBPalA8F4WstQvp8FXuw3gG3aLgP5bqVP1/gVfduUL3snK8W0w
 34xsisEjFoXTQJOAyc4lWzjWSNWqA1TuS4H3dYjleKRteumivB8orDzgZ0de4ajdv/fa
 DKlzAgSyEHsJsZZNtwnMZSfr4O510+ESdBrfa9/Qq4YlO2SiOrnZWY6WLFs6lqW/Kw/J
 FzKZ5ENZcWt+EauCr5LhTE67QzRcp9rLp1ZGmqz9+1SqVmxZuUDTNCssKOLlORFAnUBN
 czFg==
X-Gm-Message-State: APuU4Z8cb5b37LvuvU1SBo+ffsiprVrHzby0fKzjZ6FfkZ6Eu/wBL/lG
 B1ybyh94OfXJuDWJvY9t0iEpaKHU3Dc9rStSqHj3pRngdVJt8wZ+/pM0u9honAPEI1Sj6nJcNg9
 lBLLw7A19oLj+COHzxoDJ7A76MNt3LVOxjuzVbVmfII/LpjOLQeSm8Y4txJVeN/XOSKeY0wD8ll
 m8QGMYxpmv/GdL8HDXA+O7JaqSmm3HtH7vMoTZT2cenlIsQ5bfnpKt27xk
X-Gm-Gg: AYBFou1Hd6UzoWErODqQhUqM+CKIzJ9sj400YXqT5lJNjTrfLzMnPJAX0fHo++I8S6s
 ISlOaCwnSd/OuWMEqg89bppxhYrX+/iJ4xfkevqzDEneBSnwXOaAWqB8xZG5LUZWtD/zwqxnQA8
 i429/NvcUspNheZ/gnuSwjia4+Yyp+5DjskuId3pjbj+KdMml8c+q6+60=
X-Received: by 2002:a53:c08e:0:b0:677:dae6:51d4 with SMTP id
 956f58d0204a3-67c1465d103mr943651d50.106.1793959898131; 
 Fri, 06 Nov 2026 02:11:38 -0800 (PST)
X-Received: by 2002:a53:c08e:0:b0:677:dae6:51d4 with SMTP id
 956f58d0204a3-67c1465d103mr943640d50.106.1793959897668; Fri, 06 Nov 2026
 02:11:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 11:11:24 +0100
X-Gm-Features: AclHuK8CEXZ5jip4pZkvvjz47zY1o-eHSrIg5Jh4eJ4QeQH4GfBY6EOHTEYIOG0
Message-ID: <CAPzfCAYo1FqD9EXVM8Y_vEzTVF_84QFo3z=7=iDdM5pEwMhgfg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Qualcomm Firehose flashing protocol support
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
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
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: OcPrEs5qikcteFs-dRf6xefQM5xrEZrP
X-Proofpoint-GUID: OcPrEs5qikcteFs-dRf6xefQM5xrEZrP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MCBTYWx0ZWRfXwHPdLNdapYR0
 /8gfYdWD91b1m/7E7XlDFoIM9OsmKIVXlxet74uoowva8w4xNFCOFSBTdUl2eRwEiTDlaA6cad/
 hzz5Uic86S+DjpuzqWl8AdAMRQhUYsU=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aeda7db cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8 a=EUspDBNiAAAA:8
 a=oAcF8F-ipFNkRM5c_wkA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MCBTYWx0ZWRfX4Zk0Fe+3G3Xy
 aE3P/fiSCYxStdx+v6zSP+q+Kq4tmeIphdBjcWhhr86DSilApc+HIzFF7lKnSEMhCAAQ3VuNUHH
 2mQfr4JzEF0FTWyQcftGQxv0h1L+mm1XSze37znlFRPkcandUk2fJzm7x4L1G6HS8jSDjpu99NP
 qLNlqGbWauTZJSTRQrH7kbjWeRH7JIOnZUyQMdG4XBj5k4nm7NmvbhELtb1xhheMhQuDe98iKXf
 9V6dqIC/g8r4XmrQVKYkgYy8JB9AzjABeyjbtGWUCHitRBwb4eaI9QI1AZbRd5P/jn/GqNneuAQ
 u8EXZLAoWS0tjNCXI7jdHnEK/sBuCYxCvg9uOZlhMuItU3uGwrz1P+Vb0FNULQbxW7jb8MKOCzV
 BHw91sgTl4gpLCVeGHICbuM2CfJ+m9RAs81yx8EmlUU5kv9/vaqPxokwW2+WIjDA/0sJ94WU5x2
 oLwAdhfQmzTaZCMoN0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060040
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

Hi all,

On Fri, Nov 6, 2026 at 10:42=E2=80=AFAM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> This series adds a "firehose" command that serves a block device to a
> such tools as QDL [1]. Firehose is the protocol used to
> flash Qualcomm boards in EDL mode. With this, a board running U-Boot can
> be reflashed with the same toolset used for flashing any
> Snapdragon-based device.
>
> As discussed on the RFC [2], only the subset of the protocol needed
> for flashing is implemented, and the XML parser accepts only the subset
> Firehose uses:
>
> - configure, program, read, erase, patch, power (reset) and nop
> - physical partition 0 only
> - sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
> - no VIP, UFS provisioning, getsha256digest or getstorageinfo
>
> Btw, work is ongoing to make the Firehose and Sahara specs public and
> community driven, so soon there will it will be available and used
> as a reference for host and device implementations alike.
>
> The command usage:
>
> On Snapdragon SoCs the gadget enumerates as 05c6:9008, the EDL ID, since
> host tools like QDL only probe this VID:PID
>
> Usage in U-Boot:
>
>   =3D> firehose 0
>   or specifying the storage
>   =3D> firehose 0 mmc 0
>
> Running flashing tool on the host:
>
>   $ qdl --storage emmc prog_firehose_ddr.elf rawprogram0.xml patch0.xml
>
> The device is either given on the command line ("firehose 0 mmc 0") or
> picked from the MemoryName of the host's configure command
> ("firehose 0").
>
> QDL automatically skips Sahara when a Firehose "server" is already runnin=
g,
> so the programmer file is not sent.
>
> Tested this implemnentation with qdl v2.8 on the Arduino UNO Q (QRB2210, =
eMMC):
> - reads of flashed partitions match the images
> - write and read back of a scratch range, with and without a device on
>   the command line
> - erase reads back as zeros
> - GPT rewritten with gpt_main0.bin, gpt_backup0.bin and patch0.xml is
>   byte-identical to the original
> - a read of physical partition 1 is NAKed
> - power reset from the host
> - test/py test_firehose.py: 3 passed
>
> On sandbox, the ut tests dm_test_firehose_* and dm_test_cmd_firehose
> pass. UFS and NVMe are untested (no hardware), and so is a full
> rawprogram0.xml flash.

This is a minimal first implementation, I deliberately avoided any
complex cmd handling,
so it currently doesn't support these cmds/functionality:
- getsha256/digest/getcrc16digest
- getstroageinfo
- setbootablestoragedrive
- benchmark, peek/poke etc
- VIP mode (which I think we won't need probably)
- different straoge handling logic (handling multiple LUNs on UFS or
NVMe physical hardware parts)
- Payload size cconfiguration, ZLP handling etc
>
> [1] https://github.com/linux-msm/qdl
> [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/63897=
3.html
>
> ---
> Igor Opaniuk (14):
>       usb: gadget: add a Qualcomm Firehose function
>       usb: gadget: firehose: add the read command
>       usb: gadget: firehose: add the program command
>       usb: gadget: firehose: add the erase command
>       usb: gadget: firehose: add the patch command
>       usb: gadget: firehose: pick the storage from MemoryName
>       cmd: add the firehose command
>       doc: usage: describe the firehose command
>       mach-snapdragon: use the EDL USB IDs for Firehose
>       configs: qcom: enable the firehose command
>       configs: sandbox: enable the firehose command
>       test: dm: add Firehose tests
>       test: cmd: add a firehose command test
>       test: py: add firehose tests with qdl
>
>  arch/arm/mach-snapdragon/board.c    |  23 +
>  cmd/Kconfig                         |   9 +
>  cmd/Makefile                        |   1 +
>  cmd/firehose.c                      |  50 +++
>  configs/qcom_defconfig              |   1 +
>  configs/sandbox_defconfig           |   1 +
>  doc/usage/cmd/firehose.rst          |  81 ++++
>  drivers/usb/gadget/Kconfig          |   9 +
>  drivers/usb/gadget/Makefile         |   1 +
>  drivers/usb/gadget/f_firehose.c     | 849 ++++++++++++++++++++++++++++++=
++++++
>  drivers/usb/gadget/firehose_parse.c | 282 ++++++++++++
>  include/firehose.h                  | 117 +++++
>  test/cmd/Makefile                   |   1 +
>  test/cmd/firehose.c                 |  40 ++
>  test/dm/Makefile                    |   1 +
>  test/dm/firehose.c                  | 204 +++++++++
>  test/py/tests/test_firehose.py      |  99 +++++
>  17 files changed, 1769 insertions(+)
> ---
> base-commit: 709a97a05df66e394f40d249105d0baade46f107
> change-id: 20261106-firehose-v1-af7cf3b4ce48
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
