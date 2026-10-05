Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF2CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F398C40401;
	Mon,  5 Oct 2026 07:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gTF1phyjeVn; Mon,  5 Oct 2026 07:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ED3B4068C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183884;
	b=nHwH458tIyeefKjUlq6mPPX5PAuC6uzHto7N73DL5RLRW9jsDhmspk2bRUlnebDgB8YQ
	 t5jQNHt+2TOwBG9RsZ4IkNuVzxYmOAaqteazOkV3ld6hpppNVWlge1de/SKIYZwMNfDBK
	 ndb347TEJwXsZqcI5wA4fQ1XGkUw/7nsMZDZ0sAMz50yyrVB0UXwoa1pUDY333Tmi95Rv
	 t9OFZSLW1NlyhOfoXixt4qwGzECN3Fs8GQRBKVpVW73pwzxI83fwf3Pks84TWpYYlXds2
	 5yUsQO2L/L+VfiOdM7HASF2pG5CmA12ChEjzWPutJNekwoca5tIWJhqa5iVB5IEca2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	b=MwK2nx3aCPCEYt+0zGJK9C059f64O/LbON6AAG6ZuJz3H3Mnvx/T9loWXkZHQMAg5c5T
	 7hIUP/Oc2TW4GlXj0XIGaZjdmUBb7sPSju9aYXPDzdUIt+4jnowCfzmY/0m9wbMl1jK+H
	 Pv7o4tqs+LZhJjtHXcVEuIs3nELbi7CgOCfsFUM7pjxWv4WgzvAbSZEH+zrSFGOnrhZnv
	 c2pskca4Zw2afss6aMLy2BcxT68bp2OxToHzVKRfxNAQEVUhLU48A4hm5kg4KICYVJxkH
	 E/pE9tdn40ZhqmVjJ/U2yNPC9nCOQkKDPXpZJuKy4c8EoREss9K37MyWtihelgu32Fg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183884;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b49C2Yh+4wXOB98AcKjacvoSO9WxwLEVvfy/0qJ7YTJcWqqc6XmTdt4459BhmY7qK
	 EXzaAGE+HBsrX3iaItEcF2XuysQK48Huu2gj3I6657td2+6S82CKhJWuXpaobCnmWL
	 BZ2y+rMhm6rQVj3VaAo8Aq6++C38+FI6cctItApdVQG21xFa2Vq0+DXJpY7PpvxjbN
	 d7NA/LqiigQ74xc1ZWaA0fbsAT/gIxpv9aTR99MLdzNztLkcC9dpvxW3HCx9AJDEWg
	 8alCI1Nsjmdx98PItZpypXa4PjShMsjIs0/tYnPJCjTiQhfN+CrMmPATss4iNcBfZ8
	 qrZR9H1GiaaLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED3B4068C;
	Mon,  5 Oct 2026 07:04:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 652041A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A3618083E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBO3nfyoPDPc for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E95680839
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183800;
 b=n0krGX8nZ6stlpnImaUKrKPaCqzbzdk1Q4R9cqkXCexa8u8rKQZEe6hVn9EzVDLdZ1p5
 ySrMbLjjw3D/v7b1lAtk6wrcTpmGY8h8gC7EkuI1rUbz6+ION+3BBgdCxmgLQs5gA5JnI
 kYOl1sOOC/BsthSXD8DTKxuW7JqDpRLfYhUrajhVzJ3x2wNwQLDptV2mv+if3G+w+vMSV
 vi3n7LyyXKYoDjwFJ1Ir+7dMcbXndUdLLVLKZPUiO6+dcyO3gXZVrmiuHXPXoPfgaMOuQ
 9ti3M1cBUQ2b3sJcXD77oJWhQ7Ip2TlGr4hWdjvNYE6b4mqriWnfJyz6AHqMngUVr1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183800;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=fzX4VbZE+LEZcgPYAjAD00Z/qc3FCzsdFRa4HNgoa9bAlAjzLq1ALz6QIofacIfZ0D16
 bR7s2cB9mC4O1Uw+VmAXk+XjCyuWdov65d7t++1sBnSFWzU2+tfaemgRxrQWiX3S4j9cp
 Sn306f0lNYOn5l8rk1WzfC7igT+RWDw3Dc/vdQLoCQ/57M+UO5BwiTZfxAg/AKhxTJirl
 dZ4KiTped6aSYsQysdmknq2udSveai3MT4zerzGPP1gjYPZuVxGWOF3RB0DVxjLO/2gLw
 koBTDcBb0hS4gsTPXuKNgROIiw1mlk18t4xrUxr6GfJIbCGVbNHfwR5pbmWcKdlP8ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GTBP48Cm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NiU43XsO; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GTBP48Cm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NiU43XsO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E95680839
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695101qP1464549
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=; b=GTBP48CmD/DmPG77
 wXcQyDGG+a52e4sl6Jav5CGE4hfZe0IV78DVZUpFs7MdZTW2wZb/JRWgpHunZ3Fk
 pEguARljMTSbu/Ehd8G6Y+8/CkRAnPIxCEjnTd4SLgYGZI1TXDhdXSC6BPwqfgex
 poX+4H1tpq6qelG5yjN6+yJQ6J8NIOxBA2QXBWlnP2e0oSOZRLHXl4AZs6wK831U
 zuNWOhf3e2pDJyj0+bhH5cDBQRdtOD4SnMW2XuiVUZ5bN5bqXTTPjS8BqTC9vuBE
 HfLAELbwAX8AWBGrfEhcIVdEQNfspmrS6Y+Dgr2KMM+420Jt2rFJTNscFaHjkoNY
 MXV1Kw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssmse1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34e676375d9so1511196eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183799; x=1791788599;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=NiU43XsO6xLBN0iqcKkjuz2LRpsgLiBRoaersva5QKjtwWaQgbRz4X1SQlAGT7wpOJ
 qrqBhEfrmhL6E+459udp5OTID2yH0rXZMBHMJJGU5lKxqrK9R1zIZmUP1YORkLjPAGKv
 xXpbHjuvG7MBWuH8RdjS6Xv2TkRhGgourUvbigZ5I+8jh7bK4kCJhKy1SGhUmtr6L61l
 qSDNCLqeKiKN5qzFv4hSJnUtvky4eo8mBXiwJrUyz+VUKtqkronvLo1nm0fap91Dc55i
 bpjc2HC8p8FWqBn3T9OssgSb5mS0IyztK0qM5ZEErrW8iGrHu1mcZKYyANERklauhLxJ
 Ifjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183799; x=1791788599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=Nu4Z/U5l/YkDlNRzkmWlbFsbTMg+lrX4Tv/s9Gb8VIAa/zqlI4UyrSRIfwkVhXlIx+
 zMmqVl0+rzViqU+A060VFvkw22mPjeEULOFYPhenljLy/+mgTqQ+6W/tEcpUZivtj9sZ
 FRkoYBqG67uqcYaIuyZMZyMP5wleEBN7LEDycx2JzM7GXL+yLgF+SGeBFUAl/Z22jlYg
 W/GWYLxb8+cI7H2mNEagLdXStd8qrbjbGp+HkWkIg3az8CkhnE6xei78ybcQMrSU1rtN
 rLeUHhtfeCGOPyfQ0RC5gqD9bmGUu18sN+cc/r+ooZUxPSDQy0B89fzo7PW8LQWamvEe
 J87Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwllhn2Su78TC5mo0OyLEuHEIs/3HitN/iDR6DVUe1IjpM8mQkP3NVwbH/U6eS7fgOsGihy390=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nrR5ey6lctUwxmjZi/YUzh9NTekkpL6y73tTdoap/qeqjzVTQ8
 P+WyeJTdwBqPpqIrHmUAIIEOzYd1R5JrZpNeAAFu8lwXVgv6PPBqR2uWcGy8kIb+mWgQ8V+quav
 pprX4HSklLtWlFrWfQk+gt3IfXDRXxQeG4yp0kNp5+rLdbNuAxvvrSQS8q+MQyi8gJClhyeY=
