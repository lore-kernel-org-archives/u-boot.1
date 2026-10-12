Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6142CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DC006071B;
	Mon, 12 Oct 2026 17:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vM5dOrqUIClG; Mon, 12 Oct 2026 17:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D7C160711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824910;
	b=RATDAnH+zLWiGOF1h6jjNUbf8WAAkSayh1wee3N0edwxnOqd/H2mvPU4v+V9f75/vJ/1
	 uT1Tap/X6M5cvXMvuBPTxWHdFVjMh1p/Wq6a//l9OD2a4he6cyaiAcHbedv+UiGn3Vb35
	 dRjiZuVSdyq/TGk/pnaukGxm/u1YjkJ5XGEep0mbnjAwYWUHs6WhcvUuetqc1fmWQoN1+
	 XvRlx4awwc5+lzhlvhatsCByRKLhXWoE33iE+DiTX6hPWjnOdj87rGbiM1a5ielEe2nSO
	 ryFqp7HA4aa7ZMhdVYlvGfu7dqYZ6RN1tEbx9mZfgvuRx2sayd7LgaYZO7BTt50RQCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lJDv9GttDz/WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=;
	b=IUUUvhTYujqgt+YrlI3em+5reP9ajli8CKq4GjaIpovV+0iDRGL/NCeKHHpSEblBJ4Yf
	 N28MM28AMhKRf9shGBgf3uMNfnpnAkffZwrFpmwQsj3E8swy7JOURMwzyUws3rOl1tk2d
	 Xdnu+gPoBTQP6vLbeRsp0T2ia6gRuJdYxj4PB+NuvNcDUJUe/ZGGIorCJljcs1jv53qYX
	 2Q40hR/juR4pT4vEqDgLKrCQNLlzT7NkZaCJ50ddco0U1kzkzNqca15HtIEd7olvXjn8m
	 et2Y01do+I7xzY9VnDcotk3lC8+leP2OnbvPfHLcSc1lCt0QX8VAGmbN3RidcNxaqYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824910;
	bh=lJDv9GttDz/WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnLv2CcxbwXmNY04uY9SeElBu9QfWWqcXiPn+mBBz3orj0YgwZWkPePa9DM3PxAUh
	 T5La3S9XH/rddMTNqk+acQWtGskKKH8FPOXDaH2MNVgbuIcmXqUpg35wkivyOkCm+v
	 MIS2nIPqx7nmo+9Si51gTnvEb/gRF3JiAMUrMGQelMjaHEfsZwf9p7mbO9QV8szX6A
	 MpM0FsmmZ3QmTcCOAkGkJYZeM5CamyynXkSKUJbPlCfVdgy0GlUrOVppeNa/8g22tK
	 ygP8KtBZZ+9wviK2PJk8Js5QVbIJgBKaO7htjF2/boLAkfWoeay+HGUq94XvvikZqX
	 0WUL3LdmPg14Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D7C160711;
	Mon, 12 Oct 2026 17:08:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 774E8105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67DFF400D7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjCVMvP7vV77 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 831D7400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824906;
 b=g0qrv4zdBOmRTaXRCk+/g1tQv2ADIWS7kbqw4iwO3Mum+/n97uuO4zVBprN9KFyorKbo
 SYgeCzJlBachB3fsHHVtwcbiQpt/+bQwYUl/wRV2MPH6SROgVtk9jl3mjAIvrI8YF6c5r
 cksKMf+/pqXlIir474IFUVOFPjAiMjwY5Hjugxt7XCZ94qp2TXSJZ5JcOaOoSZc2EEozW
 FHWORAMeY53scHw6sSWRwUIO7779fb2RYFdZd7B0D2QV9HmVvo0dNLoyHXi/83ABCh71j
 9kRxCP9lyXi+/Lela9FhTK9JMYgW5GTuCrD9iAHsHlUPbhblh8DO0ciskomOrGCo3kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824906;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=lJDv9GttDz/WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=;
 b=F3cGSdtJ1+GNaEFL+KtR2bB+APUt0t4AlBi5L7fUHezpykB0MtEgGxuiTo573S4liTNq
 Xto9m4n19o/eJOevIVsn5dFsOJIVxxLrrlmoEXQDcXz+/ca6gIuvdRAYQ8m4qxO9ebULC
 lbZvKEh9OqfnO0CVOA/jbdyoQKDBz1Q+vGpIWl7VYE0h0CL5XfJR1xjwVk7jGJ0Y2MTt1
 /M0LHf9XmYs8bau/emsB8nDsdXaADfvzCeMdQGJGV96jis29wz02ZdIQ6xzr4/meZdPUO
 TdwHEuU/PHPDUWFLdB+7/hdUnq/4mJtpHDEelKv3FLOuuXBd7MwvCKYdiCnPV1sQbqA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=S8o9S3RZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RNijaNHX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=S8o9S3RZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RNijaNHX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 831D7400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFemYf3782599
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lJDv9GttDz/
 WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=; b=S8o9S3RZgRuBcPGgA1QW7XJO8Jo
 Ek+ieLhVKr+8vKRkgPdB8b1dE8/V+DuPcO5h1Bg2PeD5uiTOqJjUXsSbqjfaSWy/
 g6GmCyFJQCak7YxG9oUjglAiublKVCVbnfGbytq/uq53Bbd1W5+j2mdoUIg4KUbk
 i6ivu4dLzlQjTvu+LlwgfQAo1Lb8j+6ZpcMXHkga1NjCvlaTbLrylUc+6ZUwys1Y
 WlJhwqWoMo2gjRXY8DRruQaEacCtMwGi6A6ZftGBVWXHaWQRitt92Emfmtw3b2hh
 ySXweGC27sWsUg+CgJmL9WqWciE57FJ5GpYVCbX85IzzgBn/fNxyLq1hTLA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3jh13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5947791eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824905; x=1792429705;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lJDv9GttDz/WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=;
 b=RNijaNHXFg8PWawOLaDyyKEpR5Toao6X+kprKNZ9OEVjMbAHSa1BFzV2mLnIOW9xjH
 Q4Ux6KOunjktDqMSZBUB29u/wkkX26JHG4j67vKRsAglHEvb5pokG4RCsVJecS4xeO5v
 DD6MMdGzJp8ggpEgvGrF8eEhzo4V7M/OGwilLh7/1vrUmlM/Wm72p9xHRUUMKdKNmQYH
 c/ZQVO1d9GQXYGCQ/mWFEewu4dpkwjnL/0X+zs0AZBqc06zSXhiZF2hcgpwMArqeUC4R
 pavhHuPOb16INwrstkL4e5s/f0o+9wJxmYgqkPJAG0ezBRfLyXkUZUoVhY0oRyzKmkxF
 4e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824905; x=1792429705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lJDv9GttDz/WpDR+QZ4f6d4HN0l7i4ZHwr5tuzWaLho=;
 b=QJPS0hgIXqymQks0/GQhcooaGT0gtW3mc6G0wm0WXlJ0zXtwmLYfLpb/zpx8CpiAr2
 zK/dJH6Qns00PYHZ2NYRukqjFzAX62USri96GZqfjwfevBPmOuwoVwT3HhDa0MJpWH0E
 95cwgzE3/LOEUe44Vz2Q5zONsGWiDJwhj95SW7B0Yqm2IHWX/TiWmSAwC19KDzeXG5WX
 J26Ag+emfrEtd7jQxtIScwPfEVLP9x7sv8IQxTiRSGiQ641lpR8Kv9QqXJOvGHmzXXWV
 XafnehQlOCUvHZC6e8hJw5D1k3HwCHeFvy66zHQD5uWX6YE1ycptCsrA6fIEVEnmWiFr
 85vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByUPAo1hJ+nf08g1DO+GevXfcD5VCdjRF4yJ5ccYgX4aShziy76I14Jb4+RLKS29Yb9S8IvSsw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIQqJ7uADjl7fiJtdc/PhE6fJzcTgD9v2oE4KEsEY7+NV1YJIyo
 Zdl1Bn1olCRMWA4XXyNYSgANH909jfMhC/a82Z9Mz66dBKQsvygpd/7sZeATWq+3h21V7p/wA3S
 fjhxwQw483w9PjTiPASvhI1cgRwu94QavKwDUzCzjExCWUzI0FdbmIeyFoXVXMfAC844aYfQ=
