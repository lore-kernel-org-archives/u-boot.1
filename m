Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89797CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA02660C2C;
	Wed,  7 Oct 2026 18:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2IxqpTyP_wB; Wed,  7 Oct 2026 18:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 890F860BDC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396881;
	b=f7oTaQmEo/B9V2itDlkCmu2/XUJFCSQ/IRd6l2FPHvYuFahT1pf1PCmq6c/uLizewbxk
	 BPnIW1eLZ0VqfDdQNs5nWk+9EKkCIZpSN6hRH+Qs8PjC+w9JLu4DfgZEfjQHKgS16/MsV
	 CAiufNMdrdbgNxe1Py/LGSiLJtMwfUUbsx2Vhxz1OL7XZ1pLrXBB5Wlie3yiQpeBEeynX
	 m6+jVfbGdhnQqDp8i2h6OvVxBLVJEeh4JRzwVDb09RdV+fHEFxTkv55N7JvX/KBh9gRVe
	 Wh5pLlRs2ltTqho2jzkMnEtVEHwZsE+A/uSoqU++Y/DasAG4iHOxbIeST4lChpJy4Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lh82zvfNpYnhP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=;
	b=a96B3z2xullPqchsj/1kB+E/XbiE2/vG5nYd4xvu6wjsAreV6PYEIl1rkD91K/a6+pjn
	 JmQ9pFlwJJLUTy7kETeQlQaeuQzcXkRXGlUI6B40SbRhzC+bicS5B+20twnNUuGEdqqDs
	 NGcDZ8y4qg9fki2qLqhygW2zWamUibiXGtJw88kf/1tle/+nGZvkSe8MpvlIOEjqCopHy
	 ai4e03hRntxxfgewZK0CmZjDZKYcYmXXUdMxAwO6ZRzM4u65TKjh2z9FDK58g9JH2lmCV
	 Sqvod6B3W+S4IALT6AXshooQa6ZfHRenDlOR8MO2XioOA8b5znbanB3BvJ/oMjaOqQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396881;
	bh=lh82zvfNpYnhP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJI5auVCm+JAiri58WWKxcMJsm0Q5tgXQVKDaIIpc6X4hCR0d+5izQCn9yq9VnAIG
	 alOGnjEml2u7aNpBynoVlAzBfI3w0QRg5wxnD5GJQobGD8v9dQA56hp9rXX/FehRIy
	 9TZH+o6adbKry4ReZWghiQMKRR/qS8sds4hYlU7q6kCwXWbhcmQp36GJeSIUsCQs5L
	 hvSFjgA3yAt7YgJR3FXuUW4FejK3HmjDUDUNpiG8LhsQIVh3VUsJWPA8kM9BN1DjBw
	 ditUAqlNayb432VzasKZdusPC8NQ0iiEV04hlpr7CpXf/a2cqkw1zVnykr9h9cPgiq
	 Nm5pJ3IxfJjww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 890F860BDC;
	Wed,  7 Oct 2026 18:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51DD922B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E8D084B68
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmEXthq_7x5d for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6532084B6B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394967;
 b=UrybgvecfXB/EcTzo44vrcTs0qm4kARB3ADNw8DU/qa0HbnkxiY55vwbNgiIPGamSZ/r
 cZZwPfMaEwaGVqcIJqr+I8U6vq8AttUWpPiJa3c6er18Veaav9PDoww5o/ADQhsWvnhn8
 yRpFgcmFo40i2AAIyhC4eJF0U8fbLfqVwKM1GU7vH6DQ6OyPBxJ+LUq4E+Qt3zMDFndRy
 EtMkzmqEuUVMx34x5HsjU4gFoMWbNtWgb5ch/n+YRLX1k884BjfGvNP6/0ahnUvdOZKYQ
 fqjGsWTXZ4DmE+Fw7jrDUIgYGOVZ2nATxX13cvJECv1DkcW1Ib96iCklnJ2fPggr46g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394967;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=lh82zvfNpYnhP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=;
 b=iM9iGOnu5ZPwHF3+7Mvz6vNmJQ3fudRxSgM6gcER+iBarYSYYgwQjHkzKCiGsr3Fez7O
 851Cae9ai2sKYybMLoZ8gCy8uv9uYUVCILH7UMQ7K/6GxebdOUTtKw1+SojRzk2nhwtDU
 DeB/mzpejH6kM+fQnykCwY7Au619JYZYtsVQCuGudzWlZi0ve1qlke6HZOef9wPNXuzGv
 0dvB5IEmkD2llyjkET0rel9+6y2eQP+Mq3QiooqeyDv6oYJpc41IOHwIh8aEKPUR7Yn9/
 lK2P6hh6iyd5iIuxySO4T+5m7W/+rXcGppZQWSep89DuH/fyFYK7ChVIO0XV/98xtBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Xl5OtUFt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AD7Ul9vk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xl5OtUFt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AD7Ul9vk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6532084B6B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtS5D1060038
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lh82zvfNpYn
 hP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=; b=Xl5OtUFtiOqByaach+VvfuyY9JB
 T2vSP7OTSP8HbV3rinsmKlu76PH8E4AU2EWeLD7WfFMrwODjUreNRjteXVVuaxKy
 haWvLyrc2TTWObWulilGOOtaBmC9h57T9MpT2xk064l/p9NfYU1W6eAe2HFnoaZC
 q3ASMqj1xRkupMnLsxFMvndS2rvU3MQrj6sPKW5YdBxv/AsYIJHplGCiRzswhR0o
 TVqzYouaE+t+GePFt4PEhL5IR1tbFvbODaLY353vXq6SZQ1sf7EknQfWx6ljqQ8D
 2rh0ulhcKi8ory2UIxfYrVZ+5mylqQSw9mqXZqpbvoBYgWwH+nbQtInRzBg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5ar24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3515d2fc5ebso3775707eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394966; x=1791999766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lh82zvfNpYnhP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=;
 b=AD7Ul9vkL8wAy7rlZ4fotJIH/7BqFhAt+Y0WYk5poCVbWcM23V0m7XdC0Eto0At0jg
 kPkvw2NTHkJL+VzWYPDreMuU0+XJFFdNw8AicnpdQ+EwWBY98mdSCmF8WXK2laos7bcn
 buLEZDXYA8gUt3Li/ZTBRhNAeqibXcRkTt81Uv/eE1q5/CVB5Z4tKHJk1QAgpYPHz/d2
 an/palvZJtNpbVEEnlrFXlipjUyBQeqQlf1tK/e3utwaenu4n/Fd8NHBFLyDEOhLsFSp
 5yTRKwP5UTfSMS/0zGd0Bu3xG9W4ieLXwSCx/gwgCNdSUlPfFOONDNZDorLa+EhJlKSW
 avnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394966; x=1791999766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lh82zvfNpYnhP15mzTqGX9Wq/KKnAwbVx+cfITlsz98=;
 b=XIVYAfMk/m+L88ejt22XWuupzGJNb5AbOeuMrLIQFKFBChqOZ/N88LEMEYVku+UDIW
 JBnpeWC8EQg8B2o+g2iE6eU81jOYMAWWsTdasaHP4BV+xBA0GzMpO87bqwuchfBWRkgc
 Cft/EOVheJHCJtDc2F4/6ri20CMcsCSUYaGz58+qnVp+K54DRLntYnpempPKZPbKWNhm
 eoLZ06M5EOsIaoePIa0AFNFUCaS25terlTX1uIh/M2BpbG+SWpZhqllF7L7OT4GVWGEh
 sbsLUhl7yXe3hmge1Z8xslfm0X9N8tT1tpHCuPdUmqdfrv05z03u6cIdErGeJSCHl2kI
 Dbsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXObBLDb3WoAN+jMZE/2eeGWWe4ZAqfi5nze2w7IMvheNIEn//5Leb9QjVZKGTivs2Ftlevp0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mHjI7/g1GZeM8IqU07IyJelsBE4MZEnJSdmhFPB8QCBYszYxwq
 OJM4YDULzqFWwW3xwX5GCU4unpae607r4TkPfeDOwcldyCFbs2nqhusRkF2UJjaw1yl2cWu3y3Y
 Dga1ugz4tf9Fv5TbiJYBc4LpSW11OuLbqyvTFfLl+ZXWRI0LYM/09+gwLhz04twGfqA0Mk+k=
