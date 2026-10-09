Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A8CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 417DC40952;
	Fri,  9 Oct 2026 18:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9UTWIJGGpRo; Fri,  9 Oct 2026 18:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 747FD40945
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569661;
	b=lXo0URibqjbHlvK3UoUQCkrmXyrxxTgyXlSIjhCwoKLeKMFpofQu3J/m/E94oGK03Mhr
	 zpID9q4ByJ90HyXzWkz1186aWLheAGVdbtFZ5wJhsBoByfoAsE4+dSMhfTL1zzYDXhDCu
	 XPFncqXDc8iP7LvNseWq9TLWjWT2SAPqUGgzhZoNnsIQ5HlEK70vbPhD9ZcRZTYfjckrU
	 WAhbySrzTG8Dd4qn9Qjya2vd9Aom628CDTh+hGTS0Lj+PJ7SG05WbCPoHJ5sX2UlNc4p6
	 wRk94pA/+80/qh6DWTIMt2c921cCekFpk1Ez5GnsJuHYWSeeobkIeYX7TarhNb1XCvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zE9nNPxG54ucsB9MVte1xZaX8A3IfC5FAVRy4RARHM4=;
	b=AW6a7kNl5tZPPH7ol/CTw9KpQ8FORVVpuRPJblia7pii7DPCDGaG+SHMEbPwp4tb/Aqq
	 pklDMoCCe46qF1JFLFvJtjYn02T0Z2aVjFeljM7Y8g08GCQB6MBJ7NqIU1gaaJsqND9+0
	 maKnbfArj3HUbRI6VhIGkwAeSFYQEYevE9TBje00xWzBU7tJufLPjMa2VgVDXUG6z5UsH
	 aPe5hk8JoEtyj9hj8ZrraQSvSwmNQ/BKoj6tWhu21uj6vMbrJZvsLFyDlyiG5AkjWMDDE
	 DHGAb74W9AACcrmedStADHpo/V2QKPMBGZhEO1wq4GSSvzrWlAhCQZiCEEa5QW/QldQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569661;
	bh=zE9nNPxG54ucsB9MVte1xZaX8A3IfC5FAVRy4RARHM4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYKUurgc65kKW0r0nIu66A/ZysFa6nmUQOEOQ+HsMuljSl9lEBaOHQTPD40Pm2rXu
	 mTVflgyAaJyEZbAKHP9O60+F+nIdKM4S+PD4jLRnzmpPLxU7TqQN6bFWzSrm573wpi
	 FI1GIUeYMnoSGhrf/XyiumCai5lroOqAfMw04GS0gFAvu/n1jpCnUZU3tFNZRDaDDg
	 FUHLrP1b1OrRRd0jf8xU8xWkaPqVAIY/mL71HL3Eh9PpoRy7Tcx9nrMCpUiA9ZvECr
	 5C3vqOMx7M9C7R4MOpMh25SLA/4n9vm2Pi2gTwbxPL/VEuUFHBg31s4HrI06E4I7Hk
	 g8ZEPOF2Nqgqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 747FD40945;
	Fri,  9 Oct 2026 18:14:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 415D41DE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 269308149A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytEcWi02Nzsn for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 659CF814BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569659;
 b=FeSuz/C/x2ikhdOJ+QV1ZHQDOi7rShIhiRnrZs1UXCoNIJlJs0yvT1LW9LfWCWnpIf6u
 N3NksjSWjTDSkDKfEg7LAupFdXvVa4udvoMHaGz4YGFeyRqTNk0LGGQvGPOvth19NfUwT
 5RruCLwOFqtKr/dv1oWfyWQMpvh4BeEWVKBKzHDsqCaVq6Kuih6GOW7HzOrnkRQHBZhj1
 nmrZgFYxL9quq13xeiwGFFE4CRlLvRtpCbdcI9JZG6HjM0EsAZvKQ5ikvNn+CXXRlXYiJ
 0QOBT7zvfHdDUw9DZvdGbIUEd2m9wu5nRt8+jEhhLElNYLCZgm/OO3/HF4rT3W1NhXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569659;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zE9nNPxG54ucsB9MVte1xZaX8A3IfC5FAVRy4RARHM4=;
 b=pnmOZce8tqc9g3lkEsM2oefTGATruJaQgIXj5IeP6rXBkNrmIhJQ7gCu9UzPLzvUSIwi
 irjkH42BrUJpVJYO+gs66H2wvIz9FVJZYBR/8SatPSq/HNs+PIiqC5XmL/f6X4aczjLKl
 xpcX7XYhz4morSvgkdiwRagyhuz/eOa+FQPsxE5f3xJ2qelr05bRiZyJeTq77rMBLVs/t
 TwxicK2Kj8Sk3hg6ISjql+hO5Cdbuz6SqABWnT6drvwrPiN7AhniqbROmKJXNgZDpkQkG
 jwZ678uCbbNKdNJbVhU3/n6eKGkMisTMGKpAMADLUYz7OgDMUnIUPoeEgLzlTZLkI3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=d5mQcs7M; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ht56y5ga; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=d5mQcs7M; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ht56y5ga
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 659CF814BE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZVr43477983
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zE9nNPxG54u
 csB9MVte1xZaX8A3IfC5FAVRy4RARHM4=; b=d5mQcs7MESfL7izbUIPAaZrMpYb
 BqJvCD5BOE4xgsheYkVIpalwkKw8QObO91C/rp0qdgn91bscqVl392ecLVNT70jw
 JmzEG3Y5RPSkHbuEiICwxbbM/003bA7a7Ocx9yiljX/eBzg1E8PrxqNaPUTDMPVm
 tu+joyusjPsdCl4XDsDTQXTNNnLQXFTlYv137gjn+Hb0KQESZn6FEk7ji//CIoDi
 FelS1X2qroyI5ou61iwwMTf/M/bl3KSxGsvdExxy7bg8zHq2JtYpuzdo0kdYaJT/
 5qPiD6+w1EQVYOtMTdiHhWgH7cY/WqUlcDnAHX59JuXs60NYKe71ROJ2crQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8051t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:14:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so80115ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569658; x=1792174458;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zE9nNPxG54ucsB9MVte1xZaX8A3IfC5FAVRy4RARHM4=;
 b=Ht56y5gaWGQEm+527A8ls4R5JOILox3sNAdgw0mHHs+e+gFXWxgdqdevaXFOpc171I
 y5mVkre1cEohfnjzqf3cH22YMg4KnOX3ldK+Wv0008W6eFYhngWB8hWHE3ViBCJ9QOsP
 VHLa3I5zECzZC4HXLFsARJV1YnndKF/btxq5fUC0/grVaaWi4o1VyzJ9KwoAkkA9rK3N
 bC/sXdOQ+BeEbjqRKZ0+JF5TKu3F1OexwjKpzeUx37slvPSQrcEiahVRbehXsR7VTqKY
 GwAlvQDLNJNxerx9kuY+EhafbHcKg/NoPR+6AdyhY8FZ9Rgbyo2G0g+SHubPPVpX3Wyy
 IDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569658; x=1792174458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zE9nNPxG54ucsB9MVte1xZaX8A3IfC5FAVRy4RARHM4=;
 b=2AnWp84+bEIi2zELXx8rA6NPfsAF3xC/q3bJpKyDZeBuKroPQvCe2CqenhEwz1lEAA
 y8hBg4NjpeEkk5TKheqXiKJO+8+PN8DjEOX287lOn3NWB7wPp2Y1lbX4nOGGC8qCLpvv
 u8VOMqyn/1bqzkbymGneky3hAqYi/mOmwxm0XpaH7wdDfuPyYdpUygrCuWqTmB5ThxAy
 6vVJYo83dQlPcLYKM3m26DRpsmxKssf9HWorfVGs42CbR76KgiOjrOTtJaoSDkT5NNO3
 bMo7Z3sN2v4y/myWPh8/Ozi9PWZfsAxmlca+t2bXrP3p1iZAj1J23+Ij8YdmhmDtWV5z
 bxXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAYc8Y5OAWxhV091q6Gcce4bd4QXFoDRPRP7TQ+QkBW1MF2d2Ub5NDzJZ/+jPtCcikSnUlVW0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJEpcAAD6W47IdHbVN5jcspoKoA80Z6nHNsp4mIBQaOedn+6D4L
 6uWb1dpL74/fx7/VOH+tmICvvkefl96mjNFojJNMCFO96MUqk18u/SiSXoLyvPphMLmPtK6gpDp
 LlmP5NeBDFANwpfIAtWfy6xF7Z73+gMrTec4hM8YUWvx9e9QWhaMbkFvtHim0R/NlY3W0HUY=
