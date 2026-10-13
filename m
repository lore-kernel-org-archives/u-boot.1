Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B012CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108AF60739;
	Tue, 13 Oct 2026 01:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EntiGiJUMcGl; Tue, 13 Oct 2026 01:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B135B60746
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856452;
	b=j4DQNO0RlOZyf7IO7TEGj207Irz27gjwEXT5PJ3SjOSWFvLfRUJ79kuxNoJtHduP/T4s
	 FcfrGRa/gZ1PvkwMWH4XlvrWlA5wiR19D94jh/pZQtTR6yBBT2sNH1wDrJKIm/nXlEGrS
	 li+R1AMx30qJwN4JaKoKkOstIVv6DjTB2pZKG9+0xdT3ObqnIEC5StL7hPOE6FWyklRwo
	 nG8wpaXpsMeUK1h/BgzunJGWhrzHHAsplFbDtNrByBSUMQX4nedIv+siJDegOdCF3XLst
	 9o1Pc5z6lOAjlhtSLC3vM+he+IyXDQ0EzdDDkeCpq3o5DIcEYqVV0JQGFZemJdXKdBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=;
	b=LPlm0EDwqDA02JWP/UYOQW6Dbophs+t5cwKUpiIs5+cFyWFsIEEs6k4wWdCCgbiq5dBB
	 5MkdSAq2YL2wpCFNGmSSTzbQIg+6IEMwB9KI2+nGz4/v3Ig6W7IZG3ZF/F9JQpE97p6Z2
	 QVU189XmCKhN1NErjKLsNmqed/VO+ADX2FhUx55qZ/XrsUHv/AEwRpkNARaDr1KU0XNHw
	 TKtIySErp6sVD3BWDZfbz0q6hui92ra1xyp/+iXJfqMxBKhBirMhtyVDXnRlm5QzY++JM
	 XgD/KrBF3KvB11RpJGfGUhtvIDXXb/BtS6Xba5hT64HJawPBrijaaWnnpLbFJJY/6Vw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856452;
	bh=za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pp1bfnt6Xzl5xVkMtDZTz/uJc0vTu13W9IbTVzxbQfmXdnltufsoxsRMhuCaCZX9h
	 6C5huIzdlIC4LmaeJk8OkxM49cEcLjhXueYWcTlFZz0rHxG79aoeJyLB+ajorp0y1e
	 Ku4d9mP9z9J7rt0HpGjz/HMxpndT8vXL0YjplG3rw/yQjfSDkVB4LkdeWgrkBHJw2c
	 y+WFK5nidsCdolgzAoB9ujQzrHinM3rDXrrtWTfeLyqgUjqpmyyKz9wWWJGR3UWAWV
	 lM8mHe0Y1F3IyWTWvOLriEgyTrCSHHh3++m4fRUw9w/j6chusFFJPFQb6aMHkcZpFf
	 /7zIXQcA2oJtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B135B60746;
	Tue, 13 Oct 2026 01:54:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A1D2A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC16B40099
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NejWQSfNXxFM for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AAFC04008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856450;
 b=BGmIs+csnpWo0z6V8vgYx3kz4omToblMdzoNNptc3mTKW9WQcRarAXVojo/5IuhI3IpN
 EYUK5mbVj4Xh2TogIM/j2Xomp9qByHQMKX8U0TEdmi+GowMkgQra0lZ64sac0TAzju8TU
 zGywTZDko4nqerMXC09zLUwtgum08VrbBfe1tiLT7f1pSS2KuPfV6SSr5nfToNlFq3Te5
 iLcitBhl1v73cOg77/Q5Dma4RfFBoU+OQguSmNZOQIrNZetnpOWRnLjBmcIxfMqgwKPYD
 h05camaAsYiliZ2wGxD3w7jql7++qKTOKOeElTUicP9jA3sYOTRS2UiQq8drwJ3rRMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856450;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=;
 b=tRvjQqMIVIbgvURTXuezgBq2BqMUQfaGYcT4sbP0BQUKf3Ez5agZEMOTghfJfa87AwnQ
 e4MwTNAq2HB5LmLvs4cZM98AOa4EkGmilNc76B9EoK1zgMcAiOzGyF2WjS1avu7bFHums
 wSqJmY+c0iW14UZk28G/XKjVvdMhPOh2VgZQkBpTk+gO2D1HyYj6sHLv6vADeFk4ZglMR
 dchq9gCCB+KW4UkPrxiVT0MbEcs76UHK7i0lVwfYOzl10IO8SZcbQlqK9UBtzZugbknWf
 kOHMl8aHQYAxI+lopTTJdXrCqsiWa52KYlaDCg9ia3IS1HWzC/gvQVCmklrpIa2kM9A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=F9y59zy8; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PBOL9xLf; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=F9y59zy8; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PBOL9xLf
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAFC04008B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJgdj33106602
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=; b=F9y59zy8xF1JPujj
 hxrFe9fMVN9gq3sKkT5jSjiKU5lDjwn7Ax9O6r2VXjT9c3Uh/duieTchCUDPmIhB
 7hGjnqaNYJgb3NAUnCUMMl9KPIqBrXL/qCF9oQjfzE/GE8/EY+0y13MXTtdF1chQ
 d+y5KBXUabKuvIBQrm0QJPkE+xqzC25YYhYhasYVvoeN+4I/NwLrsyt+J1JRdvEJ
 ZX8ReS7akC5562X+Qo9GUtE4G/veRruwIhi1QBpjesngNzJxffMC6Oib119tqp3y
 hVmB5d8axPfnd0LLcMvTbu85W/S69dJTdACVMba0e5GPjw9zJcQyT9QFzp5REf3l
 FckFAA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqs33x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so5312917eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856448; x=1792461248;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=;
 b=PBOL9xLf6vgtOJ9yVWhuf6vyyoHADWhWK+uAq9RQeubc6g/3HdeQKIzZ8yUoSzIQ2V
 +tig00+iNlc9doDGXUWGFJURhDlXsQYe1vPb8yvVDo0/BohL35JzuOcve+Gek9OjcnXc
 bFSgBEtaOoQH4KG4J7i0s7QR9gWDoJXEX0FLpMAEsCMS4D+3/ophp1m0rFp8Ff6QfmpU
 THrWO4CpGVjraQTymBJftuzZNCLOHy04VIjwv0ZcIRrYolok5TujNzNTXdfgLYzo25Ct
 nNziUYX15vs8Nr4pD0en3qm2z1IoUWGL/76HEkX452FUXBnDNLJAks7vjR2RMDzyWNnX
 60XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856448; x=1792461248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=za0jMbnrnW8qw7y3Qi/ufmHL6dFo4PBA+y8YbtdGl14=;
 b=dNMIxCJRr6WWN6zySBZO/u41EOajPOeHy6ieCqLYyod3z9KLRWvIA+Q1gX90iT1Z/p
 Fo2uCsFf2xHT+GDSocle7hQXrWL3qgdixFUEI7Q4/XqfUzCm41C71yy4tNwMCjA5+lGa
 fw7PV8GBkTNRRiPfqym+KReSgNESCwxisDLm3ZNCwBenwteUz7pTM8WYV7qbx2yamjoc
 rUhqaESP7OMTuuS0I6fv+H3yLoj9lkp9OhoayVqIvGPLQ1+x4+XADSCdFq05G5u/ubaN
 eh6AepNQ683rmdXpSA9dDDphBMTZpi2/gONPugTFPWu+biP6OwkXv5G4yh5I0dyz9zIA
 knRw==
