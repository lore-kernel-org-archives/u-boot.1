Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7285CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F8FA60873;
	Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3mt4zkWSv7R; Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DFB3D6083F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452978;
	b=cSPL3o3YOtY/To2XubYZE2gHhLV/VKy9LxnzbEpUQ2HhPtEitOj+r2Ga/R/k9G2dW1jo
	 ylQg18wr/Svv40vzQGfbnpWzviI6U79UtFM1J5rN62/KK8pGPTlrlO0mJe3oi32moIyuF
	 hZ9w35vYWBcaFMa3oLdpkA0dPowP7ST5WE4pznL4mB1Wjqf0ifMb7kg8gCy6lVLqJ0IMj
	 XF8zSFidELEwGkNnFgDToRwragJWtqYkOnt3PVXSHSGw4lzmFtzx5X8h3CLL/lz4045i+
	 J0aI3HGaAayptuJk1EtmMvAW+p7CqSNgfbScWIz0DxFNjQUyY0C7pixljD4H92E8iWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452978;
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
	bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
	b=nYXjtMSGtEqMYcQJRgEzaDH893v8hJpKj7Deui8zqgwLoqGYdVWWxXxLb9YVI7aa+Yck
	 5vGdonv6J72iOfa5YCjE4hGiCr9VnniQioHjFitAM7zcEWOx25gaCjCJus/6AJdWHPJfZ
	 /y3h3YQfmYB+6rAYOrZpexXf7erOuXZUNdFhKPuQ14CBg4cQ7HdX+eDWVmc8zGCzISpzf
	 oJ1CzMnNfTprYT2GmKVHzU/xshSUURibx8owLdicU++60swN2+lPXNVWx4VOgolyRfn22
	 aWBWCGqtmAEJHsPIOvYumAFzO5/rt/Bb+7GKarsHGyWl3rXFecruQeh1Bq5CkcZqz4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452978;
	bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C5FBsTHRtVFoXVJUWaaCy16eCHQ7cxgvmAfUnrF8uq4H8ht6hav9ai/MxpRY/GuNT
	 ye21FPkuGsWNi9uzGiHex7Fk9Y7yCFuyotrIrWFnpciDNqmIzWxTQ2YEn78V3jSWQY
	 4R5wDVJ0gKO5B16wICgE/R2/rT8ugPCv3x6t3Q1FyCes34uY9jsxx0+UMaalATnoQr
	 rEx6g0Jb/7Jhm1gkZtLXB+vRDyiyI6PCOwF70AVRRE9DqoAOZ0FG8p5sIIwZKCpZGl
	 HDGfSY30IqPbbVVoGts8SuHV9Cvha2XGSfuzviI+7w3jljGmwY57DimIoBB39YqPsv
	 5hoKWRYqZvNiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFB3D6083F;
	Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 783941D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30A0381214
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nc5gj0Wxnx2I for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5BBAB81202
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452969;
 b=raaKN8i9t3mzTG6FBrfA+cSOXjj+rBBOZqdWGZCd2dRxBItttJpo1WCsxNoWC+vh0Dtk
 Mp0DTOSaaD+AhPBqS1h7MJqzx8bXaG/0qyLi4WW/EH2DYGVTABFy7P281pHdgeDwXCG2w
 X/GcC/QHGd8tZx2kZPVwAMD9HMXISGEg2nAux4V1XaAY6ENvJfES6FNq7NPFcF6Fc6YYQ
 L6tw3bNVE/nM3t6XYnDjHDKgtbsOTAtfWQX8NajSDQMwczcvQull1UQqr+7GYR48JY8rI
 0v7XDD37AmcCbLn5zA5SeP0/o39ESSJcuqTHGP9E6ouYqpJy0oDR1h2SmW+inkSjmvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452969;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=GL8tgKTkcQ9d7V0JqC5vIKa2JYhF+b68m5KUbQksZAMT9NaAZBW+LoQ9DMCC5HcRfQhz
 sOn69ppqIOUd664bpzjKTCjyRPTLiAHME/njzpbXU1cOmLDNvZR8eIA1/kE5St5sMZxe9
 pLVujiKdS1EMyOJsmjGBjdpF2663GA76VslYSJHlvAieoSjtPZ1XjM0ksT60FywVY28+/
 B+oUJn7KetYiCT2lLUWzMNsfmY74D2eTI/lJ7j5NwkJWlBEYemZYwlyfCGu7AgP7JI4/K
 SyOsQXgI7Q9/6o/MmcvtGiNU6xSRg4g1c4OcGlRZEexNr1tk7L1nhR8OCK+NfJvgmJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Twb25khf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A+O87m+t; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Twb25khf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A+O87m+t
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BBAB81202
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KbON730868
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z5BPJHKdvnG
 eLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=; b=Twb25khf7hOVpbS+YcEBY50xqJ/
 /vXZe9Kzo/MsXmXqXr7UPH53ikWp0tCdUSBzV0weE3zo7CCB4z9LWtkJrTjhuDn3
 qtI8PBdliTHDvJTBVlJXmMbAqkBRb7QzUEYoKUR1sxaiiqv+w4dRFhL8vaadDirB
 gYJi/oKiGEBHPCwLbsp68/zKgd+Q+w6UiZUcSbdPsrw3CD1/xyLUfZfZgWJPVO8x
 c0YgsaU6Nk7JCuBHMaLVysKqk12XKFREiB+sbiXxVDr6X+y+BCY6k64tRQD8GbEs
 7uMGa51nlUro1ocFEQ3/j2JVZNFY44BFXTOFoCJHpnMF2upFberqStZp7Fg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe327rb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30f1b904861so6921555eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452968; x=1792057768;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=A+O87m+tXcWs4UJuSGa2fiZ126ugkG7a7E/F8eBOun4Byf7XL2fCaQ6Sbg//v/2VTE
 vzVTkiGGFeeIQsHsvmCxqE0H7z4Y53QoGyVsCDsPit+9TXcWVZrFn4pXnLHnSkey43m1
 3/QfEaL7NMVPC1aCQ/mUoyK/o0ZH/VaSXe5R5jZPmBnPGPbs8ie8Nhg2cgwl1I5vj7us
 w1n1D+/nsbxbhFq/IGYz8cH7xIT3PUb2Br62gYnZb2Y9B2wzEx0pYZjJ0jtN3OwbODfp
 0q0POwNWEHUGUrKj0HrCGz9kUNMhCKyNDxoshy2edcrbZGmFNC5ZXvlb63F/0ONvf3B+
 +//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452968; x=1792057768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=YxMnVNlyYCdkWIro1XOEKHTnekj+PDLyxRODCX+xW5e4oEYjW5cOGW/PusqcBYwvVY
 H+8JpwlYTKlIHQsP9F6yY0hMi7BkQAyWSguGvNcX+LVLZcd0f9FcafC9rf0JpaSY01nW
 4Us9CMactKiwAVRNceujWl+yvTT2nPCL1/utaFaTzEyYto3FF2tCB2p6QHIgS/f8ycBY
 ds430vNZBwaNNbFmlLZZ0DoZihtHDH/LsD5BjizRfcV4j1oa/BCgkDdSIdKzZmdoxP6w
 2z2zvEowPjKGwUXYw5LY682Spu/HnU1k8UUUmroQbpeSiKc3A4bgfQkgnBt1mC1uBsFg
 uQSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnj2SMJ1k64uSOGXR2BzgBbTThzLzd3MZNZK3ohxbGOqbikxCCMetOAsS9wPxXNStbz0jXT/Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lq496s3zUJAIjy0gQFJqGodiyRaIicJQIHZAFjLlzGZDmmwY4Y
 KR4vyADerNYk0dZGn0SHQChB4m4svAHERoNS5nUFw1WKyse6EhxhE5nm1qDztU7rcQb0hgXGDQc
 GcOjEfWz6pupL14+uKxoDbOBXZuPUBrqj21Un8ZOZM71x0BKR7fq0VUPVl7EzOjg2y5G0qso=