X-Gm-Gg: AYBFou2bX8u8EgnY4st5Url/qFzsZwS5hmqJCyyZdOlAbx8kkPyIxEfAQhxt3pA0aty
 D6l50fR9XL1HCk6VxRdoOpUYS2PY2LHrt5lQkMqH9EnMwjl49C8gPuo3/HDsxhvp26w5fhfl0It
 GKudNcdrgRQCuF7PkOK2gtD3JUcC7W1QLnd0chkDBr8eoremm85fy1+D5rIn7sovN52XR145acv
 xk/wC5d1AsNWdEwp/wp3YYHYl93a2ZUbQC98BEleNVmNzzqzNFIyxbYS5UI2npQla3E20WxdDNn
 4aphFTTxlipBjIeH36mZz9GwT/xjeJ8OgGdNZI0P6uWgGrPsG+wTofbS/cQhZr+7WZ+gkSjUMaq
 h1BSmLd91cFjtthmAP5KpOvI6QmOTkIYo6jSgwtN4yG4I3UwCbZtOKvMjLxR0sb9h2+o+yhPHxb
 zN9/lri7GInpoTbQBz7g==
X-Received: by 2002:a17:902:ef45:b0:2e8:2f7:4a60 with SMTP id
 d9443c01a7336-2e842cd211emr21717665ad.51.1791569657564; 
 Fri, 09 Oct 2026 11:14:17 -0700 (PDT)