X-Gm-Message-State: AFq9FYKCTsAO8o9LXwza+ziHSI4k9YmLfzENI46Owg4Rpk9//C/bjS6h
 tKdfr0b9eLHkL8pvH8CnnK2wJmoiFP4x4APAoBRAtqxxPTLIMY5dmmsgX5qS/YWj7BH1UIsJFOm
 mXgH7+P/SSvkq0Rwl3YUhRye6gb2oqmnassQJ/YC0aTAyrhBeVZ2X8U9sC2D+hlwpHM/Fja4=
X-Gm-Gg: AYBFou1lGqU11Ss4PJpZiKWeamxIORngVuIw18y4HDX9p6OjgGSkv3tkdSTQ2o833sN
 xZi7BZym+NC6nn57Pmsslr7qmXYEQmfUOc5cBaIFddAVxzOUH6Ymwv/c5Qc6zLKYHs5DbOWLvfD
 54kRFzfhj0T61FvW4lRddJNZyFJig0+N7E8r66DaMAahbfnHNo01ERmZxUC980AnQAEgdPGwrKO
 wvwQLamegrs2iMMzV97iBiUnSWWt0+rsHzVbnYeempY+R2UP9Z//j7bP3CuDCn4/G49J/qhUnay
 iNrZXtGe3JJmbcKUiWGJ6Zl4xDePmOhEWaOYW8PxBeTOBvFXGWg7t/Zw7Doapd2RxNjH8Sx9hWg
 mz0Ai6UsGJgdS2NX+AATUYIza3AW04VY9usJLlC32wcRl/RNwQgZO9NmRwCgPQ3RN9nHYO4/nEd
 t/WrWEjV3j4/AIS8Ybef5wuQ/kiQE=
X-Received: by 2002:a05:7301:2a8:b0:358:eccb:af79 with SMTP id
 5a478bee46e88-358eccbc807mr10986090eec.34.1791856447519; 
 Mon, 12 Oct 2026 18:54:07 -0700 (PDT)
