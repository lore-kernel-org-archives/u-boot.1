Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC4606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tS6xLGMS;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aiApr9uI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A47XVyW9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E97F80DD6;
	Thu, 22 Oct 2026 21:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16mDu-wwT53l; Thu, 22 Oct 2026 21:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72D8580E0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704859;
	b=ZRq9/uU+ffrYaznB/7JoIQ0BlN4tg2IaRKnUd4IlDE9U+9ttQKc1QgOLOPyK2pGxKBKt
	 lc68LHxiM/yQbQnTvekfgGx5hGxS9j7uM1OvYXDkqtc4e1FiEaInxQMuDhQPKXm8pOz0A
	 eA9Uad67louQ9vSCll6Y/ibDqPZEw0GOL9QIA+4NmHi28VrC1lwADw+eahyM8gli6IHXC
	 /8RjF/zJS0ukfpaKl6Ydgo3VTf+l+eJSpOc004/Cno555jv0nPBjBV6L6E//GHnR6KZET
	 mva9PJsRkf7Oaa//4Gbdc/OJIzPtvn+DBRfuULUJ6LN68iL6IfPS/k5krUwJ9YYxaeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=;
	b=ljb5ux+LnMJrdvvqR89Qgeqh76bUm3n9yg4FGyldqN9bjgzppV5lsyn+Aot7dtyWrsrL
	 j4gPrUaSWYM94sPmFq0jNK2PiQcRLxgCQQoKf7trSmvkSs5wzzZq7CtwV/vwSs0NXiUU9
	 2cX+wDGCTUnvMX292owZI973ZEPFk9CuAGcrfBSekyBKIWP72yaJQIzT/tJFyrEaQ/+Cl
	 /CyscwuUOqlcTmOspFbiek0+DhdJgH936U1ZanRT4nvxnIQsEKlIgKeJ2V0+w92RlNm+u
	 gdkaSuJ+emotXsZOu5/U4Bxntescjm2wLBmA+RaH9e1ozPiGLtxd9nBvOzHGQuS8LkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704859;
	bh=E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tS6xLGMSNGYLOKfr+o92jxjoXwBNKSNNtBJGDfiBlUde8MDmkMS2wMtD31LycmZYX
	 R4u6/Jr9g54xPcfirU/0EhrIAPM4y2mxdg2bQi47KBX+n/G23AdjCmLa1R6F1jsH6C
	 iuigOz0V6RvPlnmXSutNjBWCV6zQcPxF++nLN7qtCzxJoTNeQnt4dBUTA3ybNcdVVp
	 uWI+pbcR/zklKjaW3PbDIehOzFbVqQItN/m5lcIGSi5WmyHX1c7N42aoYVWBmrjjCF
	 Y/WMu1nJo5BQVQd6pw8msVC8Ou69vXY719HlrkNPGBwUMPm88MIlXL1tPYTzupCG7Z
	 thbJl42423ZHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D8580E0F;
	Thu, 22 Oct 2026 21:34:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A6424BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C19D4040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwpzXyscMPbQ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D9AA401DE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704857;
 b=B9rKz16LHUz230FnjUaiHAOwOCPRVxka6LZ3vHhQiLItoRjX3WbmolE70G39bR5TMlyv
 rImD6CocyiId1T1k/nyAQ+GoSI5Vm+E9Zv1hXmet//fOF09Y3eByGvzUUrpQohGqUfOXK
 hzQretN68qYjMe8u0ED7V/d/f/X8JFs40iwMbCR8T7mbqfjBKYn/Uc9pLPsCiZNicWL/J
 3Dp/ygtDJx5j0FvQ88b3pIPAIAnnonzhCyJG6V+NSahE2a7+msTBqVf6RwWkSI8XhQNmA
 t06+VlFYLRqAwI7tFlJgNEZ/VOhTTwVadSCqEoUUulRw6oSzPRCXjq8cB7l5K3fOsRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704857;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=;
 b=Fashub9ej4PbXllUfakl9+06Uw3ZltgPFAtAqZo026pzfjjN/wjbbKgJKN1hmMQGpGRe
 3KusT949AABY0JEamnNYJhbewmymv1v09Z8aU/VKkbh7jP1LXnYgBEdw5Y3Sslpj7hZLy
 3cK7AGe2lVQs1eo+qepxJa3uduxs+ykZVnu91AgVxpVIJ458K8hZ0Hv1jhSvP0b7101Wy
 D/MR99hHnZz6701uULkOlID8Q+ci27SADM9fmrnQ79Pgpjb6XtEuZabzIRb/SjnjG+vXQ
 OorbMLNB+EdAOIZV+lDT/xHNTyxiQ+qtTY8uARgCDrLno6VI+pDu9X79teNYwZgPhVg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aiApr9uI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A47XVyW9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aiApr9uI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A47XVyW9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D9AA401DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBSw3741650
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=; b=aiApr9uISv1Ijr42
 bzFzANXEJAuZaK5jh6zpgqBsdMEVKSj+4d1OL+0VnHZCFuwQQROi6vnlj65ICZEI
 VnU1PttnGQNtNv9lKbLvAsIZAkKmcZYQqVzy/DivjelL3rw19h2e0tzwEpTzX/NX
 OFw/uvCbirW0UVx85bDWwTVThUaAf4zVRHAHGmXkUn9tEN/ObSGulVruwTcf7vdB
 Vgkf8shYZFXDQ0FT+e6PHPmXPkBqgGmJfSDEBbG4EVUgLqZUlJyK7neggpbHMDyz
 PGFkwgR4YDSrFwML3/m6TvZxkYU5IwUUcMu9UQB+3EO1/nk58SrsLaSIUi9xgohx
 puTwSg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0n11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:16 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-88322409239so5693027b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704855; x=1793309655;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=;
 b=A47XVyW9kXEExtczH8ynuQ4HSieGjY+dlJeoH71XbfIe0JZZ8XHSinlZNxuSbyVaFL
 Ngys9ihuVX6P3Wm/zaFw1NApxHlOeRnAxBRMGBm72crWDjK15MKCGkzIqpLqgCk2qYLT
 ONW2tObEDAf9RGMKrpVTLLznfiH/84t0BDPxk3B6UOGacR+jBnVBHfb6z8VejSGYWBnY
 7A+xduU5nKr0rPC6yEUP2E8bTzhBjl+L78b404vvsnB6ygYLUyxcE7AXxMTDxTb9ZUH6
 A/m0RNfxh+I+Ix8G6faRRNAxxD1CHXwyU/HssQM6mz0ayDB/FBwEW7FwxSKt27KNMR6J
 xSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704855; x=1793309655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E3KurE5E3+0mx2E/PdiTibmLglPdvJ/U6NjVOu8K/00=;
 b=yJ+4foaioWjLQSaJvbxfN3Z+/1oi2SFUMMzYVYtQjJ0sxO6G+RmwoePetJfesWLMVj
 zxVriwV9TA+Nn1+k9To9VVB0JnaZHqTsdZlfceu2BQI+oglnQty7h0yBRmpobfpvumUC
 pZ6P9mQaJStRKIga5i5jH1enSDr4tP/HMc6r1I0L0UMfQGXiM88A1j1qLOoV9x5mrPqH
 312v9vJEmw3OFUVMBpp9mQhp2QIinm7wReNR4Bs1eLJ1v6bt6Drrl0jKn1xtUF0KRmsA
 DuIYWwuFP6XZQZWxLK2xtiYIaDmsHMgcKK8KVu/1OQeTAQwLUBjuCCQoiSF0vVUJAg22
 po0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqHDewlHk4LXB95Fe/wmZiM7yJywMl29C/eYPzmmmH6WPBtGMqnFi35dQivStnJU7srwY9nnQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYImfq8vUVz08X6tRRELo6+7pF+vvB5Nnlw/1U0FYLHInli9scRZ
 Iq5S781wU4EUcZQegEpxU6bEiq8L9PA4ur5PMQzWVUpqj4ylI6JWvLB3SxyXYBHlaTKR8ICEQGO
 DUxR7wGinyElxS2czrk4fFYWFhh3KVZSRhaUh9C5aMGk0KOv+i7ArmMpYOv/sLboe+mKP7T8=
