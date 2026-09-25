Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE0BC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B68A7607EE;
	Fri, 25 Sep 2026 14:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oakjg1BpF68y; Fri, 25 Sep 2026 14:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D34360D95
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346398;
	b=E8OVAGeRcZkukkJL/7V4iBc5AKpk/x8g8VRNI9TZCjc5lCFyyb/NIwXTgT7D4LlD05D2
	 hitjoaCCXQ/USx8YVQSbShDEW/elxIFMZwZmnRlvzCjyoB2m6xq0Yyg0o/2loOINfJ0yL
	 /+Z5OUxtLAqVkxf4eQ2VQ55yld2V+AbwNyFxIS/soZb6O9AqGYH/TC7utO4EVBHN3ezHt
	 9SWC/bEemoGecnQi+ihlNLTFj+83doIY8DgfKbcszRPSBRZrWfRsj0sqLk/WKgMwbMgZU
	 WmtOOuhobHFz1yx4hjMpCviIlIbx5oV1mh1O2vP8lYwAx4GdX7FUKLxJX1/Ho83AB3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
	b=FZvkDnCy7ouWomaRSJ2/In25k2BY7HRDjsqrN9Rsq5SSQ/iquzR4kWTUpZNstyHKWBoM
	 9dL+an/FQvDgimDKQ8wJKjHf00DWQzHJfsl1SQjNgPnk766Si4D3Ootuew4Z0b0i693D1
	 c7XLfaAE9uFSHBrZ97/jIoHqU0jMKvO4+o/2zhA0+/CvLBs61uBvrn53feRQTW0QUe4AA
	 +zbV7V2JrRGsGwgDwAolKFTN3dBN45/TzhWJGrAkQMhHVsxqWgCWsHJwSfCmnu8WCTs9q
	 C8hy+3eWKuh6+tdhXE5MGLvPzd9vku8tQ8bYMuw31BakusKJTTlkTJfFsGMeBeKB2vA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OtLHvgbw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4OPXJGr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346398;
	bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BQ1X6LmvbZMOFo72IDR/AQdg2YTZ68RenSX6clFJPaGu89IhftjtRrr2bfdvESFc6
	 BsRasFu/ayw2x+aG7q6LuE+4vEWrNtFYpotGqMGpNi5WERY8q2LzoT4wNLTJEveFbH
	 pRaZllRwneRJq6hm22NN2tb19AUZNPcTCVrZFcB/eZn/18CDwSoQ09c2JnISlh4jTB
	 mVbKDFHYtOaISnC0m/zg9XF8CyCFZzRdeXuCg584s6//O53Zh3VGDpGh0bwTy2WXRn
	 zqAo4ab2v2Y3JoA4pi4i7ElJt5y+od1b0T05XuCJqbPqCX5w3fepiCyMs27WivuxJF
	 GUYe76P13IWcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D34360D95;
	Fri, 25 Sep 2026 14:26:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA89A355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC59260B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Ji8itadBDzx for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2BC34606E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343498;
 b=HG9ba35/z7iaLwUB5dEztm2sAdTEbuxG6RZnf27gCNwSjPydCkVyiZR55ea+i/oHNLhE
 noryakmNgk+WUXtil2cqBbQtbIjuUoScEQaZ6aE5tCjlGQ3o38VWVSocaGMlyd04IPfJ5
 n/D/a4kyrVF+qqlTLKSqKhLA5WJMjSEtMIvkra9STlsxTzd3A+LUPAdH4cE0uhLu3URgE
 RCBUZYgI3+fXrfkN1CTuz3988OwUb68YMgJa5HjYXcU9Z/+LkHqG5VXsUzu+tGl3vxNeL
 v5D/I5Q/ru/b3iaQrCEMaQ9qV46uFDeTSJw8CyjIDjUcCzSHC8AtU9tMR5ilT+rDHBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343498;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=XhgArPg9HOaYznbnb4+I6ODhtwJTrlZezTh7WIXGEtsr+PBiZzLSWIM+4OlyOTjpCLWg
 unZG5+NfCvLjKjZRnQBpMGQxE9mxeQvH+hWiyA31nwwTwZ1n2xMblwg5ppQV7Qrb7tqfd
 88aZ3k63yXXvqZanV31WGnxbCkGoopcnavfZ8XVIvqXk8785C+nuUQ6dj8txYkQgf0y0e
 HRx8aUYiLj8ztHj/FHik3B8DzOp9Mylofz4EIdnZHbj8QVy9sBs170uAAQ2Z2iD5O13w7
 powtZ2FuU2QqOiZ4zlOMeQPij61/RwsuoYtgNPspEQc3QCZ13sPQV1AUzoE//TC1nWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OtLHvgbw; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i4OPXJGr; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OtLHvgbw; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i4OPXJGr
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BC34606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDNowC1055791
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vkwzQMgC098
 HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=; b=OtLHvgbwJW982VavVyxt3XAPsMV
 cF8vQrEJ2yoAAJ3oYm8vwGGawpMVvWUTUjv3cItJ1PXWWGRxjXVULGweAouTncjV
 8mfT4yDm5TrvpmQBBBBQmGUgKLqE8ochh0AqUWzyFtKmUzfh0oz4sAWbtz7pWnue
 4ZzJpbGdUdtws36ClXzCQM7CABMUfE3KWM0M8bHjiFNs8XI2BPHAKi0hzu5axNAV
 g1TFaE34afrQ54g+48vIKYDG6GacIKdK+rHV4u9tnE8FnnFIQy2+H0nfE3Pjv+Ed
 qVMO+lKLpTcMmh0hCb07FX8D9dlvG8Ank5UkhgSDpuzWVf/MnptkkP7U8sg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7akup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1384427c3efso1225343c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343497; x=1790948297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=i4OPXJGr2L/XoiypbpLG23akNDQnzLjgBXiZKsma1NHysI6Im3EDIAI2S1e1iLbfXT
 xbe112gjVVeQYi3EioBi2vJfj7bD4bSeyvOXVpCFZnR2Eb2j/L714IHQbHcZ3eDKEmwb
 Czb3vQuMqcRYM+x65QMfe9Qmd0TFuXFeDJHmi4LnOTuwGFvUOhe7V7j9NWIiq6Y6kzqo
 Ih3yLNB5hoYO3oxq68uWnHp8gtw0O5mm2WhUm5b/MJxkHdPFmoY1nVYDbarKbqEDmgUf
 XT5jrtPvNm9LQQO5y1pGKrBQZfnxeiRo3FIq/oKMHNEEb72f+pbtLJacMvwKb76e6ZfT
 GVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343497; x=1790948297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=kZyVxtgKbb649mu9fBxkWC42aFWhhcZMgW9nyPOagJ5xRWxMd7Rsnl/psj68VWFk5d
 a6E1W3k2chKedVeeyAkrGm8IWQhHREMzuzM/rra4nfsfuPyTl8nozsHZkzAPfWYQiUV6
 8La6uxZO9b0qGY0rr9Rfi6Dc/fCTk4WIuJ4ezm+B91X/2n/PciXHmfLTO8mMd3I0EGAg
 W00/vcEW7tmxNscFR3qcubUuDqi/iVpx93wQklEv08qpzwRRK0CZMQq91t04D03QNgD3
 vDjT6CRrVmESYb0dPODHOCDp4gT6Xsk+5oDTESe/GI3jsQ7JZiV6wsqx9UNR0m1mvccr
 LtMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmPTZ0bosKAj89ffKlwZSXog488W9pGUFtPKMnGFR4xInCxPya+68V4Lf75RwxcszFyYL215s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhj47x5WnRdFlbI8U2kDDHmZf6NQn25IOqZuumtXer9nWuoPvY
 UbVjOQAOATNFK+6/idKvR1xOXRUpxvIxjXR+jLiKYmZtTbBDQDsbD4K5aJ9ZiuGqg4868rQiwiO
 UvIG00OuQ8Yawb8j469XP8RO4WFTeQueG1m4hVVr2zvslRjXoMk4px5e+HRSyKcBZg3UOiao=
