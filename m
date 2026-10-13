Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB32CCA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BBC880BED;
	Tue, 13 Oct 2026 01:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIXIZY5ywUrd; Tue, 13 Oct 2026 01:53:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A037280B7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856424;
	b=iLWQPOu+pSdZpRNYA57UeItD6a36PilOIBoK9SVnemaAGc70nWLyIgdUpLHpt7WG/2EY
	 +qpkk9ruVaPyQErbUlDQKARpnEkwL/iDY1Q80w14hbndj0q8GYVWIfIxizC0v+a83H3y8
	 ZuCxv/G0o0PrPWFJR6An8TlOpR0WDcHzXYKjclZxF1KFRdaZgcvhvHCg8+RgqGs7lWmGa
	 ltkK2dEkjU35fVwOgyaWUSF48eiQM2SjF27hqrhGf2cxoCGZvibd1yI+fJVvbN1icEEun
	 LixvhMxOdq5GFV2sptUgatyK4nCNtosEXX8y7830fvuZJMhW9Yu+OPA100Mp0J7BQ4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	b=O4N2gqrXv+Dm7CFzJmQ63afKhDziqnf8mb9Gvoav1e/Ca3ZWzvyTsIOylp4y9KiBVrXf
	 E3fUHn+wO9fwgrwSzgN3tdTY0lFuyi+sMYUDSJQLVFqIrYi8RZ+3+PmZ4v1zr/Qavm+Sf
	 p0XsL3EF8AJzsSg6V5l7+AYSEWEh6iO0orS8bBKYANRN/Wi81XSXlY/A5jSpsJJdXk/V0
	 e2VUaDrV/mRX9xmdI1UAFQyfxLrM2FSiWOnpssM7qYGAzC9aNKN6KzZE7Wn8p7vJ1V7XW
	 8onOBDVjFsvxaREA3NIb12S+LbCj7xvZ+TnKSQ3mjbIeBcakOoG6yPOcnZuUJeZjlAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856424;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+czrapajSIZlWGKe9+dRwaNJrQU+7sjx+CByCu/Q24eLN4VOStZyHfGgap5LbJOM
	 QY/yXRp0ivrG202xPz8LlcpNPW/tWdgOlhGYuYEUKxoJtB/eLhicmC8/wB1jKfZWMp
	 GZrqfE29aK/Nb1T03C6pnlkKzqHbF07Flucoy1BgyTzWGTe+8JBtPxbsS5TE+EpHFj
	 Tplb4/cX1sMRvs6RWPqeYqxQhrTyaSmCmuqYif3gtOwcHmyQfZMQF9HIAoC7IAs8oR
	 L23c/hW0z061Nkr8QSDSBq1BcOIjlKRIBFf+ipjGZMz4cGJg9L0s4y0PFfeZddBeMd
	 Rn8NsfFDyIiyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A037280B7D;
	Tue, 13 Oct 2026 01:53:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14A69F46
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF93340512
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoQXjAleH7AW for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2D864050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856422;
 b=Cl+bQ1PWYR326TVMecBWLeXr6+IdXrdBvddYldrF4OjaJ28NrdIgIYfBGwx5GPPBnxzI
 2tsij83AWE7XuD8tkrJigCl2l4pKrGJ4vFumy+/36hkKYXhOPUAJuNL3hZetQEIA41OUW
 idB4o6BwQUCBbG20ARJHQ669FX77eSsWQSfbKAqjPMzrujeHRfNsw/aZCizVP95e0XDXX
 djbHt5IlOW9I6LUO68RLarqwI3YOYD32Cy0WWtMgpJBDLBTJzCoLNP9PsoTb2K7NePnlU
 NifauoG4BZaJE2YfEI4RBT8xkf1TSx9KRJQSOh05uJLxn9VWu11Z2x4/XvmjFfNMpYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856422;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=WRLlwplayaJcLFe8n2H0ouwbfOdppR8pnGk2c+4A6wKSqiaOBOPHKKZi369UHw+qj5qz
 5W9253Srfjn580V2tHwkzBFuSAFhwRU0tywGexnjf78Qabq5fxBuEU8rQs/NLXS7TGB24
 ll65bE8biId2VL7LjIMxAXo8itXiWPcLzbrUQa43nrO46nh7tnYgMByR5cF+m3wBAmHH/
 zrqLG9z4RbdooJ5mROx5ez38+1E4fBC6i/fo70m9Sp6EUCYZhAgOMy1S+9vqmPG0m1zMe
 ImIAay5am957p8g7Ge9kvjjEeFQ2c24lltla+LcQIO04mWXsu2XVXrg9HtgWiqnho1A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=l2rX5nkW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NmzEJefv; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2rX5nkW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NmzEJefv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2D864050C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMcmSR565382
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=; b=l2rX5nkWHgw3qie8
 l75gDH8SCSGR5EQ6QpgpzfQd299D/PCF1cHYPMn35bsF2R56/N9jqyrBNDedqjaX
 zmAgz1zRS8sfBU/MifrRzYNO9H/DXS5ET2RC3g4TlXjXml8un4Bh2WYn3rzpAQFd
 FpAnpKsNY/PSfaOCr61tv/L+p54VxhS6eYyGk2WwmdrGlNW6gsNIDBwWkiIvFDal
 3DP8dNCDhpTrErEdsCtQgHIJCxOnqfqilcd+kBqzccZ1sE1w1//uRAdJGdiBHDHw
 T4Tu5FERAB8+J7BUfJibJErIwnk1hiGmwGrWRRCnERyxqzQex0xxOuOuBjKYaWgM
 SDi5mg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc8gmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so639988eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856420; x=1792461220;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=NmzEJefvv7Ojsf1B4rQlMmYODT9PKYGMbNWUOzDGkwhy9ZVdctX31lU1iVd28ktKex
 jNhs/UxxBhDBPkyPAml1iT1gk1VXpq1fw/cgA/qrRJapriIJkGzu04OEjkByiXz4f0qy
 BpltLAzYhvBKG03v5eGu5+wzuv6aqguE2g3D5vFlL/uEyZahLL4iL2jYEgDhNQYYih0M
 y+E6MAl6hkV6fPMPYiZKYyQMLhA2W/ljB+8gF3xWwR3F1fnfsaP+Jk6itQMZ4f8HIgml
 uSL+1g63dYhKJ9ip6Zo+HYqaClBhdtYr9wygIBJC1PUb71OnJohViqrSLkcdDP2orWdy
 HqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856420; x=1792461220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=NXm0nbZ3+Kv2WwVdc4CRo4OOlR0Jq/ktaH6MCn25cSbwroE56eH5KhXWV+yW9JD1xK
 IyB3R7wUetK1lzJKhrWaENPsrQQRaluUwB4abIABrybCDDPNV2hbRGqGxk6EDES19muh
 XW+hv97wY1NPD0mKB0j0mnwmNZTvIm9rkndG7CRnXiTomeXdi5Is9aPXepdWilZYez6x
 smkfQnbS5tSi4RxjlTQ4LuuOCVsTqV/pztjUhvuhDa0F6wAHJJb1A6hrWptaj6CVEzW9
 hZKqNLzNOs91+oeFdHHlPWePtjxTDtcXJSOznSUh4savCynAF3HWn1oa7MFReZdPQXNb
 Xmpg==