X-Gm-Gg: AYBFou2wyDm979FPi46vUlfT+r7zIQZdtS8OtnFfxWZoR+5ce6r8T3StWHl8VRDPR3B
 cY6KjcI8vVQduV507eW/tXcDdyQGlWtc/bSHX2uxwLKa/PSjjAGp8lgOH2567poYjDLHsSmjX8U
 eZ8ztM+jVdHkaWIbRZW9siQQ2y9nEFw+FulegFFH+KBefLTyAF4Fn/sgF7OXynzVVKd6ExlMgnN
 NOAtvCi2U0J6uyBhaAHwmhH9AmlIX9VH0NgenjHgA5ZEK/JH2pbP1pdqBfn+w2EIAuSEbhG5YW3
 gPbEWSccQIaMg9K4aLK6c6dMBCeAqjnbTRQWd3CyXCGPUUP5tn86ZDLJcM+zqpOZpKPZ7SzaZlt
 sj7OhVt2Y5plWk0Zjr8q5LmYP74+/hr/kzMBH5HwS5xWTSv4=
X-Received: by 2002:a05:701b:241a:b0:14e:516f:441f with SMTP id
 a92af1059eb24-162047a1bafmr5722712c88.20.1791452967527; 
 Thu, 08 Oct 2026 02:49:27 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:14e:516f:441f with SMTP id
 a92af1059eb24-162047a1bafmr5722656c88.20.1791452966909; 
 Thu, 08 Oct 2026 02:49:26 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:25 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 05/13] arm: dts: shikra: retain QUP SPL dependencies