X-Gm-Gg: AYBFou1teF/sIE0dATCPY255mR9TpwnZgOLcdVqiw2ggu4RNzrK0uMW4ctklRe0EASY
 YLqWhhxLPKg+dENrcZdTWcE5DGAeDryFJegk5OwHbVTc6+HMurDsUPk44ITvvJ4A/Fa/CHr0n5l
 1JRkybqUSVKUiel169NS1uSGdBTR9lUOm/BRX7Z2KKH0Zb9q/xP4Zbcb37lBZj6xbdBomhAm0iA
 rEh2IwHtcfBtaYfQmK0pekvNGr0yu4bEYJ0nCeSJGgd+WtLWb9lx5U+UUqd9qhyq2Hch1nEVO7C
 Sj2QdBdkNbRRPyUfILw2B9Jql+szMTLH6P6lDRPbvZ0yDmLqLcsU06RyDHwwrvHhXsFU7fO2PY0
 H6CPAGQ+MAGgq3RlH1xq2WKabDtTY/ZPXyf+AMT0Ho6+BDCw=
X-Received: by 2002:a05:7023:a5c:20b0:144:c123:4036 with SMTP id
 a92af1059eb24-146d077b67dmr217204c88.35.1790343496374; 
 Fri, 25 Sep 2026 06:38:16 -0700 (PDT)
