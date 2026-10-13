Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF6CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9591080C43;
	Tue, 13 Oct 2026 05:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpz5LqhgJduN; Tue, 13 Oct 2026 05:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F263A80C3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869588;
	b=F+FVNFwXqmURUCHtK3YbDOhTn6gk+2EVUuk8BixfQNMHHe71f8aI6lb6GonGVLIu+Onb
	 mH0gzEPVGi/w5MUQ11jE0PNU2Rh+D1LMvxmcMH+y67ODzGSGak9T2FhXXpE6jILX0KnSL
	 nzlCOLP8MjsuN7SbHrDVaHkogUeTi6dbkSJbg6zWh5yKuSeLA+d88NvMQ3n2dfgQORm3R
	 eKocec/NmqKvytJsN6DzLwd25MdC9EcQIHrbKMEpr+BujRT4jNcGt/gQNVUps831bzsVZ
	 +cZJYCK7A/wBwFhuXn2x9hyLe92NDOWquvtpmVfwNn2V5Dgizua1b4yYtyPQYbz/aBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=C3EQ50uMNFpANqR0MmAGWfg2A/7eOYEVqMA26rwtKyAif58Hb/rgVpShSr+g+WIR1+aZ
	 Z8OSX9PTtCUXqnRkuelxh1zndJ2ThbNN6IVCFCH/9pAG1XBX8yMvUtG+i7G+QicR56bpV
	 aWihnAaPZD52X0ebW6zbWdcWk0fE0T1C+0UhyJjpPB/aFVQfPvV6Th7tHjN29tF8clCvv
	 Hj3eeVmbopf/3wzfcO9rJgueADHp7MfVVUC6u1CZSngGh0Ep2fSDLvuncxudlRzajoWoh
	 46RbGgwfXHoEr0ywsQYV0NLSMO8CL6vDekv0+Is4ehiPOOKS7xNgPwkoKLuuWXm1v/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869588;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5FpjFsog0sjZfA7z9/ERdmgGMq8FYjVhYctk/NYefZmw9vENTq5/K96Hmpf2Tw1A
	 K1e6yOV58TEm3K+hLGOKMnvQ/UDWUukoixxAW9YwvbB7ldTWfbwTQymcuWNNERG+BK
	 9KDte0Tm6MyJCJ4TnZoebOmyMGZvA+yjepSAtAd1WHF/NpH2ohzmxSileThIyer9Lc
	 xapjX1qrSqdSPSmaB1JV4hNN75tyutJ8ZHMLF7LP3xBPaIn28SZoEibN6/zj3fyk94
	 rEvzh7rfLqJ8zpTqTEkANbQXWaETEzF5wLcLDsKhO7UwQpE9FFCwfFHpCAZyIcNJ3V
	 8dyei+zReg4MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F263A80C3B;
	Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 946AD105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86D774008E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-9pTQ6bRkhm for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E34EC40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869584;
 b=scyPGgkTAcEQ+SOsQpbZ2SukS/Jm1bCXg1keYtxca47Cx+hnihmyj4LakmUB6GYYSOSW
 Aeuxbg5Q9De06UBhv4JVJ6mpH9a6+Eq6jnd2z8dFYOJFddSl+HoS1BmR0EcPIrKJ5v6KJ
 Y754G6YweH/yh2vL0ylaCc91SZ2KPUyeqLmAdCTMUHr2CQk1L3jICn22+Yfr5e+gObZ6J
 1iCximpwIlqqpJH2xg2neKzh2UqzBzGo9tJCyjSAuPJCXPog4cxOQWvqxpUqulYHt5Gfq
 SZq5aPOjkfIhSvxCR+IImJ/VMib2Tw0GgdMMogffRykf7rnUhm86sDlfvxJF5R31PmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869584;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=YEDz0+01XdPEVYj0hohkkANKUuBjh9c71biu75XUmKJIHWd4vzpq/uOGyVUTV6pRTgI2
 edpRK30751ubYA+SPRXfhMV5S+BLza5SMxAg4aXTkoTSfQZ0unKKlG3geohK6bYoyARGp
 2Ar/iBYhgipOV4optRIb4ZauqkIQvZpKx22guzJvpT+0StWilY9BHYHUD/KhWIKXVPcUP
 Q/AW8EcB6YbxIr4MWYaG47ETORALz1YgxYh1R9XDkFFVdPgnYGPlravDmLMGx22w1btVz
 Ol+Vk6H6oIqQhczQv4nR7Sb8GykwnHhC02PwhDmafa0Xr8ywBjDuamfhdQ6EsPIfiZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Lemn1XV2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ax7L1LIX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lemn1XV2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ax7L1LIX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E34EC40068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21fjL2620701
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=Lemn1XV2190G0FVlIm01ZeiB7If
 7XSqNjrPBXk25N/VOsURXk9qYGVGRNSfcdJzcQj1D+L/3/kgIhWMtOqhq8PYw5tY
 jjAIXbkhH646mV0OhrqFQ81aWcFwFrScBWn5DRXeN27AfWUM3r60WB4G2WlHrQmS
 D1GiKenQfyqYfbDL4m26h2C9XmIFQWbTHEkOKRrqGvLyn6xTejh0HMtlQ9TyJBSD
 8IlDY1McBdliMap0UwfuCjDz96ibwk0Uv5d8pF0pth+aDd1A1d5aRsDNlzh5vueU
 K5kE5R5VcwXRfgl4BI8shnDD4b5dvau/awN6U0t4oxBs6ArcuJN2aqaC2qA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcva39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so1769413eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869582; x=1792474382;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=Ax7L1LIXCZoBNvGXt0Q5wiosg1iX4jnqL/PSZtlHCPAJerBgkAjtjasEyZjRuyVHCE
 5w0kPREFh7QR7j0pXRLBbpugRSsXXDiUrbuIkur/LunOJuDm9MKLTwTJLt3Dunsoe6pM
 Rsl5oLiNMCAh6ZXj7PJ7t1o1MwCRNnXQzAraffmrcXXohC/L7sSk8NLQDo6VWxh6uOMV
 6Z6f0RKLOHADLXRv7sJkNw+RzM+ytqlBebiVIOgHiUuRC0yaI99h0FW4MYMKXK0uc+c4
 F6wW3azZK0ofS6pHEq8TfmwAwb50x/gCb8XB7Dmgt9dm0mv2faqaR836qRw6Iv2C9t6Z
 zcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869582; x=1792474382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=z2ohTElDoVBS2rV2FE6OtOo8x85KhFF86Y/vuT2b0Ch7/2Url12MBmQko5cqLlPrEs
 3p60RzkMmZ5FriazunbYYUSZ7B6qJ+9s4XIPw3xmf+tcQPxMWxy/+SNaLJe4QO8Qap79
 drZ+y0A2OiYTwk5M6BfDB+sBhzgS1oRyHrHVQHdRVoM84DQ8lu1nMWUq1AWKdcHj38e/
 vabeA9Sk+Vpe+3+4PNOTt1+yt/0nrlyEnQgKulC8glHc5unNXBeYlYMBQ9Pgh9RG/FHP
 e+WXvSkPDTgZsPRNfIyu/arNMooi8bJemJo8HMSTRh9qVIb57A73vC8/f+0Z6n0KoiP9
 lVOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweEGp3+gg9cV9hai/WY9Mjzig6PUJcZQICHaWOIkxEWp35U0owl1Vn7BwfFzAVivvIW2fIBiU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINSl865E6X9sNhbuNEYVdjmUAxR4jwvrvUr15KgRrbG+IULsCo
 76Hwy7qd6gl+3Wa4BTIwIkevI5EYAtwwcgQ//voLVSo8Q+GTMcqqrtqrM6YR3lMiGKPuC+cJZBL
 ka1vObWr4SKdxuoEsRX7rAckqDipwmPQIu4KE2+eVZfi7wY0QruSJN2815ZeDelsK/x1gYIY=