X-Gm-Message-State: AFq9FYKMhTEvGzZIQH/0e+14+RZ+u0Bv7QByWds67A0dME/rIo2z4qeW
 f5YubPR8OTrz6QcWdbWL02YAn8k6Ke0cTOR98VNFeXyDVjgixVzwy2c3VXUq5aeRJ44myNgNnKU
 HSaQZei8/ygmCHvA5HgqSMPMi6wTeH41fUwbhxdNJzTAO6iIyeTeYcd5xwz090XbmHRE1dkI=
X-Gm-Gg: AYBFou2QY7R96+z4WGNHEGF2zsV/Epb+cuiPv/7I6rkER0kt+j8G2hEXBHotVff1W4a
 gL50n60sHUoRGI1GatgOqXBfxsXccqMJw+gxGkvdHNnv6v/xgQST40KqQrXU/q+th84A+ka+deL
 pk41zq5Pw7n7XWPZhNO5dsxQTqlKYG+J1EniHRx0m+9LRrFjqmv/HcjoNsZVkbcJAGKUMXR2MHh
 sadX3pmUvv2hHqou+VZySGS44LnGczNtSDzazI2mZ2YeFd6giwH9kZQvvwP2ePP97rtOTM0muYZ
 YndDqUOygRE0vZIM1cifPtgMaZK6SoPpnOFHBJUsY0s8EFHehMaFxwGlhRAT17wv4xzIj3Esh/a
 1NgvweTA18w3PgnukdxtEA2906ahUpbaNUUfwyMO6uVd/qFxDnD/Rxksc6UahSDP8kQRe/bs/UT
 WY3mn66AMTgjiIgtM5yVvF6AhvB8c=
