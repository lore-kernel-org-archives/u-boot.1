Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF91606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y60K0mK1;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgzYJhOn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Px8SGke7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3924089C;
	Wed, 21 Oct 2026 16:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 024KCSdAILoc; Wed, 21 Oct 2026 16:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 953D7408E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599043;
	b=ICzVK0Z3L5ACW3cUBjGpqTqalfg3SZ96v/L207n8GuMhdNxC4AlJox8XKAKlaLfxf1LL
	 5iLI+xsyTqIHiCgE9ZlYMG+ovM0DiA1IqhQ7+oPnmfHjX04AX7N1aEFHN25+Hts9U6V9E
	 Xk/00wlXLLs8pbYaMTx0eCrDKjSfjYZa9ObGTEQGFvwgJQH7eqvRJ9HZLG0B6Wsd3acAH
	 WTN6GndvUN+dnn+Ena1+ECdimLGRw4HmhnO1S4k7I8CRa/x+T6nIh9mfFjFV81t8jdize
	 HOrNpb2dnZwyfUywNl5gMVu0GFFl+2O3TQXOHZaDVEhMnOfoH8dS6jzJxGVKSzF18KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zrWmyt25VFMoy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=;
	b=rJgkE9HaSJxB+V25rie6WhzwGUSB6wavU2kaVjrKjuhtP7nXFWao08rQdUdLQFklWrMD
	 6vwmYKX2LEjR1DRpowwRE644RRydXHhSmCBnQm9vp/hGzfMxGwgVPtWjL9llf77iP0QhW
	 QI6XUOCwH7zv6gZ8LLSyQSD96TlhlWYXaVTKvYpFs+wuDRgeDBlMVo+w8hwl65f4ro5+o
	 ZlBZyzrxScmcFPK85cd3HQO1gFr7br9Y1dER+KTLI/mAK0g+/LUdqP3/Z/fnhhxtzighu
	 ufZO1Cbvln0JIQjB+ioSwF+sjF+FW1HSTjbbXZbl8Efc7srJcTIz4EppEA2zLX+Ahbw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599043;
	bh=zrWmyt25VFMoy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y60K0mK1m5irMa2Y9BvN0wQdO5YIHOQTI0eRM5iOBH+cvyQJsJ6u3QT1cHY2xx8Fa
	 uM0J7qnrx6tHuLN+ARvqL4S9YltPZiVl0YrxrPkyJimLz9HMo9ISHWggewNZ6smX/9
	 CA+k2m6xtR5/EsRL+K0YpWradY87/vX1ixtcBDPMyLuihsJoJOHmDcLToXyrKCCeEr
	 FGJ3DJ4ffR3XCfbY3b3PFiyNMzOELWQK6MfQsVwYGT72t/hQsxJ3T89M1iQsrzMAit
	 yyOKomgQXLzCV4M+cCHZqdXdoA628WZlMD2n3xLtUide0+avzZKmWHN8RGLlRw/8ML
	 VnV874IGOdIwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 953D7408E1;
	Wed, 21 Oct 2026 16:10:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD6FB95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BED5F6089D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mj8CcVS4VVkq for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 022C460844
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599042;
 b=qLguXbCya8HfMTCXnpOHJlOwFt2NhoBv+wvIk0EOMaClaFIbOcVwMhrrQwOO+rGJKqqU
 olxADn+u7K11rUKykjFaUTaiijMRXPcxbuiCXzDvA4Q/gYU4y7noUwh/2hwdhIVnGw3tG
 CSpvTjd0K/AbCCewMfYNfdW18oF7AerPFyIkgdKHhcAYL1+z3hKxe1y0n5kfBwp6NTlty
 xyLQ2ZgyAAVarU+iKpLMLR4TiMajC2qkj0r2FfSfL0OUZQor1WPKp2wxXd+hAIEKnas8U
 BqQi7RWlwUGj877Mkumf3+mpgo7ydGnb2B/xv53kD+CURxSSqclE05P70eQ8WASDGBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599042;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zrWmyt25VFMoy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=;
 b=qAfMsh/tSW1sxml/PG+4+Ptikb4cvK6rTE3T/4crd+vhxv/4sD5x48PCGQH4LOUiEQap
 372ubGYuKjP8Ds33sxKYvUJCgmpqiQhz4wIWHAUbvJCC+bsGEIy0OtjiwU0liav7YdlVF
 CE05b4nNBcOzguf6AdcCLNCbGGQnuNlCwVupeH/W3bxjP35pwc2Eaq/2L/d9vkrQR+JB/
 eCjmo60tg0izZH24HMKNrHeXBiEQd5xWVNDzjUFUnMMZiLRTNc94ZpQFsKUU6OiyGFjBM
 WaV0/N1f1/S+JmSYxJE8FUgMfA8vtX+jn/pZyZYQwDuxzFSl2zJX17XbPo9Wd7bkmhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SgzYJhOn; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Px8SGke7; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgzYJhOn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Px8SGke7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 022C460844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFpF8S1037769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zrWmyt25VFM
 oy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=; b=SgzYJhOnSQTPuWKWD7hiYdx7UbY
 JvMdk0/cn0N9g3q0OC2ih113yA7/QegE+HxjNr5O7ckeMsLdgIYm3rtDDBbfwCJO
 rG/Vcp3pZdbUHePMwsJHOE+0GXVUf6fVwL6fyAppTadzK8pm6/caF3Ut8JJXxbtg
 mua4bp1rZBDeb499pbIVqdB7XwU7skdbPJj29U/w5cnSheXvGgNc/BN+Dilkpo/5
 c3l/3njxm34n5hiwVe5Yw1f7PqXOvwCz4SQdy2szHADmQqyFaQXOsE3gNg4sIgJK
 Yb7qkWjE7msGuNt8z4lOcdysBBg9Flj0/aW8ZSK0dqaOucj3t92quiK7iSg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3xyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1540978eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599039; x=1793203839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zrWmyt25VFMoy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=;
 b=Px8SGke77JfCRcVApIRIW1UqDZIKRoeKwRLvVgFvgvzpD+9URe0BBJmN056pEseePt
 vUsCgP7rzog/rzfbYZiPvy77wjvJoJWlrc0i5nQxecnq2Xqr621e1Hv+LWI3kY/HuYA9
 fBRCSIJ1HURTSd6RDH+zP1LMTwiwrLn8hJMKml7j4hmR2QQnafDCS9QzkTxyv0W/46nJ
 u9mqurO0FGVUYCQIw6IzJ/j9KLP1NkHiWPJ3tgHpMnSetgku/Px5LWIxV+C6xXKNmd4u
 v3ZEbwvxcRkENgfQvQRLvMUTnkIoeSwytIXpA5bR52QKC6hl2KcP9s9qRFZ419aseG3V
 vZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599039; x=1793203839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zrWmyt25VFMoy/gzKjWuIEUWFrkDqltugHuqIHgoQU4=;
 b=UtFE/htD1GNI3KcLApm0+AWSoS3JaxcZ8Z5dI7AN4FqUebb+4FOL4Jhnymt+mJetqn
 vzlWavW4BsGAWZ+6jFOVbp98dEg0hD+sqqfFZcYqQwISOaq5wwCoqTwdr0bHnXu98lqH
 aMdtO2UZS8K3pvfuQPiy8qCcZDKTfTyhLmKBPZxSmnXU1jSqKtooC6/aKdbCNnWiFQqw
 DkLHrA91lLIW03AcMz6HvVLkRgrupVAz670dm1fhd/4oCtxhIpw7wbv/Q6PsKFnkvN9T
 bsHtFEktyKA/LJYZDlDu0lSU68SEwK3rhR7VrML/dXCVBaauujMJcr7h7iWGGnxqJQLp
 TTrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz226HOB1bRn4DGdKNKhBj0ug6FaQ19o738VV2soPDmpSMLEBPSsRQvxxB5BXsLuEbEhkKm1XM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJjt1UFSpMv4NBZniDqJ0nHAjsU8mnvCD1Elzn6nTBgI87pUSrp
 R4mabRndOjXVoWURN/QbY8DRBKwu5y/C8t7ceY27b9Uv7JkxLP0S+Myr+RI0KABKuKww3bxTtPw
 9DoCwOIzn7rjb75kCXJ/eFV/SjfPvej/2I8Y7Sqmb4EMkpEO0j49/c9k91R5O1s7X6SzMAvQ=