X-Received: by 2002:a05:7023:a5c:20b0:144:c123:4036 with SMTP id
 a92af1059eb24-146d077b67dmr217172c88.35.1790343495704; 
 Fri, 25 Sep 2026 06:38:15 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:15 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 07/12] clk: qcom: enable Shikra QUP wrapper clocks
Date: Fri, 25 Sep 2026 06:38:01 -0700
Message-Id: <20260925133806.1403713-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aMNHogbd12yt1PZHronPUzlCDYnmhg3r
X-Proofpoint-ORIG-GUID: aMNHogbd12yt1PZHronPUzlCDYnmhg3r
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab67949 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX79X+iJBwjfnO
 xNcEaovs19AGxtqvlkQobP2cPlhIKD5p6dtcorRuoLWzjdKyL/D4ctgCTqtQEZP5QdNfkT2kEm+
 ondoWKg6eFmHu18/gn3yD1YdM86zf5TzDG/ZTlvnGaflaIVROaR9M28EnbW6o8YXlD/e833ca6q
 T1zkmrOzHvz0pXlemI6FicT5uOPZDP0ioMlAit9O/PU2xULNLLR6pMcABjt6RLu+UD69XZRe/4u
 nY9p+VJ87+FGOtnn5EhddIP2HR9N8yrzSFeOdP7yxle6988Iw3WL2K6Lsvh4Q4D13Ud0nazKBzy
 UAz23mUJxi7/iBqaOdWQQTQciTuZXVgsWq3w16ac/aHv5Vnv+P6b18rPIKRNgx1OYK7bZOwFC5x
 y3FxiBUi2sWttqqWJ0JWtA6d9bKRBU4DlwhAvDRs+yEiIIsMQFsGhu4fe9gHaOPvA76BDa0h6CW
 haVJwRuYnU+nKCmIGJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX6AjQfLUCmHa0
 MiO9QmRsA3Pbd9jNKdOa576CFDsmpQpsO59Uo85iZlxjzHH5eYzNDvs1vvh4RSMB8jiWbaVpCX6
 CXkXljRgSI4379mGu2ighRDxy5U0zDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 9c803e6c181..ab07613aa1e 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