X-Gm-Gg: AYBFou3GvIBCHmVoztfqB6BP4RZCsh4GFPcRbPSFbqIqYLYOQLIva2oPLyjK0AnEo8q
 /v5+Jl0C1YnUyFzgUqTUnv+kAMWYNjFeWGZOIg8dP3VH4x04RAXJJI+NywzsIIeNFC+sCue6fJk
 X48JrTR/VUg5lwwnKo8Ce1quVUQlzJH/8kAweLYXYNpFKzSnEaNZM1kH8ZJVLgucXLXP4Xm+mxE
 SSfUE2EnEtmS43h+egTmtskOzlELpYkIqkMRwn+J5lSrKqMbgPRAdqjvdVwoEjCzfd0DIfD5pX4
 nibjQ0JRGYSGKKlO8n5JbE085/urdvzMz6jSTKxCiqVKe+5TmIiwthzr0ZSCHDAiwkQAeCxpikM
 FI/BZefd+gDFRGPtzINB7NoV5pi+tXvCiKj/SI8h8srLp4b7Beq3/gdEl2zpbRDkCJs7Gatu7s4
 WHWOxUhKqALYA9eOnXy3rqXp6U4jIK
X-Received: by 2002:a05:7300:5a0d:b0:347:49d2:db76 with SMTP id
 5a478bee46e88-34db3a44fe4mr14794412eec.7.1791183798692; 
 Mon, 05 Oct 2026 00:03:18 -0700 (PDT)