X-Received: by 2002:a05:7301:2a8:b0:358:eccb:af79 with SMTP id
 5a478bee46e88-358eccbc807mr10986049eec.34.1791856446777; 
 Mon, 12 Oct 2026 18:54:06 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:54:06 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:17 +0530
Subject: [PATCH v7 8/8] doc: qualcomm: Add snagboot mode documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=9398;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=evPk1Kjk2gFKr8bfov6Z08u4cfAVlPTcPeskJONMRhY=;
 b=AFBkLaDPl+DYsJeUGr/gLqqB5JdHvEP80gdJzaIqZo+a/LRK1GZ4Dwp6Vk0S2rNXCIIHRVqV9
 d36j3EouW67CWfolW/mZpQqDVmJTBRMqnONwcC9eSL2neAU/pC7Do16
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfXyhUr04YoGfsr
 biQsLny8kU1PsqQAR/vCL4an/XPmn8pvxblyERYs0Aja1hKcPBACoqRqsH6cSy3cKPhBJ4H8CH2
 sq9r+Hk89+5uFLvrUb7ghhf2WdG3YbH3+UGVRpsed1x6Yc4t69C2B/evugEPlWVeH7KSsJzT0CB
 rImAVKl+r2U+8RJxgS+UjI1U5kM4ymmSlXN7DQKLV43NFf4JFqeIQngwDIY9cYDj9GFjzOu5ltu
 QMjzVTd/Q1zHUQyOpgW3/ZR7IAJIJ3XJogngnWJv6KG5w8hM4sfdYdgBdiw4PDj6t94vrh7s1ys
 30SBckCECi/MbLTyPTeTG6Of4BUtSeGg+rEkKOxqG/4wWqakv17ghJ0cFPM/umzEp6m5oKNcaL1
 6LNk0enUrseS/TMIAabL8POjDieHS5+j0HTrrOpfiEYN3GjV/5wBubXc/OUpJibHNRnFLl9+mPz
 4EFXNqmF7/uCi3BMW7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX6EUpJ58FC0GO
 sZqHbA5s2TenKycXWWQ+4c0/6itvQPVoComEDCWv2ZeGEImpAPESBDwNST8/F6E/RGKSnEO6wRT
 caTURyJA6VbkTkzlek22kDAm2OUI4u4=
X-Proofpoint-ORIG-GUID: XgFrxmO8H29q6Fg2Xp9hOVl6lXUMSR1-
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acd8f41 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cSziVDP4AAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=OjHaD72EHvCEK3kTdW4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: XgFrxmO8H29q6Fg2Xp9hOVl6lXUMSR1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
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

Add documentation for snagboot mode support on Qualcomm platforms.
This covers build steps to compile U-Boot for Snagboot mode for
Lemans-EVK along with the architecture, execution flow, and Snagboot
enablement requirements.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Rebased on top of latest file

