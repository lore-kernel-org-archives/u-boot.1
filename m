Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD973606A32D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SG5y4sB/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IA/TtJUM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XOwriLwB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B09A74098E;
	Fri, 23 Oct 2026 15:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBNDXms5JNF7; Fri, 23 Oct 2026 15:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D833040955
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768319;
	b=QumNdUjuE7jTARdSfEURM7Bq+OTwCQ5Bkk5DJQcj1tdUfZbLiIEhXwxg5Az9kREo6iwi
	 PA5C7R/8SCMyb6F8XhDeyFigLLd6GZFyaAmbmqFFspteeMv3lIZoIYbWgWZ1VHQFP+K34
	 o6WqMnxQ3fudNjR3XAqNuuVPoEOt3vxPKanwbutcFe5+8BNhAeF2oSSerr1SePsGtEOcz
	 07XzaBwia6eNKy1B6bVd3VufyL2M56HT3729zMVr0uzmo3krpfbjPitaqwf/A4feBEATE
	 /SuTfLubPullEbyKVtczvb+dYZlF7WHpy6TSDGnO7mN6VlaqEh2qBbd/UsQmrmKPdBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	b=PG7OD+4tZD3zhh/sfDEE6+W45M7elt+bWSqwgsPPrpKbvwqTfI/P2Gi+kVGquWn46W31
	 TZNu3DccCNHfFBCjirZGjGB4A4+uK0FoqZhlyiYLnAGzNfKPJgpNBXErUijxa9EcuZJmG
	 KtkHrICB6HTnVcb06DDZmWWpojwGRqyXNxhiT7LTpDoi/omPZE9vyiVhqaxKHknzxWjQ2
	 hIcdAuZdH0KdM+dkxcqJMhYmIOHVYov0n8FT83/1kGp7qydarOskvhzpXAyNzU316GGZH
	 aik7q7t5Q0KuEf5ELjrBhyIuv3dUsWlMvOccVIoaLOzLgipa+O8dEet+i1BYAQyr0mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768319;
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SG5y4sB/yB9xCki+mFouZwysXYjMsRt0iIo7/Au8+Thzew7YB5V6aFPdkad5tXcHO
	 Wz8LycSAQuRJZcITYGltG9UopclA1ActdCKQNYp7EXW6ffd/YlJgFo6VizEbwYyhuD
	 E6IbpqjIzwFmus48dsjleT0VffLdIDD06Tv79lROVlklIErWvaPLqIAZxVq0tL8S3k
	 D9KUlqzhiRPQU7AZKyLgSchgRDlmPyNIJNIVJuVhwaikTHzvsaz2gOLo4GOa+ASvmT
	 tBzx2BMon4TsxluSqHY8q44i2NKba5jd2XObB3mVKQz75ud65FnPPyreED/Yggzxgn
	 OsNLUz19441GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D833040955;
	Fri, 23 Oct 2026 15:11:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D50612C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13B71401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBF2eevlL6l2 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37996401D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768315;
 b=ENRMYSThUati2alpPveT3GQQKCWZ5KtfgQRgUgupovGUkhZOXd3iHpi4/djOU5IQOwni
 tuEfWWS73JrRzaFQiqVj9UvUcSu96FrZik+0JENJeDMl7LpKdsk2p/w9KgDxNqzfKJcWY
 3k6XZIan57zPPav68w+XseJQ39rGvO3CQ3LkKv+lkkvF5Zm+IfQguVnKl/s2JvXJuKDOG
 ZA9conJiIz5uEp+TNhAgM7zowCFGf4riaFMfbcpIPVSVzW0RvoeUwi/x/mAxRDYKNtqq5
 J30Bx0unqFpgZfKB4Twzas/s11ckX9ChuJ7wK/ds+GFlzGXlK98ucmEQljouDBKxjhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768315;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=ElQJthe9AoU029kIXAMGVl+5TBk1WAjCZkQRy0QiXaroskMM9Q626M5++j9PrNfvSLam
 h23SehwExDmpikFMGPK5vyjNr8ckyIQucH5rbzWsAHbG8TeBTYX++fIhOcvfVCLZGmxrB
 T1QE71Y/SiJQH+tGAiQfcc/EwH6jQbeBmjhprKKQ/dUwjP8lE21E8QyTwWXaBODtPDrjY
 MpWHQHcNkvbufiwVb7flYk2T3UpJDIPELvni7d5W/3fO/EVzVbfM9kTqHHsv4cn1xQZq/
 lqp5+TbIs62/t7kCtKvGsi4CzJWku0ruKmurUvKRxaftf2KVPG6mZKKIvNv5Y+4kSsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="IA/TtJUM"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XOwriLwB; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IA/TtJUM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XOwriLwB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37996401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:53 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE66nS3018953
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=; b=IA/TtJUMFMxDOcDS
 IHFmLcxhfw2kf1aaRWdxx/IZFbqEQNKFkUotcBjblomeLW6CH2FKlfmnMpDJHxJ6
 lco1olxG8ryKqEQAzVfKYYZxBbvsXacW6i4VDMbdZrotjOn4Ney/6cP03bsiifRT
 mLxcbipaihHI68SRwcdPJf/emGIECCjzAatJI47Sg5S2QWCEcAekcSAx9ReQcTxi
 0/SGdhb9atKVkxW9LmqXY3EJZttJzt+7SKUa6QTzUlqp8x7p9Q2TG2A72c0mQWtP
 oxUuGZjDxmFeLn/euqcl3Co2Xnn1l5reyvJ+03inaaE9YaEQ7HXFNfUAtgrxhDNi
 iQSdAQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbpcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:53 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ead18311ebso155562e0c.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768312; x=1793373112;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=XOwriLwBDfY431iC8299gSJg8t16X+xwyLfCBfnteOpFaTe2Cg4uM1UOGRZ6Uv4vV9
 W671XjVLmVDWKQ/M2uuexNwhGJZJCVI8svWmm0Tf9hGiZlFvXYc+tO8dK1h3KvpWMt6g
 UrfdJy9++rbob1RnjahJfKLsfY+liBiJN86lPYq+HYijFKvtXrtPozKgavRHkWsd2YlL
 QaSYM1pX2QpxPQQLcG6RTVEws4kTFEmYoedZcVFjhpJxd79OF5yzeZXucxk5hbe9T/Uf
 BbnhpOuvr1eHA6Rs8HCUHrUk42x4DsXPsASrRxmz+NzzVeaOoXB+PHpUf+QAbNn5FmRT
 eZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768312; x=1793373112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=trpTfBUZDWgokYo00JR1/S8nPzdEcShKuD9u1p8oTrrHxFLKXJXYO/JIscFA/S7lzt
 qTfep2i8bbRGa2aRKDcKqeI/QR6DDdxa9S8Af7MAUitU4LQumluHep5HpoeVP/RhWYe4
 vmclzhB2Dha4+esnjbWxQVAQmCGgAeT9A03D25hAvHQSELxQ7iJ66nQRBsX8RWwxReAG
 COW8lvDfjoUvP43AubJjlIftmCYgAiqclnE9y1Rk99xcsBRPFDMyevy9UxH1fgrV3ekO
 9cuz04V21E3QGuAw1jWQWflOalCnWSF5Zbzf9XPisiej6WHAk4PN9FiTDAvRjef8VQgu
 xf2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgqfaxPgRGEXoQUJDKX2zXeFN5hY36RhyQ6eqfKCdPYr3l1jPFwSO3+Bq9vjsepEC9c5kxUNI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLp9AIJ/ZAtd1JjKAMCGe6TO6rbx6SEseLj+o3OXP7sYOhcLcw8
 7uNuwnUXVLXKbLK+jqpVKE3tvHc/BxPL0UwVuZB9s8VoRO3n35AjAxqqOsrgkXwo+JU9dcM/BO5
 Br6SOMroWOeqdRbgI7x4Yegx2HgIhF6BP5Tw3TpiIKzKSFdTKFfvdVS42pMqtpQlKfaFm8GU=