Date: Thu,  8 Oct 2026 02:49:04 -0700
Message-Id: <20261008094912.419090-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX9DkCRFru0C56
 cxJzQbjBU+p/tt9ZPEzqlVXOdsAqIVGqDA2gvOHEDlyq0vSILhLPq5o1ZEkgv4QdNLB8hULvpJu
 /ZCZFrp8HvwJ+nLKwNb7ts8PjkHGkgBT+PTYhepc6ZLeEzI1lxupmrcOYvzGttUr9Muk/TLdHa0
 2Oar0g8fxRH1T1jnpyB+AHY4gIx4gZiSq4GIuDlVS+cJFKUCc/o04K+5Gh3ON6EHuxSTuWE8AYl
 vu9MvvY79N6TxlXnXMSTAoMXATcArFOu85Mtl+vjlyI3LLyoUK7F5PYmTSGUyybH9H3SA6maJFQ
 1ex4AIOSnE6P9oYq0Eu0zUXlI0Vyx0COx+LevayB7bFQJIcaIto4DuxPv4C6wqweacPfPYLPYf6
 5VGn+BqZBccExkHQ9hw4+4LpPCao1gqx43pscO8ieRJJ0XiBey0IyDELo+9E42iv3eAcpRmqSC/
 P+QCKyvdrtj+lcZU2mQ==
X-Proofpoint-ORIG-GUID: BLfHKJvSHfQDBZh09NJACkDbOAfhNqzt
X-Proofpoint-GUID: BLfHKJvSHfQDBZh09NJACkDbOAfhNqzt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfXz6RWTxFJe+Qv
 2svPu77rNlK69xIdXApaHvZTFCLxexbsfVEBNhfU411q6LkzDnCS68/ze+nPYeTpShph7GpDccb
 WLGATCVS6Tipkp2jRZhn1CCbuaursTA=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac76728 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=mHJ2qds8thx7DnZp6SoA:9 a=PxkB5W3o20Ba91AHUih5:22
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

Retain QUP, console, pinctrl, clock, power-domain, RPM,
and MMC dependencies in the SPL device tree so the firmware
loader can use the boot medium once probed in SPL.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e807b91ef1f..e8831da6aa7 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -20,3 +20,47 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/*
+ * Keep SPL console and QUP dependencies.
+ */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
\ No newline at end of file
-- 
2.34.1

