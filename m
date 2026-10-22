Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBD606A320
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pu4n6ZmT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pv30Tq98;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJRDFuS3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2034A40539;
	Thu, 22 Oct 2026 21:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DgsTocMQdYNr; Thu, 22 Oct 2026 21:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7636340A3A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704887;
	b=cLNHjZ8neUm2KRXkdf87XGdlIaJS3WSNndhnEhEo2feaFNFoft+kRz+mNyNJZaUJ63fr
	 9lVTaOh81q+2RMxTqqSyDNjyTs6pNC43+eJJB1HF9kuzMufHsgbXoVLqRyfEzeP5Krsy3
	 KIiH0HuOnN4JxTE5yh9Oydw5jxX4yXG9Kj3ewE+bJ8SsK8eh08fq6lgd5KryWA4asaPVO
	 BoFXN6/Z8gTWI386pPS/LrkaQPJAaHDgPNHeP+MfXeQMqtNYHFaaWw8c8OwkKkaYvevAL
	 4R8PxGtiHi0Ia+6BAs9Rg9KPl99ycQjKSGeXjo47m85lHWmlrX+a2Mo1jwsaKRYrn+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=;
	b=jBqbfZMysdojrp7Me/VRugAC9C74hNmzdnIADsjfN2mzsS6GIHLRTNrgvB535cOSnTfC
	 8zsGotVhT/cgooFJJparZsIx5cC7hmQ5WtRqsEvlxcIATZbOqZQeNbOuWFRxsvzERP5PE
	 USxga5FHOy1N6BJJsXchwcWJi3CZizSSGTumVjMs/opYmqku8zi41m6n/Nj88kwAKuFHi
	 7jHcnpVBhbY7tAJoQkwlRxvoLcfVVrK1UnVg19zyD3Wz0K+fmvj2D9zcl1l09GO6rXDWy
	 dcqaKSmWFGvm2ClHyIIVvg1I09tRKUyfMwS4gDwKMoQ7cBci0evZTdwsNpkCauv3PzA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704887;
	bh=U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pu4n6ZmTeSeyJ8KGn3puhGB7yK2uQ0jQW03JbHEhr8OIxGTOzX8+SWan8QFjd1RUU
	 DwJwZUhHyRN1WRwL76s1YFp2Yw7IrX/9hcA1UvExKUer77xxxvqKCVBmWU3cXmPfk/
	 dFOet3F9Emt+PPOQrVtfc9I2XPo2T9xUem7AET8gs5DTIJDWMlQZRNqLvHBvYUWdly
	 FOtp5MLn3QoXX2Ynj7prmiWsZXHiN1sCTBd9/UZOa8ywoqYyB63NFcyGdqbhBAsDGs
	 oMAMugCzCfDte9QwYdIEl3XDhbRAW9PXWKN9pyZ3J11TDQkZFWPv5xuVQS1LyoEHA1
	 So7U/53ooCWPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7636340A3A;
	Thu, 22 Oct 2026 21:34:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E4DD2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44B444040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X64D93cUItv9 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A8F9B401DE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704884;
 b=m4PKV4qzresn3kVevaY09ptGm6bTWhAjxxf9UGmhSutrQrLnWtA6reeocIOUZRPli1tE
 pOGyD8l4Ed3KuphTxNAdF/2RWDVRS+Y3ttbTh3+W3EF5vPJmnjIYzKKKdwPTyYvj8SwTj
 ttOLJEk3dtSRMswVrW8q5QrL5K+2wo+CO84rArCXDf0RXK5cGHs991lK3hO9/muy4hWWs
 C0QL9Xoc2PH7vHj2ojdTjQz2QECslnSUDDvg2q3i0N+IzzJgIIt6hj6P0jc/B3VwFC+zp
 DC789pYCQ9M8hSHQJAoa+dnODojtmhJfmqjyQ9Ji+ovgidZVjOiw/UeImEKr/OD42wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704884;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=;
 b=noA2SUbg7ZMfUWeVr9RVVOtAOOSsc4Jw9zvNzc+IrWUYfUQc0sk8x80YT+uRMpliyDK2
 KxenYMolC9MqApZ1M251/KuN59YxzJychZxNgUC4LKOVzXlTBdMzqEKqcqWYLu3Iza5Y1
 ULpwzR5ZJPaYppevmfs3OH3tgk1qum5QLil34n6XYVLpXbXSMl22VSwO+dnwxycsdSG25
 UDndrmdW8RzW8qKX9HRVrQF0mygd/YirK2MAsc5USS9myJjNbCo8MV6ZMRPHY/JOFfk2S
 BgUNnQ8hRgjACuIR2RMqG/LqavVj17pG/qgvfWYdiP0OPSKhxIBGINTfKFFMK86KFOQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Pv30Tq98; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fJRDFuS3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pv30Tq98; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fJRDFuS3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8F9B401DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHa431495580
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=; b=Pv30Tq98EA0ka01y
 WF20axbh7dWRv3WZLFWs3WHwpWIHFJStg9r9nty4MqyNAJRBydmWRIoKLgJZBdzS
 Jf1eAfJ9nKOJiXZEHl6rOYRVgDpsCX+p8fk9wbhK1Gw3neG+xrbGNo+7bMzT/TQ9
 L5Ow+lOctHxg/qheEe4bsOH9V43qHnckyM3WQ0/HzQ4iQoPAgvJ5Yyf2iTrNWVtS
 lCAtL9XHBAzUG/BQqZY/ae3L6Epd+uz2P3Ej2H+4TZcF+14bUoX+3SbPCu48PLU/
 Y41fGU4BAxfWbUs2cLFXy0oX/aojd4bygAoj3bbl+T/N3iQanNwy16m4r2LYBY9E
 s7ocQw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8mvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:43 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66cbfb7ec42so591827d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704882; x=1793309682;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=;
 b=fJRDFuS356dm7ZeH7ABDfHNt8VJbDMguwW2HFYJiG3EXJtXPylJf7NdnepK1kbDYWD
 kK3EAyKLxrGnCWdsirlyo2r7H6+5nQQSyqyIxPH1FbRm0D93ZN8J9MHpzJ1QtSiYS3n/
 NGA1cC3KJIBW3iGcFTn9GmuSLXZk1jcldDeL48PWfAWkTSyXliB9UxBfqlBWo1G4kazu
 Qow6FJbVFUdVwUP7j4dzAS8lTBQC5/b8bFry13ljKE4QyuSkdhdiQ710f/TuwmcimvDr
 Ab+8isSj3jmaBxbBMwMGZ2zx3jpng02Jq5qGGGXcxToZNciut5Kv3Np9N0st4Let8J5d
 rA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704882; x=1793309682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U9geVZ+JuZTRabIyAYgNrvVt2QmQjvCGy2J7xuc320o=;
 b=ZQKr+u4e/bSx17SY1bgDueWtQaGt4ywLmcvUqekW1MfUer1dSen9zx1exJC357cBxC
 5H8+qD5I1A1Wk2RF+EBwYktXV+d50As4a/PMwqC/S4w/2rwxdpJK/zXXBi4NOBCU5vQO
 +tu68YyZOPEZdQo2nlXtKQoMPZ89Wzv+j7UCBUM2EdTVdmwotkstLQHYM8MulnOgllqX
 OlrZoEPEJcoglxQopssiqW4qxglvSQbtoYFdAc7ycCEAufNVtSQeSiermH2rvy18fmgN
 SsnfVnfD9TwqVI6Y9qsZlKNzNRW43XJNsBE6Lx3lYsPUJmLIqSoyYYaiZ6oavAzg+Mp3
 t5Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDrQBCBukEBSe7Ni6e+0aG4NzhLQ6FPIa5mSpUHngIMbSJrAUWxTy025ixbvvrdQdIcXrZZ0s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI2Jy5mXWE+GJ7BQBcDnN1ayicnJoaUHoFcA+Q7cwYdyaGxZ7gx
 31ouqS0pttZ2WUcDUCrC+kQJ627ThMmokF25yk8xDxJ8xgIoEnZaaqw0CMrxkgnJ2k+oOQm3ZS/
 LRPF5RKJsjBiUYyqzTd3wX9x314wKN0aNpIFevNN5RC4pWC6DAF0Xh5p9sqwS5g2t1v9BNxM=