X-Gm-Gg: AYBFou2aJgvEgPv8OIkUaImmqxcbFqXbVJVPIBUDK/ta92j96CCaGHt0c4u7qrdrhw6
 ImYgs/jUirCS9QQwzvp87c/9I9AOByjKFCiTTsJoPq3ywTHYR9Bjsd7wH+UvVWyENexuS9npGXG
 poTAb7jS58YJkPuE5Q4WnHgaPhwR+VcT7/wliPP6I/boI5OWLMTT0uXLPxSQgn8JHYzS82s8rru
 JsQ9P+mr6O6ScdWw0uUHSdSYbaypsRbUouxlhkQ34RDgQx9NriwulBGMJnbT0r45OyAfrhqmAmx
 IQgtPuPvNxxJoe3ybiCxa0ZR7mH7kMH8i+Z9blRbp8P1AE0ekIZjemlQDWmeUU1uLvMDktsffPw
 aHuPSPmJH3NWNcwdwJOwHw91aif/3o+eFEtjA4KwFU0E3U10=
X-Received: by 2002:a05:6102:5706:b0:7a2:7ccd:280d with SMTP id
 ada2fe7eead31-7ccc32f336dmr905675137.8.1792768311600; 
 Fri, 23 Oct 2026 08:11:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5706:b0:7a2:7ccd:280d with SMTP id
 ada2fe7eead31-7ccc32f336dmr905640137.8.1792768311007; 
 Fri, 23 Oct 2026 08:11:51 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:50 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:11:40 +0200