X-Gm-Gg: AYBFou2nGxaDNs3Jeh5s6uOIk0enwSrb5/fuMp+73cDaqpxRS8eY8AK7Umc75wH8I8K
 fA3Wy5rdT+oTdqL7yibwiLd+wqrHcxP7OlZiRWjD9gurY8dE5kZPyt75UZv+akeBYBlS2cvp5+/
 HSsKs3R+9lpTBnCRUKU0FFBJ7SiE5hckxwsb6bsV5Ag+ocEMMv0dORpdjPi7P6QQZKeLAEa2UEp
 cBiSOMJzJHFftj4xNZBEvv8n1jI2cXd8tX1djtiDIWGUCtpnoTsOqTv1XlZLPuP65Y26l+zdyGz
 59WtO1OACN038mSyt307nFVemKPVF3tJlPP3uH/hX4mDYmZiDEftwBCPQlOMzGxpUwdGK+Rmw5a
 9VePhkPD90TS2gAm3m7FSrtM92V2fXeNYFKNWUpJn6nnA0EU=
X-Received: by 2002:a05:7301:514a:b0:35c:9584:3d77 with SMTP id
 5a478bee46e88-35c95844c49mr834685eec.35.1791869581709; 
 Mon, 12 Oct 2026 22:33:01 -0700 (PDT)
X-Received: by 2002:a05:7301:514a:b0:35c:9584:3d77 with SMTP id
 5a478bee46e88-35c95844c49mr834653eec.35.1791869581064; 
 Mon, 12 Oct 2026 22:33:01 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:00 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 04/13] clk: qcom: add configurable FSM-voted PLL helper
Date: Mon, 12 Oct 2026 22:32:35 -0700
Message-Id: <20261013053244.2954876-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tG-r3TANMsKJKgLnq4zIVvWyuNRiUNvt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX7RCoRe4B094u
 8I46zxxm/BALwR64gZKEFjC7KdgYkG1qsDgtx+dV6aCrAtU7z0AxMksdxHzupYtSAbpCM8rbiF8
 6nIzHRIPsO+tm+GZVW20/GBzyrd4aCo=
X-Proofpoint-ORIG-GUID: tG-r3TANMsKJKgLnq4zIVvWyuNRiUNvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX7vu6SQT1ER9k
 yZK7i0CTNH3mPHHDtpzJ0orlmHShwYIEEKLKW10DiZyvzSTtdd+w1aVcUw1AN8nXatPpgRGKj6Y
 MaPaCowr/pwzrN33PU5FNbEbUEWkQikTYa/s3RS16LwY5hbtjGmtHC8mCc+eaeAus+rHTuO0eav
 brvyjUKKxEzJlPukl5DM2lev+yrHXpH5ShsygYf/uRSiCtkitX21rgzpe8YHd57bObosxS6DYk8
 8Rf5sqMvKQ6fGmIYUo8mO//hRGs5S2RMvfA5CwUmk4B1yQsMRIx3MEz6uFA9NVSG74OAIrmDre7
 V3mKqjpMZEHhTqQyKzgnfsIywxCqyATnzTNvDRxyAMHTWDfqdg3rzIFUMx8O754sAcq+B88X+7e
 u5Yk0JOABLeUM5oLUVBMwhrY+CB2kqGkP4e6RO0DiyOeta+u55TE8SZW07DMH9HpISducvTLcWa
 VQjhn3Bc4RZmztmyz5Q==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acdc28e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