X-Gm-Gg: AYBFou1a3Ve4JdjZbjn5Pbx1rQEYmyxh/D38GfhH/9Q5TGvvYAMDQuqaclDen1MfTFw
 c+ORyuNBpYAIdWeISTkAC09gjY4igsFpc0ynPapr6NHs4sYD9or9Xwj4wLACfhcE5ZEZ5AXnAkK
 eaXdcKnzmeFCMkC9htdCCjjnFnk7LnuDzFyMAS1EGQcWPlZB4Y/zriIXprYBkn/K4B2tVqqwOCl
 xGrksjE4F5cop05cl/voiNCKUi2gNaT5lkazXsmqzRbUNUv2EkK3W02EaHekqy0FQQ/qzdX/cIQ
 KpSxNL5VOu97rA0k0SlIfHPVBDdm/XQq625eHDqloahaQFj/KWSh7pg1quPhEDeuiiZAyDM909f
 blNaYQLc3dcCBFDbqvA+IYF0CLs8RgfKm/W9/Un1esVgmVbaiE9A+zZ7TiwtWAPmVxcSbF7QMBv
 Sk9z0E/9Y64UoUsopKlBs=
X-Received: by 2002:a05:693c:810d:b0:360:ab79:e0a6 with SMTP id
 5a478bee46e88-3674d858318mr4135252eec.28.1792599038742; 
 Wed, 21 Oct 2026 09:10:38 -0700 (PDT)