X-Gm-Gg: AYBFou39SheybTVwSV5GjWNZ1fTTnfOH+pJk8TYlZPvjzYSFqAgqLKdjMTtS+diymSb
 AnEUJiirw8vjCV8syUidAft1C6Ppxw3aJpQNExlkO0xLXi1sEAGm5qMGukrKzBL18kXut8/iKPa
 Vxo9sJ+ZOqvX9+P5+QD6UFslcKLl/1WeO5he/rf8slxBNr6vcH9DybwQfJGkGWrRsvstYor8Pu9
 iZ8YZ/3hkyDiL47DDqsUBjRbzM/mzawAthKajAePCi+arA7tLflveYQHdFQQ46hN7pRIF+gOEPh
 NdpAFcMpPMdJ4siXuIt+tpvEky2G7KZVZUe3O7RHVfq6czr+syMVJiEN70F67NMHraVb+2K67GT
 9w2R46FZE0AvnfibYHIU3yOUbIuLYnZPRFB29Y+WJ1m4EJ5s/aKdTZMM5qYdMHgXk+S3JPpe6eZ
 1AlcwE9LpDvxhn0D7mYBa+4GjigvoqiP+2Lg==
X-Received: by 2002:a05:701b:4504:10b0:143:3617:c5ae with SMTP id
 a92af1059eb24-161fed499eemr3344726c88.2.1791394965778; 
 Wed, 07 Oct 2026 10:42:45 -0700 (PDT)