X-Gm-Gg: AYBFou3zY1pEOgCXMdkIJmOePZSyStjXwKDT9zWpL57fvsBjhQyBlxVwx4HJothILus
 VGJl7+4PXRHiSUK22czCeKsHcDRp2tqHjYhgpnYXh13+TSmx7RFH8+AK1KxYPaafqBZMbv/BjVY
 lJYWSNprIDlO4rpsUOHchod7IUFegbxE2XOcuIlpFa8Ooossq68muT4MEnXl0Rx3Bvkyv0IcfoM
 j4r04SWL8FJ/N9ODqLiRXJB27ubIz1ESRtaFdmaa/bmWRADEsYDxbt0Ktu4r/ehm3d2+Pl0S+aY
 VE7nP47Ic5eKB4StX4D6ApibPd0Amz/IBh3TN4Dvreqxp0JURUnwJ/FWDNc3FcLIHS5tSDNaEG9
 iy+8Ky2yqQzy1HZncQCAZfLv3SGvMzGIh5vqqyDxDHluBIYYlamlD1nTIiDWV
X-Received: by 2002:a05:690e:1697:b0:679:aa90:d265 with SMTP id
 956f58d0204a3-67a359e6aa7mr194405d50.12.1792704882517; 
 Thu, 22 Oct 2026 14:34:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1697:b0:679:aa90:d265 with SMTP id
 956f58d0204a3-67a359e6aa7mr194383d50.12.1792704882093; 
 Thu, 22 Oct 2026 14:34:42 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a34032cb3sm343846d50.17.2026.10.22.14.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:41 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 8/8] phy: qcom: snps-eusb2: add Nord compatible