X-Gm-Gg: AYBFou3gskhjDyvr/ml2bmf4tUEO1bixzKmlx59tlYhym7lnNjDuQeH09h9Uv6nNn1y
 e/mkzyQ/RgxsAFh/NJVTODfrBKxzxFP92FUjSErp6dyxQ3ygwl5oo1Y0kRbE4IuYoLtAtIGcAKM
 qfnaknOT2tjN/31UKixtDgvxM6kzJp9luO4bSsTGjdt1Kiwt+Y82BSvgrdEw7WfKap22kF6lNhS
 920P26ng13GtDr/UcqrfIZIZiDzRgME+EKcS26+EwKMU9pOsiYqFYjPgtsRRpC0j5HnreChV+PT
 HB4Mey2lWfChFqAdSdG55eDxzornmL9EhzNHX0OW+v+d8O6QbUWNevUV0HhpQxtyYopu2XpyYdQ
 HE8YRn2IibhE2ReKGaOnSYXwWXrROLSxsV0KpL6F5L53rD2txcBPx2IjMeaKT
X-Received: by 2002:a05:690c:29d:b0:8b0:dfcb:4d1d with SMTP id
 00721157ae682-8b157ed23c9mr3111727b3.47.1792704855469; 
 Thu, 22 Oct 2026 14:34:15 -0700 (PDT)