X-Received: by 2002:a05:693c:810d:b0:360:ab79:e0a6 with SMTP id
 5a478bee46e88-3674d858318mr4135216eec.28.1792599038159; 
 Wed, 21 Oct 2026 09:10:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:36 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 10/12] qcom: smem: increase SMEM_HOST_COUNT for newer SMEM
 versions
Date: Wed, 21 Oct 2026 21:39:14 +0530
Message-Id: <20261021160916.3894471-11-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e400 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=dluG079SF-FDyRJlmAYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: _i4263EZ6DxExzxJRWpd3hzV5DRX4WdT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0J4utJElh9uw
 ZAKGTNSvBR13shX6drm0+RkXlBRHiZPnCj2AKN0yolXB662CUZNTTruNuZvnAUNz3ABYllTodCT
 6XhrRnBUrDirPYNbMLcxj/cjNyooaAgipY8ba2tYtgrNMSVp6AOFnfYRveedjplz+y0jhgsq4g9
 ceF3xurHUPv1UY/fL3U5BUYg0j1hNyj+7dE+Tn2u0fVFGOCd6Amkjr4B6kUCg7GKsftKZksrIH8
 F3+8clQog0IzKjKJigzG7g75GvVN6kz0+z0oip1owsImOf6UUN+9Oa5c8e85XM9JLSYhliLA1yg
 jPZ7qCGImIlwPxkm0FYlEd4mJeLM2eI2rRumukFgQQ+g20s8U8GeGwAnnmgajES6+nikqtm97A2
 M8GDbn0oVmhdoGAwS6+eKh/QpeeJbObyGDYaTdNbSyfjR0o8aGmNTp1CJCwQ278KS7pvRS7UucT
 gsn//5WOQ3/d9abuzbw==
X-Proofpoint-GUID: _i4263EZ6DxExzxJRWpd3hzV5DRX4WdT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX8y9QingCjOOv
 9JkNuR0t0GmZmAF8ZGj3SsYxfON86ghiYjSSnXPDDSIZHGas/cqdGXu54M5Vna1i1DdxWlWywq5
 nicS/9ZXwxZTA2+4JBlZ5nJXOossoVc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Increase SMEM_HOST_COUNT to accommodate newer SMEM versions
that support a larger number of remote processors.

This prevents failures during processor ID validation when
handling platforms with extended SMEM host entries. Shikra
& other new Drangonwing platforms require a higher host count
for proper SMEM handling.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e20523e2cec..daf7d9577b2 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -88,7 +88,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		20
+#define SMEM_HOST_COUNT		256
 
 /**
   * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
2.34.1