Date: Thu, 22 Oct 2026 17:34:38 -0400
Message-ID: <20261022213438.766021-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-9-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-9-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kcxeawJdySvcMu5G40DRGpCf-4tvncIG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX0P6cOti+H2ra
 sZejfTl4T0tPp+Uxrji/k61E7hILAm1W6YWU0g85wsk/bNR0lFDlARayHOn3yIqzNj3TZyTZ7Tj
 VtH/Yih41CVTcnLDwBcMu/66YJrcHos=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada8173 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=eIl7uMTqnB-rSxafHmQA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX7EG/OMe+5pRI
 1Ay3MUgUXZdqFJalJRjyZMsxIQ+4oeup6v2QUvSpkXt9tQCZ5IpznLqhxNQgC9cKra3fvTdyLsk
 +2yFKoEqZZQLH7f2tLWoQDKkJjTfDqDvDYGRmMqQbc6uAKWIbZTpjRZqHZMfbEQxlAUkZ+fEbGE
 ZAf8Xm2HpbPCG2t4TLDCjVNzNfq05E/UWXzwo6N8EVPg66wcjOI7yeL0Xo350vxww1wTvJShmd0
 FAYaRAJIzx8o7bp9KvmIlqiqvKDsDMgPlPpxV0iJ0OF8t7Y9hN2a4ha5+BgPY8AgXHz705iJcly
 D4l93YkZzSzf/lgwLAxTiUOGex/7HywnTAmZna8/iyvRb5K96tRqhOVK8RnvwNQlYz1sz6oZ6B1
 iN7rIMmhTmK7HZVpCYDCDzSWe7x4mWRjZ0RkuEcEfpMu8tgZ2vlz4WhAOifdnwVqlwpeJLW00MA
 rvrqUyyTgsVf7qB5ZAA==
X-Proofpoint-ORIG-GUID: kcxeawJdySvcMu5G40DRGpCf-4tvncIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220086
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
[...]
> +		.compatible = "qcom,nord-snps-eusb2-phy",

Not in the binding, and the sm8550 fallback already matches. Drop this.
