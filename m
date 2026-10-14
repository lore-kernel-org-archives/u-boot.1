Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221A9C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C4E80E80;
	Wed, 14 Oct 2026 16:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ez7AgXrITuIw; Wed, 14 Oct 2026 16:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C1D580E1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996727;
	b=gF0S6nC0RhG87ZwzEiWd4EPmNNkGKUJDPucTxPWTxHELfn6nSq2e58g2lutgep16O6X+
	 ljJm4pC17sHOqhGd2F6ou6qhSi8QvZhOx88MHkVPfVWBuE+8JAej5apPRrwrBSWIvQXeB
	 YsLp6cNga1BMh16db0lHo2P3UsDsSM+w/oZENSgXh/2EsxoAAmb7uxSTd7ryYTCnZ9xaF
	 AZqQGK/45IvWl4KAOw3BLzmphHUl6jaa0OpaXWzErR6ozMqIP8cYV2rW38A3EVZtnSR/F
	 qmXouoTcsweQ2++MyEMhppJ8m98BhpBiZoiu5oAuMsR+GH/9/oR1Xe5V3rsh8G88DnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
	b=YjsYnMmCM5rER/7jlHOAHYVEC74N8NnYGKPcCCUj2l4BN3ngBDcgGcUIWCO2lUd6WjLc
	 wyKlA6WxM/7L81/nXWn5An7JmHUkTzOtbKwt8SskM51RV30za7ByOeLl3d6BDVpi7TZMK
	 Z00BKyRXCKVJV8cYqQEk9j+YK+eIXSzqMhMx0TaCMhI6tCCk39tL0hsu36joEYQOgjXeJ
	 /LPnU/g7Kzx7bFPs6SyGjxLuRdYZ3iNLex5u5Nm0hMIHZ/H9yp+tOCQSe73ewosjm0Vf1
	 1Ly5ywjSk3dN1brDcBmQgpVe3LKg7nJoGry1RuWvGU3ZZETKptuqPWgwUz2zur7hnyQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996727;
	bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LiY9tojSXz1tGauHWQKQoMqt7bgW9lQi8Grg3VFeGE0MT9ALm4Sf5UindzG8Ua92U
	 eCyOP0vEDv7KXhqRE/RqhyDFCZpitXJrcB5KPt1XPsec4HyRa11C9bPdkUhTBp3U1/
	 vL78BJJ+fFuurl0bJ3Y/9nskSBOMDE+uRoXi5wBkun/enC6ixpaGrDFZesYI4zXl7T
	 0e4sQNzcbThgmNi8IPLLnOFkXjQh7CDUfftTkyVpf/YveDWlTN4E01f0v8BheAdQdI
	 OkzhrugS7HGXlc6HDln7iEadwFJzUOLU+53tl8DY0ateO9xSE9AKvruvDN8C5ZVyt6
	 n4LTqEX+gGYnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C1D580E1D;
	Wed, 14 Oct 2026 16:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9098F255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76E2C607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppUTf7hYUuLl for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:52:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EBB5607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996724;
 b=JKh1K54dKmC/EYBTjX3FOIz3XjcNf8efJYVauJIp7ItboxZp1jwO/8fBkRVnb8NqaGNA
 u8+WPpZrlVklBqVFA5vYo7gmtw2Iv8US6sc+CWsO00YQKQi7v14B0CZtfVz2Hh1pS7nrV
 pg3uCyGkhVfemVrwp2LVq0bjr3EAWGpoBc4qF5cgTbUdxJcrA76PJCwkBgLFW1U4eroap
 Axr3ErgXKe8KwuEXmjBQjEoGNobtCLNP/Sdz2oSHg13v5v2t6lrqruib/nhoPN8abj4UI
 C7LZnH5WbTsBjk6xUmdojg5cBf7cSZCtfPzNlP60zTyF0Ppmii3lZV6qGiQL3Cbk09g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996724;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=A8G3ZBizBMHpP67eyqU71ROd/zpdzSc8JZ467VHGF7tvCQ+600b8wLjKw4wrFUpf9YmH
 xLk/4s4hLO7elAqI6bkgmTMJy6JEW6OWKRfAAKZxBnFNaRVhzf2kDb5QR33XHJy3ouSWE
 wivlj/80T6aqd2ZA2sPGkXBldb7XRwyUVT6ddoy7dgu6MLGHmONlABYuqGWAb3hY2RXmy
 cQKn4TKve1nU0Lx90h69ofCM1+OXHo6i6DxltwCr/5YvBIRvJfs0ulVMAHZ9EKMFupaWC
 7l+pIs99sO4le7fyg/+Vs/dmoUfHEd/gK0kip57vceHPLubKR/500/V7Bbfbg1nOh/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IdgI3IvQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jG+dcvcm; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IdgI3IvQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jG+dcvcm
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EBB5607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbN5F3643036
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=; b=IdgI3IvQHCcFqRRm
 ffcJA8Xz6WLRExA9YBym1lLmEBNzycD/OXEDNf5FANaj8a69PulLNUVAmZB5y5AD
 g6Yux8EoByTpEyhoR0UXoHLt8JSjb4HPxTxlbmjcRhb9AySbuxWDmmAY1RNF6UsP
 vbQ4SId9oINYgj0Xa6wBBxaPQfIDmhDeS96uQiXrB+ATu1e2aD9qqhRJTdXQUp7n
 3u/5VTb0No7Ykd0f+EmRo+8beEhuq8VJmqqDltwuW1sNEFn544Q53FPUAiAz02xd
 B0+s/yf7310feHxn3nZBJCKUAAeO5zIGFBQLZ4lo5TVF2nU8Dbl3qy+bTI/4W9fr
 XjYiBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470ak21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3728648eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996719; x=1792601519;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=jG+dcvcm3Z9tXgidAawj/caZF9AtvpaCx7JWYn5XE7PYEZ6CdJgnMSnSvPUmURLtFR
 xIVVWmNQI1m8DwcN5v7n1I9Umy1BgtoMNzywDjmbwNxYS/GtwH/TUrEEcgkPIcsTHCbr
 q1KAEQSDZhxyXCHfsNee41Lk3rZSMNAv0XS/41C1nlVDNNvVnGw4YqMCEX/LqDjQo9ZR
 /z6sxigIj02caR/i3lUH9XgR6+kku1yxlgnsffyM1DLsq6PgXp/wXNl26hqkgkcQG6ea
 0muOCawMXVHak0K+v5tpqLJA7I01PW3vxvUEuAWEJ7gbRRhHmzFKdyKQvsSJUwNwp50k
 RBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996719; x=1792601519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=lhHD75jD3o4CFDeo3TdttRlsngkBEYNIRCCC8AJWh30JaH/gtKpJFyMSIn7e6Oxs2Q
 N6KsqBPIhAMXj89MiKQ5DQ8hjOI0Ebnv3daeuC5MqKzdFnHdDXJH8M5cO7kC5SLE3+6U
 vfXSCHH4VYVLc4GX6CYmedVUwPcb91JwiljViWOqYIqXlPgJz4kWnlfVcKrmNNDAV18q
 e6GI+7F4ynD2X4dO/lpTRiJ3v1xDa6M6SDzl3AEzYjxBXRqLv6HEvUnssh/k8XglyTlB
 a65GiHKIMD5eeZa3sTKUm1+psC8fvZXQpewLeVtFGd9y2dKaJR0VJAvH7+KS1W+qNeb7
 mlFg==