X-Received: by 2002:a17:902:ef45:b0:2e8:2f7:4a60 with SMTP id
 d9443c01a7336-2e842cd211emr21717505ad.51.1791569657091; 
 Fri, 09 Oct 2026 11:14:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:14:16 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 7/7] misc: update API documentation for bit field
 support in NVMEM
Date: Fri,  9 Oct 2026 23:42:52 +0530
Message-Id: <20261009181252.2334254-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4Xe+FdDA7PWh
 hmLp5MC+74+sSzd14w39TM+isdyKczQXBghEwq0xJwBKCR6C216nIX9iviEghlfBSMs5Ktpt3XO
 kx5vmZnYRnAR4MmeQowDQfpF8OZ943U=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ac92efa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xnw-sE8SsPs_kYMhUbAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: --g_dRw7921Grtr6XD1whNOp8jDH-GRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX2dLID0zUPRTN
 PUOq/Yd2aUyzSD1FrgxZdPE2DVv7wybmXRW2d6D/u9/EpMxqTffhfWPkCJ6jcm8h8CBt3JBmh9L
 OFT+0mxFdsU45ztdKprnmd5mVE0NpNoezqVqzIhUbNi+ZVSsF2La/YI8Pf7pLJ1zhPwDgzGFPVz
 H/YW+rRP6d5Em5pfA+oRO3Lkoeyt2XRZ2yUfVgSnX0GK3S8Obz9pfxyP1VGCxCrEsWSM8YH781T
 5fK86yXPmNtqEdOuMYUj8pS4Y1iYge6uRdULwE8tgw+vr7zeHnFkXoUsflvQ2QpHOHOVq53XTZm
 zFFTmgEmBu3vAfJujXfSRt3e4qfZGpYePw8ahR0+em51+TUN6SdzoHRMNH1px7d4jT0wQGdWrXI
 K/GLk+/cqqpS9uFhaHN4cAvC926+oRbf6xI0JncIsNK9y1qKoHcVEqhKWhYdDmaUU1enlW3s0vE
 BOzKnJNKZEb9k2SWoAw==
