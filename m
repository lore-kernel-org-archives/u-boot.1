Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B9CA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C31DB811BD;
	Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyl2D5OytJbZ; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6547F811EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452967;
	b=Fx9B5v/7/132qTvz4Z9HcxoVO9g2gaEuLeq8RuktRXmYo6UBhwnvZJTnGXo42zvPpQwh
	 tKAL3pz3uW/Ns8CyQgzRFjEUzwNETa5MbBcq/L3bYiu7yARKa8cppDn4RBVbsI/DxImTJ
	 RxBmPi4ewu3bAw6iqtJA27UJgZUJkHj7BTZ3sBRFjc/zslpx8ibxLUccPLFzd9ToHJFtg
	 wq0xdhLrAsXhLwE/p+X3IE4Q/OvQTEb5b+rIqrGxVNAFArCyoo/26P+g0MCl8OELPrX9+
	 xidNiosJjL5cZ2qcwwW3FD7YIkugKKSyDMt4U4lm1p8aMPKYq2mUe4R/761pxObDwjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	b=T4KTCNetkfx/7Z61KzTrTiRK1SMJbwuJU6SHglr6IufYYvmh2Qtj3IUoJag+VWQfjhDE
	 mBV4AsJ7Yw+XnNAIKGAIQORzY9YLtWWxBLOCHgfWi8g04yvAzYu/jHJ2Nm4Cnuxu6IEmw
	 9npOjr3+9O7jTMwguhTPyZLOIqEYQPdWmru8J3u+ZQpogqtIpniRQLttZmRjvFlaab2+f
	 f594dYB8wf1Iz9WV6D0CaGht865o+KYSTQ1BqpQhHjY1lpBIn825Cc2oERjodc2E7bGZf
	 rZg/HbYEd6MwNWVNGHEB8kq787g0bvaUM5qKIRDLSSIoec9ERw2wpxyALteN4Og8Mpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452967;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1OCjAbliPfZ7Ja8mPSCNgpT/te1nnr10CA0b9WcA9rY/F1D4Tzsdd6lDIbnk+ykK
	 cbPZivl2K/FqQFYbNACZyP8lYIVTSKj879CzQLxUhbHq2bU6MNf+fRpniY+8Ff0bRZ
	 S4ne4mHCEelv+s/WH+9wZlfDzkU8KOQm91lfqc0WIiDC64hf9BjnbLi/pBqMmWAJZT
	 5wslS8RRuISzwLeO11SizynZUzqWqRa6kZhW/9jLyrZ72EVTbPq8hnsuEUXRroF/GB
	 GoBbKwKH5k2OmVXbdZ3aojccOoJiscBpD5iFm4Wv6fSSy4M2H5t669PkhvoGmFhUPg
	 /7i1jIbjwzmXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6547F811EC;
	Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A66072AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C27740A06
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNYjm-9kjdcD for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E2CB040944
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452965;
 b=aHtfhPpIXOiD/baEqTY8FiDSTxTRtrG7ON1l4bychqr1tzJRn7yGTQbHI6TG/4EidjMB
 47lS3xOkXAFCYBOFlFALUC7oU3dh+R/wAavm/Eb70xb1Vu3cWDQeV4gTv3rrDcZJmTAZY
 +SrWuDeKdCNJHdGBP2ow4OzaaBfawdj6pR4bwds5Zj6lB3On/Ox9Yanf6+067qLvY0S2j
 R6JT9sbUr/CTQw8dNIRpmuBd8M6bF5MAxp2JSgwYd5n6+4USN9vJ7y3hyJ4IEDQ2IJmZx
 FO/lfGW/GGrg8qHi5fqKgFqpRLOVpDX754xlZRvitTUtVlgcEHx8lXhCMd2wDfbveDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452965;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=bOH63X3wfgmnbf17mR4drI3oG7djSuyF7rBqjQiDF/h0nzXXE/8Ph92sSwzjnsPMQZwh
 VYy1kywqfsEfT1gLLcYiAgyDIqrC5xnSQQTWZxgGjv9Yk6k4PaGNZ5PhN1yb3mEHafSfM
 3dahLqxsa+M9iYDlTDPZG5ZdrUvkB78sqQQUqq0HJJTnZLbdM89IJiwBK1lxzC8F/W/8S
 1jErw2scCLMPPH60WRYODF1WCM9qDan1ajNjvp81zCNkzHfpoRa5cvoARejCJUxtbJOH+
 21mbAoIlRgS4MgA0oJz35bRzmqWqBVRrovJ/Pz0gE8jhtiNMywuKq6MpRa6fB6YmnOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="kus/Rznx"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R496cbSZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kus/Rznx; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R496cbSZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2CB040944
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987Kcpi730884
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dw0YQ9AdyH0
 093F4CAXrS1D6HzWf0L9XIPmFuwc7410=; b=kus/RznxlsAuYdIPwqS56hNXeCJ
 bSWHTwi9jxs+VDxHgzd4baTRl5q1WoQ2vJhjZ3kZt0dxo10vAkXGfZsDebOhh0jd
 UP4EsqOsBdnCk9Wj/XYha/iMDo0V/TgW3zUOsgDWde1CTwDudYqe1uDUfXpg5G9f
 Q13iICiBiEIamz+ANlFDoN/FV0eVqei41qegvi+WIhEu58qqx3OVv4X5xCe7iPBm
 NJJ3B5t1fazS22fRZ8lmVOHXxDC9UYyav2Dgrwsq40S8oEgYoNZcOXWFFW/yH04C
 EmXEAHrS87la7gwAski14jUDuaM+H5DWVXHi2YnE4n9TAu6uVTidvDgUjhg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe327qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so10385832eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452963; x=1792057763;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=R496cbSZBwTUNiJj3jKtW28V8I3LosAN3dZKomd9FKWdmoak9OWG13Q3t0WC3QcyN5
 3OGHV5kPGJNdM9SgSWHZj9rNi8jxgGbvWMIE7ervztGSkmWSIxbrtCjsNu5hmDlTEsHN
 a1HOX2l/zEXLOdrI9sqfQF+Afe3CvQPF1j+35iMbf8NmFI9BIqHcCit+QAiXdpOY27jR
 DIijhrtVWIgPfp02syWxkF7BnoXAlgMjVRD/Znq/4eOPJMiA+BU8PN9DgD8mXDjDj4mc
 iNgjKUgSHyLwOQyV6tU96V5fgVBrxCVc7DjRgCk7z65zhVW6oxeOXLay4SDxcVwyQKHL
 jawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452963; x=1792057763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=R4Uk4de6uGAcu2xkuqOfY708rbJXSGj2cSC22E2NdVZQmDNWECk2K6ghnTgozly+eF
 DTTEWMLzfrVFtUrZWYvI+JereAFIG4zldpTDuxJOerf2+edYQKom3sLCmxHFD0HDQCup
 SABI+hRhpa427tEo/VqhzV0zNx4w6sZybt/qrketSx+7KIaCTkuQvfI+FfeNO8T8rA2z
 PYNEbBsKuEqJyMSE3Em/fENMbvpYFnYvChG3bOXXyT8RXFeT8z3KuOKqUku0Vh765kbK
 5LyYpZJTLwhQHBQYLWQawb7M2aA++KXGTf+s5SQYFcXyKRsZRCNNMP8w4m18yoaAn0sl
 vO1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOFCrJPJ9YJhUt627aiSrCFa0TMf5diMqU5CvKxW/JCl5Wnb4O+yXgTHEZDAVDWW0efo5W+VE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBng57nkRKIGBZToqCOvUdf+Eq61r2iMSr/Zw0U36PJ7l7t3XU
 qOvmo3eSNGBjiDu27NIZCOPspl/Hvi1HJNO/6o6X8iah3V4jWq1NqsVM+5YIAjhdJkOj9CuM8jc
 77lKjqlV1R+7NvvDpl7K/MLmG6BCIXj28jZ8axhikA5uGZWYspzdYrSxW1NdMz1DgB75i+IU=