X-Gm-Message-State: AFq9FYLKTF7MeFp+Un3ix2g83nEXWsuO2hjDuHIljqVZS1cjLpqQtP5H
 6gcO3a6rkvAEayiP6y/u3f4RYpr0XzjUfGbQqbH67/BmOUEiOPIl7NqeCzC1qjyh0/SO1vlAL7l
 8NMnb30ZA8OzSrl36R+3xH8EIUfJzqFM67+oBJ8SsI0K7whYmTUf5JArv1TXophSx/I8+dlo=
X-Gm-Gg: AYBFou3F+NP2nMtIBKeZPhJ4N/9fAhRA4ah3iN9t6m4RjMXHw+qXjjPZ/WXTLAMXUtL
 SM9KkDWL/MLYIAV1E1bEPBJCPsbRdFW0yHm+M8LfIBno6u+wvP3b+K2Pa3lygAA7emeXRKXLwV0
 7pR8KiA2uQ7fOU8i2lBU/dfz4RJqbqacZwXcgvOnyvlLoZwkSzlkaYA0iZYiuMPLI9p+hw55yPi
 0oiNQJq6ZBWDbmEXtbJmcuLYTrLVC4SoMetALo79Q14p+Tk+pyBsbJ3T/AjTqDV1EE2Qj8oA0l0
 0+vV9yKTwpj5l2fOokI+Uy8zvezoy5JjI7oTUGb4Kgf3va1+2CsQnp0NPAm3M7OQSUW0+6rGSbt
 X55hAWgTymTgCwjjpNe/jrNO4gT8twmJtK7srm2hHsASba+EBBPyu5Q5BEH71v0ouW8fQFgw26o
 wef4+/AixMnYmGkQLYZYk3yvzfZZk=