X-Received: by 2002:a05:7300:5a0d:b0:347:49d2:db76 with SMTP id
 5a478bee46e88-34db3a44fe4mr14794368eec.7.1791183798031; 
 Mon, 05 Oct 2026 00:03:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:17 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:21 +0530
Subject: [PATCH RESEND v10 05/15] mach-snapdragon: spl: Add support for MMC
 booting in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-5-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX8Y8Bj0ztio7y
 Z9ThtydZJE6LmxZhEHh3iG0AkAIWHslnMHlhEeByyL0+Gwq4X2M/V07wOUnn74qIcGQieLKnJJD
 6XQKm7DW/iQbVSO636gitcscnuAflYQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX70iwTnmRWmXn
 k4rvjzlhhFS3C/vJRJhzND5Ok0BbTdoREF6Tjsf5dD9bIjGUfF1nqeXyvIcjkQY4u8sFvrppErN
 ochYDOEw/uvykYTJoO7t8eCk6MXh9+JS2qmnEEqi1qcIHLM1BhymiNzOc3M1aJkO0UGqr6ROw1s
 gXJSxH0LFEbk0AF+Ezhdeet/WjMGGcE7SciorvPouHcKMEa2cyziwU7VPtu6BHYws4bbJY9JnR0
 J9SZIUKTbjGS0iLP1lh7LjsozHXSsHEfDj8LSXGN0g22D7jkEK4Rr8c+/m/3+4HoZebFB8/Jolb
 uHnbD2QkhhN0MhsUWaAuVu16wxh7+WWRmBjkaD2LIB5xpoc/ijmRXQnhw4lCUKRmwYfz7QhlAkk
 S3oFeAx5q1MwwlyOd5/Kt2vMMi7/O2iu7cHoesihpMk8ngj4C3ti0EisXFMCKGFG7ACO7NGEohc
 CvUyKOh4k1EeXuxJvNA==
X-Proofpoint-GUID: wLF7omQytTqGtTS2mKNgBSsot_va-n24
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac34bb7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=FyIKYYy4Oh7Up_33twMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: wLF7omQytTqGtTS2mKNgBSsot_va-n24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add routines to enable U-Boot SPL to be able to proceed with the boot from
MMC partitions.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 460d07ef0a3..2445ae8b17d 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -63,3 +63,60 @@ static int qcom_spl_populate_smem(void *ctx)
 	return -ENOENT;
 }
 #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
+#if CONFIG_IS_ENABLED(MMC)
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
+
+/**
+ * spl_mmc_boot_mode() - Determine the boot mode for MMC
+ * @mmc:	Pointer to the MMC device
+ * @boot_device:	Boot device ID
+ *
+ * Return: MMCSD_MODE_RAW to use raw partition access
+ */
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return MMCSD_MODE_RAW;
+}
+
+/**
+ * spl_mmc_boot_partition() - Determine which partition to boot from
+ * @boot_device:	Boot device ID
+ *
+ * Return: Partition number to boot from, or default partition on error
+ */
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	int p_no;
+	struct blk_desc *desc;
+	struct disk_partition info;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc) {
+		pr_err("%s: Block device not found\n", __func__);
+		return -ENODEV;
+	}
+
+	p_no = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION, &info);
+	if (p_no < 0) {
+		pr_err("Partition " QCOM_SPL_FIT_IMG_PARTITION " not found\n");
+		return -ENOENT;
+	}
+
+	pr_debug("Found " QCOM_SPL_FIT_IMG_PARTITION " at %d\n", p_no);
+
+	if (p_no < 0) {
+		printf("Using default MMC partition %d\n",
+		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
+		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+	}
+
+	return p_no;
+}
+
+unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
+{
+	return 0;
+}
+#endif /* CONFIG_IS_ENABLED(MMC) */

-- 
2.34.1