X-Gm-Gg: AYBFou0YmjBPj+ziZLWdjv5FC3X5i/dEEHcQTWGWs8eZjy8sr709s0QiBFzr6eM5xkv
 FiN3md3WZmn+NdRRJYCAU7lhJVekMkpJixWEYkWuKMd2U0vtX6PJQ7hIeUaIfmgClqiIlyvgre6
 T8J/9RZKTEjYmBtt6lE2SBpFXLd2IYEYMUtxoAAqTSGkJsRzuU7F7MGVdwMNA+2TbCAJ2/mvtzK
 bIzHAGaq/3awJP3lSsgGZ5AGYk1RJVyHCUjx1EdFAJWbMiM84RJ/p9rIABEEW1qvKBMCnDPg4bY
 znAw9ZpvuBAPt1c/IGm6n/KGzSXLJIAjz6riyiYCGvQG3ssWudkpO11OiToqqEU2rFLIHskS+Lz
 Ut0qqj6dXu/vhlWiappj5n3V25A4a5CRtEcFbO2Qe4Oc8JuS3kEeD/XWvCfHu69I8QULASl8+X4
 zmslTw8VzfitSEawUSeA==
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id
 5a478bee46e88-3537e032905mr16694050eec.8.1791824904168; 
 Mon, 12 Oct 2026 10:08:24 -0700 (PDT)
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id
 5a478bee46e88-3537e032905mr16693975eec.8.1791824902944; 
 Mon, 12 Oct 2026 10:08:22 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:22 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 3/5] mach-snapdragon: Add FIT multi-DTB selection
 support
Date: Mon, 12 Oct 2026 22:37:52 +0530
Message-Id: <20261012170754.1606314-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX0/UvvS+PUef+
 th88Jz0oc6k/RxhRHn1DAZXie5vimG7dc0uQMO8czb1KfpKSINxq5r0b4iniUxIo5m0lzpsL7Qk
 00PYDFeQpwtCb5Z7LHAD6ueySg74EAAOiIYtcePCUrmWzmQDnygKs4qgK/ujx81Nn4+tXoHOF7n
 15pSBOgx/AA0W1C8bW0e7u85KpjkkYSmVy6eUPEXrnBVhyfGWVBM7O1yiDM7e6mENOUMun1sbqY
 cXfwIgSNfnjUnxsgIObid/wFToag0emKfq9vKqzC6wizA4J1oTkNydMetvvCVbfJGaGg7kaG7Ro
 JZkdGcmSgSccg3+wa/iH7AsE2rFV2gnszOALHRljj6/P70BIcfArkJq0UQI2ecfeBHGdG4nfXTH
 GAzc6J1sDAxKynWH+vuoDkpqZRBoP/ix3dDeke8hzFTv07OppHMxJbLq/5d0Wyi5/cvoGh5zudv
 /68ItJa+2Qy7DZ98OlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX+8LYcezr4YMh
 y/EjjwU087Gm5RKMB8Tc9ZIVsTibRaZmzUZUEO+Wy2b/cnG3mrrrUOnKngdmSyl/ZOE2h3Kg5eq
 ySvNiuP6bWYLamhI5hN75eTSPKE8ZnM=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd1409 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=1VxDqnHFAAAA:8
 a=EUspDBNiAAAA:8 a=1PWcsMImatEJL7Xo4dEA:9 a=PgdUgUZ1Fhgl81T7:21
 a=PxkB5W3o20Ba91AHUih5:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: PqmBTbTK9CEMJzIvU_TsufEJDqp8knZQ