X-Received: by 2002:a05:690c:29d:b0:8b0:dfcb:4d1d with SMTP id
 00721157ae682-8b157ed23c9mr3111477b3.47.1792704855050; 
 Thu, 22 Oct 2026 14:34:15 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b155f8af63sm4525777b3.2.2026.10.22.14.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:14 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 2/8] clk: qcom: add NEGCC driver for nord
Date: Thu, 22 Oct 2026 17:34:02 -0400
Message-ID: <20261022213402.765757-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-3-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-3-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX4G3VfEFh0OQ3
 6hMlp+bP8U4aF6KK00fHTl8dLBJXtFfV0yhE+asQjo32lVRN7Okfq4rQ3VAD+Bk3MocIR4W01jl
 FDMU8X23dswpCFzC/uMFOwmHy3UTWG9gZr0ewa5N9qE1BwT/DBNHutRGcBC2jhfFfpS00iB9Nra
 +zZtaNpwSgMMaVDGxjp0MPXwVvApmOcI9eom5zoeWZyzUScp34WsVrregwlFjXlebNSoZ0n7CWZ
 la30UjWOTEhH4w6CBWg/C66CD62oIi9i4bvUltwwKCTSK/h0u0iwfy+Ay+40ZE2tw/MDYNYSJcR
 dYRcBUsXE7X4FZCG6Bx8nfrvYCWZQb862j1mfTqY5LUUNOF0Ag7Hv9BSW0qlJbwemSEiHlj36LV
 c5UNDBCo/0cK4a/t7BEPGfplU12DROESWzjVhT8lwvcEnhEWjGkRHBFtI4HEEQuUnJlfjVenCx/
 rF/gI5ypvzN9pqyTEjg==
X-Proofpoint-GUID: 9rCHHQd-VYU9aV-9JsNVJJXm0oJTUgE4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX69yduKWZ7mNA
 xLJ1CMjmmVxyN4jYbnOkQmMaovGs4vUQlc+xbaF0AbHUPhyGazm/Ke1Oh9ewf5YtswQhYfk3yWG
 hfb/jW9rKKFn6YNt2t82lLSbGeZz5mI=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada8158 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=hHpV1f6ju06AK3y-cPYA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: 9rCHHQd-VYU9aV-9JsNVJJXm0oJTUgE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220085
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
> + * negcc-nord.c calls qcom_branch_set_force_mem_core() on

Leftover note, drop it.

[...]
> +		WARN(rate != 14745600,
> +		     "Unexpected rate for NE_GCC_QUPV3_WRAP2_S1_CLK: %lu\n", rate);
> +		clk_rcg_set_rate_mnd(priv->base, NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR,
> +				     1, 384, 15625, CFG_CLK_SRC_GPLL0, 16);
> +		return rate;

The UART asks for 7372800 at 115200, so this sets 14.7456 MHz, returns
7372800 and the baud doubles. Use a freq table and return the real
rate. Same in segcc.

> +				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);

div is the raw field (2 * div - 1): 3 is /2, 300 MHz. Linux max is 240.
USB20 master below gets 200 MHz, Linux max 120.

> +				     1, 0, 0, CFG_CLK_SRC_CXO, 0);

No MND here, use clk_rcg_set_rate().

Also 20 CBCR-backed gates here use GATE_CLK, see 1/8.