X-Received: by 2002:a05:701b:2806:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-16a4e6cb97cmr24321819c88.0.1791996718876; 
 Wed, 14 Oct 2026 09:51:58 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-16a4e6cb97cmr24321764c88.0.1791996718100; 
 Wed, 14 Oct 2026 09:51:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:57 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:21:01 +0530
Subject: [PATCH v8 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-7-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=3941;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KPNNnHuguD1AneBC+YBqm54oBqvfQYhw/NTZlYFwwmY=;
 b=QnMM4UfUhCO+c6tX6woZaW6/LnsZ2lvPy8KG2fabWKkx8JrUXx+XXVsngeO/m5kLpJB+Kx6Ee
 We7jEl5Kt45DGBk79Ozbi1vpsYsymN2agfEq+bszHYpsnS/jbTF6675
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXz6CBN45hT0Ou
 UCEQDBLuo5enZBi6mH+OZgk6BSwFlug5wLf58EvFdRgQxqD0mYgCZfjjwKJHDxDdm3XMsld5vBv
 hTVEw0COBtSc1F7GLz/Tia0Hq3qKYGI0RtaC7JgYXhPKT6LmsJh7A6TMMJyB7P3r1yBAaMYsW+t
 QOIPelMst+Az+QzOy6LJltYAsNszedQQ9OzdeqfXPA9Q4CdygFQPqO4smhbc0Pv4rcVpDSHjAzq
 7invpBjTcBQmjYkmy5cLI3QVb2shwdmQTam3QJg6+RwZVTQo7tLzOuqbiL+OLmFqGNjj9jhmwa0
 8Xouz9X9S+CkVcawFgMW8ae/1X/j07AvRPL/kfN8JvTVcU5BVM3LOzxf3DM1p+VzNI0QVt4bY8f
 2ZG4Ylwe9UAs20GcArZOG6cOXlUdXY5z0JN5yX/aAPYI5NAq9jeHIXcXvALe4za+hoqeM8VbWwH
 py1xHx8m6Oh4CK0ngeg==
X-Proofpoint-GUID: TeArzbTKwd9gWpgun53hF6IOJJhTsFO_
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfb330 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=daLpoQ4NbywWfa45J7kA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: TeArzbTKwd9gWpgun53hF6IOJJhTsFO_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX4UxBKNukHDE/
 v+L168Is0hx+LFNF3UQHp1WgUX8VmvjH1O/RsMgrGF7SPul5sQfwZtHan0fL/S4nMz88C1SWA75
 gdefczjnWdvwRWdnwqMhteLOoiA+XIY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot and directly jumps to it. U-Boot then
enters fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Disable I2C configs as its not required in Snagboot mode

Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 46 ++++++++++++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig | 18 +++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..20b514a0a5d
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,46 @@
+# Common configuration fragment for Qualcomm snagboot mode
+# Include this in platform-specific snagboot defconfigs
+
+CONFIG_QCOM_SNAGBOOT_MODE=y
+
+# Disable configs that conflict with snagboot mode
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_IOMMU is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# PSCI firmware is not available in snagboot mode, so nothing implements
+# poweroff (neither SYSRESET_PSCI nor SYSRESET_CMD_POWEROFF are selected)
+# CONFIG_CMD_POWEROFF is not set
+
+# I2C peripherals aren't accessible in snagboot mode (no Command DB / RPMh
+# power-domain data from XBL), so probing them only produces noisy errors.
+# CONFIG_DM_I2C is not set
+# CONFIG_CMD_I2C is not set
+# CONFIG_SYS_I2C_QUP is not set
+# CONFIG_SYS_I2C_GENI is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_EEPROM is not set
+
+# Use default environment instead of loading from storage
+# This ensures snagboot mode works even with corrupted environment
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+CONFIG_ENV_IS_NOWHERE=y
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+
+# Fastboot configuration for partition flashing
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..d6906c1e501
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+# Platform-specific settings for Lemans-EVK
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+
+# Timer frequency for Lemans platform
+CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file

-- 
2.34.1