X-Received: by 2002:a05:701b:4504:10b0:143:3617:c5ae with SMTP id
 a92af1059eb24-161fed499eemr3344670c88.2.1791394965100; 
 Wed, 07 Oct 2026 10:42:45 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:44 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 4/5] clk: qcom: ipq5424: Add GENI I2C clocks
Date: Wed,  7 Oct 2026 23:11:50 +0530
Message-Id: <20261007174151.2590649-5-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX8xYH5R0xe1+7
 F77Q7wV3/CC14OqmDf2En6yzayQRC2ygZ2Z9kuCjQhnHs03MSuUXuEYUr+u+uYnWqRhnle5vJi6
 F6gnisg5O0cgXW27jvu/TbaJ0se8/As=
X-Proofpoint-GUID: DKr1H_TTAipqShjYxb3rFMjY5RpEZBb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfXzhW8S0dLjTXs
 YDRKJbK765LiyuRw3+ykgnX4g2JWZFF3HV/JNMeVxZwuaJJZ0T7rNBP0ECDeTVhsm0cGEASD8kJ
 7RAGzyCQw2nJmDxYOGoNh/ROQAAXZybA4bjIdXKyW9/krNosV/QByLbBpUqN0E92BgJ4/nhUO+f
 AWQe0NyKWQl3xAh1sgwSSvQuoZNBormyv0+FXkBwyaa8z+RizajgQv9DbNeXqudmia3vgsRw3MZ
 gVOSnZae6SDaz4F93GgIo9cOZjWS1rlpSIDo2iYwc5bXsYL2KX9fnKSpvY6FECg4qtQinmcKt17
 5Jdro6S2w83vmG686I5UVBHKMdsMjcQYURO8kVOmr1mHQ/Th6Cwmn3i4noJ6uSKLn5bAGLQyW+M
 6LCFgFGvczH8c9jWSd0EHdfTCMorF04ZYI8c5Vf0+EpsTANxh8uVjX9LGi9yRjBrmzTNSniy3nk
 IyUuGbKR3k1e2w76KPA==
X-Proofpoint-ORIG-GUID: DKr1H_TTAipqShjYxb3rFMjY5RpEZBb1
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac68496 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EsmRbeE4kkRlVwRWTiIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070070
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

Add clock configuration for GENI I2C and support 32 MHz clock rates.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-ipq5424.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/clock-ipq5424.c
index 40823a30ead..470b7eef41c 100644
--- a/drivers/clk/qcom/clock-ipq5424.c
+++ b/drivers/clk/qcom/clock-ipq5424.c
@@ -19,12 +19,35 @@
 #include "clock-qcom.h"
 
 #define GCC_IM_SLEEP_CBCR	0x1834020u
+#define GCC_QUPV3_I2C0_CMD_RCGR		0x02018
+#define GCC_QUPV3_I2C0_DIV_CDIVR	0x02020
+#define GCC_QUPV3_I2C1_CMD_RCGR		0x03018
+#define GCC_QUPV3_I2C1_DIV_CDIVR	0x03020
+
+#define IPQ5424_I2C_RCG_DIV		24
+#define IPQ5424_I2C_CDIV		1
 
 static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
+	case GCC_QUPV3_I2C0_CLK:
+		clk_rcg_set_rate_with_post_div(priv->base,
+					       GCC_QUPV3_I2C0_CMD_RCGR,
+					       GCC_QUPV3_I2C0_DIV_CDIVR,
+					       IPQ5424_I2C_RCG_DIV,
+					       IPQ5424_I2C_CDIV,
+					       CFG_CLK_SRC_GPLL0);
+		return rate;
+	case GCC_QUPV3_I2C1_CLK:
+		clk_rcg_set_rate_with_post_div(priv->base,
+					       GCC_QUPV3_I2C1_CMD_RCGR,
+					       GCC_QUPV3_I2C1_DIV_CDIVR,
+					       IPQ5424_I2C_RCG_DIV,
+					       IPQ5424_I2C_CDIV,
+					       CFG_CLK_SRC_GPLL0);
+		return rate;
 	case GCC_QUPV3_UART1_CLK:
 		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
 				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
@@ -38,6 +61,8 @@ static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk ipq5424_clks[] = {
+	GATE_CLK(GCC_QUPV3_I2C0_CLK, 0x02024, BIT(0)),
+	GATE_CLK(GCC_QUPV3_I2C1_CLK, 0x03024, BIT(0)),
 	GATE_CLK(GCC_QUPV3_UART1_CLK, 0x302c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
-- 
2.34.1