X-Proofpoint-GUID: PqmBTbTK9CEMJzIvU_TsufEJDqp8knZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

Add support for automatically selecting the correct DTB from a FIT
image based on hardware parameters detected at runtime via SMEM,
TCSR, and IMEM.

The FIT image (qclinux_fit.img) is loaded from the "dtb_a" raw GPT
partition. A metadata DTB embedded as the first FIT image is parsed
to build a "bucket list" of matching identifiers based on detected
hardware (OEM, SoC, SoC version, board, board revision, peripheral
subtype, storage type, DDR size, soft SKU). FIT configurations are
then scored against this bucket list via their "compatible" string,
and the best-matching configuration's DTB (plus any listed overlays)
is loaded, overlaid, and installed via the "fdt_addr" environment
variable for the EFI boot flow to consume.

This is gated behind CONFIG_QCOM_FIT_MULTIDTB and is a no-op unless
both the config is enabled and hardware detection succeeds, so it is
safe to enable without affecting boards that don't need it.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig             |    9 +
 arch/arm/mach-snapdragon/Makefile            |    1 +
 arch/arm/mach-snapdragon/board.c             |    7 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1033 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |   61 ++
 5 files changed, 1111 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5911e76dc1e..98b6655385e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -49,6 +49,15 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_FIT_MULTIDTB
+	bool "Enable FIT multi-DTB selection for Qualcomm platforms"
+	depends on FIT
+	select QCOM_HWDETECT
+	help
+	  Enable FIT multi-DTB selection for Qualcomm platforms.
+	  This allows U-Boot to select the appropriate device tree
+	  from a FIT image.
+
 config QCOM_GENERATE_MBN
 	bool "Generate an MBN-compatible ELF binary"
 	help
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 6132847d7f4..74ccdd9bd53 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -10,6 +10,7 @@ obj-y += board_spl.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_QCOM_FIT_MULTIDTB) += qcom_fit_multidtb.o
 obj-$(CONFIG_QCOM_HWDETECT) += qcom_hwdetect.o
 endif
 
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..9bfb7183241 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -26,6 +26,7 @@
 #include <time.h>
 
 #include "qcom-priv.h"