Subject: [PATCH v5 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-1-6453a6f63028@oss.qualcomm.com>
References: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXx6kwN/QTA/1u
 K/6zvgTI50Wj3rGpyZyrVJqsSaEzu+q6rpcVKrxq2lydBKS1CaqRpzt7SABUgKZ9f2RJB5E96sx
 N4D3yy8p/M5N5kr+c+dR02WNaRxXQ/ae1x+H/nHj3FYSeNIgHzIoqb1RXrdS44+vmjeNCrrMQOx
 Ia/4DrbW9xLucmhGBOfg2iQfqRzjBtPlERjRcn3USek2El7lAYxbi/CQYuhFDmW/C1bAYk9tnAU
 p3IYGy20FZiLns47NIEK2yyLEFII/hevn63uOKb4ropUFRAmUh0Cq3WYeecZrMKuzrjRRBTPGss
 icinGR9OBGMKlVxf3Jw6dajLG2iIFfYiofF5Ew9OZmjNZV4r5105ZCUvJZ8EIS9U7tikbCK3cU5
 ne+ZsOAriNj7RI+PwH1/cLwS5XvAxvhm9Or+tqoE25Q4GaBmixpsE3zXNEQhqILM6L2VpsvmKFQ
 c+XcDZPqWToVNJGct5A==
X-Proofpoint-ORIG-GUID: aj9xCfTkZjXD5D64-8zd9BK6sP4_232n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX3UR+W+FncK61
 ZSb4r75v9E2GU7ZYN0ZNjC4NPbKziCO2of/QT0SPy1pLNslxWqgg8/nGSCcZC2ymRRp23EJ+GPV
 OGPM052PxLe52p660aNZfZRu9Uq+mAo=
X-Proofpoint-GUID: aj9xCfTkZjXD5D64-8zd9BK6sP4_232n
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb7939 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

write_pvalue stores its argument as a NUL-terminated string, which cannot
carry binary data such as the 32-byte SHA-256 root key digest consumed by
CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
hex-string variants to provision and dump raw persistent values from the
U-Boot shell.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 8a915b65834..3c13d6a2cb2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <command.h>
 #include <env.h>
+#include <hexdump.h>
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
@@ -439,6 +440,100 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+int do_avb_read_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *name;
+	size_t bytes;
+	size_t bytes_read;
+	size_t i;
+	u8 *buffer;
+	char *endp;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	bytes = dectoul(argv[2], &endp);
+	if (*endp && *endp != '\n')
+		return CMD_RET_USAGE;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Read %zu bytes, value = ", bytes_read);
+		for (i = 0; i < bytes_read; i++)
+			printf("%02x", buffer[i]);
+		printf("\n");
+		free(buffer);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to read persistent value, err = %d\n", ret);
+
+	free(buffer);
+
+	return CMD_RET_FAILURE;
+}
+
+int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const char *name;
+	const char *hex;
+	size_t len, bytes;
+	u8 *buffer;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	hex = argv[2];
+	len = strlen(hex);
+	if (!len || len % 2) {
+		printf("Value must be an even number of hex digits\n");
+		return CMD_RET_USAGE;
+	}
+	bytes = len / 2;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	if (hex2bin(buffer, hex, bytes)) {
+		printf("Value is not a valid hex string\n");
+		free(buffer);
+		return CMD_RET_USAGE;
+	}
+
+	ret = avb_ops->write_persistent_value(avb_ops, name, bytes, buffer);
+	free(buffer);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Wrote %zu bytes\n", bytes);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to write persistent value `%s`, err = %d\n", name, ret);
+
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -452,6 +547,8 @@ static struct cmd_tbl cmd_avb[] = {
 #ifdef CONFIG_OPTEE_TA_AVB
 	U_BOOT_CMD_MKENT(read_pvalue, 3, 0, do_avb_read_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
+	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
 #endif
 };
 
@@ -491,6 +588,10 @@ U_BOOT_CMD(
 #ifdef CONFIG_OPTEE_TA_AVB
 	"avb read_pvalue <name> <bytes> - read a persistent value <name>\n"
 	"avb write_pvalue <name> <value> - write a persistent value <name>\n"
+	"avb read_pvalue_hex <name> <bytes> - read a persistent value <name>\n"
+	"    and print it as hex\n"
+	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
+	"    string to persistent value <name>\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"

-- 
2.53.0