X-Received: by 2002:a05:693c:60d8:b0:35a:6891:96f3 with SMTP id
 5a478bee46e88-35a6891a75amr8195967eec.40.1791856419524; 
 Mon, 12 Oct 2026 18:53:39 -0700 (PDT)
X-Received: by 2002:a05:693c:60d8:b0:35a:6891:96f3 with SMTP id
 5a478bee46e88-35a6891a75amr8195924eec.40.1791856418942; 
 Mon, 12 Oct 2026 18:53:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:12 +0530
Subject: [PATCH v7 3/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-3-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=2642;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kMXybNKBvme0kpiWoN1dRGVfV37kdSGtEZM3Wklaoi8=;
 b=J+Y0RZy06SxSJpzKa4AbqSY83mEt04qpQ3qjNSPw9hca0FEeRB1MGB+GxFTF/sDUbp5lh2EKJ
 IPf24b64lHmBfmPervVRpfoxmlO4kjMQJ5jhW/qDchq1wUelQUh04W6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX7tfoqOXcXYtu
 2vI477f13485i0qu+ODzO16IRDGc4ZojU4G23/v+v13QxYRZfm2xXckEFMX/c2NGms8icY2Lh1w
 +s4Oo0VZjsEefgQV0E5wrn+dlVhuuF4rpFvsvEkedUPNlXHJC63cL+9/HfvYbS710z4oJgLeRd0
 jfrpOBZlsy6aD3KykC2pc7biZzlProkEFyxc5ptLH58g/4In1+nNwSThuiZNWSfog5q4xd/5H2G
 xQsY9lxiwQBD+yaFUza7tr485mkum9+0Ovzx03xAw0OHX6xexnyFkix0SeilykRIo94eISJXSEB
 R7YLW5iF6W9cTY5rSDjXuTvmv0zf1BraXEOFEwxRC+XaAWRDa1jC5WTlNVdL872rqFklp7AAkEY
 ARr8908SSgEvi7BC8st+cT5QR4A0QQ+3k7I/3xk4Fem0OwTTEoBDvcaaKJwipYJSBjUKwN1+1Zb
 wU/fq8x7TDXO2wlHmEA==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acd8f24 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: _V5kiwN4Y-BOIbJE0n3QMa4fZoIHp8Qv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX1b5GmCDp09eR
 bqt7AxLLa0kHElMDlzsjdqhBm9pnkVd2Gdr0efy4twwahe0PEB6R+1QtwxwJow+8vkSV1UnKxOn
 XBhoYAJXetWKNBCwNDUY3J1mTlq1pgY=
X-Proofpoint-GUID: _V5kiwN4Y-BOIbJE0n3QMa4fZoIHp8Qv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes iv v5:
- Clear C bit (Dcache enable) also during MMU disable

Changes iv v4:
- Remove handling for EL1 or EL2 entry as for Snagboot we would
  only enter U-Boot in EL3 from previous bootloader

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f44..ecef094629b 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..f82ee87c9b9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point for EL3 entry.
+ * Snagboot mode always enters U-Boot at EL3.
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* Verify EL3 entry */
+	b.ne	reset		/* Unexpected: not at EL3 */
+
+	/* Disable MMU at EL3 */
+	mrs	x0, sctlr_el3
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	bic	x0, x0, #(1 << 2)   /* Clear C bit (Dcache enable) */
+	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
+	msr	sctlr_el3, x0
+	isb
+	/* Invalidate entire TLB for all ELs */
+	tlbi	alle3
+	dsb	sy
+	isb
+	b	reset
\ No newline at end of file

-- 
2.34.1