X-Proofpoint-ORIG-GUID: --g_dRw7921Grtr6XD1whNOp8jDH-GRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update the nvmem_cell_read() and nvmem_cell_write() documentation to
describe the new bit field operation mode.

The documentation now clearly explains:

For bit field mode (nbits > 0):
- Read: extracts the bit field from raw hardware bytes
- Write: performs read-modify-write to preserve other bits
- Requirements: buffer size must be sizeof(u32), cell size <= 4 bytes

For non-bit-field mode (nbits == 0):
- Read/Write: direct byte-level access
- Requirements: buffer size must equal the cell size

This helps developers understand when to use each mode and the
associated buffer size requirements.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 include/nvmem.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/nvmem.h b/include/nvmem.h
index dd82122f16f..c3d845c3a7e 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -43,13 +43,27 @@ struct udevice;
 
 /**
  * nvmem_cell_read() - Read the value of an nvmem cell
- * @cell: The nvmem cell to read
+ * @cell: The nvmem cell to read, containing:
+ *        - @cell->offset: Byte offset within the NVMEM device
+ *        - @cell->size: Size of the cell in bytes
+ *        - @cell->nbits: Number of bits to extract (0 = read entire cell)
+ *        - @cell->bit_offset: Starting bit position for extraction
  * @buf: The buffer to read into
  * @size: The size of @buf
  *
+ * For cells with bit fields (@cell->nbits > 0), this function:
+ * - Reads the raw bytes from @cell->offset in hardware
+ * - Extracts the bit field using @cell->bit_offset and @cell->nbits
+ * - Returns the extracted value in @buf
+ * - Requires @size == sizeof(u32) and @cell->size <= sizeof(u32)
+ *
+ * For cells without bit fields (@cell->nbits == 0):
+ * - Reads raw bytes directly from @cell->offset
+ * - Requires @size == @cell->size
+ *
  * Return:
  * * 0 on success
- * * -EINVAL if @buf is not the same size as @cell.
+ * * -EINVAL if @size doesn't match requirements
  * * -ENOSYS if CONFIG_NVMEM is disabled
  * * A negative error if there was a problem reading the underlying storage
  */
@@ -57,13 +71,27 @@ int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size);
 
 /**
  * nvmem_cell_write() - Write a value to an nvmem cell
- * @cell: The nvmem cell to write
+ * @cell: The nvmem cell to write, containing:
+ *        - @cell->offset: Byte offset within the NVMEM device
+ *        - @cell->size: Size of the cell in bytes
+ *        - @cell->nbits: Number of bits to write (0 = write entire cell)
+ *        - @cell->bit_offset: Starting bit position for insertion
  * @buf: The buffer to write from
  * @size: The size of @buf
  *
+ * For cells with bit fields (@cell->nbits > 0), this function:
+ * - Performs Read-Modify-Write to preserve other bits at @cell->offset
+ * - Masks and shifts the value to @cell->bit_offset position
+ * - Merges with existing bits outside the @cell->nbits field
+ * - Requires @size == sizeof(u32) and @cell->size <= sizeof(u32)
+ *
+ * For cells without bit fields (@cell->nbits == 0):
+ * - Writes raw bytes directly to @cell->offset
+ * - Requires @size == @cell->size
+ *
  * Return:
  * * 0 on success
- * * -EINVAL if @buf is not the same size as @cell
+ * * -EINVAL if @size doesn't match requirements
  * * -ENOSYS if @cell is read-only, or if CONFIG_NVMEM is disabled
  * * A negative error if there was a problem writing the underlying storage
  */
-- 
2.34.1