+#include "qcom_fit_multidtb.h"
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
@@ -452,5 +453,11 @@ int board_late_init(void)
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
+	/* Try FIT multi-DTB selection if enabled */
+	if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
+		if (qcom_fit_multidtb_setup())
+			log_debug("FIT multi-DTB selection not available or failed\n");
+	}
+
 	return 0;
 }
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
new file mode 100644
index 00000000000..45423910d34
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
@@ -0,0 +1,1033 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Automatic DTB selection from FIT images based on hardware detection via SMEM.
+ * Loads qclinux_fit.img from dtb partition, detects hardware parameters,
+ * and selects the best matching DTB configuration.
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <lmb.h>
+#include <log.h>
+#include <malloc.h>
+#include <part.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "qcom_fit_multidtb.h"
+#include "qcom_hwdetect.h"
+
+/* GPT partition name containing the FIT image */
+#define QCOM_FIT_PARTNAME	"dtb_a"
+
+#define lmb_alloc(size, addr) \
+	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
+
+/* Maximum values to match (SOC needs 2) */
+#define MAX_MATCH_VALUES 2
+
+/* Metadata DTB node names */
+#define META_NODE_OEM          "oem"
+#define META_NODE_SOC          "soc"
+#define META_NODE_SOCVER       "socver"
+#define META_NODE_BOARD        "board"
+#define META_NODE_BOARDREV     "boardrev"
+#define META_NODE_SOC_SKU      "soc-sku"
+#define META_NODE_BOARD_SUBTYPE_PERIPHERAL "board-subtype-peripheral-subtype"
+#define META_NODE_BOARD_SUBTYPE_STORAGE    "board-subtype-storage-type"
+#define META_NODE_BOARD_SUBTYPE_DDR_SIZE   "board-subtype-memory-size"
+#define META_NODE_SOFTSKU      "softsku"
+
+/* Property names */
+#define PROP_OEM_ID            "oem-id"
+#define PROP_MSM_ID            "msm-id"
+#define PROP_SOCVER_ID         "socver-id"
+#define PROP_BOARD_ID          "board-id"
+#define PROP_BOARDREV_ID       "boardrev-id"
+#define PROP_BOARD_SUBTYPE     "board-subtype"
+#define PROP_SOFTSKU_ID        "softsku-id"
+#define PROP_COMPATIBLE        "compatible"
+#define PROP_FDT               "fdt"
+#define PROP_DATA              "data"
+
+/**
+ * struct overlay_entry - Gathered overlay FDT image info
+ * @name: Overlay image name in the FIT
+ * @data: Pointer to overlay FDT data within the FIT
+ * @size: Size of the overlay FDT data
+ */
+struct overlay_entry {
+	const char *name;
+	const void *data;
+	size_t size;
+};
+
+/**
+ * add_to_bucket() - Add a node name to the bucket list
+ * @name: Node name to add
+ * @name_len: Length of the name
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int add_to_bucket(const char *name, int name_len, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	node = malloc(sizeof(*node));
+	if (!node)
+		return -ENOMEM;
+
+	node->name = malloc(name_len + 1);
+	if (!node->name) {
+		free(node);
+		return -ENOMEM;
+	}
+
+	strlcpy(node->name, name, name_len + 1);
+
+	list_add_tail(&node->list, bucket_head);
+
+	return 0;
+}
+
+/**
+ * search_in_bucket() - Check if a name exists in the bucket list
+ * @name: Name to search for
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: true if found, false otherwise
+ */
+static bool search_in_bucket(const char *name, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	list_for_each_entry(node, bucket_head, list) {
+		if (!strcmp(node->name, name))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * free_bucket_list() - Free all nodes in the bucket list
+ * @bucket_head: Head of the bucket list
+ */
+static void free_bucket_list(struct list_head *bucket_head)
+{
+	struct bucket_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, bucket_head, list) {
+		list_del(&node->list);
+		free(node->name);
+		free(node);
+	}
+}
+
+/**
+ * log_match_values() - Log matched hardware parameter values
+ * @log_type: Type label for logging (e.g., "SOC", "Board")
+ * @subnode_name: Name of the matched node
+ * @num_match_values: Number of values to log
+ * @match_values: Array of matched values
+ */
+static void log_match_values(const char *log_type, const char *subnode_name,
+			     int num_match_values, const u32 *match_values)
+{
+	int i;
+
+	log_info("Matched %s: %s (", log_type, subnode_name);
+
+	for (i = 0; i < num_match_values; i++) {
+		if (i > 0)
+			log_info(", ");
+		log_info("val%d=0x%x", i + 1, match_values[i]);
+	}
+
+	log_info(")\n");
+}
+
+/**
+ * process_node() - Generic metadata node processor
+ * @type: Type of node to process
+ * @metadata: Metadata DTB pointer
+ * @root_offset: Root node offset
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * Processes different types of nodes in the metadata DTB. Handles matching
+ * hardware parameters against DTB properties, with support for bit masking/shifting
+ * and fallback values.
+ *
+ * Return: 0 on success, -ENOENT if no match, other negative on error
+ */
+static int process_node(enum node_process_type type,
+			void *metadata,
+			int root_offset,
+			struct qcom_hw_params *params,
+			struct list_head *bucket_head)
+{
+	const char *node_name, *prop_name, *log_type;
+	const char *fallback;
+	const char *subnode_name;
+	int node_offset, subnode, len, name_len;
+	int num_match_values, i;
+	u32 match_values[MAX_MATCH_VALUES];
+	u32 masks[MAX_MATCH_VALUES];
+	int shifts[MAX_MATCH_VALUES];
+	bool all_match;
+
+	fallback = NULL;
+	num_match_values = 1;
+	memset(shifts, 0, sizeof(shifts));
+	memset(masks, 0xff, sizeof(masks));
+
+	switch (type) {
+	case NODE_TYPE_OEM:
+		node_name = META_NODE_OEM;
+		prop_name = PROP_OEM_ID;
+		match_values[0] = params->oem_variant_id;
+		log_type = "OEM";
+		fallback = "qcom";
+		break;
+	case NODE_TYPE_SOC:
+		node_name = META_NODE_SOC;
+		prop_name = PROP_MSM_ID;
+		match_values[0] = params->chip_id;
+		masks[0] = 0xffff;
+		num_match_values = 1;
+		log_type = "SOC";
+		break;
+	case NODE_TYPE_SOCVER:
+		node_name = META_NODE_SOCVER;
+		prop_name = PROP_SOCVER_ID;
+		match_values[0] = params->chip_version;
+		num_match_values = 1;
+		log_type = "SOCVER";
+		break;
+	case NODE_TYPE_BOARD:
+		node_name = META_NODE_BOARD;
+		prop_name = PROP_BOARD_ID;
+		match_values[0] = params->platform;
+		log_type = "Board";
+		break;
+	case NODE_TYPE_BOARDREV:
+		node_name = META_NODE_BOARDREV;
+		prop_name = PROP_BOARDREV_ID;
+		match_values[0] = params->board_version;
+		num_match_values = 1;
+		log_type = "BoardRev";
+		break;
+	case NODE_TYPE_PERIPHERAL:
+		node_name = META_NODE_BOARD_SUBTYPE_PERIPHERAL;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->subtype;
+		log_type = "Peripheral Subtype";
+		break;
+	case NODE_TYPE_STORAGE:
+		node_name = META_NODE_BOARD_SUBTYPE_STORAGE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->storage_type;
+		masks[0] = 0xc000;
+		shifts[0] = 14;
+		log_type = "Storage";
+		break;
+	case NODE_TYPE_DDR_SIZE:
+		node_name = META_NODE_BOARD_SUBTYPE_DDR_SIZE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->ddr_size_type;
+		masks[0] = 0x1f00;
+		shifts[0] = 8;
+		log_type = "DDR Size";
+		break;
+	case NODE_TYPE_SOFTSKU:
+		node_name = META_NODE_SOFTSKU;
+		prop_name = PROP_SOFTSKU_ID;
+		match_values[0] = params->softsku_id;
+		log_type = "SoftSKU";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	node_offset = fdt_subnode_offset(metadata, root_offset, node_name);
+	if (node_offset < 0) {
+		log_debug("%s node not found\n", log_type);
+		return node_offset;
+	}
+
+	fdt_for_each_subnode(subnode, metadata, node_offset) {
+		const u32 *prop = fdt_getprop(metadata, subnode, prop_name, &len);
+
+		if (!prop || len < (int)(num_match_values * sizeof(u32)))
+			continue;
+
+		all_match = true;
+		for (i = 0; i < num_match_values; i++) {
+			u32 dtb_value = fdt32_to_cpu(prop[i]);
+
+			dtb_value = (dtb_value & masks[i]) >> shifts[i];
+
+			if (dtb_value != match_values[i]) {
+				all_match = false;
+				break;
+			}
+		}
+
+		if (!all_match)
+			continue;
+
+		subnode_name = fdt_get_name(metadata, subnode, &name_len);
+		if (subnode_name) {
+			log_match_values(log_type, subnode_name, num_match_values,
+					 match_values);
+			return add_to_bucket(subnode_name, name_len, bucket_head);
+		}
+	}
+
+	if (fallback) {
+		log_info("No %s match, using fallback '%s'\n", log_type, fallback);
+		return add_to_bucket(fallback, strlen(fallback), bucket_head);
+	}
+
+	log_debug("No %s match\n", log_type);
+
+	return -ENOENT;
+}
+
+/**
+ * qcom_add_dtbo_tokens() - Split a comma-separated token string into the bucket list
+ * @str: Comma-separated overlay token string
+ * @bucket_head: Bucket list head
+ *
+ * Splits @str on commas, trims surrounding whitespace from each token, skips
+ * empty tokens, and adds each remaining token to the bucket list.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_add_dtbo_tokens(const char *str, struct list_head *bucket_head)
+{
+	char *str_copy;
+	char *str_ptr;
+	char *token;
+	int ret = 0;
+
+	str_copy = strdup(str);
+	if (!str_copy)
+		return -ENOMEM;
+
+	str_ptr = str_copy;
+	while ((token = strsep(&str_ptr, ","))) {
+		while (*token == ' ' || *token == '\t')
+			token++;
+
+		if (!*token)
+			continue;
+
+		log_info("Adding vendor DTBO token: %s\n", token);
+		ret = add_to_bucket(token, strlen(token), bucket_head);
+		if (ret) {
+			log_err("Failed to add token '%s': %d\n", token, ret);
+			break;
+		}
+	}
+
+	free(str_copy);
+	return ret;
+}
+
+/**
+ * qcom_parse_vendor_dtbo() - Parse vendor_dtbo environment variable
+ * @bucket_head: Bucket list to add overlay tokens to
+ *
+ * Reads the "vendor_dtbo" environment variable and parses its comma-separated
+ * overlay identifiers, adding them to the bucket list for FIT configuration
+ * matching. This influences which FIT configuration is selected.
+ *
+ * Return: 0 on success, negative error code on failure or if unset
+ */
+static int qcom_parse_vendor_dtbo(struct list_head *bucket_head)
+{
+	const char *vendor_dtbo;
+
+	vendor_dtbo = env_get("vendor_dtbo");
+	if (!vendor_dtbo || !*vendor_dtbo)
+		return -ENOENT;
+
+	log_info("vendor_dtbo: %s\n", vendor_dtbo);
+
+	return qcom_add_dtbo_tokens(vendor_dtbo, bucket_head);
+}
+
+/**
+ * qcom_build_bucket_list() - Build bucket list from metadata DTB
+ * @metadata: Metadata DTB pointer
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * This function parses the metadata DTB and builds a list of matching
+ * node names based on the detected hardware parameters.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_build_bucket_list(void *metadata,
+				  struct qcom_hw_params *params,
+				  struct list_head *bucket_head)
+{
+	int root_offset;
+	int ret;
+	struct bucket_node *node;
+
+	log_debug("Building bucket list from hardware parameters\n");
+
+	root_offset = fdt_path_offset(metadata, "/");
+	if (root_offset < 0) {
+		log_err("Failed to find root node in metadata DTB\n");
+		return root_offset;
+	}
+
+	ret = process_node(NODE_TYPE_OEM, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOC, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOCVER, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARD, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARDREV, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	process_node(NODE_TYPE_PERIPHERAL, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_STORAGE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_DDR_SIZE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_SOFTSKU, metadata, root_offset,
+		     params, bucket_head);
+
+	ret = qcom_parse_vendor_dtbo(bucket_head);
+	if (ret)
+		log_debug("vendor_dtbo not applied: %d\n", ret);
+
+	log_debug("Bucket list: ");
+	list_for_each_entry(node, bucket_head, list)
+		log_debug("%s ", node->name);
+	log_debug("\n");
+
+	return 0;
+}
+
+/**
+ * qcom_fit_calc_size() - Compute the true total size of a FIT image
+ * @fit: Pointer to a buffer containing at least the FIT's FDT structure
+ * @buf_size: Size of the buffer pointed to by @fit
+ *
+ * External-data FITs store image payloads after the FDT structure via
+ * "data-offset"/"data-size" properties, so fdt_totalsize() alone misses
+ * them. Walk /images to find the true end of the file.
+ *
+ * Return: total FIT size in bytes, or 0 on error
+ */
+static size_t qcom_fit_calc_size(const void *fit, size_t buf_size)
+{
+	int images_node, node;
+	size_t aligned_size, max_end, end;
+	int offset, size;
+
+	if (buf_size < sizeof(struct fdt_header) || fdt_check_header(fit)) {
+		log_err("Invalid FDT header while probing FIT size\n");
+		return 0;
+	}
+
+	aligned_size = (fdt_totalsize(fit) + 3) & ~3;
+	max_end = 0;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0)
+		return aligned_size;
+
+	fdt_for_each_subnode(node, fit, images_node) {
+		if (fit_image_get_data_offset(fit, node, &offset))
+			continue;
+		if (fit_image_get_data_size(fit, node, &size))
+			continue;
+		if (offset < 0 || size < 0)
+			continue;
+
+		end = (size_t)offset + (size_t)size;
+		if (end > max_end)
+			max_end = end;
+	}
+
+	return max_end ? aligned_size + max_end : aligned_size;
+}
+
+/**
+ * qcom_load_raw_partition() - Load FIT image from a raw partition by name
+ * @partname: GPT partition name to search for
+ * @fitp: Pointer to store FIT image address
+ * @fit_sizep: Pointer to store FIT image size
+ *
+ * Probes the FDT structure first to size the real FIT, instead of
+ * malloc()'ing the whole (possibly oversized) partition. The caller is
+ * responsible for validating the content (fdt_check_header, fit_check_format).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_raw_partition(const char *partname, void **fitp,
+				   size_t *fit_sizep)
+{
+	struct udevice *blk_dev;
+	struct blk_desc *desc = NULL;
+	struct disk_partition part_info;
+	void *probe_buf;
+	void *part_buf;
+	size_t probe_size, probe_blocks, fit_size;
+	lbaint_t fit_blocks;
+
+	blk_foreach_probe(BLKF_BOTH, blk_dev) {
+		desc = dev_get_uclass_plat(blk_dev);
+		if (!desc)
+			continue;
+		if (part_get_info_by_name(desc, partname, &part_info) >= 0)
+			break;
+		desc = NULL;
+	}
+
+	if (!desc) {
+		log_err("Partition '%s' not found on any block device\n", partname);
+		return -ENOENT;
+	}
+
+	probe_blocks = min_t(size_t, DIV_ROUND_UP(SZ_8K, part_info.blksz),
+			     part_info.size);
+	probe_size = probe_blocks * part_info.blksz;
+
+	probe_buf = malloc(probe_size);
+	if (!probe_buf)
+		return -ENOMEM;
+
+	if (blk_dread(desc, part_info.start, probe_blocks, probe_buf) != probe_blocks) {
+		log_err("Failed to probe-read partition '%s'\n", partname);
+		free(probe_buf);
+		return -EIO;
+	}
+
+	fit_size = qcom_fit_calc_size(probe_buf, probe_size);
+	free(probe_buf);
+
+	if (!fit_size) {
+		log_err("Failed to determine FIT size for partition '%s'\n", partname);
+		return -EINVAL;
+	}
+
+	if (fit_size > (size_t)(part_info.size * part_info.blksz))
+		fit_size = (size_t)(part_info.size * part_info.blksz);
+
+	fit_blocks = DIV_ROUND_UP(fit_size, part_info.blksz);
+	fit_size = (size_t)fit_blocks * part_info.blksz;
+
+	part_buf = malloc(fit_size);
+	if (!part_buf)
+		return -ENOMEM;
+
+	if (blk_dread(desc, part_info.start, fit_blocks, part_buf) != fit_blocks) {
+		log_err("Failed to read partition '%s'\n", partname);
+		free(part_buf);
+		return -EIO;
+	}
+
+	*fitp = part_buf;
+	*fit_sizep = fit_size;
+
+	log_info("Loaded raw partition '%s': %zu bytes\n", partname, fit_size);
+	return 0;
+}
+
+/**
+ * qcom_extract_metadata_dtb() - Extract metadata DTB from FIT image
+ * @fit: FIT image pointer
+ * @metadata: Pointer to store metadata DTB address
+ * @metadata_size: Pointer to store metadata DTB size
+ *
+ * The metadata DTB is the first image in the FIT (fdt-0).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_extract_metadata_dtb(void *fit, void **metadata,
+				     size_t *metadata_size)
+{
+	int images_node, first_image;
+	const void *data;
+	size_t size;
+	int ret;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0) {
+		log_err("Cannot find /images node in FIT\n");
+		return images_node;
+	}
+
+	first_image = fdt_first_subnode(fit, images_node);
+	if (first_image < 0) {
+		log_err("Cannot find first image in FIT\n");
+		return first_image;
+	}
+
+	ret = fit_image_get_data(fit, first_image, &data, &size);
+	if (ret) {
+		log_err("Failed to get metadata DTB data\n");
+		return ret;
+	}
+
+	*metadata = malloc(size);
+	if (!*metadata) {
+		log_err("Failed to allocate memory for metadata DTB\n");
+		return -ENOMEM;
+	}
+
+	memcpy(*metadata, data, size);
+	*metadata_size = size;
+
+	log_info("Extracted metadata DTB: %zu bytes\n", size);
+
+	return 0;
+}
+
+/**
+ * qcom_count_compatible_matches() - Count matching tokens in compatible string
+ * @compatible: Compatible string from FIT configuration
+ * @compat_len: Length of compatible string
+ * @bucket_head: Bucket list head
+ *
+ * Parses the compatible string and counts how many tokens match entries
+ * in the bucket list. The compatible string format is typically:
+ * "vendor,device-variant-subtype" where tokens are separated by commas and dashes.
+ *
+ * Return: Number of matching tokens
+ */
+static int qcom_count_compatible_matches(const char *compatible, int compat_len,
+					 struct list_head *bucket_head,
+					 bool *full_match)
+{
+	char *compat_copy;
+	char *str_ptr;
+	char *token;
+	int match_count = 0;
+
+	*full_match = true;
+
+	compat_copy = malloc(compat_len + 1);
+	if (!compat_copy) {
+		*full_match = false;
+		return 0;
+	}
+
+	memcpy(compat_copy, compatible, compat_len);
+	compat_copy[compat_len] = '\0';
+
+	str_ptr = compat_copy;
+
+	strsep(&str_ptr, ",");
+
+	token = strsep(&str_ptr, "-");
+	while (token) {
+		match_count++;
+		if (!search_in_bucket(token, bucket_head)) {
+			*full_match = false;
+			break;
+		}
+		token = strsep(&str_ptr, "-");
+	}
+
+	free(compat_copy);
+	return match_count;
+}
+
+/**
+ * qcom_find_matching_config() - Find matching FIT configuration
+ * @fit: FIT image pointer
+ * @bucket_head: Bucket list head
+ * @config_node: Pointer to store matching configuration node offset
+ *
+ * This function iterates through all FIT configurations and finds the one
+ * with the most matching tokens in its compatible string against the bucket list.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_find_matching_config(void *fit, struct list_head *bucket_head,
+				     int *config_node)
+{
+	int configs_node, cfg;
+	const char *compatible;
+	int compat_len;
+	const char *cfg_name;
+	int name_len;
+	int best_match_count = 0;
+	int best_config = -1;
+	int match_count;
+	bool full_match;
+
+	configs_node = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (configs_node < 0) {
+		log_err("Cannot find /configurations node in FIT\n");
+		return configs_node;
+	}
+
+	fdt_for_each_subnode(cfg, fit, configs_node) {
+		cfg_name = fdt_get_name(fit, cfg, &name_len);
+		compatible = fdt_getprop(fit, cfg, PROP_COMPATIBLE, &compat_len);
+
+		if (!compatible || compat_len <= 0) {
+			log_debug("Config %s has no compatible property\n", cfg_name);
+			continue;
+		}
+
+		log_debug("Checking config: %s, compatible: %s\n",
+			  cfg_name, compatible);
+
+		match_count = qcom_count_compatible_matches(compatible, compat_len,
+							    bucket_head, &full_match);
+
+		log_debug("Config %s: %d tokens, full_match=%d\n", cfg_name,
+			  match_count, full_match);
+
+		if (!full_match)
+			continue;
+
+		if (match_count > best_match_count) {
+			best_match_count = match_count;
+			best_config = cfg;
+		}
+	}
+
+	if (best_config < 0) {
+		log_err("No matching configuration found\n");
+		return -ENOENT;
+	}
+
+	cfg_name = fdt_get_name(fit, best_config, &name_len);
+	compatible = fdt_getprop(fit, best_config, PROP_COMPATIBLE, &compat_len);
+	log_info("Selected configuration: %s (compatible: %s, matches: %d)\n",
+		 cfg_name, compatible, best_match_count);
+
+	*config_node = best_config;
+	return 0;
+}
+
+/**
+ * qcom_get_fdt_image_data() - Get FDT image data from FIT
+ * @fit: FIT image pointer
+ * @images_node: Images node offset
+ * @fdt_name: FDT image name to load
+ * @fdt_datap: Pointer to store FDT data address
+ * @fdt_sizep: Pointer to store FDT data size
+ *
+ * Helper function to load an FDT image from the FIT by name.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_get_fdt_image_data(void *fit, int images_node,
+				   const char *fdt_name,
+				   const void **fdt_datap, size_t *fdt_sizep)
+{
+	int fdt_node;
+	int ret;
+
+	fdt_node = fdt_subnode_offset(fit, images_node, fdt_name);
+	if (fdt_node < 0) {
+		log_err("Cannot find FDT node: %s\n", fdt_name);
+		return fdt_node;
+	}
+
+	ret = fit_image_get_data(fit, fdt_node, fdt_datap, fdt_sizep);
+	if (ret) {
+		log_err("Failed to get FDT data for %s\n", fdt_name);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_load_dtb_with_overlays() - Load DTB and apply overlays
+ * @fit: FIT image pointer
+ * @config_node: Configuration node offset
+ * @final_dtb: Pointer to store final DTB address
+ * @final_dtb_size: Pointer to store final DTB size
+ *
+ * This function loads the base DTB and applies all DTBOs specified in the
+ * configuration's "fdt" property.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_dtb_with_overlays(void *fit, int config_node,
+				       void **final_dtb,
+				       size_t *final_dtb_size)
+{
+	int images_node;
+	const char *fdt_name;
+	int fdt_name_len;
+	const void *fdt_data;
+	size_t fdt_size;
+	void *base_dtb = NULL;
+	size_t base_dtb_size = 0;
+	phys_addr_t dtb_addr;
+	int i, ret;
+	int fixups_offset;
+	struct overlay_entry *overlays = NULL;
+	int overlay_count = 0;
+	size_t overlays_size = 0;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0)
+		return images_node;
+
+	fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, 0, &fdt_name_len);
+	if (!fdt_name) {
+		log_err("No fdt property in configuration\n");
+		return -EINVAL;
+	}
+
+	log_info("DTB: %s\n", fdt_name);
+
+	ret = qcom_get_fdt_image_data(fit, images_node, fdt_name,
+				      &fdt_data, &fdt_size);
+	if (ret)
+		return ret;
+
+	/* Gather overlay entries once: name, data pointer, and size */
+	for (i = 1; ; i++) {
+		const char *ov_name;
+		const void *ov_data;
+		size_t ov_size;
+		int ov_name_len;
+		struct overlay_entry *tmp;
+
+		ov_name = fdt_stringlist_get(fit, config_node, PROP_FDT, i, &ov_name_len);
+		if (!ov_name)
+			break;
+
+		if (qcom_get_fdt_image_data(fit, images_node, ov_name, &ov_data, &ov_size))
+			continue;
+
+		tmp = realloc(overlays, (overlay_count + 1) * sizeof(*overlays));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto free_overlays;
+		}
+		overlays = tmp;
+		overlays[overlay_count].name = ov_name;
+		overlays[overlay_count].data = ov_data;
+		overlays[overlay_count].size = ov_size;
+		overlay_count++;
+		overlays_size += ov_size;
+	}
+
+	/* Allocate base DTB with extra space for overlays using LMB */
+	base_dtb_size = fdt_size + overlays_size + (2 * 1024);
+	ret = lmb_alloc(base_dtb_size, &dtb_addr);
+	if (ret) {
+		log_err("Failed to allocate LMB memory for base DTB: %zu bytes\n", base_dtb_size);
+		ret = -ENOMEM;
+		goto free_overlays;
+	}
+	base_dtb = (void *)dtb_addr;
+
+	memcpy(base_dtb, fdt_data, fdt_size);
+	ret = fdt_open_into(base_dtb, base_dtb, base_dtb_size);
+	if (ret) {
+		log_err("Failed to open DTB: %d\n", ret);
+		goto free_overlays;
+	}
+
+	/* Apply overlays using the already-gathered entries */
+	for (i = 0; i < overlay_count; i++) {
+		log_info("Applying overlay: %s (%zu bytes)\n",
+			 overlays[i].name, overlays[i].size);
+
+		fixups_offset = fdt_path_offset(overlays[i].data, "/__fixups__");
+		if (fixups_offset == -FDT_ERR_NOTFOUND) {
+			log_warning("%s is not a valid overlay (no __fixups__)\n",
+				    overlays[i].name);
+			continue;
+		}
+
+		ret = fdt_overlay_apply_verbose(base_dtb, (void *)overlays[i].data);
+		if (ret)
+			log_err("Failed to apply overlay %s: %d\n", overlays[i].name, ret);
+	}
+
+	ret = fdt_pack(base_dtb);
+	if (ret) {
+		log_err("Failed to pack DTB: %d\n", ret);
+		goto free_overlays;
+	}
+
+	*final_dtb = base_dtb;
+	*final_dtb_size = fdt_totalsize(base_dtb);
+
+	log_info("Final DTB size: %zu bytes\n", *final_dtb_size);
+
+	ret = 0;
+
+free_overlays:
+	free(overlays);
+	return ret;
+}
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This is the main function that orchestrates the entire DTB selection process:
+ * 1. Load qclinux_fit.img from EFI partition
+ * 2. Extract metadata DTB
+ * 3. Detect hardware parameters from SMEM
+ * 4. Build bucket list from metadata
+ * 5. Find matching FIT configuration
+ * 6. Load DTB and apply overlays
+ * 7. Install FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void)
+{
+	void *fit = NULL;
+	size_t fit_size = 0;
+	void *metadata = NULL;
+	size_t metadata_size = 0;
+	struct qcom_hw_params hw_params;
+	LIST_HEAD(bucket_list);
+	int config_node;
+	void *final_dtb = NULL;
+	size_t final_dtb_size = 0;
+	int ret;
+
+	log_debug("=== FIT Multi-DTB Selection ===\n");
+
+	log_debug("Loading FIT image\n");
+	ret = qcom_load_raw_partition(QCOM_FIT_PARTNAME, &fit, &fit_size);
+	if (ret) {
+		log_err("Failed to load FIT image\n");
+		goto cleanup_fit;
+	}
+
+	ret = fdt_check_header(fit);
+	if (ret) {
+		log_err("Invalid FIT header\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
+	if (ret) {
+		log_err("Invalid FIT format\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	log_debug("Extracting metadata DTB\n");
+	ret = qcom_extract_metadata_dtb(fit, &metadata, &metadata_size);
+	if (ret) {
+		log_err("Failed to extract metadata DTB\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Detecting hardware parameters\n");
+	ret = qcom_hwdetect_get_params(&hw_params);
+	if (ret) {
+		log_err("Failed to detect hardware parameters\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Building bucket list\n");
+	ret = qcom_build_bucket_list(metadata, &hw_params, &bucket_list);
+	if (ret) {
+		log_err("Failed to build bucket list\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Finding matching configuration\n");
+	ret = qcom_find_matching_config(fit, &bucket_list, &config_node);
+	if (ret) {
+		log_err("Failed to find matching configuration\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Loading DTB and applying overlays\n");
+	ret = qcom_load_dtb_with_overlays(fit, config_node, &final_dtb,
+					  &final_dtb_size);
+	if (ret) {
+		log_err("Failed to load DTB with overlays\n");
+		goto cleanup_dtb;
+	}
+
+	log_debug("Setting fdt_addr to selected DTB address\n");
+
+	ret = fdt_check_header(final_dtb);
+	if (ret) {
+		log_err("Invalid final DTB header: %d\n", ret);
+		ret = -EINVAL;
+		goto cleanup_dtb;
+	}
+
+	/* Update fdt_addr environment variable to point to our DTB */
+	env_set_hex("fdt_addr", (ulong)final_dtb);
+	log_info("Updated fdt_addr=0x%lx, DTB size=%zu bytes\n", (ulong)final_dtb, final_dtb_size);
+	log_info("EFI boot flow will use DTB directly from this address\n");
+
+	/* Don't free final_dtb - LMB manages memory and EFI boot flow will use it */
+	final_dtb = NULL;
+
+	log_debug("=== FIT Multi-DTB Selection Complete ===\n");
+
+	ret = 0;
+	goto cleanup_success;
+
+cleanup_dtb:
+	if (ret && final_dtb)
+		final_dtb = NULL;
+
+cleanup_success:
+cleanup_bucket:
+	free_bucket_list(&bucket_list);
+
+cleanup_metadata:
+	if (metadata)
+		free(metadata);
+
+cleanup_fit:
+	if (fit)
+		free(fit);
+
+	return ret;
+}
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
new file mode 100644
index 00000000000..00b6d935a4a
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * This implements automatic DTB selection from FIT images based on hardware
+ * detection via SMEM.
+ */
+
+#ifndef __QCOM_FIT_MULTIDTB_H__
+#define __QCOM_FIT_MULTIDTB_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+/**
+ * struct bucket_node - Node in the bucket list
+ * @list: List head for linking nodes
+ * @name: Node name string (e.g., "qcom", "sa8775p-v2", "ride", "ufs", "8gb")
+ *
+ * The bucket list contains all matching node names from the metadata DTB.
+ * These are used to match against FIT configuration compatible strings.
+ */
+struct bucket_node {
+	struct list_head list;
+	char *name;
+};
+
+/* Node processing types for metadata DTB parsing */
+enum node_process_type {
+	NODE_TYPE_OEM,
+	NODE_TYPE_SOC,
+	NODE_TYPE_SOCVER,
+	NODE_TYPE_BOARD,
+	NODE_TYPE_BOARDREV,
+	NODE_TYPE_PERIPHERAL,
+	NODE_TYPE_STORAGE,
+	NODE_TYPE_DDR_SIZE,
+	NODE_TYPE_SOFTSKU,
+};
+
+/* Function prototypes */
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This function:
+ * 1. Loads qclinux_fit.img from EFI partition
+ * 2. Extracts metadata DTB
+ * 3. Detects hardware parameters from SMEM
+ * 4. Builds bucket list from metadata
+ * 5. Finds matching FIT configuration
+ * 6. Loads DTB and applies overlays
+ * 7. Sets FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void);
+
+#endif /* __QCOM_FIT_MULTIDTB_H__ */
-- 
2.34.1