X-Gm-Gg: AYBFou1QQmaCs42MLYi4v2C0BiUqS7uKkNBUnp+ShjI3R6DjRB+C+uMKgcCnmqPha5o
 NIvjcaBJeWbI3ys6oVJFtPDECERdTXh/+KiEibe33ioLuHcrivSgYAUo6OXd7FriSxHRc+r2LsT
 JveBtEHJKGumJTVG9yTDLknLR/RM4Oksc1sjfrFyTtPryqbhfjrkNAdDChd8uNdqrhKkUsVQ2TW
 FczMsQ28Sr99AVxrleplbQDBwGXqlNEHkmMmoqvZK32onmKFVmMSGwRW0RMBtWWqTWpuCs82kR4
 VfQq4cZPuy72Pi4+GvoX6QrfYqzbetx/q5W+5X8rjd/nOL/gJWsAJnFWlu6ENhjN24K/6uAl/bF
 I45KqEw9Bp/bplLpYnOu8iTJJbIUMRfZcmCDcUOcMnjspz6g=
X-Received: by 2002:a05:701b:42c7:10b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-16205514412mr5919072c88.16.1791452963039; 
 Thu, 08 Oct 2026 02:49:23 -0700 (PDT)
X-Received: by 2002:a05:701b:42c7:10b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-16205514412mr5919050c88.16.1791452962521; 
 Thu, 08 Oct 2026 02:49:22 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:21 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 02/13] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Thu,  8 Oct 2026 02:49:01 -0700
Message-Id: <20261008094912.419090-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5/qc1mS2acK7
 4FJHoX4fTFlyjoT1YoVS8LRwTlVQ5jlCOHNe5593l9taAnh/GFah5+IExQGXfwkSbl+VqThZ5Ym
 JCwDXxs/h0SrlQjGa/+augulV5PS9vDSGU6l1i6wzp/58wi7xLbFY3/5EBKxot7uwxHFnJ4NkeO
 IrMUUjTaZVD4vxF3yJ179l5IQnHEcR1hoNGgzyyw4MZebxBFm9CPXWE73FE6vuC+x6wFmE7BmI0
 CwvNOcp8pC1w1eUAzh4j9fD/wDtFnL9BkqDn6ohxU0ZVcjALxwhUTac4wK4sfV9hcb3FhsKnP/d
 N10HEqVw1VmljESUBrf58WMVeVMQKx6RuG4l1JZYsnk3Dh6ER7VLfYdGd7ADY9pd//C8gaaHQOE
 XLR3nszm6lfZoc0ObHE0PnDWss3TAUmqfPzOSbHzuFbqlW/aa8VnnYMQvkVeZfFDwMMf/v/nJR/
 7tiz59nHju+BgBb9ugg==
X-Proofpoint-ORIG-GUID: 42wgoXeuxy1wlsSDglzcgzh6NnpCCkTj
X-Proofpoint-GUID: 42wgoXeuxy1wlsSDglzcgzh6NnpCCkTj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX/mlZrTUcXIRl
 NxLk+g5x6irhIop8GrXx96LnJ009qTb4ti0PDOUCos7pqGJDGdhmUc5dVu5rylV326iHfkBvoxU
 Vk47bblSFruxcpBIHME3myFevqoLr8w=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac76723 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=6lju1O6RD8AOoBC9Ya0A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index bb12e93853d..ac0103631ad 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -116,6 +116,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-- 
2.34.1