Changes in v5:
- Added build steps for U-Boot in Snagboot mode

Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |   1 +
 doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..b8bc37bb384 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,4 @@ Qualcomm
    rdp
    signing
    spl
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..0cbde61253d
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,224 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+=====================================
+
+Overview
+--------
+
+Snagboot is an open-source, scriptable flashing framework that provides
+an alternative to the proprietary Firehose protocol for device
+provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
+Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
+and execute bootloaders. However, instead of using the proprietary
+Firehose programmer, Snagboot loads U-Boot into DDR and uses the
+standard fastboot protocol for device flashing.
+
+The framework consists of three modular components:
+
+* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot into RAM
+* **snagflash**: Communicates with U-Boot over USB using fastboot to flash system images
+* **snagfactory**: Orchestrates parallel factory flashing tasks
+
+Why Snagboot?
+-------------
+
+* EDL + Firehose remains the default and supported factory provisioning flow
+* Customers are requesting support for Snagboot, an open, scriptable flashing framework,
+  as an alternative option
+* Snagboot reuses Qualcomm recovery primitives and standard flashing protocols,
+  minimizing platform disruption
+* Provides an open-source alternative to proprietary flashing tools
+
+Architecture
+------------
+
+Snagboot Execution Flow on Qualcomm SoCs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The snagboot execution flow consists of two main phases:
+
+**Phase 1 - snagrecover**:
+
+1. ROM code enters recovery mode (EDL)
+2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal memory
+3. XBL executes and initializes DDR
+4. Snagrecover downloads U-Boot into DDR
+5. Control transfers to U-Boot
+
+**Phase 2 - snagflash**:
+
+1. U-Boot runs in DDR and enters fastboot mode
+2. Snagflash communicates with U-Boot over USB using fastboot protocol
+3. System images are flashed to non-volatile memory (UFS, eMMC)
+
+Boot Environment Considerations
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In the snagboot execution flow, ROM code in recovery mode loads
+snagrecover, which downloads XBL to internal memory. XBL executes
+and initializes DDR, then snagrecover downloads U-Boot into DDR and
+transfers control to it. At this point, XBL has left the MMU enabled
+with its own page tables and has not initialized PSCI firmware or
+populated the Command DB. U-Boot must handle this non-standard boot
+environment to enter fastboot mode for device flashing.
+
+This is why several standard U-Boot features must be disabled in snagboot mode.
+
+Comparison with Traditional EDL+Firehose
+-----------------------------------------
+
+**Standard Device Provisioning Path Using EDL and Firehose**:
+
+* **Emergency Download Mode (EDL)**:
+
+  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootloader (PBL) in ROM
+  * Triggered via hardware strap, software command, or recovery from boot failure
+
+* **Sahara Protocol (Stage 1)**:
+
+  * Host PC uses Sahara protocol to communicate with the SoC's PBL
+  * Transfers Device programmer (Firehose) into RAM
+
+* **Firehose Protocol (Stage 2)**:
+
+  * Once the Firehose Programmer is running on the device, it establishes a Firehose
+    protocol session with the host
+  * Host sends XML-based commands to flash firmware images to specific partitions,
+    erase or read flash memory and manage partition tables
+  * Integrated into tools like QFIL and PCAT
+
+**Snagboot Alternative**:
+
+Instead of loading a proprietary Firehose programmer, Snagboot loads U-Boot into DDR
+and uses the standard, open-source fastboot protocol for flashing operations.
+
+Supported Platforms
+-------------------
+
+Currently supported platforms:
+
+* **Lemans-EVK **: Initial platform with snagboot support
+
+Additional platforms can be enabled by following the board enablement guide below.
+
+Board Enablement
+----------------
+
+To enable snagboot mode on a new platform, follow these steps:
+
+Using the Config Fragment
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A reusable config fragment is provided at ``configs/qcom-snagboot.config`` that contains
+all common snagboot settings. Include it in your platform-specific defconfig::
+
+    # Configuration for building U-Boot for snagboot/recovery mode
+    # on <Your Platform> boards.
+    #
+    # For normal production boot, use <platform>_defconfig instead.
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Platform-specific settings for <Your Platform>
+
+    # Address where U-Boot will be loaded
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000
+
+Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically selects:
+
+* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
+* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
+* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load address)
+* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted environment
+  storage, since a recovery mechanism should not load a potentially broken or
+  untrusted environment from the board
+
+It also enforces the following at the Kconfig level via ``depends on !X``, so these
+configs cannot be enabled together with snagboot mode:
+
+* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't initialize PSCI firmware)
+* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
+* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader context is not preserved
+  in snagboot mode
+* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
+
+``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY`` and
+``CONFIG_TEXT_BASE`` to be set to a non-zero value.
+
+You still need to set the following platform-specific values in your defconfig:
+
+* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (e.g., 19200000 for Lemans)
+* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e.g., 0x1c100000 for Lemans)
+* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your platform
+
+Example: Lemans-EVK
+^^^^^^^^^^^^^^^^^^^
+
+See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of a
+platform-specific snagboot defconfig.
+
+Building U-Boot for Snagboot
+-----------------------------
+
+Build Steps
+^^^^^^^^^^^
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
+the Lemans EVK platform::
+
+    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+    $ make O=.output qcom_lemans_snagboot_defconfig
+    $ make -j8 O=.output
+
+Expected result: the build completes without errors and ``u-boot.elf`` is
+available in the ``.output`` directory.
+
+Signing Prerequisites
+^^^^^^^^^^^^^^^^^^^^^
+
+* ``u-boot.elf`` (generated from build, located in ``.output/``)
+* ``swiv_build_utility.py`` — download from:
+  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swiv_build_utility.py
+* ``qtestsign`` — clone from ``msm8916-mainline/qtestsign``::
+
+    git clone https://github.com/msm8916-mainline/qtestsign
+
+Step 1: Generate SWIV ELF
+""""""""""""""""""""""""""
+
+Add the SWIV segment required for TZ-based signing::
+
+    python3 swiv_build_utility.py \
+     .output/u-boot-swiv.elf \
+     .output/u-boot.elf \
+     lemans
+
+Output::
+
+    .output/u-boot-swiv.elf
+
+Step 2: Sign Image Using Qtestsign
+""""""""""""""""""""""""""""""""""
+
+Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
+
+    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
+
+Output::
+
+    .output/u-boot.mbn -> Final Binary to be flashed
+
+References
+----------
+
+* Snagboot project: https://github.com/bootlin/snagboot
+* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+* Qualcomm EDL mode: See your platform's technical documentation

-- 
2.34.1

